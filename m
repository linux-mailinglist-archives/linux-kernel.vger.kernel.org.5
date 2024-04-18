Return-Path: <linux-kernel+bounces-149799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A83E48A95FB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DA9E1F22510
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6239C15B0EB;
	Thu, 18 Apr 2024 09:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="GVKFDobg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jYCnF71i"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B831815E1F0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 09:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713432205; cv=none; b=kz++oqlFlKpLkq0PHZOw0HlztXIxdCIZrv4AI+LBZz1JZODajdmCkL93opFgpxjfIhRA1cxMNmzw4eucOxeBNpQCm/HufJnd4iM4YrIuN6gb1v//eNhW7CvLCM7MsZ5CKMeTGwzbJSA96ow51sCmXRU34HJQi0tvKA4yseV4KpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713432205; c=relaxed/simple;
	bh=YYd24lzdOEAiopxmzeWnvG3MqZg5713h5PUFbBbZh6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HmxZ+5ygGIMDEiexaiRxjXzTm8WkcLixVozDXR49WY2/hsXcOVK+jrRjTlEfMpiLdbhB/Nr45UpxKcAqVDUG0x+nW0fzeJHocMa9/Kyxp8oQ2CKAGHh7cGlj89/+Zp1cuG4Y6AKxgKSwCKp0tWeEguKQwoWlXJF0PkoZaEHY3LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=GVKFDobg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jYCnF71i; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id D4F8113800C6;
	Thu, 18 Apr 2024 05:23:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 18 Apr 2024 05:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1713432202; x=
	1713518602; bh=HJ3aHw2ntpRqnqoos49E4hWJ+XH7yH2ocsiFtJ2lzRs=; b=G
	VKFDobg+YjM+jyKPdvZmoV0f7KvXBLV406VfF0atmc3m9oWmhZ9lTiFupWZVMlFP
	q+dt3HrxboPkuGL8J9dInaMnM1ORs8taYxzD0AvacRmEzUNjF6Aah4KOCN3mNRAe
	xjyKshclp9phxPmKYqpr34MFcmTd84liMRvX7HLj5jnFlzRooibwF2QXs1yyQbCm
	XEkvbHL3qQHEKnqWf8qMTewIQoa5e02m0PI4xeXdF9KQE4inDvlD9AKr7S7imoB3
	deKrGMoLd0QyPVrS0SjI2uOeV3rqzt4x5yMNB7iUvECvUf3lLMdPRc1CssRE1l+W
	c8twBKXdH0oKNULl1zPhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1713432202; x=
	1713518602; bh=HJ3aHw2ntpRqnqoos49E4hWJ+XH7yH2ocsiFtJ2lzRs=; b=j
	YCnF71imnzATdTUYfKxZAb4G+nE085BHkYhBbc+yV+bl0vHGgO5jXkMcxJh5Q6Va
	Doi94TxcACHQ92CPCN8QaCTOHCA+NA4ZW48kA2L6aoQWcaGLBlLFSubouqCi2X9Y
	gyluSsdUDQ98PXhQDKDzEKtdAWm0G5tBMjFt/PPhhsvlru7fkDvqt68Z1LTp4SmY
	banjcDHDBvO2E52oVbXkxFe/+VmdO2WFPprxA1Ro41Wk/ytMgiit6tAl9nCudW1y
	SvgwC3dWZ4fzLDXcVptjpUk03UWjuuhC8+fFHSP44N9/FVqcBoM7//QbQAFCn1CT
	eKcuzimtsQIf4T581wFtg==
X-ME-Sender: <xms:iuYgZjUUVfkTjG5JGRA8GGiULafhupEdYWfVhatNzhGRfMC0SWRkCQ>
    <xme:iuYgZrlUM3jYM0ZhIByGy_R3_TLMoLRQIKfrvI_cRAZrou6dB6K1k3Rfv1QHWRNe7
    n6AMb1_A13tZMSt7gU>
X-ME-Received: <xmr:iuYgZvag5ct9bbklV5Pkc75Oxmx2KJRZU6zbuC6lz6KYi6rquhwZP04IHno_4MdLC2R6EB8GKp31vsmGpvzX7mg-ngvlZluFpvM31UP7hUOmpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudektddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:iuYgZuX4DRuDHrfh53wJ9weXNhWT7enn3b5MWm2-kJzbrKZrzTdJsw>
    <xmx:iuYgZtl78Ff5AwvxdzIKrASHIiItsNLZ9i833JUlQOASPpU-n053yA>
    <xmx:iuYgZrdNnFtKuLSH76FUj_9B9aCNxCpR9bx-tzTZmRXc2eXPXXa95Q>
    <xmx:iuYgZnESsTjMheCbu0RYEhFhIVA-cbzi1s3VX-XeVbHeqLPJby5RQA>
    <xmx:iuYgZizLEx34yh4xASfXfWVDVx7aGfqRAEpmsNIIT6lHfM58G96rp-Tw>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Apr 2024 05:23:21 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 11/13] firewire: core: add tracepoints event for asynchronous inbound response
Date: Thu, 18 Apr 2024 18:23:01 +0900
Message-ID: <20240418092303.19725-12-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240418092303.19725-11-o-takashi@sakamocchi.jp>
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
 <20240418092303.19725-11-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the transaction of IEEE 1394, the node to receive the asynchronous
request transfers response packet to the requester.

This commit adds an event for the incoming packet. Note that the code to
decode the packet header is moved, against the note about the sanity
check.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-transaction.c | 54 +++++++++++++++--------------
 drivers/firewire/trace.h            | 48 +++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 26 deletions(-)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index 11a60094182a..977d8a36f969 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -1010,32 +1010,10 @@ void fw_core_handle_response(struct fw_card *card, struct fw_packet *p)
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
@@ -1061,6 +1039,30 @@ void fw_core_handle_response(struct fw_card *card, struct fw_packet *p)
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
+	trace_async_response_inbound(card, t, p, data, data_length / 4);
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
diff --git a/drivers/firewire/trace.h b/drivers/firewire/trace.h
index 0f7d176ba647..5187f5f2b140 100644
--- a/drivers/firewire/trace.h
+++ b/drivers/firewire/trace.h
@@ -88,6 +88,54 @@ TRACE_EVENT(async_request_outbound_complete,
 	)
 )
 
+TRACE_EVENT(async_response_inbound,
+	TP_PROTO(const struct fw_card *card, const struct fw_transaction *transaction,
+		 const struct fw_packet *packet, u32 *data, unsigned int data_count),
+	TP_ARGS(card, transaction, packet, data, data_count),
+	TP_STRUCT__entry(
+		__field(u64, transaction)
+		__field(u8, scode)
+		__field(u8, generation)
+		__field(u16, timestamp)
+		__field(u16, destination)
+		__field(u8, tlabel)
+		__field(u8, retry)
+		__field(u8, tcode)
+		__field(u8, priority)
+		__field(u16, source)
+		__field(u8, rcode)
+		__dynamic_array(u32, data, data_count)
+	),
+	TP_fast_assign(
+		__entry->transaction = (u64)transaction;
+		__entry->scode = packet->speed;
+		__entry->timestamp = packet->timestamp;
+		__entry->destination = async_header_get_destination(packet->header);
+		__entry->tlabel = async_header_get_tlabel(packet->header);
+		__entry->retry = async_header_get_retry(packet->header);
+		__entry->tcode = async_header_get_tcode(packet->header);
+		__entry->priority = async_header_get_priority(packet->header);
+		__entry->source = async_header_get_source(packet->header);
+		__entry->rcode = async_header_get_rcode(packet->header);
+		memcpy(__get_dynamic_array(data), data, __get_dynamic_array_len(data));
+	),
+	TP_printk(
+		"transaction=0x%llx scode=%u timestamp=0x%04x dst_id=0x%04x tlabel=%u retry=%u tcode=%u priority=%u src_id=0x%04x rcode=%u data=%s",
+		__entry->transaction,
+		__entry->scode,
+		__entry->timestamp,
+		__entry->destination,
+		__entry->tlabel,
+		__entry->retry,
+		__entry->tcode,
+		__entry->priority,
+		__entry->source,
+		__entry->rcode,
+		__print_array(__get_dynamic_array(data),
+			      __get_dynamic_array_len(data) / sizeof(u32), sizeof(u32))
+	)
+)
+
 #endif // _FIREWIRE_TRACE_EVENT_H
 
 #define TRACE_INCLUDE_PATH	.
-- 
2.43.0


