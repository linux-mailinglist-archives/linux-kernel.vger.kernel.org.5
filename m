Return-Path: <linux-kernel+bounces-149014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A1C8A8A79
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C87281F249C4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8547A172BBA;
	Wed, 17 Apr 2024 17:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZT/9C7CI"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F1A171678;
	Wed, 17 Apr 2024 17:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713376280; cv=none; b=NVx6H+P3ojRD8XAVd+PZsFZiIbwmFUt79PwiWjskHn4pIg7h+EHGK1Y20E4Q7/JrWG37tVJk+LnARTO0sC0KdqACaSRM1E2wuRNxvM4Wc+0AoI2bW6YtDOCj7GGjM7TRtLJnn+oLd9PvVXJ+onf1rSDtkaTZa9SiCPPoDzYvfN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713376280; c=relaxed/simple;
	bh=NmylBIEaAwYTT2EFOS+5DddC7LLpxKKVE8Pro8PU9kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WXmYkoI/0e0BPRrSFQrnS0doy0pNc4ExrMFJMKKfDzPUzPBKDunid/+jvO2PpdEXkT31JRwxdcM+Rt1WuwfDSqUvFxkP4Eq+wy62rrpqSucbyKZYRws0hyx4SP4vjVl84ZYx0PpqlskJMWifSOc7Z8ydZp7Mjk2NwEpMrh6oXqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZT/9C7CI; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-418d10e6630so70515e9.1;
        Wed, 17 Apr 2024 10:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713376276; x=1713981076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCAwGt1/GtnUE+EPRZRBvhp7rEsyAUw1E8IyUXERHcw=;
        b=ZT/9C7CIqqa5UreXQxLOMxezNNvo5zihdTFAQii1ePc9WvOK8A477gtXBzh8pwZnRY
         ZYn8CEgOxGij/OLeDxwcOnOq6QtNQ865UfrP9ZzTCzCylQ0KaaDIOzYaX2aLWkczYPfy
         lr9aNA0ZG62guIti/IXqCIsUewmce2GgcS//r6M4g5AoBqnBA5hBGKhRzGaZlWShitY/
         ouyDgV2e9q0iFnXWugTSLB4J4yKhtR7sgTOarOiSRqlPiUwBQVQNz6wf/yfEJ3WJONLj
         /SMNNfpDdXic/ukIRm4iwG779/fSb+V1QM32qUlmcfA8oEiPvzR2RARRZaGHmLMctK04
         TB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713376276; x=1713981076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCAwGt1/GtnUE+EPRZRBvhp7rEsyAUw1E8IyUXERHcw=;
        b=Oq2Cdz7cpJrZqK8xNoHy9ksHdksE4dE9voboPW4scP1inLUTIEcDK6d9fSESnaCoHG
         Y8IhXi/zr8dFwXA+RnVibhSLEwpJQ0mE+OejAMG84jU4EfXo2UFj5p+7wlFNBTSKyxX+
         a5FFHM93ROg7pikUe2hpnB0lUOdZNYhvaNM0qwkVKJi9jr3SPfnlD2HraHVCh8t0wkG/
         XKGqnKHU5wd6ZH8QAXCbeRtl5Jy56jseOU8HPIR/Tyb6ACcUTHE3IsepXVYPgP07RteA
         aBN2JoyqIy23ftLABSBNYTCmxhvKS6z5jI8bjy8f8ZBJ7J6fZO/4YyM8X2Ha38fcuaRc
         8UMw==
X-Forwarded-Encrypted: i=1; AJvYcCV7m94zPAGhOD3bq4qJUZBCUtLSKFKtzuBR3iQ8q5fcwbKrfwx6uquhzJgBcYeJion9tqORFa9R9SO4P3a35+CuxY/UVXt+7nxKLN6ehcINZcLeI5i7mjXkkBW7NdB/2HOdHk51ETtV
X-Gm-Message-State: AOJu0Ywfx3VGl4ocbIuJGW2aprhqkt+1Ce6Lsn3YmCTZMMnLcb4saFy0
	/yYjSASlpz7wVZDKErK5D7RZ7L7NMm/muk9jzrCOPjIUUGNTG+w9L0exes/jGj8=
X-Google-Smtp-Source: AGHT+IGMvUXOVf3pqXKWKTjdLeglWCvkL7rKPuuOYrIu/jnWNKeewEL8z7o3gGr+I5/5ho31vJ4gPw==
X-Received: by 2002:a05:600c:1e0b:b0:418:9b4e:8963 with SMTP id ay11-20020a05600c1e0b00b004189b4e8963mr269525wmb.16.1713376276615;
        Wed, 17 Apr 2024 10:51:16 -0700 (PDT)
Received: from fedora.. (cable-178-148-234-71.dynamic.sbb.rs. [178.148.234.71])
        by smtp.gmail.com with ESMTPSA id v7-20020a05600c470700b00418916f5848sm3569866wmo.43.2024.04.17.10.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 10:51:16 -0700 (PDT)
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
Subject: [PATCH 1/2] hwmon: (aquacomputer_d5next) Add support for Octo flow sensor
Date: Wed, 17 Apr 2024 19:50:35 +0200
Message-ID: <20240417175037.32499-2-savicaleksa83@gmail.com>
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

Add support for reading the flow sensor value on
the Aquacomputer Octo. Implemented by David Flemstrom [1].

[1] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/pull/95

Originally-from: David Flemstrom <david.flemstrom@gmail.com>
Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
---
 Documentation/hwmon/aquacomputer_d5next.rst |  8 ++---
 drivers/hwmon/aquacomputer_d5next.c         | 34 +++++++++++++--------
 2 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
index cb073c79479c..f84b6a5e4373 100644
--- a/Documentation/hwmon/aquacomputer_d5next.rst
+++ b/Documentation/hwmon/aquacomputer_d5next.rst
@@ -45,9 +45,9 @@ seems to require sending it a complete configuration. That includes addressable
 RGB LEDs, for which there is no standard sysfs interface. Thus, that task is
 better suited for userspace tools.
 
-The Octo exposes four physical and sixteen virtual temperature sensors, as well as
-eight PWM controllable fans, along with their speed (in RPM), power, voltage and
-current.
+The Octo exposes four physical and sixteen virtual temperature sensors, a flow sensor
+as well as eight PWM controllable fans, along with their speed (in RPM), power, voltage
+and current.
 
 The Quadro exposes four physical and sixteen virtual temperature sensors, a flow
 sensor and four PWM controllable fans, along with their speed (in RPM), power,
@@ -95,7 +95,7 @@ Sysfs entries
 ================ ==============================================================
 temp[1-20]_input Physical/virtual temperature sensors (in millidegrees Celsius)
 temp[1-8]_offset Temperature sensor correction offset (in millidegrees Celsius)
-fan[1-8]_input   Pump/fan speed (in RPM) / Flow speed (in dL/h)
+fan[1-9]_input   Pump/fan speed (in RPM) / Flow speed (in dL/h)
 fan1_min         Minimal fan speed (in RPM)
 fan1_max         Maximal fan speed (in RPM)
 fan1_target      Target fan speed (in RPM)
diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index 2efe97f8d003..166044e01921 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -202,12 +202,14 @@ static u16 aquastreamult_sensor_fan_offsets[] = { AQUASTREAMULT_FAN_OFFSET };
 #define OCTO_NUM_FANS			8
 #define OCTO_NUM_SENSORS		4
 #define OCTO_NUM_VIRTUAL_SENSORS	16
+#define OCTO_NUM_FLOW_SENSORS		1
 #define OCTO_CTRL_REPORT_SIZE		0x65F
 
 /* Sensor report offsets for the Octo */
 #define OCTO_POWER_CYCLES		0x18
 #define OCTO_SENSOR_START		0x3D
 #define OCTO_VIRTUAL_SENSORS_START	0x45
+#define OCTO_FLOW_SENSOR_OFFSET		0x7B
 static u16 octo_sensor_fan_offsets[] = { 0x7D, 0x8A, 0x97, 0xA4, 0xB1, 0xBE, 0xCB, 0xD8 };
 
 /* Control report offsets for the Octo */
@@ -363,18 +365,6 @@ static const char *const label_aquaero_calc_temp_sensors[] = {
 	"Calc. virtual sensor 4"
 };
 
-/* Labels for Octo and Quadro (except speed) */
-static const char *const label_fan_speed[] = {
-	"Fan 1 speed",
-	"Fan 2 speed",
-	"Fan 3 speed",
-	"Fan 4 speed",
-	"Fan 5 speed",
-	"Fan 6 speed",
-	"Fan 7 speed",
-	"Fan 8 speed"
-};
-
 static const char *const label_fan_power[] = {
 	"Fan 1 power",
 	"Fan 2 power",
@@ -408,6 +398,19 @@ static const char *const label_fan_current[] = {
 	"Fan 8 current"
 };
 
+/* Labels for Octo fan speeds */
+static const char *const label_octo_speeds[] = {
+	"Fan 1 speed",
+	"Fan 2 speed",
+	"Fan 3 speed",
+	"Fan 4 speed",
+	"Fan 5 speed",
+	"Fan 6 speed",
+	"Fan 7 speed",
+	"Fan 8 speed",
+	"Flow speed [dL/h]",
+};
+
 /* Labels for Quadro fan speeds */
 static const char *const label_quadro_speeds[] = {
 	"Fan 1 speed",
@@ -844,6 +847,7 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
 					return 0444;
 				break;
 			case aquaero:
+			case octo:
 			case quadro:
 			case highflow:
 				/* Special case to support flow sensors */
@@ -1289,6 +1293,7 @@ static const struct hwmon_channel_info * const aqc_info[] = {
 			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_PULSES,
 			   HWMON_F_INPUT | HWMON_F_LABEL,
 			   HWMON_F_INPUT | HWMON_F_LABEL,
+			   HWMON_F_INPUT | HWMON_F_LABEL,
 			   HWMON_F_INPUT | HWMON_F_LABEL),
 	HWMON_CHANNEL_INFO(power,
 			   HWMON_P_INPUT | HWMON_P_LABEL,
@@ -1658,6 +1663,9 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->temp_sensor_start_offset = OCTO_SENSOR_START;
 		priv->num_virtual_temp_sensors = OCTO_NUM_VIRTUAL_SENSORS;
 		priv->virtual_temp_sensor_start_offset = OCTO_VIRTUAL_SENSORS_START;
+		priv->num_flow_sensors = OCTO_NUM_FLOW_SENSORS;
+		priv->flow_sensors_start_offset = OCTO_FLOW_SENSOR_OFFSET;
+
 		priv->temp_ctrl_offset = OCTO_TEMP_CTRL_OFFSET;
 
 		priv->buffer_size = OCTO_CTRL_REPORT_SIZE;
@@ -1667,7 +1675,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 		priv->temp_label = label_temp_sensors;
 		priv->virtual_temp_label = label_virtual_temp_sensors;
-		priv->speed_label = label_fan_speed;
+		priv->speed_label = label_octo_speeds;
 		priv->power_label = label_fan_power;
 		priv->voltage_label = label_fan_voltage;
 		priv->current_label = label_fan_current;
-- 
2.44.0


