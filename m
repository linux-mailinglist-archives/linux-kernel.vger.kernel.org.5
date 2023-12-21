Return-Path: <linux-kernel+bounces-8531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4F181B90E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FC541C24176
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489BC760B6;
	Thu, 21 Dec 2023 13:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="QpEWwwjU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ku4pvmAk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0437760AF
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 13:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id DFA2C5C029C;
	Thu, 21 Dec 2023 08:49:01 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 21 Dec 2023 08:49:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1703166541; x=
	1703252941; bh=c3+SGtxjfpRsQL1FjnGhoxDOzKY9TE2Qa/7LRiK0mv4=; b=Q
	pEWwwjUClDCY/mWlyTEgqpG6Wf5JltVWpF8igK0t7Z4LKpcg3imHYwTToEWhd3M7
	TsITVqpcN7OpphkT6BPvGZbpeMkCOOUXqJfmoI+uwGdyS4FYCVnfS86WKCONWhTM
	YSD/Pj4O9oRndtoI38IChTb9CagMRsC6H/W+Pa3OZeUvKL3gfPy8J5emy7Fgw23S
	I9OFGUVxCThayWyLPf3KxiHqM8YrQIBmpbHsyZZzkJ+35nGPGF2a93BDt1R2zUOb
	L9lmeHcnARon2pS0KGM/mTYK5QxoYsEYCflsgpFRDA+E3QvznGr8tZ7TDNMBJcEi
	XQMNfJJJmpKzSfWAzbMnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703166541; x=
	1703252941; bh=c3+SGtxjfpRsQL1FjnGhoxDOzKY9TE2Qa/7LRiK0mv4=; b=K
	u4pvmAkydzmWA/OxvIpM6OcpgNLH7BRhnHT6568EL13zTbQmLc6/gHvEROrINTvf
	/wyV9JYIq2OPPy/xkaGrBUbIypf1gHYem4tTTYPA9pnU+05LUKDpDZkfCTgl7grL
	WQuJRBamWtrJlF1YqNILHo2yIY7ZFGR9Toy3683+Py53EIUIFZAZBz5w89N/JIQc
	w03YvFGUpicqF2rOThgrZYSjhkqSaMjQX3hie+SASE1A/4EIg7Q7HYZSEChL8O6o
	/J03huKfvbHbiWl1//4ILmzwjifcqXMRLSPS+zsp5n2qFCLDaVWuTBixhx6Ccg2A
	a1RrXpT0/PqdfsQhwB8bQ==
X-ME-Sender: <xms:TUKEZUvwam5YXN4m23t39A0gQUC09gxLHeQR44_199JHqRP3mX36ig>
    <xme:TUKEZRfOhe4CVDlM6wu19hSekujgDIJXceLFOuclyO7Od9-ySsu1vx81LwBe0UGRV
    0whTyOclS5_GciaZLk>
X-ME-Received: <xmr:TUKEZfzBtayubOyQwP238dFuG2lYsnlmgfE44WjcfOevdhU13-xfAEcq9VWZbhtLZq-3M2kQIWrSqiMkSbiYYLzIsqOosSN8PwUT19mrynUnmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduhedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:TUKEZXNs33atoJ2M_m4sJRGEr18tTluEB6ic9X5-vkjRFFP2kmP6Ng>
    <xmx:TUKEZU9D2Eg95V7uUAb5FK6pI6v2mjZ1lz3mJdNCBNCGHhEdjl5Bjw>
    <xmx:TUKEZfU-SGBaz_acAaw0o-9tyhfFtGBSPC-FDycHbemF1cPUz-MXqw>
    <xmx:TUKEZSlzHkzl9xh1SC1Vo7xCeJ4-WUR386QJMLN9pMSpoCt9k_dwvw>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Dec 2023 08:49:00 -0500 (EST)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: adamg@pobox.com
Subject: [PATCH v2 6/8] firewire: core: detect numeric model identifier for legacy layout of configuration ROM
Date: Thu, 21 Dec 2023 22:48:47 +0900
Message-Id: <20231221134849.603857-7-o-takashi@sakamocchi.jp>
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
device attribute for node device. This change expects 'model' attribute
appears in node device, however it is probable to see the other types of
immediate values if the vendor directory includes.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-device.c           | 59 ++++++++++++++++++------
 drivers/firewire/device-attribute-test.c |  5 +-
 2 files changed, 49 insertions(+), 15 deletions(-)

diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index fe1e64df476c..d0ce583b93c4 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -49,6 +49,22 @@ int fw_csr_iterator_next(struct fw_csr_iterator *ci, int *key, int *value)
 }
 EXPORT_SYMBOL(fw_csr_iterator_next);
 
+static const u32 *search_directory(const u32 *directory, int search_key)
+{
+	struct fw_csr_iterator ci;
+	int key, value;
+
+	search_key |= CSR_DIRECTORY;
+
+	fw_csr_iterator_init(&ci, directory);
+	while (fw_csr_iterator_next(&ci, &key, &value)) {
+		if (key == search_key)
+			return ci.p - 1 + value;
+	}
+
+	return NULL;
+}
+
 static const u32 *search_leaf(const u32 *directory, int search_key)
 {
 	struct fw_csr_iterator ci;
@@ -253,27 +269,44 @@ static ssize_t show_immediate(struct device *dev,
 	struct config_rom_attribute *attr =
 		container_of(dattr, struct config_rom_attribute, attr);
 	struct fw_csr_iterator ci;
-	const u32 *dir;
-	int key, value, ret = -ENOENT;
+	const u32 *directories[] = {NULL, NULL};
+	int i, value = -1;
 
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
 
-	fw_csr_iterator_init(&ci, dir);
-	while (fw_csr_iterator_next(&ci, &key, &value))
-		if (attr->key == key) {
-			ret = snprintf(buf, buf ? PAGE_SIZE : 0,
-				       "0x%06x\n", value);
-			break;
+		if (!vendor_directory) {
+			directories[0] = root_directory;
+		} else {
+			// Legacy layout of configuration ROM described in Annex 1 of
+			// 'Configuration ROM for AV/C Devices 1.0 (December 12, 2000, 1394 Trading
+			// Association, TA Document 1999027)'.
+			directories[0] = vendor_directory;
+			directories[1] = root_directory;
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(directories) && !!directories[i]; ++i) {
+		int key, val;
+
+		fw_csr_iterator_init(&ci, directories[i]);
+		while (fw_csr_iterator_next(&ci, &key, &val)) {
+			if (attr->key == key)
+				value = val;
 		}
+	}
 
 	up_read(&fw_device_rwsem);
 
-	return ret;
+	if (value < 0)
+		return -ENOENT;
+
+	return snprintf(buf, buf ? PAGE_SIZE : 0, "0x%06x\n", value);
 }
 
 #define IMMEDIATE_ATTR(name, key)				\
diff --git a/drivers/firewire/device-attribute-test.c b/drivers/firewire/device-attribute-test.c
index 495af65c33b5..689115433425 100644
--- a/drivers/firewire/device-attribute-test.c
+++ b/drivers/firewire/device-attribute-test.c
@@ -199,8 +199,9 @@ static void device_attr_legacy_avc(struct kunit *test)
 	KUNIT_EXPECT_GT(test, show_immediate(node_dev, &config_rom_attributes[0].attr, buf), 0);
 	KUNIT_EXPECT_STREQ(test, buf, "0x012345\n");
 
-	// Model immediate entry is not found.
-	KUNIT_EXPECT_LT(test, show_immediate(node_dev, &config_rom_attributes[4].attr, buf), 0);
+	// Model immediate entry is found.
+	KUNIT_EXPECT_GT(test, show_immediate(node_dev, &config_rom_attributes[4].attr, buf), 0);
+	KUNIT_EXPECT_STREQ(test, buf, "0xfedcba\n");
 
 	// Descriptor leaf entry for vendor is not found.
 	KUNIT_EXPECT_LT(test, show_text_leaf(node_dev, &config_rom_attributes[5].attr, buf), 0);
-- 
2.39.2


