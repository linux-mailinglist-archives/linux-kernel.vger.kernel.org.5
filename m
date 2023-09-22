Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68C97AB2B0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 15:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbjIVN3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 09:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbjIVN3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 09:29:45 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01261A6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 06:29:38 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-321617ef967so260421f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 06:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695389377; x=1695994177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YKP2wJBaVOnyIULOTjPgCoMqgGRna4zYK5dA4TFa4TU=;
        b=BPYiquaqLIFvB0XmXf9zdsKBUUCGYFWoVeux3EnbBhYZWn2flU4tGzIeo9abeGA5cy
         8UqoD88F7rL4Rtvl+arN9Xwmo1Hp/M+YMgw9jpSUSS1ICVan5hItgJduGIiXSWtedRcN
         BTDixjcJcisUkXcSGn+8Lf4112SEm0no1FF/Qt9sI3dCnt1vKitokua7p82R9v3RZd6d
         uOeFEPBmJPoW83jXNe96ww8FeIdHk/VEaCagddtUt76n8PI2B2a18rsHhWozLtDhUN8R
         sqJLgghvsW8kaO/v+G+2bmfEbNgJPmknLIQkj8CtcBG+7OCbfc02D8UptC/YXhSpjE2b
         jUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695389377; x=1695994177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKP2wJBaVOnyIULOTjPgCoMqgGRna4zYK5dA4TFa4TU=;
        b=T+FecJKaZF5RwVYW3RWM/09NQwGhzaQ5Feh9rBzyuSlIb4XZXwfMB53W+YJCe0KBlg
         bYxLZr/9LGDd2oANqyZq12hqoplwxGyutFXG6HFDR5ajVMzvtU+DZy/y5TTZbq+AEmgT
         Y7xHq6PsKxzik+Asq8vnO/sseqloGBXlUWxgdcdXHCWUlO3GwEIYKyK58PX+PCl/W0/y
         ELWqvkZnmC74SuZdgXAQPn0wp0RyFWtsn3bLpGvdRkLmDzf+xmB1HPjhDqhM1LZpRiXg
         ur0u+XL4MjTTHQX6qOcnBiq7ZG7A7jCOJKRBpRYA3A0sCgGBTI09Olc7SoJ3bomKE3B7
         w99w==
X-Gm-Message-State: AOJu0YzZGIk0D+g1c3MKrfEZSwVdiLSh3UbafOj8NszkcnCyl3tuls+g
        GR9bNXAWw2tzue5JXuDs4ho=
X-Google-Smtp-Source: AGHT+IHl8F9IhmGLibBu/B/5h8xN+HTLbXvQ95v+aoD3AoPRjgTNMe5tFblyFwMIS6KbaUUD6M2Uag==
X-Received: by 2002:a05:6000:1148:b0:31f:edc3:c5fb with SMTP id d8-20020a056000114800b0031fedc3c5fbmr7224325wrx.5.1695389376686;
        Fri, 22 Sep 2023 06:29:36 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id r9-20020a5d4989000000b0031c5ce91ad6sm4465071wrq.97.2023.09.22.06.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 06:29:36 -0700 (PDT)
Date:   Fri, 22 Sep 2023 15:29:35 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] staging: rtl8192e: Remove mode IW_MODE_ADHOC from
 rtl_core.c
Message-ID: <7b9a4790238081736e6530135309e53d36f28574.1695387832.git.philipp.g.hortmann@gmail.com>
References: <cover.1695387832.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1695387832.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unsupported mode IW_MODE_ADHOC from rtl_core.c and further files.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 14 +-------------
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c   |  2 --
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c   |  6 +-----
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c   |  5 ++---
 drivers/staging/rtl8192e/rtllib_softmac_wx.c |  9 ---------
 5 files changed, 4 insertions(+), 32 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index cbb082d8b89f..03cabf88ce2b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -165,8 +165,7 @@ bool rtl92e_set_rf_state(struct net_device *dev,
 
 	case rf_off:
 
-		if ((priv->rtllib->iw_mode == IW_MODE_INFRA) ||
-		    (priv->rtllib->iw_mode == IW_MODE_ADHOC)) {
+		if (priv->rtllib->iw_mode == IW_MODE_INFRA) {
 			if ((priv->rtllib->rf_off_reason > RF_CHANGE_BY_IPS) ||
 			    (change_source > RF_CHANGE_BY_IPS)) {
 				if (ieee->link_state == MAC80211_LINKED)
@@ -1088,17 +1087,6 @@ static void _rtl92e_if_silent_reset(struct net_device *dev)
 
 			schedule_work(&ieee->associate_complete_wq);
 
-		} else if (ieee->link_state == MAC80211_LINKED && ieee->iw_mode ==
-			   IW_MODE_ADHOC) {
-			ieee->set_chan(ieee->dev,
-				       ieee->current_network.channel);
-			ieee->link_change(ieee->dev);
-
-			notify_wx_assoc_event(ieee);
-
-			rtllib_start_send_beacons(ieee);
-
-			netif_carrier_on(ieee->dev);
 		}
 
 		rtl92e_cam_restore(dev);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index dbf765d601b3..561ea68de56a 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -1405,8 +1405,6 @@ static void _rtl92e_dm_check_edca_turbo(struct net_device *dev)
 	unsigned long curTxOkCnt = 0;
 	unsigned long curRxOkCnt = 0;
 
-	if (priv->rtllib->iw_mode == IW_MODE_ADHOC)
-		goto dm_CheckEdcaTurbo_EXIT;
 	if (priv->rtllib->link_state != MAC80211_LINKED)
 		goto dm_CheckEdcaTurbo_EXIT;
 	if (priv->rtllib->ht_info->iot_action & HT_IOT_ACT_DISABLE_EDCA_TURBO)
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
index 598bfc0ff3d1..a4da11627199 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
@@ -181,9 +181,6 @@ static bool _rtl92e_ps_set_mode(struct net_device *dev, u8 rtPsMode)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	if (priv->rtllib->iw_mode == IW_MODE_ADHOC)
-		return false;
-
 	if (!priv->ps_force)
 		priv->rtllib->ps = rtPsMode;
 	if (priv->rtllib->sta_sleep != LPS_IS_WAKE &&
@@ -208,8 +205,7 @@ void rtl92e_leisure_ps_enter(struct net_device *dev)
 					&priv->rtllib->pwr_save_ctrl;
 
 	if (!((priv->rtllib->iw_mode == IW_MODE_INFRA) &&
-	    (priv->rtllib->link_state == MAC80211_LINKED))
-	    || (priv->rtllib->iw_mode == IW_MODE_ADHOC))
+	    (priv->rtllib->link_state == MAC80211_LINKED)))
 		return;
 
 	if (psc->bLeisurePs) {
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index 189798852568..17e7fcc01f70 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -250,7 +250,7 @@ static int _rtl92e_wx_set_mode(struct net_device *dev,
 		return 0;
 	rt_state = priv->rtllib->rf_power_state;
 	mutex_lock(&priv->wx_mutex);
-	if (wrqu->mode == IW_MODE_ADHOC || wrqu->mode == IW_MODE_MONITOR ||
+	if (wrqu->mode == IW_MODE_MONITOR ||
 	    ieee->net_promiscuous_md) {
 		if (rt_state == rf_off) {
 			if (priv->rtllib->rf_off_reason >
@@ -844,8 +844,7 @@ static int _rtl92e_wx_set_encode_ext(struct net_device *dev,
 			idx--;
 		group = ext->ext_flags & IW_ENCODE_EXT_GROUP_KEY;
 
-		if ((!group) || (ieee->iw_mode == IW_MODE_ADHOC) ||
-		    (alg ==  KEY_TYPE_WEP40)) {
+		if ((!group) || (alg ==  KEY_TYPE_WEP40)) {
 			if ((ext->key_len == 13) && (alg == KEY_TYPE_WEP40))
 				alg = KEY_TYPE_WEP104;
 			ieee->pairwise_key_type = alg;
diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index 48703d93df30..2b15251201ec 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -50,12 +50,6 @@ int rtllib_wx_set_freq(struct rtllib_device *ieee, struct iw_request_info *a,
 		}
 		ieee->current_network.channel = fwrq->m;
 		ieee->set_chan(ieee->dev, ieee->current_network.channel);
-
-		if (ieee->iw_mode == IW_MODE_ADHOC)
-			if (ieee->link_state == MAC80211_LINKED) {
-				rtllib_stop_send_beacons(ieee);
-				rtllib_start_send_beacons(ieee);
-			}
 	}
 
 	ret = 0;
@@ -360,9 +354,6 @@ void rtllib_wx_sync_scan_wq(void *data)
 		ieee->link_detect_info.NumRecvBcnInPeriod = 1;
 		ieee->link_detect_info.NumRecvDataInPeriod = 1;
 	}
-	if (ieee->iw_mode == IW_MODE_ADHOC)
-		rtllib_start_send_beacons(ieee);
-
 	rtllib_wake_all_queues(ieee);
 
 out:
-- 
2.42.0

