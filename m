Return-Path: <linux-kernel+bounces-51005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA8D8484E7
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 10:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5913B2CB0C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 09:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B18F5C8F8;
	Sat,  3 Feb 2024 09:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rc9GfFnP"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43B84BAA8;
	Sat,  3 Feb 2024 09:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706951145; cv=none; b=tkrCn9iC2byt1qKNo9lcfiaYQD7HIZ+TRx4LqURaQS83REBuVretpzOLtso4KrQbmcvLGkCI1ZUuYeIdAFWUL4IPX1OLE9AyA4XgH5Ppx2ucDHO6wip7BMzoSn1Oegvhaj3neAQ1I8Qy3KavLJUEeUcPQYQyatx0xE8emVU0mQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706951145; c=relaxed/simple;
	bh=0LIvJzVS4YdQCz7a9auX6qZszDj1B+wmUCysaen78hY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Zl/3slpn1qg5bQlh47Ppt9fUZmvB0nFd0bxHHmJCABwpA9vAmI9taqgh1zpY7iUtCTUgNcasHpmEyPzFnTqpcNDMxmrQbDXnNDiaL6GY/oGkRjmR9PQyCDie4TdaijhmVCxXzZLoFmTDUqIs40NRUbU1K802qvLUr11WUUe509c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rc9GfFnP; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-558f523c072so4213131a12.2;
        Sat, 03 Feb 2024 01:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706951141; x=1707555941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Q9Qpt0fJtqR9PGSOOdGqGAth7HERHnwhbrnzVdLJMA=;
        b=Rc9GfFnP5GHkdHF1DtJnX2IL08ZTidISYGSyEFgkZBBVFGdQxVxRj4EvHZKT01fwLR
         8k+VO0EBCBubBqz7k/hyAktzMpTkUynG8UjPSUVXJGAyIcVlkIdpDICaViTMeDKy4cXW
         LX+aEqcz9qE8JoxBqpz3mNhvajPBCUb9fSgJf7XgVzlzNspXExZqVOro9UhJKjK3JmVU
         +V+Nfx14/HEn162XkxiI//EfMHrf1HbL+B3brB0OY/xfD3aR1Cc/j9HNQBRGYu5EXXR1
         MxsQvmaLw2gpAVv+UXxHIj+eAtvjd2iEdaEqXBO1OxS1JNK43QtMTxeesvQrB+wivH2k
         Pzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706951141; x=1707555941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Q9Qpt0fJtqR9PGSOOdGqGAth7HERHnwhbrnzVdLJMA=;
        b=FWYG+HpOT3iXtd6Bvi4Aqp0k0dFFNcLRhotChCs/yAJlxeLTQVzxG5Tc+ehTfhBcOI
         PNwyz44/CsvX3FYQN6WYd4yYEQspigDbBSBjJsMOU0cahIvkM12hiN7sUwaWdBYhC7OD
         N0M6X0Hc0OLPKAWeE7IK0ZgUejFuXlQ5BIe2ntJ0DnDbd5sGnYkj6IiHPV2RMtYe5BF4
         gxQBgMbqKWso4KDGE4pSJ7lwV7oVm0F3BQqT4JvBFzTv4Efkz6GyURtNgNVpjId+XXOR
         APybwnjPAQebNz9OBmZcU0Wtfd4VCPBpZVet7xJmk6ABRl6u5WyaqGyV9HrktIT199Uu
         mn8Q==
X-Gm-Message-State: AOJu0YxXhQDX/7+O3wx715YbYx0rOXPwE6ze80Y+79GNY+CRmHQG7XUW
	IHjAYZByuWmBjAUZyYmjpydcFjhzYvdAsfzMEfD08EUfxhxOdcOV
X-Google-Smtp-Source: AGHT+IGWjQIJfY3d5EvR18PKOb7dRP/onldI9ZfzUgkRMCGQk11PdoJEa8wmWRAFo/2jnt+LzNe+CA==
X-Received: by 2002:a17:906:29c5:b0:a36:cff2:5482 with SMTP id y5-20020a17090629c500b00a36cff25482mr4537055eje.68.1706951140438;
        Sat, 03 Feb 2024 01:05:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWOR9bSOjWy2RRnTUNJuK2ZJoQMqW/Po81Edmk6sMVy6rTfg+jS1wsKNDf7klhRGWhew3JQhHo6lxg20CxkwqDHHis4BcS9LvlSZaoQYLkUXOfpDepJzRFX006VT6C1fWpzf7dOGrX19+n1rkk9/RpiIcMrtdCxJ4BazgoUohI79iOPhvqh24px5u+NsnzJLEdCl8ITk7c+ap7btB1QPDcOzVeJuZkdtb3IqKbSnk8q6MGKyMpgUcx/0VldTg==
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id pw8-20020a17090720a800b00a349d05c837sm1767668ejb.154.2024.02.03.01.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 01:05:39 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Li peiyu <579lpy@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: humidity: hdc3020: add threshold events support
Date: Sat,  3 Feb 2024 10:05:29 +0100
Message-Id: <20240203090530.53374-1-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
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
Threshold and hysteresis values are cached in the driver, used i2c-tools
to read the threshold and hysteresis values from the device and make
sure cached values are consistent to values written to the device.

Based on Fix:
a69eeaad093d "iio: humidity: hdc3020: fix temperature offset" in branch
fixes-togreg

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/iio/humidity/hdc3020.c | 339 +++++++++++++++++++++++++++++++++
 1 file changed, 339 insertions(+)

diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc3020.c
index ed70415512f6..1cdff7af4ca8 100644
--- a/drivers/iio/humidity/hdc3020.c
+++ b/drivers/iio/humidity/hdc3020.c
@@ -16,16 +16,27 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/interrupt.h>
 
 #include <asm/unaligned.h>
 
 #include <linux/iio/iio.h>
+#include <linux/iio/events.h>
 
 #define HDC3020_HEATER_CMD_MSB		0x30 /* shared by all heater commands */
 #define HDC3020_HEATER_ENABLE		0x6D
 #define HDC3020_HEATER_DISABLE		0x66
 #define HDC3020_HEATER_CONFIG		0x6E
 
+#define HDC3020_THRESH_TEMP_MASK	GENMASK(8, 0)
+#define HDC3020_THRESH_TEMP_SHIFT	7
+#define HDC3020_THRESH_HUM_MASK		GENMASK(15, 9)
+
+#define HDC3020_STATUS_T_LOW_ALERT	BIT(6)
+#define HDC3020_STATUS_T_HIGH_ALERT	BIT(7)
+#define HDC3020_STATUS_RH_LOW_ALERT	BIT(8)
+#define HDC3020_STATUS_RH_HIGH_ALERT	BIT(9)
+
 #define HDC3020_READ_RETRY_TIMES	10
 #define HDC3020_BUSY_DELAY_MS		10
 
@@ -33,14 +44,28 @@
 
 static const u8 HDC3020_S_AUTO_10HZ_MOD0[2] = { 0x27, 0x37 };
 
+static const u8 HDC3020_S_STATUS[2] = { 0x30, 0x41 };
+
 static const u8 HDC3020_EXIT_AUTO[2] = { 0x30, 0x93 };
 
+static const u8 HDC3020_S_T_RH_THRESH_LOW[2] = { 0x61, 0x00 };
+static const u8 HDC3020_S_T_RH_THRESH_LOW_CLR[2] = { 0x61, 0x0B };
+static const u8 HDC3020_S_T_RH_THRESH_HIGH_CLR[2] = { 0x61, 0x16 };
+static const u8 HDC3020_S_T_RH_THRESH_HIGH[2] = { 0x61, 0x1D };
+
 static const u8 HDC3020_R_T_RH_AUTO[2] = { 0xE0, 0x00 };
 static const u8 HDC3020_R_T_LOW_AUTO[2] = { 0xE0, 0x02 };
 static const u8 HDC3020_R_T_HIGH_AUTO[2] = { 0xE0, 0x03 };
 static const u8 HDC3020_R_RH_LOW_AUTO[2] = { 0xE0, 0x04 };
 static const u8 HDC3020_R_RH_HIGH_AUTO[2] = { 0xE0, 0x05 };
 
+static const u8 HDC3020_R_T_RH_THRESH_LOW[2] = { 0xE1, 0x02 };
+static const u8 HDC3020_R_R_RH_THRESH_LOW_CLR[2] = { 0xE1, 0x09 };
+static const u8 HDC3020_R_T_RH_THRESH_HIGH_CLR[2] = { 0xE1, 0x14 };
+static const u8 HDC3020_R_T_RH_THRESH_HIGH[2] = { 0xE1, 0x1F };
+
+static const u8 HDC3020_R_STATUS[2] = { 0xF3, 0x2D };
+
 struct hdc3020_data {
 	struct i2c_client *client;
 	/*
@@ -50,22 +75,54 @@ struct hdc3020_data {
 	 * if the device does not respond).
 	 */
 	struct mutex lock;
+	/*
+	 * Temperature and humidity thresholds are packed together into a single
+	 * 16 bit value. Each threshold is represented by a truncated 16 bit
+	 * value. The 7 MSBs of a relative humidity threshold are concatenated
+	 * with the 9 MSBs of a temperature threshold, where the temperature
+	 * threshold resides in the 7 LSBs. Due to the truncated representation,
+	 * there is a resolution loss of 0.5 degree celsius in temperature and a
+	 * 1% resolution loss in relative humidity.
+	 */
+	u16 t_rh_thresh_low;
+	u16 t_rh_thresh_high;
+	u16 t_rh_thresh_low_clr;
+	u16 t_rh_thresh_high_clr;
 };
 
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
@@ -389,10 +446,241 @@ static int hdc3020_write_raw(struct iio_dev *indio_dev,
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
+	u16 *thresh;
+	u8 buf[5];
+	int ret;
+
+	/* Supported temperature range is from –40 to 125 degree celsius */
+	if (val < -45 || val > 125)
+		return -EINVAL;
+
+	/* Select threshold and associated register */
+	if (info == IIO_EV_INFO_VALUE) {
+		if (dir == IIO_EV_DIR_RISING) {
+			thresh = &data->t_rh_thresh_high;
+			memcpy(buf, HDC3020_S_T_RH_THRESH_HIGH, 2);
+		} else {
+			thresh = &data->t_rh_thresh_low;
+			memcpy(buf, HDC3020_S_T_RH_THRESH_LOW, 2);
+		}
+	} else {
+		if (dir == IIO_EV_DIR_RISING) {
+			thresh = &data->t_rh_thresh_high_clr;
+			memcpy(buf, HDC3020_S_T_RH_THRESH_HIGH_CLR, 2);
+		} else {
+			thresh = &data->t_rh_thresh_low_clr;
+			memcpy(buf, HDC3020_S_T_RH_THRESH_LOW_CLR, 2);
+		}
+	}
+
+	guard(mutex)(&data->lock);
+	switch (chan->type) {
+	case IIO_TEMP:
+		/*
+		 * Store truncated temperature threshold into 9 LSBs while
+		 * keeping the old humidity threshold in the 7 MSBs.
+		 */
+		val = (((val + 45) * 65535 / 175) >> HDC3020_THRESH_TEMP_SHIFT);
+		val &= HDC3020_THRESH_TEMP_MASK;
+		val |= (*thresh & HDC3020_THRESH_HUM_MASK);
+		break;
+	case IIO_HUMIDITYRELATIVE:
+		/*
+		 * Store truncated humidity threshold into 7 MSBs while
+		 * keeping the old temperature threshold in the 9 LSBs.
+		 */
+		val = ((val * 65535 / 100) & HDC3020_THRESH_HUM_MASK);
+		val |= (*thresh & HDC3020_THRESH_TEMP_MASK);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	put_unaligned_be16(val, &buf[2]);
+	buf[4] = crc8(hdc3020_crc8_table, buf + 2, 2, CRC8_INIT_VALUE);
+	ret = hdc3020_write_bytes(data, buf, 5);
+	if (ret)
+		return ret;
+
+	/* Update threshold */
+	*thresh = val;
+
+	return 0;
+}
+
+static int _hdc3020_read_thresh(struct hdc3020_data *data,
+				enum iio_event_info info,
+				enum iio_event_direction dir, u16 *thresh)
+{
+	u8 crc, buf[3];
+	const u8 *cmd;
+	int ret;
+
+	if (info == IIO_EV_INFO_VALUE) {
+		if (dir == IIO_EV_DIR_RISING)
+			cmd = HDC3020_R_T_RH_THRESH_HIGH;
+		else
+			cmd = HDC3020_R_T_RH_THRESH_LOW;
+	} else {
+		if (dir == IIO_EV_DIR_RISING)
+			cmd = HDC3020_R_T_RH_THRESH_HIGH_CLR;
+		else
+			cmd = HDC3020_R_R_RH_THRESH_LOW_CLR;
+	}
+
+	ret = hdc3020_read_bytes(data, cmd, buf, 3);
+	if (ret < 0)
+		return ret;
+
+	/* CRC check of the threshold */
+	crc = crc8(hdc3020_crc8_table, buf, 2, CRC8_INIT_VALUE);
+	if (crc != buf[2])
+		return -EINVAL;
+
+	*thresh = get_unaligned_be16(buf);
+
+	return 0;
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
+	u16 *thresh;
+
+	/* Select threshold */
+	if (info == IIO_EV_INFO_VALUE) {
+		if (dir == IIO_EV_DIR_RISING)
+			thresh = &data->t_rh_thresh_high;
+		else
+			thresh = &data->t_rh_thresh_low;
+	} else {
+		if (dir == IIO_EV_DIR_RISING)
+			thresh = &data->t_rh_thresh_high_clr;
+		else
+			thresh = &data->t_rh_thresh_low_clr;
+	}
+
+	guard(mutex)(&data->lock);
+	switch (chan->type) {
+	case IIO_TEMP:
+		/* Get the truncated temperature threshold from 9 LSBs,
+		 * shift them and calculate the threshold according to the
+		 * formula in the datasheet.
+		 */
+		*val = ((*thresh) & HDC3020_THRESH_TEMP_MASK) <<
+			HDC3020_THRESH_TEMP_SHIFT;
+		*val = -2949075 + (175 * (*val));
+		*val2 = 65535;
+		break;
+	case IIO_HUMIDITYRELATIVE:
+		/* Get the truncated humidity threshold from 7 MSBs, and
+		 * calculate the threshold according to the formula in the
+		 * datasheet.
+		 */
+		*val = 100 * ((*thresh) & HDC3020_THRESH_HUM_MASK);
+		*val2 = 65535;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return IIO_VAL_FRACTIONAL;
+}
+
+static int hdc3020_clear_status(struct hdc3020_data *data)
+{
+	return hdc3020_write_bytes(data, HDC3020_S_STATUS, 2);
+}
+
+static int hdc3020_read_status(struct hdc3020_data *data, u16 *stat)
+{
+	u8 crc, buf[3];
+	int ret;
+
+	ret = hdc3020_read_bytes(data, HDC3020_R_STATUS, buf, 3);
+	if (ret < 0)
+		return ret;
+
+	/* CRC check of the status */
+	crc = crc8(hdc3020_crc8_table, buf, 2, CRC8_INIT_VALUE);
+	if (crc != buf[2])
+		return -EINVAL;
+
+	*stat = get_unaligned_be16(buf);
+
+	return 0;
+}
+
+static irqreturn_t hdc3020_interrupt_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct hdc3020_data *data;
+	u16 stat;
+	int ret;
+
+	data = iio_priv(indio_dev);
+	ret = hdc3020_read_status(data, &stat);
+	if (ret)
+		return IRQ_NONE;
+
+	if (!(stat & (HDC3020_STATUS_T_HIGH_ALERT | HDC3020_STATUS_T_LOW_ALERT |
+		HDC3020_STATUS_RH_HIGH_ALERT | HDC3020_STATUS_RH_LOW_ALERT)))
+		return IRQ_NONE;
+
+	if (stat & HDC3020_STATUS_T_HIGH_ALERT)
+		iio_push_event(indio_dev,
+			       IIO_MOD_EVENT_CODE(IIO_TEMP, 0,
+						  IIO_NO_MOD,
+						  IIO_EV_TYPE_THRESH,
+						  IIO_EV_DIR_RISING),
+						  iio_get_time_ns(indio_dev));
+
+	if (stat & HDC3020_STATUS_T_LOW_ALERT)
+		iio_push_event(indio_dev,
+			       IIO_MOD_EVENT_CODE(IIO_TEMP, 0,
+						  IIO_NO_MOD,
+						  IIO_EV_TYPE_THRESH,
+						  IIO_EV_DIR_FALLING),
+						  iio_get_time_ns(indio_dev));
+
+	if (stat & HDC3020_STATUS_RH_HIGH_ALERT)
+		iio_push_event(indio_dev,
+			       IIO_MOD_EVENT_CODE(IIO_HUMIDITYRELATIVE, 0,
+						  IIO_NO_MOD,
+						  IIO_EV_TYPE_THRESH,
+						  IIO_EV_DIR_RISING),
+						  iio_get_time_ns(indio_dev));
+
+	if (stat & HDC3020_STATUS_RH_LOW_ALERT)
+		iio_push_event(indio_dev,
+			       IIO_MOD_EVENT_CODE(IIO_HUMIDITYRELATIVE, 0,
+						  IIO_NO_MOD,
+						  IIO_EV_TYPE_THRESH,
+						  IIO_EV_DIR_FALLING),
+						  iio_get_time_ns(indio_dev));
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
@@ -402,6 +690,7 @@ static void hdc3020_stop(void *data)
 
 static int hdc3020_probe(struct i2c_client *client)
 {
+	const struct i2c_device_id *hdc3020_id;
 	struct iio_dev *indio_dev;
 	struct hdc3020_data *data;
 	int ret;
@@ -413,6 +702,8 @@ static int hdc3020_probe(struct i2c_client *client)
 	if (!indio_dev)
 		return -ENOMEM;
 
+	hdc3020_id = i2c_client_get_device_id(client);
+
 	data = iio_priv(indio_dev);
 	data->client = client;
 	mutex_init(&data->lock);
@@ -425,6 +716,54 @@ static int hdc3020_probe(struct i2c_client *client)
 	indio_dev->channels = hdc3020_channels;
 	indio_dev->num_channels = ARRAY_SIZE(hdc3020_channels);
 
+	/* Read out upper and lower thresholds and hysteresis, which can be the
+	 * default values or values programmed into non-volatile memory.
+	 */
+	ret = _hdc3020_read_thresh(data, IIO_EV_INFO_VALUE, IIO_EV_DIR_FALLING,
+				   &data->t_rh_thresh_low);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "Unable to get low thresholds\n");
+
+	ret = _hdc3020_read_thresh(data, IIO_EV_INFO_VALUE, IIO_EV_DIR_RISING,
+				   &data->t_rh_thresh_high);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "Unable to get high thresholds\n");
+
+	ret = _hdc3020_read_thresh(data, IIO_EV_INFO_HYSTERESIS,
+				   IIO_EV_DIR_FALLING,
+				   &data->t_rh_thresh_low_clr);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "Unable to get low hysteresis\n");
+
+	ret = _hdc3020_read_thresh(data, IIO_EV_INFO_HYSTERESIS,
+				   IIO_EV_DIR_RISING,
+				   &data->t_rh_thresh_high_clr);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "Unable to get high hysteresis\n");
+
+	if (client->irq) {
+		/* The alert output is activated by default upon power up, hardware
+		 * reset, and soft reset. Clear the status register before enabling
+		 * the interrupt.
+		 */
+		ret = hdc3020_clear_status(data);
+		if (ret)
+			return ret;
+
+		ret = devm_request_threaded_irq(&client->dev, client->irq,
+						NULL, hdc3020_interrupt_handler,
+						IRQF_TRIGGER_RISING |
+						IRQF_ONESHOT,
+						hdc3020_id->name, indio_dev);
+		if (ret)
+			return dev_err_probe(&client->dev, ret,
+					     "Failed to request IRQ\n");
+	}
+
 	ret = hdc3020_write_bytes(data, HDC3020_S_AUTO_10HZ_MOD0, 2);
 	if (ret)
 		return dev_err_probe(&client->dev, ret,
-- 
2.39.2


