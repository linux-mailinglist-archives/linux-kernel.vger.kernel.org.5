Return-Path: <linux-kernel+bounces-8532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E72481B90F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4474428A3C1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9402677F1C;
	Thu, 21 Dec 2023 13:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="gn9/+T1z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nbXav1BG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435897765B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 13:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 4C9E65C029E;
	Thu, 21 Dec 2023 08:49:03 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 21 Dec 2023 08:49:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1703166543; x=
	1703252943; bh=yHE5zsgLceNpgxeFsHAo6tPr0eHvDlNHIX4N5QhXKMY=; b=g
	n9/+T1zm0r7rE6Wj3SfL8zPH8MMsqPXuA8ftkHIqPT6T0OFnuhh/znjP8H6a0ZcC
	+BMmB+zsl0VRM+tsmd8H67kbT/O69QWyMkUkJREyXbt2Pe7vAAEELZLYh6vF9oQb
	3/d9jRrz8fd49YP4FTFFPyVOvp3LNL5//UQtTE6ZxVEQyh9viAvl7Cp2R8eQsy9g
	6+QYe/hG/A4M4QeMYOU7yWtX7ICKyryAd/+GHcvtAK0sL9rDzHl2o8cchAbFARKj
	Je062iCyzPj8+a8OpdfIo/J8nOCY5FvgyiuBiqVe78pU+9+jPKzU/cxJXsF1GyeL
	yUsG/zUEMtL1CnSgTjhlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703166543; x=
	1703252943; bh=yHE5zsgLceNpgxeFsHAo6tPr0eHvDlNHIX4N5QhXKMY=; b=n
	bXav1BGEfSrsh2PhdbzbS5sPp2C04K6cvOj+fyfrPHImsvK5bPWFA0ln5oqvjNKJ
	zYtFeAFBlC3lyJbGLUV2mD4ohwKIu6jaGsvpSlZbhNrn7GclxrY8j9/gWxRXJdtA
	wBlrLeIENDDG408cjEQWMnNM9F3IeQI9KNfYBtelj5AFV32tPntUGx5PsCwWydKz
	oNyMBVEYMCaQLpdkVoWOaEhE0pQFkU7ZJ+V7bBf5Ly0fYGv2LcdJFaWXmKP7c81k
	QuqNkqVqpJOdRqr4DGCEmGeM+WeKnV4cD9gQbQyD6dpkDr2WjhC/eL1ganptIrRk
	7JU59jmz918sWTIwZ/BjQ==
X-ME-Sender: <xms:T0KEZaj3lT0pkUJ1b_GCypYN72mtv1QtvpohiPjZIJShp7PEHOS5og>
    <xme:T0KEZbB-MTxounrR6GqqVlqPcSrQuiGp1A9yU_qx48WY75lHScQQn9KwK1jxghwTk
    G4xKXDX4m3GqQaQVzM>
X-ME-Received: <xmr:T0KEZSFphXp4fU152s1WCJgwYGBq7hnC_2LQ3QeCacP2LfkcA1d7lxim21_eOg8WCmx31DRZyAQJPvPhSAgvnyu3RWGpr8gBfL07QL1nwkNnzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduhedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:T0KEZTTVkNSPky-Zz3n4ta7cXUvJ5h1UuIQSKiXxB-YvFVtChhKOXA>
    <xmx:T0KEZXxDa4HVPoItj60j5W1VczVsvXIA7nyliG8ap_rYxxWpw3rslg>
    <xmx:T0KEZR7Ag7iqONV5eBFA8BG1dMRV7XxiIC52lLVgckLoHLN9w44UlQ>
    <xmx:T0KEZQrT8ZJWknlsc37BN1-Zfevu6FWyJHNou4mvmKYrE5UH_w5w_w>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Dec 2023 08:49:02 -0500 (EST)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: adamg@pobox.com
Subject: [PATCH v2 7/8] firewire: core: detect model name for legacy layout of configuration ROM
Date: Thu, 21 Dec 2023 22:48:48 +0900
Message-Id: <20231221134849.603857-8-o-takashi@sakamocchi.jp>
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
index d0ce583b93c4..029ba0ff7083 100644
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
+	int i, ret = -ENOENT;
 
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


