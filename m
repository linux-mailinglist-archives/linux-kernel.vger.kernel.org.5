Return-Path: <linux-kernel+bounces-77423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07381860519
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4C58B2414C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22D412D201;
	Thu, 22 Feb 2024 21:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ID0uZFMZ"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBE212D1EC;
	Thu, 22 Feb 2024 21:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708638535; cv=none; b=uDVFvcqA6x6na+z6HWvm0FDapCKJ7d3b07l3gCxgGe445TM9AbInBzUrtqLuR0PmPES6FZHksMRGkEn2dT8nX16gu0alpGopo4wQJ36jQJg0R2WUBtiRt2qiApW6kmoZNdGKwsfJmsbEN3OW1BPaBdlBlrDRTVzMnzXyr0SUy9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708638535; c=relaxed/simple;
	bh=aMrWqgYK1e6hxcqXytMTHp7Ih4S3iczfOmywBnfV+vA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DZjAZ99g8AeyKWAaXDqfiOPsPN4KJFsDXHgPfnU3lY8y2rO0VfrX2k9qLF35meAGYFDeCbFjNAh1z0YFESpgTuuLqh8NHz89cDmhqi1FRwUL4yP6gOaL9jIR1argeSOZCwn2o3NF6PEa8lgkAzMYTGo+jHn6hog7TUSa977HnWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ID0uZFMZ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-512cca90f38so308973e87.2;
        Thu, 22 Feb 2024 13:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708638532; x=1709243332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iestUm478PxK+5YaLCEJhp6yc3SushaDmiD6YpHgsD4=;
        b=ID0uZFMZHlgP5JNyZ3BYSrbWpLBmNKoql0THJam+ChvM0yizmJ6RWRdaEa0KtetFYM
         0+ZbMBGr+p/HV7qT0hZGynPq1y9EDb3XGvas4e5/p7NCwZsk5KLIfAX/APLXtgWe96Sq
         xvr18rPLpMfB8miyl1CmATAEyxVmOiMgAMqPaMXdYeoHOmXxrZ6gVAV/iipwYVNNAKZ2
         w//IVtSpdPCLpuDi0vCwdJFMR3r3CvGXJBPtjlfYMmf4hzAtTV0zEaxv4+unOwBDt+B0
         lG3NbByhPkfDVwTXORY8AkwDVIRnbk472bt4cGXQINRUCE1SCTLKNPkpLYOs30LI37UY
         ECeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708638532; x=1709243332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iestUm478PxK+5YaLCEJhp6yc3SushaDmiD6YpHgsD4=;
        b=boJtZJqI+BxPXOhzXdzvkMWrDBPVWIQtyLyONipVwP7fADqgACydYolwl8utvfAzyu
         mKpmKcGeuBHGA4LNCU1bVgkbOaQ1sdAXdSfIiBTmSRtSioX4jKp0QsCBZQt/KrGPeA2F
         hcQOF6pJeoLimHRUDwWa6PM5dH3USGqg0bmaLX80joqS6Xs/thIn/6mXhelpFqp6wXij
         DGwQC89G0RDkCMRiTHM+LB27xQAremggpmIPC2xaS4FGAPSGIexuQU3JyVcK89fSMmSu
         QP6xt9c8QOcP3PnDsjMtEIvw1lCYfimhWWE6GrCrTLS2rv23CrxCqP5aLRJD43OLvVe6
         I7EA==
X-Forwarded-Encrypted: i=1; AJvYcCUJj2BKqq2D3URA5pUsc5wZyvUuztiH8Qf/nmkjbu/Ql+lkTMWkSUZ3/ozztt6XvoVMsFH4l2HZyRRHybMvCaG7snU1Zc/B5Isbb9m0qGLG7MRWv2xow47NScKic4UKVuY+wdNkbhIkwYVHBOmGkRzZCJCJj/1MaE2puM9iADp3wVnQODIL6viHa/nqvEc1
X-Gm-Message-State: AOJu0YwP84sZSoEVaAuFiyvYm7kisSuLqQh710v/KuXV4GcICd+lSrGN
	UoFgIlGzyVkUT41jCE2TtAMhLX8jRkIcKCojIGvdVMbIxjntjHMD
X-Google-Smtp-Source: AGHT+IGgj0BqB2cALTtSfMvuvW4MLV2WQd/3ewSmbBPc84VCBC9Gz2CEwRZUkyUKjC68l6jNX3nXXg==
X-Received: by 2002:a05:6512:3e15:b0:512:e394:bfb1 with SMTP id i21-20020a0565123e1500b00512e394bfb1mr261194lfv.43.1708638531417;
        Thu, 22 Feb 2024 13:48:51 -0800 (PST)
Received: from localhost.localdomain ([94.120.90.19])
        by smtp.gmail.com with ESMTPSA id kf16-20020a17090776d000b00a3ef85f0bf7sm2972525ejc.85.2024.02.22.13.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 13:48:50 -0800 (PST)
From: =?UTF-8?q?Mustafa=20Ek=C5=9Fi?= <mustafa.eskieksi@gmail.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Cc: mustafa.eskieksi@gmail.com,
	jdelvare@suse.com,
	linux@roeck-us.net,
	pavel@ucw.cz,
	lee@kernel.org
Subject: [PATCH v2] platform/x86: Add wmi driver for Casper Excalibur laptops. Odd line breaks was because I have used scripts/Lindent without checking, I'm sorry for that. And for my weird rgb led API: This kind of design was also used in drivers/platform/x86/dell/alienware-wmi.c:239, but mine differs as it doesn't create different attributes for different leds. That is because driver doesn't know how many leds there are, to know how many leds there are it should check processor information (whether it's 10th gen or 11th). I don't think include/linux/mod_devicetable.h supports that. If there is a way to differentiate cpus, please let me know. And even if it knew how many leds there are, having different attributes can be cumbersome because there's no way of reading leds. And also user can change led state without notifying os (with some hotkey). But I'm open to further discussion. And thanks for all of your careful reviewing. It helped me to learn more.
Date: Fri, 23 Feb 2024 00:48:15 +0300
Message-ID: <20240222214815.245280-1-mustafa.eskieksi@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adding wmi driver for Casper Excalibur Laptops:
This driver implements a ledclass_dev device for keyboard backlight
and hwmon driver to read fan speed and (also write) pwm mode. NEW_LEDS is
selected because this driver introduces new leds, and LEDS_CLASS is selected
because this driver implements a led class device. All of Casper Excalibur
Laptops are supported but fan speeds has a bug for older generations.

Signed-off-by: Mustafa Ekşi <mustafa.eskieksi@gmail.com>
---
 MAINTAINERS                       |   6 +
 drivers/platform/x86/Kconfig      |  14 ++
 drivers/platform/x86/Makefile     |   1 +
 drivers/platform/x86/casper-wmi.c | 315 ++++++++++++++++++++++++++++++
 4 files changed, 336 insertions(+)
 create mode 100644 drivers/platform/x86/casper-wmi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ed4d386853..d0142a75d2c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4723,6 +4723,12 @@ S:	Maintained
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/carl9170
 F:	drivers/net/wireless/ath/carl9170/
 
+CASPER EXCALIBUR WMI DRIVER
+M:	Mustafa Ekşi <mustafa.eskieksi@gmail.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+F:	drivers/platform/x86/casper-wmi.c
+
 CAVIUM I2C DRIVER
 M:	Robert Richter <rric@kernel.org>
 S:	Odd Fixes
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index bdd302274b9..ebef9c9dfb6 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1127,6 +1127,20 @@ config SEL3350_PLATFORM
 	  To compile this driver as a module, choose M here: the module
 	  will be called sel3350-platform.
 
+config CASPER_WMI
+	tristate "Casper Excalibur Laptop WMI driver"
+	depends on ACPI_WMI
+	depends on HWMON
+	select NEW_LEDS
+	select LEDS_CLASS
+	help
+	  Say Y here if you want to support WMI-based fan speed reporting,
+	  power management and keyboard backlight support on Casper Excalibur
+	  Laptops.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called casper-wmi.
+
 endif # X86_PLATFORM_DEVICES
 
 config P2SB
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 1de432e8861..4b527dd44ad 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_MXM_WMI)			+= mxm-wmi.o
 obj-$(CONFIG_NVIDIA_WMI_EC_BACKLIGHT)	+= nvidia-wmi-ec-backlight.o
 obj-$(CONFIG_XIAOMI_WMI)		+= xiaomi-wmi.o
 obj-$(CONFIG_GIGABYTE_WMI)		+= gigabyte-wmi.o
+obj-$(CONFIG_CASPER_WMI)		+= casper-wmi.o
 
 # Acer
 obj-$(CONFIG_ACERHDF)		+= acerhdf.o
diff --git a/drivers/platform/x86/casper-wmi.c b/drivers/platform/x86/casper-wmi.c
new file mode 100644
index 00000000000..012ebda195d
--- /dev/null
+++ b/drivers/platform/x86/casper-wmi.c
@@ -0,0 +1,315 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/bitops.h>
+#include <linux/acpi.h>
+#include <linux/leds.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/wmi.h>
+#include <linux/device.h>
+#include <linux/hwmon.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+#include <acpi/acexcep.h>
+#include <linux/bitfield.h>
+#include <linux/sysfs.h>
+
+#define CASPER_WMI_GUID "644C5791-B7B0-4123-A90B-E93876E0DAAD"
+
+#define CASPER_READ 0xfa00
+#define CASPER_WRITE 0xfb00
+#define CASPER_GET_HARDWAREINFO 0x0200
+#define CASPER_SET_LED 0x0100
+#define CASPER_POWERPLAN 0x0300
+
+#define CASPER_KEYBOARD_LED_1 0x03
+#define CASPER_KEYBOARD_LED_2 0x04
+#define CASPER_KEYBOARD_LED_3 0x05
+#define CASPER_ALL_KEYBOARD_LEDS 0x06
+#define CASPER_CORNER_LEDS 0x07
+
+#define CASPER_LED_ID    0xF00000000
+#define CASPER_LED_MODE  0x0F0000000
+#define CASPER_LED_ALPHA 0x00F000000
+
+struct casper_wmi_args {
+	u16 a0, a1;
+	u32 a2, a3, a4, a5, a6, a7, a8;
+};
+
+static u32 casper_last_color;
+static u8 casper_last_led;
+
+static int casper_set(struct wmi_device *wdev, u16 a1, u8 led_id,
+			      u32 data)
+{
+	struct casper_wmi_args wmi_args = {
+		.a0 = CASPER_WRITE,
+		.a1 = a1,
+		.a2 = led_id,
+		.a3 = data
+	};
+	struct acpi_buffer input = {
+		(acpi_size) sizeof(struct casper_wmi_args),
+		&wmi_args
+	};
+	if (ACPI_FAILURE(wmidev_block_set(wdev, 0, &input)))
+		return -EINVAL;
+	return 0;
+}
+
+static ssize_t led_control_show(struct device *dev, struct device_attribute
+				*attr, char *buf)
+{
+	return sysfs_emit("%u%08x\n", buf, casper_last_led,
+		       casper_last_color);
+}
+
+/*
+ * Format wanted from user is a hexadecimal 36-bit integer: most significant
+ * 4 bits are led_id, next 4 bits are mode and next 4 bits are brightness,
+ * next 24 bits are rgb value. 64 bits
+ * IMARRGGBB
+ */
+static ssize_t led_control_store(struct device *dev, struct device_attribute
+				 *attr, const char *buf, size_t count)
+{
+	if (strlen(buf) != 10)
+		return -EINVAL;
+	u64 user_input;
+	/*
+	 * 16-base selected for ease of writing color codes. I chose 64 bit and
+	 * kstrtou64 because format I use determined fits into 64 bit.
+	 */
+	int ret = kstrtou64(buf, 16, &user_input);
+	if (ret)
+		return ret;
+	/*
+	 * led_id can't exceed 255 but it can vary among newer versions and
+	 * other models.
+	 */
+	u8 led_id = FIELD_GET(CASPER_LED_ID, user_input);
+	ret = casper_set(to_wmi_device(dev->parent), CASPER_SET_LED,
+			led_id, (u32) user_input);
+	if (ret)
+		return ret;
+	if (led_id != CASPER_CORNER_LEDS) {
+		casper_last_color = (u32) user_input;
+		casper_last_led = led_id;
+	}
+	return count;
+}
+
+static DEVICE_ATTR_RW(led_control);
+
+static struct attribute *casper_kbd_led_attrs[] = {
+	&dev_attr_led_control.attr,
+	NULL,
+};
+
+ATTRIBUTE_GROUPS(casper_kbd_led);
+
+static void set_casper_backlight_brightness(struct led_classdev *led_cdev,
+					    enum led_brightness brightness)
+{
+	// Setting any of the keyboard leds' brightness sets brightness of all
+	u32 bright_prep = FIELD_PREP(CASPER_LED_ALPHA, brightness);
+	u32 color_no_alpha = casper_last_color&~CASPER_LED_ALPHA;
+
+	casper_set(to_wmi_device(led_cdev->dev->parent), CASPER_SET_LED,
+		       CASPER_KEYBOARD_LED_1, color_no_alpha | bright_prep
+	);
+}
+
+static enum led_brightness get_casper_backlight_brightness(struct led_classdev
+							   *led_cdev)
+{
+	return FIELD_GET(CASPER_LED_ALPHA, casper_last_color);
+}
+
+static struct led_classdev casper_kbd_led = {
+	.name = "casper::kbd_backlight",
+	.brightness = 0,
+	.brightness_set = set_casper_backlight_brightness,
+	.brightness_get = get_casper_backlight_brightness,
+	.max_brightness = 2,
+	.groups = casper_kbd_led_groups,
+};
+
+static int casper_query(struct wmi_device *wdev, u16 a1,
+				struct casper_wmi_args *out)
+{
+	struct casper_wmi_args wmi_args = {
+		.a0 = CASPER_READ,
+		.a1 = a1
+	};
+	struct acpi_buffer input = {
+		(acpi_size) sizeof(struct casper_wmi_args),
+		&wmi_args
+	};
+
+	acpi_status ret = wmidev_block_set(wdev, 0, &input);
+	if (ACPI_FAILURE(ret))
+		return -EIO;
+
+	union acpi_object *obj = wmidev_block_query(wdev, 0);
+	if (obj->type != ACPI_TYPE_BUFFER) // obj will be int (0x10) on failure
+		return -EINVAL;
+	if (obj->buffer.length != 32)
+		return -EIO;
+
+	memcpy(out, obj->buffer.pointer, sizeof(struct casper_wmi_args));
+	kfree(obj);
+	return ret;
+}
+
+static umode_t casper_wmi_hwmon_is_visible(const void *drvdata,
+					   enum hwmon_sensor_types type,
+					   u32 attr, int channel)
+{
+	switch (type) {
+	case hwmon_fan:
+		return 0444;
+	case hwmon_pwm:
+		return 0644;
+	default:
+		return 0;
+	}
+	return 0;
+}
+
+static int casper_wmi_hwmon_read(struct device *dev,
+				 enum hwmon_sensor_types type, u32 attr,
+				 int channel, long *val)
+{
+	struct casper_wmi_args out = { 0 };
+	struct wmi_device *wdev = to_wmi_device(dev->parent);
+	int ret;
+
+	switch (type) {
+	case hwmon_fan:
+		ret = casper_query(wdev, CASPER_GET_HARDWAREINFO, &out);
+		/*
+		 * a4 and a5 is little endian in older laptops (with 10th gen
+		 * cpus or older) and big endian in newer ones. I don't think
+		 * dmi has something for cpu information. Also, defining a
+		 * dmi_list just for this seems like an overkill. This problem
+		 * can be solved in userspace too.
+		 */
+		if (channel == 0) // CPU fan
+			*val = out.a4;
+		else if (channel == 1) // GPU fan
+			*val = out.a5;
+		return 0;
+	case hwmon_pwm:
+		ret = casper_query(wdev, CASPER_POWERPLAN, &out);
+		if (ret) // power plan count varies generations.
+			return ret;
+		if (channel == 0)
+			*val = out.a2;
+		return 0;
+	default:
+		return -ENODEV;
+	}
+}
+
+static int casper_wmi_hwmon_read_string(struct device *dev,
+					enum hwmon_sensor_types type, u32 attr,
+					int channel, const char **str)
+{
+	switch (type) {
+	case hwmon_fan:
+		switch (channel) {
+		case 0:
+			*str = "cpu_fan_speed";
+			break;
+		case 1:
+			*str = "gpu_fan_speed";
+			break;
+		default:
+			return -ENODEV;
+		}
+		break;
+	default:
+		return -ENODEV;
+	}
+	return 0;
+}
+
+static int casper_wmi_hwmon_write(struct device *dev,
+				  enum hwmon_sensor_types type, u32 attr,
+				  int channel, long val)
+{
+	acpi_status ret;
+
+	switch (type) {
+	case hwmon_pwm:
+		if (val > 5 || val < 0)
+			return -EINVAL;
+		ret = casper_set(to_wmi_device(dev->parent),
+				 CASPER_POWERPLAN, val, 0);
+		if (ret)
+			return ret;
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static const struct hwmon_ops casper_wmi_hwmon_ops = {
+	.is_visible = &casper_wmi_hwmon_is_visible,
+	.read = &casper_wmi_hwmon_read,
+	.read_string = &casper_wmi_hwmon_read_string,
+	.write = &casper_wmi_hwmon_write
+};
+
+static const struct hwmon_channel_info *const casper_wmi_hwmon_info[] = {
+	HWMON_CHANNEL_INFO(fan,
+			   HWMON_F_INPUT | HWMON_F_LABEL,
+			   HWMON_F_INPUT | HWMON_F_LABEL),
+	HWMON_CHANNEL_INFO(pwm, HWMON_PWM_MODE),
+	NULL
+};
+
+static const struct hwmon_chip_info casper_wmi_hwmon_chip_info = {
+	.ops = &casper_wmi_hwmon_ops,
+	.info = casper_wmi_hwmon_info,
+};
+
+static int casper_wmi_probe(struct wmi_device *wdev, const void *context)
+{
+	struct device *hwmon_dev;
+
+	if (ACPI_FAILURE(led_classdev_register(&wdev->dev, &casper_kbd_led)))
+		return -ENODEV;
+	hwmon_dev = devm_hwmon_device_register_with_info(&wdev->dev,
+						"casper_wmi", wdev,
+						&casper_wmi_hwmon_chip_info,
+						NULL);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+static void casper_wmi_remove(struct wmi_device *wdev)
+{
+	led_classdev_unregister(&casper_kbd_led);
+}
+
+static const struct wmi_device_id casper_wmi_id_table[] = {
+	{ CASPER_WMI_GUID, NULL },
+	{ }
+};
+
+static struct wmi_driver casper_wmi_driver = {
+	.driver = {
+		   .name = "casper-wmi",
+		    },
+	.id_table = casper_wmi_id_table,
+	.probe = casper_wmi_probe,
+	.remove = &casper_wmi_remove,
+};
+
+module_wmi_driver(casper_wmi_driver);
+MODULE_DEVICE_TABLE(wmi, casper_wmi_id_table);
+
+MODULE_AUTHOR("Mustafa Ekşi <mustafa.eskieksi@gmail.com>");
+MODULE_DESCRIPTION("Casper Excalibur Laptop WMI driver");
+MODULE_LICENSE("GPL");
-- 
2.43.2


