Return-Path: <linux-kernel+bounces-137258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D4189DF91
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04AF51C22F69
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0EF13D63C;
	Tue,  9 Apr 2024 15:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="GC2vcVMQ"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFCC13D511;
	Tue,  9 Apr 2024 15:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712677589; cv=none; b=HZ8AIETrHs3duprg0Xj4e6RnZYm3EbaB451Zuesls5fLguRguXbEuIqnGV3wK8HqURhZWeGU/pYO/SZk5jNuqxsURhpe7KdzGsBD96q+wTg5I0W7rWTah7Qe58XjJn8+NI+ltyDXw6EeNRE+UQi0qdYALqFP8YtjCZ9p11pSnls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712677589; c=relaxed/simple;
	bh=6x/FrKL87ewHXSXoisJ7nhcJbDHKEiI+7bcxmW/B1qM=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=mHCESJg9pN53VTDa+SSURkDwOgqEs2F/zyFbGq5MCYfWarKdNK++YIfEyp4nNI0UweZ6JyAkZIPQME68tlA4WPjqUpAlgLNhltXVI0Tkcveoix25LPf8um7p674I+HcY2mB8v5zk8aKrSHukgarEB8x3slPTg6zFXItAQ7p8p60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=GC2vcVMQ; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=Ss04GV4f/pOz5I7Yz0x/U2smmfe+lfKuSyhMTC2CfLg=; b=GC2vcVMQEtwI/H1X3Mq1oT/DYO
	CHS+awi25MbLqUMpbqLYN4xIpZGkrh8ImSkqK4begQ63o25p5xWk7qrPZzNYYvK7gx/qUMozFzqOu
	IzoTe6wfwjh4my46paPLmBOc5PY7ovHQUnp9KeLFRj+fAabFPIBz/CwtpNN0K3ltBN/w=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:44750 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1ruDfw-0002NM-2o; Tue, 09 Apr 2024 11:46:20 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	peterz@infradead.org,
	mingo@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	andy.shevchenko@gmail.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andy@kernel.org>
Date: Tue,  9 Apr 2024 11:42:53 -0400
Message-Id: <20240409154253.3043822-6-hugo@hugovil.com>
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
Subject: [PATCH v4 5/5] serial: sc16is7xx: split into core and I2C/SPI parts (sc16is7xx_regcfg)
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Since each I2C/SPI probe function can modify sc16is7xx_regcfg at the same
time, change structure to be constant and do the required modifications on
a local copy.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
---
 drivers/tty/serial/sc16is7xx.c     |  2 +-
 drivers/tty/serial/sc16is7xx.h     |  2 +-
 drivers/tty/serial/sc16is7xx_i2c.c | 11 +++++++----
 drivers/tty/serial/sc16is7xx_spi.c | 11 +++++++----
 4 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 1eb440f0c9cd0..1e99ddd70b376 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1705,7 +1705,7 @@ const struct of_device_id __maybe_unused sc16is7xx_dt_ids[] = {
 EXPORT_SYMBOL_GPL(sc16is7xx_dt_ids);
 MODULE_DEVICE_TABLE(of, sc16is7xx_dt_ids);
 
-struct regmap_config sc16is7xx_regcfg = {
+const struct regmap_config sc16is7xx_regcfg = {
 	.reg_bits = 5,
 	.pad_bits = 3,
 	.val_bits = 8,
diff --git a/drivers/tty/serial/sc16is7xx.h b/drivers/tty/serial/sc16is7xx.h
index 2ee3ce83d95a4..afb784eaee45b 100644
--- a/drivers/tty/serial/sc16is7xx.h
+++ b/drivers/tty/serial/sc16is7xx.h
@@ -19,7 +19,7 @@ struct sc16is7xx_devtype {
 	int	nr_uart;
 };
 
-extern struct regmap_config sc16is7xx_regcfg;
+extern const struct regmap_config sc16is7xx_regcfg;
 
 extern const struct of_device_id sc16is7xx_dt_ids[];
 
diff --git a/drivers/tty/serial/sc16is7xx_i2c.c b/drivers/tty/serial/sc16is7xx_i2c.c
index de51d1675abfd..3ed47c306d855 100644
--- a/drivers/tty/serial/sc16is7xx_i2c.c
+++ b/drivers/tty/serial/sc16is7xx_i2c.c
@@ -14,17 +14,20 @@ static int sc16is7xx_i2c_probe(struct i2c_client *i2c)
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
index f110c4e6dce63..73df36f8a7fd8 100644
--- a/drivers/tty/serial/sc16is7xx_spi.c
+++ b/drivers/tty/serial/sc16is7xx_spi.c
@@ -18,6 +18,7 @@ static int sc16is7xx_spi_probe(struct spi_device *spi)
 {
 	const struct sc16is7xx_devtype *devtype;
 	struct regmap *regmaps[SC16IS7XX_MAX_PORTS];
+	struct regmap_config regcfg;
 	unsigned int i;
 	int ret;
 
@@ -37,17 +38,19 @@ static int sc16is7xx_spi_probe(struct spi_device *spi)
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


