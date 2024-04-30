Return-Path: <linux-kernel+bounces-164394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E558B7D22
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52E001C233A2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A9E181B82;
	Tue, 30 Apr 2024 16:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ltts.com header.i=@ltts.com header.b="LtTR4xUx";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="l4AIKQ5F"
Received: from c180-37.smtp-out.ap-south-1.amazonses.com (c180-37.smtp-out.ap-south-1.amazonses.com [76.223.180.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD57B660;
	Tue, 30 Apr 2024 16:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.223.180.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494832; cv=none; b=QKmk2dg97ntqQlMi0/ypZgjjZw6NEip6yWRp3CeYJtpyujbX49LD8JXdIZ3eHx+oQnGjQ/ccatluZmBHvCFg5bpkPC/GnDt6JQiLVhhi3v8+6nNLoPHS5FC6yf7V64vA5KgOgKi2IXOn/+cNEmVpdt/HZX+btMbnj0xrUj9XRm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494832; c=relaxed/simple;
	bh=zEDn16rjn9GzO2QDljpufeKyO0tKY0IaC3GTvKCqwFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYLYrBbEZ2FeTqQnu0EMnatAz5hRSnLkCJbpYeOGip9i1rTx1sz0iZXRVgjcIgEeDQsMiZJEjXRBsQ7r0m67uK6VE1Ls7oFa+Npz818NGwjOH2q3nYCPS1SR9lZD1N/wS9pB8WjcpqEElyyLQfYA5RNtGo/npJ3n7WtxtR+/uoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ap-south-1.amazonses.com; dkim=pass (2048-bit key) header.d=ltts.com header.i=@ltts.com header.b=LtTR4xUx; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=l4AIKQ5F; arc=none smtp.client-ip=76.223.180.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ap-south-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=i3fe3efcd4pbz7ipgssfqjhzqx347xbc; d=ltts.com; t=1714494827;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zEDn16rjn9GzO2QDljpufeKyO0tKY0IaC3GTvKCqwFQ=;
	b=LtTR4xUxAsHJUp9Iy+Wt9Xq1iB2+9ja62inaDe0dk4R5Y3SLiHEz4Ah3ruERqYPf
	xB1ccpjLEdgqFEpG9k0x0tQgQpwZij1c8K8wzo+eMWxyOi1ANrdlUJUwHhPSB0M3e3W
	AiCcIgjYW+05zyd6TOEVXVChGOG7FauReDdcVh2gTb/tyualS/nVg524ERm0b+Oxdtk
	3t5nxWdD5foQcm46QksfIdFPab8k0m1WbpR7K2RJf2Sow90omUoCNYWtvORxn1LbmUp
	l+KYJA3Qj04bgoBayaGBrouoDGag5t1G7UrhA9KASuu7o0inhhk2N3Pk8pzuqHIhS/N
	FpT9VCvWZQ==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zpkik46mrueu52d3326ufxxchortqmoc; d=amazonses.com; t=1714494827;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=zEDn16rjn9GzO2QDljpufeKyO0tKY0IaC3GTvKCqwFQ=;
	b=l4AIKQ5FJUZQ3PX2YdvfnxmgT/wH4VkDtsBIZ61gZbZdZVfm4o4vZZkmEUCvwHVR
	34z8EJNxjD8Mz0xQWsXGnuOr04Z5yVFY/NrQR2uGyseUq8ZF8vBQn03/SROohum8b30
	Pc5H4/qUmYv2ojj5TdydBHWx62cfyXqEOU3DaUs4=
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, broonie@kernel.org, conor+dt@kernel.org, 
	conor.dooley@microchip.com, devicetree@vger.kernel.org, 
	eblanc@baylibre.com, gregkh@linuxfoundation.org, jpanis@baylibre.com, 
	kristo@kernel.org, krzysztof.kozlowski+dt@linaro.org, lee@kernel.org, 
	lgirdwood@gmail.com, linus.walleij@linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	m.nirmaladevi@ltts.com, nm@ti.com, robh+dt@kernel.org, 
	vigneshr@ti.com, Bhargav Raviprakash <bhargav.r@ltts.com>
Subject: [PATCH v8 04/10] mfd: tps6594-i2c: Add TI TPS65224 PMIC I2C
Date: Tue, 30 Apr 2024 16:33:47 +0000
Message-ID: <0109018f2fdaecea-12513236-1059-4227-9078-7b3e0d447cc0-000000@ap-south-1.amazonses.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0109018f2f26a14f-157bb3a2-2f9b-4653-a619-46e1feb8f229-000000@ap-south-1.amazonses.com>
References: <0109018f2f26a14f-157bb3a2-2f9b-4653-a619-46e1feb8f229-000000@ap-south-1.amazonses.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.ap-south-1./RC/PI2M8xOxQmTMPi0M1Q8h2FX69egpT62QKSaMPIA=:AmazonSES
X-SES-Outgoing: 2024.04.30-76.223.180.37

Add support for TPS65224 PMIC in TPS6594's I2C driver which has
significant functional overlap.

Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
Acked-by: Julien Panis <jpanis@baylibre.com>
---
 drivers/mfd/tps6594-i2c.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/tps6594-i2c.c b/drivers/mfd/tps6594-i2c.c
index c125b474b..4ab91c34d 100644
--- a/drivers/mfd/tps6594-i2c.c
+++ b/drivers/mfd/tps6594-i2c.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * I2C access driver for TI TPS6594/TPS6593/LP8764 PMICs
+ * I2C access driver for TI TPS65224/TPS6594/TPS6593/LP8764 PMICs
  *
  * Copyright (C) 2023 BayLibre Incorporated - https://www.baylibre.com/
  */
@@ -183,7 +183,7 @@ static int tps6594_i2c_write(void *context, const void *data, size_t count)
 	return ret;
 }
 
-static const struct regmap_config tps6594_i2c_regmap_config = {
+static struct regmap_config tps6594_i2c_regmap_config = {
 	.reg_bits = 16,
 	.val_bits = 8,
 	.max_register = TPS6594_REG_DWD_FAIL_CNT_REG,
@@ -196,6 +196,7 @@ static const struct of_device_id tps6594_i2c_of_match_table[] = {
 	{ .compatible = "ti,tps6594-q1", .data = (void *)TPS6594, },
 	{ .compatible = "ti,tps6593-q1", .data = (void *)TPS6593, },
 	{ .compatible = "ti,lp8764-q1",  .data = (void *)LP8764,  },
+	{ .compatible = "ti,tps65224-q1", .data = (void *)TPS65224, },
 	{}
 };
 MODULE_DEVICE_TABLE(of, tps6594_i2c_of_match_table);
@@ -216,15 +217,18 @@ static int tps6594_i2c_probe(struct i2c_client *client)
 	tps->reg = client->addr;
 	tps->irq = client->irq;
 
-	tps->regmap = devm_regmap_init(dev, NULL, client, &tps6594_i2c_regmap_config);
-	if (IS_ERR(tps->regmap))
-		return dev_err_probe(dev, PTR_ERR(tps->regmap), "Failed to init regmap\n");
-
 	match = of_match_device(tps6594_i2c_of_match_table, dev);
 	if (!match)
 		return dev_err_probe(dev, -EINVAL, "Failed to find matching chip ID\n");
 	tps->chip_id = (unsigned long)match->data;
 
+	if (tps->chip_id == TPS65224)
+		tps6594_i2c_regmap_config.volatile_table = &tps65224_volatile_table;
+
+	tps->regmap = devm_regmap_init(dev, NULL, client, &tps6594_i2c_regmap_config);
+	if (IS_ERR(tps->regmap))
+		return dev_err_probe(dev, PTR_ERR(tps->regmap), "Failed to init regmap\n");
+
 	crc8_populate_msb(tps6594_i2c_crc_table, TPS6594_CRC8_POLYNOMIAL);
 
 	return tps6594_device_init(tps, enable_crc);
@@ -240,5 +244,5 @@ static struct i2c_driver tps6594_i2c_driver = {
 module_i2c_driver(tps6594_i2c_driver);
 
 MODULE_AUTHOR("Julien Panis <jpanis@baylibre.com>");
-MODULE_DESCRIPTION("TPS6594 I2C Interface Driver");
+MODULE_DESCRIPTION("I2C Interface Driver for TPS65224, TPS6594/3, and LP8764");
 MODULE_LICENSE("GPL");
-- 
2.25.1


