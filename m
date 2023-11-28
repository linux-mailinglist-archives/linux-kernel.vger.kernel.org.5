Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2EE7FC2ED
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344751AbjK1SRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 13:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234849AbjK1SRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 13:17:20 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CBD198D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 10:17:26 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id BF7455C0206;
        Tue, 28 Nov 2023 13:17:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 28 Nov 2023 13:17:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1701195445; x=
        1701281845; bh=QyA4RMn8/txYq9pB/6ofEzbBbltRNdrvYu4fi2NIbkU=; b=c
        BRKsTb9QHy/vwk4Og18WZ5TOKosla44oavu2rvz18SzxkHqDwjMJs2qBg7W18uzK
        drx4rxL3Pyj47eRwfdJIQNC0GVJuBDlq1Of3mEjViliu0gmYRj8wE3cxs4aRtXum
        cF7WwNcYg2fmH5Ko6zkuseMM7E4mCycXYlxN7kG4aSd3iDx/Mr7ABOCTaZW+C0P9
        ILisV9sITTaPq5Lql0OqyVpAqRN0SWmgT6jnTzXftqPntPCtqpwdOR8yxoGpFULJ
        H0DLQl1x9CcuV448j4DuGROjs+Ku+HsLercr2mKKRbh/xTQ2rTWTD9NlEsLcFuo8
        Jkq/+CiwmD0fFK05MZ3Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1701195445; x=
        1701281845; bh=QyA4RMn8/txYq9pB/6ofEzbBbltRNdrvYu4fi2NIbkU=; b=H
        KHyQvDLorNTAissGFSYFaAGzEzH0sIumTSKfEUUFyq+0wtDMeOoQxE4hzRi0J//6
        JLezu2mC9ft2BIonvKzYBJX1pbM9q8mxw/VRO8/U/nDWqpNaKtXRMPO1gzkTJ00Y
        f6Qdil60pgSTNC0dRPBFt87muoDN5RlAti5g2upk9ZoPmgFc/kMba4iMUdVVu7uv
        aFf3UXHcKJGDaUse2e9QhXm9WUCCkvk8Qx8zX+v1GpT7ExUxZJMa7NClnL7jfP3X
        CqlWsJXLVc6gFzegj+nJZgtXcEemEeucyDegdz0yC1CeQKz99MzQ/mTXelw/up6k
        a4vhQmwJljT7L7R9rM+sA==
X-ME-Sender: <xms:tS5mZWoBGei5d7ztjeREgyixQPrmIj7vLIZywrDbqVDzQJMgQIz8lA>
    <xme:tS5mZUrymMv8-1fMly6dXzdfG6gMiZPEa8H7m3JhHBb9uIp7-VgIJHFCY1QgTXwUx
    99kDfv4mZSATEwjRi4>
X-ME-Received: <xmr:tS5mZbP9ZZleediERdN9kTNIiJDgQEtITyAEVZxHou5dKGOtP9efEwqesFOSaRDjaPZGi5gzQ98Zi8bVtlbj9JUCMXY5EasUjgCfzqvjWTpH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeifedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestd
    ekredtredttdenucfhrhhomhepifgrrhihucftohhokhgrrhguuceoghgrrhihrhhoohhk
    rghrugesfhgrshhtmhgrihhlrdhorhhgqeenucggtffrrghtthgvrhhnpeekuedvffeuud
    ekgeeiueffjeehgfekteefheeuleefudeugfevleelhfefgfejvdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrghrhihrohhokhgrrhguse
    hfrghsthhmrghilhdrohhrgh
X-ME-Proxy: <xmx:tS5mZV5DQ1K9OM2leVuU9kfC5_-Iq_A2PywGzYwfqRgFoUppTOGzVQ>
    <xmx:tS5mZV7nFVDanUefJAYzKxNSnW7P9a64vUH1-V4szKCObaBW_Gv8qA>
    <xmx:tS5mZViTwBYYPd5AHQq6tgr6JPXwtH3eBS0cAKwxCg8bBfl0Bs3-ww>
    <xmx:tS5mZfkLt2MSHDG8V-pzGwFPvf2FdxNiaGxQzjG0-5ry05rrE3QrGA>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Nov 2023 13:17:25 -0500 (EST)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH v3 2/3] staging: rtl8192e: renamed variable bCurBW40MHz
Date:   Tue, 28 Nov 2023 13:17:26 -0500
Message-ID: <20231128181727.19504-3-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231128181727.19504-1-garyrookard@fastmail.org>
References: <20231128181727.19504-1-garyrookard@fastmail.org>
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
rename it bCurBW40MHz -> cur_bw_40mhz.

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
v3: Corrects commit message style issues.
v2: Style issues, redo.
v1: Style issues, redo.

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

