Return-Path: <linux-kernel+bounces-2533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E684815E88
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 11:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BC8C1C2122C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 10:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF99C111B5;
	Sun, 17 Dec 2023 10:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="EO4DA1b2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yWh4dFAt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D731E1118B
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id DDB6B5C0124;
	Sun, 17 Dec 2023 05:30:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 17 Dec 2023 05:30:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1702809029; x=
	1702895429; bh=GNxJtnuCREIc3LKzjvgp8+1jNOAQR7t6+8ZOIjGQVww=; b=E
	O4DA1b28hTv8vuM4/sfmjKgMAmMuWZrqriu/6NQl9JMM5QC+Aszgzs6m+lldEYBx
	m5jUtQBlX109BSNbB2vKL8PWSpRoKc/QdtFNNl3P1SatbZaiAB7d9/eTejJr54WT
	ZHlYcCt265eUmfwTSELEDlx3qqe55yBfmEnoqNSu/QM3j5Ix24G7iFo1XKOTIO1R
	+FVRGBCpbT3PU7d2SwY+FNQKzYOd1uh35SQ3UGnJ8TAtA1h0P8nvo7HksbY3VpTi
	5w3L1BGaWu4sevgVW7nF4/kT/fKhGkHuhHxwgu5oNvAWhyWRzVx8MddzAwhkEfJf
	xuqq+ugOhciCWpdsF3xaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1702809029; x=
	1702895429; bh=GNxJtnuCREIc3LKzjvgp8+1jNOAQR7t6+8ZOIjGQVww=; b=y
	Wh4dFAtNDIymNi8RauPDjeCH6rnCALqBmJE+ydH7D4LPZuQuI/OD3Yhqrjs9afSd
	2h+XE9SxC51Yr1HUomOrvTquFKawgjzrfZyh5qmfNzFG+ZqHQ06ciPZw/uXwT47B
	tso1Oyx6oHJlvi2WvgzmioryQwpADJCiM1xiG3h7W03iVZC8LWEb5qFKSj58aJ4C
	wbSrdX/g8GWwcA82ekzIx/NP5idKnXgQB6q9ILS2WBDOH1CYoGh6X6Ddfu1DK70u
	X16wb4jiQjA9mf0p1/Q9dzEeJjS/rHZeSEkQfW9UM/OEjhZsNtXdymqtJrw6pHWI
	0wWbP73aIo57hGQcgbK+Q==
X-ME-Sender: <xms:xc1-ZSvaIljZNAjFN4HaDurIGA-n9HwsHfQCXUiMi28w9bae2HSxWg>
    <xme:xc1-ZXeic4hJFsRlNoY8XJjRxCYxjq_Qtle3_D5tQVp_Qa1hz20O_YUt7tAZhEk1M
    MfPCgFc0cWwCVBItB4>
X-ME-Received: <xmr:xc1-ZdxuR-wSnkk9yFJKhfcs940lVuv723C5aE4LgqVG8OqLM_TabU1utWd971Ntz0I8_TvRQZeegK-Yod2CwHPg_eq2uOprAoW1a31rEwasDzU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtiedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:xc1-ZdNHtweWftRuwm4nl58gBGSzT6zYjYk1G89yOsxNgAF50YU-HQ>
    <xmx:xc1-ZS_rWGAIh5465vPpUjJLnfbBXYKvI_Iyi8MbwFYu2FmDMr7W-A>
    <xmx:xc1-ZVX5Yvv5QFU6MI4isJ8VucguY2eRqRPsiaGgAxjf3SndqEuzYw>
    <xmx:xc1-ZYlaEl4tuXcwMDtHXIGekdYXMuWHiZAosFwohbs-Y_4oI0_e3w>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 Dec 2023 05:30:28 -0500 (EST)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: adamg@pobox.com
Subject: [RFC PATCH 8/8] firewire: core: change modalias of unit device and loss of backward compatibility
Date: Sun, 17 Dec 2023 19:30:11 +0900
Message-Id: <20231217103012.41273-9-o-takashi@sakamocchi.jp>
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

As the last part of support for legacy layout of configuration ROM, this
commit traverse vendor directory as well as root directory when
constructing modalias for unit device. The change brings loss of backward
compatibility since it can fill 'mo' field which is 0 at current
implementation in the case. However, we can be optimistic against
regression for unit drivers in kernel, due to some points:

1. ALSA drivers for audio and music units uses Model fields to match
   device, however all of supported devices does not have such legacy
   layout.
2. the other unit drivers does not use Model field to match device.

The rest of concern is user space application. The most of application
just take care of node device and does not use the modalias of unit
device, thus the change does not affect to them. Although, systemd
project gets affects since it includes hwdb to take udev to configure
fw character device conveniently. I have a plan to work systemd so that
the access permission of character device is kept for the previous and
next version of Linux kernel.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-device.c  | 21 +++++++++++++++++++--
 drivers/firewire/csr-api-test.c |  2 +-
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index f7a11004f972..e04486c5e0eb 100644
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
+	vendor_directory = search_directory(root_directory, CSR_DIRECTORY | CSR_VENDOR);
+	if (!vendor_directory) {
+		directories[1] = unit->directory;
+	} else {
+		directories[1] = vendor_directory;
+		directories[2] = unit->directory;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(directories) && directories[i]; ++i)
+		get_ids(directories[i], id);
 }
 
 static bool match_ids(const struct ieee1394_device_id *id_table, int *id)
diff --git a/drivers/firewire/csr-api-test.c b/drivers/firewire/csr-api-test.c
index 779146d0cfba..753d8e83b8c2 100644
--- a/drivers/firewire/csr-api-test.c
+++ b/drivers/firewire/csr-api-test.c
@@ -178,7 +178,7 @@ static void csr_api_legacy_avc_device(struct kunit *test)
 	};
 	struct device *node_dev = (struct device *)&node.device;
 	struct device *unit0_dev = (struct device *)&unit0.device;
-	static const int unit_expected_ids[] = {0x00012345, 0x00000000, 0x00abcdef, 0x00543210};
+	static const int unit_expected_ids[] = {0x00012345, 0x00fedcba, 0x00abcdef, 0x00543210};
 	char *buf = kunit_kzalloc(test, PAGE_SIZE, GFP_KERNEL);
 	int ids[4] = {0, 0, 0, 0};
 
-- 
2.39.2


