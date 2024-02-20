Return-Path: <linux-kernel+bounces-73717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1789B85C7AE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C217F2835BF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD33A152E16;
	Tue, 20 Feb 2024 21:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1mZ5kjC"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC93D151CEE;
	Tue, 20 Feb 2024 21:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708463704; cv=none; b=lWuIsejid2fGd0k93E9OZQY9ARAtbePnr1pPwY/HuGDIXGa8z8e9DquFG18M8ZNk7NK+Uen8XWJHPRogtUGu+dyg7FNn8mkZhZDaABTAk2mSkyGWaitTXYabZEnIOsQ/htuoIR0px9WBMCy0IVCLKRL7X05rnfSS5P1as0e7ysw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708463704; c=relaxed/simple;
	bh=cqOSJPfWwGG7Yezb8uUM7UN+OOm6cCM3Di28hr7D9+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sNog9JGtq15BJLBKnjT7hxpMUHUupU/tJEQP3SZV4gw3tlIhHh1yVfmPgJi8656xlblUL8Cq0ZmPQ3gjHRl8TsKJgzx8IQ4mO48+hK2bhVB3skcBojr/MOry1yp/VBnxxz1UAaWxEES35ACc3ZkGQO7dtURg149aUc9FH8i67iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1mZ5kjC; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d0e520362cso60399781fa.2;
        Tue, 20 Feb 2024 13:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708463701; x=1709068501; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3YzuvLMT8Yp5BNl7yqqYggipfEnF06swjFmuzM89Bb8=;
        b=U1mZ5kjCjsL570UkSgYX2EsP+Y0pZagCSNJ6pZX+N6lgUFon0chbBtKsLFQjkFgywa
         Ru26bfT/xEU+jKARjh88IgBG7THyEdKvWTGwCCWQLWV+HCVI7aTziwZxEab/skhq++81
         uBiXq8rjEsOQDbfMSZMghqoViARscCFpVo0blEQtGmjB+M6vSJ5Lzua3+pZi1bvIWrIC
         Kph1mrf0M7/BX+xxNiD828/m/1ViJLqRzEDWD0CTjWqDVULHnfBp64BKlRP0XwZJ4jGD
         mEF1jCHisviIsWfFYJvmSv0RxcwlcKUCWx9U1iPFkNM5/t0tc4kP/4DO6wRgs9BbWW++
         OI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708463701; x=1709068501;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3YzuvLMT8Yp5BNl7yqqYggipfEnF06swjFmuzM89Bb8=;
        b=qhfJfyNCeO1CJTRBocRrL4y0EWuDusogRWjIIRDDuygZv61ezGAAnle9RbyEKH2ig9
         qazRJiZQ+kEO/K+tQiiu0Q8AvwtkISauuu8aRzxkux1SbtBfS2EJHE+GN3PNW+anQ6R2
         QRAftYJC+ckX4kiXIoez+h6ZIaCuJbb3tg+FsOm7qXd9F02YS0k8+p/8TGBmQj8PJlej
         PJlbKN9RXv4e62Vv0mVc18T8Fq9/u4pDsMgVsm/i3DXEVT637LOOYAzfmffWZ02dTl+q
         89TIEtmpthL/16331vek/5KvDJvaahaNeqdWAP+xbwBG7AkC/pT7PiL2PkLd564Ly9qT
         G2dQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCCCeuRBFkLGEuPYgzcGSTFeIsMD93jRJP2Q1825Ik2+jsduO151L/WoXZDl/34wKAA3punJEZkWl+vQr49+8MnB/EDpa5WG+97Wkk6A5jPLaUMD58ZeAajWvnI0Exh/HPVqQflNkfVA2ECwLXBs//0aRPb2RUcmN0Bc1A3at/WG47bA==
X-Gm-Message-State: AOJu0Ywg5H3Pms9yRPEtQUmSQ30a9Lf3OMUEWHyglKKlE+jo8eaI0Rbq
	bltsjUeDBIpA87Sufy8wEVUMGkYF9KNZhNSK2kE+8PI+AOoFBTpVenG+eVzDSNrBAg==
X-Google-Smtp-Source: AGHT+IHVlNZeOv9cbFxBjYaIN1FD87UJMYPKf2Mi0lXkNOsm0UPAihO0bxKubJmvVct3Dv2oIzYsOA==
X-Received: by 2002:a05:651c:2227:b0:2d2:20ad:a51 with SMTP id y39-20020a05651c222700b002d220ad0a51mr9373588ljq.0.1708463700716;
        Tue, 20 Feb 2024 13:15:00 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-d60d-797f-077b-a805.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:d60d:797f:77b:a805])
        by smtp.gmail.com with ESMTPSA id fj21-20020a0564022b9500b00564da28dfe2sm538137edb.19.2024.02.20.13.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 13:15:00 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 20 Feb 2024 22:14:56 +0100
Subject: [PATCH 2/4] iio: humidity: hdc3020: add power management
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-hdc3020-pm-v1-2-d8e60dbe79e9@gmail.com>
References: <20240220-hdc3020-pm-v1-0-d8e60dbe79e9@gmail.com>
In-Reply-To: <20240220-hdc3020-pm-v1-0-d8e60dbe79e9@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Li peiyu <579lpy@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev-8b532
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708463696; l=4928;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=cqOSJPfWwGG7Yezb8uUM7UN+OOm6cCM3Di28hr7D9+A=;
 b=Dw+Eu0IqRKs2r6dhcLGvcEVgTD6kgT1MOkD0wWGepF46ll3JDc7ez9kjM3voW5mk3B/t+CNDv
 dhY/99MYmgxB30bMG24PbVSWKiF2S0WUdSqJRT4b+0Eww+9Q6fLHRrW
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

The HDC3020 sensor carries out periodic measurements during normal
operation, but as long as the power supply is enabled, it will carry on
in low-power modes. In order to avoid that and reduce power consumption,
the device can be switched to Trigger-on Demand mode, and if possible,
turn off its regulator.

According to the datasheet, the maximum "Power Up Ready" is 5 ms.

Add resume/suspend pm operations to manage measurement mode and
regulator state.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/humidity/hdc3020.c | 81 +++++++++++++++++++++++++++++++++---------
 1 file changed, 65 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc3020.c
index 11ede97a31d7..0da5c5c41cd2 100644
--- a/drivers/iio/humidity/hdc3020.c
+++ b/drivers/iio/humidity/hdc3020.c
@@ -20,6 +20,8 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/pm.h>
+#include <linux/regulator/consumer.h>
 #include <linux/units.h>
 
 #include <asm/unaligned.h>
@@ -68,6 +70,7 @@
 
 struct hdc3020_data {
 	struct i2c_client *client;
+	struct regulator *vdd_supply;
 	/*
 	 * Ensure that the sensor configuration (currently only heater is
 	 * supported) will not be changed during the process of reading
@@ -551,9 +554,39 @@ static const struct iio_info hdc3020_info = {
 	.write_event_value = hdc3020_write_thresh,
 };
 
-static void hdc3020_stop(void *data)
+static int hdc3020_power_on(struct hdc3020_data *data)
 {
-	hdc3020_exec_cmd((struct hdc3020_data *)data, HDC3020_EXIT_AUTO);
+	int ret;
+
+	ret = regulator_enable(data->vdd_supply);
+	if (ret)
+		return ret;
+
+	fsleep(5000);
+
+	if (data->client->irq) {
+		/*
+		 * The alert output is activated by default upon power up,
+		 * hardware reset, and soft reset. Clear the status register.
+		 */
+		ret = hdc3020_exec_cmd(data, HDC3020_S_STATUS);
+		if (ret)
+			return ret;
+	}
+
+	return hdc3020_exec_cmd(data, HDC3020_S_AUTO_10HZ_MOD0);
+}
+
+static int hdc3020_power_off(struct hdc3020_data *data)
+{
+	hdc3020_exec_cmd(data, HDC3020_EXIT_AUTO);
+
+	return regulator_disable(data->vdd_supply);
+}
+
+static void hdc3020_exit(void *data)
+{
+	hdc3020_power_off((struct hdc3020_data *)data);
 }
 
 static int hdc3020_probe(struct i2c_client *client)
@@ -569,6 +602,8 @@ static int hdc3020_probe(struct i2c_client *client)
 	if (!indio_dev)
 		return -ENOMEM;
 
+	dev_set_drvdata(&client->dev, (void *)indio_dev);
+
 	data = iio_priv(indio_dev);
 	data->client = client;
 	mutex_init(&data->lock);
@@ -580,6 +615,14 @@ static int hdc3020_probe(struct i2c_client *client)
 	indio_dev->info = &hdc3020_info;
 	indio_dev->channels = hdc3020_channels;
 	indio_dev->num_channels = ARRAY_SIZE(hdc3020_channels);
+
+	data->vdd_supply = devm_regulator_get(&client->dev, "vdd");
+	if (IS_ERR(data->vdd_supply))
+		return dev_err_probe(&client->dev, PTR_ERR(data->vdd_supply),
+				     "Unable to get VDD regulator\n");
+
+	hdc3020_power_on(data);
+
 	if (client->irq) {
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
 						NULL, hdc3020_interrupt_handler,
@@ -588,22 +631,9 @@ static int hdc3020_probe(struct i2c_client *client)
 		if (ret)
 			return dev_err_probe(&client->dev, ret,
 					     "Failed to request IRQ\n");
-
-		/*
-		 * The alert output is activated by default upon power up,
-		 * hardware reset, and soft reset. Clear the status register.
-		 */
-		ret = hdc3020_exec_cmd(data, HDC3020_S_STATUS);
-		if (ret)
-			return ret;
 	}
 
-	ret = hdc3020_exec_cmd(data, HDC3020_S_AUTO_10HZ_MOD0);
-	if (ret)
-		return dev_err_probe(&client->dev, ret,
-				     "Unable to set up measurement\n");
-
-	ret = devm_add_action_or_reset(&data->client->dev, hdc3020_stop, data);
+	ret = devm_add_action_or_reset(&data->client->dev, hdc3020_exit, data);
 	if (ret)
 		return ret;
 
@@ -614,6 +644,24 @@ static int hdc3020_probe(struct i2c_client *client)
 	return 0;
 }
 
+static int hdc3020_suspend(struct device *dev)
+{
+	struct iio_dev *iio_dev = dev_get_drvdata(dev);
+	struct hdc3020_data *data = iio_priv(iio_dev);
+
+	return hdc3020_power_off(data);
+}
+
+static int hdc3020_resume(struct device *dev)
+{
+	struct iio_dev *iio_dev = dev_get_drvdata(dev);
+	struct hdc3020_data *data = iio_priv(iio_dev);
+
+	return hdc3020_power_on(data);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(hdc3020_pm_ops, hdc3020_suspend, hdc3020_resume);
+
 static const struct i2c_device_id hdc3020_id[] = {
 	{ "hdc3020" },
 	{ "hdc3021" },
@@ -633,6 +681,7 @@ MODULE_DEVICE_TABLE(of, hdc3020_dt_ids);
 static struct i2c_driver hdc3020_driver = {
 	.driver = {
 		.name = "hdc3020",
+		.pm = pm_sleep_ptr(&hdc3020_pm_ops),
 		.of_match_table = hdc3020_dt_ids,
 	},
 	.probe = hdc3020_probe,

-- 
2.40.1


