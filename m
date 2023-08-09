Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C6D77643C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbjHIPmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbjHIPmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:42:35 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA37E7F;
        Wed,  9 Aug 2023 08:42:35 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fe167d4a18so65595665e9.0;
        Wed, 09 Aug 2023 08:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691595753; x=1692200553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OyZNEgArShADQF9PvMzNpSn4eyGg1gUeWUuFAHYPIIc=;
        b=U2G50LDm2r3hBiOOTBh+mEYkReDXT9VmOUo8QvYZDTsYxdt3A3HrUzdH4u9yYaD2to
         2Eyl+/A13HoPXcDYgC9XXf7J4f0w4Iu5wGyaf/He4O/PSu1ZBkCSX9eBx6xvy9l3UgN8
         wIvfJZQJ7v7JKtejHBgBiWz7LemS+McjSGmhQPbauobiBtJcOr9jHu0gupzsZk7zq2hK
         kFko1iaJOXGd3Fg+lGcEBHanlniEx9MQpSq7i3ri4gFFNDmrZtLfTdjc7mEn/aTX0pL5
         cHGzCu0aBZqovPGa0L+l3xJU7RohXb6fICDiVKUxyaOBGgk/EQwRGOWaHenZBqk5tjXU
         hSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691595753; x=1692200553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OyZNEgArShADQF9PvMzNpSn4eyGg1gUeWUuFAHYPIIc=;
        b=bWDfX3fjGhrmX0L2TRqA709Cv/YCJk4H4MOw3P44E+tlW3oCz52IxtsKQAxxyPe7WA
         Dg/qjd+jc7aPP3XYTOGWTr/PHkvSTg/jtOzrseDRhVTIPA7xumTdxEeK5V8gTKd8syWf
         cOP5Rz8U0rZiFfayM+rStRYohsYTvj65XTHrbbaz/EzwP9AyWwqtdAFfpGcmGidytd1O
         GbUMu3/wIGklLK1WgKQNsx84rh5ss9vimHIxc2aaoBEWPOrNbWlWf6DYJVKcPLjaJbLx
         JXERal4fLQ9BgVEz3kMA9aR2xkINNfg/MMflNpNc5B5VrLdAsrY+M1EC3qKuPn6UUnDX
         kq6Q==
X-Gm-Message-State: AOJu0Yze3ICmQhiggfWOjmJv9WLcvXLvgwuQ90T+dDEfLiaRsyxXNAtF
        nzBmy0vpsnrtF1xJ4Jg70JbTXrMxChRxsw==
X-Google-Smtp-Source: AGHT+IE6f00sGS03vtl8WnoLUu/HwU4lXGGrrbsBQ9ZtumkQc2d4KbMY8YJWW9U6q2xkdTVxwRbYAQ==
X-Received: by 2002:a1c:790d:0:b0:3fe:4e4e:beeb with SMTP id l13-20020a1c790d000000b003fe4e4ebeebmr2627300wme.38.1691595753349;
        Wed, 09 Aug 2023 08:42:33 -0700 (PDT)
Received: from localhost.localdomain ([92.85.190.61])
        by smtp.gmail.com with ESMTPSA id f21-20020a1c6a15000000b003fc02218d6csm2296527wmc.25.2023.08.09.08.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 08:42:32 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-tegra@vger.kernel.org, ac100@lists.launchpad.net
Cc:     gregkh@linuxfoundation.org, marvin24@gmx.de, alex@shruggie.ro,
        Andrei Coardos <aboutphysycs@gmail.com>
Subject: [PATCH] staging: nvec: paz00: remove unneeded call to platform_set_drvdata()
Date:   Wed,  9 Aug 2023 18:42:11 +0300
Message-Id: <20230809154211.15741-1-aboutphysycs@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
 drivers/staging/nvec/nvec_paz00.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/nvec/nvec_paz00.c b/drivers/staging/nvec/nvec_paz00.c
index 55d59840fca4..9c01c51f0ab5 100644
--- a/drivers/staging/nvec/nvec_paz00.c
+++ b/drivers/staging/nvec/nvec_paz00.c
@@ -53,8 +53,6 @@ static int nvec_paz00_probe(struct platform_device *pdev)
 	led->cdev.flags |= LED_CORE_SUSPENDRESUME;
 	led->nvec = nvec;
 
-	platform_set_drvdata(pdev, led);
-
 	ret = devm_led_classdev_register(&pdev->dev, &led->cdev);
 	if (ret < 0)
 		return ret;
-- 
2.34.1

