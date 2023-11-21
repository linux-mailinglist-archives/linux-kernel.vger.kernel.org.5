Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C437F32BC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbjKUPxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234313AbjKUPxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:53:14 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2078.outbound.protection.outlook.com [40.107.21.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3211E139;
        Tue, 21 Nov 2023 07:53:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdjsCJxTP4E/TL3LolVPgePqaMuo/+t7c+Cf6br01B49Fs6Reg/2lA9ZhxJQmIC5Ns0OHW5ha4oaC29Vz1hXJBnVknmVKPhlG90vCT2kO3gPgjpbXRNkdxptti8GJ3VV1LnWe/RmTtUW90hT+5+JiCY20XMVI5sj/pmdU7peIee17/U3FodYaZBd6SRjlj6dDceb6Yh/1ed7QVh3ToISIzM2YjZG80vxoaq4UkmocYXNcvgawstchZl/L8SQxW6wr1wMCYIFRz8MrzlmExE+FmpTZdLRJK17+HPPq/zRni6mb4Ux1iv+m0+p2Knxv5Fs9jyS1VAltKNT3o/2jte/dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgb9ERxP5pyB7OPCkeicaVAird9kr1tXPuVPtKp3RGs=;
 b=bw0XIWO1PbTnOBvQ7wc5TOzPi9umui8Pje9JnUUf84c3MUgypSfV5Xfy5qoJ0ywAsQLF9nRwIgtmXyZorpk2+53x04TbEhk9nMl2d8gExJy1UgGNTqMh+fxWvA+g4Q3VtkiOnCWbZnwGYOcYY2MXRCKeLsOVEpFAIjM8nx+kbCAS/W/vKITiaCcR5cVu3qWj26a0t329dy2/CgZeaXg79hR7akHRhq+tQ7tiM3Q0KN0lsACxevwmIEUnrXWLZwnmE/M+KhZW247E4i1A6O3hiKLH3TDSlzx53lmShNRYRlS3Ktr5UFycq4YFAOlMD8xhkmyEV3y7t3NcokvNiX3wvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=linaro.org smtp.mailfrom=2n.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=axis.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgb9ERxP5pyB7OPCkeicaVAird9kr1tXPuVPtKp3RGs=;
 b=M5NZu+4ofxBQP4izEJ2ctVo/Vb38O9nJPZijwsbVBJZ/FEDPcf9ggk9skizRlEknXk4Ec5Hn8/xWNCK0WNeJqwDQTUNoG4oxEz5XUocP5T9D/dMD+nXN7ISkiCFa3s1h1fHzggd2eJM/UenVcmgmAQdjfx8XMP/MGqRqqM7Rf+k=
Received: from AS8P250CA0005.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:330::10)
 by DU0PR02MB9799.eurprd02.prod.outlook.com (2603:10a6:10:44c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 15:53:07 +0000
Received: from AM2PEPF0001C70A.eurprd05.prod.outlook.com
 (2603:10a6:20b:330:cafe::6b) by AS8P250CA0005.outlook.office365.com
 (2603:10a6:20b:330::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28 via Frontend
 Transport; Tue, 21 Nov 2023 15:53:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of 2n.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AM2PEPF0001C70A.mail.protection.outlook.com (10.167.16.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.13 via Frontend Transport; Tue, 21 Nov 2023 15:53:06 +0000
Received: from lap5cg227217h.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Nov
 2023 16:53:05 +0100
From:   Jiri Valek - 2N <jiriv@axis.com>
To:     <krzysztof.kozlowski+dt@linaro.org>, <dmitry.torokhov@gmail.com>
CC:     <jiriv@axis.com>, <devicetree@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v6 2/2] Input: cap11xx - add advanced sensitivity settings
Date:   Tue, 21 Nov 2023 16:52:50 +0100
Message-ID: <20231121155250.613242-3-jiriv@axis.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231121155250.613242-1-jiriv@axis.com>
References: <20231121155250.613242-1-jiriv@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70A:EE_|DU0PR02MB9799:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b780eb4-d8ec-491e-4651-08dbeaa9f425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D6mGowTlhgZ615gEjlbgmilYlsKFj77D+Q4iIw1KdVONlPh5tEeo77wNiXKp18Qesrkdmc1IR9BEHPzTKU7Esp8g6cld+ZkP0x6xSPw76G0slgfvZ5LBI539gz3dgnEHiBFeh1tc0oHqNYKeT8xVNkrzhfC43xNgRL63KGO7VPn/Q7LMKoUY3YiA0BQmXNNhVUS8ps7OgMLmog7gNOHTYwQObACmNLtP9guXvZiBCERDsz5YAH1sRjTVdS5wiwZpBSF4q7P167doc3W5BBEGCXcDmugdhujQFTmmMRX2PcUrpH2bXZfbYV4AVmIJZAg5iK7TgflXnwSQtMU1ahgalf+Wkq3eMxXS+65U6b+YRz+P5ZeHe9ociNuuOjFHWiWf9cGQLriVGQFBvUUQaCoe53Sa4doj+V8RU8m4VApAjD6N/u97WOiRLJC1lcbQjQprofFV7b17D/LJSniOSRA7wyKVRclexRsFIjPdSdVgzc4gEja/ov/iNCLeGGuioY7duSuxJpGlbhWoImK7MOi9m6QmwlZfJ1d1d0tMRuOg7YQizfNxuFGLU9whJZCGYg16zu7pK4bI3eGB/sd6iI5oMwPga6cAGSzXLUQ53glzgGAZlcwpBt4PaW+YZaAeEyHpD/RS5Z6iyyUr/lTUEUaEg6+8pln+Pdviy+QaduNu4eOTqleezJAo9/vOR0mZulO7b45HJRC0wsHYhIgUvXTPGBJHi6KB92NWSwafXhWqlsdMvXw0nsCW69fqTMtwgk3bwarFozlTDOCD4sGsC6dIRw==
X-Forefront-Antispam-Report: CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(230922051799003)(1800799012)(82310400011)(451199024)(186009)(64100799003)(40470700004)(46966006)(36840700001)(7696005)(40480700001)(83380400001)(1076003)(2616005)(6666004)(478600001)(16526019)(54906003)(40460700003)(26005)(110136005)(316002)(70206006)(70586007)(336012)(426003)(42882007)(36860700001)(47076005)(2906002)(82740400003)(356005)(41300700001)(81166007)(83170400001)(5660300002)(8936002)(36756003)(8676002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 15:53:06.9200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b780eb4-d8ec-491e-4651-08dbeaa9f425
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C70A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB9799
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 1b4937dce672..e6210f8b66ee 100644
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
+	if (!of_property_read_u32_array(node, "microchip,input-threshold",
+					priv->thresholds, priv->model->num_channels)) {
+		for (i = 0; i < priv->model->num_channels; i++) {
+			if (priv->thresholds[i] > 127) {
+				dev_err(dev, "Invalid input-threshold value %u\n",
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

