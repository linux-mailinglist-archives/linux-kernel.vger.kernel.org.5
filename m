Return-Path: <linux-kernel+bounces-21319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55699828D81
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EAED1C24985
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA1C3D3A7;
	Tue,  9 Jan 2024 19:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeGWyJ6h"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745973D0B5;
	Tue,  9 Jan 2024 19:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5e7c1012a42so29658997b3.3;
        Tue, 09 Jan 2024 11:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704828962; x=1705433762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IrBjwxMrG41K/d0qseico/etjE4prp8nctrffKFsGjA=;
        b=KeGWyJ6hlJVrWDtjX/I+tXJbuhKr5b4OnznK7ApcmC5WNQ2ZXUeUXGvbZqHC6t7fXu
         2wTTHFXmEpKLX3YXtOx1naNdexHxhWw9+X6yf/qF4jCw7XTUavphkiYO4cYjg9kgmK42
         Xd/ieebjHjLxLgHRM1C/nKZFAPgA81hujMYS1k8qNvP0pJZ8tA75tJyRMnTqM+KppKzA
         RtzyfNrxdKcWEgruQ6Rc0W0f3v/94418PhIo9VyppVNCd8sQ1wA8ATOyLt/HQDuVNCyU
         1bbcA8bHL1VKl+D7RTNjKzr/zkIbqLNuV5yF5NSV9tkKQ9mNW9MkgLmGx3KIaQ6kBxWb
         MFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704828962; x=1705433762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IrBjwxMrG41K/d0qseico/etjE4prp8nctrffKFsGjA=;
        b=CFlGIoSCYRL29bho7TjtycLF3xvz//AEbpYTmOcWcK3pIpEq52yEXpQLpNVU18I2BO
         70PceKe5N+2enbKsUoD7QPOX33FA1sVovk4wgKwOyK71bzbnIZvq8Q7Qtye8BRZ+/NZO
         qVT+YXnngJY4tkPEmGBw6azwDanZbKPssfoIaNzwFdWjQzQBrbsr+67FCqD018JEN6ah
         frcdKjJmFNvIqlslka8p6BEY8Y4fEwBAkoNRJehtMVYx7cvx6JU91zrDsOt/xKLGOSZg
         Rjgw2d9YeYrtbXLnZtPE9JtbFF1C6q8aemk/v4ehQvKJ0nXCG05FI5UDnkXnDzimzKlp
         2DEw==
X-Gm-Message-State: AOJu0Yxk+CeZk7owHaHxLwgrjJAVrQvBrkyBNn9NBPO1okgMf0mjX+Hi
	geRBe+3ofLgODHsmdsJhWvFy1WFvpzML2A==
X-Google-Smtp-Source: AGHT+IEbG1x1MLRaqf4bpsfKyKAeQ6FXOs4dmZSEE06LMsCn82BY0Xjt1s0IfLvyerYz0f+313/lyw==
X-Received: by 2002:a0d:fec5:0:b0:5f7:a1bb:bf9d with SMTP id o188-20020a0dfec5000000b005f7a1bbbf9dmr3534356ywf.60.1704828962286;
        Tue, 09 Jan 2024 11:36:02 -0800 (PST)
Received: from z-Lenovo-Product.lan ([2605:59c8:6244:7610::ece])
        by smtp.gmail.com with ESMTPSA id l184-20020a8194c1000000b005ecd8995666sm995477ywg.59.2024.01.09.11.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 11:36:01 -0800 (PST)
From: David Ober <dober6023@gmail.com>
To: linux-hwmon@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jdelvare@suse.com,
	linux@roeck-us.net,
	corbet@lwn.net,
	dober@lenovo.com,
	mpearson-lenovo@squebb.ca,
	David Ober <dober6023@gmail.com>
Subject: [PATCH v3] hwmon:Add MEC172x Micro Chip driver for Lenovo motherboards
Date: Tue,  9 Jan 2024 14:35:57 -0500
Message-Id: <20240109193557.4946-1-dober6023@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This addition adds in the ability for the system to scan the
MEC172x EC chip in Lenovo ThinkStation systems to get the
current fan RPM speeds and the Maximum speed value for each
fan also provides the current CPU and DIMM thermal status

Signed-off-by: David Ober <dober6023@gmail.com>

Written by David Ober from Lenovo using this gmail address since
my corporate email address does not comply with git email

v2 fixed mixcased naming
v2 add mutex protection
v2 removed references to ACPI as it is not used
v2 added comment to explain why returning a -1 is needed
v3 verify running on a ThinkStation before calling probe function
V3 replaced empty strings with N/A value in lable arrays
V3 rename p7_amd to p8 since the name is now changed formally
V3 removed returning -1 now returns ENODEV
V3 fixed compiler warning from version 2
---
 drivers/hwmon/Kconfig             |  10 +
 drivers/hwmon/Makefile            |   1 +
 drivers/hwmon/lenovo-ec-sensors.c | 490 ++++++++++++++++++++++++++++++
 3 files changed, 501 insertions(+)
 create mode 100644 drivers/hwmon/lenovo-ec-sensors.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index ec38c8892158..821741ec0d2f 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -862,6 +862,16 @@ config SENSORS_LAN966X
 	  This driver can also be built as a module. If so, the module
 	  will be called lan966x-hwmon.
 
+config SENSORS_LENOVO_EC
+        tristate "Microchip MEC172X Chip for Lenovo ThinkStation"
+        depends on I2C
+        help
+          If you say yes here you get support for LENOVO
+          EC Sensors on newer ThinkStation systems
+
+          This driver can also be built as a module. If so, the module
+          will be called lenovo_ec_sensors.
+
 config SENSORS_LINEAGE
 	tristate "Lineage Compact Power Line Power Entry Module"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 4ac9452b5430..aa3c2dc390ec 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -104,6 +104,7 @@ obj-$(CONFIG_SENSORS_JC42)	+= jc42.o
 obj-$(CONFIG_SENSORS_K8TEMP)	+= k8temp.o
 obj-$(CONFIG_SENSORS_K10TEMP)	+= k10temp.o
 obj-$(CONFIG_SENSORS_LAN966X)	+= lan966x-hwmon.o
+obj-$(CONFIG_SENSORS_LENOVO_EC)	+= lenovo-ec-sensors.o
 obj-$(CONFIG_SENSORS_LINEAGE)	+= lineage-pem.o
 obj-$(CONFIG_SENSORS_LOCHNAGAR)	+= lochnagar-hwmon.o
 obj-$(CONFIG_SENSORS_LM63)	+= lm63.o
diff --git a/drivers/hwmon/lenovo-ec-sensors.c b/drivers/hwmon/lenovo-ec-sensors.c
new file mode 100644
index 000000000000..731d75e06977
--- /dev/null
+++ b/drivers/hwmon/lenovo-ec-sensors.c
@@ -0,0 +1,490 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * HWMON driver for MEC172x chip that publishes some sensor values
+ * via the embedded controller registers specific to Lenovo Systems.
+ *
+ * Copyright (C) 2023 David Ober (Lenovo) <dober@lenovo.com>
+ *
+ * EC provides:
+ * - CPU temperature
+ * - DIMM temperature
+ * - Chassis zone temperatures
+ * - CPU fan RPM
+ * - DIMM fan RPM
+ * - Chassis fans RPM
+ */
+
+#include <linux/acpi.h>
+#include <linux/delay.h>
+#include <linux/dmi.h>
+#include <linux/hwmon.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/units.h>
+
+#define MCHP_SING_IDX			0x0000
+#define MCHP_EMI0_APPLICATION_ID	0x090C
+#define MCHP_EMI0_EC_ADDRESS_LSB	0x0902
+#define MCHP_EMI0_EC_ADDRESS_MSB	0x0903
+#define MCHP_EMI0_EC_DATA_BYTE0		0x0904
+#define MCHP_EMI0_EC_DATA_BYTE1		0x0905
+#define MCHP_EMI0_EC_DATA_BYTE2		0x0906
+#define MCHP_EMI0_EC_DATA_BYTE3		0x0907
+
+#define io_write8(a, b)	outb_p(b, a)
+#define io_read8(a)	inb_p(a)
+
+static inline uint8_t
+get_ec_reg(unsigned char page, unsigned char index)
+{
+	u8 onebyte;
+	unsigned short m_index;
+	unsigned short phy_index = page * 256 + index;
+
+	io_write8(MCHP_EMI0_APPLICATION_ID, 0x01);
+
+	m_index = phy_index & 0x7FFC;
+	io_write8(MCHP_EMI0_EC_ADDRESS_LSB, m_index);
+	io_write8(MCHP_EMI0_EC_ADDRESS_MSB, m_index >> 8);
+
+	switch (phy_index & 0x0003) {
+	case 0:
+		onebyte = io_read8(MCHP_EMI0_EC_DATA_BYTE0);
+		break;
+	case 1:
+		onebyte = io_read8(MCHP_EMI0_EC_DATA_BYTE1);
+		break;
+	case 2:
+		onebyte = io_read8(MCHP_EMI0_EC_DATA_BYTE2);
+		break;
+	case 3:
+		onebyte = io_read8(MCHP_EMI0_EC_DATA_BYTE3);
+		break;
+	}
+
+	io_write8(MCHP_EMI0_APPLICATION_ID, 0x01);  /* write same data to clean */
+	return onebyte;
+}
+
+static const char * const systems[] = {
+	"Tomcat",
+	"Hornet",
+	"Falcon",
+	"Manta_",
+};
+
+static const char * const lenovo_px_ec_temp_label[] = {
+	"CPU1",
+	"CPU2",
+	"R_DIMM1",
+	"L_DIMM1",
+	"R_DIMM2",
+	"L_DIMM2",
+	"PCH",
+	"M2_R",
+	"M2_Z1R",
+	"M2_Z2R",
+	"PCI_Z1",
+	"PCI_Z2",
+	"PCI_Z3",
+	"PCI_Z4",
+	"AMB",
+};
+
+static const char * const lenovo_gen_ec_temp_label[] = {
+	"CPU1",
+	"N/A",
+	"R_DIMM",
+	"L_DIMM",
+	"N/A",
+	"N/A",
+	"PCH",
+	"M2_R",
+	"M2_Z1R",
+	"M2_Z2R",
+	"PCI_Z1",
+	"PCI_Z2",
+	"PCI_Z3",
+	"PCI_Z4",
+	"AMB",
+};
+
+static const char * const px_ec_fan_label[] = {
+	"CPU1_Fan",
+	"CPU2_Fan",
+	"Front_Fan1-1",
+	"Front_Fan1-2",
+	"Front_Fan2",
+	"Front_Fan3",
+	"MEM_Fan1",
+	"MEM_Fan2",
+	"Rear_Fan1",
+	"Rear_Fan2",
+	"Flex_Bay_Fan1",
+	"Flex_Bay_Fan2",
+	"Flex_Bay_Fan2",
+	"PSU_HDD_Fan",
+	"PSU1_Fan",
+	"PSU2_Fan",
+};
+
+static const char * const p7_ec_fan_label[] = {
+	"CPU1_Fan",
+	"N/A",
+	"HP_CPU_Fan1",
+	"HP_CPU_Fan2",
+	"PCIE1_4_Fan",
+	"PCIE5_7_Fan",
+	"MEM_Fan1",
+	"MEM_Fan2",
+	"Rear_Fan1",
+	"N/A",
+	"BCB_Fan",
+	"Flex_Bay_Fan",
+	"N/A",
+	"N/A",
+	"PSU_Fan",
+	"N/A",
+};
+
+static const char * const p5_ec_fan_label[] = {
+	"CPU_Fan",
+	"N/A",
+	"N/A",
+	"N/A",
+	"N/A",
+	"HDD_Fan",
+	"Duct_Fan1",
+	"MEM_Fan",
+	"Rear_Fan",
+	"N/A",
+	"Front_Fan",
+	"Flex_Bay_Fan",
+	"N/A",
+	"N/A",
+	"PSU_Fan",
+	"N/A",
+};
+
+static const char * const p8_ec_fan_label[] = {
+	"CPU1_Fan",
+	"CPU2_Fan",
+	"HP_CPU_Fan1",
+	"HP_CPU_Fan2",
+	"PCIE1_4_Fan",
+	"PCIE5_7_Fan",
+	"DIMM1_Fan1",
+	"DIMM1_Fan2",
+	"DIMM2_Fan1",
+	"DIMM2_Fan2",
+	"Rear_Fan",
+	"HDD_Bay_Fan",
+	"Flex_Bay_Fan",
+	"N/A",
+	"PSU_Fan",
+	"N/A",
+};
+
+struct ec_sensors_data {
+	struct mutex mec_mutex; /* lock for sensors write */
+	u8 platform_id;
+	const char *const *fan_labels;
+	const char *const *temp_labels;
+};
+
+static int
+lenovo_ec_do_read_temp(struct ec_sensors_data *data, u32 attr, int channel, long *val)
+{
+	u8   LSB;
+
+	switch (attr) {
+	case hwmon_temp_input:
+		mutex_lock(&data->mec_mutex);
+		LSB = get_ec_reg(2, 0x81 + channel);
+		mutex_unlock(&data->mec_mutex);
+		if (LSB > 0x40)
+			*val = (LSB - 0x40) * 1000;
+		else
+			return -ENODEV;
+		return 0;
+	default:
+		break;
+	}
+	return -EOPNOTSUPP;
+}
+
+static int
+lenovo_ec_do_read_fan(struct ec_sensors_data *data, u32 attr, int channel, long *val)
+{
+	u8    LSB, MSB;
+
+	channel *= 2;
+	switch (attr) {
+	case hwmon_fan_input:
+		mutex_lock(&data->mec_mutex);
+		LSB = get_ec_reg(4, 0x60 + channel);
+		MSB = get_ec_reg(4, 0x61 + channel);
+		mutex_unlock(&data->mec_mutex);
+		if (MSB || LSB) {
+			mutex_lock(&data->mec_mutex);
+			LSB = get_ec_reg(4, 0x20 + channel);
+			MSB = get_ec_reg(4, 0x21 + channel);
+			mutex_unlock(&data->mec_mutex);
+			*val = (MSB << 8) + LSB;
+			return 0;
+		}
+		return -ENODATA; /* enodata has the sensors tool mark the FAN speed as N/A */
+	case hwmon_fan_max:
+		mutex_lock(&data->mec_mutex);
+		LSB = get_ec_reg(4, 0x60 + channel);
+		MSB = get_ec_reg(4, 0x61 + channel);
+		mutex_unlock(&data->mec_mutex);
+		if (MSB || LSB) {
+			mutex_lock(&data->mec_mutex);
+			LSB = get_ec_reg(4, 0x40 + channel);
+			MSB = get_ec_reg(4, 0x41 + channel);
+			mutex_unlock(&data->mec_mutex);
+			*val = (MSB << 8) + LSB;
+		} else {
+			*val = 0;
+		}
+		return 0;
+	case hwmon_fan_min:
+	case hwmon_fan_div:
+	case hwmon_fan_alarm:
+		break;
+	default:
+		break;
+	}
+	return -EOPNOTSUPP;
+}
+
+static int get_platform(struct ec_sensors_data *data)
+{
+	char system_type[6];
+	int ret = -1;
+	int idx;
+
+	for (idx = 0 ; idx < 6 ; idx++) {
+		mutex_lock(&data->mec_mutex);
+		system_type[idx] = get_ec_reg(0xC, 0x10 + idx);
+		mutex_unlock(&data->mec_mutex);
+	}
+
+	for (idx = 0 ; idx < 4 ; idx++) {
+		if (!strncmp(systems[idx], system_type, 6)) {
+			ret = idx;
+			break;
+		}
+	}
+	return ret;
+}
+
+static int
+lenovo_ec_hwmon_read_string(struct device *dev, enum hwmon_sensor_types type,
+			    u32 attr, int channel, const char **str)
+{
+	struct ec_sensors_data *state = dev_get_drvdata(dev);
+
+	switch (type) {
+	case hwmon_temp:
+		*str = state->temp_labels[channel];
+		break;
+
+	case hwmon_fan:
+		*str = state->fan_labels[channel];
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
+static int
+lenovo_ec_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
+		     u32 attr, int channel, long *val)
+{
+	struct ec_sensors_data *data = dev_get_drvdata(dev);
+
+	switch (type) {
+	case hwmon_temp:
+		return lenovo_ec_do_read_temp(data, attr, channel, val);
+	case hwmon_fan:
+		return lenovo_ec_do_read_fan(data, attr, channel, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static umode_t
+lenovo_ec_hwmon_is_visible(const void *data, enum hwmon_sensor_types type,
+			   u32 attr, int channel)
+{
+	switch (type) {
+	case hwmon_temp:
+		if (attr == hwmon_temp_input || attr == hwmon_temp_label)
+			return 0444;
+		break;
+	case hwmon_fan:
+		if (attr == hwmon_fan_input || attr == hwmon_fan_max || attr == hwmon_fan_label)
+			return 0444;
+		break;
+	default:
+		return 0;
+	}
+	return 0;
+}
+
+static const struct hwmon_channel_info *lenovo_ec_hwmon_info[] = {
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL),
+	HWMON_CHANNEL_INFO(fan,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX),
+	NULL
+};
+
+static const struct hwmon_ops lenovo_ec_hwmon_ops = {
+	.is_visible = lenovo_ec_hwmon_is_visible,
+	.read = lenovo_ec_hwmon_read,
+	.read_string = lenovo_ec_hwmon_read_string,
+};
+
+static struct hwmon_chip_info lenovo_ec_chip_info = {
+	.ops = &lenovo_ec_hwmon_ops,
+	.info = lenovo_ec_hwmon_info,
+};
+
+static int lenovo_ec_probe(struct platform_device *pdev)
+{
+	struct device *hwdev;
+	struct ec_sensors_data *ec_data;
+	const struct hwmon_chip_info *chip_info;
+	struct device *dev = &pdev->dev;
+
+	ec_data = devm_kzalloc(dev, sizeof(struct ec_sensors_data), GFP_KERNEL);
+	if (!ec_data)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, ec_data);
+
+	chip_info = &lenovo_ec_chip_info;
+
+	mutex_init(&ec_data->mec_mutex);
+
+	mutex_lock(&ec_data->mec_mutex);
+	if (io_read8(MCHP_EMI0_APPLICATION_ID) != 0) { /* check EMI Application BIT */
+		io_write8(0x90C, io_read8(0x90C)); /* set EMI Application BIT to 0 */
+	}
+	io_write8(MCHP_EMI0_EC_ADDRESS_LSB, MCHP_SING_IDX);
+	io_write8(MCHP_EMI0_EC_ADDRESS_MSB, MCHP_SING_IDX >> 8);
+	mutex_unlock(&ec_data->mec_mutex);
+
+	if ((io_read8(MCHP_EMI0_EC_DATA_BYTE0) == 'M') &&
+	    (io_read8(MCHP_EMI0_EC_DATA_BYTE1) == 'C') &&
+	    (io_read8(MCHP_EMI0_EC_DATA_BYTE2) == 'H') &&
+	    (io_read8(MCHP_EMI0_EC_DATA_BYTE3) == 'P')) {
+		ec_data->platform_id = get_platform(ec_data);
+		switch (ec_data->platform_id) {
+		case 0:
+			ec_data->fan_labels = px_ec_fan_label;
+			ec_data->temp_labels = lenovo_px_ec_temp_label;
+			break;
+		case 1:
+			ec_data->fan_labels = p7_ec_fan_label;
+			ec_data->temp_labels = lenovo_gen_ec_temp_label;
+			break;
+		case 2:
+			ec_data->fan_labels = p5_ec_fan_label;
+			ec_data->temp_labels = lenovo_gen_ec_temp_label;
+			break;
+		case 3:
+			ec_data->fan_labels = p8_ec_fan_label;
+			ec_data->temp_labels = lenovo_gen_ec_temp_label;
+			break;
+		default:
+			dev_err(dev, "Unsupported ThinkStation Model");
+			return -EINVAL;
+		}
+
+		hwdev = devm_hwmon_device_register_with_info(dev, "lenovo_ec",
+							     ec_data,
+							     chip_info, NULL);
+
+		return PTR_ERR_OR_ZERO(hwdev);
+	}
+	return -ENODEV;
+}
+
+static struct platform_driver lenovo_ec_sensors_platform_driver = {
+	.driver = {
+		.name	= "lenovo-ec-sensors",
+	},
+	.probe = lenovo_ec_probe,
+};
+
+static struct platform_device *lenovo_ec_sensors_platform_device;
+
+static int __init lenovo_ec_init(void)
+{
+	char const *s;
+
+	s = dmi_get_system_info(DMI_PRODUCT_NAME);
+	if (s && !(strncasecmp(s, "ThinkStation", 12))) {
+		lenovo_ec_sensors_platform_device =
+			platform_create_bundle(&lenovo_ec_sensors_platform_driver,
+					       lenovo_ec_probe, NULL, 0, NULL, 0);
+
+		if (IS_ERR(lenovo_ec_sensors_platform_device))
+			return PTR_ERR(lenovo_ec_sensors_platform_device);
+
+		return 0;
+	}
+	return -ENODEV;
+}
+
+static void __exit lenovo_ec_exit(void)
+{
+	platform_device_unregister(lenovo_ec_sensors_platform_device);
+	platform_driver_unregister(&lenovo_ec_sensors_platform_driver);
+}
+
+module_init(lenovo_ec_init);
+module_exit(lenovo_ec_exit);
+
+MODULE_AUTHOR("David Ober <dober@lenovo.com>");
+MODULE_DESCRIPTION("HWMON driver for MEC172x EC sensors on LENOVO motherboards");
+MODULE_LICENSE("GPL");
-- 
2.34.1


