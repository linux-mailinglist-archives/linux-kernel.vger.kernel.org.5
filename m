Return-Path: <linux-kernel+bounces-112269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D37C98877AE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 09:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A6D9282E2C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 08:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE791798E;
	Sat, 23 Mar 2024 08:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wo3NWoWw"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9ACD515;
	Sat, 23 Mar 2024 08:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711184352; cv=none; b=HuiyzHmfG00VPD3Yoyp5ApIH1jOFH/caI8PCo7iaeV5mxyTaipN3oDQcBFEf4Zzh8eEVOJ5adVhi4Qrj9Auz0YyTnGuz+NJOAR2UbzrOiUHxTs524S5un2HckDmKhILHhLpzcTW4UNk7LcNuRzfS1673llNqcgME/h/MJDKonP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711184352; c=relaxed/simple;
	bh=kfiLB3GtUR6o86KDQN1dbPxJbdjpXmDPaJ263k2kRps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N3D9lPImpbWxakBv8mL+5RFfZ5vA7NCPBR5hfctRnsa4v6evL4K42hZN0OivLrZbI/GNfp+O4kH2uSL34kik/bmGgaG8Zj8iOWr3JLWT5G0SvRd0U4XIxMDHwdgBFG5RfD7WAolN8hkWto4GoeVqzAf0lJiQPaSfnARRvJvcAik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wo3NWoWw; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4148090ca8aso2109925e9.1;
        Sat, 23 Mar 2024 01:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711184349; x=1711789149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLm5N2elrmTjUHMVtFcMTkTBFdhySIL8k7u7/87O5Qo=;
        b=Wo3NWoWwAkqsKtmXl5++rP/+UD5mTjQl46hR8eb6njyv2Q+YLW767zARgQigVBqJG6
         e9ENW0pdGK4IQ4PPwv0+15P1+g2pOC5ZwtQt9x22/yBUo1tXeUcrLP1QV2o8gXwJkozk
         hiKo1Hy3E1JAGPEtAf41S6os3sh42mzlEmwsJegQIX3fkbl6gNSd2h+Y/AOFawKdF2/D
         XJCenHJwVFPdOvwpApci4t6qThaBAOgp7vshzSPQkZlUytBoPW+VjqZ92U+FAf6/dl5O
         YXHxq7e/vFdd7IeAaTxWN9GZ0YqJvlFWZJLqzP/Jp+xEtoJld/B4PQ0kSAIsKsVcVU4H
         oaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711184349; x=1711789149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mLm5N2elrmTjUHMVtFcMTkTBFdhySIL8k7u7/87O5Qo=;
        b=MeDlWZjXWyQV1i+MyhCNtEPBFn08CbewbAFF2i0WTOThgBDE4UY9ZYBcTae0DIARA9
         DIdC22vf8nRjmFEQKzUZMlWCJdAQJhy5sKlexzIrd47UvT8RdBWHDvOxhtR9B7hQLBjf
         cThw/Qu5A7wJ0C6U5WtYzNLfBDhRD2M45E1G/dnhpA/n51TRnFiyXf3Lj1vNWORyztot
         1e2pqdYNVQWhzDHwcHjH3p5DxnZWYeBWpr75ziX1sMVv4FsN5jLTGfplYfM/qqpChdLQ
         dR9IbMqmkovrFwjf2QZKOIGJ1cDqZwSIzcHLcqQQmPywC8GvsYxlPr2IFZmkgsi5n9dn
         CmFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlEW0BT74b3CbCnL2s/tL6LJLrV70YvlqjmoGFQFvLTcoOn6CIIrBGtQO887w5e2asBd1wEVwq0kwHAV9coN6QQ74sU4QrUr8uAdHdPG2RPAPe138fnGcZ3MCktMFraTbiBYvT6YGWmzZn6n8W+9gHwVWno8tqVF6cEhhC7MSj9sZX6cY=
X-Gm-Message-State: AOJu0Yz2SXHxUaH2yolz61n219poB7Iv1rR7TAHALkkIhFdHfvkn5rBD
	/LaP1vvgYh3U8PzHOcsjXMSu1lIE/AST+/UOYNZS0DpKUmhljFU=
X-Google-Smtp-Source: AGHT+IG5UVOEGkBm3PXz1ubUKOZQVmOQyhI9m1fpgBEm4E5qn64Qw2XkH91sWPLYALGXzFFFlSAwCQ==
X-Received: by 2002:a05:600c:1989:b0:414:6cc9:6d88 with SMTP id t9-20020a05600c198900b004146cc96d88mr924394wmq.36.1711184349051;
        Sat, 23 Mar 2024 01:59:09 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:fbb8:7547:139d:a40f])
        by smtp.gmail.com with ESMTPSA id x16-20020a5d6b50000000b0033e93e00f68sm3965031wrw.61.2024.03.23.01.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 01:59:08 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Chris Zhong <zyw@rock-chips.com>,
	Zhang Qing <zhangqing@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 2/5] mfd: rk8xx: Add RK816 support
Date: Sat, 23 Mar 2024 09:58:49 +0100
Message-ID: <20240323085852.116756-3-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240323085852.116756-1-knaerzche@gmail.com>
References: <20240323085852.116756-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This integrates RK816 support in the this existing rk8xx mfd driver.

This version has unaligned interrupt registers, which requires to define a
separate get_irq_reg callback for the regmap. Apart from that the
integration is straightforward and the existing structures can be used as
is. The initialization sequence has been taken from vendor kernel.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
chnages since v1:
  - un-constify rk816_get_irq_reg's return type

 drivers/mfd/Kconfig       |   4 +-
 drivers/mfd/rk8xx-core.c  | 103 ++++++++++++++++++++++++++++
 drivers/mfd/rk8xx-i2c.c   |  45 +++++++++++-
 include/linux/mfd/rk808.h | 141 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 290 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 4b023ee229cf..2e7286cc98e4 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1225,7 +1225,7 @@ config MFD_RK8XX
 	select MFD_CORE
 
 config MFD_RK8XX_I2C
-	tristate "Rockchip RK805/RK808/RK809/RK817/RK818 Power Management Chip"
+	tristate "Rockchip RK805/RK808/RK809/RK816/RK817/RK818 Power Management Chip"
 	depends on I2C && OF
 	select MFD_CORE
 	select REGMAP_I2C
@@ -1233,7 +1233,7 @@ config MFD_RK8XX_I2C
 	select MFD_RK8XX
 	help
 	  If you say yes here you get support for the RK805, RK808, RK809,
-	  RK817 and RK818 Power Management chips.
+	  RK816, RK817 and RK818 Power Management chips.
 	  This driver provides common support for accessing the device
 	  through I2C interface. The device supports multiple sub-devices
 	  including interrupts, RTC, LDO & DCDC regulators, and onkey.
diff --git a/drivers/mfd/rk8xx-core.c b/drivers/mfd/rk8xx-core.c
index e2261b68b844..c68a380332e7 100644
--- a/drivers/mfd/rk8xx-core.c
+++ b/drivers/mfd/rk8xx-core.c
@@ -28,6 +28,10 @@ static const struct resource rtc_resources[] = {
 	DEFINE_RES_IRQ(RK808_IRQ_RTC_ALARM),
 };
 
+static const struct resource rk816_rtc_resources[] = {
+	DEFINE_RES_IRQ(RK816_IRQ_RTC_ALARM),
+};
+
 static const struct resource rk817_rtc_resources[] = {
 	DEFINE_RES_IRQ(RK817_IRQ_RTC_ALARM),
 };
@@ -87,6 +91,21 @@ static const struct mfd_cell rk808s[] = {
 	},
 };
 
+static const struct mfd_cell rk816s[] = {
+	{ .name = "rk805-pinctrl", },
+	{ .name = "rk808-clkout", },
+	{ .name = "rk808-regulator", },
+	{	.name = "rk805-pwrkey",
+		.num_resources = ARRAY_SIZE(rk805_key_resources),
+		.resources = rk805_key_resources,
+	},
+	{
+		.name = "rk808-rtc",
+		.num_resources = ARRAY_SIZE(rk816_rtc_resources),
+		.resources = rk816_rtc_resources,
+	},
+};
+
 static const struct mfd_cell rk817s[] = {
 	{ .name = "rk808-clkout", },
 	{ .name = "rk808-regulator", },
@@ -148,6 +167,17 @@ static const struct rk808_reg_data rk808_pre_init_reg[] = {
 						    VB_LO_SEL_3500MV },
 };
 
+static const struct rk808_reg_data rk816_pre_init_reg[] = {
+	{ RK818_BUCK1_CONFIG_REG, RK817_RAMP_RATE_MASK,
+				  RK817_RAMP_RATE_12_5MV_PER_US },
+	{ RK818_BUCK2_CONFIG_REG, RK817_RAMP_RATE_MASK,
+				  RK817_RAMP_RATE_12_5MV_PER_US },
+	{ RK818_BUCK4_CONFIG_REG, BUCK_ILMIN_MASK,  BUCK_ILMIN_250MA },
+	{ RK808_THERMAL_REG, TEMP_HOTDIE_MSK, TEMP105C},
+	{ RK808_VB_MON_REG, VBAT_LOW_VOL_MASK | VBAT_LOW_ACT_MASK,
+			    RK808_VBAT_LOW_3V0 | EN_VABT_LOW_SHUT_DOWN },
+};
+
 static const struct rk808_reg_data rk817_pre_init_reg[] = {
 	{RK817_RTC_CTRL_REG, RTC_STOP, RTC_STOP},
 	/* Codec specific registers */
@@ -350,6 +380,59 @@ static const struct regmap_irq rk808_irqs[] = {
 	},
 };
 
+static const unsigned int rk816_irq_status_offsets[] = {
+	(RK816_INT_STS_REG1 - RK816_INT_STS_REG1),
+	(RK816_INT_STS_REG2 - RK816_INT_STS_REG1),
+	(RK816_INT_STS_REG3 - RK816_INT_STS_REG1),
+};
+
+static const unsigned int rk816_irq_mask_offsets[] = {
+	(RK816_INT_STS_MSK_REG1 - RK816_INT_STS_MSK_REG1),
+	(RK816_INT_STS_MSK_REG2 - RK816_INT_STS_MSK_REG1),
+	(RK816_INT_STS_MSK_REG3 - RK816_INT_STS_MSK_REG1),
+};
+
+static unsigned int rk816_get_irq_reg(struct regmap_irq_chip_data *data,
+				      unsigned int base, int index)
+{
+	unsigned int irq_reg = base;
+
+	switch (base) {
+	case RK816_INT_STS_REG1:
+		irq_reg += rk816_irq_status_offsets[index];
+		break;
+	case RK816_INT_STS_MSK_REG1:
+		irq_reg += rk816_irq_mask_offsets[index];
+		break;
+	}
+
+	return irq_reg;
+};
+
+static const struct regmap_irq rk816_irqs[] = {
+	/* INT_STS_REG1 IRQs */
+	REGMAP_IRQ_REG(RK816_IRQ_PWRON_FALL, 0, RK816_INT_STS_PWRON_FALL),
+	REGMAP_IRQ_REG(RK816_IRQ_PWRON_RISE, 0, RK816_INT_STS_PWRON_RISE),
+
+	/* INT_STS_REG2 IRQs  */
+	REGMAP_IRQ_REG(RK816_IRQ_VB_LOW, 1, RK816_INT_STS_VB_LOW),
+	REGMAP_IRQ_REG(RK816_IRQ_PWRON, 1, RK816_INT_STS_PWRON),
+	REGMAP_IRQ_REG(RK816_IRQ_PWRON_LP, 1, RK816_INT_STS_PWRON_LP),
+	REGMAP_IRQ_REG(RK816_IRQ_HOTDIE, 1, RK816_INT_STS_HOTDIE),
+	REGMAP_IRQ_REG(RK816_IRQ_RTC_ALARM, 1, RK816_INT_STS_RTC_ALARM),
+	REGMAP_IRQ_REG(RK816_IRQ_RTC_PERIOD, 1, RK816_INT_STS_RTC_PERIOD),
+	REGMAP_IRQ_REG(RK816_IRQ_USB_OV, 1, RK816_INT_STS_USB_OV),
+
+	/* INT_STS3 IRQs */
+	REGMAP_IRQ_REG(RK816_IRQ_PLUG_IN, 2, RK816_INT_STS_PLUG_IN),
+	REGMAP_IRQ_REG(RK816_IRQ_PLUG_OUT, 2, RK816_INT_STS_PLUG_OUT),
+	REGMAP_IRQ_REG(RK816_IRQ_CHG_OK, 2, RK816_INT_STS_CHG_OK),
+	REGMAP_IRQ_REG(RK816_IRQ_CHG_TE, 2, RK816_INT_STS_CHG_TE),
+	REGMAP_IRQ_REG(RK816_IRQ_CHG_TS, 2, RK816_INT_STS_CHG_TS),
+	REGMAP_IRQ_REG(RK816_IRQ_CHG_CVTLIM, 2, RK816_INT_STS_CHG_CVTLIM),
+	REGMAP_IRQ_REG(RK816_IRQ_DISCHG_ILIM, 2, RK816_INT_STS_DISCHG_ILIM),
+};
+
 static const struct regmap_irq rk818_irqs[] = {
 	/* INT_STS */
 	[RK818_IRQ_VOUT_LO] = {
@@ -482,6 +565,18 @@ static const struct regmap_irq_chip rk808_irq_chip = {
 	.init_ack_masked = true,
 };
 
+static const struct regmap_irq_chip rk816_irq_chip = {
+	.name = "rk816",
+	.irqs = rk816_irqs,
+	.num_irqs = ARRAY_SIZE(rk816_irqs),
+	.num_regs = 3,
+	.get_irq_reg = rk816_get_irq_reg,
+	.status_base = RK816_INT_STS_REG1,
+	.mask_base = RK816_INT_STS_MSK_REG1,
+	.ack_base = RK816_INT_STS_REG1,
+	.init_ack_masked = true,
+};
+
 static struct regmap_irq_chip rk817_irq_chip = {
 	.name = "rk817",
 	.irqs = rk817_irqs,
@@ -530,6 +625,7 @@ static int rk808_power_off(struct sys_off_data *data)
 		reg = RK817_SYS_CFG(3);
 		bit = DEV_OFF;
 		break;
+	case RK816_ID:
 	case RK818_ID:
 		reg = RK818_DEVCTRL_REG;
 		bit = DEV_OFF;
@@ -637,6 +733,13 @@ int rk8xx_probe(struct device *dev, int variant, unsigned int irq, struct regmap
 		cells = rk808s;
 		nr_cells = ARRAY_SIZE(rk808s);
 		break;
+	case RK816_ID:
+		rk808->regmap_irq_chip = &rk816_irq_chip;
+		pre_init_reg = rk816_pre_init_reg;
+		nr_pre_init_regs = ARRAY_SIZE(rk816_pre_init_reg);
+		cells = rk816s;
+		nr_cells = ARRAY_SIZE(rk816s);
+		break;
 	case RK818_ID:
 		rk808->regmap_irq_chip = &rk818_irq_chip;
 		pre_init_reg = rk818_pre_init_reg;
diff --git a/drivers/mfd/rk8xx-i2c.c b/drivers/mfd/rk8xx-i2c.c
index 75b5cf09d5a0..69a6b297d723 100644
--- a/drivers/mfd/rk8xx-i2c.c
+++ b/drivers/mfd/rk8xx-i2c.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Rockchip RK808/RK818 Core (I2C) driver
+ * Rockchip RK805/RK808/RK816/RK817/RK818 Core (I2C) driver
  *
  * Copyright (c) 2014, Fuzhou Rockchip Electronics Co., Ltd
  * Copyright (C) 2016 PHYTEC Messtechnik GmbH
@@ -49,6 +49,35 @@ static bool rk808_is_volatile_reg(struct device *dev, unsigned int reg)
 	return false;
 }
 
+static bool rk816_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	/*
+	 * Technically the ROUND_30s bit makes RTC_CTRL_REG volatile, but
+	 * we don't use that feature.  It's better to cache.
+	 */
+
+	switch (reg) {
+	case RK808_SECONDS_REG ... RK808_WEEKS_REG:
+	case RK808_RTC_STATUS_REG:
+	case RK808_VB_MON_REG:
+	case RK808_THERMAL_REG:
+	case RK816_DCDC_EN_REG1:
+	case RK816_DCDC_EN_REG2:
+	case RK816_INT_STS_REG1:
+	case RK816_INT_STS_REG2:
+	case RK816_INT_STS_REG3:
+	case RK808_DEVCTRL_REG:
+	case RK816_SUP_STS_REG:
+	case RK816_GGSTS_REG:
+	case RK816_ZERO_CUR_ADC_REGH:
+	case RK816_ZERO_CUR_ADC_REGL:
+	case RK816_GASCNT_REG(0) ... RK816_BAT_VOL_REGL:
+		return true;
+	}
+
+	return false;
+}
+
 static bool rk817_is_volatile_reg(struct device *dev, unsigned int reg)
 {
 	/*
@@ -100,6 +129,14 @@ static const struct regmap_config rk808_regmap_config = {
 	.volatile_reg = rk808_is_volatile_reg,
 };
 
+static const struct regmap_config rk816_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = RK816_DATA_REG(18),
+	.cache_type = REGCACHE_MAPLE,
+	.volatile_reg = rk816_is_volatile_reg,
+};
+
 static const struct regmap_config rk817_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -123,6 +160,11 @@ static const struct rk8xx_i2c_platform_data rk809_data = {
 	.variant = RK809_ID,
 };
 
+static const struct rk8xx_i2c_platform_data rk816_data = {
+	.regmap_cfg = &rk816_regmap_config,
+	.variant = RK816_ID,
+};
+
 static const struct rk8xx_i2c_platform_data rk817_data = {
 	.regmap_cfg = &rk817_regmap_config,
 	.variant = RK817_ID,
@@ -161,6 +203,7 @@ static const struct of_device_id rk8xx_i2c_of_match[] = {
 	{ .compatible = "rockchip,rk805", .data = &rk805_data },
 	{ .compatible = "rockchip,rk808", .data = &rk808_data },
 	{ .compatible = "rockchip,rk809", .data = &rk809_data },
+	{ .compatible = "rockchip,rk816", .data = &rk816_data },
 	{ .compatible = "rockchip,rk817", .data = &rk817_data },
 	{ .compatible = "rockchip,rk818", .data = &rk818_data },
 	{ },
diff --git a/include/linux/mfd/rk808.h b/include/linux/mfd/rk808.h
index 78e167a92483..b90d1c278790 100644
--- a/include/linux/mfd/rk808.h
+++ b/include/linux/mfd/rk808.h
@@ -113,6 +113,145 @@ enum rk808_reg {
 #define RK808_INT_STS_MSK_REG2	0x4f
 #define RK808_IO_POL_REG	0x50
 
+/* RK816 */
+enum rk816_reg {
+	RK816_ID_DCDC1,
+	RK816_ID_DCDC2,
+	RK816_ID_DCDC3,
+	RK816_ID_DCDC4,
+	RK816_ID_LDO1,
+	RK816_ID_LDO2,
+	RK816_ID_LDO3,
+	RK816_ID_LDO4,
+	RK816_ID_LDO5,
+	RK816_ID_LDO6,
+	RK816_ID_BOOST,
+	RK816_ID_OTG_SW,
+};
+
+enum rk816_irqs {
+	/* INT_STS_REG1 */
+	RK816_IRQ_PWRON_FALL,
+	RK816_IRQ_PWRON_RISE,
+
+	/* INT_STS_REG2 */
+	RK816_IRQ_VB_LOW,
+	RK816_IRQ_PWRON,
+	RK816_IRQ_PWRON_LP,
+	RK816_IRQ_HOTDIE,
+	RK816_IRQ_RTC_ALARM,
+	RK816_IRQ_RTC_PERIOD,
+	RK816_IRQ_USB_OV,
+
+	/* INT_STS_REG3 */
+	RK816_IRQ_PLUG_IN,
+	RK816_IRQ_PLUG_OUT,
+	RK816_IRQ_CHG_OK,
+	RK816_IRQ_CHG_TE,
+	RK816_IRQ_CHG_TS,
+	RK816_IRQ_CHG_CVTLIM,
+	RK816_IRQ_DISCHG_ILIM,
+};
+
+/* power channel registers */
+#define RK816_DCDC_EN_REG1		0x23
+
+#define RK816_DCDC_EN_REG2		0x24
+#define	RK816_BOOST_EN			BIT(1)
+#define RK816_OTG_EN			BIT(2)
+#define	RK816_BOOST_EN_MSK		BIT(5)
+#define RK816_OTG_EN_MSK		BIT(6)
+#define RK816_BUCK_DVS_CONFIRM		BIT(7)
+
+#define RK816_LDO_EN_REG1		0x27
+
+#define RK816_LDO_EN_REG2		0x28
+
+/* interrupt registers and irq definitions */
+#define RK816_INT_STS_REG1		0x49
+#define RK816_INT_STS_MSK_REG1		0x4a
+#define RK816_INT_STS_PWRON_FALL	BIT(5)
+#define RK816_INT_STS_PWRON_RISE	BIT(6)
+
+#define RK816_INT_STS_REG2		0x4c
+#define RK816_INT_STS_MSK_REG2		0x4d
+#define RK816_INT_STS_VB_LOW		BIT(1)
+#define RK816_INT_STS_PWRON		BIT(2)
+#define RK816_INT_STS_PWRON_LP		BIT(3)
+#define RK816_INT_STS_HOTDIE		BIT(4)
+#define RK816_INT_STS_RTC_ALARM		BIT(5)
+#define RK816_INT_STS_RTC_PERIOD	BIT(6)
+#define RK816_INT_STS_USB_OV		BIT(7)
+
+#define RK816_INT_STS_REG3		0x4e
+#define RK816_INT_STS_MSK_REG3		0x4f
+#define RK816_INT_STS_PLUG_IN		BIT(0)
+#define RK816_INT_STS_PLUG_OUT		BIT(1)
+#define RK816_INT_STS_CHG_OK		BIT(2)
+#define RK816_INT_STS_CHG_TE		BIT(3)
+#define RK816_INT_STS_CHG_TS		BIT(4)
+#define RK816_INT_STS_CHG_CVTLIM	BIT(6)
+#define RK816_INT_STS_DISCHG_ILIM	BIT(7)
+
+/* charger, boost and OTG registers */
+#define RK816_OTG_BUCK_LDO_CONFIG_REG	0x2a
+#define RK816_CHRG_CONFIG_REG		0x2b
+#define RK816_BOOST_ON_VESL_REG		0x54
+#define RK816_BOOST_SLP_VSEL_REG	0x55
+#define RK816_CHRG_BOOST_CONFIG_REG	0x9a
+#define RK816_SUP_STS_REG		0xa0
+#define RK816_USB_CTRL_REG		0xa1
+#define RK816_CHRG_CTRL(x)		(0xa3 + (x))
+#define RK816_BAT_CTRL_REG		0xa6
+#define RK816_BAT_HTS_TS_REG		0xa8
+#define RK816_BAT_LTS_TS_REG		0xa9
+
+/* adc and fuel gauge registers */
+#define RK816_TS_CTRL_REG		0xac
+#define RK816_ADC_CTRL_REG		0xad
+#define RK816_GGCON_REG			0xb0
+#define RK816_GGSTS_REG			0xb1
+#define RK816_ZERO_CUR_ADC_REGH		0xb2
+#define RK816_ZERO_CUR_ADC_REGL		0xb3
+#define RK816_GASCNT_CAL_REG(x)		(0xb7 - (x))
+#define RK816_GASCNT_REG(x)		(0xbb - (x))
+#define RK816_BAT_CUR_AVG_REGH		0xbc
+#define RK816_BAT_CUR_AVG_REGL		0xbd
+#define RK816_TS_ADC_REGH		0xbe
+#define RK816_TS_ADC_REGL		0xbf
+#define RK816_USB_ADC_REGH		0xc0
+#define RK816_USB_ADC_REGL		0xc1
+#define RK816_BAT_OCV_REGH		0xc2
+#define RK816_BAT_OCV_REGL		0xc3
+#define RK816_BAT_VOL_REGH		0xc4
+#define RK816_BAT_VOL_REGL		0xc5
+#define RK816_RELAX_ENTRY_THRES_REGH	0xc6
+#define RK816_RELAX_ENTRY_THRES_REGL	0xc7
+#define RK816_RELAX_EXIT_THRES_REGH	0xc8
+#define RK816_RELAX_EXIT_THRES_REGL	0xc9
+#define RK816_RELAX_VOL1_REGH		0xca
+#define RK816_RELAX_VOL1_REGL		0xcb
+#define RK816_RELAX_VOL2_REGH		0xcc
+#define RK816_RELAX_VOL2_REGL		0xcd
+#define RK816_RELAX_CUR1_REGH		0xce
+#define RK816_RELAX_CUR1_REGL		0xcf
+#define RK816_RELAX_CUR2_REGH		0xd0
+#define RK816_RELAX_CUR2_REGL		0xd1
+#define RK816_CAL_OFFSET_REGH		0xd2
+#define RK816_CAL_OFFSET_REGL		0xd3
+#define RK816_NON_ACT_TIMER_CNT_REG	0xd4
+#define RK816_VCALIB0_REGH		0xd5
+#define RK816_VCALIB0_REGL		0xd6
+#define RK816_VCALIB1_REGH		0xd7
+#define RK816_VCALIB1_REGL		0xd8
+#define RK816_FCC_GASCNT_REG(x)		(0xdc - (x))
+#define RK816_IOFFSET_REGH		0xdd
+#define RK816_IOFFSET_REGL		0xde
+#define RK816_SLEEP_CON_SAMP_CUR_REG	0xdf
+
+/* general purpose data registers 0xe0 ~ 0xf2 */
+#define RK816_DATA_REG(x)		(0xe0 + (x))
+
 /* RK818 */
 #define RK818_DCDC1			0
 #define RK818_LDO1			4
@@ -791,6 +930,7 @@ enum rk806_dvs_mode {
 #define VOUT_LO_INT	BIT(0)
 #define CLK32KOUT2_EN	BIT(0)
 
+#define TEMP105C			0x08
 #define TEMP115C			0x0c
 #define TEMP_HOTDIE_MSK			0x0c
 #define SLP_SD_MSK			(0x3 << 2)
@@ -1191,6 +1331,7 @@ enum {
 	RK806_ID = 0x8060,
 	RK808_ID = 0x0000,
 	RK809_ID = 0x8090,
+	RK816_ID = 0x8160,
 	RK817_ID = 0x8170,
 	RK818_ID = 0x8180,
 };
-- 
2.43.2


