Return-Path: <linux-kernel+bounces-125693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05C1892AC0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 12:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D48701C2125D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 11:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E203374C2;
	Sat, 30 Mar 2024 11:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwdMxriv"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846D125777;
	Sat, 30 Mar 2024 11:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711797879; cv=none; b=Lrx2uX1fvi7f+Dkc6nAcT4b4NZEV5qC2W8UUuta9m8tEKbrUyeE/SMB//w4IoKdogoHC3QyNEmF4kUwKFl+7CSBd033cDoOyYIEK6lA4iuXTbdrPnmnxEY0q6HRzq0ihcGJqB7uwWlcdKk8y3ZiUAbtdRRaAJ8hX++VgnSNWP3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711797879; c=relaxed/simple;
	bh=9FBDzSTfbzAZUKuKSIYgYHJj6RJPDf5zA+UAze032IE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kKrSaT28tVJHiwBMsU4wCMUBUlEwJ+nsd0NSpIaDwEk13KjJBXaSFKPScHbJToWLEbHCTVxpRLq9jeLQ3HRz9Zr9aBBuEKKrumZHdQehPoRorI9vAhtRpuZ+ffoC1pYjcrpigTEPRzd99bL/1VSwt+AfzCQjblP4fgS4yNkXyhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EwdMxriv; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-513e89d0816so3043542e87.0;
        Sat, 30 Mar 2024 04:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711797876; x=1712402676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swsfFKDKA94pEfEcaHOpAjs9gEbFOmP0I3ngtZ3Cfoo=;
        b=EwdMxrivsvCGpo9smr0m9i0AJ91JhHSnKqrrpMAKvbPK/3aev3TuWuqnvTdch9RwG4
         IbL+q4bgfqq6bRG9HGzfDI7KKxysPCcasBT/ZcmbvY2RS375FUR9yui3+jJqqa8/7+A1
         PR3fQvcthCMBri2e3TdTGulrfNbgiXHEg9jdlKKEd/OFVETqi2/JskWytF1ow6ftPiVQ
         k+Ictfs+exi0Be3Y6dSCm0isMW/5SiFUtgI2w63vigOGRRSaM+PfokxIxx5AW3ZIwola
         LamCI8kiSn6k1qhonyaZvlrQiBDaK1kWrWToWiLDGajfANJphnP7IJaJK+wWtK3DL5c0
         KzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711797876; x=1712402676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=swsfFKDKA94pEfEcaHOpAjs9gEbFOmP0I3ngtZ3Cfoo=;
        b=qPI5IeraLInBKTMbs7GlqEGzzWbsn7W7ddRhUUQUD9qQxJF6NimxSWqaqUgrpeN4pR
         Mkg5bVGyZRMcCheYfqtktNaqS/Wpp2POyc+zpdv2jHvZ34LMM5gsDqCmpc1qYBPRNXnA
         lWE7tnIsh4CIr4UQAMLxJyKYRSnj/sVEmCDhUGAKwSookkEgs2ByljAVliSC1W1FwEs2
         S6l+ZPLG3gj55nJ9aKiurAXsFS10jJQryHk2+MRs7CSoU32pH3jJpg3lPmoUPT6eRfAt
         u/lrKDmdbd8u+M+qL6d8C8+lIkwnc74q+nAzICle1uXZg5vze/aa6dbzWsp0oSXfymAi
         d75A==
X-Forwarded-Encrypted: i=1; AJvYcCWgsW7OJmwaVhaGK6TQ/GPIcKSrB/ytDqxcLW2wI4HueEiG62czE/TSKasOAiwNx8vIDMgcNwcJvOYorxadeEOgFBBWQLYeH8q4lvkUshLHqv+YyeAWP4WoZspXUccoNGp8Drc3FNevvIIyZmFok0JR7j0E3PzCNrlNySOF03fXhnCm9C0wVPqIhAKXgLzm
X-Gm-Message-State: AOJu0YyOijRSt++oWt0U/L3Z01a7cgV+T99Qg11JRg5o/214TQFEGekV
	jiGA2veB02UFh1YsdP73Hsixr4IzZBmsfygcr03MyEmQHd6PqZTD
X-Google-Smtp-Source: AGHT+IFZAw4i4aJvglRTSFnZPKcG8IcQegPe/ANMTMVE1OH8JUh4l2gI77gg12x4MeJPObgCGi8UbA==
X-Received: by 2002:ac2:5f1a:0:b0:513:a05d:7e9a with SMTP id 26-20020ac25f1a000000b00513a05d7e9amr2794768lfq.45.1711797875418;
        Sat, 30 Mar 2024 04:24:35 -0700 (PDT)
Received: from xws.fritz.box ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id m31-20020a05600c3b1f00b004146750314csm11441775wms.3.2024.03.30.04.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 04:24:34 -0700 (PDT)
From: Maximilian Luz <luzmaximilian@gmail.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>
Cc: Ivor Wanders <ivor@iwanders.net>,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH 1/3] hwmon: Add thermal sensor driver for Surface Aggregator Module
Date: Sat, 30 Mar 2024 12:24:00 +0100
Message-ID: <20240330112409.3402943-2-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240330112409.3402943-1-luzmaximilian@gmail.com>
References: <20240330112409.3402943-1-luzmaximilian@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some of the newer Microsoft Surface devices (such as the Surface Book
3 and Pro 9) have thermal sensors connected via the Surface Aggregator
Module (the embedded controller on those devices). Add a basic driver
to read out the temperature values of those sensors.

Link: https://github.com/linux-surface/surface-aggregator-module/issues/59
Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 MAINTAINERS                  |   6 ++
 drivers/hwmon/Kconfig        |  10 +++
 drivers/hwmon/Makefile       |   1 +
 drivers/hwmon/surface_temp.c | 165 +++++++++++++++++++++++++++++++++++
 4 files changed, 182 insertions(+)
 create mode 100644 drivers/hwmon/surface_temp.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d36c19c1bf811..bc5bc418ed479 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14738,6 +14738,12 @@ S:	Maintained
 F:	Documentation/hwmon/surface_fan.rst
 F:	drivers/hwmon/surface_fan.c
 
+MICROSOFT SURFACE SENSOR THERMAL DRIVER
+M:	Maximilian Luz <luzmaximilian@gmail.com>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	drivers/hwmon/surface_temp.c
+
 MICROSOFT SURFACE GPE LID SUPPORT DRIVER
 M:	Maximilian Luz <luzmaximilian@gmail.com>
 L:	platform-driver-x86@vger.kernel.org
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 83945397b6eb1..338ef73c96a3a 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2070,6 +2070,16 @@ config SENSORS_SURFACE_FAN
 
 	  Select M or Y here, if you want to be able to read the fan's speed.
 
+config SENSORS_SURFACE_TEMP
+	tristate "Microsoft Surface Thermal Sensor Driver"
+	depends on SURFACE_AGGREGATOR
+	help
+	  Driver for monitoring thermal sensors connected via the Surface
+	  Aggregator Module (embedded controller) on Microsoft Surface devices.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called surface_temp.
+
 config SENSORS_ADC128D818
 	tristate "Texas Instruments ADC128D818"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 5c31808f6378d..de8bc99719e63 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -208,6 +208,7 @@ obj-$(CONFIG_SENSORS_SMSC47M192)+= smsc47m192.o
 obj-$(CONFIG_SENSORS_SPARX5)	+= sparx5-temp.o
 obj-$(CONFIG_SENSORS_STTS751)	+= stts751.o
 obj-$(CONFIG_SENSORS_SURFACE_FAN)+= surface_fan.o
+obj-$(CONFIG_SENSORS_SURFACE_TEMP)+= surface_temp.o
 obj-$(CONFIG_SENSORS_SY7636A)	+= sy7636a-hwmon.o
 obj-$(CONFIG_SENSORS_AMC6821)	+= amc6821.o
 obj-$(CONFIG_SENSORS_TC74)	+= tc74.o
diff --git a/drivers/hwmon/surface_temp.c b/drivers/hwmon/surface_temp.c
new file mode 100644
index 0000000000000..48c3e826713f6
--- /dev/null
+++ b/drivers/hwmon/surface_temp.c
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Thermal sensor subsystem driver for Surface System Aggregator Module (SSAM).
+ *
+ * Copyright (C) 2022-2023 Maximilian Luz <luzmaximilian@gmail.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/hwmon.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/types.h>
+
+#include <linux/surface_aggregator/controller.h>
+#include <linux/surface_aggregator/device.h>
+
+
+/* -- SAM interface. -------------------------------------------------------- */
+
+SSAM_DEFINE_SYNC_REQUEST_CL_R(__ssam_tmp_get_available_sensors, __le16, {
+	.target_category = SSAM_SSH_TC_TMP,
+	.command_id      = 0x04,
+});
+
+SSAM_DEFINE_SYNC_REQUEST_MD_R(__ssam_tmp_get_temperature, __le16, {
+	.target_category = SSAM_SSH_TC_TMP,
+	.command_id      = 0x01,
+});
+
+static int ssam_tmp_get_available_sensors(struct ssam_device *sdev, s16 *sensors)
+{
+	__le16 sensors_le;
+	int status;
+
+	status = __ssam_tmp_get_available_sensors(sdev, &sensors_le);
+	if (status)
+		return status;
+
+	*sensors = le16_to_cpu(sensors_le);
+	return 0;
+}
+
+static int ssam_tmp_get_temperature(struct ssam_device *sdev, u8 iid, long *temperature)
+{
+	__le16 temp_le;
+	int status;
+
+	status = __ssam_tmp_get_temperature(sdev->ctrl, sdev->uid.target, iid, &temp_le);
+	if (status)
+		return status;
+
+	/* Convert 1/10 °K to 1/1000 °C */
+	*temperature = (le16_to_cpu(temp_le) - 2731) * 100L;
+	return 0;
+}
+
+
+/* -- Driver.---------------------------------------------------------------- */
+
+struct ssam_temp {
+	struct ssam_device *sdev;
+	s16 sensors;
+};
+
+static umode_t ssam_temp_hwmon_is_visible(const void *data,
+					  enum hwmon_sensor_types type,
+					  u32 attr, int channel)
+{
+	const struct ssam_temp *ssam_temp = data;
+
+	if (!(ssam_temp->sensors & BIT(channel)))
+		return 0;
+
+	return 0444;
+}
+
+static int ssam_temp_hwmon_read(struct device *dev,
+				enum hwmon_sensor_types type,
+				u32 attr, int channel, long *value)
+{
+	const struct ssam_temp *ssam_temp = dev_get_drvdata(dev);
+
+	return ssam_tmp_get_temperature(ssam_temp->sdev, channel + 1, value);
+}
+
+static const struct hwmon_channel_info * const ssam_temp_hwmon_info[] = {
+	HWMON_CHANNEL_INFO(chip,
+			   HWMON_C_REGISTER_TZ),
+	/* We have at most 16 thermal sensor channels. */
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT,
+			   HWMON_T_INPUT,
+			   HWMON_T_INPUT,
+			   HWMON_T_INPUT,
+			   HWMON_T_INPUT,
+			   HWMON_T_INPUT,
+			   HWMON_T_INPUT,
+			   HWMON_T_INPUT,
+			   HWMON_T_INPUT,
+			   HWMON_T_INPUT,
+			   HWMON_T_INPUT,
+			   HWMON_T_INPUT,
+			   HWMON_T_INPUT,
+			   HWMON_T_INPUT,
+			   HWMON_T_INPUT,
+			   HWMON_T_INPUT),
+	NULL
+};
+
+static const struct hwmon_ops ssam_temp_hwmon_ops = {
+	.is_visible = ssam_temp_hwmon_is_visible,
+	.read = ssam_temp_hwmon_read,
+};
+
+static const struct hwmon_chip_info ssam_temp_hwmon_chip_info = {
+	.ops = &ssam_temp_hwmon_ops,
+	.info = ssam_temp_hwmon_info,
+};
+
+static int ssam_temp_probe(struct ssam_device *sdev)
+{
+	struct ssam_temp *ssam_temp;
+	struct device *hwmon_dev;
+	s16 sensors;
+	int status;
+
+	status = ssam_tmp_get_available_sensors(sdev, &sensors);
+	if (status)
+		return status;
+
+	ssam_temp = devm_kzalloc(&sdev->dev, sizeof(*ssam_temp), GFP_KERNEL);
+	if (!ssam_temp)
+		return -ENOMEM;
+
+	ssam_temp->sdev = sdev;
+	ssam_temp->sensors = sensors;
+
+	hwmon_dev = devm_hwmon_device_register_with_info(&sdev->dev,
+			"surface_thermal", ssam_temp, &ssam_temp_hwmon_chip_info,
+			NULL);
+	if (IS_ERR(hwmon_dev))
+		return PTR_ERR(hwmon_dev);
+
+	return 0;
+}
+
+static const struct ssam_device_id ssam_temp_match[] = {
+	{ SSAM_SDEV(TMP, SAM, 0x00, 0x02) },
+	{ },
+};
+MODULE_DEVICE_TABLE(ssam, ssam_temp_match);
+
+static struct ssam_device_driver ssam_temp = {
+	.probe = ssam_temp_probe,
+	.match_table = ssam_temp_match,
+	.driver = {
+		.name = "surface_temp",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+};
+module_ssam_device_driver(ssam_temp);
+
+MODULE_AUTHOR("Maximilian Luz <luzmaximilian@gmail.com>");
+MODULE_DESCRIPTION("Thermal sensor subsystem driver for Surface System Aggregator Module");
+MODULE_LICENSE("GPL");
-- 
2.44.0


