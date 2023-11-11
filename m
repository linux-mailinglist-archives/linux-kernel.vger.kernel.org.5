Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DF87E8A4E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 11:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjKKKmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 05:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjKKKmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 05:42:44 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6096A3C07
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 02:42:40 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id a640c23a62f3a-9e1fb7faa9dso458237366b.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 02:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1699699357; x=1700304157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eutcu8nha5gIvSO1Nw/orY10THf/Z0yjX5SxOR1EIyg=;
        b=ONatCP+NCjimx7glVaUqlVQ1ccgIpvANjCL1+dniTAcpHf0/dDPx1lvfu8g8QnQfus
         PglkSM7SxDlHi3rMtUarf7m0UJBvQ2lL3yJ6Hjr5Zzbp6pn6Qkm7eT1LCK+YiIm0IspF
         owGlYdVDDr+VxNWkxLBIPVFmpsgOCZ6WaYypw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699699357; x=1700304157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eutcu8nha5gIvSO1Nw/orY10THf/Z0yjX5SxOR1EIyg=;
        b=o2zb6eScYxhPLxYg77AGqCa6iDtarfmaK8v3YJw87UX4kI6nm9KlXUv2nN3yA6/YX9
         idpE67JB+r8Jv1FA0SnwPqtGAjNZrq+teCIWQbz2ZCExxuJ6vz3M0Va8p9Y/gdcNkY5+
         900E0FALxAAxiTw+yH3ia7f6oQg0c0htUe5FMh/hDHipKv40pmLUqOjtd28jT+x43HfX
         F6E4RxWmcUMdLTFDSy4RWyZ4JlmjtUZjwlYAB+ylCOA2Ff3wJ0GvxXEhfPNP52MMaQKx
         Wo9CNsST9BvCA3bVnywcutf1fEdZvgHu857Qi6kfUbjDOaToEJAPCQKrmbQenMZ9jUNy
         44NA==
X-Gm-Message-State: AOJu0YywzVCYgOBxfHaVx6CvkpyJgMApXOfXR56Zv7H+K3aS/vTCyo4h
        acEtxnncSfAVSNs8Db3ZfhoddZ1FrMUXFu2a/sycBy1n
X-Google-Smtp-Source: AGHT+IFaeH1R8CrvRx8lpT+f3/8b10gmDt0Mv/InNxCSXdSMqZkc1Dynsl2CrxZY/kuNg5o1BYLkuA==
X-Received: by 2002:a17:906:4742:b0:9bf:4915:22ca with SMTP id j2-20020a170906474200b009bf491522camr1072967ejs.45.1699699357215;
        Sat, 11 Nov 2023 02:42:37 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-20-97-182.retail.telecomitalia.it. [79.20.97.182])
        by smtp.gmail.com with ESMTPSA id ga33-20020a1709070c2100b0099e12a49c8fsm872183ejc.173.2023.11.11.02.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 02:42:36 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-amarula@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Fabio Estevam <festevam@gmail.com>,
        Helge Deller <deller@gmx.de>, Martin Kaiser <martin@kaiser.cx>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 01/10] fbdev: imxfb: fix left margin setting
Date:   Sat, 11 Nov 2023 11:41:50 +0100
Message-ID: <20231111104225.136512-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231111104225.136512-1-dario.binacchi@amarulasolutions.com>
References: <20231111104225.136512-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous setting did not take into account the CSTN mode.
For the H_WAIT_2 bitfield (bits 0-7) of the LCDC Horizontal Configuration
Register (LCDCR), the IMX25RM manual states that:

In TFT mode, it specifies the number of SCLK periods between the end of
HSYNC and the beginning of OE signal, and the total delay time equals
(H_WAIT_2 + 3) of SCLK periods.
In CSTN mode, it specifies the number of SCLK periods between the end of
HSYNC and the first display data in each line, and the total delay time
equals (H_WAIT_2 + 2) of SCLK periods.

The patch handles both cases.

Fixes: 4e47382fbca9 ("fbdev: imxfb: warn about invalid left/right margin")
Fixes: 7e8549bcee00 ("imxfb: Fix margin settings")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/video/fbdev/imxfb.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index 84201c9608d3..7042a43b81d8 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -42,6 +42,7 @@
 #include <video/videomode.h>
 
 #define PCR_TFT		(1 << 31)
+#define PCR_COLOR	(1 << 30)
 #define PCR_BPIX_8	(3 << 25)
 #define PCR_BPIX_12	(4 << 25)
 #define PCR_BPIX_16	(5 << 25)
@@ -150,6 +151,12 @@ enum imxfb_type {
 	IMX21_FB,
 };
 
+enum imxfb_panel_type {
+	PANEL_TYPE_MONOCHROME,
+	PANEL_TYPE_CSTN,
+	PANEL_TYPE_TFT,
+};
+
 struct imxfb_info {
 	struct platform_device  *pdev;
 	void __iomem		*regs;
@@ -157,6 +164,7 @@ struct imxfb_info {
 	struct clk		*clk_ahb;
 	struct clk		*clk_per;
 	enum imxfb_type		devtype;
+	enum imxfb_panel_type	panel_type;
 	bool			enabled;
 
 	/*
@@ -444,6 +452,13 @@ static int imxfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 	if (!is_imx1_fb(fbi) && imxfb_mode->aus_mode)
 		fbi->lauscr = LAUSCR_AUS_MODE;
 
+	if (imxfb_mode->pcr & PCR_TFT)
+		fbi->panel_type = PANEL_TYPE_TFT;
+	else if (imxfb_mode->pcr & PCR_COLOR)
+		fbi->panel_type = PANEL_TYPE_CSTN;
+	else
+		fbi->panel_type = PANEL_TYPE_MONOCHROME;
+
 	/*
 	 * Copy the RGB parameters for this display
 	 * from the machine specific parameters.
@@ -596,6 +611,7 @@ static int imxfb_activate_var(struct fb_var_screeninfo *var, struct fb_info *inf
 {
 	struct imxfb_info *fbi = info->par;
 	u32 ymax_mask = is_imx1_fb(fbi) ? YMAX_MASK_IMX1 : YMAX_MASK_IMX21;
+	u8 left_margin_low;
 
 	pr_debug("var: xres=%d hslen=%d lm=%d rm=%d\n",
 		var->xres, var->hsync_len,
@@ -604,6 +620,13 @@ static int imxfb_activate_var(struct fb_var_screeninfo *var, struct fb_info *inf
 		var->yres, var->vsync_len,
 		var->upper_margin, var->lower_margin);
 
+	if (fbi->panel_type == PANEL_TYPE_TFT)
+		left_margin_low = 3;
+	else if (fbi->panel_type == PANEL_TYPE_CSTN)
+		left_margin_low = 2;
+	else
+		left_margin_low = 0;
+
 #if DEBUG_VAR
 	if (var->xres < 16        || var->xres > 1024)
 		printk(KERN_ERR "%s: invalid xres %d\n",
@@ -611,7 +634,7 @@ static int imxfb_activate_var(struct fb_var_screeninfo *var, struct fb_info *inf
 	if (var->hsync_len < 1    || var->hsync_len > 64)
 		printk(KERN_ERR "%s: invalid hsync_len %d\n",
 			info->fix.id, var->hsync_len);
-	if (var->left_margin < 3  || var->left_margin > 255)
+	if (var->left_margin < left_margin_low  || var->left_margin > 255)
 		printk(KERN_ERR "%s: invalid left_margin %d\n",
 			info->fix.id, var->left_margin);
 	if (var->right_margin < 1 || var->right_margin > 255)
@@ -637,7 +660,7 @@ static int imxfb_activate_var(struct fb_var_screeninfo *var, struct fb_info *inf
 
 	writel(HCR_H_WIDTH(var->hsync_len - 1) |
 		HCR_H_WAIT_1(var->right_margin - 1) |
-		HCR_H_WAIT_2(var->left_margin - 3),
+		HCR_H_WAIT_2(var->left_margin - left_margin_low),
 		fbi->regs + LCDC_HCR);
 
 	writel(VCR_V_WIDTH(var->vsync_len) |
-- 
2.42.0

