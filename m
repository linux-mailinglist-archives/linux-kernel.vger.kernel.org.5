Return-Path: <linux-kernel+bounces-42605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF3A8403B2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91F222815E1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11125B5DE;
	Mon, 29 Jan 2024 11:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSJ9LL8X"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431F259B73;
	Mon, 29 Jan 2024 11:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706527228; cv=none; b=qR7hY5lDrJjTvnBF4/GfO7L9lAEW6X+mZ90Die9UimFZWotBTrh/k8V8WUlbdXZh8az7lSkzcdVbhDeETnvZ/2jBQdFFHJR9WQta3LsuJelR+l06JtQa9DiFAlEg7Mzn7I9wbcAViUElo54kh7N+kIY7Qvn65c4PGaMwAwkkH94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706527228; c=relaxed/simple;
	bh=sl6qvKoitJOaNraacGPk7UzZpl6ILhTYXVOVD3hXZ48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lPYK+FkphLKuLmL9fgqShvKkPmr6uUz0n2QSn3JztR4Pb5KJ8d6k+afRmLxIsguSRi3UpYwxX3sV+artgKs0+ydqIBiqU+a6ACTnDYC9jjVec58gbz2tQQgwYOLF4yuvnZ5MqAs+hB9CK01xZNDtn516gOMBL7FruW+cvkcXWUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSJ9LL8X; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so2812682a12.0;
        Mon, 29 Jan 2024 03:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706527223; x=1707132023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rJF51+acaZPbCH3B80okBMYHwCLPHw/sipkT/oCU3AU=;
        b=eSJ9LL8XDtVs6P/TobB2+ksVb5XSVkUSVk46/9ukc2G0l157hLZBI2VtcKY6RqAI8i
         A9aBu3qhGcoBCu/xI+vuXXzMbJ3ZyxorGpMZ/O9FKFsfcpo8XZaxLrNi+amndSjXPQsB
         OAmPURkXpV+KFQdiXsobKGKswmCnYcK8+T96waQuWk0yrbk/ukYHdb+/SRaNn6eKBkqy
         Nkut+ltZrE7BD/d52mbnWNA9VHYCIjOkgEFgfxxW1TPincTAVBIc9a2Rtjum5B7FvsQp
         Hk4/GxLTbsE5kCYu7FbjIoHJQZr3zg1Km6UjFT++3kGR1kVfqpooaZlFyun+gsH+98XR
         M3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706527223; x=1707132023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rJF51+acaZPbCH3B80okBMYHwCLPHw/sipkT/oCU3AU=;
        b=jCLJmplzbnytDD5xnccnczkZZcjpZqZBVN6UhIFwikBGeCGwoRGhY+NtZEj8auGfZL
         3ha5WnubEM+aYEDMsf8Sd0PCX4EK9qgp4/cZe021BW5IFDWAfX7zLGaMhsgNgccEjzZh
         YN97PvI1Afh7mrfMofMMnUP/X+anPi1Vs0LbX3qMftv9H5f6yKO4wI++vsDQ6YWN6tmd
         mxF0UeVLQnWRjEYWw0yzoH1Eop56/VGNz3JOOsNVQQ4oIE/BzzHgUOYrPGqgrKtXovIY
         4SlFpPrP0dw9wA23wtfLf0NLJ1D0DGioyu5fyqDqrUqkTujPDamQQWK14qENj82jrEVS
         RDNg==
X-Gm-Message-State: AOJu0YxLsEIaBR/99Tq4fRGyjdpBe8t+QeIWLzjFWbx4RhIzBv/+RqTA
	YS2QI/jBt78/30V44T2DTXx7AOafzm4hg3nlduDGZW4jdNw2EC8b+11A0Hda+fw=
X-Google-Smtp-Source: AGHT+IEwLhwv3VsebBoejahvYH6W0IPoAbYNDhI919OZfd9TNJ9v6tvLBbpm4/I/tSEpdmBirqm80Q==
X-Received: by 2002:a17:906:2b47:b0:a35:7b14:dc50 with SMTP id b7-20020a1709062b4700b00a357b14dc50mr2739388ejg.17.1706527222582;
        Mon, 29 Jan 2024 03:20:22 -0800 (PST)
Received: from fedora.. (cable-178-148-234-71.dynamic.sbb.rs. [178.148.234.71])
        by smtp.gmail.com with ESMTPSA id tz9-20020a170907c78900b00a35920de35dsm1573255ejc.188.2024.01.29.03.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 03:20:22 -0800 (PST)
From: Aleksa Savic <savicaleksa83@gmail.com>
To: linux-hwmon@vger.kernel.org
Cc: Aleksa Savic <savicaleksa83@gmail.com>,
	Jonas Malaco <jonas@protocubo.io>,
	Yury Zhuravlev <stalkerg@gmail.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: Add driver for NZXT Kraken X and Z series AIO CPU coolers
Date: Mon, 29 Jan 2024 12:19:28 +0100
Message-ID: <20240129111932.368232-1-savicaleksa83@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver enables hardware monitoring support for NZXT Kraken
X53/X63/X73 and Z53/Z63/Z73 all-in-one CPU liquid coolers.

All models expose liquid temperature and pump speed (in RPM), as well as
PWM control (natively only through a temp-PWM curve, but the driver also
emulates fixed PWM control on top of that). The Z-series models
additionally expose the speed and duty of an optionally connected fan,
with the same PWM control capabilities.

Pump and fan duty control mode can be set through pwm[1-2]_enable,
where 1 is for the manual control mode and 2 is for the liquid temp
to PWM curve mode. Writing a 0 disables control of the channel through
the driver after setting its duty to 100%. As it is not possible to query
the device for the active mode, the driver keeps track of it.

The temperature of the curves relates to the fixed [20-59] C range, per
device limitations, and correlating to the detected liquid temperature.
Only PWM values (ranging from 0-255) can be set.

The addressable RGB LEDs and LCD screen, included only on Z-series models,
are not supported in this driver.

Co-developed-by: Jonas Malaco <jonas@protocubo.io>
Signed-off-by: Jonas Malaco <jonas@protocubo.io>
Co-developed-by: Yury Zhuravlev <stalkerg@gmail.com>
Signed-off-by: Yury Zhuravlev <stalkerg@gmail.com>
Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
---
 Documentation/hwmon/index.rst        |    1 +
 Documentation/hwmon/nzxt-kraken3.rst |   74 ++
 MAINTAINERS                          |    8 +
 drivers/hwmon/Kconfig                |   10 +
 drivers/hwmon/Makefile               |    1 +
 drivers/hwmon/nzxt-kraken3.c         | 1008 ++++++++++++++++++++++++++
 6 files changed, 1102 insertions(+)
 create mode 100644 Documentation/hwmon/nzxt-kraken3.rst
 create mode 100644 drivers/hwmon/nzxt-kraken3.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index c7ed1f73ac06..7b3bc243b115 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -171,6 +171,7 @@ Hardware Monitoring Kernel Drivers
    nsa320
    ntc_thermistor
    nzxt-kraken2
+   nzxt-kraken3
    nzxt-smart2
    occ
    oxp-sensors
diff --git a/Documentation/hwmon/nzxt-kraken3.rst b/Documentation/hwmon/nzxt-kraken3.rst
new file mode 100644
index 000000000000..90fd9dec15ff
--- /dev/null
+++ b/Documentation/hwmon/nzxt-kraken3.rst
@@ -0,0 +1,74 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Kernel driver nzxt-kraken3
+==========================
+
+Supported devices:
+
+* NZXT Kraken X53
+* NZXT Kraken X63
+* NZXT Kraken X73
+* NZXT Kraken Z53
+* NZXT Kraken Z63
+* NZXT Kraken Z73
+
+Author: Jonas Malaco, Aleksa Savic
+
+Description
+-----------
+
+This driver enables hardware monitoring support for NZXT Kraken X53/X63/X73 and
+Z53/Z63/Z73 all-in-one CPU liquid coolers. All models expose liquid temperature
+and pump speed (in RPM), as well as PWM control (either as a fixed value
+or through a temp-PWM curve). The Z-series models additionally expose the speed
+and duty of an optionally connected fan, with the same PWM control capabilities.
+
+Pump and fan duty control mode can be set through pwm[1-2]_enable, where 1 is
+for the manual control mode and 2 is for the liquid temp to PWM curve mode.
+Writing a 0 disables control of the channel through the driver after setting its
+duty to 100%.
+
+The temperature of the curves relates to the fixed [20-59] range, correlating to
+the detected liquid temperature. Only PWM values (ranging from 0-255) can be set.
+If in curve mode, setting point values should be done in moderation - the devices
+require complete curves to be sent for each change; they can lock up or discard
+the changes if they are too numerous at once. Suggestion is to set them while
+in an another mode, and then apply them by switching to curve.
+
+The devices can report if they are faulty. The driver supports that situation
+and will issue a warning. This can also happen when the USB cable is connected,
+but SATA power is not.
+
+The addressable RGB LEDs and LCD screen (only on Z-series models) are not
+supported in this driver, but can be controlled through existing userspace tools,
+such as `liquidctl`_.
+
+.. _liquidctl: https://github.com/liquidctl/liquidctl
+
+Usage Notes
+-----------
+
+As these are USB HIDs, the driver can be loaded automatically by the kernel and
+supports hot swapping.
+
+Possible pwm_enable values are:
+
+====== ==========================================================================
+0      Set fan to 100%
+1      Direct PWM mode (applies value in corresponding PWM entry)
+2      Curve control mode (applies the temp-PWM duty curve based on coolant temp)
+====== ==========================================================================
+
+Sysfs entries
+-------------
+
+============================== ================================================================
+fan1_input                     Pump speed (in rpm)
+fan2_input                     Fan speed (in rpm)
+temp1_input                    Coolant temperature (in millidegrees Celsius)
+pwm1                           Pump duty (value between 0-255)
+pwm1_enable                    Pump duty control mode (0: disabled, 1: manual, 2: curve)
+pwm2                           Fan duty (value between 0-255)
+pwm2_enable                    Fan duty control mode (0: disabled, 1: manual, 2: curve)
+temp[1-2]_auto_point[1-40]_pwm Temp-PWM duty curves (for pump and fan), related to coolant temp
+============================== ================================================================
diff --git a/MAINTAINERS b/MAINTAINERS
index 5e7239cb40ea..f5e66daebf1e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15811,6 +15811,14 @@ S:	Maintained
 F:	Documentation/hwmon/nzxt-kraken2.rst
 F:	drivers/hwmon/nzxt-kraken2.c
 
+NZXT-KRAKEN3 HARDWARE MONITORING DRIVER
+M:	Jonas Malaco <jonas@protocubo.io>
+M:	Aleksa Savic <savicaleksa83@gmail.com>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	Documentation/hwmon/nzxt-kraken3.rst
+F:	drivers/hwmon/nzxt-kraken3.c
+
 NZXT-SMART2 HARDWARE MONITORING DRIVER
 M:	Aleksandr Mezin <mezin.alexander@gmail.com>
 L:	linux-hwmon@vger.kernel.org
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index a608264da87d..10b8f219fac6 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1674,6 +1674,16 @@ config SENSORS_NZXT_KRAKEN2
 	  This driver can also be built as a module. If so, the module
 	  will be called nzxt-kraken2.
 
+config SENSORS_NZXT_KRAKEN3
+	tristate "NZXT Kraken X53/X63/X73, Z53/Z63/Z73 coolers"
+	depends on USB_HID
+	help
+	  If you say yes here you get support for hardware monitoring for the
+	  NZXT Kraken X53/X63/X73, Z53/Z63/Z73 all-in-one CPU liquid coolers.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nzxt-kraken3.
+
 config SENSORS_NZXT_SMART2
 	tristate "NZXT RGB & Fan Controller/Smart Device v2"
 	depends on USB_HID
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 47be39af5c03..5ffeb0ad7fbb 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -173,6 +173,7 @@ obj-$(CONFIG_SENSORS_NPCM7XX)	+= npcm750-pwm-fan.o
 obj-$(CONFIG_SENSORS_NSA320)	+= nsa320-hwmon.o
 obj-$(CONFIG_SENSORS_NTC_THERMISTOR)	+= ntc_thermistor.o
 obj-$(CONFIG_SENSORS_NZXT_KRAKEN2) += nzxt-kraken2.o
+obj-$(CONFIG_SENSORS_NZXT_KRAKEN3) += nzxt-kraken3.o
 obj-$(CONFIG_SENSORS_NZXT_SMART2) += nzxt-smart2.o
 obj-$(CONFIG_SENSORS_OXP) += oxp-sensors.o
 obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
diff --git a/drivers/hwmon/nzxt-kraken3.c b/drivers/hwmon/nzxt-kraken3.c
new file mode 100644
index 000000000000..5806a3f32bcb
--- /dev/null
+++ b/drivers/hwmon/nzxt-kraken3.c
@@ -0,0 +1,1008 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * hwmon driver for NZXT Kraken X53/X63/X73 and Z53/Z63/Z73 all in one coolers.
+ * X53 and Z53 in code refer to all models in their respective series (shortened
+ * for brevity).
+ *
+ * Copyright 2021  Jonas Malaco <jonas@protocubo.io>
+ * Copyright 2022  Aleksa Savic <savicaleksa83@gmail.com>
+ */
+
+#include <linux/debugfs.h>
+#include <linux/hid.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
+#include <asm/unaligned.h>
+
+#define USB_VENDOR_ID_NZXT		0x1e71
+#define USB_PRODUCT_ID_X53		0x2007
+#define USB_PRODUCT_ID_X53_SECOND	0x2014
+#define USB_PRODUCT_ID_Z53		0x3008
+
+enum kinds { X53, Z53 } __packed;
+enum pwm_enable { off, manual, curve } __packed;
+
+static const char *const kraken3_device_names[] = {
+	[X53] = "x53",
+	[Z53] = "z53",
+};
+
+#define DRIVER_NAME		"nzxt_kraken3"
+#define STATUS_REPORT_ID	0x75
+#define FIRMWARE_REPORT_ID	0x11
+#define STATUS_VALIDITY		2000	/* In ms, equivalent to period of four status reports */
+#define CUSTOM_CURVE_POINTS	40	/* For temps from 20C to 59C (critical temp) */
+#define PUMP_DUTY_MIN		20	/* In percent */
+
+/* Sensor report offsets for Kraken X53 and Z53 */
+#define TEMP_SENSOR_START_OFFSET	15
+#define TEMP_SENSOR_END_OFFSET		16
+#define PUMP_SPEED_OFFSET		17
+#define PUMP_DUTY_OFFSET		19
+
+/* Firmware version report offset for Kraken X53 and Z53 */
+#define FIRMWARE_VERSION_OFFSET		17
+
+/* Sensor report offsets for Kraken Z53 */
+#define Z53_FAN_SPEED_OFFSET		23
+#define Z53_FAN_DUTY_OFFSET		25
+
+/* Report offsets for control commands for Kraken X53 and Z53 */
+#define SET_DUTY_ID_OFFSET		1
+
+/* Control commands and their lengths for Kraken X53 and Z53 */
+
+/* Last byte sets the report interval at 0.5s */
+static const u8 set_interval_cmd[] = { 0x70, 0x02, 0x01, 0xB8, 1 };
+static const u8 finish_init_cmd[] = { 0x70, 0x01 };
+static const u8 __maybe_unused get_fw_version_cmd[] = { 0x10, 0x01 };
+static const u8 set_pump_duty_cmd_header[] = { 0x72, 0x00, 0x00, 0x00 };
+static const u8 z53_get_status_cmd[] = { 0x74, 0x01 };
+
+#define SET_INTERVAL_CMD_LENGTH			5
+#define FINISH_INIT_CMD_LENGTH			2
+#define GET_FW_VERSION_CMD_LENGTH		2
+#define MAX_REPORT_LENGTH			64
+#define MIN_REPORT_LENGTH			20
+#define SET_CURVE_DUTY_CMD_HEADER_LENGTH	4
+/* 4 byte header and 40 duty offsets */
+#define SET_CURVE_DUTY_CMD_LENGTH		(4 + 40)
+#define Z53_GET_STATUS_CMD_LENGTH		2
+
+static const char *const kraken3_temp_label[] = {
+	"Coolant temp",
+};
+
+static const char *const kraken3_fan_label[] = {
+	"Pump speed",
+	"Fan speed"
+};
+
+struct kraken3_channel_info {
+	enum pwm_enable mode;
+
+	/* Both values are PWM */
+	u16 reported_duty;
+	u16 fixed_duty;		/* Manually set fixed duty */
+
+	u8 pwm_points[CUSTOM_CURVE_POINTS];
+};
+
+struct kraken3_data {
+	struct hid_device *hdev;
+	struct device *hwmon_dev;
+	struct dentry *debugfs;
+	struct mutex buffer_lock;	/* For locking access to buffer */
+	struct mutex z53_status_request_lock;
+	struct completion fw_version_processed;
+	/*
+	 * For X53 devices, tracks whether an initial (one) sensor report was received to
+	 * make fancontrol not bail outright. For Z53 devices, whether a status report
+	 * was processed after requesting one.
+	 */
+	struct completion status_report_processed;
+	/* For locking the above completion */
+	spinlock_t status_completion_lock;
+
+	u8 *buffer;
+	struct kraken3_channel_info channel_info[2];	/* Pump and fan */
+	bool is_device_faulty;
+
+	/* Sensor values */
+	s32 temp_input[1];
+	u16 fan_input[2];
+
+	enum kinds kind;
+	u8 firmware_version[3];
+
+	unsigned long updated;	/* jiffies */
+};
+
+static umode_t kraken3_is_visible(const void *data, enum hwmon_sensor_types type, u32 attr,
+				  int channel)
+{
+	const struct kraken3_data *priv = data;
+
+	switch (type) {
+	case hwmon_temp:
+		if (channel < 1)
+			return 0444;
+		break;
+	case hwmon_fan:
+		switch (priv->kind) {
+		case X53:
+			/* Just the pump */
+			if (channel < 1)
+				return 0444;
+			break;
+		case Z53:
+			/* Pump and fan */
+			if (channel < 2)
+				return 0444;
+			break;
+		default:
+			break;
+		}
+		break;
+	case hwmon_pwm:
+		switch (attr) {
+		case hwmon_pwm_enable:
+		case hwmon_pwm_input:
+			switch (priv->kind) {
+			case X53:
+				/* Just the pump */
+				if (channel < 1)
+					return 0644;
+				break;
+			case Z53:
+				/* Pump and fan */
+				if (channel < 2)
+					return 0644;
+				break;
+			default:
+				break;
+			}
+			break;
+		default:
+			break;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+/*
+ * Writes the command to the device with the rest of the report (up to 64 bytes) filled
+ * with zeroes.
+ */
+static int kraken3_write_expanded(struct kraken3_data *priv, const u8 *cmd, int cmd_length)
+{
+	int ret;
+
+	mutex_lock(&priv->buffer_lock);
+
+	memcpy_and_pad(priv->buffer, MAX_REPORT_LENGTH, cmd, cmd_length, 0x00);
+	ret = hid_hw_output_report(priv->hdev, priv->buffer, MAX_REPORT_LENGTH);
+
+	mutex_unlock(&priv->buffer_lock);
+	return ret;
+}
+
+static int kraken3_percent_to_pwm(long val)
+{
+	return DIV_ROUND_CLOSEST(val * 255, 100);
+}
+
+static int kraken3_pwm_to_percent(long val, int channel)
+{
+	int percent_value;
+
+	if (val < 0 || val > 255)
+		return -EINVAL;
+
+	percent_value = DIV_ROUND_CLOSEST(val * 100, 255);
+
+	/* Bring up pump duty to min value if needed */
+	if (channel == 0 && percent_value < PUMP_DUTY_MIN)
+		percent_value = PUMP_DUTY_MIN;
+
+	return percent_value;
+}
+
+static int kraken3_read_x53(struct kraken3_data *priv)
+{
+	int ret;
+
+	if (completion_done(&priv->status_report_processed))
+		/*
+		 * We're here because data is stale. This means that sensor reports haven't
+		 * been received for some time in kraken3_raw_event(). On X-series sensor data
+		 * can't be manually requested, so return an error.
+		 */
+		return -ENODATA;
+
+	/*
+	 * Data needs to be read, but a sensor report wasn't yet received. It's usually
+	 * fancontrol that requests data this early and it exits if it reads an error code.
+	 * So, wait for the first report to be parsed (but up to STATUS_VALIDITY).
+	 * This does not concern the Z series devices, because they send a sensor report
+	 * only when requested.
+	 */
+	ret = wait_for_completion_interruptible_timeout(&priv->status_report_processed,
+							msecs_to_jiffies(STATUS_VALIDITY));
+	if (ret == 0)
+		return -ETIMEDOUT;
+	else if (ret < 0)
+		return ret;
+
+	/* The first sensor report was parsed on time and reading can continue */
+	return 0;
+}
+
+static int kraken3_read_z53(struct kraken3_data *priv)
+{
+	int ret = mutex_lock_interruptible(&priv->z53_status_request_lock);
+
+	if (ret < 0)
+		return ret;
+
+	if (!time_after(jiffies, priv->updated + msecs_to_jiffies(STATUS_VALIDITY))) {
+		/* Data is up to date */
+		goto unlock_and_return;
+	}
+
+	/*
+	 * Disable interrupts for a moment to safely reinit the completion,
+	 * as hidraw calls could have allowed one or more readers to complete.
+	 */
+	spin_lock_bh(&priv->status_completion_lock);
+	reinit_completion(&priv->status_report_processed);
+	spin_unlock_bh(&priv->status_completion_lock);
+
+	/* Send command for getting status */
+	ret = kraken3_write_expanded(priv, z53_get_status_cmd, Z53_GET_STATUS_CMD_LENGTH);
+	if (ret < 0)
+		goto unlock_and_return;
+
+	/* Wait for completion from kraken3_raw_event() */
+	ret = wait_for_completion_interruptible_timeout(&priv->status_report_processed,
+							msecs_to_jiffies(STATUS_VALIDITY));
+	if (ret == 0)
+		ret = -ETIMEDOUT;
+
+unlock_and_return:
+	mutex_unlock(&priv->z53_status_request_lock);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int kraken3_read(struct device *dev, enum hwmon_sensor_types type, u32 attr, int channel,
+			long *val)
+{
+	struct kraken3_data *priv = dev_get_drvdata(dev);
+	int ret;
+
+	if (time_after(jiffies, priv->updated + msecs_to_jiffies(STATUS_VALIDITY))) {
+		if (priv->kind == X53)
+			ret = kraken3_read_x53(priv);
+		else
+			ret = kraken3_read_z53(priv);
+
+		if (ret < 0)
+			return ret;
+
+		if (priv->is_device_faulty)
+			return -ENODATA;
+	}
+
+	switch (type) {
+	case hwmon_temp:
+		*val = priv->temp_input[channel];
+		break;
+	case hwmon_fan:
+		*val = priv->fan_input[channel];
+		break;
+	case hwmon_pwm:
+		switch (attr) {
+		case hwmon_pwm_enable:
+			*val = priv->channel_info[channel].mode;
+			break;
+		case hwmon_pwm_input:
+			*val = priv->channel_info[channel].reported_duty;
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int kraken3_read_string(struct device *dev, enum hwmon_sensor_types type, u32 attr,
+			       int channel, const char **str)
+{
+	switch (type) {
+	case hwmon_temp:
+		*str = kraken3_temp_label[channel];
+		break;
+	case hwmon_fan:
+		*str = kraken3_fan_label[channel];
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+/* Writes custom curve to device */
+static int kraken3_write_curve(struct kraken3_data *priv, u8 *curve_array, int channel)
+{
+	u8 fixed_duty_cmd[SET_CURVE_DUTY_CMD_LENGTH];
+	int ret;
+
+	/* Copy command header */
+	memcpy(fixed_duty_cmd, set_pump_duty_cmd_header, SET_CURVE_DUTY_CMD_HEADER_LENGTH);
+
+	/* Set the correct ID for writing pump/fan duty (0x01 or 0x02, respectively) */
+	fixed_duty_cmd[SET_DUTY_ID_OFFSET] = channel + 1;
+
+	/* Copy curve to command */
+	memcpy(fixed_duty_cmd + SET_CURVE_DUTY_CMD_HEADER_LENGTH, curve_array, CUSTOM_CURVE_POINTS);
+
+	ret = kraken3_write_expanded(priv, fixed_duty_cmd, SET_CURVE_DUTY_CMD_LENGTH);
+	return ret;
+}
+
+static int kraken3_write_fixed_duty(struct kraken3_data *priv, long val, int channel)
+{
+	u8 fixed_curve_points[CUSTOM_CURVE_POINTS];
+	int ret, percent_val, i;
+
+	percent_val = kraken3_pwm_to_percent(val, channel);
+	if (percent_val < 0)
+		return percent_val;
+
+	/*
+	 * The devices can only control the duty through a curve.
+	 * Since we're setting a fixed duty here, fill the whole curve
+	 * (ranging from 20C to 59C) with the same duty, except for
+	 * the last point, the critical temperature, where it's maxed
+	 * out for safety.
+	 */
+
+	/* Fill the custom curve with the fixed value we're setting */
+	for (i = 0; i < CUSTOM_CURVE_POINTS - 1; i++)
+		fixed_curve_points[i] = percent_val;
+
+	/* Force duty to 100% at critical temp */
+	fixed_curve_points[CUSTOM_CURVE_POINTS - 1] = 100;
+
+	/* Write the fixed duty curve to the device */
+	ret = kraken3_write_curve(priv, fixed_curve_points, channel);
+	return ret;
+}
+
+static int kraken3_write(struct device *dev, enum hwmon_sensor_types type, u32 attr, int channel,
+			 long val)
+{
+	struct kraken3_data *priv = dev_get_drvdata(dev);
+	int ret;
+
+	switch (type) {
+	case hwmon_pwm:
+		switch (attr) {
+		case hwmon_pwm_input:
+			/* Remember the last set fixed duty for channel */
+			priv->channel_info[channel].fixed_duty = val;
+
+			if (priv->channel_info[channel].mode == manual) {
+				ret = kraken3_write_fixed_duty(priv, val, channel);
+				if (ret < 0)
+					return ret;
+
+				/*
+				 * Lock onto this value and report it until next interrupt status
+				 * report is received, so userspace tools can continue to work.
+				 */
+				priv->channel_info[channel].reported_duty = val;
+			}
+			break;
+		case hwmon_pwm_enable:
+			if (val < 0 || val > 2)
+				return -EINVAL;
+
+			switch (val) {
+			case 0:
+				/* Set channel to 100%, direct duty value */
+				ret = kraken3_write_fixed_duty(priv, 255, channel);
+				if (ret < 0)
+					return ret;
+
+				/* We don't control anything anymore */
+				priv->channel_info[channel].mode = off;
+				break;
+			case 1:
+				/* Apply the last known direct duty value */
+				ret =
+				    kraken3_write_fixed_duty(priv,
+							     priv->channel_info[channel].fixed_duty,
+							     channel);
+				if (ret < 0)
+					return ret;
+
+				priv->channel_info[channel].mode = manual;
+				break;
+			case 2:
+				/* Apply the curve and note as enabled */
+				ret =
+				    kraken3_write_curve(priv,
+							priv->channel_info[channel].pwm_points,
+							channel);
+				if (ret < 0)
+					return ret;
+
+				priv->channel_info[channel].mode = curve;
+				break;
+			default:
+				break;
+			}
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static ssize_t kraken3_fan_curve_pwm_store(struct device *dev, struct device_attribute *attr,
+					   const char *buf, size_t count)
+{
+	struct sensor_device_attribute_2 *dev_attr = to_sensor_dev_attr_2(attr);
+	struct kraken3_data *priv = dev_get_drvdata(dev);
+	long val;
+	int ret;
+
+	if (kstrtol(buf, 10, &val) < 0)
+		return -EINVAL;
+
+	val = kraken3_pwm_to_percent(val, dev_attr->nr);
+	if (val < 0)
+		return val;
+
+	priv->channel_info[dev_attr->nr].pwm_points[dev_attr->index] = val;
+
+	if (priv->channel_info[dev_attr->nr].mode == curve) {
+		/* Apply the curve */
+		ret =
+		    kraken3_write_curve(priv,
+					priv->channel_info[dev_attr->nr].pwm_points, dev_attr->nr);
+		if (ret < 0)
+			return ret;
+	}
+
+	return count;
+}
+
+static umode_t kraken3_curve_props_are_visible(struct kobject *kobj, struct attribute *attr,
+					       int index)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct kraken3_data *priv = dev_get_drvdata(dev);
+
+	/* Only Z53 has the fan curve */
+	if (index >= CUSTOM_CURVE_POINTS && priv->kind != Z53)
+		return 0;
+
+	return attr->mode;
+}
+
+/* Custom pump curve from 20C to 59C (critical temp) */
+static SENSOR_DEVICE_ATTR_2_WO(temp1_auto_point1_pwm, kraken3_fan_curve_pwm, 0, 0);
+static SENSOR_DEVICE_ATTR_2_WO(temp1_auto_point2_pwm, kraken3_fan_curve_pwm, 0, 1);
+static SENSOR_DEVICE_ATTR_2_WO(temp1_auto_point3_pwm, kraken3_fan_curve_pwm, 0, 2);
+static SENSOR_DEVICE_ATTR_2_WO(temp1_auto_point4_pwm, kraken3_fan_curve_pwm, 0, 3);
+static SENSOR_DEVICE_ATTR_2_WO(temp1_auto_point5_pwm, kraken3_fan_curve_pwm, 0, 4);
+static SENSOR_DEVICE_ATTR_2_WO(temp1_auto_point6_pwm, kraken3_fan_curve_pwm, 0, 5);
+static SENSOR_DEVICE_ATTR_2_WO(temp1_auto_point7_pwm, kraken3_fan_curve_pwm, 0, 6);
+static SENSOR_DEVICE_ATTR_2_WO(temp1_auto_point8_pwm, kraken3_fan_curve_pwm, 0, 7);
+static SENSOR_DEVICE_ATTR_2_WO(temp1_auto_point9_pwm, kraken3_fan_curve_pwm, 0, 8);
+static SENSOR_DEVICE_ATTR_2_WO(temp1_auto_point10_pwm, kraken3_fan_curve_pwm, 0, 9);
+static SENSOR_DEVICE_ATTR_2_WO(temp1_auto_point11_pwm, kraken3_fan_curve_pwm, 0, 10);
+static SENSOR_DEVICE_ATTR_2_WO(temp1_auto_point12_pwm, kraken3_fan_curve_pwm, 0, 11);
+static SENSOR_DEVICE_ATTR_2_WO(temp1_auto_point13_pwm, kraken3_fan_curve_pwm, 0, 12);
+static SENSOR_DEVICE_ATTR_2_WO(temp1_auto_point14_pwm, kraken3_fan_curve_pwm, 0, 13);
+static SENSOR_DEVICE_ATTR_2_WO(temp1_auto_point15_pwm, kraken3_fan_curve_pwm, 0, 14);
+static SENSOR_DEVICE_ATTR_2_WO(temp1_auto_point16_pwm, kraken3_fan_curve_pwm, 0, 15);
+static SENSOR_DEVICE_ATTR_2_WO(temp1_auto_point17_pwm, kraken3_fan_curve_pwm, 0, 16);
+static SENSOR_DEVICE_ATTR_2_WO(temp1_auto_point18_pwm, kraken3_fan_curve_pwm, 0, 17);
+static SENSOR_DEVICE_ATTR_2_WO(temp1_auto_point19_pwm, kraken3_fan_curve_pwm, 0, 18);
+static SENSOR_DEVICE_ATTR_2_WO(temp1_auto_point20_pwm, kraken3_fan_curve_pwm, 0, 19);
+static SENSOR_DEVICE_ATTR_2_WO(temp1_auto_point21_pwm, kraken3_fan_curve_pwm, 0, 20);
+static SENSOR_DEVICE_ATTR_2_WO(temp1_auto_point22_pwm, kraken3_fan_curve_pwm, 0, 21);
+static SENSOR_DEVICE_ATTR_2_WO(temp1_auto_point23_pwm, kraken3_fan_curve_pwm, 0, 22);
+static SENSOR_DEVICE_ATTR_2_WO(temp1_auto_point24_pwm, kraken3_fan_curve_pwm, 0, 23);
+static SENSOR_DEVICE_ATTR_2_WO(temp1_auto_point25_pwm, kraken3_fan_curve_pwm, 0, 24);
+static SENSOR_DEVICE_ATTR_2_WO(temp1_auto_point26_pwm, kraken3_fan_curve_pwm, 0, 25);
+static SENSOR_DEVICE_ATTR_2_WO(temp1_auto_point27_pwm, kraken3_fan_curve_pwm, 0, 26);
+static SENSOR_DEVICE_ATTR_2_WO(temp1_auto_point28_pwm, kraken3_fan_curve_pwm, 0, 27);
+static SENSOR_DEVICE_ATTR_2_WO(temp1_auto_point29_pwm, kraken3_fan_curve_pwm, 0, 28);
+static SENSOR_DEVICE_ATTR_2_WO(temp1_auto_point30_pwm, kraken3_fan_curve_pwm, 0, 29);
+static SENSOR_DEVICE_ATTR_2_WO(temp1_auto_point31_pwm, kraken3_fan_curve_pwm, 0, 30);
+static SENSOR_DEVICE_ATTR_2_WO(temp1_auto_point32_pwm, kraken3_fan_curve_pwm, 0, 31);
+static SENSOR_DEVICE_ATTR_2_WO(temp1_auto_point33_pwm, kraken3_fan_curve_pwm, 0, 32);
+static SENSOR_DEVICE_ATTR_2_WO(temp1_auto_point34_pwm, kraken3_fan_curve_pwm, 0, 33);
+static SENSOR_DEVICE_ATTR_2_WO(temp1_auto_point35_pwm, kraken3_fan_curve_pwm, 0, 34);
+static SENSOR_DEVICE_ATTR_2_WO(temp1_auto_point36_pwm, kraken3_fan_curve_pwm, 0, 35);
+static SENSOR_DEVICE_ATTR_2_WO(temp1_auto_point37_pwm, kraken3_fan_curve_pwm, 0, 36);
+static SENSOR_DEVICE_ATTR_2_WO(temp1_auto_point38_pwm, kraken3_fan_curve_pwm, 0, 37);
+static SENSOR_DEVICE_ATTR_2_WO(temp1_auto_point39_pwm, kraken3_fan_curve_pwm, 0, 38);
+static SENSOR_DEVICE_ATTR_2_WO(temp1_auto_point40_pwm, kraken3_fan_curve_pwm, 0, 39);
+
+/* Custom fan curve from 20C to 59C (critical temp) */
+static SENSOR_DEVICE_ATTR_2_WO(temp2_auto_point1_pwm, kraken3_fan_curve_pwm, 1, 0);
+static SENSOR_DEVICE_ATTR_2_WO(temp2_auto_point2_pwm, kraken3_fan_curve_pwm, 1, 1);
+static SENSOR_DEVICE_ATTR_2_WO(temp2_auto_point3_pwm, kraken3_fan_curve_pwm, 1, 2);
+static SENSOR_DEVICE_ATTR_2_WO(temp2_auto_point4_pwm, kraken3_fan_curve_pwm, 1, 3);
+static SENSOR_DEVICE_ATTR_2_WO(temp2_auto_point5_pwm, kraken3_fan_curve_pwm, 1, 4);
+static SENSOR_DEVICE_ATTR_2_WO(temp2_auto_point6_pwm, kraken3_fan_curve_pwm, 1, 5);
+static SENSOR_DEVICE_ATTR_2_WO(temp2_auto_point7_pwm, kraken3_fan_curve_pwm, 1, 6);
+static SENSOR_DEVICE_ATTR_2_WO(temp2_auto_point8_pwm, kraken3_fan_curve_pwm, 1, 7);
+static SENSOR_DEVICE_ATTR_2_WO(temp2_auto_point9_pwm, kraken3_fan_curve_pwm, 1, 8);
+static SENSOR_DEVICE_ATTR_2_WO(temp2_auto_point10_pwm, kraken3_fan_curve_pwm, 1, 9);
+static SENSOR_DEVICE_ATTR_2_WO(temp2_auto_point11_pwm, kraken3_fan_curve_pwm, 1, 10);
+static SENSOR_DEVICE_ATTR_2_WO(temp2_auto_point12_pwm, kraken3_fan_curve_pwm, 1, 11);
+static SENSOR_DEVICE_ATTR_2_WO(temp2_auto_point13_pwm, kraken3_fan_curve_pwm, 1, 12);
+static SENSOR_DEVICE_ATTR_2_WO(temp2_auto_point14_pwm, kraken3_fan_curve_pwm, 1, 13);
+static SENSOR_DEVICE_ATTR_2_WO(temp2_auto_point15_pwm, kraken3_fan_curve_pwm, 1, 14);
+static SENSOR_DEVICE_ATTR_2_WO(temp2_auto_point16_pwm, kraken3_fan_curve_pwm, 1, 15);
+static SENSOR_DEVICE_ATTR_2_WO(temp2_auto_point17_pwm, kraken3_fan_curve_pwm, 1, 16);
+static SENSOR_DEVICE_ATTR_2_WO(temp2_auto_point18_pwm, kraken3_fan_curve_pwm, 1, 17);
+static SENSOR_DEVICE_ATTR_2_WO(temp2_auto_point19_pwm, kraken3_fan_curve_pwm, 1, 18);
+static SENSOR_DEVICE_ATTR_2_WO(temp2_auto_point20_pwm, kraken3_fan_curve_pwm, 1, 19);
+static SENSOR_DEVICE_ATTR_2_WO(temp2_auto_point21_pwm, kraken3_fan_curve_pwm, 1, 20);
+static SENSOR_DEVICE_ATTR_2_WO(temp2_auto_point22_pwm, kraken3_fan_curve_pwm, 1, 21);
+static SENSOR_DEVICE_ATTR_2_WO(temp2_auto_point23_pwm, kraken3_fan_curve_pwm, 1, 22);
+static SENSOR_DEVICE_ATTR_2_WO(temp2_auto_point24_pwm, kraken3_fan_curve_pwm, 1, 23);
+static SENSOR_DEVICE_ATTR_2_WO(temp2_auto_point25_pwm, kraken3_fan_curve_pwm, 1, 24);
+static SENSOR_DEVICE_ATTR_2_WO(temp2_auto_point26_pwm, kraken3_fan_curve_pwm, 1, 25);
+static SENSOR_DEVICE_ATTR_2_WO(temp2_auto_point27_pwm, kraken3_fan_curve_pwm, 1, 26);
+static SENSOR_DEVICE_ATTR_2_WO(temp2_auto_point28_pwm, kraken3_fan_curve_pwm, 1, 27);
+static SENSOR_DEVICE_ATTR_2_WO(temp2_auto_point29_pwm, kraken3_fan_curve_pwm, 1, 28);
+static SENSOR_DEVICE_ATTR_2_WO(temp2_auto_point30_pwm, kraken3_fan_curve_pwm, 1, 29);
+static SENSOR_DEVICE_ATTR_2_WO(temp2_auto_point31_pwm, kraken3_fan_curve_pwm, 1, 30);
+static SENSOR_DEVICE_ATTR_2_WO(temp2_auto_point32_pwm, kraken3_fan_curve_pwm, 1, 31);
+static SENSOR_DEVICE_ATTR_2_WO(temp2_auto_point33_pwm, kraken3_fan_curve_pwm, 1, 32);
+static SENSOR_DEVICE_ATTR_2_WO(temp2_auto_point34_pwm, kraken3_fan_curve_pwm, 1, 33);
+static SENSOR_DEVICE_ATTR_2_WO(temp2_auto_point35_pwm, kraken3_fan_curve_pwm, 1, 34);
+static SENSOR_DEVICE_ATTR_2_WO(temp2_auto_point36_pwm, kraken3_fan_curve_pwm, 1, 35);
+static SENSOR_DEVICE_ATTR_2_WO(temp2_auto_point37_pwm, kraken3_fan_curve_pwm, 1, 36);
+static SENSOR_DEVICE_ATTR_2_WO(temp2_auto_point38_pwm, kraken3_fan_curve_pwm, 1, 37);
+static SENSOR_DEVICE_ATTR_2_WO(temp2_auto_point39_pwm, kraken3_fan_curve_pwm, 1, 38);
+static SENSOR_DEVICE_ATTR_2_WO(temp2_auto_point40_pwm, kraken3_fan_curve_pwm, 1, 39);
+
+static struct attribute *kraken3_curve_attrs[] = {
+	/* Pump control curve */
+	&sensor_dev_attr_temp1_auto_point1_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_point2_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_point3_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_point4_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_point5_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_point6_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_point7_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_point8_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_point9_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_point10_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_point11_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_point12_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_point13_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_point14_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_point15_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_point16_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_point17_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_point18_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_point19_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_point20_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_point21_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_point22_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_point23_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_point24_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_point25_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_point26_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_point27_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_point28_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_point29_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_point30_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_point31_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_point32_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_point33_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_point34_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_point35_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_point36_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_point37_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_point38_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_point39_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_point40_pwm.dev_attr.attr,
+	/* Fan control curve (Z53 only) */
+	&sensor_dev_attr_temp2_auto_point1_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_point2_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_point3_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_point4_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_point5_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_point6_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_point7_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_point8_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_point9_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_point10_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_point11_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_point12_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_point13_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_point14_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_point15_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_point16_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_point17_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_point18_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_point19_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_point20_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_point21_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_point22_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_point23_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_point24_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_point25_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_point26_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_point27_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_point28_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_point29_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_point30_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_point31_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_point32_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_point33_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_point34_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_point35_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_point36_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_point37_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_point38_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_point39_pwm.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_point40_pwm.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group kraken3_curves_group = {
+	.attrs = kraken3_curve_attrs,
+	.is_visible = kraken3_curve_props_are_visible
+};
+
+static const struct attribute_group *kraken3_groups[] = {
+	&kraken3_curves_group,
+	NULL
+};
+
+static const struct hwmon_ops kraken3_hwmon_ops = {
+	.is_visible = kraken3_is_visible,
+	.read = kraken3_read,
+	.read_string = kraken3_read_string,
+	.write = kraken3_write
+};
+
+static const struct hwmon_channel_info *kraken3_info[] = {
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT | HWMON_T_LABEL),
+	HWMON_CHANNEL_INFO(fan,
+			   HWMON_F_INPUT | HWMON_F_LABEL,
+			   HWMON_F_INPUT | HWMON_F_LABEL,
+			   HWMON_F_INPUT | HWMON_F_LABEL,
+			   HWMON_F_INPUT | HWMON_F_LABEL),
+	HWMON_CHANNEL_INFO(pwm,
+			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
+			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE),
+	NULL
+};
+
+static const struct hwmon_chip_info kraken3_chip_info = {
+	.ops = &kraken3_hwmon_ops,
+	.info = kraken3_info,
+};
+
+static int kraken3_raw_event(struct hid_device *hdev, struct hid_report *report, u8 *data, int size)
+{
+	struct kraken3_data *priv = hid_get_drvdata(hdev);
+	int i;
+
+	if (size < MIN_REPORT_LENGTH)
+		return 0;
+
+	if (report->id == FIRMWARE_REPORT_ID) {
+		/* Read firmware version */
+		for (i = 0; i < 3; i++)
+			priv->firmware_version[i] = data[FIRMWARE_VERSION_OFFSET + i];
+
+		if (!completion_done(&priv->fw_version_processed))
+			complete_all(&priv->fw_version_processed);
+
+		return 0;
+	}
+
+	if (report->id != STATUS_REPORT_ID)
+		return 0;
+
+	if (data[TEMP_SENSOR_START_OFFSET] == 0xff && data[TEMP_SENSOR_END_OFFSET] == 0xff) {
+		hid_err_once(hdev,
+			     "firmware or device is possibly damaged (is SATA power connected?), not parsing reports\n");
+
+		/*
+		 * Mark first X-series device report as received,
+		 * as well as all for Z-series, if faulty.
+		 */
+		spin_lock(&priv->status_completion_lock);
+		if (priv->kind != X53 || !completion_done(&priv->status_report_processed)) {
+			priv->is_device_faulty = true;
+			complete_all(&priv->status_report_processed);
+		}
+		spin_unlock(&priv->status_completion_lock);
+
+		return 0;
+	}
+
+	/* Received normal data */
+	priv->is_device_faulty = false;
+
+	/* Temperature and fan sensor readings */
+	priv->temp_input[0] =
+	    data[TEMP_SENSOR_START_OFFSET] * 1000 + data[TEMP_SENSOR_END_OFFSET] * 100;
+
+	priv->fan_input[0] = get_unaligned_le16(data + PUMP_SPEED_OFFSET);
+	priv->channel_info[0].reported_duty = kraken3_percent_to_pwm(data[PUMP_DUTY_OFFSET]);
+
+	spin_lock(&priv->status_completion_lock);
+	if (priv->kind == X53 && !completion_done(&priv->status_report_processed)) {
+		/* Mark first X-series device report as received */
+		complete_all(&priv->status_report_processed);
+	} else if (priv->kind == Z53) {
+		/* Additional readings for Z53 */
+		priv->fan_input[1] = get_unaligned_le16(data + Z53_FAN_SPEED_OFFSET);
+		priv->channel_info[1].reported_duty =
+		    kraken3_percent_to_pwm(data[Z53_FAN_DUTY_OFFSET]);
+
+		if (!completion_done(&priv->status_report_processed))
+			complete_all(&priv->status_report_processed);
+	}
+	spin_unlock(&priv->status_completion_lock);
+
+	priv->updated = jiffies;
+
+	return 0;
+}
+
+static int kraken3_init_device(struct hid_device *hdev)
+{
+	struct kraken3_data *priv = hid_get_drvdata(hdev);
+	int ret;
+
+	/* Set the polling interval */
+	ret = kraken3_write_expanded(priv, set_interval_cmd, SET_INTERVAL_CMD_LENGTH);
+	if (ret < 0)
+		return ret;
+
+	/* Finalize the init process */
+	ret = kraken3_write_expanded(priv, finish_init_cmd, FINISH_INIT_CMD_LENGTH);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int kraken3_get_fw_ver(struct hid_device *hdev)
+{
+	struct kraken3_data *priv = hid_get_drvdata(hdev);
+	int ret;
+
+	ret = kraken3_write_expanded(priv, get_fw_version_cmd, GET_FW_VERSION_CMD_LENGTH);
+	if (ret < 0)
+		return ret;
+
+	ret = wait_for_completion_interruptible_timeout(&priv->fw_version_processed,
+							msecs_to_jiffies(STATUS_VALIDITY));
+	if (ret == 0)
+		return -ETIMEDOUT;
+	else if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int __maybe_unused kraken3_reset_resume(struct hid_device *hdev)
+{
+	int ret;
+
+	ret = kraken3_init_device(hdev);
+	if (ret)
+		hid_err(hdev, "req init (reset_resume) failed with %d\n", ret);
+
+	return ret;
+}
+
+static int firmware_version_show(struct seq_file *seqf, void *unused)
+{
+	struct kraken3_data *priv = seqf->private;
+
+	seq_printf(seqf, "%u.%u.%u\n", priv->firmware_version[0], priv->firmware_version[1],
+		   priv->firmware_version[2]);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(firmware_version);
+
+static void kraken3_debugfs_init(struct kraken3_data *priv)
+{
+	char name[64];
+
+	if (!priv->firmware_version[0])
+		return;		/* Nothing to display in debugfs */
+
+	scnprintf(name, sizeof(name), "%s_%s-%s", DRIVER_NAME, kraken3_device_names[priv->kind],
+		  dev_name(&priv->hdev->dev));
+
+	priv->debugfs = debugfs_create_dir(name, NULL);
+	debugfs_create_file("firmware_version", 0444, priv->debugfs, priv, &firmware_version_fops);
+}
+
+static int kraken3_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	struct kraken3_data *priv;
+	int ret;
+
+	priv = devm_kzalloc(&hdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->hdev = hdev;
+	hid_set_drvdata(hdev, priv);
+
+	/*
+	 * Initialize ->updated to STATUS_VALIDITY seconds in the past, making
+	 * the initial empty data invalid for kraken3_read without the need for
+	 * a special case there.
+	 */
+	priv->updated = jiffies - msecs_to_jiffies(STATUS_VALIDITY);
+
+	ret = hid_parse(hdev);
+	if (ret) {
+		hid_err(hdev, "hid parse failed with %d\n", ret);
+		return ret;
+	}
+
+	/* Enable hidraw so existing user-space tools can continue to work */
+	ret = hid_hw_start(hdev, HID_CONNECT_HIDRAW);
+	if (ret) {
+		hid_err(hdev, "hid hw start failed with %d\n", ret);
+		return ret;
+	}
+
+	ret = hid_hw_open(hdev);
+	if (ret) {
+		hid_err(hdev, "hid hw open failed with %d\n", ret);
+		goto fail_and_stop;
+	}
+
+	switch (hdev->product) {
+	case USB_PRODUCT_ID_X53:
+	case USB_PRODUCT_ID_X53_SECOND:
+		priv->kind = X53;
+		break;
+	case USB_PRODUCT_ID_Z53:
+		priv->kind = Z53;
+		break;
+	default:
+		break;
+	}
+
+	priv->buffer = devm_kzalloc(&hdev->dev, MAX_REPORT_LENGTH, GFP_KERNEL);
+	if (!priv->buffer) {
+		ret = -ENOMEM;
+		goto fail_and_close;
+	}
+
+	mutex_init(&priv->buffer_lock);
+	mutex_init(&priv->z53_status_request_lock);
+	init_completion(&priv->fw_version_processed);
+	init_completion(&priv->status_report_processed);
+	spin_lock_init(&priv->status_completion_lock);
+
+	hid_device_io_start(hdev);
+	ret = kraken3_init_device(hdev);
+	if (ret < 0) {
+		hid_err(hdev, "device init failed with %d\n", ret);
+		goto fail_and_close;
+	}
+
+	ret = kraken3_get_fw_ver(hdev);
+	if (ret < 0)
+		hid_warn(hdev, "fw version request failed with %d\n", ret);
+
+	priv->hwmon_dev = hwmon_device_register_with_info(&hdev->dev,
+							  kraken3_device_names[priv->kind], priv,
+							  &kraken3_chip_info, kraken3_groups);
+	if (IS_ERR(priv->hwmon_dev)) {
+		ret = PTR_ERR(priv->hwmon_dev);
+		hid_err(hdev, "hwmon registration failed with %d\n", ret);
+		goto fail_and_close;
+	}
+
+	kraken3_debugfs_init(priv);
+
+	return 0;
+
+fail_and_close:
+	hid_hw_close(hdev);
+fail_and_stop:
+	hid_hw_stop(hdev);
+	return ret;
+}
+
+static void kraken3_remove(struct hid_device *hdev)
+{
+	struct kraken3_data *priv = hid_get_drvdata(hdev);
+
+	debugfs_remove_recursive(priv->debugfs);
+	hwmon_device_unregister(priv->hwmon_dev);
+
+	hid_hw_close(hdev);
+	hid_hw_stop(hdev);
+}
+
+static const struct hid_device_id kraken3_table[] = {
+	/* NZXT Kraken X53/X63/X73 have two possible product IDs */
+	{ HID_USB_DEVICE(USB_VENDOR_ID_NZXT, USB_PRODUCT_ID_X53) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_NZXT, USB_PRODUCT_ID_X53_SECOND) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_NZXT, USB_PRODUCT_ID_Z53) },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(hid, kraken3_table);
+
+static struct hid_driver kraken3_driver = {
+	.name = DRIVER_NAME,
+	.id_table = kraken3_table,
+	.probe = kraken3_probe,
+	.remove = kraken3_remove,
+	.raw_event = kraken3_raw_event,
+#ifdef CONFIG_PM
+	.reset_resume = kraken3_reset_resume,
+#endif
+};
+
+static int __init kraken3_init(void)
+{
+	return hid_register_driver(&kraken3_driver);
+}
+
+static void __exit kraken3_exit(void)
+{
+	hid_unregister_driver(&kraken3_driver);
+}
+
+/* When compiled into the kernel, initialize after the HID bus */
+late_initcall(kraken3_init);
+module_exit(kraken3_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Jonas Malaco <jonas@protocubo.io>");
+MODULE_AUTHOR("Aleksa Savic <savicaleksa83@gmail.com>");
+MODULE_DESCRIPTION("Hwmon driver for NZXT Kraken X53/X63/X73, Z53/Z63/Z73 coolers");
-- 
2.43.0


