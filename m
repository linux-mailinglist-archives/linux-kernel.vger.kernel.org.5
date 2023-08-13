Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853A377A520
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 08:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjHMGg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 02:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjHMGg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 02:36:26 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4A61713
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 23:36:28 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3174ca258bbso791600f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 23:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691908586; x=1692513386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=netjrGKmmw8kg0Kci9erRykpBVdnyt6ZhsBgAx21OOk=;
        b=Z1gD/WtSxS4539MeusCmkflEnonmRzENWhSzUiT9Xt8nJSkPi3WenviaoTJQE1e0iI
         3KN2NbVx5yCWov4UgF2VXwunkEB1Ry1B1M5owKHzuTdPEhYdQfApRhz6xaSWn0o1SNb6
         jQDX4i71vOl5JHc+uN0x6FxXQGIlXeCE9EbSUQO0j4lsrLO3n0VyVBdRvIakknDRaltL
         6L8mI8lbgfc2LtyMkusjQdy9FLw3C8AaCaM2JKXkXvcwnf70PISuPxN7ZjEsFJnQ9WPe
         GickHLOMSbRDjeRjylIVMA7vG0M21K0dExfScYHlWYPiF5V2cnV2dercPYU9FeHCnHcC
         GeDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691908586; x=1692513386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=netjrGKmmw8kg0Kci9erRykpBVdnyt6ZhsBgAx21OOk=;
        b=OnRpVNXEOuT9EMyxJ6Aqju6PfRcXWoZrlz8+/E7xkjLY1/8PEsyQjFmUeWgaqi5S+N
         yAvEw9YTiXVllsbtk3rXEFChWdYwYDsv0aSEPmHQhkTjcT1/XvOJ05YTLX46dKktGo6m
         aBFKmMjcuGV4h/FRxknJ0FzBcy2i90CIrfQ2tchYjvlGL843B9XaDHFrl4Ba44TL1GQ4
         0iTzUjeVh8L16NYhxJM1BousfFv53DR1OnMTHaLhFqvZ/OW0dqCs+PxU7O7AJTCY66KE
         rtkSLMWZmcXBQzcQOiNn4n7DFcKfvPEp9AwKxPLhLNqOeQtv1OpZyuD0Mu3+QVOQcXSx
         CCQA==
X-Gm-Message-State: AOJu0YzEAkzAGO0/i26P4xuqYXNtbTxOd5mGeu5Ri4DRGJTAlrY5E9Q2
        ixUVaD3hlr9zZe4M5xKu+0eQORNYvtM=
X-Google-Smtp-Source: AGHT+IG1KWu4m6xREdTpep2vyxS+sTjFEF1yoJNYbW7Ip391TFHaj+rwJIZlLFa3t/wnLzvVBZBmsg==
X-Received: by 2002:a05:600c:34cb:b0:3fe:4d2d:f79b with SMTP id d11-20020a05600c34cb00b003fe4d2df79bmr6128269wmq.4.1691908586242;
        Sat, 12 Aug 2023 23:36:26 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id z15-20020a05600c114f00b003fe2bea77ccsm10439161wmz.5.2023.08.12.23.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 23:36:25 -0700 (PDT)
Date:   Sun, 13 Aug 2023 08:36:23 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] staging: rtl8192e: Remove unsupported mode IW_MODE_MASTER
Message-ID: <9cd4574e4cfe0a2d7afce03c9b868757e215a23c.1691908402.git.philipp.g.hortmann@gmail.com>
References: <cover.1691908402.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1691908402.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tasklet irq_rx_tasklet is scheduled when hw is receiving frames. Function
_rtl92e_irq_rx_tasklet() is then called which calls then
_rtl92e_rx_normal(). In _rtl92e_rx_normal() all frames are processed by
rtllib_rx(). When ieee->iw_mode is IW_MODE_MASTER the function returns
0. The calling function then calls: dev_kfree_skb_any() which clears the
skb. So the driver clears all packets received in this mode. Remove dead
code in mode IW_MODE_MASTER.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c |  4 ----
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c     |  6 ++----
 drivers/staging/rtl8192e/rtl819x_HTProc.c      |  3 +--
 drivers/staging/rtl8192e/rtl819x_TSProc.c      | 14 ++------------
 drivers/staging/rtl8192e/rtllib_rx.c           |  4 +---
 drivers/staging/rtl8192e/rtllib_softmac.c      | 11 +----------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c   |  9 ++-------
 drivers/staging/rtl8192e/rtllib_tx.c           |  2 --
 8 files changed, 9 insertions(+), 44 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 5bfd84b08dd9..58e90b7772ef 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -59,10 +59,6 @@ static void _rtl92e_update_msr(struct net_device *dev)
 		if (priv->rtllib->link_state == MAC80211_LINKED)
 			msr |= MSR_LINK_ADHOC;
 		break;
-	case IW_MODE_MASTER:
-		if (priv->rtllib->link_state == MAC80211_LINKED)
-			msr |= MSR_LINK_MASTER;
-		break;
 	default:
 		break;
 	}
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
index 1c49d5da68eb..598bfc0ff3d1 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
@@ -118,8 +118,7 @@ void rtl92e_ips_enter(struct net_device *dev)
 
 	rt_state = priv->rtllib->rf_power_state;
 	if (rt_state == rf_on && !psc->bSwRfProcessing &&
-		(priv->rtllib->link_state != MAC80211_LINKED) &&
-		(priv->rtllib->iw_mode != IW_MODE_MASTER)) {
+		(priv->rtllib->link_state != MAC80211_LINKED)) {
 		psc->eInactivePowerState = rf_off;
 		_rtl92e_ps_update_rf_state(dev);
 	}
@@ -210,8 +209,7 @@ void rtl92e_leisure_ps_enter(struct net_device *dev)
 
 	if (!((priv->rtllib->iw_mode == IW_MODE_INFRA) &&
 	    (priv->rtllib->link_state == MAC80211_LINKED))
-	    || (priv->rtllib->iw_mode == IW_MODE_ADHOC) ||
-	    (priv->rtllib->iw_mode == IW_MODE_MASTER))
+	    || (priv->rtllib->iw_mode == IW_MODE_ADHOC))
 		return;
 
 	if (psc->bLeisurePs) {
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index f9fa3f2bb728..f19feea46158 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -363,8 +363,7 @@ void HTConstructInfoElement(struct rtllib_device *ieee, u8 *posHTInfo,
 	}
 
 	memset(posHTInfo, 0, *len);
-	if ((ieee->iw_mode == IW_MODE_ADHOC) ||
-	    (ieee->iw_mode == IW_MODE_MASTER)) {
+	if (ieee->iw_mode == IW_MODE_ADHOC) {
 		pHTInfoEle->ControlChl	= ieee->current_network.channel;
 		pHTInfoEle->ExtChlOffset = ((!pHT->bRegBW40MHz) ?
 					    HT_EXTCHNL_OFFSET_NO_EXT :
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 24a8b9fc0168..419ff72f2ba7 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -182,15 +182,7 @@ static struct ts_common_info *SearchAdmitTRStream(struct rtllib_device *ieee,
 	struct list_head *psearch_list;
 	struct ts_common_info *pRet = NULL;
 
-	if (ieee->iw_mode == IW_MODE_MASTER) {
-		if (TxRxSelect == TX_DIR) {
-			search_dir[DIR_DOWN] = true;
-			search_dir[DIR_BI_DIR] = true;
-		} else {
-			search_dir[DIR_UP] = true;
-			search_dir[DIR_BI_DIR] = true;
-		}
-	} else if (ieee->iw_mode == IW_MODE_ADHOC) {
+	if (ieee->iw_mode == IW_MODE_ADHOC) {
 		if (TxRxSelect == TX_DIR)
 			search_dir[DIR_UP] = true;
 		else
@@ -311,9 +303,7 @@ bool GetTs(struct rtllib_device *ieee, struct ts_common_info **ppTS,
 				(&ieee->Tx_TS_Admit_List) :
 				(&ieee->Rx_TS_Admit_List);
 
-	Dir = (ieee->iw_mode == IW_MODE_MASTER) ?
-				((TxRxSelect == TX_DIR) ? DIR_DOWN : DIR_UP) :
-				((TxRxSelect == TX_DIR) ? DIR_UP : DIR_DOWN);
+	Dir = ((TxRxSelect == TX_DIR) ? DIR_UP : DIR_DOWN);
 
 	if (!list_empty(pUnusedList)) {
 		(*ppTS) = list_entry(pUnusedList->next,
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 8a4029f26835..b3f5ab33603e 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1496,7 +1496,6 @@ int rtllib_rx(struct rtllib_device *ieee, struct sk_buff *skb,
 	case IW_MODE_INFRA:
 		ret = rtllib_rx_InfraAdhoc(ieee, skb, rx_stats);
 		break;
-	case IW_MODE_MASTER:
 	case IW_MODE_REPEAT:
 		break;
 	case IW_MODE_MONITOR:
@@ -2682,8 +2681,7 @@ static void rtllib_rx_mgt(struct rtllib_device *ieee,
 		netdev_dbg(ieee->dev, "received PROBE REQUEST (%d)\n",
 			   WLAN_FC_GET_STYPE(le16_to_cpu(header->frame_ctl)));
 		if ((ieee->softmac_features & IEEE_SOFTMAC_PROBERS) &&
-		    ((ieee->iw_mode == IW_MODE_ADHOC ||
-		    ieee->iw_mode == IW_MODE_MASTER) &&
+		    (ieee->iw_mode == IW_MODE_ADHOC &&
 		    ieee->link_state == MAC80211_LINKED))
 			rtllib_rx_probe_rq(ieee, skb);
 		break;
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 0e52b207942d..6fa1d6a9da28 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -935,8 +935,7 @@ static struct sk_buff *rtllib_assoc_resp(struct rtllib_device *ieee, u8 *dest)
 	ether_addr_copy(assoc->header.addr1, dest);
 	ether_addr_copy(assoc->header.addr3, ieee->dev->dev_addr);
 	ether_addr_copy(assoc->header.addr2, ieee->dev->dev_addr);
-	assoc->capability = cpu_to_le16(ieee->iw_mode == IW_MODE_MASTER ?
-		WLAN_CAPABILITY_ESS : WLAN_CAPABILITY_IBSS);
+	assoc->capability = cpu_to_le16(WLAN_CAPABILITY_IBSS);
 
 	assoc->capability |= cpu_to_le16(WLAN_CAPABILITY_SHORT_SLOT_TIME);
 
@@ -2248,8 +2247,6 @@ rtllib_rx_auth(struct rtllib_device *ieee, struct sk_buff *skb,
 			netdev_dbg(ieee->dev,
 				   "Received authentication response");
 			rtllib_rx_auth_resp(ieee, skb);
-		} else if (ieee->iw_mode == IW_MODE_MASTER) {
-			rtllib_rx_auth_rq(ieee, skb);
 		}
 	}
 	return 0;
@@ -2309,9 +2306,6 @@ inline int rtllib_rx_frame_softmac(struct rtllib_device *ieee,
 		break;
 	case RTLLIB_STYPE_ASSOC_REQ:
 	case RTLLIB_STYPE_REASSOC_REQ:
-		if ((ieee->softmac_features & IEEE_SOFTMAC_ASSOCIATE) &&
-		     ieee->iw_mode == IW_MODE_MASTER)
-			rtllib_rx_assoc_rq(ieee, skb);
 		break;
 	case RTLLIB_STYPE_AUTH:
 		rtllib_rx_auth(ieee, skb, rx_stats);
@@ -2807,9 +2801,6 @@ void rtllib_start_protocol(struct rtllib_device *ieee)
 	case IW_MODE_ADHOC:
 		rtllib_start_ibss(ieee);
 		break;
-	case IW_MODE_MASTER:
-		rtllib_start_master_bss(ieee);
-		break;
 	case IW_MODE_MONITOR:
 		rtllib_start_monitor_mode(ieee);
 		break;
diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index aad91dad134c..0b690f0ffeef 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -51,8 +51,7 @@ int rtllib_wx_set_freq(struct rtllib_device *ieee, struct iw_request_info *a,
 		ieee->current_network.channel = fwrq->m;
 		ieee->set_chan(ieee->dev, ieee->current_network.channel);
 
-		if (ieee->iw_mode == IW_MODE_ADHOC ||
-		    ieee->iw_mode == IW_MODE_MASTER)
+		if (ieee->iw_mode == IW_MODE_ADHOC)
 			if (ieee->link_state == MAC80211_LINKED) {
 				rtllib_stop_send_beacons(ieee);
 				rtllib_start_send_beacons(ieee);
@@ -125,10 +124,6 @@ int rtllib_wx_set_wap(struct rtllib_device *ieee,
 
 	mutex_lock(&ieee->wx_mutex);
 	/* use ifconfig hw ether */
-	if (ieee->iw_mode == IW_MODE_MASTER) {
-		ret = -1;
-		goto out;
-	}
 
 	if (temp->sa_family != ARPHRD_ETHER) {
 		ret = -EINVAL;
@@ -366,7 +361,7 @@ void rtllib_wx_sync_scan_wq(void *data)
 		ieee->link_detect_info.NumRecvBcnInPeriod = 1;
 		ieee->link_detect_info.NumRecvDataInPeriod = 1;
 	}
-	if (ieee->iw_mode == IW_MODE_ADHOC || ieee->iw_mode == IW_MODE_MASTER)
+	if (ieee->iw_mode == IW_MODE_ADHOC)
 		rtllib_start_send_beacons(ieee);
 
 	rtllib_wake_all_queues(ieee);
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 24fd40284420..4199aee930f0 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -463,8 +463,6 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 	}
 	if (ieee->current_network.capability & WLAN_CAPABILITY_SHORT_PREAMBLE)
 		tcb_desc->bUseShortPreamble = true;
-	if (ieee->iw_mode == IW_MODE_MASTER)
-		goto NO_PROTECTION;
 	return;
 NO_PROTECTION:
 	tcb_desc->bRTSEnable	= false;
-- 
2.41.0

