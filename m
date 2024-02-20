Return-Path: <linux-kernel+bounces-72572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80ED485B55B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37F1F281DD9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AB35D90B;
	Tue, 20 Feb 2024 08:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rAKHZuPU"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A545D484
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418192; cv=none; b=jzahJ8MepehO+PZrd5EJKk/2ahHcE/4ae79SBW7YN6hMpJITJgkKRUhdRTHJU9FwyDYjQ5zHFfV22b0SCsjGCNvDCLlVVd2rFiEa9NqMYDIyq8i5CPx5qUEF66joeqMIEXX+4ck6yBW5AXRjS0Bvss0PB9G96cU+lwpLOKljjaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418192; c=relaxed/simple;
	bh=h4aoiZFCXudIevMl0A7g8PBQbZQmaC+2h4xWUS34kOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tBwDubSCFwAsGFtRXCAnt711V5Z2mS7SmaLc59DyE700l8ktJG1GcYAO5E3VnUV5aNiWdTPa2eCMqIDtO2moT9gpNJB31UCz/hKcX4L1DxlPAAHxaYhQpU86EkVuWDXcDspfrBykqOBarjq14Sl+C+TNYDbNzJONs7jP2xApDiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rAKHZuPU; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d241ff062cso18374551fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 00:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708418189; x=1709022989; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0x3UN1/hSlN2X5bdmRGWv4D2ePFNha6T0KTmRcIOERc=;
        b=rAKHZuPUsjDzDKbMWBdsdarYLdjfLEaw5ngwqqzEZcJu1EaZA53zBv0vOwQwT/N478
         BZoaftHqfGEvAb49E8ViCfr/5YhkI4kT4pjbtMcKXyZhwaaVUEkVec8QPHgn6OhyUeop
         Vhh+624u4B4uMJbnBIKaAolXvFuaIcOCC1sYtmeIEh/ZHSD3hWIZ7ts3YLnYQwjYLdzj
         MsugCnWia3kC6C14KEyhIWCyzYTyerG48NTXjXFf5xkMkOZMHUNVmFruTBb8WkUjsJGh
         W7tFT0ADZXwRX54LXDvyIQI9k7Otqt0fCmR4fyltxd43ZnMVKTCiz66azFjLwBxXdBYt
         2byw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708418189; x=1709022989;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0x3UN1/hSlN2X5bdmRGWv4D2ePFNha6T0KTmRcIOERc=;
        b=RY1eZnGqUQgk3gJTQ/zX7WzV6IPbMmv3LDNhCZZBbsfetjjPYGfg5ZTf0dxT1UPjex
         i7ayGdPjnk/1m3W9NbUxFc0hmAmfyiHOQoC5tNMkwNjJdKjW7lsBfr0Kk4HUOmtFsWAO
         rZDV1f3MMksG2Dw02kMbcVRfNUlevlOxb/r0K73hg7wER4CUdTH1MK2vC0hjnREEuJuH
         MXoP8bovu0SpQW5bAFJ1sUiY35+ZJBjA1HxaiqNxHG1nUSkiJBlV7MEW0ve0x6cJ4a2Y
         YZwlrjo1ZUfpfDM4etzCGDPKo9kWtMLCjw08c9/G32ojOEy71WwqcMDpMY/mYucXReos
         K5Pw==
X-Gm-Message-State: AOJu0YxUZHFfNSsazTZcFP4NUwstx1nY0mVJn7QzY2umH4fZ7G7uZokC
	Q9GzjlWp0lS0AR+ydz2h1CfRodA83/WDoEUx25MktPBAl2faYrRotb8k54ugYZ4=
X-Google-Smtp-Source: AGHT+IF867X7wicD/0oa1lFq1WdKSaHCDVDSDl8tlzE9PS+fooQaoF6Cl07iQZ/izJ10SLPuOjEjhg==
X-Received: by 2002:a2e:8716:0:b0:2d2:39dc:ada1 with SMTP id m22-20020a2e8716000000b002d239dcada1mr2978992lji.15.1708418188869;
        Tue, 20 Feb 2024 00:36:28 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id k1-20020a2e2401000000b002d2468d3bacsm195317ljk.9.2024.02.20.00.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 00:36:28 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 20 Feb 2024 09:36:27 +0100
Subject: [PATCH 4/5] regulator: max8997: Convert to GPIO descriptors
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-descriptors-regulators-v1-4-097f608694be@linaro.org>
References: <20240220-descriptors-regulators-v1-0-097f608694be@linaro.org>
In-Reply-To: <20240220-descriptors-regulators-v1-0-097f608694be@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Support Opensource <support.opensource@diasemi.com>, 
 Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

This rewrites the max8997 regulator driver to fetch the dvs
regulators as descriptors. This will likely mostly come from
the device tree since there are no in-tree users of the platform
data, but supplying GPIO descriptor tables from board files is
also possible if needed.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/regulator/max8997-regulator.c | 85 +++++++++++------------------------
 include/linux/mfd/max8997.h           |  1 -
 2 files changed, 25 insertions(+), 61 deletions(-)

diff --git a/drivers/regulator/max8997-regulator.c b/drivers/regulator/max8997-regulator.c
index 0b38eaa73597..5f201ee9a5b8 100644
--- a/drivers/regulator/max8997-regulator.c
+++ b/drivers/regulator/max8997-regulator.c
@@ -9,8 +9,7 @@
 
 #include <linux/bug.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
-#include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -32,7 +31,7 @@ struct max8997_data {
 	u8 buck1_vol[8];
 	u8 buck2_vol[8];
 	u8 buck5_vol[8];
-	int buck125_gpios[3];
+	struct gpio_desc *buck125_gpiods[3];
 	int buck125_gpioindex;
 	bool ignore_gpiodvs_side_effect;
 
@@ -52,9 +51,9 @@ static inline void max8997_set_gpio(struct max8997_data *max8997)
 	int set2 = ((max8997->buck125_gpioindex) >> 1) & 0x1;
 	int set1 = ((max8997->buck125_gpioindex) >> 2) & 0x1;
 
-	gpio_set_value(max8997->buck125_gpios[0], set1);
-	gpio_set_value(max8997->buck125_gpios[1], set2);
-	gpio_set_value(max8997->buck125_gpios[2], set3);
+	gpiod_set_value(max8997->buck125_gpiods[0], set1);
+	gpiod_set_value(max8997->buck125_gpiods[1], set2);
+	gpiod_set_value(max8997->buck125_gpiods[2], set3);
 }
 
 struct voltage_map_desc {
@@ -873,31 +872,13 @@ static struct regulator_desc regulators[] = {
 };
 
 #ifdef CONFIG_OF
-static int max8997_pmic_dt_parse_dvs_gpio(struct platform_device *pdev,
-			struct max8997_platform_data *pdata,
-			struct device_node *pmic_np)
-{
-	int i, gpio;
-
-	for (i = 0; i < 3; i++) {
-		gpio = of_get_named_gpio(pmic_np,
-					"max8997,pmic-buck125-dvs-gpios", i);
-		if (!gpio_is_valid(gpio)) {
-			dev_err(&pdev->dev, "invalid gpio[%d]: %d\n", i, gpio);
-			return -EINVAL;
-		}
-		pdata->buck125_gpios[i] = gpio;
-	}
-	return 0;
-}
-
 static int max8997_pmic_dt_parse_pdata(struct platform_device *pdev,
 					struct max8997_platform_data *pdata)
 {
 	struct max8997_dev *iodev = dev_get_drvdata(pdev->dev.parent);
 	struct device_node *pmic_np, *regulators_np, *reg_np;
 	struct max8997_regulator_data *rdata;
-	unsigned int i, dvs_voltage_nr = 1, ret;
+	unsigned int i, dvs_voltage_nr = 1;
 
 	pmic_np = iodev->dev->of_node;
 	if (!pmic_np) {
@@ -949,10 +930,6 @@ static int max8997_pmic_dt_parse_pdata(struct platform_device *pdev,
 
 	if (pdata->buck1_gpiodvs || pdata->buck2_gpiodvs ||
 						pdata->buck5_gpiodvs) {
-		ret = max8997_pmic_dt_parse_dvs_gpio(pdev, pdata, pmic_np);
-		if (ret)
-			return -EINVAL;
-
 		if (of_property_read_u32(pmic_np,
 				"max8997,pmic-buck125-default-dvs-idx",
 				&pdata->buck125_default_idx)) {
@@ -1039,7 +1016,6 @@ static int max8997_pmic_probe(struct platform_device *pdev)
 	max8997->buck1_gpiodvs = pdata->buck1_gpiodvs;
 	max8997->buck2_gpiodvs = pdata->buck2_gpiodvs;
 	max8997->buck5_gpiodvs = pdata->buck5_gpiodvs;
-	memcpy(max8997->buck125_gpios, pdata->buck125_gpios, sizeof(int) * 3);
 	max8997->ignore_gpiodvs_side_effect = pdata->ignore_gpiodvs_side_effect;
 
 	nr_dvs = (pdata->buck1_gpiodvs || pdata->buck2_gpiodvs ||
@@ -1110,38 +1086,27 @@ static int max8997_pmic_probe(struct platform_device *pdev)
 	 */
 	if (pdata->buck1_gpiodvs || pdata->buck2_gpiodvs ||
 			pdata->buck5_gpiodvs) {
+		const char *gpio_names[3] = {"MAX8997 SET1", "MAX8997 SET2", "MAX8997 SET3"};
 
-		if (!gpio_is_valid(pdata->buck125_gpios[0]) ||
-				!gpio_is_valid(pdata->buck125_gpios[1]) ||
-				!gpio_is_valid(pdata->buck125_gpios[2])) {
-			dev_err(&pdev->dev, "GPIO NOT VALID\n");
-			return -EINVAL;
-		}
+		for (i = 0; i < 3; i++) {
+			enum gpiod_flags flags;
 
-		ret = devm_gpio_request(&pdev->dev, pdata->buck125_gpios[0],
-					"MAX8997 SET1");
-		if (ret)
-			return ret;
-
-		ret = devm_gpio_request(&pdev->dev, pdata->buck125_gpios[1],
-					"MAX8997 SET2");
-		if (ret)
-			return ret;
-
-		ret = devm_gpio_request(&pdev->dev, pdata->buck125_gpios[2],
-				"MAX8997 SET3");
-		if (ret)
-			return ret;
-
-		gpio_direction_output(pdata->buck125_gpios[0],
-				(max8997->buck125_gpioindex >> 2)
-				& 0x1); /* SET1 */
-		gpio_direction_output(pdata->buck125_gpios[1],
-				(max8997->buck125_gpioindex >> 1)
-				& 0x1); /* SET2 */
-		gpio_direction_output(pdata->buck125_gpios[2],
-				(max8997->buck125_gpioindex >> 0)
-				& 0x1); /* SET3 */
+			if (max8997->buck125_gpioindex & BIT(2 - i))
+				flags = GPIOD_OUT_HIGH;
+			else
+				flags = GPIOD_OUT_LOW;
+
+			max8997->buck125_gpiods[i] = devm_gpiod_get_index(iodev->dev,
+									  "max8997,pmic-buck125-dvs",
+									  i,
+									  flags);
+			if (IS_ERR(max8997->buck125_gpiods[i])) {
+				ret = PTR_ERR(max8997->buck125_gpiods[i]);
+				return dev_err_probe(iodev->dev, ret, "cant get GPIO %d (%d)\n",
+						     i, ret);
+			}
+			gpiod_set_consumer_name(max8997->buck125_gpiods[i], gpio_names[i]);
+		}
 	}
 
 	/* DVS-GPIO disabled */
diff --git a/include/linux/mfd/max8997.h b/include/linux/mfd/max8997.h
index 6193905abbb5..5c2cc1103437 100644
--- a/include/linux/mfd/max8997.h
+++ b/include/linux/mfd/max8997.h
@@ -178,7 +178,6 @@ struct max8997_platform_data {
 	 *
 	 */
 	bool ignore_gpiodvs_side_effect;
-	int buck125_gpios[3]; /* GPIO of [0]SET1, [1]SET2, [2]SET3 */
 	int buck125_default_idx; /* Default value of SET1, 2, 3 */
 	unsigned int buck1_voltage[8]; /* buckx_voltage in uV */
 	bool buck1_gpiodvs;

-- 
2.34.1


