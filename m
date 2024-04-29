Return-Path: <linux-kernel+bounces-161729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 986928B503F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F4D8281341
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 04:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8DD10A3B;
	Mon, 29 Apr 2024 04:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="d69Xhl/R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a1ssg9l2"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB047D530
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 04:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714365151; cv=none; b=ch1P8Xo94+sJmQU/mzroLpjeaevuyueIpH0+Ums9XRWyZq+8vyvuJA8SuDk5SN3/NDZAr+Xjg9isw/SKbeUZ710WIyHdoBFEH4fBa6k3Tqa2hlg0yzDewvO0jaNWDcAaC7FPMVu0vb20maz1wYQ+TsFPmOhXW2iEOEDyWM0lrHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714365151; c=relaxed/simple;
	bh=RFA3NB3xpvDL5LUf+TSFT+iTbtLPH9WfXmQeOQpuOq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AugqVtz4Pcbv1N0MgRDJEwRP7djTkIRJQ0u5uWCZ2qdrdYBcP62of7+3ekOCWieVKrhiBjQEGaBR/ppsLx+tW6NO/Lf+GwSY/XMff9i7kHXqaJRU9DZ3n4ss2ziP1LDOPMH/rFHZW7LaaCe/huvwXrbWt+wpRDzSrsnKhOQP7rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=d69Xhl/R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a1ssg9l2; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id D7AEA138015C;
	Mon, 29 Apr 2024 00:32:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 29 Apr 2024 00:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1714365148; x=
	1714451548; bh=vWynpCJ7ctqWnEViz41ox0kp4vazZvpoqgenoJ6du9s=; b=d
	69Xhl/RXAWsf+q9taZy2ym9CIhcAYIlttZSFP5nyKoKo8VuKO6vNnhK8Ln1bv642
	u4pqJp72ZFUHJOjo2Y3VeM/d42+KTsLkRVB2qT4MMH5HuQINSk5put3B7Fn50Grl
	I7xvegK6+rL+RHG5x7wmS85Vu3Wa81Q5wJltczj4iuEpu4QK0wGuSP12vD1cMbie
	sJimcDitZOKjoZJNHVolgJxh/jQfMKjn0zq6xh6+BuFPxhXrc+gDEwMPXLrGEyGg
	Ho+M50WD2BinuojpGENV/ByVKxDR4LFxFirLsUl1pRggGr/QvXTuzD2K2Z68SQun
	OMUuh6h6mwnXi/U9vniGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714365148; x=
	1714451548; bh=vWynpCJ7ctqWnEViz41ox0kp4vazZvpoqgenoJ6du9s=; b=a
	1ssg9l2IPsuLk1tgkIEKdt1+d1nh7BEIGVASKUmpIWf6wajI9Q6/gOONFMSSnHhm
	XJa+H80qyff6QM0F2O8OyOIFsjbx+G3j4ZQBLMl10SlIiI8FQkYgnN/XF1rt3+8O
	2C2R5Ef1i8Tk0f7VweH81mSSRrDxIrFgvSObPEbsSKKDRJ2/h+AVHq3KR/AX92RX
	HbPb2LIGa2GfTgfyUh1nnZfu9ntrrJ6usK4sW3U+6/cy/z9WmdSnDQ8Ud5BG5Oxa
	A4/KBOwAdAnXTTLZyOaaaQTBNBQ0N2oqQqV6kFkGK/PEM8Ibt+UN9uCLAzigkkUd
	sbb78DdFCkcMq7MH1vwYg==
X-ME-Sender: <xms:3CIvZnJZn-KrBcICVRWhthBliOPE0_ASJgmsIjW9JsgrStqkSsfV8Q>
    <xme:3CIvZrKdQ0EcDYs3xO6D-iPZzf3EEDk7PRMCu7vIbtCC-GrAPBZv7_Pk40mtaEFMK
    DAibCMnjIo3u56RT-E>
X-ME-Received: <xmr:3CIvZvto8DwLw081NbG3HHRqEYo1PvCZ0mZu6UkLPQy2eXBv39piActtqz9M3w_mRGZaCuLktw8V-tFlsnwtSyQDKnHkpHXx9__Fygxftm1XOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtledgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:3CIvZgah9aZsWQnRAYUxVkUtWedkW-TH12eVHxrPiD6xwR3ifnkVjA>
    <xmx:3CIvZua3DKdEdnyS79FwdIQ_DhgFCsNYFmy_JtiGQOm6XAbbtEiCGw>
    <xmx:3CIvZkCNkQpzy0oTrbbm5rImQCkiipaO3diGd6BRgb4F00Dyvwhg0A>
    <xmx:3CIvZsY1fm5WrDQZQtqGIjp-GGv8JCPSMOa-ufKZN1Lx_vNRT-KpsA>
    <xmx:3CIvZtmb5Jk04HJ2BqAFbNEFmo4i75yWyz3Qw5Ea3x6YQq_SfcmEWAQ2>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 00:32:27 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] firewire: core: add tracepoint event for asynchronous inbound request
Date: Mon, 29 Apr 2024 13:32:17 +0900
Message-ID: <20240429043218.609398-5-o-takashi@sakamocchi.jp>
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

This commit adds an event for asynchronous inbound request.

The following example is for asynchronous block write request as IEC
61883-1 FCP request from node 0xffc1.

async_request_inbound: \
  transaction=0xffff89fa08cf16c0 generation=4 scode=2 status=2 \
  timestamp=0x00b3 dst_id=0xffc0 tlabel=19 tcode=1 src_id=0xffc1 \
  offset=0xfffff0000d00 header={0xffc04d10,0xffc1ffff,0xf0000d00,0x80000} \
  data={0x19ff08,0xffff0090}

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-transaction.c |  8 +++++++-
 include/trace/events/firewire.h     | 21 +++++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index 56510d305564..8c13f996a938 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -973,11 +973,13 @@ void fw_core_handle_request(struct fw_card *card, struct fw_packet *p)
 {
 	struct fw_request *request;
 	unsigned long long offset;
+	unsigned int tcode;
 
 	if (p->ack != ACK_PENDING && p->ack != ACK_COMPLETE)
 		return;
 
-	if (tcode_is_link_internal(async_header_get_tcode(p->header))) {
+	tcode = async_header_get_tcode(p->header);
+	if (tcode_is_link_internal(tcode)) {
 		fw_cdev_handle_phy_packet(card, p);
 		return;
 	}
@@ -988,6 +990,10 @@ void fw_core_handle_request(struct fw_card *card, struct fw_packet *p)
 		return;
 	}
 
+	trace_async_request_inbound((uintptr_t)request, p->generation, p->speed, p->ack,
+				    p->timestamp, p->header, request->data,
+				    tcode_is_read_request(tcode) ? 0 : request->length / 4);
+
 	offset = async_header_get_offset(p->header);
 
 	if (!is_in_fcp_region(offset, request->length))
diff --git a/include/trace/events/firewire.h b/include/trace/events/firewire.h
index 2d5f6b196a22..a30cebed119a 100644
--- a/include/trace/events/firewire.h
+++ b/include/trace/events/firewire.h
@@ -153,6 +153,27 @@ DEFINE_EVENT(async_inbound_template, async_response_inbound,
 	TP_ARGS(transaction, generation, scode, status, timestamp, header, data, data_count)
 );
 
+DEFINE_EVENT_PRINT(async_inbound_template, async_request_inbound,
+	TP_PROTO(u64 transaction, unsigned int generation, unsigned int scode, unsigned int status, unsigned int timestamp, const u32 *header, const u32 *data, unsigned int data_count),
+	TP_ARGS(transaction, generation, scode, status, timestamp, header, data, data_count),
+	TP_printk(
+		"transaction=0x%llx generation=%u scode=%u status=%u timestamp=0x%04x dst_id=0x%04x tlabel=%u tcode=%u src_id=0x%04x offset=0x%012llx header=%s data=%s",
+		__entry->transaction,
+		__entry->generation,
+		__entry->scode,
+		__entry->status,
+		__entry->timestamp,
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
 #undef ASYNC_HEADER_GET_DESTINATION
 #undef ASYNC_HEADER_GET_TLABEL
 #undef ASYNC_HEADER_GET_TCODE
-- 
2.43.0


