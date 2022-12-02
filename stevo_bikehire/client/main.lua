
local zcoords, mcolor = 0.0, 0
local position = 0
ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()	
    while true do
		Citizen.Wait(5)	
		local playerPed = GetPlayerPed(-1)
		local pos = GetEntityCoords(playerPed, true)		
		for k,v in pairs(Config.Spawns) do
			
			DrawMarker(27, v.x, v.y, v.z+1.1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 173, 0, 255, 100, true, true, 2, true, false, false, false)
						
						if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 2.5) then							
							position = k
								if IsControlJustPressed(0, 38) then	
									if IsPedInAnyVehicle(playerPed,  true) then
										ESX.ShowNotification('~o~You already have a vehicle')
									else
									    local ModelHash = `scorcher` -- Use Compile-time hashes to get the hash of this model
									    if not IsModelInCdimage(ModelHash) then return end
									    RequestModel(ModelHash) -- Request the model
									    while not HasModelLoaded(ModelHash) do -- Waits for the model to load with a check so it does not get stuck in an infinite loop
											Citizen.Wait(10)
									    end
									    local MyPed = PlayerPedId()
									    local Vehicle = CreateVehicle(ModelHash, GetEntityCoords(MyPed), GetEntityHeading(MyPed), true, false) -- Spawns a networked vehicle on your current coords
									    TaskWarpPedIntoVehicle(playerPed, Vehicle, -1)
									    SetModelAsNoLongerNeeded(ModelHash) -- removes model from game memory as we no longer need it		
									    ESX.ShowNotification('~b~Bike Spawned')			
									end					
								end								
							
						end
		end
    end
end)




