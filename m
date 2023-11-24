Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256247F857E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 22:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbjKXVae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 16:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbjKXVaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 16:30:25 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6383F1BD2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 13:30:27 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54373788ec4so551602a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 13:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700861425; x=1701466225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yWJ0nXVb1bOTAnFt8TBwH1+zkjpEMLZEr+/8w0q7iWk=;
        b=jEbUvEBw2KcIcLVtimgIJ8MmTgXSwMQQgvJa38KmjfXqc4kLOyvIP9Y6fWbZcbRrlc
         +4s7KsRdtCpUMyCciS//MDfYgvZ1J4b2VTN3wlhU9ifoCY55bPCB+qJNeyRjXRujmg/E
         toHlXxOxf/kTTijwtvyVB1ReXP7YBSl1FsCOeOQ5ZimG5Vmd930ikXJGCSSPLpIIXWyS
         mRElomaufGjY03boC5gqpW6ySGPpfPvZDUSsqoD2EsLfnnWJSJSuEVev/EPw44PdJGpz
         xyjLdWJUbfeWI74wIys0in0ah2yPgkMBExOjXv1Cez3vJ8VFu78cJwRUlx98dZ7zLHo4
         xlSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700861425; x=1701466225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWJ0nXVb1bOTAnFt8TBwH1+zkjpEMLZEr+/8w0q7iWk=;
        b=gvFVw1/5nKK0se2Y7tHsUu2Xwkgz9vchSD39fAr0ODNBDZrKiO9pRveSsMfKkpoVPo
         Niby+bdOba3oj/vsVXkamPcPwTrIKFu6eaikb2THHp9EyiGVKQMiA3mbGyMAurW2BlzQ
         8gm8cKvH2SIOy596KrcpFo+EjD4VaeYtPxRd+FxY4i7gbmE38PWC+4GxS0qAI1xQd+p/
         wsTPP3U/eOI6TRKfk5PMTndDM7MTcmnwXHKThmam72Wb0RY5QTzrFcOlARyKmxQHOBrF
         cR1TVfhsst6SJlrDQhFSlZjhYTxe5fZVs44iaGjE8dCcscNuqamVJyjj1lOzYPGctFwG
         cTDg==
X-Gm-Message-State: AOJu0Yx0ZuQKt1Ek1YmS5U3FgmoZT5F88ffa8przMZFzDu5XEHWu1x1g
        cz7a8pSrT1osJ75PXio2A14=
X-Google-Smtp-Source: AGHT+IHmiEyndG8fPfAOadU1BbBZ66/E8F65iYc+ddfSmrclkAjyvW2GZQV2LvgeDPSu7oEPl9SBAQ==
X-Received: by 2002:a05:6402:f18:b0:54b:1f3:344c with SMTP id i24-20020a0564020f1800b0054b01f3344cmr2177455eda.2.1700861425221;
        Fri, 24 Nov 2023 13:30:25 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id h14-20020aa7c94e000000b00548a57d4f7bsm2215631edt.36.2023.11.24.13.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 13:30:25 -0800 (PST)
Date:   Fri, 24 Nov 2023 22:30:23 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] staging: rtl8192e: Remove unused interrupt for IMR_BcnInt
Message-ID: <64a1f672dbe2ed2c6a660fa1044bd058fe3ba91a.1700860758.git.philipp.g.hortmann@gmail.com>
References: <cover.1700860758.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1700860758.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver does not support AP Mode therefore no beacons need to be send.
Remove unused interrupt for IMR_BcnInt.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  | 37 -------------------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h  |  1 -
 3 files changed, 1 insertion(+), 39 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 8fe4c03b19c1..73315a236e76 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1802,7 +1802,7 @@ rtl92e_init_variables(struct net_device  *dev)
 			    IMR_MGNTDOK | IMR_COMDOK | IMR_HIGHDOK |
 			    IMR_BDOK | IMR_RXCMDOK | IMR_TIMEOUT0 |
 			    IMR_RDU | IMR_RXFOVW | IMR_TXFOVW |
-			    IMR_BcnInt | IMR_TBDOK | IMR_TBDER);
+			    IMR_TBDOK | IMR_TBDER);
 
 	priv->bfirst_after_down = false;
 }
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index c3466291e221..fc6e8ea039a3 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -416,38 +416,6 @@ static int _rtl92e_handle_assoc_response(struct net_device *dev,
 	return 0;
 }
 
-static void _rtl92e_prepare_beacon(struct tasklet_struct *t)
-{
-	struct r8192_priv *priv = from_tasklet(priv, t,
-					       irq_prepare_beacon_tasklet);
-	struct net_device *dev = priv->rtllib->dev;
-	struct sk_buff *pskb = NULL, *pnewskb = NULL;
-	struct cb_desc *tcb_desc = NULL;
-	struct rtl8192_tx_ring *ring = NULL;
-	struct tx_desc *pdesc = NULL;
-
-	ring = &priv->tx_ring[BEACON_QUEUE];
-	pskb = __skb_dequeue(&ring->queue);
-	kfree_skb(pskb);
-
-	pnewskb = rtllib_get_beacon(priv->rtllib);
-	if (!pnewskb)
-		return;
-
-	tcb_desc = (struct cb_desc *)(pnewskb->cb + 8);
-	tcb_desc->queue_index = BEACON_QUEUE;
-	tcb_desc->data_rate = 2;
-	tcb_desc->ratr_index = 7;
-	tcb_desc->tx_dis_rate_fallback = 1;
-	tcb_desc->tx_use_drv_assinged_rate = 1;
-	skb_push(pnewskb, priv->rtllib->tx_headroom);
-
-	pdesc = &ring->desc[0];
-	rtl92e_fill_tx_desc(dev, pdesc, tcb_desc, pnewskb);
-	__skb_queue_tail(&ring->queue, pnewskb);
-	pdesc->OWN = 1;
-}
-
 void rtl92e_config_rate(struct net_device *dev, u16 *rate_config)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
@@ -785,8 +753,6 @@ static void _rtl92e_init_priv_task(struct net_device *dev)
 	INIT_DELAYED_WORK(&priv->rtllib->hw_sleep_wq, (void *)rtl92e_hw_sleep_wq);
 	tasklet_setup(&priv->irq_rx_tasklet, _rtl92e_irq_rx_tasklet);
 	tasklet_setup(&priv->irq_tx_tasklet, _rtl92e_irq_tx_tasklet);
-	tasklet_setup(&priv->irq_prepare_beacon_tasklet,
-		      _rtl92e_prepare_beacon);
 }
 
 static short _rtl92e_get_channel_map(struct net_device *dev)
@@ -1810,9 +1776,6 @@ static irqreturn_t _rtl92e_irq(int irq, void *netdev)
 	if (inta & IMR_ROK)
 		tasklet_schedule(&priv->irq_rx_tasklet);
 
-	if (inta & IMR_BcnInt)
-		tasklet_schedule(&priv->irq_prepare_beacon_tasklet);
-
 	if (inta & IMR_RDU) {
 		rtl92e_writel(dev, INTA_MASK,
 			      rtl92e_readl(dev, INTA_MASK) & ~IMR_RDU);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index e7b331c4661c..846f0f7a737b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -219,7 +219,6 @@ struct r8192_priv {
 
 	struct tasklet_struct		irq_rx_tasklet;
 	struct tasklet_struct		irq_tx_tasklet;
-	struct tasklet_struct		irq_prepare_beacon_tasklet;
 
 	struct mutex				wx_mutex;
 	struct mutex				rf_mutex;
-- 
2.42.0

