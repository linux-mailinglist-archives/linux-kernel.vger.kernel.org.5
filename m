Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC227591F9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjGSJs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGSJsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:48:25 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3621D106;
        Wed, 19 Jul 2023 02:48:24 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbc63c2e84so66650665e9.3;
        Wed, 19 Jul 2023 02:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689760102; x=1692352102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7nKvAg0UeO5hQKBa9gfwBg8pDd1wlFrZUyTMDx2yTB0=;
        b=smNcEqxwsIiCHR+4dB3fdYQz+t/QVB4jhH+T9e7rmp0hz0hBqsU2uRotRbpNUGg7so
         YbvnJAC4x7LHgcHwV6lrISVVIBo1RvAXi1tTg1ALslAPxcXf7KESR4UmBHLOfsNaVqyi
         bp2ZNFtLdb3jG7CK0zn9nClRHvKp5NnETLWNFyoYJZUp9AXQ9PoHRV9mgxmqaNgi5X0G
         3qAj6iwNrgZDJNrSgoWWvUQ0ortmIn6BFJXZaIPdF4KKx6KTetBco9oXZ97Wy04F7uHq
         mW7K18TlnT36r+9UZVHotSMlUAHubouaIseskT3OhSI15SPdrTYMZ+bBRNYMv1WJG/Sd
         AW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689760102; x=1692352102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7nKvAg0UeO5hQKBa9gfwBg8pDd1wlFrZUyTMDx2yTB0=;
        b=JVWzC8AhEk5Y4DRrMPGwAUvvUBzE96CSXbYUWEduPlhNOAGRs1PCUAd08VVWMuBewr
         yx8e9cbkAXul6YJSKDweK4JM50kgNZ9YRjELBpaQtTC9ZgSUCFvyxMs8r/kkFL7mgTz0
         TipR3PCqnVQj0I43h0S/BTDF0zCNR/loXTZugpns84msiNLf7M7iFo977UnrpZw/2f28
         JFKaOFQqQuBfFA7e9nErN43n4qnCKNXWmzIvWh5rb/fujcaWF5sx6Y+TIvsKb1Z1wLmi
         QZaal736oUGPHhiVP3haVT2j250bnP55XIzz25lF/UV2rjSHL+K73JoPMnmBrdOdC74F
         Y8PQ==
X-Gm-Message-State: ABy/qLZ4Picw6kpPrzcCZJlKRdlPXvpCv2npYHEtaLrTzS8DM+9kF9tV
        PfMuPZG16jMQZOiBZzxxJkZadavS30uA3w==
X-Google-Smtp-Source: APBJJlGPLDPZNDxDIlmIip/NTEefxZiWg7Goa6dTQ1bwVEpRKRMNItmndfo+V4kz51/lSCsWkCwQTw==
X-Received: by 2002:a1c:790b:0:b0:3f7:f584:5796 with SMTP id l11-20020a1c790b000000b003f7f5845796mr1751451wme.2.1689760102257;
        Wed, 19 Jul 2023 02:48:22 -0700 (PDT)
Received: from localhost.localdomain ([92.85.190.61])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c234300b003fc04d13242sm1280401wmq.0.2023.07.19.02.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 02:48:21 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     andy@kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org,
        Andrei Coardos <aboutphysycs@gmail.com>,
        Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH] gpio: logicvc: remove unneeded platform_set_drvdata() call
Date:   Wed, 19 Jul 2023 12:48:03 +0300
Message-Id: <20230719094803.17677-1-aboutphysycs@gmail.com>
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

The platform_set_drvdata() isn't needed for anything. The function is a
simple setter that doesn't change anything in the code. That is because
there isn't a get function and since it has no dependencies it can be
removed.

Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>
Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
---
 drivers/gpio/gpio-logicvc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpio/gpio-logicvc.c b/drivers/gpio/gpio-logicvc.c
index 992cc958a43f..9b4789deae45 100644
--- a/drivers/gpio/gpio-logicvc.c
+++ b/drivers/gpio/gpio-logicvc.c
@@ -139,8 +139,6 @@ static int logicvc_gpio_probe(struct platform_device *pdev)
 	logicvc->chip.set = logicvc_gpio_set;
 	logicvc->chip.direction_output = logicvc_gpio_direction_output;
 
-	platform_set_drvdata(pdev, logicvc);
-
 	return devm_gpiochip_add_data(dev, &logicvc->chip, logicvc);
 }
 
-- 
2.34.1

