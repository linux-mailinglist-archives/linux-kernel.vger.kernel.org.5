Return-Path: <linux-kernel+bounces-82335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 954408682F8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4944D28C20E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE334131E3F;
	Mon, 26 Feb 2024 21:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzyLjoXo"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371C2130E46;
	Mon, 26 Feb 2024 21:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708982763; cv=none; b=K25SGemTf4c2KzWT4bYAR0EFLt+K8cLLlvXFOAM3PrXqnU7+3Yce6tmCdqG8Ch/OcbFXx0CQBzPfgpLSDQUiWWf1bzYrxFwYkil0glqFp4N47GwjRaMSUyvNzrcCuC+0La4J6hTBR4XLdpBF1rAlEQGsprtkfqtN4fhEXfAY48A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708982763; c=relaxed/simple;
	bh=v4m1Put7F/TGBgZJ2VHhefokJAsChLTIJYhfwC0AZyY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FxI/KpBLqEvaaNH547wVGy2RG5z8qIAsh51Tsn3oJOQRS6AkaJ1x873+U3JabMc5a285EHOsxrfIKGLAlVb8zW24NsrCYEriNZfCdBWlh9lBQLwM0ayVF90s9PNcllSjF6aD1NhthboWG0vtKDqfcpT/b8gatm6bgSUHd55WqSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzyLjoXo; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55f50cf2021so5467639a12.1;
        Mon, 26 Feb 2024 13:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708982759; x=1709587559; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3wukwNEIF4iZyo0L2rgyE4uUoJ+QW5CahBwhrSw6xvg=;
        b=VzyLjoXosd0aIj8eghxIWDkyPF3FChdyEQosniA5hwA6lGiEiV7xk1ZPv5+12mN93/
         OLF48I189pxBWNA+shkO6j3XiDIuUVLeTPmK2ER/uYdx9iwKeNkIBQLd5gSrzNmX4WX2
         B1mud9aabXjC8xTWFBEJuPkCFffvsyd6LcxYOZMw+U04ipdY6CzIxF+4f/NckMES/wl5
         AuJYJqg/CDRnOb7kGz5t2FI0RDR3j2t+c0HliVnnQSRncX7dHmTojhDYG9jEEThKOhz1
         8MheKdNLxNYdP7aBx133/qqgYlXg2Ofy2heOiIeUYqUBADiCyjuDTJNJYH4d4jR1VmzP
         MPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708982759; x=1709587559;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3wukwNEIF4iZyo0L2rgyE4uUoJ+QW5CahBwhrSw6xvg=;
        b=YNsXzVLqBHzCgnllL9FEyULVrsU5ZIZ9jYzRnhvYCiWim5Tq2gxtcpBY/vHSU5oNyS
         uL0pGOWa5/UwVtA6xpW1UcTslLKkYjVlstSpRemzEUYp3Ps3viQcBNGOw6scJmty1OCm
         E8pvPsSeojwN27PtAdwNpJAp/LHiT8BFha4XerLhWqJdSphbaqCKqs1rTnNyQk3qbE0C
         vONUE6RkoBUtVQr8kvI1T8/rw/0HQ9A8sHiBRkorhgA6uT6MYfr9k5mV9Q4K7J0YshOj
         jlVrkC2A2nWHp3YNrHEGC8vI2C0hw7uutoAO4RWzWwKUwamPTfn/5VXSwJoaHwIlXuaq
         rZeg==
X-Forwarded-Encrypted: i=1; AJvYcCWEB7Rjwy1mrcMgqGonM6OnqUwWRc6KlcvfIX6Nr3sTdABe75TE01W3+7r8aSllPGerWyQLzjHhLOjxo6fpd0Dxupw1SxnfnvSt7Ic9sLGdY8al2BOkv4ZCAklfaW2eRK0PU/72Zh52ovFFEKI9f+y5+L3cIsjvVsXW3HzFxDhgx9oWrQ==
X-Gm-Message-State: AOJu0YzfPuSpw1btn08FjZ6xt2uGit3zOsDFCmRfZRn/cHTpk5IkwSiW
	qndgpyQp/pBX516rKS8BwgyPHEyIG4XJ0BqBOVtkHwv+iyaXFBHHRWSJvRHA9Al7iQ==
X-Google-Smtp-Source: AGHT+IGxnFljQEIYi3VBFCJzj7EevLLTTAHiRGmOj+Mp5vpmt4d3/gZI0StlbgRMyjYh8HIPHFkKyw==
X-Received: by 2002:a17:906:cb8c:b0:a3f:c4f9:eb16 with SMTP id mf12-20020a170906cb8c00b00a3fc4f9eb16mr5139178ejb.20.1708982759199;
        Mon, 26 Feb 2024 13:25:59 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-06e1-5ae1-dc32-d149.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:6e1:5ae1:dc32:d149])
        by smtp.gmail.com with ESMTPSA id uz28-20020a170907119c00b00a3df13a4fe0sm122386ejb.15.2024.02.26.13.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 13:25:58 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 26 Feb 2024 22:25:55 +0100
Subject: [PATCH v2 1/3] iio: humidity: hdc3020: add power management
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-hdc3020-pm-v2-1-cec6766086e8@gmail.com>
References: <20240226-hdc3020-pm-v2-0-cec6766086e8@gmail.com>
In-Reply-To: <20240226-hdc3020-pm-v2-0-cec6766086e8@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708982756; l=5085;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=v4m1Put7F/TGBgZJ2VHhefokJAsChLTIJYhfwC0AZyY=;
 b=F40Faja/hEvhjLltiGyber32qa6JIZcO3Kpcr88hZsEsLRDV7IDDJOGKtoDIu5n07O9WFT1EF
 HTC3cltRbEbBgHbFUKtUgiJlirwI8OGbq/Jgo+dgpBE56jVD5EvdzT1
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
 drivers/iio/humidity/hdc3020.c | 89 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 73 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc3020.c
index 1e5d0d4797b1..6848be41e1c8 100644
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
 
+	dev_set_drvdata(&client->dev, (void *)indio_dev);
+
 	data = iio_priv(indio_dev);
 	data->client = client;
 	mutex_init(&data->lock);
@@ -580,6 +621,16 @@ static int hdc3020_probe(struct i2c_client *client)
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
 	if (client->irq) {
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
 						NULL, hdc3020_interrupt_handler,
@@ -588,22 +639,9 @@ static int hdc3020_probe(struct i2c_client *client)
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


