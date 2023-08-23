Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E2B78569F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 13:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbjHWLQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 07:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234394AbjHWLQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 07:16:38 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACCBE5A;
        Wed, 23 Aug 2023 04:16:14 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2bcbfb3705dso45225741fa.1;
        Wed, 23 Aug 2023 04:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692789373; x=1693394173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n1IOz8Tm2ZzuO8iIkjY/bq2n8EiedFOrmA9uVirfi0Y=;
        b=G/ua5zsN3H9V3SIILarO74A834T6Ed2jkbdnFyp39cmmWTVPHWEEeLWy4bNRRUScU+
         r+pWlq/OGftfZhmxC2I+nEV80fvGiILBQYhybBLxoVjTb+0FwUrQoKkJIy97/4HhqpIf
         cv/bEYYKrXf44rJ/NYHZeabNw1yG4yXfzlQM5Lx2n+XoUyyxukdEVMHokCmlZnYNWHv2
         40JDpm5+60QKMU7ONXXxrQCVam5UnHmV/9bajBT8J2FFEzbSxgYeHSTumAZJQe9eiZeY
         qBFGJWbxW8/oyX08PJ+ENtAAysbUxyRTUCm2kW5zcOnn3Uw6F8p2znXnRJLDXc9sMKH2
         HjzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692789373; x=1693394173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n1IOz8Tm2ZzuO8iIkjY/bq2n8EiedFOrmA9uVirfi0Y=;
        b=VdfzgNbN6SXRIAKyMhab1uGfzdef4qV5uk3volt2rj+Wyu5GYxzr+LMZVr1EzkGot5
         uXrqM07ECzJ27n2WPZvw8hytLHXpMO1mEtMDnOMehfSvPYpu54fABgFeDkx2msyqLjDa
         +vAQmUqgcKmpS4sOW0DHUkLPIj6ScPhyv11Sg+sROa+/A1+2LRSs5uzzyQY+YMSe/C/r
         J23jbI+cR5yim/a3jzKwfgGMVnruiTXgUEFv9X4ySD7cwd8HIZ+WFys1VzUQveJSQpse
         NaFhj+gRc7luGso520Y0Edw+CRH+bIxUDjJMVQnNGfzCZ11glkVxgXtLuO7dZteiKr95
         qN9A==
X-Gm-Message-State: AOJu0YzkIS+EznQONTU/iimYJYX9v1Yc4CU70WgJkaWvue9CLg1fIM7r
        Oe9c7jbpx7FwFzRwotB0pGFTPf+UINE=
X-Google-Smtp-Source: AGHT+IHNAimyqRB4bWSQDI618KWVc3sWSbdrqrCFyo/ll6MuCbBwSgsqO0JHIoB9n+rzqt3DEhGwMA==
X-Received: by 2002:a2e:9096:0:b0:2bc:d5f1:b9cf with SMTP id l22-20020a2e9096000000b002bcd5f1b9cfmr2705704ljg.27.1692789372380;
        Wed, 23 Aug 2023 04:16:12 -0700 (PDT)
Received: from localhost.localdomain ([92.85.190.61])
        by smtp.gmail.com with ESMTPSA id m18-20020a7bce12000000b003fbc0a49b57sm18419720wmc.6.2023.08.23.04.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 04:16:12 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-crypto@vger.kernel.org
Cc:     alex@shruggie.ro, Jason@zx2c4.com,
        bcm-kernel-feedback-list@broadcom.com, sbranden@broadcom.com,
        rjui@broadcom.com, florian.fainelli@broadcom.com,
        herbert@gondor.apana.org.au, olivia@selenic.com,
        Andrei Coardos <aboutphysycs@gmail.com>
Subject: [PATCH] char: hw_random: bcm2835-rng: removed call to platform_set_drvdata()
Date:   Wed, 23 Aug 2023 14:15:55 +0300
Message-Id: <20230823111555.3734-1-aboutphysycs@gmail.com>
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
 drivers/char/hw_random/bcm2835-rng.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/char/hw_random/bcm2835-rng.c b/drivers/char/hw_random/bcm2835-rng.c
index e98fcac578d6..0238f487f9ab 100644
--- a/drivers/char/hw_random/bcm2835-rng.c
+++ b/drivers/char/hw_random/bcm2835-rng.c
@@ -150,8 +150,6 @@ static int bcm2835_rng_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, priv);
-
 	/* map peripheral */
 	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base))
-- 
2.34.1

