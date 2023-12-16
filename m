Return-Path: <linux-kernel+bounces-1916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0B88155C2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 02:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2333A286630
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953F01846;
	Sat, 16 Dec 2023 01:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="eke9PR4e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RIMU3iVw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36738110D
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 01:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 254863200A40;
	Fri, 15 Dec 2023 20:00:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 15 Dec 2023 20:00:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1702688445; x=
	1702774845; bh=FoS8lC9fW9ZTl/Zz6IRqj1lD+lGfaphBlupDI+uRre8=; b=e
	ke9PR4eZsKu8kWsst8HH9MqI1L6iTC1fYTvEVcSdbHr9G8k+QEA4uQrqe+WaWZOj
	5yLDGMBcx6ZA7BOkbjlj0JIFFbu6L4sFb95JbWKp8ELQVxFUP5ahmwTxouqipY40
	Z4wEo2ZUJE7iB1c4wM2SNlQYR/V8SMLhztvpYnp62miYE131oexvo86Fsmvrte6e
	Zp+dOh0mMhgHHHra+0xS0Y/bwef1k9zffRgjmTexQjvc7K2yC9UgeN3D17lKN6mj
	UEJro7+cKjg/gOYlfNDO+nrHW74RgHmjKtrbD73LSBgax+vP8NcNEoCaxEmZJLAP
	IAiIlgJe/Jn004ek2ixfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1702688445; x=
	1702774845; bh=FoS8lC9fW9ZTl/Zz6IRqj1lD+lGfaphBlupDI+uRre8=; b=R
	IMU3iVwhDxdqpiCzKg5Ho1gm55e2eEKvZeNMq6ZxdIPtn8F+cq4zp9O/B8M1TXEC
	kzim8mGBx+D40OKAZQPC3QeN4OE2SB5R9cuJof5B4s5FyD9fH8tPZ9N94ouTU9DW
	pxLPELdP0F9UILC/DiXXbJSw4N04CPS39UTd9S1BobWYNqvPLz274gha/en7/ljs
	xmku1FJ2cwCaayiwnSbU/cOdcsYPRSV10PmWxQ8PQHPpmRKXGTUZDJwZ6qgKpfjh
	/Nc+EQ8QuYeJmQ1p344HT4rSNRoPa+CChvBtSA99jjooVkbZrdquBUCJQ+MTBP59
	bWxSe4Gy6S4TVn8lOQWkQ==
X-ME-Sender: <xms:vfZ8ZZHXJ7Vv-YHxtxGrVvKeDBq56MMTJL4_bHTBivxFRnhCHBI9dQ>
    <xme:vfZ8ZeUqRa3woiDDb_yltgSDSwjC3kGvqYPb_KqAMYXaH2CCX5i0gdeFP8wgNjzkk
    PDkxP8n862vjeqcNoc>
X-ME-Received: <xmr:vfZ8ZbJZeQM_jXFpHQwyBiN66Ptiuqorz1_XBkKTmzB5D5Nf9KnrNBGCjggy_JuBDixJMsYalFrV5Y-1jWln2PfEBNirSAuCjn5kiEU96Q4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtfedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:vfZ8ZfGIPNK3lwutlqltgvRF_N8vTwJ6V5FwPOCard_VYdh3RUl9pQ>
    <xmx:vfZ8ZfWYPl-9trufMPsXvaLDn2K1zs-eZ3jnNzEt9B9GNHDSgJl-4A>
    <xmx:vfZ8ZaPa1cM6uhjCDYGS7hkZNhKP8QML4abm73G-IRVkm9wqliriSQ>
    <xmx:vfZ8ZaTRk83SFXaSPGjqp-xNI5yvpipk4L8jJtaR1pmiDZSeKiZLmA>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Dec 2023 20:00:44 -0500 (EST)
From: Gary Rookard <garyrookard@fastmail.org>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH v2 1/4] staging: rtl8192e: rename variable pHT
Date: Fri, 15 Dec 2023 20:01:02 -0500
Message-ID: <20231216010105.9810-2-garyrookard@fastmail.org>
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
rename it. pHT -> ht

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
v2: Corrections to make applicable.
v1: Not applicable, conflicting line numbers, code changed.

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


