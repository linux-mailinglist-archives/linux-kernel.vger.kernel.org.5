Return-Path: <linux-kernel+bounces-137259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B6D89DFEB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64734B29BFF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF4513D8B9;
	Tue,  9 Apr 2024 15:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="0TPtqiv+"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA2B13D602;
	Tue,  9 Apr 2024 15:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712677591; cv=none; b=QAhhz18WtMnkS06Qia9mQD1L4TR+5Z69ynONmXMtZ44TR3SfnkbOerLy76hHEImc7twVCwAnKEYUmmzuII/KVVQerGr5FEy1Dbjl4ZxjV/0GPISB0yJHtRqi9ObWrEJJ8V2el9s0+ZHBvTa/HnCqelVESe/TAZOo253dSVHVV9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712677591; c=relaxed/simple;
	bh=SNlPweSWtVU73doNPQfknsWEGcCGz3Kp9UCuxAbiQrs=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=GBk6c1uy/5U7HG6agjZWs1pUmUyYuwiyQkZPxi+ttTjjQLYC671LqkK/SOn8w9AgBNXoiA4Rb1LrPo0S3wyTk3HIcVJp442bAaDAjQSHC9RHt0BDw1OP9AlCYRbd/mZlSS6NhF4QEv0Q7zDQhFMtD6z6ZLKiryk4Mc1roIgQJPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=0TPtqiv+; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=xismI6/UN76dXowjytnEE6ImFlGBnNQlstjuySv9/Gg=; b=0TPtqiv+eh6cwRfLpmIq7OyP5f
	UHYyrsWLnrK2oi19UeZ2GPSxW/oU1/66izgJg0jBD42YmCAMbnDmKg7aW4CF2OW5n3dKEpO+NG8ln
	XQP19YGqKMl8fcxnx+me/eAO8iGXrHqe/BRTyZRUwFELRHiOGvlKcSMh+4AWlHaTa8z0=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:44750 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1ruDfs-0002NM-Lf; Tue, 09 Apr 2024 11:46:18 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	peterz@infradead.org,
	mingo@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	andy.shevchenko@gmail.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Tue,  9 Apr 2024 11:42:51 -0400
Message-Id: <20240409154253.3043822-4-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240409154253.3043822-1-hugo@hugovil.com>
References: <20240409154253.3043822-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
Subject: [PATCH v4 3/5] serial: sc16is7xx: split into core and I2C/SPI parts (core)
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Split the common code from sc16is7xx driver and move the I2C and SPI bus
parts into interface-specific source files.

sc16is7xx becomes the core functions which can support multiple bus
interfaces like I2C and SPI.

No functional changes intended.

Also simplify and improve Kconfig entries.
  - Capitalize SPI keyword for consistency
  - Display list of supported ICs each on a separate line (and aligned) to
    facilitate locating a specific IC model
  - Add Manufacturer name at start of description string
  - Add UART keyword to description string

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/Kconfig         |  47 +++---
 drivers/tty/serial/Makefile        |   2 +
 drivers/tty/serial/sc16is7xx.c     | 225 +++++------------------------
 drivers/tty/serial/sc16is7xx.h     |  41 ++++++
 drivers/tty/serial/sc16is7xx_i2c.c |  64 ++++++++
 drivers/tty/serial/sc16is7xx_spi.c |  87 +++++++++++
 6 files changed, 248 insertions(+), 218 deletions(-)
 create mode 100644 drivers/tty/serial/sc16is7xx.h
 create mode 100644 drivers/tty/serial/sc16is7xx_i2c.c
 create mode 100644 drivers/tty/serial/sc16is7xx_spi.c

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index ffcf4882b25f9..9b5a65ea8ede3 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1021,41 +1021,30 @@ config SERIAL_SCCNXP_CONSOLE
 	  Support for console on SCCNXP serial ports.
 
 config SERIAL_SC16IS7XX_CORE
-	tristate
-
-config SERIAL_SC16IS7XX
-	tristate "SC16IS7xx serial support"
+	tristate "NXP SC16IS7xx UART support"
 	select SERIAL_CORE
-	depends on (SPI_MASTER && !I2C) || I2C
+	select SERIAL_SC16IS7XX_SPI if SPI_MASTER
+	select SERIAL_SC16IS7XX_I2C if I2C
 	help
-	  This selects support for SC16IS7xx serial ports.
-	  Supported ICs are SC16IS740, SC16IS741, SC16IS750, SC16IS752,
-	  SC16IS760 and SC16IS762. Select supported buses using options below.
+	  Core driver for NXP SC16IS7xx UARTs.
+	  Supported ICs are:
+
+	    SC16IS740
+	    SC16IS741
+	    SC16IS750
+	    SC16IS752
+	    SC16IS760
+	    SC16IS762
+
+	  The driver supports both I2C and SPI interfaces.
 
 config SERIAL_SC16IS7XX_I2C
-	bool "SC16IS7xx for I2C interface"
-	depends on SERIAL_SC16IS7XX
-	depends on I2C
-	select SERIAL_SC16IS7XX_CORE if SERIAL_SC16IS7XX
-	select REGMAP_I2C if I2C
-	default y
-	help
-	  Enable SC16IS7xx driver on I2C bus,
-	  If required say y, and say n to i2c if not required,
-	  Enabled by default to support oldconfig.
-	  You must select at least one bus for the driver to be built.
+	tristate
+	select REGMAP_I2C
 
 config SERIAL_SC16IS7XX_SPI
-	bool "SC16IS7xx for spi interface"
-	depends on SERIAL_SC16IS7XX
-	depends on SPI_MASTER
-	select SERIAL_SC16IS7XX_CORE if SERIAL_SC16IS7XX
-	select REGMAP_SPI if SPI_MASTER
-	help
-	  Enable SC16IS7xx driver on SPI bus,
-	  If required say y, and say n to spi if not required,
-	  This is additional support to existing driver.
-	  You must select at least one bus for the driver to be built.
+	tristate
+	select REGMAP_SPI
 
 config SERIAL_TIMBERDALE
 	tristate "Support for timberdale UART"
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index b25e9b54a6609..faa45f2b8bb05 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -76,6 +76,8 @@ obj-$(CONFIG_SERIAL_SAMSUNG)		+= samsung_tty.o
 obj-$(CONFIG_SERIAL_SB1250_DUART)	+= sb1250-duart.o
 obj-$(CONFIG_SERIAL_SCCNXP)		+= sccnxp.o
 obj-$(CONFIG_SERIAL_SC16IS7XX_CORE)	+= sc16is7xx.o
+obj-$(CONFIG_SERIAL_SC16IS7XX_SPI)	+= sc16is7xx_spi.o
+obj-$(CONFIG_SERIAL_SC16IS7XX_I2C)	+= sc16is7xx_i2c.o
 obj-$(CONFIG_SERIAL_SH_SCI)		+= sh-sci.o
 obj-$(CONFIG_SERIAL_SIFIVE)		+= sifive.o
 obj-$(CONFIG_SERIAL_SPRD)		+= sprd_serial.o
diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index b971fd2a9a77e..51fb1c95d3826 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1,19 +1,22 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * SC16IS7xx tty serial driver - Copyright (C) 2014 GridPoint
- * Author: Jon Ringle <jringle@gridpoint.com>
+ * SC16IS7xx tty serial driver - common code
  *
- *  Based on max310x.c, by Alexander Shiyan <shc_work@mail.ru>
+ * Copyright (C) 2014 GridPoint
+ * Author: Jon Ringle <jringle@gridpoint.com>
+ * Based on max310x.c, by Alexander Shiyan <shc_work@mail.ru>
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#undef DEFAULT_SYMBOL_NAMESPACE
+#define DEFAULT_SYMBOL_NAMESPACE SERIAL_NXP_SC16IS7XX
 
 #include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/export.h>
 #include <linux/gpio/driver.h>
-#include <linux/i2c.h>
+#include <linux/kthread.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/property.h>
@@ -21,15 +24,15 @@
 #include <linux/sched.h>
 #include <linux/serial_core.h>
 #include <linux/serial.h>
+#include <linux/string.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
-#include <linux/spi/spi.h>
 #include <linux/uaccess.h>
 #include <linux/units.h>
 
-#define SC16IS7XX_NAME			"sc16is7xx"
+#include "sc16is7xx.h"
+
 #define SC16IS7XX_MAX_DEVS		8
-#define SC16IS7XX_MAX_PORTS		2 /* Maximum number of UART ports per IC. */
 
 /* SC16IS7XX register definitions */
 #define SC16IS7XX_RHR_REG		(0x00) /* RX FIFO */
@@ -302,16 +305,9 @@
 
 
 /* Misc definitions */
-#define SC16IS7XX_SPI_READ_BIT		BIT(7)
 #define SC16IS7XX_FIFO_SIZE		(64)
 #define SC16IS7XX_GPIOS_PER_BANK	4
 
-struct sc16is7xx_devtype {
-	char	name[10];
-	int	nr_gpio;
-	int	nr_uart;
-};
-
 #define SC16IS7XX_RECONF_MD		(1 << 0)
 #define SC16IS7XX_RECONF_IER		(1 << 1)
 #define SC16IS7XX_RECONF_RS485		(1 << 2)
@@ -492,35 +488,40 @@ static void sc16is7xx_stop_rx(struct uart_port *port)
 	sc16is7xx_ier_clear(port, SC16IS7XX_IER_RDI_BIT);
 }
 
-static const struct sc16is7xx_devtype sc16is74x_devtype = {
+const struct sc16is7xx_devtype sc16is74x_devtype = {
 	.name		= "SC16IS74X",
 	.nr_gpio	= 0,
 	.nr_uart	= 1,
 };
+EXPORT_SYMBOL_GPL(sc16is74x_devtype);
 
-static const struct sc16is7xx_devtype sc16is750_devtype = {
+const struct sc16is7xx_devtype sc16is750_devtype = {
 	.name		= "SC16IS750",
 	.nr_gpio	= 8,
 	.nr_uart	= 1,
 };
+EXPORT_SYMBOL_GPL(sc16is750_devtype);
 
-static const struct sc16is7xx_devtype sc16is752_devtype = {
+const struct sc16is7xx_devtype sc16is752_devtype = {
 	.name		= "SC16IS752",
 	.nr_gpio	= 8,
 	.nr_uart	= 2,
 };
+EXPORT_SYMBOL_GPL(sc16is752_devtype);
 
-static const struct sc16is7xx_devtype sc16is760_devtype = {
+const struct sc16is7xx_devtype sc16is760_devtype = {
 	.name		= "SC16IS760",
 	.nr_gpio	= 8,
 	.nr_uart	= 1,
 };
+EXPORT_SYMBOL_GPL(sc16is760_devtype);
 
-static const struct sc16is7xx_devtype sc16is762_devtype = {
+const struct sc16is7xx_devtype sc16is762_devtype = {
 	.name		= "SC16IS762",
 	.nr_gpio	= 8,
 	.nr_uart	= 2,
 };
+EXPORT_SYMBOL_GPL(sc16is762_devtype);
 
 static bool sc16is7xx_regmap_volatile(struct device *dev, unsigned int reg)
 {
@@ -1463,9 +1464,8 @@ static const struct serial_rs485 sc16is7xx_rs485_supported = {
 	.delay_rts_after_send = 1,	/* Not supported but keep returning -EINVAL */
 };
 
-static int sc16is7xx_probe(struct device *dev,
-			   const struct sc16is7xx_devtype *devtype,
-			   struct regmap *regmaps[], int irq)
+int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
+		    struct regmap *regmaps[], int irq)
 {
 	unsigned long freq = 0, *pfreq = dev_get_platdata(dev);
 	unsigned int val;
@@ -1657,8 +1657,9 @@ static int sc16is7xx_probe(struct device *dev,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(sc16is7xx_probe);
 
-static void sc16is7xx_remove(struct device *dev)
+void sc16is7xx_remove(struct device *dev)
 {
 	struct sc16is7xx_port *s = dev_get_drvdata(dev);
 	int i;
@@ -1680,8 +1681,9 @@ static void sc16is7xx_remove(struct device *dev)
 
 	clk_disable_unprepare(s->clk);
 }
+EXPORT_SYMBOL_GPL(sc16is7xx_remove);
 
-static const struct of_device_id __maybe_unused sc16is7xx_dt_ids[] = {
+const struct of_device_id __maybe_unused sc16is7xx_dt_ids[] = {
 	{ .compatible = "nxp,sc16is740",	.data = &sc16is74x_devtype, },
 	{ .compatible = "nxp,sc16is741",	.data = &sc16is74x_devtype, },
 	{ .compatible = "nxp,sc16is750",	.data = &sc16is750_devtype, },
@@ -1690,9 +1692,10 @@ static const struct of_device_id __maybe_unused sc16is7xx_dt_ids[] = {
 	{ .compatible = "nxp,sc16is762",	.data = &sc16is762_devtype, },
 	{ }
 };
+EXPORT_SYMBOL_GPL(sc16is7xx_dt_ids);
 MODULE_DEVICE_TABLE(of, sc16is7xx_dt_ids);
 
-static struct regmap_config regcfg = {
+struct regmap_config sc16is7xx_regcfg = {
 	.reg_bits = 5,
 	.pad_bits = 3,
 	.val_bits = 8,
@@ -1705,8 +1708,9 @@ static struct regmap_config regcfg = {
 	.max_raw_write = SC16IS7XX_FIFO_SIZE,
 	.max_register = SC16IS7XX_EFCR_REG,
 };
+EXPORT_SYMBOL_GPL(sc16is7xx_regcfg);
 
-static const char *sc16is7xx_regmap_name(u8 port_id)
+const char *sc16is7xx_regmap_name(u8 port_id)
 {
 	switch (port_id) {
 	case 0:	return "port0";
@@ -1716,184 +1720,27 @@ static const char *sc16is7xx_regmap_name(u8 port_id)
 		return NULL;
 	}
 }
+EXPORT_SYMBOL_GPL(sc16is7xx_regmap_name);
 
-static unsigned int sc16is7xx_regmap_port_mask(unsigned int port_id)
+unsigned int sc16is7xx_regmap_port_mask(unsigned int port_id)
 {
 	/* CH1,CH0 are at bits 2:1. */
 	return port_id << 1;
 }
-
-#ifdef CONFIG_SERIAL_SC16IS7XX_SPI
-static int sc16is7xx_spi_probe(struct spi_device *spi)
-{
-	const struct sc16is7xx_devtype *devtype;
-	struct regmap *regmaps[SC16IS7XX_MAX_PORTS];
-	unsigned int i;
-	int ret;
-
-	/* Setup SPI bus */
-	spi->bits_per_word	= 8;
-	/* For all variants, only mode 0 is supported */
-	if ((spi->mode & SPI_MODE_X_MASK) != SPI_MODE_0)
-		return dev_err_probe(&spi->dev, -EINVAL, "Unsupported SPI mode\n");
-
-	spi->mode		= spi->mode ? : SPI_MODE_0;
-	spi->max_speed_hz	= spi->max_speed_hz ? : 4 * HZ_PER_MHZ;
-	ret = spi_setup(spi);
-	if (ret)
-		return ret;
-
-	devtype = spi_get_device_match_data(spi);
-	if (!devtype)
-		return dev_err_probe(&spi->dev, -ENODEV, "Failed to match device\n");
-
-	for (i = 0; i < devtype->nr_uart; i++) {
-		regcfg.name = sc16is7xx_regmap_name(i);
-		/*
-		 * If read_flag_mask is 0, the regmap code sets it to a default
-		 * of 0x80. Since we specify our own mask, we must add the READ
-		 * bit ourselves:
-		 */
-		regcfg.read_flag_mask = sc16is7xx_regmap_port_mask(i) |
-			SC16IS7XX_SPI_READ_BIT;
-		regcfg.write_flag_mask = sc16is7xx_regmap_port_mask(i);
-		regmaps[i] = devm_regmap_init_spi(spi, &regcfg);
-	}
-
-	return sc16is7xx_probe(&spi->dev, devtype, regmaps, spi->irq);
-}
-
-static void sc16is7xx_spi_remove(struct spi_device *spi)
-{
-	sc16is7xx_remove(&spi->dev);
-}
-
-static const struct spi_device_id sc16is7xx_spi_id_table[] = {
-	{ "sc16is74x",	(kernel_ulong_t)&sc16is74x_devtype, },
-	{ "sc16is740",	(kernel_ulong_t)&sc16is74x_devtype, },
-	{ "sc16is741",	(kernel_ulong_t)&sc16is74x_devtype, },
-	{ "sc16is750",	(kernel_ulong_t)&sc16is750_devtype, },
-	{ "sc16is752",	(kernel_ulong_t)&sc16is752_devtype, },
-	{ "sc16is760",	(kernel_ulong_t)&sc16is760_devtype, },
-	{ "sc16is762",	(kernel_ulong_t)&sc16is762_devtype, },
-	{ }
-};
-
-MODULE_DEVICE_TABLE(spi, sc16is7xx_spi_id_table);
-
-static struct spi_driver sc16is7xx_spi_uart_driver = {
-	.driver = {
-		.name		= SC16IS7XX_NAME,
-		.of_match_table	= sc16is7xx_dt_ids,
-	},
-	.probe		= sc16is7xx_spi_probe,
-	.remove		= sc16is7xx_spi_remove,
-	.id_table	= sc16is7xx_spi_id_table,
-};
-#endif
-
-#ifdef CONFIG_SERIAL_SC16IS7XX_I2C
-static int sc16is7xx_i2c_probe(struct i2c_client *i2c)
-{
-	const struct sc16is7xx_devtype *devtype;
-	struct regmap *regmaps[SC16IS7XX_MAX_PORTS];
-	unsigned int i;
-
-	devtype = i2c_get_match_data(i2c);
-	if (!devtype)
-		return dev_err_probe(&i2c->dev, -ENODEV, "Failed to match device\n");
-
-	for (i = 0; i < devtype->nr_uart; i++) {
-		regcfg.name = sc16is7xx_regmap_name(i);
-		regcfg.read_flag_mask = sc16is7xx_regmap_port_mask(i);
-		regcfg.write_flag_mask = sc16is7xx_regmap_port_mask(i);
-		regmaps[i] = devm_regmap_init_i2c(i2c, &regcfg);
-	}
-
-	return sc16is7xx_probe(&i2c->dev, devtype, regmaps, i2c->irq);
-}
-
-static void sc16is7xx_i2c_remove(struct i2c_client *client)
-{
-	sc16is7xx_remove(&client->dev);
-}
-
-static const struct i2c_device_id sc16is7xx_i2c_id_table[] = {
-	{ "sc16is74x",	(kernel_ulong_t)&sc16is74x_devtype, },
-	{ "sc16is740",	(kernel_ulong_t)&sc16is74x_devtype, },
-	{ "sc16is741",	(kernel_ulong_t)&sc16is74x_devtype, },
-	{ "sc16is750",	(kernel_ulong_t)&sc16is750_devtype, },
-	{ "sc16is752",	(kernel_ulong_t)&sc16is752_devtype, },
-	{ "sc16is760",	(kernel_ulong_t)&sc16is760_devtype, },
-	{ "sc16is762",	(kernel_ulong_t)&sc16is762_devtype, },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, sc16is7xx_i2c_id_table);
-
-static struct i2c_driver sc16is7xx_i2c_uart_driver = {
-	.driver = {
-		.name		= SC16IS7XX_NAME,
-		.of_match_table	= sc16is7xx_dt_ids,
-	},
-	.probe		= sc16is7xx_i2c_probe,
-	.remove		= sc16is7xx_i2c_remove,
-	.id_table	= sc16is7xx_i2c_id_table,
-};
-
-#endif
+EXPORT_SYMBOL_GPL(sc16is7xx_regmap_port_mask);
 
 static int __init sc16is7xx_init(void)
 {
-	int ret;
-
-	ret = uart_register_driver(&sc16is7xx_uart);
-	if (ret) {
-		pr_err("Registering UART driver failed\n");
-		return ret;
-	}
-
-#ifdef CONFIG_SERIAL_SC16IS7XX_I2C
-	ret = i2c_add_driver(&sc16is7xx_i2c_uart_driver);
-	if (ret < 0) {
-		pr_err("failed to init sc16is7xx i2c --> %d\n", ret);
-		goto err_i2c;
-	}
-#endif
-
-#ifdef CONFIG_SERIAL_SC16IS7XX_SPI
-	ret = spi_register_driver(&sc16is7xx_spi_uart_driver);
-	if (ret < 0) {
-		pr_err("failed to init sc16is7xx spi --> %d\n", ret);
-		goto err_spi;
-	}
-#endif
-	return ret;
-
-#ifdef CONFIG_SERIAL_SC16IS7XX_SPI
-err_spi:
-#endif
-#ifdef CONFIG_SERIAL_SC16IS7XX_I2C
-	i2c_del_driver(&sc16is7xx_i2c_uart_driver);
-err_i2c:
-#endif
-	uart_unregister_driver(&sc16is7xx_uart);
-	return ret;
+	return uart_register_driver(&sc16is7xx_uart);
 }
 module_init(sc16is7xx_init);
 
 static void __exit sc16is7xx_exit(void)
 {
-#ifdef CONFIG_SERIAL_SC16IS7XX_I2C
-	i2c_del_driver(&sc16is7xx_i2c_uart_driver);
-#endif
-
-#ifdef CONFIG_SERIAL_SC16IS7XX_SPI
-	spi_unregister_driver(&sc16is7xx_spi_uart_driver);
-#endif
 	uart_unregister_driver(&sc16is7xx_uart);
 }
 module_exit(sc16is7xx_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Jon Ringle <jringle@gridpoint.com>");
-MODULE_DESCRIPTION("SC16IS7XX serial driver");
+MODULE_DESCRIPTION("SC16IS7xx tty serial core driver");
diff --git a/drivers/tty/serial/sc16is7xx.h b/drivers/tty/serial/sc16is7xx.h
new file mode 100644
index 0000000000000..2ee3ce83d95a4
--- /dev/null
+++ b/drivers/tty/serial/sc16is7xx.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* SC16IS7xx SPI/I2C tty serial driver */
+
+#ifndef _SC16IS7XX_H_
+#define _SC16IS7XX_H_
+
+#include <linux/mod_devicetable.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+
+#define SC16IS7XX_NAME		"sc16is7xx"
+#define SC16IS7XX_MAX_PORTS	2 /* Maximum number of UART ports per IC. */
+
+struct device;
+
+struct sc16is7xx_devtype {
+	char	name[10];
+	int	nr_gpio;
+	int	nr_uart;
+};
+
+extern struct regmap_config sc16is7xx_regcfg;
+
+extern const struct of_device_id sc16is7xx_dt_ids[];
+
+extern const struct sc16is7xx_devtype sc16is74x_devtype;
+extern const struct sc16is7xx_devtype sc16is750_devtype;
+extern const struct sc16is7xx_devtype sc16is752_devtype;
+extern const struct sc16is7xx_devtype sc16is760_devtype;
+extern const struct sc16is7xx_devtype sc16is762_devtype;
+
+const char *sc16is7xx_regmap_name(u8 port_id);
+
+unsigned int sc16is7xx_regmap_port_mask(unsigned int port_id);
+
+int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
+		    struct regmap *regmaps[], int irq);
+
+void sc16is7xx_remove(struct device *dev);
+
+#endif /* _SC16IS7XX_H_ */
diff --git a/drivers/tty/serial/sc16is7xx_i2c.c b/drivers/tty/serial/sc16is7xx_i2c.c
new file mode 100644
index 0000000000000..de51d1675abfd
--- /dev/null
+++ b/drivers/tty/serial/sc16is7xx_i2c.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* SC16IS7xx I2C interface driver */
+
+#include <linux/dev_printk.h>
+#include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/string.h>
+
+#include "sc16is7xx.h"
+
+static int sc16is7xx_i2c_probe(struct i2c_client *i2c)
+{
+	const struct sc16is7xx_devtype *devtype;
+	struct regmap *regmaps[SC16IS7XX_MAX_PORTS];
+	unsigned int i;
+
+	devtype = i2c_get_match_data(i2c);
+	if (!devtype)
+		return dev_err_probe(&i2c->dev, -ENODEV, "Failed to match device\n");
+
+	for (i = 0; i < devtype->nr_uart; i++) {
+		sc16is7xx_regcfg.name = sc16is7xx_regmap_name(i);
+		sc16is7xx_regcfg.read_flag_mask = sc16is7xx_regmap_port_mask(i);
+		sc16is7xx_regcfg.write_flag_mask = sc16is7xx_regmap_port_mask(i);
+		regmaps[i] = devm_regmap_init_i2c(i2c, &sc16is7xx_regcfg);
+	}
+
+	return sc16is7xx_probe(&i2c->dev, devtype, regmaps, i2c->irq);
+}
+
+static void sc16is7xx_i2c_remove(struct i2c_client *client)
+{
+	sc16is7xx_remove(&client->dev);
+}
+
+static const struct i2c_device_id sc16is7xx_i2c_id_table[] = {
+	{ "sc16is74x",	(kernel_ulong_t)&sc16is74x_devtype, },
+	{ "sc16is740",	(kernel_ulong_t)&sc16is74x_devtype, },
+	{ "sc16is741",	(kernel_ulong_t)&sc16is74x_devtype, },
+	{ "sc16is750",	(kernel_ulong_t)&sc16is750_devtype, },
+	{ "sc16is752",	(kernel_ulong_t)&sc16is752_devtype, },
+	{ "sc16is760",	(kernel_ulong_t)&sc16is760_devtype, },
+	{ "sc16is762",	(kernel_ulong_t)&sc16is762_devtype, },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, sc16is7xx_i2c_id_table);
+
+static struct i2c_driver sc16is7xx_i2c_driver = {
+	.driver = {
+		.name		= SC16IS7XX_NAME,
+		.of_match_table	= sc16is7xx_dt_ids,
+	},
+	.probe		= sc16is7xx_i2c_probe,
+	.remove		= sc16is7xx_i2c_remove,
+	.id_table	= sc16is7xx_i2c_id_table,
+};
+
+module_i2c_driver(sc16is7xx_i2c_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("SC16IS7xx I2C interface driver");
+MODULE_IMPORT_NS(SERIAL_NXP_SC16IS7XX);
diff --git a/drivers/tty/serial/sc16is7xx_spi.c b/drivers/tty/serial/sc16is7xx_spi.c
new file mode 100644
index 0000000000000..f110c4e6dce63
--- /dev/null
+++ b/drivers/tty/serial/sc16is7xx_spi.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* SC16IS7xx SPI interface driver */
+
+#include <linux/dev_printk.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+#include <linux/string.h>
+#include <linux/units.h>
+
+#include "sc16is7xx.h"
+
+/* SPI definitions */
+#define SC16IS7XX_SPI_READ_BIT	BIT(7)
+
+static int sc16is7xx_spi_probe(struct spi_device *spi)
+{
+	const struct sc16is7xx_devtype *devtype;
+	struct regmap *regmaps[SC16IS7XX_MAX_PORTS];
+	unsigned int i;
+	int ret;
+
+	/* Setup SPI bus */
+	spi->bits_per_word	= 8;
+	/* For all variants, only mode 0 is supported */
+	if ((spi->mode & SPI_MODE_X_MASK) != SPI_MODE_0)
+		return dev_err_probe(&spi->dev, -EINVAL, "Unsupported SPI mode\n");
+
+	spi->mode		= spi->mode ? : SPI_MODE_0;
+	spi->max_speed_hz	= spi->max_speed_hz ? : 4 * HZ_PER_MHZ;
+	ret = spi_setup(spi);
+	if (ret)
+		return ret;
+
+	devtype = spi_get_device_match_data(spi);
+	if (!devtype)
+		return dev_err_probe(&spi->dev, -ENODEV, "Failed to match device\n");
+
+	for (i = 0; i < devtype->nr_uart; i++) {
+		sc16is7xx_regcfg.name = sc16is7xx_regmap_name(i);
+		/*
+		 * If read_flag_mask is 0, the regmap code sets it to a default
+		 * of 0x80. Since we specify our own mask, we must add the READ
+		 * bit ourselves:
+		 */
+		sc16is7xx_regcfg.read_flag_mask = sc16is7xx_regmap_port_mask(i) |
+			SC16IS7XX_SPI_READ_BIT;
+		sc16is7xx_regcfg.write_flag_mask = sc16is7xx_regmap_port_mask(i);
+		regmaps[i] = devm_regmap_init_spi(spi, &sc16is7xx_regcfg);
+	}
+
+	return sc16is7xx_probe(&spi->dev, devtype, regmaps, spi->irq);
+}
+
+static void sc16is7xx_spi_remove(struct spi_device *spi)
+{
+	sc16is7xx_remove(&spi->dev);
+}
+
+static const struct spi_device_id sc16is7xx_spi_id_table[] = {
+	{ "sc16is74x",	(kernel_ulong_t)&sc16is74x_devtype, },
+	{ "sc16is740",	(kernel_ulong_t)&sc16is74x_devtype, },
+	{ "sc16is741",	(kernel_ulong_t)&sc16is74x_devtype, },
+	{ "sc16is750",	(kernel_ulong_t)&sc16is750_devtype, },
+	{ "sc16is752",	(kernel_ulong_t)&sc16is752_devtype, },
+	{ "sc16is760",	(kernel_ulong_t)&sc16is760_devtype, },
+	{ "sc16is762",	(kernel_ulong_t)&sc16is762_devtype, },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, sc16is7xx_spi_id_table);
+
+static struct spi_driver sc16is7xx_spi_driver = {
+	.driver = {
+		.name		= SC16IS7XX_NAME,
+		.of_match_table	= sc16is7xx_dt_ids,
+	},
+	.probe		= sc16is7xx_spi_probe,
+	.remove		= sc16is7xx_spi_remove,
+	.id_table	= sc16is7xx_spi_id_table,
+};
+
+module_spi_driver(sc16is7xx_spi_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("SC16IS7xx SPI interface driver");
+MODULE_IMPORT_NS(SERIAL_NXP_SC16IS7XX);
-- 
2.39.2


