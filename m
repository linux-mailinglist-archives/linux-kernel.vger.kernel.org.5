Return-Path: <linux-kernel+bounces-2183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E171B815915
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 13:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90737285E7A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 12:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE61B24A03;
	Sat, 16 Dec 2023 12:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="V+nA7giY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="9VZbmV49"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DC618ED2
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 12:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 885635C0163;
	Sat, 16 Dec 2023 07:52:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 16 Dec 2023 07:52:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1702731149; x=
	1702817549; bh=eQS8EaoNWpSN2ocsnTg2aIeyec3HLRleleGCcF4RJis=; b=V
	+nA7giY69FIg+/AN0ctXXmyqO5O7j8W5IcGQc4xGfo1rJ2489wr3Bi01zmBpp1k/
	B/OdaGt+sIqus4GKLA6IrkZ0iefi8YDe8Wgn9jKILtdDz7py3c8p/2kREzmHZRPC
	KLctsZtAvThgN5kdYY1p3bZjPJ8Zy2dsJABEwQLF4YwQUVgVydz510bUahKScEnv
	btVdob6TwI3/eqflrZWShXgiB7w+MIHbIbNSF5qeTtSh5L6TnlV05EgHbd71uk1A
	GYbW4sWoVXzAB0irhxqZo+ciDgN92kja7ixcQds7u1BrfjzshaAbHz5eOiJXnqwk
	gmxH/ZlOVZbnMhKOJ/lXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1702731149; x=
	1702817549; bh=eQS8EaoNWpSN2ocsnTg2aIeyec3HLRleleGCcF4RJis=; b=9
	VZbmV49unnPxR49EdIEE3e/pvqP5s7FX/YBP1w5tCFbvZ4G4gZ6bm7NO+zl+mD/Y
	n5Oqpj5a/RZI7hfh+/r6PirJ0tKyLXQApEmerGZGIX/x/8aXqiDIfP8kTwwQldbx
	46FP+/NEGLxRD8Ie5YkUyN3ZKp8h2EK6w7bfIxZZeXRl9XLz9TrPYWpifp3gT+Sk
	0xPe63xpb1kAU+yuLnEF+rT8bwvOtdnZvDO1oQSau0Uo/jeMUChfF9Ossw1q2iol
	zX6XmWyELjbNYK6x7g9/7lzyw202wiArDogVkCBbCyKUAyPxmFSV7RQ32g1NOuCN
	4EBCmRrE4M5kGUteUbzpA==
X-ME-Sender: <xms:jZ19ZXM0IiHHruh9Meo-WD9EdEdwOpN12uAeng4q305dmlzwePiXTQ>
    <xme:jZ19ZR_DqTK1I6dPZQBXOaI_Z_hSDK6yElgEQJRXzXlPMQNvzoQFBpEGv3PTVOBN7
    50ZnY0aC5iifd0JhR8>
X-ME-Received: <xmr:jZ19ZWRGitFNlxrapegDRPsZz2zlQwncfEP6USpXunaVLgWEz3Qp8EgBS3hP924FKAsHFJVNy4gmEDTWAfErhMLw4yAPotIqNbLLQzKYnHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtgedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:jZ19Zbs8MVQU8E_Rt-mCKzCfrCdVvUq1xwbQv5fRQhi52FV6XgSyBg>
    <xmx:jZ19ZfehLniXiJWSpE7rW8HZ109gQSYaU1mDZ9BzVUpW9PhECKkfHw>
    <xmx:jZ19ZX18-RPkgdne6wSFgYBcb5bYnwe_k-flVk9ktefYgVZlbNzjbQ>
    <xmx:jZ19Zb4UNA7iQD5yYME1CMPHapFBcDyDRk4XgcbAM7wtmjFmbxEYzQ>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 16 Dec 2023 07:52:28 -0500 (EST)
From: Gary Rookard <garyrookard@fastmail.org>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH v3 1/4] staging: rtl8192e: rename variable pHT
Date: Sat, 16 Dec 2023 07:53:00 -0500
Message-ID: <20231216125303.3404-2-garyrookard@fastmail.org>
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
rename it. pHT -> ht

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
v3: Corrects versioning.
v2: Corrections to make applicable.
v1: Not applicable, conflicting line numbers, code change

 drivers/staging/rtl8192e/rtl819x_HTProc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 90a9356d78ca..29c3d33bf5a6 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -230,17 +230,17 @@ void ht_reset_iot_setting(struct rt_hi_throughput *ht_info)
 void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_ht_cap,
 				  u8 *len, u8 is_encrypt, bool assoc)
 {
-	struct rt_hi_throughput *pHT = ieee->ht_info;
+	struct rt_hi_throughput *ht = ieee->ht_info;
 	struct ht_capab_ele *pCapELE = NULL;
 
-	if (!pos_ht_cap || !pHT) {
+	if (!pos_ht_cap || !ht) {
 		netdev_warn(ieee->dev,
 			    "%s(): posHTCap and ht_info are null\n", __func__);
 		return;
 	}
 	memset(pos_ht_cap, 0, *len);
 
-	if ((assoc) && (pHT->ePeerHTSpecVer == HT_SPEC_VER_EWC)) {
+	if ((assoc) && (ht->ePeerHTSpecVer == HT_SPEC_VER_EWC)) {
 		static const u8	EWC11NHTCap[] = { 0x00, 0x90, 0x4c, 0x33 };
 
 		memcpy(pos_ht_cap, EWC11NHTCap, sizeof(EWC11NHTCap));
@@ -289,16 +289,16 @@ void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_ht_cap,
 	pCapELE->ASCap = 0;
 
 	if (assoc) {
-		if (pHT->iot_action & HT_IOT_ACT_DISABLE_MCS15)
+		if (ht->iot_action & HT_IOT_ACT_DISABLE_MCS15)
 			pCapELE->MCS[1] &= 0x7f;
 
-		if (pHT->iot_action & HT_IOT_ACT_DISABLE_MCS14)
+		if (ht->iot_action & HT_IOT_ACT_DISABLE_MCS14)
 			pCapELE->MCS[1] &= 0xbf;
 
-		if (pHT->iot_action & HT_IOT_ACT_DISABLE_ALL_2SS)
+		if (ht->iot_action & HT_IOT_ACT_DISABLE_ALL_2SS)
 			pCapELE->MCS[1] &= 0x00;
 
-		if (pHT->iot_action & HT_IOT_ACT_DISABLE_RX_40MHZ_SHORT_GI)
+		if (ht->iot_action & HT_IOT_ACT_DISABLE_RX_40MHZ_SHORT_GI)
 			pCapELE->ShortGI40Mhz		= 0;
 
 		if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev)) {
-- 
2.41.0


