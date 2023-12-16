Return-Path: <linux-kernel+bounces-2186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3402815918
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 13:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D62811C2181B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 12:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C7430356;
	Sat, 16 Dec 2023 12:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="suYW2ldL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="as9fC/I4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2832E40D
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 12:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id CDD115C019A;
	Sat, 16 Dec 2023 07:52:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 16 Dec 2023 07:52:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1702731154; x=
	1702817554; bh=S2oZrM9VplF7tk9wf9xKeyfGCtTRYHncJ+U5R2mrlVI=; b=s
	uYW2ldL6k8LFZW/cv5VqJ84gJHwfsMlhUwhoDqDGzKtMuhwN5df94B/C9ruut5FD
	u/OlrFToo+NvzepEWDWtJF+OUqmmMx5Q84lOrEItxKlIoHOFpxNKaQpPPYC4+qKn
	04txfG+RY1fCOp6TP2bmm2O+rO36nesyR3Y2WSDXlr9ls1S9RAA1gCfgd7QOVCMb
	W5HjVCwr6/rm4TQbPnGktO34Qpks5g3yvTx/BwHBq59zng5U9E8QDRVfwZqKoWIr
	aPYgzTDVz8RsFVwAmoNXPKl09PVN12B0cJQwLyrlirUAokXpP4Rxeme5NS8Tn1P1
	peHWLkfJtjko/wuyGCvhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1702731154; x=
	1702817554; bh=S2oZrM9VplF7tk9wf9xKeyfGCtTRYHncJ+U5R2mrlVI=; b=a
	s9fC/I4KRQpEkBuqNM2sEBBOkmqSAx8AQjRHgk1to83SFDqHdfOZ8sKLgddp4pMf
	MiDZNg4BdIGqrbylaHMKWp7ih/2LV8eI9OZRYbbMXGhSV3xiRZYRJL86w55sOHsz
	KGFi4HDNYOvpdGYAYpPyHuLBfLnBBvmi1N/UKpBXNt3apgqBHObH+3dyR4qSwX4F
	Ak1zGBbxoMcLS9PjDetUMjhOpQNw0/wovl+WMcJrZefWtQTiBUQxq64SGSZwMEr/
	rbYZGDDR8X9dOkv9R6pJdUmArR+iYsFwM0urGXo31CUuk7q7pYuUrq25YiFIGMLj
	lIhxIqUoSOVClCOoaadSg==
X-ME-Sender: <xms:kp19ZTJzajDr6oNia4T1Y73JkeyAYIA7amnSiDYNakDpTzXuAaszEw>
    <xme:kp19ZXIU4BZzexYyVOS9XbIavayZ3TgoU12DySiSFSHq2pf1bcPQnGAroO9SpyA5s
    Nu5NVDku71QiqVbd9k>
X-ME-Received: <xmr:kp19Zbt4P7yeVvKtDb4D6Fx1Rl-b9ZZpRVyeMUhy3IUC0nT-rvp8ubBCso6a6vA3pbgZ34G1vW-3LyhNZSOREQ5PTqGYmKmM6moNOvhO0xg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtgedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:kp19ZcbVxeheA5y-UXc7L1u9YAI2pAMmVvNw1M9hQ07Qfvj8jaVDDg>
    <xmx:kp19ZaatF93eS6wOGW8WrQHv4r5dk-xGrJbMHYXE-_PTgaKjBzUgWQ>
    <xmx:kp19ZQCwBvOPryQfkN3KYdInO-EV9HwpEvEYK2D-nDzIGFlVYSmVOw>
    <xmx:kp19ZaEV1dBIHw-_O9_bychMwL7PjO2Tl-raktht6sfyJfszfHGYEA>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 16 Dec 2023 07:52:34 -0500 (EST)
From: Gary Rookard <garyrookard@fastmail.org>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH v3 4/4] staging: rtl8192e: renamed variable HTFilterMCSRate
Date: Sat, 16 Dec 2023 07:53:03 -0500
Message-ID: <20231216125303.3404-5-garyrookard@fastmail.org>
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
rename it. HTFilterMCSRate -> ht_filter_mcs_rate

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
v3: Corrects versioning.
v2: Corrections to make applicable.
v1: Not applicable, conflicting line numbers, code change.

 drivers/staging/rtl8192e/rtl819x_HTProc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 6c1af19d67d2..0d57bcda33b4 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -397,7 +397,7 @@ u8 ht_get_highest_mcs_rate(struct rtllib_device *ieee, u8 *pMCSRateSet,
 	return mcsRate | 0x80;
 }
 
-static u8 HTFilterMCSRate(struct rtllib_device *ieee, u8 *pSupportMCS,
+static u8 ht_filter_mcs_rate(struct rtllib_device *ieee, u8 *pSupportMCS,
 			  u8 *pOperateMCS)
 {
 	u8 i;
@@ -490,7 +490,7 @@ void ht_on_assoc_rsp(struct rtllib_device *ieee)
 
 	ht_iot_act_determine_ra_func(ieee, ((pPeerHTCap->MCS[1]) != 0));
 
-	HTFilterMCSRate(ieee, pPeerHTCap->MCS, ieee->dot11ht_oper_rate_set);
+	ht_filter_mcs_rate(ieee, pPeerHTCap->MCS, ieee->dot11ht_oper_rate_set);
 
 	pMcsFilter = MCS_FILTER_ALL;
 	ieee->HTHighestOperaRate = ht_get_highest_mcs_rate(ieee,
-- 
2.41.0


