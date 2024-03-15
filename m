Return-Path: <linux-kernel+bounces-104375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B033287CCFC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BA49283848
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910841C291;
	Fri, 15 Mar 2024 11:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKXkN03t"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDEE635;
	Fri, 15 Mar 2024 11:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710503899; cv=none; b=n2+YgGPapaaPczjVDAPu/MKS+6DvG4OD832qfYgzYq4quvBfd6CLRilOM8wOouQfUliWfwh/u6tF53abiG8epzgatDIpsjT6JubDmWjjqOo4+6i2mvbAPG2vos3YimhhPiWaTQX+jAcdcjgnxb/Nxyhlv1YCayQFOTr5KbqjWA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710503899; c=relaxed/simple;
	bh=9Chvq8Fz7UbS3dftOZmx+B0BHFgI3v7Eznw430tZb6o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vfx9mPmeuCA3QmtKRSGio9CRusXg3YtVMYwxX2NDVH2CfK9o+hPkJuE1mAL6PLaYerM4bMFWL0LsRZgIIX64gh3wq9nwpfpeuDrNsW6UAgJZDi6xRM0e4Uz52DpHjtEAvJ5mNvN+u+zUK+ShESYgyPhhqFRQh0UxZq4ozQ0+B8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKXkN03t; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-60a0599f631so17876197b3.2;
        Fri, 15 Mar 2024 04:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710503896; x=1711108696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6SiLwbm12yK1GmIkLf1enyoqzEYREOJ/vGurc3gfjTo=;
        b=aKXkN03teNmuOzJVB7CnmRqgHw6v1VH10c3hS/n9OPOWCb4p0lmwF86yaUV4sqq6Hx
         RcOQdCffLxCRCQv1ojCB8UL1oen8Dh+0n2pe3CYMqqaq0Rf0ttmYctglhSi4l+MGs3zK
         xLXJhUEGvU1pnK7bdHk9LplF/RlwNYz8sFz7OX6TJmsNzxhmRPR95PXYhedn8y/0Wgha
         4/rh+FyUYm8yUGQGcyJs4AQQrb/Rlx/5hbNeLBcxFpxJ8WjQ3K+1JXqwzdbEgFNA0XiP
         Ae8Hvz/9NsplGiqBu/X7/ybvIV9WOHQZ57cTi/i+hl7n0bgBuCVnmn6AapsT+4XxcHbv
         rj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710503896; x=1711108696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6SiLwbm12yK1GmIkLf1enyoqzEYREOJ/vGurc3gfjTo=;
        b=smrnvaFLCZxh5IMOf39RtCOs/cCRynB6o6nrE2M5F9acOexJ16VAfsG39udLPTO0oz
         nUj6dHbFjZqCMpYT1ZKlryq9KeF1Vrhbd01eOW3bOpT7NKq6iuTiWvoo6XOOB1aoP/qk
         mqlqu3PPCx+noYgy+KD2gR7ItihA72sTh1cau7GxGWGi/5ls9iupbv1lnrLuACm2rfY7
         qYtpIi87B+UDBUAbFknYyZKEPf/Qsjz0kFgOLWzyUTkx8nZv0hbSBidtwSg0+2G7shG8
         WAlcPtqK94qz9Ni9hQeBGHFIzelhEkl4KYFj+0bYC8TTEutCdW0KTojHbO9AFSk6olTn
         P+LA==
X-Forwarded-Encrypted: i=1; AJvYcCVIJT0/sA32naKTGNs8qhI4cVtr7gxb1Xxlez6TCTdJ+Wn55NYQhHtC4rgqiFyzxkWohw7XhQthIV/xsXYSORPHCNYc3sQhY3Et7FJ1
X-Gm-Message-State: AOJu0YyH4gyZAtFyw/LoUAJdlbxPXXBuuv19QevgSofZ1hZFTvMU794o
	BI+5Oev2qhxrb0mrmeZeUc4E/yW7PDUSybEtRA3mAb8pif1Bz0ysU1SNl+rvMxg=
X-Google-Smtp-Source: AGHT+IHfoHrzs+qHe3XL4IWhL6JfvKAUb6CswftYmP8EA79WRRJPR9oWE0+U2kusw4+PhmBGVE9YQQ==
X-Received: by 2002:a0d:e212:0:b0:60a:13f3:9990 with SMTP id l18-20020a0de212000000b0060a13f39990mr4521334ywe.15.1710503895833;
        Fri, 15 Mar 2024 04:58:15 -0700 (PDT)
Received: from z-Lenovo-Product.lan ([2605:59c8:6241:1610::ece])
        by smtp.gmail.com with ESMTPSA id i72-20020a0ddf4b000000b00604a0aedd92sm680855ywe.108.2024.03.15.04.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 04:58:15 -0700 (PDT)
From: David Ober <dober6023@gmail.com>
To: linux-hwmon@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jdelvare@suse.com,
	linux@roeck-us.net,
	corbet@lwn.net,
	dober@lenovo.com,
	mpearson@lenovo.com,
	David Ober <dober6023@gmail.com>
Subject: [PATCH v4] hwmon:Add EC Chip driver for Lenovo ThinkStation motherboards
Date: Fri, 15 Mar 2024 07:58:10 -0400
Message-Id: <20240315115810.15816-1-dober6023@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This addition adds in the ability for the system to scan
the EC chip in the Lenovo ThinkStation systems to get the
current fan RPM speeds the Maximum speed value for each
fan also provides the CPU, DIMM other thermal statuses

Signed-off-by: David Ober <dober@lenovo.com>
Signed-off-by: David Ober <dober6023@gmail.com>

---
Changes in V4
removed internal name references and checks
added in DMI checks to verify the device is a on supported system
added in IO memory region protection
---
---
 drivers/hwmon/Kconfig             |  10 +
 drivers/hwmon/Makefile            |   1 +
 drivers/hwmon/lenovo-ec-sensors.c | 615 ++++++++++++++++++++++++++++++
 3 files changed, 626 insertions(+)
 create mode 100644 drivers/hwmon/lenovo-ec-sensors.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index ec38c8892158..a4bb403bd4ad 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -862,6 +862,16 @@ config SENSORS_LAN966X
 	  This driver can also be built as a module. If so, the module
 	  will be called lan966x-hwmon.
 
+config SENSORS_LENOVO_EC
+        tristate "Sensor reader for Lenovo ThinkStations"
+        depends on X86
+        help
+          If you say yes here you get support for LENOVO
+          EC Sensor data on newer ThinkStation systems
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
index 000000000000..0fc32bc11365
--- /dev/null
+++ b/drivers/hwmon/lenovo-ec-sensors.c
@@ -0,0 +1,615 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * HWMON driver for Lenovo ThinkStation based workstations
+ * via the embedded controller registers
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
+#define IO_REGION_START			0x0900
+#define IO_REGION_LENGTH		0xD
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
+	onebyte = io_read8(MCHP_EMI0_EC_DATA_BYTE0 + (phy_index & 3));
+
+	io_write8(MCHP_EMI0_APPLICATION_ID, 0x01);  /* write 0x01 again to clean */
+	return onebyte;
+}
+
+enum systems {
+	LENOVO_PX,
+	LENOVO_P7,
+	LENOVO_P5,
+	LENOVO_P8,
+};
+
+static int px_temp_map[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15};
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
+static int gen_temp_map[] = {0, 2, 3, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15};
+
+static const char * const lenovo_gen_ec_temp_label[] = {
+	"CPU1",
+	"R_DIMM",
+	"L_DIMM",
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
+static int px_fan_map[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15};
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
+static int p7_fan_map[] = {0, 2, 3, 4, 5, 6, 7, 8, 10, 11, 14};
+
+static const char * const p7_ec_fan_label[] = {
+	"CPU1_Fan",
+	"HP_CPU_Fan1",
+	"HP_CPU_Fan2",
+	"PCIE1_4_Fan",
+	"PCIE5_7_Fan",
+	"MEM_Fan1",
+	"MEM_Fan2",
+	"Rear_Fan1",
+	"BCB_Fan",
+	"Flex_Bay_Fan",
+	"PSU_Fan",
+};
+
+static int p5_fan_map[] = {0, 5, 6, 7, 8, 10, 11, 14};
+
+static const char * const p5_ec_fan_label[] = {
+	"CPU_Fan",
+	"HDD_Fan",
+	"Duct_Fan1",
+	"MEM_Fan",
+	"Rear_Fan",
+	"Front_Fan",
+	"Flex_Bay_Fan",
+	"PSU_Fan",
+};
+
+static int p8_fan_map[] = {0. 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 14};
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
+	"PSU_Fan",
+};
+
+struct ec_sensors_data {
+	struct mutex mec_mutex; /* lock for sensor data access */
+	/*int platform_id;*/
+	const char *const *fan_labels;
+	const char *const *temp_labels;
+	const int *fan_map;
+	const int *temp_map;
+};
+
+static int
+lenovo_ec_do_read_temp(struct ec_sensors_data *data, u32 attr, int channel, long *val)
+{
+	u8 lsb;
+
+	switch (attr) {
+	case hwmon_temp_input:
+		mutex_lock(&data->mec_mutex);
+		lsb = get_ec_reg(2, 0x81 + channel);
+		mutex_unlock(&data->mec_mutex);
+		if (lsb <= 0x40)
+			return -ENODATA;
+		*val = (lsb - 0x40) * 1000;
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
+	u8 lsb, msb;
+
+	channel *= 2;
+	switch (attr) {
+	case hwmon_fan_input:
+		mutex_lock(&data->mec_mutex);
+		lsb = get_ec_reg(4, 0x20 + channel);
+		msb = get_ec_reg(4, 0x21 + channel);
+		mutex_unlock(&data->mec_mutex);
+		*val = (msb << 8) + lsb;
+		return 0;
+	case hwmon_fan_max:
+		mutex_lock(&data->mec_mutex);
+		lsb = get_ec_reg(4, 0x40 + channel);
+		msb = get_ec_reg(4, 0x41 + channel);
+		mutex_unlock(&data->mec_mutex);
+		*val = (msb << 8) + lsb;
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
+		return lenovo_ec_do_read_temp(data, attr, data->temp_map[channel], val);
+	case hwmon_fan:
+		return lenovo_ec_do_read_fan(data, attr, data->fan_map[channel], val);
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
+static const struct hwmon_channel_info *lenovo_ec_hwmon_info_px[] = {
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
+static const struct hwmon_channel_info *lenovo_ec_hwmon_info_p8[] = {
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
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX),
+	NULL
+};
+
+static const struct hwmon_channel_info *lenovo_ec_hwmon_info_p7[] = {
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
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX),
+	NULL
+};
+
+static const struct hwmon_channel_info *lenovo_ec_hwmon_info_p5[] = {
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
+			   HWMON_T_INPUT | HWMON_T_LABEL),
+	HWMON_CHANNEL_INFO(fan,
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
+};
+
+static const struct dmi_system_id thinkstation_dmi_table[] = {
+	{
+		.ident = "LENOVO_PX",
+		.driver_data = (void *)(long)LENOVO_PX,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "30EU"),
+		},
+	},
+	{
+		.ident = "LENOVO_PX",
+		.driver_data = (void *)(long)LENOVO_PX,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "30EV"),
+		},
+	},
+	{
+		.ident = "LENOVO_P7",
+		.driver_data = (void *)(long)LENOVO_P7,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "30F2"),
+		},
+	},
+	{
+		.ident = "LENOVO_P7",
+		.driver_data = (void *)(long)LENOVO_P7,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "30F3"),
+		},
+	},
+	{
+		.ident = "LENOVO_P5",
+		.driver_data = (void *)(long)LENOVO_P5,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "30G9"),
+		},
+	},
+	{
+		.ident = "LENOVO_P5",
+		.driver_data = (void *)(long)LENOVO_P5,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "30GA"),
+		},
+	},
+	{
+		.ident = "LENOVO_P8",
+		.driver_data = (void *)(long)LENOVO_P8,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "30HH"),
+		},
+	},
+	{
+		.ident = "LENOVO_P8",
+		.driver_data = (void *)(long)LENOVO_P8,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "30HJ"),
+		},
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(dmi, thinkstation_dmi_table);
+
+static int lenovo_ec_probe(struct platform_device *pdev)
+{
+	struct device *hwdev;
+	struct ec_sensors_data *ec_data;
+	const struct hwmon_chip_info *chip_info;
+	struct device *dev = &pdev->dev;
+	const struct dmi_system_id *dmi_id;
+	int app_id;
+
+	ec_data = devm_kzalloc(dev, sizeof(struct ec_sensors_data), GFP_KERNEL);
+	if (!ec_data) {
+		release_region(IO_REGION_START, IO_REGION_LENGTH);
+		return -ENOMEM;
+	}
+
+	dev_set_drvdata(dev, ec_data);
+
+	chip_info = &lenovo_ec_chip_info;
+
+	mutex_init(&ec_data->mec_mutex);
+
+	mutex_lock(&ec_data->mec_mutex);
+	app_id = io_read8(MCHP_EMI0_APPLICATION_ID);
+	if (app_id) /* check EMI Application ID Value */
+		io_write8(MCHP_EMI0_APPLICATION_ID, app_id); /* set EMI Application ID to 0 */
+	io_write8(MCHP_EMI0_EC_ADDRESS_LSB, MCHP_SING_IDX);
+	io_write8(MCHP_EMI0_EC_ADDRESS_MSB, MCHP_SING_IDX >> 8);
+	mutex_unlock(&ec_data->mec_mutex);
+
+	if ((io_read8(MCHP_EMI0_EC_DATA_BYTE0) != 'M') &&
+	    (io_read8(MCHP_EMI0_EC_DATA_BYTE1) != 'C') &&
+	    (io_read8(MCHP_EMI0_EC_DATA_BYTE2) != 'H') &&
+	    (io_read8(MCHP_EMI0_EC_DATA_BYTE3) != 'P')) {
+		release_region(IO_REGION_START, IO_REGION_LENGTH);
+		return -ENODEV;
+	}
+
+	dmi_id = dmi_first_match(thinkstation_dmi_table);
+
+	switch ((long)dmi_id->driver_data) {
+	case 0:
+		ec_data->fan_labels = px_ec_fan_label;
+		ec_data->temp_labels = lenovo_px_ec_temp_label;
+		ec_data->fan_map = px_fan_map;
+		ec_data->temp_map = px_temp_map;
+		lenovo_ec_chip_info.info = lenovo_ec_hwmon_info_px;
+		break;
+	case 1:
+		ec_data->fan_labels = p7_ec_fan_label;
+		ec_data->temp_labels = lenovo_gen_ec_temp_label;
+		ec_data->fan_map = p7_fan_map;
+		ec_data->temp_map = gen_temp_map;
+		lenovo_ec_chip_info.info = lenovo_ec_hwmon_info_p7;
+		break;
+	case 2:
+		ec_data->fan_labels = p5_ec_fan_label;
+		ec_data->temp_labels = lenovo_gen_ec_temp_label;
+		ec_data->fan_map = p5_fan_map;
+		ec_data->temp_map = gen_temp_map;
+		lenovo_ec_chip_info.info = lenovo_ec_hwmon_info_p5;
+		break;
+	case 3:
+		ec_data->fan_labels = p8_ec_fan_label;
+		ec_data->temp_labels = lenovo_gen_ec_temp_label;
+		ec_data->fan_map = p8_fan_map;
+		ec_data->temp_map = gen_temp_map;
+		lenovo_ec_chip_info.info = lenovo_ec_hwmon_info_p8;
+		break;
+	default:
+		release_region(IO_REGION_START, IO_REGION_LENGTH);
+		return -ENODEV;
+	}
+
+	hwdev = devm_hwmon_device_register_with_info(dev, "lenovo_ec",
+						     ec_data,
+						     chip_info, NULL);
+
+	return PTR_ERR_OR_ZERO(hwdev);
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
+	if (!dmi_check_system(thinkstation_dmi_table))
+		return -ENODEV;
+
+	if (!request_region(IO_REGION_START, IO_REGION_LENGTH, "LNV-WKS")) {
+		pr_err(":request fail\n");
+		return -EIO;
+	}
+
+	lenovo_ec_sensors_platform_device =
+		platform_create_bundle(&lenovo_ec_sensors_platform_driver,
+				       lenovo_ec_probe, NULL, 0, NULL, 0);
+
+	if (IS_ERR(lenovo_ec_sensors_platform_device)) {
+		release_region(IO_REGION_START, IO_REGION_LENGTH);
+		return PTR_ERR(lenovo_ec_sensors_platform_device);
+	}
+
+	return 0;
+}
+
+static void __exit lenovo_ec_exit(void)
+{
+	release_region(IO_REGION_START, IO_REGION_LENGTH);
+	platform_device_unregister(lenovo_ec_sensors_platform_device);
+	platform_driver_unregister(&lenovo_ec_sensors_platform_driver);
+}
+
+module_init(lenovo_ec_init);
+module_exit(lenovo_ec_exit);
+
+MODULE_AUTHOR("David Ober <dober@lenovo.com>");
+MODULE_DESCRIPTION("HWMON driver for sensors accesssible via EC in LENOVO motherboards");
+MODULE_LICENSE("GPL");
-- 
2.34.1


