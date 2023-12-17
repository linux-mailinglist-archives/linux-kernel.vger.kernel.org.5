Return-Path: <linux-kernel+bounces-2528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA59815E80
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 11:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F30511F210E4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 10:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5669E563;
	Sun, 17 Dec 2023 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="WBo7FkL2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jkJryLQ0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3976FBB
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 10:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 16B1F5C011D;
	Sun, 17 Dec 2023 05:30:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 17 Dec 2023 05:30:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1702809022; x=
	1702895422; bh=zuT1CkGiLdT6oVSTIHR17WNH4PptubpxnOyzoYj857U=; b=W
	Bo7FkL2AwPXvHa40KrLdpILElFQK7ysX5Rdd9C+ESvBqiQH0UM1VRVNmlfbPYT+r
	V2rMkimslZnvyUC2FSuXbBV6J+UggE3/Tw6VSN7z2KUera1x63QbT1x/MT7NWA1U
	+VSADRs8M1sR40ezaePmu2xGXsS3JfTduykhMZ+6FJbO4K06GxLREb2K3dtCC8sw
	frB11UCPtc296UaFJ0qkRrW45/kYT3xqhYp6d1b2JITIOf3KYPOvvp4yYfi7xXXV
	epdjiYHxBWml0eJeyX5vWlo+B3Jc/SgUCSf2UqaV1jjeh84JF6BO/hwQWCZbXNvc
	LcO6pheSLyrIzZZgIG2oQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1702809022; x=
	1702895422; bh=zuT1CkGiLdT6oVSTIHR17WNH4PptubpxnOyzoYj857U=; b=j
	kJryLQ0fhJvwgnsAkGHT8zFdqlgWmpOozHDyK5JIeC1YOrGOfmi1KnRhGp8AMXRP
	U8hLKw+TIayJYkYCaspdZl0XR31wl+Z91TUf7COrbnSfCcovfcqHZSAaSVQcg3qt
	Va2FFmPJUCD3A+GbrShHMdgU3GGbmqaMcHb0TdDkUpiEju9uBRTuOgkZ3WnA4sN1
	LCIUMiaethl7HL1S3fZ7ll+3qxLgvnLmpr+VOVS5I/GdkvY7i0i05d6jazN5ylUI
	dseAo6fbbL1pgQu2QohhUy0jJDkNMSiRK/R0IwYyOt4HPP9znOavhEvV08edbZuK
	+HheYbfvtbxB9vwBI8CBQ==
X-ME-Sender: <xms:vc1-ZQE9RlNvhNJ77VVqw-eGXLitKVDgBUidxIRx-FZqPUHCnTD0Ug>
    <xme:vc1-ZZX7mPJi61hNykQdnGTPFLj3DEE1qtTfp-7UqAZOJcoJHEDMCUaKhrFhzfMC-
    OrL9C52q2WgzKTpLOc>
X-ME-Received: <xmr:vc1-ZaJU59dOSoBm-VrqFo3rNfYeUfc_hJarc_2IJU5HA-gA_W3lcj38C4qMEf8ipSTNtQ3Yd5g2jamkJqKMuI8-5v5JDw-AgIJ-50lpteWmiGI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtiedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeeugfevtd
    efhfeffeeuudduhfekhffgveejfeeiiefftdethfduudevjeekveffleenucffohhmrghi
    nhepthgvshhtrghnhihthhhinhhgrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhi
    rdhjph
X-ME-Proxy: <xmx:vc1-ZSEBxImL65VY1V2XCdDF9io3AkKgVYwCQgeqcAe5UJB7Q9SUgA>
    <xmx:vc1-ZWXlJ6aVfMYzlJMZ6L2hfarQmg0pOtejOwNxa9Dw7nt0N299BQ>
    <xmx:vc1-ZVMGGCeBPZ6BKkMv_vRhQstCdJISn4xGZIfitkJsDk7iLZAC_A>
    <xmx:vs1-ZZevE0Njs4uriwxE8Q_f98zEn0YR0s-5W6ZQrD-8QA6xlOVPcg>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 Dec 2023 05:30:20 -0500 (EST)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: adamg@pobox.com
Subject: [RFC PATCH 3/8] firewire: test: add KUnit test for internal CSR API
Date: Sun, 17 Dec 2023 19:30:06 +0900
Message-Id: <20231217103012.41273-4-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231217103012.41273-1-o-takashi@sakamocchi.jp>
References: <20231217103012.41273-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The operation over CSR space is important since it is related to detection
of nodes and units, addition of system devices. Any test of the operation
is enough useful.

This commit adds a skeleton of KUnit test for the purpose.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/.kunitconfig   |  1 +
 drivers/firewire/Kconfig        | 16 ++++++++++++++++
 drivers/firewire/core-device.c  |  4 ++++
 drivers/firewire/csr-api-test.c | 19 +++++++++++++++++++
 4 files changed, 40 insertions(+)
 create mode 100644 drivers/firewire/csr-api-test.c

diff --git a/drivers/firewire/.kunitconfig b/drivers/firewire/.kunitconfig
index 1599e069395f..03104cdd06eb 100644
--- a/drivers/firewire/.kunitconfig
+++ b/drivers/firewire/.kunitconfig
@@ -2,3 +2,4 @@ CONFIG_KUNIT=y
 CONFIG_PCI=y
 CONFIG_FIREWIRE=y
 CONFIG_FIREWIRE_KUNIT_UAPI_TEST=y
+CONFIG_FIREWIRE_KUNIT_CSR_API_TEST=y
diff --git a/drivers/firewire/Kconfig b/drivers/firewire/Kconfig
index 0a6596b027db..184906fdb77a 100644
--- a/drivers/firewire/Kconfig
+++ b/drivers/firewire/Kconfig
@@ -34,6 +34,22 @@ config FIREWIRE_KUNIT_UAPI_TEST
 	  For more information on KUnit and unit tests in general, refer
 	  to the KUnit documentation in Documentation/dev-tools/kunit/.
 
+config FIREWIRE_KUNIT_CSR_API_TEST
+	tristate "KUnit tests for internal CSR API" if !KUNIT_ALL_TESTS
+	depends on FIREWIRE && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This builds the KUnit tests for internal API for Control and
+	  Status Registers.
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
diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index 137001f8a695..14c7461c05f6 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -1313,3 +1313,7 @@ void fw_node_event(struct fw_card *card, struct fw_node *node, int event)
 		break;
 	}
 }
+
+#ifdef CONFIG_FIREWIRE_KUNIT_CSR_API_TEST
+#include "csr-api-test.c"
+#endif
diff --git a/drivers/firewire/csr-api-test.c b/drivers/firewire/csr-api-test.c
new file mode 100644
index 000000000000..a76d767373e9
--- /dev/null
+++ b/drivers/firewire/csr-api-test.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// csr-api-test.c - An application of Kunit to test implementation for CSR operation.
+//
+// Copyright (c) 2023 Takashi Sakamoto
+//
+// This file can not be built independently since it is intentionally included in core-device.c.
+
+#include <kunit/test.h>
+
+static struct kunit_case csr_api_test_cases[] = {
+	{}
+};
+
+static struct kunit_suite csr_api_test_suite = {
+	.name = "firewire-csr-api",
+	.test_cases = csr_api_test_cases,
+};
+kunit_test_suite(csr_api_test_suite);
-- 
2.39.2


