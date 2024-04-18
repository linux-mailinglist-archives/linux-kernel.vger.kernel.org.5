Return-Path: <linux-kernel+bounces-149791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD598A95E5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB8FA1F2252B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA4715B129;
	Thu, 18 Apr 2024 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="SDpCfHiT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IO93r7TB"
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CB515AD96
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 09:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713432194; cv=none; b=Z5Ppw/Le/UtGMhrKs5VFCY4rHnVSJsjrIU0jI7/7OhFuePe5damSbTYRdP6nfGBJVjzwos703c5Bt81VIari/Y7g4Qu9qlo9/43s+RPFzeXySOi4453ZzND+QWzRF+EDut3aSgzm8nIvGmQ8ykKWKTWq2bL9bqlgGN61YvfrsUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713432194; c=relaxed/simple;
	bh=AouYaV2OQpYrMPOlBn3z/Fh34Ltu62vIEBEFVW7ZlFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/z/J0wXSUeZmSxrgu/xcO1B3w4ipWzAU/hoMDgV/CbysWm+FfEXkSbjlOLuXzt2pEKtIDwQVcVp3e9sCnzOxDtq+X8lSz1yRzBnR+0RFiGEBqiapbVei9TCTycgOQfxlQYAHBR7btfSyH3bVAevNXaSU+siDzBc9zuw0kaIyWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=SDpCfHiT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IO93r7TB; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D0F0111400E8;
	Thu, 18 Apr 2024 05:23:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 18 Apr 2024 05:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1713432191; x=
	1713518591; bh=vL3gfEnrZ6VG6CxRuzJnshuYqrkqgK5QLXVwi+2Zjvk=; b=S
	DpCfHiTmxCUNjceeL26iIkk/37jNK1aMuYGy8c/E1IVaReDzwspj35dYwzyTgQae
	pGX44J0C9GUtScqFLTYuvOtPL9y0lwWVgix9lpgxBFZYGOK+tgpf42z7ZnuR+MSt
	5lA7tRE6b4TdSwrWaY/zUXWoKS4Ad06SeZYuzRhJyzBJAwHm6hf0grls0mHDFdQI
	E5Gu3l2YOT/tebzmVA9Qr1CUF6qz09iHJdc9xmTb8tQl1U2z/1MGQmpwJrNDM/r8
	wEc7wFnF0Pg0XCWO557uFfPbntE2js1xaIWotk6IZN//KBOOxGYCCORROPAPlMnQ
	IIF2QARe0Ue+c5v44f3ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1713432191; x=
	1713518591; bh=vL3gfEnrZ6VG6CxRuzJnshuYqrkqgK5QLXVwi+2Zjvk=; b=I
	O93r7TBbgYtIbd4ypetKV0CVCaTz3hXk6RBZHNV2jVhYYZvtfcqQ6SDcsY73e9IN
	l5SKYzrIlIPFP039eTLkwqe4+wYIyTLZ1OW0/jl9Q9i1Lw84pronvvtPO7X1K8pE
	YfteCndGULnO5BlrgjFGwLNpzSBrDVQSqtUakp6nI8pGTx2WbdHayvabS7XD1c4p
	I+vxroDUkDuNAdh45by73MEVLGBoXxXOeYm0Y18NL0fuOtlPOmMbPduU2nC2rbcg
	acTTytjw5eCP6oHcH03BdsOcAzstPzwH/9+litmc+HqJB4DXTBn5qp7nPkk/yWZM
	/owJE1JQ4TmafJ526XAEQ==
X-ME-Sender: <xms:f-YgZl-ytnimD8qDu_6kcFkE9k2lbqY5nCx6gXudLHzbnwtO-aVgfg>
    <xme:f-YgZptolaNpdkcKZmONm-MGJuGrYCjh4LalErUCb3cTgxKxX_X6xtvVVj2i6AaAx
    3K0dHVdBlZKt3aYk6Q>
X-ME-Received: <xmr:f-YgZjAk3bIVWbLCdx2P0slJ3eq82p8HunGE0wje8mlAnRVxVuKnDTxWZoc19G_ddvg1UHiZrz9fT-hDjZWq76Jc9PNVY8QrETOYdLlzeNwkYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudektddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:f-YgZpf0zhcnM-9GRSYr8d8Vd5vR6IxFzr5u36j6WmKKWijht60qXw>
    <xmx:f-YgZqOSVbwjE1xJhAK8-5nWuO6Guj7Y_kXotkmHujrJx4r0utSEMQ>
    <xmx:f-YgZrl9WBvi-S_t7O7ITmsNfhAihzL8h7016A7Vpkonq9x3Oh3P_A>
    <xmx:f-YgZktPy-x1JlyzO0VUT2YwnfRI0DEsNbUl3Bs2ZRxCBTWwF4nsrw>
    <xmx:f-YgZjYxdZhPlUT4NwGyFCZwYLCTydhbg9OxvQb_Fvmfk0P8FoKxCz6O>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Apr 2024 05:23:10 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 03/13] firewire: ohci: replace local macros with common inline functions for asynchronous packet header
Date: Thu, 18 Apr 2024 18:22:53 +0900
Message-ID: <20240418092303.19725-4-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240418092303.19725-3-o-takashi@sakamocchi.jp>
References: <20240418092303.19725-1-o-takashi@sakamocchi.jp>
 <20240418092303.19725-2-o-takashi@sakamocchi.jp>
 <20240418092303.19725-3-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit uses the common inline functions to serialize and deserialize
header for asynchronous packet.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 38d19410a2be..5254cf5c2e58 100644
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


