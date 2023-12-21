Return-Path: <linux-kernel+bounces-8932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9982381BE49
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2774EB21A3F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF9C5FEE2;
	Thu, 21 Dec 2023 18:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="cK8Hrws/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JKN4vO6c"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F4462809
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 18:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 6FA043200B1F;
	Thu, 21 Dec 2023 13:34:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 21 Dec 2023 13:34:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1703183673; x=
	1703270073; bh=1MdiefUWudgG5k/nsijxFi0g5Pt6tmJBiKrRc5LZoHU=; b=c
	K8Hrws/IiEutTbj2x0TfumpgBqqxfaRu6G0d98kdxPImt9bDgsLtA2CLScdmIXLp
	tB/L5jZEx4f1GQ4apnfgaJ7h0CSQhdLgGDYpYYeNlZbpIKgigLxhvYedznFeXSIf
	/Rvqc6Tgarfx4i+wsaq6y77I1qicmnSZOdUO33NUu1i4qdNpYFPgQ9982Xu5BXck
	6NCKu7mmZW3MzFngXLkD+595hbnu2STXLuE6xK4hovVvpY5VVspHzHB/HTaXEpAw
	TyTm6/hCLdp486gWQqUw/UD/aX6WZxtOvYGBJLAg8y7bhZH/hqX4eaAiOiVdFZR0
	PqpuL1hBJfG9cH5okJ48Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703183673; x=
	1703270073; bh=1MdiefUWudgG5k/nsijxFi0g5Pt6tmJBiKrRc5LZoHU=; b=J
	KN4vO6ccyLD0+/1PVgqB8BEL3W42S8bdDb0XybXugl6KO7WCwVwcVVCUG4Ms5kui
	TNzmacx1ckiP07ZY5ylBKdamwOiagR5D2CxY0O3CjzZGR4r6e3GCvonrsCRDoeVu
	dthqkjL1sWGC4ThdbRB4uFsFHqp7qOQeQIxIqCHEZH26MyoqLSY9GYh3ATzJwTNy
	QRKI7+k5Odmp3P3eUWamfQsPgcNv0HdVMirwHqYgNEka5q+bX02meyDw7w9q3VpB
	QpNpqPij7jhhgnOVw1QvoyKtODXQ5qWQUFKpnkELDhNpnoyTnU2j4HxRukNTIra+
	XixEwGDYhsfZYlbzFGY0w==
X-ME-Sender: <xms:OYWEZftowFytM0dQ0pdFeadk86M4t5Rnd60QiOBUynkDPLF8iBp89Q>
    <xme:OYWEZQdRmBXR4o2awiiKFh9FYcMsVEis69xPOSwDgPwS-KrYlTMl7tvBQQWVbMsjB
    5Zx8OHowlmSNFYvSVQ>
X-ME-Received: <xmr:OYWEZSwie8azL6mU6pet15OAWOimBJqjLNCiawWeNCub_umO466aFEzjc-s3MdUzenMhMrY0NvdDJzUKW8PZkHzlf8L8NndY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduhedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:OYWEZeOAlBAZC2rUbxXjN15E6SJr6lazj2SsOxg_hfrlMB9Rq1dIVg>
    <xmx:OYWEZf-WjmLo6DQvnUGmPgfoSIGvZzu7eQQpwc6pQ_l6yy14Oh8_nQ>
    <xmx:OYWEZeUAWuh_GEMV3dy5dWQTpOIxfAZCR2Hj6a2yX6uLjOtTKsAbCw>
    <xmx:OYWEZSa-6RspcajPStcGk5ArnXRns9pOEt3hR-mVeUOLIC6pt_FRIg>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Dec 2023 13:34:33 -0500 (EST)
From: Gary Rookard <garyrookard@fastmail.org>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH v2 4/5] staging: rtl8192e: rename variable HTSetConnectBwModeCallback
Date: Thu, 21 Dec 2023 13:34:12 -0500
Message-ID: <20231221183413.8349-5-garyrookard@fastmail.org>
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
rename it. HTSetConnectBwModeCallback -> ht_set_connect_bw_mode_callback

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
v2: Correcets typo in linux-staging mailing list address, patch series resent.
v1: Typo in linux-staging mailing list address, returned mail.

 drivers/staging/rtl8192e/rtl819x_HTProc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 5698b48fdcc9..ac17d510a2a5 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -633,7 +633,7 @@ u8 ht_c_check(struct rtllib_device *ieee, u8 *pFrame)
 	return false;
 }
 
-static void HTSetConnectBwModeCallback(struct rtllib_device *ieee)
+static void ht_set_connect_bw_mode_callback(struct rtllib_device *ieee)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
@@ -695,5 +695,5 @@ void ht_set_connect_bw_mode(struct rtllib_device *ieee,
 
 	ht_info->sw_bw_in_progress = true;
 
-	HTSetConnectBwModeCallback(ieee);
+	ht_set_connect_bw_mode_callback(ieee);
 }
-- 
2.43.0


