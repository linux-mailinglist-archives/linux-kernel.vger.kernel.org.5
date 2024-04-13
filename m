Return-Path: <linux-kernel+bounces-143765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABFF8A3D27
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71786B21465
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 15:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5283945C16;
	Sat, 13 Apr 2024 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8YAG5je"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4171F94C;
	Sat, 13 Apr 2024 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713021182; cv=none; b=ZEFWNFoq1TJdRAfFdylr/R4z7NHO2Of4eYf0raHyULWCUMP55E4lYtsrZHsB+dkXOdSMmdh3QGtaSE+pVKNbCWdYlFIOPuG/2pA+4y3JoWCxawVIVb8eW9vP/HZwGud75Za0lB1vM9R4uWKYwnRGhbW5L/XMM0vr8HcgQVqwTbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713021182; c=relaxed/simple;
	bh=wRQKd+OE+WtU1aqxorCSyF5sYApDtk21C9X6bXgHsjU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FwLPfmthUf3hSkAh7D1TPWWjVsQgKpXmPqRUbarMzkvpG6m2RQASbhScrTO5k1S/rckLapxqVDGd8XJPnX6owQHPEXV2yv6f8ouv+enndA2NuKK1m/Rafm56BReA6UtSea/d6inD2ah6T4Cs3Vs3pFKzhqReEpZFLqDBoFXS+zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8YAG5je; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56e1bbdb362so1818124a12.1;
        Sat, 13 Apr 2024 08:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713021179; x=1713625979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mi0tivdTQs7BmgSdyeZGLWoMbQWeDfDilLlJQQErMc8=;
        b=R8YAG5je4M9MTHF2Rrs2ARB/SIKtXqNNYpu2IUsSt6zhx4UJEQAbBttw8qT5FG1f5r
         El1nG8tSyFTXYBbZCISJ6592oVsRPz6bnaxTH3uDzSqVo8+fKYm5UtR3lGMGfUA5NDp1
         5VsduYPQyutut7c5vIg/B2AjtkglBxi7xJoKQLnXh3TlSkcuWstyK4XeVAX2ec8LcsOB
         cCIKUZm4/qoOCofIcOFCLFOeAvLKRepL/D89sPH0+YquVHluAhh6rt0Rc/brYvsiU2vh
         yRKQ4G2+mVHl+luuQL6W9c9yNTr2Xn9++oUh4yfpBdpAzRlxwRcOEDAnxXdEF+1IzyEO
         7r9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713021179; x=1713625979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mi0tivdTQs7BmgSdyeZGLWoMbQWeDfDilLlJQQErMc8=;
        b=aOhro+mCjE8Tu7Sto7nHfHoGV8ZgTRKBEtJwoMtOG2NaI8t7YwePq23r8d5z7TQGcN
         Jtk9VC1h5wWXQXeH+AdkWDuX9GVV9q9/4nBinIm/Lo5nj31eNd8pZASao2FxbqXlZSAL
         0UJ0xEOYWsvjwdD7mXNyUT7MuJuiJbYETevkub082LheqaGTxnegrmT2s6KO/TGDztNT
         H6swz8i/ldxy1wBVayuhZCXTJktFK/9+NOfD4/v9l5VOJmn9t7UdiQ6zbO020/8j4ZjY
         3zcC3mp3o29G1osqiLjZyPWjLbTDscU+kQuws3Mjv0LN8cMpqG5fJS25CGC5ty069gvq
         dhGA==
X-Forwarded-Encrypted: i=1; AJvYcCXK6jefQYTsCTFk76Lj1UVnV8jHeSb0cEqRiemQ1Emg1eRa787x3zyCGgrm3BAxS1KfBgkJSC7Dpem/6Sw6pQXa+Jcc/hyJwcNnmIyiKQNpAoIfy7vp7yF3d+ODo5jDfpWDmwtik8Grff/y+FZGo+hVVSqAUA7B4sT7spvsacyfdtQGTg==
X-Gm-Message-State: AOJu0YxZnjyaMwYk/eQeJGjAsERbO4FPDk2RsIKNRg+SvkD/NRKv5XR5
	u4ny1vedzmydHqumhnpUhVbnwayy5ofjAyrCLbSv0BDyk9V1oLSn
X-Google-Smtp-Source: AGHT+IF4uTmCgLJbUZhXPiWBltRDrnWYsDQkE+ZAZKpcRIghO/mcfTHXg+1MUd1GIV3sG1oy0YOiMQ==
X-Received: by 2002:a50:8e52:0:b0:56c:4db:33f7 with SMTP id 18-20020a508e52000000b0056c04db33f7mr4982075edx.10.1713021179020;
        Sat, 13 Apr 2024 08:12:59 -0700 (PDT)
Received: from spiri.. ([5.14.146.31])
        by smtp.gmail.com with ESMTPSA id w4-20020a056402128400b0056e2b351956sm2749883edv.22.2024.04.13.08.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 08:12:58 -0700 (PDT)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: michael.hennerich@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: alexandru.tachici@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	andy@kernel.org,
	nuno.sa@analog.com,
	marcelo.schmitt@analog.com,
	bigunclemax@gmail.com,
	dlechner@baylibre.com,
	okan.sahin@analog.com,
	fr0st61te@gmail.com,
	alisa.roman@analog.com,
	marcus.folkesson@gmail.com,
	schnelle@linux.ibm.com,
	liambeguin@gmail.com
Subject: [PATCH v5 3/5] iio: adc: ad7192: Add aincom supply
Date: Sat, 13 Apr 2024 18:11:50 +0300
Message-Id: <20240413151152.165682-4-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240413151152.165682-1-alisa.roman@analog.com>
References: <20240413151152.165682-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AINCOM should actually be a supply. If present and it has a non-zero
voltage, the pseudo-differential channels are configured as single-ended
with an offset. Otherwise, they are configured as differential channels
between AINx and AINCOM pins.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 drivers/iio/adc/ad7192.c | 53 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index ac737221beae..a9eb4fab39ca 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -175,7 +175,7 @@ enum {
 struct ad7192_chip_info {
 	unsigned int			chip_id;
 	const char			*name;
-	const struct iio_chan_spec	*channels;
+	struct iio_chan_spec		*channels;
 	u8				num_channels;
 	const struct iio_info		*info;
 };
@@ -186,6 +186,7 @@ struct ad7192_state {
 	struct regulator		*vref;
 	struct clk			*mclk;
 	u16				int_vref_mv;
+	u16				aincom_mv;
 	u32				fclk;
 	u32				mode;
 	u32				conf;
@@ -745,6 +746,9 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
 		/* Kelvin to Celsius */
 		if (chan->type == IIO_TEMP)
 			*val -= 273 * ad7192_get_temp_scale(unipolar);
+		else if (st->aincom_mv && chan->channel2 == -1)
+			*val += DIV_ROUND_CLOSEST_ULL((u64)st->aincom_mv * 1000000000,
+						      st->scale_avail[gain][1]);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*val = DIV_ROUND_CLOSEST(ad7192_get_f_adc(st), 1024);
@@ -982,7 +986,7 @@ static const struct iio_info ad7195_info = {
 #define AD7193_CHANNEL(_si, _channel1, _address) \
 	AD7193_DIFF_CHANNEL(_si, _channel1, -1, _address)
 
-static const struct iio_chan_spec ad7192_channels[] = {
+static struct iio_chan_spec ad7192_channels[] = {
 	AD719x_DIFF_CHANNEL(0, 1, 2, AD7192_CH_AIN1P_AIN2M),
 	AD719x_DIFF_CHANNEL(1, 3, 4, AD7192_CH_AIN3P_AIN4M),
 	AD719x_TEMP_CHANNEL(2, AD7192_CH_TEMP),
@@ -994,7 +998,7 @@ static const struct iio_chan_spec ad7192_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(8),
 };
 
-static const struct iio_chan_spec ad7193_channels[] = {
+static struct iio_chan_spec ad7193_channels[] = {
 	AD7193_DIFF_CHANNEL(0, 1, 2, AD7193_CH_AIN1P_AIN2M),
 	AD7193_DIFF_CHANNEL(1, 3, 4, AD7193_CH_AIN3P_AIN4M),
 	AD7193_DIFF_CHANNEL(2, 5, 6, AD7193_CH_AIN5P_AIN6M),
@@ -1048,11 +1052,27 @@ static void ad7192_reg_disable(void *reg)
 	regulator_disable(reg);
 }
 
+static int ad7192_config_channels(struct ad7192_state *st)
+{
+	struct iio_chan_spec *channels = st->chip_info->channels;
+	int i;
+
+	if (!st->aincom_mv)
+		for (i = 0; i < st->chip_info->num_channels; i++)
+			if (channels[i].channel2 == -1) {
+				channels[i].differential = 1;
+				channels[i].channel2 = 0;
+			}
+
+	return 0;
+}
+
 static int ad7192_probe(struct spi_device *spi)
 {
 	struct ad7192_state *st;
 	struct iio_dev *indio_dev;
-	int ret;
+	struct regulator *aincom;
+	int ret = 0;
 
 	if (!spi->irq) {
 		dev_err(&spi->dev, "no IRQ?\n");
@@ -1067,6 +1087,26 @@ static int ad7192_probe(struct spi_device *spi)
 
 	mutex_init(&st->lock);
 
+	aincom = devm_regulator_get_optional(&spi->dev, "aincom");
+	if (!IS_ERR(aincom)) {
+		ret = regulator_enable(aincom);
+		if (ret) {
+			dev_err(&spi->dev, "Failed to enable specified AINCOM supply\n");
+			return ret;
+		}
+
+		ret = devm_add_action_or_reset(&spi->dev, ad7192_reg_disable, aincom);
+		if (ret)
+			return ret;
+
+		ret = regulator_get_voltage(aincom);
+		if (ret < 0)
+			return dev_err_probe(&spi->dev, ret,
+					     "Device tree error, AINCOM voltage undefined\n");
+	}
+
+	st->aincom_mv = ret / 1000;
+
 	st->avdd = devm_regulator_get(&spi->dev, "avdd");
 	if (IS_ERR(st->avdd))
 		return PTR_ERR(st->avdd);
@@ -1113,6 +1153,11 @@ static int ad7192_probe(struct spi_device *spi)
 	st->int_vref_mv = ret / 1000;
 
 	st->chip_info = spi_get_device_match_data(spi);
+
+	ret = ad7192_config_channels(st);
+	if (ret)
+		return ret;
+
 	indio_dev->name = st->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = st->chip_info->channels;
-- 
2.34.1


