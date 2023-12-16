Return-Path: <linux-kernel+bounces-1917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9A28155C9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 02:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14D381C235B5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF53C3C2D;
	Sat, 16 Dec 2023 01:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="krijQ7z4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wl/NDM1m"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FD017E8
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 01:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 585623200A47;
	Fri, 15 Dec 2023 20:00:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 15 Dec 2023 20:00:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1702688447; x=
	1702774847; bh=UNqxnPS/KECSJYSAYrhyozfSwB0BLIrorXrPvuKMpIw=; b=k
	rijQ7z4dC/X1TkaIVNpPYJijTkUu1LKK3b32MRl3XDdey+0iHt0VptChxoobPfMp
	+Z5z7tddUQypyI385x1XZYC+N4sx6wndtJIPciUVw3MDkOCRH9gK+cCSvYG7nGvr
	wcOHr91SvvP6Br+vxuIpb9+pA6VwBpsg8PhybwxZN2KuNDek3XXKTU0NzNmp3i0b
	kgilFJJwkMRphAC7xm5wqEe2Jy4I3bND5LYxjqStzQkL0LOrXB6JwULbEoXzRY8D
	URzIPp1ExlEFR6++nFoClZl2RG0zAGlpHtMHCaRBtcr/o8Ek1JBnQzZxq3MRNIlv
	Bxp02MvaKOURAyPbV/lVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1702688447; x=
	1702774847; bh=UNqxnPS/KECSJYSAYrhyozfSwB0BLIrorXrPvuKMpIw=; b=w
	l/NDM1m8yZXQiYrAE8QeFNqpyFqKuO615AYFeWYz116j24ry2WDi/xeWPE9DzE6E
	pm9ruZlOyk7iQ0uP3SpxcANEPmFer2R6cH4LWRnGda7n6nZoB9VIYgAger0wKZSH
	pp2sdHY9VlIonnjwYEiWnlzWcCp4kkQZxv/2DeDZ0kCMvdWKhc5Ucd3dpew6rjI9
	IGiuSunOH0v62iM5bThwJGU46yUcTxdDtqD+hXLc/fiFSPSFfnGq9JyJgQ6ZjIAu
	rBYtdIcPzghLPq/0+oqhFzodr2l86jCrXPnQQDYIlEbtOCdDo+0wAdxWeMxJGpep
	VS6U5OUCdLl2bahYT/svw==
X-ME-Sender: <xms:v_Z8ZamMyjMWzWA-lAzO_c3tUBvWVSIJuA8W7M8n-ATyuzoLi4mvjQ>
    <xme:v_Z8ZR3WX4ny-nr4_9xhrjtKHPKkvupSl3d9Sadin5nT4UC6wU_K4iz07ytedmEq9
    53gcWEgRqNSD46NMOs>
X-ME-Received: <xmr:v_Z8ZYqQSBghGIkaO_3wdlHVcTW5KFMfidjGbJA-fvfHPXzwXiVEjkO77_fGh7ebqpdG8y7rryyCzWWG7H2GfMmrXScFmoQhC1LFRGWFnT8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtfedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:v_Z8Zeny3Lg-A1d3aubMPF-2NdaiWxVeR-4hw6fPVs1Do8L4LPkBCg>
    <xmx:v_Z8ZY2HYHE11-9Pshw5KQO5HpaywWs-LQ3VKQBxSOSfUFSCvZxyKg>
    <xmx:v_Z8ZVsBxbwVbPIqsZvYNuQ8QFQuTBH5qqwYi8KmDY8gv3wDcEoVhQ>
    <xmx:v_Z8ZVwXDE6t1duaqG1IMFyzdTlrG7HYr8cU7h5R2bJI6E5CfBgNpA>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Dec 2023 20:00:47 -0500 (EST)
From: Gary Rookard <garyrookard@fastmail.org>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH v2 2/4] staging: rtl8192e: rename variable pCapELE
Date: Fri, 15 Dec 2023 20:01:03 -0500
Message-ID: <20231216010105.9810-3-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231216010105.9810-1-garyrookard@fastmail.org>
References: <20231216010105.9810-1-garyrookard@fastmail.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Coding style issue, checkpatch Avoid CamelCase,
rename it. pCapELE -> cap_ele

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
v2: Corrections to make applicable.
v1: Not applicable, conflicting line numbers, code changed.

 drivers/staging/rtl8192e/rtl819x_HTProc.c | 64 +++++++++++------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 29c3d33bf5a6..8d9037130424 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -231,7 +231,7 @@ void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_ht_cap,
 				  u8 *len, u8 is_encrypt, bool assoc)
 {
 	struct rt_hi_throughput *ht = ieee->ht_info;
-	struct ht_capab_ele *pCapELE = NULL;
+	struct ht_capab_ele *cap_ele = NULL;
 
 	if (!pos_ht_cap || !ht) {
 		netdev_warn(ieee->dev,
@@ -244,66 +244,66 @@ void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_ht_cap,
 		static const u8	EWC11NHTCap[] = { 0x00, 0x90, 0x4c, 0x33 };
 
 		memcpy(pos_ht_cap, EWC11NHTCap, sizeof(EWC11NHTCap));
-		pCapELE = (struct ht_capab_ele *)&pos_ht_cap[4];
+		cap_ele = (struct ht_capab_ele *)&pos_ht_cap[4];
 		*len = 30 + 2;
 	} else {
-		pCapELE = (struct ht_capab_ele *)pos_ht_cap;
+		cap_ele = (struct ht_capab_ele *)pos_ht_cap;
 		*len = 26 + 2;
 	}
 
-	pCapELE->AdvCoding		= 0;
+	cap_ele->AdvCoding		= 0;
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
-		pCapELE->ChlWidth = 0;
+		cap_ele->ChlWidth = 0;
 	else
-		pCapELE->ChlWidth = 1;
+		cap_ele->ChlWidth = 1;
 
-	pCapELE->MimoPwrSave		= 3;
-	pCapELE->GreenField		= 0;
-	pCapELE->ShortGI20Mhz		= 1;
-	pCapELE->ShortGI40Mhz		= 1;
+	cap_ele->MimoPwrSave		= 3;
+	cap_ele->GreenField		= 0;
+	cap_ele->ShortGI20Mhz		= 1;
+	cap_ele->ShortGI40Mhz		= 1;
 
-	pCapELE->TxSTBC			= 1;
-	pCapELE->RxSTBC			= 0;
-	pCapELE->DelayBA		= 0;
-	pCapELE->MaxAMSDUSize = (MAX_RECEIVE_BUFFER_SIZE >= 7935) ? 1 : 0;
-	pCapELE->DssCCk = 1;
-	pCapELE->PSMP = 0;
-	pCapELE->LSigTxopProtect = 0;
+	cap_ele->TxSTBC			= 1;
+	cap_ele->RxSTBC			= 0;
+	cap_ele->DelayBA		= 0;
+	cap_ele->MaxAMSDUSize = (MAX_RECEIVE_BUFFER_SIZE >= 7935) ? 1 : 0;
+	cap_ele->DssCCk = 1;
+	cap_ele->PSMP = 0;
+	cap_ele->LSigTxopProtect = 0;
 
 	netdev_dbg(ieee->dev,
 		   "TX HT cap/info ele BW=%d MaxAMSDUSize:%d DssCCk:%d\n",
-		   pCapELE->ChlWidth, pCapELE->MaxAMSDUSize, pCapELE->DssCCk);
+		   cap_ele->ChlWidth, cap_ele->MaxAMSDUSize, cap_ele->DssCCk);
 
 	if (is_encrypt) {
-		pCapELE->MPDUDensity	= 7;
-		pCapELE->MaxRxAMPDUFactor	= 2;
+		cap_ele->MPDUDensity	= 7;
+		cap_ele->MaxRxAMPDUFactor	= 2;
 	} else {
-		pCapELE->MaxRxAMPDUFactor	= 3;
-		pCapELE->MPDUDensity	= 0;
+		cap_ele->MaxRxAMPDUFactor	= 3;
+		cap_ele->MPDUDensity	= 0;
 	}
 
-	memcpy(pCapELE->MCS, ieee->reg_dot11ht_oper_rate_set, 16);
-	memset(&pCapELE->ExtHTCapInfo, 0, 2);
-	memset(pCapELE->TxBFCap, 0, 4);
+	memcpy(cap_ele->MCS, ieee->reg_dot11ht_oper_rate_set, 16);
+	memset(&cap_ele->ExtHTCapInfo, 0, 2);
+	memset(cap_ele->TxBFCap, 0, 4);
 
-	pCapELE->ASCap = 0;
+	cap_ele->ASCap = 0;
 
 	if (assoc) {
 		if (ht->iot_action & HT_IOT_ACT_DISABLE_MCS15)
-			pCapELE->MCS[1] &= 0x7f;
+			cap_ele->MCS[1] &= 0x7f;
 
 		if (ht->iot_action & HT_IOT_ACT_DISABLE_MCS14)
-			pCapELE->MCS[1] &= 0xbf;
+			cap_ele->MCS[1] &= 0xbf;
 
 		if (ht->iot_action & HT_IOT_ACT_DISABLE_ALL_2SS)
-			pCapELE->MCS[1] &= 0x00;
+			cap_ele->MCS[1] &= 0x00;
 
 		if (ht->iot_action & HT_IOT_ACT_DISABLE_RX_40MHZ_SHORT_GI)
-			pCapELE->ShortGI40Mhz		= 0;
+			cap_ele->ShortGI40Mhz		= 0;
 
 		if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev)) {
-			pCapELE->ChlWidth = 0;
-			pCapELE->MCS[1] = 0;
+			cap_ele->ChlWidth = 0;
+			cap_ele->MCS[1] = 0;
 		}
 	}
 }
-- 
2.41.0


