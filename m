Return-Path: <linux-kernel+bounces-2185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 366B4815917
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 13:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D84BB2393C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 12:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6194B2F861;
	Sat, 16 Dec 2023 12:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="rocDuHnO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nq2FC3xK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2964E2C6B1
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 12:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 5350A5C0163;
	Sat, 16 Dec 2023 07:52:33 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 16 Dec 2023 07:52:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1702731153; x=
	1702817553; bh=nrDaEyK3uHpFn43oapnxQCxO4x4R9W7b3A/LUpl+n70=; b=r
	ocDuHnOBD+x8v7lPmJ/VuMPmAH29oDmhL6diKF6iuVSSs6VVZ2gKC7OFRP5FTmS2
	O/ehunHkY7msmgUJ5SJOBIH6wTVKdwMJhAO59OITfDoXADy+bGrD/GMgVZ8wJEuD
	uesh9R4bNmldpX5PlpoInQmkLIfASeDsK2vMXwOXOBLYPTdwrbSNaR3xdw97kCLo
	sURViXEV5lC5Sgnvtlp3pfWHjLaDHtK1CKvB9a970bQJFFQ30d15vyonkz3zhg7J
	Xbg+ZuEd3/xVu0ke8xfqEbPqIojb4fPhKc6FiBt9JU5/N/6AIV0Uk7lfLRItMFDf
	6uWbMYHNdPrUBzaiKlyBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1702731153; x=
	1702817553; bh=nrDaEyK3uHpFn43oapnxQCxO4x4R9W7b3A/LUpl+n70=; b=N
	q2FC3xKNWARpGKPnvftppZHTg7oyOJYhp9ijbwAqMNTTMWfk67nCtD3fOV+/bsjc
	b/wru/zYZpd2hUPlkOXWLlzv9f95aMUliMNxqZq7F5jVoES35oMCwd+WptI4k4Yr
	BXl/gUFXA5eBQbhE0M5J/HanASSCEsr0+KTO6Bzofo6ADSul+xz3ocTIgDHqt+qh
	X9Antu1rKKLkmj3fx+yzapYk2vyfcxAInMZBxfo4Az6ITneZtyImxKqbgVRpa3Yk
	/0t1nEcOZm7OmTnGc2vFKKGDsaQpwI79TReZGz5qzBRLjjjOtJGUCxo6dX0+bNGI
	kW6Nn5iBwZgyhSDhEEAag==
X-ME-Sender: <xms:kZ19ZYw7cEogc2aXMMCLsQr5Unw_pbMb7Ay2UJ1C8dkcSk4Njjh2dQ>
    <xme:kZ19ZcQ-Txz1Z7L4d6vff3BbmijrNBi9IZAxDfgx5fBp5nxHRYGsritLyn3BKeKQN
    rAC3p_MSxq2OVDVyUE>
X-ME-Received: <xmr:kZ19ZaUpMgz28ghEyE3K6BEvqmmqSxwWA1W3VMsHJST4U7uU9KmzuevHFso8NN7UZq4CtuW8FkCWgZT8iLaU2Nhb5EQM83I66K0X-wkQU4I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtgedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:kZ19ZWhlxQHOwi6K-p5aIFucFN0-Mj8IEjCjOKQm-RzxEPjnoNOdww>
    <xmx:kZ19ZaBhSwJrYbvWZLd4hXuG_vjTy5pQZWBc4q5ALqhfTVLmWVIcnw>
    <xmx:kZ19ZXLtNPT0WBTIdjH9daCJnDYWeNWf1CP1i9bym3NOlFK3oggPHw>
    <xmx:kZ19ZVPPbl8HG1oKgwB53ndM9gsslg0_Zo8i2qCZpChQUVtCH8Sbcg>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 16 Dec 2023 07:52:32 -0500 (EST)
From: Gary Rookard <garyrookard@fastmail.org>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH v3 3/4] staging: rtl8192e: rename variable HTGetHighestMCSRate
Date: Sat, 16 Dec 2023 07:53:02 -0500
Message-ID: <20231216125303.3404-4-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231216125303.3404-1-garyrookard@fastmail.org>
References: <20231216125303.3404-1-garyrookard@fastmail.org>
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
v3: Corrects versioning
v2: Corrections to make applicable.
v1: Not applicable, conflicting line numbers, code change.

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


