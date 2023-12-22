Return-Path: <linux-kernel+bounces-9567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A68481C7A6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B9351F22F33
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3355814F92;
	Fri, 22 Dec 2023 09:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpGsTDGR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060D6FBE4;
	Fri, 22 Dec 2023 09:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5545139bed4so560212a12.2;
        Fri, 22 Dec 2023 01:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703238788; x=1703843588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MJR/JY0wBte1fc/3m6wZPMOWo6cUDvO9p3vgn75NkA=;
        b=UpGsTDGRWIEYmd4IMnvpIuTf43oQUssTfd2eFgTlPx4BdMR99NtloFa+2YILyqwQuF
         px17zNBN9Gs5FJ3ZOO0UYsrwr9Gw43xu22fs3nzrgF/yHC3MUOrnET54wStOnWG/848P
         fB7ni3czKHbIS+5oLlCLJsNX7kb9uQ+TMiywA5TOFDCM/f0mDMVcvrkMN5bFeAXxebCa
         DZkA08EfaeeqXzl1+pvvBjl27x3S3JYi/4Uvnucr9HI/SCEkdTG5klWc06dHOxLLHbQP
         zDPjj7HksYySsUzFwcWxCKSp39qrtq//HAqkd8GhFr76i2yO33muRVihoJsbq5DkhAMg
         0S+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703238788; x=1703843588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MJR/JY0wBte1fc/3m6wZPMOWo6cUDvO9p3vgn75NkA=;
        b=PDWC6/1ifvWMqZ3kjc3kcslB2Ycewrap1607mqjQj6Vo2z8X2P5+wa+n6gc+Vt+DW4
         m5GkZFRmLjIcg23b0l6OfzUmCSmy7DAta3GZtKHyMT8vhZh0I5vtJZHLWToebb5RN/E7
         8k5+WwZIRAft0RC0NrIELNsbktyiQd8KaVDfd5bI0klDC9c07cAswTSnuZ1hSYjxuYUo
         c1Gtb77dt83c8oxFc79CekCbxXFvggPAr0zY2hSlxwwQDDLnKlDFM0YiJjRQeuW6/KkU
         CVG1toJm/Uiot9MIsukF4HjUN7Ysz1C8deZjaRUib7QhEq/EXORQzY/ToqccBjIQYNAD
         maiw==
X-Gm-Message-State: AOJu0YxNeepyXmBlFZ2Ww2nXx+kcvGX0mqihYiAc9ap9yQkbnWLqPdxM
	2+Wc9io7NhtJgytiB+CvXtc=
X-Google-Smtp-Source: AGHT+IGNZG6q+jBr/NjK3sVAaow4C1vwD4Ug2rmqwznnIuzhETk+TQFxXyO6gVVqYzj4smJwcg3xCQ==
X-Received: by 2002:a17:906:7397:b0:a26:c595:62c7 with SMTP id f23-20020a170906739700b00a26c59562c7mr91716ejl.122.1703238788266;
        Fri, 22 Dec 2023 01:53:08 -0800 (PST)
Received: from eichest-laptop.lan ([2a02:168:af72:0:f05b:3f84:67d1:580])
        by smtp.gmail.com with ESMTPSA id su24-20020a17090703d800b00a26ab41d0f7sm1311838ejb.26.2023.12.22.01.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 01:53:07 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: nick@shmanahar.org,
	dmitry.torokhov@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	linus.walleij@linaro.org,
	francesco.dolcini@toradex.com
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: [PATCH v2 2/2] Input: atmel_mxt_ts - support poweroff in suspend
Date: Fri, 22 Dec 2023 10:52:58 +0100
Message-Id: <20231222095258.33369-3-eichest@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231222095258.33369-1-eichest@gmail.com>
References: <20231222095258.33369-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Add a new device tree property to indicate that the device should be
powered off in suspend mode. We have a shared regulator that powers the
display, a USB hub and some other peripherals. The maXTouch controller
doesn't normally disable the regulator in suspend mode, so our extra
peripherals stay powered on. This is not desirable as it consumes more
power. With this patch we add the option to disable the regulator in
suspend mode for the maXTouch and accept the longer initialisation time.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 72 ++++++++++++++++++------
 1 file changed, 55 insertions(+), 17 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 20094b9899f0..3f7f58f1c930 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -317,6 +317,7 @@ struct mxt_data {
 	struct gpio_desc *reset_gpio;
 	struct gpio_desc *wake_gpio;
 	bool use_retrigen_workaround;
+	bool poweroff_sleep;
 
 	/* Cached parameters from object table */
 	u16 T5_address;
@@ -2799,15 +2800,18 @@ static int mxt_configure_objects(struct mxt_data *data,
 			dev_warn(dev, "Error %d updating config\n", error);
 	}
 
-	if (data->multitouch) {
-		error = mxt_initialize_input_device(data);
-		if (error)
-			return error;
-	} else {
-		dev_warn(dev, "No touch object detected\n");
-	}
+	/* If input device is not already registered */
+	if (!data->input_dev) {
+		if (data->multitouch) {
+			error = mxt_initialize_input_device(data);
+			if (error)
+				return error;
+		} else {
+			dev_warn(dev, "No touch object detected\n");
+		}
 
-	mxt_debug_init(data);
+		mxt_debug_init(data);
+	}
 
 	return 0;
 }
@@ -3328,6 +3332,8 @@ static int mxt_probe(struct i2c_client *client)
 		msleep(MXT_RESET_INVALID_CHG);
 	}
 
+	data->poweroff_sleep = device_property_read_bool(&client->dev,
+							 "atmel,poweroff-sleep");
 	/*
 	 * Controllers like mXT1386 have a dedicated WAKE line that could be
 	 * connected to a GPIO or to I2C SCL pin, or permanently asserted low.
@@ -3390,12 +3396,21 @@ static int mxt_suspend(struct device *dev)
 	if (!input_dev)
 		return 0;
 
-	mutex_lock(&input_dev->mutex);
+	if (!device_may_wakeup(dev) && data->poweroff_sleep) {
+		if (data->reset_gpio)
+			gpiod_set_value(data->reset_gpio, 1);
 
-	if (input_device_enabled(input_dev))
-		mxt_stop(data);
+		regulator_bulk_disable(ARRAY_SIZE(data->regulators),
+				data->regulators);
+		data->T44_address = 0;
+	} else {
+		mutex_lock(&input_dev->mutex);
+
+		if (input_device_enabled(input_dev))
+			mxt_stop(data);
 
-	mutex_unlock(&input_dev->mutex);
+		mutex_unlock(&input_dev->mutex);
+	}
 
 	disable_irq(data->irq);
 
@@ -3411,14 +3426,37 @@ static int mxt_resume(struct device *dev)
 	if (!input_dev)
 		return 0;
 
-	enable_irq(data->irq);
+	if (!device_may_wakeup(dev) && data->poweroff_sleep) {
+		int ret;
 
-	mutex_lock(&input_dev->mutex);
+		ret = regulator_bulk_enable(ARRAY_SIZE(data->regulators),
+				data->regulators);
+		if (ret) {
+			dev_err(dev, "failed to enable regulators: %d\n",
+					ret);
+			return ret;
+		}
+		msleep(MXT_BACKUP_TIME);
 
-	if (input_device_enabled(input_dev))
-		mxt_start(data);
+		if (data->reset_gpio) {
+			/* Wait a while and then de-assert the RESET GPIO line */
+			msleep(MXT_RESET_GPIO_TIME);
+			gpiod_set_value(data->reset_gpio, 0);
+			msleep(MXT_RESET_INVALID_CHG);
+		}
 
-	mutex_unlock(&input_dev->mutex);
+		/* This also enables the irq again */
+		mxt_initialize(data);
+	} else {
+		enable_irq(data->irq);
+
+		mutex_lock(&input_dev->mutex);
+
+		if (input_device_enabled(input_dev))
+			mxt_start(data);
+
+		mutex_unlock(&input_dev->mutex);
+	}
 
 	return 0;
 }
-- 
2.40.1


