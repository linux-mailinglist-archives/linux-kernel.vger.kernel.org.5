Return-Path: <linux-kernel+bounces-106860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6BA87F496
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 01:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 559291F21903
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDD81B812;
	Tue, 19 Mar 2024 00:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQjgz2Ca"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F61F503;
	Tue, 19 Mar 2024 00:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710808184; cv=none; b=peimUnh4MgZemrDR0D0hw682cFTkgUob3J2iqH23zSq1dCsGva+XVo1bZF6lESHvlhF8VO6h6TXfRXDVwJG2fnqkxGZFhtTfnF7F/EeiHXhSgOUrsPp5Fp3+IOZEDVxi1Xm/6THGin0tNHUMOLrLEAPJQfp3D9MuBgIVIQvBRmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710808184; c=relaxed/simple;
	bh=LtN4ZB+WVs9lNVCnzOsWcqArQwLuyWCeQxbL4WvR9A4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BXRa0wLqt5c7avP1S3tSBGTbbuAOxdm14VgU7Ej0/zWlDELIaTlhzPFy7d+cMT0JD1u4ckoigo58XZffO7CYcT0gC+TLX8VGvjgoqhpYwlK4GybvOSqUJ84qQV9xL99FA2emVnzi8DXubBtahtihZjs/23AQHMvfyZnZVPXEBXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQjgz2Ca; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56a2b881911so1760518a12.3;
        Mon, 18 Mar 2024 17:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710808180; x=1711412980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LiyjhF7+GyLLHMZmqQqv+Lvr6yzCKpFrf7i6pLySqY=;
        b=GQjgz2Ca6q7j9d3WRso2sVFNUPq+wnXMzMEOa8Bhl3x1JCc0NopTZbIgXir055bwzh
         FHxSk8VMKB/goixZkvpB0aeTkfb9WF6ZBX20BCW4rNDYk5m+NJEW5Y7fNVOwryMmiXOQ
         b/tbUH13MtytDRaBIGUqYZGNXD0HZOckb4nNv/QsMtbEUaX01Sxf6w6mCIXAQm3gKDTj
         fgMl1wuktlFLAj/4BIL4EtZFG+lY0+C5BtvObA8fwI5JCRWUl5WAnUS3eU46N14rzldp
         iLvcmNxdY8jysVuepoWCWC32cSHnm7TRTArHxucjzb8Sby0gwiqUcKIuNm3TPMEL9owp
         UzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710808180; x=1711412980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4LiyjhF7+GyLLHMZmqQqv+Lvr6yzCKpFrf7i6pLySqY=;
        b=wwLC4GmRSZTMC3oKsjVDT89E5RRt/r5RhXuPQTfScADyU3u6T0juAijkzq2XbpXOBm
         9GzDu1Hon7w1Bd8O9kFGnf8ZmA5ji7gpE7jAJa/dCEU1hLwodN0q2eW+WI7FxG04dbSh
         +zcZZBfroBOVmTFQB+lDlYzbqxA/0hU0sAl9VcZt6JOkM8fR+c4J+EuYlC6M6V9qOgEV
         8emRogpjr20OqNOVl55AD7NUNpxsoxP+bRlymthJ9e67vJCCfC+RQDgPFuFtkyIZM88H
         wvOtN9jtQ7U7wDNJmFF6MnbYPTMmjL9UTsfB1DWOTd4sMeldWCAL0jaA7q87eLpnt6K9
         ZnkA==
X-Forwarded-Encrypted: i=1; AJvYcCXr3QlPZdO0bY82muJl5Z9XrvfaZ5BHTwR+DVYmegnSdHckTwkIFA4AXmwRLA78pvBiA0x5eCDyNAFpjloJZD+i7H6Wg59GWHJwuA0uzemaJ8HcVsR90ItpRy3zBJJ3kGD0scjGsUrI
X-Gm-Message-State: AOJu0YwX1PYPRjsj4J7amcODUuaN13e+Q9uQ5yatQSN7nLqrlrSuLIvi
	0mL7XW6yszLPAGqVUam5R4dcuU9cpy8zIXaSfOOgi4JzwIpcEjV9
X-Google-Smtp-Source: AGHT+IGakkM11RqQhsiODsvj+HB4tZNOsfRjEgpBpl88u8OSNfoCnxj8naoVFHH4upHTsHRq9/CtJQ==
X-Received: by 2002:a05:6402:3711:b0:568:b498:ce49 with SMTP id ek17-20020a056402371100b00568b498ce49mr630008edb.3.1710808180588;
        Mon, 18 Mar 2024 17:29:40 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:8c96:c55f:eab0:860])
        by smtp.gmail.com with ESMTPSA id co24-20020a0564020c1800b00568c613570dsm2700227edb.79.2024.03.18.17.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 17:29:39 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	andriy.shevchenko@linux.intel.com,
	ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com,
	ak@it-klinger.de,
	petre.rodan@subdimension.ro,
	phil@raspberrypi.com,
	579lpy@gmail.com,
	linus.walleij@linaro.org,
	semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v3 6/6] iio: pressure: Add triggered buffer support for BMP280 driver
Date: Tue, 19 Mar 2024 01:29:25 +0100
Message-Id: <20240319002925.2121016-7-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240319002925.2121016-1-vassilisamir@gmail.com>
References: <20240319002925.2121016-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BMP2xx, BMP3xx, and BMP5xx use consecutive buffers for their
temperature, pressure and humidity readings. This facilitates
the use of burst reads in order to acquire data much faster
and in a different way from the one used in oneshot captures.

BMP085 and BMP180 use a completely different measurement
process that is well defined and is used in their buffer_handler().

Suggested-by: Angel Iglesias <ang.iglesiasg@gmail.com>
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/Kconfig       |   2 +
 drivers/iio/pressure/bmp280-core.c | 231 +++++++++++++++++++++++++++--
 drivers/iio/pressure/bmp280-spi.c  |   8 +-
 drivers/iio/pressure/bmp280.h      |  14 +-
 4 files changed, 241 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index 79adfd059c3a..5145b94b4679 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -31,6 +31,8 @@ config BMP280
 	select REGMAP
 	select BMP280_I2C if (I2C)
 	select BMP280_SPI if (SPI_MASTER)
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Bosch Sensortec BMP180, BMP280, BMP380
 	  and BMP580 pressure and temperature sensors. Also supports the BME280 with
diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index ddfcd23f29a0..ffcd17807cf5 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -40,7 +40,10 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 
 #include <asm/unaligned.h>
 
@@ -454,7 +457,7 @@ static int bmp280_read_temp(struct bmp280_data *data, s32 *comp_temp)
 	int ret;
 
 	ret = regmap_bulk_read(data->regmap, BMP280_REG_TEMP_MSB,
-			       data->buf, sizeof(data->buf));
+			       data->buf, BMP280_NUM_TEMP_BYTES);
 	if (ret < 0) {
 		dev_err(data->dev, "failed to read temperature\n");
 		return ret;
@@ -484,7 +487,7 @@ static int bmp280_read_press(struct bmp280_data *data, u32 *comp_press)
 		return ret;
 
 	ret = regmap_bulk_read(data->regmap, BMP280_REG_PRESS_MSB,
-			       data->buf, sizeof(data->buf));
+			       data->buf, BMP280_NUM_PRESS_BYTES);
 	if (ret < 0) {
 		dev_err(data->dev, "failed to read pressure\n");
 		return ret;
@@ -513,13 +516,13 @@ static int bmp280_read_humid(struct bmp280_data *data, u32 *comp_humidity)
 		return ret;
 
 	ret = regmap_bulk_read(data->regmap, BMP280_REG_HUMIDITY_MSB,
-			       &data->be16, sizeof(data->be16));
+			       &data->be16, BME280_NUM_HUMIDITY_BYTES);
 	if (ret < 0) {
 		dev_err(data->dev, "failed to read humidity\n");
 		return ret;
 	}
 
-	adc_humidity = be16_to_cpu(data->be16);
+	adc_humidity = get_unaligned_be16(&data->be16);
 	if (adc_humidity == BMP280_HUMIDITY_SKIPPED) {
 		/* reading was skipped */
 		dev_err(data->dev, "reading humidity skipped\n");
@@ -931,6 +934,73 @@ static int bmp280_chip_config(struct bmp280_data *data)
 	return ret;
 }
 
+static irqreturn_t bmp280_buffer_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct bmp280_data *data = iio_priv(indio_dev);
+	s32 adc_temp, adc_press, adc_humidity;
+	u8 size_of_burst_read;
+	int ret, chan_value;
+
+	guard(mutex)(&data->lock);
+
+	if (test_bit(BME280_HUMID, indio_dev->active_scan_mask))
+		size_of_burst_read = 8;
+	else
+		size_of_burst_read = 6;
+
+	/* Burst read data registers */
+	ret = regmap_bulk_read(data->regmap, BMP280_REG_PRESS_MSB,
+			       data->buf, 8);
+	if (ret) {
+		dev_err(data->dev, "failed to read sensor data\n");
+		return ret;
+	}
+
+	/* Temperature calculations */
+	memcpy(&chan_value, &data->buf[3], 3);
+
+	adc_temp = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(&chan_value));
+	if (adc_temp == BMP280_TEMP_SKIPPED) {
+		/* reading was skipped */
+		dev_err(data->dev, "reading temperature skipped\n");
+		return -EIO;
+	}
+	data->iio_buf.sensor_data[0] = bmp280_compensate_temp(data, adc_temp);
+
+	/* Pressure calculations */
+	memcpy(&chan_value, &data->buf[0], 3);
+
+	adc_press = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(&chan_value));
+	if (adc_press == BMP280_PRESS_SKIPPED) {
+		/* reading was skipped */
+		dev_err(data->dev, "reading pressure skipped\n");
+		return -EIO;
+	}
+	data->iio_buf.sensor_data[1] = bmp280_compensate_press(data, adc_press);
+
+	/* Humidity calculations */
+	if (test_bit(BME280_HUMID, indio_dev->active_scan_mask)) {
+		memcpy(&chan_value, &data->buf[6], 2);
+
+		adc_humidity = get_unaligned_be16(&chan_value);
+		if (adc_humidity == BMP280_HUMIDITY_SKIPPED) {
+			/* reading was skipped */
+			dev_err(data->dev, "reading humidity skipped\n");
+			return -EIO;
+		}
+	data->iio_buf.sensor_data[2] = bmp280_compensate_humidity(data, adc_humidity);
+	}
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->iio_buf,
+					   iio_get_time_ns(indio_dev));
+
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
 static const int bmp280_oversampling_avail[] = { 1, 2, 4, 8, 16 };
 static const u8 bmp280_chip_ids[] = { BMP280_CHIP_ID };
 static const int bmp280_temp_coeffs[] = { 10, 1 };
@@ -973,6 +1043,8 @@ const struct bmp280_chip_info bmp280_chip_info = {
 	.read_temp = bmp280_read_temp,
 	.read_press = bmp280_read_press,
 	.read_calib = bmp280_read_calib,
+
+	.buffer_handler = bmp280_buffer_handler
 };
 EXPORT_SYMBOL_NS(bmp280_chip_info, IIO_BMP280);
 
@@ -1032,6 +1104,8 @@ const struct bmp280_chip_info bme280_chip_info = {
 	.read_press = bmp280_read_press,
 	.read_humid = bmp280_read_humid,
 	.read_calib = bme280_read_calib,
+
+	.buffer_handler = bmp280_buffer_handler
 };
 EXPORT_SYMBOL_NS(bme280_chip_info, IIO_BMP280);
 
@@ -1158,7 +1232,7 @@ static int bmp380_read_temp(struct bmp280_data *data, s32 *comp_temp)
 	int ret;
 
 	ret = regmap_bulk_read(data->regmap, BMP380_REG_TEMP_XLSB,
-			       data->buf, sizeof(data->buf));
+			       data->buf, BMP280_NUM_TEMP_BYTES);
 	if (ret) {
 		dev_err(data->dev, "failed to read temperature\n");
 		return ret;
@@ -1187,7 +1261,7 @@ static int bmp380_read_press(struct bmp280_data *data, u32 *comp_press)
 		return ret;
 
 	ret = regmap_bulk_read(data->regmap, BMP380_REG_PRESS_XLSB,
-			       data->buf, sizeof(data->buf));
+			       data->buf, BMP280_NUM_PRESS_BYTES);
 	if (ret) {
 		dev_err(data->dev, "failed to read pressure\n");
 		return ret;
@@ -1366,6 +1440,54 @@ static int bmp380_chip_config(struct bmp280_data *data)
 	return 0;
 }
 
+static irqreturn_t bmp380_buffer_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct bmp280_data *data = iio_priv(indio_dev);
+	s32 adc_temp, adc_press;
+	int ret, chan_value;
+
+	guard(mutex)(&data->lock);
+
+	/* Burst read data registers */
+	ret = regmap_bulk_read(data->regmap, BMP380_REG_PRESS_XLSB,
+			       data->buf, 6);
+	if (ret) {
+		dev_err(data->dev, "failed to read sensor data\n");
+		return ret;
+	}
+
+	/* Temperature calculations */
+	memcpy(&chan_value, &data->buf[3], 3);
+
+	adc_temp = get_unaligned_le24(&chan_value);
+	if (adc_temp == BMP380_TEMP_SKIPPED) {
+		/* reading was skipped */
+		dev_err(data->dev, "reading temperature skipped\n");
+		return -EIO;
+	}
+	data->iio_buf.sensor_data[0] = bmp380_compensate_temp(data, adc_temp);
+
+	/* Pressure calculations */
+	memcpy(&chan_value, &data->buf[0], 3);
+
+	adc_press = get_unaligned_le24(&chan_value);
+	if (adc_press == BMP380_PRESS_SKIPPED) {
+		/* reading was skipped */
+		dev_err(data->dev, "reading pressure skipped\n");
+		return -EIO;
+	}
+	data->iio_buf.sensor_data[1] = bmp380_compensate_press(data, adc_press);
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->iio_buf,
+					   iio_get_time_ns(indio_dev));
+
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
 static const int bmp380_oversampling_avail[] = { 1, 2, 4, 8, 16, 32 };
 static const int bmp380_iir_filter_coeffs_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128};
 static const u8 bmp380_chip_ids[] = { BMP380_CHIP_ID, BMP390_CHIP_ID };
@@ -1408,6 +1530,8 @@ const struct bmp280_chip_info bmp380_chip_info = {
 	.read_press = bmp380_read_press,
 	.read_calib = bmp380_read_calib,
 	.preinit = bmp380_preinit,
+
+	.buffer_handler = bmp380_buffer_handler
 };
 EXPORT_SYMBOL_NS(bmp380_chip_info, IIO_BMP280);
 
@@ -1528,7 +1652,7 @@ static int bmp580_read_temp(struct bmp280_data *data, s32 *raw_temp)
 	int ret;
 
 	ret = regmap_bulk_read(data->regmap, BMP580_REG_TEMP_XLSB, data->buf,
-			       sizeof(data->buf));
+			       BMP280_NUM_TEMP_BYTES);
 	if (ret) {
 		dev_err(data->dev, "failed to read temperature\n");
 		return ret;
@@ -1548,7 +1672,7 @@ static int bmp580_read_press(struct bmp280_data *data, u32 *raw_press)
 	int ret;
 
 	ret = regmap_bulk_read(data->regmap, BMP580_REG_PRESS_XLSB, data->buf,
-			       sizeof(data->buf));
+			       BMP280_NUM_PRESS_BYTES);
 	if (ret) {
 		dev_err(data->dev, "failed to read pressure\n");
 		return ret;
@@ -1863,6 +1987,54 @@ static int bmp580_chip_config(struct bmp280_data *data)
 	return 0;
 }
 
+static irqreturn_t bmp580_buffer_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct bmp280_data *data = iio_priv(indio_dev);
+	s32 adc_temp, adc_press;
+	int ret, chan_value;
+
+	guard(mutex)(&data->lock);
+
+	/* Burst read data registers */
+	ret = regmap_bulk_read(data->regmap, BMP580_REG_TEMP_XLSB,
+			       data->buf, 6);
+	if (ret) {
+		dev_err(data->dev, "failed to read sensor data\n");
+		return ret;
+	}
+
+	/* Temperature calculations */
+	memcpy(&chan_value, &data->buf[3], 3);
+
+	adc_temp = get_unaligned_le24(&chan_value);
+	if (adc_temp == BMP580_TEMP_SKIPPED) {
+		/* reading was skipped */
+		dev_err(data->dev, "reading temperature skipped\n");
+		return -EIO;
+	}
+	data->iio_buf.sensor_data[0] = adc_temp;
+
+	/* Pressure calculations */
+	memcpy(&chan_value, &data->buf[0], 3);
+
+	adc_press = get_unaligned_le24(&chan_value);
+	if (adc_press == BMP580_PRESS_SKIPPED) {
+		/* reading was skipped */
+		dev_err(data->dev, "reading pressure skipped\n");
+		return -EIO;
+	}
+	data->iio_buf.sensor_data[1] =  adc_press;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->iio_buf,
+					   iio_get_time_ns(indio_dev));
+
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
 static const int bmp580_oversampling_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128 };
 static const u8 bmp580_chip_ids[] = { BMP580_CHIP_ID, BMP580_CHIP_ID_ALT };
 static const int bmp580_temp_coeffs[] = { 1000, 16 };
@@ -1903,6 +2075,8 @@ const struct bmp280_chip_info bmp580_chip_info = {
 	.read_temp = bmp580_read_temp,
 	.read_press = bmp580_read_press,
 	.preinit = bmp580_preinit,
+
+	.buffer_handler = bmp580_buffer_handler
 };
 EXPORT_SYMBOL_NS(bmp580_chip_info, IIO_BMP280);
 
@@ -2054,7 +2228,7 @@ static int bmp180_read_adc_press(struct bmp280_data *data, int *val)
 		return ret;
 
 	ret = regmap_bulk_read(data->regmap, BMP180_REG_OUT_MSB,
-			       data->buf, sizeof(data->buf));
+			       data->buf, BMP280_NUM_PRESS_BYTES);
 	if (ret)
 		return ret;
 
@@ -2122,6 +2296,35 @@ static int bmp180_chip_config(struct bmp280_data *data)
 	return 0;
 }
 
+static irqreturn_t bmp180_buffer_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct bmp280_data *data = iio_priv(indio_dev);
+	int ret, chan_value;
+
+	guard(mutex)(&data->lock);
+
+	ret = data->chip_info->read_temp(data, &chan_value);
+	if (ret)
+		return ret;
+
+	data->iio_buf.sensor_data[0] = chan_value;
+
+	ret = data->chip_info->read_press(data, &chan_value);
+	if (ret)
+		return ret;
+
+	data->iio_buf.sensor_data[1] = chan_value;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->iio_buf,
+					   iio_get_time_ns(indio_dev));
+
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
 static const int bmp180_oversampling_temp_avail[] = { 1 };
 static const int bmp180_oversampling_press_avail[] = { 1, 2, 4, 8 };
 static const u8 bmp180_chip_ids[] = { BMP180_CHIP_ID };
@@ -2157,6 +2360,8 @@ const struct bmp280_chip_info bmp180_chip_info = {
 	.read_temp = bmp180_read_temp,
 	.read_press = bmp180_read_press,
 	.read_calib = bmp180_read_calib,
+
+	.buffer_handler = bmp180_buffer_handler
 };
 EXPORT_SYMBOL_NS(bmp180_chip_info, IIO_BMP280);
 
@@ -2332,6 +2537,14 @@ int bmp280_common_probe(struct device *dev,
 					     "failed to read calibration coefficients\n");
 	}
 
+	ret = devm_iio_triggered_buffer_setup(data->dev, indio_dev,
+					      iio_pollfunc_store_time,
+					      data->chip_info->buffer_handler,
+					      NULL);
+	if (ret)
+		return dev_err_probe(data->dev, ret,
+				     "iio triggered buffer setup failed\n");
+
 	/*
 	 * Attempt to grab an optional EOC IRQ - only the BMP085 has this
 	 * however as it happens, the BMP085 shares the chip ID of BMP180
diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index a444d4b2978b..dc297583cac1 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -40,14 +40,14 @@ static int bmp380_regmap_spi_read(void *context, const void *reg,
 				  size_t reg_size, void *val, size_t val_size)
 {
 	struct spi_device *spi = to_spi_device(context);
-	u8 rx_buf[4];
+	u8 rx_buf[9];
 	ssize_t status;
 
 	/*
-	 * Maximum number of consecutive bytes read for a temperature or
-	 * pressure measurement is 3.
+	 * Maximum number of a burst read for temperature, pressure, humidity
+	 * is 8 bytes.
 	 */
-	if (val_size > 3)
+	if (val_size > 8)
 		return -EINVAL;
 
 	/*
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 8cc3eed70c18..32155567faf6 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -301,6 +301,10 @@
 #define BMP280_PRESS_SKIPPED		0x80000
 #define BMP280_HUMIDITY_SKIPPED		0x8000
 
+#define BMP280_NUM_TEMP_BYTES		3
+#define BMP280_NUM_PRESS_BYTES		3
+#define BME280_NUM_HUMIDITY_BYTES	2
+
 /* Core exported structs */
 
 static const char *const bmp280_supply_names[] = {
@@ -400,13 +404,19 @@ struct bmp280_data {
 	 */
 	s32 t_fine;
 
+	/* Data to push to userspace */
+	struct {
+		s32 sensor_data[3];
+		s64 timestamp __aligned(8);
+	} iio_buf;
+
 	/*
 	 * DMA (thus cache coherency maintenance) may require the
 	 * transfer buffers to live in their own cache lines.
 	 */
 	union {
 		/* Sensor data buffer */
-		u8 buf[3];
+		u8 buf[8];
 		/* Calibration data buffers */
 		__le16 bmp280_cal_buf[BMP280_CONTIGUOUS_CALIB_REGS / 2];
 		__be16 bmp180_cal_buf[BMP180_REG_CALIB_COUNT / 2];
@@ -462,6 +472,8 @@ struct bmp280_chip_info {
 	int (*read_humid)(struct bmp280_data *, u32 *);
 	int (*read_calib)(struct bmp280_data *);
 	int (*preinit)(struct bmp280_data *);
+
+	irqreturn_t (*buffer_handler)(int, void *);
 };
 
 /* Chip infos for each variant */
-- 
2.25.1


