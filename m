Return-Path: <linux-kernel+bounces-2184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82701815916
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 13:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A67501C21811
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 12:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577FC2CCBF;
	Sat, 16 Dec 2023 12:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="T3P0vze0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H3LqYgDl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F50F1EA80
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 12:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 40C105C019A;
	Sat, 16 Dec 2023 07:52:31 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 16 Dec 2023 07:52:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1702731151; x=
	1702817551; bh=dMfBiLPrDQcW9AnWXKU6GAIV/OVOatyWhTRd7GzOOQo=; b=T
	3P0vze07dq1lpT4CLkC9bM1Fi5zE7tTFZJcjBe+Prk3WqsCfjqONC4oBxElnHOIr
	KizvOZ0hkLuop0aPO6WxOMf+2wF+Equ6+N09rMlXNjvIOsQWBmsNb+kSC34Z9Ed/
	cnLPeSjw44hMZvrH8AvG89JqO1l1T42SHrw8J32t8yCYlLZMcOWgzE67VqvJ4uOe
	NYj2jTfnmOPdr/RXJAonNR/chOBSqko3/1pzAzqpUuuPvUNPugUJ/mr0IT6oXp9w
	aCAY7KCK796TawZcYO9+4fj1mJsP54Nz75zV2YLGq7y8AJlQc1SDMKYR7EwoHhhc
	kULaOQiRPAMFcEeNBctbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1702731151; x=
	1702817551; bh=dMfBiLPrDQcW9AnWXKU6GAIV/OVOatyWhTRd7GzOOQo=; b=H
	3LqYgDlhKgS6QSGonArr7ez8tiXRxrx8mwcm0inmPcTA1i8Ce0FF9u8TnlSRPrxv
	OGRIJ6l0oni8UZFwj8Ojta3Kn64+Gbu3Vh3wqDalkcUV8VJvbOZRJAxN4o1kDvEb
	eNb37p+j3vYc9t6N9XH686V/0PQMumGtNsNaI5d/xUchXTXnhV1SnB64VX9jv6A5
	sAoFpmZjESex+auoS5x4eDZ5+qdCYEuOk3obPG345UP/zRmw5Imh/fgBULz7kL6x
	bO1rsrL4hq5FdW+XWjBv1vKYF8uohN17RB3ja8Y9oqNGSxmA/dO585BjzaC/dqYn
	Mb2nmTtpMLouQ2HViwWPA==
X-ME-Sender: <xms:j519ZYb6j3I90X4vjxH8zwTOfPPzai1VpwChkRRf1ngNn2DVkX4p7g>
    <xme:j519ZTYr4JHigb1tz0S0wU-qmi30HmhA0rLLfzDnijOLVxQJbdX4Xo4jV5OLN__Hz
    xrpxx8dy-U8BfkuXfQ>
X-ME-Received: <xmr:j519ZS9CbSR85DOoEDBZfJ6MdvPf8jtn276UJbUJ8pRmMpWXfaYGvhgw5qNPBTTXoluE3Q-U1X6E2-qSpZrJofjpEg6919SNrScEXgsFZ2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtgedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:j519ZSrUMraKjLB_46LmDf-BYx1q2Yv2OQq1_sY9GQgDkF7wJVP2AA>
    <xmx:j519ZTrWPX3-tJ0AdQI-srSS3wqGTPsCF1Ni4bemSqyw2rIjjwzMHg>
    <xmx:j519ZQTvKixeq-H--WqYOMjdsbAbexb2FIxtho7InW0PZz3f3Tc93g>
    <xmx:j519ZSWxOEnMhpduV0iEJOmFW8FW4HPT9sXHm2VxlUeQ0QAGUph9PA>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 16 Dec 2023 07:52:30 -0500 (EST)
From: Gary Rookard <garyrookard@fastmail.org>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH v3 2/4] staging: rtl8192e: rename variable pCapELE
Date: Sat, 16 Dec 2023 07:53:01 -0500
Message-ID: <20231216125303.3404-3-garyrookard@fastmail.org>
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
rename it. pCapELE -> cap_ele

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
v3: Corrects versioning.
v2: Corrections to make applicable.
v1: Not applicable, conflicting line numbers, code change.

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


