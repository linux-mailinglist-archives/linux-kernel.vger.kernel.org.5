Return-Path: <linux-kernel+bounces-8528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DA181B90A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 484C8B25DDF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB140745F1;
	Thu, 21 Dec 2023 13:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="BfOvB/bc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fBRpnMnc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0176D6F2
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 13:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 375655C014E;
	Thu, 21 Dec 2023 08:48:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 21 Dec 2023 08:48:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1703166537; x=
	1703252937; bh=ALyVWm7/dGT5KixYxR7NqL6VJqyaNldFMTquZW7hL6k=; b=B
	fOvB/bcjpVh9NapV+lTT63YGhg5xcUFI7RTheTspm8D3vY5nA6n/avarYfBPrmRD
	r9eCvk+DPJ0n/zl3YrMozcalpCexqptYCMf/z79tv96Jk3fZx8WKsuZrbrJ7daTD
	j1pi2rwEinkD6m5B3p5jojV2bQxTTqRy0ppydD6oX27C2qHaVvsOYRV9G2TMI4Uo
	fVJIvmgqHFE+NKQa2JDHj+AZU7i92eVOFWEoUNvpCqPMpDOJNatdDdhluquWW6sm
	cGE/PbuwTGytUrS69JT6DD4dxQky8BNlb70WOSjl7ZpdJwwEvIRKT0lDHj2q8PyA
	eBvGpqyZEtyncCxczSCAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703166537; x=
	1703252937; bh=ALyVWm7/dGT5KixYxR7NqL6VJqyaNldFMTquZW7hL6k=; b=f
	BRpnMncBb1krTat9dI8YIVk3rdL5SFSMzlBSBDGuj1u+rcL9n5ApgIpTZ0gcKevl
	kE+UiiLL5ciovqJMpg5N2b/c44dijGRZpw8wD+Fq8IaHr+TMKSO0zV359T2jbJE6
	HT+/ddI9mkPEtszTLWnKtWjNdHsyZwyAFKGjoU+7p61Ylk2mrthcRcHEdkNhDkQc
	vkGaGd9wHTWKQuK+hVYs63ohsTDRhBVUDw+Gt5f5POPHvKbdKv2Y5OB9s2lY9SqR
	fOPa9/xNok21/03lz0oy4nmkAk4e/M75TUFFc8YAn6RTvH+TxpHBGlz73qxtt33Z
	dQ7qdekXjT9mlU0Op6GVQ==
X-ME-Sender: <xms:SUKEZTVPHUEMk_Mfr7j_M6_cC92rLiCMuNmZ5jp8Y-BF30yTK-khOQ>
    <xme:SUKEZblzdlGyaL33_A4AMDTY6E_78vMzXyvm3jgDegVlGLert89GPv2wIHcu7RsLo
    uJCuERpZlnLeh1h9pc>
X-ME-Received: <xmr:SUKEZfbTUy-8viKw-lS66lxJJAvMpllhb7QtRfLuDsYFiAskPUHh01bEyL8gaYfviAlJOgApvzy7MX7mZVu75cWpEGwRSdBmGqMSL5olMLthbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduhedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeeugfevtd
    efhfeffeeuudduhfekhffgveejfeeiiefftdethfduudevjeekveffleenucffohhmrghi
    nhepthgvshhtrghnhihthhhinhhgrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhi
    rdhjph
X-ME-Proxy: <xmx:SUKEZeWvy3aSvqZoar3Br5OgtrfzvN0K8xp-pSeMx8062IRzeqWqTA>
    <xmx:SUKEZdlmIY7XAgMix_8eS445z54nvh-Lhm0tGOIdMPBYmjlh33XDqA>
    <xmx:SUKEZbdckgXdIb1XfIXO6DYyazTc4fSP6yUT2WxBx4gc_dcpznVc1Q>
    <xmx:SUKEZdvy8JS1Qug7myWH4Ey2mbigFgtvDq1jm0b2-WmCAEejVgVHsw>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Dec 2023 08:48:55 -0500 (EST)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: adamg@pobox.com
Subject: [PATCH v2 3/8] firewire: test: add KUnit test for device attributes
Date: Thu, 21 Dec 2023 22:48:44 +0900
Message-Id: <20231221134849.603857-4-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231221134849.603857-1-o-takashi@sakamocchi.jp>
References: <20231221134849.603857-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The traverse over CSR space results in attributes of node and unit
devices. Any test of the traverse is useful.

This commit adds a skeleton of KUnit test for the purpose.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/.kunitconfig            |  1 +
 drivers/firewire/Kconfig                 | 16 ++++++++++++++++
 drivers/firewire/core-device.c           |  4 ++++
 drivers/firewire/device-attribute-test.c | 19 +++++++++++++++++++
 4 files changed, 40 insertions(+)
 create mode 100644 drivers/firewire/device-attribute-test.c

diff --git a/drivers/firewire/.kunitconfig b/drivers/firewire/.kunitconfig
index 1599e069395f..76444a2d5e12 100644
--- a/drivers/firewire/.kunitconfig
+++ b/drivers/firewire/.kunitconfig
@@ -2,3 +2,4 @@ CONFIG_KUNIT=y
 CONFIG_PCI=y
 CONFIG_FIREWIRE=y
 CONFIG_FIREWIRE_KUNIT_UAPI_TEST=y
+CONFIG_FIREWIRE_KUNIT_DEVICE_ATTRIBUTE_TEST=y
diff --git a/drivers/firewire/Kconfig b/drivers/firewire/Kconfig
index 0a6596b027db..552a39df8cbd 100644
--- a/drivers/firewire/Kconfig
+++ b/drivers/firewire/Kconfig
@@ -34,6 +34,22 @@ config FIREWIRE_KUNIT_UAPI_TEST
 	  For more information on KUnit and unit tests in general, refer
 	  to the KUnit documentation in Documentation/dev-tools/kunit/.
 
+config FIREWIRE_KUNIT_DEVICE_ATTRIBUTE_TEST
+	tristate "KUnit tests for device attributes" if !KUNIT_ALL_TESTS
+	depends on FIREWIRE && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This builds the KUnit tests for device attribute for node and
+	  unit.
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
index 315a2fe41643..fe1e64df476c 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -1313,3 +1313,7 @@ void fw_node_event(struct fw_card *card, struct fw_node *node, int event)
 		break;
 	}
 }
+
+#ifdef CONFIG_FIREWIRE_KUNIT_DEVICE_ATTRIBUTE_TEST
+#include "device-attribute-test.c"
+#endif
diff --git a/drivers/firewire/device-attribute-test.c b/drivers/firewire/device-attribute-test.c
new file mode 100644
index 000000000000..87cfdf97c898
--- /dev/null
+++ b/drivers/firewire/device-attribute-test.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// device-attribute-test.c - An application of Kunit to test implementation for device attributes.
+//
+// Copyright (c) 2023 Takashi Sakamoto
+//
+// This file can not be built independently since it is intentionally included in core-device.c.
+
+#include <kunit/test.h>
+
+static struct kunit_case device_attr_test_cases[] = {
+	{}
+};
+
+static struct kunit_suite device_attr_test_suite = {
+	.name = "firewire-device-attribute",
+	.test_cases = device_attr_test_cases,
+};
+kunit_test_suite(device_attr_test_suite);
-- 
2.39.2


