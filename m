Return-Path: <linux-kernel+bounces-89919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5824586F74F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 22:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF709281013
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 21:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7907AE6E;
	Sun,  3 Mar 2024 21:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmcKH3Bl"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7047E7A711;
	Sun,  3 Mar 2024 21:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709502869; cv=none; b=Hixs2F3GZ2YNQhvoqkHMDIQXh0h5w26N1SIP9BdVescbREY7ot3JTRCAvMr6FE5vqktRhQh9TPbIqcpRI6ezwJFUxbDqreRMHIlx+M561jjPh5bhxu5F8wxQ3I/aLfKYsRj0LCDGIRpxa6Uw2/eLLqxp7d1u6nFY+WkVJkZzZxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709502869; c=relaxed/simple;
	bh=OV2BerEmGLyPMQ/gowlOSwu8bjIp13BojidEhFbGVVY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iJeK/PGtw78/sPwxAcZe1o6meJAhQdKb+tiqzA6VP4P/KpxpZKoqc7k5VsMlcFb5hcYjzbFjnIjzbQHmf4ax7iQs1p5WYSHKsDBfVEWpwada6NfOCTAmiA7pnK4RQAc2vnM3PVRJ2DWiG4PS3T22DCsAiYJhTNa4BMHi+p6ciQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gmcKH3Bl; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-564647bcdbfso4483697a12.2;
        Sun, 03 Mar 2024 13:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709502865; x=1710107665; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Ho0szSHDTNaBA5W7zm6nIHAh8L8WnnynqO9y1D6L1U=;
        b=gmcKH3BlSJt3jNUexJ7TrI8tj1AIsNM5i+we38/8Xmp77gqmuR5A9rTlSx8LucVUdi
         3EhxF2yFYRhP27rBdM6gPTvb/Z0oJN2gjx3y/RURty2ecSNAhmk8gIqryLNqvj+tqUwK
         bwcmpVb6MmYSXFkX0NNj6iCy0QVWUU37QFPNnSo6P1GaXvD85PoUZgBJhRdPgZzHhcAX
         hkcUzxGOFxiK7IqbmUxazQM3jIaoNw9JgCbZBDXDi11KmdwLaDukrAkWmSuclVMHBw0K
         o2oEP0suWmyS1YWZf2E0E8hXNqiVQpAvZNwMY5H3TXwuBot24NoczXJ/XQgDSxRIBZcR
         rsPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709502865; x=1710107665;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Ho0szSHDTNaBA5W7zm6nIHAh8L8WnnynqO9y1D6L1U=;
        b=YXU6kN2kt6bQqIiRiUOQzB13ft7OeT6WwcvwVSN8EHgOqVLwDxM+QaDqGz34QMi1ho
         hn8h7hd5p6v1RszV2QubTHzxw70687MuRiNeYL7lvlGAbSZk9cmkj5F3WUwnABd2UU7S
         WvdRBd3iJlYJVneLX3XkP5GTuRFGwc0K53JO4kMLoCAqAh77n9oiSU+ZaQgiPDFb5ILV
         JFl3GSYLV3rB6a7q2gno+g/s/dxuEEfdhNqzR316HBNAiHiwdRX8rzaB3XqQv8yaDFK7
         grFrsSZvXhxulNFd4+Ya7SBU28Y9UoOqa5Ff9pe6kIcgyQI5t7QeZxraMPiqVGKGrFo+
         +sjA==
X-Forwarded-Encrypted: i=1; AJvYcCVqLtlIzJ4kPRlim7yQfeQa2NwqmsZI9Qz/ly2wgIcU8RgniWbPWnMBfYrFPzIWSjJjsPT0eMOie0UNu3IAFC5aTGMZpDtqjj8N5Spj40HNmvPngoPc+Tb5UlC8DE3faReMOZKNkxxo6EHWvQU6RbKV00S/e+XQ9RdeAJj/iifLF2MHfA==
X-Gm-Message-State: AOJu0YyLNrHD/HcIBQL9rdK0gRQ/BdC5NmXJx1dyaLHRtDySPrL2pFBM
	FSc1ILq0RjEAeQ4W/b8mekmd+cpjRcn0gA9fa1qGlViJrQjhTzz0ge3WrqfMAoo+tg==
X-Google-Smtp-Source: AGHT+IGTf2zlY4nMs6fsLtpP3ttwdiS4Jm7qw733rstZj4C4IUwxzxePw3TOnmBp1kIqwOkONFt03g==
X-Received: by 2002:a05:6402:2317:b0:566:43ab:8b78 with SMTP id l23-20020a056402231700b0056643ab8b78mr5310243eda.30.1709502864884;
        Sun, 03 Mar 2024 13:54:24 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-b3d8-5b4b-5188-4373.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b3d8:5b4b:5188:4373])
        by smtp.gmail.com with ESMTPSA id n22-20020a05640205d600b00566d6950d14sm2783250edx.92.2024.03.03.13.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 13:54:24 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 03 Mar 2024 22:54:20 +0100
Subject: [PATCH v3 1/3] iio: humidity: hdc3020: add power management
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240303-hdc3020-pm-v3-1-48bc02b5241b@gmail.com>
References: <20240303-hdc3020-pm-v3-0-48bc02b5241b@gmail.com>
In-Reply-To: <20240303-hdc3020-pm-v3-0-48bc02b5241b@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Li peiyu <579lpy@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709502861; l=5255;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=OV2BerEmGLyPMQ/gowlOSwu8bjIp13BojidEhFbGVVY=;
 b=Mf1F2FjClyyJhbpKfUhEBNZCuqeHHMXL9e7VJOLYtdfVXn3Ko6larZLZ7V+5BdMUvi7ZNAxJU
 5pPmqhWY8ywCwOMjPjU1nefZfQvJQLrx6AKlzIBUj6zV6gxgxbAfAGu
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
 drivers/iio/humidity/hdc3020.c | 95 +++++++++++++++++++++++++++++++++---------
 1 file changed, 76 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc3020.c
index 1e5d0d4797b1..7f93024b850c 100644
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
@@ -551,9 +554,45 @@ static const struct iio_info hdc3020_info = {
 	.write_event_value = hdc3020_write_thresh,
 };
 
-static void hdc3020_stop(void *data)
+static int hdc3020_power_off(struct hdc3020_data *data)
 {
-	hdc3020_exec_cmd((struct hdc3020_data *)data, HDC3020_EXIT_AUTO);
+	hdc3020_exec_cmd(data, HDC3020_EXIT_AUTO);
+
+	return regulator_disable(data->vdd_supply);
+}
+
+static int hdc3020_power_on(struct hdc3020_data *data)
+{
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
+		if (ret) {
+			hdc3020_power_off(data);
+			return ret;
+		}
+	}
+
+	ret = hdc3020_exec_cmd(data, HDC3020_S_AUTO_10HZ_MOD0);
+	if (ret)
+		hdc3020_power_off(data);
+
+	return ret;
+}
+
+static void hdc3020_exit(void *data)
+{
+	hdc3020_power_off(data);
 }
 
 static int hdc3020_probe(struct i2c_client *client)
@@ -569,6 +608,8 @@ static int hdc3020_probe(struct i2c_client *client)
 	if (!indio_dev)
 		return -ENOMEM;
 
+	dev_set_drvdata(&client->dev, indio_dev);
+
 	data = iio_priv(indio_dev);
 	data->client = client;
 	mutex_init(&data->lock);
@@ -580,6 +621,20 @@ static int hdc3020_probe(struct i2c_client *client)
 	indio_dev->info = &hdc3020_info;
 	indio_dev->channels = hdc3020_channels;
 	indio_dev->num_channels = ARRAY_SIZE(hdc3020_channels);
+
+	data->vdd_supply = devm_regulator_get(&client->dev, "vdd");
+	if (IS_ERR(data->vdd_supply))
+		return dev_err_probe(&client->dev, PTR_ERR(data->vdd_supply),
+				     "Unable to get VDD regulator\n");
+
+	ret = hdc3020_power_on(data);
+	if (ret)
+		return dev_err_probe(&client->dev, ret, "Power on failed\n");
+
+	ret = devm_add_action_or_reset(&data->client->dev, hdc3020_exit, data);
+	if (ret)
+		return ret;
+
 	if (client->irq) {
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
 						NULL, hdc3020_interrupt_handler,
@@ -588,25 +643,8 @@ static int hdc3020_probe(struct i2c_client *client)
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
-	if (ret)
-		return ret;
-
 	ret = devm_iio_device_register(&data->client->dev, indio_dev);
 	if (ret)
 		return dev_err_probe(&client->dev, ret, "Failed to add device");
@@ -614,6 +652,24 @@ static int hdc3020_probe(struct i2c_client *client)
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
@@ -633,6 +689,7 @@ MODULE_DEVICE_TABLE(of, hdc3020_dt_ids);
 static struct i2c_driver hdc3020_driver = {
 	.driver = {
 		.name = "hdc3020",
+		.pm = pm_sleep_ptr(&hdc3020_pm_ops),
 		.of_match_table = hdc3020_dt_ids,
 	},
 	.probe = hdc3020_probe,

-- 
2.40.1


