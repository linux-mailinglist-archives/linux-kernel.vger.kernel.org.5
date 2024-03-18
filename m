Return-Path: <linux-kernel+bounces-106730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 749FC87F2B7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ACD51F23DB1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E7F59B76;
	Mon, 18 Mar 2024 21:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ee4yq5qQ"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD2359B55
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 21:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710799035; cv=none; b=cgFys2TTxpcDF8S3fVle/642RcV3z95frViKjpJsQGebGs4WYWTwGsB4nbVtHvEHQqysDcrkegnfsOWAKGX0AJOy5EvAukTbCSWlMd3PcTbdjaFDpM89Y2lcGzc68GlCcr2NLoPy9FkEouWwiabxmhCsf0h52uCRsQoRTokGEE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710799035; c=relaxed/simple;
	bh=anFFZoauRsviU0zJMTL3qNPctdJFJFTYXleWO3p7Www=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zs5pm7+OMDX8RxPXob7v3GNAOianWYhq4bOrThCVLTsPxRti4HGt5duvPEul67oRVAQRcvKbSl1si1P4R06/ReA+6KdL3HB7yNaij4EjfWy8dtm/kv+YAuQJIV0/o1SO8pNVDEi7dGcrrbRr4fzDQ4r/EwveVwtkOz/wFGXys/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ee4yq5qQ; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e696ee8fa3so529112a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 14:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710799030; x=1711403830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2doriDKu/cfl9j3fNMXN6mulEhmUxk604Qd02LC5Zsg=;
        b=ee4yq5qQPEypw7A/pHYgE/R71RYpv5kD9i75fTvyD45fHuw6CQVAXWz7E4NXA1LvXd
         rBlr3jTQrWrCPDzNrjfyrG2BPN//2fO05Oii6CyNagIDT/XodniDZIjx5VVOQpK/JlFP
         9of2zNoXiBow/0s508zxoCRC/n/Ns1BDPIw8Px27/yTgPs95gHgWwX4YBkqT7lqZEH8A
         XQlYLc716dQJJF5HQFkAeNC1FeSArKLkolFS6tKsq+ymkAamcIdC0F1UfOwwSZNekEwc
         9eTVVS61VFmbyKRXcJv9vFfFCJH5/tfr/Z662moAH6pVl2os8uOdvMpmu22NCN2tescP
         CxLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710799030; x=1711403830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2doriDKu/cfl9j3fNMXN6mulEhmUxk604Qd02LC5Zsg=;
        b=bRcaGocIGVkviFZoo82L6BDVw71GXqXOQygTzTL0RG8jdlxPjXXQIuTBTjAcqTDqo8
         ABe7+qtfdFdf3ad2fsCBIgjlCFeKLXvPFBUzAlIs7LlDUBNwr00cjjMC46mMsep2j9uM
         Q6KF3LO7t7aJgzLU+OcjSNizvZi6fzq/yI3ZxfR68uK+YDR4JYMEwyYMHGS9A3Yls4cp
         ANeZiHLARIGSlo9DyoeRBil9neAtPA9J28+u3k8YoID0I7HSFqcUkgwl1xOmpIaEfqsD
         66AjWgoVBCXSYCQHdNPg0+sTcYpR9PYBK1iSbSuTLkVvgtnHdx8a4jtR+98eFRdPuW3J
         kPKg==
X-Forwarded-Encrypted: i=1; AJvYcCWFqoMYAMD4I3PbclZfe4KsNFqw+CQ6L1PXcEZagYEnJ24QevbbJgHBx8GmNOKZ5EaFbHKX82wjHEPY3D0I9jpTjTAcTmwlY2DNbdAn
X-Gm-Message-State: AOJu0YzXywCLr82f0EjL6GS2CFwVCyZXdf7pVAYbOfkAo74b/i+zuVHy
	hvIIy4vX3mLnGiTYh8XmyWKMIJInfvEElTznyk6BcaUEwycsMMmCabSTjhX86l4=
X-Google-Smtp-Source: AGHT+IGyQ8THdMBczyiUfBbRKYyo/nmZ5oAXR5fdw4tulK7Kd3aZxl4B9XI3zMnc84H3S+hGFcbbwg==
X-Received: by 2002:a9d:6b97:0:b0:6e6:8e33:7816 with SMTP id b23-20020a9d6b97000000b006e68e337816mr246109otq.12.1710799030001;
        Mon, 18 Mar 2024 14:57:10 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id dh6-20020a056830484600b006e67280b68bsm1729143otb.44.2024.03.18.14.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 14:57:09 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH] iio: adc: ad7944: simplify adi,spi-mode property parsing
Date: Mon, 18 Mar 2024 16:56:19 -0500
Message-ID: <20240318-ad7944-cleanups-v1-1-0cbb0349a14f@baylibre.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This simplifies the adi,spi-mode property parsing by using
device_property_match_property_string() instead of two separate
functions. Also, the error return value is now more informative
in cases where there was problem parsing the property.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7944.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
index d5ec6b5a41c7..356aea02920f 100644
--- a/drivers/iio/adc/ad7944.c
+++ b/drivers/iio/adc/ad7944.c
@@ -366,7 +366,6 @@ static int ad7944_probe(struct spi_device *spi)
 	struct ad7944_adc *adc;
 	bool have_refin = false;
 	struct regulator *ref;
-	const char *str_val;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
@@ -382,16 +381,18 @@ static int ad7944_probe(struct spi_device *spi)
 
 	adc->timing_spec = chip_info->timing_spec;
 
-	if (device_property_read_string(dev, "adi,spi-mode", &str_val) == 0) {
-		ret = sysfs_match_string(ad7944_spi_modes, str_val);
-		if (ret < 0)
-			return dev_err_probe(dev, -EINVAL,
-					     "unsupported adi,spi-mode\n");
-
-		adc->spi_mode = ret;
-	} else {
+	ret = device_property_match_property_string(dev, "adi,spi-mode",
+						    ad7944_spi_modes,
+						    ARRAY_SIZE(ad7944_spi_modes));
+	if (ret < 0) {
 		/* absence of adi,spi-mode property means default mode */
-		adc->spi_mode = AD7944_SPI_MODE_DEFAULT;
+		if (ret == -EINVAL)
+			adc->spi_mode = AD7944_SPI_MODE_DEFAULT;
+		else
+			return dev_err_probe(dev, ret,
+					     "getting adi,spi-mode property failed\n");
+	} else {
+		adc->spi_mode = ret;
 	}
 
 	if (adc->spi_mode == AD7944_SPI_MODE_CHAIN)

---
base-commit: 1446d8ef48196409f811c25071b2cc510a49fc60
change-id: 20240318-ad7944-cleanups-9f95a7c598b6

