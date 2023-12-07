Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D21C8087AD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379258AbjLGMYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjLGMYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:24:17 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60677E9;
        Thu,  7 Dec 2023 04:24:22 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a1f37fd4b53so37663066b.1;
        Thu, 07 Dec 2023 04:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701951860; x=1702556660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RytkUgvP6CM6Ssn/Vtk6hiCWQ3yiQINiGbjEM81bHWA=;
        b=QEdHx/dFfOt8nTx1QSAIEYS2VfQmilcyx1eeHvfot2wGJ30zhDcnozP/tyxMB578u2
         umTDGKUMkDyRyv3P5eGBTUCd0nnEkSyvhz1jcWL1mD3vm5bVWi99gJdeqpk+ujLzXY3+
         4E9TPxZ+ERIdDOtf8s8HVrNVLexoPrKzLC9hzdl7m3MyathdDXN31QglIBp/BiEVfylE
         MWUXMu67FrPBltmYAkfc4Xwxj6N/XZQ2CBVnOSM6yKgZuxGmB/AbmTD6jVXzgaWSBGfw
         0cKHbOX5wVBZ5UJI/AOP8UInCfmzDu90o525EBsS1hDO1FiVNGJuKvCDIVAodfyfthkT
         K+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701951860; x=1702556660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RytkUgvP6CM6Ssn/Vtk6hiCWQ3yiQINiGbjEM81bHWA=;
        b=d1keKXHaZHQRxLItUOnedtOymFX4J1bAMM6cKT9AcfFbRLa8nNoRmVE/IXMHiNNelk
         pm2Xx4Oox0uHNc8PcxteG8U03OD5sWKhQeXWjFDpBZ0FEfyGbIshDgi2TE6VDRSMFnJ/
         lpggC8wlshM6SnQTIKDuwEGWvf+AGS7maADS13HtW16AHbd4l+axyTdDD0FV/KYkZt59
         FRKOPcEM9wIqJ2gaC9jiQ0hqXCCD02ACIJJPCzdao+HZriAzCIWjGJmTdJDSMTxSZyaO
         HuKNy+BOzGCsOKk0F+GD1DM6kKZgKB9NENMA/HmbbD8DmjXuYuE3TxS3FQVaf7PuSZ6F
         3uTg==
X-Gm-Message-State: AOJu0YyEa8AfhLM5JI33/BrvQbpYQj9hlvuUTDTGIm3w42Lqr0awLHm8
        fLjc1YyUtZPnluIrjTHwoHYBeFRVfk8LYQ==
X-Google-Smtp-Source: AGHT+IEfRXnv4oLR7PhcQrZip24J+JGaK/OOVS1S6IonOj9iGPeyJJ3AC0UWgp4CzKK1kChPO70uvA==
X-Received: by 2002:a17:906:3f58:b0:a1c:aebe:6104 with SMTP id f24-20020a1709063f5800b00a1caebe6104mr1892494ejj.85.1701951860341;
        Thu, 07 Dec 2023 04:24:20 -0800 (PST)
Received: from fedora.. (cable-178-148-234-71.dynamic.sbb.rs. [178.148.234.71])
        by smtp.gmail.com with ESMTPSA id a19-20020a17090640d300b009ff77c2e1dasm749911ejk.167.2023.12.07.04.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 04:24:19 -0800 (PST)
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Aleksa Savic <savicaleksa83@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] hwmon: Add driver for Gigabyte AORUS Waterforce AIO coolers
Date:   Thu,  7 Dec 2023 13:23:59 +0100
Message-ID: <20231207122402.107032-1-savicaleksa83@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver exposes hardware sensors of the Gigabyte AORUS Waterforce
all-in-one CPU liquid coolers, which communicate through a proprietary
USB HID protocol. Report offsets were initially discovered in [1] and
confirmed by me on a Waterforce X240 by observing the sent reports from
the official software.

Available sensors are pump and fan speed in RPM, as well as coolant
temperature. Also available through debugfs is the firmware version.

Attaching a fan is optional and allows it to be controlled from the
device. If it's not connected, the fan-related sensors will report
zeroes.

The addressable RGB LEDs and LCD screen are not supported in this
driver and should be controlled through userspace tools.

[1]: https://github.com/liquidctl/liquidctl/issues/167

Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
---
Changes in v3:
- Used memcpy_and_pad() in waterforce_write_expanded()
- Received error code of mutex locking in waterforce_get_status() is now
  being returned instead of -ENODATA
- After wait_for_completion_interruptible_timeout() calls, -ETIMEOUT or
  received error code are returned throughout the driver
- Formatted variable declarations to follow the reverse christmas tree shape
- In waterforce_read(), removed status validity check because it's checked
  when actually getting status
- In waterforce_read(), error code of waterforce_get_status() is now returned
  instead of -ENODATA
- In waterforce_read(), -EOPNOTSUPP is now returned in the default case of
  hwmon_pwm
- Removed unneeded #ifdef related to CONFIG_DEBUG_FS and the empty function
- Moved check of success of fw version retrieval to waterforce_debugfs_init()
- Fixed the error handling path in waterforce_probe()
- Moved the fw version request before hwmon registration and removed the
  hid_device_io_stop() call in waterforce_probe()
- Added missing debugfs_remove_recursive() call in waterforce_remove()

Changes in v2 (fix issues reported by kernel bot):
- Add driver doc to hwmon doc index
- Initialize ret value in waterforce_get_status() to 0
---
 Documentation/hwmon/gigabyte_waterforce.rst |  47 +++
 Documentation/hwmon/index.rst               |   1 +
 MAINTAINERS                                 |   7 +
 drivers/hwmon/Kconfig                       |  10 +
 drivers/hwmon/Makefile                      |   1 +
 drivers/hwmon/gigabyte_waterforce.c         | 428 ++++++++++++++++++++
 6 files changed, 494 insertions(+)
 create mode 100644 Documentation/hwmon/gigabyte_waterforce.rst
 create mode 100644 drivers/hwmon/gigabyte_waterforce.c

diff --git a/Documentation/hwmon/gigabyte_waterforce.rst b/Documentation/hwmon/gigabyte_waterforce.rst
new file mode 100644
index 000000000000..d47f3e8516ee
--- /dev/null
+++ b/Documentation/hwmon/gigabyte_waterforce.rst
@@ -0,0 +1,47 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Kernel driver gigabyte_waterforce
+=================================
+
+Supported devices:
+
+* Gigabyte AORUS WATERFORCE X240
+* Gigabyte AORUS WATERFORCE X280
+* Gigabyte AORUS WATERFORCE X360
+
+Author: Aleksa Savic
+
+Description
+-----------
+
+This driver enables hardware monitoring support for the listed Gigabyte Waterforce
+all-in-one CPU liquid coolers. Available sensors are pump and fan speed in RPM, as
+well as coolant temperature. Also available through debugfs is the firmware version.
+
+Attaching a fan is optional and allows it to be controlled from the device. If
+it's not connected, the fan-related sensors will report zeroes.
+
+The addressable RGB LEDs and LCD screen are not supported in this driver and should
+be controlled through userspace tools.
+
+Usage notes
+-----------
+
+As these are USB HIDs, the driver can be loaded automatically by the kernel and
+supports hot swapping.
+
+Sysfs entries
+-------------
+
+=========== =============================================
+fan1_input  Fan speed (in rpm)
+fan2_input  Pump speed (in rpm)
+temp1_input Coolant temperature (in millidegrees Celsius)
+=========== =============================================
+
+Debugfs entries
+---------------
+
+================ =======================
+firmware_version Device firmware version
+================ =======================
diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 095c36f5e8a1..36101e9e38e9 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -73,6 +73,7 @@ Hardware Monitoring Kernel Drivers
    ftsteutates
    g760a
    g762
+   gigabyte_waterforce
    gsc-hwmon
    gl518sm
    gxp-fan-ctrl
diff --git a/MAINTAINERS b/MAINTAINERS
index 97f51d5ec1cf..b1a69c5042b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8960,6 +8960,13 @@ F:	Documentation/filesystems/gfs2*
 F:	fs/gfs2/
 F:	include/uapi/linux/gfs2_ondisk.h
 
+GIGABYTE WATERFORCE SENSOR DRIVER
+M:	Aleksa Savic <savicaleksa83@gmail.com>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	Documentation/hwmon/gigabyte_waterforce.rst
+F:	drivers/hwmon/gigabyte_waterforce.c
+
 GIGABYTE WMI DRIVER
 M:	Thomas Weißschuh <thomas@weissschuh.net>
 L:	platform-driver-x86@vger.kernel.org
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 76cb05db1dcf..a608264da87d 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -664,6 +664,16 @@ config SENSORS_FTSTEUTATES
 	  This driver can also be built as a module. If so, the module
 	  will be called ftsteutates.
 
+config SENSORS_GIGABYTE_WATERFORCE
+	tristate "Gigabyte Waterforce X240/X280/X360 AIO CPU coolers"
+	depends on USB_HID
+	help
+	  If you say yes here you get support for hardware monitoring for the
+	  Gigabyte Waterforce X240/X280/X360 all-in-one CPU liquid coolers.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called gigabyte_waterforce.
+
 config SENSORS_GL518SM
 	tristate "Genesys Logic GL518SM"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index e84bd9685b5c..47be39af5c03 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -80,6 +80,7 @@ obj-$(CONFIG_SENSORS_FSCHMD)	+= fschmd.o
 obj-$(CONFIG_SENSORS_FTSTEUTATES) += ftsteutates.o
 obj-$(CONFIG_SENSORS_G760A)	+= g760a.o
 obj-$(CONFIG_SENSORS_G762)	+= g762.o
+obj-$(CONFIG_SENSORS_GIGABYTE_WATERFORCE) += gigabyte_waterforce.o
 obj-$(CONFIG_SENSORS_GL518SM)	+= gl518sm.o
 obj-$(CONFIG_SENSORS_GL520SM)	+= gl520sm.o
 obj-$(CONFIG_SENSORS_GSC)	+= gsc-hwmon.o
diff --git a/drivers/hwmon/gigabyte_waterforce.c b/drivers/hwmon/gigabyte_waterforce.c
new file mode 100644
index 000000000000..1799377fc2f1
--- /dev/null
+++ b/drivers/hwmon/gigabyte_waterforce.c
@@ -0,0 +1,428 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * hwmon driver for Gigabyte AORUS Waterforce AIO CPU coolers: X240, X280 and X360.
+ *
+ * Copyright 2023 Aleksa Savic <savicaleksa83@gmail.com>
+ */
+
+#include <linux/debugfs.h>
+#include <linux/hid.h>
+#include <linux/hwmon.h>
+#include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <asm/unaligned.h>
+
+#define DRIVER_NAME	"gigabyte_waterforce"
+
+#define USB_VENDOR_ID_GIGABYTE		0x1044
+#define USB_PRODUCT_ID_WATERFORCE	0x7a4d	/* Gigabyte AORUS WATERFORCE X240, X280 and X360 */
+
+#define STATUS_VALIDITY		(2 * 1000)	/* ms */
+#define MAX_REPORT_LENGTH	6144
+
+#define WATERFORCE_TEMP_SENSOR	0xD
+#define WATERFORCE_FAN_SPEED	0x02
+#define WATERFORCE_PUMP_SPEED	0x05
+#define WATERFORCE_FAN_DUTY	0x08
+#define WATERFORCE_PUMP_DUTY	0x09
+
+/* Control commands, inner offsets and lengths */
+static const u8 get_status_cmd[] = { 0x99, 0xDA };
+
+#define FIRMWARE_VER_START_OFFSET_1	2
+#define FIRMWARE_VER_START_OFFSET_2	3
+static const u8 get_firmware_ver_cmd[] = { 0x99, 0xD6 };
+
+/* Command lengths */
+#define GET_STATUS_CMD_LENGTH		2
+#define GET_FIRMWARE_VER_CMD_LENGTH	2
+
+static const char *const waterforce_temp_label[] = {
+	"Coolant temp"
+};
+
+static const char *const waterforce_speed_label[] = {
+	"Fan speed",
+	"Pump speed"
+};
+
+struct waterforce_data {
+	struct hid_device *hdev;
+	struct device *hwmon_dev;
+	struct dentry *debugfs;
+	/* For locking access to buffer */
+	struct mutex buffer_lock;
+	/* For queueing multiple readers */
+	struct mutex status_report_request_mutex;
+	/* For reinitializing the completion below */
+	spinlock_t status_report_request_lock;
+	struct completion status_report_received;
+	struct completion fw_version_processed;
+
+	/* Sensor data */
+	s32 temp_input[1];
+	u16 speed_input[2];	/* Fan and pump speed in RPM */
+	u8 duty_input[2];	/* Fan and pump duty in 0-100% */
+
+	u8 *buffer;
+	int firmware_version;
+	unsigned long updated;	/* jiffies */
+};
+
+static umode_t waterforce_is_visible(const void *data,
+				     enum hwmon_sensor_types type, u32 attr, int channel)
+{
+	switch (type) {
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_label:
+		case hwmon_temp_input:
+			return 0444;
+		default:
+			break;
+		}
+		break;
+	case hwmon_fan:
+		switch (attr) {
+		case hwmon_fan_label:
+		case hwmon_fan_input:
+			return 0444;
+		default:
+			break;
+		}
+		break;
+	case hwmon_pwm:
+		switch (attr) {
+		case hwmon_pwm_input:
+			return 0444;
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
+/* Writes the command to the device with the rest of the report filled with zeroes */
+static int waterforce_write_expanded(struct waterforce_data *priv, const u8 *cmd, int cmd_length)
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
+static int waterforce_get_status(struct waterforce_data *priv)
+{
+	int ret = mutex_lock_interruptible(&priv->status_report_request_mutex);
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
+	 * Disable raw event parsing for a moment to safely reinitialize the
+	 * completion. Reinit is done because hidraw could have triggered
+	 * the raw event parsing and marked the priv->status_report_received
+	 * completion as done.
+	 */
+	spin_lock_bh(&priv->status_report_request_lock);
+	reinit_completion(&priv->status_report_received);
+	spin_unlock_bh(&priv->status_report_request_lock);
+
+	/* Send command for getting status */
+	ret = waterforce_write_expanded(priv, get_status_cmd, GET_STATUS_CMD_LENGTH);
+	if (ret < 0)
+		return ret;
+
+	ret = wait_for_completion_interruptible_timeout(&priv->status_report_received,
+							msecs_to_jiffies(STATUS_VALIDITY));
+	if (ret == 0)
+		ret = -ETIMEDOUT;
+
+unlock_and_return:
+	mutex_unlock(&priv->status_report_request_mutex);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int waterforce_read(struct device *dev, enum hwmon_sensor_types type,
+			   u32 attr, int channel, long *val)
+{
+	struct waterforce_data *priv = dev_get_drvdata(dev);
+	int ret = waterforce_get_status(priv);
+
+	if (ret < 0)
+		return ret;
+
+	switch (type) {
+	case hwmon_temp:
+		*val = priv->temp_input[channel];
+		break;
+	case hwmon_fan:
+		*val = priv->speed_input[channel];
+		break;
+	case hwmon_pwm:
+		switch (attr) {
+		case hwmon_pwm_input:
+			*val = DIV_ROUND_CLOSEST(priv->duty_input[channel] * 255, 100);
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+		break;
+	default:
+		return -EOPNOTSUPP;	/* unreachable */
+	}
+
+	return 0;
+}
+
+static int waterforce_read_string(struct device *dev, enum hwmon_sensor_types type,
+				  u32 attr, int channel, const char **str)
+{
+	switch (type) {
+	case hwmon_temp:
+		*str = waterforce_temp_label[channel];
+		break;
+	case hwmon_fan:
+		*str = waterforce_speed_label[channel];
+		break;
+	default:
+		return -EOPNOTSUPP;	/* unreachable */
+	}
+
+	return 0;
+}
+
+static int waterforce_get_fw_ver(struct hid_device *hdev)
+{
+	struct waterforce_data *priv = hid_get_drvdata(hdev);
+	int ret;
+
+	ret = waterforce_write_expanded(priv, get_firmware_ver_cmd, GET_FIRMWARE_VER_CMD_LENGTH);
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
+static const struct hwmon_ops waterforce_hwmon_ops = {
+	.is_visible = waterforce_is_visible,
+	.read = waterforce_read,
+	.read_string = waterforce_read_string
+};
+
+static const struct hwmon_channel_info *waterforce_info[] = {
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT | HWMON_T_LABEL),
+	HWMON_CHANNEL_INFO(fan,
+			   HWMON_F_INPUT | HWMON_F_LABEL,
+			   HWMON_F_INPUT | HWMON_F_LABEL),
+	HWMON_CHANNEL_INFO(pwm,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT),
+	NULL
+};
+
+static const struct hwmon_chip_info waterforce_chip_info = {
+	.ops = &waterforce_hwmon_ops,
+	.info = waterforce_info,
+};
+
+static int waterforce_raw_event(struct hid_device *hdev, struct hid_report *report, u8 *data,
+				int size)
+{
+	struct waterforce_data *priv = hid_get_drvdata(hdev);
+
+	if (data[0] == get_firmware_ver_cmd[0] && data[1] == get_firmware_ver_cmd[1]) {
+		/* Received a firmware version report */
+		priv->firmware_version =
+		    data[FIRMWARE_VER_START_OFFSET_1] * 10 + data[FIRMWARE_VER_START_OFFSET_2];
+
+		if (!completion_done(&priv->fw_version_processed))
+			complete_all(&priv->fw_version_processed);
+		return 0;
+	}
+
+	if (data[0] != get_status_cmd[0] || data[1] != get_status_cmd[1])
+		return 0;
+
+	priv->temp_input[0] = data[WATERFORCE_TEMP_SENSOR] * 1000;
+	priv->speed_input[0] = get_unaligned_le16(data + WATERFORCE_FAN_SPEED);
+	priv->speed_input[1] = get_unaligned_le16(data + WATERFORCE_PUMP_SPEED);
+	priv->duty_input[0] = data[WATERFORCE_FAN_DUTY];
+	priv->duty_input[1] = data[WATERFORCE_PUMP_DUTY];
+
+	if (!completion_done(&priv->status_report_received))
+		complete_all(&priv->status_report_received);
+
+	priv->updated = jiffies;
+
+	return 0;
+}
+
+static int firmware_version_show(struct seq_file *seqf, void *unused)
+{
+	struct waterforce_data *priv = seqf->private;
+
+	seq_printf(seqf, "%u\n", priv->firmware_version);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(firmware_version);
+
+static void waterforce_debugfs_init(struct waterforce_data *priv)
+{
+	char name[64];
+
+	if (!priv->firmware_version)
+		return;	/* There's nothing to show in debugfs */
+
+	scnprintf(name, sizeof(name), "%s-%s", DRIVER_NAME, dev_name(&priv->hdev->dev));
+
+	priv->debugfs = debugfs_create_dir(name, NULL);
+	debugfs_create_file("firmware_version", 0444, priv->debugfs, priv, &firmware_version_fops);
+}
+
+static int waterforce_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	struct waterforce_data *priv;
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
+	 * Initialize priv->updated to STATUS_VALIDITY seconds in the past, making
+	 * the initial empty data invalid for waterforce_read() without the need for
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
+	/*
+	 * Enable hidraw so existing user-space tools can continue to work.
+	 */
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
+	priv->buffer = devm_kzalloc(&hdev->dev, MAX_REPORT_LENGTH, GFP_KERNEL);
+	if (!priv->buffer) {
+		ret = -ENOMEM;
+		goto fail_and_close;
+	}
+
+	mutex_init(&priv->status_report_request_mutex);
+	mutex_init(&priv->buffer_lock);
+	spin_lock_init(&priv->status_report_request_lock);
+	init_completion(&priv->status_report_received);
+	init_completion(&priv->fw_version_processed);
+
+	hid_device_io_start(hdev);
+	ret = waterforce_get_fw_ver(hdev);
+	if (ret < 0)
+		hid_warn(hdev, "fw version request failed with %d\n", ret);
+
+	priv->hwmon_dev = hwmon_device_register_with_info(&hdev->dev, "waterforce",
+							  priv, &waterforce_chip_info, NULL);
+	if (IS_ERR(priv->hwmon_dev)) {
+		ret = PTR_ERR(priv->hwmon_dev);
+		hid_err(hdev, "hwmon registration failed with %d\n", ret);
+		goto fail_and_close;
+	}
+
+	waterforce_debugfs_init(priv);
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
+static void waterforce_remove(struct hid_device *hdev)
+{
+	struct waterforce_data *priv = hid_get_drvdata(hdev);
+
+	debugfs_remove_recursive(priv->debugfs);
+	hwmon_device_unregister(priv->hwmon_dev);
+
+	hid_hw_close(hdev);
+	hid_hw_stop(hdev);
+}
+
+static const struct hid_device_id waterforce_table[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_GIGABYTE, USB_PRODUCT_ID_WATERFORCE) },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(hid, waterforce_table);
+
+static struct hid_driver waterforce_driver = {
+	.name = "waterforce",
+	.id_table = waterforce_table,
+	.probe = waterforce_probe,
+	.remove = waterforce_remove,
+	.raw_event = waterforce_raw_event,
+};
+
+static int __init waterforce_init(void)
+{
+	return hid_register_driver(&waterforce_driver);
+}
+
+static void __exit waterforce_exit(void)
+{
+	hid_unregister_driver(&waterforce_driver);
+}
+
+/* When compiled into the kernel, initialize after the HID bus */
+late_initcall(waterforce_init);
+module_exit(waterforce_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Aleksa Savic <savicaleksa83@gmail.com>");
+MODULE_DESCRIPTION("Hwmon driver for Gigabyte AORUS Waterforce AIO coolers");
-- 
2.43.0

