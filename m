Return-Path: <linux-kernel+bounces-19067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBECB826768
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 04:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5F52281C1A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 03:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AC414A8C;
	Mon,  8 Jan 2024 03:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="VN94fafA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="7U4D0jPM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5511214A9F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 03:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 6B32532012A7;
	Sun,  7 Jan 2024 22:23:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 07 Jan 2024 22:23:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1704684187; x=
	1704770587; bh=0RwRbEVKbmzLxnzvnM2sEomesz7nvhz+5lkfRS9XEEs=; b=V
	N94fafA1KkahDoJuqAWV12gMBUtRVVEwdpVUaok9OHfTzDZ2Ji+pd4lY2skZiuS2
	MmklcMhv3KZBoAsRFlblpeZhl2ICVYahpky5tXuBYHmOph577cDUnaTulYpeWXt7
	0bS5d9wWecGokD3pq11VN8UEWmn2HrYSeTfTCobUSkpMoCnWJdis/fZCEzsH+GCx
	0xQ4oz6ajY5T6SClusUKNUzVQK75SVOeUYVL1oV/do6sW2OskUcn9m+QVDWGDX48
	3QvF3P5H+AQRwBISPBt5L8cOK2OiogseyRR2TJQ+iWLKjj1gfwDjlHroY0PMHofA
	XXj2lEXkt5R1ylK1+lXeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1704684187; x=
	1704770587; bh=0RwRbEVKbmzLxnzvnM2sEomesz7nvhz+5lkfRS9XEEs=; b=7
	U4D0jPM1MIvLOCffdhRi9YEoY24EE1jV0ZS97VMLMh1p5bvXJr+tnYB9thIH3bzW
	0C0sdLzbGsx/bG2DjGde9O7JBLQadD5WLB5QiF1buM7p5xH+/4GR37OawHaA+W6j
	nWJ3cbK8eSS0x7LtwSCNVNHbZel95m3OS+jhBM649PXS8LB9Pc+hlEFQW4C05ahh
	2XwnG/Kwg4vOr3NVQZatRoOZ97GnIE7LGmnxPDG7zvcGMgj8A/IC/jpIKGDHutNE
	HZUsPu9kuQ8Cjk1d3TX/I0FGSy4CYY48+CVtFewq781YrmmCjNhw3rOXEuXtJeTt
	KTvOnFlKIbGqrpJvGtlXw==
X-ME-Sender: <xms:m2qbZe_xW-TwdRKjSzLydntO_ppQlvK3ghcLdRmms-q8AS8vvjAYFw>
    <xme:m2qbZevYzGjrpD38vHTuA4XpKLSVhBlP_ZRGgVMIhWDjIWSYB2Vi58A4CcpjCNluK
    ByVamMtc9RJhYb8Kv0>
X-ME-Received: <xmr:m2qbZUDWH2Sd5NTxZiA6jtK2OWzFkpKp0O2zjVwSt9PdyhvTojcuPZENcWwLZiDWKfHz0PCt0oSeC7-CbvomXeRqxf3QCVhP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehhedgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:m2qbZWcl74M2V3Doxur9K2rx4aO9Iwbd8szt5iEtQdGjwXnE2Ep7dg>
    <xmx:m2qbZTM7pREIjFNIZ7ZztGFqGKlZeQqr8-WLEq624wxjdjQ3vFZHhg>
    <xmx:m2qbZQmjdEQMDFREVNZeJvvRHLlI28u01iVrQPWn_55K67CuXqV--Q>
    <xmx:m2qbZcoAQVH9C-1D0ocnvg8FXpUioW9NFuom922GEfdYkp6PdIQdWw>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Jan 2024 22:23:07 -0500 (EST)
From: Gary Rookard <garyrookard@fastmail.org>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 4/5] staging: rtl8192e: rename variable EWC11NHTCap
Date: Sun,  7 Jan 2024 22:22:32 -0500
Message-ID: <20240108032233.4280-5-garyrookard@fastmail.org>
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
rename it. EWC11NHTCap -> ewc_11n_ht_cap

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index fe066d39b563..5598e74187cd 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -241,9 +241,9 @@ void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_ht_cap,
 	memset(pos_ht_cap, 0, *len);
 
 	if ((assoc) && (ht->peer_ht_spec_ver == HT_SPEC_VER_EWC)) {
-		static const u8	EWC11NHTCap[] = { 0x00, 0x90, 0x4c, 0x33 };
+		static const u8	ewc_11n_ht_cap[] = { 0x00, 0x90, 0x4c, 0x33 };
 
-		memcpy(pos_ht_cap, EWC11NHTCap, sizeof(EWC11NHTCap));
+		memcpy(pos_ht_cap, ewc_11n_ht_cap, sizeof(ewc_11n_ht_cap));
 		cap_ele = (struct ht_capab_ele *)&pos_ht_cap[4];
 		*len = 30 + 2;
 	} else {
-- 
2.43.0


