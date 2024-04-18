Return-Path: <linux-kernel+bounces-149789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A44A58A95E3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AED828475B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C670715B109;
	Thu, 18 Apr 2024 09:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="KZKY86Jt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AX7whs4g"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184EC15AADD
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 09:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713432192; cv=none; b=uHAfFRMXSD4KaAMnR+V53aTGdjdgYI7Ih2ssuUO/zQFz1rJ6ky3dY6m06bafrXulQyoT6McS+INT5k37g8ZhWh00lr74CNUIlC69Xo8G4uJUHDUGnrXMgrsOHXKw7avBx99QrQ3rwGbKSvXJhNI7tCTkVlGRZJAZJyUsAEqBXdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713432192; c=relaxed/simple;
	bh=qhhZBGVFVVG0hR6YlV5GG7a8m90MLheInqGu3zKiP7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2TOaPNPZGMelv1aLVQjTJGaZ55h5aJGwGwjAS5KUS2hWfZHtYgARlKtDtABfHVDvs0UtYSMyq8tLV1dWVRDkTkgveaF727nGau58Sm5cHX2hhlX0vwa0OSzavvDkKTPtNYxPL/gpiJn2vW/8+hbTPzFmNvitgTpXgYalgihOV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=KZKY86Jt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AX7whs4g; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 1B9C413800D5;
	Thu, 18 Apr 2024 05:23:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 18 Apr 2024 05:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1713432189; x=
	1713518589; bh=9JMS5a+BFkL46r0QPZ6KihBqYCIVWhU6uAgQW770fr8=; b=K
	ZKY86JtJ5Q4pL8Jh6ry6I3LTNnrXKN89IMSsDyd47nQRY/eUwDeR4morbn19oOTa
	3x85FMeJ2L05hgNuIUGvILtfVaaWlCQTee1ndVLP9dRDgRd+huT1fXIcZDkVXpb3
	FoKIK3Ze3dmzuKuRJz8Zm1oC/WYLIQqO5GuLAIH/5qIr1t82hvB2it3S5W0t6uQt
	tMXgF6bbbZVSUVbywyZMQOCG913omEyG4efFv2Gme9ZsiVk92I4RfNK/XbYfRLnJ
	iu1WyxNwc1CepDf1seMppJqkVY1RS5k4CJ+9IaZBTew+oGzpY1KCfe8l9/wXhItw
	Trb3YbpPv+5PEi0DLX8Yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1713432189; x=
	1713518589; bh=9JMS5a+BFkL46r0QPZ6KihBqYCIVWhU6uAgQW770fr8=; b=A
	X7whs4gHezoNOxzQyNBBqtJK00ytT3oSSE5X0W3wu/ZxkQlycWTcQRghwWUGLWOW
	K6TV26W46QGk1T6mx3A1a0E+BBjGj5vbHpCkdsZdNdeeCZVVM6xdEiovr1NjxIPx
	LvWt31cpSBIRC5Civ1qc1pVPNATH0io/IA0SZoXnnKNmWGo+wuN+iLHQaL/j9GVv
	Y3BN4CKvEhMZ3dVkjelKS1ADyGxEqwTJJ1eoOYFrNqrRJbj9E2Pc3LnbNItqqwUe
	6XfppmicSDWvZ+cW9BNOO1Gc/123KtW7//Zrln7qWCZdMgU8ZFMYciNB826plb0s
	xIXjOHQglCFN93kTF0fSw==
X-ME-Sender: <xms:fOYgZnNp8QChqIqEP7LjsoHUX1KJcRuZ3e1So08QaRwEDAokJZuZgQ>
    <xme:fOYgZh9UgYMcQu60pxojKZ_QHxKQ9bU81ygpOeyNDpgjMxRGWIN1ctX-8V_bjRxUQ
    Kvk7QsQItMvDut0MAc>
X-ME-Received: <xmr:fOYgZmQDmZWDx1lycgR4-Vhmxqve4R4nCiluW0eGlKLH-vrgRxGOFxoGMpZZ5MNVu2sF1vqloVgNX_b3__sdidrVMfp3OyeCYoNKXKfsWv63kA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudektddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeeugfevtd
    efhfeffeeuudduhfekhffgveejfeeiiefftdethfduudevjeekveffleenucffohhmrghi
    nhepthgvshhtrghnhihthhhinhhgrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhi
    rdhjph
X-ME-Proxy: <xmx:fOYgZru1RUj3WE7nEsY35a4dsDU8duLvb9piHalBBVrIUMY6Yay7iw>
    <xmx:fOYgZvcmnFXCkqciaqJS55kYVL91ASFrdHlXIBbAyiMcdt7tfbGHng>
    <xmx:fOYgZn0dGV0W0YvBZSGRTgX_5IRdAuy2mjageee5byRM6HJhFTjGmA>
    <xmx:fOYgZr9tCTxfNH8OVqJtOp_x21zP6ApG05KZO25Yu_Z5vZl5iL4m6w>
    <xmx:feYgZgp80sydfWYeUDjgBv2j0JmPKGTX3sT548vH1gnKKMnUIK__DRFD>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Apr 2024 05:23:07 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 01/13] firewire: core: add common inline functions to serialize/deserialize asynchronous packet header
Date: Thu, 18 Apr 2024 18:22:51 +0900
Message-ID: <20240418092303.19725-2-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240418092303.19725-1-o-takashi@sakamocchi.jp>
References: <20240418092303.19725-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In both core and 1394 OHCI driver, some hard-coded values and macros are
used to serialize/deserialize the header for asynchronous packets. It is
inconvenient to reuse them.

This commit adds some helper inline functions with their tests for the
purpose.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/.kunitconfig                |   1 +
 drivers/firewire/Kconfig                     |  16 +
 drivers/firewire/Makefile                    |   3 +
 drivers/firewire/packet-header-definitions.h | 168 ++++++
 drivers/firewire/packet-serdes-test.c        | 538 +++++++++++++++++++
 5 files changed, 726 insertions(+)
 create mode 100644 drivers/firewire/packet-header-definitions.h
 create mode 100644 drivers/firewire/packet-serdes-test.c

diff --git a/drivers/firewire/.kunitconfig b/drivers/firewire/.kunitconfig
index 76444a2d5e12..60d9e7c35417 100644
--- a/drivers/firewire/.kunitconfig
+++ b/drivers/firewire/.kunitconfig
@@ -3,3 +3,4 @@ CONFIG_PCI=y
 CONFIG_FIREWIRE=y
 CONFIG_FIREWIRE_KUNIT_UAPI_TEST=y
 CONFIG_FIREWIRE_KUNIT_DEVICE_ATTRIBUTE_TEST=y
+CONFIG_FIREWIRE_KUNIT_PACKET_SERDES_TEST=y
diff --git a/drivers/firewire/Kconfig b/drivers/firewire/Kconfig
index 552a39df8cbd..869598b20e3a 100644
--- a/drivers/firewire/Kconfig
+++ b/drivers/firewire/Kconfig
@@ -50,6 +50,22 @@ config FIREWIRE_KUNIT_DEVICE_ATTRIBUTE_TEST
 	  For more information on KUnit and unit tests in general, refer
 	  to the KUnit documentation in Documentation/dev-tools/kunit/.
 
+config FIREWIRE_KUNIT_PACKET_SERDES_TEST
+	tristate "KUnit tests for packet serialization/deserialization" if !KUNIT_ALL_TESTS
+	depends on FIREWIRE && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This builds the KUnit tests for packet serialization and
+	  deserialization.
+
+	  KUnit tests run during boot and output the results to the debug
+	  log in TAP format (https://testanything.org/). Only useful for
+	  kernel devs running KUnit test harness and are not for inclusion
+	  into a production build.
+
+	  For more information on KUnit and unit tests in general, refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
 config FIREWIRE_OHCI
 	tristate "OHCI-1394 controllers"
 	depends on PCI && FIREWIRE && MMU
diff --git a/drivers/firewire/Makefile b/drivers/firewire/Makefile
index b24b2879ac34..bbde29a0fba6 100644
--- a/drivers/firewire/Makefile
+++ b/drivers/firewire/Makefile
@@ -17,4 +17,7 @@ obj-$(CONFIG_FIREWIRE_NOSY) += nosy.o
 obj-$(CONFIG_PROVIDE_OHCI1394_DMA_INIT) += init_ohci1394_dma.o
 
 firewire-uapi-test-objs += uapi-test.o
+firewire-packet-serdes-test-objs += packet-serdes-test.o
+
 obj-$(CONFIG_FIREWIRE_KUNIT_UAPI_TEST) += firewire-uapi-test.o
+obj-$(CONFIG_FIREWIRE_KUNIT_PACKET_SERDES_TEST) += firewire-packet-serdes-test.o
diff --git a/drivers/firewire/packet-header-definitions.h b/drivers/firewire/packet-header-definitions.h
new file mode 100644
index 000000000000..83e550427706
--- /dev/null
+++ b/drivers/firewire/packet-header-definitions.h
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+//
+// packet-header-definitions.h - The definitions of header fields for IEEE 1394 packet.
+//
+// Copyright (c) 2024 Takashi Sakamoto
+
+#ifndef _FIREWIRE_PACKET_HEADER_DEFINITIONS_H
+#define _FIREWIRE_PACKET_HEADER_DEFINITIONS_H
+
+#define ASYNC_HEADER_QUADLET_COUNT		4
+
+#define ASYNC_HEADER_Q0_DESTINATION_SHIFT	16
+#define ASYNC_HEADER_Q0_DESTINATION_MASK	0xffff0000
+#define ASYNC_HEADER_Q0_TLABEL_SHIFT		10
+#define ASYNC_HEADER_Q0_TLABEL_MASK		0x0000fc00
+#define ASYNC_HEADER_Q0_RETRY_SHIFT		8
+#define ASYNC_HEADER_Q0_RETRY_MASK		0x00000300
+#define ASYNC_HEADER_Q0_TCODE_SHIFT		4
+#define ASYNC_HEADER_Q0_TCODE_MASK		0x000000f0
+#define ASYNC_HEADER_Q0_PRIORITY_SHIFT		0
+#define ASYNC_HEADER_Q0_PRIORITY_MASK		0x0000000f
+#define ASYNC_HEADER_Q1_SOURCE_SHIFT		16
+#define ASYNC_HEADER_Q1_SOURCE_MASK		0xffff0000
+#define ASYNC_HEADER_Q1_RCODE_SHIFT		12
+#define ASYNC_HEADER_Q1_RCODE_MASK		0x0000f000
+#define ASYNC_HEADER_Q1_RCODE_SHIFT		12
+#define ASYNC_HEADER_Q1_RCODE_MASK		0x0000f000
+#define ASYNC_HEADER_Q1_OFFSET_HIGH_SHIFT	0
+#define ASYNC_HEADER_Q1_OFFSET_HIGH_MASK	0x0000ffff
+#define ASYNC_HEADER_Q3_DATA_LENGTH_SHIFT	16
+#define ASYNC_HEADER_Q3_DATA_LENGTH_MASK	0xffff0000
+#define ASYNC_HEADER_Q3_EXTENDED_TCODE_SHIFT	0
+#define ASYNC_HEADER_Q3_EXTENDED_TCODE_MASK	0x0000ffff
+
+static inline unsigned int async_header_get_destination(const u32 header[ASYNC_HEADER_QUADLET_COUNT])
+{
+	return (header[0] & ASYNC_HEADER_Q0_DESTINATION_MASK) >> ASYNC_HEADER_Q0_DESTINATION_SHIFT;
+}
+
+static inline unsigned int async_header_get_tlabel(const u32 header[ASYNC_HEADER_QUADLET_COUNT])
+{
+	return (header[0] & ASYNC_HEADER_Q0_TLABEL_MASK) >> ASYNC_HEADER_Q0_TLABEL_SHIFT;
+}
+
+static inline unsigned int async_header_get_retry(const u32 header[ASYNC_HEADER_QUADLET_COUNT])
+{
+	return (header[0] & ASYNC_HEADER_Q0_RETRY_MASK) >> ASYNC_HEADER_Q0_RETRY_SHIFT;
+}
+
+static inline unsigned int async_header_get_tcode(const u32 header[ASYNC_HEADER_QUADLET_COUNT])
+{
+	return (header[0] & ASYNC_HEADER_Q0_TCODE_MASK) >> ASYNC_HEADER_Q0_TCODE_SHIFT;
+}
+
+static inline unsigned int async_header_get_priority(const u32 header[ASYNC_HEADER_QUADLET_COUNT])
+{
+	return (header[0] & ASYNC_HEADER_Q0_PRIORITY_MASK) >> ASYNC_HEADER_Q0_PRIORITY_SHIFT;
+}
+
+static inline unsigned int async_header_get_source(const u32 header[ASYNC_HEADER_QUADLET_COUNT])
+{
+	return (header[1] & ASYNC_HEADER_Q1_SOURCE_MASK) >> ASYNC_HEADER_Q1_SOURCE_SHIFT;
+}
+
+static inline unsigned int async_header_get_rcode(const u32 header[ASYNC_HEADER_QUADLET_COUNT])
+{
+	return (header[1] & ASYNC_HEADER_Q1_RCODE_MASK) >> ASYNC_HEADER_Q1_RCODE_SHIFT;
+}
+
+static inline u64 async_header_get_offset(const u32 header[ASYNC_HEADER_QUADLET_COUNT])
+{
+	u32 hi = (header[1] & ASYNC_HEADER_Q1_OFFSET_HIGH_MASK) >> ASYNC_HEADER_Q1_OFFSET_HIGH_SHIFT;
+	return (((u64)hi) << 32) | ((u64)header[2]);
+}
+
+static inline u32 async_header_get_quadlet_data(const u32 header[ASYNC_HEADER_QUADLET_COUNT])
+{
+	return header[3];
+}
+
+static inline unsigned int async_header_get_data_length(const u32 header[ASYNC_HEADER_QUADLET_COUNT])
+{
+	return (header[3] & ASYNC_HEADER_Q3_DATA_LENGTH_MASK) >> ASYNC_HEADER_Q3_DATA_LENGTH_SHIFT;
+}
+
+static inline unsigned int async_header_get_extended_tcode(const u32 header[ASYNC_HEADER_QUADLET_COUNT])
+{
+	return (header[3] & ASYNC_HEADER_Q3_EXTENDED_TCODE_MASK) >> ASYNC_HEADER_Q3_EXTENDED_TCODE_SHIFT;
+}
+
+static inline void async_header_set_destination(u32 header[ASYNC_HEADER_QUADLET_COUNT],
+						unsigned int destination)
+{
+	header[0] &= ~ASYNC_HEADER_Q0_DESTINATION_MASK;
+	header[0] |= (((u32)destination) << ASYNC_HEADER_Q0_DESTINATION_SHIFT) & ASYNC_HEADER_Q0_DESTINATION_MASK;
+}
+
+static inline void async_header_set_tlabel(u32 header[ASYNC_HEADER_QUADLET_COUNT],
+					   unsigned int tlabel)
+{
+	header[0] &= ~ASYNC_HEADER_Q0_TLABEL_MASK;
+	header[0] |= (((u32)tlabel) << ASYNC_HEADER_Q0_TLABEL_SHIFT) & ASYNC_HEADER_Q0_TLABEL_MASK;
+}
+
+static inline void async_header_set_retry(u32 header[ASYNC_HEADER_QUADLET_COUNT],
+					  unsigned int retry)
+{
+	header[0] &= ~ASYNC_HEADER_Q0_RETRY_MASK;
+	header[0] |= (((u32)retry) << ASYNC_HEADER_Q0_RETRY_SHIFT) & ASYNC_HEADER_Q0_RETRY_MASK;
+}
+
+static inline void async_header_set_tcode(u32 header[ASYNC_HEADER_QUADLET_COUNT],
+					  unsigned int tcode)
+{
+	header[0] &= ~ASYNC_HEADER_Q0_TCODE_MASK;
+	header[0] |= (((u32)tcode) << ASYNC_HEADER_Q0_TCODE_SHIFT) & ASYNC_HEADER_Q0_TCODE_MASK;
+}
+
+static inline void async_header_set_priority(u32 header[ASYNC_HEADER_QUADLET_COUNT],
+					     unsigned int priority)
+{
+	header[0] &= ~ASYNC_HEADER_Q0_PRIORITY_MASK;
+	header[0] |= (((u32)priority) << ASYNC_HEADER_Q0_PRIORITY_SHIFT) & ASYNC_HEADER_Q0_PRIORITY_MASK;
+}
+
+
+static inline void async_header_set_source(u32 header[ASYNC_HEADER_QUADLET_COUNT],
+					   unsigned int source)
+{
+	header[1] &= ~ASYNC_HEADER_Q1_SOURCE_MASK;
+	header[1] |= (((u32)source) << ASYNC_HEADER_Q1_SOURCE_SHIFT) & ASYNC_HEADER_Q1_SOURCE_MASK;
+}
+
+static inline void async_header_set_rcode(u32 header[ASYNC_HEADER_QUADLET_COUNT],
+					  unsigned int rcode)
+{
+	header[1] &= ~ASYNC_HEADER_Q1_RCODE_MASK;
+	header[1] |= (((u32)rcode) << ASYNC_HEADER_Q1_RCODE_SHIFT) & ASYNC_HEADER_Q1_RCODE_MASK;
+}
+
+static inline void async_header_set_offset(u32 header[ASYNC_HEADER_QUADLET_COUNT], u64 offset)
+{
+	u32 hi = (u32)(offset >> 32);
+	header[1] &= ~ASYNC_HEADER_Q1_OFFSET_HIGH_MASK;
+	header[1] |= (hi << ASYNC_HEADER_Q1_OFFSET_HIGH_SHIFT) & ASYNC_HEADER_Q1_OFFSET_HIGH_MASK;
+	header[2] = (u32)(offset & 0x00000000ffffffff);
+}
+
+static inline void async_header_set_quadlet_data(u32 header[ASYNC_HEADER_QUADLET_COUNT], u32 quadlet_data)
+{
+	header[3] = quadlet_data;
+}
+
+static inline void async_header_set_data_length(u32 header[ASYNC_HEADER_QUADLET_COUNT],
+						unsigned int data_length)
+{
+	header[3] &= ~ASYNC_HEADER_Q3_DATA_LENGTH_MASK;
+	header[3] |= (((u32)data_length) << ASYNC_HEADER_Q3_DATA_LENGTH_SHIFT) & ASYNC_HEADER_Q3_DATA_LENGTH_MASK;
+}
+
+static inline void async_header_set_extended_tcode(u32 header[ASYNC_HEADER_QUADLET_COUNT],
+						   unsigned int extended_tcode)
+{
+	header[3] &= ~ASYNC_HEADER_Q3_EXTENDED_TCODE_MASK;
+	header[3] |= (((u32)extended_tcode) << ASYNC_HEADER_Q3_EXTENDED_TCODE_SHIFT) & ASYNC_HEADER_Q3_EXTENDED_TCODE_MASK;
+}
+
+#endif // _FIREWIRE_PACKET_HEADER_DEFINITIONS_H
diff --git a/drivers/firewire/packet-serdes-test.c b/drivers/firewire/packet-serdes-test.c
new file mode 100644
index 000000000000..299e9f908463
--- /dev/null
+++ b/drivers/firewire/packet-serdes-test.c
@@ -0,0 +1,538 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+//
+// packet-serdes-test.c - An application of Kunit to check serialization/deserialization of packets
+//			  defined by IEEE 1394.
+//
+// Copyright (c) 2024 Takashi Sakamoto
+
+#include <kunit/test.h>
+
+#include <linux/firewire-constants.h>
+
+#include "packet-header-definitions.h"
+
+static void serialize_async_header_common(u32 header[ASYNC_HEADER_QUADLET_COUNT],
+					  unsigned int dst_id, unsigned int tlabel,
+					  unsigned int retry, unsigned int tcode,
+					  unsigned int priority, unsigned int src_id)
+{
+	async_header_set_destination(header, dst_id);
+	async_header_set_tlabel(header, tlabel);
+	async_header_set_retry(header, retry);
+	async_header_set_tcode(header, tcode);
+	async_header_set_priority(header, priority);
+	async_header_set_source(header, src_id);
+}
+
+static void serialize_async_header_request(u32 header[ASYNC_HEADER_QUADLET_COUNT],
+					   unsigned int dst_id, unsigned int tlabel,
+					   unsigned int retry, unsigned int tcode,
+					   unsigned int priority, unsigned int src_id, u64 offset)
+{
+	serialize_async_header_common(header, dst_id, tlabel, retry, tcode, priority, src_id);
+	async_header_set_offset(header, offset);
+}
+
+static void serialize_async_header_quadlet_request(u32 header[ASYNC_HEADER_QUADLET_COUNT],
+						   unsigned int dst_id, unsigned int tlabel,
+						   unsigned int retry, unsigned int tcode,
+						   unsigned int priority, unsigned int src_id,
+						   u64 offset)
+{
+	serialize_async_header_request(header, dst_id, tlabel, retry, tcode, priority, src_id,
+				       offset);
+}
+
+static void serialize_async_header_block_request(u32 header[ASYNC_HEADER_QUADLET_COUNT],
+						 unsigned int dst_id, unsigned int tlabel,
+						 unsigned int retry, unsigned int tcode,
+						 unsigned int priority, unsigned int src_id,
+						 u64 offset, unsigned int data_length,
+						 unsigned int extended_tcode)
+{
+	serialize_async_header_request(header, dst_id, tlabel, retry, tcode, priority, src_id,
+				       offset);
+	async_header_set_data_length(header, data_length);
+	async_header_set_extended_tcode(header, extended_tcode);
+}
+
+static void serialize_async_header_response(u32 header[ASYNC_HEADER_QUADLET_COUNT],
+					    unsigned int dst_id, unsigned int tlabel,
+					    unsigned int retry, unsigned int tcode,
+					    unsigned int priority, unsigned int src_id,
+					    unsigned int rcode)
+{
+	serialize_async_header_common(header, dst_id, tlabel, retry, tcode, priority, src_id);
+	async_header_set_rcode(header, rcode);
+}
+
+static void serialize_async_header_quadlet_response(u32 header[ASYNC_HEADER_QUADLET_COUNT],
+						    unsigned int dst_id, unsigned int tlabel,
+						    unsigned int retry, unsigned int tcode,
+						    unsigned int priority, unsigned int src_id,
+						    unsigned int rcode)
+{
+	serialize_async_header_response(header, dst_id, tlabel, retry, tcode, priority, src_id,
+					rcode);
+}
+
+static void serialize_async_header_block_response(u32 header[ASYNC_HEADER_QUADLET_COUNT],
+						  unsigned int dst_id, unsigned int tlabel,
+						  unsigned int retry, unsigned int tcode,
+						  unsigned int priority, unsigned int src_id,
+						  unsigned int rcode, unsigned int data_length,
+						  unsigned int extended_tcode)
+{
+	serialize_async_header_response(header, dst_id, tlabel, retry, tcode, priority, src_id,
+					rcode);
+	async_header_set_data_length(header, data_length);
+	async_header_set_extended_tcode(header, extended_tcode);
+}
+
+static void deserialize_async_header_common(const u32 header[ASYNC_HEADER_QUADLET_COUNT],
+					    unsigned int *dst_id, unsigned int *tlabel,
+					    unsigned int *retry, unsigned int *tcode,
+					    unsigned int *priority, unsigned int *src_id)
+{
+	*dst_id = async_header_get_destination(header);
+	*tlabel = async_header_get_tlabel(header);
+	*retry = async_header_get_retry(header);
+	*tcode = async_header_get_tcode(header);
+	*priority = async_header_get_priority(header);
+	*src_id = async_header_get_source(header);
+}
+
+static void deserialize_async_header_request(const u32 header[ASYNC_HEADER_QUADLET_COUNT],
+					     unsigned int *dst_id, unsigned int *tlabel,
+					     unsigned int *retry, unsigned int *tcode,
+					     unsigned int *priority, unsigned int *src_id,
+					     u64 *offset)
+{
+	deserialize_async_header_common(header, dst_id, tlabel, retry, tcode, priority, src_id);
+	*offset = async_header_get_offset(header);
+}
+
+static void deserialize_async_header_quadlet_request(const u32 header[ASYNC_HEADER_QUADLET_COUNT],
+						     unsigned int *dst_id, unsigned int *tlabel,
+						     unsigned int *retry, unsigned int *tcode,
+						     unsigned int *priority, unsigned int *src_id,
+						     u64 *offset)
+{
+	deserialize_async_header_request(header, dst_id, tlabel, retry, tcode, priority, src_id,
+					 offset);
+}
+
+static void deserialize_async_header_block_request(const u32 header[ASYNC_HEADER_QUADLET_COUNT],
+						   unsigned int *dst_id, unsigned int *tlabel,
+						   unsigned int *retry, unsigned int *tcode,
+						   unsigned int *priority, unsigned int *src_id,
+						   u64 *offset,
+						   unsigned int *data_length,
+						   unsigned int *extended_tcode)
+{
+	deserialize_async_header_request(header, dst_id, tlabel, retry, tcode, priority, src_id,
+					 offset);
+	*data_length = async_header_get_data_length(header);
+	*extended_tcode = async_header_get_extended_tcode(header);
+}
+
+static void deserialize_async_header_response(const u32 header[ASYNC_HEADER_QUADLET_COUNT],
+					      unsigned int *dst_id, unsigned int *tlabel,
+					      unsigned int *retry, unsigned int *tcode,
+					      unsigned int *priority, unsigned int *src_id,
+					      unsigned int *rcode)
+{
+	deserialize_async_header_common(header, dst_id, tlabel, retry, tcode, priority, src_id);
+	*rcode = async_header_get_rcode(header);
+}
+
+static void deserialize_async_header_quadlet_response(const u32 header[ASYNC_HEADER_QUADLET_COUNT],
+						      unsigned int *dst_id, unsigned int *tlabel,
+						      unsigned int *retry, unsigned int *tcode,
+						      unsigned int *priority, unsigned int *src_id,
+						      unsigned int *rcode)
+{
+	deserialize_async_header_response(header, dst_id, tlabel, retry, tcode, priority, src_id, rcode);
+}
+
+static void deserialize_async_header_block_response(const u32 header[ASYNC_HEADER_QUADLET_COUNT],
+						    unsigned int *dst_id, unsigned int *tlabel,
+						    unsigned int *retry, unsigned int *tcode,
+						    unsigned int *priority, unsigned int *src_id,
+						    unsigned int *rcode, unsigned int *data_length,
+						    unsigned int *extended_tcode)
+{
+	deserialize_async_header_response(header, dst_id, tlabel, retry, tcode, priority, src_id, rcode);
+	*data_length = async_header_get_data_length(header);
+	*extended_tcode = async_header_get_extended_tcode(header);
+}
+
+static void test_async_header_write_quadlet_request(struct kunit *test)
+{
+	static const u32 expected[ASYNC_HEADER_QUADLET_COUNT] = {
+		0xffc05100,
+		0xffc1ffff,
+		0xf0000234,
+		0x1f0000c0,
+	};
+	u32 header[ASYNC_HEADER_QUADLET_COUNT] = {0, 0, 0, 0};
+
+	unsigned int dst_id;
+	unsigned int tlabel;
+	unsigned int retry;
+	unsigned int tcode;
+	unsigned int priority;
+	unsigned int src_id;
+	u64 offset;
+	u32 quadlet_data;
+
+	deserialize_async_header_quadlet_request(expected, &dst_id, &tlabel, &retry, &tcode,
+						 &priority, &src_id, &offset);
+	quadlet_data = async_header_get_quadlet_data(expected);
+
+	KUNIT_EXPECT_EQ(test, 0xffc0, dst_id);
+	KUNIT_EXPECT_EQ(test, 0x14, tlabel);
+	KUNIT_EXPECT_EQ(test, 0x01, retry);
+	KUNIT_EXPECT_EQ(test, TCODE_WRITE_QUADLET_REQUEST, tcode);
+	KUNIT_EXPECT_EQ(test, 0x00, priority);
+	KUNIT_EXPECT_EQ(test, 0xffc1, src_id);
+	KUNIT_EXPECT_EQ(test, 0xfffff0000234, offset);
+	KUNIT_EXPECT_EQ(test, 0x1f0000c0, quadlet_data);
+
+	serialize_async_header_quadlet_request(header, dst_id, tlabel, retry, tcode, priority,
+					       src_id, offset);
+	async_header_set_quadlet_data(header, quadlet_data);
+
+	KUNIT_EXPECT_MEMEQ(test, header, expected, sizeof(expected));
+}
+
+static void test_async_header_write_block_request(struct kunit *test)
+{
+	static const u32 expected[ASYNC_HEADER_QUADLET_COUNT] = {
+		0xffc06510,
+		0xffc1ecc0,
+		0x00000000,
+		0x00180000,
+	};
+	u32 header[ASYNC_HEADER_QUADLET_COUNT] = {0, 0, 0, 0};
+
+	unsigned int dst_id;
+	unsigned int tlabel;
+	unsigned int retry;
+	unsigned int tcode;
+	unsigned int priority;
+	unsigned int src_id;
+	u64 offset;
+	unsigned int data_length;
+	unsigned int extended_tcode;
+
+	deserialize_async_header_block_request(expected, &dst_id, &tlabel, &retry, &tcode,
+					       &priority, &src_id, &offset, &data_length,
+					       &extended_tcode);
+
+	KUNIT_EXPECT_EQ(test, 0xffc0, dst_id);
+	KUNIT_EXPECT_EQ(test, 0x19, tlabel);
+	KUNIT_EXPECT_EQ(test, 0x01, retry);
+	KUNIT_EXPECT_EQ(test, TCODE_WRITE_BLOCK_REQUEST, tcode);
+	KUNIT_EXPECT_EQ(test, 0x00, priority);
+	KUNIT_EXPECT_EQ(test, 0xffc1, src_id);
+	KUNIT_EXPECT_EQ(test, 0xecc000000000, offset);
+	KUNIT_EXPECT_EQ(test, 0x0018, data_length);
+	KUNIT_EXPECT_EQ(test, 0x0000, extended_tcode);
+
+	serialize_async_header_block_request(header, dst_id, tlabel, retry, tcode, priority, src_id,
+					     offset, data_length, extended_tcode);
+
+	KUNIT_EXPECT_MEMEQ(test, header, expected, sizeof(expected));
+}
+
+static void test_async_header_write_response(struct kunit *test)
+{
+	static const u32 expected[ASYNC_HEADER_QUADLET_COUNT] = {
+		0xffc15120,
+		0xffc00000,
+		0x00000000,
+		0x00000000,
+	};
+	u32 header[ASYNC_HEADER_QUADLET_COUNT] = {0, 0, 0, 0};
+
+	unsigned int dst_id;
+	unsigned int tlabel;
+	unsigned int retry;
+	unsigned int tcode;
+	unsigned int priority;
+	unsigned int src_id;
+	unsigned int rcode;
+
+	deserialize_async_header_quadlet_response(expected, &dst_id, &tlabel, &retry, &tcode,
+						  &priority, &src_id, &rcode);
+
+	KUNIT_EXPECT_EQ(test, 0xffc1, dst_id);
+	KUNIT_EXPECT_EQ(test, 0x14, tlabel);
+	KUNIT_EXPECT_EQ(test, 0x01, retry);
+	KUNIT_EXPECT_EQ(test, TCODE_WRITE_RESPONSE, tcode);
+	KUNIT_EXPECT_EQ(test, 0x00, priority);
+	KUNIT_EXPECT_EQ(test, 0xffc0, src_id);
+	KUNIT_EXPECT_EQ(test, RCODE_COMPLETE, rcode);
+
+	serialize_async_header_quadlet_response(header, dst_id, tlabel, retry, tcode, priority,
+						src_id, rcode);
+
+	KUNIT_EXPECT_MEMEQ(test, header, expected, sizeof(expected) - sizeof(expected[0]));
+}
+
+static void test_async_header_read_quadlet_request(struct kunit *test)
+{
+	static const u32 expected[ASYNC_HEADER_QUADLET_COUNT] = {
+		0xffc0f140,
+		0xffc1ffff,
+		0xf0000984,
+		0x00000000,
+	};
+	u32 header[ASYNC_HEADER_QUADLET_COUNT] = {0, 0, 0, 0};
+
+	unsigned int dst_id;
+	unsigned int tlabel;
+	unsigned int retry;
+	unsigned int tcode;
+	unsigned int priority;
+	unsigned int src_id;
+	u64 offset;
+
+	deserialize_async_header_quadlet_request(expected, &dst_id, &tlabel, &retry, &tcode,
+						 &priority, &src_id, &offset);
+
+	KUNIT_EXPECT_EQ(test, 0xffc0, dst_id);
+	KUNIT_EXPECT_EQ(test, 0x3c, tlabel);
+	KUNIT_EXPECT_EQ(test, 0x01, retry);
+	KUNIT_EXPECT_EQ(test, TCODE_READ_QUADLET_REQUEST, tcode);
+	KUNIT_EXPECT_EQ(test, 0x00, priority);
+	KUNIT_EXPECT_EQ(test, 0xffc1, src_id);
+	KUNIT_EXPECT_EQ(test, 0xfffff0000984, offset);
+
+	serialize_async_header_quadlet_request(header, dst_id, tlabel, retry, tcode, priority,
+					       src_id, offset);
+
+	KUNIT_EXPECT_MEMEQ(test, header, expected, sizeof(expected));
+}
+
+static void test_async_header_read_quadlet_response(struct kunit *test)
+{
+	static const u32 expected[ASYNC_HEADER_QUADLET_COUNT] = {
+		0xffc1f160,
+		0xffc00000,
+		0x00000000,
+		0x00000180,
+	};
+	u32 header[ASYNC_HEADER_QUADLET_COUNT] = {0, 0, 0, 0};
+
+	unsigned int dst_id;
+	unsigned int tlabel;
+	unsigned int retry;
+	unsigned int tcode;
+	unsigned int priority;
+	unsigned int src_id;
+	unsigned int rcode;
+	u32 quadlet_data;
+
+	deserialize_async_header_quadlet_response(expected, &dst_id, &tlabel, &retry, &tcode,
+						  &priority, &src_id, &rcode);
+	quadlet_data = async_header_get_quadlet_data(expected);
+
+	KUNIT_EXPECT_EQ(test, 0xffc1, dst_id);
+	KUNIT_EXPECT_EQ(test, 0x3c, tlabel);
+	KUNIT_EXPECT_EQ(test, 0x01, retry);
+	KUNIT_EXPECT_EQ(test, TCODE_READ_QUADLET_RESPONSE, tcode);
+	KUNIT_EXPECT_EQ(test, 0x00, priority);
+	KUNIT_EXPECT_EQ(test, 0xffc0, src_id);
+	KUNIT_EXPECT_EQ(test, RCODE_COMPLETE, rcode);
+	KUNIT_EXPECT_EQ(test, 0x00000180, quadlet_data);
+
+	serialize_async_header_quadlet_response(header, dst_id, tlabel, retry, tcode, priority,
+						src_id, rcode);
+	async_header_set_quadlet_data(header, quadlet_data);
+
+	KUNIT_EXPECT_MEMEQ(test, header, expected, sizeof(expected));
+}
+
+static void test_async_header_read_block_request(struct kunit *test)
+{
+	static const u32 expected[ASYNC_HEADER_QUADLET_COUNT] = {
+		0xffc0e150,
+		0xffc1ffff,
+		0xf0000400,
+		0x00200000,
+	};
+	u32 header[ASYNC_HEADER_QUADLET_COUNT] = {0, 0, 0, 0};
+
+	unsigned int dst_id;
+	unsigned int tlabel;
+	unsigned int retry;
+	unsigned int tcode;
+	unsigned int priority;
+	unsigned int src_id;
+	u64 offset;
+	unsigned int data_length;
+	unsigned int extended_tcode;
+
+	deserialize_async_header_block_request(expected, &dst_id, &tlabel, &retry, &tcode,
+					       &priority, &src_id, &offset, &data_length,
+					       &extended_tcode);
+
+	KUNIT_EXPECT_EQ(test, 0xffc0, dst_id);
+	KUNIT_EXPECT_EQ(test, 0x38, tlabel);
+	KUNIT_EXPECT_EQ(test, 0x01, retry);
+	KUNIT_EXPECT_EQ(test, TCODE_READ_BLOCK_REQUEST, tcode);
+	KUNIT_EXPECT_EQ(test, 0x00, priority);
+	KUNIT_EXPECT_EQ(test, 0xffc1, src_id);
+	KUNIT_EXPECT_EQ(test, 0xfffff0000400, offset);
+	KUNIT_EXPECT_EQ(test, 0x0020, data_length);
+	KUNIT_EXPECT_EQ(test, 0x0000, extended_tcode);
+
+	serialize_async_header_block_request(header, dst_id, tlabel, retry, tcode, priority, src_id,
+					     offset, data_length, extended_tcode);
+
+	KUNIT_EXPECT_MEMEQ(test, header, expected, sizeof(expected));
+}
+
+static void test_async_header_read_block_response(struct kunit *test)
+{
+	static const u32 expected[ASYNC_HEADER_QUADLET_COUNT] = {
+		0xffc1e170,
+		0xffc00000,
+		0x00000000,
+		0x00200000,
+	};
+	u32 header[ASYNC_HEADER_QUADLET_COUNT] = {0, 0, 0, 0};
+
+	unsigned int dst_id;
+	unsigned int tlabel;
+	unsigned int retry;
+	unsigned int tcode;
+	unsigned int priority;
+	unsigned int src_id;
+	unsigned int rcode;
+	unsigned int data_length;
+	unsigned int extended_tcode;
+
+	deserialize_async_header_block_response(expected, &dst_id, &tlabel, &retry, &tcode,
+						&priority, &src_id, &rcode, &data_length,
+						&extended_tcode);
+
+	KUNIT_EXPECT_EQ(test, 0xffc1, dst_id);
+	KUNIT_EXPECT_EQ(test, 0x38, tlabel);
+	KUNIT_EXPECT_EQ(test, 0x01, retry);
+	KUNIT_EXPECT_EQ(test, TCODE_READ_BLOCK_RESPONSE, tcode);
+	KUNIT_EXPECT_EQ(test, 0x00, priority);
+	KUNIT_EXPECT_EQ(test, 0xffc0, src_id);
+	KUNIT_EXPECT_EQ(test, RCODE_COMPLETE, rcode);
+	KUNIT_EXPECT_EQ(test, 0x0020, data_length);
+	KUNIT_EXPECT_EQ(test, 0x0000, extended_tcode);
+
+	serialize_async_header_block_response(header, dst_id, tlabel, retry, tcode, priority,
+					      src_id, rcode, data_length, extended_tcode);
+
+	KUNIT_EXPECT_MEMEQ(test, header, expected, sizeof(expected));
+}
+
+static void test_async_header_lock_request(struct kunit *test)
+{
+	static const u32 expected[ASYNC_HEADER_QUADLET_COUNT] = {
+		0xffc02d90,
+		0xffc1ffff,
+		0xf0000984,
+		0x00080002,
+	};
+	u32 header[ASYNC_HEADER_QUADLET_COUNT] = {0, 0, 0, 0};
+
+	unsigned int dst_id;
+	unsigned int tlabel;
+	unsigned int retry;
+	unsigned int tcode;
+	unsigned int priority;
+	unsigned int src_id;
+	u64 offset;
+	unsigned int data_length;
+	unsigned int extended_tcode;
+
+	deserialize_async_header_block_request(expected, &dst_id, &tlabel, &retry, &tcode,
+					       &priority, &src_id, &offset, &data_length,
+					       &extended_tcode);
+
+	KUNIT_EXPECT_EQ(test, 0xffc0, dst_id);
+	KUNIT_EXPECT_EQ(test, 0x0b, tlabel);
+	KUNIT_EXPECT_EQ(test, 0x01, retry);
+	KUNIT_EXPECT_EQ(test, TCODE_LOCK_REQUEST, tcode);
+	KUNIT_EXPECT_EQ(test, 0x00, priority);
+	KUNIT_EXPECT_EQ(test, 0xffc1, src_id);
+	KUNIT_EXPECT_EQ(test, 0xfffff0000984, offset);
+	KUNIT_EXPECT_EQ(test, 0x0008, data_length);
+	KUNIT_EXPECT_EQ(test, EXTCODE_COMPARE_SWAP, extended_tcode);
+
+	serialize_async_header_block_request(header, dst_id, tlabel, retry, tcode, priority, src_id,
+					     offset, data_length, extended_tcode);
+
+	KUNIT_EXPECT_MEMEQ(test, header, expected, sizeof(expected));
+}
+
+static void test_async_header_lock_response(struct kunit *test)
+{
+	static const u32 expected[ASYNC_HEADER_QUADLET_COUNT] = {
+		0xffc12db0,
+		0xffc00000,
+		0x00000000,
+		0x00040002,
+	};
+	u32 header[ASYNC_HEADER_QUADLET_COUNT] = {0, 0, 0, 0};
+
+	unsigned int dst_id;
+	unsigned int tlabel;
+	unsigned int retry;
+	unsigned int tcode;
+	unsigned int priority;
+	unsigned int src_id;
+	unsigned int rcode;
+	unsigned int data_length;
+	unsigned int extended_tcode;
+
+	deserialize_async_header_block_response(expected, &dst_id, &tlabel, &retry, &tcode,
+						&priority, &src_id, &rcode, &data_length,
+						&extended_tcode);
+
+	KUNIT_EXPECT_EQ(test, 0xffc1, dst_id);
+	KUNIT_EXPECT_EQ(test, 0x0b, tlabel);
+	KUNIT_EXPECT_EQ(test, 0x01, retry);
+	KUNIT_EXPECT_EQ(test, TCODE_LOCK_RESPONSE, tcode);
+	KUNIT_EXPECT_EQ(test, 0x00, priority);
+	KUNIT_EXPECT_EQ(test, 0xffc0, src_id);
+	KUNIT_EXPECT_EQ(test, RCODE_COMPLETE, rcode);
+	KUNIT_EXPECT_EQ(test, 0x0004, data_length);
+	KUNIT_EXPECT_EQ(test, EXTCODE_COMPARE_SWAP, extended_tcode);
+
+	serialize_async_header_block_response(header, dst_id, tlabel, retry, tcode, priority,
+					      src_id, rcode, data_length, extended_tcode);
+
+	KUNIT_EXPECT_MEMEQ(test, header, expected, sizeof(expected));
+}
+
+
+static struct kunit_case packet_serdes_test_cases[] = {
+	KUNIT_CASE(test_async_header_write_quadlet_request),
+	KUNIT_CASE(test_async_header_write_block_request),
+	KUNIT_CASE(test_async_header_write_response),
+	KUNIT_CASE(test_async_header_read_quadlet_request),
+	KUNIT_CASE(test_async_header_read_quadlet_response),
+	KUNIT_CASE(test_async_header_read_block_request),
+	KUNIT_CASE(test_async_header_read_block_response),
+	KUNIT_CASE(test_async_header_lock_request),
+	KUNIT_CASE(test_async_header_lock_response),
+	{}
+};
+
+static struct kunit_suite packet_serdes_test_suite = {
+	.name = "firewire-packet-serdes",
+	.test_cases = packet_serdes_test_cases,
+};
+kunit_test_suite(packet_serdes_test_suite);
+
+MODULE_LICENSE("GPL");
-- 
2.43.0


