Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938917B47B1
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 15:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbjJANpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 09:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235068AbjJANpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 09:45:36 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA78107
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 06:45:30 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9ae3d7eb7e0so470716366b.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 06:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696167929; x=1696772729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F4mpp0HTqoMB98qe9eiYEXks5rNRdwSriBgWOGd0HtU=;
        b=HsxThKK5cuHz7Wwoe9bFRX6PmzcY0yvEXPv0GMqyoPCLMfv5o8VZO2W9/pzJUA4byo
         jQuD2AyCRhu6Uh6vq0VXubsi4nswpAvnRz0lj3E57I3PB4ITLrJsTjyUjJRwg+xkfdgt
         Zz0/+CWJAP/tMjdRbUvExn9Bovcn6G3mZKKvKxQtoe3e8zCWOev1yHVVU+2uiq/XsAfV
         3uAcQclzXKUAc2y/9a73oBshEDDHT5y4bD1zXbRhSRr3a20Fakd8nCT5r24cjjXJqAG2
         yzl9pyoMWgFGjYcfKiOHcSfMyLQutMrgvI8tQ5JaHEI5Q8W1Pz1u+TiMJqnJHyIo+pIG
         iR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696167929; x=1696772729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4mpp0HTqoMB98qe9eiYEXks5rNRdwSriBgWOGd0HtU=;
        b=kyoUajQp7oL2+B4yrEWOzQNOxp8AkqAAvNMdzaSpEagWnCHDNQoTFNQThUDe77JjGx
         JuzkPMUGPjn8wWQqxcUzzzh8WSdCWrl1iZzdxPHY9yTGNB0VHd2fvJcTG7eGT+pEbDHO
         4KK8/LDtEzjFCHXAPXniICzCyyxBXiRWV5NJRBMgLJVgoGgzMllDzXTf2lbQGZ7yjWP1
         W1mJUsS9FCssw44M6r/X+VeE5O1Rg5czOKTyzSDU5S2YSnVIkjxN6uGaGQZlXbrwrAKs
         9DXFH03uQf1vmo2wlLiyZj+shnvIO6/sYisrAsK6eI2GeMh4n4ir8SslWTYDjHgK5NFO
         2X+A==
X-Gm-Message-State: AOJu0YyX4EqkDnrujizdGMjAYIM6BlNgPwL8lvydI81Ltto3m097gSjE
        qYPg7W87rmYqM30eHiSyrww=
X-Google-Smtp-Source: AGHT+IGNkNqp55500Dar/9Z/ljUObrvuldAHFjlgKHrcz54z7M5xcd0kE8B6BUbPJYEtmdXyb+UF7g==
X-Received: by 2002:a17:906:2ce:b0:9ae:3f76:1091 with SMTP id 14-20020a17090602ce00b009ae3f761091mr6844214ejk.0.1696167928880;
        Sun, 01 Oct 2023 06:45:28 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id bn23-20020a170906c0d700b0099cd1c0cb21sm15429750ejb.129.2023.10.01.06.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 06:45:28 -0700 (PDT)
Date:   Sun, 1 Oct 2023 15:45:27 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] staging: rtl8192e: Remove r8192_private_handler
 _rtl92e_wx_force_reset()
Message-ID: <8447643122088ff03dab65ac15e5e5199603008d.1696165351.git.philipp.g.hortmann@gmail.com>
References: <cover.1696165351.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696165351.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove r8192_private_handler _rtl92e_wx_force_reset() as driver does not
reset. Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c |  3 ---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h |  1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c   | 18 +-----------------
 3 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 2b91c481df93..c4688c273f4b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -754,7 +754,6 @@ static void _rtl92e_init_priv_variable(struct net_device *dev)
 	priv->rfa_txpowertrackingindex = 0;
 	priv->rfc_txpowertrackingindex = 0;
 	priv->cck_pwr_enl = 6;
-	priv->force_reset = false;
 	memset(priv->rtllib->swcamtable, 0, sizeof(struct sw_cam_table) * 32);
 	priv->rx_ctr = 0;
 	priv->rtllib->wx_set_enc = 0;
@@ -1130,8 +1129,6 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 		check_reset_cnt = 3;
 	}
 	spin_unlock_irqrestore(&priv->tx_lock, flags);
-
-	priv->force_reset = false;
 }
 
 static void _rtl92e_watchdog_timer_cb(struct timer_list *t)
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 0ebebb3c2c35..deb707dfa443 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -371,7 +371,6 @@ struct r8192_priv {
 
 	u16		tx_counter;
 	u16		rx_ctr;
-	bool		force_reset;
 	bool		force_lps;
 };
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index 17e7fcc01f70..ec09066f2f32 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -141,19 +141,6 @@ static int _rtl92e_wx_set_rawtx(struct net_device *dev,
 	return ret;
 }
 
-static int _rtl92e_wx_force_reset(struct net_device *dev,
-				  struct iw_request_info *info,
-				  union iwreq_data *wrqu, char *extra)
-{
-	struct r8192_priv *priv = rtllib_priv(dev);
-
-	mutex_lock(&priv->wx_mutex);
-
-	priv->force_reset = *extra;
-	mutex_unlock(&priv->wx_mutex);
-	return 0;
-}
-
 static int _rtl92e_wx_adapter_power_status(struct net_device *dev,
 					   struct iw_request_info *info,
 					   union iwreq_data *wrqu, char *extra)
@@ -1060,9 +1047,6 @@ static const struct iw_priv_args r8192_private_args[] = {
 	}, {
 		SIOCIWFIRSTPRIV + 0x2,
 		IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0, "rawtx"
-	}, {
-		SIOCIWFIRSTPRIV + 0x3,
-		IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0, "forcereset"
 	}, {
 		SIOCIWFIRSTPRIV + 0x6,
 		IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, IW_PRIV_TYPE_NONE,
@@ -1089,7 +1073,7 @@ static iw_handler r8192_private_handler[] = {
 	(iw_handler)_rtl92e_wx_set_debug,   /*SIOCIWSECONDPRIV*/
 	(iw_handler)_rtl92e_wx_set_scan_type,
 	(iw_handler)_rtl92e_wx_set_rawtx,
-	(iw_handler)_rtl92e_wx_force_reset,
+	(iw_handler)NULL,
 	(iw_handler)NULL,
 	(iw_handler)NULL,
 	(iw_handler)_rtl92e_wx_adapter_power_status,
-- 
2.42.0

