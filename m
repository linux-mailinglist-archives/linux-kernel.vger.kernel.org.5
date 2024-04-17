Return-Path: <linux-kernel+bounces-148429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2498A826F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1B1B1C22A6C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC1213CFA6;
	Wed, 17 Apr 2024 11:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ltts.com header.i=@ltts.com header.b="wiy4mEFz";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="AlPoElaa"
Received: from c180-39.smtp-out.ap-south-1.amazonses.com (c180-39.smtp-out.ap-south-1.amazonses.com [76.223.180.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A113B13D62C;
	Wed, 17 Apr 2024 11:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.223.180.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713354600; cv=none; b=svJJM68xv2NPlVEpSAdTDcYJOICI07U9UhTuGaNCoDIyBBsk59gmDyfqG+lA6LcXeRe5/MoVGeGSVqM+LszVfPPIIjzTZni3xnLeqAS2Ho7zsdnkkFpvBcMsKBkBDbHpUAbmiYekgM5z9nGLHrHOueVeyXVHMyrDHIrEVsaYlec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713354600; c=relaxed/simple;
	bh=IJCwVFHC82xALU9Z+JouTycL0dke5j/Wvz5yZnuBIwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hV2XBJ4xg5iTKmmwIVis9npGrrGDTP1uZOtry/VMWpoc1Hqsg+/tmI/4yZxtpBbPJ3hx7qb2fQr4QEvuApaP7BIQMrHSjtDJQR5By9Lt/X/1zJ6Vr3BmpnKlbUCOR/fuMGFgkCOe+26TBHoIvwHNdEycbLe40uTpxEduWULyyII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ap-south-1.amazonses.com; dkim=pass (2048-bit key) header.d=ltts.com header.i=@ltts.com header.b=wiy4mEFz; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=AlPoElaa; arc=none smtp.client-ip=76.223.180.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ap-south-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=i3fe3efcd4pbz7ipgssfqjhzqx347xbc; d=ltts.com; t=1713354596;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IJCwVFHC82xALU9Z+JouTycL0dke5j/Wvz5yZnuBIwI=;
	b=wiy4mEFzdDsconXdj9saFtiUTNauojzhkC9sNaayY4UYv5w4OeaVOENRzkDeCQK3
	BTk+XeIcnrWtknR/BaISH8G62Y6uB1yQ3e9dJ7YX4JfI2DzDBPSGjazcj3U4F/wIedd
	kGpFasI5WIw2HfgY36JYiASD4jFV5k27uMS6ydLsRppNnGQFm1LadNwFh5p4POClsoc
	1U2LltbdCX2kbXpV4qejvqKPiDPVQyA/iy5u38FN5SFJ+55cB0Odw9nS3ycfstCJdJJ
	PFDKJ0eAUv8jLEswpEj8Po3N9wcJCXz9GIpDiu9yPEjaCDd2ZxJD90iKh+gu+shWzKU
	A7oeeriBzw==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=rlntogby6xsxlfnvyxwnvvhttakdsqto; d=amazonses.com; t=1713354596;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=IJCwVFHC82xALU9Z+JouTycL0dke5j/Wvz5yZnuBIwI=;
	b=AlPoElaas3p1c/qeSSY5zbzCO8gAgv12uZW3D1wjf0l3SYJSri6Cqnn4Bd7A5kmy
	eFSpfRZtG3EAhciG7ktwTdL/pLAUVxdtGLYzTqg+cbeZeBNFADPfp+tNNtWEZXThJyB
	kxVItaAE2TmTcwd21Ca6Cy5mANqr84ENsWGg+JUg=
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: linux-kernel@vger.kernel.org
Cc: m.nirmaladevi@ltts.com, lee@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	jpanis@baylibre.com, devicetree@vger.kernel.org, arnd@arndb.de, 
	gregkh@linuxfoundation.org, lgirdwood@gmail.com, broonie@kernel.org, 
	linus.walleij@linaro.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, nm@ti.com, vigneshr@ti.com, 
	kristo@kernel.org, eblanc@baylibre.com, 
	Bhargav Raviprakash <bhargav.r@ltts.com>
Subject: [PATCH v7 05/10] mfd: tps6594-spi: Add TI TPS65224 PMIC SPI
Date: Wed, 17 Apr 2024 11:49:56 +0000
Message-ID: <0109018eebe45f0a-6aef6bbc-11ee-4e48-b39e-b1fbf42e510d-000000@ap-south-1.amazonses.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240417114934.186248-1-bhargav.r@ltts.com>
References: <20240417114934.186248-1-bhargav.r@ltts.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.ap-south-1./RC/PI2M8xOxQmTMPi0M1Q8h2FX69egpT62QKSaMPIA=:AmazonSES
X-SES-Outgoing: 2024.04.17-76.223.180.39

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


