Return-Path: <linux-kernel+bounces-164396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A688B7D2A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 317DD1C23327
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370CA176FA8;
	Tue, 30 Apr 2024 16:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ltts.com header.i=@ltts.com header.b="r8aLWyOa";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="iFe69TVP"
Received: from c180-41.smtp-out.ap-south-1.amazonses.com (c180-41.smtp-out.ap-south-1.amazonses.com [76.223.180.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25462DDBE;
	Tue, 30 Apr 2024 16:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.223.180.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494906; cv=none; b=QfRmdoMgePFcnHFt52xU0mLzR2ydLSmXmZSmbqqFDSKBo/rik3FmDnThz6cUlO6v2utmplLOUpGiJIpdn1y+nEmKtENQuAiw6VuAdD7CgSNgceqM8dwREAm9a+49bXBPawMvF0WMXjPRx2HMw24IXZ23FphUuAB3V/m22CrUtuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494906; c=relaxed/simple;
	bh=zEDn16rjn9GzO2QDljpufeKyO0tKY0IaC3GTvKCqwFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=shTNEtj4b4mY1d0xrh/p/wZGRLqSw1ObY5u/CQPZhx/hGMnsrTCCSF3GY48SB4ZfH6T2+EoYispSJX8bRRDjhqGiIQdVyZ1fXM+/R+dOMWDC4Mjxz15IR+p/OsJdEULUQPeG3y12ty2v5ApcxDn7kl1HLpaTP+COSCZrKyRGS5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ap-south-1.amazonses.com; dkim=pass (2048-bit key) header.d=ltts.com header.i=@ltts.com header.b=r8aLWyOa; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=iFe69TVP; arc=none smtp.client-ip=76.223.180.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ap-south-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=i3fe3efcd4pbz7ipgssfqjhzqx347xbc; d=ltts.com; t=1714494901;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zEDn16rjn9GzO2QDljpufeKyO0tKY0IaC3GTvKCqwFQ=;
	b=r8aLWyOaOBg6rSjBJ66YeJKwv0dFnyjrDRjtictbTipPkifspPSS+8+9xlI7yz7A
	3RU6b+kOgrIVFyWaglnlcsfU5d5OwremZL3VcXn+1396/A9S3ciAh1D+lP/ior+5izy
	xnjEIc/C4S6Sd5O+9GkWdpWQcgPC236zBelewSJKmueaZEhmZkese6ViFZvuXBjdHyq
	0h2KlAvV3ZMcuVgdfTjxVlhX93YN3+YbTIld4w0uQXHgSoLe9VOW5vlNco0z5Lnl6fC
	BCtgOoo7d4rtXGLFIRojjBPgXGiH1gukIU5uOnnNU882RcwHctLdmCAyroGzg6JXOLP
	gt04ADnX7g==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zpkik46mrueu52d3326ufxxchortqmoc; d=amazonses.com; t=1714494901;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=zEDn16rjn9GzO2QDljpufeKyO0tKY0IaC3GTvKCqwFQ=;
	b=iFe69TVPnG6pdZhasxwgQnWOnk7O+nWC23Mis94q0atYZmajQQVi7ucEBaOXsY/u
	/GpRtqlZ/m6ELfgaBBMALfdQl1p3+q5YrnxOTFa7htJlBr58gaEElEwrujA6NxUn9Jk
	tCOO33WV2BpVVKNkDqjZ+rmfHG6crszsRNL4MbDc=
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
Subject: [PATCH v8 04/10] mfd: tps6594-i2c: Add TI TPS65224 PMIC I2C
Date: Tue, 30 Apr 2024 16:35:01 +0000
Message-ID: <0109018f2fdc0d44-9e032c9d-52ed-451e-bd22-bb51b8b474b0-000000@ap-south-1.amazonses.com>
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
X-SES-Outgoing: 2024.04.30-76.223.180.41

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


