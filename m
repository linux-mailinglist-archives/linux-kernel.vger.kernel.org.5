Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAF777BE68
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjHNQxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjHNQxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:53:04 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702AC12D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:53:03 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so6115047a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692031982; x=1692636782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hV84AQgFKUheaBdQhNV6C2FJYqe1CoPa5VcMWpQTne8=;
        b=Xc/KyPcv9vL+U9DHZ2NI85pcd4+QJ3P/bqyFVslSkYZgLPr8UV9MjG/pcgK+PrZH12
         ypMjuSaA5BoNKLNjFBOqSzTyDd7lV0TTIGcdw86hBV+SGKaCE71yHlj7tpq2eJHb5HO3
         x2diuz8dCtdH0MElCjQhRmsmrcT7X31yIHCJgmXGmcmc8LXAULkq96D6dURnDAimQlcD
         Sc0LrVtnvgM3YcpQYdN28InQc+tdk8luX5X8eVaELku8hKtfVR8E6i768BKq45TnwEgQ
         jpo6vCmR+Yo5H+AgKPPvKtlTj7pRgNJtTU3uLvPaeN4S/t6111FoUyZbwl5QOqBRfsty
         x0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692031982; x=1692636782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hV84AQgFKUheaBdQhNV6C2FJYqe1CoPa5VcMWpQTne8=;
        b=ZbF14nU3bn0luJNqbC3DxeMYgUjOuvDfbvUGe3mbCE5vV5Ilyp9wrxvBxMRgC4Ixv+
         v7ekO/oGTxz4jWiX4U7pmp5YOAAmomn7Hk9Od/uTzsqlt0VJ2Rg0dRgnfURU2uKPIMGa
         H8l4d/UVj4nAToBfYNj0UET/Fyp8cGPUdjtrIWuKozjnqee939f1oer/CCcZuGdzXWg0
         yTpXdSP/7phSf3OJ88cpUgg2fWVvZPsgXEfQR8rSlPkYa3oUL5BBhD1tsoQs9IVlAFEY
         aqFVeQTSbWFendUGg7p0cY5hqpkftD8jK7HeFO6gk6R0VK5N/RlVLi4J+HIVZ5y7rJYF
         +aPA==
X-Gm-Message-State: AOJu0YxwU979Xy8cBTTHLbOlYW9iqjfO73do3IpVN20BjY3vGs/dikym
        8dUo1tc/MfpNEFyYbDuNCIXo0gJoPxCnUhyhRTs=
X-Google-Smtp-Source: AGHT+IE0LfpJJwrEtYyPCk2osiwv34tDYmDLk8mA0EAVZ1+WpR0ArqRxoODZM6lI9c/VAIjNCd83Kg==
X-Received: by 2002:aa7:da45:0:b0:523:cbc0:8d2d with SMTP id w5-20020aa7da45000000b00523cbc08d2dmr7020901eds.18.1692031982056;
        Mon, 14 Aug 2023 09:53:02 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id n5-20020aa7c785000000b0052338f5b2a4sm5811267eds.86.2023.08.14.09.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 09:53:01 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 03/22] nvmem: brcm_nvram: Use devm_platform_get_and_ioremap_resource()
Date:   Mon, 14 Aug 2023 17:52:33 +0100
Message-Id: <20230814165252.93422-4-srinivas.kandagatla@linaro.org>
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
 drivers/nvmem/brcm_nvram.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvmem/brcm_nvram.c b/drivers/nvmem/brcm_nvram.c
index 4567c597c87f..9737104f3b76 100644
--- a/drivers/nvmem/brcm_nvram.c
+++ b/drivers/nvmem/brcm_nvram.c
@@ -159,8 +159,7 @@ static int brcm_nvram_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	priv->dev = dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->base = devm_ioremap_resource(dev, res);
+	priv->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-- 
2.25.1

