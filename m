Return-Path: <linux-kernel+bounces-64893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0570854461
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8556B28DB4E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49A0B645;
	Wed, 14 Feb 2024 08:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evW/NNZH"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC64A111B0;
	Wed, 14 Feb 2024 08:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707900844; cv=none; b=os+2hshg/osQpZHieNDIbaMVDGBQSgce2DtNHi9rLfofhcQwYLlYtVz3n+7z53Eo3TT6qjdP27Z2AR4SRa91gXBYgqlRCRDBJcLB7Z6LxJzCQoNzt4J30rLg63bRgbXqalrQbGvRDYLzGMzfIV36X6mEFLx6uCpUmqdSB7RfTdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707900844; c=relaxed/simple;
	bh=/I94xPVjnIq2HIvcr6fMZBPjlXY+pJTqZwOleEM2c3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D7QeJZEYzDwkqfraNJIs1kwpYRK3/T8XsKFB0TylMzRu2xUAUk4t/oSWNbkZXfGHfSBBWsAfH/X+hzcefQW7kdVzoqgtLwnph5szWqTZDE0IUe3Uoqo+rcVmA6sXweetwyZsqbpFaRzfXc1ByigmCv+ogybTCOZt4l7AbLEAWb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evW/NNZH; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-561f4bc306fso1844900a12.1;
        Wed, 14 Feb 2024 00:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707900841; x=1708505641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cvQcXYmE+WFFmcvLefoIoD/Qtdtc6QI44VWrdwhE3w=;
        b=evW/NNZHciFTThwqAQKL3qFXjR5BnQprcPORtMWcvgf+O6Xa5imP7KQ0xULLOZNiAd
         dRt/Jawv17igdHJZCbYVMvgJCYnZZoCpwDuLoTD57/X5XFy6hRtw6KOx1IoRkOvrdVUS
         uRCi+cLKXfytPg43Q7DbZ/UIyhp/DIaB2T04WPxWFcmU+kXDprZMsmxwrqUobz1q596i
         ViIax8Wc0rmO1xt/nMyT+M+zIr6prerq3bnsxXojdAb3R6B2FUCJF4hiSb1sgPRGYkrR
         wtCMM68yY5sVe0E1m5AaWsrTawZrJTAMxxolJsEWEzSWgaQHeMBYeqWrsP0LnHJUopdk
         1D9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707900841; x=1708505641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+cvQcXYmE+WFFmcvLefoIoD/Qtdtc6QI44VWrdwhE3w=;
        b=dvdt5OpNs4SVjUoIrM34v3sRl6OhV6SOzZ/5137OuAFLF9ooWAfI7ijcVX2Bfw0Jgv
         d01u6AVZxYJw70N5GIKgi4nHtq3z7LEpObGyTMNekKTeHcQXcjftOp29Sji+OQdIhgKK
         Eirb4lYolIFyYVePP3JpuTL0ds+p6oPV9jdsTS6RuYNflsQj/v8CnprOI9bMCLOKq7hI
         nTNj+D6yQxGPHCanWijkskBo1kuLZmfjDhMHB4NuWikqrvHzc7d/T/+hyS/RGIlbBWwd
         1vuossH6Nhj533RiS0Yy7R4vPWkWnJBblDE3uiHBzrHqcBC/p1o7+XdVpe3ahaX/Aotd
         bKWA==
X-Forwarded-Encrypted: i=1; AJvYcCW8Xo8r7IlKrIJyw5qbTnfjT0Ww6alvF5nf4OIbf5tbBbr/bwQMFXgklVBRw9iyevryw6LCHV8YDxPKyUpOmaGJyWPeeu2gMVQgo8MuQXg9b2Rx9oebytjZBk8Bicwf/6nDMfqC6Z9w
X-Gm-Message-State: AOJu0Yy6/6yAjkhLAsgCgHhw4jp+vo8RW/NvhuyUkcnMY3suWfgu2qgn
	0EvoQHKLtmFEACk07M2U7KpuXZX586/NRUqCwOGoubddntMrKKRS
X-Google-Smtp-Source: AGHT+IH8EwimYquqU90ikto09jz3bEwyjwWezT7c3AOk30eezhCtXvW5HU5ymplwZcJrrGvTDi7BWQ==
X-Received: by 2002:a17:906:d28d:b0:a35:e7a1:66ec with SMTP id ay13-20020a170906d28d00b00a35e7a166ecmr1237831ejb.44.1707900840722;
        Wed, 14 Feb 2024 00:54:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWw7n5FCY7L9mC+XbXBQvV9YVSwYXyOCK3OYyciQY31HBFuRSKrfuafpljzW7oTiuFz+/ZRZYyafRW0b31t8XgYo2/a2rm+W78djCZ0xa0bpiKSjRjs/dKL1EjEpAL4/BN4ZQB5b7gIgyNzSerpNVndx/VLgmzVSFgT7MlA/EmhchJuXPLfVVZj7ulWhk2c8E5H4MzroyfGRd8x2AJVsndhN/oI079/OkGzy/RfoFw/CzfLxLkh/MIbbMIw4oUK7ULVSTLv6/Pxq9CiiH7DAddA
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id tj3-20020a170907c24300b00a3cf5450b28sm1617264ejc.189.2024.02.14.00.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 00:54:00 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Li peiyu <579lpy@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] iio: humidity: hdc3020: switch to 16bit register defines
Date: Wed, 14 Feb 2024 09:53:43 +0100
Message-Id: <20240214085350.19382-2-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240214085350.19382-1-dima.fedrau@gmail.com>
References: <20240214085350.19382-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch to 16bit register defines and drop the const u8 register pairs.
By doing so we change the parameter of functions for reading and writing
to the device. Additionally create helper functions that are aware of the
new register format and apply them wherever possible.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/iio/humidity/hdc3020.c | 200 +++++++++++----------------------
 1 file changed, 63 insertions(+), 137 deletions(-)

diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc3020.c
index ed70415512f6..4ae4dd3187db 100644
--- a/drivers/iio/humidity/hdc3020.c
+++ b/drivers/iio/humidity/hdc3020.c
@@ -21,26 +21,22 @@
 
 #include <linux/iio/iio.h>
 
-#define HDC3020_HEATER_CMD_MSB		0x30 /* shared by all heater commands */
-#define HDC3020_HEATER_ENABLE		0x6D
-#define HDC3020_HEATER_DISABLE		0x66
-#define HDC3020_HEATER_CONFIG		0x6E
+#define HDC3020_S_AUTO_10HZ_MOD0	0x2737
+#define HDC3020_HEATER_DISABLE		0x3066
+#define HDC3020_HEATER_ENABLE		0x306D
+#define HDC3020_HEATER_CONFIG		0x306E
+#define HDC3020_EXIT_AUTO		0x3093
+#define HDC3020_R_T_RH_AUTO		0xE000
+#define HDC3020_R_T_LOW_AUTO		0xE002
+#define HDC3020_R_T_HIGH_AUTO		0xE003
+#define HDC3020_R_RH_LOW_AUTO		0xE004
+#define HDC3020_R_RH_HIGH_AUTO		0xE005
 
 #define HDC3020_READ_RETRY_TIMES	10
 #define HDC3020_BUSY_DELAY_MS		10
 
 #define HDC3020_CRC8_POLYNOMIAL		0x31
 
-static const u8 HDC3020_S_AUTO_10HZ_MOD0[2] = { 0x27, 0x37 };
-
-static const u8 HDC3020_EXIT_AUTO[2] = { 0x30, 0x93 };
-
-static const u8 HDC3020_R_T_RH_AUTO[2] = { 0xE0, 0x00 };
-static const u8 HDC3020_R_T_LOW_AUTO[2] = { 0xE0, 0x02 };
-static const u8 HDC3020_R_T_HIGH_AUTO[2] = { 0xE0, 0x03 };
-static const u8 HDC3020_R_RH_LOW_AUTO[2] = { 0xE0, 0x04 };
-static const u8 HDC3020_R_RH_HIGH_AUTO[2] = { 0xE0, 0x05 };
-
 struct hdc3020_data {
 	struct i2c_client *client;
 	/*
@@ -82,7 +78,7 @@ static const struct iio_chan_spec hdc3020_channels[] = {
 
 DECLARE_CRC8_TABLE(hdc3020_crc8_table);
 
-static int hdc3020_write_bytes(struct hdc3020_data *data, const u8 *buf, u8 len)
+static int hdc3020_write_bytes(struct hdc3020_data *data, u8 *buf, u8 len)
 {
 	struct i2c_client *client = data->client;
 	struct i2c_msg msg;
@@ -90,7 +86,7 @@ static int hdc3020_write_bytes(struct hdc3020_data *data, const u8 *buf, u8 len)
 
 	msg.addr = client->addr;
 	msg.flags = 0;
-	msg.buf = (char *)buf;
+	msg.buf = buf;
 	msg.len = len;
 
 	/*
@@ -109,26 +105,28 @@ static int hdc3020_write_bytes(struct hdc3020_data *data, const u8 *buf, u8 len)
 	return -ETIMEDOUT;
 }
 
-static int hdc3020_read_bytes(struct hdc3020_data *data, const u8 *buf,
-			      void *val, int len)
+static
+int hdc3020_read_bytes(struct hdc3020_data *data, u16 reg, u8 *buf, int len)
 {
+	u8 reg_buf[2];
 	int ret, cnt;
 	struct i2c_client *client = data->client;
 	struct i2c_msg msg[2] = {
 		[0] = {
 			.addr = client->addr,
 			.flags = 0,
-			.buf = (char *)buf,
+			.buf = reg_buf,
 			.len = 2,
 		},
 		[1] = {
 			.addr = client->addr,
 			.flags = I2C_M_RD,
-			.buf = val,
+			.buf = buf,
 			.len = len,
 		},
 	};
 
+	put_unaligned_be16(reg, reg_buf);
 	/*
 	 * During the measurement process, HDC3020 will not return data.
 	 * So wait for a while and try again
@@ -145,48 +143,12 @@ static int hdc3020_read_bytes(struct hdc3020_data *data, const u8 *buf,
 	return -ETIMEDOUT;
 }
 
-static int hdc3020_read_measurement(struct hdc3020_data *data,
-				    enum iio_chan_type type, int *val)
-{
-	u8 crc, buf[6];
-	int ret;
-
-	ret = hdc3020_read_bytes(data, HDC3020_R_T_RH_AUTO, buf, 6);
-	if (ret < 0)
-		return ret;
-
-	/* CRC check of the temperature measurement */
-	crc = crc8(hdc3020_crc8_table, buf, 2, CRC8_INIT_VALUE);
-	if (crc != buf[2])
-		return -EINVAL;
-
-	/* CRC check of the relative humidity measurement */
-	crc = crc8(hdc3020_crc8_table, buf + 3, 2, CRC8_INIT_VALUE);
-	if (crc != buf[5])
-		return -EINVAL;
-
-	if (type == IIO_TEMP)
-		*val = get_unaligned_be16(buf);
-	else if (type == IIO_HUMIDITYRELATIVE)
-		*val = get_unaligned_be16(&buf[3]);
-	else
-		return -EINVAL;
-
-	return 0;
-}
-
-/*
- * After exiting the automatic measurement mode or resetting, the peak
- * value will be reset to the default value
- * This method is used to get the highest temp measured during automatic
- * measurement
- */
-static int hdc3020_read_high_peak_t(struct hdc3020_data *data, int *val)
+static int hdc3020_read_be16(struct hdc3020_data *data, u16 reg)
 {
 	u8 crc, buf[3];
 	int ret;
 
-	ret = hdc3020_read_bytes(data, HDC3020_R_T_HIGH_AUTO, buf, 3);
+	ret = hdc3020_read_bytes(data, reg, buf, 3);
 	if (ret < 0)
 		return ret;
 
@@ -194,73 +156,43 @@ static int hdc3020_read_high_peak_t(struct hdc3020_data *data, int *val)
 	if (crc != buf[2])
 		return -EINVAL;
 
-	*val = get_unaligned_be16(buf);
-
-	return 0;
+	return get_unaligned_be16(buf);
 }
 
-/*
- * This method is used to get the lowest temp measured during automatic
- * measurement
- */
-static int hdc3020_read_low_peak_t(struct hdc3020_data *data, int *val)
+static int hdc3020_exec_cmd(struct hdc3020_data *data, u16 reg)
 {
-	u8 crc, buf[3];
-	int ret;
-
-	ret = hdc3020_read_bytes(data, HDC3020_R_T_LOW_AUTO, buf, 3);
-	if (ret < 0)
-		return ret;
-
-	crc = crc8(hdc3020_crc8_table, buf, 2, CRC8_INIT_VALUE);
-	if (crc != buf[2])
-		return -EINVAL;
-
-	*val = get_unaligned_be16(buf);
+	u8 reg_buf[2];
 
-	return 0;
+	put_unaligned_be16(reg, reg_buf);
+	return hdc3020_write_bytes(data, reg_buf, 2);
 }
 
-/*
- * This method is used to get the highest humidity measured during automatic
- * measurement
- */
-static int hdc3020_read_high_peak_rh(struct hdc3020_data *data, int *val)
+static int hdc3020_read_measurement(struct hdc3020_data *data,
+				    enum iio_chan_type type, int *val)
 {
-	u8 crc, buf[3];
+	u8 crc, buf[6];
 	int ret;
 
-	ret = hdc3020_read_bytes(data, HDC3020_R_RH_HIGH_AUTO, buf, 3);
+	ret = hdc3020_read_bytes(data, HDC3020_R_T_RH_AUTO, buf, 6);
 	if (ret < 0)
 		return ret;
 
+	/* CRC check of the temperature measurement */
 	crc = crc8(hdc3020_crc8_table, buf, 2, CRC8_INIT_VALUE);
 	if (crc != buf[2])
 		return -EINVAL;
 
-	*val = get_unaligned_be16(buf);
-
-	return 0;
-}
-
-/*
- * This method is used to get the lowest humidity measured during automatic
- * measurement
- */
-static int hdc3020_read_low_peak_rh(struct hdc3020_data *data, int *val)
-{
-	u8 crc, buf[3];
-	int ret;
-
-	ret = hdc3020_read_bytes(data, HDC3020_R_RH_LOW_AUTO, buf, 3);
-	if (ret < 0)
-		return ret;
-
-	crc = crc8(hdc3020_crc8_table, buf, 2, CRC8_INIT_VALUE);
-	if (crc != buf[2])
+	/* CRC check of the relative humidity measurement */
+	crc = crc8(hdc3020_crc8_table, buf + 3, 2, CRC8_INIT_VALUE);
+	if (crc != buf[5])
 		return -EINVAL;
 
-	*val = get_unaligned_be16(buf);
+	if (type == IIO_TEMP)
+		*val = get_unaligned_be16(buf);
+	else if (type == IIO_HUMIDITYRELATIVE)
+		*val = get_unaligned_be16(&buf[3]);
+	else
+		return -EINVAL;
 
 	return 0;
 }
@@ -286,28 +218,28 @@ static int hdc3020_read_raw(struct iio_dev *indio_dev,
 	}
 	case IIO_CHAN_INFO_PEAK: {
 		guard(mutex)(&data->lock);
-		if (chan->type == IIO_TEMP) {
-			ret = hdc3020_read_high_peak_t(data, val);
-			if (ret < 0)
-				return ret;
-		} else {
-			ret = hdc3020_read_high_peak_rh(data, val);
-			if (ret < 0)
-				return ret;
-		}
+		if (chan->type == IIO_TEMP)
+			ret = hdc3020_read_be16(data, HDC3020_R_T_HIGH_AUTO);
+		else
+			ret = hdc3020_read_be16(data, HDC3020_R_RH_HIGH_AUTO);
+
+		if (ret < 0)
+			return ret;
+
+		*val = ret;
 		return IIO_VAL_INT;
 	}
 	case IIO_CHAN_INFO_TROUGH: {
 		guard(mutex)(&data->lock);
-		if (chan->type == IIO_TEMP) {
-			ret = hdc3020_read_low_peak_t(data, val);
-			if (ret < 0)
-				return ret;
-		} else {
-			ret = hdc3020_read_low_peak_rh(data, val);
-			if (ret < 0)
-				return ret;
-		}
+		if (chan->type == IIO_TEMP)
+			ret = hdc3020_read_be16(data, HDC3020_R_T_LOW_AUTO);
+		else
+			ret = hdc3020_read_be16(data, HDC3020_R_RH_LOW_AUTO);
+
+		if (ret < 0)
+			return ret;
+
+		*val = ret;
 		return IIO_VAL_INT;
 	}
 	case IIO_CHAN_INFO_SCALE:
@@ -352,23 +284,17 @@ static int hdc3020_update_heater(struct hdc3020_data *data, int val)
 	if (val < hdc3020_heater_vals[0] || val > hdc3020_heater_vals[2])
 		return -EINVAL;
 
-	buf[0] = HDC3020_HEATER_CMD_MSB;
+	if (!val)
+		hdc3020_exec_cmd(data, HDC3020_HEATER_DISABLE);
 
-	if (!val) {
-		buf[1] = HDC3020_HEATER_DISABLE;
-		return hdc3020_write_bytes(data, buf, 2);
-	}
-
-	buf[1] = HDC3020_HEATER_CONFIG;
+	put_unaligned_be16(HDC3020_HEATER_CONFIG, buf);
 	put_unaligned_be16(val & GENMASK(13, 0), &buf[2]);
 	buf[4] = crc8(hdc3020_crc8_table, buf + 2, 2, CRC8_INIT_VALUE);
 	ret = hdc3020_write_bytes(data, buf, 5);
 	if (ret < 0)
 		return ret;
 
-	buf[1] = HDC3020_HEATER_ENABLE;
-
-	return hdc3020_write_bytes(data, buf, 2);
+	return hdc3020_exec_cmd(data, HDC3020_HEATER_ENABLE);
 }
 
 static int hdc3020_write_raw(struct iio_dev *indio_dev,
@@ -397,7 +323,7 @@ static const struct iio_info hdc3020_info = {
 
 static void hdc3020_stop(void *data)
 {
-	hdc3020_write_bytes((struct hdc3020_data *)data, HDC3020_EXIT_AUTO, 2);
+	hdc3020_exec_cmd((struct hdc3020_data *)data, HDC3020_EXIT_AUTO);
 }
 
 static int hdc3020_probe(struct i2c_client *client)
@@ -425,7 +351,7 @@ static int hdc3020_probe(struct i2c_client *client)
 	indio_dev->channels = hdc3020_channels;
 	indio_dev->num_channels = ARRAY_SIZE(hdc3020_channels);
 
-	ret = hdc3020_write_bytes(data, HDC3020_S_AUTO_10HZ_MOD0, 2);
+	ret = hdc3020_exec_cmd(data, HDC3020_S_AUTO_10HZ_MOD0);
 	if (ret)
 		return dev_err_probe(&client->dev, ret,
 				     "Unable to set up measurement\n");
-- 
2.39.2


