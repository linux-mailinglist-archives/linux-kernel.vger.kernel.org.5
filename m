Return-Path: <linux-kernel+bounces-2532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86986815E87
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 11:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 464511F2210C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 10:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD20653B5;
	Sun, 17 Dec 2023 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="QxVvzmHN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rIq1W5qf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324B310974
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 10:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 4CBB55C0126;
	Sun, 17 Dec 2023 05:30:28 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 17 Dec 2023 05:30:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1702809028; x=
	1702895428; bh=z73jY6BHHBYZhY9lJ5vLyunAPVGK9kE6VxjU8LqOq38=; b=Q
	xVvzmHNtLvMdgHrGxjwkBlFWXsuhhYJZaIIFCaKiGA/TzDXFuymTP2S+TDIKVNzz
	vPVa+UR4Ey13PcFMasMPcvpggQDTI33dlZfhQ0xVC8vsYlcQnF11gxVNTZUCiIyG
	7KmHgE3cu52fn0rl8M/7th2ESS4oOJgrjyakhb1naFZKD9Fuor868jUJTxRTaNQ2
	MYtwfXl3jmAe3xJ3vrtnDGfdx/yDkb1Y7PJhKJI1sCJWR+T63Gin9LplhXW8jzBH
	wPyI/eKYTT4xzkxDQOdmq/MwwmojxzCUDVybBCkz7x+94MC5tRWcTLx4K4J0DL9d
	dgpUZfYXy6/wWAA0tthxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1702809028; x=
	1702895428; bh=z73jY6BHHBYZhY9lJ5vLyunAPVGK9kE6VxjU8LqOq38=; b=r
	Iq1W5qfdH6+UiUFI6R6DIKEGU/rj7RiVJTS54GjkUqBl/rk9gsj3rBGqNJspMuVQ
	LJgHTfX23ssDoh/H9C+zpNsRDN4l49ncGyDNRInA/AcTIbsnf6aiM5BFZTJUjKWT
	iwOHEbv52l+k3Z2Qz95eovnI9DkwVyN82Nw+JK4MsD+yDA/PibvBymA/LKMYq5BK
	Vg1fdjZc4PJrMSGrbA/ylZZNu/rCibyx7lyPJN3PW0JcEfmLZ5kLB848qJIk9Kzn
	CMc3LAkmU8dTpOLAu5DacPCYS5yAvL1+aVtbxAdQdqqXzeMR6BMOVQ0aar5LwD9J
	Zp27HMvM6fKt+7TfYxdyw==
X-ME-Sender: <xms:xM1-ZVYM7kXFYKpu4np6WaJz1C-Z5fTY6Yvk1pw8iggA77bMGqdJ_g>
    <xme:xM1-ZcagruD_GIXPtFSMdNDUmXa4kVeSP3NfYJHCAfssFJ390tsBs1sgD8Ldp6Pmq
    pjpbOD1-EWtmCKJVU4>
X-ME-Received: <xmr:xM1-ZX-wtHCnvAJmItejaAwp-kjT3bw4c5fCdhzKhLs1rLP24WaTGUb6YhUz9zkUq0JshlkAm11wbJl1-tK0GnYu0-Z0QhDEB94TbeFhuG3iCKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtiedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:xM1-ZTqseG_u60pqxb8Y-267sAAIKMQczHEYhYM2Xb2k8spjUlQ9Iw>
    <xmx:xM1-ZQo12S7NxOOtAk4eZXd_VEDJpqnP0kfDdIj3Ee7QHAI98mc7ag>
    <xmx:xM1-ZZQtQSrV5eubT0h8Qg90gDFOwI06-SuP6PDmdGSHkWtbesn6pg>
    <xmx:xM1-ZdBEP1ekeawJFyQR_r6gBf3KKt_qQpKi4GZLixK5X6F31765dg>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 Dec 2023 05:30:26 -0500 (EST)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: adamg@pobox.com
Subject: [RFC PATCH 7/8] firewire: core: detect model name for legacy layout of configuration ROM
Date: Sun, 17 Dec 2023 19:30:10 +0900
Message-Id: <20231217103012.41273-8-o-takashi@sakamocchi.jp>
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

As the part of support for legacy layout of configuration ROM, this
commit traverse vendor directory as well as root directory when showing
device attribute for node device. This change expects 'model_name'
attribute appears in node device, however it is probable to see the other
types of descriptor leaf if the vendor directory includes.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-device.c  | 23 ++++++++++++++++-------
 drivers/firewire/csr-api-test.c |  5 +++--
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index dad5c9937b78..f7a11004f972 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -315,17 +315,25 @@ static ssize_t show_text_leaf(struct device *dev,
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
+
+		directories[0] = root_directory;
+
+		// Legacy layout of configuration ROM described in Annex 1 of 'Configuration ROM
+		// for AV/C Devices 1.0 (December 12, 2000, 1394 Trading Association, TA Document
+		// 1999027)'.
+		directories[1] = search_directory(root_directory, CSR_VENDOR);
+	}
 
 	if (buf) {
 		bufsize = PAGE_SIZE - 1;
@@ -334,7 +342,8 @@ static ssize_t show_text_leaf(struct device *dev,
 		bufsize = 1;
 	}
 
-	ret = fw_csr_string(dir, attr->key, buf, bufsize);
+	for (i = 0; i < ARRAY_SIZE(directories) && directories[i]; ++i)
+		ret = fw_csr_string(directories[i], attr->key, buf, bufsize);
 
 	if (ret >= 0) {
 		/* Strip trailing whitespace and add newline. */
diff --git a/drivers/firewire/csr-api-test.c b/drivers/firewire/csr-api-test.c
index 7278e7b927a8..779146d0cfba 100644
--- a/drivers/firewire/csr-api-test.c
+++ b/drivers/firewire/csr-api-test.c
@@ -206,8 +206,9 @@ static void csr_api_legacy_avc_device(struct kunit *test)
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


