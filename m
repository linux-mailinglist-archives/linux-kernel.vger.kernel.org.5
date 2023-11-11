Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CC47E8A5B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 11:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjKKKnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 05:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjKKKmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 05:42:55 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3C746A6
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 02:42:49 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9db6cf8309cso457396066b.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 02:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1699699368; x=1700304168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fPpjqbZXDXnwfpqh3sU0UKiF5sG/PgBCsBX0KBupbI=;
        b=qqa01oJEJHpp9rHoh5vg7Qq1KNdMCp9dlgvZF2IS1Gh2tY56HgjH54JcSQfIoJ0txd
         rieCF/lk+6uM2wQ2U8WhhURh6kTFbCasRFjc4fOCBHCRPUIGw6Z2ir5aXoo/mTLqyPl/
         /Gz5VEeW+XobZguHmXCHMEnK1lLx5uZYEVc+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699699368; x=1700304168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0fPpjqbZXDXnwfpqh3sU0UKiF5sG/PgBCsBX0KBupbI=;
        b=gHx+t8RKyk+EVD8yTtq0mbd5lZqd1288rISvhCHx6fQnjxAueBCCk2bGGN2ZO1ucqm
         5x5wl/F2PCavFLGMk8zlz+0PrPRVEa5mRVYjP7PxubfAlXGMvhah6EF2jHLP22S3k7u1
         zZ0Q2AUnXXAtyk9LnC7/VLCMrHkqgNFE4z3ZAFvAbqY0lGfaH1LSnSjxlrsFedpYzC/C
         dklwvCVaPFhh0CJa6FQ//jlF19SJUbNmyDdkckReIHBpbn47WAQ3m9tpb5mdmlLysuNY
         AMrhFzwf2d0Iq8SLOPPXoGtgPxlIKOl1aWnMtpwLjaiJZLl+Y+KFduy5sAtIk8Lc+O3r
         7ZKw==
X-Gm-Message-State: AOJu0Yz46R3RqEIzkSw0iuaPK6yx+0gtzMVrUnqtVV/nKm8+6WvRt5d7
        v6aeplaykHtgirImCtKsTwRNQJgOcUeTHrfAR5prVA==
X-Google-Smtp-Source: AGHT+IHstjBS6znxzWZl5i2bWmEodHYLi43ulh4NK9b9RQW7CPLRH4hNONaMe+WD/i4AMw1LubUCfA==
X-Received: by 2002:a17:906:f247:b0:9d2:bf19:88aa with SMTP id gy7-20020a170906f24700b009d2bf1988aamr1056461ejb.59.1699699368178;
        Sat, 11 Nov 2023 02:42:48 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-20-97-182.retail.telecomitalia.it. [79.20.97.182])
        by smtp.gmail.com with ESMTPSA id ga33-20020a1709070c2100b0099e12a49c8fsm872183ejc.173.2023.11.11.02.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 02:42:47 -0800 (PST)
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
Subject: [PATCH 09/10] fbdev: imxfb: use __func__ for function name
Date:   Sat, 11 Nov 2023 11:41:58 +0100
Message-ID: <20231111104225.136512-10-dario.binacchi@amarulasolutions.com>
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

WARNING: Prefer using '"%s...", __func__' to using 'imxfb_blank', this function's name, in a string

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/video/fbdev/imxfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index a0172ff75c46..8d6943f0bfca 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -576,7 +576,7 @@ static int imxfb_blank(int blank, struct fb_info *info)
 {
 	struct imxfb_info *fbi = info->par;
 
-	pr_debug("imxfb_blank: blank=%d\n", blank);
+	pr_debug("%s: blank=%d\n", __func__, blank);
 
 	switch (blank) {
 	case FB_BLANK_POWERDOWN:
-- 
2.42.0

