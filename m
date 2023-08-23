Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16EA7856AD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 13:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbjHWLWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 07:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233505AbjHWLWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 07:22:00 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42B1E54;
        Wed, 23 Aug 2023 04:21:53 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fee87dd251so35560185e9.2;
        Wed, 23 Aug 2023 04:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692789712; x=1693394512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UK0KglLss9+3G1O+6rgFNGYqOH+7S4DnvgYXRAelUkk=;
        b=GNZVhniZ+xXtUSuBfjNA3mXH/9snWyv5TwTIf17HyA2DOIrwWUdgcqwQAPeSb3N1OG
         7ilvU6Up+xfZeWyc4reQGjiGMihjfe6U5qJ2Gh3AfujFIjl9o7uy7yeNeKP52QW2W1fX
         sIYaZH9RS1mrkafIiDqzxuAELf3dqiI9lw7CHxI21z7Uet+1QPF0lpnM2HZBmaydNFzO
         SvXlBB9PA2e5iOjr9hePPaw37yV8wSCRjWpOvNqlImH9Gy0G9OfE1+4iJX3PQZ96zNuU
         Rai93j+GX+NQtsrrfYBhTdlXzGinGuHgvwi2l+yKy6gLk3uWd8Cvf7X9m9nBk92ZA59X
         V8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692789712; x=1693394512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UK0KglLss9+3G1O+6rgFNGYqOH+7S4DnvgYXRAelUkk=;
        b=i9bO2B3X7YIDaAAZmp5b0TuMwa7Un4v7NByjy5rNl0Osrg9l2ZlVuq35DkHcd5ooST
         hsFajvSunQVbrurmiq/OYx3Xu5v8Odac7/7AswI0oNfNT9Thpkn7pqHGq/c34z+HFjAJ
         WjZ7rd3A8PMF3Rf8MaxC8PQk9yLlRKOZLvWyyUw+kAB7X3XeyrP6nfHOn14dB6NZADHU
         0GdlB+7bFieNoOAz4o8LoZW8Oh9WXj4GrBQWOobpQAc56eiVeGjHQ1TbpS2dwFWINoeP
         L7Ejd9wEPOJ5MkNbERWCzyYXrEiEvGQk6yBAbE73OtU4+1rvfWOGzf9/ebvG0dpynC1v
         4GCw==
X-Gm-Message-State: AOJu0YxHAr1rSZ93NHgrPNxG6484BdNqOkf9gKGvS3Oh4picSsOWR0eK
        fJHzcvx8xQo0zVRHZyzrdCh4HCbHbus=
X-Google-Smtp-Source: AGHT+IFcillDt6nvw6yvgH8HLpnMV5EaaxG5YBxdBqVGlV6nkent8hut801lTRLxxWThBo80dPtVXw==
X-Received: by 2002:a5d:680e:0:b0:315:ade6:a52d with SMTP id w14-20020a5d680e000000b00315ade6a52dmr9697086wru.19.1692789711985;
        Wed, 23 Aug 2023 04:21:51 -0700 (PDT)
Received: from localhost.localdomain ([92.85.190.61])
        by smtp.gmail.com with ESMTPSA id j16-20020a056000125000b00317e6f06e22sm18786010wrx.77.2023.08.23.04.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 04:21:51 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     alex@shruggie.ro, herbert@gondor.apana.org.au, olivia@selenic.com,
        Andrei Coardos <aboutphysycs@gmail.com>
Subject: [PATCH] char: hw_random: hisi-rng: removed unneeded call to platform_set_drvdata()
Date:   Wed, 23 Aug 2023 14:21:39 +0300
Message-Id: <20230823112139.4012-1-aboutphysycs@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
 drivers/char/hw_random/hisi-rng.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/char/hw_random/hisi-rng.c b/drivers/char/hw_random/hisi-rng.c
index 96438f85cafa..b6f27566e0ba 100644
--- a/drivers/char/hw_random/hisi-rng.c
+++ b/drivers/char/hw_random/hisi-rng.c
@@ -79,8 +79,6 @@ static int hisi_rng_probe(struct platform_device *pdev)
 	if (!rng)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, rng);
-
 	rng->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(rng->base))
 		return PTR_ERR(rng->base);
-- 
2.34.1

