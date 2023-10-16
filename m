Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7897CB467
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbjJPUPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjJPUPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:15:39 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0D6A1;
        Mon, 16 Oct 2023 13:15:37 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9b95622c620so875009966b.0;
        Mon, 16 Oct 2023 13:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697487336; x=1698092136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWwYlaRFlBZNOnbwWi1D/5pxIeYnW6pCz+TmV2noCe8=;
        b=R6rP9ylEpy3OYeD4M2BSLE4sdX5fayYuA4m1CHcYNuqvl8PP8DRwMQepQyCxRzq2s0
         f2DJfe94Y0c4eSKPgxhwAPGq1upxd+30qy+sM7/IilDCxlx31188uSYfM4fPMohycR/w
         quwHhT36B/VjSU5BHt1ziR1koOxhY8skJcP2ZrVGtqSs4OKhCBSJduY2LdACLtmtNNGg
         nHlOgOC+kOkViMZvf8u/n2SP/LzfI+QTCmOSKjzH8lZ/EUqlCy/s6dX2Wy26cdjwySYW
         s7A36gnpYehSVFBIbd++Tn69LX5l7cwVwwiaXrvrEdX02XW5j3bvaCKiEhCPmvHp1EEl
         StEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697487336; x=1698092136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWwYlaRFlBZNOnbwWi1D/5pxIeYnW6pCz+TmV2noCe8=;
        b=GScyY+hnX1jekHrdO/g4lrn1K/uBG9WEED3B+FiIsmvLt1TftK96+ypontwsH3Z2DT
         IfnS51b2uNkmBQHk8XMalUgHlG71wf3wztC/ozWsAYBE6tBGmHbB5Ipv5n30prk7P/We
         oTDCTApR6/qU7nloA72j/TS8l9jEMIA7R2K4KmQYrYNkwoaMGtGONMYL6laKQ92/5hvA
         aEm3XBwZw+DpIgtiyTwvg75ZkvAumi6S1oW97UcZuBH+Lk3JdOEi+IfKeK+olI5iLyPd
         2xiIJRV0gcnEyGYMq0J5hITvEuai/bQzstvPUquVtcG0ODy4EgRfJW3N42eYtrkscqH5
         SL1g==
X-Gm-Message-State: AOJu0YxOPtlDwbs7gg6ePoOYVVT3fpV36kU1LAcJB+O/xxo+/w1MLPdG
        evVTIQD3Wq891MEciYhJqg==
X-Google-Smtp-Source: AGHT+IGJSdPocqhPOmarYwovWzPyDfGeS8QtO/7KpgvqKud+6g2Ztpv0Xa9D1qNWuY2xtlBrHYcGGg==
X-Received: by 2002:a17:907:2d12:b0:9c3:e66e:2006 with SMTP id gs18-20020a1709072d1200b009c3e66e2006mr101565ejc.9.1697487335730;
        Mon, 16 Oct 2023 13:15:35 -0700 (PDT)
Received: from dorcaslitunya-virtual-machine.localdomain ([105.163.1.143])
        by smtp.gmail.com with ESMTPSA id u26-20020a17090657da00b009b97521b58bsm4606055ejr.39.2023.10.16.13.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 13:15:35 -0700 (PDT)
From:   Dorcas AnonoLitunya <anonolitunya@gmail.com>
Cc:     anonolitunya@gmail.com, outreachy@lists.linux.dev,
        julia.lawall@inria.fr, dan.carpenter@linaro.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] Staging: sm750fb: Rename displayControlAdjust_SM750E
Date:   Mon, 16 Oct 2023 23:14:08 +0300
Message-ID: <20231016201434.7880-2-anonolitunya@gmail.com>
X-Mailer: git-send-email 2.42.0.345.gaab89be2eb
In-Reply-To: <20231016201434.7880-1-anonolitunya@gmail.com>
References: <20231016201434.7880-1-anonolitunya@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename function displayControlAdjust_SM750E to
display_control_adjust_SM750E. This follows snakecase naming convention
and ensures a consistent naming style throughout the file. Issue found by
checkpatch.

Mutes the following error:
CHECK:Avoid CamelCase: <displayControlAdjust_SM750E>

Signed-off-by: Dorcas AnonoLitunya <anonolitunya@gmail.com>
---
 drivers/staging/sm750fb/ddk750_mode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index e00a6cb31947..8708995f676c 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -14,8 +14,8 @@
  * in bit 29:27 of Display Control register.
  */
 static unsigned long
-displayControlAdjust_SM750LE(struct mode_parameter *pModeParam,
-			     unsigned long dispControl)
+display_control_adjust_SM750LE(struct mode_parameter *pModeParam,
+			       unsigned long dispControl)
 {
 	unsigned long x, y;
 
@@ -125,7 +125,7 @@ static int programModeRegisters(struct mode_parameter *pModeParam,
 			tmp |= DISPLAY_CTRL_HSYNC_PHASE;
 
 		if (sm750_get_chip_type() == SM750LE) {
-			displayControlAdjust_SM750LE(pModeParam, tmp);
+			display_control_adjust_SM750LE(pModeParam, tmp);
 		} else {
 			reg = peek32(CRT_DISPLAY_CTRL) &
 				~(DISPLAY_CTRL_VSYNC_PHASE |
-- 
2.42.0.345.gaab89be2eb

