Return-Path: <linux-kernel+bounces-164397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7568B7D2D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28D0828356A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D2317BB19;
	Tue, 30 Apr 2024 16:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ltts.com header.i=@ltts.com header.b="amkOjS1B";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="CeoP/K5r"
Received: from c180-43.smtp-out.ap-south-1.amazonses.com (c180-43.smtp-out.ap-south-1.amazonses.com [76.223.180.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0239217BB0C;
	Tue, 30 Apr 2024 16:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.223.180.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494928; cv=none; b=TRQOPu7zScTKDLvmE/xlI+BRLtIxeA42n1cl0j1HUDOa0bZ7uz9OftQ62+BADxU8Gf8NU7HDTzcj3oqUulKLglJpEVAQ42nKHf30haRZz9oco15azCNaRW3iIodzcKp3jeYxhfLbEmZX7RSr5XTWU+Y+APzFrEN/DU3fpszsduc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494928; c=relaxed/simple;
	bh=IJCwVFHC82xALU9Z+JouTycL0dke5j/Wvz5yZnuBIwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QL4opjYE8eEstFlJDEVBSJqvvyh8sXs3xsyMX5rlyT3KcZQBawcTyxMcaCMY20QOUW94Rs5r8gX8gph3rTmO/6pK3tY8LewKUkBD2HfKNRV58hCwr3V1W9EOnZk45t62VacqBe0BEACR9UeyjFojPIXFnMbAV5nePS0SvxbIwHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ap-south-1.amazonses.com; dkim=pass (2048-bit key) header.d=ltts.com header.i=@ltts.com header.b=amkOjS1B; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=CeoP/K5r; arc=none smtp.client-ip=76.223.180.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ap-south-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=i3fe3efcd4pbz7ipgssfqjhzqx347xbc; d=ltts.com; t=1714494923;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IJCwVFHC82xALU9Z+JouTycL0dke5j/Wvz5yZnuBIwI=;
	b=amkOjS1BMVXN5lBRH5MAlHSS+X8CYTlOBPcl3LvGxXmtwksLZE2ayvRBVr4diuhM
	xOpSselq8CbxG+ydejw4B0ErejGqttDEwhy2ASt3H1i3OoJcVO+c6TIo4g1Omfgrm6M
	oVqdBuy7YLDKkq3N346l7YccGwSmmWVXBBS6FCU9vFR1/DGxiql/Cf9jOkH2btVyNKk
	5nDha6l2Cw/wxiMiVZG3YdotC+M2eHgwqIkhxcPd6KLM//sQYt97OFUnopd1ZlYMKQp
	aNI+TTHv07c1rE4uP27ubVNYybNNBWzWYJhBcvnPgPVXPEhoOvpG5H5uR0WZS6TAtye
	8RUqH9FKZQ==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zpkik46mrueu52d3326ufxxchortqmoc; d=amazonses.com; t=1714494923;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=IJCwVFHC82xALU9Z+JouTycL0dke5j/Wvz5yZnuBIwI=;
	b=CeoP/K5r84ACMZPm+4N2sZO6Tf4E3h6qrE/cBE6f2DS2SN2GMy/HVd/X3kznoUOn
	nKdYpNbSXBWTFtkp0kgZ1M0NixYlv5NiqxZaUStE76tXRBMUpIDQxY031NZZXwPlQ80
	G/CzIdGv0dYREQ/Fv6LvnZbKaOG4ftuYZXQs41WY=
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: linux-kernel@vger.kernel.org
Cc: bhargav.r@ltts.com, arnd@arndb.de, broonie@kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, eblanc@baylibre.com, 
	gregkh@linuxfoundation.org, jpanis@baylibre.com, kristo@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, lee@kernel.org, 
	lgirdwood@gmail.com, linus.walleij@linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	m.nirmaladevi@ltts.com, nm@ti.com, robh+dt@kernel.org, 
	vigneshr@ti.com
Subject: [PATCH v8 05/10] mfd: tps6594-spi: Add TI TPS65224 PMIC SPI
Date: Tue, 30 Apr 2024 16:35:23 +0000
Message-ID: <0109018f2fdc6328-6d13785c-9832-471b-bdfe-fb1dac3bdc60-000000@ap-south-1.amazonses.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0109018f2f24c15e-c50bfc29-5f1d-4368-a4b8-2c9f1d398abb-000000@ap-south-1.amazonses.com>
References: <0109018f2f24c15e-c50bfc29-5f1d-4368-a4b8-2c9f1d398abb-000000@ap-south-1.amazonses.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.ap-south-1./RC/PI2M8xOxQmTMPi0M1Q8h2FX69egpT62QKSaMPIA=:AmazonSES
X-SES-Outgoing: 2024.04.30-76.223.180.43

Add support for TPS65224 PMIC in TPS6594's SPI driver which has
significant functional overlap.

Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
Acked-by: Julien Panis <jpanis@baylibre.com>
---
 drivers/mfd/tps6594-spi.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/tps6594-spi.c b/drivers/mfd/tps6594-spi.c
index 5afb1736f..6ebccb79f 100644
--- a/drivers/mfd/tps6594-spi.c
+++ b/drivers/mfd/tps6594-spi.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * SPI access driver for TI TPS6594/TPS6593/LP8764 PMICs
+ * SPI access driver for TI TPS65224/TPS6594/TPS6593/LP8764 PMICs
  *
  * Copyright (C) 2023 BayLibre Incorporated - https://www.baylibre.com/
  */
@@ -66,7 +66,7 @@ static int tps6594_spi_reg_write(void *context, unsigned int reg, unsigned int v
 	return spi_write(spi, buf, count);
 }
 
-static const struct regmap_config tps6594_spi_regmap_config = {
+static struct regmap_config tps6594_spi_regmap_config = {
 	.reg_bits = 16,
 	.val_bits = 8,
 	.max_register = TPS6594_REG_DWD_FAIL_CNT_REG,
@@ -81,6 +81,7 @@ static const struct of_device_id tps6594_spi_of_match_table[] = {
 	{ .compatible = "ti,tps6594-q1", .data = (void *)TPS6594, },
 	{ .compatible = "ti,tps6593-q1", .data = (void *)TPS6593, },
 	{ .compatible = "ti,lp8764-q1",  .data = (void *)LP8764,  },
+	{ .compatible = "ti,tps65224-q1", .data = (void *)TPS65224, },
 	{}
 };
 MODULE_DEVICE_TABLE(of, tps6594_spi_of_match_table);
@@ -101,15 +102,18 @@ static int tps6594_spi_probe(struct spi_device *spi)
 	tps->reg = spi_get_chipselect(spi, 0);
 	tps->irq = spi->irq;
 
-	tps->regmap = devm_regmap_init(dev, NULL, spi, &tps6594_spi_regmap_config);
-	if (IS_ERR(tps->regmap))
-		return dev_err_probe(dev, PTR_ERR(tps->regmap), "Failed to init regmap\n");
-
 	match = of_match_device(tps6594_spi_of_match_table, dev);
 	if (!match)
 		return dev_err_probe(dev, -EINVAL, "Failed to find matching chip ID\n");
 	tps->chip_id = (unsigned long)match->data;
 
+	if (tps->chip_id == TPS65224)
+		tps6594_spi_regmap_config.volatile_table = &tps65224_volatile_table;
+
+	tps->regmap = devm_regmap_init(dev, NULL, spi, &tps6594_spi_regmap_config);
+	if (IS_ERR(tps->regmap))
+		return dev_err_probe(dev, PTR_ERR(tps->regmap), "Failed to init regmap\n");
+
 	crc8_populate_msb(tps6594_spi_crc_table, TPS6594_CRC8_POLYNOMIAL);
 
 	return tps6594_device_init(tps, enable_crc);
@@ -125,5 +129,5 @@ static struct spi_driver tps6594_spi_driver = {
 module_spi_driver(tps6594_spi_driver);
 
 MODULE_AUTHOR("Julien Panis <jpanis@baylibre.com>");
-MODULE_DESCRIPTION("TPS6594 SPI Interface Driver");
+MODULE_DESCRIPTION("SPI Interface Driver for TPS65224, TPS6594/3, and LP8764");
 MODULE_LICENSE("GPL");
-- 
2.25.1


