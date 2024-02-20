Return-Path: <linux-kernel+bounces-73254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E1D85C01A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89F1E1C21CA1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2044676C7A;
	Tue, 20 Feb 2024 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMLxWeq7"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A00576031;
	Tue, 20 Feb 2024 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708443363; cv=none; b=Cb3VEZo0+ywVQTTxEcHWKtBeQjby964oLqK0t3pGsbs7NDMI+86AxoFB/WMF5zxZ+Xd/BxytNAV1D+k666kOvfWbHLXW3I3GRwr2uWjdU+cLG3R4c09RsOBPvlNP8BNOO5TxeGIsmkv2KmykX6sj3zNfRxZmThkOWaogLtzexHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708443363; c=relaxed/simple;
	bh=Ci1c8M5BZkBhBCDvDrK0yrzanN8h67rkNcr/H4t+X34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lMlT82sZ6AAFE5X4fTltjudRylJuZ/nSxOJd8Ce2Nk0sfEyUJZeyby0gI+5GH9JmpxSXSdRGngTT+XLlnNIgflJy2CYzKeYzp++zYJONCqVgexwzaGqPKPjti9pEYYMww2px8lMUeXSHGp/fT6D3V70Zo94cH3v+cxNTgGJgD9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMLxWeq7; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-512b42b6697so2643479e87.1;
        Tue, 20 Feb 2024 07:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708443359; x=1709048159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DrQxLajP2KRm+hEcTrLRUd6tk//QuwVaoXrLr/ObD7Y=;
        b=LMLxWeq79yiPso0QKr2EENtf9qwtoaZsI37ipBv17BAMXXyI6gWnZJ11LFVLjM+CMG
         4Y8wItNStMa5lkp2eDeZD0ZULlqYAMwVFfYc0A5S3+aoB251Itq0E/zmM6TG39uKhLJl
         4C1WreEjZ99kDWhPvls2sXcN1If4J2mHPyJaiVBOy42hUsC2Oq9wLoLHSOGovcphLCrx
         p/PVyUIREgv//OEDQe7iQv/Y6+fKfQut9csdMEXfT8jkeq5l1h84Z4mW54eJ6Vtf3u6n
         cGpiEZ9dX8dLcBWZviIPULcFCQZJ6mJekiRl9e7oKVZdXYBBMpdgziUW+4olclEqwx6J
         EdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708443359; x=1709048159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DrQxLajP2KRm+hEcTrLRUd6tk//QuwVaoXrLr/ObD7Y=;
        b=wzTYb/Fqd4Vyi+uCkRe3cat9ySG+m4ofddlvkCM1rU44XncGQAQaAJpNtjOaFO3Rge
         oIsFu/wCtyoPQ7bYdOvExumcFIQSMeSKUyaHFtuNa4BP5NzA1hmJQcSiA6R9lSwY1Wp2
         3qpAlhrrP0xd7RTo1MfXDnnq+ndzJoU8xCLBdXXg0VhEVWLO5RBpsCTEhSY09hxWfI3N
         TkO3smpqFKhfFQqbU9cq5lPHldqpiMmaO4qceZS6sdvz9KVPYDQQ1P9cYAq4lBsLlATv
         LcMQ/7aSl5ZIrQIH8U8vhJiN0h4yVlsd6MS8+6/Ib1C3MyiE1MuXy48cSQWIeWV4B+aH
         6Zfw==
X-Forwarded-Encrypted: i=1; AJvYcCX39Dp23xN3dV8zTwnFkFFfgUTiVDVWrGE/20x6GozGz06sjHQ1Wl8dNXEkC2lbLZqgi7UjDx5l7eF1tTgvGe0fT189/vmYVl/cZF5aoXyoBmILq4j5fHDy/RfVpmSpqdojMAdiQg23uk0iQb9Oq1s2xgvK5v2bkhsD7MuzUlYEN9VQ+g==
X-Gm-Message-State: AOJu0YzdkY2fmeLuF9rNceOHSNASixjaRLyLGno9xeq6ZAQHEXc4nGdj
	HFeTtirxbCjm6wkle+F8LzRJvjDwiF+tPP2VJTC5puBjXL9ywBhK
X-Google-Smtp-Source: AGHT+IGRWNUV75vSG1KgSddGcHi0L+Lpflmoqp0Sc3b66p2c5wGhchaY3zWjTWl5DCO7wrtz97LPGQ==
X-Received: by 2002:a05:6512:200d:b0:512:8a57:d0b5 with SMTP id a13-20020a056512200d00b005128a57d0b5mr8675777lfb.16.1708443358826;
        Tue, 20 Feb 2024 07:35:58 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id r22-20020a170906281600b00a3d777aa8fesm4039024ejc.69.2024.02.20.07.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 07:35:58 -0800 (PST)
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
Subject: [PATCH v5 3/5] iio: amplifiers: hmc425a: move conversion logic
Date: Tue, 20 Feb 2024 17:34:49 +0200
Message-ID: <20240220153553.2432-2-mitrutzceclan@gmail.com>
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

Move gain-dB<->code conversion logic from read_raw and write_raw to
chip_info callbacks.

Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
---
 drivers/iio/amplifiers/hmc425a.c | 126 ++++++++++++++++++++-----------
 1 file changed, 83 insertions(+), 43 deletions(-)

diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/hmc425a.c
index ed4d72922696..13e018a59637 100644
--- a/drivers/iio/amplifiers/hmc425a.c
+++ b/drivers/iio/amplifiers/hmc425a.c
@@ -34,6 +34,9 @@ struct hmc425a_chip_info {
 	int				gain_min;
 	int				gain_max;
 	int				default_gain;
+
+	int				(*gain_dB_to_code)(int gain, int *code);
+	int				(*code_to_gain_dB)(int code, int *val, int *val2);
 };
 
 struct hmc425a_state {
@@ -44,6 +47,74 @@ struct hmc425a_state {
 	u32	gain;
 };
 
+static int gain_dB_to_code(struct hmc425a_state *st, int val, int val2, int *code)
+{
+	struct hmc425a_chip_info *inf = st->chip_info;
+	int gain;
+
+	if (val < 0)
+		gain = (val * 1000) - (val2 / 1000);
+	else
+		gain = (val * 1000) + (val2 / 1000);
+
+	if (gain > inf->gain_max || gain < inf->gain_min)
+		return -EINVAL;
+
+	return st->chip_info->gain_dB_to_code(gain, code);
+}
+
+static int hmc425a_gain_dB_to_code(int gain, int *code)
+{
+	*code = ~((abs(gain) / 500) & 0x3F);
+	return 0;
+}
+
+static int hmc540s_gain_dB_to_code(int gain, int *code)
+{
+	*code = ~((abs(gain) / 1000) & 0xF);
+	return 0;
+}
+
+static int adrf5740_gain_dB_to_code(int gain, int *code)
+{
+	int temp = (abs(gain) / 2000) & 0xF;
+
+	/* Bit [0-3]: 2dB 4dB 8dB 8dB */
+	*code = temp & BIT(3) ? temp | BIT(2) : temp;
+	return 0;
+}
+
+static int code_to_gain_dB(struct hmc425a_state *st, int *val, int *val2)
+{
+	return st->chip_info->code_to_gain_dB(st->gain, val, val2);
+}
+
+static int hmc425a_code_to_gain_dB(int code, int *val, int *val2)
+{
+	*val = (~code * -500) / 1000;
+	*val2 = ((~code * -500) % 1000) * 1000;
+	return 0;
+}
+
+static int hmc540s_code_to_gain_dB(int code, int *val, int *val2)
+{
+	*val = (~code * -1000) / 1000;
+	*val2 = ((~code * -1000) % 1000) * 1000;
+	return 0;
+}
+
+static int adrf5740_code_to_gain_dB(int code, int *val, int *val2)
+{
+	/*
+	 * Bit [0-3]: 2dB 4dB 8dB 8dB
+	 * When BIT(3) is set, unset BIT(2) and use 3 as double the place value
+	 */
+	code = code & BIT(3) ? code & ~BIT(2) : code;
+	*val = (code * -2000) / 1000;
+	*val2 = ((code * -2000) % 1000) * 1000;
+	return 0;
+}
+
 static int hmc425a_write(struct iio_dev *indio_dev, u32 value)
 {
 	struct hmc425a_state *st = iio_priv(indio_dev);
@@ -61,30 +132,14 @@ static int hmc425a_read_raw(struct iio_dev *indio_dev,
 			    int *val2, long m)
 {
 	struct hmc425a_state *st = iio_priv(indio_dev);
-	int code, gain = 0;
 	int ret;
 
 	mutex_lock(&st->lock);
 	switch (m) {
 	case IIO_CHAN_INFO_HARDWAREGAIN:
-		code = st->gain;
-
-		switch (st->type) {
-		case ID_HMC425A:
-			gain = ~code * -500;
-			break;
-		case ID_HMC540S:
-			gain = ~code * -1000;
+		ret = code_to_gain_dB(st, val, val2);
+		if (ret)
 			break;
-		case ID_ADRF5740:
-			code = code & BIT(3) ? code & ~BIT(2) : code;
-			gain = code * -2000;
-			break;
-		}
-
-		*val = gain / 1000;
-		*val2 = (gain % 1000) * 1000;
-
 		ret = IIO_VAL_INT_PLUS_MICRO_DB;
 		break;
 	default:
@@ -100,36 +155,15 @@ static int hmc425a_write_raw(struct iio_dev *indio_dev,
 			     int val2, long mask)
 {
 	struct hmc425a_state *st = iio_priv(indio_dev);
-	struct hmc425a_chip_info *inf = st->chip_info;
-	int code = 0, gain;
-	int ret;
-
-	if (val < 0)
-		gain = (val * 1000) - (val2 / 1000);
-	else
-		gain = (val * 1000) + (val2 / 1000);
-
-	if (gain > inf->gain_max || gain < inf->gain_min)
-		return -EINVAL;
-
-	switch (st->type) {
-	case ID_HMC425A:
-		code = ~((abs(gain) / 500) & 0x3F);
-		break;
-	case ID_HMC540S:
-		code = ~((abs(gain) / 1000) & 0xF);
-		break;
-	case ID_ADRF5740:
-		code = (abs(gain) / 2000) & 0xF;
-		code = code & BIT(3) ? code | BIT(2) : code;
-		break;
-	}
+	int code = 0, ret;
 
 	mutex_lock(&st->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_HARDWAREGAIN:
+		ret = gain_dB_to_code(st, val, val2, &code);
+		if (ret)
+			break;
 		st->gain = code;
-
 		ret = hmc425a_write(indio_dev, st->gain);
 		break;
 	default:
@@ -189,6 +223,8 @@ static struct hmc425a_chip_info hmc425a_chip_info_tbl[] = {
 		.gain_min = -31500,
 		.gain_max = 0,
 		.default_gain = -0x40, /* set default gain -31.5db*/
+		.gain_dB_to_code = hmc425a_gain_dB_to_code,
+		.code_to_gain_dB = hmc425a_code_to_gain_dB,
 	},
 	[ID_HMC540S] = {
 		.name = "hmc540s",
@@ -198,6 +234,8 @@ static struct hmc425a_chip_info hmc425a_chip_info_tbl[] = {
 		.gain_min = -15000,
 		.gain_max = 0,
 		.default_gain = -0x10, /* set default gain -15.0db*/
+		.gain_dB_to_code = hmc540s_gain_dB_to_code,
+		.code_to_gain_dB = hmc540s_code_to_gain_dB,
 	},
 	[ID_ADRF5740] = {
 		.name = "adrf5740",
@@ -207,6 +245,8 @@ static struct hmc425a_chip_info hmc425a_chip_info_tbl[] = {
 		.gain_min = -22000,
 		.gain_max = 0,
 		.default_gain = 0xF, /* set default gain -22.0db*/
+		.gain_dB_to_code = adrf5740_gain_dB_to_code,
+		.code_to_gain_dB = adrf5740_code_to_gain_dB,
 	},
 };
 
-- 
2.42.0


