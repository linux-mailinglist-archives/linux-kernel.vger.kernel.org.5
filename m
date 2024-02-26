Return-Path: <linux-kernel+bounces-82337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 576F48682FF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DF441F26B19
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2B5132465;
	Mon, 26 Feb 2024 21:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="go/dzltW"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB71132467;
	Mon, 26 Feb 2024 21:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708982766; cv=none; b=VyKpYHJj0TxFbrzpBWYuCPTzq7dtQSJFdkgPd2Ini6GRcH4vxdlzEb6nCcnphocf4zexWy1axY7nLEuxcPMGi2I7BhAcA21yHorrEkRtH81BALVy0VzEtAksZkbr+yy7ic02NgLHucQIMeKI23hz1RJrEqCrBT/3wFtsCCd9dAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708982766; c=relaxed/simple;
	bh=+aZznYEEJnxpn3Hfp1CaaYgaYW/C+miPXfNVer03ZgQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sznuEA5EDp/NsBYL1M+rA7hheHCfRdNXUufBQd5tM+Yfxl2X08Dv/AOMY63DMi5MEsbTcKcBNDXPX8CJe880emPwIztkNHiP2V7HiiK1ufxEWB9znypMwu3tvG9KArByKUqp29p+wufsPLLsRN8ty/2mI4SVWTqeOvRO5jk5cy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=go/dzltW; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512f6f263a6so1609308e87.2;
        Mon, 26 Feb 2024 13:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708982762; x=1709587562; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=144mFCoAmLnYhpxBxU841lMdT4yO+1U9AQuLuH2HZyw=;
        b=go/dzltWJvq453cg6xIphjT9bHHy1Tm4rfMV5KKuNt+xkMir0bfn7NirrZ0tWqRO9B
         Prt4wPjurTd7oA1r0tBGifpmnA8w9hKiydBOtTPeHZvDJKoy0fohSIH2jjquZfTCD6vT
         1EVqQWLf35J4lcs/SRiDRP2njOXnwHHubxKn+5SHrOzJHTP7jUze06HbGLbyPPNBiaDn
         /NWUVaPZoZWMIQhiTj5nUu/pPWFvkTJdxUwUz1LfSTACWTCBzgA9m2cUc/4y01c2ceC4
         APkvW0qZ/HEvUTpcNzxB74b650B9cj+pofZ/qTtAbbEqS/1/KvzjaATKmBWRBqzzSN0M
         UsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708982762; x=1709587562;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=144mFCoAmLnYhpxBxU841lMdT4yO+1U9AQuLuH2HZyw=;
        b=Zg8s+hfaC6fNXHjh4jvzcTWkpYTUAHJxuOiaHYavATpZrN+ZD0chEoH3kAEoaTy2Qb
         1Sq+EvLegXZq8ZLRbvpsLJYcGdMrQ7qO09+c8lkXvsQaKztEvgPm7L6cX1AgaHD82+zK
         YuN1jqEztXPSvEVGuA+Uq+v01Fnag9JHdwNuvwnmQuz0s+9qittNb7WOZ69LDUJ4PGgD
         wWI813t0W2Z1d/jgqW0CzJFlIr1B6eM3HMGxtYUns3YTedcjdwZXjiaiJi5jnL9PtUo/
         LcaO9m7OafEzgY20U9SGgLpk385zg8AUShogEQaqCmKww0A92RUBOY4SzpgHuzsBYohf
         +9zw==
X-Forwarded-Encrypted: i=1; AJvYcCUpz8TWxSC/0CvZ6R61PIAf1Id7TepTNJy1C4aGPQCBpNeSkm5+zSnWbinQGMBs86DSdDNJ1HfyLJZsye3PaB6QZbK4O56pvy5uPHv7VXvF4wAEsOXcVByM8cOsioorpL03GNGjIlJsyfgqvf9+bdiZITXWyfM/204gwvCKcWJk99cGJQ==
X-Gm-Message-State: AOJu0Yy/izbCtsc7pJ+n9PD1IJ57cdrw9oi9q8GANjnYDMDSW05KgpqR
	xhUu60lVVuC017QV9HWkhvgcv+1yFlU2qMRFgV4nWRzbXNQhFgzbg8+phF1tQWw=
X-Google-Smtp-Source: AGHT+IFQLy90dKHP1KmZIFww9MmLvhA0blg1bSFrxq0mZJs4PHyAwh+6VgF2nnwMNyfYZ/ajg1W5sw==
X-Received: by 2002:ac2:4ecf:0:b0:512:d4fb:14da with SMTP id p15-20020ac24ecf000000b00512d4fb14damr4799760lfr.44.1708982762327;
        Mon, 26 Feb 2024 13:26:02 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-06e1-5ae1-dc32-d149.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:6e1:5ae1:dc32:d149])
        by smtp.gmail.com with ESMTPSA id uz28-20020a170907119c00b00a3df13a4fe0sm122386ejb.15.2024.02.26.13.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 13:26:01 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 26 Feb 2024 22:25:57 +0100
Subject: [PATCH v2 3/3] iio: humidity: hdc3020: add reset management
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-hdc3020-pm-v2-3-cec6766086e8@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708982756; l=2300;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=+aZznYEEJnxpn3Hfp1CaaYgaYW/C+miPXfNVer03ZgQ=;
 b=CZMSC7gN5LcIOZou5QfuhlYuJ+aLxLzWNTgKdYnWvtbl6n34l0Vn2Iy1YDlOp497+AzeeU5Wa
 ppLyaUJsXAsDcbgbfAKxlBH9dEMdJQZAFrJ8mvyxhIC60dUF52FpUgX
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

The HDC3020 provides an active low reset signal that must be handled if
connected. Asserting this signal turns the device into Trigger-on Demand
measurement mode, reducing its power consumption when no measurements
are required like in low-power modes.

According to the datasheet, the longest "Reset Ready" is 3 ms, which is
only taken into account if the reset signal is defined.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/humidity/hdc3020.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc3020.c
index 6848be41e1c8..aa477b5e583e 100644
--- a/drivers/iio/humidity/hdc3020.c
+++ b/drivers/iio/humidity/hdc3020.c
@@ -15,6 +15,7 @@
 #include <linux/cleanup.h>
 #include <linux/crc8.h>
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -70,6 +71,7 @@
 
 struct hdc3020_data {
 	struct i2c_client *client;
+	struct gpio_desc *reset_gpio;
 	struct regulator *vdd_supply;
 	/*
 	 * Ensure that the sensor configuration (currently only heater is
@@ -558,6 +560,9 @@ static int hdc3020_power_off(struct hdc3020_data *data)
 {
 	hdc3020_exec_cmd(data, HDC3020_EXIT_AUTO);
 
+	if (data->reset_gpio)
+		gpiod_set_value_cansleep(data->reset_gpio, 1);
+
 	return regulator_disable(data->vdd_supply);
 }
 
@@ -571,6 +576,11 @@ static int hdc3020_power_on(struct hdc3020_data *data)
 
 	fsleep(5000);
 
+	if (data->reset_gpio) {
+		gpiod_set_value_cansleep(data->reset_gpio, 0);
+		fsleep(3000);
+	}
+
 	if (data->client->irq) {
 		/*
 		 * The alert output is activated by default upon power up,
@@ -627,6 +637,12 @@ static int hdc3020_probe(struct i2c_client *client)
 		return dev_err_probe(&client->dev, PTR_ERR(data->vdd_supply),
 				     "Unable to get VDD regulator\n");
 
+	data->reset_gpio = devm_gpiod_get_optional(&client->dev, "reset",
+						   GPIOD_OUT_HIGH);
+	if (IS_ERR(data->reset_gpio))
+		return dev_err_probe(&client->dev, PTR_ERR(data->reset_gpio),
+				     "Cannot get reset GPIO\n");
+
 	ret = hdc3020_power_on(data);
 	if (ret)
 		return dev_err_probe(&client->dev, ret, "Power on failed\n");

-- 
2.40.1


