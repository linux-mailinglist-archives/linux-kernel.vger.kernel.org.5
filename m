Return-Path: <linux-kernel+bounces-7793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E578D81AD10
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84ECC1F24C15
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56A94A9AE;
	Thu, 21 Dec 2023 03:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="EKPkf9Ue";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="9G18p7ek"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54230495CA
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 03:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 428353200A30;
	Wed, 20 Dec 2023 22:10:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 20 Dec 2023 22:10:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1703128199; x=
	1703214599; bh=XWnAqBfJFUH3eglypfU2Un+KkV5x4RHsq5AWEE/Xgd4=; b=E
	KPkf9UelKwxbA0vkfJfAP/CBgm9TLSyr0bLcg6G58owbLiMcwgJuM8dwn3Rm3xwB
	hXAa9f49DGPRtW0CXz21P/JiGJFY9yVwD2+tXnjD6S5mpAtZshDL9TPuupL+G8zT
	aQtJPsMzAQ/VPDl0NJKg7+5Ug1206wAEs1XjHlSBTMiTunj6v94mODB0vfqMlJO+
	UG3nQHttxyZNiQtT/iWfVWR5nt5hT0j91z5w2m1OopLNM94CPwqCp416CLoBtSzB
	4CidY2rt2cL7QB2RaFlGn8nV0ajxu9/vsNkHO52liauMFoHbTRgzUEeWzlwheLPS
	MdiADhCXc190AKmKJZUaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703128199; x=
	1703214599; bh=XWnAqBfJFUH3eglypfU2Un+KkV5x4RHsq5AWEE/Xgd4=; b=9
	G18p7ekNrBlIzkaP8JO5nOBz1ROGnbctUy02XBv0ctwBpY4serq88lxpMUOHSUZD
	OUb8UrnrMsjZ4KcDWMRSeeLKZU3qFY3F4bbyGV028cvam9soVUeb54gJ4OmAgs28
	03QqQW0OdQMmMRRF6soq2iwb+KI+REfpEnnFp5Wz5dryxyNnERNONKY8vZXsaoyV
	31RxIYUIT79DsL7739H0K/k0zvAjbEP7PDfjJa5f2B3T8y8+4KNELNmz8bOHO6HO
	dH81CnqtGmcwTtsB9ytBeaO5eTn9CBaWJlCMwjiyosIZ9Bd7JAsMY39TEr7tO6Hm
	ZQX9100TGZu6Bh7AIa+Kg==
X-ME-Sender: <xms:h6yDZVkJgckqXWJIjLTNb-pcqwh0pWvfyIkoJ4IGNP0_VAdmW1-mOQ>
    <xme:h6yDZQ0NWc6pLtCfMZPV53DGQlWynoZ9Z72eB36BHt30LS94T8-kKO9vRK-US4fMV
    Vaxs-rCrwmbF9kOTfQ>
X-ME-Received: <xmr:h6yDZbqUACOdTTfGlhioek1jDDKZKduVZAoaC6FDdxCT-nXPePNwNi-mORVK4RplzTxqQ1cVp7U_qfD9FXbF3ODO1-C_oEhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddufedgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:h6yDZVnbORkM56PXY2bQeqX1aDKm3fi25KD7Z3L7QI_DP4wZsnbxgw>
    <xmx:h6yDZT0fBFm5H49Xh-4skq015DqXjB3Ytx_ZeHOCCMunh5_Ln2CoHQ>
    <xmx:h6yDZUu39M1Y2Z43Qqk2nrFpoO2lHaYY8yMWm7bcd3fcAyLsnR-bQg>
    <xmx:h6yDZUyb4oJcl7uDRsyFuls8RIQ816C_MaujFghlR-USupVWeHObSg>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Dec 2023 22:09:59 -0500 (EST)
From: Gary Rookard <garyrookard@fastmail.org>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: linux-staging@list.linux.dev,
	linux-kernel@vger.kernel.org,
	Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 5/5] staging: rtl8192e: rename variable ePeerHTSpecVer
Date: Wed, 20 Dec 2023 22:10:04 -0500
Message-ID: <20231221031004.14779-6-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221031004.14779-1-garyrookard@fastmail.org>
References: <20231221031004.14779-1-garyrookard@fastmail.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Coding style issue, checkpatch Avoid CamelCase,
rename it. ePeerHTSpecVer -> peer_ht_spec_ver

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
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


