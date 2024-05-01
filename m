Return-Path: <linux-kernel+bounces-164991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D75A8B8622
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA6E01C2124F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12284F217;
	Wed,  1 May 2024 07:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="V0XNnrNS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UKRtw/Ja"
Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B0B4DA11
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 07:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714548798; cv=none; b=kNo6AmoWsgmA0jOXdxIRTEjLpbZTZblTDYvqSzAELSMF7PiSrKLJgb39kW3CwXk0/+AjRpo9N+rgi6/83KyCsCyDuuDQAy7T2iCGGFRTCR1ONPc1Du59iwyFBAbzo1i0ogMBTLX7qPXeX1QLUO7g7aRY8EGjIQSozT4it04FmDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714548798; c=relaxed/simple;
	bh=ctq6B38b/c7LjB8JdPauG3pA68DVu0dZQ8/1LoUMRXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gxord4kEGmGgFtw8eiYaOYNLoIhBZ5CfN4vICFi1MxS7070jDQcveYy55BYa6pyvYXFeboHFwA2dUrJO0iC24gScMwl1ZIeE51ijngv4n3kqlJFgrOas2Rg4rZrNd1f59gZnYUSnlxnz+n6On7orkOR3xwBhQL4pg31q7UE19s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=V0XNnrNS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UKRtw/Ja; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 415831800113;
	Wed,  1 May 2024 03:33:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 01 May 2024 03:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1714548795; x=
	1714635195; bh=3et/NwBVInRkKPuHxHe5wh8LNXDVK91DOcQrlzNNZd0=; b=V
	0XNnrNSwzWxyo8m1w4sguAKtA5S/Bm74mH4LsLVw9dlXjJOeYINWNJhBM6h4t+V2
	cUAFkePakBWZpWALgN9IHsKtZ1quW8vyLZHZ9QZAMXgSvVWWGLT+btoYaTNz0OkT
	UExdQHVStUdUuT5Ikt4YVeY3vdAubONyK7S4sUivglNc45LaRg0yeqs4P0AE05KW
	JK7P40EpJPgr7lWKE7/Ybfr4lwizPPz30YeB4ryWwGEoWB7OwBlN2MeP1Utspf1a
	Wq1C3/Nei9o6dnhgL3o5CN2z8UakiEC0jRCrbAD9ebaF/58xY+gRrK85x7D0ueoE
	HCWi03EQsf/On8p0x7w2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714548795; x=
	1714635195; bh=3et/NwBVInRkKPuHxHe5wh8LNXDVK91DOcQrlzNNZd0=; b=U
	KRtw/JaauZI7UP43GUzBAYaLO47enOH4bxivCUQaeuVOr2JrPlBbHnWbLu76bHQ3
	kwTxLldZRBGQwhxTl4hR1hIP2AzpcFzoozaCUpWaFYZy7aomjkm1HE+ZcYOY4Wa/
	hr1cQky3AtvNs7gkusb1Pclatv0H9TDkaRvCicYeJdFdexSu3JrmhMWgXqn15k3D
	bS9pkC5hKADzLwAbmhQiCjc1Ru4wfVwnm4Dd0E5egaQi1E0ToaW/dzEcnGXWhVdK
	AmBiNu8LJy783M2a2FI/X4Yim1lqNi2Pw+F7iKyebul27KcQoE15Sp7tdAvB3rfI
	4H/c8UzhobfSgyq1rPYzQ==
X-ME-Sender: <xms:O_AxZgmZEGbx4PSyM492TkcsnD6Dbx1njfqNwjnoJBXYC6udJMYi3g>
    <xme:O_AxZv1a0YiUqGpSJIJWvi_SRFd1TpK2asrMQ1pC1cMiHEdW4Z6azqxmpYhA4qp3j
    fjaVWFR5pUc0kCUKHw>
X-ME-Received: <xmr:O_AxZupjf5dqlRrqU1Z7K0r58eGPd6aoLIdBHBqgEWCh0pcmj_YH-vK7zSJp4ffm1NIYLAeqc2xfX5Y8gPL8bqheEJM7CSmCgob_kjOwHHKfMfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduhedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:O_AxZskynUHMi9IcK6rO6uND_-G4d9S52Mbf9_nmNU2oQl1O9bUNsg>
    <xmx:O_AxZu35HoeYZzLnPM8Q6EKCSC0KV4sY4OqZLkF81XNasPMJJ7pTRw>
    <xmx:O_AxZjv0HcpjbSYePqBQH969-xpgxxMvPFXYwJ3jN9C6i2YaoW46Lg>
    <xmx:O_AxZqWQL7swICdUrWibPwsYl9ah5BVuHKu6HpUsLk2UoTs3MtQ9-A>
    <xmx:O_AxZjyGvH-NHVnXWxKal9Z3O7_E6apjO1pP0GioJGpO3-LSw4xo3Fw_>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 May 2024 03:33:14 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	adamg@pobox.com
Subject: [PATCH 3/5] firewire: core: add tracepoints events for initiating bus reset
Date: Wed,  1 May 2024 16:32:36 +0900
Message-ID: <20240501073238.72769-4-o-takashi@sakamocchi.jp>
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

At a commit 673249124304 ("firewire: core: option to log bus reset
initiation"), some kernel log messages were added to trace initiation of
bus reset. The kernel log messages are really helpful, while nowadays it
is not preferable just for debugging purpose. For the purpose, Linux
kernel tracepoints is more preferable.

This commit adds some alternative tracepoints events.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-card.c    |  7 +++++++
 include/trace/events/firewire.h | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/firewire/core-card.c b/drivers/firewire/core-card.c
index dac1b0fc7a42..5d43acf45a7d 100644
--- a/drivers/firewire/core-card.c
+++ b/drivers/firewire/core-card.c
@@ -23,6 +23,7 @@
 #include <asm/byteorder.h>
 
 #include "core.h"
+#include <trace/events/firewire.h>
 
 #define define_fw_printk_level(func, kern_level)		\
 void func(const struct fw_card *card, const char *fmt, ...)	\
@@ -221,6 +222,8 @@ static int reset_bus(struct fw_card *card, bool short_reset)
 	int reg = short_reset ? 5 : 1;
 	int bit = short_reset ? PHY_BUS_SHORT_RESET : PHY_BUS_RESET;
 
+	trace_bus_reset_initiate(card->generation, short_reset);
+
 	if (unlikely(fw_core_param_debug & FW_CORE_PARAM_DEBUG_BUSRESETS))
 		fw_notice(card, "initiating %s bus reset\n",
 		          short_reset ? "short" : "long");
@@ -230,6 +233,8 @@ static int reset_bus(struct fw_card *card, bool short_reset)
 
 void fw_schedule_bus_reset(struct fw_card *card, bool delayed, bool short_reset)
 {
+	trace_bus_reset_schedule(card->generation, short_reset);
+
 	if (unlikely(fw_core_param_debug & FW_CORE_PARAM_DEBUG_BUSRESETS))
 		fw_notice(card, "scheduling %s bus reset\n",
 		          short_reset ? "short" : "long");
@@ -252,6 +257,8 @@ static void br_work(struct work_struct *work)
 	/* Delay for 2s after last reset per IEEE 1394 clause 8.2.1. */
 	if (card->reset_jiffies != 0 &&
 	    time_before64(get_jiffies_64(), card->reset_jiffies + 2 * HZ)) {
+		trace_bus_reset_postpone(card->generation, card->br_short);
+
 		if (unlikely(fw_core_param_debug & FW_CORE_PARAM_DEBUG_BUSRESETS))
 			fw_notice(card, "delaying bus reset\n");
 		if (!queue_delayed_work(fw_workqueue, &card->br_work, 2 * HZ))
diff --git a/include/trace/events/firewire.h b/include/trace/events/firewire.h
index db49b9828bd1..92bcbe69bb42 100644
--- a/include/trace/events/firewire.h
+++ b/include/trace/events/firewire.h
@@ -284,6 +284,39 @@ TRACE_EVENT(async_phy_inbound,
 	)
 );
 
+DECLARE_EVENT_CLASS(bus_reset_arrange_template,
+	TP_PROTO(unsigned int generation, bool short_reset),
+	TP_ARGS(generation, short_reset),
+	TP_STRUCT__entry(
+		__field(u8, generation)
+		__field(bool, short_reset)
+	),
+	TP_fast_assign(
+		__entry->generation = generation;
+		__entry->short_reset = short_reset;
+	),
+	TP_printk(
+		"generation=%u short_reset=%s",
+		__entry->generation,
+		__entry->short_reset ? "true" : "false"
+	)
+);
+
+DEFINE_EVENT(bus_reset_arrange_template, bus_reset_initiate,
+	TP_PROTO(unsigned int generation, bool short_reset),
+	TP_ARGS(generation, short_reset)
+);
+
+DEFINE_EVENT(bus_reset_arrange_template, bus_reset_schedule,
+	TP_PROTO(unsigned int generation, bool short_reset),
+	TP_ARGS(generation, short_reset)
+);
+
+DEFINE_EVENT(bus_reset_arrange_template, bus_reset_postpone,
+	TP_PROTO(unsigned int generation, bool short_reset),
+	TP_ARGS(generation, short_reset)
+);
+
 #endif // _FIREWIRE_TRACE_EVENT_H
 
 #include <trace/define_trace.h>
-- 
2.43.0


