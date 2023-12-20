Return-Path: <linux-kernel+bounces-6148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9206681951B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B64841C2552E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9794FBE0;
	Wed, 20 Dec 2023 00:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqAtc9vO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B0C168CE;
	Wed, 20 Dec 2023 00:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3ba2e03e21cso3493929b6e.0;
        Tue, 19 Dec 2023 16:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703031563; x=1703636363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCAQR0nSmtHfVDJci0iP7649xX5LmFBxv4LCvGHIT0A=;
        b=RqAtc9vOW46y+vMDN+aikDO7mNj6gySdY+xmqrZSo83Hqn7LmXLWbKLc+C8Wqx5xVe
         Oh66lvh3Kj6rG6ynApRLBWXa0TrYfW5Byt/i7G0XhuhHCwRkM+lmMdj9BfXWYrugmJn+
         4K64rb8Xrn5MELh1oWeppEqk85OHroCQTq+FQrCTYMkr+y5REtXjwn0wl3iCEecAeF3l
         UCNld3p/Go0NccPI6XcYG1/yumONf3y8/UH3YapvmVDtcmLZISEPugjE5w++vivMEP2s
         Xm+d6yCXMv66X64kEE1bRRMieMpPXvHBWXp8Ezqi6yEOu30FmdhKZhsIdwlQourpkzyy
         B2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703031563; x=1703636363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCAQR0nSmtHfVDJci0iP7649xX5LmFBxv4LCvGHIT0A=;
        b=qebEVxAFju6kSqIGf8rPCJbrTlSUM6GP1dQmkEfw0vufdCSTKEhtgvhNxdQfuEOzba
         fa5V8jp2G3ighWYpQGRwrrWjFMoTgTxnSKyI0lmoKmyuX8cf+wULKhR+APC5M/AbmSJg
         BkE9eswNZa4rA1NbplakKEghJEc0CoRyHYzvNYeE2KBEq1Hr8Yll17MV87cnKNvtsO7t
         B6Om8tXyny0s0H68H/qEI6IqP0LPHxjwXKqp/YsHVX82CPhjSgXvEkWaG2uSWB1ezWvd
         CnUqU6HHdPWZ8nGcBeoJb1EsjKUVBnroIub34p758VxuFX+WMmo0pQy7L6wGc8FrZ+0F
         0Ibw==
X-Gm-Message-State: AOJu0Yx2o5hBRcSTB8kVvQM3+6ppaZ+AO7Pdrmbuf65MTEjr7ALXr6qw
	dPZw+3dKGlhgVFSWHBqhFpk=
X-Google-Smtp-Source: AGHT+IGDUHGe9PWnOO/Bb3nEq9SUxMWNn7+jy7XZwI+ovi1VCwkE+pTJlEncOzyFWgHLZcokt6bxfw==
X-Received: by 2002:a05:6808:1692:b0:3b8:b063:666d with SMTP id bb18-20020a056808169200b003b8b063666dmr17855816oib.100.1703031563447;
        Tue, 19 Dec 2023 16:19:23 -0800 (PST)
Received: from localhost.localdomain ([174.95.13.129])
        by smtp.gmail.com with ESMTPSA id da14-20020a05621408ce00b0067a276fd8d5sm3814094qvb.54.2023.12.19.16.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 16:19:23 -0800 (PST)
From: Abdel Alkuor <alkuor@gmail.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Abdel Alkuor <alkuor@gmail.com>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v3 2/2] hwmon: (lm75) Add AMS AS6200 temperature sensor
Date: Tue, 19 Dec 2023 19:17:48 -0500
Message-Id: <d0365d67958ec49f2d3f286047a950316c6d025b.1703030297.git.alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <af834e980f57dc11d3e821c074c433cdbc6accc3.1703030297.git.alkuor@gmail.com>
References: <af834e980f57dc11d3e821c074c433cdbc6accc3.1703030297.git.alkuor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

as6200 is a temperature sensor with 0.0625°C resolution and a
range between -40°C to 125°C.

By default, the driver configures as6200 as following:
- Converstion rate: 8 Hz
- Conversion mode: continuous
- Consecutive fault counts: 4 samples
- Alert state: high polarity
- Alert mode: comparator mode

Interrupt is supported for the alert pin.

Datasheet: https://ams.com/documents/20143/36005/AS6200_DS000449_4-00.pdf
Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
---
Changes in v3:
  - Fix format for new added lm75 params
  - Add missing break for hwmon_temp_alarm case in lm75_is_visible
  - Return combined error code and status from lm75_read_config 
  - Revert back to the previous configure setting semantics in lm75_probe
  - When an interrupt is tried to be requested and alarm bit is not supported
    then log an error instead of a warning. Also, remove the unnecessery
    suggestion about chips with no alarm bit.
  - Fix as6200 order in lm75_ids

Changes in v2:
  - Incorporate as6200 into lm75 driver

 Documentation/hwmon/lm75.rst |  10 ++++
 drivers/hwmon/lm75.c         | 108 ++++++++++++++++++++++++++++++-----
 2 files changed, 104 insertions(+), 14 deletions(-)

diff --git a/Documentation/hwmon/lm75.rst b/Documentation/hwmon/lm75.rst
index 8d0ab4ad5fb5..6adab608dd05 100644
--- a/Documentation/hwmon/lm75.rst
+++ b/Documentation/hwmon/lm75.rst
@@ -133,6 +133,16 @@ Supported chips:
 
                https://www.nxp.com/docs/en/data-sheet/PCT2075.pdf
 
+  * AMS OSRAM AS6200
+
+    Prefix: 'as6200'
+
+    Addresses scanned: none
+
+    Datasheet: Publicly available at the AMS website
+
+               https://ams.com/documents/20143/36005/AS6200_DS000449_4-00.pdf
+
 Author: Frodo Looijaard <frodol@dds.nl>
 
 Description
diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 5b2ea05c951e..4add2563b199 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -7,6 +7,7 @@
 
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
@@ -25,6 +26,7 @@
 
 enum lm75_type {		/* keep sorted in alphabetical order */
 	adt75,
+	as6200,
 	at30ts74,
 	ds1775,
 	ds75,
@@ -55,6 +57,7 @@ enum lm75_type {		/* keep sorted in alphabetical order */
 
 /**
  * struct lm75_params - lm75 configuration parameters.
+ * @config_reg_16bits:	Configure register size is 2 bytes.
  * @set_mask:		Bits to set in configuration register when configuring
  *			the chip.
  * @clr_mask:		Bits to clear in configuration register when configuring
@@ -75,17 +78,20 @@ enum lm75_type {		/* keep sorted in alphabetical order */
  * @sample_times:	All the possible sample times to be set. Mandatory if
  *			num_sample_times is larger than 1. If set, number of
  *			entries must match num_sample_times.
+ * @alarm:		Alarm bit is supported.
  */
 
 struct lm75_params {
-	u8			set_mask;
-	u8			clr_mask;
+	bool			config_reg_16bits;
+	u16			set_mask;
+	u16			clr_mask;
 	u8			default_resolution;
 	u8			resolution_limits;
 	const u8		*resolutions;
 	unsigned int		default_sample_time;
 	u8			num_sample_times;
 	const unsigned int	*sample_times;
+	bool			alarm;
 };
 
 /* Addresses scanned */
@@ -104,8 +110,8 @@ struct lm75_data {
 	struct i2c_client		*client;
 	struct regmap			*regmap;
 	struct regulator		*vs;
-	u8				orig_conf;
-	u8				current_conf;
+	u16				orig_conf;
+	u16				current_conf;
 	u8				resolution;	/* In bits, 9 to 16 */
 	unsigned int			sample_time;	/* In ms */
 	enum lm75_type			kind;
@@ -128,6 +134,15 @@ static const struct lm75_params device_params[] = {
 		.default_resolution = 12,
 		.default_sample_time = MSEC_PER_SEC / 10,
 	},
+	[as6200] = {
+		.config_reg_16bits = true,
+		.set_mask = 0x94C0,	/* 8 sample/s, 4 CF, positive polarity */
+		.default_resolution = 12,
+		.default_sample_time = 125,
+		.num_sample_times = 4,
+		.sample_times = (unsigned int []){ 125, 250, 1000, 4000 },
+		.alarm = true,
+	},
 	[at30ts74] = {
 		.set_mask = 3 << 5,	/* 12-bit mode*/
 		.default_resolution = 12,
@@ -317,20 +332,23 @@ static inline long lm75_reg_to_mc(s16 temp, u8 resolution)
 	return ((temp >> (16 - resolution)) * 1000) >> (resolution - 8);
 }
 
-static int lm75_write_config(struct lm75_data *data, u8 set_mask,
-			     u8 clr_mask)
+static int lm75_write_config(struct lm75_data *data, u16 set_mask,
+			     u16 clr_mask)
 {
-	u8 value;
+	unsigned int value;
 
-	clr_mask |= LM75_SHUTDOWN;
+	clr_mask |= LM75_SHUTDOWN << (8 * data->params->config_reg_16bits);
 	value = data->current_conf & ~clr_mask;
 	value |= set_mask;
 
 	if (data->current_conf != value) {
 		s32 err;
-
-		err = i2c_smbus_write_byte_data(data->client, LM75_REG_CONF,
-						value);
+		if (data->params->config_reg_16bits)
+			err = regmap_write(data->regmap, LM75_REG_CONF, value);
+		else
+			err = i2c_smbus_write_byte_data(data->client,
+							LM75_REG_CONF,
+							value);
 		if (err)
 			return err;
 		data->current_conf = value;
@@ -338,6 +356,27 @@ static int lm75_write_config(struct lm75_data *data, u8 set_mask,
 	return 0;
 }
 
+static int lm75_read_config(struct lm75_data *data)
+{
+	int ret;
+	unsigned int status;
+
+	if (data->params->config_reg_16bits) {
+		ret = regmap_read(data->regmap, LM75_REG_CONF, &status);
+		return ret ? ret : status;
+	}
+
+	return i2c_smbus_read_byte_data(data->client, LM75_REG_CONF);
+}
+
+static irqreturn_t lm75_alarm_handler(int irq, void *private)
+{
+	struct device *hwmon_dev = private;
+
+	hwmon_notify_event(hwmon_dev, hwmon_temp, hwmon_temp_alarm, 0);
+	return IRQ_HANDLED;
+}
+
 static int lm75_read(struct device *dev, enum hwmon_sensor_types type,
 		     u32 attr, int channel, long *val)
 {
@@ -366,6 +405,9 @@ static int lm75_read(struct device *dev, enum hwmon_sensor_types type,
 		case hwmon_temp_max_hyst:
 			reg = LM75_REG_HYST;
 			break;
+		case hwmon_temp_alarm:
+			reg = LM75_REG_CONF;
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -373,7 +415,17 @@ static int lm75_read(struct device *dev, enum hwmon_sensor_types type,
 		if (err < 0)
 			return err;
 
-		*val = lm75_reg_to_mc(regval, data->resolution);
+		if (attr == hwmon_temp_alarm) {
+			switch (data->kind) {
+			case as6200:
+				*val = (regval >> 5) & 0x1;
+				break;
+			default:
+				return -EINVAL;
+			}
+		} else {
+			*val = lm75_reg_to_mc(regval, data->resolution);
+		}
 		break;
 	default:
 		return -EINVAL;
@@ -436,6 +488,7 @@ static int lm75_update_interval(struct device *dev, long val)
 			data->resolution = data->params->resolutions[index];
 		break;
 	case tmp112:
+	case as6200:
 		err = regmap_read(data->regmap, LM75_REG_CONF, &reg);
 		if (err < 0)
 			return err;
@@ -503,6 +556,10 @@ static umode_t lm75_is_visible(const void *data, enum hwmon_sensor_types type,
 		case hwmon_temp_max:
 		case hwmon_temp_max_hyst:
 			return 0644;
+		case hwmon_temp_alarm:
+			if (config_data->params->alarm)
+				return 0444;
+			break;
 		}
 		break;
 	default:
@@ -515,7 +572,8 @@ static const struct hwmon_channel_info * const lm75_info[] = {
 	HWMON_CHANNEL_INFO(chip,
 			   HWMON_C_REGISTER_TZ | HWMON_C_UPDATE_INTERVAL),
 	HWMON_CHANNEL_INFO(temp,
-			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST),
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST |
+			   HWMON_T_ALARM),
 	NULL
 };
 
@@ -623,7 +681,7 @@ static int lm75_probe(struct i2c_client *client)
 		return err;
 
 	/* Cache original configuration */
-	status = i2c_smbus_read_byte_data(client, LM75_REG_CONF);
+	status = lm75_read_config(data);
 	if (status < 0) {
 		dev_dbg(dev, "Can't read config? %d\n", status);
 		return status;
@@ -646,6 +704,23 @@ static int lm75_probe(struct i2c_client *client)
 	if (IS_ERR(hwmon_dev))
 		return PTR_ERR(hwmon_dev);
 
+	if (client->irq) {
+		if (data->params->alarm) {
+			err = devm_request_threaded_irq(dev,
+							client->irq,
+							NULL,
+							&lm75_alarm_handler,
+							IRQF_ONESHOT,
+							client->name,
+							hwmon_dev);
+			if (err)
+				return err;
+		} else {
+			 /* alarm is only supported for chips with alarm bit */
+			dev_err(dev, "alarm interrupt is not supported\n");
+		}
+	}
+
 	dev_info(dev, "%s: sensor '%s'\n", dev_name(hwmon_dev), client->name);
 
 	return 0;
@@ -653,6 +728,7 @@ static int lm75_probe(struct i2c_client *client)
 
 static const struct i2c_device_id lm75_ids[] = {
 	{ "adt75", adt75, },
+	{ "as6200", as6200, },
 	{ "at30ts74", at30ts74, },
 	{ "ds1775", ds1775, },
 	{ "ds75", ds75, },
@@ -689,6 +765,10 @@ static const struct of_device_id __maybe_unused lm75_of_match[] = {
 		.compatible = "adi,adt75",
 		.data = (void *)adt75
 	},
+	{
+		.compatible = "ams,as6200",
+		.data = (void *)as6200
+	},
 	{
 		.compatible = "atmel,at30ts74",
 		.data = (void *)at30ts74
-- 
2.34.1


