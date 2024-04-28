Return-Path: <linux-kernel+bounces-161304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F558B4A6D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 09:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A1491F220C6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 07:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C51E54919;
	Sun, 28 Apr 2024 07:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="ZwSTrBjY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FYhcsQzE"
Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28377548EC
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 07:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714288452; cv=none; b=ApnxIKUN74Tp4vX+0gOeDUVKbDiv9QAfH6ppn9i3p+b/TxYAEwWmBsZJkCd0k0h3PzuQ3ziDpJ43W3W8mJTstFZuUWZaTY86zzpMd2eIN8Us9PL+n21HaUVTNE5XmUbFxvRMKRLvk8BvIHPP2Lbg0M6zleuJhI2SBSurhPb93hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714288452; c=relaxed/simple;
	bh=LCrACMQobUD1N2aJwOzCe0jVPAcOB6NcU9fKqGniKfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V0PCUwqeCt3yXD23QFzbPyMQbOdUM57dEv1Mwk4KKEixoqeoYdir5WOwofrIn7KrOTcnwZAX39vUCVsx5hQ3SMkPcX2SKi9uZIOH9ezV9+FIfejK1HMuL8ail8H/4wp2fZmBjOyYv/tLpcx715laWBi5xqMal/qFUOPr5fPHs0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=ZwSTrBjY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FYhcsQzE; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 557BE1C00117;
	Sun, 28 Apr 2024 03:14:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Sun, 28 Apr 2024 03:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1714288449; x=
	1714374849; bh=lPogmESFCjjhKwyywY5ioCHwxWU0kxDIYwzD2LnEo2I=; b=Z
	wSTrBjY43WI6YKaYmgDkI9Nst9YYYq6A4nsb1IJ5HuvrqQqtb5WGRD2tGZ9HW6QL
	H1Ly41PTSoY6oidRtPzI7ViCgxNHmhVElnFuk2OKl3zCP9IuiYvKunzbE4MR50VT
	O8/Mp+Uh5K08o3a/at7r/msylib5UJbZqQnG4khImEwsUTdrImTLpRQhc0CVH1H/
	thuc+dV5hfMKKFnegc3Mu6prEjBJaEBTcGtbH1FLYRc6Nq6Ya1iY++FM7BrHspKR
	6gSK3Zd61NBOT9f78gZ5fTFjBGoTzEVkOoSd9urLcyj3af1lc5zByXfJZC7QBXEf
	fhZvt0qIbeAxbMFKoa31A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714288449; x=
	1714374849; bh=lPogmESFCjjhKwyywY5ioCHwxWU0kxDIYwzD2LnEo2I=; b=F
	YhcsQzE4PfsHqDm8r24CRLhIwR9M/lIzMWUtH0z6aNYUwdzM6N4EFeXxFLhe88EK
	gB9bnz3KWsh8wd0bAUZ4GICH3ggl7G9k0N15+bC9pjaISimxUqsk415vyb3Tnv7T
	N7gw75+4qddcXdKY+7qEPxbBclopI6R38bgV9s0nHV/Rj3PwPTCVs009uGsnVSiV
	xEcxZliPPvvtjmcKEt19Ys4E2rjZlelwiTux0Fg0ARjfaPVTlMFSsaY2wJXsgEMn
	WZWPG4Z8W1UjHf13Z2DtU7xq1vQ4vHiT2v0MAeVy0n5gUTSqaCUaO57taOlB01sJ
	tqVGckZGmmlGeGLh1XzlQ==
X-ME-Sender: <xms:QfctZvfXMQZkHTcIIPUuxQA67v6K9ewAjIBZM1i3Q3_9aoGD3TCugg>
    <xme:QfctZlP66vyEKnt_-KXP1Fz78kQO7dJ50yGzPOru3ZxsctSqyW5I51wwaVU_Ew23f
    sCoNPH81TBUbuNabQc>
X-ME-Received: <xmr:QfctZoh_14IMkh1I4cYf84pam-QFhaIFK6Mp4PaWCaALl03DIjS_CqQ7vILkZG3F2ZP0Gt0FSxQ6s8fZpWnj834D1eGHUlHqP3xPHlpZvVMSFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtgedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:QfctZg_pmBhWuAW6SF1YTA0ixsuQefSJDzq_ZKAN53nOkNGBrEncyw>
    <xmx:QfctZrt5lvLijpdI6gxZGdr8VSjOWs6U9NauJ4zBtafNoEnQrji6Xw>
    <xmx:QfctZvFyul6bR86fo_f6IWX2J3dBAVPdnfrbLuu_P31KIt7TBglLPw>
    <xmx:QfctZiMIcT9XQH85mxQLUZ6mzZeVrXhV-hTb7F8zXc3FfxlTie5_pw>
    <xmx:QfctZk7j0jRF_FbRN1bYZsv-FwGv4h_63LfxTl1EzCKfoIGSmWrQHIay>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Apr 2024 03:14:08 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] firewire: core: replace local macros with common inline functions for isochronous packet header
Date: Sun, 28 Apr 2024 16:13:46 +0900
Message-ID: <20240428071347.409202-9-o-takashi@sakamocchi.jp>
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

This commit replaces the local macros with the common inline functions
to serialize the packer header for Asynchronous Streaming Packet.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-transaction.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index 45ea15342ab8..3ecb0b945083 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -31,9 +31,6 @@
 #include "core.h"
 #include "packet-header-definitions.h"
 
-#define HEADER_TCODE(tcode)		((tcode) << 4)
-#define HEADER_DATA_LENGTH(length)	((length) << 16)
-
 #define HEADER_DESTINATION_IS_BROADCAST(header) \
 	((async_header_get_destination(header) & 0x3f) == 0x3f)
 
@@ -215,10 +212,11 @@ static void fw_fill_request(struct fw_packet *packet, int tcode, int tlabel,
 	int ext_tcode;
 
 	if (tcode == TCODE_STREAM_DATA) {
-		packet->header[0] =
-			HEADER_DATA_LENGTH(length) |
-			destination_id |
-			HEADER_TCODE(TCODE_STREAM_DATA);
+		// The value of destination_id argument should include tag, channel, and sy fields
+		// as isochronous packet header has.
+		packet->header[0] = destination_id;
+		isoc_header_set_data_length(packet->header, length);
+		isoc_header_set_tcode(packet->header, TCODE_STREAM_DATA);
 		packet->header_length = 4;
 		packet->payload = payload;
 		packet->payload_length = length;
-- 
2.43.0


