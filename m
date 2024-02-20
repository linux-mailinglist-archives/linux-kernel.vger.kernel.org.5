Return-Path: <linux-kernel+bounces-72573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F0485B55D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A854E281A98
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D917F5F463;
	Tue, 20 Feb 2024 08:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="khJdv0r1"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B085D734
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418193; cv=none; b=AlHqxhIf16/DRjzODn2gLF0oCq9rHE1otJZqJPMOJQrEP+icDcUhyoGA7kj71c9D33RenB5kTWJhqyHoQB6hpw925WV0SI7Iz3nZD1aufMwnQzbST8j3zDxueTM6LONDPRIRhXljJDKdraQmoMwbdYfaxgYRilTExSn4yUoYBkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418193; c=relaxed/simple;
	bh=fyH53ptZ4KyW3Du56DUQ5YuVOX6CkzmPU/Yac+/WEZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kco7AjnNJyJMg7x5+pAq29A6APQz7erF3CefOKKuiAcvuM+HTa7koFlbhf2wWsJNiMsnBZoDpPj4Avztt5FxsDlCC1qedtkaSafeCZ8QV+pCjeoJ/3utN+HPd6o459WO4DnSP63HKj3Ms4rbp/GqKfs0h1Qw+mrBrmt7itrW3lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=khJdv0r1; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d208d0b282so69034541fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 00:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708418190; x=1709022990; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uE6eEEsx/5e/WVNE54y1IYM2rczvEuy341hCQZHsSiQ=;
        b=khJdv0r1Rg/wr4Nvatxr1VRAndM5tulqZuNlda7jAL4Ivz+zXwf8aDX16pss5pI2rQ
         xGuzI3K2n9SmffzLEO95JOgRULFUB4pMWxW7DAVG5Nz7c62ZPZsO7j8FwqRMAqauXCxS
         yz8uc2HuEz02Q5XN/jKKcPAuiGfmbuuMvtWKRPj5Z8hSHsHQfCHFTde+ILrE63dNkpct
         Txh9p7vddFZSm3CWoOBYiAWsXlZWMDG1QWgAe7JE2Wi4faMGRqCYAy9strq3G7xh0JoD
         PXOXJaea3GsdQFJ+mI1BOItxrwH8ld29mkpOIfcJNpvwPs0MtI43jnbszP8f+I6OWDOV
         8n6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708418190; x=1709022990;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uE6eEEsx/5e/WVNE54y1IYM2rczvEuy341hCQZHsSiQ=;
        b=koN8Y5g9MH8y+RZtHiWBT7bIUrAKbTIUrvPiL2MQukWru4HLQxEuTwAsvS7cL/sqSP
         8kmZy/wXBtBeuuXTM60xlmaweYuEn9sD+zajv1YEYne4k37qKr5j91OIoneKwLaJbx2o
         p4MXkuz/9LWZGdFmghPz5mNNhsQ9kj61wWxflq90UqNfVeDjv5BG+Ljzf8n0K2Nbpl44
         +RS/KgHVQwOgf87dniQ/1oq33asi+ohDpAak0WARQqfS+Z+fjGpL7I0fHhEHZXntjyX/
         ICMWILm7t/yZ1sGtsJQMJU9P85VbBMpV2lCY04C4nBW8fmU0tnNOtcAGuSKNgQKdoUX1
         2nog==
X-Gm-Message-State: AOJu0YxBcrvkKZLmC6yCmWs9DX8NLJI96yWG3G1YV72do5HM65Sl/M4f
	nlHtbtDFvkTXYRvdDJDyIdj/b9bwDym6y8O3DiOFYWf7/um0i+a1Yj5zpBXA5Yc=
X-Google-Smtp-Source: AGHT+IFt4+GEvYfZ6QgN4I1TuvjUDUz6uxByLlTmCvH4C6f885cQ4L8QOkUTkVAbp7NqvjsECSwM5w==
X-Received: by 2002:a05:651c:1423:b0:2d2:3978:a11 with SMTP id u35-20020a05651c142300b002d239780a11mr3449620lje.36.1708418189760;
        Tue, 20 Feb 2024 00:36:29 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id k1-20020a2e2401000000b002d2468d3bacsm195317ljk.9.2024.02.20.00.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 00:36:29 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 20 Feb 2024 09:36:28 +0100
Subject: [PATCH 5/5] regulator: max8998: Convert to GPIO descriptors
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-descriptors-regulators-v1-5-097f608694be@linaro.org>
References: <20240220-descriptors-regulators-v1-0-097f608694be@linaro.org>
In-Reply-To: <20240220-descriptors-regulators-v1-0-097f608694be@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Support Opensource <support.opensource@diasemi.com>, 
 Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

This rewrites the max8998 regulator driver to fetch the dvs
regulators as descriptors. This will likely mostly come from
the device tree since there are no in-tree users of the platform
data, but supplying GPIO descriptor tables from board files is
also possible if needed.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/regulator/max8998.c | 150 ++++++++++++++++----------------------------
 include/linux/mfd/max8998.h |   6 --
 2 files changed, 54 insertions(+), 102 deletions(-)

diff --git a/drivers/regulator/max8998.c b/drivers/regulator/max8998.c
index fadb4717384a..254a77887f66 100644
--- a/drivers/regulator/max8998.c
+++ b/drivers/regulator/max8998.c
@@ -10,12 +10,12 @@
 #include <linux/init.h>
 #include <linux/i2c.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
+#include <linux/bits.h>
+#include <linux/gpio/consumer.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/of_regulator.h>
@@ -31,6 +31,9 @@ struct max8998_data {
 	unsigned int		buck1_idx; /* index to last changed voltage */
 					   /* value in a set */
 	unsigned int		buck2_idx;
+	struct gpio_desc	*buck1_gpio1;
+	struct gpio_desc	*buck1_gpio2;
+	struct gpio_desc	*buck2_gpio;
 };
 
 static const unsigned int charger_current_table[] = {
@@ -227,15 +230,15 @@ static int max8998_set_voltage_ldo_sel(struct regulator_dev *rdev,
 	return ret;
 }
 
-static inline void buck1_gpio_set(int gpio1, int gpio2, int v)
+static inline void buck1_gpio_set(struct gpio_desc *gpio1, struct gpio_desc *gpio2, int v)
 {
-	gpio_set_value(gpio1, v & 0x1);
-	gpio_set_value(gpio2, (v >> 1) & 0x1);
+	gpiod_set_value(gpio1, v & 0x1);
+	gpiod_set_value(gpio2, (v >> 1) & 0x1);
 }
 
-static inline void buck2_gpio_set(int gpio, int v)
+static inline void buck2_gpio_set(struct gpio_desc *gpio, int v)
 {
-	gpio_set_value(gpio, v & 0x1);
+	gpiod_set_value(gpio, v & 0x1);
 }
 
 static int max8998_set_voltage_buck_sel(struct regulator_dev *rdev,
@@ -260,16 +263,15 @@ static int max8998_set_voltage_buck_sel(struct regulator_dev *rdev,
 			selector, max8998->buck1_vol[0], max8998->buck1_vol[1],
 			max8998->buck1_vol[2], max8998->buck1_vol[3]);
 
-		if (gpio_is_valid(pdata->buck1_set1) &&
-		    gpio_is_valid(pdata->buck1_set2)) {
+		if (max8998->buck1_gpio1 && max8998->buck1_gpio2) {
 
 			/* check if requested voltage */
 			/* value is already defined */
 			for (j = 0; j < ARRAY_SIZE(max8998->buck1_vol); j++) {
 				if (max8998->buck1_vol[j] == selector) {
 					max8998->buck1_idx = j;
-					buck1_gpio_set(pdata->buck1_set1,
-						       pdata->buck1_set2, j);
+					buck1_gpio_set(max8998->buck1_gpio1,
+						       max8998->buck1_gpio2, j);
 					goto buck1_exit;
 				}
 			}
@@ -286,13 +288,13 @@ static int max8998_set_voltage_buck_sel(struct regulator_dev *rdev,
 							   &shift,
 							   &mask);
 			ret = max8998_write_reg(i2c, reg, selector);
-			buck1_gpio_set(pdata->buck1_set1,
-				       pdata->buck1_set2, max8998->buck1_idx);
+			buck1_gpio_set(max8998->buck1_gpio1,
+				       max8998->buck1_gpio2, max8998->buck1_idx);
 			buck1_last_val++;
 buck1_exit:
 			dev_dbg(max8998->dev, "%s: SET1:%d, SET2:%d\n",
-				i2c->name, gpio_get_value(pdata->buck1_set1),
-				gpio_get_value(pdata->buck1_set2));
+				i2c->name, gpiod_get_value(max8998->buck1_gpio1),
+				gpiod_get_value(max8998->buck1_gpio2));
 			break;
 		} else {
 			ret = max8998_write_reg(i2c, reg, selector);
@@ -303,14 +305,13 @@ static int max8998_set_voltage_buck_sel(struct regulator_dev *rdev,
 		dev_dbg(max8998->dev,
 			"BUCK2, selector:%d buck2_vol1:%d, buck2_vol2:%d\n",
 			selector, max8998->buck2_vol[0], max8998->buck2_vol[1]);
-		if (gpio_is_valid(pdata->buck2_set3)) {
-
+		if (max8998->buck2_gpio) {
 			/* check if requested voltage */
 			/* value is already defined */
 			for (j = 0; j < ARRAY_SIZE(max8998->buck2_vol); j++) {
 				if (max8998->buck2_vol[j] == selector) {
 					max8998->buck2_idx = j;
-					buck2_gpio_set(pdata->buck2_set3, j);
+					buck2_gpio_set(max8998->buck2_gpio, j);
 					goto buck2_exit;
 				}
 			}
@@ -322,10 +323,10 @@ static int max8998_set_voltage_buck_sel(struct regulator_dev *rdev,
 					&reg, &shift, &mask);
 			ret = max8998_write_reg(i2c, reg, selector);
 			max8998->buck2_vol[max8998->buck2_idx] = selector;
-			buck2_gpio_set(pdata->buck2_set3, max8998->buck2_idx);
+			buck2_gpio_set(max8998->buck2_gpio, max8998->buck2_idx);
 buck2_exit:
 			dev_dbg(max8998->dev, "%s: SET3:%d\n", i2c->name,
-				gpio_get_value(pdata->buck2_set3));
+				gpiod_get_value(max8998->buck2_gpio));
 		} else {
 			ret = max8998_write_reg(i2c, reg, selector);
 		}
@@ -539,36 +540,6 @@ static const struct regulator_desc regulators[] = {
 			    charger_current_table, MAX8998_REG_CHGR1, 0x7),
 };
 
-static int max8998_pmic_dt_parse_dvs_gpio(struct max8998_dev *iodev,
-			struct max8998_platform_data *pdata,
-			struct device_node *pmic_np)
-{
-	int gpio;
-
-	gpio = of_get_named_gpio(pmic_np, "max8998,pmic-buck1-dvs-gpios", 0);
-	if (!gpio_is_valid(gpio)) {
-		dev_err(iodev->dev, "invalid buck1 gpio[0]: %d\n", gpio);
-		return -EINVAL;
-	}
-	pdata->buck1_set1 = gpio;
-
-	gpio = of_get_named_gpio(pmic_np, "max8998,pmic-buck1-dvs-gpios", 1);
-	if (!gpio_is_valid(gpio)) {
-		dev_err(iodev->dev, "invalid buck1 gpio[1]: %d\n", gpio);
-		return -EINVAL;
-	}
-	pdata->buck1_set2 = gpio;
-
-	gpio = of_get_named_gpio(pmic_np, "max8998,pmic-buck2-dvs-gpio", 0);
-	if (!gpio_is_valid(gpio)) {
-		dev_err(iodev->dev, "invalid buck 2 gpio: %d\n", gpio);
-		return -EINVAL;
-	}
-	pdata->buck2_set3 = gpio;
-
-	return 0;
-}
-
 static int max8998_pmic_dt_parse_pdata(struct max8998_dev *iodev,
 					struct max8998_platform_data *pdata)
 {
@@ -614,10 +585,6 @@ static int max8998_pmic_dt_parse_pdata(struct max8998_dev *iodev,
 	of_node_put(reg_np);
 	of_node_put(regulators_np);
 
-	ret = max8998_pmic_dt_parse_dvs_gpio(iodev, pdata, pmic_np);
-	if (ret)
-		return -EINVAL;
-
 	pdata->buck_voltage_lock = of_property_read_bool(pmic_np, "max8998,pmic-buck-voltage-lock");
 
 	ret = of_property_read_u32(pmic_np,
@@ -665,6 +632,7 @@ static int max8998_pmic_probe(struct platform_device *pdev)
 	struct regulator_dev *rdev;
 	struct max8998_data *max8998;
 	struct i2c_client *i2c;
+	enum gpiod_flags flags;
 	int i, ret;
 	unsigned int v;
 
@@ -693,37 +661,38 @@ static int max8998_pmic_probe(struct platform_device *pdev)
 	max8998->buck1_idx = pdata->buck1_default_idx;
 	max8998->buck2_idx = pdata->buck2_default_idx;
 
-	/* NOTE: */
-	/* For unused GPIO NOT marked as -1 (thereof equal to 0)  WARN_ON */
-	/* will be displayed */
-
 	/* Check if MAX8998 voltage selection GPIOs are defined */
-	if (gpio_is_valid(pdata->buck1_set1) &&
-	    gpio_is_valid(pdata->buck1_set2)) {
-		/* Check if SET1 is not equal to 0 */
-		if (!pdata->buck1_set1) {
-			dev_err(&pdev->dev,
-				"MAX8998 SET1 GPIO defined as 0 !\n");
-			WARN_ON(!pdata->buck1_set1);
-			return -EIO;
-		}
-		/* Check if SET2 is not equal to 0 */
-		if (!pdata->buck1_set2) {
-			dev_err(&pdev->dev,
-				"MAX8998 SET2 GPIO defined as 0 !\n");
-			WARN_ON(!pdata->buck1_set2);
-			return -EIO;
-		}
-
-		gpio_request(pdata->buck1_set1, "MAX8998 BUCK1_SET1");
-		gpio_direction_output(pdata->buck1_set1,
-				      max8998->buck1_idx & 0x1);
-
-
-		gpio_request(pdata->buck1_set2, "MAX8998 BUCK1_SET2");
-		gpio_direction_output(pdata->buck1_set2,
-				      (max8998->buck1_idx >> 1) & 0x1);
-
+	flags = (max8998->buck1_idx & BIT(0)) ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
+	max8998->buck1_gpio1 = devm_gpiod_get_index_optional(iodev->dev,
+							     "max8998,pmic-buck1-dvs",
+							     0,
+							     flags);
+	if (IS_ERR(max8998->buck1_gpio1))
+		return dev_err_probe(&pdev->dev, PTR_ERR(max8998->buck1_gpio1),
+				     "could not get BUCK1 GPIO1\n");
+	gpiod_set_consumer_name(max8998->buck1_gpio1, "MAX8998 BUCK1_SET1");
+
+	flags = (max8998->buck1_idx & BIT(1)) ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
+	max8998->buck1_gpio2 = devm_gpiod_get_index_optional(iodev->dev,
+							     "max8998,pmic-buck1-dvs",
+							     1,
+							     flags);
+	if (IS_ERR(max8998->buck1_gpio2))
+		return dev_err_probe(&pdev->dev, PTR_ERR(max8998->buck1_gpio2),
+				     "could not get BUCK1 GPIO2\n");
+	gpiod_set_consumer_name(max8998->buck1_gpio1, "MAX8998 BUCK1_SET2");
+
+	flags = (max8998->buck2_idx & BIT(0)) ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
+	max8998->buck2_gpio = devm_gpiod_get_index_optional(iodev->dev,
+							     "max8998,pmic-buck2-dvs",
+							     0,
+							     flags);
+	if (IS_ERR(max8998->buck2_gpio))
+		return dev_err_probe(&pdev->dev, PTR_ERR(max8998->buck2_gpio),
+				     "could not get BUCK2 GPIO\n");
+	gpiod_set_consumer_name(max8998->buck1_gpio1, "MAX8998 BUCK2_SET3");
+
+	if (max8998->buck1_gpio1 && max8998->buck1_gpio2) {
 		/* Set predefined values for BUCK1 registers */
 		for (v = 0; v < ARRAY_SIZE(pdata->buck1_voltage); ++v) {
 			int index = MAX8998_BUCK1 - MAX8998_LDO2;
@@ -742,18 +711,7 @@ static int max8998_pmic_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (gpio_is_valid(pdata->buck2_set3)) {
-		/* Check if SET3 is not equal to 0 */
-		if (!pdata->buck2_set3) {
-			dev_err(&pdev->dev,
-				"MAX8998 SET3 GPIO defined as 0 !\n");
-			WARN_ON(!pdata->buck2_set3);
-			return -EIO;
-		}
-		gpio_request(pdata->buck2_set3, "MAX8998 BUCK2_SET3");
-		gpio_direction_output(pdata->buck2_set3,
-				      max8998->buck2_idx & 0x1);
-
+	if (max8998->buck2_gpio) {
 		/* Set predefined values for BUCK2 registers */
 		for (v = 0; v < ARRAY_SIZE(pdata->buck2_voltage); ++v) {
 			int index = MAX8998_BUCK2 - MAX8998_LDO2;
diff --git a/include/linux/mfd/max8998.h b/include/linux/mfd/max8998.h
index 79c020bd0c70..a054e55c8646 100644
--- a/include/linux/mfd/max8998.h
+++ b/include/linux/mfd/max8998.h
@@ -65,10 +65,7 @@ struct max8998_regulator_data {
  *   be other than the preset values.
  * @buck1_voltage: BUCK1 DVS mode 1 voltage registers
  * @buck2_voltage: BUCK2 DVS mode 2 voltage registers
- * @buck1_set1: BUCK1 gpio pin 1 to set output voltage
- * @buck1_set2: BUCK1 gpio pin 2 to set output voltage
  * @buck1_default_idx: Default for BUCK1 gpio pin 1, 2
- * @buck2_set3: BUCK2 gpio pin to set output voltage
  * @buck2_default_idx: Default for BUCK2 gpio pin.
  * @wakeup: Allow to wake up from suspend
  * @rtc_delay: LP3974 RTC chip bug that requires delay after a register
@@ -91,10 +88,7 @@ struct max8998_platform_data {
 	bool				buck_voltage_lock;
 	int				buck1_voltage[4];
 	int				buck2_voltage[2];
-	int				buck1_set1;
-	int				buck1_set2;
 	int				buck1_default_idx;
-	int				buck2_set3;
 	int				buck2_default_idx;
 	bool				wakeup;
 	bool				rtc_delay;

-- 
2.34.1


