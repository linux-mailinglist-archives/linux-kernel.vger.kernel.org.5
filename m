Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6E57724AE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjHGMs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbjHGMs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:48:26 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4271010F7;
        Mon,  7 Aug 2023 05:48:25 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3178fa77b27so3781803f8f.2;
        Mon, 07 Aug 2023 05:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691412503; x=1692017303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QSsFFMDnhnoYvwOucI8nbfeRsF7SqpPW/TzWXV6mxlQ=;
        b=aJPpVhiiR1nJfa6ZRRn5GMPVVmiGydg5TEOZ5UY/1PgNgUfO3qqPYTmd36jFI73mB4
         nVvtw86p4Mot8yid7Rp8jTM12fSpXPuFIzdo3ZnQCELDzno16dN7+4c6bfQZoBofQ1WP
         Z1hf29r9udmDAh35ja6M5qo/yeEXV0bhkmLQnhXaHQUM02/CB6YX3G7PJ1v+kA1pR4fZ
         K2yCod3dFght/Gr8hCA0AbvNRX350FAEvU7jCvKsdBEFQ7NQOGLqd+KSdrvwMSwwd6+W
         iEAYqHM5ryuGzZLGO5PA7cytrpUc72NfH5I2Rv1t0eS/EastVyZ1pH/zaTYtJXMVL+zi
         Do7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691412503; x=1692017303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QSsFFMDnhnoYvwOucI8nbfeRsF7SqpPW/TzWXV6mxlQ=;
        b=TsgG+SWyuavf47H31UkFRHzylfsToz6x0FgBJd3lkqU3ryTuxOLuVUpa213hy37AUD
         bAqpZW9UAvCqFPBHWrYVKH6Qs5GzHOPxzllyfoBPPuQb+gY2azh3syQtkXftTLYMI49I
         7J8o5yPrmNj1ArLooGrijjgkvOeG2euh5MBKDgDKiKnNm+ncXvMYRCJYDoYV4A2sZLU3
         T0EBTotEyGUbivD+OS7AfVoiBrQaFSMADjcquTptU0mnRr6uV+BZUCbrKb0c5AdnQ9Wl
         +rxtaq5dVwc6YjeQHrjOazC3vPfJT8FZBrv9IDnAjKU4c9tVJs7PoXwZJCqOZHa49/ck
         x1Fg==
X-Gm-Message-State: AOJu0YwXb2vRq2SNYWzBGndE1kZu1pu5HDXwlMdjFghnyb+k9fuHfSX4
        FryVrLawNeMxMwthmXrWC3CCmENtz8SfxQ==
X-Google-Smtp-Source: AGHT+IFx4cs/LGcPF2+8WR9/qMwP2ZFppQ/3rUwyT0TckgNaJC/wrxFbf8HK/vf79wWlN9j1cJoxag==
X-Received: by 2002:a5d:65cc:0:b0:313:e8bf:a6e with SMTP id e12-20020a5d65cc000000b00313e8bf0a6emr6500008wrw.21.1691412503376;
        Mon, 07 Aug 2023 05:48:23 -0700 (PDT)
Received: from localhost.localdomain ([92.85.190.61])
        by smtp.gmail.com with ESMTPSA id k18-20020a5d66d2000000b0031417fd473csm10534017wrw.78.2023.08.07.05.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 05:48:22 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     alexandre.belloni@bootlin.com, a.zummo@towertech.it,
        sebastian.hesselbarth@gmail.com, gregory.clement@bootlin.com,
        andrew@lunn.ch, alex@shruggie.ro,
        Andrei Coardos <aboutphysycs@gmail.com>
Subject: [PATCH] rtc: armada38x: remove unneeded call to platform_set_drvdata()
Date:   Mon,  7 Aug 2023 15:48:11 +0300
Message-Id: <20230807124811.16763-1-aboutphysycs@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function call was found to be unnecessary as there is no equivalent
platform_get_drvdata() call to access the private data of the driver. Also,
the private data is defined in this driver, so there is no risk of it being
accessed outside of this driver file.

Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
---
 drivers/rtc/rtc-armada38x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rtc/rtc-armada38x.c b/drivers/rtc/rtc-armada38x.c
index b4139c200676..5ed028429565 100644
--- a/drivers/rtc/rtc-armada38x.c
+++ b/drivers/rtc/rtc-armada38x.c
@@ -527,7 +527,6 @@ static __init int armada38x_rtc_probe(struct platform_device *pdev)
 		dev_warn(&pdev->dev, "Interrupt not available.\n");
 		rtc->irq = -1;
 	}
-	platform_set_drvdata(pdev, rtc);
 
 	if (rtc->irq != -1)
 		device_init_wakeup(&pdev->dev, 1);
-- 
2.34.1

