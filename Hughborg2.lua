
bestTarget = {0, 0}


--###############################################
--#minimax:
--#monsArray entry format: [x, y, currentSimulatedHealth]
--###############################################
function minimax(monsArray, playerSimulatedHealth, depth, currentTurn, alpha, beta)
    if playerSimulatedHealth <= 0 then
        return -10
    end
    deadEnemies = true
    for i = 1, #monsArray do
        if(monsArray[i][3] > 0) then
            deadEnemies = false
        end
    end
    if deadEnemies == true then
        return 10
    end
    if depth == 0 then
        return 0
    end
    
    if currentTurn == true then
        bestVal = 0
        for i = 1, #monsArray do
            if monsArray[i][3] > 0 then
                nextArray = copyMonsArray(monsArray)
                nextArray[i][3] = nextArray[i][3] - you.simulateDamage(nextArray[i][1], nextArray[i][2])
                val = minimax(nextArray, playerSimulatedHealth, depth - 1, not currentTurn, alpha, beta)
                if(val > bestVal) then
                    bestVal = val
                    bestTarget = {nextArray[i][1], nextArray[i][2]}
                end
                if(val > alpha) then
                    alpha = val
                end
                if(beta <= alpha) then
                break end
            end
        end
        return bestVal
    else
        bestVal = 9999
        totalSimulatedDamage = 0
        for i = 1, #monsArray do
            totalSimulatedDamage = totalSimulatedDamage + you.simulateEnemyDamage(monsArray[i][1], monsArray[i][2])
        end
        val = minimax(monsArray, playerSimulatedHealth - totalSimulatedDamage, depth - 1, not currentTurn, alpha, beta)
        if(val < bestVal) then
            bestVal = val
        end
        if(val < beta) then
            beta = val
        end
        if(beta <= alpha) then
        end
        return bestVal
    end
end


function copyMonsArray(monsArray)
    local newArray = {}
    for i = 1, #monsArray do
        newArray[i] = {}
        for j = 1, #(monsArray[i]) do
            newArray[i][j] = monsArray[i][j]
        end
    end
    return newArray
end



    