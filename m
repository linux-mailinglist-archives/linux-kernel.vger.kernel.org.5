Return-Path: <linux-kernel+bounces-70848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5748F859D32
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECC181F22C32
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED34E20DC1;
	Mon, 19 Feb 2024 07:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Msv/k5sx"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A8220DF4;
	Mon, 19 Feb 2024 07:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708328652; cv=none; b=Bqb1Getw8UDn7/2d/R0lQI2ZjfYHq48/400Sx2F7WmWpxB5ydupc0mROAhkGab/9DWyUucb9NbEoMfmbWJqo8P6m9f/OWSY4bbvC4umSDVDHKUP9JOZl0WiCYmQbpTDJFlzBNFSPgAUn/Xnh2/m9lS9t/1neTFNtbf5oMSuo5ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708328652; c=relaxed/simple;
	bh=0cPDHhNi8bYSx15AbJNOmGn2pNvsKEpiuV1I2zmlnwY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XgzCrxKiZT4diEO5+6WPMeU7d1ln2i+GJc33qlwjHla9m8Z5PmpyXa083C1pD0xazIpR6hBronpcn3/k55u+F6/KxPMaqMk6Nuv7gVQtn1+TTwIn7ZLj/QuSWZc58Vs9xtbAhBA9zRURA8lAm2LHpxL3APacj+QADQsopeSgeS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Msv/k5sx; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-512a96e44e2so1582155e87.2;
        Sun, 18 Feb 2024 23:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708328649; x=1708933449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NWRB34m7daMDprm8NGoyhlWPNl7PmR3a1A52zijhYzY=;
        b=Msv/k5sxoRnCL4mkL5twCE9KD6+WOikyOO/4VftT+8mppfg/Z4YFljtmxP8WSmZ8L6
         5nbk7yhwDG8A22BW2odqJ9lHZg7UKHD96IGGkZdn0MU575ITAqvD+1dw9ziXJBpOc2pv
         ymKOKo2fPwgr28M8gc2TCMkx0i4s5bKjr8jUjYIUXHaQ7d8SXkkZ47TeLBnkz19c344E
         BDnGzN97I9UBO3JU+8p0zWhRPTwkQ7+gc3nvE4iD9JKtZOqqmSeVkXYGTn8uq129vJ/J
         vQELhTSZ4hHV/GWMxyp6oIsGfIeVrrad+vFF+fIaSi91rrbUiDAwjIqO7qRNG6p9rML4
         i1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708328649; x=1708933449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NWRB34m7daMDprm8NGoyhlWPNl7PmR3a1A52zijhYzY=;
        b=WhQpE/dkBxEW1JqdNdLRhXQjmPYUVztllxRDX6tHksrLSkOsey2hpSYLxVIV9RDJ34
         UM7jQqb/39blLTB32yshfSbnE4ZIL+5oP5eIXVVNIZE5rq7YsqSwRpcKpLLBr2wy+72C
         DmInpCB+muj2PWCnSYBGaK/IZmPq84mJRVEpYT4dOoK4jIGMtjGtxmnGI0xIXTle6UJg
         N0SeazCUo1IqcGIsebbC5A+k3Rp66ezb86IaDn9P9IFyeeWcbcXg6QB8+GWZpMWoEv7Q
         AZXZSJIte0TGGlIyaNfOwvqQoP4FFlCyOk0Io8RopxXgOeE6lbuc4crxlN665gtlTh7H
         AROA==
X-Forwarded-Encrypted: i=1; AJvYcCUu+hXNgDruy3ioRr696cw+klhh7JcaddjJoKvxxDLv6QoEsiPP864bpiOWIzoq7CZqnzX60oHhn3+Ns85grfWUdodKWT+DtAnG8RMs
X-Gm-Message-State: AOJu0YzFnUXy5NtzyIJYUKIANqLuo+PykFxwguvWKbpnZH2qsl0rW3GD
	WqilghbkQesBIByqXyrSEupA2XP7/DlF4l5DytjvvczlR9uuptJh
X-Google-Smtp-Source: AGHT+IHwTzvIMcCzSWgF2FY2fsE7PoYQdgs4QcL5zFtGQflR01k671ZTTneY7Qd+J6RV5oa7EVxc0A==
X-Received: by 2002:a05:6512:12c7:b0:512:bc14:6b80 with SMTP id p7-20020a05651212c700b00512bc146b80mr395625lfg.25.1708328648730;
        Sun, 18 Feb 2024 23:44:08 -0800 (PST)
Received: from localhost.localdomain ([86.38.153.174])
        by smtp.gmail.com with ESMTPSA id qw23-20020a170906fcb700b00a3e426149a1sm1886019ejb.50.2024.02.18.23.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 23:44:08 -0800 (PST)
From: Arturas Moskvinas <arturas.moskvinas@gmail.com>
To: jic23@kernel.org,
	Jonathan.Cameron@huawei.com,
	oskar.andero@gmail.com,
	lars@metafoo.de,
	lukas@wunner.de
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arturas Moskvinas <arturas.moskvinas@gmail.com>
Subject: [PATCH v2] iio: adc: mcp320x: Simplify device removal logic
Date: Mon, 19 Feb 2024 09:41:40 +0200
Message-ID: <20240219074139.193464-2-arturas.moskvinas@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_* APIs to enable/disable regulator and to register in IIO infrastructure.

Signed-off-by: Arturas Moskvinas <arturas.moskvinas@gmail.com>

---
v1 -> v2:
- Use devm_add_action_or_reset instead of devm_regulator_get_enable to automate disabling regulator
- Remove empty mcp320x_remove function
---
 drivers/iio/adc/mcp320x.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
index f3b81798b3c9..da1421bd7b62 100644
--- a/drivers/iio/adc/mcp320x.c
+++ b/drivers/iio/adc/mcp320x.c
@@ -371,6 +371,11 @@ static const struct mcp320x_chip_info mcp320x_chip_infos[] = {
 	},
 };
 
+static void mcp320x_regulator_disable(void *reg)
+{
+	regulator_disable(reg);
+}
+
 static int mcp320x_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
@@ -388,7 +393,6 @@ static int mcp320x_probe(struct spi_device *spi)
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &mcp320x_info;
-	spi_set_drvdata(spi, indio_dev);
 
 	device_index = spi_get_device_id(spi)->driver_data;
 	chip_info = &mcp320x_chip_infos[device_index];
@@ -445,27 +449,13 @@ static int mcp320x_probe(struct spi_device *spi)
 	if (ret < 0)
 		return ret;
 
-	mutex_init(&adc->lock);
-
-	ret = iio_device_register(indio_dev);
+	ret = devm_add_action_or_reset(&spi->dev, mcp320x_regulator_disable, adc->reg);
 	if (ret < 0)
-		goto reg_disable;
-
-	return 0;
-
-reg_disable:
-	regulator_disable(adc->reg);
-
-	return ret;
-}
+		return ret;
 
-static void mcp320x_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct mcp320x *adc = iio_priv(indio_dev);
+	mutex_init(&adc->lock);
 
-	iio_device_unregister(indio_dev);
-	regulator_disable(adc->reg);
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct of_device_id mcp320x_dt_ids[] = {
@@ -520,7 +510,6 @@ static struct spi_driver mcp320x_driver = {
 		.of_match_table = mcp320x_dt_ids,
 	},
 	.probe = mcp320x_probe,
-	.remove = mcp320x_remove,
 	.id_table = mcp320x_id,
 };
 module_spi_driver(mcp320x_driver);

base-commit: 8d3dea210042f54b952b481838c1e7dfc4ec751d
-- 
2.43.2


