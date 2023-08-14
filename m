Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0EB77BE6D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjHNQxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjHNQxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:53:08 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D8512D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:53:07 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-523d0fab783so4017388a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692031986; x=1692636786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7+Juus+8zqjM8rfjV+O0dsXAjzoK79gT3GVbXmTpDs=;
        b=hlF7BEYwKHiA7wdUa+FYX64m+8/t/HIgVMnt8+LuzOSP4MbzLHUQHvR0Le9T8nnydw
         n02O9QgK1fsr0mb2yfnP889CRm8P6uMfNUx6vNKG+lpur/HchRSMwSHvQMldpSktDGHK
         97QU8o00e0zJVbkw2+dc0Z45eXaQ2Z5tVB0HpvkXu3U8v2I0VYMg5itccluvsdyquQUd
         Zm4E/+porU9Hjz+jvt6pcW2Av1iRw2Hj10olKdv0U6HISrXqmQ8fTh+ttlq1LpWu6bpi
         GNRMxIE/q36ULJaKl09uCX3kgw7Pt+iZJEWpM1f1WAFcdnwSw5LCRIUebdqgKDzwUuKY
         55WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692031986; x=1692636786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z7+Juus+8zqjM8rfjV+O0dsXAjzoK79gT3GVbXmTpDs=;
        b=LlOPDY5+kYv0t+Ec1U9gyxDQdRH8vnYMeei7neDgh/mwaw6gUMn/6jxPR8lR40E8Ph
         BLepNBTiHzTCul+sHDWxIoweNWzLn2tXrxhisiI052uKlY9NYBv7pfQ+NEQzZqQQVu5y
         +G4s6mkpJHvSvuuqD5nGNUBZxo7Y7IeSIGfOScM3AivZyl9Pth52FJkb727wCuoRjtfF
         P8j1eYDfPAonqTphjJORObQApdXV5GIWHo1j5eplYXklHVa6poK3ukeVRkZzYZoTEvwR
         C1HAkTaG/ar+t6QhD+bumYU9Gf0x8+1tlemOwpHoIVSzBdVnB/yv06N9B0VfeWsIuOw9
         9zUA==
X-Gm-Message-State: AOJu0YxzTBEfRRsd0v/UbRO3G74/cYEcjZ4j4whkUatMAOpe4mTxuZ39
        tYGg1F6nDTR0nlMRDptM0rJSQ62tyFZjAOYsiIo=
X-Google-Smtp-Source: AGHT+IFDJM3Catv6Ve94RVgAHOdxSdLGggaUTY/ARe1sB8iQDPTaLhsWNk21rN6pOlDUKY3bY2xCUw==
X-Received: by 2002:a50:ee84:0:b0:522:4dd0:de76 with SMTP id f4-20020a50ee84000000b005224dd0de76mr7390717edr.2.1692031986287;
        Mon, 14 Aug 2023 09:53:06 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id n5-20020aa7c785000000b0052338f5b2a4sm5811267eds.86.2023.08.14.09.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 09:53:05 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 07/22] nvmem: stm32-romem: Use devm_platform_get_and_ioremap_resource()
Date:   Mon, 14 Aug 2023 17:52:37 +0100
Message-Id: <20230814165252.93422-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
References: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <frank.li@vivo.com>

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/stm32-romem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvmem/stm32-romem.c b/drivers/nvmem/stm32-romem.c
index 38d0bf557129..0f84044bd1ad 100644
--- a/drivers/nvmem/stm32-romem.c
+++ b/drivers/nvmem/stm32-romem.c
@@ -196,8 +196,7 @@ static int stm32_romem_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->base = devm_ioremap_resource(dev, res);
+	priv->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-- 
2.25.1

