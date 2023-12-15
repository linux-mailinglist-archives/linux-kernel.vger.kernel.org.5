Return-Path: <linux-kernel+bounces-1806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA36F81545D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21F86B2319A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03B949F7D;
	Fri, 15 Dec 2023 23:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="lOwaxZ89";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2K0RrMZV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EA04653B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 23:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 594435C029D;
	Fri, 15 Dec 2023 18:12:03 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 15 Dec 2023 18:12:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1702681923; x=
	1702768323; bh=1DHPsvWEuMaTTOoIqrXEFhe9UR8dRXa61SmYgRwAafA=; b=l
	OwaxZ89ztzl0SC5n+yAE5yEQbQWYSdlpN0FGXCX6UBXSPJPAdDIXcfVDjULEfy0P
	5bKMoDZvIB/P7QdVIERwa2k0b6PPood36GlWe1p5YpFFiaJQ9ldBXdmCxl0bc1e2
	N/Lg60sUDH93zC83VLor5u2QrPcUS3r8uEvmzPb+S/qGMhyWO8/OUecvz6nU2vi2
	uTC0bM3bueYtarZ4JMmeNkdMaVR/ZmzOFId+FyBu6Z+R5Z166k45Hg+y8dZPdyDv
	3Vzym6WIhBeTMEXr3LGJxV9denJeDTVzHovKEJY/X8JTNwpGIdb0kU8qUEmui4Qs
	ZoPOofTF+op0UaFWEHaDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1702681923; x=
	1702768323; bh=1DHPsvWEuMaTTOoIqrXEFhe9UR8dRXa61SmYgRwAafA=; b=2
	K0RrMZV5YiUmNnT3K/nu8GYoO0O0zxH6T+gSsn55WPBKI5Fc3sT+iT0AjUqHxv9Q
	edIvkczllt7k2KL/esoLz/53cwbuvW1l1JaVFwc8ieVR7cnDz3m2wYcN+P75tqsj
	F64mNp+p1Rq4RXrheXkIKHgDd64V1gbz3ghHRVP+VsLPXLausy4uJb9BmYr0jT9I
	BtvbGl+M1P4h2iEmkoj8qwolmpEHbtUuS2N0lgrZ3C8vBiEJbedPDbl9gzsgdehc
	+ox//GbTK8vlMQp1XGyPSfTrNU9DuL/kaAhkcL+OYenWQdau7iBvNXYoVYiXvZ3i
	6JuB6004AIX1JfBcOFV9A==
X-ME-Sender: <xms:Q918Zbh3PKm8K0mtb9vqQ9khS7reI1cgknnNQOsunB5Bix7btdW7Zw>
    <xme:Q918ZYBl5Jc-QzP2-wkeimS_L5ZEtfS3h7162ZpaA0jyDSSLBruEnc8g5uHA8Co_4
    wQYoq2itVBJGb2XFHE>
X-ME-Received: <xmr:Q918ZbGP0Gh8x5-8OM7_M4AWbnPhDbkYytfQjLHXRlcKXDCEA4OE8UKRlOhDABU5fGG0DuIlYL1VptGHaOPiFSHE9GBAxqfhsMsu2RbwT74>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtfedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:Q918ZYSg9Tv8q-JZLgeWRz0146MB7TuueS6sDDuBpVfEgh-U0JvrAQ>
    <xmx:Q918ZYy0v-OsiRgJTbp2nwlYARC8zz10IbzsmrcQYWhvetqJIQwfdA>
    <xmx:Q918Ze5DzI4qDBG9mYms-57a58gCecuubwkF3_3JAlWVK6TmDIxhbA>
    <xmx:Q918ZU_5k88PxfTkV9nHN1_vKr5OKdESCb1C-BLiMbJV6vl9XprU1A>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Dec 2023 18:12:02 -0500 (EST)
From: Gary Rookard <garyrookard@fastmail.org>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 2/4] staging: rtl8192e: rename variable pCapELE
Date: Fri, 15 Dec 2023 18:12:33 -0500
Message-ID: <20231215231235.8265-3-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231215231235.8265-1-garyrookard@fastmail.org>
References: <20231215231235.8265-1-garyrookard@fastmail.org>
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


