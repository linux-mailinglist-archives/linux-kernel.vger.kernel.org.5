Return-Path: <linux-kernel+bounces-128452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94764895B02
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C835282274
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505C415B106;
	Tue,  2 Apr 2024 17:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="OZOkIwNV"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB9315ADBF;
	Tue,  2 Apr 2024 17:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079912; cv=none; b=gbzSlxlxdkIIfRZp+9YLyE950Y9cIgAU1DQN6nzZnGWkrFa+kIWyGOnGXe/nHhFm4r7/oTFl5T7LdN+1zBwCDrCsAh4zfekzgto2KB9hnTvuWJsmWFn7TyTBnvr73y9TqAKK+scjOHBhaKBSPxI7q4BbICxhHmCAxY0OJHQ+xQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079912; c=relaxed/simple;
	bh=ZExgYK1lc/odUB10bnyU121AdGCYyk5mk0k3XUuUDfg=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=lkDxcDne7DOJwAgI8CeysJiuwrahVw4gETLHP/84BWpdNBNIP0yW9tSXw7oCB1QPeyIyGz4kByYqeFr3fdsi9fnHf/a3c4cSGQ4Z9UtHTO6p2ovoCj5WCi+cHN78u5yRxM2Cxgl2UUIPWdrPwFRK0RbBnBIV1jRVz1ze0eMBO3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=OZOkIwNV; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=4a3dE7OJUM0DAJrpkdiDAWUP4yaj18BCncRxKmo3kaM=; b=OZOkIwNVXhj8/X6BUCZSg1wjro
	9FLyZMS2JNE1Gs9CPCzHWOlffLH4ajvU12yMmAEO/jD+MinSOkMuYB70vs1m1GtsfvJFUDpHPRu1H
	m0x/p9rJebOjZ29IerkNmDMYe9n3piOboY5uyx/u/7Kp85gBQCiMB5MA04UMna00jEds=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:56268 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rriC4-0008FF-FX; Tue, 02 Apr 2024 13:45:08 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	andy.shevchenko@gmail.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Tue,  2 Apr 2024 13:43:53 -0400
Message-Id: <20240402174353.256627-6-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240402174353.256627-1-hugo@hugovil.com>
References: <20240402174353.256627-1-hugo@hugovil.com>
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
Subject: [PATCH v3 5/5] serial: sc16is7xx: split into core and I2C/SPI parts (sc16is7xx_regcfg)
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Since each I2C/SPI probe function can modify sc16is7xx_regcfg at the same
time, change structure to be constant and do the required modifications on
a local copy.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c     |  2 +-
 drivers/tty/serial/sc16is7xx.h     |  2 +-
 drivers/tty/serial/sc16is7xx_i2c.c | 11 +++++++----
 drivers/tty/serial/sc16is7xx_spi.c | 11 +++++++----
 4 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 58ab6b16860b8..9d2d527dd7039 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1701,7 +1701,7 @@ const struct of_device_id __maybe_unused sc16is7xx_dt_ids[] = {
 EXPORT_SYMBOL_GPL(sc16is7xx_dt_ids);
 MODULE_DEVICE_TABLE(of, sc16is7xx_dt_ids);
 
-struct regmap_config sc16is7xx_regcfg = {
+const struct regmap_config sc16is7xx_regcfg = {
 	.reg_bits = 5,
 	.pad_bits = 3,
 	.val_bits = 8,
diff --git a/drivers/tty/serial/sc16is7xx.h b/drivers/tty/serial/sc16is7xx.h
index 410f34b1005c3..8d03357e35c7e 100644
--- a/drivers/tty/serial/sc16is7xx.h
+++ b/drivers/tty/serial/sc16is7xx.h
@@ -19,7 +19,7 @@ struct sc16is7xx_devtype {
 	int	nr_uart;
 };
 
-extern struct regmap_config sc16is7xx_regcfg;
+extern const struct regmap_config sc16is7xx_regcfg;
 
 extern const struct of_device_id __maybe_unused sc16is7xx_dt_ids[];
 
diff --git a/drivers/tty/serial/sc16is7xx_i2c.c b/drivers/tty/serial/sc16is7xx_i2c.c
index 70f0c329cc133..5667c56cf2aac 100644
--- a/drivers/tty/serial/sc16is7xx_i2c.c
+++ b/drivers/tty/serial/sc16is7xx_i2c.c
@@ -12,17 +12,20 @@ static int sc16is7xx_i2c_probe(struct i2c_client *i2c)
 {
 	const struct sc16is7xx_devtype *devtype;
 	struct regmap *regmaps[SC16IS7XX_MAX_PORTS];
+	struct regmap_config regcfg;
 	unsigned int i;
 
 	devtype = i2c_get_match_data(i2c);
 	if (!devtype)
 		return dev_err_probe(&i2c->dev, -ENODEV, "Failed to match device\n");
 
+	memcpy(&regcfg, &sc16is7xx_regcfg, sizeof(struct regmap_config));
+
 	for (i = 0; i < devtype->nr_uart; i++) {
-		sc16is7xx_regcfg.name = sc16is7xx_regmap_name(i);
-		sc16is7xx_regcfg.read_flag_mask = sc16is7xx_regmap_port_mask(i);
-		sc16is7xx_regcfg.write_flag_mask = sc16is7xx_regmap_port_mask(i);
-		regmaps[i] = devm_regmap_init_i2c(i2c, &sc16is7xx_regcfg);
+		regcfg.name = sc16is7xx_regmap_name(i);
+		regcfg.read_flag_mask = sc16is7xx_regmap_port_mask(i);
+		regcfg.write_flag_mask = sc16is7xx_regmap_port_mask(i);
+		regmaps[i] = devm_regmap_init_i2c(i2c, &regcfg);
 	}
 
 	return sc16is7xx_probe(&i2c->dev, devtype, regmaps, i2c->irq);
diff --git a/drivers/tty/serial/sc16is7xx_spi.c b/drivers/tty/serial/sc16is7xx_spi.c
index 3942fc1b7455a..55c1d4ad83f5d 100644
--- a/drivers/tty/serial/sc16is7xx_spi.c
+++ b/drivers/tty/serial/sc16is7xx_spi.c
@@ -16,6 +16,7 @@ static int sc16is7xx_spi_probe(struct spi_device *spi)
 {
 	const struct sc16is7xx_devtype *devtype;
 	struct regmap *regmaps[SC16IS7XX_MAX_PORTS];
+	struct regmap_config regcfg;
 	unsigned int i;
 	int ret;
 
@@ -35,17 +36,19 @@ static int sc16is7xx_spi_probe(struct spi_device *spi)
 	if (!devtype)
 		return dev_err_probe(&spi->dev, -ENODEV, "Failed to match device\n");
 
+	memcpy(&regcfg, &sc16is7xx_regcfg, sizeof(struct regmap_config));
+
 	for (i = 0; i < devtype->nr_uart; i++) {
-		sc16is7xx_regcfg.name = sc16is7xx_regmap_name(i);
+		regcfg.name = sc16is7xx_regmap_name(i);
 		/*
 		 * If read_flag_mask is 0, the regmap code sets it to a default
 		 * of 0x80. Since we specify our own mask, we must add the READ
 		 * bit ourselves:
 		 */
-		sc16is7xx_regcfg.read_flag_mask = sc16is7xx_regmap_port_mask(i) |
+		regcfg.read_flag_mask = sc16is7xx_regmap_port_mask(i) |
 			SC16IS7XX_SPI_READ_BIT;
-		sc16is7xx_regcfg.write_flag_mask = sc16is7xx_regmap_port_mask(i);
-		regmaps[i] = devm_regmap_init_spi(spi, &sc16is7xx_regcfg);
+		regcfg.write_flag_mask = sc16is7xx_regmap_port_mask(i);
+		regmaps[i] = devm_regmap_init_spi(spi, &regcfg);
 	}
 
 	return sc16is7xx_probe(&spi->dev, devtype, regmaps, spi->irq);
-- 
2.39.2


