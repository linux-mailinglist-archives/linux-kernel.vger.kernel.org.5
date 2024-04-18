Return-Path: <linux-kernel+bounces-149798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C71D8A95FA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5823B227F4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F0815E20E;
	Thu, 18 Apr 2024 09:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="Ssg59Sjc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bn6wtJ5p"
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284FD15D5D0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 09:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713432203; cv=none; b=OOYF7m1in975sZVoBXADGDV/LalhaUhwkoUI8ItEL1Nq9eJJGBhQCryiAQrkiyZ0qgDU+RmJzkNIY61LW1O+OZZ7tUub0amB03iQMt6sZorHagRRMJZ59C6PiZRfJ8aZ9OTY3rXE5T6xvcVK81kFj1t2WHdR1Ea/6BV3rzei4Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713432203; c=relaxed/simple;
	bh=zA23cZDQyGLohQCzPuFxnsJDg2EuKgcHcPyeqmLNnB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJvUuet5Yv8wjzlY1ogryQeXtjYsyfvFoYS6XOZB5ebIn5qDCaDMio63sNRpGQtC18FleMwk53S1+XLUAedeG4KsfHIC9P564xUEURLkxhEc8S9B2QhJNMhN4URMfP2wwEqoHwaIVKHov+3PyLzwXFxqWSxAn5CphQdUuQAoMlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=Ssg59Sjc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bn6wtJ5p; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 760D8114010A;
	Thu, 18 Apr 2024 05:23:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 18 Apr 2024 05:23:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1713432201; x=
	1713518601; bh=3OABItpF1JJisjkVcgLVvbjO0GkY74R1iQwCloYtwbM=; b=S
	sg59SjcTv4+DcqC8eMlsZ/zPxkKv2iNV/yvgcOUwG87KpxzoC3t3ix3nE1nuh0Ns
	LfB8FuqlCTwKvIVZbFF4zp82gIsq1SpTgi230MPYdSCwhMJn91gVs6aYz30OBA5/
	lOGnwkhH7pWo0yRaJKGHdHstXAnjqlP1nl7IpMlQ7x3l/Pw/df+0FXLkOlSdmxv8
	t4orY++nOeDIm90HuafC3HmxCqpbouaMB+/aJcStAK1hkg3QPPGkMY5aLvfYceUL
	+VCXdT8ECBMA0QtMu4f3AnfyEpAEG+UVutwSlxx1gFKsrlIGfESXlj2StgZ60hEn
	Cki/wv/NhbRABYhUx4nkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1713432201; x=
	1713518601; bh=3OABItpF1JJisjkVcgLVvbjO0GkY74R1iQwCloYtwbM=; b=b
	n6wtJ5pHVVmTnjKnScJB0ZzTxISLQPJmAVhKli9CSUIoMIBlziSN/RFl7OC5gA7H
	wGkXgzwqatmJ0ym8MylluMLrPIIQtEsqC04Kv+eae4aWLru6eec22AqRxGUrSplw
	f1g7WO48BspDa9pY+QilhFxv1b5rKLisSjrTZRcLXUl2jxDXK7GwHxOh1zVmM5CM
	s4l6/SLg72c4CEyq8InWwgWvfpwP2mdELkQamQgRbV+SCc5ZWCLhoB6lbk5q6uyI
	TdXgCDRhKayLST68tinhzMYzZVyICiqVSlN5cD/flkVb13MaIKqwVy+oKbQ+2MEe
	9fcIUtQ9ql16/tLfjpmBg==
X-ME-Sender: <xms:ieYgZphEQ2gse6UcCFn-954uezXYBU3Px5Y6wesViI9evv4ct-Tyfw>
    <xme:ieYgZuDgWijWfvc6G7TLIxD0FrTOF-AbP36UNiOi9du0fTe4gyRjdHKwdS-imfKUh
    zRu4npJLEsjBXYm7Ic>
X-ME-Received: <xmr:ieYgZpFXm1puASJXlZ59_qH8lmnCI4vFBPBpOKEShcQdHmps5XhClmM0JhWFSN99YGonX9JrBPuupqWrqLDKgT_mEpuKK8mdW4SYC9LPhDABbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudektddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:ieYgZuT6X-Ee2xWpYtDftVGEjv-T_vUwKYJorGV8AdhA4fNDMO5lQw>
    <xmx:ieYgZmxvum82f2R9LGOP_f-AdhlqVqXDnVxRC4188MCUaYZiHVnJzg>
    <xmx:ieYgZk4V8_Ks81qgw6A6kB0KZl5QoNnedIOvE3gSg_n41ImyWyPTiw>
    <xmx:ieYgZry3KZGQJsSxhxZaOEgvbedmIQipH0cl9NCHBykqNgGoA0OOGQ>
    <xmx:ieYgZh9-ox2WDnMSE-m7xRJwEahebUoK0JqrKzulQfL_PPwjIYgAaMUb>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Apr 2024 05:23:20 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 10/13] firewire: core: add tracepoints events for asynchronous outbound request
Date: Thu, 18 Apr 2024 18:23:00 +0900
Message-ID: <20240418092303.19725-11-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240418092303.19725-10-o-takashi@sakamocchi.jp>
References: <20240418092303.19725-1-o-takashi@sakamocchi.jp>
 <20240418092303.19725-2-o-takashi@sakamocchi.jp>
 <20240418092303.19725-3-o-takashi@sakamocchi.jp>
 <20240418092303.19725-4-o-takashi@sakamocchi.jp>
 <20240418092303.19725-5-o-takashi@sakamocchi.jp>
 <20240418092303.19725-6-o-takashi@sakamocchi.jp>
 <20240418092303.19725-7-o-takashi@sakamocchi.jp>
 <20240418092303.19725-8-o-takashi@sakamocchi.jp>
 <20240418092303.19725-9-o-takashi@sakamocchi.jp>
 <20240418092303.19725-10-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a view of core transaction service, the asynchronous outbound request
consists of two stages; initiation and completion.

This commit adds a pair of event for them.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-transaction.c |  6 +++
 drivers/firewire/trace.h            | 80 ++++++++++++++++++++++++++++-
 2 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index 52d8d483c178..11a60094182a 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -29,6 +29,7 @@
 #include <asm/byteorder.h>
 
 #include "core.h"
+#include "trace.h"
 #include "packet-header-definitions.h"
 
 #define HEADER_DESTINATION_IS_BROADCAST(header) \
@@ -173,6 +174,8 @@ static void transmit_complete_callback(struct fw_packet *packet,
 	struct fw_transaction *t =
 	    container_of(packet, struct fw_transaction, packet);
 
+	trace_async_request_outbound_complete(card, t, packet);
+
 	switch (status) {
 	case ACK_COMPLETE:
 		close_transaction(t, card, RCODE_COMPLETE, packet->timestamp);
@@ -394,6 +397,9 @@ void __fw_send_request(struct fw_card *card, struct fw_transaction *t, int tcode
 
 	spin_unlock_irqrestore(&card->lock, flags);
 
+	trace_async_request_outbound_initiate(card, t, &t->packet, payload,
+					      tcode_is_read_request(tcode) ? 0 : length / 4);
+
 	card->driver->send_request(card, &t->packet);
 }
 EXPORT_SYMBOL_GPL(__fw_send_request);
diff --git a/drivers/firewire/trace.h b/drivers/firewire/trace.h
index d36a10460301..0f7d176ba647 100644
--- a/drivers/firewire/trace.h
+++ b/drivers/firewire/trace.h
@@ -7,8 +7,86 @@
 #define _FIREWIRE_TRACE_EVENT_H
 
 #include <linux/tracepoint.h>
+#include <linux/firewire.h>
 
-// Placeholder for future use.
+#include <linux/firewire-constants.h>
+
+#include "packet-header-definitions.h"
+
+TRACE_EVENT(async_request_outbound_initiate,
+	TP_PROTO(const struct fw_card *card, const struct fw_transaction *transaction,
+		 const struct fw_packet *packet, const u32 *data, size_t data_count),
+	TP_ARGS(card, transaction, packet, data, data_count),
+	TP_STRUCT__entry(
+		__field(u64, transaction)
+		__field(u8, scode)
+		__field(u8, generation)
+		__field(u16, destination)
+		__field(u8, tlabel)
+		__field(u8, retry)
+		__field(u8, tcode)
+		__field(u8, priority)
+		__field(u16, source)
+		__field(u64, offset)
+		__dynamic_array(u32, data, data_count)
+	),
+	TP_fast_assign(
+		__entry->transaction = (u64)transaction;
+		__entry->scode = packet->speed;
+		__entry->generation = packet->generation;
+		__entry->destination = async_header_get_destination(packet->header);
+		__entry->tlabel = async_header_get_tlabel(packet->header);
+		__entry->retry = async_header_get_retry(packet->header);
+		__entry->tcode = async_header_get_tcode(packet->header);
+		__entry->priority = async_header_get_priority(packet->header);
+		__entry->source = async_header_get_source(packet->header);
+		__entry->offset = async_header_get_offset(packet->header);
+		memcpy(__get_dynamic_array(data), data, __get_dynamic_array_len(data));
+	),
+	TP_printk(
+		"transaction=0x%llx scode=%u generation=%u dst_id=0x%04x tlabel=%u retry=%u tcode=%u priority=%u src_id=0x%04x offset=0x%012llx data=%s",
+		__entry->transaction,
+		__entry->scode,
+		__entry->generation,
+		__entry->destination,
+		__entry->tlabel,
+		__entry->retry,
+		__entry->tcode,
+		__entry->priority,
+		__entry->source,
+		__entry->offset,
+		__print_array(__get_dynamic_array(data),
+			      __get_dynamic_array_len(data) / sizeof(u32), sizeof(u32))
+	)
+)
+
+TRACE_EVENT(async_request_outbound_complete,
+	TP_PROTO(const struct fw_card *card, const struct fw_transaction *transaction,
+		 const struct fw_packet *packet),
+	TP_ARGS(card, transaction, packet),
+	TP_STRUCT__entry(
+		__field(u64, transaction)
+		__field(u8, scode)
+		__field(u8, generation)
+		__field(u8, ack)
+		__field(u16, timestamp)
+	),
+	TP_fast_assign(
+		__entry->transaction = (u64)transaction;
+		__entry->scode = packet->speed;
+		__entry->generation = packet->generation;
+		__entry->ack = packet->ack;
+		__entry->timestamp = packet->timestamp;
+	),
+	TP_printk(
+		"transaction=0x%llx scode=%u generation=%u ack=%u timestamp=0x%04x",
+		__entry->transaction,
+		__entry->scode,
+		__entry->generation,
+		__entry->ack,
+		__entry->timestamp
+	)
+)
 
 #endif // _FIREWIRE_TRACE_EVENT_H
 
-- 
2.43.0


