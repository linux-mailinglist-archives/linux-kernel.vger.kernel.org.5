Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C041F8098ED
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 02:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572965AbjLHB57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 20:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572967AbjLHB56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 20:57:58 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2ED172A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 17:58:03 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id E878C5C0196;
        Thu,  7 Dec 2023 20:58:02 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 07 Dec 2023 20:58:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1702000682; x=1702087082; bh=g9WdJ4WPYl
        AyFqWitCmXhTNa1UUs0fuQm3YH1CTd4KE=; b=AnmyvHwN5339kwluYcJ7l4qwmK
        N2GSZfpiHCTdfMmwtHV4mFXWJ6PmsMXC0yLJVogg0pbgWt4J9M2Fz0vTlx60m0/N
        pKiOX/kE/txOOPDhfnr/tYjoqOOmNiXJ+Oclzdcf4rImTCsO3DnywGOFESPw7P/P
        YlIS/GXFthY7kSVr1sHSEJ7y//mwcRsRD9hsV6+3RfZCwrs2d9f65Rj8MPu5r2sm
        dNhOeU4HPpmueVjr2z/PbIgsyEiGP4SXs+0lKJOwxXnBbpmqnuPttsOhlLYbudJp
        LZE7GxCj5EyeiaoKu0/teSh64dglwGSxo68aDVeANFCXvE8m/E5H7JjzKeyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1702000682; x=1702087082; bh=g9WdJ4WPYlAyF
        qWitCmXhTNa1UUs0fuQm3YH1CTd4KE=; b=Vy0MwEcdWHRYOu1DHZ2+wqtABZk+r
        aLYynSNJG7ykIRs8tJMREXJR+SwZD1gU2hKLPd6Oj89L7EWO+OiLIPso1P5DTpcs
        z6zxCfhvw8fdB2zLiYed4VW6LS85dGnfxQ/I2Wy1rKo4iToo+b4zHxogNKHnTfqu
        Rqd+Ua9+54uXFlwld8Z2s5rcNwWrWaHwyU82EH/CpzXgMEHFrSI/CQpHdVPTN1/x
        AvcrX232ANyvb0IKAOVFcuJfhJolyB+P8WJXO3l9nX5z/M5TPqsqsltoz8GE4azu
        cJ0VDZ6T8GYzcWaqnPg3sWyNIA9GL3cjGwfFGf6yHKj5y/R2kvcKU7YaQ==
X-ME-Sender: <xms:KnhyZfI3lu0B_C6YXqjCTlTWcJH6Jr7fXeMkyS6j9w6ngusdtuSFBw>
    <xme:KnhyZTJaR9YmYF7oPokGEl8Sj8D2UNRJaoRjLGHj0vtLMspbMqEzJ_PJDyWi80GH-
    VjVkL2LZn_N0u_WjFM>
X-ME-Received: <xmr:KnhyZXur4tAADbQF4RaXXlmrD40Ypb22tPFOyJeAkJYCdPfULvlinYw8ZlqL4WWy0Ti4-7iZancpzu9HM3qdTa77l-c_XDKUqUk9vBBQUts>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekgedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgrrhgu
    sehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepleegffffgfehhfejge
    ejheeivdfgleefheeuueetkedtffeihfevlefhgeevvdevnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfhgrsh
    htmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:KnhyZYbx2prdDpW623a9Bugry-VoY1Y6dZ8s_HUzLhAJKU8ujPsM2g>
    <xmx:KnhyZWb-ArwVQkxTeB1VU6R-O33Zxaw4fF23RMSCmCbGJIAYxdVuag>
    <xmx:KnhyZcCRxDjMCDInvrcgoj7zzz6-c5NBBPhVIosarSPb_4MdsK3bcw>
    <xmx:KnhyZWFvRZ6EsFhztXrOsN3BYwsOgKROUfhIEIICShi9IVgqas0VxQ>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Dec 2023 20:58:02 -0500 (EST)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 5/5] staging: rtl8192e: renamed variable IOTPeer
Date:   Thu,  7 Dec 2023 20:58:27 -0500
Message-ID: <20231208015827.21185-1-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coding style issue, checkpatch Avoid CamelCase,
rename it. IOTPeer -> iot_peer

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 18 +++++-----
 drivers/staging/rtl8192e/rtl819x_HT.h      |  2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c  | 38 +++++++++++-----------
 3 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index e2828d57d1fd..92143c50c149 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -1142,7 +1142,7 @@ static void _rtl92e_dm_check_edca_turbo(struct net_device *dev)
 				if (priv->bis_cur_rdlstate ||
 				    !priv->bcurrent_turbo_EDCA) {
 					rtl92e_writel(dev, EDCAPARA_BE,
-						      edca_setting_UL[ht_info->IOTPeer]);
+						      edca_setting_UL[ht_info->iot_peer]);
 					priv->bis_cur_rdlstate = false;
 				}
 			} else {
@@ -1150,10 +1150,10 @@ static void _rtl92e_dm_check_edca_turbo(struct net_device *dev)
 				    !priv->bcurrent_turbo_EDCA) {
 					if (priv->rtllib->mode == WIRELESS_MODE_G)
 						rtl92e_writel(dev, EDCAPARA_BE,
-							      edca_setting_DL_GMode[ht_info->IOTPeer]);
+							      edca_setting_DL_GMode[ht_info->iot_peer]);
 					else
 						rtl92e_writel(dev, EDCAPARA_BE,
-							      edca_setting_DL[ht_info->IOTPeer]);
+							      edca_setting_DL[ht_info->iot_peer]);
 					priv->bis_cur_rdlstate = true;
 				}
 			}
@@ -1164,17 +1164,17 @@ static void _rtl92e_dm_check_edca_turbo(struct net_device *dev)
 				    !priv->bcurrent_turbo_EDCA) {
 					if (priv->rtllib->mode == WIRELESS_MODE_G)
 						rtl92e_writel(dev, EDCAPARA_BE,
-							      edca_setting_DL_GMode[ht_info->IOTPeer]);
+							      edca_setting_DL_GMode[ht_info->iot_peer]);
 					else
 						rtl92e_writel(dev, EDCAPARA_BE,
-							      edca_setting_DL[ht_info->IOTPeer]);
+							      edca_setting_DL[ht_info->iot_peer]);
 					priv->bis_cur_rdlstate = true;
 				}
 			} else {
 				if (priv->bis_cur_rdlstate ||
 				    !priv->bcurrent_turbo_EDCA) {
 					rtl92e_writel(dev, EDCAPARA_BE,
-						      edca_setting_UL[ht_info->IOTPeer]);
+						      edca_setting_UL[ht_info->iot_peer]);
 					priv->bis_cur_rdlstate = false;
 				}
 			}
@@ -1217,7 +1217,7 @@ static void _rtl92e_dm_cts_to_self(struct net_device *dev)
 		ht_info->iot_action &= ~HT_IOT_ACT_FORCED_CTS2SELF;
 		return;
 	}
-	if (ht_info->IOTPeer == HT_IOT_PEER_BROADCOM) {
+	if (ht_info->iot_peer == HT_IOT_PEER_BROADCOM) {
 		curTxOkCnt = priv->stats.txbytesunicast - lastTxOkCnt;
 		curRxOkCnt = priv->stats.rxbytesunicast - lastRxOkCnt;
 		if (curRxOkCnt > 4 * curTxOkCnt)
@@ -1713,7 +1713,7 @@ static void _rtl92e_dm_check_fsync(struct net_device *dev)
 	static u8 reg_c38_State = RegC38_Default;
 
 	if (priv->rtllib->link_state == MAC80211_LINKED &&
-	    priv->rtllib->ht_info->IOTPeer == HT_IOT_PEER_BROADCOM) {
+	    priv->rtllib->ht_info->iot_peer == HT_IOT_PEER_BROADCOM) {
 		if (priv->rtllib->bfsync_enable == 0) {
 			switch (priv->rtllib->fsync_state) {
 			case Default_Fsync:
@@ -1819,7 +1819,7 @@ static void _rtl92e_dm_dynamic_tx_power(struct net_device *dev)
 		priv->dynamic_tx_low_pwr = false;
 		return;
 	}
-	if ((priv->rtllib->ht_info->IOTPeer == HT_IOT_PEER_ATHEROS) &&
+	if ((priv->rtllib->ht_info->iot_peer == HT_IOT_PEER_ATHEROS) &&
 	    (priv->rtllib->mode == WIRELESS_MODE_G)) {
 		txhipower_threshold = TX_POWER_ATHEROAP_THRESH_HIGH;
 		txlowpower_threshold = TX_POWER_ATHEROAP_THRESH_LOW;
diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 77f28d87d3c0..c004020099e3 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -138,7 +138,7 @@ struct rt_hi_throughput {
 	u8 rx_reorder_win_size;
 	u8 rx_reorder_pending_time;
 	u16 rx_reorder_drop_counter;
-	u8 IOTPeer;
+	u8 iot_peer;
 	u32 iot_action;
 	u8 iot_ra_func;
 } __packed;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 5486b1ab4b5a..99626be899fd 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -170,41 +170,41 @@ static void ht_iot_peer_determine(struct rtllib_device *ieee)
 	struct rtllib_network *net = &ieee->current_network;
 
 	if (net->bssht.bd_rt2rt_aggregation) {
-		ht_info->IOTPeer = HT_IOT_PEER_REALTEK;
+		ht_info->iot_peer = HT_IOT_PEER_REALTEK;
 		if (net->bssht.rt2rt_ht_mode & RT_HT_CAP_USE_92SE)
-			ht_info->IOTPeer = HT_IOT_PEER_REALTEK_92SE;
+			ht_info->iot_peer = HT_IOT_PEER_REALTEK_92SE;
 		if (net->bssht.rt2rt_ht_mode & RT_HT_CAP_USE_SOFTAP)
-			ht_info->IOTPeer = HT_IOT_PEER_92U_SOFTAP;
+			ht_info->iot_peer = HT_IOT_PEER_92U_SOFTAP;
 	} else if (net->broadcom_cap_exist) {
-		ht_info->IOTPeer = HT_IOT_PEER_BROADCOM;
+		ht_info->iot_peer = HT_IOT_PEER_BROADCOM;
 	} else if (!memcmp(net->bssid, UNKNOWN_BORADCOM, 3) ||
 		 !memcmp(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3) ||
 		 !memcmp(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3)) {
-		ht_info->IOTPeer = HT_IOT_PEER_BROADCOM;
+		ht_info->iot_peer = HT_IOT_PEER_BROADCOM;
 	} else if ((memcmp(net->bssid, BELKINF5D8233V1_RALINK, 3) == 0) ||
 		 (memcmp(net->bssid, BELKINF5D82334V3_RALINK, 3) == 0) ||
 		 (memcmp(net->bssid, PCI_RALINK, 3) == 0) ||
 		 (memcmp(net->bssid, EDIMAX_RALINK, 3) == 0) ||
 		 (memcmp(net->bssid, AIRLINK_RALINK, 3) == 0) ||
 		  net->ralink_cap_exist) {
-		ht_info->IOTPeer = HT_IOT_PEER_RALINK;
+		ht_info->iot_peer = HT_IOT_PEER_RALINK;
 	} else if ((net->atheros_cap_exist) ||
 		(memcmp(net->bssid, DLINK_ATHEROS_1, 3) == 0) ||
 		(memcmp(net->bssid, DLINK_ATHEROS_2, 3) == 0)) {
-		ht_info->IOTPeer = HT_IOT_PEER_ATHEROS;
+		ht_info->iot_peer = HT_IOT_PEER_ATHEROS;
 	} else if ((memcmp(net->bssid, CISCO_BROADCOM, 3) == 0) ||
 		  net->cisco_cap_exist) {
-		ht_info->IOTPeer = HT_IOT_PEER_CISCO;
+		ht_info->iot_peer = HT_IOT_PEER_CISCO;
 	} else if ((memcmp(net->bssid, LINKSYS_MARVELL_4400N, 3) == 0) ||
 		  net->marvell_cap_exist) {
-		ht_info->IOTPeer = HT_IOT_PEER_MARVELL;
+		ht_info->iot_peer = HT_IOT_PEER_MARVELL;
 	} else if (net->airgo_cap_exist) {
-		ht_info->IOTPeer = HT_IOT_PEER_AIRGO;
+		ht_info->iot_peer = HT_IOT_PEER_AIRGO;
 	} else {
-		ht_info->IOTPeer = HT_IOT_PEER_UNKNOWN;
+		ht_info->iot_peer = HT_IOT_PEER_UNKNOWN;
 	}
 
-	netdev_dbg(ieee->dev, "IOTPEER: %x\n", ht_info->IOTPeer);
+	netdev_dbg(ieee->dev, "IOTPEER: %x\n", ht_info->iot_peer);
 }
 
 static u8 ht_iot_act_is_mgnt_use_cck_6m(struct rtllib_device *ieee,
@@ -212,7 +212,7 @@ static u8 ht_iot_act_is_mgnt_use_cck_6m(struct rtllib_device *ieee,
 {
 	u8	retValue = 0;
 
-	if (ieee->ht_info->IOTPeer == HT_IOT_PEER_BROADCOM)
+	if (ieee->ht_info->iot_peer == HT_IOT_PEER_BROADCOM)
 		retValue = 1;
 
 	return retValue;
@@ -222,7 +222,7 @@ static u8 ht_iot_act_is_ccd_fsync(struct rtllib_device *ieee)
 {
 	u8	retValue = 0;
 
-	if (ieee->ht_info->IOTPeer == HT_IOT_PEER_BROADCOM)
+	if (ieee->ht_info->iot_peer == HT_IOT_PEER_BROADCOM)
 		retValue = 1;
 	return retValue;
 }
@@ -233,7 +233,7 @@ static void HTIOTActDetermineRaFunc(struct rtllib_device *ieee, bool bPeerRx2ss)
 
 	ht_info->iot_ra_func &= HT_IOT_RAFUNC_DISABLE_ALL;
 
-	if (ht_info->IOTPeer == HT_IOT_PEER_RALINK && !bPeerRx2ss)
+	if (ht_info->iot_peer == HT_IOT_PEER_RALINK && !bPeerRx2ss)
 		ht_info->iot_ra_func |= HT_IOT_RAFUNC_PEER_1R;
 
 	if (ht_info->iot_action & HT_IOT_ACT_AMSDU_ENABLE)
@@ -243,7 +243,7 @@ static void HTIOTActDetermineRaFunc(struct rtllib_device *ieee, bool bPeerRx2ss)
 void HTResetIOTSetting(struct rt_hi_throughput *ht_info)
 {
 	ht_info->iot_action = 0;
-	ht_info->IOTPeer = HT_IOT_PEER_UNKNOWN;
+	ht_info->iot_peer = HT_IOT_PEER_UNKNOWN;
 	ht_info->iot_ra_func = 0;
 }
 
@@ -501,8 +501,8 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 	ht_info->current_ampdu_enable = ht_info->ampdu_enable;
 	if (ieee->rtllib_ap_sec_type &&
 	    (ieee->rtllib_ap_sec_type(ieee) & (SEC_ALG_WEP | SEC_ALG_TKIP))) {
-		if ((ht_info->IOTPeer == HT_IOT_PEER_ATHEROS) ||
-		    (ht_info->IOTPeer == HT_IOT_PEER_UNKNOWN))
+		if ((ht_info->iot_peer == HT_IOT_PEER_ATHEROS) ||
+		    (ht_info->iot_peer == HT_IOT_PEER_UNKNOWN))
 			ht_info->current_ampdu_enable = false;
 	}
 
@@ -590,7 +590,7 @@ void HTInitializeHTInfo(struct rtllib_device *ieee)
 	ht_info->current_rt2rt_long_slot_time = false;
 	ht_info->RT2RT_HT_Mode = (enum rt_ht_capability)0;
 
-	ht_info->IOTPeer = 0;
+	ht_info->iot_peer = 0;
 	ht_info->iot_action = 0;
 	ht_info->iot_ra_func = 0;
 
-- 
2.41.0

