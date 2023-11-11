Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF637E8A5C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 11:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjKKKnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 05:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjKKKm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 05:42:57 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571734687
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 02:42:51 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53df747cfe5so4666563a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 02:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1699699369; x=1700304169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57XfclRA1DPTjEGTeta8gbvZTvGhPeSww56J1vwZoGA=;
        b=bqRVzsokysWOjTYqiiyzz63kLTJ12L/yQx9u0AoEXyg3teldFilGzA6jx9bjpv9PCd
         8LHXBX6yxFrCkOVfFOU4DIIT/aM1is3JoeApWBvzi8KYjpdsfavhvdc4gI9WWsM4Aqcm
         yoTOvWWWGCaiJmHWLZ/gZBA+60j2PYWk/w/bQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699699369; x=1700304169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57XfclRA1DPTjEGTeta8gbvZTvGhPeSww56J1vwZoGA=;
        b=GjFUAbKlzf9sQZ0q2eqkrFDFRUBbEfQK9/mN5dxcX3721EAQ3iv6ojY6irTAXVbhkC
         FrtSfoqdbsxbEppyMHLghZReNTzdcdxCyuCsXa+63XSkQsvM03FJ9DpqsdkwDhM22ijQ
         wzvOLL+Hq6w5SGfrEw5fhlYd5j9yczsLQ60hApzYqHcTW7SPjAeqldpGRuiBN20aqQOe
         p/ZbDteIPX2UH4J4vN81wOL6KUihdR//AuiURkdtBsUCitf+KhxzHT3LpEdkOp9Hih6f
         oCOOvFclbklrW3WmqMEsNY4dGCuwN9PAdi82bCRf8VElZayftuKgr8lJpPADJ2cuukgF
         iHwA==
X-Gm-Message-State: AOJu0YwsXR1RcprHV8MtkXVeOKR2Nv8u6Ul0QdWfzXvUQyTCkERTbBRK
        z4T9Yqz4VLxDQGy60X6/9BHTPaCDMlqjhpXD+MGCyw==
X-Google-Smtp-Source: AGHT+IF51sz/9Eym2oiwu4zOU3bpJ1pg92NvUM3b8/mDpd88MUL1wczf210dAwnnzyMpQ5H7XMHxcg==
X-Received: by 2002:a17:906:361a:b0:9dd:bd42:4ec2 with SMTP id q26-20020a170906361a00b009ddbd424ec2mr908050ejb.10.1699699369457;
        Sat, 11 Nov 2023 02:42:49 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-20-97-182.retail.telecomitalia.it. [79.20.97.182])
        by smtp.gmail.com with ESMTPSA id ga33-20020a1709070c2100b0099e12a49c8fsm872183ejc.173.2023.11.11.02.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 02:42:49 -0800 (PST)
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
Subject: [PATCH 10/10] fbdev: imxfb: add '*/' on a separate line in block comment
Date:   Sat, 11 Nov 2023 11:41:59 +0100
Message-ID: <20231111104225.136512-11-dario.binacchi@amarulasolutions.com>
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

Linux kernel coding style uses '*/' on a separate line at the end of
multi line comments.

Fix block comments by moving '*/' at the end of block comments on a
separate line as reported by checkpatch:

WARNING: Block comments use a trailing */ on a separate line

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 drivers/video/fbdev/imxfb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index 8d6943f0bfca..a4dbc72f93c3 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -946,8 +946,10 @@ static int imxfb_probe(struct platform_device *pdev)
 	if (ret)
 		goto failed_init;
 
-	/* Calculate maximum bytes used per pixel. In most cases this should
-	 * be the same as m->bpp/8 */
+	/*
+	 * Calculate maximum bytes used per pixel. In most cases this should
+	 * be the same as m->bpp/8
+	 */
 	m = &fbi->mode[0];
 	bytes_per_pixel = (m->bpp + 7) / 8;
 	for (i = 0; i < fbi->num_modes; i++, m++)
-- 
2.42.0

