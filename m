Return-Path: <linux-kernel+bounces-28992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 508DB83061D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88528B211F3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FB1208A2;
	Wed, 17 Jan 2024 12:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnPW4ZHB"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3078C200A6;
	Wed, 17 Jan 2024 12:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705495901; cv=none; b=WKJQziRUH073/4dLZsMdWYEL220Fh76EA8LkVGb0aTZDcRyU64j8o2T+OKJSG6bPPCe6GE5xpd3vCAUQrEzR7zmObHR2k6ymuWG4DUw4/0q7OZgtIfzj0E3/DjXD8s7QZk5AvhvLku2LM0j5laZyC1nLd3mW7/4mdO+Os2sd76I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705495901; c=relaxed/simple;
	bh=xXLlIP7osWnXSX7nf/88IxxEVdS3vDPA432NiT+QTnM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=WBJYAitzpeIK64lAJ1tXUE875MjTjqp/rnd3+5R0ZNgYlvlRY1JbQLB6OfqA8q8DJNHYG1UBYCqu1ovbCZX/xx8So4kTizKNPfnaQGsLr0luZ6/HQr+kOmxfdbUKc1i5+0uloGUl8OGJM2Fssj8mqVnKyFAcH67lMSv+5+ooaU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SnPW4ZHB; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-557dcb0f870so10928181a12.2;
        Wed, 17 Jan 2024 04:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705495898; x=1706100698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/bvLckPY/B6iV2JgYPRYCAJR1OfXTgLpwfT8b63pic=;
        b=SnPW4ZHBDHYVBEH40lGEU8f8+ii8sjrEbrYfufUV0B+U/oLPkDtBjYRnIZ9PKP2itc
         OsETXdxZhL543Wo/ioOL4zYrCXY7PY3ADJlmGIcbGESHZCFJxYqfggUHnkfVNulbP/1A
         FCi1wr4DNZhvM7V2tFg7Jk0uN+NotRExRMHzoZulhA3+uAd5LETfK1M+0nIqT0EHpr0+
         rKbYKhU1scNyqse0U7of9zTCMTxilq+v8laFItKbpuj2c6dzlL+6GGByFUxc0+Y3NUun
         ToMvAefYGRWTKyCyuwHtUL/0W5CvUbh9CVNDbwBsHGbaGgyeQuR/CQJfHX8S82B7p1J1
         yOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705495898; x=1706100698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/bvLckPY/B6iV2JgYPRYCAJR1OfXTgLpwfT8b63pic=;
        b=dvd9GeIgTk5tTZHmiUFSa/R94HDyuptDpW8xAHb2FeHdzdT+7EsZgo2EDQkNFz5SzH
         LpFXR5DUTRpWLeUXPLz/HOWYc/wkem1BYnC7zX6lUQsVKoN/locLT5TC5DV9tLm1AlEh
         Vw0cxzBT4yh81Oc9YbDsYRQUZjnNhfdbleXBrXCC7dyvYiAm7xZI9oNTM3Rm6+dnWmG+
         iWhHFyFV2L1o+8rl2fk8+XWm002ieVqH8qtvZeCJ1NJb7LcQ2Aa+zFEwyNfz2gPMvWVN
         qk7f3iZboAvlt5DVeXz2UZ69Foyih+N/yDKEqbk3FwbmOpRSNqClMyDIDfUpXtj5wgN9
         tG5g==
X-Gm-Message-State: AOJu0Yx/WbcAK1gWgkgipI4Qo5nzaoHNCkde0NyA/9Cj4EPlqkCbwbRa
	M5d3Cq+0IkKW6XgN2dyeDNM=
X-Google-Smtp-Source: AGHT+IHzcBZTFl7/R4qH13jyO+4HXHx+ZcDfvAqmcfLITq5pCz36dHkbFJlw8S61Cf3tHls37k3nhw==
X-Received: by 2002:a17:906:6a12:b0:a2b:1a20:e634 with SMTP id qw18-20020a1709066a1200b00a2b1a20e634mr5226175ejc.11.1705495898408;
        Wed, 17 Jan 2024 04:51:38 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id t13-20020a17090616cd00b00a2ea45637desm1277247ejd.112.2024.01.17.04.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 04:51:38 -0800 (PST)
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
Subject: [PATCH v4 5/5] iio: amplifiers: hmc425a: add support for LTC6373 Instrumentation Amplifier
Date: Wed, 17 Jan 2024 14:51:14 +0200
Message-ID: <20240117125124.8326-6-mitrutzceclan@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240117125124.8326-1-mitrutzceclan@gmail.com>
References: <20240117125124.8326-1-mitrutzceclan@gmail.com>
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
 drivers/iio/amplifiers/hmc425a.c | 118 +++++++++++++++++++++++++++++--
 1 file changed, 114 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/hmc425a.c
index b116b54e4206..e7f425677fd3 100644
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
@@ -34,6 +49,8 @@ struct hmc425a_chip_info {
 	int				gain_min;
 	int				gain_max;
 	int				default_gain;
+	int				powerdown_val;
+	bool				has_powerdown;
 };
 
 struct hmc425a_state {
@@ -42,6 +59,7 @@ struct hmc425a_state {
 	struct				gpio_descs *gpios;
 	enum				hmc425a_type type;
 	u32				gain;
+	bool				powerdown;
 };
 
 static int hmc425a_write(struct iio_dev *indio_dev, u32 value)
@@ -80,6 +98,17 @@ static int hmc425a_gain_dB_to_code(struct hmc425a_state *st, int val, int val2,
 		temp = (abs(gain) / 2000) & 0xF;
 		*code = temp & BIT(3) ? temp | BIT(2) : temp;
 		return 0;
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
+		return 0;
 	default:
 		return -EINVAL;
 	}
@@ -101,6 +130,12 @@ static int hmc425a_code_to_gain_dB(struct hmc425a_state *st, int *val, int *val2
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
@@ -174,6 +209,48 @@ static const struct iio_info hmc425a_info = {
 	.write_raw_get_fmt = &hmc425a_write_raw_get_fmt,
 };
 
+static ssize_t ltc6373_read_powerdown(struct iio_dev *indio_dev,
+				      uintptr_t private,
+				      const struct iio_chan_spec *chan,
+				      char *buf)
+{
+	struct hmc425a_state *st = iio_priv(indio_dev);
+
+	return sysfs_emit(buf, "%d\n", st->powerdown);
+}
+
+static ssize_t ltc6373_write_powerdown(struct iio_dev *indio_dev,
+				       uintptr_t private,
+				       const struct iio_chan_spec *chan,
+				       const char *buf,
+				       size_t len)
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
@@ -183,10 +260,24 @@ static const struct iio_info hmc425a_info = {
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
 static struct hmc425a_chip_info hmc425a_chip_info_tbl[] = {
 	[ID_HMC425A] = {
 		.name = "hmc425a",
@@ -215,6 +306,18 @@ static struct hmc425a_chip_info hmc425a_chip_info_tbl[] = {
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
+		.default_gain = LTC6373_MIN_GAIN_CODE,
+		.powerdown_val = LTC6373_SHUTDOWN,
+		.has_powerdown = true,
+	},
+
 };
 
 /* Match table for of_platform binding */
@@ -225,6 +328,8 @@ static const struct of_device_id hmc425a_of_match[] = {
 	  .data = &hmc425a_chip_info_tbl[ID_HMC540S]},
 	{ .compatible = "adi,adrf5740",
 	  .data = &hmc425a_chip_info_tbl[ID_ADRF5740]},
+	{ .compatible = "adi,ltc6373",
+	  .data = &hmc425a_chip_info_tbl[ID_LTC6373]},
 	{},
 };
 MODULE_DEVICE_TABLE(of, hmc425a_of_match);
@@ -270,8 +375,13 @@ static int hmc425a_probe(struct platform_device *pdev)
 	indio_dev->info = &hmc425a_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	/* Set default gain */
-	hmc425a_write(indio_dev, st->gain);
+	if (st->chip_info->has_powerdown) {
+		st->powerdown = true;
+		hmc425a_write(indio_dev, st->chip_info->powerdown_val);
+	} else {
+		/* Set default gain */
+		hmc425a_write(indio_dev, st->gain);
+	}
 
 	return devm_iio_device_register(&pdev->dev, indio_dev);
 }
-- 
2.42.0


