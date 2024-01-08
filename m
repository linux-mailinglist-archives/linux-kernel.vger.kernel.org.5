Return-Path: <linux-kernel+bounces-19066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BB6826767
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 04:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62EC81C21874
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 03:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533FF14291;
	Mon,  8 Jan 2024 03:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="JTSLJNPY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DBXyi89U"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C4E1428A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 03:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 0771B3201200;
	Sun,  7 Jan 2024 22:23:00 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 07 Jan 2024 22:23:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1704684180; x=
	1704770580; bh=3wEPxbKkHpnRIdMmYfCvHR60EoMdiQJdirzE9v0MLlA=; b=J
	TSLJNPY4IruuLIk5k75nWDT0dMjxHp0T0mXY2kYHB+vZ+GIGk/mmw0vO7coEeGDm
	O8deDGgBLLHiuFj7l303D0de64t/M6sdjjAkJBSpCr0aFInMixDGUCFu2sKe8GNK
	P0Jabkr/iEhc64UJdlg/N139ZJFQNGpVuhcjEj+qhXHuW1DBtcb63xNZ8a6IR1Tr
	cn9EFc9qwdsGcV9qoNLUY/gAKzAytZalaE8OXwQIRc451Pxpk5RG2rAMV4p5zJJz
	PZsAhkFLiZ5gXs+4vH8eXP8LRx037LXsF/mB5OyqvrZ0pXQp/MHltj18EmwRFvSn
	dyO89RSmqm3zVsUSRNmvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1704684180; x=
	1704770580; bh=3wEPxbKkHpnRIdMmYfCvHR60EoMdiQJdirzE9v0MLlA=; b=D
	BXyi89Ue1/o8HIxsm2ApDAShq3dHn1yPBmMe2TlpYm298TEitfFjAP0JZ/ENaMs/
	AXiu513sc9PsTDqbFg4SiPvGGLLnhdsBSMrGKE1D+KeenQK01B7CeWKVUWDky3RP
	SagrU6pFPkqMuD1lr0gm8hHHapXGKvoYfzpCrJJoM/hAzt76Xf0L5xO3sRfBJCvy
	3FWXeAWpYNh/g1DxH2jvakgRf6Bn5ZwClTpJlmzshBJexZo1wDjI2C5GM/p9S7Gs
	cn+1e/DAiRTprfbtrXRUG28O7YXY7j04A6A5V4kiB3GZ7J5u4+ih0N49QBKEEWLE
	gm9JohKm5NbcEOXL2CGEA==
X-ME-Sender: <xms:lGqbZY5dQPT0Sw0dcqWVZjEzo-ZRFpCTZIexPjJj36PK7Lq1hMWPog>
    <xme:lGqbZZ6FU34M9ZKDjhswYU2N87C5ZY1Ik-xicTQqTH8TeEKkRnvWiO0He7Qqaq2kZ
    amCbMo51TXUeVnxHjI>
X-ME-Received: <xmr:lGqbZXcwpPytZe5gd2sJ6b1wXjHQOYaslYBGEj7e-k4QzsG5u21raRDYPGAPTH_ZbKw32i6HW7Luw1cI8-CCTwib27wBquZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehhedgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:lGqbZdL4Cjpy-q_Ri8lrRRabOF1EmrCOeCTdQkkceOregZOEu5gkSA>
    <xmx:lGqbZcJhFEyJ7qR_nNYZg3a6dNLBSx43cWAHdkegGG-Ohsv2_D9eIw>
    <xmx:lGqbZeyHQJAv3dO9Y25XD8L2ASjyhBHGN_HqxOuWBo8W5NP1U7uWzg>
    <xmx:lGqbZQ1_gcsiAY3snRfxupb3tNP4lL_L80GxYyqDA8Jk0hHMR0VHRw>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Jan 2024 22:22:59 -0500 (EST)
From: Gary Rookard <garyrookard@fastmail.org>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 3/5] staging: rtl8192e: rename variable retValue
Date: Sun,  7 Jan 2024 22:22:31 -0500
Message-ID: <20240108032233.4280-4-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108032233.4280-1-garyrookard@fastmail.org>
References: <20240108032233.4280-1-garyrookard@fastmail.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Coding style issue, checkpatch Avoid CamelCase,
rename it. retValue -> ret_value

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 24 +++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 43249b9cda44..fe066d39b563 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -121,7 +121,7 @@ u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 data_rate)
 
 bool is_ht_half_nmode_aps(struct rtllib_device *ieee)
 {
-	bool			retValue = false;
+	bool			ret_value = false;
 	struct rtllib_network *net = &ieee->current_network;
 
 	if ((memcmp(net->bssid, BELKINF5D8233V1_RALINK, 3) == 0) ||
@@ -130,18 +130,18 @@ bool is_ht_half_nmode_aps(struct rtllib_device *ieee)
 	    (memcmp(net->bssid, EDIMAX_RALINK, 3) == 0) ||
 	    (memcmp(net->bssid, AIRLINK_RALINK, 3) == 0) ||
 	    (net->ralink_cap_exist))
-		retValue = true;
+		ret_value = true;
 	else if (!memcmp(net->bssid, UNKNOWN_BORADCOM, 3) ||
 		 !memcmp(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3) ||
 		 !memcmp(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3) ||
 		(net->broadcom_cap_exist))
-		retValue = true;
+		ret_value = true;
 	else if (net->bssht.bd_rt2rt_aggregation)
-		retValue = true;
+		ret_value = true;
 	else
-		retValue = false;
+		ret_value = false;
 
-	return retValue;
+	return ret_value;
 }
 
 static void ht_iot_peer_determine(struct rtllib_device *ieee)
@@ -190,21 +190,21 @@ static void ht_iot_peer_determine(struct rtllib_device *ieee)
 static u8 ht_iot_act_is_mgnt_use_cck_6m(struct rtllib_device *ieee,
 				 struct rtllib_network *network)
 {
-	u8	retValue = 0;
+	u8	ret_value = 0;
 
 	if (ieee->ht_info->iot_peer == HT_IOT_PEER_BROADCOM)
-		retValue = 1;
+		ret_value = 1;
 
-	return retValue;
+	return ret_value;
 }
 
 static u8 ht_iot_act_is_ccd_fsync(struct rtllib_device *ieee)
 {
-	u8	retValue = 0;
+	u8	ret_value = 0;
 
 	if (ieee->ht_info->iot_peer == HT_IOT_PEER_BROADCOM)
-		retValue = 1;
-	return retValue;
+		ret_value = 1;
+	return ret_value;
 }
 
 static void ht_iot_act_determine_ra_func(struct rtllib_device *ieee, bool bPeerRx2ss)
-- 
2.43.0


