Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E6580C9C6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 13:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343518AbjLKMaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 07:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234949AbjLKM3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 07:29:49 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC889F5;
        Mon, 11 Dec 2023 04:29:53 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id d9443c01a7336-1d0ccda19eeso25907145ad.1;
        Mon, 11 Dec 2023 04:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702297793; x=1702902593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQy6JMbkXoRg/IbLqaCNb5mhh1h/Z0l6Wlh0ceHFycQ=;
        b=aZkP9IBxJE9pPqFu2e2ThAdNHYsS7nr350ntwZ34cPG8WyRS/nYNEjd/Z+6C9GD+Re
         D1kNHOhn9cOoAsq/rrHsDwndaUyoclXfaUIa5RQd9BSeljBzkTwv6ofVSekC9wOkEDjo
         kSq9V0dxjowU7StnIpnNzacbWVT4JjUx0xzrUu1hN0ET03EJcrlZwihGG+z3OT4nRzlR
         b062XWoTWXNmMuyR1NjTX0nOheUkL0CANUaMSMNiono217Rxp8RRtcYKgE9qmFly6MVM
         VTCvpFYCB7oqsBp08AYK8vQ1PbHzSBCIcn5oL2bJMBZuFimf7HCxNEFWGl+4SRLtSLLm
         2TrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702297793; x=1702902593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQy6JMbkXoRg/IbLqaCNb5mhh1h/Z0l6Wlh0ceHFycQ=;
        b=c0AE+WUbbNYn3OStUedbAxSVbTiEzDFFq2rO9xhMuw/1QD7EZYQpUkxKETOKh81+9d
         JCTn3s+xGrDnNsVzfZjAptvaozpogY+pQ4nQyc73hBSvMlv/3Zl0Hw5Cdlgx7375ZkB6
         eCwcobUHTUbbkSHC3cItnSK4dxKglZYxMfVPoVCcgZh9tnfiksAtoXThziBLAZGM6FRV
         4V+ZJn6fC8zBkHtV2UaiFyKr10xECCaOwLzzgHuWEOmbqsalba5Gu7jJgnfp3GpcABnY
         8xMPi2JWNeJtKNX7UhaOM7fg0EhyZ1WG8OVvwJUJ7pNGzDCfd1UViYR0DXfz8a9C88SK
         3ZgQ==
X-Gm-Message-State: AOJu0Yzsakq3xX7IlRWFI/YVuiKnVuFEuco86dWuG9HPcM7YD4NEVapp
        XWttxGkElpQB27J0K2F4ciE=
X-Google-Smtp-Source: AGHT+IEAnIQtdHCZgRuFAHhUdlPmCF5x4+SFQKCQ7lrdZzdwIg8RU+wNuj+ijdRUDlmdLbGsgiJ1yA==
X-Received: by 2002:a17:902:e851:b0:1d0:6ffe:1ea6 with SMTP id t17-20020a170902e85100b001d06ffe1ea6mr1994740plg.137.1702297793111;
        Mon, 11 Dec 2023 04:29:53 -0800 (PST)
Received: from dawn-virtual-machine.localdomain ([183.198.110.72])
        by smtp.gmail.com with ESMTPSA id j6-20020a170902c3c600b001d2e958df6dsm6533110plj.253.2023.12.11.04.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 04:29:52 -0800 (PST)
From:   Li peiyu <579lpy@gmail.com>
To:     jic23@kernel.org
Cc:     javier.carrasco.cruz@gmail.com, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li peiyu <579lpy@gmail.com>
Subject: [PATCH v6 3/4] iio: humidity: Add driver for ti HDC302x humidity sensors
Date:   Mon, 11 Dec 2023 20:29:40 +0800
Message-Id: <20231211122940.9791-1-579lpy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211122201.9598-1-579lpy@gmail.com>
References: <20231211122201.9598-1-579lpy@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

Co-developed-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Signed-off-by: Li peiyu <579lpy@gmail.com>
---
 MAINTAINERS                    |   8 +
 drivers/iio/humidity/Kconfig   |  12 +
 drivers/iio/humidity/Makefile  |   1 +
 drivers/iio/humidity/hdc3020.c | 473 +++++++++++++++++++++++++++++++++
 4 files changed, 494 insertions(+)
 create mode 100644 drivers/iio/humidity/hdc3020.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 788be9ab5b73..485dcbf37a19 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21795,6 +21795,14 @@ F:	Documentation/devicetree/bindings/media/i2c/ti,ds90*
 F:	drivers/media/i2c/ds90*
 F:	include/media/i2c/ds90*
 
+TI HDC302X HUMIDITY DRIVER
+M:	Javier Carrasco <javier.carrasco.cruz@gmail.com>
+M:	Li peiyu <579lpy@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml
+F:	drivers/iio/humidity/hdc3020.c
+
 TI ICSSG ETHERNET DRIVER (ICSSG)
 R:	MD Danish Anwar <danishanwar@ti.com>
 R:	Roger Quadros <rogerq@kernel.org>
diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
index 2de5494e7c22..b15b7a3b66d5 100644
--- a/drivers/iio/humidity/Kconfig
+++ b/drivers/iio/humidity/Kconfig
@@ -48,6 +48,18 @@ config HDC2010
 	  To compile this driver as a module, choose M here: the module
 	  will be called hdc2010.
 
+config HDC3020
+	tristate "TI HDC3020 relative humidity and temperature sensor"
+	depends on I2C
+	select CRC8
+	help
+	  Say yes here to build support for the Texas Instruments
+	  HDC3020, HDC3021 and HDC3022 relative humidity and temperature
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
index 000000000000..4e3311170725
--- /dev/null
+++ b/drivers/iio/humidity/hdc3020.c
@@ -0,0 +1,473 @@
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
+#include <linux/bitops.h>
+#include <linux/cleanup.h>
+#include <linux/crc8.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+
+#include <asm/unaligned.h>
+
+#include <linux/iio/iio.h>
+
+#define HDC3020_HEATER_CMD_MSB		0x30 /* shared by all heater commands */
+#define HDC3020_HEATER_ENABLE		0x6D
+#define HDC3020_HEATER_DISABLE		0x66
+#define HDC3020_HEATER_CONFIG		0x6E
+
+#define HDC3020_READ_RETRY_TIMES	10
+#define HDC3020_BUSY_DELAY_MS		10
+
+#define HDC3020_CRC8_POLYNOMIAL		0x31
+
+static const u8 HDC3020_S_AUTO_10HZ_MOD0[2] = { 0x27, 0x37 };
+
+static const u8 HDC3020_EXIT_AUTO[2] = { 0x30, 0x93 };
+
+static const u8 HDC3020_R_T_RH_AUTO[2] = { 0xE0, 0x00 };
+static const u8 HDC3020_R_T_LOW_AUTO[2] = { 0xE0, 0x02 };
+static const u8 HDC3020_R_T_HIGH_AUTO[2] = { 0xE0, 0x03 };
+static const u8 HDC3020_R_RH_LOW_AUTO[2] = { 0xE0, 0x04 };
+static const u8 HDC3020_R_RH_HIGH_AUTO[2] = { 0xE0, 0x05 };
+
+struct hdc3020_data {
+	struct i2c_client *client;
+	/*
+	 * Ensure that the sensor configuration (currently only heater is
+	 * supported) will not be changed during the process of reading
+	 * sensor data (this driver will try HDC3020_READ_RETRY_TIMES times
+	 * if the device does not respond).
+	 */
+	struct mutex lock;
+};
+
+static const int hdc3020_heater_vals[] = {0, 1, 0x3FFF};
+
+static const struct iio_chan_spec hdc3020_channels[] = {
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_PEAK) |
+		BIT(IIO_CHAN_INFO_TROUGH) | BIT(IIO_CHAN_INFO_OFFSET),
+	},
+	{
+		.type = IIO_HUMIDITYRELATIVE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_PEAK) |
+		BIT(IIO_CHAN_INFO_TROUGH),
+	},
+	{
+		/*
+		 * For setting the internal heater, which can be switched on to
+		 * prevent or remove any condensation that may develop when the
+		 * ambient environment approaches its dew point temperature.
+		 */
+		.type = IIO_CURRENT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_RAW),
+		.output = 1,
+	},
+};
+
+DECLARE_CRC8_TABLE(hdc3020_crc8_table);
+
+static int hdc3020_write_bytes(struct hdc3020_data *data, const u8 *buf, u8 len)
+{
+	struct i2c_client *client = data->client;
+	struct i2c_msg msg;
+	int ret, cnt;
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
+	for (cnt = 0; cnt < HDC3020_READ_RETRY_TIMES; cnt++) {
+		ret = i2c_transfer(client->adapter, &msg, 1);
+		if (ret == 1)
+			return 0;
+
+		mdelay(HDC3020_BUSY_DELAY_MS);
+	}
+	dev_err(&client->dev, "Could not write sensor command\n");
+
+	return -ETIMEDOUT;
+}
+
+static int hdc3020_read_bytes(struct hdc3020_data *data, const u8 *buf,
+			      void *val, int len)
+{
+	int ret, cnt;
+	struct i2c_client *client = data->client;
+	struct i2c_msg msg[2] = {
+		[0] = {
+			.addr = client->addr,
+			.flags = 0,
+			.buf = (char *)buf,
+			.len = 2,
+		},
+		[1] = {
+			.addr = client->addr,
+			.flags = I2C_M_RD,
+			.buf = val,
+			.len = len,
+		},
+	};
+
+	/*
+	 * During the measurement process, HDC3020 will not return data.
+	 * So wait for a while and try again
+	 */
+	for (cnt = 0; cnt < HDC3020_READ_RETRY_TIMES; cnt++) {
+		ret = i2c_transfer(client->adapter, msg, 2);
+		if (ret == 2)
+			return 0;
+
+		mdelay(HDC3020_BUSY_DELAY_MS);
+	}
+	dev_err(&client->dev, "Could not read sensor data\n");
+
+	return -ETIMEDOUT;
+}
+
+static int hdc3020_read_measurement(struct hdc3020_data *data,
+				    enum iio_chan_type type, int *val)
+{
+	u8 crc, buf[6];
+	int ret;
+
+	ret = hdc3020_read_bytes(data, HDC3020_R_T_RH_AUTO, buf, 6);
+	if (ret < 0)
+		return ret;
+
+	/* CRC check of the temperature measurement */
+	crc = crc8(hdc3020_crc8_table, buf, 2, CRC8_INIT_VALUE);
+	if (crc != buf[2])
+		return -EINVAL;
+
+	/* CRC check of the relative humidity measurement */
+	crc = crc8(hdc3020_crc8_table, buf + 3, 2, CRC8_INIT_VALUE);
+	if (crc != buf[5])
+		return -EINVAL;
+
+	if (type == IIO_TEMP)
+		*val = get_unaligned_be16(buf);
+	else if (type == IIO_HUMIDITYRELATIVE)
+		*val = get_unaligned_be16(&buf[3]);
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+/*
+ * After exiting the automatic measurement mode or resetting, the peak
+ * value will be reset to the default value
+ * This method is used to get the highest temp measured during automatic
+ * measurement
+ */
+static int hdc3020_read_high_peak_t(struct hdc3020_data *data, int *val)
+{
+	u8 crc, buf[3];
+	int ret;
+
+	ret = hdc3020_read_bytes(data, HDC3020_R_T_HIGH_AUTO, buf, 3);
+	if (ret < 0)
+		return ret;
+
+	crc = crc8(hdc3020_crc8_table, buf, 2, CRC8_INIT_VALUE);
+	if (crc != buf[2])
+		return -EINVAL;
+
+	*val = get_unaligned_be16(buf);
+
+	return 0;
+}
+
+/*
+ * This method is used to get the lowest temp measured during automatic
+ * measurement
+ */
+static int hdc3020_read_low_peak_t(struct hdc3020_data *data, int *val)
+{
+	u8 crc, buf[3];
+	int ret;
+
+	ret = hdc3020_read_bytes(data, HDC3020_R_T_LOW_AUTO, buf, 3);
+	if (ret < 0)
+		return ret;
+
+	crc = crc8(hdc3020_crc8_table, buf, 2, CRC8_INIT_VALUE);
+	if (crc != buf[2])
+		return -EINVAL;
+
+	*val = get_unaligned_be16(buf);
+
+	return 0;
+}
+
+/*
+ * This method is used to get the highest humidity measured during automatic
+ * measurement
+ */
+static int hdc3020_read_high_peak_rh(struct hdc3020_data *data, int *val)
+{
+	u8 crc, buf[3];
+	int ret;
+
+	ret = hdc3020_read_bytes(data, HDC3020_R_RH_HIGH_AUTO, buf, 3);
+	if (ret < 0)
+		return ret;
+
+	crc = crc8(hdc3020_crc8_table, buf, 2, CRC8_INIT_VALUE);
+	if (crc != buf[2])
+		return -EINVAL;
+
+	*val = get_unaligned_be16(buf);
+
+	return 0;
+}
+
+/*
+ * This method is used to get the lowest humidity measured during automatic
+ * measurement
+ */
+static int hdc3020_read_low_peak_rh(struct hdc3020_data *data, int *val)
+{
+	u8 crc, buf[3];
+	int ret;
+
+	ret = hdc3020_read_bytes(data, HDC3020_R_RH_LOW_AUTO, buf, 3);
+	if (ret < 0)
+		return ret;
+
+	crc = crc8(hdc3020_crc8_table, buf, 2, CRC8_INIT_VALUE);
+	if (crc != buf[2])
+		return -EINVAL;
+
+	*val = get_unaligned_be16(buf);
+
+	return 0;
+}
+
+static int hdc3020_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	struct hdc3020_data *data = iio_priv(indio_dev);
+	int ret;
+
+	if (chan->type != IIO_TEMP && chan->type != IIO_HUMIDITYRELATIVE)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW: {
+		guard(mutex)(&data->lock);
+		ret = hdc3020_read_measurement(data, chan->type, val);
+		if (ret < 0)
+			return ret;
+
+		return IIO_VAL_INT;
+	}
+	case IIO_CHAN_INFO_PEAK: {
+		guard(mutex)(&data->lock);
+		if (chan->type == IIO_TEMP) {
+			ret = hdc3020_read_high_peak_t(data, val);
+			if (ret < 0)
+				return ret;
+		} else {
+			ret = hdc3020_read_high_peak_rh(data, val);
+			if (ret < 0)
+				return ret;
+		}
+		return IIO_VAL_INT;
+	}
+	case IIO_CHAN_INFO_TROUGH: {
+		guard(mutex)(&data->lock);
+		if (chan->type == IIO_TEMP) {
+			ret = hdc3020_read_low_peak_t(data, val);
+			if (ret < 0)
+				return ret;
+		} else {
+			ret = hdc3020_read_low_peak_rh(data, val);
+			if (ret < 0)
+				return ret;
+		}
+		return IIO_VAL_INT;
+	}
+	case IIO_CHAN_INFO_SCALE:
+		*val2 = 65536;
+		if (chan->type == IIO_TEMP)
+			*val = 175;
+		else
+			*val = 100;
+		return IIO_VAL_FRACTIONAL;
+
+	case IIO_CHAN_INFO_OFFSET:
+		if (chan->type != IIO_TEMP)
+			return -EINVAL;
+
+		*val = 16852;
+		return IIO_VAL_INT;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int hdc3020_read_available(struct iio_dev *indio_dev,
+				  struct iio_chan_spec const *chan,
+				  const int **vals,
+				  int *type, int *length, long mask)
+{
+	if (mask != IIO_CHAN_INFO_RAW || chan->type != IIO_CURRENT)
+		return -EINVAL;
+
+	*vals = hdc3020_heater_vals;
+	*type = IIO_VAL_INT;
+
+	return IIO_AVAIL_RANGE;
+}
+
+static int hdc3020_update_heater(struct hdc3020_data *data, int val)
+{
+	u8 buf[5];
+	int ret;
+
+	if (val < hdc3020_heater_vals[0] || val > hdc3020_heater_vals[2])
+		return -EINVAL;
+
+	buf[0] = HDC3020_HEATER_CMD_MSB;
+
+	if (!val) {
+		buf[1] = HDC3020_HEATER_DISABLE;
+		return hdc3020_write_bytes(data, buf, 2);
+	}
+
+	buf[1] = HDC3020_HEATER_CONFIG;
+	put_unaligned_be16(val & GENMASK(13, 0), &buf[2]);
+	buf[4] = crc8(hdc3020_crc8_table, buf + 2, 2, CRC8_INIT_VALUE);
+	ret = hdc3020_write_bytes(data, buf, 5);
+	if (ret < 0)
+		return ret;
+
+	buf[1] = HDC3020_HEATER_ENABLE;
+
+	return hdc3020_write_bytes(data, buf, 2);
+}
+
+static int hdc3020_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct hdc3020_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (chan->type != IIO_CURRENT)
+			return -EINVAL;
+
+		guard(mutex)(&data->lock);
+		return hdc3020_update_heater(data, val);
+	}
+
+	return -EINVAL;
+}
+
+static const struct iio_info hdc3020_info = {
+	.read_raw = hdc3020_read_raw,
+	.write_raw = hdc3020_write_raw,
+	.read_avail = hdc3020_read_available,
+};
+
+static void hdc3020_stop(void *data)
+{
+	hdc3020_write_bytes((struct hdc3020_data *)data, HDC3020_EXIT_AUTO, 2);
+}
+
+static int hdc3020_probe(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev;
+	struct hdc3020_data *data;
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return -EOPNOTSUPP;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->client = client;
+	mutex_init(&data->lock);
+
+	crc8_populate_msb(hdc3020_crc8_table, HDC3020_CRC8_POLYNOMIAL);
+
+	indio_dev->name = "hdc3020";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &hdc3020_info;
+	indio_dev->channels = hdc3020_channels;
+	indio_dev->num_channels = ARRAY_SIZE(hdc3020_channels);
+
+	ret = hdc3020_write_bytes(data, HDC3020_S_AUTO_10HZ_MOD0, 2);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "Unable to set up measurement\n");
+
+	ret = devm_add_action_or_reset(&data->client->dev, hdc3020_stop, data);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_device_register(&data->client->dev, indio_dev);
+	if (ret)
+		return dev_err_probe(&client->dev, ret, "Failed to add device");
+
+	return 0;
+}
+
+static const struct i2c_device_id hdc3020_id[] = {
+	{ "hdc3020" },
+	{ "hdc3021" },
+	{ "hdc3022" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, hdc3020_id);
+
+static const struct of_device_id hdc3020_dt_ids[] = {
+	{ .compatible = "ti,hdc3020" },
+	{ .compatible = "ti,hdc3021" },
+	{ .compatible = "ti,hdc3022" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, hdc3020_dt_ids);
+
+static struct i2c_driver hdc3020_driver = {
+	.driver = {
+		.name = "hdc3020",
+		.of_match_table = hdc3020_dt_ids,
+	},
+	.probe = hdc3020_probe,
+	.id_table = hdc3020_id,
+};
+module_i2c_driver(hdc3020_driver);
+
+MODULE_AUTHOR("Javier Carrasco <javier.carrasco.cruz@gmail.com>");
+MODULE_AUTHOR("Li peiyu <579lpy@gmail.com>");
+MODULE_DESCRIPTION("TI HDC3020 humidity and temperature sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.39.2

