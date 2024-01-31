Return-Path: <linux-kernel+bounces-47267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB879844B25
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6393D2925D1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8C13CF48;
	Wed, 31 Jan 2024 22:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aBhqhn4j"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94043B29A
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 22:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706740656; cv=none; b=KOhDYl/Bzk0qurce9PwMd7q0QvO6zVp4tdWXcdGOtDj5D5nLuTYd/xgdYLb8SwGFWpE89KBLQt6fAbj6ym7h6DcxpSMxdlhfTFNbWFIzkL/2j18L7lsl34qQ6P3OpHCLM3ho6yiU2i/tjdruZNdMb3WxbSXstqhCQWOaHL+yLWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706740656; c=relaxed/simple;
	bh=WvEjD8jcit9p/EBjrR1N6NawFgsZhp6NvZZ3ZQiGnQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f6ROl58LQJbZP/kBK3jgvGkmSJC8STrp9W9+wKntJHtQvqyK9qSznHQnZhA6jrN3iXnvdabf9GtYfSa9JfeO/v6NuvwrD3EJcxoqunXBaQ6wgDjSl6WTZCXGUeQMQcCtyrTk8sacX1hhk1KjhWcAIIA7qnAx5blX9P88IBcjtpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aBhqhn4j; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51124e08565so448130e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706740652; x=1707345452; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=okzddJtDl2wZ92vdZoXz+eQZ4Yo4IwWgeQb2Nkz5V54=;
        b=aBhqhn4jpqKVsL42Zp9armYhYRFNPAKOL2ufm6CGUzf9KNynM7FSlLgUudv2Bmch5/
         ArugxE8+TRa05dVM6JoKuDq83PYn/RPJNFDLdbR+XqVqJ/TXvsW89+tGpkw4Mlobwj+A
         uL6+WXcl8wn1hVZTEDRezstVFFttL0AmCOfXItDGvOuBgpIH/jzKphwan99TnMqa+03p
         ugng4cv1CNCY+ze9NLrxPIFGMYtsxD4Mg1QnnJookpddW2HMZyJABn0+Eda/x9dzgxzG
         0R2oQpC3S1kBdc13KPEE8sKZ61oiL1kfVXf4tkSlk3ZMNEr9QVNZtxEq4GfVS1uwppc/
         saWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706740652; x=1707345452;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=okzddJtDl2wZ92vdZoXz+eQZ4Yo4IwWgeQb2Nkz5V54=;
        b=JklKR9csx1glPjZAi3moQvN2JBMvU1M7i+MBpolPqPCaAyC723/bt39lrTFDCiet30
         ewThfO036wEUyHDa/7EMkFOyK6opuKwgGYOo5HgPHaaMA/p73Ek9g3o1KazR2/TzYVlW
         MW/hT7moNmK6c2SZf2InHEvE8dB+71zMS/+QpuVl5Z+oWdqWNq/glezXFY82xNGuF02J
         F313wjV50MCBfzG5JMT3DxZti7i2bnse+gvfA7yJlgO2GL5qVb7GKAxobUmBXYUzfMeQ
         tXeQzQNYoK/PzmpZfXYLhKQJCIWBcNhdiG8HQsDDUcxp1TR8/G6fJmJ+c9nuOQSJLkEG
         zoiQ==
X-Gm-Message-State: AOJu0YxcdiNfWYrMIk3400lCBC4CijYWctsCtTKVXOuSTT6pgd34ObO1
	zjfO48yEByVcYLn5GCAjvKFt1sAsyySJXreEYZDowPL1HHoGgNl0pvYtyfFkQlc=
X-Google-Smtp-Source: AGHT+IGH+EAgSWIqZG+M7RJ7mnt9a9Op044NAH4HNCWte2NJHhvM0dhLGwPCcBNJqTdJxc5Kkuqs9w==
X-Received: by 2002:a05:6512:4db:b0:511:211b:43e0 with SMTP id w27-20020a05651204db00b00511211b43e0mr607338lfq.67.1706740651893;
        Wed, 31 Jan 2024 14:37:31 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVmMjpi/JZHvgCPf0wWOUcgxhE44ZJ1CcrefxPHn3urkFqe8PyCMR2Ap73e1z7vbcWYclVFMIwn6t/jRE0miJi/wOngtnIiuy17U+6HTtTIPJyiDTB3FrdpEfhTCCZ8MSyL0M0+KO5ZLfo02uzSy6kyxqouDICtztL4lQtL+eSvLKZVUDYwjq9QJ/ni8VJEfSJTBgwG3DPoZSipr2zFbie9GXaNMHvou8x1aGcpIjr+hVt6nZRisYSM37W0CvNQd5y11I84WJAVglqnbFttCIyTHCWaxI36Pd3CFqsrJJRTOW63Hxy6cf4AA6VOSCK3eA/dC68tGvDVKbE1KKAzRzsylgHnVxQD/6i4d75wIwhWb/AaqLbLnqh2wf2WbEL2OBGXQDBTujPoGLRWTQhow214dH9W6M1qngNCQRjFjUSG8zOryilrr2nYqStsjEFxr6ZpDw7uUAln9Tmbig==
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id v25-20020a05651203b900b0051023149df3sm1976021lfp.248.2024.01.31.14.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 14:37:31 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 31 Jan 2024 23:37:25 +0100
Subject: [PATCH 6/6] wifi: cw1200: Convert to GPIO descriptors
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-descriptors-wireless-v1-6-e1c7c5d68746@linaro.org>
References: <20240131-descriptors-wireless-v1-0-e1c7c5d68746@linaro.org>
In-Reply-To: <20240131-descriptors-wireless-v1-0-e1c7c5d68746@linaro.org>
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
 Kalle Valo <kvalo@kernel.org>, Arend van Spriel <aspriel@gmail.com>, 
 Franky Lin <franky.lin@broadcom.com>, 
 Hante Meuleman <hante.meuleman@broadcom.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee@kernel.org>, 
 Brian Norris <briannorris@chromium.org>, 
 Srinivasan Raju <srini.raju@purelifi.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 brcm80211-dev-list.pdl@broadcom.com, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

The CW1200 uses two GPIOs to control the powerup and reset
pins, get these from GPIO descriptors instead of being passed
as platform data from boardfiles.

The RESET line will need to be marked as active low as we will
let gpiolib handle the polarity inversion.

The SDIO case is a bit special since the "card" need to be
powered up before it gets detected on the SDIO bus and
properly probed. Fix this by using board-specific GPIOs
assigned to device "NULL".

There are currently no in-tree users.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/wireless/st/cw1200/cw1200_sdio.c | 42 +++++++++-------
 drivers/net/wireless/st/cw1200/cw1200_spi.c  | 71 ++++++++++++++++------------
 include/linux/platform_data/net-cw1200.h     |  4 --
 3 files changed, 65 insertions(+), 52 deletions(-)

diff --git a/drivers/net/wireless/st/cw1200/cw1200_sdio.c b/drivers/net/wireless/st/cw1200/cw1200_sdio.c
index 4c30b5772ce0..00c4731d8f8e 100644
--- a/drivers/net/wireless/st/cw1200/cw1200_sdio.c
+++ b/drivers/net/wireless/st/cw1200/cw1200_sdio.c
@@ -8,7 +8,7 @@
 
 #include <linux/module.h>
 #include <linux/interrupt.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/sdio_func.h>
@@ -178,12 +178,15 @@ static int cw1200_sdio_irq_unsubscribe(struct hwbus_priv *self)
 	return ret;
 }
 
+/* Like the rest of the driver, this only supports one device per system */
+static struct gpio_desc *cw1200_reset;
+static struct gpio_desc *cw1200_powerup;
+
 static int cw1200_sdio_off(const struct cw1200_platform_data_sdio *pdata)
 {
-	if (pdata->reset) {
-		gpio_set_value(pdata->reset, 0);
+	if (cw1200_reset) {
+		gpiod_set_value(cw1200_reset, 0);
 		msleep(30); /* Min is 2 * CLK32K cycles */
-		gpio_free(pdata->reset);
 	}
 
 	if (pdata->power_ctrl)
@@ -196,16 +199,21 @@ static int cw1200_sdio_off(const struct cw1200_platform_data_sdio *pdata)
 
 static int cw1200_sdio_on(const struct cw1200_platform_data_sdio *pdata)
 {
-	/* Ensure I/Os are pulled low */
-	if (pdata->reset) {
-		gpio_request(pdata->reset, "cw1200_wlan_reset");
-		gpio_direction_output(pdata->reset, 0);
+	/* Ensure I/Os are pulled low (reset is active low) */
+	cw1200_reset = devm_gpiod_get_optional(NULL, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(cw1200_reset)) {
+		pr_err("could not get CW1200 SDIO reset GPIO\n");
+		return PTR_ERR(cw1200_reset);
 	}
-	if (pdata->powerup) {
-		gpio_request(pdata->powerup, "cw1200_wlan_powerup");
-		gpio_direction_output(pdata->powerup, 0);
+	gpiod_set_consumer_name(cw1200_reset, "cw1200_wlan_reset");
+	cw1200_powerup = devm_gpiod_get_optional(NULL, "powerup", GPIOD_OUT_LOW);
+	if (IS_ERR(cw1200_powerup)) {
+		pr_err("could not get CW1200 SDIO powerup GPIO\n");
+		return PTR_ERR(cw1200_powerup);
 	}
-	if (pdata->reset || pdata->powerup)
+	gpiod_set_consumer_name(cw1200_powerup, "cw1200_wlan_powerup");
+
+	if (cw1200_reset || cw1200_powerup)
 		msleep(10); /* Settle time? */
 
 	/* Enable 3v3 and 1v8 to hardware */
@@ -226,13 +234,13 @@ static int cw1200_sdio_on(const struct cw1200_platform_data_sdio *pdata)
 	}
 
 	/* Enable POWERUP signal */
-	if (pdata->powerup) {
-		gpio_set_value(pdata->powerup, 1);
+	if (cw1200_powerup) {
+		gpiod_set_value(cw1200_powerup, 1);
 		msleep(250); /* or more..? */
 	}
-	/* Enable RSTn signal */
-	if (pdata->reset) {
-		gpio_set_value(pdata->reset, 1);
+	/* Deassert RSTn signal, note active low */
+	if (cw1200_reset) {
+		gpiod_set_value(cw1200_reset, 0);
 		msleep(50); /* Or more..? */
 	}
 	return 0;
diff --git a/drivers/net/wireless/st/cw1200/cw1200_spi.c b/drivers/net/wireless/st/cw1200/cw1200_spi.c
index c82c0688b549..9df7f46588b4 100644
--- a/drivers/net/wireless/st/cw1200/cw1200_spi.c
+++ b/drivers/net/wireless/st/cw1200/cw1200_spi.c
@@ -11,7 +11,7 @@
  */
 
 #include <linux/module.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
@@ -38,6 +38,8 @@ struct hwbus_priv {
 	const struct cw1200_platform_data_spi *pdata;
 	spinlock_t		lock; /* Serialize all bus operations */
 	wait_queue_head_t       wq;
+	struct gpio_desc	*reset;
+	struct gpio_desc	*powerup;
 	int claimed;
 };
 
@@ -275,12 +277,12 @@ static void cw1200_spi_irq_unsubscribe(struct hwbus_priv *self)
 	free_irq(self->func->irq, self);
 }
 
-static int cw1200_spi_off(const struct cw1200_platform_data_spi *pdata)
+static int cw1200_spi_off(struct hwbus_priv *self, const struct cw1200_platform_data_spi *pdata)
 {
-	if (pdata->reset) {
-		gpio_set_value(pdata->reset, 0);
+	if (self->reset) {
+		/* Assert RESET, note active low */
+		gpiod_set_value(self->reset, 1);
 		msleep(30); /* Min is 2 * CLK32K cycles */
-		gpio_free(pdata->reset);
 	}
 
 	if (pdata->power_ctrl)
@@ -291,18 +293,12 @@ static int cw1200_spi_off(const struct cw1200_platform_data_spi *pdata)
 	return 0;
 }
 
-static int cw1200_spi_on(const struct cw1200_platform_data_spi *pdata)
+static int cw1200_spi_on(struct hwbus_priv *self, const struct cw1200_platform_data_spi *pdata)
 {
 	/* Ensure I/Os are pulled low */
-	if (pdata->reset) {
-		gpio_request(pdata->reset, "cw1200_wlan_reset");
-		gpio_direction_output(pdata->reset, 0);
-	}
-	if (pdata->powerup) {
-		gpio_request(pdata->powerup, "cw1200_wlan_powerup");
-		gpio_direction_output(pdata->powerup, 0);
-	}
-	if (pdata->reset || pdata->powerup)
+	gpiod_direction_output(self->reset, 1); /* Active low */
+	gpiod_direction_output(self->powerup, 0);
+	if (self->reset || self->powerup)
 		msleep(10); /* Settle time? */
 
 	/* Enable 3v3 and 1v8 to hardware */
@@ -323,13 +319,13 @@ static int cw1200_spi_on(const struct cw1200_platform_data_spi *pdata)
 	}
 
 	/* Enable POWERUP signal */
-	if (pdata->powerup) {
-		gpio_set_value(pdata->powerup, 1);
+	if (self->powerup) {
+		gpiod_set_value(self->powerup, 1);
 		msleep(250); /* or more..? */
 	}
-	/* Enable RSTn signal */
-	if (pdata->reset) {
-		gpio_set_value(pdata->reset, 1);
+	/* Assert RSTn signal, note active low */
+	if (self->reset) {
+		gpiod_set_value(self->reset, 0);
 		msleep(50); /* Or more..? */
 	}
 	return 0;
@@ -381,20 +377,33 @@ static int cw1200_spi_probe(struct spi_device *func)
 		spi_get_chipselect(func, 0), func->mode, func->bits_per_word,
 		func->max_speed_hz);
 
-	if (cw1200_spi_on(plat_data)) {
+	self = devm_kzalloc(&func->dev, sizeof(*self), GFP_KERNEL);
+	if (!self) {
+		pr_err("Can't allocate SPI hwbus_priv.");
+		return -ENOMEM;
+	}
+
+	/* Request reset asserted */
+	self->reset = devm_gpiod_get_optional(&func->dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(self->reset))
+		return dev_err_probe(&func->dev, PTR_ERR(self->reset),
+				     "could not get reset GPIO\n");
+	gpiod_set_consumer_name(self->reset, "cw1200_wlan_reset");
+
+	self->powerup = devm_gpiod_get_optional(&func->dev, "powerup", GPIOD_OUT_LOW);
+	if (IS_ERR(self->powerup))
+		return dev_err_probe(&func->dev, PTR_ERR(self->powerup),
+				     "could not get powerup GPIO\n");
+	gpiod_set_consumer_name(self->reset, "cw1200_wlan_powerup");
+
+	if (cw1200_spi_on(self, plat_data)) {
 		pr_err("spi_on() failed!\n");
-		return -1;
+		return -ENODEV;
 	}
 
 	if (spi_setup(func)) {
 		pr_err("spi_setup() failed!\n");
-		return -1;
-	}
-
-	self = devm_kzalloc(&func->dev, sizeof(*self), GFP_KERNEL);
-	if (!self) {
-		pr_err("Can't allocate SPI hwbus_priv.");
-		return -ENOMEM;
+		return -ENODEV;
 	}
 
 	self->pdata = plat_data;
@@ -416,7 +425,7 @@ static int cw1200_spi_probe(struct spi_device *func)
 
 	if (status) {
 		cw1200_spi_irq_unsubscribe(self);
-		cw1200_spi_off(plat_data);
+		cw1200_spi_off(self, plat_data);
 	}
 
 	return status;
@@ -434,7 +443,7 @@ static void cw1200_spi_disconnect(struct spi_device *func)
 			self->core = NULL;
 		}
 	}
-	cw1200_spi_off(dev_get_platdata(&func->dev));
+	cw1200_spi_off(self, dev_get_platdata(&func->dev));
 }
 
 static int __maybe_unused cw1200_spi_suspend(struct device *dev)
diff --git a/include/linux/platform_data/net-cw1200.h b/include/linux/platform_data/net-cw1200.h
index c510734405bb..89d0ec6f7d46 100644
--- a/include/linux/platform_data/net-cw1200.h
+++ b/include/linux/platform_data/net-cw1200.h
@@ -14,8 +14,6 @@ struct cw1200_platform_data_spi {
 
 	/* All others are optional */
 	bool have_5ghz;
-	int reset;                     /* GPIO to RSTn signal (0 disables) */
-	int powerup;                   /* GPIO to POWERUP signal (0 disables) */
 	int (*power_ctrl)(const struct cw1200_platform_data_spi *pdata,
 			  bool enable); /* Control 3v3 / 1v8 supply */
 	int (*clk_ctrl)(const struct cw1200_platform_data_spi *pdata,
@@ -30,8 +28,6 @@ struct cw1200_platform_data_sdio {
 	/* All others are optional */
 	bool have_5ghz;
 	bool no_nptb;       /* SDIO hardware does not support non-power-of-2-blocksizes */
-	int reset;          /* GPIO to RSTn signal (0 disables) */
-	int powerup;        /* GPIO to POWERUP signal (0 disables) */
 	int irq;            /* IRQ line or 0 to use SDIO IRQ */
 	int (*power_ctrl)(const struct cw1200_platform_data_sdio *pdata,
 			  bool enable); /* Control 3v3 / 1v8 supply */

-- 
2.34.1


