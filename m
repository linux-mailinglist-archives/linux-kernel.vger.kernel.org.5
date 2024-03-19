Return-Path: <linux-kernel+bounces-106858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A04587F491
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 01:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0244A1F21A9E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6806BF513;
	Tue, 19 Mar 2024 00:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnzDgy6G"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B937433FE;
	Tue, 19 Mar 2024 00:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710808181; cv=none; b=TRw0Nrw0qfAIB55tkLLIPGhk7pFlvjtEyfQwl7GOGSNp06RkQncVuqDQK2/KXRkiJ6BjXKHH0dh8oXoPYWXqSu8mrxVWTjaM9J8dysBBImh7NrQHf1xAxw4uR2FG0cth13eKx8Ovmqpw+dI6ftWK0tNrXcUY/ebpHk4CwZFzi/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710808181; c=relaxed/simple;
	bh=bckAFWelMQTYHoBmPhmyx86sCP8tz+XGH+4phCRTEO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=unJlEfQvZ+t6/eryU+jLLrTGdsfUGAaINh22ThGqEHruVbAp9qCA0Zy4fcmY7pGR5ZC9Me8Ry/uFSupWmKeOwd0R6Egc5YrC7OHcB5roLpaJJd6Atz2Uyqf2gfrGkgXeXH9f8ECHboDGx3tDPy4L/Kq/AKMNddtO89GR0nBDZ4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnzDgy6G; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5688eaf1165so7225369a12.1;
        Mon, 18 Mar 2024 17:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710808178; x=1711412978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+sF/Ulgh9y8JBAdDd8JKsJdaWhYesUGo5m0d2yPND/g=;
        b=TnzDgy6G8rkkQy4FAzdXqMQgKBooBS2d7ESsp80Z5z8h6CNspj0ZymgjkBQZstYEp0
         hAHJ7X17HbN1sXTZc+IluLlksMvhZ7E/h8bJe+HErsLnEgBxaNe7UKY7SMDey7mt4tsa
         2u9SKF9i1kSEHvlsdjO3MAMworcflfOXDS7N8ujri64TD50qQN/T6mKYPf6uqQb/v3u6
         wExfDuOSdO6BOLyL6Zl+DBb5yqjaGowqKwATV5WidMZn4HbigY4kJFs2sinLCkN+UvsW
         ovMIpsPumQG4qi6/Z2keoS4O4b+lQy80RRVm1bl/NC5PrS1779jJLk4s/ACxZSiPqkno
         qckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710808178; x=1711412978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+sF/Ulgh9y8JBAdDd8JKsJdaWhYesUGo5m0d2yPND/g=;
        b=mMdG+U6lFT5N9K1VHkCK2i7d/U/bAoiO15hwTDylXHXnwfNWs2tR6F4nP89FlyjvwF
         0x4EYAcfph7RJGSq633nsJG+FFxJLSlNmecGWC8AGE2uQv2FlvOuX76PFx5RZ3sNBNuc
         U94uu0KICI0ehc4JtREPRBZ+bWTvT7JvuRDGfkqp5ORJVi7dBTT3yH/suq0y7CtOCWTh
         ywq6NaikQX8pRDrif4ioS2lhlrfC/3eY+/jTbcRZWqdtnCatjCRnyXEpsoqjvNzT7IT2
         gFS5n3gXOHAVlZR2vHjW9NGOubaa9He5gJ/1EUQKvdIbj3nLp4H2u/vNE8x3/SHjb8vh
         R90A==
X-Forwarded-Encrypted: i=1; AJvYcCWdgfsGHLEWPTgPOFw6cBttBgDVnE4RdLGRZZ6I7eWpAvKZeGt1PSLfsTtDFHR2HzKFHxzPMKKA+J7MaHywoYtImjVXp2KKVtjWGlwRz8ZaB2m6M126P9JASpSudpSHxBQ8sTynbdzD
X-Gm-Message-State: AOJu0Ywa7i/yZrs4itkVh5E7d4iGyrEx5wVgrTCanFJoD6MHcP73WnrD
	RUGjrilYeDmq3aF/nvXaBvCDoZ7StMLTHcN9dtKAkD5GH7y/omCr
X-Google-Smtp-Source: AGHT+IGwVvHI2gzfPhnPi4wLWqKeWoB92ryibjKIfkbKXF5HRd0VFSbsdg2PBXCzkaywISNVlOY2PA==
X-Received: by 2002:a05:6402:3645:b0:568:af3d:4a5f with SMTP id em5-20020a056402364500b00568af3d4a5fmr875014edb.22.1710808178170;
        Mon, 18 Mar 2024 17:29:38 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:8c96:c55f:eab0:860])
        by smtp.gmail.com with ESMTPSA id co24-20020a0564020c1800b00568c613570dsm2700227edb.79.2024.03.18.17.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 17:29:37 -0700 (PDT)
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
	linus.walleij@linaro.org,
	semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v3 4/6] iio: pressure: Add SCALE and RAW values for channels
Date: Tue, 19 Mar 2024 01:29:23 +0100
Message-Id: <20240319002925.2121016-5-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240319002925.2121016-1-vassilisamir@gmail.com>
References: <20240319002925.2121016-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add extra IIO_CHAN_INFO_SCALE and IIO_CHAN_INFO_RAW in order to be
able to calculate the processed value with standard userspace IIO
tools. Can be used for triggered buffers as well.

Even though it is not a good design choice to have SCALE, RAW and
PROCESSED together, the PROCESSED channel is kept for ABI compatibility.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 63 ++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 6d6173c4b744..312bc2617583 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -137,17 +137,26 @@ enum {
 static const struct iio_chan_spec bmp280_channels[] = {
 	{
 		.type = IIO_PRESSURE,
+		/* PROCESSED maintained for ABI backwards compatibility */
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 	},
 	{
 		.type = IIO_TEMP,
+		/* PROCESSED maintained for ABI backwards compatibility */
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 	},
 	{
 		.type = IIO_HUMIDITYRELATIVE,
+		/* PROCESSED maintained for ABI backwards compatibility */
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 	},
 };
@@ -155,21 +164,30 @@ static const struct iio_chan_spec bmp280_channels[] = {
 static const struct iio_chan_spec bmp380_channels[] = {
 	{
 		.type = IIO_PRESSURE,
+		/* PROCESSED maintained for ABI backwards compatibility */
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
 	},
 	{
 		.type = IIO_TEMP,
+		/* PROCESSED maintained for ABI backwards compatibility */
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
 	},
 	{
 		.type = IIO_HUMIDITYRELATIVE,
+		/* PROCESSED maintained for ABI backwards compatibility */
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
@@ -487,6 +505,51 @@ static int bmp280_read_raw_guarded(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 		return 0;
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->type) {
+		case IIO_HUMIDITYRELATIVE:
+			ret = data->chip_info->read_humid(data, &chan_value);
+			if (ret)
+				return ret;
+
+			*val = chan_value;
+			return IIO_VAL_INT;
+		case IIO_PRESSURE:
+			ret = data->chip_info->read_press(data, &chan_value);
+			if (ret)
+				return ret;
+
+			*val = chan_value;
+			return IIO_VAL_INT;
+		case IIO_TEMP:
+			ret = data->chip_info->read_press(data, &chan_value);
+			if (ret)
+				return ret;
+
+			*val = chan_value;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+		return 0;
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_HUMIDITYRELATIVE:
+			*val = data->chip_info->humid_coeffs[0];
+			*val2 = data->chip_info->humid_coeffs[1];
+			return data->chip_info->humid_coeffs_type;
+		case IIO_PRESSURE:
+			*val = data->chip_info->press_coeffs[0];
+			*val2 = data->chip_info->press_coeffs[1];
+			return data->chip_info->press_coeffs_type;
+		case IIO_TEMP:
+			*val = data->chip_info->temp_coeffs[0];
+			*val2 = data->chip_info->temp_coeffs[1];
+			return data->chip_info->temp_coeffs_type;
+		default:
+			return -EINVAL;
+		}
+		return 0;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		switch (chan->type) {
 		case IIO_HUMIDITYRELATIVE:
-- 
2.25.1


