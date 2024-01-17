Return-Path: <linux-kernel+bounces-29502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1906D830F63
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A17BB2695E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605C22D7B0;
	Wed, 17 Jan 2024 22:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="pqIDe0M6"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B4A2D04C;
	Wed, 17 Jan 2024 22:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705531165; cv=none; b=dtRhUiYT6ZScCU+A8gP0ueKpE5ZCezW2BGEoNWCZSFvwCCvDkyVvR0+zquj+89Y/EY0DrK+nnF1yA+QTEVg6LugAkAGWfXiCxESzzXaiDT1IIPZbFii9QQkLQGA78c0Z2u8REyjIYdZe2/RlD5UBYlRi++aPJallvhSovAnNv9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705531165; c=relaxed/simple;
	bh=UsfYCO+9P4C5JUfMGNA9Q03iOuNiCOU6RATeL+Ld9gg=;
	h=DKIM-Signature:Received:From:To:Cc:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-SA-Exim-Connect-IP:X-SA-Exim-Mail-From:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Report:X-Spam-Status:Subject:X-SA-Exim-Version:
	 X-SA-Exim-Scanned; b=ZaL1tVNf0sjMI6I3TiIMboBEg8jK83CMc+6b2RwPp5rmzgi9VWw2Zy8NIqdNrN/IXkSO2J8zrdC7N4VFgaVSYWlc9XD0E+h2Npo5eJygvR86TOLbq7SLiETjwfR4tAWQClUdGabps2xZf85MzOgFvXA44yiNK9MKbQtD6VVGRjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=pqIDe0M6; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=2DkYHW314makx7Ntekpgg2tBupOHU+bD2YNVvAz6x6o=; b=pqIDe0M65S7w7iQ0art0+qjc9R
	KphIiZQkLbdUKeuyyCf5JoAUpMZJj8UHC4RG7QYAQtRvNLNaqpg5qt54ugt/nHaDJ4lZugRy0UVit
	RXVU6XTXePTTRKoGe+awm9Tu+ZQOJaeohYZNXk4G5jRQQWVbOlYb99VXgod/zXFckMKc=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:52924 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rQEZ4-000155-R0; Wed, 17 Jan 2024 17:39:20 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	cosmin.tanislav@analog.com,
	andy.shevchenko@gmail.com,
	shc_work@mail.ru
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Wed, 17 Jan 2024 17:38:51 -0500
Message-Id: <20240117223856.2303475-14-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240117223856.2303475-1-hugo@hugovil.com>
References: <20240117223856.2303475-1-hugo@hugovil.com>
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
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
Subject: [PATCH 13/18] serial: max310x: use common detect function for all variants
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Simplify driver by defining a common function to handle the detection
of all variants.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/max310x.c | 134 ++++++++++++++---------------------
 1 file changed, 54 insertions(+), 80 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index c93b326faf89..83beaab3a0c5 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -67,6 +67,7 @@
 #define MAX310X_BRGDIVMSB_REG		(0x1d) /* Baud rate divisor MSB */
 #define MAX310X_CLKSRC_REG		(0x1e) /* Clock source */
 #define MAX310X_REG_1F			(0x1f)
+#define MAX310X_EXTREG_START		(0x20) /* Only relevant in SPI mode. */
 
 #define MAX310X_REVID_REG		MAX310X_REG_1F /* Revision ID */
 
@@ -74,9 +75,9 @@
 #define MAX310X_GLOBALCMD_REG		MAX310X_REG_1F /* Global Command (WO) */
 
 /* Extended registers */
-#define MAX310X_SPI_REVID_EXTREG	MAX310X_REG_05 /* Revision ID */
-#define MAX310X_I2C_REVID_EXTREG	(0x25) /* Revision ID */
-
+#define MAX310X_REVID_EXTREG		(0x25) /* Revision ID
+						* (extended addressing space)
+						*/
 /* IRQ register bits */
 #define MAX310X_IRQ_LSR_BIT		(1 << 0) /* LSR interrupt */
 #define MAX310X_IRQ_SPCHR_BIT		(1 << 1) /* Special char interrupt */
@@ -250,8 +251,7 @@
 
 struct max310x_if_cfg {
 	int (*extended_reg_enable)(struct device *dev, bool enable);
-
-	unsigned int rev_id_reg;
+	u8 rev_id_offset;
 };
 
 struct max310x_devtype {
@@ -260,10 +260,11 @@ struct max310x_devtype {
 		unsigned short max;
 	} slave_addr;
 	int	nr;
-	int	(*detect)(struct device *);
 	void	(*power)(struct uart_port *, int);
 	char	name[9];
 	u8	mode1;
+	u8	rev_id_val;
+	u8	rev_id_reg; /* Relevant only if rev_id_val is defined. */
 };
 
 struct max310x_one {
@@ -324,62 +325,52 @@ static void max310x_port_update(struct uart_port *port, u8 reg, u8 mask, u8 val)
 	regmap_update_bits(one->regmap, reg, mask, val);
 }
 
-static int max3107_detect(struct device *dev)
+static int max310x_detect(struct device *dev)
 {
 	struct max310x_port *s = dev_get_drvdata(dev);
 	unsigned int val = 0;
 	int ret;
 
-	ret = regmap_read(s->regmap, MAX310X_REVID_REG, &val);
-	if (ret)
-		return ret;
+	/* Check if variant supports REV ID register: */
+	if (s->devtype->rev_id_val) {
+		u8 rev_id_reg = s->devtype->rev_id_reg;
 
-	if (((val & MAX310x_REV_MASK) != MAX3107_REV_ID)) {
-		dev_err(dev,
-			"%s ID 0x%02x does not match\n", s->devtype->name, val);
-		return -ENODEV;
-	}
+		/* Check if REV ID is in extended addressing space: */
+		if (s->devtype->rev_id_reg >= MAX310X_EXTREG_START) {
+			ret = s->if_cfg->extended_reg_enable(dev, true);
+			if (ret)
+				return ret;
 
-	return 0;
-}
+			/* Adjust REV ID extended addressing space address: */
+			if (s->if_cfg->rev_id_offset)
+				rev_id_reg -= s->if_cfg->rev_id_offset;
+		}
 
-static int max3108_detect(struct device *dev)
-{
-	struct max310x_port *s = dev_get_drvdata(dev);
-	unsigned int val = 0;
-	int ret;
+		regmap_read(s->regmap, rev_id_reg, &val);
 
-	/* MAX3108 have not REV ID register, we just check default value
-	 * from clocksource register to make sure everything works.
-	 */
-	ret = regmap_read(s->regmap, MAX310X_CLKSRC_REG, &val);
-	if (ret)
-		return ret;
+		if (s->devtype->rev_id_reg >= MAX310X_EXTREG_START) {
+			ret = s->if_cfg->extended_reg_enable(dev, false);
+			if (ret)
+				return ret;
+		}
 
-	if (val != (MAX310X_CLKSRC_EXTCLK_BIT | MAX310X_CLKSRC_PLLBYP_BIT)) {
-		dev_err(dev, "%s not present\n", s->devtype->name);
-		return -ENODEV;
-	}
+		if (((val & MAX310x_REV_MASK) != s->devtype->rev_id_val))
+			return dev_err_probe(dev, -ENODEV,
+					     "%s ID 0x%02x does not match\n",
+					     s->devtype->name, val);
+	} else {
+		/*
+		 * For variant without REV ID register, just check default value
+		 * from clocksource register to make sure everything works.
+		 */
+		ret = regmap_read(s->regmap, MAX310X_CLKSRC_REG, &val);
+		if (ret)
+			return ret;
 
-	return 0;
-}
-
-static int max3109_detect(struct device *dev)
-{
-	struct max310x_port *s = dev_get_drvdata(dev);
-	unsigned int val = 0;
-	int ret;
-
-	ret = s->if_cfg->extended_reg_enable(dev, true);
-	if (ret)
-		return ret;
-
-	regmap_read(s->regmap, s->if_cfg->rev_id_reg, &val);
-	s->if_cfg->extended_reg_enable(dev, false);
-	if (((val & MAX310x_REV_MASK) != MAX3109_REV_ID)) {
-		dev_err(dev,
-			"%s ID 0x%02x does not match\n", s->devtype->name, val);
-		return -ENODEV;
+		if (val != (MAX310X_CLKSRC_EXTCLK_BIT | MAX310X_CLKSRC_PLLBYP_BIT))
+			return dev_err_probe(dev, -ENODEV,
+					     "%s not present\n",
+					     s->devtype->name);
 	}
 
 	return 0;
@@ -394,27 +385,6 @@ static void max310x_power(struct uart_port *port, int on)
 		msleep(50);
 }
 
-static int max14830_detect(struct device *dev)
-{
-	struct max310x_port *s = dev_get_drvdata(dev);
-	unsigned int val = 0;
-	int ret;
-
-	ret = s->if_cfg->extended_reg_enable(dev, true);
-	if (ret)
-		return ret;
-
-	regmap_read(s->regmap, s->if_cfg->rev_id_reg, &val);
-	s->if_cfg->extended_reg_enable(dev, false);
-	if (((val & MAX310x_REV_MASK) != MAX14830_REV_ID)) {
-		dev_err(dev,
-			"%s ID 0x%02x does not match\n", s->devtype->name, val);
-		return -ENODEV;
-	}
-
-	return 0;
-}
-
 static void max14830_power(struct uart_port *port, int on)
 {
 	max310x_port_update(port, MAX310X_BRGCFG_REG,
@@ -428,7 +398,8 @@ static const struct max310x_devtype max3107_devtype = {
 	.name	= "MAX3107",
 	.nr	= 1,
 	.mode1	= MAX310X_MODE1_AUTOSLEEP_BIT | MAX310X_MODE1_IRQSEL_BIT,
-	.detect	= max3107_detect,
+	.rev_id_val = MAX3107_REV_ID,
+	.rev_id_reg = MAX310X_REVID_REG,
 	.power	= max310x_power,
 	.slave_addr	= {
 		.min = 0x2c,
@@ -440,7 +411,8 @@ static const struct max310x_devtype max3108_devtype = {
 	.name	= "MAX3108",
 	.nr	= 1,
 	.mode1	= MAX310X_MODE1_AUTOSLEEP_BIT,
-	.detect	= max3108_detect,
+	.rev_id_val = 0, /* Unsupported. */
+	.rev_id_reg = 0, /* Irrelevant when rev_id_val is not defined. */
 	.power	= max310x_power,
 	.slave_addr	= {
 		.min = 0x60,
@@ -452,7 +424,8 @@ static const struct max310x_devtype max3109_devtype = {
 	.name	= "MAX3109",
 	.nr	= 2,
 	.mode1	= MAX310X_MODE1_AUTOSLEEP_BIT,
-	.detect	= max3109_detect,
+	.rev_id_val = MAX3109_REV_ID,
+	.rev_id_reg = MAX310X_REVID_EXTREG,
 	.power	= max310x_power,
 	.slave_addr	= {
 		.min = 0x60,
@@ -464,7 +437,8 @@ static const struct max310x_devtype max14830_devtype = {
 	.name	= "MAX14830",
 	.nr	= 4,
 	.mode1	= MAX310X_MODE1_IRQSEL_BIT,
-	.detect	= max14830_detect,
+	.rev_id_val = MAX14830_REV_ID,
+	.rev_id_reg = MAX310X_REVID_EXTREG,
 	.power	= max14830_power,
 	.slave_addr	= {
 		.min = 0x60,
@@ -1322,7 +1296,7 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 	dev_set_drvdata(dev, s);
 
 	/* Check device to ensure we are talking to what we expect */
-	ret = devtype->detect(dev);
+	ret = max310x_detect(dev);
 	if (ret)
 		goto out_clk;
 
@@ -1501,7 +1475,7 @@ static int max310x_spi_extended_reg_enable(struct device *dev, bool enable)
 
 static const struct max310x_if_cfg __maybe_unused max310x_spi_if_cfg = {
 	.extended_reg_enable = max310x_spi_extended_reg_enable,
-	.rev_id_reg = MAX310X_SPI_REVID_EXTREG,
+	.rev_id_offset = MAX310X_EXTREG_START,
 };
 
 static int max310x_spi_probe(struct spi_device *spi)
@@ -1574,7 +1548,7 @@ static struct regmap_config regcfg_i2c = {
 	.writeable_reg = max310x_reg_writeable,
 	.volatile_reg = max310x_reg_volatile,
 	.precious_reg = max310x_reg_precious,
-	.max_register = MAX310X_I2C_REVID_EXTREG,
+	.max_register = MAX310X_REVID_EXTREG,
 	.writeable_noinc_reg = max310x_reg_noinc,
 	.readable_noinc_reg = max310x_reg_noinc,
 	.max_raw_read = MAX310X_FIFO_SIZE,
@@ -1583,7 +1557,7 @@ static struct regmap_config regcfg_i2c = {
 
 static const struct max310x_if_cfg max310x_i2c_if_cfg = {
 	.extended_reg_enable = max310x_i2c_extended_reg_enable,
-	.rev_id_reg = MAX310X_I2C_REVID_EXTREG,
+	.rev_id_offset = 0, /* No offset in I2C mode. */
 };
 
 static unsigned short max310x_i2c_slave_addr(unsigned short addr,
-- 
2.39.2


