Return-Path: <linux-kernel+bounces-6359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6FC8197AD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 05:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 581932850E3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B5B1DA38;
	Wed, 20 Dec 2023 04:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="W225XQu2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jDImt9U6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2493B1CF91
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 04:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 2F3D13200A30;
	Tue, 19 Dec 2023 23:18:32 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 19 Dec 2023 23:18:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1703045911; x=
	1703132311; bh=sjjjefL0YuZeCDEla/9R8UiAeKIsBwn7UqHFh3/lofs=; b=W
	225XQu2m6vWAYoKRd4NM++hCM4eASw9S6K3Fx3778pgZM5Ll0utI3UamMcJ/XNcl
	wrngppSs3+p2T4kD0YEggkwEpmrFWmRXgxD9T3E5HKb6nlBLY3FgDeMrrYKIIZHW
	anTxlzQzDinS68G7M8+8jwQGGioR28MMormZjIicM+e8dy/4eiekfLAoEbiUd2xT
	Uj1mGxnjeu02kebSP8bmNNLPnAlBcYMkFM+/iBgzo/2qahn6x8oUUsl8BntYwlwj
	kj1MfDVFTLOoZ9CTE1RxIJVH4UOHDfv0TIpx+Gr0trQsltbZN7T275+tNmViR1pa
	p1i5xjHaVsHqG/XQGmcug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703045911; x=
	1703132311; bh=sjjjefL0YuZeCDEla/9R8UiAeKIsBwn7UqHFh3/lofs=; b=j
	DImt9U64mM2RRxEIRNkLbo9qw7T0r2fGxcz+ZXYAqmu/jvs8YuOGH69RYWjjuEDW
	1fu77sdhyx0sukoz5Tco6vWgMd7QFvhjzqf3dkLydFREeIgKcnFlYWx/vFCmEe5S
	0BRI/E142dpqMC0m3rPas1W25eIf1ofhHEYrzpCQ0HrqOjlLekiQZupY9OWvzqEn
	+3UENhDgBrqsS0Y1rdmnI5XqjPg8CkzDp7YdR+c8HM8YUV4Bw1fJ9CkpTB6zrOrl
	kd3QRd27Cd+eM+ZTKHdEpR2r9ZEnhyANNMYASkGu4U8mMBOqgd4QvSdcpLQuun0Q
	l9ShV9yHn7RctKmjiowVA==
X-ME-Sender: <xms:F2uCZS8gpikRo1Gr9BiRHPU69S3P1c-q5smNRA7kPySsN0YNdpT9YQ>
    <xme:F2uCZSsK8LGNE3l2ZxTYYQe5ROMWL295mqqY-14X6dTFDQSThXhOnQLQbYHfvw_zu
    iSzc3EFRMoyoUpe7WQ>
X-ME-Received: <xmr:F2uCZYBOWw1s03IucCg7U0ModYZ7zIpnX3dyyGiSiZFFm6K7gJBlMFjm9OCFs7_B7ALzueOC90_RiIWUZsOoQ6LDYLmgJhhn82Klikre3mESBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduuddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:F2uCZafYSltlZKOasMRtT980mGLnBgmBmTuDfb_qi-ws1H39jYUccw>
    <xmx:F2uCZXMNvOWyOrC9_wns-HEFmnWn8Xj5nOJq2o-_wpHlpGaJuBg-Mw>
    <xmx:F2uCZUmoEWYIduSVzuGcmbgNG6qga9i7FsF41NKTm7VaZDHFBVdhFA>
    <xmx:F2uCZd2xr2WZbvQsDbM7qJp4bbbuDyL78Dtf7Z_ryfLdMPOU-NXSNA>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Dec 2023 23:18:30 -0500 (EST)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: adamg@pobox.com
Subject: [PATCH 7/8] firewire: core: detect model name for legacy layout of configuration ROM
Date: Wed, 20 Dec 2023 13:18:05 +0900
Message-Id: <20231220041806.39816-8-o-takashi@sakamocchi.jp>
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

As the part of support for legacy layout of configuration ROM, this
commit traverses vendor directory as well as root directory when showing
device attribute for node device. This change expects 'model_name'
attribute appears in node device, however it is probable to see the other
types of descriptor leaf if the vendor directory includes.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-device.c           | 31 ++++++++++++++++++------
 drivers/firewire/device-attribute-test.c |  5 ++--
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index d0ce583b93c4..2bc6c874e89c 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -317,17 +317,29 @@ static ssize_t show_text_leaf(struct device *dev,
 {
 	struct config_rom_attribute *attr =
 		container_of(dattr, struct config_rom_attribute, attr);
-	const u32 *dir;
+	const u32 *directories[] = {NULL, NULL};
 	size_t bufsize;
 	char dummy_buf[2];
-	int ret;
+	int i, ret;
 
 	down_read(&fw_device_rwsem);
 
-	if (is_fw_unit(dev))
-		dir = fw_unit(dev)->directory;
-	else
-		dir = fw_device(dev)->config_rom + ROOT_DIR_OFFSET;
+	if (is_fw_unit(dev)) {
+		directories[0] = fw_unit(dev)->directory;
+	} else {
+		const u32 *root_directory = fw_device(dev)->config_rom + ROOT_DIR_OFFSET;
+		const u32 *vendor_directory = search_directory(root_directory, CSR_VENDOR);
+
+		if (!vendor_directory) {
+			directories[0] = root_directory;
+		} else {
+			// Legacy layout of configuration ROM described in Annex 1 of
+			// 'Configuration ROM for AV/C Devices 1.0 (December 12, 2000, 1394
+			// Trading Association, TA Document 1999027)'.
+			directories[0] = root_directory;
+			directories[1] = vendor_directory;
+		}
+	}
 
 	if (buf) {
 		bufsize = PAGE_SIZE - 1;
@@ -336,7 +348,12 @@ static ssize_t show_text_leaf(struct device *dev,
 		bufsize = 1;
 	}
 
-	ret = fw_csr_string(dir, attr->key, buf, bufsize);
+	for (i = 0; i < ARRAY_SIZE(directories) && !!directories[i]; ++i) {
+		int result = fw_csr_string(directories[i], attr->key, buf, bufsize);
+		// Detected.
+		if (result >= 0)
+			ret = result;
+	}
 
 	if (ret >= 0) {
 		/* Strip trailing whitespace and add newline. */
diff --git a/drivers/firewire/device-attribute-test.c b/drivers/firewire/device-attribute-test.c
index 689115433425..da2a4a09bf84 100644
--- a/drivers/firewire/device-attribute-test.c
+++ b/drivers/firewire/device-attribute-test.c
@@ -206,8 +206,9 @@ static void device_attr_legacy_avc(struct kunit *test)
 	// Descriptor leaf entry for vendor is not found.
 	KUNIT_EXPECT_LT(test, show_text_leaf(node_dev, &config_rom_attributes[5].attr, buf), 0);
 
-	// Descriptor leaf entry for model is not found.
-	KUNIT_EXPECT_LT(test, show_text_leaf(node_dev, &config_rom_attributes[6].attr, buf), 0);
+	// Descriptor leaf entry for model is found.
+	KUNIT_EXPECT_GT(test, show_text_leaf(node_dev, &config_rom_attributes[6].attr, buf), 0);
+	KUNIT_EXPECT_STREQ(test, buf, "ABCDEFGHIJ\n");
 
 	// For entries in unit 0 directory.
 
-- 
2.39.2


