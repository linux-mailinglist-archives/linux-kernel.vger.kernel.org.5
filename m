Return-Path: <linux-kernel+bounces-59126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D35984F19C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9C1F2880AD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0741965BDC;
	Fri,  9 Feb 2024 08:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9vkI6md"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA7865BDD;
	Fri,  9 Feb 2024 08:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707468506; cv=none; b=g/L9j/HQvQLetZPgpdNGdN4y+KcVbzNMPv+zwuI1gfR9IGe748HLH/UR/MbKxnmraELZZWa3OSy2kdJl6sM4kB2wqYewICLsrFOVK0IfgipZ4CTdUfB27kPCkJsW1WzEVzouwxyudsygeEARRK5Wg5hw7imKZ7NkKs/cdt9/oY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707468506; c=relaxed/simple;
	bh=FACvZGCzZd/Mj3qjKO44p5hHKQ4QqwarXOST8mlvQ/U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o4SwgLrD3lElRgDFpCij+iJZsRdkGzUWmf3FvlnKwNOlCWUKipawnnebDJHRWP74YJxjFWP5PN48aak4FXHa+Gkcs1u8RQTjoTEo1OQO8WlX3C2/N209eWDStZ52AykXV+rvXJ76/s7QX9uR/T/zVsMc1mI5/dFZLJHoZezW9l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9vkI6md; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41071e85659so1586215e9.1;
        Fri, 09 Feb 2024 00:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707468502; x=1708073302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mVc4M1YbGvNb8ipoFp9BUg+QNpL61/sf2CwDTAOM2wc=;
        b=V9vkI6mdGUHE6/sa1BPVoJECys3C+YvQPCVARyXGzM0JBVXLhyVjhduX85VxE2nMZE
         qUsrW+rCY+YpBkvcSlex08cC/3v3RJzZtBOlH6GtawaCDMfqvlDyW7RVwfvnPBGwVfWf
         AV6XirBzHBCF1DEl/M5n6KwoZ8qIqwVqnSUtmkXbLmThglo9c1ple5fernuORbZBrKrN
         O6ZTPDujmswnZD3OlbVfshdWVexahIIdyoTCxPNGLfujddYXxb5+0/DnMy1+I9Yr12bP
         wK7M49hiew2QYRKaJfyrxV1NvlpkmXegM5KOrIQMYflmh7rnbpuEUTyGszSEb+oVt9ka
         DzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707468502; x=1708073302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mVc4M1YbGvNb8ipoFp9BUg+QNpL61/sf2CwDTAOM2wc=;
        b=Lus9e8UJ18oM+WxoIhgMcKUlobPcE2V6IMsZUUZs1MnOaB0DsnC4M3XuGiyMBN87kY
         yqeM6DTZL5E0utyG9a3y4TwUP1lXWg2QJSuHr37tRpztG5mQXnykLoU1zyf98t2sezFx
         JfsI+OegFQsNje23jw2Wa0dm23vI87IjwX2nEVIOCoZ93al4Hcn1k5+qJpCjSCs8p5kE
         tPtcrSXkVR+dHVWIXhPH67FHQc8SrR91H/ibvcp/5yEDivcBLA+WOlpQts5OURv7oPYp
         bKdzw0UDncL7RFp4KtV+klcxntyuSMSaGBljKNIuNPXNYt59IyXNMoOsa91PMSq2EuDt
         OSXg==
X-Forwarded-Encrypted: i=1; AJvYcCV8r/03X49cLqnx8puAHT09DzzGyZTyUHjz5h2b2fuJaW9eIwif8oI8Gilvc56rrke9U5YJj1+buNNUzhkgpSK8v2Ib03ka5n/FbO0LaLvp7TiifCu0PChwmYzuwYEiw7F2YVTtGbISBQ==
X-Gm-Message-State: AOJu0YzGqyhXkAI/pfYiGdr4Fa0flgto2BFwYc3cnb7uA5niHnFb4BN0
	QvBqh2J7lVjDj3O8k3M5DS/Qizwlfnf3/TKxSuNjMTORZ83GiJ0c
X-Google-Smtp-Source: AGHT+IHuxdHaNTj7uUg4YZXvHOqK3J6+QqpObkDOjVG7/rLFtq6TckteUGsRtSTTw5jPMArfUD8fuw==
X-Received: by 2002:a05:600c:4587:b0:410:5f2f:ba24 with SMTP id r7-20020a05600c458700b004105f2fba24mr654283wmo.36.1707468502203;
        Fri, 09 Feb 2024 00:48:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU2Tiy+O6M8HnHHpdnhfaYBO9GDILs3PraxayUeInXD/FQNeVFFqDpP9cvIj2VDvLQpSL16hHaq6NYgiQl0xiku68jJZbUarnWIm5Uynd8AG0ziwiKLLN3zrvxEUFLKpG8sqzBN6V2PDK+8EYt/qLcxXjG2oNtyLchDkKFY84igUAOzKxZknzNbc88edXa2cVEim4RkUH4J4ubb8vREvigKjR2p/uE9uB0eOlV6u+A3nhk2f0ocOonK1UhkpVZ3a8BMs5lhgj9WSC1KX8ozVQKG8E1NGcNNSQOWO7MP4FTh2oUPV4Id2iKS3vXAm7tzaHj96tqcnj2x+veWjUBi736aRC3MRlm0y4VCkjEVt32esUhvHf+cEWVmKwrrGbOyrFY+onnWKAaWy/PepFKcIQPQHQAqQOvLDfCvGL8XgqCplOIZIe5HhlDImUDvD5hi7miShnN9DHXVaDDMcWSv89azzDowpFofhCLe/SY0ebvBk0nWsvHXDAngFWgSKN+2wcJsDSRU5ozb7eM+F+qY4CQwKB1roiAA9l6q0rx/CzU4oARbeRz3
Received: from eichest-laptop.toradex.int ([2a02:168:af72:0:765:2268:762e:2748])
        by smtp.gmail.com with ESMTPSA id e13-20020a05600c4e4d00b0040fdb244485sm1897494wmq.40.2024.02.09.00.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 00:48:21 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: nick@shmanahar.org,
	dmitry.torokhov@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	linus.walleij@linaro.org
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	francesco.dolcini@toradex.com,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: [PATCH v3 2/2] Input: atmel_mxt_ts - support poweroff in suspend
Date: Fri,  9 Feb 2024 09:48:18 +0100
Message-Id: <20240209084818.14925-1-eichest@gmail.com>
X-Mailer: git-send-email 2.40.1
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
index 542a31448c8f..2d5655385702 100644
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
@@ -3325,6 +3329,8 @@ static int mxt_probe(struct i2c_client *client)
 		msleep(MXT_RESET_INVALID_CHG);
 	}
 
+	data->poweroff_sleep = device_property_read_bool(&client->dev,
+							 "atmel,poweroff-sleep");
 	/*
 	 * Controllers like mXT1386 have a dedicated WAKE line that could be
 	 * connected to a GPIO or to I2C SCL pin, or permanently asserted low.
@@ -3387,12 +3393,21 @@ static int mxt_suspend(struct device *dev)
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
 
@@ -3408,14 +3423,37 @@ static int mxt_resume(struct device *dev)
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


