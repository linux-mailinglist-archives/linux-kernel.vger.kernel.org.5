Return-Path: <linux-kernel+bounces-26030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF19282DA21
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 421471F21C4F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D74175B1;
	Mon, 15 Jan 2024 13:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6C+UUEe"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8082F17561;
	Mon, 15 Jan 2024 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3368b1e056eso7262038f8f.3;
        Mon, 15 Jan 2024 05:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705325431; x=1705930231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5ZLiXR5kdUypmrHIYtLlSib8TGB/r6oX4cgy4GCPvM=;
        b=Z6C+UUEenpB5+rWjiFwTmNWq9kCaF/7wc+2YasaKz7Trsy4JWNgw+lv/TJ56XtjzgB
         WZgsLIhYK9yg9JfZGoGYZWTVDTXgD0EF6/Hq2cQDauEuMZi9xMP/h+RcS+haIL5sZp7o
         bxqcQN8WmrihT0/QtCtbRYcDOEyPQJOUe9ouUr+JB6XDhwip4nPpZaQgUb0G7sjpHP7k
         /3BcfxWM4u6Z9U8tyR2nsV69/3nuRDNCRHYMXDr4fC0DSxxpMlNRkba0eIhk4rQmWZyg
         fH1dZ1CNj6+9CuDVUtjhpJYpEamotI0A9XLprSLAJlOWojEWCfZoXDbaIh7QSeDlRTjQ
         iTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705325431; x=1705930231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5ZLiXR5kdUypmrHIYtLlSib8TGB/r6oX4cgy4GCPvM=;
        b=MWW2dAzGF9GSy8Vw7B3NkGWS4KgrwkbMV3XGdHZTUVAWsaG7Y6ot2cXZi3fT3ht06K
         Mjt0eC9VHRK4f2J6RL0vcsBCQeamgnolgKltH8x68Fv7zjk8IRrfX+ceGOgxgGMLU2GF
         OierY55y+mBFJm3vDR3uyRkK23fdlTaEcxjo/o4w9jshIs1xLhfyAAY7J8tEOocJ2Tpt
         0YLfl6697KhKl7EpcX0gjLGbOZSkdqByaSwaupdRvhbCJuukfbdSwN06Mj5rrHvn/VSO
         3AHduK7BVfNf/m9TUlj8r5ySlTgr1VyQ1DfSofBKc1y9B8iZnIiQ6mzACl2Dr1EkPuCi
         Gc5Q==
X-Gm-Message-State: AOJu0YwnBB3g0DyKBLWF0E401B7mZEecP8sfBCqwx3h7y3Lcw7g0hcLn
	cmZljB7iLReDCrUxXiCFtNo=
X-Google-Smtp-Source: AGHT+IEgeuLFnWbC+uyW/D/cvny4NZ3iIkKdFiN+k1H21ZKEbeQ8MT8C6jaSZqa6FG0M3By1LLHlJA==
X-Received: by 2002:a5d:6588:0:b0:337:358d:4b5e with SMTP id q8-20020a5d6588000000b00337358d4b5emr3077432wru.73.1705325430766;
        Mon, 15 Jan 2024 05:30:30 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id i6-20020adfb646000000b003378d89737fsm11566669wre.46.2024.01.15.05.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 05:30:30 -0800 (PST)
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
Subject: [PATCH v3 3/5] iio: amplifiers: hmc425a: move conversion logic
Date: Mon, 15 Jan 2024 15:30:16 +0200
Message-ID: <20240115133023.3465-4-mitrutzceclan@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240115133023.3465-1-mitrutzceclan@gmail.com>
References: <20240115133023.3465-1-mitrutzceclan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move gain-dB<->code conversion logic from read_raw and write_raw to
hmc425a_gain_dB_to_code() and hmc425a_code_to_gain_dB().

Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
---
 drivers/iio/amplifiers/hmc425a.c | 102 ++++++++++++++++++-------------
 1 file changed, 59 insertions(+), 43 deletions(-)

diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/hmc425a.c
index ed4d72922696..e1162a500daf 100644
--- a/drivers/iio/amplifiers/hmc425a.c
+++ b/drivers/iio/amplifiers/hmc425a.c
@@ -56,35 +56,72 @@ static int hmc425a_write(struct iio_dev *indio_dev, u32 value)
 	return 0;
 }
 
+static int hmc425a_gain_dB_to_code(struct hmc425a_state *st, int val, int val2, int *code)
+{
+	struct hmc425a_chip_info *inf = st->chip_info;
+	int gain, temp;
+
+	if (val < 0)
+		gain = (val * 1000) - (val2 / 1000);
+	else
+		gain = (val * 1000) + (val2 / 1000);
+
+	if (gain > inf->gain_max || gain < inf->gain_min)
+		return -EINVAL;
+
+	switch (st->type) {
+	case ID_HMC425A:
+		*code = ~((abs(gain) / 500) & 0x3F);
+		return 0;
+	case ID_HMC540S:
+		*code = ~((abs(gain) / 1000) & 0xF);
+		return 0;
+	case ID_ADRF5740:
+		temp = (abs(gain) / 2000) & 0xF;
+		*code = temp & BIT(3) ? temp | BIT(2) : temp;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int hmc425a_code_to_gain_dB(struct hmc425a_state *st, int *val, int *val2)
+{
+	int code, gain;
+
+	code = st->gain;
+	switch (st->type) {
+	case ID_HMC425A:
+		gain = ~code * -500;
+		break;
+	case ID_HMC540S:
+		gain = ~code * -1000;
+		break;
+	case ID_ADRF5740:
+		code = code & BIT(3) ? code & ~BIT(2) : code;
+		gain = code * -2000;
+		break;
+	}
+
+	*val = gain / 1000;
+	*val2 = (gain % 1000) * 1000;
+
+	return 0;
+}
+
 static int hmc425a_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan, int *val,
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
+		ret = hmc425a_code_to_gain_dB(st, val, val2);
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
@@ -100,36 +137,15 @@ static int hmc425a_write_raw(struct iio_dev *indio_dev,
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
+		ret = hmc425a_gain_dB_to_code(st, val, val2, &code);
+		if (ret)
+			break;
 		st->gain = code;
-
 		ret = hmc425a_write(indio_dev, st->gain);
 		break;
 	default:
-- 
2.42.0


