-- Основной скрипт для создания GUI
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local screenGui = Instance.new("ScreenGui")
local mainFrame = Instance.new("Frame")
local showMenuButton = Instance.new("TextButton") -- Кнопка для показа меню
local toggleButton = Instance.new("TextButton") -- Кнопка для скрытия/показа меню
local infiniteJumpButton = Instance.new("TextButton") -- Бесконечный прыжок
local speedSlider = Instance.new("TextBox") -- Ввод желаемой скорости
local teleportMenuButton = Instance.new("TextButton") -- Кнопка телепортации
local noclipButton = Instance.new("TextButton") -- Кнопка для включения прохода сквозь стены
local espButton = Instance.new("TextButton") -- Добавленная кнопка для ESP

local infiniteJumpEnabled = false
local noclipEnabled = false
local espEnabled = false -- Состояние ESP

screenGui.Parent = playerGui
screenGui.Name = "CustomMenu"

mainFrame.Parent = screenGui
mainFrame.BackgroundColor3 = Color3.new(1, 1, 1)
mainFrame.Size = UDim2.new(0, 200, 0, 300) -- Изменен размер для вмещения новой кнопки
mainFrame.Position = UDim2.new(0.5, -100, 0.5, -150)

-- Делаем меню перемещаемым
mainFrame.Active = true
mainFrame.Draggable = true

-- Создание и настройка кнопки для показа меню
showMenuButton.Parent = screenGui
showMenuButton.Text = "Показать меню"
showMenuButton.BackgroundColor3 = Color3.new(0.5, 0.5, 1)
showMenuButton.Size = UDim2.new(0, 100, 0, 50)
showMenuButton.Position = UDim2.new(0, 15, 0, 15)
showMenuButton.Visible = false

-- Функция для переключения видимости меню
local function toggleMenu()
    mainFrame.Visible = not mainFrame.Visible
    showMenuButton.Visible = not mainFrame.Visible
end

toggleButton.Parent = mainFrame
toggleButton.Text = "Скрыть меню"
toggleButton.BackgroundColor3 = Color3.new(0, 1, 0)
toggleButton.Size = UDim2.new(0, 200, 0, 50)
toggleButton.Position = UDim2.new(0, 0, 0, 250)

toggleButton.MouseButton1Click:Connect(toggleMenu)

-- Настройка кнопки showMenuButton для показа меню
showMenuButton.MouseButton1Click:Connect(toggleMenu)

-- [Ваш текущий код для бесконечного прыжка, скорости, телепортации и noclip здесь]

-- Кнопка ESP и её функциональность добавлены ниже

espButton.Parent = mainFrame
espButton.Text = "ESP: ВЫКЛ"
espButton.BackgroundColor3 = Color3.new(1, 1, 0) -- Желтый цвет
espButton.Size = UDim2.new(0, 200, 0, 50)
espButton.Position = UDim2.new(0, 0, 0, 200) -- Расположение под кнопкой noclip

local function updateEsp()
    if espEnabled then
        for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
            if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("Head") then
                local head = otherPlayer.Character.Head
                local espTag = head:FindFirstChild("EspTag")
                if not espTag then
                    espTag = Instance.new("BillboardGui", head)
                    espTag.Name = "EspTag"
                    espTag.Size = UDim2.new(0, 200, 0, 50)
                    espTag.Adornee = head
                    espTag.AlwaysOnTop = true
                    local textLabel = Instance.new("TextLabel", espTag)
                    textLabel.Text = otherPlayer.Name
                    textLabel.BackgroundTransparency = 1
                    textLabel.Size = UDim2.new(1, 0, 1, 0)
                    textLabel.TextColor3 = Color3.new(1, 0, 0)
                end
            end
        end
    else
        for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
            if otherPlayer.Character and otherPlayer.Character:FindFirstChild("Head") then
                local head = otherPlayer.Character.Head
                local espTag = head:FindFirstChild("EspTag")
                if espTag then
                    espTag:Destroy()
                end
            end
        end
    end
end

espButton.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    espButton.Text = espEnabled and "ESP: ВКЛ" or "ESP: ВЫКЛ"
    updateEsp()
end)-- Бесконечный прыжок
infiniteJumpButton.Parent = mainFrame
infiniteJumpButton.Text = "Беск. прыжок: ВЫКЛ"
infiniteJumpButton.BackgroundColor3 = Color3.new(1, 0.5, 0) -- Оранжевый
infiniteJumpButton.Size = UDim2.new(0, 200, 0, 50)
infiniteJumpButton.Position = UDim2.new(0, 0, 0, 50)

infiniteJumpButton.MouseButton1Click:Connect(function()
    infiniteJumpEnabled = not infiniteJumpEnabled
    infiniteJumpButton.Text = infiniteJumpEnabled and "Беск. прыжок: ВКЛ" or "Беск. прыжок: ВЫКЛ"
    if infiniteJumpEnabled then
        local UserInputService = game:GetService("UserInputService")
        UserInputService.JumpRequest:Connect(function()
            if infiniteJumpEnabled then
                player.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
            end
        end)
    end
end)

-- Изменение скорости
speedSlider.Parent = mainFrame
speedSlider.Text = "Введите скорость"
speedSlider.BackgroundColor3 = Color3.new(1, 1, 1)
speedSlider.Size = UDim2.new(0, 200, 0, 50)
speedSlider.Position = UDim2.new(0, 0, 0, 100)

speedSlider.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local speed = tonumber(speedSlider.Text)
        if speed and player.Character then
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = speed
            end
        end
    end
end)

-- Телепортация
teleportMenuButton.Parent = mainFrame
teleportMenuButton.Text = "Телепорт"
teleportMenuButton.BackgroundColor3 = Color3.new(0, 1, 1) -- Голубой
teleportMenuButton.Size = UDim2.new(0, 200, 0, 50)
teleportMenuButton.Position = UDim2.new(0, 0, 0, 150)

-- Добавьте функцию телепортации по необходимости

-- Noclip
noclipButton.Parent = mainFrame
noclipButton.Text = "Noclip: ВЫКЛ"
noclipButton.BackgroundColor3 = Color3.new(0, 0, 1) -- Синий
noclipButton.Size = UDim2.new(0, 200, 0, 50)
noclipButton.Position = UDim2.new(0, 0, 0, 200)

noclipButton.MouseButton1Click:Connect(function()
    noclipEnabled = not noclipEnabled
    noclipButton.Text = noclipEnabled and "Noclip: ВКЛ" or "Noclip: ВЫКЛ"
    -- Реализуйте функциональность noclip по необходимости
end)

-- Обновление ESP для смены цвета игрока на красный
local function updateEsp()
    if espEnabled then
        for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
            if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("Head") then
                local head = otherPlayer.Character.Head
                local espTag = head:FindFirstChild("EspTag")
                if not espTag then
                    espTag = Instance.new("BillboardGui", head)
                    espTag.Name = "EspTag"
                    espTag.Size = UDim2.new(0, 200, 0, 50)
                    espTag.Adornee = head
                    espTag.AlwaysOnTop = true
                    local textLabel = Instance.new("TextLabel", espTag)
                    textLabel.Text = otherPlayer.Name
                    textLabel.BackgroundTransparency = 1
                    textLabel.Size = UDim2.new(1, 0, 1, 0)
                    textLabel.TextColor3 = Color3.new(1, 0, 0) -- Красный цвет
                end
            end
        end
    else
        for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
            if otherPlayer.Character and otherPlayer.Character:FindFirstChild("Head") then
                local head = otherPlayer.Character.Head
                local espTag = head:FindFirstChild("EspTag")
                if espTag then
                    espTag:Destroy()
                end
            end
        end
    end
end-- Размеры и позиции
local buttonHeight = 50
local buttonPadding = 5
local menuWidth = 200
local menuHeight = 350 -- Увеличено для дополнительного пространства

mainFrame.Size = UDim2.new(0, menuWidth, 0, menuHeight) -- Обновлённый размер главного фрейма

-- Обновлённые позиции кнопок
espButton.Position = UDim2.new(0, 0, 0, 0) -- ESP наверху
infiniteJumpButton.Position = UDim2.new(0, 0, 0, buttonHeight + buttonPadding) -- Под ESP
speedSlider.Position = UDim2.new(0, 0, 0, 2 * (buttonHeight + buttonPadding)) -- Под бесконечным прыжком
teleportMenuButton.Position = UDim2.new(0, 0, 0, 3 * (buttonHeight + buttonPadding)) -- Под скоростью
noclipButton.Position = UDim2.new(0, 0, 0, 4 * (buttonHeight + buttonPadding)) -- Под телепортацией
toggleButton.Position = UDim2.new(0, 0, 1, -buttonHeight - buttonPadding) -- Внизу, отступ снизу

-- Обновите остальные свойства и добавьте недостающие элементы интерфейса согласно этой схеме-- Предполагается, что mainFrame и screenGui уже созданы

-- Кнопка вызова меню телепортации
local teleportToPlayerButton = Instance.new("TextButton")
teleportToPlayerButton.Parent = mainFrame
teleportToPlayerButton.Text = "Телепорт к игроку"
teleportToPlayerButton.BackgroundColor3 = Color3.new(1, 0.5, 0) -- Оранжевый цвет
teleportToPlayerButton.Size = UDim2.new(0, 200, 0, 50)
teleportToPlayerButton.Position = UDim2.new(0, 0, 0, 150)

local teleportMenu -- Переменная для хранения меню телепортации
local playersButtons = {} -- Таблица для хранения кнопок игроков

-- Функция для создания или обновления меню телепортации
local function createOrUpdateTeleportMenu()
    if not teleportMenu or not teleportMenu.Parent then
        teleportMenu = Instance.new("Frame", screenGui)
        teleportMenu.Name = "TeleportMenu"
        teleportMenu.Size = UDim2.new(0, 200, 0, 0) -- Начальная высота будет корректироваться
        teleportMenu.Position = UDim2.new(0.5, -100, 0.5, -100)
        teleportMenu.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2) -- Темно-серый
    end

    -- Очистка предыдущих кнопок
    for _, btn in pairs(playersButtons) do
        btn:Destroy()
    end
    playersButtons = {} -- Очищаем таблицу кнопок

    -- Создание кнопок для каждого игрока
    local yPos = 0
    for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
        local playerButton = Instance.new("TextButton", teleportMenu)
        playerButton.Text = otherPlayer.Name
        playerButton.Size = UDim2.new(1, 0, 0, 30)
        playerButton.Position = UDim2.new(0, 0, 0, yPos)
        playerButton.BackgroundColor3 = Color3.new(0.8, 0.8, 0.8) -- Светло-серый
        yPos = yPos + 30

        playerButton.MouseButton1Click:Connect(function()
            if otherPlayer.Character and otherPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local player = game.Players.LocalPlayer
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    player.Character.HumanoidRootPart.CFrame = otherPlayer.Character.HumanoidRootPart.CFrame
                end
            end
        end)

        table.insert(playersButtons, playerButton) -- Добавляем кнопку в таблицу
    end

    teleportMenu.Size = UDim2.new(0, 200, 0, yPos) -- Корректируем высоту меню
end

-- Подписка на события подключения и отключения игроков
game.Players.PlayerAdded:Connect(function()
    createOrUpdateTeleportMenu()
    print("Новый игрок подключился. Меню обновлено.")
end)

game.Players.PlayerRemoving:Connect(function()
    createOrUpdateTeleportMenu()
    print("Игрок вышел. Меню обновлено.")
end)

-- Привязываем создание или обновление меню к кнопке вызова
teleportToPlayerButton.MouseButton1Click:Connect(function()
    createOrUpdateTeleportMenu()
    teleportMenu.Visible = not teleportMenu.Visible -- Показываем или скрываем меню
end)

-- Инициализация меню при запуске
createOrUpdateTeleportMenu()mainFrame.Position = UDim2.new(0.5, 10, 0.5, -150) -- Сместим на 10 пикселей вправо от центра-- Флаг состояния noclip режима
local noclipActive = false

-- Функция включения/выключения noclip
local function toggleNoclip()
    noclipActive = not noclipActive -- Изменение состояния на противоположное
    local player = game.Players.LocalPlayer
    if player and player.Character then
        if noclipActive then
            -- Включение noclip: отключаем физическое взаимодействие для всех частей тела
            for _, part in pairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        else
            -- Выключение noclip: включаем физическое взаимодействие обратно
            for _, part in pairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end

-- Привязываем функцию toggleNoclip к какому-либо действию, например, к нажатию кнопки в интерфейсе
noclipButton.MouseButton1Click:Connect(toggleNoclip)

-- Вы также можете привязать toggleNoclip к нажатию клавиши на клавиатуре:
game:GetService("UserInputService").InputBegan:Connect(function(input, isProcessed)
    if not isProcessed then
        if input.KeyCode == Enum.KeyCode.N then -- Предполагается, что для включения/выключения noclip используется клавиша N
            toggleNoclip()
        end
    end
end)local gui = teleportMenu -- Замените на ваш элемент GUI
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

gui.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = gui.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

gui.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)-- Флаг состояния noclip режима
local noclipActive = false

-- Функция включения/выключения noclip
local function toggleNoclip()
    noclipActive = not noclipActive -- Изменение состояния на противоположное
end

-- Обработчик, который постоянно обновляет состояние noclip
local function handleNoclip()
    game:GetService("RunService").Heartbeat:Connect(function()
        if noclipActive then
            local player = game.Players.LocalPlayer
            if player and player.Character then
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end
    end)
end

-- Привязываем функцию toggleNoclip к нажатию кнопки в интерфейсе (предполагается, что noclipButton уже существует в вашем интерфейсе)
noclipButton.MouseButton1Click:Connect(toggleNoclip)

-- Привязываем toggleNoclip к нажатию клавиши на клавиатуре
game:GetService("UserInputService").InputBegan:Connect(function(input, isProcessed)
    if not isProcessed then
        if input.KeyCode == Enum.KeyCode.N then -- Предполагается, что для включения/выключения noclip используется клавиша N
            toggleNoclip()
        end
    end
end)

-- Запускаем обработчик noclip
handleNoclip()
