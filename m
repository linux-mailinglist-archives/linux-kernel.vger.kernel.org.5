Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9674A7F8FD5
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 23:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjKYWen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 17:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjKYWek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 17:34:40 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6032311B
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 14:34:46 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id CAE9E5C0117;
        Sat, 25 Nov 2023 17:34:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 25 Nov 2023 17:34:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1700951685; x=
        1701038085; bh=hA1LldQ2kqUSciH6ZS5YKPp5CEt1y2lK2c/ypEYCoDc=; b=C
        0yby/o+kcRyWAiDnpp22W4dERtEjKiDScdL0FZ5I45tzNNbOtaR6MMeGXgrQ/DhD
        nt/ied6QwL403IkUFyC6/yHlU7BdCPV1asBkqn5Md/yQOWsjnIADeMVBFddbQtl+
        go0zA8kcoDTZIh+I0OhLsPGmscp29NKPtGAnTi8CRs3ibODJWiWoT6IXv1bBpY7r
        kRlBb0m5gK9ddi3aVzOWUTbgQ2V03nz1bE1yPVWIoGsxEF6zHK4Wg01h3/tZEYoe
        tyIVBdHtz3v6rtP4ZqfcwWgt6WwI53j0+28ah2NrO5hKG6TU5Adu+/Bl1aK6eYPN
        h0UeT8cgusANeUDIc0EIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1700951685; x=
        1701038085; bh=hA1LldQ2kqUSciH6ZS5YKPp5CEt1y2lK2c/ypEYCoDc=; b=V
        j0QA48i3SILZHBn7IkwFybXL3E+vCN21nT4GktfTTo65SVY/8jfcWXtl5mjfCbsO
        Ol9eghLLDfcsPdFWfjdD31Bg5MVpcHrUM8JIBYIPhxl/1Mb/zpR+//AMWtHvt/Hb
        irrPMGFJDNfKF4YusvG7kRL0RhiVi+qb0QTR8tPRIGzO8OIi1lmjXegyl4sbyCMJ
        0nY8OI/dMheO4qWz7l6Ytvj3GEHTZQMkqko4XybGaCEYH3yuV00KbdekY2GY6F3j
        D5yifra0x2cvvAyCF3ExD3V4mVFWthafEx6fYs8jmXWsE0e5KGK6SWHLFU06EyvU
        6ANeDmVVNA2foU0kq02Ng==
X-ME-Sender: <xms:hXZiZTGnMcNU3Lr-2AKVoz9p7KNWVfZf8m25Hzgc8NxANCRftbjqbA>
    <xme:hXZiZQVSfJ9iP5Scb1bwLal_oU81s5oQcqPt_JrpuK0LYVk_FVSCYhYAgNB2Xkfyx
    5qoM-wQUQ5pOHBUGSM>
X-ME-Received: <xmr:hXZiZVLCm4Ppnm4pMaF3Xa-jbte60Kryf-TkbSlyDnldYITuZDukQdqZtdMUYjpr2Q3t0mHsVG6CS6d1aGyQTGd_HZUkLeSGq_v2kZnP4wB5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehjedgudeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestd
    ekredtredttdenucfhrhhomhepifgrrhihucftohhokhgrrhguuceoghgrrhihrhhoohhk
    rghrugesfhgrshhtmhgrihhlrdhorhhgqeenucggtffrrghtthgvrhhnpeekuedvffeuud
    ekgeeiueffjeehgfekteefheeuleefudeugfevleelhfefgfejvdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrghrhihrohhokhgrrhguse
    hfrghsthhmrghilhdrohhrgh
X-ME-Proxy: <xmx:hXZiZRHVYn6bWFbsJv4YRKPptPMqgNa_12EPw2pzDBzBD1h9YawORQ>
    <xmx:hXZiZZXCcQEyohAxBibl6G9b27YbmDoMEKVAH2gXmV8sK07qLu9YRg>
    <xmx:hXZiZcNThOrYCcsLm1Q3S9rqTqGxR5c-68nCje0S8YwrZzuhZ3Bo3A>
    <xmx:hXZiZcRO7Ij-d3A2wIdAlD31zCby1rNylZeWU84JFRVaiEwPfnH7tQ>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Nov 2023 17:34:45 -0500 (EST)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 3/5] staging: rtl8192e: renamed variable bCurBW40MHz
Date:   Sat, 25 Nov 2023 17:34:30 -0500
Message-ID: <20231125223432.13780-4-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231125223432.13780-1-garyrookard@fastmail.org>
References: <20231125223432.13780-1-garyrookard@fastmail.org>
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

Renamed from CamelCase to Snake case the variable bCurBW40MHz.
bCurBW40MHz -> b_cur_bw_40mhz

Linux kernel coding style (cleanup), checkpatch Avoid CamelCase.
Driver/module rtl8192e compiles.

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HT.h        |  2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c    | 16 ++++++++--------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c |  4 ++--
 drivers/staging/rtl8192e/rtllib_tx.c         | 10 +++++-----
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index f8eb4d553fe0..e24b106ca700 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -95,7 +95,7 @@ struct rt_hi_throughput {
 	u8 enable_ht;
 	u8 current_ht_support;
 	u8 bRegBW40MHz;
-	u8 bCurBW40MHz;
+	u8 b_cur_bw_40mhz;
 	u8 bRegShortGI40MHz;
 	u8 bCurShortGI40MHz;
 	u8 bRegShortGI20MHz;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index f002d948a316..f4de5ad7d9d1 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -107,8 +107,8 @@ static u16 ht_mcs_to_data_rate(struct rtllib_device *ieee, u8 n_mcs_rate)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
-	u8	is40MHz = (ht_info->bCurBW40MHz) ? 1 : 0;
-	u8	is_short_gi = (ht_info->bCurBW40MHz) ?
+	u8	is40MHz = (ht_info->b_cur_bw_40mhz) ? 1 : 0;
+	u8	is_short_gi = (ht_info->b_cur_bw_40mhz) ?
 			    ((ht_info->bCurShortGI40MHz) ? 1 : 0) :
 			    ((ht_info->bCurShortGI20MHz) ? 1 : 0);
 	return MCS_DATA_RATE[is40MHz][is_short_gi][(n_mcs_rate & 0x7f)];
@@ -575,7 +575,7 @@ void HTInitializeHTInfo(struct rtllib_device *ieee)
 
 	ht_info->current_ht_support = false;
 
-	ht_info->bCurBW40MHz = false;
+	ht_info->b_cur_bw_40mhz = false;
 	ht_info->cur_tx_bw40mhz = false;
 
 	ht_info->bCurShortGI20MHz = false;
@@ -721,7 +721,7 @@ static void HTSetConnectBwModeCallback(struct rtllib_device *ieee)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
-	if (ht_info->bCurBW40MHz) {
+	if (ht_info->b_cur_bw_40mhz) {
 		if (ht_info->CurSTAExtChnlOffset == HT_EXTCHNL_OFFSET_UPPER)
 			ieee->set_chan(ieee->dev,
 				       ieee->current_network.channel + 2);
@@ -766,19 +766,19 @@ void HTSetConnectBwMode(struct rtllib_device *ieee,
 			Offset = HT_EXTCHNL_OFFSET_NO_EXT;
 		if (Offset == HT_EXTCHNL_OFFSET_UPPER ||
 		    Offset == HT_EXTCHNL_OFFSET_LOWER) {
-			ht_info->bCurBW40MHz = true;
+			ht_info->b_cur_bw_40mhz = true;
 			ht_info->CurSTAExtChnlOffset = Offset;
 		} else {
-			ht_info->bCurBW40MHz = false;
+			ht_info->b_cur_bw_40mhz = false;
 			ht_info->CurSTAExtChnlOffset = HT_EXTCHNL_OFFSET_NO_EXT;
 		}
 	} else {
-		ht_info->bCurBW40MHz = false;
+		ht_info->b_cur_bw_40mhz = false;
 		ht_info->CurSTAExtChnlOffset = HT_EXTCHNL_OFFSET_NO_EXT;
 	}
 
 	netdev_dbg(ieee->dev, "%s():ht_info->bCurBW40MHz:%x\n", __func__,
-		   ht_info->bCurBW40MHz);
+		   ht_info->b_cur_bw_40mhz);
 
 	ht_info->sw_bw_in_progress = true;
 
diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index 28aba1d610f7..255867334be0 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -318,10 +318,10 @@ void rtllib_wx_sync_scan_wq(void *data)
 	ieee->ScanOperationBackupHandler(ieee->dev, SCAN_OPT_BACKUP);
 
 	if (ieee->ht_info->current_ht_support && ieee->ht_info->enable_ht &&
-	    ieee->ht_info->bCurBW40MHz) {
+	    ieee->ht_info->b_cur_bw_40mhz) {
 		b40M = 1;
 		chan_offset = ieee->ht_info->CurSTAExtChnlOffset;
-		bandwidth = (enum ht_channel_width)ieee->ht_info->bCurBW40MHz;
+		bandwidth = (enum ht_channel_width)ieee->ht_info->b_cur_bw_40mhz;
 		ieee->set_bw_mode_handler(ieee->dev, HT_CHANNEL_WIDTH_20,
 				       HT_EXTCHNL_OFFSET_NO_EXT);
 	}
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 9bf679438ad1..a74b92de024e 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -362,9 +362,9 @@ static void rtllib_query_HTCapShortGI(struct rtllib_device *ieee,
 		return;
 	}
 
-	if (ht_info->bCurBW40MHz && ht_info->bCurShortGI40MHz)
+	if (ht_info->b_cur_bw_40mhz && ht_info->bCurShortGI40MHz)
 		tcb_desc->bUseShortGI = true;
-	else if (!ht_info->bCurBW40MHz && ht_info->bCurShortGI20MHz)
+	else if (!ht_info->b_cur_bw_40mhz && ht_info->bCurShortGI20MHz)
 		tcb_desc->bUseShortGI = true;
 }
 
@@ -383,7 +383,7 @@ static void rtllib_query_BandwidthMode(struct rtllib_device *ieee,
 
 	if ((tcb_desc->data_rate & 0x80) == 0)
 		return;
-	if (ht_info->bCurBW40MHz && ht_info->cur_tx_bw40mhz &&
+	if (ht_info->b_cur_bw_40mhz && ht_info->cur_tx_bw40mhz &&
 	    !ieee->bandwidth_auto_switch.bforced_tx20Mhz)
 		tcb_desc->bPacketBW = true;
 }
@@ -441,9 +441,9 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 		if (ht_info->current_ht_support && ht_info->enable_ht) {
 			u8 HTOpMode = ht_info->current_op_mode;
 
-			if ((ht_info->bCurBW40MHz && (HTOpMode == 2 ||
+			if ((ht_info->b_cur_bw_40mhz && (HTOpMode == 2 ||
 						      HTOpMode == 3)) ||
-			     (!ht_info->bCurBW40MHz && HTOpMode == 3)) {
+			     (!ht_info->b_cur_bw_40mhz && HTOpMode == 3)) {
 				tcb_desc->rts_rate = MGN_24M;
 				tcb_desc->bRTSEnable = true;
 				break;
-- 
2.41.0

