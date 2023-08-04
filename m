Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA60F76FFB8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 13:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjHDLvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 07:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjHDLv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 07:51:28 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE4A126;
        Fri,  4 Aug 2023 04:51:27 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bba2318546so17287795ad.1;
        Fri, 04 Aug 2023 04:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691149887; x=1691754687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EpCoMosoIXOO1/gDhVlRe3nSdzU9AxF1CUsvfhuvl64=;
        b=Q+yg1h+AqmExFO6I6PkkJXrz9I9Q0PZyKNpQsaP5rDr7Yp2ajIjHjOxLY1wIktXqzL
         8ovTZi9IZViFTdNhfs1tzTNtnjrJIRji390eUIhUU0AyRIghbjY7PbBvTTlOC1NjVmiy
         Spt3ki4F0evyXTOXxIJnRUe7P3e6bgdj/W/s7qUOVmtlWnCbgSu5rkMRgIoOY5G69lQG
         BrwBmcUnl6/Vhe2Pod6t6yKtH7tjzFqZ1JOYu8/11D2QRCaZGf0//ROoBQEGMm8LyArY
         PSivE6WHV3zUUnOc6Cosa9OD/JQQYPSEWNe2CDi+bQkxF0FxETe34gnMgi25hFftMi5e
         OhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691149887; x=1691754687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EpCoMosoIXOO1/gDhVlRe3nSdzU9AxF1CUsvfhuvl64=;
        b=J4Tw9PMrsYUuLEi2SaIv8a8jTTyZ7J6skcl5qObc2tiFDkfoXqTiRwBrxwL3qkAS7j
         LnhvzEhjpJYH8TA+v+VakSQevTPxeIJRxtrT+ef3sXIXXzJBGIF3tlyRJT7NT2weHI8R
         8aeGbeuNr8FGBqbxt0d177MlemF1mQER0FySxgClMFr+6b5d2qyQYQrb66ZAapn43nlX
         /Cf6tNXhP9aMGW0MQh8kr2Djcim7tDlxtkY1u4+fyv8Fn2vrDXMPjo6TW19/gS4z1mVG
         gblbm5lmG+yNrFhpQ0Eh0DGvo6u00A1shFDJQvJyzzO89IlEJauPg+vZ4Huhp6fIwbwv
         HzaA==
X-Gm-Message-State: AOJu0YzPtq/UDdu01KbHni/ZQS8AM+Lvq9BUA0eLGSx1ll0hBm9/Ay9f
        16/cB4aWX0/htnKObhWdsLq50BJm3Rs=
X-Google-Smtp-Source: AGHT+IH8TzRuRlHcKcXfFTrYBjw0CCIesfPCEfbmWNWXvGmi6iSEXk400b8aRkLxVaP8Yf4nSuGW5g==
X-Received: by 2002:a17:903:41c1:b0:1b1:9233:bbf5 with SMTP id u1-20020a17090341c100b001b19233bbf5mr1811114ple.57.1691149887016;
        Fri, 04 Aug 2023 04:51:27 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c2:1022:c939:1859:30f6:c95a:3e44])
        by smtp.gmail.com with ESMTPSA id je19-20020a170903265300b001b9dab0397bsm1587773plb.29.2023.08.04.04.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 04:51:26 -0700 (PDT)
From:   coolrrsh@gmail.com
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Rajeshwar R Shinde <coolrrsh@gmail.com>
Subject: [PATCH 1/2] fixes warning
Date:   Fri,  4 Aug 2023 17:21:20 +0530
Message-Id: <20230804115121.34035-1-coolrrsh@gmail.com>
X-Mailer: git-send-email 2.25.1
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

From: Rajeshwar R Shinde <coolrrsh@gmail.com>

drivers/spi/spi-mpc512x-psc.c:493:5-13:
WARNING: Unsigned expression compared with zero: mps -> irq < 0

Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>
---
 drivers/spi/spi-mpc512x-psc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index 99aeef2..50a4f31 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -490,7 +490,7 @@ static int mpc512x_psc_spi_of_probe(struct platform_device *pdev)
 		(struct mpc512x_psc_fifo *)(tempp + sizeof(struct mpc52xx_psc));
 
 	mps->irq = platform_get_irq(pdev, 0);
-	if (mps->irq < 0)
+	if ((int)mps->irq < 0)
 		return mps->irq;
 
 	ret = devm_request_irq(dev, mps->irq, mpc512x_psc_spi_isr, IRQF_SHARED,
-- 
2.25.1

