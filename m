Return-Path: <linux-kernel+bounces-72571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F7385B55A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58DE81C210DC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F60C5D75A;
	Tue, 20 Feb 2024 08:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r+bCQ0Ie"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7525D464
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418191; cv=none; b=Jp0OankRUIiQ/L/4mKgD3A3iQgHlUf0X8JLJDpH7h2601CKh59h8W/rzED+QndnsNq0edgHDm0RU9/WQNA3R2Fz4V9HiCcBGizNFjUmd9XpaBpul5r6B70v9Wb9cZYuEDNhnSZ51M98x1MglkgSJbv+kNA5NCq1+/uSR+DIowEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418191; c=relaxed/simple;
	bh=6Gz51bBXN6Q8boWrX2GQVXiS/ekJ2yeDalfCuLeQcy0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BETeOmx3narAS3s8NYgNQKJ14Bg7pOIxiFBqVyfkprVWnHf2191iaS54oXpA/aCwF+ouBmBfJObJKqAwoTrH/IIeKboSRK8+SPYAEqYo1/PkNQPdZVVfyly8nEcuu4N5gnrDyoiCcB1z2DbT5f2qZYZHoc/fJhGFdDbE8nKsGMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r+bCQ0Ie; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d220e39907so50657061fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 00:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708418188; x=1709022988; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SZGKzH/426CN3opzPjYcCV0wzHXep85KgnBvxUchGh8=;
        b=r+bCQ0Ieb9atk9w1QNme+6RsGpRgEFD8Gcz4hHHMH72vNqqRga+/ns+Ra16j9z8U9T
         DodDTE3SXgjeZnhm6Fny+dKPVgD9CY+2dexvj1Y1RCUS5P6hFnhyc/jrBumzw1Tfr/xr
         lfv/bNfeqRZr22W1qLDUif4X0KPDnkFW1vWxUHuAlvuXK+tvcEFEIss1zvQfHLeoJsa9
         lTqsSguobYLLPojvtJx7PwDVKA+hR3Rc/0EeBtb7wwd/R+lMxSjrwiSeYUIugQJPD371
         yHrZLps0/FM5KNAnpY1lSd/vHsICdgJ/0+5W0s8oBm4CxmLqxd3ReGH2xV7AEsYIt0+r
         XCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708418188; x=1709022988;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZGKzH/426CN3opzPjYcCV0wzHXep85KgnBvxUchGh8=;
        b=ncOF3Q7ZVWPhf/tQCOwlTdDLpc4dRrn1tVjhxWpTBObeGruG4QKQQYDsDawHx13144
         FVWjvIEpdhgVclMFWpbk/XgMyVsIV42YqwYWexqv4r1+WhpBJUVfZhsMZAc9E0KfZ4/Q
         nK4P6rbEF8Wzii0T5E4T2WGYPFQfEgQOMnCmry8if8/JhH1hWjd9SKYQHv9snUNDgCgx
         xmW/VLDPON7ZZOpGAbuQctMmQlyYpgRnjOozanGAXgLG3V+mwAuOVz5X0cTMRlPfWOgY
         slnrx4Ll5SJx8pckcT7dzESWSBJKirIkkQOOPe8YTePp8b6qxTDkZBvOHryiY26p5KZb
         /Jew==
X-Gm-Message-State: AOJu0YzF60NjbH+aAD0N789Aks8n3gfZRJqfwyXLqRiQREgvaUC7SRzS
	8NsC1IEEq/wcZQEHlXpZY2Pd1OeMq9MUOikMuo0nsDCmnzjnw5lCIGjpkhIWAfs=
X-Google-Smtp-Source: AGHT+IGBglYYVqTTbg9LEcR3IzHE27rB4USlrxalsneTmdX7jGssr7/St4LulJKZdu3Jz9GEXsn2Sg==
X-Received: by 2002:a2e:3318:0:b0:2d2:426b:455c with SMTP id d24-20020a2e3318000000b002d2426b455cmr3262023ljc.0.1708418187964;
        Tue, 20 Feb 2024 00:36:27 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id k1-20020a2e2401000000b002d2468d3bacsm195317ljk.9.2024.02.20.00.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 00:36:27 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 20 Feb 2024 09:36:26 +0100
Subject: [PATCH 3/5] regulator: lp8788-buck: Fully convert to GPIO
 descriptors
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-descriptors-regulators-v1-3-097f608694be@linaro.org>
References: <20240220-descriptors-regulators-v1-0-097f608694be@linaro.org>
In-Reply-To: <20240220-descriptors-regulators-v1-0-097f608694be@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Support Opensource <support.opensource@diasemi.com>, 
 Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

This converts the LP8788 BUCK regulator driver to use GPIO
descriptors.

BUCK1 can use one DVS GPIO and BUCK2 can use two DVS GPIOS,
and no more so just hardcode two GPIO descriptors into
the per-DVS state containers.

Obtain the descriptors from each regulators subdevice.

As there are no in-tree users, board files need to populate
descriptor tables for the buck regulator devices when
they want to use this driver. BUCK1 need a GPIO descriptor
at index 0 and BUCK2 needs two GPIO descriptors at
indices 0 and 1.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/regulator/lp8788-buck.c | 64 +++++++++++++++++------------------------
 include/linux/mfd/lp8788.h      |  9 ++----
 2 files changed, 28 insertions(+), 45 deletions(-)

diff --git a/drivers/regulator/lp8788-buck.c b/drivers/regulator/lp8788-buck.c
index e97ade09dede..712eaa6ff8ab 100644
--- a/drivers/regulator/lp8788-buck.c
+++ b/drivers/regulator/lp8788-buck.c
@@ -13,7 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/mfd/lp8788.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 
 /* register address */
 #define LP8788_EN_BUCK			0x0C
@@ -69,8 +69,8 @@
 #define BUCK_FPWM_SHIFT(x)		(x)
 
 enum lp8788_dvs_state {
-	DVS_LOW  = GPIOF_OUT_INIT_LOW,
-	DVS_HIGH = GPIOF_OUT_INIT_HIGH,
+	DVS_LOW  = 0,
+	DVS_HIGH = 1,
 };
 
 enum lp8788_dvs_mode {
@@ -89,6 +89,8 @@ struct lp8788_buck {
 	struct lp8788 *lp;
 	struct regulator_dev *regulator;
 	void *dvs;
+	struct gpio_desc *gpio1;
+	struct gpio_desc *gpio2; /* Only used on BUCK2 */
 };
 
 /* BUCK 1 ~ 4 voltage ranges */
@@ -106,8 +108,7 @@ static void lp8788_buck1_set_dvs(struct lp8788_buck *buck)
 		return;
 
 	pinstate = dvs->vsel == DVS_SEL_V0 ? DVS_LOW : DVS_HIGH;
-	if (gpio_is_valid(dvs->gpio))
-		gpio_set_value(dvs->gpio, pinstate);
+	gpiod_set_value(buck->gpio1, pinstate);
 }
 
 static void lp8788_buck2_set_dvs(struct lp8788_buck *buck)
@@ -139,11 +140,8 @@ static void lp8788_buck2_set_dvs(struct lp8788_buck *buck)
 		return;
 	}
 
-	if (gpio_is_valid(dvs->gpio[0]))
-		gpio_set_value(dvs->gpio[0], pin1);
-
-	if (gpio_is_valid(dvs->gpio[1]))
-		gpio_set_value(dvs->gpio[1], pin2);
+	gpiod_set_value(buck->gpio1, pin1);
+	gpiod_set_value(buck->gpio2, pin2);
 }
 
 static void lp8788_set_dvs(struct lp8788_buck *buck, enum lp8788_buck_id id)
@@ -202,19 +200,13 @@ static u8 lp8788_select_buck_vout_addr(struct lp8788_buck *buck,
 					enum lp8788_buck_id id)
 {
 	enum lp8788_dvs_mode mode = lp8788_get_buck_dvs_ctrl_mode(buck, id);
-	struct lp8788_buck1_dvs *b1_dvs;
-	struct lp8788_buck2_dvs *b2_dvs;
 	u8 val, idx, addr;
 	int pin1, pin2;
 
 	switch (id) {
 	case BUCK1:
 		if (mode == EXTPIN) {
-			b1_dvs = (struct lp8788_buck1_dvs *)buck->dvs;
-			if (!b1_dvs)
-				goto err;
-
-			idx = gpio_get_value(b1_dvs->gpio) ? 1 : 0;
+			idx = gpiod_get_value(buck->gpio1);
 		} else {
 			lp8788_read_byte(buck->lp, LP8788_BUCK_DVS_SEL, &val);
 			idx = (val & LP8788_BUCK1_DVS_M) >> LP8788_BUCK1_DVS_S;
@@ -223,12 +215,8 @@ static u8 lp8788_select_buck_vout_addr(struct lp8788_buck *buck,
 		break;
 	case BUCK2:
 		if (mode == EXTPIN) {
-			b2_dvs = (struct lp8788_buck2_dvs *)buck->dvs;
-			if (!b2_dvs)
-				goto err;
-
-			pin1 = gpio_get_value(b2_dvs->gpio[0]);
-			pin2 = gpio_get_value(b2_dvs->gpio[1]);
+			pin1 = gpiod_get_value(buck->gpio1);
+			pin2 = gpiod_get_value(buck->gpio2);
 
 			if (pin1 == PIN_LOW && pin2 == PIN_LOW)
 				idx = 0;
@@ -424,28 +412,28 @@ static int lp8788_dvs_gpio_request(struct platform_device *pdev,
 				enum lp8788_buck_id id)
 {
 	struct lp8788_platform_data *pdata = buck->lp->pdata;
-	char *b1_name = "LP8788_B1_DVS";
-	char *b2_name[] = { "LP8788_B2_DVS1", "LP8788_B2_DVS2" };
-	int i, gpio, ret;
+	struct device *dev = &pdev->dev;
 
 	switch (id) {
 	case BUCK1:
-		gpio = pdata->buck1_dvs->gpio;
-		ret = devm_gpio_request_one(&pdev->dev, gpio, DVS_LOW,
-					    b1_name);
-		if (ret)
-			return ret;
+		buck->gpio1 = devm_gpiod_get(dev, "dvs", GPIOD_OUT_LOW);
+		if (IS_ERR(buck->gpio1))
+			return PTR_ERR(buck->gpio1);
+		gpiod_set_consumer_name(buck->gpio1, "LP8788_B1_DVS");
 
 		buck->dvs = pdata->buck1_dvs;
 		break;
 	case BUCK2:
-		for (i = 0; i < LP8788_NUM_BUCK2_DVS; i++) {
-			gpio = pdata->buck2_dvs->gpio[i];
-			ret = devm_gpio_request_one(&pdev->dev, gpio,
-						    DVS_LOW, b2_name[i]);
-			if (ret)
-				return ret;
-		}
+		buck->gpio1 = devm_gpiod_get_index(dev, "dvs", 0, GPIOD_OUT_LOW);
+		if (IS_ERR(buck->gpio1))
+			return PTR_ERR(buck->gpio1);
+		gpiod_set_consumer_name(buck->gpio1, "LP8788_B2_DVS1");
+
+		buck->gpio2 = devm_gpiod_get_index(dev, "dvs", 1, GPIOD_OUT_LOW);
+		if (IS_ERR(buck->gpio1))
+			return PTR_ERR(buck->gpio1);
+		gpiod_set_consumer_name(buck->gpio1, "LP8788_B2_DVS2");
+
 		buck->dvs = pdata->buck2_dvs;
 		break;
 	default:
diff --git a/include/linux/mfd/lp8788.h b/include/linux/mfd/lp8788.h
index 3d5c480d58ea..51b47966a04d 100644
--- a/include/linux/mfd/lp8788.h
+++ b/include/linux/mfd/lp8788.h
@@ -10,7 +10,6 @@
 #ifndef __MFD_LP8788_H__
 #define __MFD_LP8788_H__
 
-#include <linux/gpio.h>
 #include <linux/irqdomain.h>
 #include <linux/pwm.h>
 #include <linux/regmap.h>
@@ -159,21 +158,17 @@ struct lp8788;
 
 /*
  * lp8788_buck1_dvs
- * @gpio         : gpio pin number for dvs control
  * @vsel         : dvs selector for buck v1 register
  */
 struct lp8788_buck1_dvs {
-	int gpio;
 	enum lp8788_dvs_sel vsel;
 };
 
 /*
  * lp8788_buck2_dvs
- * @gpio         : two gpio pin numbers are used for dvs
  * @vsel         : dvs selector for buck v2 register
  */
 struct lp8788_buck2_dvs {
-	int gpio[LP8788_NUM_BUCK2_DVS];
 	enum lp8788_dvs_sel vsel;
 };
 
@@ -268,8 +263,8 @@ struct lp8788_vib_platform_data {
  * @buck_data    : regulator initial data for buck
  * @dldo_data    : regulator initial data for digital ldo
  * @aldo_data    : regulator initial data for analog ldo
- * @buck1_dvs    : gpio configurations for buck1 dvs
- * @buck2_dvs    : gpio configurations for buck2 dvs
+ * @buck1_dvs    : configurations for buck1 dvs
+ * @buck2_dvs    : configurations for buck2 dvs
  * @chg_pdata    : platform data for charger driver
  * @alarm_sel    : rtc alarm selection (1 or 2)
  * @bl_pdata     : configurable data for backlight driver

-- 
2.34.1


