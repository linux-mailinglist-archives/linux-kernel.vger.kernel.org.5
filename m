Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC2876E5D5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235360AbjHCKlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbjHCKlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:41:15 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1FF2109
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 03:41:14 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-522382c4840so1004922a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 03:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691059273; x=1691664073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gU6VUAZZ0sIjL4b4ZPVJ9XR6xLN5ROpJfb1snbabqgQ=;
        b=NW00WG0wO6M4drM7zfuvTPP52kJobU4OMJeabuhygxkdg+xdvIhiwVNQSX5kXiz3Fu
         Yd+fpRcxwzuFTorYIie99Vy+F1PGv1ya9XmzzfCcumhhCnyeaSpYrV9ZfuMFhSJwm0QE
         REUFJFC37Z1EOhP1gk8xZlPvx3OY5QCPZYLzjqW6dkeH0aUVK88Wr6SxrbQ8IM6uT6I4
         HQOqWvvgWCXviaKJZr0f5HcT+oGXyJFWg3ESST5gJKqYrdy3Wxd8pSG+sVHLrgf3/HX0
         IS5qh261JUWTP0QjtAPtRoeOKhQhYmKMdiDco9TiQQE7uQ2jV4ywiOxcklUSvzOkN9C6
         CAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691059273; x=1691664073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gU6VUAZZ0sIjL4b4ZPVJ9XR6xLN5ROpJfb1snbabqgQ=;
        b=jrafFgFOAKV8gytCodsWu6v9Eoqt8UjXtj7/OqdsBW+mbUxap7qbTm2gJqY4GGwlqq
         U4e1BEHOaRu0QhCQk0zYCCxsLR1ClizWUQ+IFjgJ7MdLfOi02IFkjX7hHB7ZBScd8E7M
         950tMQRo/C2rk1dFD3yZuHnnA72R6awsAE2iZTilwFJEwWWAdI1h1at/GivuSJlxVFnr
         xcWMaltXn+KJOZDJltttHrymapaSlbLLJGcYhluxDm6pgYQTjJlalzoaIbi6spdYbSxu
         wRxB8P0072XYC2xZ1MRt2LrEFmbKnlv4V10gL+cjYM/JjkRc8CN/VXcE9GIDWkExQ5Zu
         eleg==
X-Gm-Message-State: AOJu0Yy7Wj5/rRO3Mimebx8HBVghIFl60iPfIBo5tvHsoMi8K+11R2KZ
        X0jynBx0VnVrdabeGu9j0Yu8+9hx/8/gGQ==
X-Google-Smtp-Source: AGHT+IEGAPmomRoeQkh3mTAp7g5zssu6IHyxmaCIvB6NvM2gIZJQiY99DqvmBQ6KUgkMXyhCMhtXFQ==
X-Received: by 2002:a50:ed93:0:b0:523:e2b:3245 with SMTP id h19-20020a50ed93000000b005230e2b3245mr1050348edr.21.1691059272584;
        Thu, 03 Aug 2023 03:41:12 -0700 (PDT)
Received: from localhost.localdomain ([78.97.234.98])
        by smtp.gmail.com with ESMTPSA id q25-20020a056402033900b0052286e8dee1sm9926660edw.76.2023.08.03.03.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 03:41:12 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     p.zabel@pengutronix.de, Andrei Coardos <aboutphysycs@gmail.com>,
        Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH] reset: ath79: remove unneeded call to platform_set_drvdata()
Date:   Thu,  3 Aug 2023 13:41:02 +0300
Message-Id: <20230803104102.29647-1-aboutphysycs@gmail.com>
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
 drivers/reset/reset-ath79.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/reset/reset-ath79.c b/drivers/reset/reset-ath79.c
index a8b8f5ea77ec..b5d620132052 100644
--- a/drivers/reset/reset-ath79.c
+++ b/drivers/reset/reset-ath79.c
@@ -93,8 +93,6 @@ static int ath79_reset_probe(struct platform_device *pdev)
 	if (!ath79_reset)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, ath79_reset);
-
 	ath79_reset->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ath79_reset->base))
 		return PTR_ERR(ath79_reset->base);
-- 
2.34.1

