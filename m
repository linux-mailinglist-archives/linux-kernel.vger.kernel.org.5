Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D1B7B47AB
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 15:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235035AbjJANpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 09:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235007AbjJANpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 09:45:01 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90895B8
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 06:44:57 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9ae3d4c136fso419575266b.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 06:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696167896; x=1696772696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WHEL4ZALe3kNObgKSEfdRhrWQpcI6CZqiH24RXB1Qgs=;
        b=ShLYEdisgxR8pGlw+Xm4zwb5vSGvxg2xmai3ta4Z913qe1UQV3BH9yo/L/kIVWv7NU
         iRCQMoeASHRPpfuroPqU3+dG5Y7tlWUMHONSexSOwS6bz9OMzrqtr+ZqfRhYO0ues5GQ
         Hfm5Q57y/VV1vxhuxa6uCrFiHHZGwpbNx/RGun9C9m2YeP/pFRP52Bfh/zSP3rq31FRR
         HMDY0GEHvURakurhW9fkeo6kkGt78rF1UshFjQzv4CMiqrl9nN4Ktpl9qtlorqX8NdT6
         e1v3YYUj8EY/yidR8/JOin/sXQCgFk/9iPZXw2ilf3hDqwlEMogt6x1RoaE3Z4JmS9sm
         oJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696167896; x=1696772696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHEL4ZALe3kNObgKSEfdRhrWQpcI6CZqiH24RXB1Qgs=;
        b=mYW5uZx9JlA7+ZKGInof0zcrm3qxQ8KDJn2V0uZVlCeIQ3XuShmxG6/ArXdaDXS/Yl
         t/9cPyps/YiOMHNwxJwQmkmqlnEYXpT79leuzzDOzXDKeoAJoqbGIydalLqhNukAkc2y
         8ShzVBI3NWM5v8QH+cjjdg54/+vbBSq+d6FVnXvikLa38HnZpAxwG8AJAW+yYdSjbcPo
         Vhtv17kCZafQ90XEhHo4JFl3N46sHMBn4rDOsMjeBjkgCiE3ZqQjr+MRkvWsKuSvu6wq
         gKmiVfl0PYKxWrFnEhkWsPaXLRW+8qyrmqIoBClRzyEBCQ7gYz9LNesTp3fKU2dyEJR8
         HTCQ==
X-Gm-Message-State: AOJu0YwlHO3aGl/xfQQG0vnUTK0S9o9napBL6OBsAmpJOgA0aPGx78b8
        XbTktQ9vs7dyQyumFigAHsE=
X-Google-Smtp-Source: AGHT+IHJsItI5qF7EHosVw7+KaqcorDCR6RAGP01XLgG4SDc3FBapzAv2L7WbSwVUtQngUO66Byy5Q==
X-Received: by 2002:a17:906:74d4:b0:9ad:dfe7:b361 with SMTP id z20-20020a17090674d400b009addfe7b361mr6959767ejl.5.1696167895946;
        Sun, 01 Oct 2023 06:44:55 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id j8-20020a170906050800b009934855d8f1sm15380208eja.34.2023.10.01.06.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 06:44:55 -0700 (PDT)
Date:   Sun, 1 Oct 2023 15:44:54 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] staging: rtl8192e: Remove unused variable
 reset_in_progress
Message-ID: <25259d69b955472a74725f3665238fb6daee76b4.1696165351.git.philipp.g.hortmann@gmail.com>
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

priv->reset_in_progress is set to false and never changed. All
equations result accordingly. Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 6 ++----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c   | 5 -----
 3 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 7ca6a04d034c..9da858510211 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -1132,7 +1132,6 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 	spin_unlock_irqrestore(&priv->tx_lock, flags);
 
 	priv->force_reset = false;
-	priv->reset_in_progress = false;
 }
 
 static void _rtl92e_watchdog_timer_cb(struct timer_list *t)
@@ -1218,8 +1217,7 @@ static void _rtl92e_hard_data_xmit(struct sk_buff *skb, struct net_device *dev,
 				    MAX_DEV_ADDR_SIZE);
 	u8 queue_index = tcb_desc->queue_index;
 
-	if ((priv->rtllib->rf_power_state == rf_off) || !priv->up ||
-	     priv->reset_in_progress) {
+	if ((priv->rtllib->rf_power_state == rf_off) || !priv->up) {
 		kfree_skb(skb);
 		return;
 	}
@@ -1252,7 +1250,7 @@ static int _rtl92e_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	if (queue_index != TXCMD_QUEUE) {
 		if ((priv->rtllib->rf_power_state == rf_off) ||
-		     !priv->up || priv->reset_in_progress) {
+		     !priv->up) {
 			kfree_skb(skb);
 			return 0;
 		}
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 855bee78c674..fa5d0eec90d3 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -372,7 +372,6 @@ struct r8192_priv {
 
 	u16		tx_counter;
 	u16		rx_ctr;
-	bool		reset_in_progress;
 	bool		force_reset;
 	bool		force_lps;
 };
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 561ea68de56a..fd5228e7a462 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -530,11 +530,6 @@ static void _rtl92e_dm_tx_power_tracking_callback_tssi(struct net_device *dev)
 			if (Pwr_Flag == 0) {
 				mdelay(1);
 
-				if (priv->reset_in_progress) {
-					rtl92e_writeb(dev, Pw_Track_Flag, 0);
-					rtl92e_writeb(dev, FW_Busy_Flag, 0);
-					return;
-				}
 				if (priv->rtllib->rf_power_state != rf_on) {
 					rtl92e_writeb(dev, Pw_Track_Flag, 0);
 					rtl92e_writeb(dev, FW_Busy_Flag, 0);
-- 
2.42.0

