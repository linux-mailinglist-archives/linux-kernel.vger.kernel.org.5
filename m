Return-Path: <linux-kernel+bounces-8929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 175B181BE46
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4953E1C24CEA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4ECC59902;
	Thu, 21 Dec 2023 18:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="ApO0ggb9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JbTouHYG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2391C848C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 18:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 1787E3200B01;
	Thu, 21 Dec 2023 13:34:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 21 Dec 2023 13:34:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1703183644; x=
	1703270044; bh=V38iJjZvIkUg/Kt6bVnkVHDRR/l72dcvgF2UEK6mQ/o=; b=A
	pO0ggb9hywKC5x+5xgUeQhOhIREA8nmtfnRrvLK47jUzb1bpeXD6fqNtsQW/EoYd
	AjFJ58jIayKKu9ZkW57A+1urRK+FitEiLKJW7iO40ws5iRoNCnuioMPbUCwB2u9c
	filELsiM/d7QQoZWaEyiHyzNcMebwbRQRYBTNpeOWHTYXgIq6heSwCsrV+nBLfP6
	Nj+MT/U5khYqKUVf2SgMUVyVKbcEWmkMl1hpru6QTvzPracDOtq1ynSUQLTRSpmb
	kgxTTpNKFsCHh8GF1LWbCwHC/EpOpz/WYestC82gAiS8b34zO6/101OMQ2ApMQNP
	W1pxHnnVLbb1ramvYsq2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703183644; x=
	1703270044; bh=V38iJjZvIkUg/Kt6bVnkVHDRR/l72dcvgF2UEK6mQ/o=; b=J
	bTouHYGbFCkKkewlY7874vw90UEeLWASw7QYykS9zdHHaAPyg/bQDyrObX7R4aRq
	5la+CCBzeBxbAl0b36XcluixNyMCNgyVvvYa7ABAkOLxi3mDl8g83I/6ZAsK4kf6
	kuZL29mGFzDHsLM0VTsEKdoc/mRlh91PJwwtPPWQWx0m0TUbfE3krTtZV+4DuyI/
	RbAcim48jeOLUdwxDj37zqdKMQ/94pRscKxG77gOBIMCcYbDPQKJbIPBE/hkoney
	fNPbA8hzik6GaS95RSGuAmejQxMvwJAEXKEXs0m3k0L5tWwQ6Q0UjpBZcAse6rdf
	RGwvGM/ltG+9Lx8zn2ylQ==
X-ME-Sender: <xms:HIWEZXjcTNfGDYH04NKg9QYQCpgkGl49a6CBWffN2O5ZH7XhxXZl9Q>
    <xme:HIWEZUDLY1B4hP5IRavXfdEQVlBFHjf4hOWC9r8gj2PzIySxBhfgUU0noKLoaP0gE
    qma3Ve3FDPTI1FCwWI>
X-ME-Received: <xmr:HIWEZXFiebn1uQ5yqxEOs0ZjUeXIbuWRTDGkj5FKx9bRp6U1XOAZlda2rs86-6vXXcj-iADVfZhq8hxjUtHI0J9SFpH4ytZY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduhedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:HIWEZUTcLwqqow6tcJYkltjtk0heAmqBN-ao-VozcIeLuVyl5xtPaQ>
    <xmx:HIWEZUylOZlgKk8LsUgIlfFYCNJZGuzHVMu7N1Mtx4ZTsrpMrSE_lw>
    <xmx:HIWEZa5FBNOvOTUg_BfshECnC2erMfka0Satrzoey1H3wr0WmNt6hw>
    <xmx:HIWEZQ9zouRw8t9HpsJ4lrUGRjSFbJUy3QnnLPiPj1PDGck3I8g4Ag>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Dec 2023 13:34:03 -0500 (EST)
From: Gary Rookard <garyrookard@fastmail.org>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH v2 1/5] staging: rtl8192e: rename variable HTInitializeBssDesc
Date: Thu, 21 Dec 2023 13:34:09 -0500
Message-ID: <20231221183413.8349-2-garyrookard@fastmail.org>
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
rename it. HTInitializeBssDesc -> ht_initialize_bss_desc

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
v2: Corrects typo in linux-staging mailing list address, patch series resent.
v1: Typo in linux-staging mailing list, returned mail.

 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 0d57bcda33b4..edfc2c7461ee 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -543,7 +543,7 @@ void ht_initialize_ht_info(struct rtllib_device *ieee)
 	}
 }
 
-void HTInitializeBssDesc(struct bss_ht *pBssHT)
+void ht_initialize_bss_desc(struct bss_ht *pBssHT)
 {
 	pBssHT->bd_support_ht = false;
 	memset(pBssHT->bd_ht_cap_buf, 0, sizeof(pBssHT->bd_ht_cap_buf));
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 4df46eae6aa8..193b4a5a7c04 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1758,7 +1758,7 @@ void ht_construct_rt2rt_agg_element(struct rtllib_device *ieee,
 				u8 *posRT2RTAgg, u8 *len);
 void ht_on_assoc_rsp(struct rtllib_device *ieee);
 void ht_initialize_ht_info(struct rtllib_device *ieee);
-void HTInitializeBssDesc(struct bss_ht *pBssHT);
+void ht_initialize_bss_desc(struct bss_ht *pBssHT);
 void HTResetSelfAndSavePeerSetting(struct rtllib_device *ieee,
 				   struct rtllib_network *pNetwork);
 void HT_update_self_and_peer_setting(struct rtllib_device *ieee,
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 196eacc7a768..5f219cfb65eb 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -2189,7 +2189,7 @@ static inline int rtllib_network_init(
 	network->RSSI = stats->SignalStrength;
 	network->CountryIeLen = 0;
 	memset(network->CountryIeBuf, 0, MAX_IE_LEN);
-	HTInitializeBssDesc(&network->bssht);
+	ht_initialize_bss_desc(&network->bssht);
 	network->flags |= NETWORK_HAS_CCK;
 
 	network->wpa_ie_len = 0;
-- 
2.43.0


