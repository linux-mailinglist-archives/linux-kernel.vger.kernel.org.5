Return-Path: <linux-kernel+bounces-161728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 280B58B503E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12630B22596
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 04:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3001FF516;
	Mon, 29 Apr 2024 04:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="K7T/dUzV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YF2Vv2pi"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AD6BE62
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 04:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714365150; cv=none; b=ocuFhTi/odpAdUzdUDjbTQrLV97QjCXKOAZlGsMdcnFevTgkFkf91mESNgEZUFOA/OEVUtZWdGQbXxUY5imGoqLh3jEwudMvfo/wP7WmjjRJZqmjSif65TRkbmO60+TjnLZU16W101j9GrLt5rnkHX0Vpi3ye0kuEwLOWe66Co8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714365150; c=relaxed/simple;
	bh=CQy+2C2nKRJNzvpkFfrqatnLUHdid88Yiz8r9I9HVHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gdG1s62C9pyQ3ViZ6CZztLqTIYI99nCJrmMpzJ8VH5FqE1RVPirRykl5P2e9Nt1+riBaieeQ7/3kh8sUFz7CMZpeI6p8NEvSqOgd4xYNcDJxFY2qvDH4Gpfzx7TQZ7EWBM4HX96YaXHHzKIacuXGqkvAQWHXBKXNQ25j6JymEos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=K7T/dUzV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YF2Vv2pi; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 81EDE1380234;
	Mon, 29 Apr 2024 00:32:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 29 Apr 2024 00:32:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1714365147; x=
	1714451547; bh=c5X9sc3Zt5b5UZQSiCbWNAlpqM0YI+asugIh/bdaOy8=; b=K
	7T/dUzVMtROr4/mzKxqkI6XvlMJU+kHDJwNZIg+hQIOBIjPvE5D76H6+Gl99E/ho
	6o0jV9D3VmzA/2drEE5/EmRzRsFiR+KtEOXFRjmsCrEvUcjRJtfu4Yii+kiAtTta
	1Ir1zS+l2uu/8/BJC8OaQNJeG4XzezzYuQMhV5xmITyALc+GHYfDSjlJBl4upcPb
	q2mVMmceHAgfiPnRq8tQYdyYG5ssegsjW7j26FSS7cFYxUWTvy/iBNibCslLUJGD
	OcXLsep1AQEfXXVAlKyhoLwLX9w/K3FU7yEukjLMo0Y8muX9eOm7m51jRnvC3Khr
	AFqV/XKVz1lWecrUh+1Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714365147; x=
	1714451547; bh=c5X9sc3Zt5b5UZQSiCbWNAlpqM0YI+asugIh/bdaOy8=; b=Y
	F2Vv2piLDRbYLY9jSgFUuoDE0WKBvkcUWUHuLKeNObK2xaLCmzgjjVsMH3sTTf6+
	qOxY5CxbyIGoWMCubMMQQBV0pAMAboPwzmMXU3cJogK4oXcyD8zrFUr3OWlYPJJm
	wcDJm1oBvv20WZAorQ3TXyX/Zc/17W+1LA7fCEVwMM+JSd2B3Dgc0qYqB6DtZmuH
	t8a2zc/CjKdTxUvAizTUktNmz6w6zKd7bwPgLGBkXRvOFS6aS42vWGAgj6hmDIrc
	pwhLNiBrSjOnn9X0HNfwArJGrZrKS/1DMhjjzD5/UgNQb2w8HcHOQTo2pIlxDaZu
	ZLvgZmG75FqAQI5V1w0HQ==
X-ME-Sender: <xms:2yIvZoki3lLj3IluupmVfIKCsFhYincgVEnXXfhF7sgo9PF-TKXmVA>
    <xme:2yIvZn3m3ceRG1aO5yDbhxM6KJf24Kt8MHYWXhSkqZscX1C62zHyeFnGR9su4-PDX
    sGj9I8JIZyFEKYwaK0>
X-ME-Received: <xmr:2yIvZmrJK09BYIiU2gAxXt6YgVcIbvupd0GUAFl2pYhXekAN8kRBx88u8TzwI49UG8W9xWUA3hJHmG4DBCUz7utZ2qZ5CSL_dvdY3p0Ihts80Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtledgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:2yIvZklqNev25ajNeJY0yWaWkkcPpNfKNHmwMjUTBOcYBt9r4VH50g>
    <xmx:2yIvZm2by6iv9oBzpk88EbN4ZhxMbkyDcJB6hIrZHf-KudLCLcs4YQ>
    <xmx:2yIvZru3txvGosv7pZDDKvDKiROOib7ZWGRdaaDWwm5rOieXPB6taw>
    <xmx:2yIvZiXOTNndn3mZY48uOS6-vv6kKTyXlUxHCrHJ633r5dlyxwEPoA>
    <xmx:2yIvZkDJUx5JWhVOB0UzhMB9ssNIJ3U4K5tPIprmB1FO0oXG2IWU5QeR>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 00:32:26 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] firewire: core: add tracepoints event for asynchronous inbound response
Date: Mon, 29 Apr 2024 13:32:16 +0900
Message-ID: <20240429043218.609398-4-o-takashi@sakamocchi.jp>
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

In the transaction of IEEE 1394, the node to receive the asynchronous
request transfers any response packet to the requester except for the
unified transaction.

This commit adds an event for the inbound packet. Note that the code to
decode the packet header is moved, against the note about the sanity
check.

The following example is for asynchronous lock response with
compare_and_swap code.

async_response_inbound: \
  transaction=0xffff955fc6a07a10 generation=5 scode=2 status=1 \
  timestamp=0x0089 dst_id=0xffc1 tlabel=54 tcode=11 src_id=0xffc0 \
  rcode=0 header={0xffc1d9b0,0xffc00000,0x0,0x40002} data={0x50800080}

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-transaction.c | 55 +++++++++++++++--------------
 include/trace/events/firewire.h     | 50 ++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 26 deletions(-)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index c9318024386f..56510d305564 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -1011,32 +1011,10 @@ void fw_core_handle_response(struct fw_card *card, struct fw_packet *p)
 	source = async_header_get_source(p->header);
 	rcode = async_header_get_rcode(p->header);
 
-	spin_lock_irqsave(&card->lock, flags);
-	list_for_each_entry(iter, &card->transaction_list, link) {
-		if (iter->node_id == source && iter->tlabel == tlabel) {
-			if (!try_cancel_split_timeout(iter)) {
-				spin_unlock_irqrestore(&card->lock, flags);
-				goto timed_out;
-			}
-			list_del_init(&iter->link);
-			card->tlabel_mask &= ~(1ULL << iter->tlabel);
-			t = iter;
-			break;
-		}
-	}
-	spin_unlock_irqrestore(&card->lock, flags);
-
-	if (!t) {
- timed_out:
-		fw_notice(card, "unsolicited response (source %x, tlabel %x)\n",
-			  source, tlabel);
-		return;
-	}
-
-	/*
-	 * FIXME: sanity check packet, is length correct, does tcodes
-	 * and addresses match.
-	 */
+	// FIXME: sanity check packet, is length correct, does tcodes
+	// and addresses match to the transaction request queried later.
+	//
+	// For the tracepoints event, let us decode the header here against the concern.
 
 	switch (tcode) {
 	case TCODE_READ_QUADLET_RESPONSE:
@@ -1062,6 +1040,31 @@ void fw_core_handle_response(struct fw_card *card, struct fw_packet *p)
 		break;
 	}
 
+	spin_lock_irqsave(&card->lock, flags);
+	list_for_each_entry(iter, &card->transaction_list, link) {
+		if (iter->node_id == source && iter->tlabel == tlabel) {
+			if (!try_cancel_split_timeout(iter)) {
+				spin_unlock_irqrestore(&card->lock, flags);
+				goto timed_out;
+			}
+			list_del_init(&iter->link);
+			card->tlabel_mask &= ~(1ULL << iter->tlabel);
+			t = iter;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&card->lock, flags);
+
+	trace_async_response_inbound((uintptr_t)t, p->generation, p->speed, p->ack, p->timestamp,
+				     p->header, data, data_length / 4);
+
+	if (!t) {
+ timed_out:
+		fw_notice(card, "unsolicited response (source %x, tlabel %x)\n",
+			  source, tlabel);
+		return;
+	}
+
 	/*
 	 * The response handler may be executed while the request handler
 	 * is still pending.  Cancel the request handler.
diff --git a/include/trace/events/firewire.h b/include/trace/events/firewire.h
index 063695874cfb..2d5f6b196a22 100644
--- a/include/trace/events/firewire.h
+++ b/include/trace/events/firewire.h
@@ -30,6 +30,9 @@
 	((((unsigned long long)((header)[1] & ASYNC_HEADER_Q1_OFFSET_HIGH_MASK)) >> ASYNC_HEADER_Q1_OFFSET_HIGH_SHIFT) << 32)| \
 	(header)[2]
 
+#define ASYNC_HEADER_GET_RCODE(header)	\
+	(((header)[1] & ASYNC_HEADER_Q1_RCODE_MASK) >> ASYNC_HEADER_Q1_RCODE_SHIFT)
+
 #define QUADLET_SIZE	4
 
 DECLARE_EVENT_CLASS(async_outbound_initiate_template,
@@ -94,6 +97,47 @@ DECLARE_EVENT_CLASS(async_outbound_complete_template,
 	)
 );
 
+// The value of status is one of ack codes and rcodes specific to Linux FireWire subsystem.
+DECLARE_EVENT_CLASS(async_inbound_template,
+	TP_PROTO(u64 transaction, unsigned int generation, unsigned int scode, unsigned int status, unsigned int timestamp, const u32 *header, const u32 *data, unsigned int data_count),
+	TP_ARGS(transaction, generation, scode, status, timestamp, header, data, data_count),
+	TP_STRUCT__entry(
+		__field(u64, transaction)
+		__field(u8, generation)
+		__field(u8, scode)
+		__field(u8, status)
+		__field(u8, timestamp)
+		__array(u32, header, ASYNC_HEADER_QUADLET_COUNT)
+		__dynamic_array(u32, data, data_count)
+	),
+	TP_fast_assign(
+		__entry->transaction = transaction;
+		__entry->generation = generation;
+		__entry->scode = scode;
+		__entry->status = status;
+		__entry->timestamp = timestamp;
+		memcpy(__entry->header, header, QUADLET_SIZE * ASYNC_HEADER_QUADLET_COUNT);
+		memcpy(__get_dynamic_array(data), data, __get_dynamic_array_len(data));
+	),
+	// This format is for the response subaction.
+	TP_printk(
+		"transaction=0x%llx generation=%u scode=%u status=%u timestamp=0x%04x dst_id=0x%04x tlabel=%u tcode=%u src_id=0x%04x rcode=%u header=%s data=%s",
+		__entry->transaction,
+		__entry->generation,
+		__entry->scode,
+		__entry->status,
+		__entry->timestamp,
+		ASYNC_HEADER_GET_DESTINATION(__entry->header),
+		ASYNC_HEADER_GET_TLABEL(__entry->header),
+		ASYNC_HEADER_GET_TCODE(__entry->header),
+		ASYNC_HEADER_GET_SOURCE(__entry->header),
+		ASYNC_HEADER_GET_RCODE(__entry->header),
+		__print_array(__entry->header, ASYNC_HEADER_QUADLET_COUNT, QUADLET_SIZE),
+		__print_array(__get_dynamic_array(data),
+			      __get_dynamic_array_len(data) / QUADLET_SIZE, QUADLET_SIZE)
+	)
+);
+
 DEFINE_EVENT(async_outbound_initiate_template, async_request_outbound_initiate,
 	TP_PROTO(u64 transaction, unsigned int generation, unsigned int scode, const u32 *header, const u32 *data, unsigned int data_count),
 	TP_ARGS(transaction, generation, scode, header, data, data_count)
@@ -104,11 +148,17 @@ DEFINE_EVENT(async_outbound_complete_template, async_request_outbound_complete,
 	TP_ARGS(transaction, generation, scode, status, timestamp)
 );
 
+DEFINE_EVENT(async_inbound_template, async_response_inbound,
+	TP_PROTO(u64 transaction, unsigned int generation, unsigned int scode, unsigned int status, unsigned int timestamp, const u32 *header, const u32 *data, unsigned int data_count),
+	TP_ARGS(transaction, generation, scode, status, timestamp, header, data, data_count)
+);
+
 #undef ASYNC_HEADER_GET_DESTINATION
 #undef ASYNC_HEADER_GET_TLABEL
 #undef ASYNC_HEADER_GET_TCODE
 #undef ASYNC_HEADER_GET_SOURCE
 #undef ASYNC_HEADER_GET_OFFSET
+#undef ASYNC_HEADER_GET_RCODE
 #undef QUADLET_SIZE
 
 #endif // _FIREWIRE_TRACE_EVENT_H
-- 
2.43.0


