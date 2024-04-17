Return-Path: <linux-kernel+bounces-148428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B52B8A826D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87FA6B232F3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8DD13E8A2;
	Wed, 17 Apr 2024 11:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ltts.com header.i=@ltts.com header.b="d7OQjq2W";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="CtwqLles"
Received: from c180-41.smtp-out.ap-south-1.amazonses.com (c180-41.smtp-out.ap-south-1.amazonses.com [76.223.180.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A423A13D527;
	Wed, 17 Apr 2024 11:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.223.180.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713354599; cv=none; b=e3hsYnC5KlzvcG3bnD3lU9WS5OWChDWlchOIhC3l+c9LCFrIWDuN3sGO9R1zAsBFyd9hcpK+yCxfp0vMUYkOFSCTFXZ7S/awT05LUziU1HyeggLtHlkOoTLjTqkFWeoINHxphQ64JfoPGA4/ACwtqsoiwAOS+wLy3JLsGYIiLq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713354599; c=relaxed/simple;
	bh=zEDn16rjn9GzO2QDljpufeKyO0tKY0IaC3GTvKCqwFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tbBqJEIqkNFAczmB9GSGSwaQHeFSZeSCHUQJUrpdJcCxZSg4FhydkRPPW/rFpzeh28LYYhTi4WQhmxP9C5gQjLZ5Bmi3forD69A2qmG0HzT32bYyR0L6cCBpDcqdKtpk6zFgIfdcRoqXf9iLZzPZu6ze8luw1EcldVMjbhR9Zbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ap-south-1.amazonses.com; dkim=pass (2048-bit key) header.d=ltts.com header.i=@ltts.com header.b=d7OQjq2W; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=CtwqLles; arc=none smtp.client-ip=76.223.180.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ap-south-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=i3fe3efcd4pbz7ipgssfqjhzqx347xbc; d=ltts.com; t=1713354595;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zEDn16rjn9GzO2QDljpufeKyO0tKY0IaC3GTvKCqwFQ=;
	b=d7OQjq2WP1GraKIdT3lEgvqwvekWNuqFiNpLFOGDMwVE9lRNDgTSnrRd0qp/XE1C
	d/nognW6+1iEFgiLnvJPeJ4UUQj1YOUiB4ORf45q/tatvKTb7VzpYAflz1uTgbUCC9/
	LwB4IiiOBEhJDgyPQ0uRyUYcBFRVKU2DwFJyAJfbexsZ7ullrwF0CG6BhUPMXWRLAAl
	ZkMTluEqE9p3kPMBXV13ryoLbSWb/gtPVRAvTuo83gyZWEeXGcjBzAP2qY7mbwRX79P
	5tSQopcyYjwVgEOTR0ZMJwQqvIhB4L0OSNw8qi5y8JgdrsPmG/aCY5pU6yX6jTSVUJN
	akDxaK1NIQ==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=rlntogby6xsxlfnvyxwnvvhttakdsqto; d=amazonses.com; t=1713354595;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=zEDn16rjn9GzO2QDljpufeKyO0tKY0IaC3GTvKCqwFQ=;
	b=CtwqLlesaEuoeffl2OyqWhLzFgZCiJTz6d6K+F4NOXng8ULF42qS5m/pIR7f3SXN
	ZwkF8rIGhO6/eLQh5VL+BQd5sZF10tOrlX/4MOn1CvNAOHMP3YXq9dFnll5lDP7nOlb
	cj4OR12KhlBWfN3ftAXokfONwIj3woR1QQye3M6Y=
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
Subject: [PATCH v7 04/10] mfd: tps6594-i2c: Add TI TPS65224 PMIC I2C
Date: Wed, 17 Apr 2024 11:49:55 +0000
Message-ID: <0109018eebe45afd-938f4824-d01e-442f-a8d2-454cc6c8a60a-000000@ap-south-1.amazonses.com>
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
X-SES-Outgoing: 2024.04.17-76.223.180.41

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


