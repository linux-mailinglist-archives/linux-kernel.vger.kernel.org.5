Return-Path: <linux-kernel+bounces-1919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC7B8155CC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 02:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49684B23719
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5A67480;
	Sat, 16 Dec 2023 01:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="siGbXl7G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="03+43M1q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC755C82
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 01:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 7A8A6320099B;
	Fri, 15 Dec 2023 20:00:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 15 Dec 2023 20:00:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1702688454; x=
	1702774854; bh=/rTFRkoubujNguLvM+nzRXTxdokh3eYIDIQoUp6/p3M=; b=s
	iGbXl7G+SZK5drAIJOu8vfi3gqVnjChWpIOCyN/Vq2qGyeneDFwsovyUrRcCRXOW
	r0Lxyi5fLZ4QIyaag3HBrxQPJ5ZEzgv0FMx0QioqYD2/qosc1f7Q1Rld8f9F5tE4
	9L1EincJ0iLMnnPD3wTrglhxYoRxfbZmlUF3BkFZtB/D81HrtmVZw69JMLWMNxgw
	CXaL4wHhtTdMqZRlDea8xY6q/1CmVUxAFklQ5jl8EPYAoiGwqYiEIAV8SZEKydGb
	aw3Pe3QtJPoF9gyTF0lQb5t+yLJB43b0fsOoWT1SDhDa595A3wMOV3hbeGM71jTo
	YzO6EmPblv3+Utg6myp2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1702688454; x=
	1702774854; bh=/rTFRkoubujNguLvM+nzRXTxdokh3eYIDIQoUp6/p3M=; b=0
	3+43M1qOchUAv6UOOyPpAd5jUESDU9PkMPaXR5oPzXhWkWiSz6HrCNQM1oNm2J8H
	/0LU/gVQ82lk2ajieR++7H1CK8TQ/RQCvGxjgM0NRuurySoEul9nNfOs31eXfaxT
	YksimFpmQJO/cR4s7brdNGUXo3Kpk149gynNKs9MbHR4sYwCjjfWX1yt9ds/XiwR
	Axa5YKt688Sj3HQEdwNVi67cTmlb2hBhLrtbbphZ5c5Ax7Sz7dHqW1f0Fl9X17ye
	gCDmDqcWYXWROp3YWQmrTszYXr4GEZHhfcYI3i+K6EAwsP2nPfqmEgfna5wmBZni
	8cRc0Ns62yp4adkTFhnYQ==
X-ME-Sender: <xms:xfZ8Ze0Rqz1yU68QZ0dKDxK6apfeD0isbx2SjpM_3Yec4DkyGX5tZw>
    <xme:xfZ8ZRGsY0gKp0gA-LtstO-1MEX8EAxpNNPLAatZmxFlGA9dz7Nf5U1HhAxpRU2SV
    lx24Akj5KC56Z1Xbtg>
X-ME-Received: <xmr:xfZ8ZW7hE7RA5quLYPEj7YB39oYpRC33lKcZjVuCU4Chu0bcLvUqlaNi61GD5zs4BN_gciItQ6ulPyodkbW16L8oRmMRx0m_N5UVjWRHdc0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtfedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:xfZ8Zf07SwME7dOPhzpuLLsrxNLJvAsitHAQWxfBmVZFHwgOqE0mKA>
    <xmx:xfZ8ZRGdbe5-B0bdazgs5LTPZQonreQrMLcyEkV1MsWDLT5vUyBUtg>
    <xmx:xfZ8ZY_CWwrjlW8XcEG_WYL3Gg17yxozGAic5JxLImsvKloFDAs3GA>
    <xmx:xvZ8ZRBL_igencsSKSr2GcbfX9Ij0n_7_DF6Orr-frik74MrNZFtJQ>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Dec 2023 20:00:53 -0500 (EST)
From: Gary Rookard <garyrookard@fastmail.org>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH v2 4/4] staging: rtl8192e: renamed variable HTFilterMCSRate
Date: Fri, 15 Dec 2023 20:01:05 -0500
Message-ID: <20231216010105.9810-5-garyrookard@fastmail.org>
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
rename it. HTFilterMCSRate -> ht_filter_mcs_rate

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
v2: Corrections to make applicable.
v1: Not applicable, conflicting line numbers, code changed.

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


