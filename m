Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741257A5993
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 07:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjISFss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 01:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjISFsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 01:48:38 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44C710F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 22:48:28 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-532aaba8747so871770a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 22:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1695102507; x=1695707307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sa5GzOASbkNoJ2Stb1sLrl1OAJ/byJTgOBQxqP09BnU=;
        b=J5PqMbQxvK8/xpda3IBBBOXYFq+tuD9tGBg94dISSOBQQLLptnW26BOZtQGajJifOU
         lgdLTS2jMPYW0wx8xZuTmFG+9LQAsJKF0pNeUO8oc4kiZvLeLucH7wNkHGobzytJjqFo
         lwj0cVlvEcjehQm8ZK8iNAUMegIxMlTF8clJ7w/u6MFGUqc8e54xMdoAAgW0A8OHHnSU
         G1qCMxIzQBEMN+oSAMFpdJp5wbd++5bkrBBhlGgv8TKHTcFBMqvP+LL/MQj8pFplUhjO
         EyhZRYc3A/GRzXe3yeUK4SHByZT10YwKj5L3A4ryZFRh562xRrYmV93zLGpMM4ssXxnE
         h2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695102507; x=1695707307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sa5GzOASbkNoJ2Stb1sLrl1OAJ/byJTgOBQxqP09BnU=;
        b=mljdV3t+PW5DZWLPTquNum8gJeNstprSULZnAepHqZbD+XgE0Gc8joko8+ZWwSb27M
         flD2LAlTvJDo/CVR+OIV7221qNhXs7LRR8jqPn8UFZOyr8vSew4zuAACss/LPk5JLUlr
         gJraVKnytkR2UMa1RudAYN/qHNNQRKNSl6kSAhwkym6P9UT4AWYtg0ecdCMkMn6LJUKN
         huaQQH6xx7N1q/8V5ng80F6pxY5LTWtgHKqdk+/2VlVRcTc+w2kFIDfy7og9M/oG66oE
         9vFeX4KkAYM9oRNKbw+CtWkznXlhMsBJzoErNah8VniNVbpLcoOd5DpeNwDaa+AS80Tk
         1ebw==
X-Gm-Message-State: AOJu0Yyuy9MLPooLUGZZwsB4pJXHri7kyK2ecKu34PTJmR91KngFK3Ft
        igZmy6MiIJX+rRDU+2ng0yXnAmr+Om/O8WEhLSU=
X-Google-Smtp-Source: AGHT+IHsaiK+Tyup4XKJsX0UftxKSwKGEZTvRGAYAwRGlqlhUylUA90QZKCeRUYn1CeKQmHJbTBmtA==
X-Received: by 2002:aa7:d893:0:b0:52f:736f:b50 with SMTP id u19-20020aa7d893000000b0052f736f0b50mr7876247edq.18.1695102507162;
        Mon, 18 Sep 2023 22:48:27 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id dn22-20020a05640222f600b00532c1dfe8ecsm194173edb.66.2023.09.18.22.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 22:48:26 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
To:     broonie@kernel.org, zev@bewilderbeest.net,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Naresh Solanki <naresh.solanki@9elements.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: [PATCH v4] regulator (max5970): Add hwmon support
Date:   Tue, 19 Sep 2023 07:48:23 +0200
Message-ID: <20230919054824.3368656-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Utilize the integrated 10-bit ADC in Max5970/Max5978 to enable voltage
and current monitoring. This feature is seamlessly integrated through
the hwmon subsystem.

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
---
Changes in V4:
- Use IS_REACHABLE
- Use rdevs array for hwmon ops.
- Remove duplicate i2c_set_clientdata
Changes in V3:
- Update signed-off
- Add break
- Update hwmon dev register name to max5970
- Remove changes in Kconfig.
Changes in V2:
- default case added for switch statement
- Add dependency on HWMON
---
 drivers/regulator/max5970-regulator.c | 138 +++++++++++++++++++++++++-
 1 file changed, 136 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/max5970-regulator.c b/drivers/regulator/max5970-regulator.c
index b56a174cde3d..06168fe1dadd 100644
--- a/drivers/regulator/max5970-regulator.c
+++ b/drivers/regulator/max5970-regulator.c
@@ -10,6 +10,7 @@
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/hwmon.h>
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/of.h>
@@ -32,6 +33,128 @@ enum max597x_regulator_id {
 	MAX597X_SW1,
 };
 
+static int max5970_read_adc(struct regmap *regmap, int reg, long *val)
+{
+	u8 reg_data[2];
+	int ret;
+
+	ret = regmap_bulk_read(regmap, reg, &reg_data[0], 2);
+	if (ret < 0)
+		return ret;
+
+	*val = (reg_data[0] << 2) | (reg_data[1] & 3);
+
+	return 0;
+}
+
+static int max5970_read(struct device *dev, enum hwmon_sensor_types type,
+			u32 attr, int channel, long *val)
+{
+	struct regulator_dev **rdevs = dev_get_drvdata(dev);
+	struct max5970_regulator *ddata = rdev_get_drvdata(rdevs[channel]);
+	struct regmap *regmap = ddata->regmap;
+	int ret;
+
+	switch (type) {
+	case hwmon_curr:
+		switch (attr) {
+		case hwmon_curr_input:
+			ret = max5970_read_adc(regmap, MAX5970_REG_CURRENT_H(channel), val);
+			/*
+			 * Calculate current from ADC value, IRNG range & shunt resistor value.
+			 * ddata->irng holds the voltage corresponding to the maximum value the
+			 * 10-bit ADC can measure.
+			 * To obtain the output, multiply the ADC value by the IRNG range (in
+			 * millivolts) and then divide it by the maximum value of the 10-bit ADC.
+			 */
+			*val = (*val * ddata->irng) >> 10;
+			/* Convert the voltage meansurement across shunt resistor to current */
+			*val = (*val * 1000) / ddata->shunt_micro_ohms;
+			return ret;
+		default:
+			return -EOPNOTSUPP;
+		}
+
+	case hwmon_in:
+		switch (attr) {
+		case hwmon_in_input:
+			ret = max5970_read_adc(regmap, MAX5970_REG_VOLTAGE_H(channel), val);
+			/*
+			 * Calculate voltage from ADC value and MON range.
+			 * ddata->mon_rng holds the voltage corresponding to the maximum value the
+			 * 10-bit ADC can measure.
+			 * To obtain the output, multiply the ADC value by the MON range (in
+			 * microvolts) and then divide it by the maximum value of the 10-bit ADC.
+			 */
+			*val = mul_u64_u32_shr(*val, ddata->mon_rng, 10);
+			/* uV to mV */
+			*val = *val / 1000;
+			return ret;
+		default:
+			return -EOPNOTSUPP;
+		}
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static umode_t max5970_is_visible(const void *data,
+				  enum hwmon_sensor_types type,
+				  u32 attr, int channel)
+{
+	struct regulator_dev **rdevs = (struct regulator_dev **)data;
+	struct max5970_regulator *ddata;
+
+	if (!rdevs || !rdevs[channel])
+		return 0;
+
+	ddata = rdev_get_drvdata(rdevs[channel]);
+
+	if (!ddata || channel >= ddata->num_switches)
+		return 0;
+
+	switch (type) {
+	case hwmon_in:
+		switch (attr) {
+		case hwmon_in_input:
+			return 0444;
+		default:
+			break;
+		}
+		break;
+	case hwmon_curr:
+		switch (attr) {
+		case hwmon_curr_input:
+			/* Current measurement requires knowledge of the shunt resistor value. */
+			if (ddata->shunt_micro_ohms)
+				return 0444;
+			break;
+		default:
+			break;
+		}
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static const struct hwmon_ops max5970_hwmon_ops = {
+	.is_visible = max5970_is_visible,
+	.read = max5970_read,
+};
+
+static const struct hwmon_channel_info *max5970_info[] = {
+	HWMON_CHANNEL_INFO(in, HWMON_I_INPUT, HWMON_I_INPUT),
+	HWMON_CHANNEL_INFO(curr, HWMON_C_INPUT, HWMON_C_INPUT),
+	NULL
+};
+
+static const struct hwmon_chip_info max5970_chip_info = {
+	.ops = &max5970_hwmon_ops,
+	.info = max5970_info,
+};
+
 static int max597x_uvp_ovp_check_mode(struct regulator_dev *rdev, int severity)
 {
 	int ret, reg;
@@ -431,7 +554,8 @@ static int max597x_regulator_probe(struct platform_device *pdev)
 	struct i2c_client *i2c = to_i2c_client(pdev->dev.parent);
 	struct regulator_config config = { };
 	struct regulator_dev *rdev;
-	struct regulator_dev *rdevs[MAX5970_NUM_SWITCHES];
+	struct regulator_dev **rdevs = NULL;
+	struct device *hwmon_dev;
 	int num_switches;
 	int ret, i;
 
@@ -451,9 +575,10 @@ static int max597x_regulator_probe(struct platform_device *pdev)
 	else
 		return -ENODEV;
 
-	i2c_set_clientdata(i2c, max597x);
 	num_switches = max597x->num_switches;
 
+	rdevs = devm_kcalloc(&i2c->dev, num_switches, sizeof(struct regulator_dev *), GFP_KERNEL);
+
 	for (i = 0; i < num_switches; i++) {
 		data =
 		    devm_kzalloc(&i2c->dev, sizeof(struct max5970_regulator),
@@ -485,6 +610,15 @@ static int max597x_regulator_probe(struct platform_device *pdev)
 		max597x->shunt_micro_ohms[i] = data->shunt_micro_ohms;
 	}
 
+	if (IS_REACHABLE(CONFIG_HWMON)) {
+		hwmon_dev = devm_hwmon_device_register_with_info(&i2c->dev, "max5970", rdevs,
+								 &max5970_chip_info, NULL);
+		if (IS_ERR(hwmon_dev)) {
+			return dev_err_probe(&i2c->dev, PTR_ERR(hwmon_dev),
+					     "Unable to register hwmon device\n");
+		}
+	}
+
 	if (i2c->irq) {
 		ret =
 		    max597x_setup_irq(&i2c->dev, i2c->irq, rdevs, num_switches,

base-commit: 41f02a383ac652f1a0b5538c5901b7ec93e37290
-- 
2.41.0

