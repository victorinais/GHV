-- Active: 1721578399744@@buatrte4cm8jtqxtuba0-mysql.services.clever-cloud.com@3306@buatrte4cm8jtqxtuba0
CREATE TABLE Roles(
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(50) NOT NULL,
    GuardName VARCHAR(50) NOT NULL,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    Description TEXT
);

CREATE TABLE Permissions(
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(50) NOT NULL,
    GuardName VARCHAR(50) NOT NULL,
    CreatedAT DATETIME DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    Description TEXT,
    Module VARCHAR(50)
);

CREATE TABLE RoleHasPermissions(
    PermissionId INT NOT NULL,
    RoleId INT NOT NULL,
    PRIMARY KEY (PermissionId, RoleId),
    FOREIGN KEY (PermissionId) REFERENCES Permissions(Id),
    FOREIGN KEY (RoleId) REFERENCES Roles(Id)
);

CREATE TABLE ModelHasRoles(  
    RoleId INT NOT NULL,
    ModelType VARCHAR(50) NOT NULL,
    ModelId INT NOT NULL,
    PRIMARY KEY (RoleId, ModelType, ModelId),
    FOREIGN KEY (RoleId) REFERENCES Roles(Id)
);

CREATE TABLE ModelHasPermissions(
    PermissionId INT NOT NULL,
    ModelType VARCHAR(50) NOT NULL,
    ModelId INT NOT NULL,
    PRIMARY KEY (PermissionId, ModelType, ModelId),
    FOREIGN KEY (PermissionId) REFERENCES Permissions(Id)
);

-- Insertar roles
INSERT INTO Roles (Name, GuardName, Description) VALUES
('Admin', 'web', 'Administrador del sistema'),
('User', 'web', 'Usuario estándar');

-- Insertar permisos
INSERT INTO Permissions (Name, GuardName, Description, Module) VALUES
('create_cv', 'web', 'Crear hoja de vida', 'CV'),
('view_cv', 'web', 'Ver detalles de la hoja de vida', 'CV'),
('edit_cv', 'web', 'Editar hoja de vida', 'CV'),
('delete_cv', 'web', 'Eliminar hoja de vida', 'CV'),
('generate_reports', 'web', 'Generar informes en Excel', 'Admin');

-- Asignar permisos a roles
INSERT INTO RoleHasPermissions (RoleId, PermissionId) VALUES
((SELECT Id FROM Roles WHERE Name = 'Admin'), (SELECT Id FROM Permissions WHERE Name = 'generate_reports')),
((SELECT Id FROM Roles WHERE Name = 'User'), (SELECT Id FROM Permissions WHERE Name = 'create_cv')),
((SELECT Id FROM Roles WHERE Name = 'User'), (SELECT Id FROM Permissions WHERE Name = 'view_cv')),
((SELECT Id FROM Roles WHERE Name = 'User'), (SELECT Id FROM Permissions WHERE Name = 'edit_cv')),
((SELECT Id FROM Roles WHERE Name = 'User'), (SELECT Id FROM Permissions WHERE Name = 'delete_cv'));

-- Asignar rol a un usuario (ejemplo)
INSERT INTO ModelHasRoles (RoleId, ModelType, ModelId) VALUES
((SELECT Id FROM Roles WHERE Name = 'User'), 'User', 1);


