Return-Path: <linux-kernel+bounces-8293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9844981B50C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C6FB1F25EF3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3635773177;
	Thu, 21 Dec 2023 11:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrfjNQd1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023C76E5AA;
	Thu, 21 Dec 2023 11:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40c339d2b88so6921845e9.3;
        Thu, 21 Dec 2023 03:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703158740; x=1703763540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z0/TYd/8rVyUf11DYs46AxL5K7um2W7Rvs+jbNKoDFo=;
        b=RrfjNQd1SkcvXtE8VJGpTfLSkXtz/D2tysmfAO/6CKmaTuSBthNBspJJodJz3xgG1A
         XRjqaXBEwb2rzWAaSNMySg6J2G6yQx3WETeqwK9cevu69FbMr93t9oy8rfPa89Eg42GT
         R3szgWVoHhw6mwHrKaORKTKH5v0lTedAOEAWyrSftIRbN7KU3wp93XC5/JnzLgW4OtDj
         Wx0nV/6r7sPH16E3cMxUjV202VJrKhtydA1Qd8rZnzJDLdMtXjIACGN8uEBJ1Yldz2NB
         dvRW/NWVFnoZcJ/kWfVZOQ8j29XbkowMW811ZQZCq4A6ChUcwAq5wS5MTqY+yCw2aBYU
         H30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703158740; x=1703763540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z0/TYd/8rVyUf11DYs46AxL5K7um2W7Rvs+jbNKoDFo=;
        b=h05q/E9F/u760tr6cw6MpWGb/kH2+21rO12JHiooBZy97/aqVxzsQYeQnR/hcqZL4J
         vUsQjLdbTCXFRSxPY9jo3rrfurqxXAWt/hNh3QCp8C4qLLeYN+nY/tq+96zx88vJuaFn
         lOBgi7cww0j0rURO3D91IzsRRXkq2hvHTsUb6aS6dJsswtDrs8P6DOxr5goEfYt9ge2O
         j/yO1ZJUjGQsaT0jmvDoy5ncamgg0mHHTXP9lGcbv0Xrv8zka2Oh9+mpj94RSsTv7ESH
         16bAMft7eWDxdF+B7dIhHboW2OvRPLm1F5B6bFSHloDjZ0A1gBYJVzPow1zWhEG6ZUtL
         4crQ==
X-Gm-Message-State: AOJu0YyuMhYD2ZzslRMiuenf3B9Fvu7qvtbM+tIv9K8PEijFooUvoYj0
	4MxVXmZYg6Baq9E7soa+mGs=
X-Google-Smtp-Source: AGHT+IFr1yaSw8trK5frteAEEJccS+RNZHpn7HuXmQ69F3+1PucV4dhn84sD+bN4J/nDvZmxj5IsHg==
X-Received: by 2002:a05:600c:1548:b0:40c:2e1c:8f93 with SMTP id f8-20020a05600c154800b0040c2e1c8f93mr659929wmg.179.1703158739869;
        Thu, 21 Dec 2023 03:38:59 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([213.157.161.11])
        by smtp.gmail.com with ESMTPSA id fl25-20020a05600c0b9900b0040b3e26872dsm10940404wmb.8.2023.12.21.03.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 03:38:59 -0800 (PST)
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
Subject: [PATCH 2/3] iio: amplifiers: hmc425a: move conversion logic
Date: Thu, 21 Dec 2023 13:38:39 +0200
Message-ID: <20231221113842.25957-3-mitrutzceclan@gmail.com>
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

Move gain-dB<->code conversion logic from read_raw and write_raw to
hmc425a_gain_dB_to_code() and hmc425a_code_to_gain_dB().

Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
---
 drivers/iio/amplifiers/hmc425a.c | 100 ++++++++++++++++++-------------
 1 file changed, 57 insertions(+), 43 deletions(-)

diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/hmc425a.c
index ed4d72922696..b5fd19403d15 100644
--- a/drivers/iio/amplifiers/hmc425a.c
+++ b/drivers/iio/amplifiers/hmc425a.c
@@ -56,35 +56,70 @@ static int hmc425a_write(struct iio_dev *indio_dev, u32 value)
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
+		break;
+	case ID_HMC540S:
+		*code = ~((abs(gain) / 1000) & 0xF);
+		break;
+	case ID_ADRF5740:
+		temp = (abs(gain) / 2000) & 0xF;
+		*code = temp & BIT(3) ? temp | BIT(2) : temp;
+		break;
+	}
+	return 0;
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
-			break;
-		case ID_ADRF5740:
-			code = code & BIT(3) ? code & ~BIT(2) : code;
-			gain = code * -2000;
+		ret = hmc425a_code_to_gain_dB(st, val, val2);
+		if (ret)
 			break;
-		}
-
-		*val = gain / 1000;
-		*val2 = (gain % 1000) * 1000;
-
 		ret = IIO_VAL_INT_PLUS_MICRO_DB;
 		break;
 	default:
@@ -100,36 +135,15 @@ static int hmc425a_write_raw(struct iio_dev *indio_dev,
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


