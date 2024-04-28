Return-Path: <linux-kernel+bounces-161299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB718B4A65
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 09:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F21A61C20EDC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 07:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F05352F82;
	Sun, 28 Apr 2024 07:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="coJi8ATk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QYqOW+Uw"
Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC60524AD
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 07:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714288441; cv=none; b=s4bwBCzIfeZjZxv+QIh9+9hbUXnXasY6Xd9Znem7m6n6mmJYmKqa3vQg1HzFuTEDbNw/qBVa0u9CeukW65got8XKm2IXl2K39DLzjSEF68dduMHPdRiBT1XDZmCNnrPJ375BchdVmyBVksMd+5oweg+lSI5qiVkJv7/XcJzCU64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714288441; c=relaxed/simple;
	bh=TJls4eJgjILIoLoh7e72vgk38wF3wZdb5E9SMVw62i8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Js+8rqsupnEsG5OpeGuXOBRVplCWd5ONq5ePP9jMzMKYdOZR8MQ0avXL1N4VrLTHEnna3uKAoCLbKd5ydMSq35HfRS0PThU8gskmdVxWbImh8t2oamamOXhe12ELUn608q/6U0XeYXzvkRQWAVuwqit3O7F2ULAEgkJEsFKXb6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=coJi8ATk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QYqOW+Uw; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 0C8C21C0010F;
	Sun, 28 Apr 2024 03:13:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 28 Apr 2024 03:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1714288438; x=
	1714374838; bh=470UmX6MvxsOpPDrhAZoiwlvja/CUYrvQC6qp4umF88=; b=c
	oJi8ATkKxRWB8+w2DwpZlcoEDB6RAV47lw9TimBoY/5BRM0mAcj7Z+Ls4OGKEPg1
	FtH+y/A0wZ9WGpmN9bgFeKG2VYDS0fsBe0v5O3teqXhjePEk/s3B2hWpNyUHS7Lw
	ec/tnSOiAqIpWjjRomozS+7FyiH5s2DzF0AkiRMNLCI0oq7Y739i0xxHJmtT1kYX
	HRfoH8cCEG9ukH5bPHANrAjuUuWaiiDisZ3LIW+9Sf/CMdJny0zICBCQj91uVQEd
	iQW/DmruuxAYPCE6cgHXeebTQhCljLwchnypAsz1dOtoEFVbU88nWqEbSHmM6KzU
	6dmtZ4sNPvHI4KXTzoz/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714288438; x=
	1714374838; bh=470UmX6MvxsOpPDrhAZoiwlvja/CUYrvQC6qp4umF88=; b=Q
	YqOW+UwSpbxvF4GJPEJLGmuZgCYtQKx2+eV4U0RcRtJjmm1sDPzOryBG528sTwL3
	tpCVqvMPQt11n1jOli4MUYnt75+a/bgcFKmcHeHFi0fpyzN27E6StrMa4AWNuy3v
	dgIVUTCfnUNG4Zigtv2K9Ezj0VpdMl1k6p7GcYlPrgj/rfPmqhL701ftxbm7/UJ1
	KaDJXOQw+aVLAWyTxkoG3lObzo5T9ErDHWz9q8F2rQFJxUMHTDvWyS8ZeMb+ag4F
	tZKajJ6r+pAHYcB4VqswBijfPcS4jqVttW0/x14xu238oyBQljZtbATb+wf3CDAW
	7lePIYCzujjJWX1WAGG3w==
X-ME-Sender: <xms:NvctZkL406FmMZj0AN1sbTrPmm1wlxftArz_cOCKEAOpeEqO8iP1ng>
    <xme:NvctZkIcGrlRHYJD__r2IubrnpsbK3G9qTglfhtP3plEH0CutQ_w18jLfElKBzcdx
    o2lP5H3fm51SAV_Cqg>
X-ME-Received: <xmr:NvctZkusuYXcXv9ehHmr1QJk5Ooif72oiQkGJlbFsn1f3xPtXjb7nMVACbu4rJ0qGNlA-Ym8YmfX5n_h_C7VctK-W3dY9Gpl2--b5ghd7BxQIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtgedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:NvctZhYq4eSuIJjqv4xJpsIh6UfbhBEfoWgBxY3GZOU_Y_bZa5cvgA>
    <xmx:NvctZrZzOtylvQkucN4s9aPUgYHpHb5Uu0E_ccpuZ6jxA1f3ui4lEw>
    <xmx:NvctZtBkh0m6u4Wm9R8sKIWSLjC-xprZttAqBIX2RGVUXWoHoyjvyw>
    <xmx:NvctZhZelrWyBmxwmv630kHxPNNPIgdyx1RdUYxKWXHOZHibQXrcpw>
    <xmx:NvctZqkBgDEq-o3nX7pig0D_zeKsj3jIw1FYqMWeccE3ppFXljfDOpe5>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Apr 2024 03:13:57 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] firewire: ohci: replace local macros with common inline functions for asynchronous packet header
Date: Sun, 28 Apr 2024 16:13:41 +0900
Message-ID: <20240428071347.409202-4-o-takashi@sakamocchi.jp>
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

This commit uses the common inline functions to serialize and deserialize
header of asynchronous packet.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index e4ad624c60cb..5f702f56ac7b 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -40,6 +40,7 @@
 
 #include "core.h"
 #include "ohci.h"
+#include "packet-header-definitions.h"
 
 #define ohci_info(ohci, f, args...)	dev_info(ohci->card.device, f, ##args)
 #define ohci_notice(ohci, f, args...)	dev_notice(ohci->card.device, f, ##args)
@@ -1550,21 +1551,15 @@ static int handle_at_packet(struct context *context,
 	return 1;
 }
 
-#define HEADER_GET_DESTINATION(q)	(((q) >> 16) & 0xffff)
-#define HEADER_GET_TCODE(q)		(((q) >> 4) & 0x0f)
-#define HEADER_GET_OFFSET_HIGH(q)	(((q) >> 0) & 0xffff)
-#define HEADER_GET_DATA_LENGTH(q)	(((q) >> 16) & 0xffff)
-#define HEADER_GET_EXTENDED_TCODE(q)	(((q) >> 0) & 0xffff)
-
 static void handle_local_rom(struct fw_ohci *ohci,
 			     struct fw_packet *packet, u32 csr)
 {
 	struct fw_packet response;
 	int tcode, length, i;
 
-	tcode = HEADER_GET_TCODE(packet->header[0]);
+	tcode = async_header_get_tcode(packet->header);
 	if (TCODE_IS_BLOCK_PACKET(tcode))
-		length = HEADER_GET_DATA_LENGTH(packet->header[3]);
+		length = async_header_get_data_length(packet->header);
 	else
 		length = 4;
 
@@ -1591,10 +1586,10 @@ static void handle_local_lock(struct fw_ohci *ohci,
 	__be32 *payload, lock_old;
 	u32 lock_arg, lock_data;
 
-	tcode = HEADER_GET_TCODE(packet->header[0]);
-	length = HEADER_GET_DATA_LENGTH(packet->header[3]);
+	tcode = async_header_get_tcode(packet->header);
+	length = async_header_get_data_length(packet->header);
 	payload = packet->payload;
-	ext_tcode = HEADER_GET_EXTENDED_TCODE(packet->header[3]);
+	ext_tcode = async_header_get_extended_tcode(packet->header);
 
 	if (tcode == TCODE_LOCK_REQUEST &&
 	    ext_tcode == EXTCODE_COMPARE_SWAP && length == 8) {
@@ -1640,10 +1635,7 @@ static void handle_local_request(struct context *ctx, struct fw_packet *packet)
 		packet->callback(packet, &ctx->ohci->card, packet->ack);
 	}
 
-	offset =
-		((unsigned long long)
-		 HEADER_GET_OFFSET_HIGH(packet->header[1]) << 32) |
-		packet->header[2];
+	offset = async_header_get_offset(packet->header);
 	csr = offset - CSR_REGISTER_BASE;
 
 	/* Handle config rom reads. */
@@ -1679,7 +1671,7 @@ static void at_context_transmit(struct context *ctx, struct fw_packet *packet)
 
 	spin_lock_irqsave(&ctx->ohci->lock, flags);
 
-	if (HEADER_GET_DESTINATION(packet->header[0]) == ctx->ohci->node_id &&
+	if (async_header_get_destination(packet->header) == ctx->ohci->node_id &&
 	    ctx->ohci->generation == packet->generation) {
 		spin_unlock_irqrestore(&ctx->ohci->lock, flags);
 
-- 
2.43.0


