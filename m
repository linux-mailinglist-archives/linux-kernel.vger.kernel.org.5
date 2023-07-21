Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B8775C765
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 15:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjGUNMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 09:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjGUNML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 09:12:11 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394DDE68;
        Fri, 21 Jul 2023 06:12:10 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51d95aed33aso2560252a12.3;
        Fri, 21 Jul 2023 06:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689945128; x=1690549928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FLOhJ2rJe0Qc3xeU0mPkMornHnJZ7T3VIe9SRIhazhc=;
        b=iAYToVXi/ijdwSzHq4d+wkebjmSC99gou5UMnv6zjGjRWP5bI4WTLBhrV1DfagTJan
         rDpCPIQDkKafttAfARGXZo3KEusmajti9zf90LyJQaP+J0S7Dg7RWFMtEASJMG153pdj
         4WpNppMYg+TtP1WjEppm30Mfe3uE5AAJFSeWLVlMOHs6Q6AW7mUZlidmgpsF2zZwKfup
         73h5RuuqzNROShZ18hPhOsF24CBNUdrVxZ2wF9V06+QwdnNQKu1uPIEceJZiVoxJSYHB
         xn1VKZmpdCHP/EpMUii91RdU/Mq3seN7RQUkVvOJnuAxpMbs2aJvs5WxS2rCTivvR3TM
         LXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689945128; x=1690549928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FLOhJ2rJe0Qc3xeU0mPkMornHnJZ7T3VIe9SRIhazhc=;
        b=KoeLWMamWFbzETRN0vK8jRzt+Zgv/pDVNeSij/P3MEvGfx4kMaO46ic/IvUCtbKeAp
         fTY+QN9usAOyvdu8+8pAVYv2d89KMuKfVncHxW2nz4jBCVPJL7BUpwSdeOOO+K4PjnfQ
         FAyB/9Tq8NC/HUX5NFLloUCX1qxe4lLeXOH6iQjOu7gSIKTz6bpAf0KtmL/jLhFDsZdT
         0QAObBR1+bIBgQJ0Y+F4UDGwyVpg8GKoBPcaOy6jKZGajbR/pUyfZ8duN0eKd8ts+iWr
         CtaBNlI3QkfEdyB6/CAh6bk5nXqujY7V/dYCkcwD9QK/yDVYYicV7Xq57w++jYSRLkn6
         zb1Q==
X-Gm-Message-State: ABy/qLaXtWhBQu46BUrSSrS9XHcTZrzYh2fxgWTBZzu72RaxE7aBH7Lf
        PpBqiO+HJrn7VpCmo6KLPCLvOZC9c0NAIQ==
X-Google-Smtp-Source: APBJJlGnJ2hbt7GQPk1lHcmsW/FH7OjoWu8mc2s6uhhRQv7d/aL1OvXGbjhQ3BAjZHskVuObr0dBdA==
X-Received: by 2002:aa7:d618:0:b0:51d:b89d:9818 with SMTP id c24-20020aa7d618000000b0051db89d9818mr1412956edr.12.1689945128161;
        Fri, 21 Jul 2023 06:12:08 -0700 (PDT)
Received: from localhost.localdomain ([92.85.190.61])
        by smtp.gmail.com with ESMTPSA id t23-20020a05640203d700b0050cc4461fc5sm2104270edw.92.2023.07.21.06.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 06:12:07 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     andy@kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org,
        romain.perier@gmail.com, daniel@thingy.jp,
        Andrei Coardos <aboutphysycs@gmail.com>,
        Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH] gpio: msc313: remove unnecessary call to platform_set_drvdata()
Date:   Fri, 21 Jul 2023 16:11:57 +0300
Message-Id: <20230721131157.26640-1-aboutphysycs@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function call was found to be unnecessary as there is no equivalent
platform_get_drvdata() call to access the private data of the driver.
Also, the private data is defined in this driver, so there is no risk of
it being accessed outside of this driver file.

Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>
Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
---
 drivers/gpio/gpio-msc313.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpio/gpio-msc313.c b/drivers/gpio/gpio-msc313.c
index 036ad2324892..8e6835399d24 100644
--- a/drivers/gpio/gpio-msc313.c
+++ b/drivers/gpio/gpio-msc313.c
@@ -643,8 +643,6 @@ static int msc313_gpio_probe(struct platform_device *pdev)
 	if (IS_ERR(gpio->base))
 		return PTR_ERR(gpio->base);
 
-	platform_set_drvdata(pdev, gpio);
-
 	gpiochip = devm_kzalloc(dev, sizeof(*gpiochip), GFP_KERNEL);
 	if (!gpiochip)
 		return -ENOMEM;
-- 
2.34.1

