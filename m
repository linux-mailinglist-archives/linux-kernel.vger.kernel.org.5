Return-Path: <linux-kernel+bounces-154717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 542E78AE01A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B989283BDA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EC9633E5;
	Tue, 23 Apr 2024 08:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvHpWkP5"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD3259173;
	Tue, 23 Apr 2024 08:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713861764; cv=none; b=KqeVkjb16SA6q+DVBzFBAm5+kujTpakoeolk1eMWNoEYnqC/Y/+ovpxaTQVkddgXCBZlM3eJLVs03af589VEi6AxHKrsDtfaOxv944UKxzX/YLJglkkpomx8Z3ERXxuj3Y4YnXHwlkv+8c3CC7ySXwAOyiO0BUTyuQrR53l6WIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713861764; c=relaxed/simple;
	bh=2NXtJqNwMfj19zuaumAKGjpJjaHAeKnJ8xEnBbcueR8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gvhWcUsI21OwRaaaDC8yLRNv3WNjqRxtAG6Juw05t2YJ7pHXoEjkYubzQiTCu1C5F21/AhCetNvqLfdrybsMitYwGP+aAcqwSWuyHfRXALl3+zXrzr2EDQd2IUKQYflbcjJlsuZ+qz/JC7a7ppXD8/t9LHyNLdytLtz1KIMtN3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvHpWkP5; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-34a7e47d164so3135874f8f.3;
        Tue, 23 Apr 2024 01:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713861760; x=1714466560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MmgvWFvlswLGZUJ7yfS60zJgrcO9Ytw9o2rKwpBXkoY=;
        b=DvHpWkP5wW0DHatcDf/7fW1HF79YjXd7NNr76tCNeW5Qjl894/KjhZNL8cxWH+201B
         VzYdk12SZ5iPICjV56sI3Ci3avkN2Ptoi3k+oHBSEFz2bDYVsfGOz19oObyzkReVczKQ
         3Nhny9DHCx27B6r5nw7TtLgptjGYAhTG5LhRW7wY54r7UexQIkaNNdXg0e7AXI2qhz9H
         GCbspQm/rt5xZxz5cBRKG4uyOqJMdVorX2RT2ct8whCgeS748wLlhdPBj4S7EBJ2xDzH
         FMmkpHdWGNZGCzLJgJnaMtkXeULRxc+77jesDepjz3SggEVTbxhlElVb12uyMFNflRez
         Hhyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713861760; x=1714466560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MmgvWFvlswLGZUJ7yfS60zJgrcO9Ytw9o2rKwpBXkoY=;
        b=Z33PZ7RDIrxG5qNIEIh0uKaHb0ckXzfrIj2tRS2QJAukpSnljl1ZMkXObhrSkK5i3u
         NoaKd6WN/NF/1CWWTDtg9LWHPLRxvFT8AjInfQhymr0hN9F3mPbYAEmaVJFF2MqV0NrP
         MJp31xxD2WhXNszp4iX1wCUFzJTt+s/gK7Xu73dVj+nfaYvvfd4J0uLLYwnY9ieiOA6P
         IQST9KNcBZOlAi0+o6QJt5RzGR39CVBeSY7WukNpkQBvzirfKkTtvfJZIWK65vTeMQpr
         f+DSW6wj8bgdm5Cl8Rv8AnTiznVwAXvi2imwmV/e92FPLeTk/7C5zKoP5Uuq/0xsU2hi
         Q5sg==
X-Forwarded-Encrypted: i=1; AJvYcCUSYjPX6ehv//2V/LL9opGvy7pwqDMVj0mrDhsC8VXpvWocx32lL3mTszU96mdTqnpgFyrlpe449inOo7p5PtZnPszaxaaKbgW3WyQF/El+GbyOlnQrK01eOc/LqxO2jiYjS8BbdGgWtH/7L1r3QgrQEZaRxBAseOQR150J00wloQ==
X-Gm-Message-State: AOJu0Yw2IYXcy4cDRq1EZQ6fHbWO/oicz35yzc1LJmmZCH7L0rjURY3z
	moU/hYewK34cqMZVw7NDVkvAJSMVa51UWdR8wfAzZMx0UdimailmSWjWircI
X-Google-Smtp-Source: AGHT+IHA7RStjrs648Bt277IwOsy4o4Y3wUoLcKkpOWil4UMH0QOlaryQDoNgB70AfnKxoIrE4qCQw==
X-Received: by 2002:a05:6000:1109:b0:343:a098:f41 with SMTP id z9-20020a056000110900b00343a0980f41mr7778658wrw.28.1713861760501;
        Tue, 23 Apr 2024 01:42:40 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:320d:e800:cce2:61fe:1efc:ce48])
        by smtp.gmail.com with ESMTPSA id a16-20020adffb90000000b0034af18ef68csm5989939wrr.5.2024.04.23.01.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 01:42:40 -0700 (PDT)
From: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
X-Google-Original-From: Ramona Gradinariu <ramona.gradinariu@analog.com>
To: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	corbet@lwn.net,
	conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org
Cc: Ramona Gradinariu <ramona.gradinariu@analog.com>
Subject: [PATCH 2/5] iio: imu: adis16480.c: Add delta angle and delta velocity channels
Date: Tue, 23 Apr 2024 11:42:07 +0300
Message-Id: <20240423084210.191987-3-ramona.gradinariu@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423084210.191987-1-ramona.gradinariu@analog.com>
References: <20240423084210.191987-1-ramona.gradinariu@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for delta angle and delta velocity raw readings to
adis16480 driver.

Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
---
 drivers/iio/imu/adis16480.c | 78 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index bc6cbd00cd4b..4adc2244a4ef 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -140,6 +140,8 @@ struct adis16480_chip_info {
 	unsigned int accel_max_val;
 	unsigned int accel_max_scale;
 	unsigned int temp_scale;
+	unsigned int deltang_max_val;
+	unsigned int deltvel_max_val;
 	unsigned int int_clk;
 	unsigned int max_dec_rate;
 	const unsigned int *filter_freqs;
@@ -445,6 +447,12 @@ enum {
 	ADIS16480_SCAN_MAGN_Z,
 	ADIS16480_SCAN_BARO,
 	ADIS16480_SCAN_TEMP,
+	ADIS16480_SCAN_DELTANG_X,
+	ADIS16480_SCAN_DELTANG_Y,
+	ADIS16480_SCAN_DELTANG_Z,
+	ADIS16480_SCAN_DELTVEL_X,
+	ADIS16480_SCAN_DELTVEL_Y,
+	ADIS16480_SCAN_DELTVEL_Z,
 };
 
 static const unsigned int adis16480_calibbias_regs[] = {
@@ -688,6 +696,14 @@ static int adis16480_read_raw(struct iio_dev *indio_dev,
 			*val = 131; /* 1310mbar = 131 kPa */
 			*val2 = 32767 << 16;
 			return IIO_VAL_FRACTIONAL;
+		case IIO_DELTA_ANGL:
+			*val = st->chip_info->deltang_max_val;
+			*val2 = 31;
+			return IIO_VAL_FRACTIONAL_LOG2;
+		case IIO_DELTA_VELOCITY:
+			*val = st->chip_info->deltvel_max_val;
+			*val2 = 31;
+			return IIO_VAL_FRACTIONAL_LOG2;
 		default:
 			return -EINVAL;
 		}
@@ -761,6 +777,30 @@ static int adis16480_write_raw(struct iio_dev *indio_dev,
 	BIT(IIO_CHAN_INFO_CALIBSCALE), \
 	32)
 
+#define ADIS16480_DELTANG_CHANNEL(_mod) \
+	ADIS16480_MOD_CHANNEL(IIO_DELTA_ANGL, IIO_MOD_ ## _mod, \
+	ADIS16480_REG_ ## _mod ## _DELTAANG_OUT, ADIS16480_SCAN_DELTANG_ ## _mod, \
+	0, \
+	32)
+
+#define ADIS16480_DELTANG_CHANNEL_NO_SCAN(_mod) \
+	ADIS16480_MOD_CHANNEL(IIO_DELTA_ANGL, IIO_MOD_ ## _mod, \
+	ADIS16480_REG_ ## _mod ## _DELTAANG_OUT, -1, \
+	0, \
+	32)
+
+#define ADIS16480_DELTVEL_CHANNEL(_mod) \
+	ADIS16480_MOD_CHANNEL(IIO_DELTA_VELOCITY, IIO_MOD_ ## _mod, \
+	ADIS16480_REG_ ## _mod ## _DELTAVEL_OUT, ADIS16480_SCAN_DELTVEL_ ## _mod, \
+	0, \
+	32)
+
+#define ADIS16480_DELTVEL_CHANNEL_NO_SCAN(_mod) \
+	ADIS16480_MOD_CHANNEL(IIO_DELTA_VELOCITY, IIO_MOD_ ## _mod, \
+	ADIS16480_REG_ ## _mod ## _DELTAVEL_OUT, -1, \
+	0, \
+	32)
+
 #define ADIS16480_MAGN_CHANNEL(_mod) \
 	ADIS16480_MOD_CHANNEL(IIO_MAGN, IIO_MOD_ ## _mod, \
 	ADIS16480_REG_ ## _mod ## _MAGN_OUT, ADIS16480_SCAN_MAGN_ ## _mod, \
@@ -816,7 +856,13 @@ static const struct iio_chan_spec adis16480_channels[] = {
 	ADIS16480_MAGN_CHANNEL(Z),
 	ADIS16480_PRESSURE_CHANNEL(),
 	ADIS16480_TEMP_CHANNEL(),
-	IIO_CHAN_SOFT_TIMESTAMP(11)
+	IIO_CHAN_SOFT_TIMESTAMP(11),
+	ADIS16480_DELTANG_CHANNEL_NO_SCAN(X),
+	ADIS16480_DELTANG_CHANNEL_NO_SCAN(Y),
+	ADIS16480_DELTANG_CHANNEL_NO_SCAN(Z),
+	ADIS16480_DELTVEL_CHANNEL_NO_SCAN(X),
+	ADIS16480_DELTVEL_CHANNEL_NO_SCAN(Y),
+	ADIS16480_DELTVEL_CHANNEL_NO_SCAN(Z),
 };
 
 static const struct iio_chan_spec adis16485_channels[] = {
@@ -827,7 +873,13 @@ static const struct iio_chan_spec adis16485_channels[] = {
 	ADIS16480_ACCEL_CHANNEL(Y),
 	ADIS16480_ACCEL_CHANNEL(Z),
 	ADIS16480_TEMP_CHANNEL(),
-	IIO_CHAN_SOFT_TIMESTAMP(7)
+	IIO_CHAN_SOFT_TIMESTAMP(7),
+	ADIS16480_DELTANG_CHANNEL_NO_SCAN(X),
+	ADIS16480_DELTANG_CHANNEL_NO_SCAN(Y),
+	ADIS16480_DELTANG_CHANNEL_NO_SCAN(Z),
+	ADIS16480_DELTVEL_CHANNEL_NO_SCAN(X),
+	ADIS16480_DELTVEL_CHANNEL_NO_SCAN(Y),
+	ADIS16480_DELTVEL_CHANNEL_NO_SCAN(Z),
 };
 
 enum adis16480_variant {
@@ -938,6 +990,8 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.accel_max_val = IIO_M_S_2_TO_G(21973 << 16),
 		.accel_max_scale = 18,
 		.temp_scale = 5650, /* 5.65 milli degree Celsius */
+		.deltang_max_val = IIO_DEGREE_TO_RAD(180),
+		.deltvel_max_val = 100,
 		.int_clk = 2460000,
 		.max_dec_rate = 2048,
 		.has_sleep_cnt = true,
@@ -952,6 +1006,8 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.accel_max_val = IIO_M_S_2_TO_G(12500 << 16),
 		.accel_max_scale = 10,
 		.temp_scale = 5650, /* 5.65 milli degree Celsius */
+		.deltang_max_val = IIO_DEGREE_TO_RAD(720),
+		.deltvel_max_val = 200,
 		.int_clk = 2460000,
 		.max_dec_rate = 2048,
 		.has_sleep_cnt = true,
@@ -966,6 +1022,8 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.accel_max_val = IIO_M_S_2_TO_G(20000 << 16),
 		.accel_max_scale = 5,
 		.temp_scale = 5650, /* 5.65 milli degree Celsius */
+		.deltang_max_val = IIO_DEGREE_TO_RAD(720),
+		.deltvel_max_val = 50,
 		.int_clk = 2460000,
 		.max_dec_rate = 2048,
 		.has_sleep_cnt = true,
@@ -980,6 +1038,8 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.accel_max_val = IIO_M_S_2_TO_G(22500 << 16),
 		.accel_max_scale = 18,
 		.temp_scale = 5650, /* 5.65 milli degree Celsius */
+		.deltang_max_val = IIO_DEGREE_TO_RAD(720),
+		.deltvel_max_val = 200,
 		.int_clk = 2460000,
 		.max_dec_rate = 2048,
 		.has_sleep_cnt = true,
@@ -994,6 +1054,8 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.accel_max_val = IIO_M_S_2_TO_G(16000 << 16),
 		.accel_max_scale = 8,
 		.temp_scale = 14285, /* 14.285 milli degree Celsius */
+		.deltang_max_val = IIO_DEGREE_TO_RAD(720),
+		.deltvel_max_val = 200,
 		.int_clk = 4250000,
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
@@ -1008,6 +1070,8 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.accel_max_val = IIO_M_S_2_TO_G(32000 << 16),
 		.accel_max_scale = 8,
 		.temp_scale = 12500, /* 12.5 milli degree Celsius */
+		.deltang_max_val = IIO_DEGREE_TO_RAD(360),
+		.deltvel_max_val = 100,
 		.int_clk = 4250000,
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
@@ -1025,6 +1089,8 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.accel_max_val = IIO_M_S_2_TO_G(32000 << 16),
 		.accel_max_scale = 8,
 		.temp_scale = 12500, /* 12.5 milli degree Celsius */
+		.deltang_max_val = IIO_DEGREE_TO_RAD(720),
+		.deltvel_max_val = 100,
 		.int_clk = 4250000,
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
@@ -1042,6 +1108,8 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.accel_max_val = IIO_M_S_2_TO_G(32000 << 16),
 		.accel_max_scale = 8,
 		.temp_scale = 12500, /* 12.5 milli degree Celsius */
+		.deltang_max_val = IIO_DEGREE_TO_RAD(2160),
+		.deltvel_max_val = 100,
 		.int_clk = 4250000,
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
@@ -1059,6 +1127,8 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.accel_max_val = IIO_M_S_2_TO_G(32000 << 16),
 		.accel_max_scale = 40,
 		.temp_scale = 12500, /* 12.5 milli degree Celsius */
+		.deltang_max_val = IIO_DEGREE_TO_RAD(360),
+		.deltvel_max_val = 400,
 		.int_clk = 4250000,
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
@@ -1076,6 +1146,8 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.accel_max_val = IIO_M_S_2_TO_G(32000 << 16),
 		.accel_max_scale = 40,
 		.temp_scale = 12500, /* 12.5 milli degree Celsius */
+		.deltang_max_val = IIO_DEGREE_TO_RAD(720),
+		.deltvel_max_val = 400,
 		.int_clk = 4250000,
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
@@ -1093,6 +1165,8 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.accel_max_val = IIO_M_S_2_TO_G(32000 << 16),
 		.accel_max_scale = 40,
 		.temp_scale = 12500, /* 12.5 milli degree Celsius */
+		.deltang_max_val = IIO_DEGREE_TO_RAD(2160),
+		.deltvel_max_val = 400,
 		.int_clk = 4250000,
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
-- 
2.34.1


