Return-Path: <linux-kernel+bounces-70008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B208591A6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 19:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B55BC1F2174F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 18:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1D37E0F6;
	Sat, 17 Feb 2024 18:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjYf0qo3"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB011BF26;
	Sat, 17 Feb 2024 18:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708193790; cv=none; b=ZVR3oL3nOVHTSt/Yf1iOS+B+IV3F1ZbCfaqfJyFRPtjVxAy4gdHFgUDzOAQRoPPPcuYjOYWjVe50tqUEtQdmWSBY32fxaRaN94pLKXkWz6pBnr+UHpYnAe4uksOjU3KFZCdqFhyL86Cbxwt8axihwzDUUHzJO7f7D1NweHEocw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708193790; c=relaxed/simple;
	bh=6JaMbzvXElJKDwMGGagRTinlOMD9SEMyT0dM0G4N6hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sDH2PhpUf9ggpR6FbYIjTBMr47a00FyMbi8dfVXde07cVuD0EhbCwemy0K3bKA7aqXfLmehHAVk1z3XBDGzFRLCLMys6vyfZ8rviqYSF2QRbUy9dUN0dY5jdz4LsiFhsH0rC7v6UU1hcZhic4AFicIfjYF2Qj3kykcUIDvKCEtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjYf0qo3; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-512a9ae6c02so385591e87.2;
        Sat, 17 Feb 2024 10:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708193786; x=1708798586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=28MpLj21qVTEK8TjTKOL0nGG31w9h8k1TshcjliBdBE=;
        b=GjYf0qo3L7/z2F7pLdi8RetaJM5rQlT8M/XYCU0XK1yqTWnV8UXrf1NudX0Zn4eNie
         PbbEysebXwZZPoSUqBrkHv0h9lDjmd673oEmuE7llTKpmRUyu3IdJ9+a4CcNbc3RIwG9
         McyEchW8IrX+hWlGf21Qi00h8KKgf01G1x4ypDy9wngeThbnatpJwc4B8vMTt08sc4yV
         PTPRps82PtP/HMqWe03AUDUchjqTps3osOpH6Yna92uA1PMEUqkaQiXSSM3nTXTV4SWy
         UjwMAkmXfaILWWZMwBVgOdnnsCQITtRw9nGloecD4e5oQfLZ8S5QYUX2b9fvnaOGphtE
         pc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708193786; x=1708798586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=28MpLj21qVTEK8TjTKOL0nGG31w9h8k1TshcjliBdBE=;
        b=GQ7G0idwo/Gzpo9joHT22WvpnL+sQTE7ynekp0w5acXEsgapTt4mxPqinnz8d9UwPC
         bcYWQbKWCljNtDu+AzYRmWLUylefIvYjWnC2R5xxU+039squQt2qLKMMpeyf/gasouJD
         E4oZPw0Oj9b9sQcUiyD9kYh2wPywV6uaoqN5z9I3XQUCwEwntF0jKWE01YXKt9a02PPN
         68K3VhVFW9TxpF6ph4U5XR+jfRDOtNhvI+AiG2cw7Lq7h0VFQs98sdvm7UZ/B75y3cyi
         Rrb4lK4iUOn5puoWdofE7dXPuN4dGgs6vE3WEXWp/fWr0mF/6ZW/TxUpwzRh0o8M8m1F
         7Rdw==
X-Forwarded-Encrypted: i=1; AJvYcCXlB8K6KBOrVNBEBQ37m+QP8NuMu7FY595+bOqE5I98tstNjqA7UNG6zjWApywOOkVXlX5nmkdfu8WCStAkBNNQK6KDinDA6GQOkSym
X-Gm-Message-State: AOJu0YzREuwX2ayyxRI7TrnyW5oBbeIOSiR0Y840sVHzu5iy6s8NvFuJ
	w0AnJkIhtShjq4KryqqTOk4seBXqBWbBzoCW+2V63Tvu+YJLZzbH/4qBHvPFGOw=
X-Google-Smtp-Source: AGHT+IEaOxKBNZXkZNUKkJAzouFxIWaavAx+PVrcoxuddO7HkCkEK8NjX0517n9qztZ0mKLKKz/AHg==
X-Received: by 2002:a19:4318:0:b0:511:69b3:a47e with SMTP id q24-20020a194318000000b0051169b3a47emr4742170lfa.52.1708193785977;
        Sat, 17 Feb 2024 10:16:25 -0800 (PST)
Received: from fedora.. (cable-178-148-234-71.dynamic.sbb.rs. [178.148.234.71])
        by smtp.gmail.com with ESMTPSA id fg11-20020a056402548b00b00564168e6674sm923545edb.51.2024.02.17.10.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 10:16:25 -0800 (PST)
From: Aleksa Savic <savicaleksa83@gmail.com>
To: linux-hwmon@vger.kernel.org
Cc: Aleksa Savic <savicaleksa83@gmail.com>,
	Jack Doan <me@jackdoan.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (aquacomputer_d5next) Set fan to direct PWM mode when writing value
Date: Sat, 17 Feb 2024 19:15:36 +0100
Message-ID: <20240217181536.344386-1-savicaleksa83@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When setting a PWM value for a fan channel, ensure that the device
is actually in direct PWM value mode, as it could be in PID, curve or
fan following mode from previous user configurations. The byte
signifying the channel mode is just behind the offset for the value.
Otherwise, setting PWM speed might result in a no-op from the point
of the user.

Fixes: 752b927951ea ("hwmon: (aquacomputer_d5next) Add support for Aquacomputer Octo")
Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
---
 drivers/hwmon/aquacomputer_d5next.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index 2efe97f8d003..809fbbd087f4 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -111,6 +111,9 @@ static u8 aquaero_secondary_ctrl_report[] = {
 #define AQC_FAN_POWER_OFFSET		0x06
 #define AQC_FAN_SPEED_OFFSET		0x08
 
+/* Report offsets for fan control */
+#define AQC_FAN_CTRL_PWM_OFFSET		1
+
 /* Specs of the Aquaero fan controllers */
 #define AQUAERO_SERIAL_START			0x07
 #define AQUAERO_FIRMWARE_VERSION		0x0B
@@ -160,7 +163,7 @@ static u16 d5next_sensor_fan_offsets[] = { D5NEXT_PUMP_OFFSET, D5NEXT_FAN_OFFSET
 
 /* Control report offsets for the D5 Next pump */
 #define D5NEXT_TEMP_CTRL_OFFSET		0x2D	/* Temperature sensor offsets location */
-static u16 d5next_ctrl_fan_offsets[] = { 0x97, 0x42 };	/* Pump and fan speed (from 0-100%) */
+static u16 d5next_ctrl_fan_offsets[] = { 0x96, 0x41 };	/* Pump and fan speed (from 0-100%) */
 
 /* Specs of the Aquastream Ultimate pump */
 /* Pump does not follow the standard structure, so only consider the fan */
@@ -213,7 +216,7 @@ static u16 octo_sensor_fan_offsets[] = { 0x7D, 0x8A, 0x97, 0xA4, 0xB1, 0xBE, 0xC
 /* Control report offsets for the Octo */
 #define OCTO_TEMP_CTRL_OFFSET		0xA
 /* Fan speed offsets (0-100%) */
-static u16 octo_ctrl_fan_offsets[] = { 0x5B, 0xB0, 0x105, 0x15A, 0x1AF, 0x204, 0x259, 0x2AE };
+static u16 octo_ctrl_fan_offsets[] = { 0x5A, 0xAF, 0x104, 0x159, 0x1AE, 0x203, 0x258, 0x2AD };
 
 /* Specs of Quadro fan controller */
 #define QUADRO_NUM_FANS			4
@@ -232,7 +235,7 @@ static u16 quadro_sensor_fan_offsets[] = { 0x70, 0x7D, 0x8A, 0x97 };
 /* Control report offsets for the Quadro */
 #define QUADRO_TEMP_CTRL_OFFSET		0xA
 #define QUADRO_FLOW_PULSES_CTRL_OFFSET	0x6
-static u16 quadro_ctrl_fan_offsets[] = { 0x37, 0x8c, 0xe1, 0x136 }; /* Fan speed offsets (0-100%) */
+static u16 quadro_ctrl_fan_offsets[] = { 0x36, 0x8b, 0xe0, 0x135 }; /* Fan speed offsets (0-100%) */
 
 /* Specs of High Flow Next flow sensor */
 #define HIGHFLOWNEXT_NUM_SENSORS	2
@@ -1094,8 +1097,9 @@ static int aqc_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 			*val = aqc_percent_to_pwm(*val);
 			break;
 		default:
-			ret = aqc_get_ctrl_val(priv, priv->fan_ctrl_offsets[channel],
-					       val, AQC_BE16);
+			ret = aqc_get_ctrl_val(priv,
+					       priv->fan_ctrl_offsets[channel] +
+					       AQC_FAN_CTRL_PWM_OFFSET, val, AQC_BE16);
 			if (ret < 0)
 				return ret;
 
@@ -1233,8 +1237,19 @@ static int aqc_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 					return ret;
 				break;
 			default:
-				ret = aqc_set_ctrl_val(priv, priv->fan_ctrl_offsets[channel],
-						       pwm_value, AQC_BE16);
+				/* Set fan controller to direct PWM mode */
+				ctrl_values_offsets[0] = priv->fan_ctrl_offsets[channel];
+				ctrl_values[0] = 0;	/* Use direct PWM mode */
+				ctrl_values_types[0] = AQC_8;
+
+				/* Set the PWM value */
+				ctrl_values_offsets[1] =
+				    priv->fan_ctrl_offsets[channel] + AQC_FAN_CTRL_PWM_OFFSET;
+				ctrl_values[1] = pwm_value;
+				ctrl_values_types[1] = AQC_BE16;
+
+				ret = aqc_set_ctrl_vals(priv, ctrl_values_offsets, ctrl_values,
+							ctrl_values_types, 2);
 				if (ret < 0)
 					return ret;
 				break;
-- 
2.43.0


