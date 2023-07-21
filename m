Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A2E75C401
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjGUKGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjGUKGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:06:00 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A9BCE;
        Fri, 21 Jul 2023 03:05:57 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id ca18e2360f4ac-786f25bcb40so76107139f.3;
        Fri, 21 Jul 2023 03:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689933956; x=1690538756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BEW196PpnTlK0N66UFK6IxuhCDHvVfXtZq2tyJ9L5OM=;
        b=EcWpYGO/mxolyz42jGQdvGwDRvMLkaPenFTrf4xtyA8wde+O26qR0KvviFl5ydAfv7
         W8xJLXD5yV9S8SGb59nMg8HYfnghQOllH78HNjjupu/TFeoPH28O4HHtH6N9+P6dxjTd
         TFElFtvplZLbBr57h22nsKmclzhudv0S2Sv8sBjFHcU+OWz8thz1PTV4VH+GJ9+bJ5Jm
         /M8+7W43oiEktgOfLegB4lNAaAZ9HCAXCqrHwm8HnEmnQlvJyQbyul3mK4b+nOJjmI/I
         jPrW4Mh0szCxBGE/ZkV7C516sSJyFdokhPHnOUcxJ8Mt3WeKOfTe9BbE/O/0WYNA5cDu
         t0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689933956; x=1690538756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BEW196PpnTlK0N66UFK6IxuhCDHvVfXtZq2tyJ9L5OM=;
        b=Kno1pckUyA+2KIPPaorCtXRtZKXbfwC5pYv2rr4kbK8vDcAueIA+sOjxf/t8Evfv63
         IpaDmBrTpN75hopffTu0t81CJ+r9zWVKT8aEPThDf4j4PcNOLSiiMKusm0KJHpe9mkVK
         NeplXNq2P6MAO3CjIfqWPT8HXKD5/iMnKQluxlZrXDj9x6BKM4DG3RSw+ziejpPcSkPD
         BHDndjqTjMTx8F1J7dF7KpOBNNEuyQzwg/V7jNQ83bYDHBkxfj1KOCYPAbTlULp4EjP/
         WbLsdVj9Ay8zwMfutx1uk9iigJp6ojdRcQe+wxZhvVmzB1bBIJGqNyqGoHKMaG2pk2gn
         xHLg==
X-Gm-Message-State: ABy/qLZ3gmMyGifPOJT/mQWPCLGGN+4Mo9HoA+5oRci2Q0MMAMR0cEm7
        dv+Qyf+cTCj2UGWqyyHvU1I=
X-Google-Smtp-Source: APBJJlFXhCnSkY2B1xkToWHVhsBoFZwt0rpyvOTpPu/jluHxRmY0nf7jtfulxeVS/ZOZ0MhxU7NowQ==
X-Received: by 2002:a5e:834c:0:b0:787:1d53:e6cc with SMTP id y12-20020a5e834c000000b007871d53e6ccmr1277010iom.21.1689933956458;
        Fri, 21 Jul 2023 03:05:56 -0700 (PDT)
Received: from ws-565760.systec.local ([212.185.67.148])
        by smtp.gmail.com with ESMTPSA id u2-20020a02cb82000000b0042bb3e62108sm957187jap.4.2023.07.21.03.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 03:05:55 -0700 (PDT)
From:   werneazc@gmail.com
X-Google-Original-From: andre.werner@systec-electronic.com
To:     jdelvare@suse.com, linux@roeck-us.net,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        robh+dt@kernel.org
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andre Werner <andre.werner@systec-electronic.com>
Subject: [PATCH v4 2/2] hwmon: (hs3001) Add driver for Renesas HS3001
Date:   Fri, 21 Jul 2023 12:05:19 +0200
Message-ID: <20230721100519.597-2-andre.werner@systec-electronic.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andre Werner <andre.werner@systec-electronic.com>

Add base support for Renesas HS3001 temperature
and humidity sensors and its compatibles HS3002,
HS3003 and HS3004.

The sensor has a fix I2C address 0x44. The resolution
is fixed to 14bit (ref. Missing feature).

Missing feature:
- Accessing non-volatile memory: Custom board has no
  possibility to control voltage supply of sensor. Thus,
  we cannot send the necessary control commands within
  the first 10ms after power-on.

Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>

---
Changelog:
v1: Initial version
v2: Extensive refactoring following recommendations of reviewers:
 - Delete unused defines and device properties. These are added in
   the initial version because the device supports a programming mode,
   but I was not able to implement it, because the custom board was
   not able to control the power supply of the device and so I cannot
   enter the programming mode of the device.
 - Correct misunderstanding comments for defines.
 - Delete mutexes for data and I2C bus accesses.
 - Replace attributes with recommended chip-info structure. In the
   initial version I followed the sth3x.c implementation that uses
   files and attributes in sysfs. The show functions are replaced by
   is_visible and read callbacks from the HWMON ABI. I also  delete pointless
   function argument checks.
 - Correct Yoda programming.
 - Refactor probe function and delete sleep and measurement of humidity
   and temperature in probe function. I kept an initial I2C
   communication to ensure that the device is accessible during probe.
 - Reduce the number of attributes to humidity and temperature input.
 v3: Delete chip data because it is unused.
 v4: Refactor driver as follows:
 - Delete further unused defines
 - Replace masks and operations with GENMASK and FIELD_GET macros
 - Add mutex to protect chip wakeup and data transfer operations on bus
 - Reformat driver as requested
 - Make hs3001_is_visible and hs3001_read function static
---
 Documentation/hwmon/hs3001.rst |  37 +++++
 MAINTAINERS                    |   6 +
 drivers/hwmon/Kconfig          |  10 ++
 drivers/hwmon/Makefile         |   1 +
 drivers/hwmon/hs3001.c         | 250 +++++++++++++++++++++++++++++++++
 5 files changed, 304 insertions(+)
 create mode 100644 Documentation/hwmon/hs3001.rst
 create mode 100644 drivers/hwmon/hs3001.c

diff --git a/Documentation/hwmon/hs3001.rst b/Documentation/hwmon/hs3001.rst
new file mode 100644
index 000000000000..703fb9c45313
--- /dev/null
+++ b/Documentation/hwmon/hs3001.rst
@@ -0,0 +1,37 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Kernel driver HS3001
+===================
+
+Supported chips:
+
+  * Renesas HS3001, HS3002, HS3003, HS3004
+
+    Prefix: 'hs3001'
+
+    Addresses scanned: -
+
+    Datasheet: https://www.renesas.com/us/en/document/dst/hs300x-datasheet?r=417401
+
+Author:
+
+  - Andre Werner <andre.werner@systec-electronic.com>
+
+Description
+-----------
+
+This driver implements support for the Renesas HS3001 chips, a humidity
+and temperature family. Temperature is measured in degrees celsius, relative
+humidity is expressed as a percentage. In the sysfs interface, all values are
+scaled by 1000, i.e. the value for 31.5 degrees celsius is 31500.
+
+The device communicates with the I2C protocol. Sensors have the I2C
+address 0x44 by default.
+
+sysfs-Interface
+---------------
+
+===============================================================================
+temp1_input:        temperature input
+humidity1_input:    humidity input
+===============================================================================
diff --git a/MAINTAINERS b/MAINTAINERS
index aee340630eca..25d5282b43aa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9494,6 +9494,12 @@ S:	Maintained
 W:	http://artax.karlin.mff.cuni.cz/~mikulas/vyplody/hpfs/index-e.cgi
 F:	fs/hpfs/
 
+HS3001 Hardware Temperature and Humidity Sensor
+M:	Andre Werner <andre.werner@systec-electronic.com>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	drivers/hwmon/hs3001.c
+
 HSI SUBSYSTEM
 M:	Sebastian Reichel <sre@kernel.org>
 S:	Maintained
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 307477b8a371..ca6be5a23271 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -734,6 +734,16 @@ config SENSORS_HIH6130
 	  This driver can also be built as a module. If so, the module
 	  will be called hih6130.
 
+config SENSORS_HS3001
+	tristate "Renesas HS3001 humidity and temperature sensors"
+	depends on I2C
+	help
+	  If you say yes here you get support for the Renesas HS3001,
+	  to HS3004 humidity and temperature sensors.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called hs3001.
+
 config SENSORS_IBMAEM
 	tristate "IBM Active Energy Manager temperature/power sensors and control"
 	select IPMI_SI
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 3f4b0fda0998..cdae4e1fc919 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -86,6 +86,7 @@ obj-$(CONFIG_SENSORS_GSC)	+= gsc-hwmon.o
 obj-$(CONFIG_SENSORS_GPIO_FAN)	+= gpio-fan.o
 obj-$(CONFIG_SENSORS_GXP_FAN_CTRL) += gxp-fan-ctrl.o
 obj-$(CONFIG_SENSORS_HIH6130)	+= hih6130.o
+obj-$(CONFIG_SENSORS_HS3001)	+= hs3001.o
 obj-$(CONFIG_SENSORS_ULTRA45)	+= ultra45_env.o
 obj-$(CONFIG_SENSORS_I5500)	+= i5500_temp.o
 obj-$(CONFIG_SENSORS_I5K_AMB)	+= i5k_amb.o
diff --git a/drivers/hwmon/hs3001.c b/drivers/hwmon/hs3001.c
new file mode 100644
index 000000000000..483b47c81b83
--- /dev/null
+++ b/drivers/hwmon/hs3001.c
@@ -0,0 +1,250 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * This is a non-complete driver implementation for the
+ * HS3001 humidity and temperature sensor and compatibles. It does not include
+ * the configuration possibilities, where it needs to be set to 'programming mode'
+ * during power-up.
+ *
+ *
+ * Copyright (C) 2023 SYS TEC electronic AG
+ * Author: Andre Werner <andre.werner@systec-electronic.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/hwmon.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+/* Measurement times */
+#define HS3001_WAKEUP_TIME	100	/* us */
+#define HS3001_8BIT_RESOLUTION	550	/* us */
+#define HS3001_10BIT_RESOLUTION	1310	/* us */
+#define HS3001_12BIT_RESOLUTION	4500	/* us */
+#define HS3001_14BIT_RESOLUTION	16900	/* us */
+
+#define HS3001_RESPONSE_LENGTH	4
+
+#define HS3001_FIXPOINT_ARITH	1000U
+
+#define HS3001_MASK_HUMIDITY_0X3FFF	GENMASK(13, 0)
+#define HS3001_MASK_STATUS_0XC0	GENMASK(7, 6)
+
+/* Definitions for Status Bits of A/D Data */
+#define HS3001_DATA_VALID	0x00	/* Valid Data */
+#define HS3001_DATA_STALE	0x01	/* Stale Data */
+
+struct hs3001_data {
+	struct i2c_client *client;
+	struct mutex i2c_lock; /* lock for sending i2c commands */
+	u32 wait_time;		/* in us */
+	int temperature;	/* in milli degree */
+	u32 humidity;		/* in milli % */
+};
+
+static int hs3001_extract_temperature(u16 raw)
+{
+	/* fixpoint arithmetic 1 digit */
+	int temp = (raw >> 2) * HS3001_FIXPOINT_ARITH;
+
+	temp /= (1 << 14) - 1;
+
+	return temp * 165 - 40 * HS3001_FIXPOINT_ARITH;
+}
+
+static u32 hs3001_extract_humidity(u16 raw)
+{
+	u32 hum = (raw & HS3001_MASK_HUMIDITY_0X3FFF) * HS3001_FIXPOINT_ARITH;
+
+	hum /= (1 << 14) - 1;
+
+	return hum * 100;
+}
+
+static int hs3001_data_fetch_command(struct i2c_client *client,
+				     struct hs3001_data *data)
+{
+	int ret;
+	u8 buf[HS3001_RESPONSE_LENGTH];
+	u8 hs3001_status;
+
+	ret = i2c_master_recv(client, buf, HS3001_RESPONSE_LENGTH);
+	if (ret != HS3001_RESPONSE_LENGTH) {
+		ret = ret < 0 ? ret : -EIO;
+		dev_dbg(&client->dev,
+			"Error in i2c communication. Error code: %d.\n", ret);
+		return ret;
+	}
+
+	hs3001_status = FIELD_GET(HS3001_MASK_STATUS_0XC0, buf[0]);
+	if (hs3001_status == HS3001_DATA_STALE) {
+		dev_dbg(&client->dev, "Sensor busy.\n");
+		return -EBUSY;
+	}
+	if (hs3001_status != HS3001_DATA_VALID) {
+		dev_dbg(&client->dev, "Data invalid.\n");
+		return -EIO;
+	}
+
+	data->humidity =
+		hs3001_extract_humidity(be16_to_cpup((__be16 *)&buf[0]));
+	data->temperature =
+		hs3001_extract_temperature(be16_to_cpup((__be16 *)&buf[2]));
+
+	return 0;
+}
+
+static umode_t hs3001_is_visible(const void *data, enum hwmon_sensor_types type,
+				 u32 attr, int channel)
+{
+	/* Both, humidity and temperature can only be read. */
+	return 0444;
+}
+
+static int hs3001_read(struct device *dev, enum hwmon_sensor_types type,
+		       u32 attr, int channel, long *val)
+{
+	struct hs3001_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
+	int ret;
+
+	/* Protected section beginn */
+	mutex_lock(&data->i2c_lock);
+	ret = i2c_master_send(client, NULL, 0);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Sensor needs some time to process measurement depending on
+	 * resolution (ref. datasheet)
+	 */
+	fsleep(data->wait_time);
+
+	ret = hs3001_data_fetch_command(client, data);
+	mutex_unlock(&data->i2c_lock);
+	/* Protected section end */
+
+	if (ret < 0)
+		return ret;
+
+	switch (type) {
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_input:
+			*val = data->temperature;
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	case hwmon_humidity:
+		switch (attr) {
+		case hwmon_humidity_input:
+			*val = data->humidity;
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct hwmon_channel_info *hs3001_info[] = {
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
+	HWMON_CHANNEL_INFO(humidity, HWMON_H_INPUT),
+	NULL
+};
+
+static const struct hwmon_ops hs3001_hwmon_ops = {
+	.is_visible = hs3001_is_visible,
+	.read = hs3001_read,
+};
+
+static const struct hwmon_chip_info hs3001_chip_info = {
+	.ops = &hs3001_hwmon_ops,
+	.info = hs3001_info,
+};
+
+/* device ID table */
+static const struct i2c_device_id hs3001_ids[] = {
+	{ "hs3001", 0 },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(i2c, hs3001_ids);
+
+static const struct of_device_id hs3001_of_match[] = {
+	{.compatible = "renesas,hs3001"},
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, hs3001_of_match);
+
+static int hs3001_probe(struct i2c_client *client)
+{
+	struct hs3001_data *data;
+	struct device *hwmon_dev;
+	struct device *dev = &client->dev;
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return -EOPNOTSUPP;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->client = client;
+
+	/*
+	 * Measurement time = wake-up time + measurement time temperature
+	 * + measurment time humidity. This is currently static, because
+	 * enabling programming mode is not supported, yet.
+	 */
+	data->wait_time = (HS3001_WAKEUP_TIME + HS3001_14BIT_RESOLUTION +
+			   HS3001_14BIT_RESOLUTION);
+
+	mutex_init(&data->i2c_lock);
+
+	/* Test access to device */
+	ret = i2c_master_send(client, NULL, 0);
+	if (ret)
+		return ret;
+
+	hwmon_dev = devm_hwmon_device_register_with_info(dev,
+							 client->name,
+							 data,
+							 &hs3001_chip_info,
+							 NULL);
+
+	if (IS_ERR(hwmon_dev))
+		return dev_err_probe(dev, PTR_ERR(hwmon_dev),
+				     "Unable to register hwmon device.\n");
+
+	return 0;
+}
+
+static struct i2c_driver hs3001_i2c_driver = {
+	.driver = {
+		   .name = "hs3001",
+		   .of_match_table = hs3001_of_match,
+	},
+	.probe_new = hs3001_probe,
+	.id_table = hs3001_ids,
+};
+
+module_i2c_driver(hs3001_i2c_driver);
+
+MODULE_AUTHOR("Andre Werner <andre.werner@systec-electronic.com>");
+MODULE_DESCRIPTION("HS3001 humidity and temperature sensor base driver");
+MODULE_LICENSE("GPL");
-- 
2.41.0

