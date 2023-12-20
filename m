Return-Path: <linux-kernel+bounces-7379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C48881A700
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 19:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30EC21F2443E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 18:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A5F1E516;
	Wed, 20 Dec 2023 18:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t5MlsovE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F0AC13D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 18:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1fb37f25399so3358208fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 10:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703098075; x=1703702875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XSQemk7U39WKyikso39pwz5Iu5SNEeiFiZyYBT6nCdE=;
        b=t5MlsovE6pCE0EgNfHUcT80Dv057h/EyaiN9wsPdWjI4zE47b5dtUDKx6fxraSRRjD
         d2WlZE0AqjblYrum1drtuxGZKGAWtDRHBLlmfWvQFpHosPyXiApDE8/mNwYpRvcxknba
         gYYTOQg9evXd8Uhe5IY73lO3iu5XBesfS5+3f6B8F+a50O42Q+Ge386XSR4NssPLyg8m
         /QLU61756WWq0sx//hWWPDZCzmTIuXRhIiaLTx+WY0VPu6oIVtT4JekQ3ieyyirfVwtZ
         sSRWgDyZxrT0dgD1O3uxsPoWD1uiHhIjwBiywz+PFrIeO1RDlyCJ6OmSeaZ6M6oygMkK
         nwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703098075; x=1703702875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XSQemk7U39WKyikso39pwz5Iu5SNEeiFiZyYBT6nCdE=;
        b=WcSx4D7aNG0lF657iFOsbJBDsQkI92OtQRZ5Fv2inGrRxav91a+VzL7U5JJvJlw8z3
         cMm2ZALURlLcT2KKSH8p0kRwFvWYgpzBuDmokeW0NKlfUI/mxJnyLGEZS167vG5yzn0o
         EQcFUXjaI2LwtSdsmQYGXEXGWfj8QALSIEdKSjOXq73mjnGvrtRX6qNIldvvIRQUeByq
         8gbSmldCTFFzLZo/g9g1YP5gXhXDYdBkWvI73TnYQxGga8AljPInEY7t93iQbNBF6cbA
         qSgNt8DgN2z/ryvd5ONuNw8auwV/aInIxbmEtTQcMFSnUePPZii/MGzK9owN6k3ddgbW
         kPvQ==
X-Gm-Message-State: AOJu0Yx2tvD0xjiv1s/bN4lbrkuvlULpD8mplIJqD/ir0GSZRa7eEBiZ
	EiBL6nMcQ56fuO+d4D/rvx1DcA==
X-Google-Smtp-Source: AGHT+IHPm/zsYbScP6wb4pX4aDJlY+n0Tw+L95MSFor94i3idDFNPi0tjtvdGqppyCl8xNlG9/GYGQ==
X-Received: by 2002:a05:6870:c088:b0:203:b01c:e99 with SMTP id c8-20020a056870c08800b00203b01c0e99mr195364oad.97.1703098074970;
        Wed, 20 Dec 2023 10:47:54 -0800 (PST)
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id oo15-20020a0568715a8f00b00204059b76a0sm53721oac.53.2023.12.20.10.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 10:47:54 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Angel Iglesias <ang.iglesiasg@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: pressure: bmp280: Add missing bmp085 to SPI id table
Date: Wed, 20 Dec 2023 12:47:53 -0600
Message-Id: <20231220184753.6472-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"bmp085" is missing in bmp280_spi_id[] table, which leads to the next
warning in dmesg:

    SPI driver bmp280 has no spi_device_id for bosch,bmp085

Add "bmp085" to bmp280_spi_id[] by mimicking its existing description in
bmp280_of_spi_match[] table to fix the above warning.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Fixes: b26b4e91700f ("iio: pressure: bmp280: add SPI interface driver")
---
 drivers/iio/pressure/bmp280-spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index 433d6fac83c4..e8a5fed07e88 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -87,6 +87,7 @@ static const struct of_device_id bmp280_of_spi_match[] = {
 MODULE_DEVICE_TABLE(of, bmp280_of_spi_match);
 
 static const struct spi_device_id bmp280_spi_id[] = {
+	{ "bmp085", (kernel_ulong_t)&bmp180_chip_info },
 	{ "bmp180", (kernel_ulong_t)&bmp180_chip_info },
 	{ "bmp181", (kernel_ulong_t)&bmp180_chip_info },
 	{ "bmp280", (kernel_ulong_t)&bmp280_chip_info },
-- 
2.39.2


