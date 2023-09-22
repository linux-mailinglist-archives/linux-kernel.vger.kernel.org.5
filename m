Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564427AB2AD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 15:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbjIVN3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 09:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbjIVN3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 09:29:31 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74009CE
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 06:29:25 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3216b83c208so231095f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 06:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695389364; x=1695994164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LBy3wFhLTQf4ZmbkwmQwK7h4Pebz0NJBR2zXKtkevTU=;
        b=NA77nXEAh9+XUhWnOhIo7nnTaP+grmfqfK5oDfqaiKFglMrjTAisy72s/6V8Ns0mNz
         +mXW5tQR6UrzbrFupbJLWKEUPhLBdGtlTcxW3aI+la+bfs9fj+zEi2bJkUnVD3XV7K46
         d46eG0LjDVglrw41m7EXf9ZdgMvuC/nQg/fRunN4lmQUmGowsmzHUe4SL9Mq/nY9ugS0
         2j3V7F8n2+sXwYz+vH30J0ep6G1vgJrvXHI5DBOklVgz66ryGymli84WpPfcBTUieZ2R
         0nbUSVL34+HFhnLskX/KAGEzzquEaavGc0yxVQb42jraYHYdlylJv23pXjNDBc78YXB+
         Ulog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695389364; x=1695994164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBy3wFhLTQf4ZmbkwmQwK7h4Pebz0NJBR2zXKtkevTU=;
        b=AIh1CNqMRx4L5x1XxM5iymHWyNJarQq0XTbF7cDB9HOfhkDbldVsV1RLS8Z+qhdhhg
         JBlDYr9Xyy5YvzFamHsbpMdT8ZIBUyRf5xhZCZaXcFPJTT8B3huKdDVDytRN++/h4nqb
         7ptFpeEU3oDWtBygxV++P3LyzbXaacNULxPbpKbPKI7jKeP1sy8eB1A5Rm8d16G2WFBK
         qhsGQWnkb4rVn4FhuGstAFcP6jRI+b73zK4wyCc09ONHFrzIl7mGWkg4/FOGRT8XY0Q9
         uaMjsnDOx6QfyvKw1pj73d0YJm+6EbzWvNx9y37pjZJxvpXbi+qBNmxBERGIfCwK8Rue
         BvUw==
X-Gm-Message-State: AOJu0Yx42nnA6CYHViaC7GMeL9XCcDtAkseg4tBfoW+KDTsC38BEk/kX
        JHMFssT5RbAJdBxo5me7k4k=
X-Google-Smtp-Source: AGHT+IHz3Jcw4j2xB6knYF2ElgaLojpc6W6Uci1Xiqu9UQfofIxUtJ5pWF/iD3wRoPYB5AeaOZH41A==
X-Received: by 2002:adf:f2c3:0:b0:320:8f0:b93d with SMTP id d3-20020adff2c3000000b0032008f0b93dmr7530568wrp.3.1695389363548;
        Fri, 22 Sep 2023 06:29:23 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id k17-20020a5d66d1000000b0031759e6b43fsm4467639wrw.39.2023.09.22.06.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 06:29:23 -0700 (PDT)
Date:   Fri, 22 Sep 2023 15:29:21 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] staging: rtl8192e: Remove mode IW_MODE_ADHOC from
 rtllib_tx.c
Message-ID: <59564ce06fc0a23fd26304b8ecd585abd5ddd82f.1695387832.git.philipp.g.hortmann@gmail.com>
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

Remove unsupported mode IW_MODE_ADHOC from rtllib_tx.c, rtl819x_TSProc.c,
rtl819x_HTProc.c, r8192E_dev.c

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 20 +-----------
 drivers/staging/rtl8192e/rtl819x_HTProc.c     | 32 +------------------
 drivers/staging/rtl8192e/rtl819x_TSProc.c     | 21 ++++--------
 drivers/staging/rtl8192e/rtllib_tx.c          | 11 +------
 4 files changed, 10 insertions(+), 74 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 95be6fb043dd..fe9f6585266b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -55,10 +55,6 @@ static void _rtl92e_update_msr(struct net_device *dev)
 		if (priv->rtllib->link_state == MAC80211_LINKED)
 			msr |= MSR_LINK_MANAGED;
 		break;
-	case IW_MODE_ADHOC:
-		if (priv->rtllib->link_state == MAC80211_LINKED)
-			msr |= MSR_LINK_ADHOC;
-		break;
 	default:
 		break;
 	}
@@ -706,7 +702,6 @@ static void _rtl92e_net_update(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 	struct rtllib_network *net;
-	u16 BcnTimeCfg = 0, BcnCW = 6, BcnIFS = 0xf;
 	u16 rate_config = 0;
 
 	net = &priv->rtllib->current_network;
@@ -715,19 +710,6 @@ static void _rtl92e_net_update(struct net_device *dev)
 	priv->basic_rate = rate_config &= 0x15f;
 	rtl92e_writew(dev, BSSIDR, *(u16 *)net->bssid);
 	rtl92e_writel(dev, BSSIDR + 2, *(u32 *)(net->bssid + 2));
-
-	if (priv->rtllib->iw_mode == IW_MODE_ADHOC) {
-		rtl92e_writew(dev, ATIMWND, 2);
-		rtl92e_writew(dev, BCN_DMATIME, 256);
-		rtl92e_writew(dev, BCN_INTERVAL, net->beacon_interval);
-		rtl92e_writew(dev, BCN_DRV_EARLY_INT, 10);
-		rtl92e_writeb(dev, BCN_ERR_THRESH, 100);
-
-		BcnTimeCfg |= (BcnCW << BCN_TCFG_CW_SHIFT);
-		BcnTimeCfg |= BcnIFS << BCN_TCFG_IFS;
-
-		rtl92e_writew(dev, BCN_TCFG, BcnTimeCfg);
-	}
 }
 
 void rtl92e_link_change(struct net_device *dev)
@@ -749,7 +731,7 @@ void rtl92e_link_change(struct net_device *dev)
 	}
 	_rtl92e_update_msr(dev);
 
-	if (ieee->iw_mode == IW_MODE_INFRA || ieee->iw_mode == IW_MODE_ADHOC) {
+	if (ieee->iw_mode == IW_MODE_INFRA) {
 		u32 reg;
 
 		reg = rtl92e_readl(dev, RCR);
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index f19feea46158..0f14d9eb4fcd 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -352,7 +352,6 @@ void HTConstructCapabilityElement(struct rtllib_device *ieee, u8 *posHTCap,
 void HTConstructInfoElement(struct rtllib_device *ieee, u8 *posHTInfo,
 			    u8 *len, u8 IsEncrypt)
 {
-	struct rt_hi_throughput *pHT = ieee->ht_info;
 	struct ht_info_ele *pHTInfoEle = (struct ht_info_ele *)posHTInfo;
 
 	if (!posHTInfo || !pHTInfoEle) {
@@ -363,32 +362,7 @@ void HTConstructInfoElement(struct rtllib_device *ieee, u8 *posHTInfo,
 	}
 
 	memset(posHTInfo, 0, *len);
-	if (ieee->iw_mode == IW_MODE_ADHOC) {
-		pHTInfoEle->ControlChl	= ieee->current_network.channel;
-		pHTInfoEle->ExtChlOffset = ((!pHT->bRegBW40MHz) ?
-					    HT_EXTCHNL_OFFSET_NO_EXT :
-					    (ieee->current_network.channel <= 6)
-					    ? HT_EXTCHNL_OFFSET_UPPER :
-					    HT_EXTCHNL_OFFSET_LOWER);
-		pHTInfoEle->RecommemdedTxWidth	= pHT->bRegBW40MHz;
-		pHTInfoEle->RIFS			= 0;
-		pHTInfoEle->PSMPAccessOnly		= 0;
-		pHTInfoEle->SrvIntGranularity		= 0;
-		pHTInfoEle->OptMode			= pHT->current_op_mode;
-		pHTInfoEle->NonGFDevPresent		= 0;
-		pHTInfoEle->DualBeacon			= 0;
-		pHTInfoEle->SecondaryBeacon		= 0;
-		pHTInfoEle->LSigTxopProtectFull		= 0;
-		pHTInfoEle->PcoActive			= 0;
-		pHTInfoEle->PcoPhase			= 0;
-
-		memset(pHTInfoEle->BasicMSC, 0, 16);
-
-		*len = 22 + 2;
-
-	} else {
-		*len = 0;
-	}
+	*len = 0;
 }
 
 void HTConstructRT2RTAggElement(struct rtllib_device *ieee, u8 *posRT2RTAgg,
@@ -781,10 +755,6 @@ void HTUseDefaultSetting(struct rtllib_device *ieee)
 		ht_info->bCurShortGI20MHz = ht_info->bRegShortGI20MHz;
 
 		ht_info->bCurShortGI40MHz = ht_info->bRegShortGI40MHz;
-
-		if (ieee->iw_mode == IW_MODE_ADHOC)
-			ieee->current_network.qos_data.active =
-				 ieee->current_network.qos_data.supported;
 		ht_info->bCurrent_AMSDU_Support = ht_info->bAMSDU_Support;
 		ht_info->nCurrent_AMSDU_MaxSize = ht_info->nAMSDU_MaxSize;
 
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 637e22897803..a482acd5ee06 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -181,21 +181,14 @@ static struct ts_common_info *SearchAdmitTRStream(struct rtllib_device *ieee,
 	struct list_head *psearch_list;
 	struct ts_common_info *pRet = NULL;
 
-	if (ieee->iw_mode == IW_MODE_ADHOC) {
-		if (TxRxSelect == TX_DIR)
-			search_dir[DIR_UP] = true;
-		else
-			search_dir[DIR_DOWN] = true;
+	if (TxRxSelect == TX_DIR) {
+		search_dir[DIR_UP] = true;
+		search_dir[DIR_BI_DIR] = true;
+		search_dir[DIR_DIRECT] = true;
 	} else {
-		if (TxRxSelect == TX_DIR) {
-			search_dir[DIR_UP] = true;
-			search_dir[DIR_BI_DIR] = true;
-			search_dir[DIR_DIRECT] = true;
-		} else {
-			search_dir[DIR_DOWN] = true;
-			search_dir[DIR_BI_DIR] = true;
-			search_dir[DIR_DIRECT] = true;
-		}
+		search_dir[DIR_DOWN] = true;
+		search_dir[DIR_BI_DIR] = true;
+		search_dir[DIR_DIRECT] = true;
 	}
 
 	if (TxRxSelect == TX_DIR)
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 9b77d6fa7954..bad01599033b 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -482,8 +482,7 @@ static void rtllib_txrate_selectmode(struct rtllib_device *ieee,
 		tcb_desc->tx_use_drv_assinged_rate = true;
 	if (!tcb_desc->tx_dis_rate_fallback ||
 	    !tcb_desc->tx_use_drv_assinged_rate) {
-		if (ieee->iw_mode == IW_MODE_INFRA ||
-		    ieee->iw_mode == IW_MODE_ADHOC)
+		if (ieee->iw_mode == IW_MODE_INFRA)
 			tcb_desc->ratr_index = 0;
 	}
 }
@@ -677,14 +676,6 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 						ieee->current_network.bssid);
 			else
 				ether_addr_copy(header.addr3, dest);
-		} else if (ieee->iw_mode == IW_MODE_ADHOC) {
-			/* not From/To DS: Addr1 = DA, Addr2 = SA,
-			 * Addr3 = BSSID
-			 */
-			ether_addr_copy(header.addr1, dest);
-			ether_addr_copy(header.addr2, src);
-			ether_addr_copy(header.addr3,
-					ieee->current_network.bssid);
 		}
 
 		bIsMulticast = is_multicast_ether_addr(header.addr1);
-- 
2.42.0

