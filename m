Return-Path: <linux-kernel+bounces-64895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCFF854467
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0372F1F2A6A5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D4E12B96;
	Wed, 14 Feb 2024 08:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmNMoxy4"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E640612B98;
	Wed, 14 Feb 2024 08:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707900859; cv=none; b=WKiR4wNrPyDV9FfvHrU+cFe7v8bCQfkV/fMKh/tr+Qhyviqm/PCnULQ3Tp1zH0MkegxCoUN+cF0O7YV8lPaQXgvAEIn7XjM5WsyaAqMQ5p9yyIwiwQ39isGw8mD4ugGIAuG2of6H8xoPU3dA6of8HB+hDpst2Pe5aN3NJ5w1NqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707900859; c=relaxed/simple;
	bh=27TB8y3R5pl3bqJcGL/bPZHjMjG/ti4dr0pzQuI9Rm0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ml8/4huYITG4ggTD6vtw7noJA8MSrysd69tx6nWBkUk5mweTiNbpcV+kGrTUtvy6XyAvSwJNNEkdUjyk0Mevxg+H5hyw2Priv3oKvv0HeW5n3TcF3ov6ZpB55ecysw2F3heuXwuIRNWz6MkEwombv4WszSBc4hsFc8JrhJHsfBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmNMoxy4; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3d54555692so24296266b.1;
        Wed, 14 Feb 2024 00:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707900855; x=1708505655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CE2NV3RRaf38fxRK5UVybyzXRuOyJW56L0G7b0zCM/g=;
        b=CmNMoxy4z1yNsaV+ql0f8MuoQKGuIwwr3uAE2vr3gwiFspS4f2siOxOsXcPI12afat
         PBZ70TvOLz3ZOaM+EYQUgQV74bexDgvv/dbKhSXolGuDcP3Bt8+KDo6BuwbUswtYbn1z
         wMw06hVWuy89viFuoRmReLBhnWOXUuNgJT6sV5798uG2fUBLnJy+a/YXfksTysoyGgkW
         mM7FzLCj2RZVRP2u5E/IMyGIm4AGIe2/5Ep2qpyqIIGWxipNLxLln3BP20PCFFkps0fh
         X3GWu6xtCH18suGWbU6Bnpp1CKE/EPpcP4r4zpuSoJRofKUmBRu93Iy3R9XeInSJTBMl
         xBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707900855; x=1708505655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CE2NV3RRaf38fxRK5UVybyzXRuOyJW56L0G7b0zCM/g=;
        b=I4opP3uiTAUPc9rOKiFpCAXrbhyyJGCRi6YqtXFK8ZiYBt/PQqj3iWrc63kRW68ATt
         X1mIiqWosUVfowbbNuSpJ4lToIJFzVomhqAd1KQjg6kelBblUVdb1gUvH+Np9Me9QNMy
         CuGZzT4uoMeSjAyG00Mi4kq2VXSfFJvE6QzcQt127iLEJ/O3I5dcnykYUj3RUi1h2Flt
         o1xRm31qcX681jX0t7t4mgJYYJjrLTSdYUYdiJSXZ67yuZODEeMSKsJER7MJKzKXdFmp
         Wven0EiJ3UrQDVko1CNqRqB/8bqsBhBqZhnecWZggsRWug7L/BR75yjxwUrC6CQhKoG0
         KvQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9Xpz6Xm7qzukD2mXmbkH3aEEfwerB1TuyxIS6sPBTeX2mFz4GVVciBSwt6NUe78lVXc0YPqQRA8t3fs0w6Gaf5GGrR3WIRKnB7wxUPRUtLB4jqryuDZZUWDa9R2CuDfkq5fYGerKj
X-Gm-Message-State: AOJu0YzitUFVhX/oATtsFXI/TT+fgP2KKpd9uddw0sa9ibC8provWPeP
	5R9UbgBBYa+gZSMWRbcf8B8KBbY36xI9TZYLrKeTlg5I1zh0VaEe
X-Google-Smtp-Source: AGHT+IFM/FCLSiunhvKT4RhDXum8svplDtQFSHbnlcpXjRAaGu+P0zauc4RNG36fA4H/gwivsPG3aA==
X-Received: by 2002:a17:906:378a:b0:a3d:14ce:d95 with SMTP id n10-20020a170906378a00b00a3d14ce0d95mr1278136ejc.47.1707900855060;
        Wed, 14 Feb 2024 00:54:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUuzonwDxhVRQGXt7tO1Pt36qkuxtjOmCEpxZTBdnLkS1i1b7DKwrf76spj27oQ7aj8KAVfUWmXgnQd1J6c3X2pzaZaQwIvgtMBB4HNTPMXbICrCj03zn/+0MEL5k8gpm4v+MDz0/4x5XsnmdJmJF7jIO0Aywlj3BsvSbgN1CDV8BTdUb926KaswdmyDAeGcF+GW35PB8USSinCH+iNHDPKA68O5qcIK34iX1o9kCWabrgK592F1zGx5pIJQVrC4q5YAQ5LK7cn5YhKQeJ8httf
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id tj3-20020a170907c24300b00a3cf5450b28sm1617264ejc.189.2024.02.14.00.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 00:54:14 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Nuno Sa <nuno.sa@analog.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Li peiyu <579lpy@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] iio: humidity: hdc3020: add threshold events support
Date: Wed, 14 Feb 2024 09:53:45 +0100
Message-Id: <20240214085350.19382-4-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240214085350.19382-1-dima.fedrau@gmail.com>
References: <20240214085350.19382-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add threshold events support for temperature and relative humidity. To
enable them the higher and lower threshold registers must be programmed
and the higher threshold must be greater then or equal to the lower
threshold. Otherwise the event is disabled. Invalid hysteresis values
are ignored by the device. There is no further configuration possible.

Tested by setting thresholds/hysteresis and turning the heater on/off.
Used iio_event_monitor in tools/iio to catch events while constantly
displaying temperature and humidity values.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/iio/humidity/hdc3020.c | 247 +++++++++++++++++++++++++++++++++
 1 file changed, 247 insertions(+)

diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc3020.c
index 4ae4dd3187db..1e5d0d4797b1 100644
--- a/drivers/iio/humidity/hdc3020.c
+++ b/drivers/iio/humidity/hdc3020.c
@@ -5,38 +5,67 @@
  *
  * Copyright (C) 2023
  *
+ * Copyright (C) 2024 Liebherr-Electronics and Drives GmbH
+ *
  * Datasheet: https://www.ti.com/lit/ds/symlink/hdc3020.pdf
  */
 
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/cleanup.h>
 #include <linux/crc8.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/units.h>
 
 #include <asm/unaligned.h>
 
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 
 #define HDC3020_S_AUTO_10HZ_MOD0	0x2737
+#define HDC3020_S_STATUS		0x3041
 #define HDC3020_HEATER_DISABLE		0x3066
 #define HDC3020_HEATER_ENABLE		0x306D
 #define HDC3020_HEATER_CONFIG		0x306E
 #define HDC3020_EXIT_AUTO		0x3093
+#define HDC3020_S_T_RH_THRESH_LOW	0x6100
+#define HDC3020_S_T_RH_THRESH_LOW_CLR	0x610B
+#define HDC3020_S_T_RH_THRESH_HIGH_CLR	0x6116
+#define HDC3020_S_T_RH_THRESH_HIGH	0x611D
 #define HDC3020_R_T_RH_AUTO		0xE000
 #define HDC3020_R_T_LOW_AUTO		0xE002
 #define HDC3020_R_T_HIGH_AUTO		0xE003
 #define HDC3020_R_RH_LOW_AUTO		0xE004
 #define HDC3020_R_RH_HIGH_AUTO		0xE005
+#define HDC3020_R_T_RH_THRESH_LOW	0xE102
+#define HDC3020_R_T_RH_THRESH_LOW_CLR	0xE109
+#define HDC3020_R_T_RH_THRESH_HIGH_CLR	0xE114
+#define HDC3020_R_T_RH_THRESH_HIGH	0xE11F
+#define HDC3020_R_STATUS		0xF32D
+
+#define HDC3020_THRESH_TEMP_MASK	GENMASK(8, 0)
+#define HDC3020_THRESH_TEMP_TRUNC_SHIFT	7
+#define HDC3020_THRESH_HUM_MASK		GENMASK(15, 9)
+#define HDC3020_THRESH_HUM_TRUNC_SHIFT	9
+
+#define HDC3020_STATUS_T_LOW_ALERT	BIT(6)
+#define HDC3020_STATUS_T_HIGH_ALERT	BIT(7)
+#define HDC3020_STATUS_RH_LOW_ALERT	BIT(8)
+#define HDC3020_STATUS_RH_HIGH_ALERT	BIT(9)
 
 #define HDC3020_READ_RETRY_TIMES	10
 #define HDC3020_BUSY_DELAY_MS		10
 
 #define HDC3020_CRC8_POLYNOMIAL		0x31
 
+#define HDC3020_MIN_TEMP		-40
+#define HDC3020_MAX_TEMP		125
+
 struct hdc3020_data {
 	struct i2c_client *client;
 	/*
@@ -50,18 +79,37 @@ struct hdc3020_data {
 
 static const int hdc3020_heater_vals[] = {0, 1, 0x3FFF};
 
+static const struct iio_event_spec hdc3020_t_rh_event[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+		BIT(IIO_EV_INFO_HYSTERESIS),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+		BIT(IIO_EV_INFO_HYSTERESIS),
+	},
+};
+
 static const struct iio_chan_spec hdc3020_channels[] = {
 	{
 		.type = IIO_TEMP,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_PEAK) |
 		BIT(IIO_CHAN_INFO_TROUGH) | BIT(IIO_CHAN_INFO_OFFSET),
+		.event_spec = hdc3020_t_rh_event,
+		.num_event_specs = ARRAY_SIZE(hdc3020_t_rh_event),
 	},
 	{
 		.type = IIO_HUMIDITYRELATIVE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_PEAK) |
 		BIT(IIO_CHAN_INFO_TROUGH),
+		.event_spec = hdc3020_t_rh_event,
+		.num_event_specs = ARRAY_SIZE(hdc3020_t_rh_event),
 	},
 	{
 		/*
@@ -315,10 +363,192 @@ static int hdc3020_write_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static int hdc3020_write_thresh(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan,
+				enum iio_event_type type,
+				enum iio_event_direction dir,
+				enum iio_event_info info,
+				int val, int val2)
+{
+	struct hdc3020_data *data = iio_priv(indio_dev);
+	u8 buf[5];
+	u64 tmp;
+	u16 reg;
+	int ret;
+
+	/* Supported temperature range is from –40 to 125 degree celsius */
+	if (val < HDC3020_MIN_TEMP || val > HDC3020_MAX_TEMP)
+		return -EINVAL;
+
+	/* Select threshold register */
+	if (info == IIO_EV_INFO_VALUE) {
+		if (dir == IIO_EV_DIR_RISING)
+			reg = HDC3020_S_T_RH_THRESH_HIGH;
+		else
+			reg = HDC3020_S_T_RH_THRESH_LOW;
+	} else {
+		if (dir == IIO_EV_DIR_RISING)
+			reg = HDC3020_S_T_RH_THRESH_HIGH_CLR;
+		else
+			reg = HDC3020_S_T_RH_THRESH_LOW_CLR;
+	}
+
+	guard(mutex)(&data->lock);
+	ret = hdc3020_read_be16(data, reg);
+	if (ret < 0)
+		return ret;
+
+	switch (chan->type) {
+	case IIO_TEMP:
+		/*
+		 * Calculate temperature threshold, shift it down to get the
+		 * truncated threshold representation in the 9LSBs while keeping
+		 * the current humidity threshold in the 7 MSBs.
+		 */
+		tmp = ((u64)(((val + 45) * MICRO) + val2)) * 65535ULL;
+		tmp = div_u64(tmp, MICRO * 175);
+		val = tmp >> HDC3020_THRESH_TEMP_TRUNC_SHIFT;
+		val = FIELD_PREP(HDC3020_THRESH_TEMP_MASK, val);
+		val |= (FIELD_GET(HDC3020_THRESH_HUM_MASK, ret) <<
+			HDC3020_THRESH_HUM_TRUNC_SHIFT);
+		break;
+	case IIO_HUMIDITYRELATIVE:
+		/*
+		 * Calculate humidity threshold, shift it down and up to get the
+		 * truncated threshold representation in the 7MSBs while keeping
+		 * the current temperature threshold in the 9 LSBs.
+		 */
+		tmp = ((u64)((val * MICRO) + val2)) * 65535ULL;
+		tmp = div_u64(tmp, MICRO * 100);
+		val = tmp >> HDC3020_THRESH_HUM_TRUNC_SHIFT;
+		val = FIELD_PREP(HDC3020_THRESH_HUM_MASK, val);
+		val |= FIELD_GET(HDC3020_THRESH_TEMP_MASK, ret);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	put_unaligned_be16(reg, buf);
+	put_unaligned_be16(val, buf + 2);
+	buf[4] = crc8(hdc3020_crc8_table, buf + 2, 2, CRC8_INIT_VALUE);
+	return hdc3020_write_bytes(data, buf, 5);
+}
+
+static int hdc3020_read_thresh(struct iio_dev *indio_dev,
+			       const struct iio_chan_spec *chan,
+			       enum iio_event_type type,
+			       enum iio_event_direction dir,
+			       enum iio_event_info info,
+			       int *val, int *val2)
+{
+	struct hdc3020_data *data = iio_priv(indio_dev);
+	u16 reg;
+	int ret;
+
+	/* Select threshold register */
+	if (info == IIO_EV_INFO_VALUE) {
+		if (dir == IIO_EV_DIR_RISING)
+			reg = HDC3020_R_T_RH_THRESH_HIGH;
+		else
+			reg = HDC3020_R_T_RH_THRESH_LOW;
+	} else {
+		if (dir == IIO_EV_DIR_RISING)
+			reg = HDC3020_R_T_RH_THRESH_HIGH_CLR;
+		else
+			reg = HDC3020_R_T_RH_THRESH_LOW_CLR;
+	}
+
+	guard(mutex)(&data->lock);
+	ret = hdc3020_read_be16(data, reg);
+	if (ret < 0)
+		return ret;
+
+	switch (chan->type) {
+	case IIO_TEMP:
+		/*
+		 * Get the temperature threshold from 9 LSBs, shift them to get
+		 * the truncated temperature threshold representation and
+		 * calculate the threshold according to the formula in the
+		 * datasheet.
+		 */
+		*val = FIELD_GET(HDC3020_THRESH_TEMP_MASK, ret);
+		*val = *val << HDC3020_THRESH_TEMP_TRUNC_SHIFT;
+		*val = -2949075 + (175 * (*val));
+		*val2 = 65535;
+		return IIO_VAL_FRACTIONAL;
+	case IIO_HUMIDITYRELATIVE:
+		/*
+		 * Get the humidity threshold from 7 MSBs, shift them to get the
+		 * truncated humidity threshold representation and calculate the
+		 * threshold according to the formula in the datasheet.
+		 */
+		*val = FIELD_GET(HDC3020_THRESH_HUM_MASK, ret);
+		*val = (*val << HDC3020_THRESH_HUM_TRUNC_SHIFT) * 100;
+		*val2 = 65535;
+		return IIO_VAL_FRACTIONAL;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static irqreturn_t hdc3020_interrupt_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct hdc3020_data *data;
+	s64 time;
+	int ret;
+
+	data = iio_priv(indio_dev);
+	ret = hdc3020_read_be16(data, HDC3020_R_STATUS);
+	if (ret < 0)
+		return IRQ_HANDLED;
+
+	if (!(ret & (HDC3020_STATUS_T_HIGH_ALERT | HDC3020_STATUS_T_LOW_ALERT |
+		HDC3020_STATUS_RH_HIGH_ALERT | HDC3020_STATUS_RH_LOW_ALERT)))
+		return IRQ_NONE;
+
+	time = iio_get_time_ns(indio_dev);
+	if (ret & HDC3020_STATUS_T_HIGH_ALERT)
+		iio_push_event(indio_dev,
+			       IIO_MOD_EVENT_CODE(IIO_TEMP, 0,
+						  IIO_NO_MOD,
+						  IIO_EV_TYPE_THRESH,
+						  IIO_EV_DIR_RISING),
+						  time);
+
+	if (ret & HDC3020_STATUS_T_LOW_ALERT)
+		iio_push_event(indio_dev,
+			       IIO_MOD_EVENT_CODE(IIO_TEMP, 0,
+						  IIO_NO_MOD,
+						  IIO_EV_TYPE_THRESH,
+						  IIO_EV_DIR_FALLING),
+						  time);
+
+	if (ret & HDC3020_STATUS_RH_HIGH_ALERT)
+		iio_push_event(indio_dev,
+			       IIO_MOD_EVENT_CODE(IIO_HUMIDITYRELATIVE, 0,
+						  IIO_NO_MOD,
+						  IIO_EV_TYPE_THRESH,
+						  IIO_EV_DIR_RISING),
+						  time);
+
+	if (ret & HDC3020_STATUS_RH_LOW_ALERT)
+		iio_push_event(indio_dev,
+			       IIO_MOD_EVENT_CODE(IIO_HUMIDITYRELATIVE, 0,
+						  IIO_NO_MOD,
+						  IIO_EV_TYPE_THRESH,
+						  IIO_EV_DIR_FALLING),
+						  time);
+
+	return IRQ_HANDLED;
+}
+
 static const struct iio_info hdc3020_info = {
 	.read_raw = hdc3020_read_raw,
 	.write_raw = hdc3020_write_raw,
 	.read_avail = hdc3020_read_available,
+	.read_event_value = hdc3020_read_thresh,
+	.write_event_value = hdc3020_write_thresh,
 };
 
 static void hdc3020_stop(void *data)
@@ -350,6 +580,23 @@ static int hdc3020_probe(struct i2c_client *client)
 	indio_dev->info = &hdc3020_info;
 	indio_dev->channels = hdc3020_channels;
 	indio_dev->num_channels = ARRAY_SIZE(hdc3020_channels);
+	if (client->irq) {
+		ret = devm_request_threaded_irq(&client->dev, client->irq,
+						NULL, hdc3020_interrupt_handler,
+						IRQF_ONESHOT, "hdc3020",
+						indio_dev);
+		if (ret)
+			return dev_err_probe(&client->dev, ret,
+					     "Failed to request IRQ\n");
+
+		/*
+		 * The alert output is activated by default upon power up,
+		 * hardware reset, and soft reset. Clear the status register.
+		 */
+		ret = hdc3020_exec_cmd(data, HDC3020_S_STATUS);
+		if (ret)
+			return ret;
+	}
 
 	ret = hdc3020_exec_cmd(data, HDC3020_S_AUTO_10HZ_MOD0);
 	if (ret)
-- 
2.39.2


