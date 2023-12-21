Return-Path: <linux-kernel+bounces-8931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E60D81BE48
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 606A81C22909
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA9FBA4B;
	Thu, 21 Dec 2023 18:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="T7WWlwMn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="8nZM40wb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C606519E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 18:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 298B93200B48;
	Thu, 21 Dec 2023 13:34:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 21 Dec 2023 13:34:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1703183664; x=
	1703270064; bh=Gxzeu2TfqRhvl96ezzD1mBuyLc4q4EaPGvDV+WsUUj4=; b=T
	7WWlwMngMOQJm4x7BULcxTf4nZcdDr42RZJcuVX/T4oX5YhAjwfRb8V+whyq1wGr
	PAh1NHE6Pd/gwy5CjAzIUuzuNsql4YcfahrQxlHY6NRN0eWNGo6cOuD8+GZogxnG
	4ANWExW/NUOyv8/+STg6ZQLJ7iSsWxYh7FU82ovVM22AvmwSsSeZyHsITxz+MRir
	aANBkIPmpOEOknRV17Ulk9sM6myJ0CHW+bYD+LEKz+UYFo+GgpxNM0n0QuPnmAKI
	X0AoYO/7xel/U3TXfIlgyKvshsVMKQk/9FfdA4bNjznnXop8jn7c37AI1qFj08RC
	nXGB5LY6MKwSWCvjOtKrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703183664; x=
	1703270064; bh=Gxzeu2TfqRhvl96ezzD1mBuyLc4q4EaPGvDV+WsUUj4=; b=8
	nZM40wbiFaBS3aV2+I9nxBRoIOSgmZNOYvf3kUABITOoBiVJBmlAVyswUwDFLvSl
	jemh+MIRcM9EZRVnC1FEYOF0b1EaPXNHhCOo4yYknqBm3bx8EnIBJQUxjIF/du9T
	nB9OSS/LnmUO7+dehGlLoEL2meE9SBVySh35NMw9WILC7ohGzklcqjcy6pBiOe0L
	zqgV3DcE9/jVNYUiT+pkdnZFAzfJSHWnrxeYlAKMw2iDjx4mtP4sBMt9h87bq6eH
	8vdtHpX3bE3CGjNhaPIScRVCgU9XvYZ1m6otQ6rHmtB7yoW6ZaCNNqKq7mS/E8EB
	jtQ1ViDE1KSXuNtwdD+ng==
X-ME-Sender: <xms:MIWEZab4rTMJ1TEv4cazzACczUROEH_-qALhg3O3Dcv4DTE6orRkpQ>
    <xme:MIWEZdYedsP2iUaTSwEXBntJTT1Egvk-7nKl1oRBLnWdbBv2dqgb1sdOI9r3gWNJs
    sypMNFp9N3iiEGszOw>
X-ME-Received: <xmr:MIWEZU-9p1FpOO4BUSIPxDUG9i01LSbWnINykBGI_JsqX85WO5WLh4qL-NgQAJ1dBbi8R98ZGn2KBu3Lk2Grgb_YG-EomSVa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduhedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:MIWEZcoAOMRmGjmWeYl9E4yrGkvmnJQ4Rc4q-6qh7jJbF7_kLn0XsA>
    <xmx:MIWEZVqWCf-ssidcek39wmVsoYUqhmFncpzhjXL4GTh4ZoOCg7pozA>
    <xmx:MIWEZaR8CFyljbPUZu3eFmp6vyd2agA3c7vU8LKeeoCg9EoLpSXrMw>
    <xmx:MIWEZcVS3ufe26gGyuOK85K4z5WFlYBMFpZhbB2RfnMbhuCKIync-g>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Dec 2023 13:34:23 -0500 (EST)
From: Gary Rookard <garyrookard@fastmail.org>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH v2 3/5] staging: rtl8192e: rename variable HTCCheck
Date: Thu, 21 Dec 2023 13:34:11 -0500
Message-ID: <20231221183413.8349-4-garyrookard@fastmail.org>
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
rename it. HTCCheck -> ht_c_check

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
v2: Corrects typo in linux-staging mailing list, patch series resent.
v1: Typo in linux-staging mailing list, returned mail.

 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c      | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index a32f3553df93..5698b48fdcc9 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -622,7 +622,7 @@ void HT_update_self_and_peer_setting(struct rtllib_device *ieee,
 }
 EXPORT_SYMBOL(HT_update_self_and_peer_setting);
 
-u8 HTCCheck(struct rtllib_device *ieee, u8 *pFrame)
+u8 ht_c_check(struct rtllib_device *ieee, u8 *pFrame)
 {
 	if (ieee->ht_info->current_ht_support) {
 		if ((IsQoSDataFrame(pFrame) && Frame_Order(pFrame)) == 1) {
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 78eae7daa351..341d9ddc9a1f 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1767,7 +1767,7 @@ u8 ht_get_highest_mcs_rate(struct rtllib_device *ieee, u8 *pMCSRateSet,
 		       u8 *pMCSFilter);
 extern u8 MCS_FILTER_ALL[];
 extern u16 MCS_DATA_RATE[2][2][77];
-u8 HTCCheck(struct rtllib_device *ieee, u8 *pFrame);
+u8 ht_c_check(struct rtllib_device *ieee, u8 *pFrame);
 void ht_reset_iot_setting(struct rt_hi_throughput *ht_info);
 bool is_ht_half_nmode_aps(struct rtllib_device *ieee);
 u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 nDataRate);
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 5f219cfb65eb..595ec9af25ea 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -857,7 +857,7 @@ static size_t rtllib_rx_get_hdrlen(struct rtllib_device *ieee,
 	size_t hdrlen;
 
 	hdrlen = rtllib_get_hdrlen(fc);
-	if (HTCCheck(ieee, skb->data)) {
+	if (ht_c_check(ieee, skb->data)) {
 		if (net_ratelimit())
 			netdev_info(ieee->dev, "%s: find HTCControl!\n",
 				    __func__);
@@ -1401,7 +1401,7 @@ static int rtllib_rx_Monitor(struct rtllib_device *ieee, struct sk_buff *skb,
 		return 0;
 	}
 
-	if (HTCCheck(ieee, skb->data)) {
+	if (ht_c_check(ieee, skb->data)) {
 		if (net_ratelimit())
 			netdev_info(ieee->dev, "%s: Find HTCControl!\n",
 				    __func__);
-- 
2.43.0


