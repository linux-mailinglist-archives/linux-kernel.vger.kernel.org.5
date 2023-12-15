Return-Path: <linux-kernel+bounces-1804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F7281545B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8325B231D1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76E9482C3;
	Fri, 15 Dec 2023 23:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="JL4DajpJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wmgmG4sF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F003FB12
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 23:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 512BB5C01C5;
	Fri, 15 Dec 2023 18:12:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 15 Dec 2023 18:12:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1702681921; x=
	1702768321; bh=NaUjN3g+a3d0G2064+wY3rD5KV/0JB4rEeQ9newEbxE=; b=J
	L4DajpJadepvJDfVn0/mC219j5lkC4lp4afVIkcjevR5B4IE4cvWpe56iNhrJG1U
	5PqhI1OOyl32OWJjIPVOlwbjipj5BqrM8KorSO6O7jOJZU0AV7p/4m0t36EST51D
	vy+H8jgt6lwKoDTX7yMOL9lJBhSdI7KPwoKqKBfc97mVTn39rB4QymV60R5CUXjO
	1hzyuLjz6CFx74sIeupRBbssFcCbfsqBHYoVx/O/MCVqJwB48BOaVz6gJxf6DwMc
	Wdai5UvTVypWDMRB+0YL2aimPco0dbUeAdTpc/rYmBhHgu21Ra3Y8z6twVo/Ujg+
	LXy2+h7tEc2f0pkeAvifw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1702681921; x=
	1702768321; bh=NaUjN3g+a3d0G2064+wY3rD5KV/0JB4rEeQ9newEbxE=; b=w
	mgmG4sF8rfBuk/0KV2ORQhJsK6zKVbMlYFrFjPkljgtGslf/Z78cLEplk391tpl3
	qbw20QyoIwpD76IuUKLlfsKosB5swxBEF8jhbg2p2ldp0v9XMNtliWqoUtYrtCgC
	v2kdvju3+Htw/Z5Q5Vsse1QAKhRj38IzzTZWppP0eZ5bLaFG3RIL8dilFWwKVOpc
	cs1oC3GuNWkkT+d9MwBspvpHXD+69scuAqO8S+A6Fv6GdsMQ7HZGQIv7e8XSiwUm
	GrB14elcSGl4JJERwvNnxWb3HjKhw8a3GOZsw9rl7xRXyj5ksxbt+2jqFdspIkxI
	th/hP/NkmPPSdilInaRqg==
X-ME-Sender: <xms:Qd18ZbmV0eFClKLeN8kD2ZtLAeeoOBwSxtlom3rrbSUnfBGi86rNXw>
    <xme:Qd18Ze0RQy9QZ44eSYLifzjM892KgdrF89ydKMLL2nvRY8Hou2uccYQhfyE_sx0fq
    O-kW1MDfOhmCdrMuuE>
X-ME-Received: <xmr:Qd18ZRrohWXrTGIOGMCT9wAyWBv_W6dRbEg3aoijeXD6aVWYeEra__0XVM3H9fipJsmFx4NnI0-lW5nu8YdZBgUs26QOvPjo0h9pOnRnyPU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtfedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:Qd18ZTmbZlHs8B4SkYcWIhDUHlZpkyYMdfFUeDyEbJJVKeSEphodtA>
    <xmx:Qd18ZZ0R9ZrZgfPsmIh4w21A8qYPu7rpctjifkHbHRmn7oJyT6z0rQ>
    <xmx:Qd18ZSsqzgu2uL9CQiG54btSsao-HUrZzT6bC5hgcuEkKnDYXquJyQ>
    <xmx:Qd18ZSyKo0TIPq8Mtv0amsnp5h2lQ8_BuBKHIxBjSRa2INXLflZQ2g>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Dec 2023 18:12:00 -0500 (EST)
From: Gary Rookard <garyrookard@fastmail.org>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 1/4] staging: rtl8192e: rename variable pHT
Date: Fri, 15 Dec 2023 18:12:32 -0500
Message-ID: <20231215231235.8265-2-garyrookard@fastmail.org>
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
rename it. pHT -> ht

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
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


