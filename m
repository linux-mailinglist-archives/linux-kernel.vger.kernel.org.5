Return-Path: <linux-kernel+bounces-19068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68972826769
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 04:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F23A71F21962
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 03:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C0A249FD;
	Mon,  8 Jan 2024 03:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="li5baQRl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="6JjFoVNq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C2F219E2
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 03:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 2082832012CF;
	Sun,  7 Jan 2024 22:23:16 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sun, 07 Jan 2024 22:23:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1704684195; x=
	1704770595; bh=+R3F62X3U/sQ5pF/DcFmLgx05zf8bbzHtroH7XEogPE=; b=l
	i5baQRl6pYxe6CD2U6RME286qPXP3XtvWT6hAiH+vGikjG0St5q8oBu042i+eq7b
	jvYLyAaxq6OKykMCPQePZCGuFl1O9mltTlVz3ryxNawuwjZ/6ZLFmPAtqPNujF08
	DF7lmF4GHYCksCb0Hs6k9p0EvKhpEv5v5i7hcMTPMDC/eetpydUyaQDpXo1eevP7
	w4Ue5VYppn0x98PK9PNo5OzYM1UiiIihhdvpjAtGE1hn3ovLcSXmNcYr9O6c0IBR
	EPeFdz1zzbXvh46i1Z7aBJwI3ltmngwcqY1JuG9FTkerKR3h7zYxYSxKLAKFc3nN
	NPJts0mm+Hisv6gt28z1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1704684195; x=
	1704770595; bh=+R3F62X3U/sQ5pF/DcFmLgx05zf8bbzHtroH7XEogPE=; b=6
	JjFoVNqjbtpUaXSMmbLPKdvvZmXxj2mZIReKcnar3THr95kYBtSZ8xfGtXZj10i+
	H3etDQQN+elSFyl+uhqAGNPhLPyTZgljQ7qO3PX0jWbIBS060AG40vWqjpWqTMGG
	RuJiZvqmWzYtkmTWP9MjkQXUPOMLLVjA9Dj6h7TSfGkkle3hKgMRhYjbYkTcxmK+
	7+/rpEWaA4OyfTWO3iSX7EfgfFYwu7pDf7G70lBIHCVQnvRARiGGKfe4z7GDjKJE
	BGToYa+G23uU1BgMrr0pTVmRUq28BlKKGrxe8xewIt3RzLmDwp7mjfd7d8Y+2RLR
	QJ0OHAS/H+2TGOGtUnJ6g==
X-ME-Sender: <xms:o2qbZaG3q4HHAWTEhGGw96y_8JOwiwzE9LI4e8qxkwNDIFGDBdwKlw>
    <xme:o2qbZbXxeatT0ojUQc9WDEiDwfgT0840MNQG-zXxSyS_WNppbQlGGJRx35Raav1QI
    R34bl2Bnfnm5gQZAKE>
X-ME-Received: <xmr:o2qbZULgUFI7aaNiHf6Zrdu5ZPYFltQcgcFdqsv4HFKhlB7cQP57r_JHUwVLkPNhKMqCRkZMTLSTkVu6N_EfJpxb31O1LTWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehhedgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:o2qbZUE0pvMHKjSb8QjFB3gQjJZlh06_95JqiWsEpkonBEjqWDCDAg>
    <xmx:o2qbZQVq5tYmQ5kigjWBVK2kUo88TolULr7XBSKlunrBbVY3AErqPA>
    <xmx:o2qbZXM-3hbE21F4_rrIwD_iGhfKBd5NlmOIEf_bLCcp61egZqnEiQ>
    <xmx:o2qbZXTftlS6EI5ZRapeIPZndpxr99NvpU0mR4WQ90iyodXHIx88Kw>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Jan 2024 22:23:15 -0500 (EST)
From: Gary Rookard <garyrookard@fastmail.org>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 5/5] staging: rtl8192e: rename variable AdvCoding
Date: Sun,  7 Jan 2024 22:22:33 -0500
Message-ID: <20240108032233.4280-6-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108032233.4280-1-garyrookard@fastmail.org>
References: <20240108032233.4280-1-garyrookard@fastmail.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Coding style issue, checkpatch Avoid CamelCase,
rename it. AdvCoding -> adv_coding

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     | 2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 68577bffb936..95613619d568 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -24,7 +24,7 @@ enum ht_extchnl_offset {
 };
 
 struct ht_capab_ele {
-	u8	AdvCoding:1;
+	u8	adv_coding:1;
 	u8	ChlWidth:1;
 	u8	MimoPwrSave:2;
 	u8	GreenField:1;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 5598e74187cd..351000d3bce7 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -251,7 +251,7 @@ void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_ht_cap,
 		*len = 26 + 2;
 	}
 
-	cap_ele->AdvCoding		= 0;
+	cap_ele->adv_coding		= 0;
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
 		cap_ele->ChlWidth = 0;
 	else
-- 
2.43.0


