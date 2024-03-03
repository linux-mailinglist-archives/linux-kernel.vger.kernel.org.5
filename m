Return-Path: <linux-kernel+bounces-89831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B8A86F639
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 17:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADEEF1F231D3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AFD6F06B;
	Sun,  3 Mar 2024 16:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvFvC23s"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060FC6E5EC;
	Sun,  3 Mar 2024 16:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709484790; cv=none; b=YL1jkRdIYzrGht0wyr2RcpCqVowJMsKe09joV1FTWatIIY6kOI8zqXzubDtu4IYyjwAu2cL0c1mMvzLjeYW5j6ORsCFTbcN7yxWKYlI8XonL65o5uhy/6fa2gg9s3g2EPnhT5WK3zomNyYdFLjjfdF/9nbqEUqCfjOW3wLBSIKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709484790; c=relaxed/simple;
	bh=jVXy9lioZ8kjlYkytLDO0ybrYl1qAi+3ZwTGHGj4x7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RSPV4XPYXZ9nsqevDV0j6Q2Es1/Hj8pUx62L3Xr/nJaSqLVA77WIMQu9EAY2iD9VF6RwDAatk3gW/GdiIedfmR5TCbEn5E44pZeWI6xrHwAe7lthLNCTKHYxw5c4B5MxOWzOYZfTtR1K42whLjd8AYrx5FCg+Ior8aFh2F/V0/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvFvC23s; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a36126ee41eso576598566b.2;
        Sun, 03 Mar 2024 08:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709484787; x=1710089587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRG8TNmENP/pTcySnhHli+1ouRQdj2vqC4wgPeKT1sQ=;
        b=fvFvC23sSjn9beHvqIg3pcnROzEFwA/9/fi/qX3ThqPacBk9jEZa4kxA9EzOzPOZ9g
         yYHH65jgYGGfB1Zem9B46tQNQCUXe/7WKgBGc7AE5zX40nRPEY0M3d4hzKOc+KPcKVMB
         DHSkOI8w+qz8Fk/i1E0hSSkAtJobQyzAriq70x/1yux7fb/VFcwv4CIuC1p6BTk4sAL0
         Hsax//rjuHwo2t5NvMjA+ieXL3RNtfkwdCgFfc243hm29oeK7fg65RqnnSZoWLtuj/VH
         Pd6oVkZl/iPURnpdscxWieMCcPkN7lni2HgQT9/Rv7nzF23wMIvQeBlwTftzIM6OTSpi
         fa2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709484787; x=1710089587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRG8TNmENP/pTcySnhHli+1ouRQdj2vqC4wgPeKT1sQ=;
        b=nxV2e1UeAELg6iKsPSite2jQWRbo3uWtK2Y4ODdGYTVn2C+hKZgMnx2sN2KR1yS9y+
         OYV7OaCM8bDeuYjSmtkkLfSxM5iLD5xPtPfba3m8unuLrAn8kunMSEhN9CWCcaYGNt5I
         apQmQ6mbnWBb0t9ZSbKDZ43/OVFFtvwzJ0sVuggba62jBw2lOSsZl/tdRcfrWyCZNcra
         xgIwj6cjX+CAbwhuC53CEu0LvkuQfPmbxhvdqnkdFOuvHU9UUoewKFOd70YXon0Z/tCh
         +NWbgexly2/ioeDPhE9DZ+VkKPJY23jwMY1v9vFurZnRK3xYHPLWrR149KOa3Pv0ZbHp
         5uXA==
X-Forwarded-Encrypted: i=1; AJvYcCXlcLlxcVJ0pGb3GbQLORjGsV8w/cQS6XqQ8CRIfbQVgeNBWdAJAEDnZGkIj7SuFkbhSki/S7Pbgp0vv2xNTc29vB8Fr+slYUNPKwQRxCSbH2FENMii38v5QZgWnJy8Wh2rs4hxmpwN
X-Gm-Message-State: AOJu0Yx71okllLln16AVqL78+Nufxp6RC8eE8fRH8nltY1DDIsmIeLpH
	0G59PLoK1ZKhJUqtIslo/3U3WfsbJpQLlYNATLjiXVnbPxTbQaYvfGrOWUsotSUVcurC
X-Google-Smtp-Source: AGHT+IFwkivHORp9/DELAvjWF9pUwUuYgSYHm6ZvEsidzS7M0b2A0y1EUXDO7uhNbQoD9YA5M6sVrQ==
X-Received: by 2002:a17:906:2411:b0:a44:e92:ebcb with SMTP id z17-20020a170906241100b00a440e92ebcbmr5005844eja.21.1709484787156;
        Sun, 03 Mar 2024 08:53:07 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:82:7577:d4e3:724b:4d69:34b2])
        by smtp.gmail.com with ESMTPSA id lh15-20020a170906f8cf00b00a44f14c8d64sm1413992ejb.135.2024.03.03.08.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 08:53:06 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	andriy.shevchenko@linux.intel.com,
	ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com,
	ak@it-klinger.de,
	petre.rodan@subdimension.ro,
	phil@raspberrypi.com,
	579lpy@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH 2/4] iio: pressure: Add scale value for channels
Date: Sun,  3 Mar 2024 17:52:58 +0100
Message-Id: <20240303165300.468011-3-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240303165300.468011-1-vassilisamir@gmail.com>
References: <20240303165300.468011-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add extra IIO_CHAN_INFO_SCALE in order to be able to have the scales
for the values in userspace. Can be used for triggered buffers.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 70 ++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 29a8b7195076..acdf6138d317 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -138,16 +138,19 @@ static const struct iio_chan_spec bmp280_channels[] = {
 	{
 		.type = IIO_PRESSURE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 	},
 	{
 		.type = IIO_TEMP,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 	},
 	{
 		.type = IIO_HUMIDITYRELATIVE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 	},
 };
@@ -156,6 +159,7 @@ static const struct iio_chan_spec bmp380_channels[] = {
 	{
 		.type = IIO_PRESSURE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
@@ -163,6 +167,7 @@ static const struct iio_chan_spec bmp380_channels[] = {
 	{
 		.type = IIO_TEMP,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
@@ -170,6 +175,7 @@ static const struct iio_chan_spec bmp380_channels[] = {
 	{
 		.type = IIO_HUMIDITYRELATIVE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
@@ -487,6 +493,70 @@ static int bmp280_read_raw(struct iio_dev *indio_dev,
 			break;
 		}
 		break;
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_HUMIDITYRELATIVE:
+			if (!strcmp(indio_dev->name, "bme280")) {
+				*val = 1000;
+				*val2 = 1024;
+				ret = IIO_VAL_FRACTIONAL;
+			} else {
+				ret = -EINVAL;
+			}
+			break;
+		case IIO_PRESSURE:
+			if ((!strcmp(indio_dev->name, "bmp085")) ||
+			    (!strcmp(indio_dev->name, "bmp180")) ||
+			    (!strcmp(indio_dev->name, "bmp181"))) {
+				*val = 1;
+				*val2 = 1000;
+				ret = IIO_VAL_FRACTIONAL;
+			} else if ((!strcmp(indio_dev->name, "bmp280")) ||
+				   (!strcmp(indio_dev->name, "bme280"))) {
+				*val = 1;
+				*val2 = 256000;
+				ret = IIO_VAL_FRACTIONAL;
+			} else if (!strcmp(indio_dev->name, "bmp380")) {
+				*val = 1;
+				*val2 = 100000;
+				ret = IIO_VAL_FRACTIONAL;
+			} else if (!strcmp(indio_dev->name, "bmp580")) {
+				*val = 1;
+				*val2 = 64000;
+				ret = IIO_VAL_FRACTIONAL;
+			} else {
+				ret = -EINVAL;
+			}
+			break;
+		case IIO_TEMP:
+			if ((!strcmp(indio_dev->name, "bmp085")) ||
+			    (!strcmp(indio_dev->name, "bmp180")) ||
+			    (!strcmp(indio_dev->name, "bmp181"))) {
+				*val = 100;
+				*val2 = 1;
+				ret = IIO_VAL_FRACTIONAL;
+			} else if ((!strcmp(indio_dev->name, "bmp280")) ||
+				   (!strcmp(indio_dev->name, "bme280"))) {
+				*val = 10;
+				*val2 = 1;
+				ret = IIO_VAL_FRACTIONAL;
+			} else if (!strcmp(indio_dev->name, "bmp380")) {
+				*val = 10;
+				*val2 = 1;
+				ret = IIO_VAL_FRACTIONAL;
+			} else if (!strcmp(indio_dev->name, "bmp580")) {
+				*val = 1000;
+				*val2 = 16;
+				ret = IIO_VAL_FRACTIONAL_LOG2;
+			} else {
+				ret = -EINVAL;
+			}
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
+		break;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		switch (chan->type) {
 		case IIO_HUMIDITYRELATIVE:
-- 
2.25.1


