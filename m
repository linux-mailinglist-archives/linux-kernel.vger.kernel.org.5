Return-Path: <linux-kernel+bounces-8530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 962CB81B90D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C874B218A8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE55177640;
	Thu, 21 Dec 2023 13:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="jteC3Olc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QBJ6jDRJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA9E651BA
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 13:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 5160C5C0297;
	Thu, 21 Dec 2023 08:49:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 21 Dec 2023 08:49:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1703166540; x=
	1703252940; bh=3EzlJFfSkML/ta9lyeEKf9o6eumBFTgrZNdRmkxbQEo=; b=j
	teC3OlcSZp7DWYnmvMUCzJwViMIdUt3B3DUSCxyYV67REqbtnOCO59oXKeRY9eOv
	1Rd13daI+weZgSYaGRSJyzAyNzkhek6IO7aeNZtfqZEDUq/yTqJRUSsLv3fsEFzR
	bkefIBGHZGc2/ucszO2VR79N1zduZqbCIwCYFquIjlu/kFi4nOWNHcG9v+dag3Nn
	+i+2AuugkFpGE663kN7+wDcYhMYF22uisgPI04IsgRcPkOtK1JDuaXyBN3pQ/o+S
	Zl3gJpSkH/OuUKq+CVmddr7ecd+u7tG9YNcwpLB2Mft38F3lvAVh7p/hFRsHgWtB
	UrImDIl2t0rSj/LCj1t3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703166540; x=
	1703252940; bh=3EzlJFfSkML/ta9lyeEKf9o6eumBFTgrZNdRmkxbQEo=; b=Q
	BJ6jDRJjAe1xJnUsI6aHfSY728ddOMU1uynIMQ3B7kE91HH1bHOc1P4ub9ayNIY7
	xa10ThrpFJz3o1hSPJDpM3avU4bymJD4NFQyvohIae1jEbOOS+NGzb3kt6HJ2/ud
	/3rnFlDs+xS70YVJ8ONu6Ce/JPKtQ3AsqCAr4oEhAbXVqYAXbkw6m5UdTmdepBAn
	Vvd6+X5GFEI3qF1MqeDo9WdT7v/cJF9zzQZjtK7VyIZFB0X+R8dom8PJl+KHdEV1
	7CIHs8B1RgwG+bov2Y1lS7JLDj9YEJll4puFam9mglmn8rxIEGj7mYjOzL7c4xHC
	pCluntaoKTDcr6ZC1wxYw==
X-ME-Sender: <xms:TEKEZXsQuIEDIPjygnZ_aNfMddqNr85DohAE778P7O2adsNWODMEkA>
    <xme:TEKEZYeih7364V1ylOUafdTn-B8TAjmcisjTasU5-8Qbe8pvWjQn7TVXdFqa_zlY8
    CkXWUyLyzHvyhmue0g>
X-ME-Received: <xmr:TEKEZazVmWy_9yJ6GkfJo6jm4kIMJ56KzkQalb46dDBr2er0TgpO7nVn4zIfAurWo2JnobCFH6IqVtCWD7uPDpHkZeZM2OdaCnYDN_fpNG_dWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduhedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeffvefhff
    dugeetkeektdegheejheegteegffeihfevvefggfeuueekvdeffeehfeenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgpdguvghvihgtvgdrughirhgvtghtohhrhienucevlhhush
    htvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhi
    sehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:TEKEZWPu69rZRZRKiagqHakYqk4-0YfxUdTdIDI1yrN4fySVCjGc5w>
    <xmx:TEKEZX82KQgtXiVJJBjJuxOPgy2w3cBbHigAsW1P2kaTQB7I9cDcVA>
    <xmx:TEKEZWXqfGClBCBYR34xC1cvecMT6p8HVdnj5UxrLXWgwpW_bch63g>
    <xmx:TEKEZRlDH84kSd0mYuCMUt5rluwIBt4O5guKuptkaM-fYp3fYN2-aw>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Dec 2023 08:48:58 -0500 (EST)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: adamg@pobox.com
Subject: [PATCH v2 5/8] firewire: test: add test of device attributes for legacy AV/C device
Date: Thu, 21 Dec 2023 22:48:46 +0900
Message-Id: <20231221134849.603857-6-o-takashi@sakamocchi.jp>
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

Some legacy devices have configuration ROM against standard AV/C device.
They have vendor directory to store model identifier. It is described in
annex of the following document.

- Configuration ROM for AV/C Devices 1.0 (Dec. 12, 2000, 1394 Trading
  Association)

In the case, current implementation of core function does not detect the
model identifier, thus device attributes and modalias of unit have lack of
it. Another KUnit test is required for the case, and this commit is for
the purpose.

The following output is the parse result for the hard-coded data, by
config-rom-pretty-printer in linux-firewire-utils
(https://git.kernel.org/pub/scm/utils/ieee1394/linux-firewire-utils.git/).
The data is written by my hand.

$ config-rom-pretty-printer < /tmp/rom.img
               ROM header and bus information block
               -----------------------------------------------------------------
1024  04199fe7  bus_info_length 4, crc_length 25, crc 40935
1028  31333934  bus_name "1394"
1032  e0644000  irmc 1, cmc 1, isc 1, bmc 0, cyc_clk_acc 100, max_rec 4 (32)
1036  00112233  company_id 001122     |
1040  44556677  device_id 220189779575  | EUI-64 4822678189205111

               root directory
               -----------------------------------------------------------------
1044  0005dace  directory_length 5, crc 56014
1048  03012345  vendor
1052  0c0083c0  node capabilities: per IEEE 1394
1056  8d000009  --> eui-64 leaf at 1092
1060  d1000002  --> unit directory at 1068
1064  c3000004  --> vendor directory at 1080

               unit directory at 1068
               -----------------------------------------------------------------
1068  0002e107  directory_length 2, crc 57607
1072  12abcdef  specifier id
1076  13543210  version

               vendor directory at 1080
               -----------------------------------------------------------------
1080  0002cb73  directory_length 2, crc 52083
1084  17fedcba  model
1088  81000004  --> descriptor leaf at 1104

               eui-64 leaf at 1092
               -----------------------------------------------------------------
1092  00026dc1  leaf_length 2, crc 28097
1096  00112233  company_id 001122     |
1100  44556677  device_id 220189779575  | EUI-64 4822678189205111

               descriptor leaf at 1104
               -----------------------------------------------------------------
1104  00050e84  leaf_length 5, crc 3716
1108  00000000  textual descriptor
1112  00000000  minimal ASCII
1116  41424344  "ABCD"
1120  45464748  "EFGH"
1124  494a0000  "IJ"

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/device-attribute-test.c | 111 +++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/drivers/firewire/device-attribute-test.c b/drivers/firewire/device-attribute-test.c
index e2c5587d0757..495af65c33b5 100644
--- a/drivers/firewire/device-attribute-test.c
+++ b/drivers/firewire/device-attribute-test.c
@@ -45,6 +45,40 @@ static const u32 simple_avc_config_rom[] = {
 	0x6d650000,
 };
 
+// Ibid.
+// Annex A:Consideration for configuration ROM reader design (informative)
+// A.1 Vendor directory
+//
+// Written by hand.
+static const u32 legacy_avc_config_rom[] = {
+	0x04199fe7,
+	0x31333934,
+	0xe0644000,
+	0x00112233,
+	0x44556677,
+	0x0005dace, // root directory.
+	0x03012345,
+	0x0c0083c0,
+	0x8d000009,
+	0xd1000002,
+	0xc3000004,
+	0x0002e107, // unit 0 directory.
+	0x12abcdef,
+	0x13543210,
+	0x0002cb73, // vendor directory.
+	0x17fedcba,
+	0x81000004,
+	0x00026dc1, // leaf for EUI-64.
+	0x00112233,
+	0x44556677,
+	0x00050e84, // leaf for textual descriptor.
+	0x00000000,
+	0x00000000,
+	0x41424344,
+	0x45464748,
+	0x494a0000,
+};
+
 static void device_attr_simple_avc(struct kunit *test)
 {
 	static const struct fw_device node = {
@@ -126,8 +160,85 @@ static void device_attr_simple_avc(struct kunit *test)
 	KUNIT_EXPECT_MEMEQ(test, ids, unit0_expected_ids, sizeof(ids));
 }
 
+static void device_attr_legacy_avc(struct kunit *test)
+{
+	static const struct fw_device node = {
+		.device = {
+			.type = &fw_device_type,
+		},
+		.config_rom = legacy_avc_config_rom,
+		.config_rom_length = sizeof(legacy_avc_config_rom),
+	};
+	static const struct fw_unit unit0 = {
+		.device = {
+			.type = &fw_unit_type,
+			.parent = (struct device *)&node.device,
+		},
+		.directory = &legacy_avc_config_rom[11],
+	};
+	struct device *node_dev = (struct device *)&node.device;
+	struct device *unit0_dev = (struct device *)&unit0.device;
+	static const int unit0_expected_ids[] = {0x00012345, 0x00000000, 0x00abcdef, 0x00543210};
+	char *buf = kunit_kzalloc(test, PAGE_SIZE, GFP_KERNEL);
+	int ids[4] = {0, 0, 0, 0};
+
+	// Ensure associations for node and unit devices.
+
+	KUNIT_ASSERT_TRUE(test, is_fw_device(node_dev));
+	KUNIT_ASSERT_FALSE(test, is_fw_unit(node_dev));
+	KUNIT_ASSERT_PTR_EQ(test, fw_device((node_dev)), &node);
+
+	KUNIT_ASSERT_FALSE(test, is_fw_device(unit0_dev));
+	KUNIT_ASSERT_TRUE(test, is_fw_unit(unit0_dev));
+	KUNIT_ASSERT_PTR_EQ(test, fw_parent_device((&unit0)), &node);
+	KUNIT_ASSERT_PTR_EQ(test, fw_unit(unit0_dev), &unit0);
+
+	// For entries in root directory.
+
+	// Vendor immediate entry is found.
+	KUNIT_EXPECT_GT(test, show_immediate(node_dev, &config_rom_attributes[0].attr, buf), 0);
+	KUNIT_EXPECT_STREQ(test, buf, "0x012345\n");
+
+	// Model immediate entry is not found.
+	KUNIT_EXPECT_LT(test, show_immediate(node_dev, &config_rom_attributes[4].attr, buf), 0);
+
+	// Descriptor leaf entry for vendor is not found.
+	KUNIT_EXPECT_LT(test, show_text_leaf(node_dev, &config_rom_attributes[5].attr, buf), 0);
+
+	// Descriptor leaf entry for model is not found.
+	KUNIT_EXPECT_LT(test, show_text_leaf(node_dev, &config_rom_attributes[6].attr, buf), 0);
+
+	// For entries in unit 0 directory.
+
+	// Vendor immediate entry is not found.
+	KUNIT_EXPECT_LT(test, show_immediate(unit0_dev, &config_rom_attributes[0].attr, buf), 0);
+
+	// Model immediate entry is not found.
+	KUNIT_EXPECT_LT(test, show_immediate(unit0_dev, &config_rom_attributes[4].attr, buf), 0);
+
+	// Descriptor leaf entry for vendor is not found.
+	KUNIT_EXPECT_LT(test, show_text_leaf(unit0_dev, &config_rom_attributes[5].attr, buf), 0);
+
+	// Descriptor leaf entry for model is not found.
+	KUNIT_EXPECT_LT(test, show_text_leaf(unit0_dev, &config_rom_attributes[6].attr, buf), 0);
+
+	// Specifier_ID immediate entry is found.
+	KUNIT_EXPECT_GT(test, show_immediate(unit0_dev, &config_rom_attributes[2].attr, buf), 0);
+	KUNIT_EXPECT_STREQ(test, buf, "0xabcdef\n");
+
+	// Version immediate entry is found.
+	KUNIT_EXPECT_GT(test, show_immediate(unit0_dev, &config_rom_attributes[3].attr, buf), 0);
+	KUNIT_EXPECT_STREQ(test, buf, "0x543210\n");
+
+	kunit_kfree(test, buf);
+
+	get_modalias_ids(&unit0, ids);
+	KUNIT_EXPECT_MEMEQ(test, ids, unit0_expected_ids, sizeof(ids));
+}
+
 static struct kunit_case device_attr_test_cases[] = {
 	KUNIT_CASE(device_attr_simple_avc),
+	KUNIT_CASE(device_attr_legacy_avc),
 	{}
 };
 
-- 
2.39.2


