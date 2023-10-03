Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F69B7B71D3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240995AbjJCTeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 15:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240884AbjJCTeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:34:16 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF237B4
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 12:34:10 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9ae3d7eb7e0so45045166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 12:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696361649; x=1696966449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WUj0EUzF8U/cERPhR5EBlsdUDyXZHpv8WU11BXIk4f0=;
        b=LF+Wea7Vu/KYgwCeYCrVXJez/KApPt+fB5h6MC1Ks9PUY2JBfBub44x4HmI8ThlETb
         kKjT2uJNMbkrT6h1tkfBgQvK8xZjeUru5CpskbdoPJbBVOyWjYnXGoepHjcZnb6BwJdS
         x9z8joM1Bccd8SlmHVgWVLv8hQp4/Tn+ByXtljGyIVT16j50CSlQcATb6qXQ4K8V8hKo
         wykGzUjtzqazOrWgnmCv1Ic/XhtxQbn4cGB2BhUaTBHJT/TCgGjl52m10N++3WPh2Hm/
         KpMRqqcYehydpAJ0lJzrU8eM2CP1OIKzJAFCeYLIg8ApVtnh2rubnt+gPCdzywIQcVRE
         11cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696361649; x=1696966449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUj0EUzF8U/cERPhR5EBlsdUDyXZHpv8WU11BXIk4f0=;
        b=v4c2Sf6d+LY7H6PtSvAX+ZhpXRdjlp96Yn+RFrJBAXwcXo5kou74Xf/rNn5Gh+/SUl
         iNjO+Mw+EIZfNMElJARqgGn0vMV9v/tQG6V1ZsonBv/7nKdXTIv8ZTLW5351zN9sufT+
         M7jDYDtVJmb0Qra/iQwrmY2h4AG/yDbGsi+FrT51YeEGiSym4k94hrrDWDwJBRjCO4/h
         lHT3UWZbjFnJuwcFj10JncjjsBN2isBvdEuQLzj7PpX97IYeFon9Mk8TtB4WrBq9t+rJ
         k2s1CZfYsIW3Z1Cc1PYUsAqKibPhZpRoFSs9ueJFaA6en6F/UmFwDlvCiJY9JCevyZfT
         gOiw==
X-Gm-Message-State: AOJu0YzqrdoqZdVTeIIJ7DM+7kTAs1fGVE7z4jHSz8j1WXJpP0YmYFkk
        fnxuMFKn/fmkLh3QmCaRCbY=
X-Google-Smtp-Source: AGHT+IH4KmJJDaDE1n/5ieqYpG2Po1NFW6luZ6E4c+g8/Fggj169fBjpQzmYsbcPblvsSPbUPt/9pg==
X-Received: by 2002:a17:906:2254:b0:9b2:bf2d:6b65 with SMTP id 20-20020a170906225400b009b2bf2d6b65mr101253ejr.4.1696361649103;
        Tue, 03 Oct 2023 12:34:09 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id os25-20020a170906af7900b009934855d8f1sm1536778ejb.34.2023.10.03.12.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 12:34:08 -0700 (PDT)
Date:   Tue, 3 Oct 2023 21:34:07 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] staging: rtl8192e: Remove constant variable
 net_promiscuous_md
Message-ID: <84a9865f763feeaaa51ce9abecf76c848e13580e.1696360404.git.philipp.g.hortmann@gmail.com>
References: <cover.1696360403.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696360403.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove variable net_promiscuous_md as it is set to 0 and unchanged. The
equations result accordingly. Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 8 ++------
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c   | 4 +---
 drivers/staging/rtl8192e/rtllib.h            | 1 -
 drivers/staging/rtl8192e/rtllib_rx.c         | 8 ++------
 4 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index ef17472bea05..f46cb152930a 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -739,7 +739,6 @@ static void _rtl92e_init_priv_variable(struct net_device *dev)
 	priv->chan = 1;
 	priv->rtllib->mode = WIRELESS_MODE_AUTO;
 	priv->rtllib->iw_mode = IW_MODE_INFRA;
-	priv->rtllib->net_promiscuous_md = false;
 	priv->rtllib->ieee_up = 0;
 	priv->retry_rts = DEFAULT_RETRY_RTS;
 	priv->retry_data = DEFAULT_RETRY_DATA;
@@ -1030,15 +1029,12 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 		     MAC80211_NOLINK) &&
 		     (ieee->rf_power_state == rf_on) && !ieee->is_set_key &&
 		     (!ieee->proto_stoppping) && !ieee->wx_set_enc) {
-			if ((ieee->pwr_save_ctrl.ReturnPoint ==
-			     IPS_CALLBACK_NONE) &&
-			     (!ieee->net_promiscuous_md)) {
+			if (ieee->pwr_save_ctrl.ReturnPoint == IPS_CALLBACK_NONE) {
 				rtl92e_ips_enter(dev);
 			}
 		}
 	}
-	if ((ieee->link_state == MAC80211_LINKED) && (ieee->iw_mode ==
-	     IW_MODE_INFRA) && (!ieee->net_promiscuous_md)) {
+	if ((ieee->link_state == MAC80211_LINKED) && (ieee->iw_mode == IW_MODE_INFRA)) {
 		if (ieee->link_detect_info.NumRxOkInPeriod > 100 ||
 		ieee->link_detect_info.NumTxOkInPeriod > 100)
 			bBusyTraffic = true;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index d0b68b258af7..c367e4fa2af1 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -209,7 +209,6 @@ static int _rtl92e_wx_set_mode(struct net_device *dev,
 			       union iwreq_data *wrqu, char *b)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
-	struct rtllib_device *ieee = netdev_priv_rsl(dev);
 
 	enum rt_rf_power_state rt_state;
 	int ret;
@@ -218,8 +217,7 @@ static int _rtl92e_wx_set_mode(struct net_device *dev,
 		return 0;
 	rt_state = priv->rtllib->rf_power_state;
 	mutex_lock(&priv->wx_mutex);
-	if (wrqu->mode == IW_MODE_MONITOR ||
-	    ieee->net_promiscuous_md) {
+	if (wrqu->mode == IW_MODE_MONITOR) {
 		if (rt_state == rf_off) {
 			if (priv->rtllib->rf_off_reason >
 			    RF_CHANGE_BY_IPS) {
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 97bb00bdbf4d..6d54c03f5680 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1253,7 +1253,6 @@ struct rtllib_device {
 	int scan_age;
 
 	int iw_mode; /* operating mode (IW_MODE_*) */
-	bool net_promiscuous_md;
 
 	spinlock_t lock;
 	spinlock_t wpax_suitlist_lock;
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index f03ec5f53b34..9a5fdf16f6a1 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1255,12 +1255,8 @@ static int rtllib_rx_InfraAdhoc(struct rtllib_device *ieee, struct sk_buff *skb,
 	/*Filter pkt not to me*/
 	multicast = is_multicast_ether_addr(hdr->addr1);
 	unicast = !multicast;
-	if (unicast && !ether_addr_equal(dev->dev_addr, hdr->addr1)) {
-		if (ieee->net_promiscuous_md)
-			bToOtherSTA = true;
-		else
-			goto rx_dropped;
-	}
+	if (unicast && !ether_addr_equal(dev->dev_addr, hdr->addr1))
+		goto rx_dropped;
 
 	/*Filter pkt has too small length */
 	hdrlen = rtllib_rx_get_hdrlen(ieee, skb, rx_stats);
-- 
2.42.0

