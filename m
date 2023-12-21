Return-Path: <linux-kernel+bounces-8933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6C481BE4A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C84B1F24B82
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDC26280C;
	Thu, 21 Dec 2023 18:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="Hy3ZVqFI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OqebRP6u"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD79762809
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 18:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 9526C3200AE7;
	Thu, 21 Dec 2023 13:34:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 21 Dec 2023 13:34:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1703183685; x=
	1703270085; bh=ry85f9qxM0P0A6HW2fBl050SMTTDv8ahOoVUbMewc5s=; b=H
	y3ZVqFIV0R3xGuD2DPdRn/lyBP0dYcliMLXzr03zwJ6XOYWdxznQBnV+M9Jp26Xz
	L1PxI97YyOGd7+bV1gQh4q2/soeLBJnFjA0dH+P3CulJl544hd7rRFBNxwEMv0uq
	vfwxMCSCkmpnhKDeECP8e7fgHsJANgu7oJQ/FCct/8bLs0JD+LM8RJ+UifYZ+VVj
	aiVYbYmAIUDqOMYDLUCGYtB5IkC19Ofnpb04/2WuEkP50VG4+BFpJFZnhM4WOsMt
	SmCxd6n4F4v767aIGOU40sgRBDH2oDV+ABqs2sN93cH6gtXT1LU9SUIcxwepzEkG
	QRbtEvdPxkMAC55/6iwAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703183685; x=
	1703270085; bh=ry85f9qxM0P0A6HW2fBl050SMTTDv8ahOoVUbMewc5s=; b=O
	qebRP6uzky1s6bjWqqWDjdvVxgWody/NAbF65dFcx9a9DyQYLlcKhEX5FlxgJT5U
	OwIQnrHV/JzECW31y0ItazQ2qlLdNz0oTSA322d1ZnlU/wNIax3CiwFcPDO0WgwL
	1lNvXXaV44a3vsmXaAKoUriCgbHVfPEECme2B7P+0qp+1Uz7s+OPixMP8G4KCxPC
	nGXp2H2ajZJK2VtAvFk/267KINMkhsdsl0ux128AbaKdZOKegoACcw7/sIJFOAq/
	2EYH/cJ0L39Vg7eEof9UgcFCuy1hVYXKeAbWhf0oej+g6/owsmIFC72ov6iGYy6c
	h26x5VIDqHQm0WY2UDbnA==
X-ME-Sender: <xms:RIWEZSxi9ARXo92UEo8k-DPBch2b-kHa3FyzvDSeBV7lWIc-A5Q3Gw>
    <xme:RIWEZeRwx5xICp0O0ya7A_JrFqYwjpLc6zAtasT6ynSWJm-i-vjcY_rDyb-wivIgI
    ty9lHyamfHoECvpR48>
X-ME-Received: <xmr:RIWEZUVB6LFm7Vbmz75yOdjUFiWZJDOWKPJnRsnpbBwisO889gHBjmnDwlh3FA3OqPtoBAEaoqYBGL6I3gpoXm6VfboE-bZD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduhedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:RIWEZYg0B7EjNf72RyqKLpg8gRL9Pi_8_6ZYMTcILCDTUJzAAIN1ng>
    <xmx:RIWEZUBS53JRNFa50aEQaOuu0Ik41tdegjJ8JUuKInpcAAaVW7SzQQ>
    <xmx:RIWEZZIhSpRdVxw-kLPBIz6PI90qllHyOlMzEYkFV_vrkTW3bXxBMg>
    <xmx:RYWEZXNnKpYSJTo72rnH5iCyAE7AOrHtVdeqTDTFMtXrY_L590FyyA>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Dec 2023 13:34:44 -0500 (EST)
From: Gary Rookard <garyrookard@fastmail.org>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH v2 5/5] staging: rtl8192e: rename variable ePeerHTSpecVer
Date: Thu, 21 Dec 2023 13:34:13 -0500
Message-ID: <20231221183413.8349-6-garyrookard@fastmail.org>
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
rename it. ePeerHTSpecVer -> peer_ht_spec_ver

Signed-off-by: Gary Rookard <garyrookard@fastmail.org
---
v2: Corrects typo in linux-staging mailing list address, patch series resent.
v1: Typo in linux-staging mailing list address, returned mail.

 drivers/staging/rtl8192e/rtl819x_HT.h     | 2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 6 +++---
 drivers/staging/rtl8192e/rtllib_softmac.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 2911ea82dd17..68577bffb936 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -97,7 +97,7 @@ struct rt_hi_throughput {
 	u8 cur_bw_40mhz;
 	u8 cur_short_gi_40mhz;
 	u8 cur_short_gi_20mhz;
-	enum ht_spec_ver ePeerHTSpecVer;
+	enum ht_spec_ver peer_ht_spec_ver;
 	struct ht_capab_ele SelfHTCap;
 	u8 PeerHTCapBuf[32];
 	u8 PeerHTInfoBuf[32];
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index ac17d510a2a5..6d0912f90198 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -240,7 +240,7 @@ void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_ht_cap,
 	}
 	memset(pos_ht_cap, 0, *len);
 
-	if ((assoc) && (ht->ePeerHTSpecVer == HT_SPEC_VER_EWC)) {
+	if ((assoc) && (ht->peer_ht_spec_ver == HT_SPEC_VER_EWC)) {
 		static const u8	EWC11NHTCap[] = { 0x00, 0x90, 0x4c, 0x33 };
 
 		memcpy(pos_ht_cap, EWC11NHTCap, sizeof(EWC11NHTCap));
@@ -525,7 +525,7 @@ void ht_initialize_ht_info(struct rtllib_device *ieee)
 
 	ht_info->sw_bw_in_progress = false;
 
-	ht_info->ePeerHTSpecVer = HT_SPEC_VER_IEEE;
+	ht_info->peer_ht_spec_ver = HT_SPEC_VER_IEEE;
 
 	ht_info->current_rt2rt_aggregation = false;
 	ht_info->current_rt2rt_long_slot_time = false;
@@ -569,7 +569,7 @@ void ht_reset_self_and_save_peer_setting(struct rtllib_device *ieee,
 	 */
 	if (pNetwork->bssht.bd_support_ht) {
 		ht_info->current_ht_support = true;
-		ht_info->ePeerHTSpecVer = pNetwork->bssht.bd_ht_spec_ver;
+		ht_info->peer_ht_spec_ver = pNetwork->bssht.bd_ht_spec_ver;
 
 		if (pNetwork->bssht.bd_ht_cap_len > 0 &&
 		    pNetwork->bssht.bd_ht_cap_len <= sizeof(ht_info->PeerHTCapBuf))
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 14f34e6a591a..953222d57f0e 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -866,7 +866,7 @@ rtllib_association_req(struct rtllib_network *beacon,
 		tag += osCcxVerNum.Length;
 	}
 	if (ieee->ht_info->current_ht_support && ieee->ht_info->enable_ht) {
-		if (ieee->ht_info->ePeerHTSpecVer != HT_SPEC_VER_EWC) {
+		if (ieee->ht_info->peer_ht_spec_ver != HT_SPEC_VER_EWC) {
 			tag = skb_put(skb, ht_cap_len);
 			*tag++ = MFIE_TYPE_HT_CAP;
 			*tag++ = ht_cap_len - 2;
@@ -900,7 +900,7 @@ rtllib_association_req(struct rtllib_network *beacon,
 	}
 
 	if (ieee->ht_info->current_ht_support && ieee->ht_info->enable_ht) {
-		if (ieee->ht_info->ePeerHTSpecVer == HT_SPEC_VER_EWC) {
+		if (ieee->ht_info->peer_ht_spec_ver == HT_SPEC_VER_EWC) {
 			tag = skb_put(skb, ht_cap_len);
 			*tag++ = MFIE_TYPE_GENERIC;
 			*tag++ = ht_cap_len - 2;
-- 
2.43.0


