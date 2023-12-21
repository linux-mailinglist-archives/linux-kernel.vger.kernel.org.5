Return-Path: <linux-kernel+bounces-7788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDFD81AD09
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFB57288CD6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D98C3C68E;
	Thu, 21 Dec 2023 03:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="gbMegyYT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="7SIs6TCR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DB038F9B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 03:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 780243200A30;
	Wed, 20 Dec 2023 22:09:36 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 20 Dec 2023 22:09:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1703128175; x=
	1703214575; bh=eLwhieIwWiEuq+3M/i7XeeaQWFp+cT7u7PxwVjCwPro=; b=g
	bMegyYTomN3UWYDkEtC+YOOvGFk3DFZI33t0MxqD53aMqTGiuuXCBn3QnycRp3Sj
	x1d6NC9mhuZz0rZmz0g1HJWoYJsIRbhhi+/PTaFC708jqLCR8BaiR88jEmL//4MJ
	aYhq9zb6XxjnBLNGY6z6tkgr/q9a6g+uawP1qToMMF+j7fK43M3e2JKeQmqKpCPo
	mWKcw5wp+65o0itAR8Xkvw2xMeMCebChDP2oWm0Z7hW+APw+PCnuBaG2ldYs0l8L
	xuL3q8bI2P4tEPTpNHTg18Soj0NkyUuIk5YOJmZk8AfjKnhnVVNjG18uA5A/oqw5
	hqoCGUwl6H2s5Fyy8YCDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703128175; x=
	1703214575; bh=eLwhieIwWiEuq+3M/i7XeeaQWFp+cT7u7PxwVjCwPro=; b=7
	SIs6TCRUW4XwRh7hF1UP1iqvQMCqe8w0uP8290ro5bbQutEmGAREsBT40WvLzpRx
	XjD/5FmyPPh7SwAlZcFmRGlno/Cz9ebDHn9bHrvJJX9D38qxW4c2jSwnGuoC8Tnj
	ePyDXJd7oFuBYvHDtwKxbSqAd/MqJAhD9QnabhtialTyK7WniebWKrYGWBC0+Ebg
	sH8PrFoESvJXfc45cGzyyZaAXoEDIaLc32DO0QHMr8zD+SAmqiJQ5VLbaIqGmwu0
	SzmWvkCoxWRWDdw4M/JgFMigZQ1V2HhNadL7gOaN+CvctcC4F9XJCIOu/pEPsQ59
	clc9NL7ewA+F0ObAs9ssA==
X-ME-Sender: <xms:b6yDZaVtxFLwdg9GhNyu36oHLrnOQpd3gnwsq6gP_kGQatEWjS_SDQ>
    <xme:b6yDZWkJNyrQN_2-uPA2pOOW9UXuWbd_DK7XEdXy18su0N0XAuBsn5ERmpjf4K3ku
    q8I37IJYEfuP7-SKqM>
X-ME-Received: <xmr:b6yDZeavDx6gOSOWFzSbo3a7AEMP1z8tUnZD62vKx_ts01LJcDJy4j-md-YNz_KQ-g_0zq7GtkPJz2uLzU0w88Xv9_L6E73r>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddufedgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:b6yDZRX1ocVVB-QAh4Uu0-o7RyLTmdV5nCUoZM1nA5hkLGHZPMPwvw>
    <xmx:b6yDZUn8xQnyRsGrDb1kJeIHwIkJxc5JJE6fatrgJT1W31C2dem8_g>
    <xmx:b6yDZWedKGygbIk1CkYb7U_7hrek_RT2ZzbZNqjTCwG80PjR60h23w>
    <xmx:b6yDZeioismz2mhF1BExn2wEino90GjrpuKY0mDMSF9uNa0nOqKmBQ>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Dec 2023 22:09:35 -0500 (EST)
From: Gary Rookard <garyrookard@fastmail.org>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: linux-staging@list.linux.dev,
	linux-kernel@vger.kernel.org,
	Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 1/5] staging: rtl8192e: rename variable HTInitializeBssDesc
Date: Wed, 20 Dec 2023 22:10:00 -0500
Message-ID: <20231221031004.14779-2-garyrookard@fastmail.org>
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
rename it. HTInitializeBssDesc -> ht_initialize_bss_desc

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
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


