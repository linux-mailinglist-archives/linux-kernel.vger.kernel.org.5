Return-Path: <linux-kernel+bounces-163177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C028B66CB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 02:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 010111C211A3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 00:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4171FAA;
	Tue, 30 Apr 2024 00:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="dH/If4aI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bn77oDCp"
Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4303A635
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 00:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714436053; cv=none; b=K6yyp0eX/A0z5VswlS1pmg/CSeZQa866itp+RE5itmLYFD9pyqatYqALMfvH0Sn7NXZDkKHMlfLBI6/Q1hIZwtcEHJw26vHqEWzYRMN63ygTBpfkyQiYpUGv0FJvLWQt7CFrNaHsiGHlPnk2Dkl09bzB1Xlcwvmxv+KL8b9p2ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714436053; c=relaxed/simple;
	bh=T85yen7HnG+x+lmA6ANvjwm4bTms2b7gFzcgLogpfwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lU3IhT28sfunz8+tr4gOBIxxIWt2h3Vmgy388aPV7dteBdsf/bDXLqLVB/7gQ4ZWrdbkSurEOPPkGLXzngR4JSTDhQjLMZvrV1CFzRJTspIMO7jP8erk4QTnxVln2VHonVjTnIzmtUZYraWmh0RJOcxMeubiaUlS0Ky8hsKIgMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=dH/If4aI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bn77oDCp; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 6A2AA1800117;
	Mon, 29 Apr 2024 20:14:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 29 Apr 2024 20:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1714436050; x=
	1714522450; bh=Hr78+iTtvJXTwj7q8gZRLKxv3nui8iV2ZdOeKx/4HVw=; b=d
	H/If4aIpp0PqrRHNEJWcIgt3c4HyGXWbGd4F/9YaHr6DrBboQ7c4US2mjGbQuGCQ
	wZ7VYL0hS15VeY3deLzciybhBdIjlOJrZZsxjrUx3pZOWxtoThkjS5pElzAY1v38
	s/32HK1it6WLnYjiTDTbvVfACoMo33o6ivkxguW0F0qwTcOGVlGSOml2Rnmb2k3C
	79gDPrYjsVCFv/0dZgmgXJ0hKcby0Rt+Q0iW7i9v68hzY4i3EsM75nE3BQpLO3Ze
	ci8mxE8jkXc9/2Iwt8fiA7rTliazPqZXTyBopXChDirabbA3CYCzu9XXSsI5PcHH
	gB2+cV306zgv041SD3kvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714436050; x=
	1714522450; bh=Hr78+iTtvJXTwj7q8gZRLKxv3nui8iV2ZdOeKx/4HVw=; b=b
	n77oDCp3NNtWEbqDlGfyALlShZsn9f0SEhOV0IRZYATyHQ2vlgYHvfD0ya3grU7a
	bAzUz8WFbWrDhx2L/plH+WVZPu86D6Ytmfg9D6EUFACyDTXSw8NQMowvbnUMiHaO
	KKrAEZf/uFDth4AI3aNYFEi6FKGyxOeETb0KU7nJmK5OEGYfNypaRuCXZxhJjB5i
	sNX1Fk7G2n8oSS3eRC3UmwE2SzvVWOmVTBs+rDQr+ugIGy592CHgcfnKA/pfFTLK
	iw6X5mYXGTbEXlMowa14v4wNPlbbfjng33BPdkXrEF7rcfSFbr1iGqLrT9irOdqH
	vRdiOoEm75g/Dvhof31Yg==
X-ME-Sender: <xms:0TcwZo5djTquAhZt99wdBSqMUDGcB5Wmoho9rW5xvS0L-QZSAfKgyQ>
    <xme:0TcwZp6FHJurRTfKEExze4z9osWwQtAVKnin5zGWsmtAbuor-cw2FQHoXvAAKmEd9
    j8_ZnpKk8fBtDaQOLA>
X-ME-Received: <xmr:0TcwZncwOdReupCh0cQFK9QEjNEFbeSqCWswtEQaTVlKeiXC9snzMVz0Wn18Egj2aYm2MBRTZlnDFy2cmXk2vjbp6CPuRNooPsEq1oCu12ZRwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduvddgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:0TcwZtL4e-K-XkRH_yX7ShCslkBbTQAca9Esmfr2EmKDJDfarF9Ecw>
    <xmx:0TcwZsJhMYohtpgy366vyYcUNbpOMBxGiNnvvXE9tsDV90fd5n6wCg>
    <xmx:0TcwZuyHmRCqaqHWmnHaZnAOfBS4Wg3HbhY3BUCBjeXVtftQM4z1sw>
    <xmx:0TcwZgJ5qmlcYblIraBStauynPDhykp8wo_OVfGYmFIsQn8pPHunVg>
    <xmx:0jcwZjUl6tfPqYMM2pw2ZAgIQ44Q8iTs11V8-YhOgdNUayw8puBx_cpB>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 20:14:08 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] firewire: core/cdev: add tracepoints events for asynchronous phy packet
Date: Tue, 30 Apr 2024 09:14:03 +0900
Message-ID: <20240430001404.734657-2-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240430001404.734657-1-o-takashi@sakamocchi.jp>
References: <20240430001404.734657-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In IEEE 1394 bus, the type of asynchronous packet without any offset to
node address space is called as phy packet. The destination of packet is
IEEE 1394 phy itself. This type of packet is used for several purposes,
mainly for selfID at the state of bus reset, to force selection of root
node, and to adjust gap count.

This commit adds tracepoints events for the type of asynchronous outbound
packet. Like asynchronous outbound transaction packets, a pair of events
are added to trace initiation and completion of transmission.

In the case that the phy packet is sent by kernel API, the match between
the initiation and completion is not so easy, since the data of
'struct fw_packet' is allocated statically. In the case that it is sent by
userspace applications via cdev, the match is easy, since the data is
allocated per each.

This example is for Remote Access Packet by lsfirewirephy command in
linux-firewire-utils:

async_phy_outbound_initiate: \
  packet=0xffff89fb34e42e78 generation=1 first_quadlet=0x00148200 \
  second_quadlet=0xffeb7dff
async_phy_outbound_complete: \
  packet=0xffff89fb34e42e78 generation=1 status=1 timestamp=0x0619

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-cdev.c        |  7 +++++
 drivers/firewire/core-transaction.c |  6 ++++
 include/trace/events/firewire.h     | 48 +++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index 6274b86eb943..55993c9e0b90 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -35,6 +35,7 @@
 
 
 #include "core.h"
+#include <trace/events/firewire.h>
 
 /*
  * ABI version history is documented in linux/firewire-cdev.h.
@@ -1558,6 +1559,9 @@ static void outbound_phy_packet_callback(struct fw_packet *packet,
 	struct client *e_client = e->client;
 	u32 rcode;
 
+	trace_async_phy_outbound_complete((uintptr_t)packet, status, packet->generation,
+					  packet->timestamp);
+
 	switch (status) {
 	// expected:
 	case ACK_COMPLETE:
@@ -1655,6 +1659,9 @@ static int ioctl_send_phy_packet(struct client *client, union ioctl_arg *arg)
 		memcpy(pp->data, a->data, sizeof(a->data));
 	}
 
+	trace_async_phy_outbound_initiate((uintptr_t)&e->p, e->p.generation, e->p.header[1],
+					  e->p.header[2]);
+
 	card->driver->send_request(card, &e->p);
 
 	return 0;
diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index 0e49ebf52500..a828b7167d15 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -463,6 +463,8 @@ static DECLARE_COMPLETION(phy_config_done);
 static void transmit_phy_packet_callback(struct fw_packet *packet,
 					 struct fw_card *card, int status)
 {
+	trace_async_phy_outbound_complete((uintptr_t)packet, packet->generation, status,
+					  packet->timestamp);
 	complete(&phy_config_done);
 }
 
@@ -501,6 +503,10 @@ void fw_send_phy_config(struct fw_card *card,
 	phy_config_packet.generation = generation;
 	reinit_completion(&phy_config_done);
 
+	trace_async_phy_outbound_initiate((uintptr_t)&phy_config_packet,
+					  phy_config_packet.generation, phy_config_packet.header[1],
+					  phy_config_packet.header[2]);
+
 	card->driver->send_request(card, &phy_config_packet);
 	wait_for_completion_timeout(&phy_config_done, timeout);
 
diff --git a/include/trace/events/firewire.h b/include/trace/events/firewire.h
index d4688e341837..3ade7d4b9268 100644
--- a/include/trace/events/firewire.h
+++ b/include/trace/events/firewire.h
@@ -206,6 +206,54 @@ DEFINE_EVENT(async_outbound_complete_template, async_response_outbound_complete,
 #undef ASYNC_HEADER_GET_RCODE
 #undef QUADLET_SIZE
 
+TRACE_EVENT(async_phy_outbound_initiate,
+	TP_PROTO(u64 packet, unsigned int generation, u32 first_quadlet, u32 second_quadlet),
+	TP_ARGS(packet, generation, first_quadlet, second_quadlet),
+	TP_STRUCT__entry(
+		__field(u64, packet)
+		__field(u8, generation)
+		__field(u32, first_quadlet)
+		__field(u32, second_quadlet)
+	),
+	TP_fast_assign(
+		__entry->packet = packet;
+		__entry->generation = generation;
+		__entry->first_quadlet = first_quadlet;
+		__entry->second_quadlet = second_quadlet
+	),
+	TP_printk(
+		"packet=0x%016llx generation=%u first_quadlet=0x%08x second_quadlet=0x%08x",
+		__entry->packet,
+		__entry->generation,
+		__entry->first_quadlet,
+		__entry->second_quadlet
+	)
+);
+
+TRACE_EVENT(async_phy_outbound_complete,
+	TP_PROTO(u64 packet, unsigned int generation, unsigned int status, unsigned int timestamp),
+	TP_ARGS(packet, generation, status, timestamp),
+	TP_STRUCT__entry(
+		__field(u64, packet)
+		__field(u8, generation)
+		__field(u8, status)
+		__field(u16, timestamp)
+	),
+	TP_fast_assign(
+		__entry->packet = packet;
+		__entry->generation = generation;
+		__entry->status = status;
+		__entry->timestamp = timestamp;
+	),
+	TP_printk(
+		"packet=0x%016llx generation=%u status=%u timestamp=0x%04x",
+		__entry->packet,
+		__entry->generation,
+		__entry->status,
+		__entry->timestamp
+	)
+);
+
 #endif // _FIREWIRE_TRACE_EVENT_H
 
 #include <trace/define_trace.h>
-- 
2.43.0


