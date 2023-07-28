Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5338D76743A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 20:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235359AbjG1SJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 14:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjG1SJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 14:09:00 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40A41724;
        Fri, 28 Jul 2023 11:08:59 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-522382c4840so3169183a12.2;
        Fri, 28 Jul 2023 11:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690567738; x=1691172538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uV7/ewhQ6VJYm7Yy3VDKL+cMnMex0ecA2i8QY1vvyn8=;
        b=ndlanUesP7HvcI3OsfjO9p5JOah7gp/lK2bYJ2i2K7lfB7jljNb7G+3FoX6HnFWFM6
         yCsyjn8Uq4RtKW9hG7hYj3dfMMxUw00OBBa69gFyb3PcLBHkxV0yprA/juI7F7iJv2TE
         rD+yrTZSFsd3UbiBfcTj/g7kesPoMzJf5CS/7aGqf29uWd0GWnZvxXoaPfjxmyP2cLzZ
         KFQXfUOJBjUK+1uoV8ABon12oxdSeoCoe7TK8vbknDpwuyVPXBeJaOLsJOLE6c03gwbi
         +l/Ph4DI9JV9xrTC6Yt8RF7EqK3HhQqwrfvTcnZQd9NI4T3eO9GKkldWnasljy/Q+RGL
         ylgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690567738; x=1691172538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uV7/ewhQ6VJYm7Yy3VDKL+cMnMex0ecA2i8QY1vvyn8=;
        b=XeKf16YqSQobuBchw2hmIR1KQMwrhwmiN1b7KM6fgxeRKMHHunQlNA71lKxXFidWoU
         Ei45Lc1V326ovglCkYc8UbJ0cNywfNc21z59spOj700TYf6utvX75opEj3wuIEcSPiph
         hBYdpNTRcrN6tPMXcHv8a0kDJhAxRTSq/Om3U/pCQH7pzcyl/7/1tCHUOMu62l/cjUbJ
         KMC7Bx03oeYkXdP57WVK/+yP1QnE90BiAnKn32RVv0fKvR3TKUU1FxJohkvAAqq612LG
         SBr0cIy8KoepRTP5IQE3k7ALNBMiuinxHuBRqIY32fOim7VYIVL8HiQcEJ6WBhEtCKqo
         zEBQ==
X-Gm-Message-State: ABy/qLahAyDX8ZLm6Az4IivoSzzArDFoczwZwewBbEV8WoClnB7Q72VL
        r+h+tZLvqwWE9QFrlBBNfDHtPCu3sg/83w==
X-Google-Smtp-Source: APBJJlFy8KzkucLQ+un7GE3rcs/CE0v3WeXpqXFBzzYBRrhnIWzFefSBhizP4oWwd4bf3TnVrxuZDA==
X-Received: by 2002:a17:907:7854:b0:99b:cf4f:909a with SMTP id lb20-20020a170907785400b0099bcf4f909amr108917ejc.37.1690567738055;
        Fri, 28 Jul 2023 11:08:58 -0700 (PDT)
Received: from localhost.localdomain ([78.97.234.98])
        by smtp.gmail.com with ESMTPSA id gq15-20020a170906e24f00b00992b510089asm2305134ejb.84.2023.07.28.11.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 11:08:57 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     zhang.lyra@gmail.com, baolin.wang@linux.alibaba.com,
        orsonzhai@gmail.com, andy@kernel.org, brgl@bgdev.pl,
        linus.walleij@linaro.org, Andrei Coardos <aboutphysycs@gmail.com>,
        Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH] gpio: pmic-eic-sprd: remove unnecessary call to platform_set_drvdata()
Date:   Fri, 28 Jul 2023 21:08:33 +0300
Message-Id: <20230728180833.18399-1-aboutphysycs@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function call was found to be unnecessary as there is no equivalent
platform_get_drvdata() call to access the private data of the driver. Also,
the private data is defined in this driver, so there is no risk of it being
accessed outside of this driver file.

Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>
Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
---
 drivers/gpio/gpio-pmic-eic-sprd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpio-pmic-eic-sprd.c b/drivers/gpio/gpio-pmic-eic-sprd.c
index c3e4d90f6b18..bfb003ccbd99 100644
--- a/drivers/gpio/gpio-pmic-eic-sprd.c
+++ b/drivers/gpio/gpio-pmic-eic-sprd.c
@@ -363,7 +363,6 @@ static int sprd_pmic_eic_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, pmic_eic);
 	return 0;
 }
 
-- 
2.34.1

