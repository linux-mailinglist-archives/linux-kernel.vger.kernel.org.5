Return-Path: <linux-kernel+bounces-85012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 351EE86AF22
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD3CC1F22FF0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590CE6CDC5;
	Wed, 28 Feb 2024 12:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiTq2hI+"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153673BBF7;
	Wed, 28 Feb 2024 12:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709123215; cv=none; b=FwWHBcquo0CTjV97ZRXT2ETRnaK2vbDbbHD3OnWfb0Mt7TwKBtghD8s5ybxxyjuGR4B+CmF2GMm4R3e/NVSEhD5xZzOdOVjb14gU3jJk2SO320kMCod7bnJtHq3WhwF6crpUP7QBONdMhen9dEFlA6twxTRmBw1eeW+6h1JJhwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709123215; c=relaxed/simple;
	bh=9LRp6pyZzKOPMwdJmb0cgyOrxZ2yUXGdwFoFFeN5y3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F/n7Ni+okfXpTXiCYoW6EC4S2pRCEsyM/LJ3KTSjaWxHKZs/vuoatbes9UyjLv8pBJxYbyIV2ZGSJp8kjd8MwGfTH0kBCQVSb/XZTn6BOIpD8ifX+dMAbP2+B7ou5ZkuXEhxHMS65FVp/cAymoxeMFVDT2ZplhGhs89zv08vsRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiTq2hI+; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a4419683a6bso33637866b.1;
        Wed, 28 Feb 2024 04:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709123212; x=1709728012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfu1NXdJaxRIuGk1AGGi0w8J7Vn0Rmrv+AxI/bKxIZU=;
        b=iiTq2hI+KN3cQ50pZgxmicOeV4QEKNbNFiPWs5jf8/G7n6QxDt1i9u9UHagOh8UxHZ
         5sXiB+te0snFQVFECmW1QMFade5kC+uwIHnCQdoHy9Gpvvl6WeCphbcsjTC60j4MXud0
         gZY+IOWnYyNreJFTLf69j1vcDpbKj9QKojZ9w4wNzQNI6FksiA+4nmAhHFxCpDN4wXk4
         Lv8m0jLqDc7b6Jih1MQy8wvURf7COZ0e4RdpxESjRb8056zK5IWOVUbYvxBDT2mwC02O
         uop4SbzQ7pj5h4zMJAr/ZT8NyiGO9jehNpZQGZZuSxVU9U1Q0zB8c60E2ic7v8l5Bjnj
         zRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709123212; x=1709728012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yfu1NXdJaxRIuGk1AGGi0w8J7Vn0Rmrv+AxI/bKxIZU=;
        b=Dvc2pzpcwMqakzwU40eXN7byq0/1q5cOaRBZkFlY6KTmEB8cnoJTTZA0pcX8TfLxda
         dbgPbu+ZOhnieQ4FMaBIJamWObVCwkFr7R+AoySkObh/YMcFVCSJqigeaE026oHNcoUv
         1eyIgpKFA7Chz9a3j0of7qNon/9u56jVS3XCwuljXu4cQaJMAL9f7z3URdjyuaez/2J0
         GwtNLhmvd9XMvYLqc2aqY3c2tg+OQpR4bNOouwxJl+0mrF14PjpPIpb5g0ErrCDJ9kZN
         HZEl8O002HThjCRiJxKP+1OP36GiCRAW8wmgCWADHb4OfecF23V7tB1ktG39PFnMs14c
         D4Fw==
X-Forwarded-Encrypted: i=1; AJvYcCXhjFyMiK5XA6Brt5UAhplj8tZZdg4kvHuZEfJlYqwH0steef6jU2jx5RvexcOu8QgfaIBcx6qlUGl8XI0VWzfcTrEDi6FsXFJZDt0xzZJu7bSmZ3w6fgpAndpWF/Z1lwTj1x1Dpm0al3rDXF3zG2KsQF9mLi0kei/bb45LAgSrOC/sUQ==
X-Gm-Message-State: AOJu0YxK2IYdE47oGXuVMadhYZTU4IDfEEWXXLE9O8sdbvWRHIGzPajY
	xCS+jZMngWR1+i38PKEmU0n2rAd5jGWcWm9w+OEey2SU2tzy0XWX
X-Google-Smtp-Source: AGHT+IE1NiJeYEubifaFA/hUzo6Udj5vWz5f5UUWJg5PzMbVijkXKbPCZQlLp/Qh0IFejTdtP4OcSA==
X-Received: by 2002:a17:906:c40c:b0:a3f:d2f3:d226 with SMTP id u12-20020a170906c40c00b00a3fd2f3d226mr8362653ejz.17.1709123212058;
        Wed, 28 Feb 2024 04:26:52 -0800 (PST)
Received: from spiri.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id f3-20020a170906c08300b00a3d1c0a3d5dsm1800417ejz.63.2024.02.28.04.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 04:26:51 -0800 (PST)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: michael.hennerich@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com,
	nuno.sa@analog.com,
	alisa.roman@analog.com,
	dlechner@baylibre.com
Subject: [PATCH v4 1/4] iio: adc: ad7192: Pass state directly
Date: Wed, 28 Feb 2024 14:26:14 +0200
Message-Id: <20240228122617.185814-2-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228122617.185814-1-alisa.roman@analog.com>
References: <20240228122617.185814-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass only the ad7192_state structure. There is no need to pass the
iio_dev structure.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
Signed-off-by: romandariana <alisa.roman@analog.com>
---
 drivers/iio/adc/ad7192.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 7bcc7e2aa2a2..72de9cc6716e 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -387,9 +387,9 @@ static int ad7192_clock_select(struct ad7192_state *st)
 	return clock_sel;
 }
 
-static int ad7192_setup(struct iio_dev *indio_dev, struct device *dev)
+static int ad7192_setup(struct ad7192_state *st)
 {
-	struct ad7192_state *st = iio_priv(indio_dev);
+	struct device *dev = &st->sd.spi->dev;
 	bool rej60_en, refin2_en;
 	bool buf_en, bipolar, burnout_curr_en;
 	unsigned long long scale_uv;
@@ -460,7 +460,7 @@ static int ad7192_setup(struct iio_dev *indio_dev, struct device *dev)
 	/* Populate available ADC input ranges */
 	for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++) {
 		scale_uv = ((u64)st->int_vref_mv * 100000000)
-			>> (indio_dev->channels[0].scan_type.realbits -
+			>> (st->chip_info->channels[0].scan_type.realbits -
 			!FIELD_GET(AD7192_CONF_UNIPOLAR, st->conf));
 		scale_uv >>= i;
 
@@ -1152,7 +1152,7 @@ static int ad7192_probe(struct spi_device *spi)
 		}
 	}
 
-	ret = ad7192_setup(indio_dev, &spi->dev);
+	ret = ad7192_setup(st);
 	if (ret)
 		return ret;
 
-- 
2.34.1


