Return-Path: <linux-kernel+bounces-6355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C44BD8197A9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 05:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E8DC2823F3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371B614AA0;
	Wed, 20 Dec 2023 04:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="tyyrCZ1m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eCnm3MzZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF513125A2
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 04:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id E41B53200A71;
	Tue, 19 Dec 2023 23:18:20 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 19 Dec 2023 23:18:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1703045900; x=
	1703132300; bh=ALyVWm7/dGT5KixYxR7NqL6VJqyaNldFMTquZW7hL6k=; b=t
	yyrCZ1mldw5oxES3sSKlitze9mgR3g5YAr0G6vzD5mIFAXHDlH7vyeGvkRxI5WOi
	t9axlL3r7m/Kx5hFU6BJ6Z601tcReVXtQm5l8pjsnADfddjGWKPe2ewF054+KlTC
	YusJ9T6etzA9F7ArVMBv5fUxHv6CVIq29jrQaQ5LvbRLKx8JwPNdSN5uT8wJFU5P
	WCPFW1gO5PZ+U4u9zx/Y2R2OvQ7dMjMN1AJV7K/F7oVRXSu3d+Ej7KogMzZB5yvY
	I1HokEdznOyglWn365PQnzUrUcbfhu8YpLGaKgh7UyrIKBOR0hxyzAzbYSq7rFrP
	zwDODqXVzozUtdvvizAyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703045900; x=
	1703132300; bh=ALyVWm7/dGT5KixYxR7NqL6VJqyaNldFMTquZW7hL6k=; b=e
	Cnm3MzZWJiTerFmLesCAfuWaoh7k1VxoJ41Dqoqy8VgSjQJxZTlXn3I9gA4pOqnV
	0fpGI0r1GRKiykMPIV4m461q0wx+C9jxZZW+HUoJPlXY7onN6J2l4oK9tcC69kYA
	OTA5lYkLlhCOT/D8xf0ns5d/yilk5liyrsEILsI7T8GvhLL2XHcK3AvsiSdGJy28
	sO36uFvvu400env8d+4khvyEDFAgiDS60tkyer2HrMMqxM3yw+5Ai0aPWYy2fxax
	h5tLjVO2tzUscL78AdCNidv1I4PQ2xWqiJ4eBEjUzzPkYpwU6uudtXMMXKix6XpM
	xQv5zxyWh57wIa+61bsmg==
X-ME-Sender: <xms:DGuCZUxEErf0DnV_gHR8m9eOo_QdL45_BoZqPz50O2n5-8O1KxKoxw>
    <xme:DGuCZYR4KYIh1S0CgLqRgbRvO1l7zIIX6Aa61RanBKz94MJdvNSC1DtK_Z3a014my
    5MRmL5LfZ6Fae3uvOQ>
X-ME-Received: <xmr:DGuCZWVA_zaqiOXjbuPJKUJ_UotiUQ5s32HFwTmYMuot32Yw2zjTBVIcELM2fqgRLpUc5OduP93SERTcUscEP-usG-EwvRmkVWRj1u9Zztdv-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduuddgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeeugfevtd
    efhfeffeeuudduhfekhffgveejfeeiiefftdethfduudevjeekveffleenucffohhmrghi
    nhepthgvshhtrghnhihthhhinhhgrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhi
    rdhjph
X-ME-Proxy: <xmx:DGuCZSiViPYITeQ_sTkzFWByJaHbiLmKzmJJV-NIDxUtV6uNed3Tbw>
    <xmx:DGuCZWA2TRvANR6vjECvH4JQM1Q_LuMZ6mEnQrkDHXgfcQo-x2AbqA>
    <xmx:DGuCZTIDIeCC6ma9fGqRUF2ldPcO0wWYaZq6GWzF61iWb8-9zZm-uw>
    <xmx:DGuCZX4dXh5XPhfbl0a8mBTkGQZ03V8LdiRZO2MfjuTt14mkzpszTw>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Dec 2023 23:18:18 -0500 (EST)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: adamg@pobox.com
Subject: [PATCH 3/8] firewire: test: add KUnit test for device attributes
Date: Wed, 20 Dec 2023 13:18:01 +0900
Message-Id: <20231220041806.39816-4-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231220041806.39816-1-o-takashi@sakamocchi.jp>
References: <20231220041806.39816-1-o-takashi@sakamocchi.jp>
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


