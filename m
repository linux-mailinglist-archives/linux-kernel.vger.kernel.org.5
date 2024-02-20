Return-Path: <linux-kernel+bounces-72569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC8885B558
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A55C5281C41
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BE15D481;
	Tue, 20 Feb 2024 08:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ye4gITr9"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B046B5CDEE
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418189; cv=none; b=DJpNIhzOk8nfPlR5IN75i4sTSSnCASZaB0gfargln7YfQrYNIcRb7fFBR4rRWyPcH9Km6pOWCID73VTqlFKGhMittj7WP78EyW5Ca6Cc7I2ljR+sSioXNTur7DCtLPKxITS2KpQ3Ni4/HLWzROrztAtQBbu3KygQ4lWHHpxNR8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418189; c=relaxed/simple;
	bh=ATwedi7r0f8J9Ug8Epyk/2KLGwmag5JdWfXjjEF/N7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HXp7w1p3l2lDcHjlY5WqrrvY8pGPQmw3CQ4kR0yEGCJqHLdECbUN3+lE715BZ+ivF0IRcaeI/VM0qnykDiqbisiOxoAFlo2uWGiZjS4rhEhOrU+z/HfsppxxTTmEpIrfcysa9EU09Q3acT2P8+jOnWJUmMLHo6i+JntMgE2pYFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ye4gITr9; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d180d6bd32so55576461fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 00:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708418186; x=1709022986; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=928LPkm/7Nxxi2kK6MUa7iVBvhdKBt6BA4yDf3dLRoI=;
        b=Ye4gITr9ETUvlY65Dj19ABpg+fOaI7ss9lfWKHPElbYsAg+jmrgOTBBmVedWKcp3Vy
         4DSgU92NvYndJlQYghlo6PAgnxC5IfKD/C8Js6OjyxI0MhWcupgJHlGRknypTBo6BiKi
         G4SsPct89EDOtPOHQCJwVzHaZRtFMWmgxvbEhehrFkZCFXPSGWgCvrlCOBmZ8e/C89aV
         nfgIxcxvOKW1YfBFyBI58B3q579msExzSf+PUR4KjPqYjgmwxax7nU8oA0Ylm1JwcVqq
         nI0aX0PbCAQBodmm2gsT7xDjTnZECRFrohydQqbvhBilJEneyuGZhi5ACl2dFRcBA/lK
         a7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708418186; x=1709022986;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=928LPkm/7Nxxi2kK6MUa7iVBvhdKBt6BA4yDf3dLRoI=;
        b=cZFrV39H9QduP4Sm2NgaPWbT9rX/XjXKIcTGIp1qSyzYZjCVkTBEpDxVEZ0GcKkMxn
         BvaMoQZLSBXFnBFjIniLNeW1Vq6MI67NfEndoT6CFD9kHBszvfc4CJE3LvwXNrpiY/jW
         eDhxhPJsGaX0YnC+CzMmaSftUYHkAhdIVsaYvTRVyq58k5mqM6rOdgKKYwaJuQKVU2nl
         veknuZnm0E0+PuNoPC/JZ3XlqXIeaVz2tiUd4B1ie+hQ2BTuq2QQs87DkJRJyae66Tp7
         NbnfHgI9nZqDQBkjC2bGtLroiox9mcvMXgwG/U4KrKz4xdKZjuP5CkmAfo+8OA+vIow5
         AsyA==
X-Gm-Message-State: AOJu0YyGd8LU9D8HnBBP6tnMJMEDIqlreglf/OGvR7EkB9zXUvLg5QYV
	Q94CVoJzrxY9naMhWHPOLSSsCw1YhM86hHaQrbveN2icwPRZAvAbq3UURv8a374ATGKxU3USTAZ
	q
X-Google-Smtp-Source: AGHT+IGEzTko57/CbYT/0+7OdSYWpufjTkcphUezc23hzLEO3Y284BxrXea4FQUEOHf+yK3U8te2Ow==
X-Received: by 2002:a2e:b7ca:0:b0:2d2:36fa:dd2 with SMTP id p10-20020a2eb7ca000000b002d236fa0dd2mr3377102ljo.23.1708418185819;
        Tue, 20 Feb 2024 00:36:25 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id k1-20020a2e2401000000b002d2468d3bacsm195317ljk.9.2024.02.20.00.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 00:36:25 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 20 Feb 2024 09:36:24 +0100
Subject: [PATCH 1/5] regulator: max8973: Finalize switch to GPIO
 descriptors
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-descriptors-regulators-v1-1-097f608694be@linaro.org>
References: <20240220-descriptors-regulators-v1-0-097f608694be@linaro.org>
In-Reply-To: <20240220-descriptors-regulators-v1-0-097f608694be@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Support Opensource <support.opensource@diasemi.com>, 
 Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

The dvs gpio was still using a legacy number passed from the
platform data. There are no in-tree users of the platform data
so just switch it to a gpio descriptor and obtain it in probe(),
the device tree users will work just as fine with this.

Drop the entirely unused enable_gpio from the platform data
as well. The device tree bindings mentions this but the driver
does not look for it and makes no use of it: it should probably
be implemented properly in a separate patch.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/regulator/max8973-regulator.c       | 36 ++++++++++-------------------
 include/linux/regulator/max8973-regulator.h |  6 -----
 2 files changed, 12 insertions(+), 30 deletions(-)

diff --git a/drivers/regulator/max8973-regulator.c b/drivers/regulator/max8973-regulator.c
index 8d5193207552..f8bb6828feef 100644
--- a/drivers/regulator/max8973-regulator.c
+++ b/drivers/regulator/max8973-regulator.c
@@ -20,9 +20,7 @@
 #include <linux/regulator/machine.h>
 #include <linux/regulator/max8973-regulator.h>
 #include <linux/regulator/of_regulator.h>
-#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
-#include <linux/of_gpio.h>
 #include <linux/i2c.h>
 #include <linux/slab.h>
 #include <linux/regmap.h>
@@ -102,7 +100,7 @@ struct max8973_chip {
 	struct regulator_desc desc;
 	struct regmap *regmap;
 	bool enable_external_control;
-	int dvs_gpio;
+	struct gpio_desc *dvs_gpiod;
 	int lru_index[MAX8973_MAX_VOUT_REG];
 	int curr_vout_val[MAX8973_MAX_VOUT_REG];
 	int curr_vout_reg;
@@ -184,7 +182,7 @@ static int max8973_dcdc_set_voltage_sel(struct regulator_dev *rdev,
 	 * If gpios are available to select the VOUT register then least
 	 * recently used register for new configuration.
 	 */
-	if (gpio_is_valid(max->dvs_gpio))
+	if (max->dvs_gpiod)
 		found = find_voltage_set_register(max, vsel,
 					&vout_reg, &gpio_val);
 
@@ -201,8 +199,8 @@ static int max8973_dcdc_set_voltage_sel(struct regulator_dev *rdev,
 	}
 
 	/* Select proper VOUT register vio gpios */
-	if (gpio_is_valid(max->dvs_gpio)) {
-		gpio_set_value_cansleep(max->dvs_gpio, gpio_val & 0x1);
+	if (max->dvs_gpiod) {
+		gpiod_set_value_cansleep(max->dvs_gpiod, gpio_val & 0x1);
 		max->curr_gpio_val = gpio_val;
 	}
 	return 0;
@@ -531,7 +529,6 @@ static struct max8973_regulator_platform_data *max8973_parse_dt(
 
 	pdata->enable_ext_control = of_property_read_bool(np,
 						"maxim,externally-enable");
-	pdata->dvs_gpio = of_get_named_gpio(np, "maxim,dvs-gpio", 0);
 
 	ret = of_property_read_u32(np, "maxim,dvs-default-state", &pval);
 	if (!ret)
@@ -612,13 +609,17 @@ static int max8973_probe(struct i2c_client *client)
 		return -EIO;
 	}
 
-	if (pdata->dvs_gpio == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
-
 	max = devm_kzalloc(&client->dev, sizeof(*max), GFP_KERNEL);
 	if (!max)
 		return -ENOMEM;
 
+	max->dvs_gpiod = devm_gpiod_get_optional(&client->dev, "maxim,dvs",
+			 (pdata->dvs_def_state) ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW);
+	if (IS_ERR(max->dvs_gpiod))
+		return dev_err_probe(&client->dev, PTR_ERR(max->dvs_gpiod),
+				     "failed to obtain dvs gpio\n");
+	gpiod_set_consumer_name(max->dvs_gpiod, "max8973-dvs");
+
 	max->regmap = devm_regmap_init_i2c(client, &max8973_regmap_config);
 	if (IS_ERR(max->regmap)) {
 		ret = PTR_ERR(max->regmap);
@@ -663,7 +664,6 @@ static int max8973_probe(struct i2c_client *client)
 	max->desc.ramp_delay_table = max8973_buck_ramp_table;
 	max->desc.n_ramp_values = ARRAY_SIZE(max8973_buck_ramp_table);
 
-	max->dvs_gpio = (pdata->dvs_gpio) ? pdata->dvs_gpio : -EINVAL;
 	max->enable_external_control = pdata->enable_ext_control;
 	max->curr_gpio_val = pdata->dvs_def_state;
 	max->curr_vout_reg = MAX8973_VOUT + pdata->dvs_def_state;
@@ -671,21 +671,9 @@ static int max8973_probe(struct i2c_client *client)
 
 	max->lru_index[0] = max->curr_vout_reg;
 
-	if (gpio_is_valid(max->dvs_gpio)) {
-		int gpio_flags;
+	if (max->dvs_gpiod) {
 		int i;
 
-		gpio_flags = (pdata->dvs_def_state) ?
-				GPIOF_OUT_INIT_HIGH : GPIOF_OUT_INIT_LOW;
-		ret = devm_gpio_request_one(&client->dev, max->dvs_gpio,
-				gpio_flags, "max8973-dvs");
-		if (ret) {
-			dev_err(&client->dev,
-				"gpio_request for gpio %d failed, err = %d\n",
-				max->dvs_gpio, ret);
-			return ret;
-		}
-
 		/*
 		 * Initialize the lru index with vout_reg id
 		 * The index 0 will be most recently used and
diff --git a/include/linux/regulator/max8973-regulator.h b/include/linux/regulator/max8973-regulator.h
index 8313e7ed6aec..a225e9eeb30d 100644
--- a/include/linux/regulator/max8973-regulator.h
+++ b/include/linux/regulator/max8973-regulator.h
@@ -48,10 +48,6 @@
  *		control signal from EN input pin. If it is false then
  *		voltage output will be enabled/disabled through EN bit of
  *		device register.
- * @enable_gpio: Enable GPIO. If EN pin is controlled through GPIO from host
- *		then GPIO number can be provided. If no GPIO controlled then
- *		it should be -1.
- * @dvs_gpio: GPIO for dvs. It should be -1 if this is tied with fixed logic.
  * @dvs_def_state: Default state of dvs. 1 if it is high else 0.
  */
 struct max8973_regulator_platform_data {
@@ -59,8 +55,6 @@ struct max8973_regulator_platform_data {
 	unsigned long control_flags;
 	unsigned long junction_temp_warning;
 	bool enable_ext_control;
-	int enable_gpio;
-	int dvs_gpio;
 	unsigned dvs_def_state:1;
 };
 

-- 
2.34.1


