Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C887E8A51
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 11:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjKKKm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 05:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjKKKms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 05:42:48 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67A144BA
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 02:42:45 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9df8d0c2505so585437266b.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 02:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1699699364; x=1700304164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKRsMdTRp52wX/RfOne0bAjVlYqKCb2FkmXxuvgSsdI=;
        b=DJl/s2fuQIIcozKl54nfpJuDneZJxL4Lrr891YmgCslA9lVF/SYCZuK9pailC1wRRN
         lWc5XmA2AXfltpSjbNB+UWIwer9WItEtSxZH6uOP1/jQ77Bl2hhTjoNTA4xWfxOxsOaH
         WVBDYizY2Z52is4+NnEpgxNxTlF9WfSXCVWCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699699364; x=1700304164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gKRsMdTRp52wX/RfOne0bAjVlYqKCb2FkmXxuvgSsdI=;
        b=itZwVWXkXnxTSDqECYHUp9Q7DSC99mMytIAlbmo3kn24QmHDrTJO4zm0VPOsMDJNjF
         fezuD/tg/ANcmTF4sV1x1aZsxc6z+2jtnLmkYYq/Rt7rcGR1eaAyFxORcNRxsENQ4aX3
         zL+EDKqLguG1s1TrnNTsdoFvPMueLBxb6iCPgBUEko2yI4cMaJBN9kv86ynQ1K7JLwY8
         G6H0vblTtNWhjR047wTNw3S4Rt8wYGpdcyHLzpzNwdL7PAruyCBjDDHuotFvxvKpk3je
         icyulJhrwxdc68t655TqfFWpoKLxfMbWTLjXHJ+oZ3mvCZ7IlcGLfDC3Lr1XAJaqsQ7L
         IbkA==
X-Gm-Message-State: AOJu0Yz3H+7c0KAXPc2Yd8WUho6UduncLmjG7+vV1Z20jT1WeVnO62JL
        YLYmwIniifFAwIp0biAs2yIWrFp7G0jbzASA8hhMNA==
X-Google-Smtp-Source: AGHT+IEJbLdVs0JW+jcGlc8xPQxdZhfaKGnEyX/Ga6OBU0qyC2zAkwbXYZvVAliT6vWUL6mEDi9zyw==
X-Received: by 2002:a17:906:4e4d:b0:9ba:8ed:ea58 with SMTP id g13-20020a1709064e4d00b009ba08edea58mr1653246ejw.30.1699699364258;
        Sat, 11 Nov 2023 02:42:44 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-20-97-182.retail.telecomitalia.it. [79.20.97.182])
        by smtp.gmail.com with ESMTPSA id ga33-20020a1709070c2100b0099e12a49c8fsm872183ejc.173.2023.11.11.02.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 02:42:43 -0800 (PST)
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
Subject: [PATCH 06/10] fbdev: imxfb: drop ftrace-like logging
Date:   Sat, 11 Nov 2023 11:41:55 +0100
Message-ID: <20231111104225.136512-7-dario.binacchi@amarulasolutions.com>
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

WARNING: Unnecessary ftrace-like logging - prefer using ftrace

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/video/fbdev/imxfb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index de1434069530..83497f6998f1 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -694,8 +694,6 @@ static int imxfb_init_fbinfo(struct platform_device *pdev)
 	struct imxfb_info *fbi = info->par;
 	struct device_node *np;
 
-	pr_debug("%s\n",__func__);
-
 	info->pseudo_palette = devm_kmalloc_array(&pdev->dev, 16,
 						  sizeof(u32), GFP_KERNEL);
 	if (!info->pseudo_palette)
-- 
2.42.0

