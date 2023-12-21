Return-Path: <linux-kernel+bounces-8533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8459381B910
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C2B82859F8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2AF78E67;
	Thu, 21 Dec 2023 13:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="RUZiik/+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cgD2IAt6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE64B77F0D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 13:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id D11055C0245;
	Thu, 21 Dec 2023 08:49:04 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 21 Dec 2023 08:49:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1703166544; x=
	1703252944; bh=W8++sea8gpKHCOGyelCyTGYcLj9Ir33YrV0oYJ5xXSE=; b=R
	UZiik/+ck8ZzHIB7lL6s21SNYE+Ngd+LozderYS/PIpndT4Toj5lx6jIWExBXw6I
	1gp4PXOFkXTAn/ZKeMZM56exWQaXTh3OPBKw3r/NlGJqB3KPHtgNGH8EXL84wUkd
	5JmEdRkL2BAY+ceAk92FQXDC+4Gc1qMhqbFMqE6eSXa5Lbn0NTckb5e1Ty7Szvxf
	6VzVSO7KjmNEmIuHjY4Kkbv2It9XZUmaugEvfL7ehyS/i5W49xcUiozEtg+yafqg
	vNInN8l8o0D6c1h2ePTOtPY3EYI6siRLp7Y2bMTmF5L6id2tQTmxKZmq+pF3jkNg
	ntiUFvfzg7uZBI6k2wxrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703166544; x=
	1703252944; bh=W8++sea8gpKHCOGyelCyTGYcLj9Ir33YrV0oYJ5xXSE=; b=c
	gD2IAt6c6aWChOdUR0j84/+MaaKxq/URdhAfpe7raKyD9zzFhcmZiR3CrTI7NrUJ
	d2AXmpsmXfR7YV5MgWUNY2u/rJwmN2sYM/cbsdDJ1VbLnqDFx9udTEIdZk4maSHq
	gIpdg9yFwOecJHo95kgcPVELLRr8aD7d+fFQV9aM2/FbRI2VghojS3R8lrl71wR1
	frXnSggDSKe/83GC4gE8wR7AiYrACmVVQ9f7Bw/7eBH6snrhDUFBhn1fx9aQdjUS
	zE7OYbjZI00Yo1Ybf1Y2ZCJa86WKjfku07xCWeY903Vu3G/SEebH2A/3Z13S/FyJ
	F3P1Ys8mCCX2lHP4N12ig==
X-ME-Sender: <xms:UEKEZeP05umdr83bRx6iXQU_9IwsQEdqNM1geFMr2zcsRWK6PrYxOA>
    <xme:UEKEZc9SlPr_UwE43v0g1wLEpJeVb14Om6vmmHYmcPgZnVzzErG6DhbUN1V8rUaxw
    QvmRRq_aBAj7g990n8>
X-ME-Received: <xmr:UEKEZVSUwcPPJy7Zjsyr7DKPe2dNI_fQqjNSXl7n1W3OGyc9w4U-Y_gpTNkLzmgcLW1jYRgAKrvSf8yYW9fRxrVmDSyJO-hx5N_V6bl7VRy90g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduhedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:UEKEZesLAx80osSuAtqOs-o_pFZ8tprXNDiK-nnyk0L6gXawb76Tsg>
    <xmx:UEKEZWf56PO6CL4kLB7EiCvMjApFhAqnRJULilxDDa8Qx7Kjgfgj3g>
    <xmx:UEKEZS1XH-hTnZxA4fCiOrbkqiVD87XaHXfYoMzHCv_cSl_GlUK3Tw>
    <xmx:UEKEZaGJGa1mJfWv_7_b3wH0jCWEfay3kirHOVbUqGt61fdP3PUxPg>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Dec 2023 08:49:03 -0500 (EST)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: adamg@pobox.com
Subject: [PATCH v2 8/8] firewire: core: change modalias of unit device with backward incompatibility
Date: Thu, 21 Dec 2023 22:48:49 +0900
Message-Id: <20231221134849.603857-9-o-takashi@sakamocchi.jp>
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

As the last part of support for legacy layout of configuration ROM, this
commit traverses vendor directory as well as root directory when
constructing modalias for unit device. The change brings loss of backward
compatibility since it can fill model field ('mo') which is 0 at current
implementation in the case. However, we can be optimistic against
regression for unit drivers in kernel, due to some points:

1. ALSA drivers for audio and music units use the model fields to match
   device, however all of supported devices does not have such legacy
   layout.
2. the other unit drivers (e.g. sbp2) does not use the model field to
   match device.

The rest of concern is user space application. The most of applications
just take care of node device and does not use the modalias of unit
device, thus the change does not affect to them. But systemd project is
known to get affects from the change since it includes hwdb to take udev
to configure fw character device conveniently. I have a plan to work for
systemd so that the access permission of character device could be kept
across the change.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-device.c           | 21 +++++++++++++++++++--
 drivers/firewire/device-attribute-test.c |  2 +-
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index 029ba0ff7083..829b3d590ccd 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -153,8 +153,25 @@ static void get_ids(const u32 *directory, int *id)
 
 static void get_modalias_ids(const struct fw_unit *unit, int *id)
 {
-	get_ids(&fw_parent_device(unit)->config_rom[ROOT_DIR_OFFSET], id);
-	get_ids(unit->directory, id);
+	const u32 *root_directory = &fw_parent_device(unit)->config_rom[ROOT_DIR_OFFSET];
+	const u32 *directories[] = {NULL, NULL, NULL};
+	const u32 *vendor_directory;
+	int i;
+
+	directories[0] = root_directory;
+
+	// Legacy layout of configuration ROM described in Annex 1 of 'Configuration ROM for AV/C
+	// Devices 1.0 (December 12, 2000, 1394 Trading Association, TA Document 1999027)'.
+	vendor_directory = search_directory(root_directory, CSR_VENDOR);
+	if (!vendor_directory) {
+		directories[1] = unit->directory;
+	} else {
+		directories[1] = vendor_directory;
+		directories[2] = unit->directory;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(directories) && !!directories[i]; ++i)
+		get_ids(directories[i], id);
 }
 
 static bool match_ids(const struct ieee1394_device_id *id_table, int *id)
diff --git a/drivers/firewire/device-attribute-test.c b/drivers/firewire/device-attribute-test.c
index da2a4a09bf84..2f123c6b0a16 100644
--- a/drivers/firewire/device-attribute-test.c
+++ b/drivers/firewire/device-attribute-test.c
@@ -178,7 +178,7 @@ static void device_attr_legacy_avc(struct kunit *test)
 	};
 	struct device *node_dev = (struct device *)&node.device;
 	struct device *unit0_dev = (struct device *)&unit0.device;
-	static const int unit0_expected_ids[] = {0x00012345, 0x00000000, 0x00abcdef, 0x00543210};
+	static const int unit0_expected_ids[] = {0x00012345, 0x00fedcba, 0x00abcdef, 0x00543210};
 	char *buf = kunit_kzalloc(test, PAGE_SIZE, GFP_KERNEL);
 	int ids[4] = {0, 0, 0, 0};
 
-- 
2.39.2


