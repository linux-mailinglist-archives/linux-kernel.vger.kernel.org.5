Return-Path: <linux-kernel+bounces-149797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F828A95F7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B72A41F22547
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857D015E1EA;
	Thu, 18 Apr 2024 09:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="cVzmE+6p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FNxU8BAO"
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092DF15CD76
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 09:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713432202; cv=none; b=WDiGD/0ibfL1wJ3kP+Atm3HmCAeQeT9RT66MeS2kaaEe1VWe9sURWkFcqjj6dDB5SVW8PpRLO5p5tcx7YwDK3i/O8BfdkHy+8UIvT/7Zgnd8xOw+r65ZPNZu63Ywyn6w8RFf3yp7NSEOJzLfdnY93mGrQLMr58HV9lope7hXFLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713432202; c=relaxed/simple;
	bh=uTOfGq0h6+lnuHB1WN07O0CMmN/tHW246Cg9evlPFmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ky6IC7Lz6SJZjJ+FNwXV2EMqoyqYC5dciw/x/ZHIMz8MS6li+mpTOrflVhtyZj3bgM0IJxQKtITzSN0e6W7ynLwQx1tLpffpFfB5vOsBCUakXT5yuvMqa7hnAEkqZ+RB3GySMNx6MEcAUQU10+ZE0M5Rfd7Q19FPMYR6kMwKFy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=cVzmE+6p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FNxU8BAO; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2169111400F6;
	Thu, 18 Apr 2024 05:23:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 18 Apr 2024 05:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1713432200; x=
	1713518600; bh=I8JF/lc0fwY+8HUxUwF74jT5UxEyTs7wRVVyo2OzKhg=; b=c
	VzmE+6p60aLdEBC73ImhLsE0bhZv6wPyQLbSjxY9N5/JIhIsEZKgBOakVwR5n7+Y
	v1GROfYVXqsSGe1qK3hkm1IWf7lXtf8tGabpVxiCD0a2MgedIJq9eWG+tJ6rTebi
	lU2KiXKs7LrMWEgHqRpIZEeA160bJ8k5p2eduPv19w4sQ4RK2BmD3C1XzpS7GSA/
	jYhEjfeVrDa9IqOlGC1pdr/Qmr+3GG6CXpKsjdiyWY/lfLR9vxSWZBj1alO+WzmO
	roWxSRC/qBO7zZwIlKe2dN578ftEupuGrSFVSx9G9vjbzp0pQUVfkvYKdU/V1HBS
	jVPSGCiGHdYyB/5oivrkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1713432200; x=
	1713518600; bh=I8JF/lc0fwY+8HUxUwF74jT5UxEyTs7wRVVyo2OzKhg=; b=F
	NxU8BAO9nyZIwT1e7f0ujBthRff7xUmLgItgICiS3jln6fqvjCIUxwXxXNHD8fRk
	lfmbdA+M2sI4dwXtcHEvJu8TSuYTWzAeAAsVQjHCuERy6qqc/dIv06JcdQc6B8aX
	ur3zss6X5APx6ocSmid/uuaOAsgrek+Y2pJ/d7nypD+Q+LcL930PSK48zGdtA/83
	E8PsnqS80c6/+RVI5dRvUd06VeTA+wwYPZuYRrC3kYmjokOymLh61wH3H0KCzx2j
	0PVyR7wejin8lgUTrAvYZdONlYM57RmXMhJZRLqN4zfX7vDeH97wWonGv+hNlxpr
	UBsmDNpF5+hFge7mB/HKw==
X-ME-Sender: <xms:h-YgZoCfnVQoDA19oqqICd_nGJNMEIlSvvxclMwqvVFEMcLi6BJqwA>
    <xme:h-YgZqgFYPZZMzQkHrvfcvF6Oox5QoCSVaoYmsVwxhnt8u4rgBsCdBzYmM7EOU7Ur
    ju5jd9Jzyp8kZa0_Zw>
X-ME-Received: <xmr:h-YgZrmwNwo1QhLfCeiDs5_Nfm0ma8h9CNRqGGnIIJErc0ae34GRIbVsicf18h_g0rdb_S37MxZh-DFI6UHaEmkeKBJuBU0hxLfiajSvMU55vA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudektddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:h-YgZuzg6_-KElappZdKrzW9JlTOaPHjQyYbtkX9-T5-J0m4u-gR6Q>
    <xmx:h-YgZtSQViEOOcBamlkgOgN3ALjSxpQgrNuZtYAwrETjp0pxM-M0eg>
    <xmx:h-YgZpa-UNSDVMfqoGhd337X6qt6Gcnw6O1mODJqHTR52_Go3jpNTQ>
    <xmx:h-YgZmR7gSrQp1joI_CPBFvteRwZClzFE9YcROZqWXeATKQ0ombBbA>
    <xmx:iOYgZodki2dy5YFEtsE4L5pyg5zH5nxdDshrAzjjb0YfCXEYppEF-BsC>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Apr 2024 05:23:18 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 09/13] firewire: core: add support for Linux kernel tracepoints
Date: Thu, 18 Apr 2024 18:22:59 +0900
Message-ID: <20240418092303.19725-10-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240418092303.19725-9-o-takashi@sakamocchi.jp>
References: <20240418092303.19725-1-o-takashi@sakamocchi.jp>
 <20240418092303.19725-2-o-takashi@sakamocchi.jp>
 <20240418092303.19725-3-o-takashi@sakamocchi.jp>
 <20240418092303.19725-4-o-takashi@sakamocchi.jp>
 <20240418092303.19725-5-o-takashi@sakamocchi.jp>
 <20240418092303.19725-6-o-takashi@sakamocchi.jp>
 <20240418092303.19725-7-o-takashi@sakamocchi.jp>
 <20240418092303.19725-8-o-takashi@sakamocchi.jp>
 <20240418092303.19725-9-o-takashi@sakamocchi.jp>
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
 drivers/firewire/Makefile |  5 ++++-
 drivers/firewire/trace.c  |  5 +++++
 drivers/firewire/trace.h  | 17 +++++++++++++++++
 3 files changed, 26 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firewire/trace.c
 create mode 100644 drivers/firewire/trace.h

diff --git a/drivers/firewire/Makefile b/drivers/firewire/Makefile
index bbde29a0fba6..92376e045805 100644
--- a/drivers/firewire/Makefile
+++ b/drivers/firewire/Makefile
@@ -3,12 +3,15 @@
 # Makefile for the Linux IEEE 1394 implementation
 #
 
-firewire-core-y += core-card.o core-cdev.o core-device.o \
+firewire-core-y += trace.o core-card.o core-cdev.o core-device.o \
                    core-iso.o core-topology.o core-transaction.o
 firewire-ohci-y += ohci.o
 firewire-sbp2-y += sbp2.o
 firewire-net-y  += net.o
 
+# Let "include/trace/define_trace.h" find the header.
+CFLAGS_trace.o := -I$(src)
+
 obj-$(CONFIG_FIREWIRE)      += firewire-core.o
 obj-$(CONFIG_FIREWIRE_OHCI) += firewire-ohci.o
 obj-$(CONFIG_FIREWIRE_SBP2) += firewire-sbp2.o
diff --git a/drivers/firewire/trace.c b/drivers/firewire/trace.c
new file mode 100644
index 000000000000..ffe427764a90
--- /dev/null
+++ b/drivers/firewire/trace.c
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright (c) 2024 Takashi Sakamoto
+
+#define CREATE_TRACE_POINTS
+#include "trace.h"
diff --git a/drivers/firewire/trace.h b/drivers/firewire/trace.h
new file mode 100644
index 000000000000..d36a10460301
--- /dev/null
+++ b/drivers/firewire/trace.h
@@ -0,0 +1,17 @@
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
+#define TRACE_INCLUDE_PATH	.
+#define TRACE_INCLUDE_FILE	trace
+#include <trace/define_trace.h>
-- 
2.43.0


