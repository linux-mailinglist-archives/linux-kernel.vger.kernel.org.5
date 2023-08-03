Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F261676E5D7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbjHCKl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbjHCKly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:41:54 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599FF2109
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 03:41:53 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bf9252eddso118135766b.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 03:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691059311; x=1691664111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2ZZ+1993PFiL9vsimGluFZaqdjZxW6PFOZVirQWnu4c=;
        b=lLN4YasPvfDXyEsqgmXjcwmqwQmCsCs6i2izgRd8p9asCAmMCWdYd6Kqn8HMQ97wFY
         l4E2VJQktKJ17M61ReFUR377fse+rqflWcc1PrHifsdxdjdWR660eBbUoxQc1UpJf1rx
         7o6uKGqe0qKfAqhL/PzHUtoNUjdE8ow3G2S+Q0d0ODofzSVWG2V0Up7DLl2PsV1GrHNj
         wtgMeyZ8oG41648pPQJlpJZQDhaXxgvOIJnNGgGK5dhaDRnOQqK05y5B4yZ8iVJFTdwC
         qQhH503S3ABu+S3eFojY9O2jYMQiFXSCst6GznJBuEGK7FgET8ORa3YP99zJvEMpuuY+
         VowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691059311; x=1691664111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ZZ+1993PFiL9vsimGluFZaqdjZxW6PFOZVirQWnu4c=;
        b=dSMTzraInlI7/syxW33P3Aen6ApGqhLQd4R/msBLpNLY3KKPx1PkvqS/cnI76A5hBl
         7lmeouE1dG4q6Ig6kYvIYSRLbIpfq4kGnEDLWbIpfbuZumWpCqdwbUyyp9/7kR/EpFVl
         xEaq2WXnHowoi3kw6XuUmA7tYgal41JN/3tcK7GHhoWZIXUTpzudZGQjzsCpNBMrXo/7
         D4n1PfFcpSij9H/amA3FZ+VgiSMcejg2rBlGGDLa5BUNNGkE1Jj5l9T5oNUV86Sl+95W
         +ZxcF/8X5Bt4rg0Uz8Mgha7SVWFyx9s0etjoRWJghPeLICahAFpYX/LvVZIENk7qkXmn
         1koQ==
X-Gm-Message-State: ABy/qLbruKQPAvg9+yJ5B4KQKZ80bQn/pu9cSX3bEg4sEwJqGYtgtsfr
        gZwdrIjyZYOAJ2syh1OYlI+JKJuQBynn0g==
X-Google-Smtp-Source: APBJJlEjB15fiXHkbVNtqsWOeFH7FesBMOnIDR97ydxYfBVrc04dYg5Ds1hkUtY3/7FJfRoDqBjZlA==
X-Received: by 2002:a17:906:10ca:b0:992:42d4:a7dc with SMTP id v10-20020a17090610ca00b0099242d4a7dcmr7678471ejv.21.1691059311571;
        Thu, 03 Aug 2023 03:41:51 -0700 (PDT)
Received: from localhost.localdomain ([78.97.234.98])
        by smtp.gmail.com with ESMTPSA id i10-20020a170906250a00b009931baa0d44sm10466582ejb.140.2023.08.03.03.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 03:41:51 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     p.zabel@pengutronix.de, Andrei Coardos <aboutphysycs@gmail.com>,
        Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH] reset: bcm6345: remove unneeded call to platform_set_drvdata()
Date:   Thu,  3 Aug 2023 13:41:42 +0300
Message-Id: <20230803104142.29694-1-aboutphysycs@gmail.com>
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
platform_get_drvdata() call to access the private data of the driver. Also,
the private data is defined in this driver, so there is no risk of it being
accessed outside of this driver file.

Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>
Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
---
 drivers/reset/reset-bcm6345.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/reset/reset-bcm6345.c b/drivers/reset/reset-bcm6345.c
index ac6c7ad1deda..aa9353439e70 100644
--- a/drivers/reset/reset-bcm6345.c
+++ b/drivers/reset/reset-bcm6345.c
@@ -102,8 +102,6 @@ static int bcm6345_reset_probe(struct platform_device *pdev)
 	if (!bcm6345_reset)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, bcm6345_reset);
-
 	bcm6345_reset->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(bcm6345_reset->base))
 		return PTR_ERR(bcm6345_reset->base);
-- 
2.34.1

