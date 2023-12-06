Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B30807C09
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 00:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377813AbjLFXDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 18:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379612AbjLFXDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 18:03:52 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82481D72
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 15:03:57 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 879433200ABA;
        Wed,  6 Dec 2023 18:03:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 06 Dec 2023 18:03:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1701903836; x=
        1701990236; bh=Ts4cLhYYzzok3kwgsMOTCxxx9gZzMOek+V++hFjm8cU=; b=S
        Av3A07SdHtRfyBIMQDtmao1jF8edpQDgM81AqugmQMg9GDU4qSjYLp+Q9C+0NNpr
        sJUKIeMI1vwu4iJyapBarXH9M2FBu8gGfSCwvBDkp1icDwGZfyaMSQZckT6x6ON9
        BS0cUtWUEdCWTk9M4ufqoDMzM/19y48ZNcHJI5n4f3WZ1lqi4yhIW1M7W/Dxi0Ma
        XtmEbCjfYqqXtUX/9Fjng9oh0qO4ECqR8/6pq/v5mkyfZaFZGJ+CeE/J/k/PXwMM
        82NZatDhI4KO9g3Hdf8so/7Ej8EW30uLLO9KiQ/5TSyhkvkOAR9k7Xx9iZiTE9lG
        LNkXlWuEXqnUjplXZq09A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1701903836; x=
        1701990236; bh=Ts4cLhYYzzok3kwgsMOTCxxx9gZzMOek+V++hFjm8cU=; b=H
        UGOS+RwixbYuXhQ1whIJBm+FYXIfbUldw6NvwBPWBz/36LcbLGKucjtPRvHetB1g
        8THaHYJsRR2VlvGQOeIDEQHURA9wO451Ktq4lmZkL7cJM+MV5kyLTy7UKRqjBdRH
        RI19zYZJgtXtVs+iefTPLH/txLMz7m9yUD5oB4MWeF/l+DuUf7AUT/bn6eJ0XDRG
        iExoQ/07a+2eZgpKSIrTtnmzEjcmVlYyE4K9pYGzb/KVCGbwuQNZ2MwMd4flnfNM
        lphy+eY7zy+HhQMvxucBsPsqY1L9RMmYKgzx/Sk6VT4N+V9X0nfsrGxuCpgvbrzd
        uszCQcTaoJ23EPJe5ljkw==
X-ME-Sender: <xms:2_1wZdq8TNEcrNqMKG719wKMvN9VgYURkLM-sGCNVyUQLb84ZDAOUw>
    <xme:2_1wZfpgRnyDEmnY0PDA24g3G04IY6SxNpbpED0o85cFEIgirZeEqaKvYMW5VWBH9
    dlb_hoBEYSpRI1sLCA>
X-ME-Received: <xmr:2_1wZaM-8E6IyO1pFg0bUFBSMZnmz0SpZnvoNGxWxPt7WRXZQwEzJLNRW6RHkpQD5cJFiUgglwar1tC6wlY9hB45WMfz0NNyWhYCf3IHb6k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekuddgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:2_1wZY6JuNHtBm5XLa45-_CFhv4-yivHA6A2xm6cKF0yLFG07NiqLg>
    <xmx:2_1wZc7pU0ZdNUgeoLKBbBD8E2Lc00MTTHyzlC-AlQpuMjw3NVOQWw>
    <xmx:2_1wZQg9mASJQ9BieEIDnPMddlZyKL-DRe6-6mAh_46Z_ZFguojr3g>
    <xmx:3P1wZak7WNVDwSEjcxnnUczmpUWUz82dEgWzXR_sPqDcLtbVRdNTWA>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Dec 2023 18:03:55 -0500 (EST)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 2/5] staging: rtl8192e: renamed variable bAMPDUEnable
Date:   Wed,  6 Dec 2023 18:04:01 -0500
Message-ID: <20231206230404.1721-3-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231206230404.1721-1-garyrookard@fastmail.org>
References: <20231206230404.1721-1-garyrookard@fastmail.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coding style issue, checkpatch Avoid CamelCase,
rename it. bAMPDUEnable -> ampdu_enable

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 +-
 drivers/staging/rtl8192e/rtl819x_HT.h          | 2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c      | 4 ++--
 drivers/staging/rtl8192e/rtllib.h              | 2 +-
 drivers/staging/rtl8192e/rtllib_tx.c           | 8 ++++----
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 13e3f26279aa..fe48cc6b7132 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -883,7 +883,7 @@ void  rtl92e_fill_tx_desc(struct net_device *dev, struct tx_desc *pdesc,
 	pTxFwInfo->Short = _rtl92e_query_is_short(pTxFwInfo->TxHT,
 						  pTxFwInfo->TxRate, cb_desc);
 
-	if (cb_desc->bAMPDUEnable) {
+	if (cb_desc->ampdu_enable) {
 		pTxFwInfo->AllowAggregation = 1;
 		pTxFwInfo->RxMF = cb_desc->ampdu_factor;
 		pTxFwInfo->RxAMD = cb_desc->ampdu_density;
diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index e02fa40262bd..7a3e36db849c 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -111,7 +111,7 @@ struct rt_hi_throughput {
 	u16 amsdu_max_size;
 	u8 bCurrent_AMSDU_Support;
 	u16 nCurrent_AMSDU_MaxSize;
-	u8 bAMPDUEnable;
+	u8 ampdu_enable;
 	u8 current_ampdu_enable;
 	u8 AMPDU_Factor;
 	u8 CurrentAMPDUFactor;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index b2f2e1c0cf6b..9841af15089f 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -84,7 +84,7 @@ void ht_update_default_setting(struct rtllib_device *ieee)
 	ht_info->amsdu_max_size = 7935UL;
 	ht_info->amsdu_support = 0;
 
-	ht_info->bAMPDUEnable = 1;
+	ht_info->ampdu_enable = 1;
 	ht_info->AMPDU_Factor = 2;
 	ht_info->MPDU_Density = 0;
 
@@ -498,7 +498,7 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 	else
 		ht_info->nCurrent_AMSDU_MaxSize = ht_info->amsdu_max_size;
 
-	ht_info->current_ampdu_enable = ht_info->bAMPDUEnable;
+	ht_info->current_ampdu_enable = ht_info->ampdu_enable;
 	if (ieee->rtllib_ap_sec_type &&
 	    (ieee->rtllib_ap_sec_type(ieee) & (SEC_ALG_WEP | SEC_ALG_TKIP))) {
 		if ((ht_info->IOTPeer == HT_IOT_PEER_ATHEROS) ||
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 47da9b1a8682..6bad7d410075 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -118,7 +118,7 @@ struct cb_desc {
 	u8 bUseShortGI:1;
 	u8 bUseShortPreamble:1;
 	u8 bTxEnableFwCalcDur:1;
-	u8 bAMPDUEnable:1;
+	u8 ampdu_enable:1;
 	u8 bRTSSTBC:1;
 	u8 RTSSC:1;
 
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index a79f9d8c9162..5a69f4c6d0c9 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -312,7 +312,7 @@ static void rtllib_tx_query_agg_cap(struct rtllib_device *ieee,
 				goto FORCED_AGG_SETTING;
 		}
 		if (ieee->iw_mode == IW_MODE_INFRA) {
-			tcb_desc->bAMPDUEnable = true;
+			tcb_desc->ampdu_enable = true;
 			tcb_desc->ampdu_factor = ht_info->CurrentAMPDUFactor;
 			tcb_desc->ampdu_density = ht_info->current_mpdu_density;
 		}
@@ -323,13 +323,13 @@ static void rtllib_tx_query_agg_cap(struct rtllib_device *ieee,
 		break;
 
 	case HT_AGG_FORCE_ENABLE:
-		tcb_desc->bAMPDUEnable = true;
+		tcb_desc->ampdu_enable = true;
 		tcb_desc->ampdu_density = ht_info->forced_mpdu_density;
 		tcb_desc->ampdu_factor = ht_info->forced_ampdu_factor;
 		break;
 
 	case HT_AGG_FORCE_DISABLE:
-		tcb_desc->bAMPDUEnable = false;
+		tcb_desc->ampdu_enable = false;
 		tcb_desc->ampdu_density = 0;
 		tcb_desc->ampdu_factor = 0;
 		break;
@@ -454,7 +454,7 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 			tcb_desc->bRTSEnable = true;
 			break;
 		}
-		if (tcb_desc->bAMPDUEnable) {
+		if (tcb_desc->ampdu_enable) {
 			tcb_desc->rts_rate = MGN_24M;
 			tcb_desc->bRTSEnable = false;
 			break;
-- 
2.41.0

