Return-Path: <linux-kernel+bounces-10384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE20081D39C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 11:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76BFF283D3A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 10:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6EDD52B;
	Sat, 23 Dec 2023 10:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fT7QlOi9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1A4D276;
	Sat, 23 Dec 2023 10:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d2e5e8d1dso28570625e9.0;
        Sat, 23 Dec 2023 02:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703328380; x=1703933180; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+YWVx8xpB3+TPTsOi8aWAFVbwfxaLVpgng8SgAFQrGc=;
        b=fT7QlOi9hpEFWnTSk84guHynTDOcXYQSjlOvlSG3XwYH/DOJelFHSVdKnK+w/q82ZU
         CJaKTHpMCKx9AiuOQ4s2/3bNRMEfUbVCGKldnFIv9dKsA46h2CZvtsOf23x3N1rQXDUF
         yyhu4bBSKBrnjMJspWuFjga5Egj5j6IOER/yqPHKMrfgtNfYJDEO/GxGtWJ+jCv4T54C
         FdyaBrTLIcv/0f+nD4CC28hkT+5ZsuCxX7kLzVyrqoK4pa/FRl2u7/cHrVO/mtnD1h/j
         D0GmC1HwGm+e5ZOmKUkmRCeWmM3ihbPlpy+cfjZedz48epCVoGoYSKdAuQIgG8R0pTvI
         OKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703328380; x=1703933180;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+YWVx8xpB3+TPTsOi8aWAFVbwfxaLVpgng8SgAFQrGc=;
        b=tSkU/LwMsY6ViNYMe3oNi++odh+r2JOE8uqK1nxSYzUUcT6SANCeaaxOBqLZ4LHOlu
         jJalsmoO8U8GLq+1pF6WEva7ADEmeFYCG7ViZTuHg5un+VRHCpOgyAkZlYCXThcrbLRW
         g5jUWcKY/Rd2bUPkN2oScMJxO5mQxRm06yY8DSm3mzzZfhg7fSAa0hd/4ek3UP5g+sFH
         fEaW6uankEY5tRmp5MMvTzN0z2oKENVFiFZF2mpS1sJwfuqUrUfcf/SUwEgYH7nAqXMt
         W8EdEftyHSVWRfHc6zNNilUtmY7GN8t0g1QpNN4N/H6h5WtVXlhLjG/65Z5V/TkQEC07
         NRIQ==
X-Gm-Message-State: AOJu0YyVCWw+vRjeF6200XRbBZmFp/iuBX9e8zqm4+3umexccggxW/OK
	dBFPo5bR0mETxoAKgIAZVe4=
X-Google-Smtp-Source: AGHT+IFSlOdBtGs25jwiBCJuDHgvGc8zuqOFQC91Txy6uHDgmvqeSFP+rsBKyInXQ9PAZK4zxwHCDg==
X-Received: by 2002:a05:600c:a083:b0:40d:5021:a0e2 with SMTP id jh3-20020a05600ca08300b0040d5021a0e2mr215509wmb.155.1703328379876;
        Sat, 23 Dec 2023 02:46:19 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-a224-d056-3f15-a90a.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:a224:d056:3f15:a90a])
        by smtp.gmail.com with ESMTPSA id fc13-20020a05600c524d00b0040b3867a297sm10045373wmb.36.2023.12.23.02.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 02:46:18 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sat, 23 Dec 2023 11:46:14 +0100
Subject: [PATCH 2/2] io: light: as73211: add support for as7331
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231220-as7331-v1-2-745b73c27703@gmail.com>
References: <20231220-as7331-v1-0-745b73c27703@gmail.com>
In-Reply-To: <20231220-as7331-v1-0-745b73c27703@gmail.com>
To: Christian Eggers <ceggers@arri.de>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703328374; l=10233;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=bnJony0VY1gcC2o7SUZ6m952bpRKxMqDwQqyUPGy/Kw=;
 b=dlBuNrnznbzlvwnMpMtFzaA08hMn/TJE8CiBRWNJqti/dlSjay59aM27Us0j6/6H+snih0jQt
 Yi1fuqrhSggCG++e31DmwQW0XUNDR4SrNwT4CN9UjxOYhUnDbk5QIuO
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
datasheet (nW/cm^2) because no additional upscaling is required to work
with integers as opposed to the scale values for the AS73211. Actually
if the same upscaling is used, their values will not fit in 4-byte
integers without affecting its sign.

Instead, the AS7331-specific function to retrieve the intensity scales
returns decimal values as listed in the datasheet for every
combination of GAIN and Nclk, keeping the unit as nW/cm^2.
To achieve that, a fractional value is returned.
The AS73211 scales use nW/m^2 units to work with integers that fit in
a 4-byte integer, and in that case there is no need to modify the value
type.

Add a new device-specific data structure to account for the device
differences: channel types and scale of LSB per channel.

[1] https://ams.com/documents/20143/9106314/AS7331_DS001047_4-00.pdf

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/Kconfig   |   5 +-
 drivers/iio/light/as73211.c | 146 ++++++++++++++++++++++++++++++++++++--------
 2 files changed, 122 insertions(+), 29 deletions(-)

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
index ec97a3a46839..d53a0ae5255a 100644
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
@@ -316,6 +361,50 @@ static int as73211_req_data(struct as73211_data *data)
 	return 0;
 }
 
+static int as73211_intensity_scale(struct as73211_data *data, int chan, int *val, int *val2)
+{
+	unsigned int scale;
+
+	switch (chan) {
+	case IIO_MOD_X:
+		scale = AS73211_SCALE_X;
+		break;
+	case IIO_MOD_Y:
+		scale = AS73211_SCALE_Y;
+		break;
+	case IIO_MOD_Z:
+		scale = AS73211_SCALE_Z;
+		break;
+	default:
+		return -EINVAL;
+	}
+	scale /= as73211_gain(data);
+	scale /= as73211_integration_time_1024cyc(data);
+	*val = scale;
+
+	return IIO_VAL_INT;
+}
+
+static int as7331_intensity_scale(struct as73211_data *data, int chan, int *val, int *val2)
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
+	*val2 = as73211_gain(data) * as73211_integration_time_1024cyc(data);
+
+	return IIO_VAL_FRACTIONAL;
+}
+
 static int as73211_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
 			     int *val, int *val2, long mask)
 {
@@ -355,30 +444,12 @@ static int as73211_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec cons
 			*val2 = AS73211_SCALE_TEMP_MICRO;
 			return IIO_VAL_INT_PLUS_MICRO;
 
-		case IIO_INTENSITY: {
-			unsigned int scale;
-
-			switch (chan->channel2) {
-			case IIO_MOD_X:
-				scale = AS73211_SCALE_X;
-				break;
-			case IIO_MOD_Y:
-				scale = AS73211_SCALE_Y;
-				break;
-			case IIO_MOD_Z:
-				scale = AS73211_SCALE_Z;
-				break;
-			default:
-				return -EINVAL;
-			}
-			scale /= as73211_gain(data);
-			scale /= as73211_integration_time_1024cyc(data);
-			*val = scale;
-			return IIO_VAL_INT;
+		case IIO_INTENSITY:
+			return data->spec_dev->intensity_scale(data, chan->channel2, val, val2);
 
 		default:
 			return -EINVAL;
-		}}
+		}
 
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		/* f_samp is configured in CREG3 in powers of 2 (x 1.024 MHz) */
@@ -676,13 +747,20 @@ static int as73211_probe(struct i2c_client *client)
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
 
+	if (dev_fwnode(dev))
+		data->spec_dev = device_get_match_data(dev);
+	else
+		data->spec_dev = i2c_get_match_data(client);
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
@@ -772,14 +850,28 @@ static int as73211_resume(struct device *dev)
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


