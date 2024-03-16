Return-Path: <linux-kernel+bounces-105158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 311EE87D9D7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 12:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9A7E1F21907
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 11:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721A018027;
	Sat, 16 Mar 2024 11:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkEQrEEB"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30AE17BAF;
	Sat, 16 Mar 2024 11:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710587278; cv=none; b=lF4sC+Bx1HnUn1H1ZdZ33WNpWZ0vHRstPq8K6PE27FZu9QyrPt16+Lyu1oYiU9rSIAbqHbE5AKNuK5nYfOCQ9xr78XDfOpZkvvBaHnlVXHKHvD5UYmfmQaCizYamKeZ0iLdF3HZmIIkZG2zij+V9DCT+NnLy047BrBtWZ12o3cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710587278; c=relaxed/simple;
	bh=nQsUfa83tl0YhyaJGxxaECbg0XLcXaowiMIY4sSj3s0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fFcNTwWOTjo2PIJJt9qdhjvEHdXxuWXs2brMmbJ+yeq7w7g+Vek+zHwv5NO+I56MRVlY+IjPnK+/p9AfvOsNfyKoAHfqjgg6Nk2UAQcv9rz6iu962kbY/2ySGIz/Qn7sUbHErZmw85A+CCFE+0pEoXDh69+D7i+6onDsADtjd9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UkEQrEEB; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a469adabc4cso128463466b.2;
        Sat, 16 Mar 2024 04:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710587274; x=1711192074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azsNtSIGobhoP54I2iCnLJg74NKdgh6eoP1MAVpKh38=;
        b=UkEQrEEB1haILp26OG4LPaDwxee4bdhE99iAg8O9mXH03ECiLti4n0+Xhq5T5/qDjr
         uPGj9U9qO1+5kpIR38NqQyH78oXjzgkUr65xgk0CSKxWdbPGZaZoTzOhwBDv+HkgcMuc
         uYtpy/UgoQeo12QuRjzG8YYLsr1yXsERXdhRl1XmvM6Y3j9hZC5ttzcooJ5HeOqkjCNb
         dlypDOxeNhdTn7mbnrxAzmSrDxmZ7nB9S7nnKsR8HyPKwsYv/ymnQXRdW8P119eBm1sG
         o1I2b/HZs3I8fA85naQ5X7GZtDr2LZ9bcHK0VUJwWWapa9ZzKFZMr2TjUF+DNfEqd/Gs
         O3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710587274; x=1711192074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azsNtSIGobhoP54I2iCnLJg74NKdgh6eoP1MAVpKh38=;
        b=RqOWjP3BEoJuFnKz27B2dqPEtmvFoweGKJ3C8eg2DxA5+7bri2AiYH9B+JDT310skM
         x7Z8CfLYxF4/xAKJPBcPUFeXSVHiA7A/E54h46HkD3I9hStu9H1qE8DYMtBM5UcoURAX
         +W0oG5I+wDajE26A5wH413Ee+FfO58b/hTUuYSdRUp/e7dgE35WjchMqv/85bRJ/NqaP
         RHD+oJCovDLxHiWSO4o1qhCfs0QTs/Rq7U7gALXPs9rrNldX27+RVU43gZHSFo2UdOIL
         qh2y+f0IxB8V0RtvOFz1YKRio9lKbRAz7dgpQQZdAHfEtFFs/Ak1K3C6sWedbKeA6cDH
         5vIg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ2PRpWtsZ8n6BqaN68DhYl9DcFYbbDfW6PcDmOyKDG7yAadGJ6S6nW1ZuB7/nORuOGpmXGZmkHTqUfZdc7lZImUr9sKM3jse3gPZs45LiXsmdCFhbqHBBelsjzJiw1atqbxZ1qpme
X-Gm-Message-State: AOJu0Ywngy7caX6jJQwYli3fbyLksbkRzbLN24R9goGxbJE+yy55yqTv
	kaVQUvXeau/BJf/RQJRxfgf4KH55KUMhY9PtChxrzS6SwpEUj4AW
X-Google-Smtp-Source: AGHT+IHOefYDd6wyfQ6VMRVzTy+ziigdZMF0NQ2nehUm4427PLztRZbFnUaD5OKbKRQoS8TYHRHRcg==
X-Received: by 2002:a17:906:2e8b:b0:a45:9db3:472b with SMTP id o11-20020a1709062e8b00b00a459db3472bmr5085023eji.52.1710587273711;
        Sat, 16 Mar 2024 04:07:53 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:c0f3:8008:e41a:ce01])
        by smtp.gmail.com with ESMTPSA id bx21-20020a170906a1d500b00a4655976025sm2627223ejb.82.2024.03.16.04.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 04:07:53 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	andriy.shevchenko@linux.intel.com,
	ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org,
	phil@raspberrypi.com,
	579lpy@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v2 1/2] iio: pressure: Fixes BME280 SPI driver data
Date: Sat, 16 Mar 2024 12:07:42 +0100
Message-Id: <20240316110743.1998400-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240316110743.1998400-1-vassilisamir@gmail.com>
References: <20240316110743.1998400-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use bme280_chip_info structure instead of bmp280_chip_info
in SPI support for the BME280 sensor.

Fixes: 0b0b772637cd ("iio: pressure: bmp280: Use chip_info pointers for each chip as driver data")
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index a444d4b2978b..038d36aad3eb 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -127,7 +127,7 @@ static const struct of_device_id bmp280_of_spi_match[] = {
 	{ .compatible = "bosch,bmp180", .data = &bmp180_chip_info },
 	{ .compatible = "bosch,bmp181", .data = &bmp180_chip_info },
 	{ .compatible = "bosch,bmp280", .data = &bmp280_chip_info },
-	{ .compatible = "bosch,bme280", .data = &bmp280_chip_info },
+	{ .compatible = "bosch,bme280", .data = &bme280_chip_info },
 	{ .compatible = "bosch,bmp380", .data = &bmp380_chip_info },
 	{ .compatible = "bosch,bmp580", .data = &bmp580_chip_info },
 	{ },
@@ -139,7 +139,7 @@ static const struct spi_device_id bmp280_spi_id[] = {
 	{ "bmp180", (kernel_ulong_t)&bmp180_chip_info },
 	{ "bmp181", (kernel_ulong_t)&bmp180_chip_info },
 	{ "bmp280", (kernel_ulong_t)&bmp280_chip_info },
-	{ "bme280", (kernel_ulong_t)&bmp280_chip_info },
+	{ "bme280", (kernel_ulong_t)&bme280_chip_info },
 	{ "bmp380", (kernel_ulong_t)&bmp380_chip_info },
 	{ "bmp580", (kernel_ulong_t)&bmp580_chip_info },
 	{ }
-- 
2.25.1


