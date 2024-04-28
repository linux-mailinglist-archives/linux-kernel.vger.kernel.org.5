Return-Path: <linux-kernel+bounces-161301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D2F8B4A6A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 09:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64D181F21B03
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 07:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001C553E1F;
	Sun, 28 Apr 2024 07:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="WtvjpqUu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jo1KtoeW"
Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ADB535A9
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 07:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714288446; cv=none; b=KyYB61JGszeKgqTxiB5OTG+KOBNtL1hPIUumRj2ioYzom1J3sC+xTXAwwGb5nnbORRxTTW/XSsdLRcfUtdN1/oMuDlf2+6+s2GJmIXK/d3b4LAaWWVUFa4mDicdUIssYbDW2yIDLRoC4pKBcGm4VYgehiMCnZ0WfgjjhN9wgI14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714288446; c=relaxed/simple;
	bh=eUXulv8SLIbPh3UEbF+PLVZxSxMdc1BB+wVcSzMxjBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iEiAhBIXM2i7Xh2TwtCPvcML3JH/F8AISof3RT25kH92Kk9pr8t9w1kCUi8napFBiwoWAI5UDJx2KMeYP/gEQ7n+ZgHCtPHIWyJwn6/p8knnEmS5+b2aJ3kXZgSwBK466KSROQTk3E4avOHg/2R2ZxEJn4AsiYTqiGdMpb/7dsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=WtvjpqUu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jo1KtoeW; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 82BFA18000DF;
	Sun, 28 Apr 2024 03:14:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 28 Apr 2024 03:14:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1714288443; x=
	1714374843; bh=L/RXyIBehhYux/Or0vr4pakBmao+Fg8KZrIh09642yE=; b=W
	tvjpqUubt161YGVTW1Rws77Fn/buXIZeCo4Pen1YMoN92WydCKHLZahDRJ5UqVUC
	cNqAS6L0ev7t2OwZo6orfEkqTetkTUKgZXGiwcq8/t6bJCYafMjOaqm8VZrb2Kth
	e0qr1cVPO7SkBhMAuOn9JO5riww9SIRmmQb6VxFbLdIuFFRiu11J59RAlkroi3qx
	yGdDd59dEq038wD0rU8eQhSMeGdZ8j2mmhsRPfJD3OdRNhnEMwQZdZkn6/GWPAJN
	K2GXkYfioIHUqUDkuh98P0m1rHoteFZABjF4djxx1z1nGjuRd6zRZoYEbNOX1u0E
	6oDFt85ga91pGvlePKiBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714288443; x=
	1714374843; bh=L/RXyIBehhYux/Or0vr4pakBmao+Fg8KZrIh09642yE=; b=J
	o1KtoeWtX7K9GT0S73UqzZvVFj1Ix9pnrkDpPV6zhAlGtWWakUvfpfFGTFQuRltk
	J3el6msTNrDXfCuMU+pIrGTGnCQ8arpmfEhmgDFUwLSs3dPemgcAEEI14s/VjfK8
	YcVmgqZElmvxO2Fkab58H7BmmbEYaVfq4TAITIbtY8VvYMx7xCE8qQFCRJO2rdw4
	vkgvvMJrvD7ZcaCsqxYJXO1i+Lqx5lEDy9Zlcp7cj0STbA0IhFCyJni5xe3vQkuj
	OJia3B31EnhXUBxDY2TVqiSGx2Iooe5nvD/8rNsLu5TAo1k5ahWc44hK7hZrjlOL
	pDpBhfWGLSvmcnospPVoQ==
X-ME-Sender: <xms:OvctZmPitrAL7EhHFhkVj-ku0xhT_ECm6FtN0Bscy03Pxe-vgWaGSA>
    <xme:OvctZk9yfWJPi4QML_dQBXiwRaBVPvTaoGTNd2svMPVkhF_TRgKSKKEsCzZJGKRgt
    nOFZzbpOoN2gexKD9c>
X-ME-Received: <xmr:OvctZtT9UH7bkCwYiFPYXPq9UF4GBmFHh2FQzm8GCG2jj9RQ86z4NABQ38cgUSCkcKij_ecWi1QvcSY7_xUUqegKECZg3gUL5QfgKuX-cJTueg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtgedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:OvctZmv326hozKHpvYmGotA2_M_YTCYkG6qscayQVg-yEvvjdaRy3g>
    <xmx:OvctZuc-2qKYTZBM4ueUFJ2Y8N2rQt-uHNgETKQPZhVutUBVU51vaw>
    <xmx:OvctZq3uSjte4P4yB8iTTeyomMbLl4zY6Fb18hq3qbgdUBSN_JJSOQ>
    <xmx:OvctZi-fcBEdGIWpgzlkBV-VvclWcrFdrcCZsE4ZzV-52FVreEBifw>
    <xmx:O_ctZvqhYdh_epz2FOTPzfxe37ZW7t_YodGS29B1RaX8hhrBPczGzAS5>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Apr 2024 03:14:01 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] firewire: ohci: replace hard-coded values with common macros
Date: Sun, 28 Apr 2024 16:13:43 +0900
Message-ID: <20240428071347.409202-6-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240428071347.409202-1-o-takashi@sakamocchi.jp>
References: <20240428071347.409202-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the helper function for logging in 1394 ohci driver includes the
hard-coded variables for transaction code. They can be replaced with
the enumerations in UAPI header.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index be8ede492ead..4811e3255ca8 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -533,11 +533,17 @@ static void log_ar_at_event(struct fw_ohci *ohci,
 	}
 
 	switch (tcode) {
-	case 0x0: case 0x6: case 0x8:
+	case TCODE_WRITE_QUADLET_REQUEST:
+	case TCODE_READ_QUADLET_RESPONSE:
+	case TCODE_CYCLE_START:
 		snprintf(specific, sizeof(specific), " = %08x",
 			 be32_to_cpu((__force __be32)header[3]));
 		break;
-	case 0x1: case 0x5: case 0x7: case 0x9: case 0xb:
+	case TCODE_WRITE_BLOCK_REQUEST:
+	case TCODE_READ_BLOCK_REQUEST:
+	case TCODE_READ_BLOCK_RESPONSE:
+	case TCODE_LOCK_REQUEST:
+	case TCODE_LOCK_RESPONSE:
 		snprintf(specific, sizeof(specific), " %x,%x",
 			 async_header_get_data_length(header),
 			 async_header_get_extended_tcode(header));
@@ -547,7 +553,7 @@ static void log_ar_at_event(struct fw_ohci *ohci,
 	}
 
 	switch (tcode) {
-	case 0xa:
+	case TCODE_STREAM_DATA:
 		ohci_notice(ohci, "A%c %s, %s\n",
 			    dir, evts[evt], tcodes[tcode]);
 		break;
@@ -555,7 +561,11 @@ static void log_ar_at_event(struct fw_ohci *ohci,
 		ohci_notice(ohci, "A%c %s, PHY %08x %08x\n",
 			    dir, evts[evt], header[1], header[2]);
 		break;
-	case 0x0: case 0x1: case 0x4: case 0x5: case 0x9:
+	case TCODE_WRITE_QUADLET_REQUEST:
+	case TCODE_WRITE_BLOCK_REQUEST:
+	case TCODE_READ_QUADLET_REQUEST:
+	case TCODE_READ_BLOCK_REQUEST:
+	case TCODE_LOCK_REQUEST:
 		ohci_notice(ohci,
 			    "A%c spd %x tl %02x, %04x -> %04x, %s, %s, %012llx%s\n",
 			    dir, speed, async_header_get_tlabel(header),
-- 
2.43.0


