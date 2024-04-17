Return-Path: <linux-kernel+bounces-149015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACC58A8A7C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E906B2717E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BC4172BCF;
	Wed, 17 Apr 2024 17:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFGy9vSf"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F798174ECD;
	Wed, 17 Apr 2024 17:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713376285; cv=none; b=kOa3A9ge8FFTpzB2X4e1xUXHc8bUQEGgHJwZXHuMXZfl0NizU0z9pA7JtcamenoUF/4hN3esWdEh5UidFaD7pS3Q1HgVjmF3xrXARMQg9BaaVk0U/3/FseRC4Qldejlq2JStS5VYSVL1kFHWjfdEhNpIWlfVUxZOw2WFQPfXsu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713376285; c=relaxed/simple;
	bh=UtXbvqhE7xD5plrDZFZ6E8KDK4bDTVwFxnGb3CZpD1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=grIUUuPtHNAO8v7eQvjTb1BQ5Lx+v0+sHSIfFYnxLTsV4IhmKswnHhP7NzHp5u24cp56fv0AoP2fUpva1Yw1CVno5MBpFV004/zxg3vC5Imn6l1N2+0Tks7cgqmzrcllHBPEbJYG74LxeUDk4jIHP+9L+znhArbiEdFZXjqxifs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFGy9vSf; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-418a2de4d8fso23785e9.2;
        Wed, 17 Apr 2024 10:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713376281; x=1713981081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ft5wsqvMDGwoTIQ2TLrexp9TcOahaFf12PegEvKDN5c=;
        b=VFGy9vSfp6a/46g+eu7WnMybwJLZEmb3EZfLXAPR+Eni6tET5b4+X+9QOWIq2Oujvw
         Zzwj4Yuag7RPs1vav6tHig5QzAEpNEMFq8QggriuSkKrO9IqOClcLq2lDK0N5PGFPZ7y
         01ak5umtyjGOGWpiACW+BPmlpc0wYEW7KkVwKr8yZpFXtazHoM5iibojSwCGMs63mSid
         3IaHnOfYGogqpvF5zNvyAX+4j8pmUUxD6/VkeFXcD332veDKGRmIccJ1DdgY06xYaOKG
         go9whl7xlP54r7jRcW7mj44eKJmMNUysUVNax8a+Ti75amT7c3OcOH/7H+SS9BJ5sife
         I13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713376281; x=1713981081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ft5wsqvMDGwoTIQ2TLrexp9TcOahaFf12PegEvKDN5c=;
        b=eXRUkA29h6S3Wl3OoBl6wQ8Wn9lKzZOyTHdxajTtUzInDOrVKECEWB2UkBJJ9UjB3V
         iVwI18cKSB8vVBUUrjpUzPS2FSF4+4FJXzy9SEYTuqzebPXSivBIyLjSH4cNQ/IxIEZQ
         aACCAcVMfAPegp+xaGPclufC88ft4PohBzulvjvDSm/xebQkWXXJIrSZFiBgeNQ8u7dn
         dRFq/MTeKOG4sF7JMolbbS3obLAyXdFY6i7GAl+Cz8Ycu2oHK8M0J04MDF29AKMpbwUm
         oYuApxOib1P2fYde7ZngOnkYWf3FnCrcZz/NA9GU9H+xEA90Nc7OXYEuSeeOaHy2pw6I
         9DUg==
X-Forwarded-Encrypted: i=1; AJvYcCUX6gA/bJ81mYpeAPBD8HsMa1RaGfpU0LnM4n9DnLGU4OiiNe4V7ZcqtRjb8vuEXEfGUyLhJk5XTte+/5ctPJHed3vmQ0iJf7NTLHka9H3JWjGroDpmRETVhfFw79TowJ5NaIIgGG19
X-Gm-Message-State: AOJu0YwtYNlIHCtZUKkCywLO49rUjIk9mGKx/nQCROnPQL1iNxYSAPi3
	SFxTPn8t2GaTKn4uppL7A8vJWk+EcjkW5ulhPLIJegf+vGcCeImRySBHZFVfo64=
X-Google-Smtp-Source: AGHT+IHk2VAMi49T+4077Go5Hlx6VJT8wTCmuQe1qUocMLKqn83srsiJL/JS/9CTW/Evw911UOROpw==
X-Received: by 2002:a05:600c:3b27:b0:418:32f7:e87 with SMTP id m39-20020a05600c3b2700b0041832f70e87mr203669wms.32.1713376281460;
        Wed, 17 Apr 2024 10:51:21 -0700 (PDT)
Received: from fedora.. (cable-178-148-234-71.dynamic.sbb.rs. [178.148.234.71])
        by smtp.gmail.com with ESMTPSA id v7-20020a05600c470700b00418916f5848sm3569866wmo.43.2024.04.17.10.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 10:51:21 -0700 (PDT)
From: Aleksa Savic <savicaleksa83@gmail.com>
To: linux-hwmon@vger.kernel.org
Cc: David Flemstrom <david.flemstrom@gmail.com>,
	Aleksa Savic <savicaleksa83@gmail.com>,
	Jack Doan <me@jackdoan.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] hwmon: (aquacomputer_d5next) Add support for Octo flow sensor pulses
Date: Wed, 17 Apr 2024 19:50:36 +0200
Message-ID: <20240417175037.32499-3-savicaleksa83@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417175037.32499-1-savicaleksa83@gmail.com>
References: <20240417175037.32499-1-savicaleksa83@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for reading and writing the flow sensor pulses on
the Aquacomputer Octo. Implemented by David Flemstrom [1].

[1] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/pull/95

Originally-from: David Flemstrom <david.flemstrom@gmail.com>
Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
---
 Documentation/hwmon/aquacomputer_d5next.rst |  3 ++-
 drivers/hwmon/aquacomputer_d5next.c         | 17 +++++++++++++----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
index f84b6a5e4373..49163f387b90 100644
--- a/Documentation/hwmon/aquacomputer_d5next.rst
+++ b/Documentation/hwmon/aquacomputer_d5next.rst
@@ -47,7 +47,7 @@ better suited for userspace tools.
 
 The Octo exposes four physical and sixteen virtual temperature sensors, a flow sensor
 as well as eight PWM controllable fans, along with their speed (in RPM), power, voltage
-and current.
+and current. Flow sensor pulses are also available.
 
 The Quadro exposes four physical and sixteen virtual temperature sensors, a flow
 sensor and four PWM controllable fans, along with their speed (in RPM), power,
@@ -100,6 +100,7 @@ fan1_min         Minimal fan speed (in RPM)
 fan1_max         Maximal fan speed (in RPM)
 fan1_target      Target fan speed (in RPM)
 fan5_pulses      Quadro flow sensor pulses
+fan9_pulses      Octo flow sensor pulses
 power[1-8]_input Pump/fan power (in micro Watts)
 in[0-7]_input    Pump/fan voltage (in milli Volts)
 curr[1-8]_input  Pump/fan current (in milli Amperes)
diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index 166044e01921..8e55cd2f46f5 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -214,6 +214,7 @@ static u16 octo_sensor_fan_offsets[] = { 0x7D, 0x8A, 0x97, 0xA4, 0xB1, 0xBE, 0xC
 
 /* Control report offsets for the Octo */
 #define OCTO_TEMP_CTRL_OFFSET		0xA
+#define OCTO_FLOW_PULSES_CTRL_OFFSET	0x6
 /* Fan speed offsets (0-100%) */
 static u16 octo_ctrl_fan_offsets[] = { 0x5B, 0xB0, 0x105, 0x15A, 0x1AF, 0x204, 0x259, 0x2AE };
 
@@ -861,9 +862,16 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
 			}
 			break;
 		case hwmon_fan_pulses:
-			/* Special case for Quadro flow sensor */
-			if (priv->kind == quadro && channel == priv->num_fans)
-				return 0644;
+			/* Special case for Quadro/Octo flow sensor */
+			if (channel == priv->num_fans) {
+				switch (priv->kind) {
+				case quadro:
+				case octo:
+					return 0644;
+				default:
+					break;
+				}
+			}
 			break;
 		case hwmon_fan_min:
 		case hwmon_fan_max:
@@ -1294,7 +1302,7 @@ static const struct hwmon_channel_info * const aqc_info[] = {
 			   HWMON_F_INPUT | HWMON_F_LABEL,
 			   HWMON_F_INPUT | HWMON_F_LABEL,
 			   HWMON_F_INPUT | HWMON_F_LABEL,
-			   HWMON_F_INPUT | HWMON_F_LABEL),
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_PULSES),
 	HWMON_CHANNEL_INFO(power,
 			   HWMON_P_INPUT | HWMON_P_LABEL,
 			   HWMON_P_INPUT | HWMON_P_LABEL,
@@ -1671,6 +1679,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->buffer_size = OCTO_CTRL_REPORT_SIZE;
 		priv->ctrl_report_delay = CTRL_REPORT_DELAY;
 
+		priv->flow_pulses_ctrl_offset = OCTO_FLOW_PULSES_CTRL_OFFSET;
 		priv->power_cycle_count_offset = OCTO_POWER_CYCLES;
 
 		priv->temp_label = label_temp_sensors;
-- 
2.44.0


