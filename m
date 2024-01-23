Return-Path: <linux-kernel+bounces-35548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9518839311
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 488701F23AD6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C45061674;
	Tue, 23 Jan 2024 15:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ioSmhcqz"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0A560BBA
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024079; cv=none; b=OQPLwedq4iZZCm0pbWJ/c+NsTRC1kunGGG0873bsTnGbpk/I6C5BIlV3VVpahnkOPhLqFCQTndyTl9YK1bNL1wrxukbB8oPx1J1JEsvXp9PQCTZMDqgltdQVLU3wpzSMi3NGL+PqvuWXDu8LdVfUVO9yGvKg4KwrQkvDmpjJuxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024079; c=relaxed/simple;
	bh=ABSBo8ChnyWfSDmKV7SkQrHMoHBUlI2Sroam7dwUzCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzw4xbV8k6FDl4cmBmFVPDMMd0JmwNPmxnOudelG+ndtL/IsmkynAPyXgLK/3UTJISgWftT9UCHmCMV3R0BJ3vtP9tgbG9jWqgJ5CIe1Ja9R7Z7Ya9GGplmUmDcJ0bKRg7fKUapB1f3af1N/f/OA9+CgB6z900d/EuvJbgmbM8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ioSmhcqz; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40ec2594544so4095295e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 07:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706024075; x=1706628875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BB2Xa0B54slaxQ4TFzJZkt9rUGgpa6L4k5N0BA4Wago=;
        b=ioSmhcqzk9xBOnliJ7fe26EMcL/uk3BWE065odkQ3uhog+Hdo+usdhF6y+om+3azGz
         8ghhpKTmxwmwXkFR7D2YMYeg2+zJI6O3Ku+8PAQIgqsXuAe4YKV126pqFHCzAr9ettA4
         aiO+PVbRxZzFd2Arip+1QZcw1gpI/TJOk+wmoSFpKKAnCriPuts+P+TeKxfQtb9/HEBC
         i1nBcLeHA3BFpsoFgK9wKMDdRMz7/wt1AAElxC5dpebnVsg/qS3S+7u2NsVmd8lGguvn
         ZLAT/RrOqe03noggtPYV2klFHpdn/ISZRQbmsy7OIy+O/ZjcsOtaTPes70WOByUPBHth
         2Ztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706024075; x=1706628875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BB2Xa0B54slaxQ4TFzJZkt9rUGgpa6L4k5N0BA4Wago=;
        b=hb1BK52PiCZu/8GQWdGjnBUuAqkRpTVe5OL6eyVlhR9KZ9Yr6P/DH5vxr5Izlh98yT
         TH7xegIIgGGCK91ynk7I01icGuB0vubOl6ETIDwavlpqv3Zw+itjhwYwpGwViGCrq/Mq
         unEzAmCELCOzKMiApJnSga5nq0xmoP7NMu8W5TH3kl4OfRoxMf1tVCWkTpkSllvbZ7zo
         aAAPbQCnXOci4fuG5ry1eav0U8llY2aj7vSd8FJGG+WGs02Dtj6Pz4vVbd+NM0Efb21k
         6uD1ywN2MhU78kfHJ1uGc1djk6adRO7dxHkUQSt+JZ9Mzis7gog8ak9VzeKd2gYD7qpW
         gOaw==
X-Gm-Message-State: AOJu0Yx5IfDpLM75z0rjZu3idyIY2KOOB/Szc4qRA/mIhroUw8MjmTCH
	VbQC0uMIL0/eyvuXe45HsLmW0iio+SXmk+o0kak83IoG3OFhwW5dWIfTcAmZx4Y=
X-Google-Smtp-Source: AGHT+IEp2Ri4s9MSjNV1VlE0RaiDM1zebT1VTZlSVw5LZqKCz7pZak2vpPPA7KZ21bzUs72y5miHDg==
X-Received: by 2002:a05:600c:2108:b0:40e:62c9:9e6f with SMTP id u8-20020a05600c210800b0040e62c99e6fmr241876wml.184.1706024075595;
        Tue, 23 Jan 2024 07:34:35 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id p21-20020a05600c359500b0040e3488f16dsm42457536wmq.12.2024.01.23.07.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 07:34:34 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	arnd@arndb.de
Cc: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	semen.protsenko@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 11/21] spi: s3c64xx: check return code of dmaengine_slave_config()
Date: Tue, 23 Jan 2024 15:34:10 +0000
Message-ID: <20240123153421.715951-12-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240123153421.715951-1-tudor.ambarus@linaro.org>
References: <20240123153421.715951-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check the return code of dmaengine_slave_config().

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 4b13252da8b8..cc33647eab14 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -296,7 +296,9 @@ static int prepare_dma(struct s3c64xx_spi_dma_data *dma,
 		config.dst_maxburst = 1;
 	}
 	config.direction = dma->direction;
-	dmaengine_slave_config(dma->ch, &config);
+	ret = dmaengine_slave_config(dma->ch, &config);
+	if (ret)
+		return ret;
 
 	desc = dmaengine_prep_slave_sg(dma->ch, sgt->sgl, sgt->nents,
 				       dma->direction, DMA_PREP_INTERRUPT);
-- 
2.43.0.429.g432eaa2c6b-goog


