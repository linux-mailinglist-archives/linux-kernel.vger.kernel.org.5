Return-Path: <linux-kernel+bounces-89921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B78A86F755
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 22:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0BB7281063
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 21:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2497BAF3;
	Sun,  3 Mar 2024 21:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAPuQsRR"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113037AE69;
	Sun,  3 Mar 2024 21:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709502871; cv=none; b=WAhhkAncC7vtxOB6YTUUO36HFLkNdx7Bcyipj3J5gz++SVL6GxfDbeg5GcTP33YfiunxjmgOc0eh7Jk5a6KeiillvUWERNPcx4A3FDqMZlcbJMQw7tCDdbyz8g0j2N1ig4DvLLtbp2+6lCTtZQBLDRYebPp6ixUTrrwDsaq7aNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709502871; c=relaxed/simple;
	bh=aVC+szChqUVwP9dorH1s8x/ORY9BRZBBC5IcgeZmXjg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P84b+j5UeABYtxB33pWiwrJYrolTdjzTf1pYKExgzB/BV67R1KK12t+/3Xno//IUReyOTCYs2ugQWPRPHChLRCywK2IG3IO1vSHVSmSRx8CNiGlRtPL97P3Xd7y49WCNElGD8t5L6tQTSANrEtjMN6+H/b4e6dHIL6R319Nre2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAPuQsRR; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-565a3910f86so5780691a12.3;
        Sun, 03 Mar 2024 13:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709502868; x=1710107668; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9wfVpFY3RFJ1WZsM48MjjCquUKLQaa0zbDWX/ailz6E=;
        b=LAPuQsRRH3MtUkpY4uyzvQAxycxbMMxYnRebDqj2r3fgGbzn+Zdse+rMlsApbCOgnj
         KjfW4ho58K0ywn1Ge75S/GrtIAl9od3B10LKqTRt2b7W8uEENq+2gzQFKn5gh4Hf86Jt
         LltZmjFCm3HPShymDFrZvXFCeRHpWTA/narVc/YTy9gIKGd5+XRU1SUt8tDai+oMmYw3
         OFmiUK1dEal48If07a9zZLeizupanwAB/5PIoKG2VfNBxrNul2jtdQzd2x2oCKjzmNy2
         suxh0kBAkSp+jj7DPFB95yP8GKCWOZl95D+X5YHDTelv06eLWQkSxnojpb4qEz/9PML6
         gkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709502868; x=1710107668;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9wfVpFY3RFJ1WZsM48MjjCquUKLQaa0zbDWX/ailz6E=;
        b=Sop0gEfcW9nDp5yuvWdjKdrJUevz/ddrNZjpQPj1qc7hIzrfZ7Vz0W66KfrNavqFSg
         +UrFNf1BgkP7o2iCPFieP1ZTTgXE1M4h2Kq/H41Cd7mGfM1Socff9vmQvafZauEVLiVm
         BDKjbyCS4Od1L7OHMFBUbYidE34qjpyeRvFABN+PNa8BD7uW8WZM0MIAVxiPylt35hwg
         dtm92NZWoOgQg6KPRjlzG/KTYNIbmTHxdKp8BZqKSfYuMP1saX5DklA+nc+FfGbT6mEC
         tN6E7bTlK+g78A5i1AROQbJilMTfoz3jLtEyeT1Jsb+mkSazv7nSYShFSNi7/oV5chfJ
         7JLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj3LSGRPsh/NNMmauEy8LkSj7Dw+4Vqg8L1sWsEqIhEiENglAvHKYNdO3ulUOroLqm+TNd4mRBlCm8f3bjtVATa0TdzTtk82RIr8uqRzN9lGB8mXw26M0sZvijf2gbodAsNZvZIW1QA1mXf4jIcvGTTT+drR3BfyaeSasrFVYFYM7VFA==
X-Gm-Message-State: AOJu0YwjT+QhyHkHj9WxNvAGXy1AxhOmB1SbfOdG/UGP9GqiNB9rX2ge
	7uEjfGLLgs1b9o785wJgRo+BMPSljk97gWBJyggbR4JkHvZmhsFmpjHFX1GOrswcwg==
X-Google-Smtp-Source: AGHT+IHlckUN5ksJiFKHAfgeDqB9otVgcaNUqPtywMP22W0xmNKg7pinjAu1q0x4S4lT+ZC662dFAQ==
X-Received: by 2002:a05:6402:26c5:b0:564:3392:e9db with SMTP id x5-20020a05640226c500b005643392e9dbmr6313049edd.33.1709502867851;
        Sun, 03 Mar 2024 13:54:27 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-b3d8-5b4b-5188-4373.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b3d8:5b4b:5188:4373])
        by smtp.gmail.com with ESMTPSA id n22-20020a05640205d600b00566d6950d14sm2783250edx.92.2024.03.03.13.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 13:54:27 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 03 Mar 2024 22:54:22 +0100
Subject: [PATCH v3 3/3] iio: humidity: hdc3020: add reset management
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240303-hdc3020-pm-v3-3-48bc02b5241b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709502861; l=2300;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=aVC+szChqUVwP9dorH1s8x/ORY9BRZBBC5IcgeZmXjg=;
 b=xhvMcJZaOIgBiJ8bzYqJ/tYs7KdeFM+Wd6KN70+V7hWYPyQ2kzRvnmsoX3Zm9WEFQFe2IKYAg
 tg+4Ko2kB1QAgRb8ys164IE+lFVQKv8CSAOa57mZnOoVr73mFaO8t2L
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
index 7f93024b850c..cdc4789213ba 100644
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


