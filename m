Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977077ACA78
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 17:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjIXPWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 11:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIXPWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 11:22:32 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258969B;
        Sun, 24 Sep 2023 08:22:25 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40535597f01so48647395e9.3;
        Sun, 24 Sep 2023 08:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695568943; x=1696173743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8QRWcmJTIU+4WH45SS9zHPUgdcrqvZWBP9VNxcfLWXQ=;
        b=PWnS3gypkek0THl6Jwc24G60ho7UJro/eSytk4p+dH0hVkmf5YwNRuWe1IRqevnm3J
         QkrG7FQHan1X9C2RiYT5m254OZ62FGZ9uCF4TGhzRpaibqkhID8epO59bneIEyyWodZU
         Ox0MGnyVNbEy4gQo3lWtgNcnLtkuaf+pWQSNdpf2tYAGqYzVuzkZOC2LyW3hqFpF+3eh
         hYkUNo9Rt5DF1mEuY3mwU+C9DVOCZxBvbRksivCozHzdBwBye9fsHAiViwvrU8podaco
         FpFkufrEAVJj0/cck46rSl888TEG2JbnKae8bX7BdgHAnydArkfHqDCPl1GRoSYdYgdK
         kkfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695568943; x=1696173743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8QRWcmJTIU+4WH45SS9zHPUgdcrqvZWBP9VNxcfLWXQ=;
        b=QlA+ilfQ3rw73dx7g44wZvOhNNyqmKAQIx0jDhCXCSyMRLXM3pb6rxyz2P7T74b4A2
         Tf22CKPuQt9eBH6KcYX4QmOe/QAi7a40AHo/Qd6CVpUsnJEgCYUST/WRv6KFZTCXsao0
         /nI4Qp7lEKISXHvqHuZncOMVi9Hg4z4TmgWIC0kbU0KzZcqjgxTkgYeOf789K/7GHpbR
         HdvtuMUtHnuSXrVpuaDzEzAyyOlpClcqPghdiXrHE+9L6FOVrdNQDrjK/4GE4Kzj0rk3
         eH7M46zMot7UG7I7VQy7HbuhXO5RgoJ8WN0KsL9QscpcDkWN+//HuY2K0jxmvpOHCx0y
         mNpw==
X-Gm-Message-State: AOJu0YyMpbrcKxA89KDil2/L2nKn074DpuVSoxva96KrBqh1xyvT7yQ0
        iDgYSyupnc7/G4+66TTuCgw=
X-Google-Smtp-Source: AGHT+IEg1Y9CDEeNmhEKaGImfvyE8aQsjJzuojQqXiKDyVyE6hAbk2Ban4rp0H4fa+gGlEf7TIkncg==
X-Received: by 2002:a05:600c:21d2:b0:401:be70:53b6 with SMTP id x18-20020a05600c21d200b00401be7053b6mr3836420wmj.15.1695568943158;
        Sun, 24 Sep 2023 08:22:23 -0700 (PDT)
Received: from spiri.. ([2a02:2f08:a301:7000:1bc9:cab8:e784:6ddb])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c204c00b003fe1a092925sm9732838wmg.19.2023.09.24.08.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 08:22:22 -0700 (PDT)
From:   alisadariana@gmail.com
Cc:     Alisa-Dariana Roman <alisa.roman@analog.com>,
        stable@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: adc: ad7192: Correct reference voltage
Date:   Sun, 24 Sep 2023 18:21:48 +0300
Message-Id: <20230924152149.41884-1-alisadariana@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alisa-Dariana Roman <alisa.roman@analog.com>

The avdd and the reference voltage are two different sources but the
reference voltage was assigned according to the avdd supply.

Add vref regulator structure and set the reference voltage according to
the vref supply from the devicetree.

In case vref supply is missing, reference voltage is set according to
the avdd supply for compatibility with old devicetrees.

Fixes: b581f748cce0 ("staging: iio: adc: ad7192: move out of staging")
Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
Cc: stable@vger.kernel.org
---
v1 -> v2
	- use dev_err_probe()
	Link: https://lore.kernel.org/lkml/20230923225827.75681-1-alisadariana@gmail.com/

 drivers/iio/adc/ad7192.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 69d1103b9508..b64fd365f83f 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -177,6 +177,7 @@ struct ad7192_chip_info {
 struct ad7192_state {
 	const struct ad7192_chip_info	*chip_info;
 	struct regulator		*avdd;
+	struct regulator		*vref;
 	struct clk			*mclk;
 	u16				int_vref_mv;
 	u32				fclk;
@@ -1008,10 +1009,30 @@ static int ad7192_probe(struct spi_device *spi)
 	if (ret)
 		return dev_err_probe(&spi->dev, ret, "Failed to enable specified DVdd supply\n");
 
-	ret = regulator_get_voltage(st->avdd);
-	if (ret < 0) {
-		dev_err(&spi->dev, "Device tree error, reference voltage undefined\n");
-		return ret;
+	st->vref = devm_regulator_get_optional(&spi->dev, "vref");
+	if (IS_ERR(st->vref)) {
+		if (PTR_ERR(st->vref) != -ENODEV)
+			return PTR_ERR(st->vref);
+
+		ret = regulator_get_voltage(st->avdd);
+		if (ret < 0)
+			return dev_err_probe(&spi->dev, ret,
+					     "Device tree error, AVdd voltage undefined\n");
+	} else {
+		ret = regulator_enable(st->vref);
+		if (ret) {
+			dev_err(&spi->dev, "Failed to enable specified Vref supply\n");
+			return ret;
+		}
+
+		ret = devm_add_action_or_reset(&spi->dev, ad7192_reg_disable, st->vref);
+		if (ret)
+			return ret;
+
+		ret = regulator_get_voltage(st->vref);
+		if (ret < 0)
+			return dev_err_probe(&spi->dev, ret,
+					     "Device tree error, Vref voltage undefined\n");
 	}
 	st->int_vref_mv = ret / 1000;
 
-- 
2.34.1

