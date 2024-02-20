Return-Path: <linux-kernel+bounces-72570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4CB85B559
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B36128195C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5E85D73A;
	Tue, 20 Feb 2024 08:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="szowWkGw"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29FC5CDF7
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418190; cv=none; b=Efk5NibMvYwjbmzXGvDj56gWPgOjCUCTsT6PBHpZ75jJCcwc9W+fDtpaTTkEphEs7aY4DYXWQmSTKdaL36b0cGLkSrR7T4Y0fG/+BOk/qVjz5NOrIe9S1RaF4hqPZBDzRlEOcOSCQMAX/Iit5VY/jyTKWXWG3jIkhdyQLzVgWC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418190; c=relaxed/simple;
	bh=z2cxCTfWPEPydtoKnMFvKQ2VIVJj/81Jcc3ebBTGNY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qrnLdS4SrTxVWy6x11LtdVqH4XNMO1Gj8Y7fP49U2pOXemOz5TqbcnMFeOnlvKHTpiiYI2MwMGUK64Xf72JF4vZ/xHZCMRa5/ao8gyhPDiPlEbv7VA3+BYlISWMMmqGAn5+3n34/cLRvd5AZ6VInJYQPyE+v2GflpIQZeKEK53I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=szowWkGw; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d21e2b2245so51188321fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 00:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708418187; x=1709022987; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QjY74HkehgK0i0REEpSEnW6XrJ8Vf9fEs6vzbNOlqqI=;
        b=szowWkGwA6s3nMSRE7+RhWh8RiSag87faBDhwxs11NygN66QA/sL+i8/Lb4++FuE7o
         WChY1iu1rLVgCx3stfEBniyrh1tvWJktzRKTkmwi6S9+VxulpkuXHwJg9jN/d7oJNrDN
         XqS0ZbZf4omWjxHQQu7zCmkg4CBnzXCMupI2l971kbVkp5PGJoL/KaDj0/UmvE0QvL+e
         ShmWGGxmp/BfbQ8cCnUeej1UjztRgctf5DP1/wl5p7hj2AYgF4AUKu6BF0dR70jVjks2
         gWsctd05graCvPSDtm1gzF5AaJhe1+eu8IPu0dcdpkzfN8sNrN97SONoZqmg3NuKpd8X
         7hEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708418187; x=1709022987;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QjY74HkehgK0i0REEpSEnW6XrJ8Vf9fEs6vzbNOlqqI=;
        b=OaLWncHpFBqW2XI4+6TLbkNGwurhEu6OQMRjE/x7DUyoLApN3NAwAeD+guo1i1uj1l
         sSzBcSsi28hsrhPVWaQ3LiGLLql0xUuATSOzT/Q5vVgAndXbu6jTxcHQ4affg8axQ7jr
         nKoY5/vhIRZwzymWGaKXatCZF9hvxSeBEnD6UrJE3PDf0esVQWMqBA1Nlu6GWsEFH7H5
         hmwIBaNtnTk1FPDzbWtSOs0uZu6xf9x7FnmTOsDpoJYWSz5s8x2eDG6jCni0MzVrhkJP
         Qr+9qAgSFYmRCSxtv+4tbRdAbw+e+u3C8Z7ZZQ35Hn4xaKzLHvPSPLJ20o8puoaXByU9
         D3GQ==
X-Gm-Message-State: AOJu0YwD1NP2+Ga4Cs1ftVf2adJE0Ykfhnnn6WQ23S4v2uetq+YUnPCA
	Mdj3TsHdvFf3hRXxvuo6diMBlHsfrNz+OXUu7Haz16FV/s1T8Su3TZqSUs9T23Q=
X-Google-Smtp-Source: AGHT+IHwWRXXjsNCQdzHXxttlkN6Mj+MrPGa+OkuHg3cDk4/LznRl0ffW3SZY6MoPAlBSfhCHt01GA==
X-Received: by 2002:a2e:a68f:0:b0:2d2:366c:b219 with SMTP id q15-20020a2ea68f000000b002d2366cb219mr3488096lje.51.1708418187103;
        Tue, 20 Feb 2024 00:36:27 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id k1-20020a2e2401000000b002d2468d3bacsm195317ljk.9.2024.02.20.00.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 00:36:26 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 20 Feb 2024 09:36:25 +0100
Subject: [PATCH 2/5] regulator: da9055: Fully convert to GPIO descriptors
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-descriptors-regulators-v1-2-097f608694be@linaro.org>
References: <20240220-descriptors-regulators-v1-0-097f608694be@linaro.org>
In-Reply-To: <20240220-descriptors-regulators-v1-0-097f608694be@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Support Opensource <support.opensource@diasemi.com>, 
 Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

The DA9055 regulator was touched before, requireing enable GPIOs
to be passed from pdata.

As we have a device for each regulator, obtain the three gpios
ren ("regulator enable"), rsel ("regulator select") and the
ena ("enable") GPIO associated with the regulator enable
directly from the device and cut down on the amount of
GPIO numbers passed as platform data.

The ren and rsel are just requested as inputs: these are
actually handled by hardware. The ena gpios are driven
actively by the regulator core.

There are no in-tree users, but the regulators are instantiated
from the (undocumed) device tree nodes with "dlg,da9055-regulator"
as compatible, and by simply adding regulator-enable-gpios,
regulator-select-gpios and enable-gpios to this DT node, all
will work as before.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/regulator/da9055-regulator.c | 48 ++++++++++++++++++------------------
 include/linux/mfd/da9055/pdata.h     | 13 ----------
 2 files changed, 24 insertions(+), 37 deletions(-)

diff --git a/drivers/regulator/da9055-regulator.c b/drivers/regulator/da9055-regulator.c
index 8fd9ac787588..352547c375bd 100644
--- a/drivers/regulator/da9055-regulator.c
+++ b/drivers/regulator/da9055-regulator.c
@@ -9,7 +9,6 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
@@ -413,31 +412,35 @@ static struct da9055_regulator_info da9055_regulator_info[] = {
  * GPIO can control regulator state and/or select the regulator register
  * set A/B for voltage ramping.
  */
-static int da9055_gpio_init(struct da9055_regulator *regulator,
+static int da9055_gpio_init(struct device *dev,
+			    struct da9055_regulator *regulator,
 			    struct regulator_config *config,
 			    struct da9055_pdata *pdata, int id)
 {
 	struct da9055_regulator_info *info = regulator->info;
+	struct gpio_desc *ren;
+	struct gpio_desc *ena;
+	struct gpio_desc *rsel;
 	int ret = 0;
 
-	if (!pdata)
-		return 0;
+	/* Look for "regulator-enable-gpios" GPIOs in the regulator node */
+	ren = devm_gpiod_get_optional(dev, "regulator-enable", GPIOD_IN);
+	if (IS_ERR(ren))
+		return PTR_ERR(ren);
 
-	if (pdata->gpio_ren && pdata->gpio_ren[id]) {
-		char name[18];
-		int gpio_mux = pdata->gpio_ren[id];
+	if (ren) {
+		/* This GPIO is not optional at this point */
+		ena = devm_gpiod_get(dev, "enable", GPIOD_OUT_HIGH);
+		if (IS_ERR(ena))
+			return PTR_ERR(ena);
 
-		config->ena_gpiod = pdata->ena_gpiods[id];
+		config->ena_gpiod = ena;
 
 		/*
 		 * GPI pin is muxed with regulator to control the
 		 * regulator state.
 		 */
-		sprintf(name, "DA9055 GPI %d", gpio_mux);
-		ret = devm_gpio_request_one(config->dev, gpio_mux, GPIOF_DIR_IN,
-					    name);
-		if (ret < 0)
-			goto err;
+		gpiod_set_consumer_name(ren, "DA9055 ren GPI");
 
 		/*
 		 * Let the regulator know that its state is controlled
@@ -448,24 +451,22 @@ static int da9055_gpio_init(struct da9055_regulator *regulator,
 					pdata->reg_ren[id]
 					<< DA9055_E_GPI_SHIFT);
 		if (ret < 0)
-			goto err;
+			return ret;
 	}
 
-	if (pdata->gpio_rsel && pdata->gpio_rsel[id]) {
-		char name[18];
-		int gpio_mux = pdata->gpio_rsel[id];
+	/* Look for "regulator-select-gpios" GPIOs in the regulator node */
+	rsel = devm_gpiod_get_optional(dev, "regulator-select", GPIOD_IN);
+	if (IS_ERR(rsel))
+		return PTR_ERR(rsel);
 
+	if (rsel) {
 		regulator->reg_rselect = pdata->reg_rsel[id];
 
 		/*
 		 * GPI pin is muxed with regulator to select the
 		 * regulator register set A/B for voltage ramping.
 		 */
-		sprintf(name, "DA9055 GPI %d", gpio_mux);
-		ret = devm_gpio_request_one(config->dev, gpio_mux, GPIOF_DIR_IN,
-					    name);
-		if (ret < 0)
-			goto err;
+		gpiod_set_consumer_name(rsel, "DA9055 rsel GPI");
 
 		/*
 		 * Let the regulator know that its register set A/B
@@ -477,7 +478,6 @@ static int da9055_gpio_init(struct da9055_regulator *regulator,
 					<< DA9055_V_GPI_SHIFT);
 	}
 
-err:
 	return ret;
 }
 
@@ -532,7 +532,7 @@ static int da9055_regulator_probe(struct platform_device *pdev)
 	if (pdata)
 		config.init_data = pdata->regulators[pdev->id];
 
-	ret = da9055_gpio_init(regulator, &config, pdata, pdev->id);
+	ret = da9055_gpio_init(&pdev->dev, regulator, &config, pdata, pdev->id);
 	if (ret < 0)
 		return ret;
 
diff --git a/include/linux/mfd/da9055/pdata.h b/include/linux/mfd/da9055/pdata.h
index d3f126990ad0..137a2b067512 100644
--- a/include/linux/mfd/da9055/pdata.h
+++ b/include/linux/mfd/da9055/pdata.h
@@ -7,7 +7,6 @@
 #define DA9055_MAX_REGULATORS	8
 
 struct da9055;
-struct gpio_desc;
 
 enum gpio_select {
 	NO_GPIO = 0,
@@ -23,16 +22,6 @@ struct da9055_pdata {
 	struct regulator_init_data *regulators[DA9055_MAX_REGULATORS];
 	/* Enable RTC in RESET Mode */
 	bool reset_enable;
-	/*
-	 * GPI muxed pin to control
-	 * regulator state A/B, 0 if not available.
-	 */
-	int *gpio_ren;
-	/*
-	 * GPI muxed pin to control
-	 * regulator set, 0 if not available.
-	 */
-	int *gpio_rsel;
 	/*
 	 * Regulator mode control bits value (GPI offset) that
 	 * controls the regulator state, 0 if not available.
@@ -43,7 +32,5 @@ struct da9055_pdata {
 	 * controls the regulator set A/B, 0 if  not available.
 	 */
 	enum gpio_select *reg_rsel;
-	/* GPIO descriptors to enable regulator, NULL if not available */
-	struct gpio_desc **ena_gpiods;
 };
 #endif /* __DA9055_PDATA_H */

-- 
2.34.1


