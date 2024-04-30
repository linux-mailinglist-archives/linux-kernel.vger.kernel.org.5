Return-Path: <linux-kernel+bounces-163178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C168B66CF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 02:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E130F2831B6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 00:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C1E4C8B;
	Tue, 30 Apr 2024 00:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="j6fLsFqN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lq5o/44I"
Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901D410E4
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 00:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714436055; cv=none; b=ujr1m+rWT04WWNElyfBxG++OP5wg2OUjS9x7sGRgfI8IjJQjFXLyPXmy6VSjZAYfxU0l2XRpy3fv9D2lNYn77LUlS+HpeNPvEahSJIo7PKEEat5qyPrVsnM9VYritDTfga3s2BY5G+QymkEatyZgEsFxm13FEIbYYovsrFLVZIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714436055; c=relaxed/simple;
	bh=f7J7AByp16lTNUyKN3w2Z+wIhLTVdjiRSQubEzdIp2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P1JPl1e0WB6ZZ6QFqz5xHx5ohfYBUkDzM6RIdquuLY+/7RodfRFqj+ZOMa97hg4rOMr5MdPyRpW0/fvPe8rRiAu9Zt9+Tamt29Ek/JWGvIam0YOZ4czLF9wlxYWZ3Q4OnqRT2kQNmAdUSWIjYXLF+/F6ZblsCIVU5GM9Rpk2DmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=j6fLsFqN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lq5o/44I; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id A4FAE1C00139;
	Mon, 29 Apr 2024 20:14:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 29 Apr 2024 20:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1714436052; x=
	1714522452; bh=Tp122UnR3pnsKSGpowqnjXWFjoFKONpXEM4cHTo76o0=; b=j
	6fLsFqNSmkHgAwtQtHhdEUXfpMCc1/fp5Oj0fTo5C5VPD3AZcgw90C5c07yp9dsv
	yHhdPdXik6EerF4dnoO8pu1of77RN8CGBDkgBMURu48hR0/Rz2SYC3fIQczGx1ui
	h1qDp63X+hq72ETsLiB/nyLd7ZxNsXd+KvcRBO9Rsmk36IgUej8dTqNEK0TVrMkB
	6ilaBJfOC+dvXRdTQTJMvpPpFLn9TD9dtF/ohos1BO4e7pgESFLgJX5wGfJsjdje
	Rm8eG8j76J9z4x4PiOdVepYCN2mT65zocQJmnY4rrYb0omve7VRSI3sWh37TApfx
	5VJmslt93+8XvLGDmhmWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714436052; x=
	1714522452; bh=Tp122UnR3pnsKSGpowqnjXWFjoFKONpXEM4cHTo76o0=; b=L
	q5o/44Ig6XzllntaVdiLyc8Ed3SlU5iXugfIFBL6Zc+IrTZwC++hGpeFjUATDfuk
	NIivjMPHHEudDPA96k95u16AV4+EK2tDw2aJRH/sEmgVl+rS+33Xw54UPQYK/xu5
	40K5dcW8TuSzP9JXDUubHislsaYPrFxveaN5cS1PlZkVZwYQUuan7eFvzoKFndHk
	Xmr5dHU/HERcptorsNe5rHkOyVCMnNdOj8paI3rVqfcUqKlb411HbKOD+o6UCHkl
	dTpQflzSpv3AdNAekis1bDsZm+apy0Yn1S2ojWMlv+VsUF9RHMmRJMbGExqzEwPG
	xL6eaDI+0TQdyS4ePu+7Q==
X-ME-Sender: <xms:0zcwZvst1t87p-coPKYkONsvBhh2lrBGDaNBuVej-2287PUSdG-JOg>
    <xme:0zcwZgcy2xAcvKVC5gyqAqtZEXBJbw81qYanPcRI2BJ0x8-7SJ6drwN0jXUoZd6oF
    -m2a__7g83S4v9lacY>
X-ME-Received: <xmr:0zcwZizvGkSYeyBJZX5_ce4Ygx_y_1mUOV0YeOcT2EOmMPsfF5LxNNmxks8_tmHjnST4tTUquTj0qsh8uxJNXIiSJ8iWvqfuaN7IEyZSZpK62A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduvddgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:0zcwZuPJzBsV58UgyENtQnzvGyg2JreK6mSgmE5PKftyR3xnKRQbHg>
    <xmx:0zcwZv-rGwdYXYTH0oi9g1oG5qZa_klZHLnvXfoBmJtPKPIwLF-zpw>
    <xmx:0zcwZuXxSRXVaOwIxBKnFDs1trZcxprEQLXHKwj0C6G80sRzarkygQ>
    <xmx:0zcwZgdOiYekWWdMHJxrXPf2kSJL88d1b2owtH9KeLq2teWhrJ7eZA>
    <xmx:1DcwZhKaChQzmBaRlm6RqvWNuZHTV4UnZw_KybxcCcv4d9NYqyO8QlEH>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 20:14:10 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] firewire: core: add tracepoints event for asynchronous inbound phy packet
Date: Tue, 30 Apr 2024 09:14:04 +0900
Message-ID: <20240430001404.734657-3-o-takashi@sakamocchi.jp>
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

At the former commit, a pair of tracepoints events is added to trace
asynchronous outbound phy packet. This commit adds a tracepoints event
to trace inbound phy packet. It includes transaction status as well as
the content of phy packet.

This is an example for Remote Reply Packet as a response to Remote Access
Packet sent by lsfirewirephy command in linux-firewire-utils:

async_phy_inbound: \
  packet=0xffff955fc02b4e10 generation=1 status=1 timestamp=0x0619 \
  first_quadlet=0x001c8208 second_quadlet=0xffe37df7

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-transaction.c |  2 ++
 include/trace/events/firewire.h     | 30 +++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index a828b7167d15..d3eefbf23663 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -995,6 +995,8 @@ void fw_core_handle_request(struct fw_card *card, struct fw_packet *p)
 
 	tcode = async_header_get_tcode(p->header);
 	if (tcode_is_link_internal(tcode)) {
+		trace_async_phy_inbound((uintptr_t)p, p->generation, p->ack, p->timestamp,
+					 p->header[1], p->header[2]);
 		fw_cdev_handle_phy_packet(card, p);
 		return;
 	}
diff --git a/include/trace/events/firewire.h b/include/trace/events/firewire.h
index 3ade7d4b9268..db49b9828bd1 100644
--- a/include/trace/events/firewire.h
+++ b/include/trace/events/firewire.h
@@ -254,6 +254,36 @@ TRACE_EVENT(async_phy_outbound_complete,
 	)
 );
 
+TRACE_EVENT(async_phy_inbound,
+	TP_PROTO(u64 packet, unsigned int generation, unsigned int status, unsigned int timestamp, u32 first_quadlet, u32 second_quadlet),
+	TP_ARGS(packet, generation, status, timestamp, first_quadlet, second_quadlet),
+	TP_STRUCT__entry(
+		__field(u64, packet)
+		__field(u8, generation)
+		__field(u8, status)
+		__field(u16, timestamp)
+		__field(u32, first_quadlet)
+		__field(u32, second_quadlet)
+	),
+	TP_fast_assign(
+		__entry->packet = packet;
+		__entry->generation = generation;
+		__entry->status = status;
+		__entry->timestamp = timestamp;
+		__entry->first_quadlet = first_quadlet;
+		__entry->second_quadlet = second_quadlet
+	),
+	TP_printk(
+		"packet=0x%016llx generation=%u status=%u timestamp=0x%04x first_quadlet=0x%08x second_quadlet=0x%08x",
+		__entry->packet,
+		__entry->generation,
+		__entry->status,
+		__entry->timestamp,
+		__entry->first_quadlet,
+		__entry->second_quadlet
+	)
+);
+
 #endif // _FIREWIRE_TRACE_EVENT_H
 
 #include <trace/define_trace.h>
-- 
2.43.0


