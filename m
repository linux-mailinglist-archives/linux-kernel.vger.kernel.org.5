Return-Path: <linux-kernel+bounces-163894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB718B7566
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE92C1F215AE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4631813D8A4;
	Tue, 30 Apr 2024 12:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwpY4sh7"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDED14535E;
	Tue, 30 Apr 2024 12:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714478765; cv=none; b=g+m6f2wQn56paakrXHV+HWyVuJQpA4bUEZ9NLn9ZhDrcccKsp3qygF3rZYUFqCbH0ezAeO0NChM6pQOfq+ZyQ8m5++48QYFYpOrfsq3UwmG3XXazI1HilWkFlxSsFAAktMxyBh7w2pkXEu2kApdxvycwNlygwi2vm2scxA/jyMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714478765; c=relaxed/simple;
	bh=h51PIdWJMbhHLXoQSCH/hNxJQjBIStdp9I7ajhbwaM0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tVIhldt+WiSJZxrzE65gDBZOGjCxi8bIsfPLEfYyk8H3f/eGPoQyiGYBhmXf9fE4lVUlSC9isb50ZFQYA9sYNYGq56MXpUmd7qFXwKIqyKFagsxoksUb47sKUUeJo8wzM1vri2oZTOtbfh6+jrHQDdr+rCRoCFIFrrmgvQLirHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwpY4sh7; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51b09c3a111so7912668e87.1;
        Tue, 30 Apr 2024 05:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714478761; x=1715083561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVfmzv9+M83+3dtszQOFJXPN2DCqsj2JOs+0IqmE2GE=;
        b=AwpY4sh7MTlEOEbaLhrRD7TGZFhdHaIBfh7DcCSuXzafHZXuzn3F9ZPKNOyK2NFMNa
         oETHuPrYniuVbUE+LHFHtnCfe2FGuZ+UDBkpQTJPBpFAG+MBGGO2NBUgDdq7Vvt1DVE5
         C/GgXCgo00SV9W9vETZLlVMZQUv2DdqygGt5Xn91AdkOOnvPb2xploLZjR5JJQJ+nzP/
         za7eEUq1z76KleKc5KHz0dI4mAT7jNONGvlddWZZHgv3G2Btil65ar6vQzkVQ/k6R/eD
         BDbUi5DLGoeFvAASXpMIEqVFtj5fT5n5juBzVTkJ1fetnVK7gSO1nykbl7lT0r5ibz6M
         Hxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714478761; x=1715083561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVfmzv9+M83+3dtszQOFJXPN2DCqsj2JOs+0IqmE2GE=;
        b=vxilPoRMZMyH5dsFP+2M2mofC+BJjAH0bsrpVM+t+BnBFZR+ZI/Rl8W48OiTFnXYPl
         ZPBGyTiXlmwgIrGSNomVAq4RAljkIpYghlFVwAkbWQX8jUP8uGhw6OdDAcYf1CZoF2WW
         3zdgVuacNa5SxtlomK0W2CGd3QiJkadBkA1k5thBBhoALv2JEAql6Xr+zwNC/vJiQQn7
         2SGIAihvMLTg1RZ7gChRgW4ikL3rTw2gUZeX0FISoEsFChcJmiqxCeF4OJEg0kaBULZk
         B6aWokJLYkO0UlcF1f0433vyCDi8CgYXfvqDAv0Y0ACLKaixnKaKzaZ+x67NrSvqYa0P
         YhGw==
X-Forwarded-Encrypted: i=1; AJvYcCWPT8klSfJueKZuf3x1hX1NFWhrfibkpkkSJBClGqKo6p57weRquL04Il/+m3SdCJyMelOnCX26pIM+JcZMAam1LZ0t6s5R502sLlftzoO4IaetQAOm0Qg0A8p4yHaei+S4hxigv+91
X-Gm-Message-State: AOJu0YwL3SpZiePq0Oc8to0+mO1q0WLD6y4PqDGF9ZyHfh+3xA9NC1LB
	pClvMyQyRBKaL4v+YqOgc01q28zOGUEnoThmk4+C6A7moMsNQJJf
X-Google-Smtp-Source: AGHT+IHR0YLkYkN7kcebQLnWolrqsg1wtV6tlAVJCIRtmojLPrO5oCvuyJQod00OjkCNOEdZB3EHkA==
X-Received: by 2002:ac2:5235:0:b0:51d:4260:4bf8 with SMTP id i21-20020ac25235000000b0051d42604bf8mr4738999lfl.35.1714478760811;
        Tue, 30 Apr 2024 05:06:00 -0700 (PDT)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id r21-20020a05600c35d500b0041bf45c0665sm11054324wmq.15.2024.04.30.05.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 05:06:00 -0700 (PDT)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Andrew Hepp <andrew.hepp@ahepp.dev>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] iio: temperature: mcp9600: add threshold events support
Date: Tue, 30 Apr 2024 14:05:35 +0200
Message-Id: <20240430120535.46097-6-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240430120535.46097-1-dima.fedrau@gmail.com>
References: <20240430120535.46097-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The device has four programmable temperature alert outputs which can be
used to monitor hot or cold-junction temperatures and detect falling and
rising temperatures. It supports up to 255 degree celsius programmable
hysteresis. Each alert can be individually configured by setting following
options in the associated alert configuration register:
  - monitor hot or cold junction temperature
  - monitor rising or falling temperature
  - set comparator or interrupt mode
  - set output polarity
  - enable alert

This patch binds alert outputs to iio events:
  - alert1: hot junction, rising temperature
  - alert2: hot junction, falling temperature
  - alert3: cold junction, rising temperature
  - alert4: cold junction, falling temperature

All outputs are set in comparator mode and polarity depends on interrupt
configuration.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/iio/temperature/mcp9600.c | 358 +++++++++++++++++++++++++++++-
 1 file changed, 354 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
index cb1c1c1c361d..f7e1b4e3253d 100644
--- a/drivers/iio/temperature/mcp9600.c
+++ b/drivers/iio/temperature/mcp9600.c
@@ -6,21 +6,80 @@
  * Author: <andrew.hepp@ahepp.dev>
  */
 
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
+#include <linux/math.h>
+#include <linux/minmax.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/units.h>
 
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 
 /* MCP9600 registers */
-#define MCP9600_HOT_JUNCTION 0x0
-#define MCP9600_COLD_JUNCTION 0x2
-#define MCP9600_DEVICE_ID 0x20
+#define MCP9600_HOT_JUNCTION		0x0
+#define MCP9600_COLD_JUNCTION		0x2
+#define MCP9600_STATUS			0x4
+#define MCP9600_STATUS_ALERT(x)		BIT(x)
+#define MCP9600_ALERT_CFG1		0x8
+#define MCP9600_ALERT_CFG(x)		(MCP9600_ALERT_CFG1 + (x - 1))
+#define MCP9600_ALERT_CFG_ENABLE	BIT(0)
+#define MCP9600_ALERT_CFG_ACTIVE_HIGH	BIT(2)
+#define MCP9600_ALERT_CFG_FALLING	BIT(3)
+#define MCP9600_ALERT_CFG_COLD_JUNCTION	BIT(4)
+#define MCP9600_ALERT_HYSTERESIS1	0xc
+#define MCP9600_ALERT_HYSTERESIS(x)	(MCP9600_ALERT_HYSTERESIS1 + (x - 1))
+#define MCP9600_ALERT_LIMIT1		0x10
+#define MCP9600_ALERT_LIMIT(x)		(MCP9600_ALERT_LIMIT1 + (x - 1))
+
+#define MCP9600_DEVICE_ID		0x20
 
 /* MCP9600 device id value */
-#define MCP9600_DEVICE_ID_MCP9600 0x40
+#define MCP9600_DEVICE_ID_MCP9600	0x40
+
+#define MCP9600_ALERT_COUNT		4
+
+#define MCP9600_MIN_TEMP_HOT_JUNCTION	-200
+#define MCP9600_MAX_TEMP_HOT_JUNCTION	1800
+
+#define MCP9600_MIN_TEMP_COLD_JUNCTION	-40
+#define MCP9600_MAX_TEMP_COLD_JUNCTION	125
+
+enum mcp9600_alert {
+	MCP9600_ALERT1,
+	MCP9600_ALERT2,
+	MCP9600_ALERT3,
+	MCP9600_ALERT4
+};
+
+static const char * const mcp9600_alert_name[MCP9600_ALERT_COUNT] = {
+	[MCP9600_ALERT1] = "alert1",
+	[MCP9600_ALERT2] = "alert2",
+	[MCP9600_ALERT3] = "alert3",
+	[MCP9600_ALERT4] = "alert4",
+};
+
+static const struct iio_event_spec mcp9600_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |
+				 BIT(IIO_EV_INFO_VALUE) |
+				 BIT(IIO_EV_INFO_HYSTERESIS),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |
+				 BIT(IIO_EV_INFO_VALUE) |
+				 BIT(IIO_EV_INFO_HYSTERESIS),
+	},
+};
 
 static const struct iio_chan_spec mcp9600_channels[] = {
 	{
@@ -30,6 +89,8 @@ static const struct iio_chan_spec mcp9600_channels[] = {
 		.modified = 1,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE),
+		.event_spec = mcp9600_events,
+		.num_event_specs = ARRAY_SIZE(mcp9600_events),
 	},
 	{
 		.type = IIO_TEMP,
@@ -38,11 +99,15 @@ static const struct iio_chan_spec mcp9600_channels[] = {
 		.modified = 1,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE),
+		.event_spec = mcp9600_events,
+		.num_event_specs = ARRAY_SIZE(mcp9600_events),
 	},
 };
 
 struct mcp9600_data {
 	struct i2c_client *client;
+	struct mutex lock[MCP9600_ALERT_COUNT];
+	int irq[MCP9600_ALERT_COUNT];
 };
 
 static int mcp9600_read(struct mcp9600_data *data,
@@ -83,10 +148,292 @@ static int mcp9600_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int mcp9600_get_alert_index(int channel2, enum iio_event_direction dir)
+{
+	switch (channel2) {
+	case IIO_MOD_TEMP_OBJECT:
+		if (dir == IIO_EV_DIR_RISING)
+			return MCP9600_ALERT1;
+		else
+			return MCP9600_ALERT2;
+	case IIO_MOD_TEMP_AMBIENT:
+		if (dir == IIO_EV_DIR_RISING)
+			return MCP9600_ALERT3;
+		else
+			return MCP9600_ALERT4;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mcp9600_read_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir)
+{
+	struct mcp9600_data *data = iio_priv(indio_dev);
+	struct i2c_client *client = data->client;
+	int i, ret;
+
+	i = mcp9600_get_alert_index(chan->channel2, dir);
+	if (i < 0)
+		return i;
+
+	ret = i2c_smbus_read_byte_data(client, MCP9600_ALERT_CFG(i + 1));
+	if (ret < 0)
+		return ret;
+
+	return (ret & MCP9600_ALERT_CFG_ENABLE);
+}
+
+static int mcp9600_write_event_config(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir,
+				      int state)
+{
+	struct mcp9600_data *data = iio_priv(indio_dev);
+	struct i2c_client *client = data->client;
+	int i, ret;
+
+	i = mcp9600_get_alert_index(chan->channel2, dir);
+	if (i < 0)
+		return i;
+
+	ret = i2c_smbus_read_byte_data(client, MCP9600_ALERT_CFG(i + 1));
+	if (ret < 0)
+		return ret;
+
+	if (state)
+		ret |= MCP9600_ALERT_CFG_ENABLE;
+	else
+		ret &= ~MCP9600_ALERT_CFG_ENABLE;
+
+	return i2c_smbus_write_byte_data(client, MCP9600_ALERT_CFG(i + 1), ret);
+}
+
+static int mcp9600_read_thresh(struct iio_dev *indio_dev,
+			       const struct iio_chan_spec *chan,
+			       enum iio_event_type type,
+			       enum iio_event_direction dir,
+			       enum iio_event_info info, int *val, int *val2)
+{
+	struct mcp9600_data *data = iio_priv(indio_dev);
+	struct i2c_client *client = data->client;
+	s32 ret;
+	int i;
+
+	i = mcp9600_get_alert_index(chan->channel2, dir);
+	if (i < 0)
+		return i;
+
+	guard(mutex)(&data->lock[i]);
+	ret = i2c_smbus_read_word_swapped(client, MCP9600_ALERT_LIMIT(i + 1));
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Temperature is stored in two’s complement format in bits(15:2),
+	 * LSB is 0.25 degree celsius.
+	 */
+	*val = sign_extend32(ret, 15) >> 2;
+	*val2 = 4;
+	if (info == IIO_EV_INFO_VALUE)
+		return IIO_VAL_FRACTIONAL;
+
+	ret = i2c_smbus_read_byte_data(client, MCP9600_ALERT_HYSTERESIS(i + 1));
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Hysteresis is stored as offset which is not signed, therefore we have
+	 * to include directions when calculating the real hysteresis value.
+	 */
+	if (dir == IIO_EV_DIR_RISING)
+		*val -= (*val2 * ret);
+	else
+		*val += (*val2 * ret);
+
+	return IIO_VAL_FRACTIONAL;
+}
+
+static int mcp9600_write_thresh(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan,
+				enum iio_event_type type,
+				enum iio_event_direction dir,
+				enum iio_event_info info, int val, int val2)
+{
+	struct mcp9600_data *data = iio_priv(indio_dev);
+	struct i2c_client *client = data->client;
+	int s_val, s_thresh, i;
+	s16 thresh;
+	s32 ret;
+	u8 hyst;
+
+	/* Scale value to include decimal part into calculations */
+	s_val = (val < 0) ? ((val * (int)MICRO) - val2) :
+			    ((val * (int)MICRO) + val2);
+
+	/* Hot junction temperature range is from –200 to 1800 degree celsius */
+	if (chan->channel2 == IIO_MOD_TEMP_OBJECT &&
+	   (s_val < (MCP9600_MIN_TEMP_HOT_JUNCTION * (int)MICRO) ||
+	    s_val > (MCP9600_MAX_TEMP_HOT_JUNCTION * (int)MICRO)))
+		return -EINVAL;
+
+	/* Cold junction temperature range is from –40 to 125 degree celsius */
+	if (chan->channel2 == IIO_MOD_TEMP_AMBIENT &&
+	   (s_val < (MCP9600_MIN_TEMP_COLD_JUNCTION * (int)MICRO) ||
+	    s_val > (MCP9600_MAX_TEMP_COLD_JUNCTION * (int)MICRO)))
+		return -EINVAL;
+
+	i = mcp9600_get_alert_index(chan->channel2, dir);
+	if (i < 0)
+		return i;
+
+	guard(mutex)(&data->lock[i]);
+	if (info == IIO_EV_INFO_VALUE) {
+		/*
+		 * Shift length 4 bits = 2(15:2) + 2(0.25 LSB), temperature is
+		 * stored in two’s complement format.
+		 */
+		thresh = (s16)(s_val / (int)(MICRO >> 4));
+		return i2c_smbus_write_word_swapped(client,
+						    MCP9600_ALERT_LIMIT(i + 1),
+						    thresh);
+	}
+
+	/* Read out threshold, hysteresis is stored as offset */
+	ret = i2c_smbus_read_word_swapped(client, MCP9600_ALERT_LIMIT(i + 1));
+	if (ret < 0)
+		return ret;
+
+	/* Shift length 4 bits = 2(15:2) + 2(0.25 LSB), see above. */
+	s_thresh = sign_extend32(ret, 15) * (int)(MICRO >> 4);
+
+	/*
+	 * Hysteresis is stored as offset, for rising temperatures, the
+	 * hysteresis range is below the alert limit where, as for falling
+	 * temperatures, the hysteresis range is above the alert limit.
+	 */
+	hyst = min(255, abs(s_thresh - s_val) / MICRO);
+
+	return i2c_smbus_write_byte_data(client,
+					 MCP9600_ALERT_HYSTERESIS(i + 1),
+					 hyst);
+}
+
 static const struct iio_info mcp9600_info = {
 	.read_raw = mcp9600_read_raw,
+	.read_event_config = mcp9600_read_event_config,
+	.write_event_config = mcp9600_write_event_config,
+	.read_event_value = mcp9600_read_thresh,
+	.write_event_value = mcp9600_write_thresh,
 };
 
+static irqreturn_t mcp9600_alert_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct mcp9600_data *data = iio_priv(indio_dev);
+	enum iio_event_direction dir;
+	enum iio_modifier mod;
+	int i, ret;
+
+	for (i = 0; i < MCP9600_ALERT_COUNT; i++) {
+		if (data->irq[i] == irq)
+			break;
+	}
+
+	if (i >= MCP9600_ALERT_COUNT)
+		return IRQ_NONE;
+
+	ret = i2c_smbus_read_byte_data(data->client, MCP9600_STATUS);
+	if (ret < 0)
+		return IRQ_HANDLED;
+
+	switch (ret & MCP9600_STATUS_ALERT(i)) {
+	case 0:
+		return IRQ_NONE;
+	case MCP9600_STATUS_ALERT(MCP9600_ALERT1):
+		mod = IIO_MOD_TEMP_OBJECT;
+		dir = IIO_EV_DIR_RISING;
+		break;
+	case MCP9600_STATUS_ALERT(MCP9600_ALERT2):
+		mod = IIO_MOD_TEMP_OBJECT;
+		dir = IIO_EV_DIR_FALLING;
+		break;
+	case MCP9600_STATUS_ALERT(MCP9600_ALERT3):
+		mod = IIO_MOD_TEMP_AMBIENT;
+		dir = IIO_EV_DIR_RISING;
+		break;
+	case MCP9600_STATUS_ALERT(MCP9600_ALERT4):
+		mod = IIO_MOD_TEMP_AMBIENT;
+		dir = IIO_EV_DIR_FALLING;
+		break;
+	default:
+		return IRQ_HANDLED;
+	}
+
+	iio_push_event(indio_dev,
+		       IIO_MOD_EVENT_CODE(IIO_TEMP, 0, mod,
+					  IIO_EV_TYPE_THRESH, dir),
+		       iio_get_time_ns(indio_dev));
+
+	return IRQ_HANDLED;
+}
+
+static int mcp9600_probe_alerts(struct iio_dev *indio_dev)
+{
+	struct mcp9600_data *data = iio_priv(indio_dev);
+	struct i2c_client *client = data->client;
+	struct device *dev = &client->dev;
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
+	unsigned int irq_type;
+	int ret, irq, i;
+	u8 val;
+
+	/*
+	 * alert1: hot junction, rising temperature
+	 * alert2: hot junction, falling temperature
+	 * alert3: cold junction, rising temperature
+	 * alert4: cold junction, falling temperature
+	 */
+	for (i = 0; i < MCP9600_ALERT_COUNT; i++) {
+		data->irq[i] = 0;
+		mutex_init(&data->lock[i]);
+		irq = fwnode_irq_get_byname(fwnode, mcp9600_alert_name[i]);
+		if (irq <= 0)
+			continue;
+
+		val = 0;
+		irq_type = irq_get_trigger_type(irq);
+		if (irq_type == IRQ_TYPE_EDGE_RISING)
+			val |= MCP9600_ALERT_CFG_ACTIVE_HIGH;
+
+		if (i == MCP9600_ALERT2 || i == MCP9600_ALERT4)
+			val |= MCP9600_ALERT_CFG_FALLING;
+
+		if (i == MCP9600_ALERT3 || i == MCP9600_ALERT4)
+			val |= MCP9600_ALERT_CFG_COLD_JUNCTION;
+
+		ret = i2c_smbus_write_byte_data(client,
+						MCP9600_ALERT_CFG(i + 1),
+						val);
+		if (ret < 0)
+			return ret;
+
+		ret = devm_request_threaded_irq(dev, irq, NULL,
+						mcp9600_alert_handler,
+						IRQF_ONESHOT, "mcp9600",
+						indio_dev);
+		if (ret)
+			return ret;
+
+		data->irq[i] = irq;
+	}
+
+	return 0;
+}
+
 static int mcp9600_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -109,6 +456,8 @@ static int mcp9600_probe(struct i2c_client *client)
 	data = iio_priv(indio_dev);
 	data->client = client;
 
+	mcp9600_probe_alerts(indio_dev);
+
 	indio_dev->info = &mcp9600_info;
 	indio_dev->name = "mcp9600";
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -140,6 +489,7 @@ static struct i2c_driver mcp9600_driver = {
 };
 module_i2c_driver(mcp9600_driver);
 
+MODULE_AUTHOR("Dimitri Fedrau <dima.fedrau@gmail.com>");
 MODULE_AUTHOR("Andrew Hepp <andrew.hepp@ahepp.dev>");
 MODULE_DESCRIPTION("Microchip MCP9600 thermocouple EMF converter driver");
 MODULE_LICENSE("GPL");
-- 
2.39.2


