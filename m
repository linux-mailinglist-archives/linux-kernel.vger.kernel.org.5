Return-Path: <linux-kernel+bounces-126046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB1389315C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 12:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40949281F6C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 10:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A636144D23;
	Sun, 31 Mar 2024 10:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b="SQPRhtE/"
Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B11144301;
	Sun, 31 Mar 2024 10:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711882729; cv=none; b=X0lF44cJEY0GzKAVhNntyb+ulk6214S1etDEDCRh0J8BPxpf/iHRPnE9i7jfiJelOxpwqIGGZc77QBpLcTnyG2LQkl7roZXBokXOu+sJ/DZcq8nBCartv5SfiJQWxX6DG5JQS7FgsbR4muHVCl5opmyEt/Yj13Iu2t+EcA28h08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711882729; c=relaxed/simple;
	bh=6uRmGmtHyqrzE9b7FnR9dGbBDCOqbzypZ1zZcRKGeDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EccNBX8pyjvB7dJbONaTU3kUJCF+l4iB3ysvDHP/FTmFoBOT3a7V2aoQFcAstg8Xtk1wGlwqxnCyYsyFj1dZEqeogNdCsmWuHSRKI7292389+gIFZUZkZ27CahouecO1YVXTMgHX3Ns8sMgcP1CfQJJdKCdQwJqXWcs2CgdpgD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=SQPRhtE/; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mff.cuni.cz;
	s=submission; t=1711882700; x=1713182700;
	bh=RMsxrjCCRIAeDDqP+C1o1uh41VPi50Pm6IaAy/MFVnM=;
	h=From:MIME-Version;
	b=SQPRhtE/TkO4QNY4mJR6p43o+GefMquSzYM+YEtR1KBt9PSqAmCvKZcHoscslzF2f
	 0BgnMYEhGDmV9tx+YXSjso681aRzfn234omiBO/L6uRBZjC1BaHHkn9r6e2kW7iwXH
	 kSadmfoCzAmgQ8o5LjaYpYZjFhBfZRyHdjqPBseUTMVuRrARksyyiKpj3FfopkPWHQ
	 KVi3CuAeoMxg5Ih9LM+FvHxnIV6EhLDL1jP6xmlPkIf9QSl99DSBWloSvt0NSq0Nxk
	 PAXIt07nq923QPvrsUFcrXqT22+Bu/DQSpZM3vlhpg/i0YrF8iVGSCARs0+D10ar9Y
	 ZE+jB1igx8g/A==
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 42VAwICD095410
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sun, 31 Mar 2024 12:58:20 +0200 (CEST)
	(envelope-from balejk@matfyz.cz)
From: Karel Balej <balejk@matfyz.cz>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Cc: =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: [PATCH 3/5] regulator: add regulators driver for Marvell 88PM886 PMIC
Date: Sun, 31 Mar 2024 12:46:56 +0200
Message-ID: <20240331105608.7338-5-balejk@matfyz.cz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240331105608.7338-2-balejk@matfyz.cz>
References: <20240331105608.7338-2-balejk@matfyz.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support the LDO and buck regulators of the Marvell 88PM886 PMIC.

Signed-off-by: Karel Balej <balejk@matfyz.cz>
---

Notes:
    v1:
    - Add remaining regulators.
    - Clean up includes.
    - Address Mark's feedback:
      - Use dedicated regmap config.
    RFC v4:
    - Initialize regulators regmap in the regulators driver.
    - Register all regulators at once.
    - Drop regulator IDs.
    - Add missing '\n' to dev_err_probe message.
    - Fix includes.
    - Add ID table.
    RFC v3:
    - Do not have a variable for each regulator -- define them all in the
      pm886_regulators array.
    - Use new regulators regmap index name.
    - Use dev_err_probe.
    RFC v2:
    - Drop of_compatible and related code.
    - Drop unused include.
    - Remove some abstraction: use only one regmap for all regulators and
      only mention 88PM886 in Kconfig description.
    - Reword commit message.

 drivers/regulator/88pm886-regulator.c | 509 ++++++++++++++++++++++++++
 drivers/regulator/Kconfig             |   6 +
 drivers/regulator/Makefile            |   1 +
 3 files changed, 516 insertions(+)
 create mode 100644 drivers/regulator/88pm886-regulator.c

diff --git a/drivers/regulator/88pm886-regulator.c b/drivers/regulator/88pm886-regulator.c
new file mode 100644
index 000000000000..05d24bf444cb
--- /dev/null
+++ b/drivers/regulator/88pm886-regulator.c
@@ -0,0 +1,509 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+
+#include <linux/mfd/88pm886.h>
+
+#define PM886_PAGE_OFFSET_REGULATORS	1
+
+#define PM886_REG_LDO_EN1		0x09
+#define PM886_REG_LDO_EN2		0x0a
+
+#define PM886_REG_BUCK_EN		0x08
+
+#define PM886_REG_LDO1_VOUT		0x20
+#define PM886_REG_LDO2_VOUT		0x26
+#define PM886_REG_LDO3_VOUT		0x2c
+#define PM886_REG_LDO4_VOUT		0x32
+#define PM886_REG_LDO5_VOUT		0x38
+#define PM886_REG_LDO6_VOUT		0x3e
+#define PM886_REG_LDO7_VOUT		0x44
+#define PM886_REG_LDO8_VOUT		0x4a
+#define PM886_REG_LDO9_VOUT		0x50
+#define PM886_REG_LDO10_VOUT		0x56
+#define PM886_REG_LDO11_VOUT		0x5c
+#define PM886_REG_LDO12_VOUT		0x62
+#define PM886_REG_LDO13_VOUT		0x68
+#define PM886_REG_LDO14_VOUT		0x6e
+#define PM886_REG_LDO15_VOUT		0x74
+#define PM886_REG_LDO16_VOUT		0x7a
+
+#define PM886_REG_BUCK1_VOUT		0xa5
+#define PM886_REG_BUCK2_VOUT		0xb3
+#define PM886_REG_BUCK3_VOUT		0xc1
+#define PM886_REG_BUCK4_VOUT		0xcf
+#define PM886_REG_BUCK5_VOUT		0xdd
+
+#define PM886_LDO_VSEL_MASK		0x0f
+#define PM886_BUCK_VSEL_MASK		0x7f
+
+static const struct regmap_config pm886_regulator_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = PM886_REG_BUCK5_VOUT,
+};
+
+struct pm886_regulator {
+	struct regulator_desc desc;
+	int max_uA;
+};
+
+static int pm886_regulator_get_ilim(struct regulator_dev *rdev)
+{
+	struct pm886_regulator *data = rdev_get_drvdata(rdev);
+
+	if (!data) {
+		dev_err(&rdev->dev, "Failed to get regulator data\n");
+		return -EINVAL;
+	}
+	return data->max_uA;
+}
+
+static const struct regulator_ops pm886_ldo_ops = {
+	.list_voltage = regulator_list_voltage_table,
+	.map_voltage = regulator_map_voltage_iterate,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.get_current_limit = pm886_regulator_get_ilim,
+};
+
+static const struct regulator_ops pm886_buck_ops = {
+	.list_voltage = regulator_list_voltage_linear_range,
+	.map_voltage = regulator_map_voltage_linear_range,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.get_current_limit = pm886_regulator_get_ilim,
+};
+
+static const unsigned int pm886_ldo_volt_table1[] = {
+	1700000, 1800000, 1900000, 2500000, 2800000, 2900000, 3100000, 3300000,
+};
+
+static const unsigned int pm886_ldo_volt_table2[] = {
+	1200000, 1250000, 1700000, 1800000, 1850000, 1900000, 2500000, 2600000,
+	2700000, 2750000, 2800000, 2850000, 2900000, 3000000, 3100000, 3300000,
+};
+
+static const unsigned int pm886_ldo_volt_table3[] = {
+	1700000, 1800000, 1900000, 2000000, 2100000, 2500000, 2700000, 2800000,
+};
+
+static const struct linear_range pm886_buck_volt_ranges1[] = {
+	REGULATOR_LINEAR_RANGE(600000, 0, 79, 12500),
+	REGULATOR_LINEAR_RANGE(1600000, 80, 84, 50000),
+};
+
+static const struct linear_range pm886_buck_volt_ranges2[] = {
+	REGULATOR_LINEAR_RANGE(600000, 0, 79, 12500),
+	REGULATOR_LINEAR_RANGE(1600000, 80, 114, 50000),
+};
+
+static struct pm886_regulator pm886_regulators[] = {
+	{
+		.desc = {
+			.name = "LDO1",
+			.regulators_node = "regulators",
+			.of_match = "ldo1",
+			.ops = &pm886_ldo_ops,
+			.type = REGULATOR_VOLTAGE,
+			.enable_reg = PM886_REG_LDO_EN1,
+			.enable_mask = BIT(0),
+			.volt_table = pm886_ldo_volt_table1,
+			.n_voltages = ARRAY_SIZE(pm886_ldo_volt_table1),
+			.vsel_reg = PM886_REG_LDO1_VOUT,
+			.vsel_mask = PM886_LDO_VSEL_MASK,
+		},
+		.max_uA = 100000,
+	},
+	{
+		.desc = {
+			.name = "LDO2",
+			.regulators_node = "regulators",
+			.of_match = "ldo2",
+			.ops = &pm886_ldo_ops,
+			.type = REGULATOR_VOLTAGE,
+			.enable_reg = PM886_REG_LDO_EN1,
+			.enable_mask = BIT(1),
+			.volt_table = pm886_ldo_volt_table1,
+			.n_voltages = ARRAY_SIZE(pm886_ldo_volt_table1),
+			.vsel_reg = PM886_REG_LDO2_VOUT,
+			.vsel_mask = PM886_LDO_VSEL_MASK,
+		},
+		.max_uA = 100000,
+	},
+	{
+		.desc = {
+			.name = "LDO3",
+			.regulators_node = "regulators",
+			.of_match = "ldo3",
+			.ops = &pm886_ldo_ops,
+			.type = REGULATOR_VOLTAGE,
+			.enable_reg = PM886_REG_LDO_EN1,
+			.enable_mask = BIT(2),
+			.volt_table = pm886_ldo_volt_table1,
+			.n_voltages = ARRAY_SIZE(pm886_ldo_volt_table1),
+			.vsel_reg = PM886_REG_LDO3_VOUT,
+			.vsel_mask = PM886_LDO_VSEL_MASK,
+		},
+		.max_uA = 100000,
+	},
+	{
+		.desc = {
+			.name = "LDO4",
+			.regulators_node = "regulators",
+			.of_match = "ldo4",
+			.ops = &pm886_ldo_ops,
+			.type = REGULATOR_VOLTAGE,
+			.enable_reg = PM886_REG_LDO_EN1,
+			.enable_mask = BIT(3),
+			.volt_table = pm886_ldo_volt_table2,
+			.n_voltages = ARRAY_SIZE(pm886_ldo_volt_table2),
+			.vsel_reg = PM886_REG_LDO4_VOUT,
+			.vsel_mask = PM886_LDO_VSEL_MASK,
+		},
+		.max_uA = 400000,
+	},
+	{
+		.desc = {
+			.name = "LDO5",
+			.regulators_node = "regulators",
+			.of_match = "ldo5",
+			.ops = &pm886_ldo_ops,
+			.type = REGULATOR_VOLTAGE,
+			.enable_reg = PM886_REG_LDO_EN1,
+			.enable_mask = BIT(4),
+			.volt_table = pm886_ldo_volt_table2,
+			.n_voltages = ARRAY_SIZE(pm886_ldo_volt_table2),
+			.vsel_reg = PM886_REG_LDO5_VOUT,
+			.vsel_mask = PM886_LDO_VSEL_MASK,
+		},
+		.max_uA = 400000,
+	},
+	{
+		.desc = {
+			.name = "LDO6",
+			.regulators_node = "regulators",
+			.of_match = "ldo6",
+			.ops = &pm886_ldo_ops,
+			.type = REGULATOR_VOLTAGE,
+			.enable_reg = PM886_REG_LDO_EN1,
+			.enable_mask = BIT(5),
+			.volt_table = pm886_ldo_volt_table2,
+			.n_voltages = ARRAY_SIZE(pm886_ldo_volt_table2),
+			.vsel_reg = PM886_REG_LDO6_VOUT,
+			.vsel_mask = PM886_LDO_VSEL_MASK,
+		},
+		.max_uA = 400000,
+	},
+	{
+		.desc = {
+			.name = "LDO7",
+			.regulators_node = "regulators",
+			.of_match = "ldo7",
+			.ops = &pm886_ldo_ops,
+			.type = REGULATOR_VOLTAGE,
+			.enable_reg = PM886_REG_LDO_EN1,
+			.enable_mask = BIT(6),
+			.volt_table = pm886_ldo_volt_table2,
+			.n_voltages = ARRAY_SIZE(pm886_ldo_volt_table2),
+			.vsel_reg = PM886_REG_LDO7_VOUT,
+			.vsel_mask = PM886_LDO_VSEL_MASK,
+		},
+		.max_uA = 400000,
+	},
+	{
+		.desc = {
+			.name = "LDO8",
+			.regulators_node = "regulators",
+			.of_match = "ldo8",
+			.ops = &pm886_ldo_ops,
+			.type = REGULATOR_VOLTAGE,
+			.enable_reg = PM886_REG_LDO_EN1,
+			.enable_mask = BIT(7),
+			.volt_table = pm886_ldo_volt_table2,
+			.n_voltages = ARRAY_SIZE(pm886_ldo_volt_table2),
+			.vsel_reg = PM886_REG_LDO8_VOUT,
+			.vsel_mask = PM886_LDO_VSEL_MASK,
+		},
+		.max_uA = 400000,
+	},
+	{
+		.desc = {
+			.name = "LDO9",
+			.regulators_node = "regulators",
+			.of_match = "ldo9",
+			.ops = &pm886_ldo_ops,
+			.type = REGULATOR_VOLTAGE,
+			.enable_reg = PM886_REG_LDO_EN2,
+			.enable_mask = BIT(0),
+			.volt_table = pm886_ldo_volt_table2,
+			.n_voltages = ARRAY_SIZE(pm886_ldo_volt_table2),
+			.vsel_reg = PM886_REG_LDO9_VOUT,
+			.vsel_mask = PM886_LDO_VSEL_MASK,
+		},
+		.max_uA = 400000,
+	},
+	{
+		.desc = {
+			.name = "LDO10",
+			.regulators_node = "regulators",
+			.of_match = "ldo10",
+			.ops = &pm886_ldo_ops,
+			.type = REGULATOR_VOLTAGE,
+			.enable_reg = PM886_REG_LDO_EN2,
+			.enable_mask = BIT(1),
+			.volt_table = pm886_ldo_volt_table2,
+			.n_voltages = ARRAY_SIZE(pm886_ldo_volt_table2),
+			.vsel_reg = PM886_REG_LDO10_VOUT,
+			.vsel_mask = PM886_LDO_VSEL_MASK,
+		},
+		.max_uA = 200000,
+	},
+	{
+		.desc = {
+			.name = "LDO11",
+			.regulators_node = "regulators",
+			.of_match = "ldo11",
+			.ops = &pm886_ldo_ops,
+			.type = REGULATOR_VOLTAGE,
+			.enable_reg = PM886_REG_LDO_EN2,
+			.enable_mask = BIT(2),
+			.volt_table = pm886_ldo_volt_table2,
+			.n_voltages = ARRAY_SIZE(pm886_ldo_volt_table2),
+			.vsel_reg = PM886_REG_LDO11_VOUT,
+			.vsel_mask = PM886_LDO_VSEL_MASK,
+		},
+		.max_uA = 200000,
+	},
+	{
+		.desc = {
+			.name = "LDO12",
+			.regulators_node = "regulators",
+			.of_match = "ldo12",
+			.ops = &pm886_ldo_ops,
+			.type = REGULATOR_VOLTAGE,
+			.enable_reg = PM886_REG_LDO_EN2,
+			.enable_mask = BIT(3),
+			.volt_table = pm886_ldo_volt_table2,
+			.n_voltages = ARRAY_SIZE(pm886_ldo_volt_table2),
+			.vsel_reg = PM886_REG_LDO12_VOUT,
+			.vsel_mask = PM886_LDO_VSEL_MASK,
+		},
+		.max_uA = 200000,
+	},
+	{
+		.desc = {
+			.name = "LDO13",
+			.regulators_node = "regulators",
+			.of_match = "ldo13",
+			.ops = &pm886_ldo_ops,
+			.type = REGULATOR_VOLTAGE,
+			.enable_reg = PM886_REG_LDO_EN2,
+			.enable_mask = BIT(4),
+			.volt_table = pm886_ldo_volt_table2,
+			.n_voltages = ARRAY_SIZE(pm886_ldo_volt_table2),
+			.vsel_reg = PM886_REG_LDO13_VOUT,
+			.vsel_mask = PM886_LDO_VSEL_MASK,
+		},
+		.max_uA = 200000,
+	},
+	{
+		.desc = {
+			.name = "LDO14",
+			.regulators_node = "regulators",
+			.of_match = "ldo14",
+			.ops = &pm886_ldo_ops,
+			.type = REGULATOR_VOLTAGE,
+			.enable_reg = PM886_REG_LDO_EN2,
+			.enable_mask = BIT(5),
+			.volt_table = pm886_ldo_volt_table2,
+			.n_voltages = ARRAY_SIZE(pm886_ldo_volt_table2),
+			.vsel_reg = PM886_REG_LDO14_VOUT,
+			.vsel_mask = PM886_LDO_VSEL_MASK,
+		},
+		.max_uA = 200000,
+	},
+	{
+		.desc = {
+			.name = "LDO15",
+			.regulators_node = "regulators",
+			.of_match = "ldo15",
+			.ops = &pm886_ldo_ops,
+			.type = REGULATOR_VOLTAGE,
+			.enable_reg = PM886_REG_LDO_EN2,
+			.enable_mask = BIT(6),
+			.volt_table = pm886_ldo_volt_table2,
+			.n_voltages = ARRAY_SIZE(pm886_ldo_volt_table2),
+			.vsel_reg = PM886_REG_LDO15_VOUT,
+			.vsel_mask = PM886_LDO_VSEL_MASK,
+		},
+		.max_uA = 200000,
+	},
+	{
+		.desc = {
+			.name = "LDO16",
+			.regulators_node = "regulators",
+			.of_match = "ldo16",
+			.ops = &pm886_ldo_ops,
+			.type = REGULATOR_VOLTAGE,
+			.enable_reg = PM886_REG_LDO_EN2,
+			.enable_mask = BIT(7),
+			.volt_table = pm886_ldo_volt_table3,
+			.n_voltages = ARRAY_SIZE(pm886_ldo_volt_table3),
+			.vsel_reg = PM886_REG_LDO16_VOUT,
+			.vsel_mask = PM886_LDO_VSEL_MASK,
+		},
+		.max_uA = 200000,
+	},
+	{
+		.desc = {
+			.name = "buck1",
+			.regulators_node = "regulators",
+			.of_match = "buck1",
+			.ops = &pm886_buck_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = 85,
+			.linear_ranges = pm886_buck_volt_ranges1,
+			.n_linear_ranges = ARRAY_SIZE(pm886_buck_volt_ranges1),
+			.vsel_reg = PM886_REG_BUCK1_VOUT,
+			.vsel_mask = PM886_BUCK_VSEL_MASK,
+			.enable_reg = PM886_REG_BUCK_EN,
+			.enable_mask = BIT(0),
+		},
+		.max_uA = 3000000,
+	},
+	{
+		.desc = {
+			.name = "buck2",
+			.regulators_node = "regulators",
+			.of_match = "buck2",
+			.ops = &pm886_buck_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = 115,
+			.linear_ranges = pm886_buck_volt_ranges2,
+			.n_linear_ranges = ARRAY_SIZE(pm886_buck_volt_ranges2),
+			.vsel_reg = PM886_REG_BUCK2_VOUT,
+			.vsel_mask = PM886_BUCK_VSEL_MASK,
+			.enable_reg = PM886_REG_BUCK_EN,
+			.enable_mask = BIT(1),
+		},
+		.max_uA = 1200000,
+	},
+	{
+		.desc = {
+			.name = "buck3",
+			.regulators_node = "regulators",
+			.of_match = "buck3",
+			.ops = &pm886_buck_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = 115,
+			.linear_ranges = pm886_buck_volt_ranges2,
+			.n_linear_ranges = ARRAY_SIZE(pm886_buck_volt_ranges2),
+			.vsel_reg = PM886_REG_BUCK3_VOUT,
+			.vsel_mask = PM886_BUCK_VSEL_MASK,
+			.enable_reg = PM886_REG_BUCK_EN,
+			.enable_mask = BIT(2),
+		},
+		.max_uA = 1200000,
+	},
+	{
+		.desc = {
+			.name = "buck4",
+			.regulators_node = "regulators",
+			.of_match = "buck4",
+			.ops = &pm886_buck_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = 115,
+			.linear_ranges = pm886_buck_volt_ranges2,
+			.n_linear_ranges = ARRAY_SIZE(pm886_buck_volt_ranges2),
+			.vsel_reg = PM886_REG_BUCK4_VOUT,
+			.vsel_mask = PM886_BUCK_VSEL_MASK,
+			.enable_reg = PM886_REG_BUCK_EN,
+			.enable_mask = BIT(3),
+		},
+		.max_uA = 1200000,
+	},
+	{
+		.desc = {
+			.name = "buck5",
+			.regulators_node = "regulators",
+			.of_match = "buck5",
+			.ops = &pm886_buck_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = 115,
+			.linear_ranges = pm886_buck_volt_ranges2,
+			.n_linear_ranges = ARRAY_SIZE(pm886_buck_volt_ranges2),
+			.vsel_reg = PM886_REG_BUCK5_VOUT,
+			.vsel_mask = PM886_BUCK_VSEL_MASK,
+			.enable_reg = PM886_REG_BUCK_EN,
+			.enable_mask = BIT(4),
+		},
+		.max_uA = 1200000,
+	},
+};
+
+static int pm886_regulator_probe(struct platform_device *pdev)
+{
+	struct pm886_chip *chip = dev_get_drvdata(pdev->dev.parent);
+	struct regulator_config rcfg = { };
+	struct pm886_regulator *regulator;
+	struct device *dev = &pdev->dev;
+	struct regulator_desc *rdesc;
+	struct regulator_dev *rdev;
+	struct i2c_client *page;
+	struct regmap *regmap;
+
+	page = devm_i2c_new_dummy_device(dev, chip->client->adapter,
+			chip->client->addr + PM886_PAGE_OFFSET_REGULATORS);
+	if (IS_ERR(page))
+		return dev_err_probe(dev, PTR_ERR(page),
+				"Failed to initialize regulators client\n");
+
+	regmap = devm_regmap_init_i2c(page, &pm886_regulator_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				"Failed to initialize regulators regmap\n");
+	rcfg.regmap = regmap;
+
+	rcfg.dev = dev->parent;
+
+	for (int i = 0; i < ARRAY_SIZE(pm886_regulators); i++) {
+		regulator = &pm886_regulators[i];
+		rdesc = &regulator->desc;
+		rcfg.driver_data = regulator;
+		rdev = devm_regulator_register(dev, rdesc, &rcfg);
+		if (IS_ERR(rdev))
+			return dev_err_probe(dev, PTR_ERR(rdev),
+					"Failed to register %s\n", rdesc->name);
+	}
+
+	return 0;
+}
+
+static const struct platform_device_id pm886_regulator_id_table[] = {
+	{ "88pm886-regulator", },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, pm886_regulator_id_table);
+
+static struct platform_driver pm886_regulator_driver = {
+	.driver = {
+		.name = "88pm886-regulator",
+	},
+	.probe = pm886_regulator_probe,
+	.id_table = pm886_regulator_id_table,
+};
+module_platform_driver(pm886_regulator_driver);
+
+MODULE_DESCRIPTION("Marvell 88PM886 PMIC regulator driver");
+MODULE_AUTHOR("Karel Balej <balejk@matfyz.cz>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 7db0a29b5b8d..89845892c533 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -91,6 +91,12 @@ config REGULATOR_88PM8607
 	help
 	  This driver supports 88PM8607 voltage regulator chips.
 
+config REGULATOR_88PM886
+	tristate "Marvell 88PM886 voltage regulators"
+	depends on MFD_88PM886_PMIC
+	help
+	  This driver implements support for Marvell 88PM886 voltage regulators.
+
 config REGULATOR_ACT8865
 	tristate "Active-semi act8865 voltage regulator"
 	depends on I2C
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 46fb569e6be8..f30089b74b2e 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_REGULATOR_USERSPACE_CONSUMER) += userspace-consumer.o
 obj-$(CONFIG_REGULATOR_88PG86X) += 88pg86x.o
 obj-$(CONFIG_REGULATOR_88PM800) += 88pm800-regulator.o
 obj-$(CONFIG_REGULATOR_88PM8607) += 88pm8607.o
+obj-$(CONFIG_REGULATOR_88PM886) += 88pm886-regulator.o
 obj-$(CONFIG_REGULATOR_CROS_EC) += cros-ec-regulator.o
 obj-$(CONFIG_REGULATOR_CPCAP) += cpcap-regulator.o
 obj-$(CONFIG_REGULATOR_AAT2870) += aat2870-regulator.o
-- 
2.44.0


