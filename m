Return-Path: <linux-kernel+bounces-143793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3BC8A3D86
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16A3C281E35
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 15:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A83481AB;
	Sat, 13 Apr 2024 15:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j51xE/oR"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29E547768
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 15:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713023119; cv=none; b=jJMZZ9eqxEddmJwQz2q9txlwOZ6F0t3dFoQpEGGjKq8wbyHAiMQKq2TVjcrKOEvxnG+/colkm4STyuisMRxspU97V21vIyGevasQHzvJvMnhiN4SkRGTE+kQnwc6TGElzxf9OHmo8OkhfEWz5/aoCP2+TAR+JpHWhOadh1gfulo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713023119; c=relaxed/simple;
	bh=2JEeEAKK+fM9/amx8WJRJ3XYvGn0sAnfwgksY9PdaRg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HPglj53LezeOjLUQvMvEURorIMEbNiNjoUuBcw90fvW42UApflC2ynic/28XI2nmzsWt7K5KCRlx2Y/94TUruK34FIAfKPJYfxvS25pLyy/C8wnOEy1epQgysIjq5LQ70jdjnEz7cAYANm1ZPwNFiz9G5M+uw9Zze9Xwgj8OHQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j51xE/oR; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-570005cdf62so1159286a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 08:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713023116; x=1713627916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tlcxDayxy7liV/dNtJA0sj3nxRJNURx3h61HUHMkCRg=;
        b=j51xE/oRuEn4+A/ufUVddpV+xmkedGMEXILhpMmyu3/9LncXJlXroxt3q9N+mA4Qbx
         4GpEWudDcuXF7ntFNPtGIMi4BVs4Lfgugk07CgUYyFHou02nraL3eNoeTKI647jQZicW
         KNkwJbB7mtBKh9ma7ExTqoZrtzg63aJenGesNH4EIdqB6m0wZAXbpHDOMxcoJc2dCcK1
         a3j57/UCzwYOYBsFz1BH/VbM0NDVQuhNOd7XKwZkq4G7s8mKRLPaQDxSN9JvGrI2Ve+k
         aLSFmezWLAaNI+rZV6dxGVvKNKWKxgenvn4Hcof4ubc/HKGqM+yGv+dZnSWZMGPEFspf
         U17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713023116; x=1713627916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tlcxDayxy7liV/dNtJA0sj3nxRJNURx3h61HUHMkCRg=;
        b=WuGCHMn7KobSSXAGzxjOnYxzgPHp6bwUvNG6XhjzjzhXhplOw1zSNJ8NaYN696QxLi
         wseeGwQWVM45GlcXO+udOl1uspKn5Z352lWuGWiYGNDgT9YqCZSabWAmy6DCzwpF1fPz
         BxyWuniy2895MzuLgdV+ZSoOhl/h+Ndm0MVledhgQ0/GW9YndxMFdgF6Yb7doyX0Lf4v
         nZ2R1jNYRjqQyHRYLdD1otQFNyURUWbzpbXUT927WCyX+pUgfLxAZItZfjn67zOkObhF
         CBMf0PQAWIirtzZQVzPXx8ONf9UPFm3xnJjGK598p+iBLO8kWkJquGNmKpnpFKdhzvVn
         msRg==
X-Forwarded-Encrypted: i=1; AJvYcCVHtAK0d3KoHW0Zd8kSUCW/mbUqN363b+VtuY2XtfUtLu4ATYdP8cKUhLk93/R39cLvCASOeHJJcJVl7isqTqv5UMSx+6y6VULsVSyt
X-Gm-Message-State: AOJu0Ywu6c0scO0ux1GrtWY2QUZeXut+/qg3tkwbvVNwiGqBb19H5Eh6
	7RMak55fmdGGUT59AGzcQt7QEbYWwtLHpBEfGZsTwq3OmwqomUfzo7vdStBujNc=
X-Google-Smtp-Source: AGHT+IH9nITMH1NYXvvNGCWOo5LpcfxyT/1mKLAquxmsTCBUpElTHPDzGJwDeR2jyobj1TP+8ro/HQ==
X-Received: by 2002:a17:906:3c49:b0:a52:40b5:aedf with SMTP id i9-20020a1709063c4900b00a5240b5aedfmr1989672ejg.9.1713023116031;
        Sat, 13 Apr 2024 08:45:16 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id en5-20020a17090728c500b00a51b8e8c8besm3128294ejc.86.2024.04.13.08.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 08:45:15 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3] iio: dac: ad5755: make use of of_device_id table
Date: Sat, 13 Apr 2024 17:45:11 +0200
Message-Id: <20240413154511.52576-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Store pointers to chip info (struct ad5755_chip_info) in driver match
data, instead of enum, so every value will be != 0, populate the
of_device_id table and use it in driver.  Even though it is one change,
it gives multiple benefits:
1. Allows to use spi_get_device_match_data() dropping local 'type'
   variable.
2. Makes both ID tables usable, so kernel can match via any of these
   methods.
3. Code is more obvious as both tables are properly filled.
4. Fixes W=1 warning:
   ad5755.c:866:34: error: unused variable 'ad5755_of_match' [-Werror,-Wunused-const-variable]

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v3:
1. Use pointers, according to Jonathan comments.

v2: https://lore.kernel.org/all/20240226192555.14aa178e@jic23-huawei/

An old v1:
https://lore.kernel.org/all/20230810111933.205619-1-krzysztof.kozlowski@linaro.org/
---
 drivers/iio/dac/ad5755.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
index 404865e35460..0b24cb19ac9d 100644
--- a/drivers/iio/dac/ad5755.c
+++ b/drivers/iio/dac/ad5755.c
@@ -809,7 +809,6 @@ static struct ad5755_platform_data *ad5755_parse_fw(struct device *dev)
 
 static int ad5755_probe(struct spi_device *spi)
 {
-	enum ad5755_type type = spi_get_device_id(spi)->driver_data;
 	const struct ad5755_platform_data *pdata;
 	struct iio_dev *indio_dev;
 	struct ad5755_state *st;
@@ -824,7 +823,7 @@ static int ad5755_probe(struct spi_device *spi)
 	st = iio_priv(indio_dev);
 	spi_set_drvdata(spi, indio_dev);
 
-	st->chip_info = &ad5755_chip_info_tbl[type];
+	st->chip_info = spi_get_device_match_data(spi);
 	st->spi = spi;
 	st->pwr_down = 0xf;
 
@@ -854,21 +853,21 @@ static int ad5755_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id ad5755_id[] = {
-	{ "ad5755", ID_AD5755 },
-	{ "ad5755-1", ID_AD5755 },
-	{ "ad5757", ID_AD5757 },
-	{ "ad5735", ID_AD5735 },
-	{ "ad5737", ID_AD5737 },
+	{ "ad5755", (kernel_ulong_t)&ad5755_chip_info_tbl[ID_AD5755] },
+	{ "ad5755-1", (kernel_ulong_t)&ad5755_chip_info_tbl[ID_AD5755] },
+	{ "ad5757", (kernel_ulong_t)&ad5755_chip_info_tbl[ID_AD5757] },
+	{ "ad5735", (kernel_ulong_t)&ad5755_chip_info_tbl[ID_AD5735] },
+	{ "ad5737", (kernel_ulong_t)&ad5755_chip_info_tbl[ID_AD5737] },
 	{}
 };
 MODULE_DEVICE_TABLE(spi, ad5755_id);
 
 static const struct of_device_id ad5755_of_match[] = {
-	{ .compatible = "adi,ad5755" },
-	{ .compatible = "adi,ad5755-1" },
-	{ .compatible = "adi,ad5757" },
-	{ .compatible = "adi,ad5735" },
-	{ .compatible = "adi,ad5737" },
+	{ .compatible = "adi,ad5755", &ad5755_chip_info_tbl[ID_AD5755] },
+	{ .compatible = "adi,ad5755-1", &ad5755_chip_info_tbl[ID_AD5755] },
+	{ .compatible = "adi,ad5757", &ad5755_chip_info_tbl[ID_AD5757] },
+	{ .compatible = "adi,ad5735", &ad5755_chip_info_tbl[ID_AD5735] },
+	{ .compatible = "adi,ad5737", &ad5755_chip_info_tbl[ID_AD5737] },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad5755_of_match);
@@ -876,6 +875,7 @@ MODULE_DEVICE_TABLE(of, ad5755_of_match);
 static struct spi_driver ad5755_driver = {
 	.driver = {
 		.name = "ad5755",
+		.of_match_table = ad5755_of_match,
 	},
 	.probe = ad5755_probe,
 	.id_table = ad5755_id,
-- 
2.34.1


