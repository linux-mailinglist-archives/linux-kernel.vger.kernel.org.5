Return-Path: <linux-kernel+bounces-15493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC94822CB9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A669B1F240D3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80341199AE;
	Wed,  3 Jan 2024 12:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEk0Oag4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC0E19456;
	Wed,  3 Jan 2024 12:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40d3352b525so113804175e9.1;
        Wed, 03 Jan 2024 04:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704283749; x=1704888549; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mQ7sYvZt+Hf2d2qr73Yb6Uv+J9M3D9ss9N8ljtt/mVM=;
        b=hEk0Oag4LYpOyuOA3Qg9U2jq2kdmta+aQLWmDPb3yvKRN/5V8L26Z4MRa9RJfS70UE
         RyQMwg7kJFLsIy6wZW5Uz0tq9acWqYTQ9GH75rPp/Wr7ZvRhjJcRcSmpypk2+syxrlG7
         M5fwzwvBh1QdbUM436K6ivyHiKXD22Szyx/x35XD5KzYOhuXha0g5uaJqPEx99g/xfWW
         m8rNpoH/StSJHgjk1mr/izA5me1fG9cTUUNB1k9X72UuqhzvgjR1LOUuCOdeIj/iV1qR
         8as0yBdFJATejfvsNt5yafKOGxpdSurmE0xUhgqC4/v8o61AT5sWXoQmS+ho1od9FJ6v
         WWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704283749; x=1704888549;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQ7sYvZt+Hf2d2qr73Yb6Uv+J9M3D9ss9N8ljtt/mVM=;
        b=KdGVpG2M/Q/gfJG36imtf73d9h1tvbdY8YwgCpuwM/scYQ4h+oduKmlvNM2A9wljf9
         EUIF45DrAmfC6oK21i4n6b8ODRJvUDRu5HLOjsAUS6F5Ibrme+QEbLkTgKxQUjtWAdyw
         65rx3MBy0wusPA7M71HjL7bieaDJh3cF/wS7ecPTtcNcdmcvASxn3Mz5aTuWZDmuSLDJ
         mdoyLYehiNl1Gyf9cdFhIZ+sZrw0tfGI8v1hGpYEVpuVNzE371yWv6u0TpP/clwEQy5G
         PdPORrABgphXFid84WgkFZyMecNOV7j8l2DtMR1zRwWoYON5v5qCtLrnTC7ingkybFLE
         m9kQ==
X-Gm-Message-State: AOJu0Yw3/nhhycv0rCylJYLuUg0SJP/sSOnnS9TeOL3WwnyRUnLMm4H3
	MJl9EnDTDjrS+ApcDOhD9lq0WORL+B8Cwwd2
X-Google-Smtp-Source: AGHT+IFZnKN+CxFoHVbo18LPs+6QA5wqNG75V6dA+/qhvPjlY3lU4zQBH0faDrcAdWpbwx6vSl7cBA==
X-Received: by 2002:a05:600c:3115:b0:40d:8919:d1df with SMTP id g21-20020a05600c311500b0040d8919d1dfmr2111442wmo.163.1704283748824;
        Wed, 03 Jan 2024 04:09:08 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-1a90-a88c-d3fe-4285.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:1a90:a88c:d3fe:4285])
        by smtp.gmail.com with ESMTPSA id o28-20020a05600c511c00b0040b37f1079dsm2106443wms.29.2024.01.03.04.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 04:09:08 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 03 Jan 2024 13:08:53 +0100
Subject: [PATCH v2 3/3] iio: light: as73211: add support for as7331
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-as7331-v2-3-6f0ad05e0482@gmail.com>
References: <20240103-as7331-v2-0-6f0ad05e0482@gmail.com>
In-Reply-To: <20240103-as7331-v2-0-6f0ad05e0482@gmail.com>
To: Christian Eggers <ceggers@arri.de>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704283743; l=9566;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=C+/+kQ2C27ds2UC68SS96vr1DGcfshe3A9AsxHtV6EI=;
 b=8VybhJeoxFmQMEye7wYzm6Xtg9CnjnCLtkEor8oxCKcfT6tEcKrpgib3sXAMxVnC+bkpdIaI7
 OrqV8cmMlZ3CWKoGnX5cTmPm/jD4Qrkrg0ykDmt1Hg29xOiqGnQPqUJ
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

The AMS AS7331 is a UV light sensor with three channels: UVA, UVB and
UVC (also known as deep UV and referenced as DUV in the iio core).
Its internal structure and forming blocks are practically identical to
the ones the AS73211 contains: API, internal DAC, I2C interface and
registers, measurement modes, number of channels and pinout.

The only difference between them is the photodiodes used to acquire
light, which means that only some modifications are required to add
support for the AS7331 in the existing driver.

The temperature channel is identical for both devices and only the
channel modifiers of the IIO_INTENSITY channels need to account for the
device type.

The scale values have been obtained from the chapter "7.5 Transfer
Function" of the official datasheet[1] for the configuration chosen as
basis (Nclk = 1024 and GAIN = 1). Those values keep the units from the
datasheet (nW/cm^2), as opposed to the units used for the AS73211
(nW/m^2).

Add a new device-specific data structure to account for the device
differences: channel types and scale of LSB per channel.

[1] https://ams.com/documents/20143/9106314/AS7331_DS001047_4-00.pdf

Tested-by: Christian Eggers <ceggers@arri.de>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/Kconfig   |   5 +-
 drivers/iio/light/as73211.c | 141 ++++++++++++++++++++++++++++++++++++--------
 2 files changed, 118 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 143003232d1c..fd5a9879a582 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -87,13 +87,14 @@ config APDS9960
 	  module will be called apds9960
 
 config AS73211
-	tristate "AMS AS73211 XYZ color sensor"
+	tristate "AMS AS73211 XYZ color sensor and AMS AS7331 UV sensor"
 	depends on I2C
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
 	 If you say yes here you get support for the AMS AS73211
-	 JENCOLOR(R) Digital XYZ Sensor.
+	 JENCOLOR(R) Digital XYZ and the AMS AS7331 UVA, UVB and UVC
+	 ultraviolet sensors.
 
 	 For triggered measurements, you will need an additional trigger driver
 	 like IIO_HRTIMER_TRIGGER or IIO_SYSFS_TRIGGER.
diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
index b4c6f389a292..44daf816ae57 100644
--- a/drivers/iio/light/as73211.c
+++ b/drivers/iio/light/as73211.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Support for AMS AS73211 JENCOLOR(R) Digital XYZ Sensor
+ * Support for AMS AS73211 JENCOLOR(R) Digital XYZ Sensor and AMS AS7331
+ * UVA, UVB and UVC (DUV) Ultraviolet Sensor
  *
  * Author: Christian Eggers <ceggers@arri.de>
  *
@@ -9,7 +10,9 @@
  * Color light sensor with 16-bit channels for x, y, z and temperature);
  * 7-bit I2C slave address 0x74 .. 0x77.
  *
- * Datasheet: https://ams.com/documents/20143/36005/AS73211_DS000556_3-01.pdf
+ * Datasheets:
+ * AS73211: https://ams.com/documents/20143/36005/AS73211_DS000556_3-01.pdf
+ * AS7331: https://ams.com/documents/20143/9106314/AS7331_DS001047_4-00.pdf
  */
 
 #include <linux/bitfield.h>
@@ -84,6 +87,20 @@ static const int as73211_hardwaregain_avail[] = {
 	1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048,
 };
 
+struct as73211_data;
+
+/**
+ * struct spec_dev_data - device-specific data
+ * @intensity_scale:  Function to retrieve intensity scale values.
+ * @channel:          Device channels.
+ * @num_channels:     Number of channels of the device.
+ */
+struct spec_dev_data {
+	int (*intensity_scale)(struct as73211_data *data, int chan, int *val, int *val2);
+	struct iio_chan_spec const *channel;
+	int num_channels;
+};
+
 /**
  * struct as73211_data - Instance data for one AS73211
  * @client: I2C client.
@@ -94,6 +111,7 @@ static const int as73211_hardwaregain_avail[] = {
  * @mutex:  Keeps cached registers in sync with the device.
  * @completion: Completion to wait for interrupt.
  * @int_time_avail: Available integration times (depend on sampling frequency).
+ * @spec_dev: device-specific configuration.
  */
 struct as73211_data {
 	struct i2c_client *client;
@@ -104,6 +122,7 @@ struct as73211_data {
 	struct mutex mutex;
 	struct completion completion;
 	int int_time_avail[AS73211_SAMPLE_TIME_NUM * 2];
+	const struct spec_dev_data *spec_dev;
 };
 
 #define AS73211_COLOR_CHANNEL(_color, _si, _addr) { \
@@ -138,6 +157,10 @@ struct as73211_data {
 #define AS73211_SCALE_Y 298384270  /* nW/m^2 */
 #define AS73211_SCALE_Z 160241927  /* nW/m^2 */
 
+#define AS7331_SCALE_UVA 340000  /* nW/cm^2 */
+#define AS7331_SCALE_UVB 378000  /* nW/cm^2 */
+#define AS7331_SCALE_UVC 166000  /* nW/cm^2 */
+
 /* Channel order MUST match devices result register order */
 #define AS73211_SCAN_INDEX_TEMP 0
 #define AS73211_SCAN_INDEX_X    1
@@ -176,6 +199,28 @@ static const struct iio_chan_spec as73211_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(AS73211_SCAN_INDEX_TS),
 };
 
+static const struct iio_chan_spec as7331_channels[] = {
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate =
+			BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_OFFSET) |
+			BIT(IIO_CHAN_INFO_SCALE),
+		.address = AS73211_OUT_TEMP,
+		.scan_index = AS73211_SCAN_INDEX_TEMP,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_LE,
+		}
+	},
+	AS73211_COLOR_CHANNEL(LIGHT_UVA, AS73211_SCAN_INDEX_X, AS73211_OUT_MRES1),
+	AS73211_COLOR_CHANNEL(LIGHT_UVB, AS73211_SCAN_INDEX_Y, AS73211_OUT_MRES2),
+	AS73211_COLOR_CHANNEL(LIGHT_DUV, AS73211_SCAN_INDEX_Z, AS73211_OUT_MRES3),
+	IIO_CHAN_SOFT_TIMESTAMP(AS73211_SCAN_INDEX_TS),
+};
+
 static unsigned int as73211_integration_time_1024cyc(struct as73211_data *data)
 {
 	/*
@@ -316,6 +361,48 @@ static int as73211_req_data(struct as73211_data *data)
 	return 0;
 }
 
+static int as73211_intensity_scale(struct as73211_data *data, int chan,
+				   int *val, int *val2)
+{
+	switch (chan) {
+	case IIO_MOD_X:
+		*val = AS73211_SCALE_X;
+		break;
+	case IIO_MOD_Y:
+		*val = AS73211_SCALE_Y;
+		break;
+	case IIO_MOD_Z:
+		*val = AS73211_SCALE_Z;
+		break;
+	default:
+		return -EINVAL;
+	}
+	*val2 = as73211_integration_time_1024cyc(data) * as73211_gain(data);
+
+	return IIO_VAL_FRACTIONAL;
+}
+
+static int as7331_intensity_scale(struct as73211_data *data, int chan,
+				  int *val, int *val2)
+{
+	switch (chan) {
+	case IIO_MOD_LIGHT_UVA:
+		*val = AS7331_SCALE_UVA;
+		break;
+	case IIO_MOD_LIGHT_UVB:
+		*val = AS7331_SCALE_UVB;
+		break;
+	case IIO_MOD_LIGHT_DUV:
+		*val = AS7331_SCALE_UVC;
+		break;
+	default:
+		return -EINVAL;
+	}
+	*val2 = as73211_integration_time_1024cyc(data) * as73211_gain(data);
+
+	return IIO_VAL_FRACTIONAL;
+}
+
 static int as73211_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
 			     int *val, int *val2, long mask)
 {
@@ -355,29 +442,13 @@ static int as73211_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec cons
 			*val2 = AS73211_SCALE_TEMP_MICRO;
 			return IIO_VAL_INT_PLUS_MICRO;
 
-		case IIO_INTENSITY: {
-
-			switch (chan->channel2) {
-			case IIO_MOD_X:
-				*val = AS73211_SCALE_X;
-				break;
-			case IIO_MOD_Y:
-				*val = AS73211_SCALE_Y;
-				break;
-			case IIO_MOD_Z:
-				*val = AS73211_SCALE_Z;
-				break;
-			default:
-				return -EINVAL;
-			}
-			*val2 = as73211_integration_time_1024cyc(data) *
-				as73211_gain(data);
-
-			return IIO_VAL_FRACTIONAL;
+		case IIO_INTENSITY:
+			return data->spec_dev->intensity_scale(data, chan->channel2,
+							       val, val2);
 
 		default:
 			return -EINVAL;
-		}}
+		}
 
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		/* f_samp is configured in CREG3 in powers of 2 (x 1.024 MHz) */
@@ -675,13 +746,17 @@ static int as73211_probe(struct i2c_client *client)
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
 
+	data->spec_dev = i2c_get_match_data(client);
+	if (!data->spec_dev)
+		return -EINVAL;
+
 	mutex_init(&data->mutex);
 	init_completion(&data->completion);
 
 	indio_dev->info = &as73211_info;
 	indio_dev->name = AS73211_DRV_NAME;
-	indio_dev->channels = as73211_channels;
-	indio_dev->num_channels = ARRAY_SIZE(as73211_channels);
+	indio_dev->channels = data->spec_dev->channel;
+	indio_dev->num_channels = data->spec_dev->num_channels;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = i2c_smbus_read_byte_data(data->client, AS73211_REG_OSR);
@@ -771,14 +846,28 @@ static int as73211_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(as73211_pm_ops, as73211_suspend,
 				as73211_resume);
 
+static const struct spec_dev_data as73211_spec = {
+	.intensity_scale = as73211_intensity_scale,
+	.channel = as73211_channels,
+	.num_channels = ARRAY_SIZE(as73211_channels),
+};
+
+static const struct spec_dev_data as7331_spec = {
+	.intensity_scale = as7331_intensity_scale,
+	.channel = as7331_channels,
+	.num_channels = ARRAY_SIZE(as7331_channels),
+};
+
 static const struct of_device_id as73211_of_match[] = {
-	{ .compatible = "ams,as73211" },
+	{ .compatible = "ams,as73211", &as73211_spec },
+	{ .compatible = "ams,as7331", &as7331_spec },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, as73211_of_match);
 
 static const struct i2c_device_id as73211_id[] = {
-	{ "as73211", 0 },
+	{ "as73211", (kernel_ulong_t)&as73211_spec },
+	{ "as7331", (kernel_ulong_t)&as7331_spec },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, as73211_id);

-- 
2.39.2


