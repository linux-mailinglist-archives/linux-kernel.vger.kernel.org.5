Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2747E8A40
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 11:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjKKKmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 05:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjKKKmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 05:42:43 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1F03AA6
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 02:42:40 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9e5dd91b0acso267637466b.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 02:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1699699358; x=1700304158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cv+Nw99h5TQ+ZdPAOUHCJ7Is/AuyKPzv38qwm03SYTY=;
        b=iUVTib7IJ4nhaswszUcXNqeDYfL9gea5rmO66MPg09zFniiYdl8zeNd7NL/UI0WXr3
         kLBahdPopN5Tgd9pCNTkFE0JUd4OpJhp8WN0DGjLxLu26Q66OgCXa9a+4CUbZhXBu+nG
         2Frn8VH7h/uX9zsEua2SXecMfxyNoAku+QdO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699699358; x=1700304158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cv+Nw99h5TQ+ZdPAOUHCJ7Is/AuyKPzv38qwm03SYTY=;
        b=TDb9C7qldkwVJY/EH8aK7MlHwWMw+kv/XE2lg5V1Z4Pz2KaYuJzvNGsDUwg3QYrkCL
         xcRbu6Z8rripTHFNrzZzJSkMJHJkI20XduaGEVMN12YWbAwFYGxhkNRpdWrgqDBgBKZ/
         xHAqAVgxRdBycx6hcwMpCg6tuEClNQzljYmxI5KphWtsSlpPTUoXFCzX3OWYwLiPnhmv
         Aynyo+mAWMZF6D8PWBEcMwEHe8wUPBjz1Z97uCyzTdOiQ5jTGBM+8z9JHV8KJM8fw9UW
         74uNCmNuFx/wOPwd0G2oGtn9bdiW7E9IETgObwaFH1cJ1MBa9E8C2RYEj4pvPkJJMB+C
         EtQg==
X-Gm-Message-State: AOJu0Yxqc/Ts/puMfF1hrD7MiLIqqY5SVVMUvAN3qYrHnsOXFN6moGu7
        ng3f9Iw1L9BILSssoHPle5NgPdBOKO2K+EC0X2fibw==
X-Google-Smtp-Source: AGHT+IGV/oLH/5lcH7sOkoekG3D+ekNeJmSBIhCHEhoX0aYsTwH02HKUCdbRojD3+VixFTGso1kIJg==
X-Received: by 2002:a17:906:fc0a:b0:9e0:5d5c:aa81 with SMTP id ov10-20020a170906fc0a00b009e05d5caa81mr1063698ejb.27.1699699358600;
        Sat, 11 Nov 2023 02:42:38 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-20-97-182.retail.telecomitalia.it. [79.20.97.182])
        by smtp.gmail.com with ESMTPSA id ga33-20020a1709070c2100b0099e12a49c8fsm872183ejc.173.2023.11.11.02.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 02:42:38 -0800 (PST)
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
Subject: [PATCH 02/10] fbdev: imxfb: move PCR bitfields near their offset
Date:   Sat, 11 Nov 2023 11:41:51 +0100
Message-ID: <20231111104225.136512-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231111104225.136512-1-dario.binacchi@amarulasolutions.com>
References: <20231111104225.136512-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch moves the bitfields of the PCR register near the macro that
defines its offset, just like for all the other registers.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/video/fbdev/imxfb.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index 7042a43b81d8..6af5f09d9c85 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -41,13 +41,6 @@
 #include <video/of_videomode.h>
 #include <video/videomode.h>
 
-#define PCR_TFT		(1 << 31)
-#define PCR_COLOR	(1 << 30)
-#define PCR_BPIX_8	(3 << 25)
-#define PCR_BPIX_12	(4 << 25)
-#define PCR_BPIX_16	(5 << 25)
-#define PCR_BPIX_18	(6 << 25)
-
 struct imx_fb_videomode {
 	struct fb_videomode mode;
 	u32 pcr;
@@ -88,6 +81,12 @@ struct imx_fb_videomode {
 #define LCDC_LCHCC	0x14
 
 #define LCDC_PCR	0x18
+#define PCR_TFT		(1 << 31)
+#define PCR_COLOR	(1 << 30)
+#define PCR_BPIX_8	(3 << 25)
+#define PCR_BPIX_12	(4 << 25)
+#define PCR_BPIX_16	(5 << 25)
+#define PCR_BPIX_18	(6 << 25)
 
 #define LCDC_HCR	0x1C
 #define HCR_H_WIDTH(x)	(((x) & 0x3f) << 26)
-- 
2.42.0

