Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BF37BFBC7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjJJMtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjJJMtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:49:43 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F55CA;
        Tue, 10 Oct 2023 05:49:41 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5344d996bedso9974804a12.3;
        Tue, 10 Oct 2023 05:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696942180; x=1697546980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8suyV6sP7GoitIkAdNCXlUthdUiktEklkTsQndWCoo4=;
        b=D9Rq9MmLhxJhe4SOtCRmYdd2P7hqMoclRZHoyiZEOXs5tdlEAW9vKAw+6LbxRzpovU
         FwBO+bp2XFs18u6y0RYnUSh0+n2jzsfIG7s2yCsw7MLvWRp/S4iHavKUmWiBqNO3yIHb
         SBZFI5ThUn65JfATyYZrb3qRHYJftHP4JMwvY+efL8Ji7NEmcL6VLnlJn4sWAeIbnQzr
         bul3pZ+H+y3BiVAm+bP04uoN1Z1PYxF3sHtIB+RL+G9YiaJcdrryIaKhOmqbl6lvouTK
         84Pw6Cp2ss0DqvMHYkWHqwg4x8t54j82iYsRzaw6fSDlye8jkolS0zXkR6qN9iY3zpkx
         nk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696942180; x=1697546980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8suyV6sP7GoitIkAdNCXlUthdUiktEklkTsQndWCoo4=;
        b=Na6JOJQUgV4aRWg+Libdr6SNInUFZlZrzsZxYoUx4foX/45Z2dXkdKnqYOn6FA4YUu
         K/JvPiFswaoC3+tg07UbBheh48lathoo/Ph/5TaUyKSd/R+sZeRGGBXxcLwWxmcIkCZk
         4nLUc8OExEra2HP7YHtnP4Jodrukg3S0GkKnlCIIA3b6YGPeybDCWmjk+KhmkXq3IrVO
         BlYhpAs2eW6HnIX4alyVtcZOQcTVlbVYP4VUX/Cd9OHtFkYQls+B0ibvp4EZPFUCYZz4
         6l70IWcsj5W4G4X2/8vxmhX7H/YHrGTRNJH9lWnUIP6S4yqnjtQ7/F2L3rVWECvBd0SX
         Xp5w==
X-Gm-Message-State: AOJu0Ywsv0Sr1S9wwJkcJjPow+51h5yGuXur03Y69uPOS608mNGKulMM
        XrUffhsx5Yt55OpGyo/bdgA=
X-Google-Smtp-Source: AGHT+IED1WNebR77WW3mI+IKpo65f5r+N3wig/iYA88V5wrS/2c23ibzXbIQI4Hw/W+lAanlJSDJxg==
X-Received: by 2002:a05:6402:c4f:b0:53b:b110:1bd4 with SMTP id cs15-20020a0564020c4f00b0053bb1101bd4mr6386093edb.6.1696942179656;
        Tue, 10 Oct 2023 05:49:39 -0700 (PDT)
Received: from spiri.. ([5.14.139.113])
        by smtp.gmail.com with ESMTPSA id f26-20020a056402005a00b00530bc7cf377sm7629476edu.12.2023.10.10.05.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 05:49:39 -0700 (PDT)
From:   alisadariana@gmail.com
Cc:     Alisa-Dariana Roman <alisa.roman@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] iio: adc: ad7192: Organize chip info
Date:   Tue, 10 Oct 2023 15:49:24 +0300
Message-Id: <20231010124927.143343-2-alisadariana@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010124927.143343-1-alisadariana@gmail.com>
References: <20231010124927.143343-1-alisadariana@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alisa-Dariana Roman <alisa.roman@analog.com>

Move all chip specific data into chip_info structure.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 drivers/iio/adc/ad7192.c | 45 ++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index e0be394ccb34..d72a190c5109 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -171,6 +171,9 @@ enum {
 struct ad7192_chip_info {
 	unsigned int			chip_id;
 	const char			*name;
+	const struct iio_chan_spec	*channels;
+	u8				num_channels;
+	const struct iio_info		*info;
 };
 
 struct ad7192_state {
@@ -964,39 +967,33 @@ static const struct ad7192_chip_info ad7192_chip_info_tbl[] = {
 	[ID_AD7190] = {
 		.chip_id = CHIPID_AD7190,
 		.name = "ad7190",
+		.channels = ad7192_channels,
+		.num_channels = ARRAY_SIZE(ad7192_channels),
+		.info = &ad7192_info,
 	},
 	[ID_AD7192] = {
 		.chip_id = CHIPID_AD7192,
 		.name = "ad7192",
+		.channels = ad7192_channels,
+		.num_channels = ARRAY_SIZE(ad7192_channels),
+		.info = &ad7192_info,
 	},
 	[ID_AD7193] = {
 		.chip_id = CHIPID_AD7193,
 		.name = "ad7193",
+		.channels = ad7193_channels,
+		.num_channels = ARRAY_SIZE(ad7193_channels),
+		.info = &ad7192_info,
 	},
 	[ID_AD7195] = {
 		.chip_id = CHIPID_AD7195,
 		.name = "ad7195",
+		.channels = ad7192_channels,
+		.num_channels = ARRAY_SIZE(ad7192_channels),
+		.info = &ad7195_info,
 	},
 };
 
-static int ad7192_channels_config(struct iio_dev *indio_dev)
-{
-	struct ad7192_state *st = iio_priv(indio_dev);
-
-	switch (st->chip_info->chip_id) {
-	case CHIPID_AD7193:
-		indio_dev->channels = ad7193_channels;
-		indio_dev->num_channels = ARRAY_SIZE(ad7193_channels);
-		break;
-	default:
-		indio_dev->channels = ad7192_channels;
-		indio_dev->num_channels = ARRAY_SIZE(ad7192_channels);
-		break;
-	}
-
-	return 0;
-}
-
 static void ad7192_reg_disable(void *reg)
 {
 	regulator_disable(reg);
@@ -1051,15 +1048,9 @@ static int ad7192_probe(struct spi_device *spi)
 		st->chip_info = (void *)spi_get_device_id(spi)->driver_data;
 	indio_dev->name = st->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-
-	ret = ad7192_channels_config(indio_dev);
-	if (ret < 0)
-		return ret;
-
-	if (st->chip_info->chip_id == CHIPID_AD7195)
-		indio_dev->info = &ad7195_info;
-	else
-		indio_dev->info = &ad7192_info;
+	indio_dev->channels = st->chip_info->channels;
+	indio_dev->num_channels = st->chip_info->num_channels;
+	indio_dev->info = st->chip_info->info;
 
 	ret = ad_sd_init(&st->sd, indio_dev, spi, &ad7192_sigma_delta_info);
 	if (ret)
-- 
2.34.1

