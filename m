Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93C77EFE90
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 09:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbjKRIvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 03:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbjKRIv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 03:51:26 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAB510DF
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 00:51:22 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9c40c3814a8so83382966b.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 00:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700297480; x=1700902280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VjN035WLtuadTMm7LXZaDKsk+/K6gPiiTmDAIdpngNw=;
        b=G+vdkGchrx750Rla7shaxkq6xV8zkvUPuVtujRYxTe1vGdvFvRDvtCvbWOXBZi51lq
         ke8mVuCG2uC9WmgRViloKVY4SyQXb4+39SsgetPuCFg8hFCMVTE1gwHWd8GezNfu4df1
         ih6ibvN9ZelgE5+WecCk90mjrJ5lzvDde5ZiIYNKRUHyx7SH3huD2/R+bzSDGDviIBLm
         UDRXxQm0NuqZVizeyOsjOwnecy12jfe+Gd/zmoo5MY6/Qd7XIXYkTMlVVJcVe5ncBEog
         jTrwQprTL/OLasfy0pLJli91g4qtUMr5znLH3ib2q6tuQOwUBwAtgumSCJrr+NL1AUat
         Gjbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700297480; x=1700902280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjN035WLtuadTMm7LXZaDKsk+/K6gPiiTmDAIdpngNw=;
        b=NCdS4k3GrnXcOShK4eeontI8J4aR/iCQAT/8wNMuCaI/OBzeLY242rZvl6mcXqctvg
         kZOqW5R1WZL63joWZnV5c2Rha1tCTb3Y5Sg+kNDuY9aluvm8aUhyjeWbphtldNRTCIKM
         +JmsPTbhaUh//ZAFW72qWVc4Y2sZDaxXe3o/WtEYSI8U1V8O6KSWIWGsHDffTVvGRn40
         himzEacvLd79KcmbFdPt5z9RcWaSTvGFx17RdFhl69ffWmgnrRfXfdgM5u0Nfm9SbRa6
         WmkHi8uTQU7iSbeR/NJyIXrBcsrXIkq73GPDh/OGZNhsDFnOXev6hHN0vmHgITO01WwV
         Y/CQ==
X-Gm-Message-State: AOJu0Yz4ehSJq84h+q3enXlMy51hMDHPVaWvYWvh7bU54P0oBvngygyX
        28qkBirRgUNjM8Hg8IxrrCQ=
X-Google-Smtp-Source: AGHT+IG5F9h8BVeuct8xQu0rHUtQYbzO8SW40R9kkuWIu8+iTl1P1FWgTc52bIv6c7lFf8JP4z03Zw==
X-Received: by 2002:a17:906:74c1:b0:9f2:3e76:5d39 with SMTP id z1-20020a17090674c100b009f23e765d39mr1325758ejl.0.1700297480379;
        Sat, 18 Nov 2023 00:51:20 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57ba2f20.dip0.t-ipconnect.de. [87.186.47.32])
        by smtp.gmail.com with ESMTPSA id e6-20020a170906844600b009cd1fca4d68sm1658948ejy.5.2023.11.18.00.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 00:51:20 -0800 (PST)
Date:   Sat, 18 Nov 2023 09:51:18 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] staging: rtl8192e: Unwind pointer to pointer to
 rtl92e_set_channel()
Message-ID: <a96bac1f34e669a3b2fc4940a0a2d850564a5975.1700296319.git.philipp.g.hortmann@gmail.com>
References: <cover.1700296319.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1700296319.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace pointer to function to pointer to rtl92e_set_channel() with
pointer to rtl92e_set_channel(). This increases readability of the code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 13 +------------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h |  2 --
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 98b25768f614..2789f428e4f9 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -226,16 +226,6 @@ static void _rtl92e_tx_timeout(struct net_device *dev, unsigned int txqueue)
 	netdev_info(dev, "TXTIMEOUT");
 }
 
-static void _rtl92e_set_chan(struct net_device *dev, u8 ch)
-{
-	struct r8192_priv *priv = rtllib_priv(dev);
-
-	priv->chan = ch;
-
-	if (priv->rf_set_chan)
-		priv->rf_set_chan(dev, priv->chan);
-}
-
 static void _rtl92e_update_cap(struct net_device *dev, u16 cap)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
@@ -685,7 +675,7 @@ static void _rtl92e_init_priv_handler(struct net_device *dev)
 	struct r8192_priv *priv = rtllib_priv(dev);
 
 	priv->rtllib->softmac_hard_start_xmit	= _rtl92e_hard_start_xmit;
-	priv->rtllib->set_chan			= _rtl92e_set_chan;
+	priv->rtllib->set_chan			= rtl92e_set_channel;
 	priv->rtllib->link_change		= rtl92e_link_change;
 	priv->rtllib->softmac_data_hard_start_xmit = _rtl92e_hard_data_xmit;
 	priv->rtllib->check_nic_enough_desc	= _rtl92e_check_nic_enough_desc;
@@ -694,7 +684,6 @@ static void _rtl92e_init_priv_handler(struct net_device *dev)
 	priv->rtllib->set_wireless_mode		= rtl92e_set_wireless_mode;
 	priv->rtllib->leisure_ps_leave		= rtl92e_leisure_ps_leave;
 	priv->rtllib->set_bw_mode_handler	= rtl92e_set_bw_mode;
-	priv->rf_set_chan			= rtl92e_set_channel;
 
 	priv->rtllib->sta_wake_up = rtl92e_hw_wakeup;
 	priv->rtllib->enter_sleep_state = rtl92e_enter_sleep;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 9b0be6dff627..348df71e122e 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -228,8 +228,6 @@ struct r8192_priv {
 	struct rt_stats stats;
 	struct iw_statistics			wstats;
 
-	void (*rf_set_chan)(struct net_device *dev, u8 ch);
-
 	struct rx_desc *rx_ring;
 	struct sk_buff	*rx_buf[MAX_RX_COUNT];
 	dma_addr_t	rx_ring_dma;
-- 
2.42.0

