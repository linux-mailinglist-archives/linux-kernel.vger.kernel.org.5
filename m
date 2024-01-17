Return-Path: <linux-kernel+bounces-28990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F26830615
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F9DB1F2539D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DDD200C3;
	Wed, 17 Jan 2024 12:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVeGgeS5"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A891F606;
	Wed, 17 Jan 2024 12:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705495899; cv=none; b=VyncjEBSnVOc4YI0JkWuzbWSLiZrt9J2tyqA6jOTztAQsrYjnTNJ4KdYn+FJ5Uqb7zgD26jPAGf4yqS+m+XBSkSAQ49QGq+NrifHHsC7tfH10JJMpJWShO1+lxJZ3NVYn2Tu5ltTPcYIqMVcZKw3dxq21JwC2hKJfRVmjGZ31eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705495899; c=relaxed/simple;
	bh=rZdXxZyCEnWFR8TyQNWm4yjCaV4aXUlaTR3kIo+Mdm8=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=oB0gIxvdKwfHinL6yLFHIwRT0mm0cRR+we6KeXj6fD3kYuipi9cDauAdMf2PPwlkdWIAi7RTPsIrnz0KxT4D3E3zXOanZbyt4uWL6JE3/1f9k3i++60ZgWcVe94R4XwG6I8lVn31c1Zmai/QN+h8LV6mlzajxSnHoeVb29Q0zhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVeGgeS5; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a2cea0563cbso756315366b.3;
        Wed, 17 Jan 2024 04:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705495896; x=1706100696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5ZLiXR5kdUypmrHIYtLlSib8TGB/r6oX4cgy4GCPvM=;
        b=NVeGgeS5vcNO1UBliZCo2INJvYokLcPWcDfRPBv5SEqmC5WhsAuV71dQUK82LI4Vvr
         +wF18fZKqXg7JnTPKcO/pJ37X4Dg5J6HBFVAtrof+Q2PivqA2YXI76weNZZ0S53JXntK
         ujaIw/DEUTv1aFzeKDn3awklYmvvfnepyIKkjK5AxMu3cUP6uHuWKWZg4mqGs0Yhb1zE
         15AZJqU1xOjGEaqaH9Fswixx5fZ3L8edgCeX7kGh3jufQ+SjCUdc6l1ppcoP1FslKYVx
         CM7gbpVO6tbBytcZbCFeaO00y0EQXGP9VBOJ+kLlHaI4WdeYuqXo+aDD0hpKZP+ALBjQ
         HF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705495896; x=1706100696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5ZLiXR5kdUypmrHIYtLlSib8TGB/r6oX4cgy4GCPvM=;
        b=vNaJfudphuQ/XjYXFOglG1RPerCylx/6ig2WsuLiKcJ93eURm7aE0ANjdUgVzHWA89
         Xs/42RL8y6Fwj8ZO1MfPSHt7oQQxukBj2HBGWxAu9T/Ocwuklrt0BbeAObeMKppzNBfO
         YLKwoUDdRozFyxAzAjug/HzuUaoE5/4U3Qvj3Sn+JvjvMhDRwrdOAwoNfaOa+eD7cmja
         jWkvBOLLyQxK3VICQYdlC0o1GthOfksU0vlHKoWGDIw10CJt83ZEUb+R1Y6B856gP99l
         CJ+J3crvyA5l20YVifKojkgRKLAddrteW0mphcDW3Nn1d6c+zM+ZFYZmLnaSnyEivBKO
         NrRw==
X-Gm-Message-State: AOJu0YzdquyFb4GpSfW7LzKYYOmXCbiuRB7pyVdpHvxbSStT0jnHhPed
	9K3wDxlJkrCXePP5N+H1PInDUrwG4Fc/jw==
X-Google-Smtp-Source: AGHT+IF9r/nZwOZ6mVkIlgUhmh2o3dTQNnudOztLr/ghUY3RPJs3BsEw0t1t/thmpn2iH4xPC+l9Dg==
X-Received: by 2002:a17:906:30c2:b0:a2c:1061:c648 with SMTP id b2-20020a17090630c200b00a2c1061c648mr4343059ejb.9.1705495896169;
        Wed, 17 Jan 2024 04:51:36 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id t13-20020a17090616cd00b00a2ea45637desm1277247ejd.112.2024.01.17.04.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 04:51:35 -0800 (PST)
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
Subject: [PATCH v4 3/5] iio: amplifiers: hmc425a: move conversion logic
Date: Wed, 17 Jan 2024 14:51:12 +0200
Message-ID: <20240117125124.8326-4-mitrutzceclan@gmail.com>
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


