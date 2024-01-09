Return-Path: <linux-kernel+bounces-20327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC86B827D5F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32BA01F248D2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3814422;
	Tue,  9 Jan 2024 03:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="YrGmcy1m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="8Y4oJnto"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE14259D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 03:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id CD8515C0301;
	Mon,  8 Jan 2024 22:32:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 08 Jan 2024 22:32:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1704771158; x=1704857558; bh=GA/6l5C2ZLdlHTJQ6KRAJ
	qf5de3wrvXX2Aj1i+fXNAo=; b=YrGmcy1mAWCOUxZfsEbSBK6xYsBFQfD8wHhMP
	dEJWj3tkXNJH1+WJ9qjsC+8aeZwjukKVO9LRro4GOqJViC71M3HwOYydymFrJcSK
	lyYZJcIsirckn3SDOhJm9t7Emf7OzrDQSTAqdWbBZqD0oZvt8NfSVNfM4fx8SHTG
	Gs37k/DpkVuvNWZ3fCyAGPl+o+W/Rqgmr4LVl9OO8nmVKheIERXgjYmrqXkut2iD
	KY1B9sNzTLA3xbSsB8gmh3k63itmXBrOnJbuXAjan11gWGb7SFxi8oXWiUsvLuum
	HhZPqypjQMCLSj4C+MtNyPKVxHhDOGUa4FJBtFhhRKV/Fff0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704771158; x=1704857558; bh=GA/6l5C2ZLdlHTJQ6KRAJqf5de3w
	rvXX2Aj1i+fXNAo=; b=8Y4oJntoliS40R7tyQ6BaJVGJsPUWW0bo/uZjci2hbFO
	d/yGyZi6p1xPohCuF6y0vWvUkkunEACufFgoxdHfomT5YQzLd6477+Ws56vZFQ0P
	uE0qEIu3McSghNTRV+zssyuPg/8fqCqWqwKLmTEeAEoLQbzvIbwhdpMc3iXwncdT
	RD0DBLmYfAxbEZPHhlA5g0F2R2S7xA1PMt2vjsO4LqaLLflhBpnxKQamlpm4f+oR
	Mhgu0jaWeYwF/ZZIDVQMCXDQUrfRR6NcElGWFqda0te0AjSCcVyzHeVETXmTRHEE
	yBMbEcXJBQwvW7x9ulc69v9Qosec3IQ8RheOfYqz0g==
X-ME-Sender: <xms:Vr6cZVSfKuW1cJ02HRHnH_RrjBLhD_N21MACofvzL3q07MlL2KLUMg>
    <xme:Vr6cZexqsd-H0Hkc8OplFufw3wjzsQ2APcBCZw9cQpVrXVrEFt34xM_HW0rbWRsXp
    hoE1kmuY_7SHAGZPt8>
X-ME-Received: <xmr:Vr6cZa3mitVitNYXuwiMoBDPP7ME5hdUbAmCKnIAxkWEkas_aQfaHwXd-PoM_LfbQm_UgZZwTMz2O3DkFZLYq4kFOs_W9Mk0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehkedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgrrhgu
    sehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepleegffffgfehhfejge
    ejheeivdfgleefheeuueetkedtffeihfevlefhgeevvdevnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfhgrsh
    htmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:Vr6cZdARw6kPxPx4Zs17ajCJLGryc2ndB7_KFTKcG1-EwjmVKFm7dQ>
    <xmx:Vr6cZeg5E5Izwc70Vogb9bkC9k4D-wuvKISWD8Vcucz1_kV8jZxufw>
    <xmx:Vr6cZRq0_IpJtDpUJ52AMDf6bjufZJTbGZKpsY0R3i6BTjFjLBbcRA>
    <xmx:Vr6cZfvC2fHbAVNPRR0pmpY8AxUFXSERROP495qv0X6CWiLADfETfg>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jan 2024 22:32:38 -0500 (EST)
From: Gary Rookard <garyrookard@fastmail.org>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH v4] staging: rtl8192e: rename variable cur_bw_40mhz
Date: Mon,  8 Jan 2024 22:32:34 -0500
Message-ID: <20240109033234.570-1-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes from v3 include
Rename from  millihertz(mhz) Megahertz(MHz)
cur_bw_40mhz -> cur_bw_40MHz

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
v4: Corrects mislablelling, millihertz(mhz) -> Megahertz(MHz)
v3: Corrects commit message style issues.
v2: Style issues, redo.
v1: Style issues, redo.
 drivers/staging/rtl8192e/rtl819x_HT.h        |  2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c    | 16 ++++++++--------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c |  4 ++--
 drivers/staging/rtl8192e/rtllib_tx.c         | 10 +++++-----
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 68577bffb936..50e6d010abaa 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -94,7 +94,7 @@ enum ht_aggre_mode {
 struct rt_hi_throughput {
 	u8 enable_ht;
 	u8 current_ht_support;
-	u8 cur_bw_40mhz;
+	u8 cur_bw_40MHz;
 	u8 cur_short_gi_40mhz;
 	u8 cur_short_gi_20mhz;
 	enum ht_spec_ver peer_ht_spec_ver;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 6d0912f90198..0f8112af76e8 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -87,8 +87,8 @@ static u16 ht_mcs_to_data_rate(struct rtllib_device *ieee, u8 mcs_rate)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
-	u8	is40MHz = (ht_info->cur_bw_40mhz) ? 1 : 0;
-	u8	isShortGI = (ht_info->cur_bw_40mhz) ?
+	u8	is40MHz = (ht_info->cur_bw_40MHz) ? 1 : 0;
+	u8	isShortGI = (ht_info->cur_bw_40MHz) ?
 			    ((ht_info->cur_short_gi_40mhz) ? 1 : 0) :
 			    ((ht_info->cur_short_gi_20mhz) ? 1 : 0);
 	return MCS_DATA_RATE[is40MHz][isShortGI][(mcs_rate & 0x7f)];
@@ -507,7 +507,7 @@ void ht_initialize_ht_info(struct rtllib_device *ieee)
 
 	ht_info->current_ht_support = false;
 
-	ht_info->cur_bw_40mhz = false;
+	ht_info->cur_bw_40MHz = false;
 	ht_info->cur_tx_bw40mhz = false;
 
 	ht_info->cur_short_gi_20mhz = false;
@@ -637,7 +637,7 @@ static void ht_set_connect_bw_mode_callback(struct rtllib_device *ieee)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
-	if (ht_info->cur_bw_40mhz) {
+	if (ht_info->cur_bw_40MHz) {
 		if (ht_info->CurSTAExtChnlOffset == HT_EXTCHNL_OFFSET_UPPER)
 			ieee->set_chan(ieee->dev,
 				       ieee->current_network.channel + 2);
@@ -679,19 +679,19 @@ void ht_set_connect_bw_mode(struct rtllib_device *ieee,
 			Offset = HT_EXTCHNL_OFFSET_NO_EXT;
 		if (Offset == HT_EXTCHNL_OFFSET_UPPER ||
 		    Offset == HT_EXTCHNL_OFFSET_LOWER) {
-			ht_info->cur_bw_40mhz = true;
+			ht_info->cur_bw_40MHz = true;
 			ht_info->CurSTAExtChnlOffset = Offset;
 		} else {
-			ht_info->cur_bw_40mhz = false;
+			ht_info->cur_bw_40MHz = false;
 			ht_info->CurSTAExtChnlOffset = HT_EXTCHNL_OFFSET_NO_EXT;
 		}
 	} else {
-		ht_info->cur_bw_40mhz = false;
+		ht_info->cur_bw_40MHz = false;
 		ht_info->CurSTAExtChnlOffset = HT_EXTCHNL_OFFSET_NO_EXT;
 	}
 
 	netdev_dbg(ieee->dev, "%s():ht_info->bCurBW40MHz:%x\n", __func__,
-		   ht_info->cur_bw_40mhz);
+		   ht_info->cur_bw_40MHz);
 
 	ht_info->sw_bw_in_progress = true;
 
diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index 2afa701e5445..0eb309f28c23 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -317,10 +317,10 @@ void rtllib_wx_sync_scan_wq(void *data)
 	ieee->ScanOperationBackupHandler(ieee->dev, SCAN_OPT_BACKUP);
 
 	if (ieee->ht_info->current_ht_support && ieee->ht_info->enable_ht &&
-	    ieee->ht_info->cur_bw_40mhz) {
+	    ieee->ht_info->cur_bw_40MHz) {
 		b40M = 1;
 		chan_offset = ieee->ht_info->CurSTAExtChnlOffset;
-		bandwidth = (enum ht_channel_width)ieee->ht_info->cur_bw_40mhz;
+		bandwidth = (enum ht_channel_width)ieee->ht_info->cur_bw_40MHz;
 		ieee->set_bw_mode_handler(ieee->dev, HT_CHANNEL_WIDTH_20,
 				       HT_EXTCHNL_OFFSET_NO_EXT);
 	}
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index f7098a2ba8b0..dfbccd77538b 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -340,9 +340,9 @@ static void rtllib_query_HTCapShortGI(struct rtllib_device *ieee,
 	if (!ht_info->current_ht_support || !ht_info->enable_ht)
 		return;
 
-	if (ht_info->cur_bw_40mhz && ht_info->cur_short_gi_40mhz)
+	if (ht_info->cur_bw_40MHz && ht_info->cur_short_gi_40mhz)
 		tcb_desc->bUseShortGI = true;
-	else if (!ht_info->cur_bw_40mhz && ht_info->cur_short_gi_20mhz)
+	else if (!ht_info->cur_bw_40MHz && ht_info->cur_short_gi_20mhz)
 		tcb_desc->bUseShortGI = true;
 }
 
@@ -361,7 +361,7 @@ static void rtllib_query_BandwidthMode(struct rtllib_device *ieee,
 
 	if ((tcb_desc->data_rate & 0x80) == 0)
 		return;
-	if (ht_info->cur_bw_40mhz && ht_info->cur_tx_bw40mhz &&
+	if (ht_info->cur_bw_40MHz && ht_info->cur_tx_bw40mhz &&
 	    !ieee->bandwidth_auto_switch.bforced_tx20Mhz)
 		tcb_desc->bPacketBW = true;
 }
@@ -419,9 +419,9 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 		if (ht_info->current_ht_support && ht_info->enable_ht) {
 			u8 HTOpMode = ht_info->current_op_mode;
 
-			if ((ht_info->cur_bw_40mhz && (HTOpMode == 2 ||
+			if ((ht_info->cur_bw_40MHz && (HTOpMode == 2 ||
 						      HTOpMode == 3)) ||
-			     (!ht_info->cur_bw_40mhz && HTOpMode == 3)) {
+			     (!ht_info->cur_bw_40MHz && HTOpMode == 3)) {
 				tcb_desc->rts_rate = MGN_24M;
 				tcb_desc->bRTSEnable = true;
 				break;
-- 
2.43.0


