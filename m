Return-Path: <linux-kernel+bounces-1918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6458155CA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 02:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 957241C2354A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1F14C77;
	Sat, 16 Dec 2023 01:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="MivDLGmr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tXXgs4qK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83461257E
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 01:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 989B0320099B;
	Fri, 15 Dec 2023 20:00:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 15 Dec 2023 20:00:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1702688450; x=
	1702774850; bh=5750rQocdnyD7jpR3uy757KH/wiiVOExOowo8BdV8LQ=; b=M
	ivDLGmrD1XO+HxFe1xL2Rd14o0PHGsIivWMC2yMOY2IMhpwW1RzoByqg7NGaReuc
	O75vqpHuDGTfSLv4gFofw0Zem/q4TvK7M2ae+LROLaoSv8W3YTzS6qpH4O+05Jck
	1KWrE+jEcAm6Q8DHdZvUEC6kyBnYEM1Hxpx/S0+qAvxlUKvYxZDrvIDDQ7r6CfZD
	e/K1P2q82e1yMSIZ7chl3LJN3oi/BDeqIKZnpbfXKTVV29SjQaLhbmwBPKYBAzGI
	A9DMolt5GMf0oH97zomp7xw0udG3dTqYN9Ato80rWq/fZNHo51xua7iz4sCDBTpB
	rvP3hwV5nByJvoCQ67WeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1702688450; x=
	1702774850; bh=5750rQocdnyD7jpR3uy757KH/wiiVOExOowo8BdV8LQ=; b=t
	XXgs4qK/a6BwhtMN/O0MhehFxj6B/mHXcTLoh7RlcgqblQZK3/CMMPPBO4pnHknu
	HUbus//1YaUorua0xKWiCsV8bPCtDrWXWsC5mE8cKnrDYAH24Qk3UpXuBsVVcYS9
	Fs/3MkSbjSYa8c62EiY+VRVJ9kpUO7du9mrv3bRek/B9qVEZWNvW4kPl+Ss2QBMD
	txsravPlDd1heTEnMTz1m9NtCe8VFTbThI1RULSz5Wdyy0TnD0hF3MLmpJcVU5Qx
	DB8CeGvXr+ig29HsRKZPLhHojmDjK3KbgoU6c3rnexdrZsUrCdvOpHrAFxTqI2do
	FReOhRhY/r2by6FaMgF0Q==
X-ME-Sender: <xms:wfZ8Zd5_UwQ0EzgdtEQkjuLhcIlDz0PsRmfrMIxemWLTyLwH1pJp2Q>
    <xme:wfZ8Za4BDYlzcs4qCbETmQ8_5GPUlnCHpY_n3lK_MKLHc0Mn3z1Bo_zMPtNdhRi68
    TXtymRWElAvNgw5wsw>
X-ME-Received: <xmr:wfZ8ZUdj1HE0wr23FI0t_i3RjCbmNzIYiv_iKtpaVg-M6VshNB4MNbU_H7HWStVH9w-FJe2XQMdSozewh_qhiPFICsJ0gbay833OhoX9vM4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtfedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:wvZ8ZWJ796TcKaljtQfgRJlzEWIL4ZJbphXCWmvAwrio_loYcOslpQ>
    <xmx:wvZ8ZRJZ1YxtYWrhsBtTSl3TZnDRuEisx8j3_vhzEU7V7d4dFyYqCw>
    <xmx:wvZ8Zfy0W96Ll50H3SMqUXHeBtUB26ckz2mA5HYZS6J3dizpzwznMQ>
    <xmx:wvZ8ZR0-TzGMv0pukX8Qr_4TehiEAbzQDBJ-Dqwqus7MYx1-Bgw80A>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Dec 2023 20:00:49 -0500 (EST)
From: Gary Rookard <garyrookard@fastmail.org>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH v2 3/4] staging: rtl8192e: rename variable HTGetHighestMCSRate
Date: Fri, 15 Dec 2023 20:01:04 -0500
Message-ID: <20231216010105.9810-4-garyrookard@fastmail.org>
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
rename it. HTGetHighestMCSRate -> ht_get_highest_mcs_rate

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
v2: Corrections to make applicable.
v1: Not applicable, conflicting line numbers, code changed.

 drivers/staging/rtl8192e/rtl819x_HTProc.c | 4 ++--
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_wx.c      | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 8d9037130424..6c1af19d67d2 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -357,7 +357,7 @@ static u8 ht_pick_mcs_rate(struct rtllib_device *ieee, u8 *pOperateMCS)
 	return true;
 }
 
-u8 HTGetHighestMCSRate(struct rtllib_device *ieee, u8 *pMCSRateSet,
+u8 ht_get_highest_mcs_rate(struct rtllib_device *ieee, u8 *pMCSRateSet,
 		       u8 *pMCSFilter)
 {
 	u8		i, j;
@@ -493,7 +493,7 @@ void ht_on_assoc_rsp(struct rtllib_device *ieee)
 	HTFilterMCSRate(ieee, pPeerHTCap->MCS, ieee->dot11ht_oper_rate_set);
 
 	pMcsFilter = MCS_FILTER_ALL;
-	ieee->HTHighestOperaRate = HTGetHighestMCSRate(ieee,
+	ieee->HTHighestOperaRate = ht_get_highest_mcs_rate(ieee,
 						       ieee->dot11ht_oper_rate_set,
 						       pMcsFilter);
 	ieee->HTCurrentOperaRate = ieee->HTHighestOperaRate;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index b4413cfcb17e..966a62cfcfde 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1763,7 +1763,7 @@ void HTResetSelfAndSavePeerSetting(struct rtllib_device *ieee,
 				   struct rtllib_network *pNetwork);
 void HT_update_self_and_peer_setting(struct rtllib_device *ieee,
 				     struct rtllib_network *pNetwork);
-u8 HTGetHighestMCSRate(struct rtllib_device *ieee, u8 *pMCSRateSet,
+u8 ht_get_highest_mcs_rate(struct rtllib_device *ieee, u8 *pMCSRateSet,
 		       u8 *pMCSFilter);
 extern u8 MCS_FILTER_ALL[];
 extern u16 MCS_DATA_RATE[2][2][77];
diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
index a37250de7ba3..f92ec0faf4d5 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -134,7 +134,7 @@ static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
 				((ht_cap->ShortGI40Mhz) ? 1 : 0) :
 				((ht_cap->ShortGI20Mhz) ? 1 : 0);
 
-		max_mcs = HTGetHighestMCSRate(ieee, ht_cap->MCS,
+		max_mcs = ht_get_highest_mcs_rate(ieee, ht_cap->MCS,
 					      MCS_FILTER_ALL);
 		rate = MCS_DATA_RATE[is40M][isShortGI][max_mcs & 0x7f];
 		if (rate > max_rate)
-- 
2.41.0


