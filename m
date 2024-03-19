Return-Path: <linux-kernel+bounces-107367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FAB87FB89
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBA26282E8D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6B47EF08;
	Tue, 19 Mar 2024 10:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LtEliHFp"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDE07E116
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710843097; cv=none; b=HfAMCJiwwPvmhXLtTGpo1eNCdSNUuV2Enq7xC5oDy+ebOxDczSiszJ68fdnl1JlL12R3wuwIwt2mJgAyHTONCAt65qaRKKdlmu7YT1Zi58rcypRsC6/61WdaGWQ5NpgqnGOm5RvYKJjMH6EZ9EAsyd8uqLg+eTsr9h9r1/kKYoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710843097; c=relaxed/simple;
	bh=67jkLPpX8jgzabmmStnvNhPoM5e/mmApaIdTINBUkzI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZkGqgHmkVBS0769cBbVK5g0tqHP8Xdt2D7QVTf0H9fKMwxK36PQGTbuuC97w3iU2+U41HGJIpc2eqzxjZDBRXlb1GyFUVb+BF6QrxqspslkhI1n8lr7XlUhDvrDxvw5LZc6zzh606JXlVwgPkmjI2bkOxJwLP6DprnSjLcXJhAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LtEliHFp; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41467d697a2so876675e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 03:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710843094; x=1711447894; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hXHxCG3DorXB+eSGZtM4Yud+b78y3PSqhEWeD2BkfRU=;
        b=LtEliHFpS4YaqhJogS+AtsjdOZp/pGO8yj2beh6jPa/mY7L2mz8m0NpZuJnGNLw5aK
         1aS12oulTDw+W/Gp5FEeZUjSrY1BOgOv0JY+R3UdtDFsMfbLh6WDhZZDPETLmS7eyf1Z
         8llJdXikfQykRnz8mDt4yaFIrx6vEdgzFPyryq7Wi923Jf8gf00WRSV1FmJEhfOL72fM
         LXI7cVHxTlUFuiSk0HZqizz1oOguMs0z+3DW87YPwGlpSAPahhVd/847/U6Y7bsFD8pM
         8KMau5w5NU+GTKbUtCzwqh6S/Q/SxwUT/ruKNODjGAf2g16Q33EjqRrlO+TejoVRNNGs
         ZmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710843094; x=1711447894;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hXHxCG3DorXB+eSGZtM4Yud+b78y3PSqhEWeD2BkfRU=;
        b=ay7ZP2Lf77nfVmaqjfxSDmHVQslMTpNs4A/TkN1NUyPnHG1Z9sQ8EfZc+4pqe5opFM
         NgJA5EO0jt739deOnB0HMTHAcoKAP0EJqyAWZfFKPXCu83+DmpmWyxHTiifimfJGVfeh
         WLnQpWMFNJ9X5omtEr9iRdA965h6ifMFmGUGL0WN6+5t000cBcaTzSZJd/dGdnu1oXX3
         kp4C4MpAmqbKHYrBfe3zaot43QY8KOnoGpHjNDgbW+6GGzfeZfC3uHtZECn42bVAqX5z
         xjlaK23HfTKBH4nkXaPRDI0KmaxAwrWXmnSb+lq6X83YT4dqMkhA9k+QkBeE8nRnvws3
         QvOw==
X-Forwarded-Encrypted: i=1; AJvYcCVyhbJnhgz/Pi4zUBj/kt7I/U0hYtHqCk9JWXQLBO0+wNpBuhP4zJUJlJtN8KwGMJO342BtiVFOomS47BOw5W1wdoFG+1MU2ED9UHDo
X-Gm-Message-State: AOJu0YyssnMAgg+xHE+HQEb1XDFBU1l4GWcy0S8fAEtRvxn6BpjprjR2
	0cxQeAx1p0WxlJdmRddi1lcZ7r/ss+ebPieKrPcldHBwS42ZPk6O8Vr79f0SQso=
X-Google-Smtp-Source: AGHT+IEJ0dpnRdO8/M/RMCZv3uRXGWXb+uUxUNqhxXfNE/bWgR/lGWgod9UB4z3T0/Y3vbblGVSbZQ==
X-Received: by 2002:a05:600c:4747:b0:414:6865:b5bc with SMTP id w7-20020a05600c474700b004146865b5bcmr99355wmo.28.1710843094052;
        Tue, 19 Mar 2024 03:11:34 -0700 (PDT)
Received: from [192.168.1.63] ([2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id je2-20020a05600c1f8200b004133072017csm21096384wmb.42.2024.03.19.03.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 03:11:33 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 19 Mar 2024 11:11:25 +0100
Subject: [PATCH v5 4/7] iio: adc: ad7380: add support for
 pseudo-differential parts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-adding-new-ad738x-driver-v5-4-ce7df004ceb3@baylibre.com>
References: <20240319-adding-new-ad738x-driver-v5-0-ce7df004ceb3@baylibre.com>
In-Reply-To: <20240319-adding-new-ad738x-driver-v5-0-ce7df004ceb3@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.13.0

From: David Lechner <dlechner@baylibre.com>

Add support for AD7383, AD7384 pseudo-differential compatible parts.
Pseudo differential parts require common mode voltage supplies so add
the support for them and add the support of IIO_CHAN_INFO_OFFSET to
retrieve the offset

Signed-off-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/adc/ad7380.c | 98 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 85 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index caf6deb3a8b1..996ca83feaed 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -7,6 +7,7 @@
  *
  * Datasheets of supported parts:
  * ad7380/1 : https://www.analog.com/media/en/technical-documentation/data-sheets/AD7380-7381.pdf
+ * ad7383/4 : https://www.analog.com/media/en/technical-documentation/data-sheets/ad7383-7384.pdf
  */
 
 #include <linux/bitfield.h>
@@ -68,16 +69,19 @@ struct ad7380_chip_info {
 	const char *name;
 	const struct iio_chan_spec *channels;
 	unsigned int num_channels;
+	const char * const *vcm_supplies;
+	unsigned int num_vcm_supplies;
 };
 
-#define AD7380_CHANNEL(index, bits) {				\
+#define AD7380_CHANNEL(index, bits, diff) {			\
 	.type = IIO_VOLTAGE,					\
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+		((diff) ? 0 : BIT(IIO_CHAN_INFO_OFFSET)),	\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
 	.indexed = 1,						\
-	.differential = 1,					\
-	.channel = 2 * (index),					\
-	.channel2 = 2 * (index) + 1,				\
+	.differential = (diff),					\
+	.channel = (diff) ? (2 * (index)) : (index),		\
+	.channel2 = (diff) ? (2 * (index) + 1) : 0,		\
 	.scan_index = (index),					\
 	.scan_type = {						\
 		.sign = 's',					\
@@ -87,15 +91,23 @@ struct ad7380_chip_info {
 	},							\
 }
 
-#define DEFINE_AD7380_2_CHANNEL(name, bits)	\
-static const struct iio_chan_spec name[] = {	\
-	AD7380_CHANNEL(0, bits),		\
-	AD7380_CHANNEL(1, bits),		\
-	IIO_CHAN_SOFT_TIMESTAMP(2),		\
+#define DEFINE_AD7380_2_CHANNEL(name, bits, diff)	\
+static const struct iio_chan_spec name[] = {		\
+	AD7380_CHANNEL(0, bits, diff),			\
+	AD7380_CHANNEL(1, bits, diff),			\
+	IIO_CHAN_SOFT_TIMESTAMP(2),			\
 }
 
-DEFINE_AD7380_2_CHANNEL(ad7380_channels, 16);
-DEFINE_AD7380_2_CHANNEL(ad7381_channels, 14);
+/* fully differential */
+DEFINE_AD7380_2_CHANNEL(ad7380_channels, 16, 1);
+DEFINE_AD7380_2_CHANNEL(ad7381_channels, 14, 1);
+/* pseudo differential */
+DEFINE_AD7380_2_CHANNEL(ad7383_channels, 16, 0);
+DEFINE_AD7380_2_CHANNEL(ad7384_channels, 14, 0);
+
+static const char * const ad7380_2_channel_vcm_supplies[] = {
+	"aina", "ainb",
+};
 
 /* Since this is simultaneous sampling, we don't allow individual channels. */
 static const unsigned long ad7380_2_channel_scan_masks[] = {
@@ -115,11 +127,28 @@ static const struct ad7380_chip_info ad7381_chip_info = {
 	.num_channels = ARRAY_SIZE(ad7381_channels),
 };
 
+static const struct ad7380_chip_info ad7383_chip_info = {
+	.name = "ad7383",
+	.channels = ad7383_channels,
+	.num_channels = ARRAY_SIZE(ad7383_channels),
+	.vcm_supplies = ad7380_2_channel_vcm_supplies,
+	.num_vcm_supplies = ARRAY_SIZE(ad7380_2_channel_vcm_supplies),
+};
+
+static const struct ad7380_chip_info ad7384_chip_info = {
+	.name = "ad7384",
+	.channels = ad7384_channels,
+	.num_channels = ARRAY_SIZE(ad7384_channels),
+	.vcm_supplies = ad7380_2_channel_vcm_supplies,
+	.num_vcm_supplies = ARRAY_SIZE(ad7380_2_channel_vcm_supplies),
+};
+
 struct ad7380_state {
 	const struct ad7380_chip_info *chip_info;
 	struct spi_device *spi;
 	struct regmap *regmap;
 	unsigned int vref_mv;
+	unsigned int vcm_mv[2];
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
@@ -304,6 +333,11 @@ static int ad7380_read_raw(struct iio_dev *indio_dev,
 		*val2 = chan->scan_type.realbits;
 
 		return IIO_VAL_FRACTIONAL_LOG2;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = st->vcm_mv[chan->channel] * (1 << chan->scan_type.realbits)
+			/ st->vref_mv;
+
+		return IIO_VAL_INT;
 	}
 
 	return -EINVAL;
@@ -350,7 +384,7 @@ static int ad7380_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 	struct ad7380_state *st;
 	struct regulator *vref;
-	int ret;
+	int ret, i;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
@@ -394,6 +428,40 @@ static int ad7380_probe(struct spi_device *spi)
 		st->vref_mv = AD7380_INTERNAL_REF_MV;
 	}
 
+	if (st->chip_info->num_vcm_supplies > ARRAY_SIZE(st->vcm_mv))
+		return dev_err_probe(&spi->dev, -EINVAL,
+				     "invalid number of VCM supplies\n");
+
+	/*
+	 * pseudo-differential chips have common mode supplies for the negative
+	 * input pin.
+	 */
+	for (i = 0; i < st->chip_info->num_vcm_supplies; i++) {
+		struct regulator *vcm;
+
+		vcm = devm_regulator_get_optional(&spi->dev,
+						  st->chip_info->vcm_supplies[i]);
+		if (IS_ERR(vcm))
+			return dev_err_probe(&spi->dev, PTR_ERR(vcm),
+					     "Failed to get %s regulator\n",
+					     st->chip_info->vcm_supplies[i]);
+
+		ret = regulator_enable(vcm);
+		if (ret)
+			return ret;
+
+		ret = devm_add_action_or_reset(&spi->dev,
+					       ad7380_regulator_disable, vcm);
+		if (ret)
+			return ret;
+
+		ret = regulator_get_voltage(vcm);
+		if (ret < 0)
+			return ret;
+
+		st->vcm_mv[i] = ret / 1000;
+	}
+
 	st->regmap = devm_regmap_init(&spi->dev, NULL, st, &ad7380_regmap_config);
 	if (IS_ERR(st->regmap))
 		return dev_err_probe(&spi->dev, PTR_ERR(st->regmap),
@@ -422,12 +490,16 @@ static int ad7380_probe(struct spi_device *spi)
 static const struct of_device_id ad7380_of_match_table[] = {
 	{ .compatible = "adi,ad7380", .data = &ad7380_chip_info },
 	{ .compatible = "adi,ad7381", .data = &ad7381_chip_info },
+	{ .compatible = "adi,ad7383", .data = &ad7383_chip_info },
+	{ .compatible = "adi,ad7384", .data = &ad7384_chip_info },
 	{ }
 };
 
 static const struct spi_device_id ad7380_id_table[] = {
 	{ "ad7380", (kernel_ulong_t)&ad7380_chip_info },
 	{ "ad7381", (kernel_ulong_t)&ad7381_chip_info },
+	{ "ad7383", (kernel_ulong_t)&ad7383_chip_info },
+	{ "ad7384", (kernel_ulong_t)&ad7384_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad7380_id_table);

-- 
2.44.0


