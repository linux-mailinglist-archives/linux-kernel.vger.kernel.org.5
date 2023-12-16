Return-Path: <linux-kernel+bounces-2278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFED815A76
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C5A01F2393A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654C930D05;
	Sat, 16 Dec 2023 16:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="em5wJHY6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D4030645;
	Sat, 16 Dec 2023 16:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-77f8308616eso143956085a.2;
        Sat, 16 Dec 2023 08:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702744889; x=1703349689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Etz+ReDYEWzjFjGAW3ei94pJhObROkWL8EBMLBIAVyU=;
        b=em5wJHY6/bnwlvEVstmWsi7M+LxcFe/U7l5zK6idzpFOcYB8BAGINJb+rdXtYNyyrr
         7OV8d+SZrXc0Kgz8q19urYlYYRT7RMCMmCjZzDNiO/jWUTy4ShNSf4oMgBmDUd99NS/M
         sd7N6o+9KAa0jTbpmbzcXbx3i+tmgS954Obz/Zh4HNf9xkcglHLRN6HtwAz3bfhNUWJO
         /6T1PEx0MhNGeq/m5RNRX+0UnxMdGpx5F8bZmZ9RTh27wcJ59tL2kdrw6KJFTDtx4SHW
         c6ElZh45RlY3a6749rGz5y3fTTU+YhASJnLcsrTLIn9dGGJOoAMU92BZrHc5upUNNtFW
         cYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702744889; x=1703349689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Etz+ReDYEWzjFjGAW3ei94pJhObROkWL8EBMLBIAVyU=;
        b=iZMioQ/9YhcZEM9QqjG28toPjzCa7GDYIrbglzocECncCZWnyZHg2e8JeArR/MaI9b
         xkLXw7IqdcL9AT6+ohboS/X3R1m5Jq3R8HCwd0EKONF9Cy949GoF0T+RJwbNtyHekqhK
         0UQhnTT8Yv/FPqFmXv3NwXLOkYTL+wcmMw+HJxsRWUatjRXt8jaK03stC8eEO/SaGYVh
         vy3Bj2htadz9n39/FQqUcIhbMJ/vYG9yVeuAmJMQIjWuCj8XXJr/9ZAvFUfSipX4uSEq
         OzewghEOlXk1AfZ+fPCmlorqmXHO+fGQqbzPZwqLt6v/W5+9VFL1Th079DkYdEQMmYct
         4wnQ==
X-Gm-Message-State: AOJu0Yyg9Dvo0S60tRLuhSlK4sdGn9LQj4aryrY7BYzVT3BBaV3adP5t
	CNQ6eHZWnlJHa6pgCETzf48=
X-Google-Smtp-Source: AGHT+IHNrZzlygMSFO0VlUrDd1kPB8vYZW7b95drewctQoWzcMGyVl9B9/pKcgxUORDsvcajoj86CQ==
X-Received: by 2002:a05:620a:454e:b0:77e:fba3:a20e with SMTP id u14-20020a05620a454e00b0077efba3a20emr19298152qkp.104.1702744888714;
        Sat, 16 Dec 2023 08:41:28 -0800 (PST)
Received: from localhost.localdomain ([174.95.13.129])
        by smtp.gmail.com with ESMTPSA id c1-20020a37e101000000b0077d72f820adsm6861697qkm.115.2023.12.16.08.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 08:41:28 -0800 (PST)
From: Abdel Alkuor <alkuor@gmail.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Abdel Alkuor <alkuor@gmail.com>
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 2/2] hwmon: Add AMS AS6200 temperature sensor
Date: Sat, 16 Dec 2023 11:39:30 -0500
Message-Id: <63e352150ed51eefce90ca4058af5459730174b2.1702744180.git.alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <149032e99136a9fe47c3533b57a71092646e497d.1702744180.git.alkuor@gmail.com>
References: <149032e99136a9fe47c3533b57a71092646e497d.1702744180.git.alkuor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

as6200 is a temperature sensor with 0.0625°C resolution and a range between
-40°C to 125°C.

By default, the driver configures as6200 as following:
- Converstion rate: 8 Hz
- Conversion mode: continuous
- Consecutive fault counts: 6 samples
- Alert state: high polarity
- Alert mode: comparator mode

Interrupt is supported for the alert pin.

Datasheet: https://ams.com/documents/20143/36005/AS6200_DS000449_4-00.pdf
Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
---
 Documentation/hwmon/as6200.rst |  50 +++++++
 drivers/hwmon/Kconfig          |  10 ++
 drivers/hwmon/Makefile         |   1 +
 drivers/hwmon/as6200.c         | 249 +++++++++++++++++++++++++++++++++
 4 files changed, 310 insertions(+)
 create mode 100644 Documentation/hwmon/as6200.rst
 create mode 100644 drivers/hwmon/as6200.c

diff --git a/Documentation/hwmon/as6200.rst b/Documentation/hwmon/as6200.rst
new file mode 100644
index 000000000000..f6156c2105ff
--- /dev/null
+++ b/Documentation/hwmon/as6200.rst
@@ -0,0 +1,50 @@
+Kernel driver as6200
+====================
+
+Supported chips:
+
+  * AMS OSRAM AS6200
+
+    Prefix: 'as6200'
+
+    Addresses scanned: none
+
+    Datasheet: https://ams.com/documents/20143/36005/AS6200_DS000449_4-00.pdf
+
+Author:
+
+	Abdel Alkuor <alkuor@gmail.com>
+
+Description
+-----------
+The AS6200 IC is a temperature sensor with a range between -40°C and 125°C.
+It supports ultra-low power consumption (low operation and quiescent current)
+which makes it ideally suited for mobile/battery powered applications.
+Additionally the AS6200 temperature sensor system also features an alert
+functionality, which triggers an interrupt to protect devices from excessive
+temperatures.
+
+The sensor has an accuracy of ±0.4°C between 0°C and 60°C and has an accuracy
+of 1.0°C from -40°C to +125°C, with Resolution of 0.0625°C. The sensor
+supports conversion rate of 0.25, 1, 4, 8 Hz, and consecutive fault counts of
+1, 2, 4, 6 samples which triggers/clears an alert when high/low temperature
+is detected respectively. Two alert modes are supported, interrupt mode and
+comparator mode.
+
+Configuration Notes
+-------------------
+By default as6200 driver reads the temperature continuously at 8Hz.
+Consecutive faults is set to 6 samples with true polarity which an
+alert is set when the current temperaute goes above high temperature
+theshold and is cleared when it falls below the low temperature threshold.
+Alert is configured in comparator mode.
+
+Interrupt is supported for the alert where user space is notified
+when alert is set/cleared.
+
+sysfs-Interface
+---------------
+temp#_input		 temperature input (read-only)
+temp#_alert              alert flag (read-only)
+temp#_max		 temperature maximum setpoint (read/write)
+temp#_max_hyst		 hysteresis for temperature maximum (read/write)
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index cf27523eed5a..f6edcbf1b7cf 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -287,6 +287,16 @@ config SENSORS_AS370
 	  This driver can also be built as a module. If so, the module
 	  will be called as370-hwmon.
 
+config SENSORS_AS6200
+	tristate "AMS AS6200 temperature sensor"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  If you say yes here you get support for AMS AS6200
+	  temperature sensor.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called as6200.
 
 config SENSORS_ASC7621
 	tristate "Andigilog aSC7621"
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index e84bd9685b5c..11fe2b7a80a9 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_SENSORS_AQUACOMPUTER_D5NEXT) += aquacomputer_d5next.o
 obj-$(CONFIG_SENSORS_ARM_SCMI)	+= scmi-hwmon.o
 obj-$(CONFIG_SENSORS_ARM_SCPI)	+= scpi-hwmon.o
 obj-$(CONFIG_SENSORS_AS370)	+= as370-hwmon.o
+obj-$(CONFIG_SENSORS_AS6200)	+= as6200.o
 obj-$(CONFIG_SENSORS_ASC7621)	+= asc7621.o
 obj-$(CONFIG_SENSORS_ASPEED)	+= aspeed-pwm-tacho.o
 obj-$(CONFIG_SENSORS_ATXP1)	+= atxp1.o
diff --git a/drivers/hwmon/as6200.c b/drivers/hwmon/as6200.c
new file mode 100644
index 000000000000..173f86e48ee1
--- /dev/null
+++ b/drivers/hwmon/as6200.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for AMS AS6200 Temperature sensor
+ *
+ * Author: Abdel Alkuor <alkuor@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#include <linux/hwmon.h>
+
+#define AS6200_TVAL_REG		0x0
+#define AS6200_CONFIG_REG	0x1
+#define AS6200_TLOW_REG		0x2
+#define AS6200_THIGH_REG	0x3
+
+#define AS6200_CONFIG_AL	BIT(5)
+#define AS6200_CONFIG_CR	GENMASK(7, 6)
+#define AS6200_CONFIG_SM	BIT(8)
+#define AS6200_CONFIG_IM	BIT(9)
+#define AS6200_CONFIG_POL	BIT(10)
+#define AS6200_CONFIG_CF	GENMASK(12, 11)
+
+#define AS6200_TEMP_MASK	GENMASK(15, 4)
+#define AS6200_DEFAULT_CONFIG	(AS6200_CONFIG_CR |\
+				 AS6200_CONFIG_CF |\
+				 AS6200_CONFIG_POL)
+
+static const struct regmap_config as6200_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.max_register = AS6200_THIGH_REG,
+};
+
+static irqreturn_t as6200_event_handler(int irq, void *private)
+{
+	struct device *hwmon_dev = private;
+
+	hwmon_notify_event(hwmon_dev, hwmon_temp, hwmon_temp_alarm, 0);
+	return IRQ_HANDLED;
+}
+
+static int as6200_read(struct device *dev, enum hwmon_sensor_types type,
+		       u32 attr, int channel, long *val)
+{
+	struct regmap *regmap = dev_get_drvdata(dev);
+	unsigned int regval;
+	unsigned int reg;
+	s32 temp;
+	int ret;
+
+	switch (attr) {
+	case hwmon_temp_input:
+		reg = AS6200_TVAL_REG;
+		break;
+	case hwmon_temp_max_hyst:
+		reg = AS6200_TLOW_REG;
+		break;
+	case hwmon_temp_max:
+		reg = AS6200_THIGH_REG;
+		break;
+	case hwmon_temp_alarm:
+		reg = AS6200_CONFIG_REG;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	ret = regmap_read(regmap, reg, &regval);
+	if (ret)
+		return ret;
+
+	if (reg == AS6200_CONFIG_REG) {
+		*val = FIELD_GET(AS6200_CONFIG_AL, regval);
+	} else {
+		temp = sign_extend32(FIELD_GET(AS6200_TEMP_MASK, regval), 11);
+		*val = DIV_ROUND_CLOSEST(temp * 625, 10);
+	}
+
+	return 0;
+}
+
+static int as6200_write(struct device *dev, enum hwmon_sensor_types type,
+			u32 attr, int channel, long val)
+{
+	struct regmap *regmap = dev_get_drvdata(dev);
+	int reg;
+
+	switch (attr) {
+	case hwmon_temp_max_hyst:
+		reg = AS6200_TLOW_REG;
+		break;
+	case hwmon_temp_max:
+		reg = AS6200_THIGH_REG;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	val = clamp_val(val, -40000, 125000) * 16 / 1000;
+	return regmap_write(regmap, reg, FIELD_PREP(AS6200_TEMP_MASK, val));
+}
+
+static umode_t as6200_is_visible(const void *data, enum hwmon_sensor_types type,
+				 u32 attr, int channel)
+{
+	if (type != hwmon_temp)
+		return 0;
+
+	switch (attr) {
+	case hwmon_temp_input:
+	case hwmon_temp_alarm:
+		return 0444;
+	case hwmon_temp_max_hyst:
+	case hwmon_temp_max:
+		return 0644;
+	default:
+		return 0;
+	}
+}
+
+static const struct hwmon_ops as6200_hwmon_ops = {
+	.is_visible = as6200_is_visible,
+	.read = as6200_read,
+	.write = as6200_write,
+};
+
+static const struct hwmon_channel_info * const as6200_info[] = {
+	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT | HWMON_T_MAX |
+			   HWMON_T_MAX_HYST | HWMON_T_ALARM),
+	NULL
+};
+
+struct hwmon_chip_info as6200_chip_info = {
+	.ops = &as6200_hwmon_ops,
+	.info = as6200_info
+};
+
+static int as6200_probe(struct i2c_client *client)
+{
+	struct regmap *regmap;
+	struct device *hwmon_dev;
+	struct device *dev = &client->dev;
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return -EINVAL;
+
+	regmap = devm_regmap_init_i2c(client, &as6200_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Could not get and enable regulator %d\n",
+				     ret);
+
+	ret = regmap_write(regmap, AS6200_CONFIG_REG, AS6200_DEFAULT_CONFIG);
+	if (ret)
+		return ret;
+
+	hwmon_dev = devm_hwmon_device_register_with_info(dev, "as6200",
+							 regmap,
+							 &as6200_chip_info,
+							 NULL);
+	if (IS_ERR(hwmon_dev))
+		return PTR_ERR(hwmon_dev);
+
+	if (client->irq) {
+		ret = devm_request_threaded_irq(dev,
+						client->irq,
+						NULL,
+						&as6200_event_handler,
+						IRQF_ONESHOT,
+						client->name,
+						hwmon_dev);
+		if (ret)
+			return ret;
+	}
+
+	i2c_set_clientdata(client, regmap);
+
+	return 0;
+}
+
+static int __maybe_unused as6200_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct regmap *regmap = i2c_get_clientdata(client);
+
+	if (client->irq)
+		disable_irq(client->irq);
+
+	return regmap_update_bits(regmap, AS6200_CONFIG_REG,
+				  AS6200_CONFIG_SM, AS6200_CONFIG_SM);
+}
+
+static int __maybe_unused as6200_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct regmap *regmap = i2c_get_clientdata(client);
+	int ret;
+
+	ret = regmap_update_bits(regmap, AS6200_CONFIG_REG, AS6200_CONFIG_SM, 0);
+	if (ret)
+		return ret;
+
+	if (client->irq)
+		enable_irq(client->irq);
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(as6200_pm_ops, as6200_suspend, as6200_resume);
+
+static const struct i2c_device_id as6200_id_table[] = {
+	{ "as6200", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, as6200_id_table);
+
+static const struct of_device_id as6200_of_match[] = {
+	{ .compatible = "ams,as6200" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, as6200_of_match);
+
+static struct i2c_driver as6200_driver = {
+	.driver = {
+		.name = "as6200",
+		.pm = pm_sleep_ptr(&as6200_pm_ops),
+		.of_match_table = as6200_of_match,
+	},
+	.probe = as6200_probe,
+	.id_table = as6200_id_table,
+};
+module_i2c_driver(as6200_driver);
+
+MODULE_AUTHOR("Abdel Alkuor <alkuor@gmail.com");
+MODULE_DESCRIPTION("AMS AS6200 Temperature Sensor");
+MODULE_LICENSE("GPL");
-- 
2.34.1


