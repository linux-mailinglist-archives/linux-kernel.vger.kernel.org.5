Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C310D7A21DF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 17:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236023AbjIOPEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 11:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235495AbjIOPDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 11:03:51 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554F4211E;
        Fri, 15 Sep 2023 08:03:45 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-59bdad64411so23909317b3.3;
        Fri, 15 Sep 2023 08:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694790224; x=1695395024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qxlmDKhX/vwddWYDS1OilmowN1W0iaI9KLv2XvNed6A=;
        b=QPfpXAxTcIlwByB6iNXJC3Ufpn3FzceZIkSoHzJKh1rYpIh8ZK4FTkMG31wSg+1ZJC
         uCrvL9kUt3hGXjbQdQUpOVCewyTeYCUZBAW0H1lNh0a7smdLJNjUBk1MY5Sj5WE9JO/T
         uVlLZgXknLljPFZGH6YvcdhwSLXkUqQb76y83jVWLUGXU0Bvh146RMuz9MG8HxBq4VIb
         1MdXhkhXEilR7eRYTD3qdda5ZLf/PMQ0H4ySnyQvUEzfDUt+4qu9nxyZbmxZk3oRsd9y
         uJTDD5zQSmzsgXrnOUMHuqpBgeVlgPSpxHDar7MJmLv3uek7Jnailf+twn/YTtQS2tfO
         jI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694790224; x=1695395024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qxlmDKhX/vwddWYDS1OilmowN1W0iaI9KLv2XvNed6A=;
        b=OWmgITnPbnzCqa8h//IAfrufSDu4wa90HIVnQZmtEgiJkg6MxQZ7z/r9yDpx89v2xI
         lM6RwbcGRAq5AkTz1mU5UEOsMnnFg3q1+Lv17n3luLz1ORCs/fzdD6WCDrpxYrPj+2wK
         el+ZDpimArI8whVa+bWgG0LFK5P2HQ05NJxRnHE7d2O9OrvEJrctsQjaXebWtpvDkGH+
         7F79myNvR178H/O/NdWroYawxDJeFN5Fa9Og80px4PR8fSRS2Ynr01LiXFbjePTsitC9
         K17CT27cNLKJOwGMCP8fWcoMfqCIu/NhhHVZkZhKZ/X5d1xtFBNsiH4R5A4QlJswwtnq
         nVkQ==
X-Gm-Message-State: AOJu0YwzINyt6iX8EaRwyeswLfc+v93/Y/rK4YEEn2kdoVPvBh1GyEcH
        +7k02U0Rqb70OBaMeYMrbUpbu1RGx1XALA==
X-Google-Smtp-Source: AGHT+IF3lI2lL6AvjT8vF4t6V6HHLJ9uFvDBYCI1r+v0beO4H42ak/r8sJTnBSIdvwYTea2wW8PcMw==
X-Received: by 2002:a81:8345:0:b0:58f:af0f:1dcd with SMTP id t66-20020a818345000000b0058faf0f1dcdmr1937929ywf.17.1694790224127;
        Fri, 15 Sep 2023 08:03:44 -0700 (PDT)
Received: from z-Lenovo-Product.. ([2605:59c8:6244:7600::ece])
        by smtp.gmail.com with ESMTPSA id m17-20020a819c11000000b005707fb5110bsm888968ywa.58.2023.09.15.08.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 08:03:43 -0700 (PDT)
From:   David Ober <dober6023@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net,
        dober@lenovo.com, mpearson@lenovo.com,
        David Ober <dober6023@gmail.com>
Subject: [PATCH] hwmon:Add MEC172x Micro Chip driver for Lenovo motherboards
Date:   Fri, 15 Sep 2023 11:03:40 -0400
Message-Id: <20230915150340.301067-1-dober6023@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This addition adds in the ability for the system to scan the
MEC172x EC chip in Lenovo ThinkStation systems to get the
current fan RPM speeds and the Maximum speed value for each
fan also provides the current CPU and DIMM thermal status

Signed-off-by: David Ober <dober6023@gmail.com>

Written by David Ober from Lenovo using this gmail address since
my corporate email address does not comply with git email
---
 drivers/hwmon/Kconfig             |  10 +
 drivers/hwmon/Makefile            |   1 +
 drivers/hwmon/lenovo-ec-sensors.c | 471 ++++++++++++++++++++++++++++++
 3 files changed, 482 insertions(+)
 create mode 100644 drivers/hwmon/lenovo-ec-sensors.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 307477b8a371..565fc957a900 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -852,6 +852,16 @@ config SENSORS_LAN966X
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
index 3f4b0fda0998..ac7855b48bd5 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -103,6 +103,7 @@ obj-$(CONFIG_SENSORS_JC42)	+= jc42.o
 obj-$(CONFIG_SENSORS_K8TEMP)	+= k8temp.o
 obj-$(CONFIG_SENSORS_K10TEMP)	+= k10temp.o
 obj-$(CONFIG_SENSORS_LAN966X)	+= lan966x-hwmon.o
+obj-$(CONFIG_SENSORS_LENOVO_EC)	+= lenovo-ec-sensors.o
 obj-$(CONFIG_SENSORS_LINEAGE)	+= lineage-pem.o
 obj-$(CONFIG_SENSORS_LOCHNAGAR)	+= lochnagar-hwmon.o
 obj-$(CONFIG_SENSORS_LM63)	+= lm63.o
diff --git a/drivers/hwmon/lenovo-ec-sensors.c b/drivers/hwmon/lenovo-ec-sensors.c
new file mode 100644
index 000000000000..acf26ed4c96b
--- /dev/null
+++ b/drivers/hwmon/lenovo-ec-sensors.c
@@ -0,0 +1,471 @@
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
+#include <linux/hwmon.h>
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
+#define IoWrite8(a, b)	outb_p(b, a)
+#define IoRead8(a)	inb_p(a)
+
+static inline uint8_t
+get_ec_reg(unsigned char page, unsigned char index)
+{
+	u8 onebyte;
+	unsigned short m_index;
+	unsigned short phy_index = page * 256 + index;
+
+	if (IoRead8(MCHP_EMI0_APPLICATION_ID) != 0) /* EMI access locked */
+		return false;
+
+	IoWrite8(MCHP_EMI0_APPLICATION_ID, 0x01);
+
+	m_index = phy_index & 0x7FFC;
+	IoWrite8(MCHP_EMI0_EC_ADDRESS_LSB, m_index);
+	IoWrite8(MCHP_EMI0_EC_ADDRESS_MSB, m_index >> 8);
+
+	switch (phy_index & 0x0003) {
+	case 0:
+		onebyte = IoRead8(MCHP_EMI0_EC_DATA_BYTE0);
+		break;
+	case 1:
+		onebyte = IoRead8(MCHP_EMI0_EC_DATA_BYTE1);
+		break;
+	case 2:
+		onebyte = IoRead8(MCHP_EMI0_EC_DATA_BYTE2);
+		break;
+	case 3:
+		onebyte = IoRead8(MCHP_EMI0_EC_DATA_BYTE3);
+		break;
+	}
+
+	IoWrite8(MCHP_EMI0_APPLICATION_ID, 0x01);  /* write same data to clean */
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
+	"",
+	"R_DIMM",
+	"L_DIMM",
+	"",
+	"",
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
+	"",
+	"HP_CPU_Fan1",
+	"HP_CPU_Fan2",
+	"PCIE1_4_Fan",
+	"PCIE5_7_Fan",
+	"MEM_Fan1",
+	"MEM_Fan2",
+	"Rear_Fan1",
+	"",
+	"BCB_Fan",
+	"Flex_Bay_Fan",
+	"",
+	"",
+	"PSU_Fan",
+	"",
+};
+
+static const char * const p5_ec_fan_label[] = {
+	"CPU_Fan",
+	"",
+	"",
+	"",
+	"",
+	"HDD_Fan",
+	"Duct_Fan1",
+	"MEM_Fan",
+	"Rear_Fan",
+	"",
+	"Front_Fan",
+	"Flex_Bay_Fan",
+	"",
+	"",
+	"PSU_Fan",
+	"",
+};
+
+static const char * const p7_amd_ec_fan_label[] = {
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
+	"",
+	"PSU_Fan",
+	"",
+};
+
+struct ec_sensors_data {
+	u8 platform_id;
+	const char *const *fan_labels;
+	const char *const *temp_labels;
+};
+
+static int
+lenovo_ec_do_read_temp(u32 attr, int channel, long *val)
+{
+	u8   LSB;
+
+	switch (attr) {
+	case hwmon_temp_input:
+		LSB = get_ec_reg(2, 0x81 + channel);
+		if (LSB > 0x40) {
+			*val = (LSB - 0x40) * 1000;
+		} else {
+			*val = 0;
+			return -1;
+		}
+		return 0;
+	default:
+		break;
+	}
+	return -EOPNOTSUPP;
+}
+
+static int
+lenovo_ec_do_read_fan(u32 attr, int channel, long *val)
+{
+	u8    LSB, MSB;
+
+	channel *= 2;
+	switch (attr) {
+	case hwmon_fan_input:
+		LSB = get_ec_reg(4, 0x60 + channel);
+		MSB = get_ec_reg(4, 0x61 + channel);
+		if ((MSB << 8) + LSB != 0) {
+			LSB = get_ec_reg(4, 0x20 + channel);
+			MSB = get_ec_reg(4, 0x21 + channel);
+			*val = (MSB << 8) + LSB;
+			return 0;
+		}
+		return -1;
+	case hwmon_fan_max:
+		LSB = get_ec_reg(4, 0x60 + channel);
+		MSB = get_ec_reg(4, 0x61 + channel);
+		if ((MSB << 8) + LSB != 0) {
+			LSB = get_ec_reg(4, 0x40 + channel);
+			MSB = get_ec_reg(4, 0x41 + channel);
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
+static int get_platform(void)
+{
+	char system_type[6];
+	int ret = -1;
+	int idx;
+
+	for (idx = 0 ; idx < 6 ; idx++)
+		system_type[idx] = get_ec_reg(0xC, (0x10 + idx));
+
+	for (idx = 0 ; idx < 4 ; idx++) {
+		if (strcmp(systems[idx], system_type) == 0) {
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
+		return -EOPNOTSUPP; /* unreachable */
+	}
+	return 0;
+}
+
+static int
+lenovo_ec_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
+		     u32 attr, int channel, long *val)
+{
+	switch (type) {
+	case hwmon_temp:
+		return lenovo_ec_do_read_temp(attr, channel, val);
+	case hwmon_fan:
+		return lenovo_ec_do_read_fan(attr, channel, val);
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
+	//if (type != hwmon_fan)
+//		return 0;
+
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
+	if (IoRead8(0x90C) != 0) {               /* check EMI Application BIT */
+		IoWrite8(0x90C, IoRead8(0x90C)); /* set EMI Application BIT to 0 */
+	}
+	IoWrite8(MCHP_EMI0_EC_ADDRESS_LSB, MCHP_SING_IDX);
+	IoWrite8(MCHP_EMI0_EC_ADDRESS_MSB, MCHP_SING_IDX >> 8);
+
+	if ((IoRead8(MCHP_EMI0_EC_DATA_BYTE0) == 'M') &&
+	    (IoRead8(MCHP_EMI0_EC_DATA_BYTE1) == 'C') &&
+	    (IoRead8(MCHP_EMI0_EC_DATA_BYTE2) == 'H') &&
+	    (IoRead8(MCHP_EMI0_EC_DATA_BYTE3) == 'P')) {
+		ec_data->platform_id = get_platform();
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
+			ec_data->fan_labels = p7_amd_ec_fan_label;
+			ec_data->temp_labels = lenovo_gen_ec_temp_label;
+			break;
+		default:
+			dev_err(dev, "Unknown ThinkStation Model");
+			return -EINVAL;
+		}
+
+		hwdev = devm_hwmon_device_register_with_info(dev, "lenovo_ec",
+							     ec_data,
+							     chip_info, NULL);
+
+		return PTR_ERR_OR_ZERO(hwdev);
+	} else {
+		return -ENODEV;
+	}
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
+	lenovo_ec_sensors_platform_device =
+		platform_create_bundle(&lenovo_ec_sensors_platform_driver,
+				       lenovo_ec_probe, NULL, 0, NULL, 0);
+
+	if (IS_ERR(lenovo_ec_sensors_platform_device))
+		return PTR_ERR(lenovo_ec_sensors_platform_device);
+
+	return 0;
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
+MODULE_DESCRIPTION("HWMON driver for MEC172x EC sensors accessible via ACPI on LENOVO motherboards");
+MODULE_LICENSE("GPL");
-- 
2.34.1

