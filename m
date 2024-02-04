Return-Path: <linux-kernel+bounces-51589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8811F848CE7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 11:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDEB71F225EB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 10:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86FB21109;
	Sun,  4 Feb 2024 10:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJryjgu3"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956471B59B;
	Sun,  4 Feb 2024 10:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707043045; cv=none; b=RBXSbFRqe7Kgw7gwTigx0Ny1SLGr9BwCCBV1ltLZVnSUtJlHO0wcziDSl0q4ZDEMqBB7CX30XqXEsEqtxyLUN3Umfb4aNzpCAPQAYSLwwzkVrR0VdSahzCZxg3j13CnXkqXhUDu5XDKtcERZOT+p9aZ5RPdRdnKtqjeTWyHGFvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707043045; c=relaxed/simple;
	bh=WB5Pz1kg//9u+ZslxoeU6g2+4RyW4MapvV9JhR2P6BI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=gqPIzGRJKlON+4c+bdsM4bdNddga3ih7M5wY0mBlfcwTx/PfH0qHYkuzkH2HPbmyT52JkQfGI38a8b9uf5MLef808zt0NIrfWE6PQKU9JTlHgw4Z1eTbHne5x2ipKkJUk6OF+0cK93zKgpnP/dDaQqaXqUl9sab8i2kjRPCtLVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJryjgu3; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a30f7c9574eso473492766b.0;
        Sun, 04 Feb 2024 02:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707043042; x=1707647842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bIC1+lrcS7R1KbRR4TD5y30tw/y4TTmSSk4RmS745uQ=;
        b=aJryjgu3wfl2b0e3Lh623CliA4w5cugaXWSqYZq5vOhK6Ymy+mLknYOJk+eXuMV80t
         s2MODleIesQPxfp4CR6JLfTEdkYK1URg3IRArDFYlkDtJ5B0anwz8pn2jMRiZWcaV0ma
         FPTJWIMV6hDlmVA1YRZjmaVNIFDc0dpthhBBRjczN1Q+AktFVt3elYdO+lJ79NWtuM80
         Il5Ziii0G0taEfD/tqkOB+8KvDxkTrdEPTHhxQXY1RMlWgvJ6bhVZtFh6utPZ9TK9EL/
         gVAjdccHMIzRHwDNTvJze2QDKRjC6xOUcjZ1Z7VoPi9aosejjGDSplkQjQJ4TXl9m3XJ
         vyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707043042; x=1707647842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bIC1+lrcS7R1KbRR4TD5y30tw/y4TTmSSk4RmS745uQ=;
        b=IU1EAhxv/k0dG9+VIsLU0XfI4KlNb/cbrkMJ2lFFAE48KrxZIkdqYhpkgTcVOpVfmd
         kFoW2DqqVd6rCTEd0i5N3H9cOkcs7EJ/0amUuXhmMOatcXW7os8VES5od0nwNoNzgM+C
         Dl1bX4jbCCnQhI/wsEgoAgWiQmF10I97zDSECLHBIieM4dbvEwbyfHRWK3s8dC+vDKJu
         Ke8pRHTh9ew+0XuOWJxw6Z003DwgoURLaLnzCh5ace7ri+KLToZEuQlHJHHF1QQDrDB4
         MfiKvvTnYZ6nP2bVrsd6X2pB6ti2Ys+8U+QQLG9Vzb5TKbhpskZLRdOJvgTdv5h7rVn5
         xD6A==
X-Gm-Message-State: AOJu0Yys6rdOxeHtE000YUeHhBUecReafkJTiZzPHJtcU0QJymdhsdgw
	+JSM+3zBbLBv9XjfHVnda66DxciF2VPg/2KmrmBFCuIbB27+Prvc
X-Google-Smtp-Source: AGHT+IEMWLBi7FARt0dFCImAfBDSjqOULB1iStDkomyemn1TYaO7XWcPbQLwQ0cSLnSSiXO9gofMxw==
X-Received: by 2002:a17:906:314c:b0:a37:4765:658 with SMTP id e12-20020a170906314c00b00a3747650658mr2453651eje.34.1707043041283;
        Sun, 04 Feb 2024 02:37:21 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVv9/gL7kPHp7QqlxZ4ajY0G2GBL8Gh+zi5u8r+iPRkN8QJmlNkUa2FVDGtqAPqbIGZPDtLRiulv7R2OVcm1SIIW+gd3iL7l8OWPysk2NYqJDk3Zk5PozI3eNLrh7tCHsA4jGIkUReK1WgYg3amlvxNg928P3wAPC9/AJlD4ZKPukAIbLyQx5UmI2GSZW4JfvPIVcsR0LZpzveegEKuH+OnJe4Lh+zRO3s9CGH1BgtmBxTAte1B79SuhZLSig==
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id vq11-20020a170907a4cb00b00a36cc8c1bcbsm3005158ejc.173.2024.02.04.02.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 02:37:20 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Li peiyu <579lpy@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: humidity: hdc3020: add threshold events support
Date: Sun,  4 Feb 2024 11:37:10 +0100
Message-Id: <20240204103710.19212-1-dima.fedrau@gmail.com>
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
Changes in V2:
  - Fix alphabetical order of includes(Christophe)
  - Fix typo: change varibale name "HDC3020_R_R_RH_THRESH_LOW_CLR" to
    HDC3020_R_T_RH_THRESH_LOW_CLR to match variable name pattern
    (Christophe)
  - Add constants HDC3020_MIN_TEMP and HDC3020_MAX_TEMP for min/max
    threshold inputs (Christophe)
  - Change HDC3020_MIN_TEMP to -40, as stated in the datasheet(Javier)
  - Fix shadowing of global variable "hdc3020_id" in probe function,
    rename variable in probe function to "dev_id"(Javier)
---
 drivers/iio/humidity/hdc3020.c | 342 +++++++++++++++++++++++++++++++++
 1 file changed, 342 insertions(+)

diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc3020.c
index ed70415512f6..80cfb343c92d 100644
--- a/drivers/iio/humidity/hdc3020.c
+++ b/drivers/iio/humidity/hdc3020.c
@@ -14,11 +14,13 @@
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 
 #include <asm/unaligned.h>
 
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 
 #define HDC3020_HEATER_CMD_MSB		0x30 /* shared by all heater commands */
@@ -26,21 +28,47 @@
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
 
 #define HDC3020_CRC8_POLYNOMIAL		0x31
 
+#define HDC3020_MIN_TEMP		-40
+#define HDC3020_MAX_TEMP		125
+
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
+static const u8 HDC3020_R_T_RH_THRESH_LOW_CLR[2] = { 0xE1, 0x09 };
+static const u8 HDC3020_R_T_RH_THRESH_HIGH_CLR[2] = { 0xE1, 0x14 };
+static const u8 HDC3020_R_T_RH_THRESH_HIGH[2] = { 0xE1, 0x1F };
+
+static const u8 HDC3020_R_STATUS[2] = { 0xF3, 0x2D };
+
 struct hdc3020_data {
 	struct i2c_client *client;
 	/*
@@ -50,22 +78,54 @@ struct hdc3020_data {
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
@@ -389,10 +449,241 @@ static int hdc3020_write_raw(struct iio_dev *indio_dev,
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
+	if (val < HDC3020_MIN_TEMP || val > HDC3020_MAX_TEMP)
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
+			cmd = HDC3020_R_T_RH_THRESH_LOW_CLR;
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
@@ -402,6 +693,7 @@ static void hdc3020_stop(void *data)
 
 static int hdc3020_probe(struct i2c_client *client)
 {
+	const struct i2c_device_id *dev_id;
 	struct iio_dev *indio_dev;
 	struct hdc3020_data *data;
 	int ret;
@@ -413,6 +705,8 @@ static int hdc3020_probe(struct i2c_client *client)
 	if (!indio_dev)
 		return -ENOMEM;
 
+	dev_id = i2c_client_get_device_id(client);
+
 	data = iio_priv(indio_dev);
 	data->client = client;
 	mutex_init(&data->lock);
@@ -425,6 +719,54 @@ static int hdc3020_probe(struct i2c_client *client)
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
+						dev_id->name, indio_dev);
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


