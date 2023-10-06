Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E617BBF7C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 21:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbjJFTFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 15:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbjJFTFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 15:05:02 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA430BB
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 12:04:57 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-523029050d0so848431a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 12:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696619096; x=1697223896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=68/nbTks8CXo1X/QB95+J8jvFGHLP1OjPuI8hsZjNRI=;
        b=Q4OrOazgml/RsKtPvKhGrHJzFat/udzkYwjDX/RGffa2U/p9uk5w0h+JudOZzGKAvr
         gN+jMnfNVTPG+vHO8xLw0FzbTK/vxhQZXCRXXy8Z1mLhx1Usey5foJwIBJfSgQiII4fY
         IL5ez/4OZ+18yz9lDII7c6zPZR2OBDHnUKpP+tjG6o8VZV0qKvps0pbrhToGjMpxfHvx
         GFKtSwJ8MPwrz8x5y8/au25Fg098czFiURvIa3PaEeJF+4vWSqlwu2Fn3vHElkvawhGf
         Snvrqxwcbg93FLec76fPW8mArK3g9ZIcb5QVr9IS3tJvXRdT0ieLAlthayy/D1IR7psz
         L63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696619096; x=1697223896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68/nbTks8CXo1X/QB95+J8jvFGHLP1OjPuI8hsZjNRI=;
        b=wpeSe4DXTip9HjMJx9Zo5DxDkpwP1FiFmHmPde6QxA/VSCjqn6fLAXISEt46PPmSl9
         lku7thtPDXKf+q+jK2k1hgPoF1g/dxDeMvbrccyw3hbgtpR+WbOGRauubFEVWevrumoq
         CtE0hVducymeUrmcL3LqkfX0AE0SF/bib243pFBPgch0KHnETAqnCWcP8GE4BAuYf736
         /rbJNcpivQozNVc85lUjxDZNQRTFcITPXaABwCMidNvrnN0/hKv59BNexJX+fHDl8KBd
         KtNSlEgRRfB1z9JD4j6AupntYe9kr0/Vs3sHixukAUhtIgIW1mjiASh30xKqJAC+aD3o
         /sBQ==
X-Gm-Message-State: AOJu0YyqJZ1cSVluPYQGqRidTRsBrh5q0AFSLxMeIbnXpM5C1fUjxEdJ
        +bPpXMBptBr8qSwJNRHTYz4=
X-Google-Smtp-Source: AGHT+IGDAH25y+WS9bMxScDAaMkKQ7xkjm4qdz6XkggJ9HO6OwZY6UYPPnH2GZNV4sqp0xum2cSRSA==
X-Received: by 2002:a05:6402:35c2:b0:530:2bd:71b2 with SMTP id z2-20020a05640235c200b0053002bd71b2mr7460311edc.0.1696619096088;
        Fri, 06 Oct 2023 12:04:56 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id ev5-20020a056402540500b0053b67aba57bsm244120edb.17.2023.10.06.12.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 12:04:55 -0700 (PDT)
Date:   Fri, 6 Oct 2023 21:04:54 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] staging: rtl8192e: Remove constant variable
 reg_max_lps_awake_intvl
Message-ID: <d5b2ccc0f10c28f960552dd2b2c5ec83aa62041f.1696548527.git.philipp.g.hortmann@gmail.com>
References: <cover.1696548527.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696548527.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove constant variable reg_max_lps_awake_intvl as this value is just
written to MaxPeriod. Function _rtl92e_init_priv_constant() is then empty
and can be removed as well.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 10 ----------
 drivers/staging/rtl8192e/rtllib.h            |  1 -
 drivers/staging/rtl8192e/rtllib_softmac.c    |  8 +-------
 3 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index f46cb152930a..7db01d68000a 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -712,15 +712,6 @@ static void _rtl92e_init_priv_handler(struct net_device *dev)
 	priv->rtllib->ScanOperationBackupHandler = rtl92e_scan_op_backup;
 }
 
-static void _rtl92e_init_priv_constant(struct net_device *dev)
-{
-	struct r8192_priv *priv = rtllib_priv(dev);
-	struct rt_pwr_save_ctrl *psc = (struct rt_pwr_save_ctrl *)
-					&priv->rtllib->pwr_save_ctrl;
-
-	psc->reg_max_lps_awake_intvl = 5;
-}
-
 static void _rtl92e_init_priv_variable(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
@@ -838,7 +829,6 @@ static short _rtl92e_init(struct net_device *dev)
 	memset(&priv->stats, 0, sizeof(struct rt_stats));
 
 	_rtl92e_init_priv_handler(dev);
-	_rtl92e_init_priv_constant(dev);
 	_rtl92e_init_priv_variable(dev);
 	_rtl92e_init_priv_lock(priv);
 	_rtl92e_init_priv_task(dev);
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 6d54c03f5680..307bcbb7fbb6 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1079,7 +1079,6 @@ struct rt_pwr_save_ctrl {
 
 	bool				bLeisurePs;
 	u8				LpsIdleCount;
-	u8				reg_max_lps_awake_intvl;
 	u8				LPSAwakeIntvl;
 
 	u32				CurPsLevel;
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 206f8e05d5d0..f84133744bc3 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1588,16 +1588,10 @@ static short rtllib_sta_ps_sleep(struct rtllib_device *ieee, u64 *time)
 		if (ieee->bAwakePktSent) {
 			psc->LPSAwakeIntvl = 1;
 		} else {
-			u8 MaxPeriod = 1;
+			u8 MaxPeriod = 5;
 
 			if (psc->LPSAwakeIntvl == 0)
 				psc->LPSAwakeIntvl = 1;
-			if (psc->reg_max_lps_awake_intvl == 0)
-				MaxPeriod = 1;
-			else if (psc->reg_max_lps_awake_intvl == 0xFF)
-				MaxPeriod = ieee->current_network.dtim_period;
-			else
-				MaxPeriod = psc->reg_max_lps_awake_intvl;
 			psc->LPSAwakeIntvl = (psc->LPSAwakeIntvl >=
 					       MaxPeriod) ? MaxPeriod :
 					       (psc->LPSAwakeIntvl + 1);
-- 
2.42.0

