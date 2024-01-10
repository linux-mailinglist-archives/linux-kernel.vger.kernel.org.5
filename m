Return-Path: <linux-kernel+bounces-22435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A2B829DB8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A58BB1F275F7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5424D119;
	Wed, 10 Jan 2024 15:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eR0nGKcO"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABA24CDF8;
	Wed, 10 Jan 2024 15:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40d88fff7faso44082865e9.3;
        Wed, 10 Jan 2024 07:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704901088; x=1705505888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTMaMXmqDjo2TjzKR4Go+S5q8z7l19GhbUs2M7Oy3ZA=;
        b=eR0nGKcOQ+YuEdFaxzChDvNPXcRUEWA9uQx72HTw0sOUrmdAqRfVjzWO5Hd6qmCdrQ
         tWkDjQERqMvQoHup3a7L0oyAkrb/QMKqpqjAUjI6g/p0xzVSt7cf9q43CaQHpkaXkAm4
         dUj+80clyRIxv2n1+0JvBdNw718qX+6CFeLS4meFUpJ0T+rHy8hgD6ccnVMMi2oAxOH9
         r+Znsk1ZEPzIZARgVzv3XyX3upbwB0c2xgFZZevvUQZOWpACDt57TjTP/+fDdXn58qjy
         zhM+/HrDzhi9PoyFtnbk9M5Nb6fa62TmV6g7iqpEGj+lCfR+yvUg+d7A9LZVvrcueu3c
         3sbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704901088; x=1705505888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTMaMXmqDjo2TjzKR4Go+S5q8z7l19GhbUs2M7Oy3ZA=;
        b=uXHQx8/SyvBCDPviaCapGp2eMZf0iYHYB6suMH+dJiFA4IojQQGsSesu5A51Yazg9G
         iVJI+xTETW7nT0yIRdvdGtqbNbDsKrzAua3M6/OE7yJenC3d8B0SSxyDj4jpvWK16B5d
         lxHi+rbG92FRe9qHwytFCEXS0omEUPDqlWeWQK4WWwBBrRGZMoNBETD5ymvkJWjphOqL
         dqYh10RaVqF2zH/qdHi2itXRHk6UERK2/T1hCUkPNdVFNTbbNqriBhIPuom+mW2tJR4r
         QBfu8jumk8o/JS2pwkBt2WgLdVpjrULACYGgRKg6gbxaSh7q+PeA/NrOy+FTsvq9R3c5
         m90g==
X-Gm-Message-State: AOJu0YxCju8Y3XyMYjYI9hgGawu6ywxRFKfUoyVl6HN6ED3HKvK4sL8Z
	1ix0zZ3JIqk7SiIoC43l2TE=
X-Google-Smtp-Source: AGHT+IE1DTMf17Awc4OzMIOaBNuqw77o/Z5yZIP7lqm/WzjKuPT7HZWhOh2YvdzcCF9/NrOUnk5whQ==
X-Received: by 2002:a05:600c:4755:b0:40d:3be1:daaf with SMTP id w21-20020a05600c475500b0040d3be1daafmr356022wmo.51.1704901088400;
        Wed, 10 Jan 2024 07:38:08 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([86.125.72.218])
        by smtp.gmail.com with ESMTPSA id e30-20020a5d595e000000b0033776a50472sm4179907wri.10.2024.01.10.07.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 07:38:07 -0800 (PST)
From: Dumitru Ceclan <mitrutzceclan@gmail.com>
To: 
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>
Subject: [PATCH v2 4/4] iio: amplifiers: hmc425a: add support for LTC6373 Instrumentation Amplifier
Date: Wed, 10 Jan 2024 17:37:12 +0200
Message-ID: <20240110153757.5754-5-mitrutzceclan@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240110153757.5754-1-mitrutzceclan@gmail.com>
References: <20240110153757.5754-1-mitrutzceclan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds support for LTC6373 36 V Fully-Differential Programmable-Gain
Instrumentation Amplifier with 25 pA Input Bias Current.
The user can program the gain to one of seven available settings through
a 3-bit parallel interface (A2 to A0).

Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
---
 drivers/iio/amplifiers/hmc425a.c | 104 ++++++++++++++++++++++++++++++-
 1 file changed, 102 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/hmc425a.c
index b5fd19403d15..2048bf9e0343 100644
--- a/drivers/iio/amplifiers/hmc425a.c
+++ b/drivers/iio/amplifiers/hmc425a.c
@@ -2,9 +2,10 @@
 /*
  * HMC425A and similar Gain Amplifiers
  *
- * Copyright 2020 Analog Devices Inc.
+ * Copyright 2020, 2023 Analog Devices Inc.
  */
 
+#include <linux/bits.h>
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -20,10 +21,24 @@
 #include <linux/regulator/consumer.h>
 #include <linux/sysfs.h>
 
+/*
+ * The LTC6373 amplifier supports configuring gain using GPIO's with the following
+ *  values (OUTPUT_V / INPUT_V): 0(shutdown), 0.25, 0.5, 1, 2, 4, 8, 16
+ *
+ * Except for the shutdown value, all can be converted to dB using 20 * log10(x)
+ * From here, it is observed that all values are multiples of the '2' gain setting,
+ *  with the correspondent of 6.020dB.
+ */
+#define LTC6373_CONVERSION_CONSTANT	6020
+#define LTC6373_MIN_GAIN_CODE		0x6
+#define LTC6373_CONVERSION_MASK		GENMASK(2, 0)
+#define LTC6373_SHUTDOWN		GENMASK(2, 0)
+
 enum hmc425a_type {
 	ID_HMC425A,
 	ID_HMC540S,
-	ID_ADRF5740
+	ID_ADRF5740,
+	ID_LTC6373,
 };
 
 struct hmc425a_chip_info {
@@ -42,6 +57,7 @@ struct hmc425a_state {
 	struct	gpio_descs *gpios;
 	enum	hmc425a_type type;
 	u32	gain;
+	bool	powerdown;
 };
 
 static int hmc425a_write(struct iio_dev *indio_dev, u32 value)
@@ -80,6 +96,17 @@ static int hmc425a_gain_dB_to_code(struct hmc425a_state *st, int val, int val2,
 		temp = (abs(gain) / 2000) & 0xF;
 		*code = temp & BIT(3) ? temp | BIT(2) : temp;
 		break;
+	case ID_LTC6373:
+		if (st->powerdown)
+			return -EPERM;
+
+		/* add half of the value for rounding */
+		temp = LTC6373_CONVERSION_CONSTANT / 2;
+		if (val < 0)
+			temp *= -1;
+		*code = ~((gain + temp) / LTC6373_CONVERSION_CONSTANT + 3)
+			& LTC6373_CONVERSION_MASK;
+		break;
 	}
 	return 0;
 }
@@ -100,6 +127,12 @@ static int hmc425a_code_to_gain_dB(struct hmc425a_state *st, int *val, int *val2
 		code = code & BIT(3) ? code & ~BIT(2) : code;
 		gain = code * -2000;
 		break;
+	case ID_LTC6373:
+		if (st->powerdown)
+			return -EPERM;
+		gain = ((~code & LTC6373_CONVERSION_MASK) - 3) *
+		       LTC6373_CONVERSION_CONSTANT;
+		break;
 	}
 
 	*val = gain / 1000;
@@ -172,6 +205,44 @@ static const struct iio_info hmc425a_info = {
 	.write_raw_get_fmt = &hmc425a_write_raw_get_fmt,
 };
 
+static ssize_t ltc6373_read_powerdown(struct iio_dev *indio_dev,
+	uintptr_t private, const struct iio_chan_spec *chan, char *buf)
+{
+	struct hmc425a_state *st = iio_priv(indio_dev);
+
+	return sysfs_emit(buf, "%d\n", st->powerdown);
+}
+
+static ssize_t ltc6373_write_powerdown(struct iio_dev *indio_dev,
+	 uintptr_t private, const struct iio_chan_spec *chan, const char *buf,
+	 size_t len)
+{
+	struct hmc425a_state *st = iio_priv(indio_dev);
+	bool powerdown;
+	int code, ret;
+
+	ret = kstrtobool(buf, &powerdown);
+	if (ret)
+		return ret;
+
+	mutex_lock(&st->lock);
+	st->powerdown = powerdown;
+	code = (powerdown) ? LTC6373_SHUTDOWN : st->gain;
+	ret = hmc425a_write(indio_dev, code);
+	mutex_unlock(&st->lock);
+	return len;
+}
+
+static const struct iio_chan_spec_ext_info ltc6373_ext_info[] = {
+	{
+		.name = "powerdown",
+		.read = ltc6373_read_powerdown,
+		.write = ltc6373_write_powerdown,
+		.shared = IIO_SEPARATE,
+	},
+	{},
+};
+
 #define HMC425A_CHAN(_channel)						\
 {									\
 	.type = IIO_VOLTAGE,						\
@@ -181,15 +252,30 @@ static const struct iio_info hmc425a_info = {
 	.info_mask_separate = BIT(IIO_CHAN_INFO_HARDWAREGAIN),		\
 }
 
+#define LTC6373_CHAN(_channel)						\
+{									\
+	.type = IIO_VOLTAGE,						\
+	.output = 1,							\
+	.indexed = 1,							\
+	.channel = _channel,						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_HARDWAREGAIN),		\
+	.ext_info = ltc6373_ext_info,					\
+}
+
 static const struct iio_chan_spec hmc425a_channels[] = {
 	HMC425A_CHAN(0),
 };
 
+static const struct iio_chan_spec ltc6373_channels[] = {
+	LTC6373_CHAN(0),
+};
+
 /* Match table for of_platform binding */
 static const struct of_device_id hmc425a_of_match[] = {
 	{ .compatible = "adi,hmc425a", .data = (void *)ID_HMC425A },
 	{ .compatible = "adi,hmc540s", .data = (void *)ID_HMC540S },
 	{ .compatible = "adi,adrf5740", .data = (void *)ID_ADRF5740 },
+	{ .compatible = "adi,ltc6373", .data = (void *)ID_LTC6373 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, hmc425a_of_match);
@@ -222,6 +308,15 @@ static struct hmc425a_chip_info hmc425a_chip_info_tbl[] = {
 		.gain_max = 0,
 		.default_gain = 0xF, /* set default gain -22.0db*/
 	},
+	[ID_LTC6373] = {
+		.name = "ltc6373",
+		.channels = ltc6373_channels,
+		.num_channels = ARRAY_SIZE(ltc6373_channels),
+		.num_gpios = 3,
+		.gain_min = -12041, /* gain setting x0.25*/
+		.gain_max = 24082,  /* gain setting x16  */
+		.default_gain = LTC6373_SHUTDOWN,
+	},
 };
 
 static int hmc425a_probe(struct platform_device *pdev)
@@ -266,6 +361,11 @@ static int hmc425a_probe(struct platform_device *pdev)
 	/* Set default gain */
 	hmc425a_write(indio_dev, st->gain);
 
+	if (st->type == ID_LTC6373) {
+		st->powerdown = true;
+		st->gain = LTC6373_MIN_GAIN_CODE;
+	}
+
 	return devm_iio_device_register(&pdev->dev, indio_dev);
 }
 
-- 
2.42.0


