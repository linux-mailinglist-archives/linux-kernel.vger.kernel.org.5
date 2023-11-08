Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222717E5AA6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbjKHP5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbjKHP5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:57:13 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2088.outbound.protection.outlook.com [40.107.247.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347E2172E;
        Wed,  8 Nov 2023 07:57:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBkiSZxpgrlKwvkwmpz9EM5OKLRzA+p2ffAprcrKhaAqhRtpSqEG41RDewQxNB1j+wFlNUNDGrt5fTyVTio7DbV3GdUVdnaD95OVOFu5KVZIU1a8kzFbbi6151gAr0uCviLdUqNT/o3dAVN478L080ExwLgtl3KQGZQDk2v+D3MSrIn/A3cMx0LqRexOHMQQ5+xHb07PUeNvPhUtieMn2mwWjqp9aszEh73bbjtk2kxmVClUWF9VfbzcHTiOx7y1WUBg6nA3gu47DE3PnuOYDrO5evCogPbSoIJWqQiLwiRW07lWX6e/uWypvIVsk6yh5C4cHo6meMT0l2H7PedSpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PfeqEQQMUyX063aD7bQtdefaNe3lhR9MsuX+3sapWZc=;
 b=lAECoFmsylrm6lB7jOT4AU3La3UJaX5hiXH9w7qqo5s3hhsuXzU1WVkc6/6hz7MQ19r4Wd1J2VuBm7+eCGo+Lg3seSGA/3hhAHzW8XwdE30AFWxEe3/Q7QowizaS4o14pObTj9OXuxDc5zqrlYbI6BNk9ry6YkKgU+X9JwphVZMfzX1q6ou6C/fwXf22sXiQ8oewyGLqEeYPmuIYRq9yF8xayB+Q04UVCp36dw6aPNoS+lAnNenNwpjiSgCZj6MQMwxDS0Xvu8Yn463UzdwscuJA8z/fUwrqDbb+6dv4+qBQj9EeT2QbtNhkseRH0HyqUm0oYu6eZGpnhkcnESLTYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=linaro.org smtp.mailfrom=2n.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=axis.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfeqEQQMUyX063aD7bQtdefaNe3lhR9MsuX+3sapWZc=;
 b=BnFJ8Avg6m9SvF1pqnyQpcuf9lBF4EIFSkHtRf7AygYwwiTiPi/rLUsXIDDwR8L7WYAN08ssjHEnlOBLYUSGPlL8vyAabUG4v+kZblCUO+OCeD4DAtywtnXsuD4KpLwQWXin8mTczw+BXUokk8uMXmiiuFXflaDurov43S2NYAM=
Received: from AS9PR01CA0004.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:540::13) by DU0PR02MB9444.eurprd02.prod.outlook.com
 (2603:10a6:10:41c::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 15:57:08 +0000
Received: from AM2PEPF0001C714.eurprd05.prod.outlook.com
 (2603:10a6:20b:540:cafe::13) by AS9PR01CA0004.outlook.office365.com
 (2603:10a6:20b:540::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 15:57:08 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of 2n.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AM2PEPF0001C714.mail.protection.outlook.com (10.167.16.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.17 via Frontend Transport; Wed, 8 Nov 2023 15:57:08 +0000
Received: from lap5cg227217h.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 8 Nov
 2023 16:57:06 +0100
From:   Jiri Valek - 2N <jiriv@axis.com>
To:     <krzysztof.kozlowski+dt@linaro.org>, <dmitry.torokhov@gmail.com>
CC:     <jiriv@axis.com>, <devicetree@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v5 2/3] Input: cap11xx - add advanced sensitivity settings
Date:   Wed, 8 Nov 2023 16:56:46 +0100
Message-ID: <20231108155647.1812835-3-jiriv@axis.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231108155647.1812835-1-jiriv@axis.com>
References: <20231108155647.1812835-1-jiriv@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C714:EE_|DU0PR02MB9444:EE_
X-MS-Office365-Filtering-Correlation-Id: 60e1ff79-49bf-408e-dbda-08dbe0735c85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IGfYoVI1hFAJsY6tx5a7sHDhBTK4p6ykuPsUzMHF9mgeYdxOWSLJWqPKq9yAN77y81pRU40wOnhLsf/o3XaIL/BWE+LN80Q5auBEQqymdckEcfh6a4SgX2K5Fc2AO7NNY59cHmbpz+WGcn/CYWvGLkOl8Y/zbNSN4mmVPwXOedtkOaxys7rU5ojd4ujV1/8XIxmDzkzIwdEYWNFFqaS/Xsxoe21kRDB0Qy+ekTfq4FFJI+CMIDGhsZqhAE0VBaM1j5Ie3iEztWVIVfFGOC1WhtordYV0EgzWa+PWkbkLbPzr/k+Mxvoxw85RZvR9h0no3gpAT1RXyQl0mj2Bqss2ZSeLYpdiE+IhGnwTTogtHZqsg6nm0G2c1vyXPGZLx9SXeIdxAv02ZyszawQtJHS6uV/+yPxinozePBjHKKC7Oup4EGUrRKwq2y2R+XOWj7MB8p9sAikDXQQOXexlUor7SkTZJSsBEC2ZVrFc/3bXYMJdBOcOsSQBovQF+hfkJT+SMzbdO6vEP1oHsck9MvegvQo2ll+3OgWUJt94h5ZSDwO4Q/x4SSjbgMRxgIg9e6IGYi2EdJoAkwN50MEwyzAAE++KB3qsJgwcAAAvWCRxNwG2xJv6kjWc6mg7VoEeu9o6j7aUNPyIhKpTk3m1nR55/3l+RgM6QvyRJhjUguy+LcD/7paF61e5rzwSIvMeFHFTkooSZ9rkhvbpNzfNf9Y99tC0T1OVPE8el++o7IbstknlB7iMhLWbNBU/PaUqzGQXuKsfV/2wMLTYTVn0LAB0XA==
X-Forefront-Antispam-Report: CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(451199024)(64100799003)(82310400011)(1800799009)(186009)(40470700004)(46966006)(36840700001)(2906002)(40460700003)(40480700001)(16526019)(426003)(7696005)(336012)(26005)(41300700001)(47076005)(42882007)(2616005)(1076003)(6666004)(36860700001)(81166007)(83170400001)(356005)(36756003)(82740400003)(478600001)(5660300002)(8676002)(8936002)(4326008)(70586007)(83380400001)(70206006)(316002)(54906003)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 15:57:08.0881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e1ff79-49bf-408e-dbda-08dbe0735c85
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C714.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB9444
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for advanced sensitivity settings that allows more precise
tunig of touch buttons. Input-treshold allows to set the sensitivity for
each channel separately. Also add signal guard feature for CAP129x chips.

Signed-off-by: Jiri Valek - 2N <jiriv@axis.com>
---
 drivers/input/keyboard/cap11xx.c | 242 +++++++++++++++++++++++++------
 1 file changed, 196 insertions(+), 46 deletions(-)

diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
index 1b4937dce672..4711ea985627 100644
--- a/drivers/input/keyboard/cap11xx.c
+++ b/drivers/input/keyboard/cap11xx.c
@@ -14,6 +14,7 @@
 #include <linux/regmap.h>
 #include <linux/i2c.h>
 #include <linux/gpio/consumer.h>
+#include <linux/bitfield.h>
 
 #define CAP11XX_REG_MAIN_CONTROL	0x00
 #define CAP11XX_REG_MAIN_CONTROL_GAIN_SHIFT	(6)
@@ -24,6 +25,7 @@
 #define CAP11XX_REG_NOISE_FLAG_STATUS	0x0a
 #define CAP11XX_REG_SENOR_DELTA(X)	(0x10 + (X))
 #define CAP11XX_REG_SENSITIVITY_CONTROL	0x1f
+#define CAP11XX_REG_SENSITIVITY_CONTROL_DELTA_SENSE_MASK	0x70
 #define CAP11XX_REG_CONFIG		0x20
 #define CAP11XX_REG_SENSOR_ENABLE	0x21
 #define CAP11XX_REG_SENSOR_CONFIG	0x22
@@ -32,6 +34,7 @@
 #define CAP11XX_REG_CALIBRATION		0x26
 #define CAP11XX_REG_INT_ENABLE		0x27
 #define CAP11XX_REG_REPEAT_RATE		0x28
+#define CAP11XX_REG_SIGNAL_GUARD_ENABLE	0x29
 #define CAP11XX_REG_MT_CONFIG		0x2a
 #define CAP11XX_REG_MT_PATTERN_CONFIG	0x2b
 #define CAP11XX_REG_MT_PATTERN		0x2d
@@ -47,6 +50,8 @@
 #define CAP11XX_REG_SENSOR_BASE_CNT(X)	(0x50 + (X))
 #define CAP11XX_REG_LED_POLARITY	0x73
 #define CAP11XX_REG_LED_OUTPUT_CONTROL	0x74
+#define CAP11XX_REG_CALIB_SENSITIVITY_CONFIG	0x80
+#define CAP11XX_REG_CALIB_SENSITIVITY_CONFIG2	0x81
 
 #define CAP11XX_REG_LED_DUTY_CYCLE_1	0x90
 #define CAP11XX_REG_LED_DUTY_CYCLE_2	0x91
@@ -78,12 +83,20 @@ struct cap11xx_led {
 
 struct cap11xx_priv {
 	struct regmap *regmap;
+	struct device *dev;
 	struct input_dev *idev;
+	const struct cap11xx_hw_model *model;
+	u8 id;
 
 	struct cap11xx_led *leds;
 	int num_leds;
 
 	/* config */
+	u8 analog_gain;
+	u8 sensitivity_delta_sense;
+	u8 signal_guard_inputs_mask;
+	u32 thresholds[8];
+	u32 calib_sensitivities[8];
 	u32 keycodes[];
 };
 
@@ -181,6 +194,178 @@ static const struct regmap_config cap11xx_regmap_config = {
 	.volatile_reg = cap11xx_volatile_reg,
 };
 
+static int
+cap11xx_write_calib_sens_config_1(struct cap11xx_priv *priv)
+{
+	return regmap_write(priv->regmap,
+			CAP11XX_REG_CALIB_SENSITIVITY_CONFIG,
+			(priv->calib_sensitivities[3] << 6) |
+			(priv->calib_sensitivities[2] << 4) |
+			(priv->calib_sensitivities[1] << 2) |
+			priv->calib_sensitivities[0]);
+}
+
+static int
+cap11xx_write_calib_sens_config_2(struct cap11xx_priv *priv)
+{
+	return regmap_write(priv->regmap,
+			CAP11XX_REG_CALIB_SENSITIVITY_CONFIG2,
+			(priv->calib_sensitivities[7] << 6) |
+			(priv->calib_sensitivities[6] << 4) |
+			(priv->calib_sensitivities[5] << 2) |
+			priv->calib_sensitivities[4]);
+}
+
+static int
+cap11xx_init_keys(struct cap11xx_priv *priv)
+{
+	struct device_node *node = priv->dev->of_node;
+	struct device *dev = priv->dev;
+	int i, error;
+	u32 u32_val;
+
+	if (!node) {
+		dev_err(dev, "Corresponding DT entry is not available\n");
+		return -ENODEV;
+	}
+
+	if (!of_property_read_u32(node, "microchip,sensor-gain", &u32_val)) {
+		if (priv->model->no_gain) {
+			dev_warn(dev,
+				 "This model doesn't support 'sensor-gain'\n");
+		} else if (is_power_of_2(u32_val) && u32_val <= 8) {
+			priv->analog_gain = (u8)ilog2(u32_val);
+
+			error = regmap_update_bits(priv->regmap,
+				CAP11XX_REG_MAIN_CONTROL,
+				CAP11XX_REG_MAIN_CONTROL_GAIN_MASK,
+				priv->analog_gain << CAP11XX_REG_MAIN_CONTROL_GAIN_SHIFT);
+			if (error)
+				return error;
+		} else {
+			dev_err(dev, "Invalid sensor-gain value %u\n", u32_val);
+			return -EINVAL;
+		}
+	}
+
+	if (of_property_read_bool(node, "microchip,irq-active-high")) {
+		if (priv->id == CAP1106 ||
+		    priv->id == CAP1126 ||
+		    priv->id == CAP1188) {
+			error = regmap_update_bits(priv->regmap,
+						   CAP11XX_REG_CONFIG2,
+						   CAP11XX_REG_CONFIG2_ALT_POL,
+						   0);
+			if (error)
+				return error;
+		} else {
+			dev_warn(dev,
+				 "This model doesn't support 'irq-active-high'\n");
+		}
+	}
+
+	if (!of_property_read_u32(node,
+				  "microchip,sensitivity-delta-sense", &u32_val)) {
+		if (!is_power_of_2(u32_val) || u32_val > 128) {
+			dev_err(dev, "Invalid sensitivity-delta-sense value %u\n", u32_val);
+			return -EINVAL;
+		}
+
+		priv->sensitivity_delta_sense = (u8)ilog2(u32_val);
+		u32_val = ~(FIELD_PREP(CAP11XX_REG_SENSITIVITY_CONTROL_DELTA_SENSE_MASK,
+					priv->sensitivity_delta_sense));
+
+		error = regmap_update_bits(priv->regmap,
+					   CAP11XX_REG_SENSITIVITY_CONTROL,
+					   CAP11XX_REG_SENSITIVITY_CONTROL_DELTA_SENSE_MASK,
+					   u32_val);
+		if (error)
+			return error;
+	}
+
+	if (!of_property_read_u32_array(node, "microchip,input-treshold",
+					priv->thresholds, priv->model->num_channels)) {
+		for (i = 0; i < priv->model->num_channels; i++) {
+			if (priv->thresholds[i] > 127) {
+				dev_err(dev, "Invalid input-treshold value %u\n",
+					priv->thresholds[i]);
+				return -EINVAL;
+			}
+
+			error = regmap_write(priv->regmap,
+					     CAP11XX_REG_SENSOR_THRESH(i),
+					     priv->thresholds[i]);
+			if (error)
+				return error;
+		}
+	}
+
+	if (!of_property_read_u32_array(node, "microchip,calib-sensitivity",
+					priv->calib_sensitivities, priv->model->num_channels)) {
+		if (priv->id == CAP1293 || priv->id == CAP1298) {
+			for (i = 0; i < priv->model->num_channels; i++) {
+				if (!is_power_of_2(priv->calib_sensitivities[i]) ||
+				    priv->calib_sensitivities[i] > 4) {
+					dev_err(dev, "Invalid calib-sensitivity value %u\n",
+						priv->calib_sensitivities[i]);
+					return -EINVAL;
+				}
+				priv->calib_sensitivities[i] = ilog2(priv->calib_sensitivities[i]);
+			}
+
+			error = cap11xx_write_calib_sens_config_1(priv);
+			if (error)
+				return error;
+
+			if (priv->id == CAP1298) {
+				error = cap11xx_write_calib_sens_config_2(priv);
+				if (error)
+					return error;
+			}
+		} else {
+			dev_warn(dev,
+				 "This model doesn't support 'calib-sensitivity'\n");
+		}
+	}
+
+	for (i = 0; i < priv->model->num_channels; i++) {
+		if (!of_property_read_u32_index(node, "microchip,signal-guard",
+						i, &u32_val)) {
+			if (u32_val > 1)
+				return -EINVAL;
+			if (u32_val)
+				priv->signal_guard_inputs_mask |= 0x01 << i;
+		}
+	}
+
+	if (priv->signal_guard_inputs_mask) {
+		if (priv->id == CAP1293 || priv->id == CAP1298) {
+			error = regmap_write(priv->regmap,
+					     CAP11XX_REG_SIGNAL_GUARD_ENABLE,
+					     priv->signal_guard_inputs_mask);
+			if (error)
+				return error;
+		} else {
+			dev_warn(dev,
+				 "This model doesn't support 'signal-guard'\n");
+		}
+	}
+
+	/* Provide some useful defaults */
+	for (i = 0; i < priv->model->num_channels; i++)
+		priv->keycodes[i] = KEY_A + i;
+
+	of_property_read_u32_array(node, "linux,keycodes",
+				   priv->keycodes, priv->model->num_channels);
+
+	/* Disable autorepeat. The Linux input system has its own handling. */
+	error = regmap_write(priv->regmap, CAP11XX_REG_REPEAT_RATE, 0);
+	if (error)
+		return error;
+
+	return 0;
+}
+
 static irqreturn_t cap11xx_thread_func(int irq_num, void *data)
 {
 	struct cap11xx_priv *priv = data;
@@ -332,11 +517,9 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client)
 	const struct i2c_device_id *id = i2c_client_get_device_id(i2c_client);
 	struct device *dev = &i2c_client->dev;
 	struct cap11xx_priv *priv;
-	struct device_node *node;
 	const struct cap11xx_hw_model *cap;
-	int i, error, irq, gain = 0;
+	int i, error, irq;
 	unsigned int val, rev;
-	u32 gain32;
 
 	if (id->driver_data >= ARRAY_SIZE(cap11xx_devices)) {
 		dev_err(dev, "Invalid device ID %lu\n", id->driver_data);
@@ -355,6 +538,8 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->dev = dev;
+
 	priv->regmap = devm_regmap_init_i2c(i2c_client, &cap11xx_regmap_config);
 	if (IS_ERR(priv->regmap))
 		return PTR_ERR(priv->regmap);
@@ -384,50 +569,15 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client)
 		return error;
 
 	dev_info(dev, "CAP11XX detected, model %s, revision 0x%02x\n",
-		 id->name, rev);
-	node = dev->of_node;
-
-	if (!of_property_read_u32(node, "microchip,sensor-gain", &gain32)) {
-		if (cap->no_gain)
-			dev_warn(dev,
-				 "This version doesn't support sensor gain\n");
-		else if (is_power_of_2(gain32) && gain32 <= 8)
-			gain = ilog2(gain32);
-		else
-			dev_err(dev, "Invalid sensor-gain value %d\n", gain32);
-	}
+			 id->name, rev);
 
-	if (id->driver_data == CAP1106 ||
-	    id->driver_data == CAP1126 ||
-	    id->driver_data == CAP1188) {
-		if (of_property_read_bool(node, "microchip,irq-active-high")) {
-			error = regmap_update_bits(priv->regmap,
-						   CAP11XX_REG_CONFIG2,
-						   CAP11XX_REG_CONFIG2_ALT_POL,
-						   0);
-			if (error)
-				return error;
-		}
-	}
+	priv->model = cap;
+	priv->id = id->driver_data;
 
-	/* Provide some useful defaults */
-	for (i = 0; i < cap->num_channels; i++)
-		priv->keycodes[i] = KEY_A + i;
-
-	of_property_read_u32_array(node, "linux,keycodes",
-				   priv->keycodes, cap->num_channels);
-
-	if (!cap->no_gain) {
-		error = regmap_update_bits(priv->regmap,
-				CAP11XX_REG_MAIN_CONTROL,
-				CAP11XX_REG_MAIN_CONTROL_GAIN_MASK,
-				gain << CAP11XX_REG_MAIN_CONTROL_GAIN_SHIFT);
-		if (error)
-			return error;
-	}
+	dev_info(dev, "CAP11XX device detected, model %s, revision 0x%02x\n",
+		 id->name, rev);
 
-	/* Disable autorepeat. The Linux input system has its own handling. */
-	error = regmap_write(priv->regmap, CAP11XX_REG_REPEAT_RATE, 0);
+	error = cap11xx_init_keys(priv);
 	if (error)
 		return error;
 
@@ -439,7 +589,7 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client)
 	priv->idev->id.bustype = BUS_I2C;
 	priv->idev->evbit[0] = BIT_MASK(EV_KEY);
 
-	if (of_property_read_bool(node, "autorepeat"))
+	if (of_property_read_bool(dev->of_node, "autorepeat"))
 		__set_bit(EV_REP, priv->idev->evbit);
 
 	for (i = 0; i < cap->num_channels; i++)
@@ -474,7 +624,7 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client)
 	if (error)
 		return error;
 
-	irq = irq_of_parse_and_map(node, 0);
+	irq = irq_of_parse_and_map(dev->of_node, 0);
 	if (!irq) {
 		dev_err(dev, "Unable to parse or map IRQ\n");
 		return -ENXIO;
-- 
2.25.1

