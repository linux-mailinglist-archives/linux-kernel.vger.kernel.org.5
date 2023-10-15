Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2741E7C99B9
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 17:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjJOPSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 11:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjJOPR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 11:17:59 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CD2AB;
        Sun, 15 Oct 2023 08:17:58 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40572aeb73cso37434485e9.3;
        Sun, 15 Oct 2023 08:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697383076; x=1697987876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VeqxvK0uzWzz37Q8uuFTlmCXM4qg5qnRs/tMuLh55uE=;
        b=CNxaX3FUbbNckzulXhmeasF4Q7mw2Bu4c7cHTauiPAaG9T6NiLuoRwdTk1HTM6IHh3
         mdVuAUQfx7KtzoVShokBEqOqWLZz1rwMHKcW64w/FlzZ+dwaQb5E0qJX/YL5SJsNsadS
         CEQ4Zulg8WCieAU8W7kjHRvHV02BdEpXmmDroTSYhDSc+j3MSyoTRNcQCN+EHrAiqGNH
         8NRL7nrU4yfSDHkMHtjZwA2EyaAlHGd30cbfGdpbwFRlYaLsxKg6AfThsmLOpC6znzEG
         tlQ3h5RJDkkyk7z9Ko5qs+TAZ0kcTu58sjxzjMGuIK8pQ1Ggv11OhZGl67shjwfRB69O
         jzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697383076; x=1697987876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VeqxvK0uzWzz37Q8uuFTlmCXM4qg5qnRs/tMuLh55uE=;
        b=M29AJosP7ERYPJuSi1r+/jVsRAa6P612pkKxg3+OFEtNsT6ajlacEdgGXtb3cpTqM6
         njMH+mBji4IVpIXYlCe/Th6a9Y8hsvSAsvQGc93JJ64KmWpW3mUBQy8chaqXEJzbdL9A
         nVC7lbPWXjCj7/CD6Q33lBTXJLtwSzez/nk3bl5iLbI/7wHxPl1F5RkwafT5mNPwNa2G
         NyofRB7Ih5p60yjtofD7ZBN9Xl6ra4mURTfIwnfJoOcWYoqxzU1EaGWVD+oW8g3J2biN
         X3JNpIEVCDmTVbBl3ux3HmkCcts6QtaavFfbOTA9WcqpRHxgQP1VZsUTf/e89ynol2pW
         1FMA==
X-Gm-Message-State: AOJu0Yw4mo846f/kvApbjCAk+lqFYCsjeptCUei2aZSAk7eFsk5qf+aS
        FwSy/+HS52178wDKoGMP1niRNepMqIs=
X-Google-Smtp-Source: AGHT+IGgCeGEK/lYbOLRjUeDidJ1lvIUgMMm8ayU1vK1oeSgFTuGMdGygsWpxdLfZJ01peRIeDpC0w==
X-Received: by 2002:a1c:6a0d:0:b0:3fc:1a6:7764 with SMTP id f13-20020a1c6a0d000000b003fc01a67764mr27721664wmc.16.1697383076236;
        Sun, 15 Oct 2023 08:17:56 -0700 (PDT)
Received: from localhost.localdomain (13.red-83-35-58.dynamicip.rima-tde.net. [83.35.58.13])
        by smtp.gmail.com with ESMTPSA id n35-20020a05600c3ba300b003fc16ee2864sm4712455wms.48.2023.10.15.08.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 08:17:56 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        linux-kernel@vger.kernel.org,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 2/5] iio: pressure: bmp280: Use spi_get_device_match_data()
Date:   Sun, 15 Oct 2023 17:16:24 +0200
Message-ID: <553d1e9187fac10094116d3a1688b66bebd60cd2.1697381932.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697381932.git.ang.iglesiasg@gmail.com>
References: <cover.1697381932.git.ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the spi_get_device_match_data() helper instead of
device_get_match_data() and the fallback match_id logic.

Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>

diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index 1dff9bb7c4e9..2eed483a8cc4 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -58,9 +58,7 @@ static int bmp280_spi_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	chip_info = device_get_match_data(&spi->dev);
-	if (!chip_info)
-		chip_info = (const struct bmp280_chip_info *) id->driver_data;
+	chip_info = spi_get_device_match_data(spi);
 
 	regmap = devm_regmap_init(&spi->dev,
 				  &bmp280_regmap_bus,
-- 
2.42.0

