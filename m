Return-Path: <linux-kernel+bounces-1807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B8D81545E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 280522878C1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7901E563A2;
	Fri, 15 Dec 2023 23:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="eu/WKnCb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kmYZUZ8t"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1FF49F67
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 23:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 5286B5C01B4;
	Fri, 15 Dec 2023 18:12:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 15 Dec 2023 18:12:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1702681925; x=
	1702768325; bh=xFMn8TRG6BQqEPJx0TwrVqYON1NIGk0tmOvBi1/MOLE=; b=e
	u/WKnCbk4ND+W25ezcJW4/hRdM41dM2mvC+eGJi4285OwylfQWg39NsqQzmxVs7i
	CpsGBgx/PFOpI7qTIaW2QkgCYz8tIrpr7ueqZY85cuoUoSEWuMnxOJQrbSJZHgQn
	0U25GHSOZ+fxkUUYcdk+xP79plwl1ew/dRl1d+OlakrVSTXrfEs7lZ5N7qwwpBno
	1dMFHgcVCRvhilZ7THEftkZXhIHtfPjTj2xhI/KF5pJlI/6VnHFqTv0ZWGOx7lOa
	px02DMn9nQQ+0WDIuObsfxmrPWIYLS2bB3fGHeGGmMZc0YCs20W8JEfDvGbKJHBB
	zMhV87KK5swLaMvjC4HCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1702681925; x=
	1702768325; bh=xFMn8TRG6BQqEPJx0TwrVqYON1NIGk0tmOvBi1/MOLE=; b=k
	mYZUZ8tYymJQwLBFQWPdwztSr39kTRBM6Bkijn2KxhbkTHOeuOAnax+IBYP3/j3A
	WEbCIlUNViz7dvU3160Jf2klcSOqpR591mbT78YabzPWb/c8u3AJ1onXAtf2/izK
	uRILeeF9fFVXza/PbA/BZt6ysCfrDVYItKNRgrhkqCbXeHd00UZKUlGcAsq63f4Z
	GaH90enoG/McaSogCKhmayXDV8WoCmV85jYBNT+PK7d6AZ2Dmu+2NQV1zzkGgcfJ
	qATxEcORm4Za7iGvbrmjec7+OwWATUWxFAi8rbwUq5bjuB7MXCLg5alA8CxWFUG4
	on7L0oVTnUkhhrBLXQyKg==
X-ME-Sender: <xms:Rd18ZakzdDPtYvTNRo18Tw1UUipq6pzMyBVk226WJDXtT7JFQKEtlw>
    <xme:Rd18ZR3xpcTaXhtlPHjsVegY9vAnCQkJa2T3xvWGDUQE4M05kx9xkbj3Y2rpC3Cy8
    CJuMoxxpNF9wnn50r0>
X-ME-Received: <xmr:Rd18ZYoPZDUPwwwa7XDZn8QJV_TSiQRh7s4v9-I6Fm7ZvC41t9TgjnD6_WpQweInhKJmxMPA8XFUHoploqEUL-lgCR-31vOCJQotuE7J85o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtfedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:Rd18ZekFrOU7IaEd9AMd-VHjt91woiYpg_IE9-2krIH3NyEUp4KvEw>
    <xmx:Rd18ZY2enRTCVBhJ7wTiVD23lYKW8G6iJiKrqrFNOpBbVjGx6ZVmpw>
    <xmx:Rd18ZVvMcVT4F-LdEZfGR3JdrPjzVzge6_UBRoYygfp2O8qDJarwEQ>
    <xmx:Rd18ZVxCZ4R6OFpW8jsoYCApo4sDpNdNQ-P8_Rj7Oow-LeH5B3sinw>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Dec 2023 18:12:04 -0500 (EST)
From: Gary Rookard <garyrookard@fastmail.org>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 3/4] staging: rtl8192e: rename variable HTGetHighestMCSRate
Date: Fri, 15 Dec 2023 18:12:34 -0500
Message-ID: <20231215231235.8265-4-garyrookard@fastmail.org>
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
rename it. HTGetHighestMCSRate -> ht_get_highest_mcs_rate

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 4 ++--
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_wx.c      | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 8d9037130424..6c1af19d67d2 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -357,7 +357,7 @@ static u8 ht_pick_mcs_rate(struct rtllib_device *ieee, u8 *pOperateMCS)
 	return true;
 }
 
-u8 HTGetHighestMCSRate(struct rtllib_device *ieee, u8 *pMCSRateSet,
+u8 ht_get_highest_mcs_rate(struct rtllib_device *ieee, u8 *pMCSRateSet,
 		       u8 *pMCSFilter)
 {
 	u8		i, j;
@@ -493,7 +493,7 @@ void ht_on_assoc_rsp(struct rtllib_device *ieee)
 	HTFilterMCSRate(ieee, pPeerHTCap->MCS, ieee->dot11ht_oper_rate_set);
 
 	pMcsFilter = MCS_FILTER_ALL;
-	ieee->HTHighestOperaRate = HTGetHighestMCSRate(ieee,
+	ieee->HTHighestOperaRate = ht_get_highest_mcs_rate(ieee,
 						       ieee->dot11ht_oper_rate_set,
 						       pMcsFilter);
 	ieee->HTCurrentOperaRate = ieee->HTHighestOperaRate;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index b4413cfcb17e..966a62cfcfde 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1763,7 +1763,7 @@ void HTResetSelfAndSavePeerSetting(struct rtllib_device *ieee,
 				   struct rtllib_network *pNetwork);
 void HT_update_self_and_peer_setting(struct rtllib_device *ieee,
 				     struct rtllib_network *pNetwork);
-u8 HTGetHighestMCSRate(struct rtllib_device *ieee, u8 *pMCSRateSet,
+u8 ht_get_highest_mcs_rate(struct rtllib_device *ieee, u8 *pMCSRateSet,
 		       u8 *pMCSFilter);
 extern u8 MCS_FILTER_ALL[];
 extern u16 MCS_DATA_RATE[2][2][77];
diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
index a37250de7ba3..f92ec0faf4d5 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -134,7 +134,7 @@ static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
 				((ht_cap->ShortGI40Mhz) ? 1 : 0) :
 				((ht_cap->ShortGI20Mhz) ? 1 : 0);
 
-		max_mcs = HTGetHighestMCSRate(ieee, ht_cap->MCS,
+		max_mcs = ht_get_highest_mcs_rate(ieee, ht_cap->MCS,
 					      MCS_FILTER_ALL);
 		rate = MCS_DATA_RATE[is40M][isShortGI][max_mcs & 0x7f];
 		if (rate > max_rate)
-- 
2.41.0


