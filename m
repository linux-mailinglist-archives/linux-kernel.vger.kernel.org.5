Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9697575C353
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjGUJoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjGUJoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:44:23 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4563C03;
        Fri, 21 Jul 2023 02:44:02 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so3743711a12.0;
        Fri, 21 Jul 2023 02:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689932634; x=1690537434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KufbHwDVTAENvqW3Gbf2Cw3W/WRIPa478XeaP0bFlnE=;
        b=f706MmNZTq1vkEZF0vgWp8uaxQ7UDeMZ6ORg5gnEyfcNubUEDaMmPT2uIyFfeq+fn5
         DO+slVl1pNGDSEdv+WUe+dYHkKzkj5aPiWWRm2AXDUKN1yf6Sz89VCR4Gl7QWp0wNpeG
         JbOej55Y1JRoBeRAQ/2SrPaEs0f2uIdHO+Roi6KITMcRXT24BqAP8NfgU2ki6SltNoCi
         KeYt/ax9yo1KxHGtSPadC0KzvasdiUry9POeKqqPb2ziA52oYCpk0a950K+pEWLf7GKd
         WtY/uwmY7g/pgpccZdvD3RNebafMmuGVPxsMkdzMmazcZoVpUMDi64hk/ZySrSVyf+TP
         cZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689932634; x=1690537434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KufbHwDVTAENvqW3Gbf2Cw3W/WRIPa478XeaP0bFlnE=;
        b=ERV3QO9QBIsv6TPKMj47zoMx8dKA0/1DmRFtHQJzMQWb2XRsJQN/CrYHa3NBc6ZQ8F
         Ik0ExaSr/KQrsoiQPdDHg0W1LBTRvhCL3ZhFV/YBNQ3J7AEmyEnfyc8Qd+at3DfZjuhP
         U24LYEM7LjOvbfZYRb8XB+dQSo/TEQ2aBuDNII1NDXI+2Ll7szO8/6w/JrlHBHlMJrrR
         7lENpgpcyLeW5dyVHtw6r/trg/Ntyz+ELkPpawNkZjrEwFFKxNufkXRTwr/Udinb0sLJ
         jU4qT+GztAk2pJbv9D9wODGeJftdinKOf+cJv3QJjM3nmeWSC0i/Ygqm8KJnm/3korcK
         KGug==
X-Gm-Message-State: ABy/qLbV4pj5yJog1O019Dl5nPvU+uNcBkbLfdkydzm8yjnCuD/cx/qH
        sgIcS0hdZRG+nKWn3vzbWuHz/feynUbR6A==
X-Google-Smtp-Source: APBJJlHduXlURDiNUU/29o6F0cjfTOVbLT8hqp/RI1O8Tdj/uYL9fjXPO5uuTfKR+ls2/o/NCPE0KA==
X-Received: by 2002:a05:6402:12cf:b0:51f:f079:875f with SMTP id k15-20020a05640212cf00b0051ff079875fmr1460361edx.4.1689932633840;
        Fri, 21 Jul 2023 02:43:53 -0700 (PDT)
Received: from localhost.localdomain ([92.85.190.61])
        by smtp.gmail.com with ESMTPSA id d2-20020a056402516200b00521d18687besm1847837ede.82.2023.07.21.02.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 02:43:53 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     andy@kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org,
        Andrei Coardos <aboutphysycs@gmail.com>,
        Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH] gpio: lp873x: remove unnecessary call to platform_set_drvdata()
Date:   Fri, 21 Jul 2023 12:43:43 +0300
Message-Id: <20230721094343.25741-1-aboutphysycs@gmail.com>
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
 drivers/gpio/gpio-lp873x.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpio/gpio-lp873x.c b/drivers/gpio/gpio-lp873x.c
index 5c79ba1f229c..7427a74ce4e2 100644
--- a/drivers/gpio/gpio-lp873x.c
+++ b/drivers/gpio/gpio-lp873x.c
@@ -140,8 +140,6 @@ static int lp873x_gpio_probe(struct platform_device *pdev)
 	if (!gpio)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, gpio);
-
 	gpio->lp873 = dev_get_drvdata(pdev->dev.parent);
 	gpio->chip = template_chip;
 	gpio->chip.parent = gpio->lp873->dev;
-- 
2.34.1

