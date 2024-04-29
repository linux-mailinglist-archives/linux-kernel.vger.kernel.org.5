Return-Path: <linux-kernel+bounces-161727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEB98B503B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C31591F220F9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 04:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C222DDD9;
	Mon, 29 Apr 2024 04:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="mhIqjVgF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C6uWSeZA"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33315205E1A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 04:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714365149; cv=none; b=UO9zPw/M/TJsGPFIX8ngVGnDyoHHBmQvFI2GUdM77BcXegHfDFa94844o2zsD7uBhZqbvfCBNk/VEMIex8BgV9uRToitexOhWUFh792agDKgYty1EheZbSiRmoC8vihwumdo/ZVtBexzsZSu8tpDJbtdoVSVGwsRTEd+j7q9hqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714365149; c=relaxed/simple;
	bh=DRWiMZ7fnsNUDzbgJvqR+TY6gBoFOAasUF9gH3Rufqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E05g46kqZ7alXyT0lxQCYHGFFKdMQBBSGlVumVVQApEpwIKkj9pHigBjKowe1osE34Mue4eDsYAkcLxIiADf6KfFSrhA2zEOnbsYjYQVMRiKwtLT6qqlUSwf1yNiXi4l4P4KL5FrLrU6YD3b7QDb2Gb0Ct1aEFaI6uuTRdKWrgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=mhIqjVgF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C6uWSeZA; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 254B5138022A;
	Mon, 29 Apr 2024 00:32:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 29 Apr 2024 00:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1714365146; x=
	1714451546; bh=+v/W52sgfzq2ue59zU7TOTW/CP2Eu1i/HIwanBpCTGo=; b=m
	hIqjVgFsaxOAzUeO8VhexcX1tutTW8fRH6/8yqvdHtn7I0lVCOKtA32gXM6Kp2WQ
	3MNOOyBXF/XesEjjD61xmAA9gFJduY7suu7Swu2aVmTZam7W8xbn+JtGabieCDMy
	Sie3iafuUfHx+QpG2BxQMCcBUsbMfka7wwtrkBy+JHd7Jt+iuqkB7F4/Xo9kmxUn
	jLqKZsl3jhHjqFblc0A9d20NPvm0R4my6Jh52JyqjiQXVTE9DAUPzN8SDaLn3x8v
	A0nh6Prq27rQKy8+yzsZaGMkgzKwKeOjD2QhQg/ZkiDXs6SK+rGMSMvD0zPQ9Yzt
	/ZtmcT53hhtMGALOXwNFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714365146; x=
	1714451546; bh=+v/W52sgfzq2ue59zU7TOTW/CP2Eu1i/HIwanBpCTGo=; b=C
	6uWSeZA+QV2Lz2HO4gNWWFBq2HMU5UYwoqD0jBNMfb6nBrYO3AMLHXDX0c6Wwokx
	pr8aqLSeigSpk1okQOTMpyGPVPYSV1vqbForjKBe6IO+5zxVTVs6ONmbAVBiLHbJ
	G48f53B1llBNllVYqw95nmrBQtE2Lbc0tlQ/NfLb7DbWFCxkow6QYGbEKUSPUkaZ
	7/+fUJB2UcGXG9pF0HP21rP0GYOe9492BxfjxrOf5Rp1RH6evYrAABmDjkxQ618A
	iUwdW9xuttJpQRQPt+LWoT6Pqkl5DmuPX/il5tlAi1rfRh8Oq2oJyeIi+kc8Uv9e
	YKN8WWhlWx4pGaDqjk85A==
X-ME-Sender: <xms:2SIvZnKaVjajli1-GmJNpWfdck4-RHX_oEzybjYUuKmcWni4AByNiw>
    <xme:2SIvZrJKsHZ2PRHSaCJFfUpEgCADAdtcPGJ3kLTK99yC43hC-7s4StOO-IviwMdTu
    RhRJq395KeaVxw9qyg>
X-ME-Received: <xmr:2SIvZvsRpBtq-QU6jxfOhYQtSGD-4qNh7LYIhynHrI9k2c17GuRiCSYylCmHTw5cBDxFgi65UUtSkgJNa7M9ZnL2NP36_8Y7MCdlcnmoRQLKSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtledgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:2SIvZgaWSq96iXVfFCiQ62ep2BDwA-0jR9bhAN4_L-SOzJe-X1KCMw>
    <xmx:2SIvZuYIV2OTVWk9RbED7keMaJVORUYf2jEnV-mkls2FoIWxLFBR_A>
    <xmx:2SIvZkAK_KYESPQhLLgQgMXg5-j4A8NypLsLHXO8IE_zEVd_9ePlxA>
    <xmx:2SIvZsZuI_COnKOfAG_PYIo1pT-Hy6A-l89FwjYFAA7GOWz0hxyTJg>
    <xmx:2iIvZtkMyLyaQByvs6e9T9JfmB0BilxvrgNZDxcoXpeHQMdLdDojqRKN>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 00:32:24 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] firewire: core: add tracepoints events for asynchronous outbound request
Date: Mon, 29 Apr 2024 13:32:15 +0900
Message-ID: <20240429043218.609398-3-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240429043218.609398-1-o-takashi@sakamocchi.jp>
References: <20240429043218.609398-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a view of core transaction service, the asynchronous outbound request
consists of two stages; initiation and completion. This commit adds a pair
of event for them.

The following example is for asynchronous lock request with compare_swap
code to offset 0x'ffff'f000'0904 in node 0xffc0.

async_request_outbound_initiate: \
  transaction=0xffff955fc6a07a10 generation=5 scode=2 dst_id=0xffc0 \
  tlabel=54 tcode=9 src_id=0xffc1 offset=0xfffff0000904 \
  header={0xffc0d990,0xffc1ffff,0xf0000904,0x80002}
  data={0x80,0x940181}
async_request_outbound_complete: \
  transaction=0xffff955fc6a07a10 generation=5 scode=2 status=2 \
  timestamp=0xd887

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-transaction.c |   7 ++
 include/trace/events/firewire.h     | 103 +++++++++++++++++++++++++++-
 2 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index 3ecb0b945083..c9318024386f 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -29,6 +29,7 @@
 #include <asm/byteorder.h>
 
 #include "core.h"
+#include <trace/events/firewire.h>
 #include "packet-header-definitions.h"
 
 #define HEADER_DESTINATION_IS_BROADCAST(header) \
@@ -173,6 +174,9 @@ static void transmit_complete_callback(struct fw_packet *packet,
 	struct fw_transaction *t =
 	    container_of(packet, struct fw_transaction, packet);
 
+	trace_async_request_outbound_complete((uintptr_t)t, packet->generation, packet->speed,
+					      status, packet->timestamp);
+
 	switch (status) {
 	case ACK_COMPLETE:
 		close_transaction(t, card, RCODE_COMPLETE, packet->timestamp);
@@ -394,6 +398,9 @@ void __fw_send_request(struct fw_card *card, struct fw_transaction *t, int tcode
 
 	spin_unlock_irqrestore(&card->lock, flags);
 
+	trace_async_request_outbound_initiate((uintptr_t)t, generation, speed, t->packet.header, payload,
+					      tcode_is_read_request(tcode) ? 0 : length / 4);
+
 	card->driver->send_request(card, &t->packet);
 }
 EXPORT_SYMBOL_GPL(__fw_send_request);
diff --git a/include/trace/events/firewire.h b/include/trace/events/firewire.h
index bc55eaabf695..063695874cfb 100644
--- a/include/trace/events/firewire.h
+++ b/include/trace/events/firewire.h
@@ -7,8 +7,109 @@
 #define _FIREWIRE_TRACE_EVENT_H
 
 #include <linux/tracepoint.h>
+#include <linux/firewire.h>
 
-// Placeholder for future use.
+#include <linux/firewire-constants.h>
+
+#include "../../../drivers/firewire/packet-header-definitions.h"
+
+// The content of TP_printk field is preprocessed, then put to the module binary.
+#define ASYNC_HEADER_GET_DESTINATION(header)	\
+	(((header)[0] & ASYNC_HEADER_Q0_DESTINATION_MASK) >> ASYNC_HEADER_Q0_DESTINATION_SHIFT)
+
+#define ASYNC_HEADER_GET_TLABEL(header)	\
+	(((header)[0] & ASYNC_HEADER_Q0_TLABEL_MASK) >> ASYNC_HEADER_Q0_TLABEL_SHIFT)
+
+#define ASYNC_HEADER_GET_TCODE(header)	\
+	(((header)[0] & ASYNC_HEADER_Q0_TCODE_MASK) >> ASYNC_HEADER_Q0_TCODE_SHIFT)
+
+#define ASYNC_HEADER_GET_SOURCE(header)	\
+	(((header)[1] & ASYNC_HEADER_Q1_SOURCE_MASK) >> ASYNC_HEADER_Q1_SOURCE_SHIFT)
+
+#define ASYNC_HEADER_GET_OFFSET(header)	\
+	((((unsigned long long)((header)[1] & ASYNC_HEADER_Q1_OFFSET_HIGH_MASK)) >> ASYNC_HEADER_Q1_OFFSET_HIGH_SHIFT) << 32)| \
+	(header)[2]
+
+#define QUADLET_SIZE	4
+
+DECLARE_EVENT_CLASS(async_outbound_initiate_template,
+	TP_PROTO(u64 transaction, unsigned int generation, unsigned int scode, const u32 *header, const u32 *data, unsigned int data_count),
+	TP_ARGS(transaction, generation, scode, header, data, data_count),
+	TP_STRUCT__entry(
+		__field(u64, transaction)
+		__field(u8, generation)
+		__field(u8, scode)
+		__array(u32, header, ASYNC_HEADER_QUADLET_COUNT)
+		__dynamic_array(u32, data, data_count)
+	),
+	TP_fast_assign(
+		__entry->transaction = transaction;
+		__entry->generation = generation;
+		__entry->scode = scode;
+		memcpy(__entry->header, header, QUADLET_SIZE * ASYNC_HEADER_QUADLET_COUNT);
+		memcpy(__get_dynamic_array(data), data, __get_dynamic_array_len(data));
+	),
+	// This format is for the request subaction.
+	TP_printk(
+		"transaction=0x%llx generation=%u scode=%u dst_id=0x%04x tlabel=%u tcode=%u src_id=0x%04x offset=0x%012llx header=%s data=%s",
+		__entry->transaction,
+		__entry->generation,
+		__entry->scode,
+		ASYNC_HEADER_GET_DESTINATION(__entry->header),
+		ASYNC_HEADER_GET_TLABEL(__entry->header),
+		ASYNC_HEADER_GET_TCODE(__entry->header),
+		ASYNC_HEADER_GET_SOURCE(__entry->header),
+		ASYNC_HEADER_GET_OFFSET(__entry->header),
+		__print_array(__entry->header, ASYNC_HEADER_QUADLET_COUNT, QUADLET_SIZE),
+		__print_array(__get_dynamic_array(data),
+			      __get_dynamic_array_len(data) / QUADLET_SIZE, QUADLET_SIZE)
+	)
+);
+
+// The value of status is one of ack codes and rcodes specific to Linux FireWire subsystem.
+DECLARE_EVENT_CLASS(async_outbound_complete_template,
+	TP_PROTO(u64 transaction, unsigned int generation, unsigned int scode, unsigned int status, unsigned int timestamp),
+	TP_ARGS(transaction, generation, scode, status, timestamp),
+	TP_STRUCT__entry(
+		__field(u64, transaction)
+		__field(u8, generation)
+		__field(u8, scode)
+		__field(u8, status)
+		__field(u16, timestamp)
+	),
+	TP_fast_assign(
+		__entry->transaction = transaction;
+		__entry->generation = generation;
+		__entry->scode = scode;
+		__entry->status = status;
+		__entry->timestamp = timestamp;
+	),
+	TP_printk(
+		"transaction=0x%llx generation=%u scode=%u status=%u timestamp=0x%04x",
+		__entry->transaction,
+		__entry->generation,
+		__entry->scode,
+		__entry->status,
+		__entry->timestamp
+	)
+);
+
+DEFINE_EVENT(async_outbound_initiate_template, async_request_outbound_initiate,
+	TP_PROTO(u64 transaction, unsigned int generation, unsigned int scode, const u32 *header, const u32 *data, unsigned int data_count),
+	TP_ARGS(transaction, generation, scode, header, data, data_count)
+);
+
+DEFINE_EVENT(async_outbound_complete_template, async_request_outbound_complete,
+	TP_PROTO(u64 transaction, unsigned int generation, unsigned int scode, unsigned int status, unsigned int timestamp),
+	TP_ARGS(transaction, generation, scode, status, timestamp)
+);
+
+#undef ASYNC_HEADER_GET_DESTINATION
+#undef ASYNC_HEADER_GET_TLABEL
+#undef ASYNC_HEADER_GET_TCODE
+#undef ASYNC_HEADER_GET_SOURCE
+#undef ASYNC_HEADER_GET_OFFSET
+#undef QUADLET_SIZE
 
 #endif // _FIREWIRE_TRACE_EVENT_H
 
-- 
2.43.0


