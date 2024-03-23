Return-Path: <linux-kernel+bounces-112361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3C58878E4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 14:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D623E1F2423F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 13:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914F847F45;
	Sat, 23 Mar 2024 13:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dm0/G7GV"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D253D0D5;
	Sat, 23 Mar 2024 13:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711200548; cv=none; b=SPWpFbyr0wc4/F6pHtD0Yl5HaxzGWHD2yfeH6bdKcXe/DzgMiC/82MS4+R+DG5RhYo6XD51ki+j+zneY01GVj2T+jDOIXVFPyMyR0eUa87n+nfhg9VYo4hrchTOxiXD9sySTNFcz+syEC4Y5uFq9yr3Ab3tnRuVBBdAAY1geRr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711200548; c=relaxed/simple;
	bh=8wb5CVIJLDyMys+SRGpLYKAUPgGcnDty7OZUjGoVOfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A2JDc3bmnVMZ1fBKL9HeBCTALV+eKiQUWl1/jNdXFZjUH9H9jx+NgAlwp3wyjb7gzePQrMVkgBpYUP2BuJ8ow1uQYzRpAR0AdIwdfGZa8X/HKd7XeHYpDEUR0B7kgQW9hmvGej9DKaqDgpXH0j7Fwn79xGOg3hphBf69eZ4Umys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dm0/G7GV; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4146e9e45c8so20063675e9.1;
        Sat, 23 Mar 2024 06:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711200545; x=1711805345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8r2vrVWoun2pakpPCHmiPerhdl2nmzZoDCfJWcigRM=;
        b=dm0/G7GVETSoEPOa4gHOoGKcCdbRiMNkchXxynDS5TGhqwyeq5lA8bQseMB4HZoTLN
         kTD7oSOebb/aO5blmoTQjsb2pvKpFEtsXlu9u18YOX9Owbr6nvsN6/PJ/eYX3ai5FNTf
         uGhT6nUkn64G380nE/+n8XdzzvJYGx08j1gDZoSqLHsbeYI5QvWNOSowavbPaRSKflhD
         oFvzWuqOwJtWaM6SqeP/jHLNkkGiGFDV/lv1/e9q6X14ws3X86scV5vWEpoVHZ0AMgpW
         irKkjABhnyXJuTn+c57jazaP+2YhjUpvi9ITWFC4rnxsGgTgyw7obCp+rOI1UvdGxeNv
         O4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711200545; x=1711805345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q8r2vrVWoun2pakpPCHmiPerhdl2nmzZoDCfJWcigRM=;
        b=RgXNpUYQyVjuOR7xtZSgblxqOgLFT1Q9OIHpH++3nWfEkKEUPhdaM8fiOw98xuNFb2
         MIXdVQEfbWvCi+/XbOcNE3UfZd650iH9PtAFU4iDe+M/eKNOCrAu5oQ7vLKUBqpMn9Pp
         JlujZnaiEEUunHqeyOqrn+FCctTPkXrsWEhW6dxOo7woWjPTJgyo3yVVvirIN2NHVYry
         nbl4m+s2dLHyrxAoHV4Am7yhI+r36v/zofaIfzNfriiGddWPmlUJN7CE00Q/P2wQJc9v
         BFHVwUREwNlf6Lzni01PXKagbEhKwJX2SM+Nr1+B9c9X+JatGwojvgIDDTPwXCCOZjNH
         1bMA==
X-Forwarded-Encrypted: i=1; AJvYcCUzi8NmaaN7+kDDhTnPTLhBPFA9obO1BeF2tAyh7v/bT6Kh3HtWvTBPIod6V7OdxqjGcZLeYT2B1CcuUrmhPEd9Bv3wn2GPPQrmEmcCAJOdgVON6zkZpkEgPup/szFBGmmnrlwVOvxaSGhbX8OzcoB9q+YGXBrdU5UMNTxxqaTJs5/vMFk=
X-Gm-Message-State: AOJu0YzLrW4fBk5jChzNzA/z2jjl/7EZUehVqIqu/8ogflTnYudYZtzj
	teBhqRxKJVsWzbIn7hqWryaFJ4FJ9fLB+tIdMIdaBFsJ6Xlkgpk=
X-Google-Smtp-Source: AGHT+IFFNz/ZREhwsJ4BtbxNcNjSaIf8/PqDDl1exv8SmWZsUSfY8y0SF25z1XW73icvSQd16JlSug==
X-Received: by 2002:a5d:6acf:0:b0:341:c487:fb44 with SMTP id u15-20020a5d6acf000000b00341c487fb44mr763950wrw.11.1711200544904;
        Sat, 23 Mar 2024 06:29:04 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:fbb8:7547:139d:a40f])
        by smtp.gmail.com with ESMTPSA id x17-20020adfffd1000000b00341babb8af0sm3076061wrs.7.2024.03.23.06.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 06:29:04 -0700 (PDT)
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
Subject: [PATCH v3 5/5] regulator: rk808: Add RK816 support
Date: Sat, 23 Mar 2024 14:28:03 +0100
Message-ID: <20240323132757.141861-12-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240323132757.141861-2-knaerzche@gmail.com>
References: <20240323132757.141861-2-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for rk816 to the existing rk808 regulator driver.

The infrastructure of the driver can be re-used as is. A peculiarity for
this version is, that BUCK1/BUCK2 have a (common) bit which needs to
toggled after a voltage change to confirm the change. Regulator regmap
takes care of that by defining a apply_bit and apply_reg for those
regulators.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes since v1:
  - align regulator's .name and .of_match with updated binding

changes since v2:
  - align regulator's .name and .of_match with updated binding
    (dropped "-regulator" prefix)

 drivers/regulator/rk808-regulator.c | 202 +++++++++++++++++++++++++++-
 1 file changed, 201 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index a6a563e402d0..14b60abd6afc 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -158,6 +158,11 @@
 	RK8XX_DESC_COM(_id, _match, _supply, _min, _max, _step, _vreg,	\
 	_vmask, _ereg, _emask, 0, 0, _etime, &rk808_reg_ops)
 
+#define RK816_DESC(_id, _match, _supply, _min, _max, _step, _vreg,	\
+	_vmask, _ereg, _emask, _disval, _etime)				\
+	RK8XX_DESC_COM(_id, _match, _supply, _min, _max, _step, _vreg,	\
+	_vmask, _ereg, _emask, _emask, _disval, _etime, &rk816_reg_ops)
+
 #define RK817_DESC(_id, _match, _supply, _min, _max, _step, _vreg,	\
 	_vmask, _ereg, _emask, _disval, _etime)				\
 	RK8XX_DESC_COM(_id, _match, _supply, _min, _max, _step, _vreg,	\
@@ -258,7 +263,7 @@ static const unsigned int rk808_buck1_2_ramp_table[] = {
 	2000, 4000, 6000, 10000
 };
 
-/* RK817 RK809 */
+/* RK817/RK809/RK816 (buck 1/2 only) */
 static const unsigned int rk817_buck1_4_ramp_table[] = {
 	3000, 6300, 12500, 25000
 };
@@ -640,6 +645,38 @@ static int rk808_set_suspend_disable(struct regulator_dev *rdev)
 				  rdev->desc->enable_mask);
 }
 
+static const struct rk8xx_register_bit rk816_suspend_bits[] = {
+	RK8XX_REG_BIT(RK818_SLEEP_SET_OFF_REG1, 0),
+	RK8XX_REG_BIT(RK818_SLEEP_SET_OFF_REG1, 1),
+	RK8XX_REG_BIT(RK818_SLEEP_SET_OFF_REG1, 2),
+	RK8XX_REG_BIT(RK818_SLEEP_SET_OFF_REG1, 3),
+	RK8XX_REG_BIT(RK818_SLEEP_SET_OFF_REG2, 0),
+	RK8XX_REG_BIT(RK818_SLEEP_SET_OFF_REG2, 1),
+	RK8XX_REG_BIT(RK818_SLEEP_SET_OFF_REG2, 2),
+	RK8XX_REG_BIT(RK818_SLEEP_SET_OFF_REG2, 3),
+	RK8XX_REG_BIT(RK818_SLEEP_SET_OFF_REG2, 4),
+	RK8XX_REG_BIT(RK818_SLEEP_SET_OFF_REG2, 5),
+	RK8XX_REG_BIT(RK818_SLEEP_SET_OFF_REG1, 5),
+	RK8XX_REG_BIT(RK818_SLEEP_SET_OFF_REG1, 6),
+};
+
+static int rk816_set_suspend_enable(struct regulator_dev *rdev)
+{
+	int rid = rdev_get_id(rdev);
+
+	return regmap_update_bits(rdev->regmap, rk816_suspend_bits[rid].reg,
+				  rk816_suspend_bits[rid].bit,
+				  rk816_suspend_bits[rid].bit);
+}
+
+static int rk816_set_suspend_disable(struct regulator_dev *rdev)
+{
+	int rid = rdev_get_id(rdev);
+
+	return regmap_update_bits(rdev->regmap, rk816_suspend_bits[rid].reg,
+				  rk816_suspend_bits[rid].bit, 0);
+}
+
 static int rk817_set_suspend_enable_ctrl(struct regulator_dev *rdev,
 					 unsigned int en)
 {
@@ -913,6 +950,54 @@ static const struct regulator_ops rk809_buck5_ops_range = {
 	.set_suspend_disable	= rk817_set_suspend_disable,
 };
 
+static const struct regulator_ops rk816_buck1_2_ops_ranges = {
+	.list_voltage		= regulator_list_voltage_linear_range,
+	.map_voltage		= regulator_map_voltage_linear_range,
+	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
+	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
+	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.is_enabled		= regulator_is_enabled_regmap,
+	.set_mode		= rk8xx_set_mode,
+	.get_mode		= rk8xx_get_mode,
+	.set_suspend_mode	= rk8xx_set_suspend_mode,
+	.set_ramp_delay		= regulator_set_ramp_delay_regmap,
+	.set_suspend_voltage	= rk808_set_suspend_voltage_range,
+	.set_suspend_enable	= rk816_set_suspend_enable,
+	.set_suspend_disable	= rk816_set_suspend_disable,
+};
+
+static const struct regulator_ops rk816_buck4_ops_ranges = {
+	.list_voltage		= regulator_list_voltage_linear_range,
+	.map_voltage		= regulator_map_voltage_linear_range,
+	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
+	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
+	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.is_enabled		= regulator_is_enabled_regmap,
+	.set_mode		= rk8xx_set_mode,
+	.get_mode		= rk8xx_get_mode,
+	.set_suspend_mode	= rk8xx_set_suspend_mode,
+	.set_suspend_voltage	= rk808_set_suspend_voltage_range,
+	.set_suspend_enable	= rk816_set_suspend_enable,
+	.set_suspend_disable	= rk816_set_suspend_disable,
+};
+
+static const struct regulator_ops rk816_reg_ops = {
+	.list_voltage		= regulator_list_voltage_linear,
+	.map_voltage		= regulator_map_voltage_linear,
+	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
+	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.is_enabled		= rk8xx_is_enabled_wmsk_regmap,
+	.set_suspend_voltage	= rk808_set_suspend_voltage,
+	.set_suspend_enable	= rk816_set_suspend_enable,
+	.set_suspend_disable	= rk816_set_suspend_disable,
+};
+
 static const struct regulator_ops rk817_reg_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
@@ -1392,6 +1477,117 @@ static const struct regulator_desc rk809_reg[] = {
 			  DISABLE_VAL(3)),
 };
 
+static const struct linear_range rk816_buck_4_voltage_ranges[] = {
+	REGULATOR_LINEAR_RANGE(800000, 0, 26, 100000),
+	REGULATOR_LINEAR_RANGE(3500000, 27, 31, 0),
+};
+
+static const struct regulator_desc rk816_reg[] = {
+	{
+		.name = "dcdc1",
+		.supply_name = "vcc1",
+		.of_match = of_match_ptr("dcdc1"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = RK816_ID_DCDC1,
+		.ops = &rk816_buck1_2_ops_ranges,
+		.type = REGULATOR_VOLTAGE,
+		.n_voltages = 64,
+		.linear_ranges = rk805_buck_1_2_voltage_ranges,
+		.n_linear_ranges = ARRAY_SIZE(rk805_buck_1_2_voltage_ranges),
+		.vsel_reg = RK818_BUCK1_ON_VSEL_REG,
+		.vsel_mask = RK818_BUCK_VSEL_MASK,
+		.apply_reg = RK816_DCDC_EN_REG2,
+		.apply_bit = RK816_BUCK_DVS_CONFIRM,
+		.enable_reg = RK816_DCDC_EN_REG1,
+		.enable_mask = BIT(4) | BIT(0),
+		.enable_val = BIT(4) | BIT(0),
+		.disable_val = BIT(4),
+		.ramp_reg = RK818_BUCK1_CONFIG_REG,
+		.ramp_mask = RK808_RAMP_RATE_MASK,
+		.ramp_delay_table = rk817_buck1_4_ramp_table,
+		.n_ramp_values = ARRAY_SIZE(rk817_buck1_4_ramp_table),
+		.of_map_mode = rk8xx_regulator_of_map_mode,
+		.owner = THIS_MODULE,
+	}, {
+		.name = "dcdc2",
+		.supply_name = "vcc2",
+		.of_match = of_match_ptr("dcdc2"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = RK816_ID_DCDC2,
+		.ops = &rk816_buck1_2_ops_ranges,
+		.type = REGULATOR_VOLTAGE,
+		.n_voltages = 64,
+		.linear_ranges = rk805_buck_1_2_voltage_ranges,
+		.n_linear_ranges = ARRAY_SIZE(rk805_buck_1_2_voltage_ranges),
+		.vsel_reg = RK818_BUCK2_ON_VSEL_REG,
+		.vsel_mask = RK818_BUCK_VSEL_MASK,
+		.apply_reg = RK816_DCDC_EN_REG2,
+		.apply_bit = RK816_BUCK_DVS_CONFIRM,
+		.enable_reg = RK816_DCDC_EN_REG1,
+		.enable_mask = BIT(5) | BIT(1),
+		.enable_val = BIT(5) | BIT(1),
+		.disable_val = BIT(5),
+		.ramp_reg = RK818_BUCK2_CONFIG_REG,
+		.ramp_mask = RK808_RAMP_RATE_MASK,
+		.ramp_delay_table = rk817_buck1_4_ramp_table,
+		.n_ramp_values = ARRAY_SIZE(rk817_buck1_4_ramp_table),
+		.of_map_mode = rk8xx_regulator_of_map_mode,
+		.owner = THIS_MODULE,
+	}, {
+		.name = "dcdc3",
+		.supply_name = "vcc3",
+		.of_match = of_match_ptr("dcdc3"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = RK816_ID_DCDC3,
+		.ops = &rk808_switch_ops,
+		.type = REGULATOR_VOLTAGE,
+		.n_voltages = 1,
+		.enable_reg = RK816_DCDC_EN_REG1,
+		.enable_mask = BIT(6) | BIT(2),
+		.enable_val =  BIT(6) | BIT(2),
+		.disable_val = BIT(6),
+		.of_map_mode = rk8xx_regulator_of_map_mode,
+		.owner = THIS_MODULE,
+	}, {
+		.name = "dcdc4",
+		.supply_name = "vcc4",
+		.of_match = of_match_ptr("dcdc4"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = RK816_ID_DCDC4,
+		.ops = &rk816_buck4_ops_ranges,
+		.type = REGULATOR_VOLTAGE,
+		.n_voltages = 32,
+		.linear_ranges = rk816_buck_4_voltage_ranges,
+		.n_linear_ranges = ARRAY_SIZE(rk816_buck_4_voltage_ranges),
+		.vsel_reg = RK818_BUCK4_ON_VSEL_REG,
+		.vsel_mask = RK818_BUCK4_VSEL_MASK,
+		.enable_reg = RK816_DCDC_EN_REG1,
+		.enable_mask = BIT(7) | BIT(3),
+		.enable_val = BIT(7) | BIT(3),
+		.disable_val = BIT(7),
+		.of_map_mode = rk8xx_regulator_of_map_mode,
+		.owner = THIS_MODULE,
+	},
+	RK816_DESC(RK816_ID_LDO1, "ldo1", "vcc5", 800, 3400, 100,
+		   RK818_LDO1_ON_VSEL_REG, RK818_LDO_VSEL_MASK,
+		   RK816_LDO_EN_REG1, ENABLE_MASK(0), DISABLE_VAL(0), 400),
+	RK816_DESC(RK816_ID_LDO2, "ldo2", "vcc5", 800, 3400, 100,
+		   RK818_LDO2_ON_VSEL_REG, RK818_LDO_VSEL_MASK,
+		   RK816_LDO_EN_REG1, ENABLE_MASK(1), DISABLE_VAL(1), 400),
+	RK816_DESC(RK816_ID_LDO3, "ldo3", "vcc5", 800, 3400, 100,
+		   RK818_LDO3_ON_VSEL_REG, RK818_LDO_VSEL_MASK,
+		   RK816_LDO_EN_REG1, ENABLE_MASK(2), DISABLE_VAL(2), 400),
+	RK816_DESC(RK816_ID_LDO4, "ldo4", "vcc6", 800, 3400, 100,
+		   RK818_LDO4_ON_VSEL_REG, RK818_LDO_VSEL_MASK,
+		   RK816_LDO_EN_REG1, ENABLE_MASK(3), DISABLE_VAL(3), 400),
+	RK816_DESC(RK816_ID_LDO5, "ldo5", "vcc6", 800, 3400, 100,
+		   RK818_LDO5_ON_VSEL_REG, RK818_LDO_VSEL_MASK,
+		   RK816_LDO_EN_REG2, ENABLE_MASK(0), DISABLE_VAL(0), 400),
+	RK816_DESC(RK816_ID_LDO6, "ldo6", "vcc6", 800, 3400, 100,
+		   RK818_LDO6_ON_VSEL_REG, RK818_LDO_VSEL_MASK,
+		   RK816_LDO_EN_REG2, ENABLE_MASK(1), DISABLE_VAL(1), 400),
+};
+
 static const struct regulator_desc rk817_reg[] = {
 	{
 		.name = "DCDC_REG1",
@@ -1714,6 +1910,10 @@ static int rk808_regulator_probe(struct platform_device *pdev)
 		regulators = rk809_reg;
 		nregulators = RK809_NUM_REGULATORS;
 		break;
+	case RK816_ID:
+		regulators = rk816_reg;
+		nregulators = ARRAY_SIZE(rk816_reg);
+		break;
 	case RK817_ID:
 		regulators = rk817_reg;
 		nregulators = RK817_NUM_REGULATORS;
-- 
2.43.2


