Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8389757A76
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 13:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbjGRL2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 07:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjGRL2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 07:28:45 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F043710FE;
        Tue, 18 Jul 2023 04:28:42 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 5b1f17b1804b1-3fb4146e8deso57987235e9.0;
        Tue, 18 Jul 2023 04:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689679721; x=1692271721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jodyYJIboGlAv/P2zcpXsk9c6MZ/7Bhfs83Nl+3ElfU=;
        b=CcRb2JRIULjRxa4hrsemwI9sl2eMfoBlB5RNmD4p1TPrXKhGfS04LE8I7uRmrKkfLh
         Cfs7VALqxIfiPCKnBlCkJCqpzRISawiqCNJeQsr0Ri7hKWnacxZkgfxaIQVA3Fjzie5w
         EE9z3E/eIl5nyxDhpIyoJQ4GRNtAPBtzEl+lLGTdyT0eZXLnuTd0ROuHbj1uEK5f50R9
         BO78cDsBQBnvu4hkUhqE5FenH/UHEC1UcfgNR2F0vX/SamHXL/piEuNcrxtxdDwvt0E6
         xK0fvR9UGbRWC6+8JA4upcm7jhZA4WKOB8UCFgWenNSc7oox8vrk+USLrW/ReIiKNsSw
         c5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689679721; x=1692271721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jodyYJIboGlAv/P2zcpXsk9c6MZ/7Bhfs83Nl+3ElfU=;
        b=kVkEx50T75OsFAXch/RUZ8PkLVHeZ0aU+76UT4NvW5DNnpHdrYoqsVFwoiI19f0DZ0
         duN2am3u7cziee9UTq15SeTvAR3WvHDYvdtsaWtqA7DncAw5S4u0UWaHZi+5POUpMHtn
         87pwzfpKPzjqu4rJxDQikuZC74cR1HdJRQ6XqOVARYvIp2cWQsDgXjE89JP7c9vwEw2u
         qkAqcv6ZmxCPk7tQ5hiecaZdV8FifGQh3wf9c4PX2YsBqERo9FrO3RuwkB4evbk7x0ec
         21P2F54EsnCghflLs7S9nEgl8MDvvyHtR+j0B3czHjLcn88CeAMaKNW+AOLvjEpzh27l
         lxTw==
X-Gm-Message-State: ABy/qLZ1Hy6sMwPRHlVyiqS9asVDQ6VAtoGi/ZfEjyyKF8gG+UEVFoGi
        vf+mpyW/hLslogagNVxmpdw=
X-Google-Smtp-Source: APBJJlGDyEJnI5PVdn3p1CknTYTUDFMF7OSrxSyxA0RPQV1l9m2G33eGm3/omvTxmkkiXWTfuQSbiA==
X-Received: by 2002:a1c:6a0a:0:b0:3fa:aeac:e96c with SMTP id f10-20020a1c6a0a000000b003faaeace96cmr1870622wmc.9.1689679720972;
        Tue, 18 Jul 2023 04:28:40 -0700 (PDT)
Received: from ws-565760.systec.local ([212.185.67.148])
        by smtp.gmail.com with ESMTPSA id x12-20020adfec0c000000b003142c85fbcdsm2155433wrn.11.2023.07.18.04.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 04:28:40 -0700 (PDT)
From:   Andre Werner <werneazc@gmail.com>
X-Google-Original-From: Andre Werner <andre.werner@systec-electronic.com>
To:     jdelvare@suse.com, linux@roeck-us.net,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        robh+dt@kernel.org
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andre Werner <andre.werner@systec-electronic.com>
Subject: [PATCH v3 2/2] hwmon: (hs3001) Add driver for Renesas HS3001
Date:   Tue, 18 Jul 2023 13:28:10 +0200
Message-ID: <20230718112810.21322-2-andre.werner@systec-electronic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230718112810.21322-1-andre.werner@systec-electronic.com>
References: <20230718112810.21322-1-andre.werner@systec-electronic.com>
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
 - Correct missunderstanding comments for defines.
 - Delete mutexes for data and I2C bus accesses.
 - Replace attributes with recommented chip-info structure. In the
   initial version I followed the sth3x.c implementation that uses
   files and attributes in sysfs. The show functions are replaced by
   is_visible and read callbacks from the HWMON ABI. I also  delete pointless
   function argument checks.
 - Correct Yoda programming.
 - Refactor probe function and delete sleep and measurement of humidity
   and temperature in probe function. I kept an initial I2C
   communication to ensure that the device is accessible during probe.
 - Reduce the number of atteributes to humidity and temperature input.
 v3: Delete chip data because it is unused.
---
 Documentation/hwmon/hs3001.rst |  37 +++++
 MAINTAINERS                    |   6 +
 drivers/hwmon/Kconfig          |  10 ++
 drivers/hwmon/Makefile         |   1 +
 drivers/hwmon/hs3001.c         | 249 +++++++++++++++++++++++++++++++++
 5 files changed, 303 insertions(+)
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
index 000000000000..162466d35cc2
--- /dev/null
+++ b/drivers/hwmon/hs3001.c
@@ -0,0 +1,249 @@
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
+#define HS3001_WAKEUP_TIME		100		/* us */
+#define HS3001_8BIT_RESOLUTION	550		/* us */
+#define HS3001_10BIT_RESOLUTION	1310	/* us */
+#define HS3001_12BIT_RESOLUTION	4500	/* us */
+#define HS3001_14BIT_RESOLUTION	16900	/* us */
+
+#define HS3001_RESPONSE_LENGTH	4
+
+#define HS3001_FIXPOINT_ARITH	1000
+#define HS3001_MIN_TEMPERATURE	(-40 * HS3001_FIXPOINT_ARITH)	/* milli degree */
+#define HS3001_MAX_TEMPERATURE	(125 * HS3001_FIXPOINT_ARITH)	/* milli degree */
+#define HS3001_MIN_HUMIDITY		(0 * HS3001_FIXPOINT_ARITH)	/* milli percent */
+#define HS3001_MAX_HUMIDITY		(100 * HS3001_FIXPOINT_ARITH)	/* milli percent */
+
+#define HS3001_MASK_HUMIDITY_0X3FFF		0x3FFF
+#define HS3001_MASK_TEMPERATURE_0XFFFC	0xFFFC
+#define HS3001_MASK_STATUS_0XC0			0xC0
+#define HS3001_STATUS_SHIFT				6
+
+/* Definitions for Status Bits of A/D Data */
+#define HS3001_DATA_VALID	0x00	/* Valid Data */
+#define HS3001_DATA_STALE	0x01	/* Stale Data */
+
+#define LIMIT_MAX	0
+#define LIMIT_MIN	1
+
+struct hs3001_data {
+	struct i2c_client *client;
+	u32 wait_time;		/* in us */
+	int temperature;	/* in milli degree */
+	u32 humidity;		/* in milli % */
+};
+
+static int hs3001_extract_temperature(u16 raw)
+{
+	/* fixpoint arithmetic 1 digit */
+	int temp = ((raw & HS3001_MASK_TEMPERATURE_0XFFFC) >> 2) *
+	    HS3001_FIXPOINT_ARITH;
+
+	temp /= (1 << 14) - 1;
+
+	return temp * 165 - 40 * HS3001_FIXPOINT_ARITH;
+}
+
+static u32 hs3001_extract_humidity(u16 raw)
+{
+	int hum = (raw & HS3001_MASK_HUMIDITY_0X3FFF) * HS3001_FIXPOINT_ARITH;
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
+
+	if (ret != HS3001_RESPONSE_LENGTH) {
+		ret = ret < 0 ? ret : -EIO;
+		dev_dbg(&client->dev,
+			"Error in i2c communication. Error code: %d.\n", ret);
+		return ret;
+	}
+
+	hs3001_status = (buf[0] & HS3001_MASK_STATUS_0XC0) >>
+	    HS3001_STATUS_SHIFT;
+	if (hs3001_status == HS3001_DATA_STALE) {
+		dev_dbg(&client->dev, "Sensor busy.\n");
+		return -EBUSY;
+	} else if (hs3001_status != HS3001_DATA_VALID) {
+		dev_dbg(&client->dev, "Data invalid.\n");
+		return -EIO;
+	}
+
+	data->humidity =
+	    hs3001_extract_humidity(be16_to_cpup((__be16 *)&buf[0]));
+	data->temperature =
+	    hs3001_extract_temperature(be16_to_cpup((__be16 *)&buf[2]));
+
+	return 0;
+}
+
+umode_t hs3001_is_visible(const void *data, enum hwmon_sensor_types type,
+			  u32 attr, int channel)
+{
+	/* Both, humidity and temperature can only be read. */
+	return 0444;
+}
+
+int hs3001_read(struct device *dev, enum hwmon_sensor_types type,
+		u32 attr, int channel, long *val)
+{
+	struct hs3001_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
+	int ret;
+
+	ret = i2c_master_send(client, NULL, 0);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Sensor needs some time to process measurement depending on
+	 * resolution
+	 */
+	fsleep(data->wait_time);
+
+	ret = hs3001_data_fetch_command(client, data);
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
+	/* Test access to device */
+	ret = i2c_master_send(client, NULL, 0);
+	if (ret)
+		return ret;
+
+	hwmon_dev = devm_hwmon_device_register_with_info(dev,
+				client->name, data, &hs3001_chip_info, NULL);
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
+MODULE_DESCRIPTION("HS3001 humidity and temperature sensor base  driver");
+MODULE_LICENSE("GPL");
-- 
2.41.0

