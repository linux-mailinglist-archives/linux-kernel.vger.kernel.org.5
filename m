Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7B075AFF5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjGTNaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbjGTN3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:29:44 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503C22D7C;
        Thu, 20 Jul 2023 06:29:25 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51e5e4c6026so1042397a12.0;
        Thu, 20 Jul 2023 06:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689859763; x=1690464563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EAKOFZ4eRsWM0xGfBzouN0FPvtStI7fkmnGxkak+jLg=;
        b=kUloNH7XNx93JEpMMMeQvXV1FAHG24vvyml07aorZwaR5WVpsIEW8rFRUW6hs0LU1v
         ZLgFGKA9ctbVvhQsS3cfCUYSoA3IAZw4QaPpz6uidkPAcon0CBdwkXMRSFTwzxYagaxT
         b4KXk7d8khUHSMfnM/baf7yQb5gauWR0U90qCARs4Am6m32HESpvWu1478uNMCW04hmD
         gUqYHRFxogDRQER9S8U+ELs77R1NkTwMlF8H5oA/FGl5QVeb04ZfKQln5iTpJ+6n1E+2
         L/5yGas9/lLfMhhgVoMFOotZn0JLu4P4tYYW9q6GKsK/qFcAUteCp3rMAQyk1ps8EVdh
         9qQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689859763; x=1690464563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EAKOFZ4eRsWM0xGfBzouN0FPvtStI7fkmnGxkak+jLg=;
        b=g17+b5cvPB4QUrIQZ3+SFgVub/WGoVH52qXbJuoZiez9ilgsbpcshWc5NA8scA0GFN
         e+T1FMIac3qA0nHpyUVzDrk8VoxuekwwpAK8gMgi4cwZ4CvtHo/Bx9IN6sFD9k5WvFOj
         TLxcRPVINz4/P6DeMlZZBD11k0GeseM4lS8reeSe+tDa4/IUFoWq1MkQBMdlQ6yiw9SS
         RK8z2h5V/KdZ50+mLGNnCaEdfPkVBV24zRntcPWOvmA7h7vAcMNoQkM1ZeVLWlErJaRs
         sHrgtgo7l8aN/EtMz7lzyJVvYGBH0gijJEAUSoV2MZuRJNc2ndt/YE/zIdgbX9Cfe/nb
         MxJg==
X-Gm-Message-State: ABy/qLYxgSULMDqBq9rATxt/jZzBLZqwBzadh+Rf4Ds812Dz4JBPECnx
        09NFqaWOYlo2g6She8hitxZXhy8XUGiK7Q==
X-Google-Smtp-Source: APBJJlH/SP0nlLL+fGYpzF5xxnfPCGA3bUHuwKYTRAcCYT6CWkI0alP57EibCaBWPraggifTbQXhFg==
X-Received: by 2002:a17:907:6d20:b0:991:e815:a1ef with SMTP id sa32-20020a1709076d2000b00991e815a1efmr5419375ejc.31.1689859763311;
        Thu, 20 Jul 2023 06:29:23 -0700 (PDT)
Received: from localhost.localdomain ([92.85.190.61])
        by smtp.gmail.com with ESMTPSA id ju13-20020a17090798ad00b00988be3c1d87sm704189ejc.116.2023.07.20.06.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 06:29:22 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     andy@kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org,
        Andrei Coardos <aboutphysycs@gmail.com>,
        Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH] gpio :lp3943 :remove unneeded platform_set_drvdata() call
Date:   Thu, 20 Jul 2023 16:29:11 +0300
Message-Id: <20230720132911.23449-1-aboutphysycs@gmail.com>
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
platform_get_drvdata() call, to access the private data of the driver.
Also, the private data is defined in this driver, so there is no risk of
it being accessed outside of this driver file.

Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>
Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
---
 drivers/gpio/gpio-lp3943.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpio/gpio-lp3943.c b/drivers/gpio/gpio-lp3943.c
index 79edd5db49d2..8e58242f5123 100644
--- a/drivers/gpio/gpio-lp3943.c
+++ b/drivers/gpio/gpio-lp3943.c
@@ -199,8 +199,6 @@ static int lp3943_gpio_probe(struct platform_device *pdev)
 	lp3943_gpio->chip = lp3943_gpio_chip;
 	lp3943_gpio->chip.parent = &pdev->dev;
 
-	platform_set_drvdata(pdev, lp3943_gpio);
-
 	return devm_gpiochip_add_data(&pdev->dev, &lp3943_gpio->chip,
 				      lp3943_gpio);
 }
-- 
2.34.1

