Return-Path: <linux-kernel+bounces-6360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F778197AE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 05:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A88E61C21104
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA661F602;
	Wed, 20 Dec 2023 04:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="v6ohUlE+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tUVNVZek"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA35F1DA4D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 04:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id E5C0B3200A34;
	Tue, 19 Dec 2023 23:18:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 19 Dec 2023 23:18:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1703045914; x=
	1703132314; bh=MqOifYCucTPnKbf3hkszGvdZNwn7ZENwvdLMF39HtZM=; b=v
	6ohUlE+Lfs0BtQd+J/Z313mMYLUgyZwsby8e4D0A90VohPRi8dR4wLE6aO1RlD+4
	ppF7X5iGNBrHCE+7vAWvCMnelbMMbSYaBATQOtwcLvGOkXYdWsHcg984M6ulM2dJ
	KzuF9cLnvydouP8HcdtqftYKJ7k6qJ86fq9ep5oGZGwdwGMHSSFWvTesTg4xtuSJ
	Gz5fdiUzwMJu4+gmn4+Laezw5G5kLc+f20BvDem2MHupZHJpR0Sp0ENRlKzWpKyk
	5/BEj8ZdljsGIYih0RMls+fF2cyAtmWxY2KGBEALE30WNPqV8mGi0Ok7DHYhs64i
	NlNLDBPiCReuUzsCH7T+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703045914; x=
	1703132314; bh=MqOifYCucTPnKbf3hkszGvdZNwn7ZENwvdLMF39HtZM=; b=t
	UVNVZekYdYMrbFmliSodW1ZOQjUVtaJxkaqFT+qeoRCV5hPPBTGjPF1vuKTbZX8s
	nBfS6rsLEyZVVvVz5+YYF2f1Cvb9W3DyomCrfBJ1BxIRJf8RB63tCRP1V1DDh3aM
	msuiz1HoXUvYn/UWXZGelfvw2kB/JMFdyDWWS3gd5bbivxihJWEpWIc/e/g5rSEi
	vNxG+ZW3bRsSgqdldXPaj0KNjZH3MPMfM4aFyASoGzl1xIwPV5Jmh7/vRCE8cVaf
	lSqwTjYptnm+NozdscOqDawpJ8pPWdOLEHIhBey1c2Fn/9e4WCJ2JM6unh2QrU9t
	+R4vCOdgx+AaFKvL4Jqgw==
X-ME-Sender: <xms:GmuCZRDfLWBXbF9Cf7aJqgazisdkgRHgkWgz3YQNduF9PGHFHaN2mA>
    <xme:GmuCZfh1pvRg2mCcRMbaHL2B_9xHGcallZ-QqwkRheMQZOJwB95DHKokvQ5cp-E8H
    SJElIbowwyWBZg-BDc>
X-ME-Received: <xmr:GmuCZcli3YDy1-Zl7XS4xyba2GibsNxqJ3q-F7_Yz06lNs0WQJ0SfhYzog22WFzKDYOzMeu3tbNNtd4-o0B5V61-3STcWXvOWijFvu22qp1LbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduuddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:GmuCZbwRM2kgWYKvqzxtjuvPQHMafBe9A6I0NmCu2UhtEO5ylpCG7g>
    <xmx:GmuCZWQ5QUo-OLazhoEAojtk--suB69TV-mJUtpfivVi7PPFMak7uQ>
    <xmx:GmuCZebja1hlzaGGniQKCx2Y-FAq_evRpS-Cl6UurUv8S58nPaVeoA>
    <xmx:GmuCZZIYHLezGkzcFKcXzBtu9bvfe1DOr--h79BNV1CR-pNid8yhhg>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Dec 2023 23:18:32 -0500 (EST)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: adamg@pobox.com
Subject: [PATCH 8/8] firewire: core: change modalias of unit device with backward incompatibility
Date: Wed, 20 Dec 2023 13:18:06 +0900
Message-Id: <20231220041806.39816-9-o-takashi@sakamocchi.jp>
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
index 2bc6c874e89c..abcb0f036fcd 100644
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


