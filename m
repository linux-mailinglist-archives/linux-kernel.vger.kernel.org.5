Return-Path: <linux-kernel+bounces-8294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2151981B50F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD3722820B4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5F97319A;
	Thu, 21 Dec 2023 11:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQT4GPr9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A0D697B4;
	Thu, 21 Dec 2023 11:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40c256ffdbcso7700565e9.2;
        Thu, 21 Dec 2023 03:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703158742; x=1703763542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqSYpHf1/FbLuBZDQt+DqkeQkv3UvQKwqCA0rndeeF4=;
        b=fQT4GPr9wLSx2P0fqOn404yk/LHkRPPK3vjTLmJngYLWa5a/faoCjekYdgXbgmY3/s
         QQegiVEO57FcMuH2PYsWj8zIanLTrbtXFD02oV24cKhtv2bmrdMExaVGEXku9QtGyOkK
         mKSi0RH1Q44udAYTw3vdCoflQLX3himhU75l7uEf+AMwA1YQkXBcE5cEDjDzY7GB3F14
         Tqndbg3QpGCCmvZbKv8eumVBsdn6gYaIGEFLFAplt7Rkw8WOT8LYaK0I5nhuHXiJoFjL
         zJZC/QxhtzM8iJI7m8/TgFDEOvN4mZR7lEHc6OgauO4aKuc+Zzv74CTWsdy5RXSNv3jF
         UlLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703158742; x=1703763542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LqSYpHf1/FbLuBZDQt+DqkeQkv3UvQKwqCA0rndeeF4=;
        b=ogDULhXD/FQ/Bu0XceYshpDKLN2pxRzUHxb2Zr5xaCe5a0Uscflk/4OWg0IYIhcLoj
         rC172ykisT9ILlVHPYvSsSj9mlLxhOsPSa3+wRMrJ+P2bVnSteFD2nfJs5FskeK40HWZ
         xWDpFQzspvir8+03TjGn390YkPjHDZhA4MtHJzjcvh92Q0hi7/poQM0Muaanj7JUULtw
         9ufjtCO2oY5H9dZbc0Q57xqBBpF5l4RZyv6bOs0q+nfTdQmAcL41npnQh64IrH4Lha5v
         KWBrYxvxP9zg/S/lbx3yWaLwfK4TC21jz6ecByuvbanVA2+5y0snwxlJfpiF9JLkAWcA
         AGvA==
X-Gm-Message-State: AOJu0Ywk27hO1Bq1I14Dn0CgaN2uUZXLZYmnKtct2a6J0u+XZlkRIuc/
	lQJLthH3ZAI8riuWH3ci2XM=
X-Google-Smtp-Source: AGHT+IHqmtlPObdCHfV3z7QJW2WeL5kq4RokaiCmAhU3UYEhZcm3ufXs0xWkSt8lJn8YhSZsTaqHSw==
X-Received: by 2002:a05:600c:4592:b0:40b:5e21:d360 with SMTP id r18-20020a05600c459200b0040b5e21d360mr682155wmo.105.1703158741723;
        Thu, 21 Dec 2023 03:39:01 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([213.157.161.11])
        by smtp.gmail.com with ESMTPSA id fl25-20020a05600c0b9900b0040b3e26872dsm10940404wmb.8.2023.12.21.03.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 03:39:01 -0800 (PST)
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
Subject: [PATCH 3/3] iio: amplifiers: hmc425a: add support for LTC6373 Instrumentation Amplifier
Date: Thu, 21 Dec 2023 13:38:40 +0200
Message-ID: <20231221113842.25957-4-mitrutzceclan@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231221113842.25957-1-mitrutzceclan@gmail.com>
References: <20231221113842.25957-1-mitrutzceclan@gmail.com>
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
 drivers/iio/amplifiers/hmc425a.c | 78 +++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/hmc425a.c
index b5fd19403d15..27fdc32a0457 100644
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
@@ -20,10 +21,23 @@
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
@@ -42,6 +56,8 @@ struct hmc425a_state {
 	struct	gpio_descs *gpios;
 	enum	hmc425a_type type;
 	u32	gain;
+	bool	enabled;
+
 };
 
 static int hmc425a_write(struct iio_dev *indio_dev, u32 value)
@@ -80,6 +96,17 @@ static int hmc425a_gain_dB_to_code(struct hmc425a_state *st, int val, int val2,
 		temp = (abs(gain) / 2000) & 0xF;
 		*code = temp & BIT(3) ? temp | BIT(2) : temp;
 		break;
+	case ID_LTC6373:
+		if (!st->enabled)
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
+		if (!st->enabled)
+			return -EPERM;
+		gain = ((~code & LTC6373_CONVERSION_MASK) - 3) *
+		       LTC6373_CONVERSION_CONSTANT;
+		break;
 	}
 
 	*val = gain / 1000;
@@ -122,6 +155,10 @@ static int hmc425a_read_raw(struct iio_dev *indio_dev,
 			break;
 		ret = IIO_VAL_INT_PLUS_MICRO_DB;
 		break;
+	case IIO_CHAN_INFO_ENABLE:
+		*val = st->enabled;
+		ret = IIO_VAL_INT;
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -146,6 +183,17 @@ static int hmc425a_write_raw(struct iio_dev *indio_dev,
 		st->gain = code;
 		ret = hmc425a_write(indio_dev, st->gain);
 		break;
+	case IIO_CHAN_INFO_ENABLE:
+		switch (st->type) {
+		case ID_LTC6373:
+			code = (val) ? st->gain : LTC6373_SHUTDOWN;
+			st->enabled = val;
+			ret = hmc425a_write(indio_dev, code);
+			break;
+		default:
+			ret = -EINVAL;
+		}
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -161,6 +209,8 @@ static int hmc425a_write_raw_get_fmt(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_HARDWAREGAIN:
 		return IIO_VAL_INT_PLUS_MICRO_DB;
+	case IIO_CHAN_INFO_ENABLE:
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
@@ -181,15 +231,30 @@ static const struct iio_info hmc425a_info = {
 	.info_mask_separate = BIT(IIO_CHAN_INFO_HARDWAREGAIN),		\
 }
 
+#define LTC6373_CHAN(_channel)						\
+{									\
+	.type = IIO_VOLTAGE,						\
+	.output = 1,							\
+	.indexed = 1,							\
+	.channel = _channel,						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_HARDWAREGAIN) |		\
+			      BIT(IIO_CHAN_INFO_ENABLE),		\
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
@@ -222,6 +287,15 @@ static struct hmc425a_chip_info hmc425a_chip_info_tbl[] = {
 		.gain_max = 0,
 		.default_gain = 0xF, /* set default gain -22.0db*/
 	},
+		[ID_LTC6373] = {
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
-- 
2.42.0


