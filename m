Return-Path: <linux-kernel+bounces-89833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A1E86F63D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 17:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9F181F2321A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A5870CB6;
	Sun,  3 Mar 2024 16:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emP4IYTw"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1EE6CDD1;
	Sun,  3 Mar 2024 16:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709484798; cv=none; b=lSa7jnMQV6+WmN5dLpTqIctkipUfzkIPufmW639R6wx3WRks3YxzhZN9NtC7pNH9bunBMu7DKSHC2BvAd0R+288K+Id+KHu96lsHZs7QXrC+Lxl/EPtMi4A5shpNmz+/ORyLwlYGN6srUgTl5vnyC5u10V/nV9MA5jhrq1DDZu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709484798; c=relaxed/simple;
	bh=uhESgY2UxXBKI+7rBvTEsnnDNHfYJqOz6gw05iIfEZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E44XnD+OPkfTixPjjy12kZXBQBFjLdSWbb5Jw0ZwNdOhIUnS9LiqIOAD3MC5bus9lkxLlmvkRi9sGTX37MDPxZLCKRfXs6oRzseQAMJQDhg80r1yhLrvLqaYjijEjxz0l+LyWHMv5rAMRoJonlHZW1Xckb0totAAA19/meT9tyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emP4IYTw; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d23d301452so40406761fa.1;
        Sun, 03 Mar 2024 08:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709484794; x=1710089594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvQGs5JXVU+jRv/aFfQyeDN1+W6T2RkgkEWiTbN0Q2Q=;
        b=emP4IYTwgb8okUTOxbUC8qlEDpzlN2KKPJJoSMLPFt38yiDF1/kWEX7OU/PJPRJFsx
         ffebZhJtHdDLJ6tAHySKtxo4RxWKNaeECvM5M5Q+TptcxyrxELiPfFVcRNlAhbnYvE8Y
         q9th+XoOl0NaDhWegrWRjgUvRjLAp8zkCFBzEHnKAJLShKqPbrWnVmiuzK/Uez83m64+
         LVsUvMR1R4DrW0xFXlR1biHBpEp69V63CwyX5Kraxseiwycu2OtsQmTqDqDRK3zPFLJ8
         A8cRLcLMHvZC3WopDHlEuKf0wwWSCntGVsEBHyBLb2X2Qd0398wNNn4w6QAXVsksrLoM
         3aFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709484794; x=1710089594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvQGs5JXVU+jRv/aFfQyeDN1+W6T2RkgkEWiTbN0Q2Q=;
        b=Jxi330V8JMhphWk5rbAvBQ5fQ2JFsayNsWIFTA3bUfJ3lb1/KaZGCItDzknVszE6F9
         xqxWslNnOUlCVGUVxSDdlTI9NcYwV0bh8yCz6ifyTXAITTGo8PfCsuKoSU0TR2fCzC9R
         v/WKIQMlZCaDrR6TScBv9FCJDafD/VincioaneWz9YPH6Jgu6B+KvXwt7C3by0WWGYYt
         IirT/5taJb+ORNXpv599hFpr70yom+iMUwvG7qTLlh4J65Ol/Lmvy3mrOS3Sl2fJUoOw
         zrG3M1WVpyv5zWuZ+y/CPfC7y8x9oRVSmIq+Md/RWhJ51vqyIoty/VNYYJobRYrgEfd9
         CEkA==
X-Forwarded-Encrypted: i=1; AJvYcCV2Xf+IruRIGG8kyxeSuWSKTLOWEFpX7lkrnLAXIbPXr8riLHLMrRVl3yuN/Y5LisdOgKmPoBVU1Hgrpni7+WBChU5IqgCfd5m/2apkXOqKA/wyi3TYbx1SVVILy0Tmp7LjRATR85f2
X-Gm-Message-State: AOJu0Yzq8gvCBi4FLb4tUbi7BhrgTSq7ZQDau4mXc+9HA+O+dN0u/7AS
	r0P08nxORrZ2ygoe2zrpnTDj8hWL2si8xSm6J/lGxla+SVKehPHX
X-Google-Smtp-Source: AGHT+IHBVQnX6U+5ZuBsF7tNjPtOunE/B/o91NDafDH9W4gR/xabrIQ7eit/M+UkVW/nPPqxZzioLA==
X-Received: by 2002:a05:6512:2388:b0:512:be8e:79da with SMTP id c8-20020a056512238800b00512be8e79damr6134926lfv.8.1709484794074;
        Sun, 03 Mar 2024 08:53:14 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:82:7577:d4e3:724b:4d69:34b2])
        by smtp.gmail.com with ESMTPSA id lh15-20020a170906f8cf00b00a44f14c8d64sm1413992ejb.135.2024.03.03.08.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 08:53:13 -0800 (PST)
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
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH 4/4] iio: pressure: Add triggered buffer support for BMP280 driver
Date: Sun,  3 Mar 2024 17:53:00 +0100
Message-Id: <20240303165300.468011-5-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240303165300.468011-1-vassilisamir@gmail.com>
References: <20240303165300.468011-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a buffer struct that will hold the values of the measurements
and will be pushed to userspace. Modify all read_* functions in order
to just read and compensate the data without though converting to the
required IIO measurement units which are used for the oneshot captures.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/Kconfig       |   2 +
 drivers/iio/pressure/bmp280-core.c | 155 +++++++++++++++++++++++------
 drivers/iio/pressure/bmp280.h      |   7 ++
 3 files changed, 134 insertions(+), 30 deletions(-)

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
index 3bdf6002983f..3b1a159e57ea 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -31,8 +31,12 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/gpio/consumer.h>
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h> /* For irq_get_irq_data() */
 #include <linux/module.h>
@@ -457,13 +461,16 @@ static int bmp280_read_temp(struct bmp280_data *data,
 
 	/*
 	 * val might be NULL if we're called by the read_press routine,
-	 * who only cares about the carry over t_fine value.
+	 * who only cares about the carry over t_fine value or if we're called
+	 * by the buffer handler function.
 	 */
 	if (val) {
 		*val = comp_temp * 10;
 		return IIO_VAL_INT;
 	}
 
+	data->iio_buffer.temperature = comp_temp;
+
 	return 0;
 }
 
@@ -494,10 +501,16 @@ static int bmp280_read_press(struct bmp280_data *data,
 	}
 	comp_press = bmp280_compensate_press(data, adc_press);
 
-	*val = comp_press;
-	*val2 = 256000;
+	/* val might be NULL if we're called by the buffer handler */
+	if (val) {
+		*val = comp_press;
+		*val2 = 256000;
+		return IIO_VAL_FRACTIONAL;
+	}
+
+	data->iio_buffer.pressure = comp_press;
 
-	return IIO_VAL_FRACTIONAL;
+	return 0;
 }
 
 static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
@@ -526,9 +539,15 @@ static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
 	}
 	comp_humidity = bmp280_compensate_humidity(data, adc_humidity);
 
-	*val = comp_humidity * 1000 / 1024;
+	/* val might be NULL if we're called by the buffer handler */
+	if (val) {
+		*val = comp_humidity * 1000 / 1024;
+		return IIO_VAL_INT;
+	}
 
-	return IIO_VAL_INT;
+	data->iio_buffer.humidity = comp_humidity;
+
+	return 0;
 }
 
 static int bmp280_read_raw(struct iio_dev *indio_dev,
@@ -1170,7 +1189,8 @@ static int bmp380_read_temp(struct bmp280_data *data, int *val, int *val2)
 
 	/*
 	 * Val might be NULL if we're called by the read_press routine,
-	 * who only cares about the carry over t_fine value.
+	 * who only cares about the carry over t_fine value or if we're called
+	 * by the buffer handler.
 	 */
 	if (val) {
 		/* IIO reports temperatures in milli Celsius */
@@ -1178,6 +1198,8 @@ static int bmp380_read_temp(struct bmp280_data *data, int *val, int *val2)
 		return IIO_VAL_INT;
 	}
 
+	data->iio_buffer.temperature = comp_temp;
+
 	return 0;
 }
 
@@ -1206,11 +1228,17 @@ static int bmp380_read_press(struct bmp280_data *data, int *val, int *val2)
 	}
 	comp_press = bmp380_compensate_press(data, adc_press);
 
-	*val = comp_press;
-	/* Compensated pressure is in cPa (centipascals) */
-	*val2 = 100000;
+	/* val might be NULL if we're called by the buffer handler */
+	if (val) {
+		*val = comp_press;
+		/* Compensated pressure is in cPa (centipascals) */
+		*val2 = 100000;
+		return IIO_VAL_FRACTIONAL;
+	}
+
+	data->iio_buffer.pressure = comp_press;
 
-	return IIO_VAL_FRACTIONAL;
+	return 0;
 }
 
 static int bmp380_read_calib(struct bmp280_data *data)
@@ -1543,14 +1571,21 @@ static int bmp580_read_temp(struct bmp280_data *data, int *val, int *val2)
 		return -EIO;
 	}
 
-	/*
-	 * Temperature is returned in Celsius degrees in fractional
-	 * form down 2^16. We rescale by x1000 to return milli Celsius
-	 * to respect IIO ABI.
-	 */
-	*val = raw_temp * 1000;
-	*val2 = 16;
-	return IIO_VAL_FRACTIONAL_LOG2;
+	/* val might be NULL if we're called by the buffer handler */
+	if (val) {
+		/*
+		* Temperature is returned in Celsius degrees in fractional
+		* form down 2^16. We rescale by x1000 to return milli Celsius
+		* to respect IIO ABI.
+		*/
+		*val = raw_temp * 1000;
+		*val2 = 16;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	}
+
+	data->iio_buffer.temperature = raw_temp;
+
+	return 0;
 }
 
 static int bmp580_read_press(struct bmp280_data *data, int *val, int *val2)
@@ -1570,13 +1605,21 @@ static int bmp580_read_press(struct bmp280_data *data, int *val, int *val2)
 		dev_err(data->dev, "reading pressure skipped\n");
 		return -EIO;
 	}
-	/*
-	 * Pressure is returned in Pascals in fractional form down 2^16.
-	 * We rescale /1000 to convert to kilopascal to respect IIO ABI.
-	 */
-	*val = raw_press;
-	*val2 = 64000; /* 2^6 * 1000 */
-	return IIO_VAL_FRACTIONAL;
+
+	/* val might be NULL if we're called by the buffer handler */
+	if (val) {
+		/*
+		 * Pressure is returned in Pascals in fractional form down 2^16.
+		 * We rescale /1000 to convert to kilopascal to respect IIO ABI.
+		*/
+		*val = raw_press;
+		*val2 = 64000; /* 2^6 * 1000 */
+		return IIO_VAL_FRACTIONAL;
+	}
+
+	data->iio_buffer.pressure = raw_press;
+
+	return 0;
 }
 
 static const int bmp580_odr_table[][2] = {
@@ -2048,13 +2091,16 @@ static int bmp180_read_temp(struct bmp280_data *data, int *val, int *val2)
 
 	/*
 	 * val might be NULL if we're called by the read_press routine,
-	 * who only cares about the carry over t_fine value.
+	 * who only cares about the carry over t_fine value or if we're called
+	 * by the buffer handler.
 	 */
 	if (val) {
 		*val = comp_temp * 100;
 		return IIO_VAL_INT;
 	}
 
+	data->iio_buffer.temperature = comp_temp;
+
 	return 0;
 }
 
@@ -2133,10 +2179,16 @@ static int bmp180_read_press(struct bmp280_data *data,
 
 	comp_press = bmp180_compensate_press(data, adc_press);
 
-	*val = comp_press;
-	*val2 = 1000;
+	/* val might be NULL if we're called by the buffer handler */
+	if (val) {
+		*val = comp_press;
+		*val2 = 1000;
+		return IIO_VAL_FRACTIONAL;
+	}
+
+	data->iio_buffer.pressure = comp_press;
 
-	return IIO_VAL_FRACTIONAL;
+	return 0;
 }
 
 static int bmp180_chip_config(struct bmp280_data *data)
@@ -2217,6 +2269,43 @@ static int bmp085_fetch_eoc_irq(struct device *dev,
 	return 0;
 }
 
+static irqreturn_t bmp280_buffer_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct bmp280_data *data = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&data->lock);
+
+	if (test_bit(BMP280_TEMP, indio_dev->active_scan_mask)) {
+		ret = data->chip_info->read_temp(data, NULL, NULL);
+		if (ret < 0)
+			goto done;
+	}
+
+	if (test_bit(BMP280_PRESS, indio_dev->active_scan_mask)) {
+		ret = data->chip_info->read_press(data, NULL, NULL);
+		if (ret < 0)
+			goto done;
+	}
+
+	if (test_bit(BME280_HUMID, indio_dev->active_scan_mask)) {
+		ret = data->chip_info->read_humid(data, NULL, NULL);
+		if (ret < 0)
+			goto done;
+	}
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->iio_buffer,
+					   pf->timestamp);
+
+done:
+	mutex_unlock(&data->lock);
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+
+}
 static void bmp280_pm_disable(void *data)
 {
 	struct device *dev = data;
@@ -2358,6 +2447,12 @@ int bmp280_common_probe(struct device *dev,
 			return ret;
 	}
 
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					      iio_pollfunc_store_time,
+					      &bmp280_buffer_handler, NULL);
+	if (ret)
+		return dev_err_probe(data->dev, ret,
+				     "iio triggered buffer setup failed\n");
 	/* Enable runtime PM */
 	pm_runtime_get_noresume(dev);
 	pm_runtime_set_active(dev);
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index d77402cb3121..d5c0451ebf68 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -400,6 +400,13 @@ struct bmp280_data {
 	 */
 	s32 t_fine;
 
+	/* IIO sysfs buffer */
+	struct {
+		s32 temperature;
+		u32 pressure;
+		u32 humidity;
+		s64 timestamp;
+	} iio_buffer;
 	/*
 	 * DMA (thus cache coherency maintenance) may require the
 	 * transfer buffers to live in their own cache lines.
-- 
2.25.1


