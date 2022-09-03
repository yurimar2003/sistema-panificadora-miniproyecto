-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.1.32-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win32
-- HeidiSQL Versión:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Volcando estructura para tabla panificadora.unidades
CREATE TABLE IF NOT EXISTS `unidades` (
  `id_uni` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id de la unidad',
  `des_uni` varchar(50) COLLATE utf8_spanish_ci NOT NULL COMMENT 'Descripción de la unidad',
  PRIMARY KEY (`id_uni`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci COMMENT='Tabla que contiene información de las unidades de medida';

-- Volcando datos para la tabla panificadora.unidades: ~5 rows (aproximadamente)
/*!40000 ALTER TABLE `unidades` DISABLE KEYS */;
INSERT INTO `unidades` (`id_uni`, `des_uni`) VALUES
  (1, 'KILO'),
  (2, 'GRAMO'),
  (3, 'SACO'),
  (4, 'LITRO'),
  (5, 'CARTÓN');
/*!40000 ALTER TABLE `unidades` ENABLE KEYS */;

-- Volcando estructura para tabla panificadora.insumos
CREATE TABLE IF NOT EXISTS `insumos` (
  `id_ins` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id del insumo',
  `des_ins` varchar(50) COLLATE utf8_spanish_ci NOT NULL COMMENT 'Descripción del insumo',
  `id_uni` int(10) unsigned NOT NULL COMMENT 'Id de la unidad de medida',
  `exi_min` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Existencia mínima',
  `exi_max` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Existencia máxima',
  `can_disp` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Cantidad disponible',
  PRIMARY KEY (`id_ins`),
  KEY `FK_insumos_unidades` (`id_uni`),
  CONSTRAINT `FK_insumos_unidades` FOREIGN KEY (`id_uni`) REFERENCES `unidades` (`id_uni`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci COMMENT='Tabla que contiene información de los insumos utilizados';

-- Volcando datos para la tabla panificadora.insumos: ~7 rows (aproximadamente)
/*!40000 ALTER TABLE `insumos` DISABLE KEYS */;
INSERT INTO `insumos` (`id_ins`, `des_ins`, `id_uni`, `exi_min`, `exi_max`, `can_disp`) VALUES
	(1, 'HARINA DE TRIGO', 3, 10, 50, 25),
	(2, 'AZÚCAR', 1, 20, 100, 48),
	(3, 'MARGARINA', 1, 10, 80, 30),
	(4, 'LECHE', 4, 15, 60, 22),
	(5, 'HUEVOS', 5, 5, 30, 8),
	(6, 'SAL', 1, 10, 20, 13),
	(7, 'LEVADURA', 1, 20, 50, 40);
/*!40000 ALTER TABLE `insumos` ENABLE KEYS */;

-- Volcando estructura para tabla panificadora.panes
CREATE TABLE IF NOT EXISTS `panes` (
  `id_pan` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id del pan',
  `des_pan` varchar(50) COLLATE utf8_spanish_ci NOT NULL COMMENT 'Descripción del pan',
  PRIMARY KEY (`id_pan`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci COMMENT='Tabla que contiene la información de los panes';

-- Volcando datos para la tabla panificadora.panes: ~6 rows (aproximadamente)
/*!40000 ALTER TABLE `panes` DISABLE KEYS */;
INSERT INTO `panes` (`id_pan`, `des_pan`) VALUES
	(1, 'CAMPESINO'),
	(2, 'AZUCARADO'),
	(3, 'DE LECHE'),
	(4, 'DE MAÍZ'),
	(5, 'CAMALEÓN'),
	(6, 'DE MANTEQUILLA');
/*!40000 ALTER TABLE `panes` ENABLE KEYS */;

-- Volcando estructura para tabla panificadora.panes_insumos
CREATE TABLE IF NOT EXISTS `panes_insumos` (
  `id_panins` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id del registro',
  `id_pan` int(10) unsigned NOT NULL COMMENT 'Id del pan',
  `id_ins` int(10) unsigned NOT NULL COMMENT 'Id del insumo',
  `can_ins` decimal(20,2) unsigned NOT NULL DEFAULT '0.00' COMMENT 'Cantidad utilizada del insumo',
  `id_uni` int(10) unsigned NOT NULL COMMENT 'Unidad de medida',
  PRIMARY KEY (`id_panins`),
  KEY `FK_panes_insumos_panes` (`id_pan`),
  KEY `FK_panes_insumos_insumos` (`id_ins`),
  KEY `FK_panes_insumos_unidades` (`id_uni`),
  CONSTRAINT `FK_panes_insumos_insumos` FOREIGN KEY (`id_ins`) REFERENCES `insumos` (`id_ins`) ON UPDATE CASCADE,
  CONSTRAINT `FK_panes_insumos_panes` FOREIGN KEY (`id_pan`) REFERENCES `panes` (`id_pan`) ON UPDATE CASCADE,
  CONSTRAINT `FK_panes_insumos_unidades` FOREIGN KEY (`id_uni`) REFERENCES `unidades` (`id_uni`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci COMMENT='Tabla que contiene información de los insumos utilizados para elaborar un tipo de pan específico';

-- Volcando datos para la tabla panificadora.panes_insumos: ~7 rows (aproximadamente)
/*!40000 ALTER TABLE `panes_insumos` DISABLE KEYS */;
INSERT INTO `panes_insumos` (`id_panins`, `id_pan`, `id_ins`, `can_ins`, `id_uni`) VALUES
	(1, 1, 1, 1.00, 3),
	(2, 1, 6, 0.50, 1),
	(3, 1, 7, 50.00, 2),
	(4, 2, 1, 1.00, 3),
	(5, 2, 2, 2.00, 1),
	(7, 2, 4, 1.00, 4),
	(8, 2, 5, 0.50, 5),
	(9, 3, 1, 1.00, 3),
	(10, 3, 4, 2.00, 4),
	(11, 3, 7, 50.00, 2);
/*!40000 ALTER TABLE `panes_insumos` ENABLE KEYS */;

-- Volcando estructura para tabla panificadora.tandas
CREATE TABLE IF NOT EXISTS `tandas` (
  `id_tan` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id de la tanda',
  `fec_tan` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de elaboración',
  `id_pan` int(10) unsigned NOT NULL COMMENT 'Id del pan',
  `can_pie` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Cantidad de piezas de la tanda',
  PRIMARY KEY (`id_tan`),
  KEY `FK_tandas_panes` (`id_pan`),
  CONSTRAINT `FK_tandas_panes` FOREIGN KEY (`id_pan`) REFERENCES `panes` (`id_pan`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci COMMENT='Tabla que contiene información de las tandas de pan a hornear';

-- Volcando datos para la tabla panificadora.tandas: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `tandas` DISABLE KEYS */;
INSERT INTO `tandas` (`id_tan`, `fec_tan`, `id_pan`, `can_pie`) VALUES
	(1, '2021-07-08 20:07:10', 1, 20),
	(2, '2021-07-08 20:07:23', 2, 10),
	(3, '2021-07-08 20:07:46', 3, 10);
/*!40000 ALTER TABLE `tandas` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
