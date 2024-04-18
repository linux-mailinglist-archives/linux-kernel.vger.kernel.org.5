Return-Path: <linux-kernel+bounces-149800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEABF8A95FC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91FA5284719
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F68A15E5CA;
	Thu, 18 Apr 2024 09:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="DnCEBtEr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YAU48Izp"
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BD915E215
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 09:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713432206; cv=none; b=Kj9IbN3lHk+LXGi1tOvfn9doA5t5IsVMNXOTEf7cBx8hqnr+dGBTSVu/waFnSnJs/icG5K9GAgOf/TeT5dVFFi4NsDhjYpmT4xWO7G/17XnCWibpg0ttA1zPLPTyU9X4IbJmLKvJwKR4pZfZT8qsTWdlsY6yaQl4Er/BxF1lrQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713432206; c=relaxed/simple;
	bh=+iue6vUJSFEkVGwlqQ49JgmUF0zJCSuRmxg9vrDDtHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KC3ZSZDM75tZoHj7KoJyvlii7Fc/M94M497xV3GdHWSGi3ln527YBgeL+JB2VANl8631LLeDAuYvLuLr00ZgIAH3m8x6B/8MdIUyjtKvojKsqj3+gPX4q7PzEfO9PuysuRCor+xGLiE/Ph4w2sGJDmLrJhkHRTYIKFVH3UHOik8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=DnCEBtEr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YAU48Izp; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3ACCD114011F;
	Thu, 18 Apr 2024 05:23:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 18 Apr 2024 05:23:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1713432204; x=
	1713518604; bh=FDQwV+EcmAsl476lXLMlzTwzlhfthYLIcTW64tkepxs=; b=D
	nCEBtErDjGHapb0yZmxwr/smuBOJ8BOlxPLPFVjxuJjSd0M0lm910U9ImP2sg9w5
	F3F+XhKaTF38VWhhr55QSAo5v0qOIRlAgNCLsV+IB2Ja1Jg/R91YfEhc19Pb6ZVP
	bhOxCSdJb3ih1LV22RI7f6dXPd/nr5v317mekRc7UnBjhlPAv+saNZKVpYvIa5t9
	0p0Bt2v5gozXE2gnhpjXsyDupWgDv5pTvtcSOSQQBtNm5WIHGKKkV2KcaBA0y0MW
	CKW29wHD/sJYCFI4Eg5wUCh1av4eWKuZJznPxgYp7eIr7J4UsKzSAR8nluhNLaIt
	K0fIenCw79P09EszTlW0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1713432204; x=
	1713518604; bh=FDQwV+EcmAsl476lXLMlzTwzlhfthYLIcTW64tkepxs=; b=Y
	AU48IzpAhqW+/UinTkLuykptFSZdSD4R+pifposyY5U+vmFSScvVPh7SwISJuX4A
	OvKRqkKlQmL4L6fT4NyCMk6ZMwk72HSM2HHLtWotC2ZQly1wWmwvlGdXBXixH35E
	fFOYJxleJekLqmXZ4FfR8EVPNlEOjkDG7WjdVwQYY1R+s7fdHszrJlKPPC7wpPFD
	gNSqq2mKKRiCvpABYWoaAlzrLWwZCfVUFyUTmZjYjzw+g0EgNSdy1cey/RTE5Bf4
	rQKRctbIcV8PzUKRl7RjqZAm+fqg1SlU6H35kk7Ucya1SMXR4h/ASsuhyEOsKech
	9lE+4AYtJiThtgcud+/2w==
X-ME-Sender: <xms:jOYgZgoTLxKXFe6IDwIe00JZxVCqMwcWOXoG-NyHR7GqgZfba36FOQ>
    <xme:jOYgZmozVIoAaradK5Uq6_asGKklja57XxHZk7oX-v-qQJkfBCv33IGdwoX7dRQI0
    lTwpVL0_FPk2QiPlcQ>
X-ME-Received: <xmr:jOYgZlN4I9Xe5cvt_IHNQt-CWGDYnY5jGA2nGKH1dcFPwc_mhFNILm9IPwqaTyMmZRUBPZvrDUFK5qsClsfwFVWDbnGwWUagENoTCDI2d1dOrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudektddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:jOYgZn45nMmFZ-_cBosJYh-DsU3A6sy4mbQJFYoeHlIDSq2XVH_dUw>
    <xmx:jOYgZv5yl7OUUs1hgkdJUlCiXEUf_RB0vgV4wbWqA05tt-XKcrPe7Q>
    <xmx:jOYgZnjG2k_hwqZDV55SunLwEoMVVxBQp1m0ODQ3rRG9Y881kdfdYg>
    <xmx:jOYgZp7isweVygzX18iDa36dXYIvUuCXAOE-eEI9jIG0NaDXi-Le7w>
    <xmx:jOYgZvGhclQBzklAMsJRnBNSgPmovfbPX6kdIgd-0L8AYF-484aRP2sU>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Apr 2024 05:23:23 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 12/13] firewire: core: add tracepoint event for asynchronous inbound request
Date: Thu, 18 Apr 2024 18:23:02 +0900
Message-ID: <20240418092303.19725-13-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240418092303.19725-12-o-takashi@sakamocchi.jp>
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
 <20240418092303.19725-12-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds an event for asynchronous inbound request.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-transaction.c |  8 ++++-
 drivers/firewire/trace.h            | 54 +++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index 977d8a36f969..1b972e95fe36 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -972,11 +972,13 @@ void fw_core_handle_request(struct fw_card *card, struct fw_packet *p)
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
@@ -987,6 +989,10 @@ void fw_core_handle_request(struct fw_card *card, struct fw_packet *p)
 		return;
 	}
 
+	trace_async_request_inbound(card, request, p->ack, p->speed, p->timestamp, p->generation,
+				    p->header, request->data,
+				    tcode_is_read_request(tcode) ? 0 : request->length / 4);
+
 	offset = async_header_get_offset(p->header);
 
 	if (!is_in_fcp_region(offset, request->length))
diff --git a/drivers/firewire/trace.h b/drivers/firewire/trace.h
index 5187f5f2b140..ba09eb720933 100644
--- a/drivers/firewire/trace.h
+++ b/drivers/firewire/trace.h
@@ -136,6 +136,60 @@ TRACE_EVENT(async_response_inbound,
 	)
 )
 
+TRACE_EVENT(async_request_inbound,
+	TP_PROTO(const struct fw_card *card, const struct fw_request *request, unsigned int ack,
+		 unsigned int scode, unsigned int timestamp, unsigned int generation,
+		 const u32 *header, const u32 *data, unsigned int data_count),
+	TP_ARGS(card, request, ack, scode, timestamp, generation, header, data, data_count),
+	TP_STRUCT__entry(
+		__field(u64, transaction)
+		__field(u8, scode)
+		__field(u8, ack)
+		__field(u8, generation)
+		__field(u16, timestamp)
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
+		__entry->transaction = (u64)request;
+		__entry->scode = scode;
+		__entry->ack = ack;
+		__entry->generation = generation;
+		__entry->timestamp = timestamp;
+		__entry->destination = async_header_get_destination(header);
+		__entry->tlabel = async_header_get_tlabel(header);
+		__entry->retry = async_header_get_retry(header);
+		__entry->tcode = async_header_get_tcode(header);
+		__entry->priority = async_header_get_priority(header);
+		__entry->source = async_header_get_source(header);
+		__entry->offset = async_header_get_offset(header);
+		memcpy(__get_dynamic_array(data), data, __get_dynamic_array_len(data));
+	),
+	TP_printk(
+		"transaction=0x%llx scode=%u ack=%u generation=%u timestamp=0x%04x dst_id=0x%04x tlabel=%u retry=%u tcode=%u priority=%u src_id=0x%04x offset=0x%012llx data=%s",
+		__entry->transaction,
+		__entry->scode,
+		__entry->ack,
+		__entry->generation,
+		__entry->timestamp,
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
 #endif // _FIREWIRE_TRACE_EVENT_H
 
 #define TRACE_INCLUDE_PATH	.
-- 
2.43.0


