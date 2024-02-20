Return-Path: <linux-kernel+bounces-73719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D177685C7B5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F8D11F266A8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C9A15351A;
	Tue, 20 Feb 2024 21:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rqi8mqQ/"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E05151CD6;
	Tue, 20 Feb 2024 21:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708463707; cv=none; b=NGEosVWls/a3BIivJvXYWNdV1fmnqoUJFvXXavkqccGAOPNiYFWUgGT079Qc56nJ8h1l8N1IEH/Jv/ubmGpxX1cE+w/SOJuGVvRV5aAFLeBLCEoaSIPwcs+nhHXT2ql0jRqGVbQJOYlfd7AA7xrHPoRqbOMUSVcjuVL1O3q9Z8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708463707; c=relaxed/simple;
	bh=PfgqwBzwcDb+91qumay33JWHJ7BTVWpHM3HbGeClp7I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q38fhipNm0iu+OcLsC6GAoEMeP6+JUd3ocOAO3T/zPraLeEskYBiH2BaGggX7R4F8FOc7++1Y7HAXcsGpNhj1FL5IVAQnYGw31LrM/4/AKCpDcqdBkUqnXyzhQa5l28kGen2ZubO3ecDoDQ1BKA+e4UDLJQggFAs/Pn7niVkVK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rqi8mqQ/; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-564f1876a2fso182525a12.3;
        Tue, 20 Feb 2024 13:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708463703; x=1709068503; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rpz65CgEKeFqCseDG6nHrCx/ipraX250PSOWkqJO8E4=;
        b=Rqi8mqQ/Bx0R4GUvFuKSZy/e6YC3oycmtsUMu4dcj3ZYmbKfRlKvN88AdRZ+FKHdO7
         3ZZm+s6OT8L9BUKUugHaURCrqCOYrTD6UibQ0NJ0BM8yStHTuHV/GFBFfo44RFyNwA+J
         ZSxZKPTOhV/uMidRpLWfiDELiYwNI5wn36bpOx8a2gHvcUXrOWXTDLqYG06Hnw2mxvka
         gq5QrF6eVC9fK36pBv6gzAyicMm8Qu6OqP7xrHjILf/mv0C2XVlLZ/JG43PrBX9VCdiO
         7OozmmEtQWfdCbzXJBEecEHu3WlqM2qsNUM4aJhFZRFTwJP8c9hlAOIs4h9hhnZauRhE
         n52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708463703; x=1709068503;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rpz65CgEKeFqCseDG6nHrCx/ipraX250PSOWkqJO8E4=;
        b=D2ALL7PgOj9PNuFrnH9Nw7w1lvcHJM7vumlh1He8mZbFZrzfAtWemt15BzE1sffPDW
         3U962m67enUlo0r2mZ5wl/X5ReZjuNYv0Hm+plU4XNQWbW+NPoW4LGLg6GCnfPwhBTbM
         SxcegicXA0b5BZSi8ITWV5XQcV8gUbZ3ATiRps2xMnoeg5EBf1pte37R2dLCrbPfSivp
         Yb1WwDfnHMgKiFon2tMeSclo7y0sWpQrV0UEz0C/g1J41edwhHkPbBj3ToKMQZlXw+tc
         cVXSl6eOaSX+90L5pBMIF/CAz7xgvrwb2ZNJehT9pRA3VKtJCCSYKlbPPbEqF2I/0uw1
         Eh4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVGlRNb05i7jzZ5IS8PM1EROQYqfE6KP84m0kHV7Yb/GHNlgwEnK+YW4TROzA6HZZ8NIhYXSBoNQn8hzr/rAIE1hIOjxgctFJUx/K3LFvcjIflJ4i1ErwfDVCim9Cm6pkT3eBlNJi1RIBANNDCqObydaTEOw6CVZMHamkXjkGHRjICk/A==
X-Gm-Message-State: AOJu0Ywqm7gkgEh4Y8bJx1VBf9icum7zvvy543h+UuYNXirKtZtWYE7F
	y+RW+jslZN2xJBYTa991aFdgPw4wRZNGHBaj2rjNdJAOPa/mD3QZMX1qNyaLW5I1AA==
X-Google-Smtp-Source: AGHT+IFM2A45QUCqPCimobrtQz/hB59OTos8oA4Jt5gqJ5JnmUHY8EDJ3AGFYAq1Y1/Q0CUXezxtUw==
X-Received: by 2002:aa7:d997:0:b0:564:71d1:6cbd with SMTP id u23-20020aa7d997000000b0056471d16cbdmr4697858eds.14.1708463703514;
        Tue, 20 Feb 2024 13:15:03 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-d60d-797f-077b-a805.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:d60d:797f:77b:a805])
        by smtp.gmail.com with ESMTPSA id fj21-20020a0564022b9500b00564da28dfe2sm538137edb.19.2024.02.20.13.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 13:15:03 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 20 Feb 2024 22:14:58 +0100
Subject: [PATCH 4/4] iio: humidity: hdc3020: add reset management
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-hdc3020-pm-v1-4-d8e60dbe79e9@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708463696; l=2241;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=PfgqwBzwcDb+91qumay33JWHJ7BTVWpHM3HbGeClp7I=;
 b=54ovICHbb8pco+EjzIxuBxnPtD3cYYN+SBpBLC2Tnc5vCDXBBIlegBTCEeG0TC9xqxDvX0IsL
 NArRKsDJhrIAUau1dSTjETtzBA75FnxjpacxAPgfJrlDKmPMv9tGgYa
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
index 0da5c5c41cd2..bd2f57a7eedc 100644
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
@@ -564,6 +566,11 @@ static int hdc3020_power_on(struct hdc3020_data *data)
 
 	fsleep(5000);
 
+	if (data->reset_gpio) {
+		gpiod_set_value_cansleep(data->reset_gpio, 0);
+		fsleep(3000);
+	}
+
 	if (data->client->irq) {
 		/*
 		 * The alert output is activated by default upon power up,
@@ -581,6 +588,9 @@ static int hdc3020_power_off(struct hdc3020_data *data)
 {
 	hdc3020_exec_cmd(data, HDC3020_EXIT_AUTO);
 
+	if (data->reset_gpio)
+		gpiod_set_value_cansleep(data->reset_gpio, 1);
+
 	return regulator_disable(data->vdd_supply);
 }
 
@@ -621,6 +631,12 @@ static int hdc3020_probe(struct i2c_client *client)
 		return dev_err_probe(&client->dev, PTR_ERR(data->vdd_supply),
 				     "Unable to get VDD regulator\n");
 
+	data->reset_gpio = devm_gpiod_get_optional(&client->dev, "reset",
+						   GPIOD_OUT_HIGH);
+	if (IS_ERR(data->reset_gpio))
+		return dev_err_probe(&client->dev, PTR_ERR(data->reset_gpio),
+				     "Cannot get reset GPIO\n");
+
 	hdc3020_power_on(data);
 
 	if (client->irq) {

-- 
2.40.1


