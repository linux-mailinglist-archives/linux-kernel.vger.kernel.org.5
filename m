Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3327E8A56
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 11:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjKKKnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 05:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjKKKmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 05:42:50 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49C63C15
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 02:42:47 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9c3aec5f326so808483466b.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 02:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1699699365; x=1700304165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDgHYbXQcqXOi8pgjjCFs89msy5Cd5Tn06zlqflQDL0=;
        b=pZLxDQfMMPGoJyHV3OuLrZpModlaTSVAMJ6G4Yo/kxPSZnPrMk/VXJwu2ssgffb+/R
         Zj6FZ4L5uFUpR7kJ5+J6jz90hBCKjL8V5+J7y+8ESBStJelNwX3xnNk50kG5mhupnd6j
         kfELC3UYqRTaQ/LRCGjEhrCOrqFVghNwlP2c4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699699365; x=1700304165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IDgHYbXQcqXOi8pgjjCFs89msy5Cd5Tn06zlqflQDL0=;
        b=AlmulAz1BfWonc8H/w04Vu5mIpL7yU17fDBvrEbpVzro0UJu7S2laO25dMd6tyxP0s
         N7GEn//+YrTAJag3MV8VBZ/SVwkBmIBZS5WXtdgks74jyi+Vwpbkp+k9GrGocFp75mAX
         07kkwXAlD3qhrxrythOgySpm7fWL7ct0cM0WlFQTxFALP2I/X/DHjxD451rGrWiIyQci
         D+W1dEwigHCcDyTV533bz41iJuGcQfzzpwnmS7SP0bktz+2FX9YIARJL8OpaI8IpUCGs
         8zAqJ6qSD8V8SRu5AZ8iimfvBLcNEi66iS98Xd/7mFczJj07ol+oqpUlFSJSKQaCTjY0
         2ivg==
X-Gm-Message-State: AOJu0YwqbynfepGbfVlZbORLYIQtL62pEXm1lhnaNqOCwuBDcSCGL/68
        Er575BhCtJM6yhcQOnZPYy2myc+5XhyFUPPpBx4QxA==
X-Google-Smtp-Source: AGHT+IGWjzXZAnVOpqEeTHo29O9vwepCgThZZ6Cih0GL59Twpo4NVs/EaN2y7j4ks3a/O63PR8CCEA==
X-Received: by 2002:a17:906:80c4:b0:9ae:50ec:bd81 with SMTP id a4-20020a17090680c400b009ae50ecbd81mr4311227ejx.21.1699699365597;
        Sat, 11 Nov 2023 02:42:45 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-20-97-182.retail.telecomitalia.it. [79.20.97.182])
        by smtp.gmail.com with ESMTPSA id ga33-20020a1709070c2100b0099e12a49c8fsm872183ejc.173.2023.11.11.02.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 02:42:45 -0800 (PST)
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
Subject: [PATCH 07/10] fbdev: imxfb: add missing spaces after ','
Date:   Sat, 11 Nov 2023 11:41:56 +0100
Message-ID: <20231111104225.136512-8-dario.binacchi@amarulasolutions.com>
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

Fix the following checkpatch error:

ERROR: space required after that ',' (ctx:VxV)

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/video/fbdev/imxfb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index 83497f6998f1..ad293dc44dbb 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -280,10 +280,10 @@ static int imxfb_setpalettereg(u_int regno, u_int red, u_int green, u_int blue,
 	struct imxfb_info *fbi = info->par;
 	u_int val, ret = 1;
 
-#define CNVT_TOHW(val,width) ((((val)<<(width))+0x7FFF-(val))>>16)
+#define CNVT_TOHW(val, width) ((((val)<<(width))+0x7FFF-(val))>>16)
 	if (regno < fbi->palette_size) {
 		val = (CNVT_TOHW(red, 4) << 8) |
-		      (CNVT_TOHW(green,4) << 4) |
+		      (CNVT_TOHW(green, 4) << 4) |
 		      CNVT_TOHW(blue,  4);
 
 		writel(val, fbi->regs + 0x800 + (regno << 2));
-- 
2.42.0

