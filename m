Return-Path: <linux-kernel+bounces-161377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D44138B4B4F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 12:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63BF71F21967
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 10:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747595789B;
	Sun, 28 Apr 2024 10:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gt2PYhZa"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA295787B;
	Sun, 28 Apr 2024 10:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714301326; cv=none; b=iyAMGaZKNNLczdTZXQfCMkannzvY8XuCMhI/q1ff5eXDFwoIY7FtqJX4TrP2v7HQ9Jet85leFIb775mGFb69nlIog7rCUwXgHq2ImO+iRG1pVbVaCKj/IgXvCBMUwZynZnssqm9am4vtZxhsuMmFf6TtbLRwQNOtOd9HKkG8F2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714301326; c=relaxed/simple;
	bh=In8shMtQv7jElDm5P8pmI3UwM0xudLklJc4ZOJwVjNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QlVVpPHypJMyg4u1I6aMv24Y494iXakCg3WAH68cHBiIYhZCk2lcbppThAUpJhrSh2f3njjExqYygfSBtO6aFvcuCP70wwFzsmxySeDDCon5yn6uJIN68kBVq90HIWRtivqLTI002hy7FaKNZl9p/Jgpvkc8/Fl/HLYpDtiRGWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gt2PYhZa; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41adf3580dbso20070685e9.0;
        Sun, 28 Apr 2024 03:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714301322; x=1714906122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xd8L9XP0fw1NEhmiMn9eld/ysBss7e11l8BAHB1r9yQ=;
        b=Gt2PYhZaMedcrFJpQh4SCoIRKR4rw7P+A/qJ5wTyTrQlrjqhlfjyN+X2JYOsorNkaW
         7SvXKdEW4u7AZ+5/EOR56gzTT1WdN/dH+uOn3BKU9FJIYZMm5wt4IcqDW6h5GeZqakUN
         tAn7fTZk2pI0qupkxloH9/6fHAX8E52XzG4Bxx+GBiKxU/BiMjHm/goISyDyTA3MI/SI
         ZeJKi0T3+MqAO74tkUTl1+sff2jVpivh/kWcDMNZaW81IuOtMcMkuyrQ2nZTbVruT0o9
         5Dc1dvzyf5Noor3jP95YQoNgS9mhhV3pnCAdYGdPqwIYA7nOXdOkXDBUC5scr3sGDa4x
         qoVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714301322; x=1714906122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xd8L9XP0fw1NEhmiMn9eld/ysBss7e11l8BAHB1r9yQ=;
        b=MgGdkJUvO+78Hmnk0fLnAhqEXLrreWSUU3MF/rSgaLuMrSgNR9sO+Xme1Qlz5FFxDW
         UeqQr8Cl6GDOqPv4o4RcTa8UD5XcgF+im22tz4x3VfMeKpHKjXkLMpKR+42gSyQy5W+d
         Og3yN5van9XkvyYOPNaRczXVjDXlznPqGSkg7qwFlURaqAM9fH1QIQNA1RK6gHRO7u0M
         /gGhoFIoSqOdu6sl3djbAn2s9GMXMHXeCetWP3Q7WbDKIlj8p61kxrSEIZmgNk8NPxAG
         hGnILtKmssuqVmIcrqn5Hq/x9PoBoSoUWmIeBL8aWj0i3Qu/SPk6/6HTFKGjhB43sp4z
         Fsog==
X-Forwarded-Encrypted: i=1; AJvYcCV/jLZopHGUFTVKZDSbGcOAfouCZFmEsC3zCpAkhkdCTX1wmiL9PLDyo5bFGxj3DlQWm2jETYdFKTIaYxwFg5OBduw46p7i/Wu7mkNWppyxNYVo8bfcegIrnESTN+mQolFfg2twz3Bw
X-Gm-Message-State: AOJu0YzhuFsaQtePkrSkJyKELjxuHuw5Xl22sb7M9uuAsv7FduDIaNdp
	9BdAq7T8D85do8w95mrBcuumePaASzNcLPt7vK7lnDlg4FhmNdL2u/RFRrzUtPw=
X-Google-Smtp-Source: AGHT+IFDmAnb1hp1LRZqe+AWbOY4AfuC5s9bZRSiu97qd8ssLexNt4cwa4UprzCh+ZZGg6sB3gQlVg==
X-Received: by 2002:a05:600c:1f94:b0:41b:fad8:45e0 with SMTP id je20-20020a05600c1f9400b0041bfad845e0mr1742308wmb.0.1714301321846;
        Sun, 28 Apr 2024 03:48:41 -0700 (PDT)
Received: from fedora.. (cable-178-148-234-71.dynamic.sbb.rs. [178.148.234.71])
        by smtp.gmail.com with ESMTPSA id g7-20020a05600c4ec700b0041c24321934sm1268352wmq.41.2024.04.28.03.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 03:48:41 -0700 (PDT)
From: Aleksa Savic <savicaleksa83@gmail.com>
To: linux-hwmon@vger.kernel.org
Cc: Aleksa Savic <savicaleksa83@gmail.com>,
	Jonas Malaco <jonas@protocubo.io>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] hwmon: (nzxt-kraken3) Add support for NZXT Kraken 2023 (standard and Elite) models
Date: Sun, 28 Apr 2024 12:48:11 +0200
Message-ID: <20240428104812.14037-3-savicaleksa83@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240428104812.14037-1-savicaleksa83@gmail.com>
References: <20240428104812.14037-1-savicaleksa83@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for NZXT Kraken 2023 (standard) and NZXT Kraken 2023 Elite
all-in-one CPU coolers. These models communicate identically to the NZXT
Kraken Z-series (Z53 code paths) in all cases except when writing the
fan curve, where setting additional bits in the report is needed.

Reviewed-by: Jonas Malaco <jonas@protocubo.io>
Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
---
 Documentation/hwmon/nzxt-kraken3.rst | 19 ++++++++------
 drivers/hwmon/nzxt-kraken3.c         | 38 ++++++++++++++++++++++------
 2 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/Documentation/hwmon/nzxt-kraken3.rst b/Documentation/hwmon/nzxt-kraken3.rst
index 90fd9dec15ff..57fe99d23301 100644
--- a/Documentation/hwmon/nzxt-kraken3.rst
+++ b/Documentation/hwmon/nzxt-kraken3.rst
@@ -11,17 +11,20 @@ Supported devices:
 * NZXT Kraken Z53
 * NZXT Kraken Z63
 * NZXT Kraken Z73
+* NZXT Kraken 2023
+* NZXT Kraken 2023 Elite
 
 Author: Jonas Malaco, Aleksa Savic
 
 Description
 -----------
 
-This driver enables hardware monitoring support for NZXT Kraken X53/X63/X73 and
-Z53/Z63/Z73 all-in-one CPU liquid coolers. All models expose liquid temperature
-and pump speed (in RPM), as well as PWM control (either as a fixed value
-or through a temp-PWM curve). The Z-series models additionally expose the speed
-and duty of an optionally connected fan, with the same PWM control capabilities.
+This driver enables hardware monitoring support for NZXT Kraken X53/X63/X73,
+Z53/Z63/Z73 and Kraken 2023 (standard and Elite) all-in-one CPU liquid coolers.
+All models expose liquid temperature and pump speed (in RPM), as well as PWM
+control (either as a fixed value or through a temp-PWM curve). The Z-series and
+Kraken 2023 models additionally expose the speed and duty of an optionally connected
+fan, with the same PWM control capabilities.
 
 Pump and fan duty control mode can be set through pwm[1-2]_enable, where 1 is
 for the manual control mode and 2 is for the liquid temp to PWM curve mode.
@@ -39,9 +42,9 @@ The devices can report if they are faulty. The driver supports that situation
 and will issue a warning. This can also happen when the USB cable is connected,
 but SATA power is not.
 
-The addressable RGB LEDs and LCD screen (only on Z-series models) are not
-supported in this driver, but can be controlled through existing userspace tools,
-such as `liquidctl`_.
+The addressable RGB LEDs and LCD screen (only on Z-series and Kraken 2023 models)
+are not supported in this driver, but can be controlled through existing userspace
+tools, such as `liquidctl`_.
 
 .. _liquidctl: https://github.com/liquidctl/liquidctl
 
diff --git a/drivers/hwmon/nzxt-kraken3.c b/drivers/hwmon/nzxt-kraken3.c
index 571087e3fd3e..0b3f04c740b0 100644
--- a/drivers/hwmon/nzxt-kraken3.c
+++ b/drivers/hwmon/nzxt-kraken3.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * hwmon driver for NZXT Kraken X53/X63/X73 and Z53/Z63/Z73 all in one coolers.
- * X53 and Z53 in code refer to all models in their respective series (shortened
- * for brevity).
+ * hwmon driver for NZXT Kraken X53/X63/X73, Z53/Z63/Z73 and 2023/2023 Elite all in one coolers.
+ * X53 and Z53 in code refer to all models in their respective series (shortened for brevity).
+ * 2023 models use the Z53 code paths.
  *
  * Copyright 2021  Jonas Malaco <jonas@protocubo.io>
  * Copyright 2022  Aleksa Savic <savicaleksa83@gmail.com>
@@ -23,8 +23,10 @@
 #define USB_PRODUCT_ID_X53		0x2007
 #define USB_PRODUCT_ID_X53_SECOND	0x2014
 #define USB_PRODUCT_ID_Z53		0x3008
+#define USB_PRODUCT_ID_KRAKEN2023	0x300E
+#define USB_PRODUCT_ID_KRAKEN2023_ELITE	0x300C
 
-enum kinds { X53, Z53 } __packed;
+enum kinds { X53, Z53, KRAKEN2023 } __packed;
 enum pwm_enable { off, manual, curve } __packed;
 
 #define DRIVER_NAME		"nzxt_kraken3"
@@ -136,6 +138,7 @@ static umode_t kraken3_is_visible(const void *data, enum hwmon_sensor_types type
 				return 0444;
 			break;
 		case Z53:
+		case KRAKEN2023:
 			/* Pump and fan */
 			if (channel < 2)
 				return 0444;
@@ -155,6 +158,7 @@ static umode_t kraken3_is_visible(const void *data, enum hwmon_sensor_types type
 					return 0644;
 				break;
 			case Z53:
+			case KRAKEN2023:
 				/* Pump and fan */
 				if (channel < 2)
 					return 0644;
@@ -242,6 +246,7 @@ static int kraken3_read_x53(struct kraken3_data *priv)
 	return 0;
 }
 
+/* Covers Z53 and KRAKEN2023 device kinds */
 static int kraken3_read_z53(struct kraken3_data *priv)
 {
 	int ret = mutex_lock_interruptible(&priv->z53_status_request_lock);
@@ -355,6 +360,13 @@ static int kraken3_write_curve(struct kraken3_data *priv, u8 *curve_array, int c
 	/* Set the correct ID for writing pump/fan duty (0x01 or 0x02, respectively) */
 	fixed_duty_cmd[SET_DUTY_ID_OFFSET] = channel + 1;
 
+	if (priv->kind == KRAKEN2023) {
+		/* These require 1s in the next one or two slots after SET_DUTY_ID_OFFSET */
+		fixed_duty_cmd[SET_DUTY_ID_OFFSET + 1] = 1;
+		if (channel == 1) /* Fan */
+			fixed_duty_cmd[SET_DUTY_ID_OFFSET + 2] = 1;
+	}
+
 	/* Copy curve to command */
 	memcpy(fixed_duty_cmd + SET_CURVE_DUTY_CMD_HEADER_LENGTH, curve_array, CUSTOM_CURVE_POINTS);
 
@@ -502,8 +514,8 @@ static umode_t kraken3_curve_props_are_visible(struct kobject *kobj, struct attr
 	struct device *dev = kobj_to_dev(kobj);
 	struct kraken3_data *priv = dev_get_drvdata(dev);
 
-	/* Only Z53 has the fan curve */
-	if (index >= CUSTOM_CURVE_POINTS && priv->kind != Z53)
+	/* X53 does not have a fan */
+	if (index >= CUSTOM_CURVE_POINTS && priv->kind == X53)
 		return 0;
 
 	return attr->mode;
@@ -769,8 +781,8 @@ static int kraken3_raw_event(struct hid_device *hdev, struct hid_report *report,
 	if (priv->kind == X53 && !completion_done(&priv->status_report_processed)) {
 		/* Mark first X-series device report as received */
 		complete_all(&priv->status_report_processed);
-	} else if (priv->kind == Z53) {
-		/* Additional readings for Z53 */
+	} else if (priv->kind == Z53 || priv->kind == KRAKEN2023) {
+		/* Additional readings for Z53 and KRAKEN2023 */
 		priv->fan_input[1] = get_unaligned_le16(data + Z53_FAN_SPEED_OFFSET);
 		priv->channel_info[1].reported_duty =
 		    kraken3_percent_to_pwm(data[Z53_FAN_DUTY_OFFSET]);
@@ -907,6 +919,14 @@ static int kraken3_probe(struct hid_device *hdev, const struct hid_device_id *id
 		priv->kind = Z53;
 		device_name = "z53";
 		break;
+	case USB_PRODUCT_ID_KRAKEN2023:
+		priv->kind = KRAKEN2023;
+		device_name = "kraken2023";
+		break;
+	case USB_PRODUCT_ID_KRAKEN2023_ELITE:
+		priv->kind = KRAKEN2023;
+		device_name = "kraken2023elite";
+		break;
 	default:
 		break;
 	}
@@ -969,6 +989,8 @@ static const struct hid_device_id kraken3_table[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_NZXT, USB_PRODUCT_ID_X53) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_NZXT, USB_PRODUCT_ID_X53_SECOND) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_NZXT, USB_PRODUCT_ID_Z53) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_NZXT, USB_PRODUCT_ID_KRAKEN2023) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_NZXT, USB_PRODUCT_ID_KRAKEN2023_ELITE) },
 	{ }
 };
 
-- 
2.44.0


