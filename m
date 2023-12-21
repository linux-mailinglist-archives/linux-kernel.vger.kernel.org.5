Return-Path: <linux-kernel+bounces-8930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E31881BE47
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E95FF1F24BAD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A27BA5F;
	Thu, 21 Dec 2023 18:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="UEErgRrc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MVrF2Hh4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E667364A86
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 18:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id CB3DB32002E2;
	Thu, 21 Dec 2023 13:34:16 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 21 Dec 2023 13:34:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1703183656; x=
	1703270056; bh=kWH1m/5141abRghwbgNf6k7CnfEgBzv8dWkfM1ae3oU=; b=U
	EErgRrcKfmJs53RfkNKvIRukWAz+ZN8GIt2xqa2T+ZJcgnt08Yffw9orHcCUANDk
	y35RIcp6wDzvJOBqZGtwGjWxK6tw6B5KOJwZQgjwyIiipei6Yh1hFiT7TFI/4rCV
	ceaytXQ7YAVSuxwNSd9kqOfOWS1zSWYfFJtXjX3ibG0scxtAtwKi9vjKAqjEPN0K
	If5CRRcXprUj/Z4FWEBn4uA7Ghd6YNUUFXZk7dBBUaTVBoPzPHggbBvpkxRpWg+Y
	IakckEOEaNE4oqv69joaXMD73jEjjGwW8t/k2hzhcjuwyfKJAMQTJLToFEXQoVGw
	bEpGDzA7oDBC1YGsutdsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703183656; x=
	1703270056; bh=kWH1m/5141abRghwbgNf6k7CnfEgBzv8dWkfM1ae3oU=; b=M
	VrF2Hh4kaAbkD5QpB9UEbemxyjQXht1OoZ9Kc/Wg9eeNZq2HQavuBm0B4pWpuZmV
	iRzRUUuZ1N5DHCx5Or5rKqQL7LTMTTWYLAAHKrfLoav7ikhKtnj5gnKWnlkHwNOk
	HgsosAqs4q2ytd7oIBDpX3e8NACWBYvd1SNeqOqKwpoByvWHir57s88giPBITofU
	cxFhAv2mIy5TGHsCAOYujBdhVluTEBz2Qgbgk1wKmtGJW/xBvJTb5dtSZt3ljXbK
	Tmek7yuszlSC7WRSVFWknvPV5fiMtqriuAL/OTj1pZcD3oxqHbAYkPAyE4FAWnaU
	QTepBeml0gGhss0NYwTTw==
X-ME-Sender: <xms:KIWEZQM7oiMWjpiL8g4r-LzJjA-E0vdDAv-pxez47pA73sLxQtGzTw>
    <xme:KIWEZW_u0TUzHjA6KAU97zfDAJ1grj90dsQwbRYIRICMt59taacbK61jsTCJpBx6w
    xuFLdDURdsWnOh_rBI>
X-ME-Received: <xmr:KIWEZXSXTo5DcFpUqVcDhs26jGgrYeHoARR77y35TDWJqUQlDejlylmK8xcumuxmtMJP8jbHig-Nu9aUdCT575AxyxZgqpyB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduhedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepvdevtdeigfduvd
    euhefguddutdeijedtvdejvdevvdfgvdetudehvefhhefgieeknecuffhomhgrihhnpegs
    shhshhhtrdgsugenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehgrghrhihrohhokhgrrhgusehfrghsthhmrghilhdrohhrgh
X-ME-Proxy: <xmx:KIWEZYsgXK-Aj2w3GzWbQ7TvyF4mvrqeHlE4y4Pg0bWzJzWkAaR4Qw>
    <xmx:KIWEZYeB3jUQXIQAog3ekY7HWgWX-qQWYTNameXaixMSwWQaKG_CHA>
    <xmx:KIWEZc0Md9NzYhmC5twJ2nA0YwrjRzzXl_yXIbm-KAcwW4dGp690Ww>
    <xmx:KIWEZQ5flUWEEgd2bqqeG6u3FstF1S9EPNV_QzJp5KwUApzZEBJe5Q>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Dec 2023 13:34:15 -0500 (EST)
From: Gary Rookard <garyrookard@fastmail.org>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH v2 2/5] staging: rtl8192e: rename variable HTResetSelfAndSavePeerSetting
Date: Thu, 21 Dec 2023 13:34:10 -0500
Message-ID: <20231221183413.8349-3-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221183413.8349-1-garyrookard@fastmail.org>
References: <20231221183413.8349-1-garyrookard@fastmail.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Coding style issue, checkpatch Avoid CamelCase,
rename it. HTResetSelfAndSavePeerSetting -> ht_reset_self_and_save_peer_setting

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
v2: Correct typo in linux-staging mailing list address, patch series resent.
v1: Typo in linux-staging mailing list, returned mail.

 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index edfc2c7461ee..a32f3553df93 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -558,7 +558,7 @@ void ht_initialize_bss_desc(struct bss_ht *pBssHT)
 	pBssHT->rt2rt_ht_mode = (enum rt_ht_capability)0;
 }
 
-void HTResetSelfAndSavePeerSetting(struct rtllib_device *ieee,
+void ht_reset_self_and_save_peer_setting(struct rtllib_device *ieee,
 				   struct rtllib_network *pNetwork)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 193b4a5a7c04..78eae7daa351 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1759,7 +1759,7 @@ void ht_construct_rt2rt_agg_element(struct rtllib_device *ieee,
 void ht_on_assoc_rsp(struct rtllib_device *ieee);
 void ht_initialize_ht_info(struct rtllib_device *ieee);
 void ht_initialize_bss_desc(struct bss_ht *pBssHT);
-void HTResetSelfAndSavePeerSetting(struct rtllib_device *ieee,
+void ht_reset_self_and_save_peer_setting(struct rtllib_device *ieee,
 				   struct rtllib_network *pNetwork);
 void HT_update_self_and_peer_setting(struct rtllib_device *ieee,
 				     struct rtllib_network *pNetwork);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 9c94c5ceccd5..14f34e6a591a 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1219,7 +1219,7 @@ inline void rtllib_softmac_new_net(struct rtllib_device *ieee,
 				ieee->AsocRetryCount = 0;
 				if ((ieee->current_network.qos_data.supported == 1) &&
 				    ieee->current_network.bssht.bd_support_ht)
-					HTResetSelfAndSavePeerSetting(ieee,
+					ht_reset_self_and_save_peer_setting(ieee,
 						 &(ieee->current_network));
 				else
 					ieee->ht_info->current_ht_support = false;
-- 
2.43.0


