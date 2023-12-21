Return-Path: <linux-kernel+bounces-7789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB2481AD0B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDD54288A8B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8D4433DC;
	Thu, 21 Dec 2023 03:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="NzRNQHqx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ymjLaGgC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2B0433C9
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 03:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 2BBD73200A8A;
	Wed, 20 Dec 2023 22:09:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 20 Dec 2023 22:09:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1703128182; x=
	1703214582; bh=9jw6b4ctxOb/8uYJBFa5pYNQkgdRK6UDuv41VJI8kCA=; b=N
	zRNQHqxEemc2QvdQKbpki0idb1lVg7Le0wKfSPGzVU11q/PzwU+VtcrXdUj9BDOl
	efc6A85CsKsoA/fooUw6s+mx2hWOVPVquRtl4KvDiTFXe1czECf5B1RbWkG/UKR4
	PYSudptalyIcZl9ZOH9Ah7HbqcBVfcg6FMXDK0SPuJwFZzUOM9DdJugG9xtaoTqq
	rgY9HdisHqsJJ4pvNMKSZHnm9vYRzG62EKEArhjeuuc8RyOOG5mZN2eB9X70hX2g
	Qkxb37UwPZphxQH4wIGYBRHgEIGsZfbuXXVLSBfMOMpzQi10Ww4gGCFECpwdCSEs
	cthi+8rNrUor2daWClVOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703128182; x=
	1703214582; bh=9jw6b4ctxOb/8uYJBFa5pYNQkgdRK6UDuv41VJI8kCA=; b=y
	mjLaGgCeBcEZht+VOe8sdvap144hlZt4YWjhITxbvw4YMZ/DSs7dYugBb5CiG2kb
	Jm8DK6Ld86HdgIjpgMRW3xyjtYWOu9Cum3MQ7nHvKbUcon8i4ivXjBRyON7bVygG
	Ym+RdOj1S+Qj4hSlnwQ7b+q3Ff/1i3Lz2NT4374OycZ7w0KqZ4pAY9lqbyAlGP/P
	m8/Trb3RJTZJfswc2viH336SaKjxRurRtJukJAbmS7w8N5UFmTYF/KqGN5whfJno
	KV81hwqyKkMQ4S2A7jlQkzAeGtOHLrFAr11bC3qm+zGirCWzh/fgyzexRlV4XAiY
	ShBorvZrTAF5gzzBUjr+Q==
X-ME-Sender: <xms:dqyDZXeuecdHoxOd-w7RzjfXdQz_83xUdnUN1kwrkQ2OR9R2D66SQw>
    <xme:dqyDZdNOOJGtDck0kbShg-ojaQD3LKOuI6S7kSJmbGYvJXRijdOR6pc1Og6kOJG3j
    J8feuvuhuaP_OGrbjo>
X-ME-Received: <xmr:dqyDZQh6rwc1zYaHqFkQGgfgxUf2ydOw6UAkilIvcqO2BHAQx1rs9mponMUHM6YOE4KDelxZ6jNU_bRUrY0JxOT73-Afeuj3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddufedgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepvdevtdeigfduvd
    euhefguddutdeijedtvdejvdevvdfgvdetudehvefhhefgieeknecuffhomhgrihhnpegs
    shhshhhtrdgsugenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehgrghrhihrohhokhgrrhgusehfrghsthhmrghilhdrohhrgh
X-ME-Proxy: <xmx:dqyDZY-RnaGQaDlv0F8cKmRnRcTJcQeJBArTj7NyeOulAl32iGZznw>
    <xmx:dqyDZTs49c6FpHj7tJECmEhfeiRgjhS3-juBQAT8LHvEu5MF9XKvCw>
    <xmx:dqyDZXGPOPCY_aSjTm7l1zVg85N_xMuhi99pefzm1gHwjWVO8iaDQg>
    <xmx:dqyDZTISX-hKrJ80-tFgyCDbsXB9GnWN9OoLNWv64uzbwAyaTSX1Nw>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Dec 2023 22:09:42 -0500 (EST)
From: Gary Rookard <garyrookard@fastmail.org>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: linux-staging@list.linux.dev,
	linux-kernel@vger.kernel.org,
	Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 2/5] staging: rtl8192e: rename variable HTResetSelfAndSavePeerSetting
Date: Wed, 20 Dec 2023 22:10:01 -0500
Message-ID: <20231221031004.14779-3-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221031004.14779-1-garyrookard@fastmail.org>
References: <20231221031004.14779-1-garyrookard@fastmail.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Coding style issue, checkpatch Avoid CamelCase,
rename it.
HTResetSelfAndSavePeerSetting -> ht_reset_self_and_save_peer_setting

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index edfc2c7461ee..a32f3553df93 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -558,7 +558,7 @@ void ht_initialize_bss_desc(struct bss_ht *pBssHT)
 	pBssHT->rt2rt_ht_mode = (enum rt_ht_capability)0;
 }
 
-void HTResetSelfAndSavePeerSetting(struct rtllib_device *ieee,
+void ht_reset_self_and_save_peer_setting(struct rtllib_device *ieee,
 				   struct rtllib_network *pNetwork)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 193b4a5a7c04..78eae7daa351 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1759,7 +1759,7 @@ void ht_construct_rt2rt_agg_element(struct rtllib_device *ieee,
 void ht_on_assoc_rsp(struct rtllib_device *ieee);
 void ht_initialize_ht_info(struct rtllib_device *ieee);
 void ht_initialize_bss_desc(struct bss_ht *pBssHT);
-void HTResetSelfAndSavePeerSetting(struct rtllib_device *ieee,
+void ht_reset_self_and_save_peer_setting(struct rtllib_device *ieee,
 				   struct rtllib_network *pNetwork);
 void HT_update_self_and_peer_setting(struct rtllib_device *ieee,
 				     struct rtllib_network *pNetwork);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 9c94c5ceccd5..14f34e6a591a 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1219,7 +1219,7 @@ inline void rtllib_softmac_new_net(struct rtllib_device *ieee,
 				ieee->AsocRetryCount = 0;
 				if ((ieee->current_network.qos_data.supported == 1) &&
 				    ieee->current_network.bssht.bd_support_ht)
-					HTResetSelfAndSavePeerSetting(ieee,
+					ht_reset_self_and_save_peer_setting(ieee,
 						 &(ieee->current_network));
 				else
 					ieee->ht_info->current_ht_support = false;
-- 
2.43.0


