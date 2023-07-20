Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5B175AB81
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjGTJza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjGTJz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:55:26 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E2EFD;
        Thu, 20 Jul 2023 02:55:24 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99313a34b2dso94409866b.1;
        Thu, 20 Jul 2023 02:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689846923; x=1690451723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EAKOFZ4eRsWM0xGfBzouN0FPvtStI7fkmnGxkak+jLg=;
        b=hzDCZuH3xvkWv1p6kCElrJshFhXjoOF2hXoMF37sU9znUbeY9zzLwwBN99cR9eOckZ
         RL2lsWWTzO6RSVUw7WPQh7QmcoaCuPHs+J020t/YKCQJSqA+FBUt6ygCwGwO2O+Cm+ti
         Zwm/sQH5Zv4nuVasNx+7NvsWutsPQp7T81XValAazdJQNri6dEa5ZdbcTMK2QNHMk2DK
         2tvWc6mKW8+URqeWvIRA5O3MagwqklD1ZdgMvaa6M8XawbsPD/r74miTwiPZnJ93s0UH
         32m6eal65/iLMAMyr1mW0yi0oYuSepjkN42R2cEcJuxQRa5w/kZzos6xGkuS2ad4lODC
         GEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689846923; x=1690451723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EAKOFZ4eRsWM0xGfBzouN0FPvtStI7fkmnGxkak+jLg=;
        b=HHDxhkqlC/7HMvrgzdefPp39voDGK0xQIkgEu1X+w/yaOql9Rott03hrKj6+wZMzaR
         Q+CVBMy3BsfY5qR2u8GUkJ/2n857plVIEBrK3PGwlPOxba0uDN9y6eTVPi6fgxD6lFJS
         U1yjYgz2z3c/73Q/L7JisVGcC4B5rgPMZ2l7tgpyMtcfv4b6Nzz7ZgM2o/UUzY72xMZb
         lo4BBKwnmMS5eHbNMaN1S2jwgGiLcH+sCKQRJBZjb0RoIkgt3ET3b2jhXlQCUxqNBmpe
         UP4ioWwGIqFs4LciQymmCujhUP9vWXxpdZlfL19TTFfYfRHfB8q+MVT3vdOQOggkUFD+
         iFkg==
X-Gm-Message-State: ABy/qLb/ZLb4f4Z6I4NF28di1RrRZH4ibqZ6JSq7BamEMUVD6antEjye
        MrC9SDDNarw/VB6xChS4LDIzn3/42TBKYw==
X-Google-Smtp-Source: APBJJlHZYhtdxZdZ7ZAMD4/eEzpKreWsr9pOAjC+LgF0ijcHmSBSvUEXXPHJz/FlQ8VgLK/hUUf15g==
X-Received: by 2002:a17:907:7f18:b0:98f:c9b:24ed with SMTP id qf24-20020a1709077f1800b0098f0c9b24edmr5816363ejc.67.1689846922634;
        Thu, 20 Jul 2023 02:55:22 -0700 (PDT)
Received: from localhost.localdomain ([92.85.190.61])
        by smtp.gmail.com with ESMTPSA id x2-20020a1709060a4200b00992ddf46e65sm449622ejf.46.2023.07.20.02.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 02:55:22 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     andy@kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org,
        Andrei Coardos <aboutphysycs@gmail.com>,
        Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH] gpio :lp3943 :remove unneeded platform_set_drvdata() call
Date:   Thu, 20 Jul 2023 12:54:55 +0300
Message-Id: <20230720095455.21474-1-aboutphysycs@gmail.com>
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

