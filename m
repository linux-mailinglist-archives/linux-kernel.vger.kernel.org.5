Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B88D7E8A59
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 11:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjKKKnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 05:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjKKKmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 05:42:52 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D254699
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 02:42:48 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso459501866b.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 02:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1699699367; x=1700304167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXZvMG+ePha/xCPPyQSZcW7mIHQVo6pfDhdFQ8Ys4tc=;
        b=UNBvDhYAIRvg6gLaB/0hwwz+OB45vtUOomtc0ASMSf/2BNtOy+ib2yl+sBpspCqFrm
         adlfglJ/YKksfbBEOmmqC9u6aqHUp2Z12RNs5IQ5s34jFhoEXEyBwIvNprrc8IE0JSvg
         IGGYWW9UB1N334JsuA0OcMXucQcGfw+drl+Yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699699367; x=1700304167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uXZvMG+ePha/xCPPyQSZcW7mIHQVo6pfDhdFQ8Ys4tc=;
        b=L6N9Fl8g5TD4aiE6kzon9kKuTjY24x360EY1M5frKTc9MqbMMhyyUePmbU+pHiK7tn
         qCm/2ZOuoQe+CLkm9WHeE+ugdAYnq2uIq2IXervdggrZVFGawrWV3EpsHDVfOaBHfZ9z
         xUyc3O3rJmY0CUEbL+IRrB9qFk7Ci8+PuCrEPtbCjHfJyUbXcOKFdDm92Yj5TvwVWSbj
         6ohv2NpA1AxiIM3VdF9tBXOykdSV8fDGJZpw6MvBxSGFt1llKGwgzchwg974Jqaxbp/t
         lxA8GG2smBQBtjf0+aTqCUfB1AUENtJd5aDefeDvrUkhs8tCj9JADaVyJaVenK7SibR8
         aFoQ==
X-Gm-Message-State: AOJu0YwrXjEGbIHPy2p1iZki+7s1PePOekmmoamm+0+fK02K2+/s0h/5
        07R8NlrGiVEsaDgdWqe1xQdhWvZZCQed819hkeUyXqKc
X-Google-Smtp-Source: AGHT+IGJZcFy9OdyadzV+Qr9dejIzMtNTDEhCcEQriAhe7EtSGvFTDpXzYmEJXyYAtgH1pYC278gVQ==
X-Received: by 2002:a17:906:fa9b:b0:9dd:6664:1a3a with SMTP id lt27-20020a170906fa9b00b009dd66641a3amr1013488ejb.51.1699699366905;
        Sat, 11 Nov 2023 02:42:46 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-20-97-182.retail.telecomitalia.it. [79.20.97.182])
        by smtp.gmail.com with ESMTPSA id ga33-20020a1709070c2100b0099e12a49c8fsm872183ejc.173.2023.11.11.02.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 02:42:46 -0800 (PST)
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
Subject: [PATCH 08/10] fbdev: imxfb: Fix style warnings relating to printk()
Date:   Sat, 11 Nov 2023 11:41:57 +0100
Message-ID: <20231111104225.136512-9-dario.binacchi@amarulasolutions.com>
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

Resolve the following warning reported by checkpatch:

WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...

This made it necessary to move the 'fbi->pdev = pdev' setting to the
beginning of the driver's probing.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/video/fbdev/imxfb.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index ad293dc44dbb..a0172ff75c46 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -414,8 +414,8 @@ static int imxfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 
 	if (--pcr > PCR_PCD_MASK) {
 		pcr = PCR_PCD_MASK;
-		printk(KERN_WARNING "Must limit pixel clock to %luHz\n",
-				lcd_clk / pcr);
+		dev_warn(&fbi->pdev->dev, "Must limit pixel clock to %luHz\n",
+			 lcd_clk / pcr);
 	}
 
 	switch (var->bits_per_pixel) {
@@ -628,28 +628,28 @@ static int imxfb_activate_var(struct fb_var_screeninfo *var, struct fb_info *inf
 
 #if DEBUG_VAR
 	if (var->xres < 16        || var->xres > 1024)
-		printk(KERN_ERR "%s: invalid xres %d\n",
+		dev_err(&fbi->pdev->dev, "%s: invalid xres %d\n",
 			info->fix.id, var->xres);
 	if (var->hsync_len < 1    || var->hsync_len > 64)
-		printk(KERN_ERR "%s: invalid hsync_len %d\n",
+		dev_err(&fbi->pdev->dev, "%s: invalid hsync_len %d\n",
 			info->fix.id, var->hsync_len);
 	if (var->left_margin < left_margin_low  || var->left_margin > 255)
-		printk(KERN_ERR "%s: invalid left_margin %d\n",
+		dev_err(&fbi->pdev->dev, "%s: invalid left_margin %d\n",
 			info->fix.id, var->left_margin);
 	if (var->right_margin < 1 || var->right_margin > 255)
-		printk(KERN_ERR "%s: invalid right_margin %d\n",
+		dev_err(&fbi->pdev->dev, "%s: invalid right_margin %d\n",
 			info->fix.id, var->right_margin);
 	if (var->yres < 1 || var->yres > ymax_mask)
-		printk(KERN_ERR "%s: invalid yres %d\n",
+		dev_err(&fbi->pdev->dev, "%s: invalid yres %d\n",
 			info->fix.id, var->yres);
 	if (var->vsync_len > 100)
-		printk(KERN_ERR "%s: invalid vsync_len %d\n",
+		dev_err(&fbi->pdev->dev, "%s: invalid vsync_len %d\n",
 			info->fix.id, var->vsync_len);
 	if (var->upper_margin > 63)
-		printk(KERN_ERR "%s: invalid upper_margin %d\n",
+		dev_err(&fbi->pdev->dev, "%s: invalid upper_margin %d\n",
 			info->fix.id, var->upper_margin);
 	if (var->lower_margin > 255)
-		printk(KERN_ERR "%s: invalid lower_margin %d\n",
+		dev_err(&fbi->pdev->dev, "%s: invalid lower_margin %d\n",
 			info->fix.id, var->lower_margin);
 #endif
 
@@ -701,6 +701,7 @@ static int imxfb_init_fbinfo(struct platform_device *pdev)
 
 	memset(fbi, 0, sizeof(struct imxfb_info));
 
+	fbi->pdev = pdev;
 	fbi->devtype = pdev->id_entry->driver_data;
 
 	strscpy(info->fix.id, IMX_NAME, sizeof(info->fix.id));
@@ -1044,7 +1045,6 @@ static int imxfb_probe(struct platform_device *pdev)
 	lcd->props.max_contrast = 0xff;
 
 	imxfb_enable_controller(fbi);
-	fbi->pdev = pdev;
 
 	return 0;
 
-- 
2.42.0

