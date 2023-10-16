Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268FF7CA1D1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjJPIie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbjJPIib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:38:31 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5543710D;
        Mon, 16 Oct 2023 01:38:24 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-406609df1a6so41259535e9.3;
        Mon, 16 Oct 2023 01:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697445502; x=1698050302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTkqFwPt0aEXFhb7PLLlF1hO7I83zUiamZxBrmXfZfM=;
        b=LvOHUtokYFXM41vnmO1GyHnK2mWjuL1cQtjAzg+qhE6yYKHn9gQ/nTiW2yWSoPeoL7
         jx3TaMMD4r8rf8juCaqqavEbYzhBxm8w3sI+qk35/59VMGJcOjsUmSeHN61yhf/TylN8
         3Lqy9F6pLwXdcI7D/f4q0WQ+zJL51mpwJ6zrBXZCKzQNt4mN9RRrT0dmnb77Gb8BbUak
         zLJFBqGVpvqvHGZedFn/a7pTTVjiuK5sEbHhNuJwouwf/EJK4mP1norSkB9nOlCSBLUW
         Hs7QMA9Ko5IBKq9TcFaN7m637bnu3UHdmhguN2FyRkxpd0mMmHPgaY8HwsTaJsARj0Hy
         6B5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697445502; x=1698050302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WTkqFwPt0aEXFhb7PLLlF1hO7I83zUiamZxBrmXfZfM=;
        b=j2QDz8TD1z66FoZprDe7BjcWdg5l7oZqmwPIEfrrKIkAO+zE7/Scoux27H1EprKmob
         yW249CRD2BGoHxYbtu8CNfv66kRn0TFggVWPCGHBLKYVHbS5pRBXrQ2aA384JEsMru1E
         KRJTcN3wZYDIT4cALRX81AzZFVNVslFF0gm0FtYv6BacpOuI/14VgGSCCpUmjQXvg90O
         kDPv5TpZVQf4IVv1qi7x8xGbvILkKBCBaVNldKSyOiHNwclLQaAwIYNMhAcI+r8gYKly
         rjdknXibwUixidH10PYkxF2SluRdH+EJhdi0SIUtX9nF+ZQKKz5nZwJnmwYaoYKDVnsi
         WGqw==
X-Gm-Message-State: AOJu0YzsJfuJZ8v3GdT5+9IDKBkNLzpBFz6fKOUK2gIQD8skVzcMSDBX
        IlngLfYUtp1qHNds4JXxXFuIrNq+hCm+/g==
X-Google-Smtp-Source: AGHT+IFCyrG3zs0e8XFkOrfanhgTaGEi55CK+Y5UyYAS+Eep5YQIX3JLev/pF7q16k8a/h9NhZ1EnA==
X-Received: by 2002:a1c:f202:0:b0:407:5ad0:ab5b with SMTP id s2-20020a1cf202000000b004075ad0ab5bmr13788661wmc.8.1697445502291;
        Mon, 16 Oct 2023 01:38:22 -0700 (PDT)
Received: from fedora.. (cable-178-148-234-71.dynamic.sbb.rs. [178.148.234.71])
        by smtp.gmail.com with ESMTPSA id p20-20020a05600c469400b004067e905f44sm6633554wmo.9.2023.10.16.01.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 01:38:22 -0700 (PDT)
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     leonard.anderweit@gmail.com,
        Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] hwmon: (aquacomputer_d5next) Add support for Aquacomputer High Flow USB and MPS Flow
Date:   Mon, 16 Oct 2023 10:35:58 +0200
Message-ID: <20231016083559.139341-3-savicaleksa83@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231016083559.139341-1-savicaleksa83@gmail.com>
References: <20231016083559.139341-1-savicaleksa83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend aquacomputer_d5next driver to expose various hardware sensors of the
Aquacomputer High Flow USB flow sensor, which communicates through a
proprietary USB HID protocol. This commit also adds support for the sensors
of the MPS Flow devices, as they have the same USB product ID and sensor
layouts. Implemented by Leonard Anderweit [1].

Internal and external temp sensor readings are available, along with
the flow sensor.

Additionally, serial number and firmware version are exposed through
debugfs.

[1] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/pull/90

Originally-from: Leonard Anderweit <leonard.anderweit@gmail.com>
Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
---
 Documentation/hwmon/aquacomputer_d5next.rst |  7 +++
 drivers/hwmon/aquacomputer_d5next.c         | 67 +++++++++++++++++++--
 2 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
index 94dc2d93d180..cb073c79479c 100644
--- a/Documentation/hwmon/aquacomputer_d5next.rst
+++ b/Documentation/hwmon/aquacomputer_d5next.rst
@@ -16,6 +16,8 @@ Supported devices:
 * Aquacomputer Aquastream XT watercooling pump
 * Aquacomputer Aquastream Ultimate watercooling pump
 * Aquacomputer Poweradjust 3 fan controller
+* Aquacomputer High Flow USB flow meter
+* Aquacomputer MPS Flow devices
 
 Author: Aleksa Savic
 
@@ -73,6 +75,11 @@ It also exposes pressure and flow speed readings.
 
 The Poweradjust 3 controller exposes a single external temperature sensor.
 
+The High Flow USB exposes an internal and external temperature sensor, and a flow meter.
+
+The MPS Flow devices expose the same entries as the High Flow USB because they have
+the same USB product ID and report sensors equivalently.
+
 Depending on the device, not all sysfs and debugfs entries will be available.
 Writing to virtual temperature sensors is not currently supported.
 
diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index 46ff4fd4f87d..4fdd2e12427b 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -1,11 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * hwmon driver for Aquacomputer devices (D5 Next, Farbwerk, Farbwerk 360, Octo,
- * Quadro, High Flow Next, Aquaero, Aquastream Ultimate, Leakshield)
+ * Quadro, High Flow Next, Aquaero, Aquastream Ultimate, Leakshield,
+ * High Flow USB/MPS Flow family)
  *
  * Aquacomputer devices send HID reports (with ID 0x01) every second to report
  * sensor values, except for devices that communicate through the
- * legacy way (currently, Poweradjust 3).
+ * legacy way (currently, Poweradjust 3 and High Flow USB/MPS Flow family).
  *
  * Copyright 2021 Aleksa Savic <savicaleksa83@gmail.com>
  * Copyright 2022 Jack Doan <me@jackdoan.com>
@@ -35,11 +36,12 @@
 #define USB_PRODUCT_ID_AQUASTREAMXT	0xf0b6
 #define USB_PRODUCT_ID_AQUASTREAMULT	0xf00b
 #define USB_PRODUCT_ID_POWERADJUST3	0xf0bd
+#define USB_PRODUCT_ID_HIGHFLOW		0xf003
 
 enum kinds {
 	d5next, farbwerk, farbwerk360, octo, quadro,
 	highflownext, aquaero, poweradjust3, aquastreamult,
-	aquastreamxt, leakshield
+	aquastreamxt, leakshield, highflow
 };
 
 static const char *const aqc_device_names[] = {
@@ -53,7 +55,8 @@ static const char *const aqc_device_names[] = {
 	[aquastreamxt] = "aquastreamxt",
 	[aquaero] = "aquaero",
 	[aquastreamult] = "aquastreamultimate",
-	[poweradjust3] = "poweradjust3"
+	[poweradjust3] = "poweradjust3",
+	[highflow] = "highflow" /* Covers MPS Flow devices */
 };
 
 #define DRIVER_NAME			"aquacomputer_d5next"
@@ -90,6 +93,8 @@ static u8 aquaero_secondary_ctrl_report[] = {
 
 #define POWERADJUST3_STATUS_REPORT_ID	0x03
 
+#define HIGHFLOW_STATUS_REPORT_ID	0x02
+
 /* Data types for reading and writing control reports */
 #define AQC_8		0
 #define AQC_BE16	1
@@ -282,6 +287,17 @@ static u16 aquastreamxt_sensor_fan_offsets[] = { 0x13, 0x1b };
 /* Sensor report offsets for the Poweradjust 3 */
 #define POWERADJUST3_SENSOR_START	0x03
 
+/* Specs of the High Flow USB */
+#define HIGHFLOW_NUM_SENSORS		2
+#define HIGHFLOW_NUM_FLOW_SENSORS	1
+#define HIGHFLOW_SENSOR_REPORT_SIZE	0x76
+
+/* Sensor report offsets for the High Flow USB */
+#define HIGHFLOW_FIRMWARE_VERSION	0x3
+#define HIGHFLOW_SERIAL_START		0x9
+#define HIGHFLOW_FLOW_SENSOR_OFFSET	0x23
+#define HIGHFLOW_SENSOR_START		0x2b
+
 /* Labels for D5 Next */
 static const char *const label_d5next_temp[] = {
 	"Coolant temp"
@@ -486,6 +502,16 @@ static const char *const label_poweradjust3_temp_sensors[] = {
 	"External sensor"
 };
 
+/* Labels for Highflow */
+static const char *const label_highflow_temp[] = {
+	"External temp",
+	"Internal temp"
+};
+
+static const char *const label_highflow_speeds[] = {
+	"Flow speed [dL/h]"
+};
+
 struct aqc_fan_structure_offsets {
 	u8 voltage;
 	u8 curr;
@@ -819,6 +845,7 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
 				break;
 			case aquaero:
 			case quadro:
+			case highflow:
 				/* Special case to support flow sensors */
 				if (channel < priv->num_fans + priv->num_flow_sensors)
 					return 0444;
@@ -965,6 +992,17 @@ static int aqc_legacy_read(struct aqc_data *priv)
 		sensor_value = get_unaligned_le16(priv->buffer + AQUASTREAMXT_FAN_VOLTAGE_OFFSET);
 		priv->voltage_input[1] = DIV_ROUND_CLOSEST(sensor_value * 1000, 63);
 		break;
+	case highflow:
+		/* Info provided with every report */
+		priv->serial_number[0] = get_unaligned_le16(priv->buffer +
+							    priv->serial_number_start_offset);
+		priv->firmware_version =
+		    get_unaligned_le16(priv->buffer + priv->firmware_version_offset);
+
+		/* Read flow speed */
+		priv->speed_input[0] = get_unaligned_le16(priv->buffer +
+							  priv->flow_sensors_start_offset);
+		break;
 	default:
 		break;
 	}
@@ -1750,6 +1788,20 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 		priv->temp_label = label_poweradjust3_temp_sensors;
 		break;
+	case USB_PRODUCT_ID_HIGHFLOW:
+		priv->kind = highflow;
+
+		priv->num_fans = 0;
+
+		priv->num_temp_sensors = HIGHFLOW_NUM_SENSORS;
+		priv->temp_sensor_start_offset = HIGHFLOW_SENSOR_START;
+		priv->num_flow_sensors = HIGHFLOW_NUM_FLOW_SENSORS;
+		priv->flow_sensors_start_offset = HIGHFLOW_FLOW_SENSOR_OFFSET;
+		priv->buffer_size = HIGHFLOW_SENSOR_REPORT_SIZE;
+
+		priv->temp_label = label_highflow_temp;
+		priv->speed_label = label_highflow_speeds;
+		break;
 	default:
 		break;
 	}
@@ -1775,6 +1827,12 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 		priv->status_report_id = AQUASTREAMXT_STATUS_REPORT_ID;
 		break;
+	case highflow:
+		priv->serial_number_start_offset = HIGHFLOW_SERIAL_START;
+		priv->firmware_version_offset = HIGHFLOW_FIRMWARE_VERSION;
+
+		priv->status_report_id = HIGHFLOW_STATUS_REPORT_ID;
+		break;
 	default:
 		priv->serial_number_start_offset = AQC_SERIAL_START;
 		priv->firmware_version_offset = AQC_FIRMWARE_VERSION;
@@ -1849,6 +1907,7 @@ static const struct hid_device_id aqc_table[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_AQUASTREAMXT) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_AQUASTREAMULT) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_POWERADJUST3) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_HIGHFLOW) },
 	{ }
 };
 
-- 
2.41.0

