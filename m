Return-Path: <linux-kernel+bounces-161726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B11988B5036
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75179281115
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 04:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2F0C8E2;
	Mon, 29 Apr 2024 04:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="J8ZEgBcr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KIcrUOg1"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1558A32
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 04:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714365147; cv=none; b=htQMaLOhYRZor/fOUT75YzHMJ4TCbVsWoqR1irGYzl8hRrpsQ7KqZs0DIKvVRdCUPOSZGr5IXWB108PQ1PLHwQ/mIKR+kDbogDZ7KfoW5RjgHOpN0Z5J1/7381Rotm+o+eBx08QglyCMi0M6gf4RYEAS+0QyFNU/1OlOG0Y1fEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714365147; c=relaxed/simple;
	bh=BYNytHz/VtV9EIiOMZGUojlxT11Q0sFg43HjDNrVvsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TH1fKI/2PsTA5q10Lt4/7r0Sq/vfh9iGLORTtpSgFd0kM91q+UHB51s/V2lyj3G4YwvBM0AI5GErE2fZ3m+fjtsEOEl9pouy1Cjv/FTRfNwRakNxK9RW2cXxcTyZYj/EfCyax22lDCNIvB8ay/1bNxXotVsX6FiAlvQU7jnjoHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=J8ZEgBcr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KIcrUOg1; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id B5A061380221;
	Mon, 29 Apr 2024 00:32:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 29 Apr 2024 00:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1714365144; x=
	1714451544; bh=8x1ayh0rdEcHJ/0K+RxhHA07RKEwCYeuO2LAWr/frNA=; b=J
	8ZEgBcrwRhO8sLViLhketzlN+StkEwk97LCKZ/NoL/RLQBCni8AivV99eS5spyzz
	XjMl8IMn28zdp4B5nn1QFUv66sQvqcJUiFNr+Kh4WQTa8EM4T1v9uYU2NhHV5hH+
	XyUYM5NSz4adV9Q06ZiZ0ncttpcgg++ddBIo+8b0kxydIqKSYVOcHMbQBKXQLdRI
	2xY9K8v6Kcc6wTak2ng2qQJOgZEQcii4d7DVufcuFR5+TphhwRPByYMwvaGkjqt6
	RcjS631pZ8DyeV/nanK84jSw1yHoafd/t8N/1IxCqrHBcm/J8/t2Yy3rHFzai9q8
	9CyKXZmv/VdcAVYzPEJeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714365144; x=
	1714451544; bh=8x1ayh0rdEcHJ/0K+RxhHA07RKEwCYeuO2LAWr/frNA=; b=K
	IcrUOg1rK1jO4pZNtc8rmnaTx/ECBBEzytM/P9aH6xfPK2ecD8eRNdMxfeAKpdCM
	U0UjlOp6n9C7MWT9euyjYVmrxstC07RgUKfD2nLCfeDmQ6UB9y3K9nOD05dz89eY
	5JWZlUQE1a9GZwL6k8YpNPeuQYJ+SIsq12oZxglIBphA16q2fTwq3QpMH3i4IanR
	MBKLHlzFEjprXJ3PqfddDnLkD9w468OuzkwIC1lY95YEIQz2BoJ9Fe64XyEfxjSR
	9qrAvbf/Ca1RRqYrbNSWjaGKigtrx5EijDcF1sBAc522jZ1TZyr53NDKxOKhOJoP
	wbkRJm4qMYSzb3Ec/8P9Q==
X-ME-Sender: <xms:2CIvZjTGW16oHoa_2OhRxOkF461kbjpoSB3IahnpovO2DaiVn8ak4Q>
    <xme:2CIvZkw4DLnxUkGHztz8MerwAG3FLAufcqU1gosf1CZNB1GxggWZ67EmEYy8rWP-a
    GjY2-tFY-I6eR2jxRA>
X-ME-Received: <xmr:2CIvZo2YOIpjSRIGxymU4L6nSQnI7lUbb5VgfUeVcFQGi4SELOH3S56yKZI1yFLz5by1_lOpRAfb0nlfk8v47iySKDuHUI-EtlJ43wTjgsroOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtledgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:2CIvZjAOB-CqyhxaodiYNYLMnRZWfXunUZn6rTf_liql0SpU7qgOng>
    <xmx:2CIvZsjuQ6o3bnJ-SQW3IAIauX_wqwevbEg6jwrlylNe1Z5flc5jEw>
    <xmx:2CIvZnr3upjF0AmnFukqQacsTdoRwZBTH75T8YfbTUXiqlXP1MJ8mA>
    <xmx:2CIvZniMCGWUuUho70FpnnjoFxMBRmW8OIVf0_rS-yGee5sbT-80Wg>
    <xmx:2CIvZvsMw5tlt6hS2h4lw0EJTcQgTRe_S5w6NekVAano8JBg5HQT-Nf4>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 00:32:23 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] firewire: core: add support for Linux kernel tracepoints
Date: Mon, 29 Apr 2024 13:32:14 +0900
Message-ID: <20240429043218.609398-2-o-takashi@sakamocchi.jp>
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

The Linux Kernel Tracepoints framework is enough useful to trace
packet data inbound to and outbound from core.

This commit adds firewire subsystem to use the framework.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/Makefile       |  2 +-
 drivers/firewire/core-trace.c   |  5 +++++
 include/trace/events/firewire.h | 15 +++++++++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firewire/core-trace.c
 create mode 100644 include/trace/events/firewire.h

diff --git a/drivers/firewire/Makefile b/drivers/firewire/Makefile
index bbde29a0fba6..013e1f2641bd 100644
--- a/drivers/firewire/Makefile
+++ b/drivers/firewire/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the Linux IEEE 1394 implementation
 #
 
-firewire-core-y += core-card.o core-cdev.o core-device.o \
+firewire-core-y += core-trace.o core-card.o core-cdev.o core-device.o \
                    core-iso.o core-topology.o core-transaction.o
 firewire-ohci-y += ohci.o
 firewire-sbp2-y += sbp2.o
diff --git a/drivers/firewire/core-trace.c b/drivers/firewire/core-trace.c
new file mode 100644
index 000000000000..96cbd9d384dc
--- /dev/null
+++ b/drivers/firewire/core-trace.c
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright (c) 2024 Takashi Sakamoto
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/firewire.h>
diff --git a/include/trace/events/firewire.h b/include/trace/events/firewire.h
new file mode 100644
index 000000000000..bc55eaabf695
--- /dev/null
+++ b/include/trace/events/firewire.h
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright (c) 2024 Takashi Sakamoto
+
+#define TRACE_SYSTEM	firewire
+
+#if !defined(_FIREWIRE_TRACE_EVENT_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _FIREWIRE_TRACE_EVENT_H
+
+#include <linux/tracepoint.h>
+
+// Placeholder for future use.
+
+#endif // _FIREWIRE_TRACE_EVENT_H
+
+#include <trace/define_trace.h>
-- 
2.43.0


