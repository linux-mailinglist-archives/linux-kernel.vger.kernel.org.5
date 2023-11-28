Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D907FC209
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346221AbjK1Oax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346200AbjK1OUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:20:22 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED78D64
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:20:28 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id C77045C01DC;
        Tue, 28 Nov 2023 09:20:27 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 28 Nov 2023 09:20:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1701181227; x=
        1701267627; bh=wUnayjmA/sOeM/Grko2VTpHkJJo8kIBAYmK/s8vG5Bg=; b=i
        og2GnV0HcoL6NN/dHW+eAPPzf5usP8KI5ADbXGe9IVKJpf0VuzPTbz22Gek+Of/O
        YtUvRwCydBYpQvFL6u5X2sRbMFLATwbUst3EEMoY/+aQWP0AvtlfJB5U/EPvfUFV
        HUi9f7Onm+OQncYdbqfjbJTM2yhTvZBUYd2Zga2RdtUgenlld+jjFbJbgMUA9UIy
        rPC9TUSit05WiMQo54CsF2piSdkLPlkp1Mg+rsCCadw1kyaiTEbSfniewC9a3HFo
        QY0nvt6xDI0jo50fORSxevD5XUv3oxWxjXCTOartiYeKUqIaT+eSszMWBJlkneKP
        TLj23ZFNuRlkWBMufrQ5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1701181227; x=
        1701267627; bh=wUnayjmA/sOeM/Grko2VTpHkJJo8kIBAYmK/s8vG5Bg=; b=D
        +mHufesiXQHMGOejo7gegEmjr1/OfR5CU1QVMJJ6WgvQID5D6vqMP53GacWNabRK
        Bkq/zEzgv4ZqxFbeehUfMbyuEMKM2s1DWX89d1alHgrs/9B0FkAKE3XOdkj/RlKu
        gnhWiUyexP7jdYGjGP4WERUS+Et/nUTfg5Il6fjwOZcPDnWMChjODUR4ibRryDEB
        AAOkXMNmUaAD++CYZZX5u3CTGQDbdP2qdwb92NqdSQTNqahysHl3NX3N+N7eqzSn
        0A7NOBSUZYnOtiXz08BGDGaPU25L0Vyj87ovFG7mKmVh1kmHe7MBgHlEPnPbFiN1
        pMOIX4YOJ/6g8pxX3b+bA==
X-ME-Sender: <xms:K_dlZX-DxR9qcFItgwwWGu3A2eimtZB9Dsqcf8R9FE3U7tcq2XvS2w>
    <xme:K_dlZTszR55bD3V-0wAE96X14ThmYQutLDY9EsYNnyekMxuEbv1OxnIG7_TkpIsKr
    Uz7elImNmCpoqF33wE>
X-ME-Received: <xmr:K_dlZVAqHLje4WlIyIBSPNtbZU2oOL41i2ktdwFu33mgGfFFGOQb18W6jZ-pxQi8aG51ULZhK5TlZQ_rqqdMiq0fe-66-uOdQF6cGMVRyYnl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeifedgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:K_dlZTdQpVi0KXnyJR3ZoxwXj82WFDJrDt5lnVV5JAtiJaJHwhpb-w>
    <xmx:K_dlZcNVbCU-W70bwDoMVekskhymMZ8wQqJ8OX83w8A8eL8WdyQOXw>
    <xmx:K_dlZVlS2O770_DiDD_4CIGQz27SaRzyUVd-GEQBie0eyqZwb6S5zw>
    <xmx:K_dlZRpKjThcC4WiUweuySsxvkteVE9Lx4-BxvInIAiY5SD-VtdpuA>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Nov 2023 09:20:27 -0500 (EST)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH v2 2/3] staging: rtl8192e: renamed variable bCurBW40MHz
Date:   Tue, 28 Nov 2023 09:20:26 -0500
Message-ID: <20231128142027.15617-3-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231128142027.15617-1-garyrookard@fastmail.org>
References: <20231128142027.15617-1-garyrookard@fastmail.org>
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

v2: Renamed from CamelCase to Snake case the variable bCurBW40MHz,
and addionally removed the Hungarian notation (n) that [v1] did not.
bCurBW40MHz -> cur_bw_40mhz

Linux kernel coding style (cleanup), checkpatch Avoid CamelCase.
Driver/module rtl8192e compiles.

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
v2: Removes Hungarian notation.
v1: Renamed from CamelCase only, Hungarian notation unremoved.

 drivers/staging/rtl8192e/rtl819x_HT.h        |  2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c    | 16 ++++++++--------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c |  4 ++--
 drivers/staging/rtl8192e/rtllib_tx.c         | 10 +++++-----
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index a4fe72943b36..dd86faab6f53 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -95,7 +95,7 @@ struct rt_hi_throughput {
 	u8 enable_ht;
 	u8 current_ht_support;
 	u8 bRegBW40MHz;
-	u8 bCurBW40MHz;
+	u8 cur_bw_40mhz;
 	u8 bRegShortGI40MHz;
 	u8 bCurShortGI40MHz;
 	u8 bRegShortGI20MHz;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 4ed72936eb4a..87e96f2abed0 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -107,8 +107,8 @@ static u16 ht_mcs_to_data_rate(struct rtllib_device *ieee, u8 mcs_rate)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
-	u8	is40MHz = (ht_info->bCurBW40MHz) ? 1 : 0;
-	u8	isShortGI = (ht_info->bCurBW40MHz) ?
+	u8	is40MHz = (ht_info->cur_bw_40mhz) ? 1 : 0;
+	u8	isShortGI = (ht_info->cur_bw_40mhz) ?
 			    ((ht_info->bCurShortGI40MHz) ? 1 : 0) :
 			    ((ht_info->bCurShortGI20MHz) ? 1 : 0);
 	return MCS_DATA_RATE[is40MHz][isShortGI][(mcs_rate & 0x7f)];
@@ -559,7 +559,7 @@ void HTInitializeHTInfo(struct rtllib_device *ieee)
 
 	ht_info->current_ht_support = false;
 
-	ht_info->bCurBW40MHz = false;
+	ht_info->cur_bw_40mhz = false;
 	ht_info->cur_tx_bw40mhz = false;
 
 	ht_info->bCurShortGI20MHz = false;
@@ -705,7 +705,7 @@ static void HTSetConnectBwModeCallback(struct rtllib_device *ieee)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
-	if (ht_info->bCurBW40MHz) {
+	if (ht_info->cur_bw_40mhz) {
 		if (ht_info->CurSTAExtChnlOffset == HT_EXTCHNL_OFFSET_UPPER)
 			ieee->set_chan(ieee->dev,
 				       ieee->current_network.channel + 2);
@@ -750,19 +750,19 @@ void HTSetConnectBwMode(struct rtllib_device *ieee,
 			Offset = HT_EXTCHNL_OFFSET_NO_EXT;
 		if (Offset == HT_EXTCHNL_OFFSET_UPPER ||
 		    Offset == HT_EXTCHNL_OFFSET_LOWER) {
-			ht_info->bCurBW40MHz = true;
+			ht_info->cur_bw_40mhz = true;
 			ht_info->CurSTAExtChnlOffset = Offset;
 		} else {
-			ht_info->bCurBW40MHz = false;
+			ht_info->cur_bw_40mhz = false;
 			ht_info->CurSTAExtChnlOffset = HT_EXTCHNL_OFFSET_NO_EXT;
 		}
 	} else {
-		ht_info->bCurBW40MHz = false;
+		ht_info->cur_bw_40mhz = false;
 		ht_info->CurSTAExtChnlOffset = HT_EXTCHNL_OFFSET_NO_EXT;
 	}
 
 	netdev_dbg(ieee->dev, "%s():ht_info->bCurBW40MHz:%x\n", __func__,
-		   ht_info->bCurBW40MHz);
+		   ht_info->cur_bw_40mhz);
 
 	ht_info->sw_bw_in_progress = true;
 
diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index 28aba1d610f7..b48c89d2e7bf 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -318,10 +318,10 @@ void rtllib_wx_sync_scan_wq(void *data)
 	ieee->ScanOperationBackupHandler(ieee->dev, SCAN_OPT_BACKUP);
 
 	if (ieee->ht_info->current_ht_support && ieee->ht_info->enable_ht &&
-	    ieee->ht_info->bCurBW40MHz) {
+	    ieee->ht_info->cur_bw_40mhz) {
 		b40M = 1;
 		chan_offset = ieee->ht_info->CurSTAExtChnlOffset;
-		bandwidth = (enum ht_channel_width)ieee->ht_info->bCurBW40MHz;
+		bandwidth = (enum ht_channel_width)ieee->ht_info->cur_bw_40mhz;
 		ieee->set_bw_mode_handler(ieee->dev, HT_CHANNEL_WIDTH_20,
 				       HT_EXTCHNL_OFFSET_NO_EXT);
 	}
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 1da098f5b84c..a79f9d8c9162 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -362,9 +362,9 @@ static void rtllib_query_HTCapShortGI(struct rtllib_device *ieee,
 		return;
 	}
 
-	if (ht_info->bCurBW40MHz && ht_info->bCurShortGI40MHz)
+	if (ht_info->cur_bw_40mhz && ht_info->bCurShortGI40MHz)
 		tcb_desc->bUseShortGI = true;
-	else if (!ht_info->bCurBW40MHz && ht_info->bCurShortGI20MHz)
+	else if (!ht_info->cur_bw_40mhz && ht_info->bCurShortGI20MHz)
 		tcb_desc->bUseShortGI = true;
 }
 
@@ -383,7 +383,7 @@ static void rtllib_query_BandwidthMode(struct rtllib_device *ieee,
 
 	if ((tcb_desc->data_rate & 0x80) == 0)
 		return;
-	if (ht_info->bCurBW40MHz && ht_info->cur_tx_bw40mhz &&
+	if (ht_info->cur_bw_40mhz && ht_info->cur_tx_bw40mhz &&
 	    !ieee->bandwidth_auto_switch.bforced_tx20Mhz)
 		tcb_desc->bPacketBW = true;
 }
@@ -441,9 +441,9 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 		if (ht_info->current_ht_support && ht_info->enable_ht) {
 			u8 HTOpMode = ht_info->current_op_mode;
 
-			if ((ht_info->bCurBW40MHz && (HTOpMode == 2 ||
+			if ((ht_info->cur_bw_40mhz && (HTOpMode == 2 ||
 						      HTOpMode == 3)) ||
-			     (!ht_info->bCurBW40MHz && HTOpMode == 3)) {
+			     (!ht_info->cur_bw_40mhz && HTOpMode == 3)) {
 				tcb_desc->rts_rate = MGN_24M;
 				tcb_desc->bRTSEnable = true;
 				break;
-- 
2.41.0

