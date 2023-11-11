Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA55C7E8A54
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 11:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjKKKnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 05:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjKKKmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 05:42:49 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8CE9F
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 02:42:46 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9e5dd91b0acso267640666b.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 02:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1699699361; x=1700304161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZuBW6agG70lIoCkGnVCWEFfcl6uwNB9B1+pa2Yxc8Go=;
        b=j9/uP+Xdw1Pq1sOD1h6jzT5RhRDbh7QbdYHMsw0DFpoZJwoJziQuHef1h0jrjFE5O1
         WjTyTx93aPwRDuSOGHMq/qIRSEQUQOSX0FT8FN7o3TEEwNMqp+hVKAuUdAMbRJL2g5LJ
         qWjxsbHnyCLi610M+A9iCZdBac+AZ/WG/hXQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699699361; x=1700304161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZuBW6agG70lIoCkGnVCWEFfcl6uwNB9B1+pa2Yxc8Go=;
        b=dRPtwYiDkn+22ccF2fKDOfpy8En5QQFW1BuoAt6N+3Z2K48XewC6GCzLayXRIHuIP/
         pse2X5eVp9h5zkToPpsNOIqNM5VsCkJnn1CXnIXgZmP/vt+8pjVjJPrBXNLt4wer6P69
         KIqEhZ7LnghxD5ZFHJvXK3icOQ9UrOKmPU4kzko6qGuhWpxYY9yX5Oaa1CJJibR2BT+V
         OIqn5thBqesw8SbKNpyObP5boSJY6WN7DvN6/BI2XfcdZDApF3bPKA1aBXdAxWdqvbd0
         MhaBUWG1bJz/WQATYCJGDbixMiVxGgqabbQnw8VNWayS0ezZc1rVvvSg2GQ0Cr4UtM9n
         dJFQ==
X-Gm-Message-State: AOJu0Yw/wTZr/YOmj2GsZzcKP5zHoweJCLxWogoE+xbddu5BQ7R9dPv2
        4tU43MhhpPbArmyqVJjWAyi5ygkhtbJl26of23cScQ==
X-Google-Smtp-Source: AGHT+IFbVhFnBfDEfeThETUmx79l/FqCUdUKdBP1kZUSVO8UVeOwurpqW+LCgtJFLlAn08avd0DyXw==
X-Received: by 2002:a17:906:3c9:b0:9e6:59d5:7a86 with SMTP id c9-20020a17090603c900b009e659d57a86mr915376eja.57.1699699361285;
        Sat, 11 Nov 2023 02:42:41 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-20-97-182.retail.telecomitalia.it. [79.20.97.182])
        by smtp.gmail.com with ESMTPSA id ga33-20020a1709070c2100b0099e12a49c8fsm872183ejc.173.2023.11.11.02.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 02:42:41 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-amarula@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Fabio Estevam <festevam@gmail.com>,
        Helge Deller <deller@gmx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 04/10] fbdev: imxfb: replace some magic numbers with constants
Date:   Sat, 11 Nov 2023 11:41:53 +0100
Message-ID: <20231111104225.136512-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231111104225.136512-1-dario.binacchi@amarulasolutions.com>
References: <20231111104225.136512-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch gets rid of magic numbers replacing them with appropriate
macros.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/video/fbdev/imxfb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index b7ef43a7930a..485e57fa9389 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -89,6 +89,7 @@ struct imx_fb_videomode {
 #define PCR_BPIX_12	4
 #define PCR_BPIX_16	5
 #define PCR_BPIX_18	6
+#define PCR_PCD_MASK	GENMASK(5, 0)
 
 #define LCDC_HCR	0x1C
 #define HCR_H_WIDTH_MASK	GENMASK(31, 26)
@@ -414,8 +415,8 @@ static int imxfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 
 	pcr = (unsigned int)tmp;
 
-	if (--pcr > 0x3F) {
-		pcr = 0x3F;
+	if (--pcr > PCR_PCD_MASK) {
+		pcr = PCR_PCD_MASK;
 		printk(KERN_WARNING "Must limit pixel clock to %luHz\n",
 				lcd_clk / pcr);
 	}
@@ -444,7 +445,7 @@ static int imxfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 	}
 
 	/* add sync polarities */
-	pcr |= imxfb_mode->pcr & ~(0x3f | (7 << 25));
+	pcr |= imxfb_mode->pcr & ~(PCR_PCD_MASK | PCR_BPIX_MASK);
 
 	fbi->pcr = pcr;
 	/*
-- 
2.42.0

