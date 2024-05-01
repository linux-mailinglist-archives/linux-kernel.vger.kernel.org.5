Return-Path: <linux-kernel+bounces-164993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1202A8B8624
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EC3D1F226DE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CCC50288;
	Wed,  1 May 2024 07:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="Wde8Sqka";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QZVlLWT3"
Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77724F897
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 07:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714548803; cv=none; b=n2BpVAlXtyChpP9RZlnir/0gnXKu2y8Mf+1Qj9Rtd+ypyvtcSYEq7fJ6BJjMS4uVyrVXUAjmKtlbTHmMevBLPUgvbYqGX4+KFpYuz9S3+YySv4tjkT60Jufgi5WZ94H9RCse6hz+AYxTrGDAFmiiqAahHSeEuWeSlJWaGUgw2Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714548803; c=relaxed/simple;
	bh=L/nIJ0NVg0scqGPi6YtPzjqXDmqeoi/bV5TK/tjXfLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tjrjt9FYqzF7GHKkRurAz5K3RHWcJ4y3KC5ufjfI0Fj05ytsu666uE9N21Ilj9fYmN5oiFR8pAEXe9qezMbOK43NPWml7gCdpkiDmrN5MVpqmCUymETKs8n4tpf3wOyRGR8h64v4EkpTISuBecJvDPrp8UWt9/3HhUunC0ZHVi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=Wde8Sqka; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QZVlLWT3; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id CACED1C000F0;
	Wed,  1 May 2024 03:33:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 01 May 2024 03:33:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1714548800; x=
	1714635200; bh=UXhYUUuJV5tMvW12H0m4FPip2YTr/sl2Xn2dSZa5qW8=; b=W
	de8Sqkafz1D2bcq4aia9vDn7yU0eNXX/hQjOnVxmu91+kCed+Z6edaikvFfcv7U4
	enzsgP+8Em+EJ16x0AET+sJAE+/B/EZXZA/39xlEznBsQ2Wfy3ZV/6GVDqx1Vm4d
	CcPX/wf6TMyk/KqZHz+F0lTIRwoqYEFEY+TzQrjP6gCbpHQMpnDPYUfwV6d3Oca4
	mU04Kzu6fQKH54L8bFWbUDOGpdG+8Mx8qiAYGW3+dYtxno+B+zWRnG+I7ijYDifQ
	X2bON+OncH6ILVKcLB9gIT9sTp5m9LPuRSOydEZFs+gMeZcXeCMXsfaQh9xqbQ5s
	4kholFG914roWyPx6BBYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714548800; x=
	1714635200; bh=UXhYUUuJV5tMvW12H0m4FPip2YTr/sl2Xn2dSZa5qW8=; b=Q
	ZVlLWT3oRZfRecIvSrMN9h3fc3JL2J84d6lkP6eceMVYpaz1GuiEvkMzditprYn+
	sC33K5+v0KbyYz8twHUH2zUdSJVltIKq74lMHjjsiBiRP6UR11xAaxu2aAPF6HcT
	Y4vgKUf7HkeIKljGInNhm7SnmQwpXwLyof0ijiccYynBFHF+7vJKGdcjVZVmlR49
	gAk+RTd2Kf1GBD+ZX3UjgbeXHpfP3S7ImpSqbs7Q15T2NbEiRX0S4fFRSuWaxI+C
	+HJMbofd7kPuz2F8TOT+oL+8sNdyPco0uLwq7H/eQftlx151GV8iaClO7JBrDsBk
	aaMULPcsk8Ga2dg7Dgbfg==
X-ME-Sender: <xms:QPAxZlnr_pAmOpwqj4xX1eOg7hSfuzsxzar6e_ubl5f541OR-625Bg>
    <xme:QPAxZg1H_i-UBOQgcvwN5mw10IAKu8ZVZLXK2zoykN494zQhxw5_gBsdANzGPjjio
    vhNod2YY7X6Sr2F9jk>
X-ME-Received: <xmr:QPAxZrpGdqBqtKFkO1x2flPbAw9FUronVaRS8OhsWcSoEm6IwgVrc1sIBmI4wkxE95eTZUnwy2z5AjBmxoWYprZHDHHBJUbp1kZ0AOltb0_DmsM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduhedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:QPAxZlmlQlrXK8r2EtC1-KR_WfebCuHBG8fDoT7a56qMe9FVTwcJHA>
    <xmx:QPAxZj0hPiceHd0FvXrzuHXC1KsjqRuWNmYgKDcHrBnzuGnuuSoh8g>
    <xmx:QPAxZkuRc5KY0zZymmDMnQzYbJXhdGoOdUbQtJSvszo_4RpUAfMPpg>
    <xmx:QPAxZnXQf50xSPy96YuG_kCuNnEGzK-pH-fttRo8O3mYq1M1vZuh3Q>
    <xmx:QPAxZky1oiLdOnK-W7du4HHVcorMlpL4csIDptiJYtyI1JM3iaIZkHJB>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 May 2024 03:33:19 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	adamg@pobox.com
Subject: [PATCH 5/5] firewire: core: add tracepoint event for handling bus reset
Date: Wed,  1 May 2024 16:32:38 +0900
Message-ID: <20240501073238.72769-6-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240501073238.72769-1-o-takashi@sakamocchi.jp>
References: <20240501073238.72769-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The core function expects hardware drivers to call
fw_core_handle_bus_reset() when changing bus topology. The 1394 OHCI
driver calls it when handling selfID event as a result of any bus-reset.

This commit adds a tracepoints event for it.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-topology.c |  3 +++
 include/trace/events/firewire.h  | 28 +++++++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-topology.c
index f40c81534381..837cc44d8d9f 100644
--- a/drivers/firewire/core-topology.c
+++ b/drivers/firewire/core-topology.c
@@ -20,6 +20,7 @@
 #include <asm/byteorder.h>
 
 #include "core.h"
+#include <trace/events/firewire.h>
 
 #define SELF_ID_PHY_ID(q)		(((q) >> 24) & 0x3f)
 #define SELF_ID_EXTENDED(q)		(((q) >> 23) & 0x01)
@@ -507,6 +508,8 @@ void fw_core_handle_bus_reset(struct fw_card *card, int node_id, int generation,
 	struct fw_node *local_node;
 	unsigned long flags;
 
+	trace_bus_reset_handle(generation, node_id, bm_abdicate, self_ids, self_id_count);
+
 	spin_lock_irqsave(&card->lock, flags);
 
 	/*
diff --git a/include/trace/events/firewire.h b/include/trace/events/firewire.h
index 92bcbe69bb42..4163959be57a 100644
--- a/include/trace/events/firewire.h
+++ b/include/trace/events/firewire.h
@@ -204,7 +204,6 @@ DEFINE_EVENT(async_outbound_complete_template, async_response_outbound_complete,
 #undef ASYNC_HEADER_GET_SOURCE
 #undef ASYNC_HEADER_GET_OFFSET
 #undef ASYNC_HEADER_GET_RCODE
-#undef QUADLET_SIZE
 
 TRACE_EVENT(async_phy_outbound_initiate,
 	TP_PROTO(u64 packet, unsigned int generation, u32 first_quadlet, u32 second_quadlet),
@@ -317,6 +316,33 @@ DEFINE_EVENT(bus_reset_arrange_template, bus_reset_postpone,
 	TP_ARGS(generation, short_reset)
 );
 
+TRACE_EVENT(bus_reset_handle,
+	TP_PROTO(unsigned int generation, unsigned int node_id, bool bm_abdicate, u32 *self_ids, unsigned int self_id_count),
+	TP_ARGS(generation, node_id, bm_abdicate, self_ids, self_id_count),
+	TP_STRUCT__entry(
+		__field(u8, generation)
+		__field(u8, node_id)
+		__field(bool, bm_abdicate)
+		__dynamic_array(u32, self_ids, self_id_count)
+	),
+	TP_fast_assign(
+		__entry->generation = generation;
+		__entry->node_id = node_id;
+		__entry->bm_abdicate = bm_abdicate;
+		memcpy(__get_dynamic_array(self_ids), self_ids, __get_dynamic_array_len(self_ids));
+	),
+	TP_printk(
+		"generation=%u node_id=0x%04x bm_abdicate=%s self_ids=%s",
+		__entry->generation,
+		__entry->node_id,
+		__entry->bm_abdicate ? "true" : "false",
+		__print_array(__get_dynamic_array(self_ids),
+			      __get_dynamic_array_len(self_ids) / QUADLET_SIZE, QUADLET_SIZE)
+	)
+);
+
+#undef QUADLET_SIZE
+
 #endif // _FIREWIRE_TRACE_EVENT_H
 
 #include <trace/define_trace.h>
-- 
2.43.0


