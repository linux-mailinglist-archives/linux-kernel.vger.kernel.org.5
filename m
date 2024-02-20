Return-Path: <linux-kernel+bounces-73258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B65285C024
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A5691F22678
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195C277F33;
	Tue, 20 Feb 2024 15:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+DntWSc"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2938E77625;
	Tue, 20 Feb 2024 15:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708443368; cv=none; b=HUGkIu8NLKXKggUyHN2IwPXcdvGB/4lIn0p54p0zYwW0PYFQfvgT4iq7wxh7RjMlinhOxZvCAFTRpPwBEN0VxRMrAgb/ZNQoxmXKDsW6roncZGoAErxnJ3ldH5HYrlIKQlJMo4XME97OEYk1oaWCwaS3kyg+AO0MZbcagBaYub4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708443368; c=relaxed/simple;
	bh=yngViWPOAMHAODTTAwgLH5RffJRA3vHYGb/gjQx44BA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QN7GKtoX+dGvsHYMkcGA8hxRL7bacb9StkJDJoXCa5Mmj4KhQKu+fSEEuGMSzE5/XbqJTFvLcf1vtBhh4tteC2wUw38tAk3YToWQ5GrdiCMpylsApjX28D5vsBNvIVnWFc0/qoD1cqpg72kGCUlq7YfpcNduyRmNSsRrvbMzx6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+DntWSc; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-564d9b0e96dso706754a12.2;
        Tue, 20 Feb 2024 07:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708443364; x=1709048164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=geyL8OfscOjPv2YlXwfaUvMZU6dkavwR22sE4+gZy1A=;
        b=e+DntWScsguJci0a0JpZECFHbaTgHAckoXtbSdNvSMvbmRL/SrH218OgmAdETxiofY
         K3+8lLN0XV4k8n0fNgSXjPS8S+muVjlPiEOgT03meAPZuvBb7JG2Apu30+w4ozZg2kSW
         u6rAisvA2HnczDzJF9KUbNV94IwiTocpcer94ZWZmyWd+HNGudSqw8npYubNlnzii5We
         ckCs2G1Ly5FFUq5mXOCFFfXAkKnB8tIVLtQg+HDrtN9oKNsSInm+DQ9sBj1k5/ir0ae8
         5HsoLekMEdJIO0tCuGOc/lDvznwJyWxWNkovi25VNuqCDd+aQhpxrc/7Rmh1j8tGfcuH
         KQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708443364; x=1709048164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=geyL8OfscOjPv2YlXwfaUvMZU6dkavwR22sE4+gZy1A=;
        b=Epf/jzBqEi0qrBilTsD1fVWSMOA5TkQpJKkEqznh8F2F8NuD0IbnCo2rRfCPmfDKTa
         ZKpUFt8TtEuhC3Z8dWAipmHiUI+QR8NrvP4dl2vjT0EE1IW15vych1MnVmgxtr47qAhF
         8mMmkb4cWD1/8m5p8abNc/eAX4TpNmACsI8Dvruke/6FOTlpS9XMzZZSWWYhoUmo8xVe
         l0qCpEes5y7PriCto2GFAvUmuZw8Ol2SqzC8mYcctriaV4tRBH7T08V+lTJTpmrGIo7p
         LHmJQOv+RP4uZF8WIB0Ph5guCcsouMdMAhOmWXo+TO7TqP2GRKfXXOP0Wx3uLnKQdVLV
         94Pw==
X-Forwarded-Encrypted: i=1; AJvYcCUBDsJPsvPVAKNU79NNaRL2n8C64YQTmUHXjoYpl1WLKkBxywxMvkRfzAwnXn3B5sjTloOecXNHth0Pe+dpPFtJqZma+6nSsuHS/0eWxgJIdm0kpcUyeGJa3Pu8zOkV2XfHDAj0RFuwdTC9QCjRt3Ob1d9BbzDbIh8eS+/hHbVfemFeJA==
X-Gm-Message-State: AOJu0YzaiXbphNxr/8DUqJC5VV4bY8XJnRFS/MkpAWJjzBPbNmVLgQ9u
	k5MjuTuQMaY8VH7VhTctMtDOfV1xwaQg3yADrnb4uIQYuFSiuiorod7LEGqQUa+h3hIY
X-Google-Smtp-Source: AGHT+IGLMDm3ARrwgLRHtJQorhTGCrr++X65+2urQqfqV1DRT2pDJexdtFgo/FBtACLc10UWEePyIA==
X-Received: by 2002:a17:906:2a90:b0:a3e:1a96:a22c with SMTP id l16-20020a1709062a9000b00a3e1a96a22cmr6049808eje.38.1708443364117;
        Tue, 20 Feb 2024 07:36:04 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id r22-20020a170906281600b00a3d777aa8fesm4039024ejc.69.2024.02.20.07.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 07:36:03 -0800 (PST)
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
Subject: [PATCH v5 5/5] iio: amplifiers: hmc425a: add support for LTC6373 Instrumentation Amplifier
Date: Tue, 20 Feb 2024 17:34:53 +0200
Message-ID: <20240220153553.2432-6-mitrutzceclan@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240220153553.2432-1-mitrutzceclan@gmail.com>
References: <20240220153553.2432-1-mitrutzceclan@gmail.com>
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
 drivers/iio/amplifiers/hmc425a.c | 124 ++++++++++++++++++++++++++++++-
 1 file changed, 120 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/hmc425a.c
index 77872e2dfdfe..50c86c2d28d7 100644
--- a/drivers/iio/amplifiers/hmc425a.c
+++ b/drivers/iio/amplifiers/hmc425a.c
@@ -2,9 +2,10 @@
 /*
  * HMC425A and similar Gain Amplifiers
  *
- * Copyright 2020 Analog Devices Inc.
+ * Copyright 2020, 2024 Analog Devices Inc.
  */
 
+#include <linux/bits.h>
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -12,6 +13,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/kernel.h>
+#include <linux/math.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -20,10 +22,24 @@
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
@@ -34,6 +50,8 @@ struct hmc425a_chip_info {
 	int				gain_min;
 	int				gain_max;
 	int				default_gain;
+	int				powerdown_val;
+	bool				has_powerdown;
 
 	int				(*gain_dB_to_code)(int gain, int *code);
 	int				(*code_to_gain_dB)(int code, int *val, int *val2);
@@ -44,6 +62,7 @@ struct hmc425a_state {
 	const struct	hmc425a_chip_info *chip_info;
 	struct	gpio_descs *gpios;
 	u32	gain;
+	bool	powerdown;
 };
 
 static int gain_dB_to_code(struct hmc425a_state *st, int val, int val2, int *code)
@@ -58,6 +77,8 @@ static int gain_dB_to_code(struct hmc425a_state *st, int val, int val2, int *cod
 
 	if (gain > inf->gain_max || gain < inf->gain_min)
 		return -EINVAL;
+	if (st->powerdown)
+		return -EPERM;
 
 	return st->chip_info->gain_dB_to_code(gain, code);
 }
@@ -83,8 +104,17 @@ static int adrf5740_gain_dB_to_code(int gain, int *code)
 	return 0;
 }
 
+static int ltc6373_gain_dB_to_code(int gain, int *code)
+{
+	*code = ~(DIV_ROUND_CLOSEST(gain, LTC6373_CONVERSION_CONSTANT) + 3)
+		& LTC6373_CONVERSION_MASK;
+	return 0;
+}
+
 static int code_to_gain_dB(struct hmc425a_state *st, int *val, int *val2)
 {
+	if (st->powerdown)
+		return -EPERM;
 	return st->chip_info->code_to_gain_dB(st->gain, val, val2);
 }
 
@@ -114,6 +144,16 @@ static int adrf5740_code_to_gain_dB(int code, int *val, int *val2)
 	return 0;
 }
 
+static int ltc6373_code_to_gain_dB(int code, int *val, int *val2)
+{
+	int gain = ((~code & LTC6373_CONVERSION_MASK) - 3) *
+		   LTC6373_CONVERSION_CONSTANT;
+
+	*val = gain / 1000;
+	*val2 = (gain % 1000) * 1000;
+	return 0;
+}
+
 static int hmc425a_write(struct iio_dev *indio_dev, u32 value)
 {
 	struct hmc425a_state *st = iio_priv(indio_dev);
@@ -191,6 +231,48 @@ static const struct iio_info hmc425a_info = {
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
+	hmc425a_write(indio_dev, code);
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
+	{}
+};
+
 #define HMC425A_CHAN(_channel)						\
 {									\
 	.type = IIO_VOLTAGE,						\
@@ -200,10 +282,24 @@ static const struct iio_info hmc425a_info = {
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
@@ -238,6 +334,19 @@ static struct hmc425a_chip_info hmc425a_chip_info_tbl[] = {
 		.gain_dB_to_code = adrf5740_gain_dB_to_code,
 		.code_to_gain_dB = adrf5740_code_to_gain_dB,
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
+		.gain_dB_to_code = ltc6373_gain_dB_to_code,
+		.code_to_gain_dB = ltc6373_code_to_gain_dB,
+	},
 };
 
 static int hmc425a_probe(struct platform_device *pdev)
@@ -278,8 +387,13 @@ static int hmc425a_probe(struct platform_device *pdev)
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
@@ -292,6 +406,8 @@ static const struct of_device_id hmc425a_of_match[] = {
 	  .data = &hmc425a_chip_info_tbl[ID_HMC540S]},
 	{ .compatible = "adi,adrf5740",
 	  .data = &hmc425a_chip_info_tbl[ID_ADRF5740]},
+	{ .compatible = "adi,ltc6373",
+	  .data = &hmc425a_chip_info_tbl[ID_LTC6373]},
 	{}
 };
 MODULE_DEVICE_TABLE(of, hmc425a_of_match);
-- 
2.42.0


