Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC6078AAA0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjH1KXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjH1KXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:23:43 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F49A7;
        Mon, 28 Aug 2023 03:23:40 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b9338e4695so45769351fa.2;
        Mon, 28 Aug 2023 03:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693218218; x=1693823018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6OX5Z+xV4iFsNRL3h/ZSBtl2mNUhSgbKrGXyYKt6ueU=;
        b=ayDOj/0mF11EdHLUUbz5HZq1CEFP2QzyDC8RnZ3/6PaTqTXTXA7n4eNJE07Kuw7x2J
         OgJbd8DvxQd3YyTDZR47FMQRrKnrsO1QGK7Ifd3upL3aT62NAouNiZ6im/BHUTvEEz1p
         Jf6Gmy/16o8dmZdqRIQlXJ2lGaGtyHsB1Qz2ykqThuyzeBtOmnPAnNrEuMG2XERtj67v
         wI2Ne2ZySYiDAVX4I7WlNV3Cy9htHntZ28UYIPi5q2pVq5eSB7RT90R6xuB61ZtlXsKx
         PZ3o5pQm0x63m+PBHtFtAequeZ2vMUKT3eeuFmgCFe/WOngjkF97YJlPFSlvIxAVE1Sn
         br1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693218218; x=1693823018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6OX5Z+xV4iFsNRL3h/ZSBtl2mNUhSgbKrGXyYKt6ueU=;
        b=AKHvjiq1IYy4O+7xN0vC/lNS3H5pVy0aLn/zjWMsIIXcI9+VhtEa1KjbMrlzUjOwYm
         NCoaKMJg+LEWU8yfsRFaWlIniz3YRAmIqS12YX++viadVBFnYl1B/xoNn7pE4Ru93LLY
         lW4UA3mpZ1939Ns3Xmv851OAiDINbv5N+EmWO+l7thzHrAnS4LVn6nrBl1R8ON0Bjobi
         KtPlJ54Wx/GEkH6BCBf75oHIMFsL/S+2ihMU+29gvTlxZRtdkypFRZAX3MeTcGBkvbmB
         wBhJuqA2W5iAF+3KCXy6Cbm4FcSBmeyKWQwGL16X8tuy34S+XPKL3D2WyAQYpZZaezym
         a5ng==
X-Gm-Message-State: AOJu0YybQkKk6W3//YVU/1vlk963MN0YfA5oYaBk1yT5Vd95Qbr/hyWK
        MhTIe7GHunIOtvF2GTzOaft1E8eYjlQ=
X-Google-Smtp-Source: AGHT+IFOf26xlqO9SKeldJ6//auUiKP0kI9OV+dzuXDqwO6970hLx61HHz5zNnHcMwDJKxFjrOe7IQ==
X-Received: by 2002:a05:651c:cd:b0:2bc:f4ee:ca57 with SMTP id 13-20020a05651c00cd00b002bcf4eeca57mr6322219ljr.48.1693218217833;
        Mon, 28 Aug 2023 03:23:37 -0700 (PDT)
Received: from localhost.localdomain ([92.85.190.61])
        by smtp.gmail.com with ESMTPSA id 21-20020a05600c029500b003fe1a96845bsm13537050wmk.2.2023.08.28.03.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 03:23:37 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     yuzhe@nfschina.com, u.kleine-koenig@pengutronix.de,
        herbert@gondor.apana.org.au, olivia@selenic.com, alex@shruggie.ro,
        Andrei Coardos <aboutphysycs@gmail.com>
Subject: [PATCH] char: hw_random: xgene-rng: removed unneeded call to platform_set_drvdata()
Date:   Mon, 28 Aug 2023 13:23:29 +0300
Message-Id: <20230828102329.20867-1-aboutphysycs@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This function call was found to be unnecessary as there is no equivalent
platform_get_drvdata() call to access the private data of the driver. Also,
the private data is defined in this driver, so there is no risk of it being
accessed outside of this driver file.

Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
---
 drivers/char/hw_random/xgene-rng.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/hw_random/xgene-rng.c b/drivers/char/hw_random/xgene-rng.c
index 7c8f3cb7c6af..9d64b5931a27 100644
--- a/drivers/char/hw_random/xgene-rng.c
+++ b/drivers/char/hw_random/xgene-rng.c
@@ -321,7 +321,6 @@ static int xgene_rng_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ctx->dev = &pdev->dev;
-	platform_set_drvdata(pdev, ctx);
 
 	ctx->csr_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ctx->csr_base))
-- 
2.34.1

