Return-Path: <linux-kernel+bounces-148206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E2F8A7F39
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B113283420
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744AA13AA2F;
	Wed, 17 Apr 2024 09:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7ZDe6vE"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5338112BF30;
	Wed, 17 Apr 2024 09:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713344760; cv=none; b=M+iksfIqNwtoq7eJyBLCkZeQpEiUNxW+deX1Ksg9CcatP1NCiLEBjBOJ7M7mCey9hotjvzuI1T8d+8v21kYMzA3xQf7XPQlUxjkkXTzQn2wkKi8TbwG7YlRxz+9vdxssiyVcRme2x9fild8uOEs8bo8ycw2DJomm643ujyR04o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713344760; c=relaxed/simple;
	bh=taU1a+PvqEj7zU9d98qqcwVmANraBiwZLPOEA43082Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lYJvViRUTnyLhv0nGjtXICvPTl2CE2AQmpbK4iPpEEaMDmLNjNUp1RA9OIP5OfmK2NDYadKpm97aKerYa9TZOQooKDmgAlzrKSbxgEYCLFGPL/Y6mlXjvM5KSHMpkMDhbE007bKVTjQxlUOXSo4vN2DRa7XQgMuuWLs4+EPKBto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7ZDe6vE; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5176f217b7bso9476367e87.0;
        Wed, 17 Apr 2024 02:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713344752; x=1713949552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RapgrZErc/ITlKzcSUQIzooYAlK8fdOO3y65E56afes=;
        b=N7ZDe6vE8un0C8X62FoeBZI0xVDVATzMKqoMXeeT2/GQH7UfiBetpDC/Sw4Tr+E7gT
         1vDPprmet9IBSxqRzPD2IEYoBGvc34FGk0LTdUK1AF1UvhHu4YZfn1AiNhw2kq/Sb+gM
         KUtQVQWPZ+z0EnXZdK2mhJQSB4YjX+Vx+qW5Ps5w4I9ePAjsf0lIGShg772DFUs6G269
         h0Wt96vDQKX3lOJ65PR/peaAjtyz4lkQ2GMOczioDN6eIly5YxqaiMTBpzaW8K5PIlyx
         v/M7e8Z6u4z4Q0OKiOI/KkbbhqCeG2ajlCXdRF+Cl5qSBBrFfF5n5JaFdSK0Xg3k4o0H
         CyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713344752; x=1713949552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RapgrZErc/ITlKzcSUQIzooYAlK8fdOO3y65E56afes=;
        b=oKog8jW1dYWrneaFYApLk0eMLc5QL/uLAJJX9ysBHhM4KdoIN1mJoOszyTpFznJuU+
         tSSLO3UUdq640U4uyHEpTnkT/p0kvBLgE5geX4jL+b+YlIoVDSsnzumVBuoH7IRuY2Ha
         FEgbmEchiGd+WxqXZbGePlbeIBQ4NDt89AAcB2tgpjMpOSkktgwcxyIJ/WBevcPH5+yT
         74Fi3pAmYkpuijyBA/yDv5DMMOGJsNVENzsjUqB/lMPN32iJ84Tkp6Gfs93YJaTA07Vn
         D+Hn01x0f6pBTaXa44tnUo2IC+L8FY79Ylz/NMUoilHUSLxlrLveb1sVFgUwvm2N88F6
         nJ9A==
X-Forwarded-Encrypted: i=1; AJvYcCWAHSQX4FAtlO5GnojlN+69Li/eXc0pVOycNeMvlhwsJMNM9qMmPkD75qdmhOGn6ChqmYWbjhwZsUIsyo4RM/3rxcTtjEbEK7OYe6iN2wClKfEFvvyyECzriOlqwE9laJ42TgwVAhNf/A==
X-Gm-Message-State: AOJu0YypbUQ6CdZGLl0qezDficeUCgNrFqDt8wjicMxDTcG9O+7R6DM3
	kQ3T8kUqgHyHgRTvT2xU25C/+X2oqf9ns33rmf6thqHy/xvZm1Ar
X-Google-Smtp-Source: AGHT+IGb9+72n5V0xsJVA67N8YPnU7MziiZfTlYdiLX0d1cdd/KwyS2M0kpZ/IL4HChGoZxSrp+hmw==
X-Received: by 2002:a19:6a07:0:b0:513:c61c:7331 with SMTP id u7-20020a196a07000000b00513c61c7331mr11302672lfu.3.1713344752318;
        Wed, 17 Apr 2024 02:05:52 -0700 (PDT)
Received: from eichest-laptop.corp.toradex.com (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id x16-20020a170906135000b00a51a7832a7asm7897814ejb.199.2024.04.17.02.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 02:05:51 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: nick@shmanahar.org,
	dmitry.torokhov@gmail.com,
	robh@kernel.org,
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
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: [PATCH v4 4/4] Input: atmel_mxt_ts - add support for poweroff-sleep
Date: Wed, 17 Apr 2024 11:05:27 +0200
Message-Id: <20240417090527.15357-5-eichest@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240417090527.15357-1-eichest@gmail.com>
References: <20240417090527.15357-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Add support for poweroff-sleep to the Atmel maXTouch driver. This allows
us to power off the input device entirely and only power it on when it
is opened. This will also automatically power it off when we suspend the
system.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 71 +++++++++++++++++++-----
 1 file changed, 57 insertions(+), 14 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 7c807d1f1f9b..f92808be3f5b 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -317,6 +317,7 @@ struct mxt_data {
 	struct gpio_desc *reset_gpio;
 	struct gpio_desc *wake_gpio;
 	bool use_retrigen_workaround;
+	bool poweroff_sleep;
 
 	/* Cached parameters from object table */
 	u16 T5_address;
@@ -2277,6 +2278,19 @@ static void mxt_config_cb(const struct firmware *cfg, void *ctx)
 	release_firmware(cfg);
 }
 
+static int mxt_initialize_after_resume(struct mxt_data *data)
+{
+	const struct firmware *fw;
+
+	mxt_acquire_irq(data);
+
+	firmware_request_nowarn(&fw, MXT_CFG_NAME, &data->client->dev);
+
+	mxt_config_cb(fw, data);
+
+	return 0;
+}
+
 static void mxt_debug_init(struct mxt_data *data);
 
 static int mxt_device_register(struct mxt_data *data)
@@ -2341,17 +2355,23 @@ static int mxt_initialize(struct mxt_data *data)
 	if (error)
 		return error;
 
-	error = mxt_acquire_irq(data);
-	if (error)
-		return error;
+	if (data->poweroff_sleep) {
+		error = mxt_device_register(data);
+		if (error)
+			return error;
+	} else {
+		error = mxt_acquire_irq(data);
+		if (error)
+			return error;
 
-	error = request_firmware_nowait(THIS_MODULE, true, MXT_CFG_NAME,
-					&client->dev, GFP_KERNEL, data,
-					mxt_config_cb);
-	if (error) {
-		dev_err(&client->dev, "Failed to invoke firmware loader: %d\n",
-			error);
-		return error;
+		error = request_firmware_nowait(THIS_MODULE, true, MXT_CFG_NAME,
+						&client->dev, GFP_KERNEL, data,
+						mxt_config_cb);
+		if (error) {
+			dev_err(&client->dev, "Failed to invoke firmware loader: %d\n",
+				error);
+			return error;
+		}
 	}
 
 	return 0;
@@ -3089,6 +3109,9 @@ static ssize_t mxt_update_fw_store(struct device *dev,
 	struct mxt_data *data = dev_get_drvdata(dev);
 	int error;
 
+	if (data->poweroff_sleep && !data->in_bootloader)
+		mxt_power_on(data);
+
 	error = mxt_load_fw(dev, MXT_FW_NAME);
 	if (error) {
 		dev_err(dev, "The firmware update failed(%d)\n", error);
@@ -3101,6 +3124,9 @@ static ssize_t mxt_update_fw_store(struct device *dev,
 			return error;
 	}
 
+	if (data->poweroff_sleep && !data->in_bootloader)
+		mxt_power_off(data);
+
 	return count;
 }
 
@@ -3123,7 +3149,12 @@ static const struct attribute_group mxt_attr_group = {
 
 static void mxt_start(struct mxt_data *data)
 {
-	mxt_wakeup_toggle(data->client, true, false);
+	if (data->poweroff_sleep) {
+		mxt_power_on(data);
+		mxt_initialize_after_resume(data);
+	} else {
+		mxt_wakeup_toggle(data->client, true, false);
+	}
 
 	switch (data->suspend_mode) {
 	case MXT_SUSPEND_T9_CTRL:
@@ -3160,7 +3191,12 @@ static void mxt_stop(struct mxt_data *data)
 		break;
 	}
 
-	mxt_wakeup_toggle(data->client, false, false);
+	if (data->poweroff_sleep) {
+		disable_irq(data->irq);
+		mxt_power_off(data);
+	} else {
+		mxt_wakeup_toggle(data->client, false, false);
+	}
 }
 
 static int mxt_input_open(struct input_dev *dev)
@@ -3357,6 +3393,8 @@ static int mxt_probe(struct i2c_client *client)
 	if (error)
 		return error;
 
+	data->poweroff_sleep = device_property_read_bool(&client->dev,
+							 "atmel,poweroff-sleep");
 	/*
 	 * Controllers like mXT1386 have a dedicated WAKE line that could be
 	 * connected to a GPIO or to I2C SCL pin, or permanently asserted low.
@@ -3387,6 +3425,9 @@ static int mxt_probe(struct i2c_client *client)
 		goto err_free_object;
 	}
 
+	if (data->poweroff_sleep && !data->in_bootloader)
+		mxt_power_off(data);
+
 	return 0;
 
 err_free_object:
@@ -3406,7 +3447,8 @@ static void mxt_remove(struct i2c_client *client)
 	sysfs_remove_group(&client->dev.kobj, &mxt_attr_group);
 	mxt_free_input_device(data);
 	mxt_free_object_table(data);
-	mxt_power_off(data);
+	if (!data->poweroff_sleep)
+		mxt_power_off(data);
 }
 
 static int mxt_suspend(struct device *dev)
@@ -3439,7 +3481,8 @@ static int mxt_resume(struct device *dev)
 	if (!input_dev)
 		return 0;
 
-	enable_irq(data->irq);
+	if (!data->poweroff_sleep)
+		enable_irq(data->irq);
 
 	mutex_lock(&input_dev->mutex);
 
-- 
2.40.1


