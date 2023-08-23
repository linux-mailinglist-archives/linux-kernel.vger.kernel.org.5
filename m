Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C28785CCA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237371AbjHWP65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjHWP6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:58:55 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12463E6E;
        Wed, 23 Aug 2023 08:58:54 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31ae6bf91a9so4607963f8f.2;
        Wed, 23 Aug 2023 08:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692806332; x=1693411132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DqdYH9doSRvp2JH1D1rlVrHQrKY8RQikW+rUObWbAko=;
        b=aXSyEPPqSAMJ6+JPKCnCD+RrsG2+xVlrOxSjGYKnbrorVip9Ci7LKJQ/Yrij0fGKzF
         iEppPgJg2SupU8R1Zg4MzM5Lf2ogLDvgnTtVAXv+T27I/ETxvsX+Ecn35Yn6BEFtUV5V
         vGADv7eMMk1PbOjdgfS/azPQ6I/wvBfn9CBxLWMDN9XsRbkgJwTxDQytnaNVD0rOyoAP
         dkZGpOUwSJWXfsceUQzm1Vmj+X1eJygNtTG6DD7SCWeNIG2/JoUe6t1bm2IVsYxevGZq
         K61ouGmsMvcHjrTfcOQKwyCaBm1GJ8P17/TEHjnBZ/A/Waaol8+FxtLx5CwSzXTgVGc1
         eFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692806332; x=1693411132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DqdYH9doSRvp2JH1D1rlVrHQrKY8RQikW+rUObWbAko=;
        b=hagRIeqImcbHfsjiQDvJ+fFhfMFNVmemAAuGIodf4squvvtiSpF2IvhB7JvyXWqQrx
         AfH5RxDvP9CowAyx1LisTnXfIubFJu7SI8PJbe/Za+hRkEwYMxH2BiJ2nABPNveotkfT
         KdDMaZ+K5sqqmie75rzggpUU1gFbyu4wr8sZnhfUYybVT2ucN/fjwAF8fsutNKv0pgXr
         NawWrhyO0a+LDdtcyk3DSBj86CGET4pIIacf1O/35s9lDFP4fhUKT/vyvM+Hz7vT186Z
         AHCcWgVdWmCd5mte0zBUMPTTZe/JXF2RLAori5YfX9nFM2S7urDAxQAhGQscB1EuEQZu
         BwSQ==
X-Gm-Message-State: AOJu0YyWr2h2LPhHgP91lg94xsUcWHybsm5Hz/mMMXu6KgoVhKQgccPG
        FQl7H6DLGUh7RtprM2O3VbwdZkKMioo=
X-Google-Smtp-Source: AGHT+IHkTN7Z9GeeDmillfrS3M+Nu9K4B6bWlzat2COel2SfLV9iNqkSMvGDXkYiK3aK6li1hxitPw==
X-Received: by 2002:adf:fcca:0:b0:319:85e2:6972 with SMTP id f10-20020adffcca000000b0031985e26972mr9150195wrs.42.1692806332129;
        Wed, 23 Aug 2023 08:58:52 -0700 (PDT)
Received: from localhost.localdomain (35.red-83-35-63.dynamicip.rima-tde.net. [83.35.63.35])
        by smtp.gmail.com with ESMTPSA id t24-20020a7bc3d8000000b003fe195cecb3sm17044613wmj.38.2023.08.23.08.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 08:58:51 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/3] iio: pressure: bmp280: Use uint8 to store chip ids
Date:   Wed, 23 Aug 2023 17:58:05 +0200
Message-ID: <cf08dd2fab1fd91ca7ed0724d1f50435c8c2914b.1692805377.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1692805377.git.ang.iglesiasg@gmail.com>
References: <cover.1692805377.git.ang.iglesiasg@gmail.com>
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

Represent the device id reg values using uint8 to optimize memory use.

Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>

diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 5c0563ce7572..ff72e82f55ad 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -418,7 +418,7 @@ struct bmp280_data {
 
 struct bmp280_chip_info {
 	unsigned int id_reg;
-	const unsigned int chip_id;
+	uint8_t chip_id;
 
 	const struct regmap_config *regmap_config;
 
-- 
2.42.0

