Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1801379B217
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346994AbjIKVYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236868AbjIKLhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 07:37:02 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966C4CE5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 04:36:54 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-402cc6b8bedso49232005e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 04:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1694432213; x=1695037013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OMQTJ2avPAKOBj81L2n0sYev5R3medPyh0K0RXca3p0=;
        b=PTYJHqAYoa3zmoJVZsDKCbHaHVNlcyWDv8yUxU/BhhD0TAviU++aBkj+ECilXfTRSf
         hUO29WNVWIQ2mUeJErzCXqm/r0uDc3ID4EIuwz+p/G+4L+9Z39W1tcatT0Si7dowRRlf
         UiZTR7oBln8zMpuimFCFjM/bfTytwFogy9qFrxebCmfJ2G4b8N1iRMRoWElk5bXZR6Nk
         rJjB5wt4XvJdNo1IxGDWUQ8rfAyVTrj6+WOWWV5Jd275aKS+9cEzVcvKQD93AEhjSA2g
         JuEFV6tQVdjBS6y84z0tNNfvn8PPhGlGcLBukKIPL3Tneet/cn2bkcPjqYZZOUK/LOCS
         1WhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694432213; x=1695037013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OMQTJ2avPAKOBj81L2n0sYev5R3medPyh0K0RXca3p0=;
        b=FCnpN2eLs37G5HJfTFq5+90jwfy9jMY8Gn5p2ZVcYP5OUcRibgoFHWGGw8tn3eI9Q1
         +Sf4hn/Buti0WZRPz4knKTnCtaFNENthnBqEhLVP1dK3gXCcYUKG12aYrO3UD9kUFAfk
         lDAACydmaF4WQQZMvPFhKAzDnG7VS3mjmxAv3R3xUUxfYomWbdyNsP0IUo7Flxo4S5qw
         /deNOOdnxU2gFPd9hSuv1weiQkAyBp17ESN1t2kvXNKU8xL9zSE+ml4+K2fJrY2bC0YQ
         sdOYBsOJhKwjAzuu3RShkvVOKTBqxyX6MEnKh4hQL9AOKsd1n6nyR7dE3fqaWuSRrv5h
         2GwA==
X-Gm-Message-State: AOJu0Yy/fdy3/UjxqZPHAM+uMZw6nDq3M4Jh3SL6iwqevQFO+62RSqLl
        EwHXz69UDD0AUCAB5zo8VZSVrz4cNuZ/6fjngrA=
X-Google-Smtp-Source: AGHT+IGwJskSzGezWEMZKE95Q6Tlo7aQiYAaepY1c2f4YkkiluxN2azbeo9fbI3Cqjmqdnjfr37BEQ==
X-Received: by 2002:a1c:4b03:0:b0:401:264b:5df7 with SMTP id y3-20020a1c4b03000000b00401264b5df7mr8373335wma.35.1694432212831;
        Mon, 11 Sep 2023 04:36:52 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id e10-20020adf9bca000000b003143cb109d5sm7418185wrc.14.2023.09.11.04.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 04:36:52 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
To:     broonie@kernel.org, zev@bewilderbeest.net,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Naresh Solanki <naresh.solanki@9elements.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: [PATCH v3] regulator (max5970): Add hwmon support
Date:   Mon, 11 Sep 2023 13:36:47 +0200
Message-ID: <20230911113647.1259204-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Changes in V3:
- Update signed-off
- Add break
- Update hwmon dev register name to max5970
- Remove changes in Kconfig.
Changes in V2:
- default case added for switch statement
- Add dependency on HWMON
---
 drivers/regulator/max5970-regulator.c | 126 ++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/drivers/regulator/max5970-regulator.c b/drivers/regulator/max5970-regulator.c
index b56a174cde3d..208de66c0928 100644
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
@@ -32,6 +33,121 @@ enum max597x_regulator_id {
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
+	struct max5970_data *ddata = dev_get_drvdata(dev);
+	struct regmap *regmap = dev_get_regmap(dev->parent, NULL);
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
+			*val = (*val * ddata->irng[channel]) >> 10;
+			/* Convert the voltage meansurement across shunt resistor to current */
+			*val = (*val * 1000) / ddata->shunt_micro_ohms[channel];
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
+			*val = mul_u64_u32_shr(*val, ddata->mon_rng[channel], 10);
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
+	struct max5970_data *ddata = (struct max5970_data *)data;
+
+	if (channel >= ddata->num_switches)
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
+			if (ddata->shunt_micro_ohms[channel])
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
@@ -432,6 +548,7 @@ static int max597x_regulator_probe(struct platform_device *pdev)
 	struct regulator_config config = { };
 	struct regulator_dev *rdev;
 	struct regulator_dev *rdevs[MAX5970_NUM_SWITCHES];
+	struct device *hwmon_dev;
 	int num_switches;
 	int ret, i;
 
@@ -485,6 +602,15 @@ static int max597x_regulator_probe(struct platform_device *pdev)
 		max597x->shunt_micro_ohms[i] = data->shunt_micro_ohms;
 	}
 
+	if (IS_ENABLED(CONFIG_HWMON)) {
+		hwmon_dev = devm_hwmon_device_register_with_info(&i2c->dev, "max5970", max597x,
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

