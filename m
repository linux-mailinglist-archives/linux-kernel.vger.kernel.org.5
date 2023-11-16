Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEFF7EE0EB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 13:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345169AbjKPMy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 07:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344966AbjKPMy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 07:54:57 -0500
Received: from mail-oa1-x43.google.com (mail-oa1-x43.google.com [IPv6:2001:4860:4864:20::43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65EA193;
        Thu, 16 Nov 2023 04:54:53 -0800 (PST)
Received: by mail-oa1-x43.google.com with SMTP id 586e51a60fabf-1f4e17c1edfso363816fac.0;
        Thu, 16 Nov 2023 04:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700139293; x=1700744093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mFAey1C9h9PS+NKMUCsuXi9TIL0A3GhPL0q3RW7hQNo=;
        b=ItWlN6YLXiQqvluEfjtkwGa387lD+39305kCjvq8G+iQVnra+gl0tUDApgdQboSLu6
         haCb1mEhGU7HFUg9VPJt8OqzPvhWmhd3TrdiaLy0rHxW7/NtsLuRD9d1WzGQszPzfFJ1
         kV1Ht/HpCiQSwDZgQbiz9l0eN8JNvgXr4nllvkh12o7wKa+Ea4n+jBRejlRzl0EVq7kx
         btEEWZ1E4hbGCl4C0IHxXW411dO15WMdhrUh4UjIL95awwGN0Iis+n2GcLLPr7XCuR6G
         0dK8GI1VsYi5yfNRRXqJnlJLHu7tlbtfmXmTzEDnYPR4kG/5kH9bTm4MK8jqED2mY+Em
         bdcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700139293; x=1700744093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mFAey1C9h9PS+NKMUCsuXi9TIL0A3GhPL0q3RW7hQNo=;
        b=Zd9m4iq72W7NRomIXqm/vF16H5DG8IYdPeJ6n3ucQ5D+QvOSoDZm4zNbz5OPfyh6Qn
         qdCwvSI8+GDUAt3xj7nWNpyKlVUZ21nXtsV4o4sibPvbptmS3wvZEwiksdhNT+2nRfcS
         Ssezo05UxhbJdRoIIjVZ/WZ9xjXbT+kQSgyoopJpYdc3zySxqx9P4YhOm2Slxszzqjsl
         z5E04Fjl7A86po5lHneWv6qrOgKc9FyDyOIdbZB1Gk+5Xz3beSI0mVgCW5Id5UUE0fjP
         cCRHm8Z4J2LIyoc6m56hjjvKKi5BQZ1kUdRGdmnMznSgpy7hLu6uvwzdoJ6BziqDjcY6
         afLQ==
X-Gm-Message-State: AOJu0YzaVkC+WtaMi75aj0zAtXXDX/Dh4Z1FQZ1LWWNMXVPXCRQZhJOK
        ROIxEg0i6BbsQFtuvsCrm9Q=
X-Google-Smtp-Source: AGHT+IFhgBn0A+cn9W376rcJG9Vv6UYxV8agu6OvusRiQjXhunjjXw0maZviRGQKkwmm0pofgPafew==
X-Received: by 2002:a05:6870:4994:b0:1e9:c224:bb91 with SMTP id ho20-20020a056870499400b001e9c224bb91mr20111075oab.38.1700139292810;
        Thu, 16 Nov 2023 04:54:52 -0800 (PST)
Received: from dawn-virtual-machine.localdomain ([183.198.111.40])
        by smtp.gmail.com with ESMTPSA id k20-20020a635614000000b005b9288d51f0sm2805548pgb.48.2023.11.16.04.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 04:54:52 -0800 (PST)
From:   Li peiyu <579lpy@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li peiyu <579lpy@gmail.com>
Subject: [PATCH [1/2]] iio: humidity: Add driver for ti HDC302x humidity sensors
Date:   Thu, 16 Nov 2023 20:54:32 +0800
Message-Id: <20231116125433.13285-1-579lpy@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for HDC302x integrated capacitive based relative
humidity (RH) and temperature sensor.
This driver supports reading values, reading the maximum and
minimum of values and controlling the integrated heater of
the sensor.

Signed-off-by: Li peiyu <579lpy@gmail.com>
---
 drivers/iio/humidity/Kconfig   |  11 +
 drivers/iio/humidity/Makefile  |   1 +
 drivers/iio/humidity/hdc3020.c | 481 +++++++++++++++++++++++++++++++++
 3 files changed, 493 insertions(+)
 create mode 100644 drivers/iio/humidity/hdc3020.c

diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
index 2de5494e7c22..7b585bc7db9a 100644
--- a/drivers/iio/humidity/Kconfig
+++ b/drivers/iio/humidity/Kconfig
@@ -48,6 +48,17 @@ config HDC2010
 	  To compile this driver as a module, choose M here: the module
 	  will be called hdc2010.
 
+config HDC3020
+	tristate "TI HDC3020 relative humidity and temperature sensor"
+	depends on I2C
+	help
+	  Say yes here to build support for the Texas Instruments
+	  HDC3020,HDC3021 and HDC3022 relative humidity and temperature
+	  sensors.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called hdc3020.
+
 config HID_SENSOR_HUMIDITY
 	tristate "HID Environmental humidity sensor"
 	depends on HID_SENSOR_HUB
diff --git a/drivers/iio/humidity/Makefile b/drivers/iio/humidity/Makefile
index f19ff3de97c5..5fbeef299f61 100644
--- a/drivers/iio/humidity/Makefile
+++ b/drivers/iio/humidity/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_AM2315) += am2315.o
 obj-$(CONFIG_DHT11) += dht11.o
 obj-$(CONFIG_HDC100X) += hdc100x.o
 obj-$(CONFIG_HDC2010) += hdc2010.o
+obj-$(CONFIG_HDC3020) += hdc3020.o
 obj-$(CONFIG_HID_SENSOR_HUMIDITY) += hid-sensor-humidity.o
 
 hts221-y := hts221_core.o \
diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc3020.c
new file mode 100644
index 000000000000..a61f2358340f
--- /dev/null
+++ b/drivers/iio/humidity/hdc3020.c
@@ -0,0 +1,481 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * hdc3020.c - Support for the TI HDC3020,HDC3021 and HDC3022
+ * temperature + relative humidity sensors
+ *
+ * Copyright (C) 2023
+ *
+ * Datasheet: https://www.ti.com/lit/ds/symlink/hdc3020.pdf
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+#define READ_RETRY_TIMES 10
+#define BUSY_DELAY 10
+
+const u8 HDC3020_S_AUTO_10HZ_MOD0[2] = { 0x27, 0x37 };
+
+const u8 HDC3020_EXIT_AUTO[2] = { 0x30, 0x93 };
+
+const u8 HDC3020_R_T_RH_AUTO[2] = { 0xE0, 0x00 };
+const u8 HDC3020_R_T_LOW_AUTO[2] = { 0xE0, 0x02 };
+const u8 HDC3020_R_T_HIGH_AUTO[2] = { 0xE0, 0x03 };
+const u8 HDC3020_R_RH_LOW_AUTO[2] = { 0xE0, 0x04 };
+const u8 HDC3020_R_RH_HIGH_AUTO[2] = { 0xE0, 0x05 };
+
+const u8 HDC3020_ENABLE_HEATER[2] = { 0x30, 0x6D };
+const u8 HDC3020_DISABLE_HEATER[2] = { 0x30, 0x66 };
+
+const u8 HDC3020_HEATER_FULL[5] = { 0x30, 0x6E, 0x3F, 0xFF, 0x06 };
+const u8 HDC3020_HEATER_HALF[5] = { 0x30, 0x6E, 0x03, 0xFF, 0x00 };
+const u8 HDC3020_HEATER_QUARTER[5] = { 0x30, 0x6E, 0x00, 0x9F, 0x96 };
+
+struct hdc3020_data {
+	struct i2c_client *client;
+	struct mutex lock;
+
+	int temp;
+	int humidity;
+	int temp_high_peak;
+	int temp_low_peak;
+	int humidity_high_peak;
+	int humidity_low_peak;
+};
+
+/*
+ * For heater
+ * 0 -> turn off
+ * 1 -> 1/4 full power
+ * 2 -> 1/2 full power
+ * 3 -> full power
+ */
+static IIO_CONST_ATTR(out_current_heater_raw_available, "0 1 2 3");
+
+static struct attribute *hdc3020_attributes[] = {
+	&iio_const_attr_out_current_heater_raw_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group hdc3020_attribute_group = {
+	.attrs = hdc3020_attributes,
+};
+
+static const struct iio_chan_spec hdc3020_channels[] = {
+	{
+	 .type = IIO_TEMP,
+	 .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+	 BIT(IIO_CHAN_INFO_SCALE),
+	  },
+	{
+	 .type = IIO_TEMP,
+	 .info_mask_separate = BIT(IIO_CHAN_INFO_PEAK),
+	 .extend_name = "high",
+	  },
+	{
+	 .type = IIO_TEMP,
+	 .info_mask_separate = BIT(IIO_CHAN_INFO_PEAK),
+	 .extend_name = "low",
+	  },
+	{
+	 .type = IIO_HUMIDITYRELATIVE,
+	 .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+	 BIT(IIO_CHAN_INFO_SCALE),
+	  },
+	{
+	 .type = IIO_HUMIDITYRELATIVE,
+	 .info_mask_separate = BIT(IIO_CHAN_INFO_PEAK),
+	 .extend_name = "high",
+	  },
+	{
+	 .type = IIO_HUMIDITYRELATIVE,
+	 .info_mask_separate = BIT(IIO_CHAN_INFO_PEAK),
+	 .extend_name = "low",
+	  },
+	{
+	 .type = IIO_CURRENT,
+	 .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+	 .extend_name = "heater",
+	 .output = 1,
+	  },
+};
+
+static int hdc3020_write_bytes(struct hdc3020_data *data, const u8 *buf,
+			       u8 len)
+{
+	int ret, cnt;
+	struct i2c_msg msg;
+	struct i2c_client *client = data->client;
+
+	msg.addr = client->addr;
+	msg.flags = 0;
+	msg.buf = (char *)buf;
+	msg.len = len;
+
+	/*
+	 * During the measurement process, HDC3020 will not return data.
+	 * So wait for a while and try again
+	 */
+	ret = 0;
+	cnt = 0;
+
+	while (cnt < READ_RETRY_TIMES) {
+		ret = i2c_transfer(client->adapter, &msg, 1);
+		if (ret == 1) {
+			ret = 0;
+			break;
+		}
+
+		mdelay(BUSY_DELAY);
+		cnt++;
+	}
+	if (cnt == READ_RETRY_TIMES) {
+		dev_err(&client->dev, "Could not write sensor command\n");
+		ret = -EREMOTEIO;
+	}
+
+	return ret;
+}
+
+static int hdc3020_read_bytes(struct hdc3020_data *data, const u8 *buf,
+			      void *val, int len)
+{
+	int ret, cnt;
+	struct i2c_msg msg[2];
+	struct i2c_client *client = data->client;
+
+	msg[0].addr = client->addr;
+	msg[0].flags = 0;
+	msg[0].buf = (char *)buf;
+	msg[0].len = 2;
+
+	msg[1].addr = client->addr;
+	msg[1].flags = I2C_M_RD;
+	msg[1].buf = val;
+	msg[1].len = len;
+
+	/*
+	 * During the measurement process, HDC3020 will not return data.
+	 * So wait for a while and try again
+	 */
+	ret = 0;
+	cnt = 0;
+
+	while (cnt < READ_RETRY_TIMES) {
+		ret = i2c_transfer(client->adapter, msg, 2);
+		if (ret == 2) {
+			ret = 0;
+			break;
+		}
+		mdelay(BUSY_DELAY);
+		cnt++;
+	}
+
+	if (cnt == READ_RETRY_TIMES) {
+		dev_err(&client->dev, "Could not read sensor data\n");
+		ret = -EREMOTEIO;
+	}
+
+	return ret;
+}
+
+/*
+ * Returns temperature in DegC, resolution is 0.01 DegC.  Output value of
+ * "2608" equals 26.08 DegC.
+ * Returns humidity in percent, resolution is 0.1 percent. Output value of
+ * "323" represents 323/10 = 32.3 %RH.
+ */
+static int hdc3020_read_measurement(struct hdc3020_data *data)
+{
+	int ret;
+	u8 buf[6];
+
+	ret = hdc3020_read_bytes(data, HDC3020_R_T_RH_AUTO, (void *)buf, 6);
+	if (ret < 0)
+		return ret;
+	data->temp = (((int)buf[0] << 8) | buf[1]) * 100 * 175 / 65535 - 4500;
+	data->humidity = (((int)buf[3] << 8) | buf[4]) * 10 * 100 / 65535;
+	return 0;
+}
+
+/*
+ * After exiting the automatic measurement mode or resetting, the peak
+ * value will be reset to the default value
+ */
+static int hdc3020_read_peak_temp(struct hdc3020_data *data)
+{
+	int ret;
+	u8 buf[3];
+
+	ret = hdc3020_read_bytes(data, HDC3020_R_T_LOW_AUTO, (void *)buf, 3);
+	if (ret < 0)
+		return ret;
+	data->temp_low_peak =
+	    (((int)buf[0] << 8) | buf[1]) * 100 * 175 / 65535 - 4500;
+	ret = hdc3020_read_bytes(data, HDC3020_R_T_HIGH_AUTO, (void *)buf, 3);
+	if (ret < 0)
+		return ret;
+	data->temp_high_peak =
+	    (((int)buf[0] << 8) | buf[1]) * 100 * 175 / 65535 - 4500;
+
+	return 0;
+}
+
+/*
+ * After exiting the automatic measurement mode or resetting, the peak
+ * value will be reset to the default value
+ */
+static int hdc3020_read_peak_humidity(struct hdc3020_data *data)
+{
+	int ret;
+	u8 buf[3];
+
+	ret = hdc3020_read_bytes(data, HDC3020_R_RH_LOW_AUTO, (void *)buf, 3);
+	if (ret < 0)
+		return ret;
+	data->humidity_low_peak =
+	    (((int)buf[0] << 8) | buf[1]) * 10 * 100 / 65535;
+	ret = hdc3020_read_bytes(data, HDC3020_R_T_HIGH_AUTO, (void *)buf, 3);
+	if (ret < 0)
+		return ret;
+	data->humidity_high_peak =
+	    (((int)buf[0] << 8) | buf[1]) * 10 * 100 / 65535;
+
+	return 0;
+}
+
+static int hdc3020_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	struct hdc3020_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:{
+			int ret;
+
+			ret = iio_device_claim_direct_mode(indio_dev);
+
+			if (ret)
+				return ret;
+
+			mutex_lock(&data->lock);
+			ret = hdc3020_read_measurement(data);
+			mutex_unlock(&data->lock);
+			iio_device_release_direct_mode(indio_dev);
+
+			if (ret < 0)
+				return ret;
+			if (chan->type == IIO_TEMP)
+				*val = data->temp;
+			else if (chan->type == IIO_HUMIDITYRELATIVE)
+				*val = data->humidity;
+			return IIO_VAL_INT;
+		}
+	case IIO_CHAN_INFO_PEAK:{
+			int ret;
+
+			ret = iio_device_claim_direct_mode(indio_dev);
+
+			if (ret)
+				return ret;
+
+			if (chan->type == IIO_TEMP) {
+				mutex_lock(&data->lock);
+				ret = hdc3020_read_peak_temp(data);
+				mutex_unlock(&data->lock);
+				if (ret < 0)
+					return ret;
+				if (strcmp(chan->extend_name, "high") == 0)
+					*val = data->temp_high_peak;
+				else if (strcmp(chan->extend_name, "low") == 0)
+					*val = data->temp_low_peak;
+			} else if (chan->type == IIO_HUMIDITYRELATIVE) {
+				mutex_lock(&data->lock);
+				ret = hdc3020_read_peak_humidity(data);
+				mutex_unlock(&data->lock);
+				if (ret < 0)
+					return ret;
+				if (strcmp(chan->extend_name, "high") == 0)
+					*val = data->humidity_high_peak;
+				else if (strcmp(chan->extend_name, "low") == 0)
+					*val = data->humidity_low_peak;
+			}
+			iio_device_release_direct_mode(indio_dev);
+			return IIO_VAL_INT;
+		}
+	case IIO_CHAN_INFO_SCALE:
+		*val2 = 65536;
+		if (chan->type == IIO_TEMP)
+			*val = 1750;
+		else
+			*val = 1000;
+		return IIO_VAL_FRACTIONAL;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int hdc3020_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct hdc3020_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (chan->type != IIO_CURRENT || val2 != 0)
+			return -EINVAL;
+
+		switch (val) {
+		case 1:
+			mutex_lock(&data->lock);
+			ret =
+			    hdc3020_write_bytes(data, HDC3020_HEATER_QUARTER,
+						5);
+			mutex_unlock(&data->lock);
+			if (ret < 0)
+				return ret;
+			mutex_lock(&data->lock);
+			ret =
+			    hdc3020_write_bytes(data, HDC3020_ENABLE_HEATER, 2);
+			mutex_unlock(&data->lock);
+			if (ret < 0)
+				return ret;
+			break;
+		case 2:
+			mutex_lock(&data->lock);
+			ret = hdc3020_write_bytes(data, HDC3020_HEATER_HALF, 5);
+			mutex_unlock(&data->lock);
+			if (ret < 0)
+				return ret;
+			mutex_lock(&data->lock);
+			ret =
+			    hdc3020_write_bytes(data, HDC3020_ENABLE_HEATER, 2);
+			mutex_unlock(&data->lock);
+			if (ret < 0)
+				return ret;
+			break;
+		case 3:
+			mutex_lock(&data->lock);
+			ret = hdc3020_write_bytes(data, HDC3020_HEATER_FULL, 5);
+			mutex_unlock(&data->lock);
+			if (ret < 0)
+				return ret;
+			mutex_lock(&data->lock);
+			ret =
+			    hdc3020_write_bytes(data, HDC3020_ENABLE_HEATER, 2);
+			mutex_unlock(&data->lock);
+			if (ret < 0)
+				return ret;
+			break;
+		case 0:
+			mutex_lock(&data->lock);
+			ret =
+			    hdc3020_write_bytes(data, HDC3020_DISABLE_HEATER,
+						2);
+			mutex_unlock(&data->lock);
+			if (ret < 0)
+				return ret;
+			break;
+		default:
+			return -EINVAL;
+		}
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info hdc3020_info = {
+	.read_raw = hdc3020_read_raw,
+	.write_raw = hdc3020_write_raw,
+	.attrs = &hdc3020_attribute_group,
+};
+
+static int hdc3020_probe(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev;
+	struct hdc3020_data *data;
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return -EOPNOTSUPP;
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+	mutex_init(&data->lock);
+
+	indio_dev->name = "hdc3020";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &hdc3020_info;
+
+	indio_dev->channels = hdc3020_channels;
+	indio_dev->num_channels = ARRAY_SIZE(hdc3020_channels);
+
+	ret = hdc3020_write_bytes(data, HDC3020_S_AUTO_10HZ_MOD0, 2);
+	if (ret) {
+		dev_err(&client->dev, "Unable to set up measurement\n");
+		return ret;
+	}
+
+	return iio_device_register(indio_dev);
+}
+
+static void hdc3020_remove(struct i2c_client *client)
+{
+	int ret;
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct hdc3020_data *data = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+
+	/* Disable Automatic Measurement Mode */
+	ret = hdc3020_write_bytes(data, HDC3020_EXIT_AUTO, 2);
+	if (ret)
+		dev_err(&client->dev, "Unable to stop measurement\n");
+}
+
+static const struct i2c_device_id hdc3020_id[] = {
+	{ "hdc3020" },
+	{ "hdc3021" },
+	{ "hdc3022" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, hdc3020_id);
+
+static const struct of_device_id hdc3020_dt_ids[] = {
+	{.compatible = "ti,hdc3020" },
+	{.compatible = "ti,hdc3021" },
+	{.compatible = "ti,hdc3022" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, hdc3020_dt_ids);
+
+static struct i2c_driver hdc3020_driver = {
+	.driver = {
+		   .name = "hdc3020",
+		   .of_match_table = hdc3020_dt_ids,
+		    },
+	.probe = hdc3020_probe,
+	.remove = hdc3020_remove,
+	.id_table = hdc3020_id,
+};
+
+module_i2c_driver(hdc3020_driver);
+
+MODULE_AUTHOR("Li peiyu <579lpy@gmail.com>");
+MODULE_DESCRIPTION("TI HDC3020 humidity and temperature sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

