Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C84D8023A5
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 13:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbjLCMMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 07:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjLCMMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 07:12:49 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4C6DB;
        Sun,  3 Dec 2023 04:12:54 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40c09f4bea8so2520075e9.1;
        Sun, 03 Dec 2023 04:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701605573; x=1702210373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wn+x3zBOfVaqJ6tgmSvBwPQOc/K0lcodJORVTpxMa/c=;
        b=JQXlg+ZZizFEDjHGiW9VRi1Rt7Un4p6pkWnjMoGj4YYcvq6LnPgHJVp4rQnAGQksr/
         BBKeA3gbJc1MtiWrH3WdoebnYY4AICiTTmCHZ29CuKDopc8GA7PecY3wD6VQrze2sMn2
         GSCYrJLCyh7UkRI/8ji4em3E8QwuFU/FE919h5BPsY5SOIy9KdFUJlr9l5TTV7ReuMp3
         ozGHgAoEGZ5kcbIYnDLl3abM712njq2ZIY+1LsSP14WvTV9ngIy0sv0pcXMaYEIyn4bq
         LRZztAJiojSJGEKZRKygbvu0dAx/EA0PPAu/9Kor+/sKN+JfP0DWJ8SRE/v1oAp1YWcO
         6AoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701605573; x=1702210373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wn+x3zBOfVaqJ6tgmSvBwPQOc/K0lcodJORVTpxMa/c=;
        b=OYO7dn9glw2vFDdbZmcJJCBzu2hq60lxurKR5GLYAFSNfxQtU1uFk/LNyx3C3jyKIv
         w40t+sW5uR8UzHESBAH6q5OL9za3pI18ogkvCaAUoN76BRogADVyo+LJaV8NZYaQ6w3y
         zKh4zHZ+5AzVbSJ0GPS9169+dY4BLneT5IPiplwAB+QkdWEkT95wu8FpfMFZShvcFA9v
         82C+w/wQhkJA47FgfdTLfmSV+mGVvGK7TXOmI/PRB+WTuI2Fpg9QSo/wM5Bn/m5JZhhf
         2YvUmyzVn1tOfq9OSIZ+X5J2ch6YwWr5rA6v9M+i5faqvf5Fy+5NrVx5LtSWNnIOeMaw
         RF1Q==
X-Gm-Message-State: AOJu0YxnNiDHo7JmztoPmiCiV/njkq23TPW3y9xl+t1S8HD6EyRbdcRg
        QkTKRpsQCf5fLq6zUxdyhoud44h3nc54rw==
X-Google-Smtp-Source: AGHT+IEts0iey4/TLNJvuTHhg568YFM9+x9aN6VFpR1x2wiaGKFx13EadOP1ONmmVJWyt8R2EPv9gg==
X-Received: by 2002:a05:600c:4f47:b0:40b:4a80:6b84 with SMTP id m7-20020a05600c4f4700b0040b4a806b84mr1681982wmq.22.1701605572527;
        Sun, 03 Dec 2023 04:12:52 -0800 (PST)
Received: from fedora.. (cable-178-148-234-71.dynamic.sbb.rs. [178.148.234.71])
        by smtp.gmail.com with ESMTPSA id p23-20020a05600c1d9700b0040b3645a7c2sm15372150wms.40.2023.12.03.04.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 04:12:51 -0800 (PST)
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Aleksa Savic <savicaleksa83@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] hwmon: Add driver for Gigabyte AORUS Waterforce AIO coolers
Date:   Sun,  3 Dec 2023 13:06:48 +0100
Message-ID: <20231203120651.371429-1-savicaleksa83@gmail.com>
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
Changes in v2 (fix issues reported by kernel bot):
- Add driver doc to hwmon doc index
- Initialize ret value in waterforce_get_status() to 0
---
 Documentation/hwmon/gigabyte_waterforce.rst |  47 +++
 Documentation/hwmon/index.rst               |   1 +
 MAINTAINERS                                 |   7 +
 drivers/hwmon/Kconfig                       |  10 +
 drivers/hwmon/Makefile                      |   1 +
 drivers/hwmon/gigabyte_waterforce.c         | 439 ++++++++++++++++++++
 6 files changed, 505 insertions(+)
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
index 000000000000..5c1084ad340a
--- /dev/null
+++ b/drivers/hwmon/gigabyte_waterforce.c
@@ -0,0 +1,439 @@
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
+	memset(priv->buffer, 0x00, MAX_REPORT_LENGTH);
+	memcpy(priv->buffer, cmd, cmd_length);
+	ret = hid_hw_output_report(priv->hdev, priv->buffer, MAX_REPORT_LENGTH);
+
+	mutex_unlock(&priv->buffer_lock);
+	return ret;
+}
+
+static int waterforce_get_status(struct waterforce_data *priv)
+{
+	int ret = 0;
+
+	if (!mutex_lock_interruptible(&priv->status_report_request_mutex)) {
+		if (!time_after(jiffies, priv->updated + msecs_to_jiffies(STATUS_VALIDITY))) {
+			/* Data is up to date */
+			goto unlock_and_return;
+		}
+
+		/*
+		 * Disable raw event parsing for a moment to safely reinitialize the
+		 * completion. Reinit is done because hidraw could have triggered
+		 * the raw event parsing and marked the priv->status_report_received
+		 * completion as done.
+		 */
+		spin_lock_bh(&priv->status_report_request_lock);
+		reinit_completion(&priv->status_report_received);
+		spin_unlock_bh(&priv->status_report_request_lock);
+
+		/* Send command for getting status */
+		ret = waterforce_write_expanded(priv, get_status_cmd, GET_STATUS_CMD_LENGTH);
+		if (ret < 0)
+			return ret;
+
+		if (wait_for_completion_interruptible_timeout
+		    (&priv->status_report_received, msecs_to_jiffies(STATUS_VALIDITY)) <= 0)
+			ret = -ENODATA;
+unlock_and_return:
+		mutex_unlock(&priv->status_report_request_mutex);
+		if (ret < 0)
+			return ret;
+	} else {
+		return -ENODATA;
+	}
+
+	return 0;
+}
+
+static int waterforce_read(struct device *dev, enum hwmon_sensor_types type,
+			   u32 attr, int channel, long *val)
+{
+	int ret;
+	struct waterforce_data *priv = dev_get_drvdata(dev);
+
+	if (time_after(jiffies, priv->updated + msecs_to_jiffies(STATUS_VALIDITY))) {
+		/* Request status on demand */
+		ret = waterforce_get_status(priv);
+		if (ret < 0)
+			return -ENODATA;
+	}
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
+			break;
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
+	int ret;
+	struct waterforce_data *priv = hid_get_drvdata(hdev);
+
+	ret = waterforce_write_expanded(priv, get_firmware_ver_cmd, GET_FIRMWARE_VER_CMD_LENGTH);
+	if (ret < 0)
+		return ret;
+
+	if (wait_for_completion_interruptible_timeout
+	    (&priv->fw_version_processed, msecs_to_jiffies(STATUS_VALIDITY)) <= 0)
+		return -ENODATA;
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
+#ifdef CONFIG_DEBUG_FS
+
+static int firmware_version_show(struct seq_file *seqf, void *unused)
+{
+	struct waterforce_data *priv = seqf->private;
+
+	if (!priv->firmware_version)
+		return -ENODATA;
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
+	scnprintf(name, sizeof(name), "%s-%s", DRIVER_NAME, dev_name(&priv->hdev->dev));
+
+	priv->debugfs = debugfs_create_dir(name, NULL);
+	debugfs_create_file("firmware_version", 0444, priv->debugfs, priv, &firmware_version_fops);
+}
+
+#else
+
+static void waterforce_debugfs_init(struct waterforce_data *priv)
+{
+}
+
+#endif
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
+		goto fail_and_stop;
+	}
+
+	ret = hid_hw_open(hdev);
+	if (ret) {
+		hid_err(hdev, "hid hw open failed with %d\n", ret);
+		goto fail_and_close;
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
+	priv->hwmon_dev = hwmon_device_register_with_info(&hdev->dev, "waterforce",
+							  priv, &waterforce_chip_info, NULL);
+	if (IS_ERR(priv->hwmon_dev)) {
+		ret = PTR_ERR(priv->hwmon_dev);
+		hid_err(hdev, "hwmon registration failed with %d\n", ret);
+		goto fail_and_close;
+	}
+
+	hid_device_io_start(hdev);
+	ret = waterforce_get_fw_ver(hdev);
+	if (ret < 0)
+		hid_warn(hdev, "fw version request failed with %d\n", ret);
+	hid_device_io_stop(hdev);
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

