Return-Path: <linux-kernel+bounces-164400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 127358B7D36
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 328961C231C5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A87C12C7FA;
	Tue, 30 Apr 2024 16:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ltts.com header.i=@ltts.com header.b="nMjkvxkf";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="KuciX4Ss"
Received: from c180-40.smtp-out.ap-south-1.amazonses.com (c180-40.smtp-out.ap-south-1.amazonses.com [76.223.180.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2487173351;
	Tue, 30 Apr 2024 16:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.223.180.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494953; cv=none; b=Efcz0DtVk9cdVjL3xLknMuPuxgdOI2IfGjAyppkZKEURDZNdHd+rJrZnMalBWJMAt9xcKEWJxk7y1LPowQMhEvI2gOTgaAaJTh/NYnbZVbsOPI+tYNlBZ2EyVdZAyb8eI3HTEqbE3CLWOcgTWp778yjMjGw/mkqx74nA9/+Cudk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494953; c=relaxed/simple;
	bh=GBwdYSqo6Yrk5sxTXJ0YXK3nqt281uzuGcvmpPcZ0KI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Of2sHsjFuWrbxke0F01xVt2rcq5aUg1Qd8ktBoVIDRz7v7ZfJRcyOrSOiUKPTLtflZj2HpJhh1C03vKD4qXWxBh+ayvkDnCC+mOLEUpWbRSYYbPiJjc9BBcn+wiBH2n/0+URK3zDVBezjXutNke+pIpkBuGkLDW5XD7OQTkwzF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ap-south-1.amazonses.com; dkim=pass (2048-bit key) header.d=ltts.com header.i=@ltts.com header.b=nMjkvxkf; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=KuciX4Ss; arc=none smtp.client-ip=76.223.180.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ap-south-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=i3fe3efcd4pbz7ipgssfqjhzqx347xbc; d=ltts.com; t=1714494948;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GBwdYSqo6Yrk5sxTXJ0YXK3nqt281uzuGcvmpPcZ0KI=;
	b=nMjkvxkfHFh11QmFSwYSylnMbOtTcUY/311ivFHyoQRRX3OAn8polbyjmMBXwyaL
	h4NmPx4yN8r62VJ0v7XrOXGz2Lqdqw+Us5EvCta+XL0aNXzdxsgcAsrTjK0ouLf0XJr
	JN+ijIQm++Q1tSBm1/Zx7nb+PXmHRUD7tHBynHdbYBpXZjYcEFKoCg+SoBbWgms3pxV
	P7CtALFJ/RMZc9KlblhI1siA6EULBYJ8Qpml1OsMd+fWIVn9CY3i1JObrpsHkh05ENt
	tU0Btrit8sRSXGSqKBu2MKgNl0Kn36AzIeBo2cffHrBbpVIYjEZXFWn08TgQBDVdIhn
	E0s46W6lXg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zpkik46mrueu52d3326ufxxchortqmoc; d=amazonses.com; t=1714494948;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=GBwdYSqo6Yrk5sxTXJ0YXK3nqt281uzuGcvmpPcZ0KI=;
	b=KuciX4SsgmNFPZuqLK+36kx/pwH6C7HDh98FhGoinUiog3MdV/7/VcrXw8Ctt4ZF
	JTjVrwU+6QTbpbfn8QFU0E7ni6csgsWvHd6Smd3nPS9Vy9TBoRJ/CunNVYc/rKD/RYu
	O/HyXfM1hj83fDZHxaAjTKmAgG0DqXLBh61VxpCg=
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
Subject: [PATCH v8 08/10] regulator: tps6594-regulator: Add TI TPS65224 PMIC regulators
Date: Tue, 30 Apr 2024 16:35:48 +0000
Message-ID: <0109018f2fdcc305-3b817569-21b6-42a7-942c-8edbff3848f2-000000@ap-south-1.amazonses.com>
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
X-SES-Outgoing: 2024.04.30-76.223.180.40

From: Nirmala Devi Mal Nadar <m.nirmaladevi@ltts.com>

Add support for TPS65224 regulators (bucks and LDOs) to TPS6594 driver as
they have significant functional overlap. TPS65224 PMIC has 4 buck
regulators and 3 LDOs. BUCK12 can operate in dual phase.
The output voltages are configurable and are meant to supply power to the
main processor and other components.

Signed-off-by: Nirmala Devi Mal Nadar <m.nirmaladevi@ltts.com>
Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/Kconfig             |   4 +-
 drivers/regulator/tps6594-regulator.c | 334 ++++++++++++++++++++------
 2 files changed, 268 insertions(+), 70 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 7db0a29b5..1e4119f00 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1563,13 +1563,15 @@ config REGULATOR_TPS6594
 	depends on MFD_TPS6594 && OF
 	default MFD_TPS6594
 	help
-	  This driver supports TPS6594 voltage regulator chips.
+	  This driver supports TPS6594 series and TPS65224 voltage regulator chips.
 	  TPS6594 series of PMICs have 5 BUCKs and 4 LDOs
 	  voltage regulators.
 	  BUCKs 1,2,3,4 can be used in single phase or multiphase mode.
 	  Part number defines which single or multiphase mode is i used.
 	  It supports software based voltage control
 	  for different voltage domains.
+	  TPS65224 PMIC has 4 BUCKs and 3 LDOs. BUCK12 can be used in dual phase.
+	  All BUCKs and LDOs volatge can be controlled through software.
 
 config REGULATOR_TPS6524X
 	tristate "TI TPS6524X Power regulators"
diff --git a/drivers/regulator/tps6594-regulator.c b/drivers/regulator/tps6594-regulator.c
index b7f0c8779..9e7886bd4 100644
--- a/drivers/regulator/tps6594-regulator.c
+++ b/drivers/regulator/tps6594-regulator.c
@@ -18,10 +18,13 @@
 
 #include <linux/mfd/tps6594.h>
 
-#define BUCK_NB		5
-#define LDO_NB		4
-#define MULTI_PHASE_NB	4
-#define REGS_INT_NB	4
+#define BUCK_NB			5
+#define LDO_NB			4
+#define MULTI_PHASE_NB		4
+/* TPS6593 and LP8764 supports OV, UV, SC, ILIM */
+#define REGS_INT_NB		4
+/* TPS65224 supports OV or UV */
+#define TPS65224_REGS_INT_NB	1
 
 enum tps6594_regulator_id {
 	/* DCDC's */
@@ -66,6 +69,15 @@ static struct tps6594_regulator_irq_type tps6594_ext_regulator_irq_types[] = {
 	  REGULATOR_EVENT_OVER_VOLTAGE_WARN },
 };
 
+static struct tps6594_regulator_irq_type tps65224_ext_regulator_irq_types[] = {
+	{ TPS65224_IRQ_NAME_VCCA_UVOV, "VCCA", "voltage out of range",
+	  REGULATOR_EVENT_REGULATION_OUT },
+	{ TPS65224_IRQ_NAME_VMON1_UVOV, "VMON1", "voltage out of range",
+	  REGULATOR_EVENT_REGULATION_OUT },
+	{ TPS65224_IRQ_NAME_VMON2_UVOV, "VMON2", "voltage out of range",
+	  REGULATOR_EVENT_REGULATION_OUT },
+};
+
 struct tps6594_regulator_irq_data {
 	struct device *dev;
 	struct tps6594_regulator_irq_type *type;
@@ -122,6 +134,27 @@ static const struct linear_range ldos_4_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1200000, 0x20, 0x74, 25000),
 };
 
+/* Voltage range for TPS65224 Bucks and LDOs */
+static const struct linear_range tps65224_bucks_1_ranges[] = {
+	REGULATOR_LINEAR_RANGE(500000, 0x0a, 0x0e, 20000),
+	REGULATOR_LINEAR_RANGE(600000, 0x0f, 0x72, 5000),
+	REGULATOR_LINEAR_RANGE(1100000, 0x73, 0xaa, 10000),
+	REGULATOR_LINEAR_RANGE(1660000, 0xab, 0xfd, 20000),
+};
+
+static const struct linear_range tps65224_bucks_2_3_4_ranges[] = {
+	REGULATOR_LINEAR_RANGE(500000, 0x0, 0x1a, 25000),
+	REGULATOR_LINEAR_RANGE(1200000, 0x1b, 0x45, 50000),
+};
+
+static const struct linear_range tps65224_ldos_1_ranges[] = {
+	REGULATOR_LINEAR_RANGE(1200000, 0xC, 0x36, 50000),
+};
+
+static const struct linear_range tps65224_ldos_2_3_ranges[] = {
+	REGULATOR_LINEAR_RANGE(600000, 0x0, 0x38, 50000),
+};
+
 /* Operations permitted on BUCK1/2/3/4/5 */
 static const struct regulator_ops tps6594_bucks_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
@@ -197,6 +230,38 @@ static const struct regulator_desc buck_regs[] = {
 			  4, 0, 0, NULL, 0, 0),
 };
 
+/* Buck configuration for TPS65224 */
+static const struct regulator_desc tps65224_buck_regs[] = {
+	TPS6594_REGULATOR("BUCK1", "buck1", TPS6594_BUCK_1,
+			  REGULATOR_VOLTAGE, tps6594_bucks_ops, TPS65224_MASK_BUCK1_VSET,
+			  TPS6594_REG_BUCKX_VOUT_1(0),
+			  TPS65224_MASK_BUCK1_VSET,
+			  TPS6594_REG_BUCKX_CTRL(0),
+			  TPS6594_BIT_BUCK_EN, 0, 0, tps65224_bucks_1_ranges,
+			  4, 0, 0, NULL, 0, 0),
+	TPS6594_REGULATOR("BUCK2", "buck2", TPS6594_BUCK_2,
+			  REGULATOR_VOLTAGE, tps6594_bucks_ops, TPS65224_MASK_BUCKS_VSET,
+			  TPS6594_REG_BUCKX_VOUT_1(1),
+			  TPS65224_MASK_BUCKS_VSET,
+			  TPS6594_REG_BUCKX_CTRL(1),
+			  TPS6594_BIT_BUCK_EN, 0, 0, tps65224_bucks_2_3_4_ranges,
+			  4, 0, 0, NULL, 0, 0),
+	TPS6594_REGULATOR("BUCK3", "buck3", TPS6594_BUCK_3,
+			  REGULATOR_VOLTAGE, tps6594_bucks_ops, TPS65224_MASK_BUCKS_VSET,
+			  TPS6594_REG_BUCKX_VOUT_1(2),
+			  TPS65224_MASK_BUCKS_VSET,
+			  TPS6594_REG_BUCKX_CTRL(2),
+			  TPS6594_BIT_BUCK_EN, 0, 0, tps65224_bucks_2_3_4_ranges,
+			  4, 0, 0, NULL, 0, 0),
+	TPS6594_REGULATOR("BUCK4", "buck4", TPS6594_BUCK_4,
+			  REGULATOR_VOLTAGE, tps6594_bucks_ops, TPS65224_MASK_BUCKS_VSET,
+			  TPS6594_REG_BUCKX_VOUT_1(3),
+			  TPS65224_MASK_BUCKS_VSET,
+			  TPS6594_REG_BUCKX_CTRL(3),
+			  TPS6594_BIT_BUCK_EN, 0, 0, tps65224_bucks_2_3_4_ranges,
+			  4, 0, 0, NULL, 0, 0),
+};
+
 static struct tps6594_regulator_irq_type tps6594_buck1_irq_types[] = {
 	{ TPS6594_IRQ_NAME_BUCK1_OV, "BUCK1", "overvoltage", REGULATOR_EVENT_OVER_VOLTAGE_WARN },
 	{ TPS6594_IRQ_NAME_BUCK1_UV, "BUCK1", "undervoltage", REGULATOR_EVENT_UNDER_VOLTAGE },
@@ -269,6 +334,41 @@ static struct tps6594_regulator_irq_type tps6594_ldo4_irq_types[] = {
 	  REGULATOR_EVENT_OVER_CURRENT },
 };
 
+static struct tps6594_regulator_irq_type tps65224_buck1_irq_types[] = {
+	{ TPS65224_IRQ_NAME_BUCK1_UVOV, "BUCK1", "voltage out of range",
+	  REGULATOR_EVENT_REGULATION_OUT },
+};
+
+static struct tps6594_regulator_irq_type tps65224_buck2_irq_types[] = {
+	{ TPS65224_IRQ_NAME_BUCK2_UVOV, "BUCK2", "voltage out of range",
+	  REGULATOR_EVENT_REGULATION_OUT },
+};
+
+static struct tps6594_regulator_irq_type tps65224_buck3_irq_types[] = {
+	{ TPS65224_IRQ_NAME_BUCK3_UVOV, "BUCK3", "voltage out of range",
+	  REGULATOR_EVENT_REGULATION_OUT },
+};
+
+static struct tps6594_regulator_irq_type tps65224_buck4_irq_types[] = {
+	{ TPS65224_IRQ_NAME_BUCK4_UVOV, "BUCK4", "voltage out of range",
+	  REGULATOR_EVENT_REGULATION_OUT },
+};
+
+static struct tps6594_regulator_irq_type tps65224_ldo1_irq_types[] = {
+	{ TPS65224_IRQ_NAME_LDO1_UVOV, "LDO1", "voltage out of range",
+	  REGULATOR_EVENT_REGULATION_OUT },
+};
+
+static struct tps6594_regulator_irq_type tps65224_ldo2_irq_types[] = {
+	{ TPS65224_IRQ_NAME_LDO2_UVOV, "LDO2", "voltage out of range",
+	  REGULATOR_EVENT_REGULATION_OUT },
+};
+
+static struct tps6594_regulator_irq_type tps65224_ldo3_irq_types[] = {
+	{ TPS65224_IRQ_NAME_LDO3_UVOV, "LDO3", "voltage out of range",
+	  REGULATOR_EVENT_REGULATION_OUT },
+};
+
 static struct tps6594_regulator_irq_type *tps6594_bucks_irq_types[] = {
 	tps6594_buck1_irq_types,
 	tps6594_buck2_irq_types,
@@ -284,7 +384,20 @@ static struct tps6594_regulator_irq_type *tps6594_ldos_irq_types[] = {
 	tps6594_ldo4_irq_types,
 };
 
-static const struct regulator_desc multi_regs[] = {
+static struct tps6594_regulator_irq_type *tps65224_bucks_irq_types[] = {
+	tps65224_buck1_irq_types,
+	tps65224_buck2_irq_types,
+	tps65224_buck3_irq_types,
+	tps65224_buck4_irq_types,
+};
+
+static struct tps6594_regulator_irq_type *tps65224_ldos_irq_types[] = {
+	tps65224_ldo1_irq_types,
+	tps65224_ldo2_irq_types,
+	tps65224_ldo3_irq_types,
+};
+
+static const struct regulator_desc tps6594_multi_regs[] = {
 	TPS6594_REGULATOR("BUCK12", "buck12", TPS6594_BUCK_1,
 			  REGULATOR_VOLTAGE, tps6594_bucks_ops, TPS6594_MASK_BUCKS_VSET,
 			  TPS6594_REG_BUCKX_VOUT_1(1),
@@ -315,7 +428,17 @@ static const struct regulator_desc multi_regs[] = {
 			  4, 4000, 0, NULL, 0, 0),
 };
 
-static const struct regulator_desc ldo_regs[] = {
+static const struct regulator_desc tps65224_multi_regs[] = {
+	TPS6594_REGULATOR("BUCK12", "buck12", TPS6594_BUCK_1,
+			  REGULATOR_VOLTAGE, tps6594_bucks_ops, TPS65224_MASK_BUCK1_VSET,
+			  TPS6594_REG_BUCKX_VOUT_1(0),
+			  TPS65224_MASK_BUCK1_VSET,
+			  TPS6594_REG_BUCKX_CTRL(0),
+			  TPS6594_BIT_BUCK_EN, 0, 0, tps65224_bucks_1_ranges,
+			  4, 4000, 0, NULL, 0, 0),
+};
+
+static const struct regulator_desc tps6594_ldo_regs[] = {
 	TPS6594_REGULATOR("LDO1", "ldo1", TPS6594_LDO_1,
 			  REGULATOR_VOLTAGE, tps6594_ldos_1_2_3_ops, TPS6594_MASK_LDO123_VSET,
 			  TPS6594_REG_LDOX_VOUT(0),
@@ -346,6 +469,30 @@ static const struct regulator_desc ldo_regs[] = {
 			  1, 0, 0, NULL, 0, 0),
 };
 
+static const struct regulator_desc tps65224_ldo_regs[] = {
+	TPS6594_REGULATOR("LDO1", "ldo1", TPS6594_LDO_1,
+			  REGULATOR_VOLTAGE, tps6594_ldos_1_2_3_ops, TPS6594_MASK_LDO123_VSET,
+			  TPS6594_REG_LDOX_VOUT(0),
+			  TPS6594_MASK_LDO123_VSET,
+			  TPS6594_REG_LDOX_CTRL(0),
+			  TPS6594_BIT_LDO_EN, 0, 0, tps65224_ldos_1_ranges,
+			  1, 0, 0, NULL, 0, TPS6594_BIT_LDO_BYPASS),
+	TPS6594_REGULATOR("LDO2", "ldo2", TPS6594_LDO_2,
+			  REGULATOR_VOLTAGE, tps6594_ldos_1_2_3_ops, TPS6594_MASK_LDO123_VSET,
+			  TPS6594_REG_LDOX_VOUT(1),
+			  TPS6594_MASK_LDO123_VSET,
+			  TPS6594_REG_LDOX_CTRL(1),
+			  TPS6594_BIT_LDO_EN, 0, 0, tps65224_ldos_2_3_ranges,
+			  1, 0, 0, NULL, 0, TPS6594_BIT_LDO_BYPASS),
+	TPS6594_REGULATOR("LDO3", "ldo3", TPS6594_LDO_3,
+			  REGULATOR_VOLTAGE, tps6594_ldos_1_2_3_ops, TPS6594_MASK_LDO123_VSET,
+			  TPS6594_REG_LDOX_VOUT(2),
+			  TPS6594_MASK_LDO123_VSET,
+			  TPS6594_REG_LDOX_CTRL(2),
+			  TPS6594_BIT_LDO_EN, 0, 0, tps65224_ldos_2_3_ranges,
+			  1, 0, 0, NULL, 0, TPS6594_BIT_LDO_BYPASS),
+};
+
 static irqreturn_t tps6594_regulator_irq_handler(int irq, void *data)
 {
 	struct tps6594_regulator_irq_data *irq_data = data;
@@ -369,17 +516,18 @@ static irqreturn_t tps6594_regulator_irq_handler(int irq, void *data)
 static int tps6594_request_reg_irqs(struct platform_device *pdev,
 				    struct regulator_dev *rdev,
 				    struct tps6594_regulator_irq_data *irq_data,
-				    struct tps6594_regulator_irq_type *tps6594_regs_irq_types,
+				    struct tps6594_regulator_irq_type *regs_irq_types,
+				    size_t interrupt_cnt,
 				    int *irq_idx)
 {
 	struct tps6594_regulator_irq_type *irq_type;
 	struct tps6594 *tps = dev_get_drvdata(pdev->dev.parent);
-	int j;
+	size_t j;
 	int irq;
 	int error;
 
-	for (j = 0; j < REGS_INT_NB; j++) {
-		irq_type = &tps6594_regs_irq_types[j];
+	for (j = 0; j < interrupt_cnt; j++) {
+		irq_type = &regs_irq_types[j];
 		irq = platform_get_irq_byname(pdev, irq_type->irq_name);
 		if (irq < 0)
 			return -EINVAL;
@@ -411,23 +559,47 @@ static int tps6594_regulator_probe(struct platform_device *pdev)
 	struct tps6594_regulator_irq_data *irq_data;
 	struct tps6594_ext_regulator_irq_data *irq_ext_reg_data;
 	struct tps6594_regulator_irq_type *irq_type;
-	u8 buck_configured[BUCK_NB] = { 0 };
-	u8 buck_multi[MULTI_PHASE_NB] = { 0 };
-	static const char * const multiphases[] = {"buck12", "buck123", "buck1234", "buck34"};
+	struct tps6594_regulator_irq_type *irq_types;
+	bool buck_configured[BUCK_NB] = { false };
+	bool buck_multi[MULTI_PHASE_NB] = { false };
+
 	static const char *npname;
-	int error, i, irq, multi, delta;
+	int error, i, irq, multi;
 	int irq_idx = 0;
 	int buck_idx = 0;
-	size_t ext_reg_irq_nb = 2;
+	int nr_ldo;
+	int nr_buck;
+	int nr_types;
+	unsigned int irq_count;
+	unsigned int multi_phase_cnt;
 	size_t reg_irq_nb;
+	struct tps6594_regulator_irq_type **bucks_irq_types;
+	const struct regulator_desc *multi_regs;
+	struct tps6594_regulator_irq_type **ldos_irq_types;
+	const struct regulator_desc *ldo_regs;
+	size_t interrupt_count;
+
+	if (tps->chip_id == TPS65224) {
+		bucks_irq_types = tps65224_bucks_irq_types;
+		interrupt_count = ARRAY_SIZE(tps65224_buck1_irq_types);
+		multi_regs = tps65224_multi_regs;
+		ldos_irq_types = tps65224_ldos_irq_types;
+		ldo_regs = tps65224_ldo_regs;
+		multi_phase_cnt = ARRAY_SIZE(tps65224_multi_regs);
+	} else {
+		bucks_irq_types = tps6594_bucks_irq_types;
+		interrupt_count = ARRAY_SIZE(tps6594_buck1_irq_types);
+		multi_regs = tps6594_multi_regs;
+		ldos_irq_types = tps6594_ldos_irq_types;
+		ldo_regs = tps6594_ldo_regs;
+		multi_phase_cnt = ARRAY_SIZE(tps6594_multi_regs);
+	}
+
 	enum {
 		MULTI_BUCK12,
+		MULTI_BUCK12_34,
 		MULTI_BUCK123,
 		MULTI_BUCK1234,
-		MULTI_BUCK12_34,
-		MULTI_FIRST = MULTI_BUCK12,
-		MULTI_LAST = MULTI_BUCK12_34,
-		MULTI_NUM = MULTI_LAST - MULTI_FIRST + 1
 	};
 
 	config.dev = tps->dev;
@@ -442,61 +614,68 @@ static int tps6594_regulator_probe(struct platform_device *pdev)
 	 * In case of Multiphase configuration, value should be defined for
 	 * buck_configured to avoid creating bucks for every buck in multiphase
 	 */
-	for (multi = MULTI_FIRST; multi < MULTI_NUM; multi++) {
-		np = of_find_node_by_name(tps->dev->of_node, multiphases[multi]);
+	for (multi = 0; multi < multi_phase_cnt; multi++) {
+		np = of_find_node_by_name(tps->dev->of_node, multi_regs[multi].supply_name);
 		npname = of_node_full_name(np);
 		np_pmic_parent = of_get_parent(of_get_parent(np));
 		if (of_node_cmp(of_node_full_name(np_pmic_parent), tps->dev->of_node->full_name))
 			continue;
-		delta = strcmp(npname, multiphases[multi]);
-		if (!delta) {
+		if (strcmp(npname, multi_regs[multi].supply_name) == 0) {
 			switch (multi) {
 			case MULTI_BUCK12:
-				buck_multi[0] = 1;
-				buck_configured[0] = 1;
-				buck_configured[1] = 1;
+				buck_multi[0] = true;
+				buck_configured[0] = true;
+				buck_configured[1] = true;
 				break;
 			/* multiphase buck34 is supported only with buck12 */
 			case MULTI_BUCK12_34:
-				buck_multi[0] = 1;
-				buck_multi[1] = 1;
-				buck_configured[0] = 1;
-				buck_configured[1] = 1;
-				buck_configured[2] = 1;
-				buck_configured[3] = 1;
+				buck_multi[0] = true;
+				buck_multi[1] = true;
+				buck_configured[0] = true;
+				buck_configured[1] = true;
+				buck_configured[2] = true;
+				buck_configured[3] = true;
 				break;
 			case MULTI_BUCK123:
-				buck_multi[2] = 1;
-				buck_configured[0] = 1;
-				buck_configured[1] = 1;
-				buck_configured[2] = 1;
+				buck_multi[2] = true;
+				buck_configured[0] = true;
+				buck_configured[1] = true;
+				buck_configured[2] = true;
 				break;
 			case MULTI_BUCK1234:
-				buck_multi[3] = 1;
-				buck_configured[0] = 1;
-				buck_configured[1] = 1;
-				buck_configured[2] = 1;
-				buck_configured[3] = 1;
+				buck_multi[3] = true;
+				buck_configured[0] = true;
+				buck_configured[1] = true;
+				buck_configured[2] = true;
+				buck_configured[3] = true;
 				break;
 			}
 		}
 	}
 
 	if (tps->chip_id == LP8764) {
-		/* There is only 4 buck on LP8764 */
-		buck_configured[4] = 1;
-		reg_irq_nb = size_mul(REGS_INT_NB, (BUCK_NB - 1));
+		nr_buck = ARRAY_SIZE(buck_regs);
+		nr_ldo = 0;
+		nr_types = REGS_INT_NB;
+	} else if (tps->chip_id == TPS65224) {
+		nr_buck = ARRAY_SIZE(tps65224_buck_regs);
+		nr_ldo = ARRAY_SIZE(tps65224_ldo_regs);
+		nr_types = REGS_INT_NB;
 	} else {
-		reg_irq_nb = size_mul(REGS_INT_NB, (size_add(BUCK_NB, LDO_NB)));
+		nr_buck = ARRAY_SIZE(buck_regs);
+		nr_ldo = ARRAY_SIZE(tps6594_ldo_regs);
+		nr_types = TPS65224_REGS_INT_NB;
 	}
 
+	reg_irq_nb = nr_types * (nr_buck + nr_ldo);
+
 	irq_data = devm_kmalloc_array(tps->dev, reg_irq_nb,
 				      sizeof(struct tps6594_regulator_irq_data), GFP_KERNEL);
 	if (!irq_data)
 		return -ENOMEM;
 
-	for (i = 0; i < MULTI_PHASE_NB; i++) {
-		if (buck_multi[i] == 0)
+	for (i = 0; i < multi_phase_cnt; i++) {
+		if (!buck_multi[i])
 			continue;
 
 		rdev = devm_regulator_register(&pdev->dev, &multi_regs[i], &config);
@@ -506,52 +685,60 @@ static int tps6594_regulator_probe(struct platform_device *pdev)
 					     pdev->name);
 
 		/* config multiphase buck12+buck34 */
-		if (i == 1)
+		if (i == MULTI_BUCK12_34)
 			buck_idx = 2;
+
 		error = tps6594_request_reg_irqs(pdev, rdev, irq_data,
-						 tps6594_bucks_irq_types[buck_idx], &irq_idx);
+						 bucks_irq_types[buck_idx],
+						 interrupt_count, &irq_idx);
 		if (error)
 			return error;
+
 		error = tps6594_request_reg_irqs(pdev, rdev, irq_data,
-						 tps6594_bucks_irq_types[buck_idx + 1], &irq_idx);
+						 bucks_irq_types[buck_idx + 1],
+						 interrupt_count, &irq_idx);
 		if (error)
 			return error;
 
-		if (i == 2 || i == 3) {
+		if (i == MULTI_BUCK123 || i == MULTI_BUCK1234) {
 			error = tps6594_request_reg_irqs(pdev, rdev, irq_data,
 							 tps6594_bucks_irq_types[buck_idx + 2],
+							 interrupt_count,
 							 &irq_idx);
 			if (error)
 				return error;
 		}
-		if (i == 3) {
+		if (i == MULTI_BUCK1234) {
 			error = tps6594_request_reg_irqs(pdev, rdev, irq_data,
 							 tps6594_bucks_irq_types[buck_idx + 3],
+							 interrupt_count,
 							 &irq_idx);
 			if (error)
 				return error;
 		}
 	}
 
-	for (i = 0; i < BUCK_NB; i++) {
-		if (buck_configured[i] == 1)
+	for (i = 0; i < nr_buck; i++) {
+		if (buck_configured[i])
 			continue;
 
-		rdev = devm_regulator_register(&pdev->dev, &buck_regs[i], &config);
+		const struct regulator_desc *buck_cfg = (tps->chip_id == TPS65224) ?
+							 tps65224_buck_regs : buck_regs;
+
+		rdev = devm_regulator_register(&pdev->dev, &buck_cfg[i], &config);
 		if (IS_ERR(rdev))
 			return dev_err_probe(tps->dev, PTR_ERR(rdev),
-					     "failed to register %s regulator\n",
-					     pdev->name);
+					     "failed to register %s regulator\n", pdev->name);
 
 		error = tps6594_request_reg_irqs(pdev, rdev, irq_data,
-						 tps6594_bucks_irq_types[i], &irq_idx);
+						 bucks_irq_types[i], interrupt_count, &irq_idx);
 		if (error)
 			return error;
 	}
 
-	/* LP8764 dosen't have LDO */
+	/* LP8764 doesn't have LDO */
 	if (tps->chip_id != LP8764) {
-		for (i = 0; i < ARRAY_SIZE(ldo_regs); i++) {
+		for (i = 0; i < nr_ldo; i++) {
 			rdev = devm_regulator_register(&pdev->dev, &ldo_regs[i], &config);
 			if (IS_ERR(rdev))
 				return dev_err_probe(tps->dev, PTR_ERR(rdev),
@@ -559,26 +746,34 @@ static int tps6594_regulator_probe(struct platform_device *pdev)
 						     pdev->name);
 
 			error = tps6594_request_reg_irqs(pdev, rdev, irq_data,
-							 tps6594_ldos_irq_types[i],
+							 ldos_irq_types[i], interrupt_count,
 							 &irq_idx);
 			if (error)
 				return error;
 		}
 	}
 
-	if (tps->chip_id == LP8764)
-		ext_reg_irq_nb = ARRAY_SIZE(tps6594_ext_regulator_irq_types);
+	if (tps->chip_id == TPS65224) {
+		irq_types = tps65224_ext_regulator_irq_types;
+		irq_count = ARRAY_SIZE(tps65224_ext_regulator_irq_types);
+	} else {
+		irq_types = tps6594_ext_regulator_irq_types;
+		if (tps->chip_id == LP8764)
+			irq_count = ARRAY_SIZE(tps6594_ext_regulator_irq_types);
+		else
+			/* TPS6593 supports only VCCA OV and UV */
+			irq_count = 2;
+	}
 
 	irq_ext_reg_data = devm_kmalloc_array(tps->dev,
-					ext_reg_irq_nb,
-					sizeof(struct tps6594_ext_regulator_irq_data),
-					GFP_KERNEL);
+					      irq_count,
+					      sizeof(struct tps6594_ext_regulator_irq_data),
+					      GFP_KERNEL);
 	if (!irq_ext_reg_data)
 		return -ENOMEM;
 
-	for (i = 0; i < ext_reg_irq_nb; ++i) {
-		irq_type = &tps6594_ext_regulator_irq_types[i];
-
+	for (i = 0; i < irq_count; ++i) {
+		irq_type = &irq_types[i];
 		irq = platform_get_irq_byname(pdev, irq_type->irq_name);
 		if (irq < 0)
 			return -EINVAL;
@@ -610,5 +805,6 @@ module_platform_driver(tps6594_regulator_driver);
 
 MODULE_ALIAS("platform:tps6594-regulator");
 MODULE_AUTHOR("Jerome Neanne <jneanne@baylibre.com>");
+MODULE_AUTHOR("Nirmala Devi Mal Nadar <m.nirmaladevi@ltts.com>");
 MODULE_DESCRIPTION("TPS6594 voltage regulator driver");
 MODULE_LICENSE("GPL");
-- 
2.25.1


