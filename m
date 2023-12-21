Return-Path: <linux-kernel+bounces-8529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A732F81B90B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B042B2186C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034AB745EE;
	Thu, 21 Dec 2023 13:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="aOkLT8HO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vuRwiGJJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0CA6D6DB
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 13:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id C1EB65C01C6;
	Thu, 21 Dec 2023 08:48:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 21 Dec 2023 08:48:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1703166538; x=
	1703252938; bh=+JyhqIbPXo2UEHWmNxjsb67UTphTfDWfW8T3FHbJGc8=; b=a
	OkLT8HOT6saWUEYTMJoBoiA05Vk3PToNiVUlO62CPJWY3KMl/M1e1RKCJ5GrUywD
	Q6BJgqB8EadsVCvtuiR15IAqyD0DynsUHmwgL0qGA81KKmVDOjd9BLvSujMN8eJA
	gCqg22XlJKnKOo3iGc3VpLgdeUD+efertJ/7MahCHFMSdWjk3mgfgHYq8EfQPhFP
	B4dL+Os+cSiZmNToMds3b5wUVHk51SVEHuyUkVg1no7DYeR2fpE+zymAJav0tNw/
	XAgAKQ1eOQ+oon39BarmJmWdEB2ntepgr2JZW+9RfumuBqO5DrLjMF2Q5bs5c+GE
	VvMwnRjszI99/HKDgh0Tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703166538; x=
	1703252938; bh=+JyhqIbPXo2UEHWmNxjsb67UTphTfDWfW8T3FHbJGc8=; b=v
	uRwiGJJphym6HWt6l4pGqun/Rq4sdKohTa7NY5h1Vnqw2tKyNzeXacrQeOkxhVRl
	gV6i0e2S+qCilKTDzx04BnDUhAC3diM1otte4d4SloGxWAtB4Ca75Zn/LtnviJsA
	VI7y6KkppikcJYXvxSfv3moM37iO9Sx+TBR+m/d+odcdGBtNPINxcgRneaGs5SpD
	CL/dhYU4wMighlTx0ZNMlZxWqdH3Ez6w9EOW9naqRTW86y8y2XKp9ec3l3ByLIkJ
	HVplTvGV0hQsJuJnTAZ6EpHnek1pIbpnBYCKADelBTWAvBmEAxMQ1BT55DZBpopC
	de42qNk8dHm/2e2bXJrkg==
X-ME-Sender: <xms:SkKEZT_0ya6dtWwHu0rmcn4ewmePsilKALkhxiGcfpJ0db686KwAyQ>
    <xme:SkKEZfu0d_Hjw5qjg6TJuU3q8Z6geKvfkQ6nEOqixSFd7OmG9LQTQlVzUA_S27u8p
    TmVS56e1tnS9EZ4o7E>
X-ME-Received: <xmr:SkKEZRDpVdUf10IyTUykWPsuZ8vcav3xICljYSiy__TD4l4VO4n68QtLjNJJzgE9aAo9Yvh04TGKVDQsW1KP6QRic0mOcYdTtdBZqSbSfSSF6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduhedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeffvefhff
    dugeetkeektdegheejheegteegffeihfevvefggfeuueekvdeffeehfeenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgpdguvghvihgtvgdrughirhgvtghtohhrhienucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhi
    sehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:SkKEZfcHnAQZ7MdGLmMfdJr0UPNQUFl5G1UTuGKRymYK4g4FehFfkw>
    <xmx:SkKEZYMSj-vCxC8caEllx3WuPGCtuPRYvRlIExNiZ81xVkAMLQMurA>
    <xmx:SkKEZRkwNwKG-GIeJ81yhzfUXSHwlYtHP-YRjrc0-1YqNeeI5b4FNw>
    <xmx:SkKEZS17GSyX8wZrM3VlGrH6221GZldWavUqUUF0iojYMJY7Q3BIrQ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Dec 2023 08:48:57 -0500 (EST)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: adamg@pobox.com
Subject: [PATCH v2 4/8] firewire: test: add test of device attributes for simple AV/C device
Date: Thu, 21 Dec 2023 22:48:45 +0900
Message-Id: <20231221134849.603857-5-o-takashi@sakamocchi.jp>
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

At present, core function can handle node which has configuration ROM
similar to standard AV/C device somehow. The standard layout of
configuration ROM is described in the following document.

- Configuration ROM for AV/C Devices 1.0 (Dec. 12, 2000, 1394 Trading
  Association)

This commit adds a KUnit test for the above case.

The following output is the parse result for the hard-coded data, by
config-rom-pretty-printer in linux-firewire-utils
(https://git.kernel.org/pub/scm/utils/ieee1394/linux-firewire-utils.git/).

$ config-rom-pretty-printer < /tmp/rom.img
               ROM header and bus information block
               -----------------------------------------------------------------
1024  0404eabf  bus_info_length 4, crc_length 4, crc 60095
1028  31333934  bus_name "1394"
1032  e0646102  irmc 1, cmc 1, isc 1, bmc 0, cyc_clk_acc 100, max_rec 6 (128)
1036  ffffffff  company_id ffffff     |
1040  ffffffff  device_id 1099511627775  | EUI-64 18446744073709551615

               root directory
               -----------------------------------------------------------------
1044  00063287  directory_length 6, crc 12935
1048  03ffffff  vendor
1052  8100000a  --> descriptor leaf at 1092
1056  17ffffff  model
1060  8100000e  --> descriptor leaf at 1116
1064  0c0083c0  node capabilities: per IEEE 1394
1068  d1000001  --> unit directory at 1072

               unit directory at 1072
               -----------------------------------------------------------------
1072  0004442d  directory_length 4, crc 17453
1076  1200a02d  specifier id
1080  13010001  version
1084  17ffffff  model
1088  81000007  --> descriptor leaf at 1116

               descriptor leaf at 1092
               -----------------------------------------------------------------
1092  0005c915  leaf_length 5, crc 51477
1096  00000000  textual descriptor
1100  00000000  minimal ASCII
1104  56656e64  "Vend"
1108  6f72204e  "or N"
1112  616d6500  "ame"

               descriptor leaf at 1116
               -----------------------------------------------------------------
1116  00057f16  leaf_length 5, crc 32534
1120  00000000  textual descriptor
1124  00000000  minimal ASCII
1128  4d6f6465  "Mode"
1132  6c204e61  "l Na"
1136  6d650000  "me"

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/device-attribute-test.c | 119 +++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/drivers/firewire/device-attribute-test.c b/drivers/firewire/device-attribute-test.c
index 87cfdf97c898..e2c5587d0757 100644
--- a/drivers/firewire/device-attribute-test.c
+++ b/drivers/firewire/device-attribute-test.c
@@ -8,7 +8,126 @@
 
 #include <kunit/test.h>
 
+// Configuration ROM for AV/C Devices 1.0 (Dec. 12, 2000, 1394 Trading Association)
+// Annex C:Configuration ROM example(informative)
+// C.1 Simple AV/C device
+//
+// Copied from the documentation.
+static const u32 simple_avc_config_rom[] = {
+	0x0404eabf,
+	0x31333934,
+	0xe0646102,
+	0xffffffff,
+	0xffffffff,
+	0x00063287, // root directory.
+	0x03ffffff,
+	0x8100000a,
+	0x17ffffff,
+	0x8100000e,
+	0x0c0083c0,
+	0xd1000001,
+	0x0004442d, // unit 0 directory.
+	0x1200a02d,
+	0x13010001,
+	0x17ffffff,
+	0x81000007,
+	0x0005c915, // leaf for textual descriptor.
+	0x00000000,
+	0x00000000,
+	0x56656e64,
+	0x6f72204e,
+	0x616d6500,
+	0x00057f16, // leaf for textual descriptor.
+	0x00000000,
+	0x00000000,
+	0x4d6f6465,
+	0x6c204e61,
+	0x6d650000,
+};
+
+static void device_attr_simple_avc(struct kunit *test)
+{
+	static const struct fw_device node = {
+		.device = {
+			.type = &fw_device_type,
+		},
+		.config_rom = simple_avc_config_rom,
+		.config_rom_length = sizeof(simple_avc_config_rom),
+	};
+	static const struct fw_unit unit0 = {
+		.device = {
+			.type = &fw_unit_type,
+			.parent = (struct device *)&node.device,
+		},
+		.directory = &simple_avc_config_rom[12],
+	};
+	struct device *node_dev = (struct device *)&node.device;
+	struct device *unit0_dev = (struct device *)&unit0.device;
+	static const int unit0_expected_ids[] = {0x00ffffff, 0x00ffffff, 0x0000a02d, 0x00010001};
+	char *buf = kunit_kzalloc(test, PAGE_SIZE, GFP_KERNEL);
+	int ids[4] = {0, 0, 0, 0};
+
+	// Ensure associations for node and unit devices.
+
+	KUNIT_ASSERT_TRUE(test, is_fw_device(node_dev));
+	KUNIT_ASSERT_FALSE(test, is_fw_unit(node_dev));
+	KUNIT_ASSERT_PTR_EQ(test, fw_device(node_dev), &node);
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
+	KUNIT_EXPECT_STREQ(test, buf, "0xffffff\n");
+
+	// Model immediate entry is found.
+	KUNIT_EXPECT_GT(test, show_immediate(node_dev, &config_rom_attributes[4].attr, buf), 0);
+	KUNIT_EXPECT_STREQ(test, buf, "0xffffff\n");
+
+	// Descriptor leaf entry for vendor is found.
+	KUNIT_EXPECT_GT(test, show_text_leaf(node_dev, &config_rom_attributes[5].attr, buf), 0);
+	KUNIT_EXPECT_STREQ(test, buf, "Vendor Name\n");
+
+	// Descriptor leaf entry for model is found.
+	KUNIT_EXPECT_GT(test, show_text_leaf(node_dev, &config_rom_attributes[6].attr, buf), 0);
+	KUNIT_EXPECT_STREQ(test, buf, "Model Name\n");
+
+	// For entries in unit 0 directory.
+
+	// Vendor immediate entry is not found.
+	KUNIT_EXPECT_LT(test, show_immediate(unit0_dev, &config_rom_attributes[0].attr, buf), 0);
+
+	// Model immediate entry is found.
+	KUNIT_EXPECT_GT(test, show_immediate(unit0_dev, &config_rom_attributes[4].attr, buf), 0);
+	KUNIT_EXPECT_STREQ(test, buf, "0xffffff\n");
+
+	// Descriptor leaf entry for vendor is not found.
+	KUNIT_EXPECT_LT(test, show_text_leaf(unit0_dev, &config_rom_attributes[5].attr, buf), 0);
+
+	// Descriptor leaf entry for model is found.
+	KUNIT_EXPECT_GT(test, show_text_leaf(unit0_dev, &config_rom_attributes[6].attr, buf), 0);
+	KUNIT_EXPECT_STREQ(test, buf, "Model Name\n");
+
+	// Specifier_ID immediate entry is found.
+	KUNIT_EXPECT_GT(test, show_immediate(unit0_dev, &config_rom_attributes[2].attr, buf), 0);
+	KUNIT_EXPECT_STREQ(test, buf, "0x00a02d\n");
+
+	// Version immediate entry is found.
+	KUNIT_EXPECT_GT(test, show_immediate(unit0_dev, &config_rom_attributes[3].attr, buf), 0);
+	KUNIT_EXPECT_STREQ(test, buf, "0x010001\n");
+
+	kunit_kfree(test, buf);
+
+	get_modalias_ids(&unit0, ids);
+	KUNIT_EXPECT_MEMEQ(test, ids, unit0_expected_ids, sizeof(ids));
+}
+
 static struct kunit_case device_attr_test_cases[] = {
+	KUNIT_CASE(device_attr_simple_avc),
 	{}
 };
 
-- 
2.39.2


