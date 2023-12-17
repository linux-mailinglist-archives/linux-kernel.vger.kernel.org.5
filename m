Return-Path: <linux-kernel+bounces-2534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 256DE815E89
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 11:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFA741F2216B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 10:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E9612E7D;
	Sun, 17 Dec 2023 10:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="OuHjnjhi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S9rUBTE4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC8111CA7
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 783955C0125;
	Sun, 17 Dec 2023 05:30:31 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 17 Dec 2023 05:30:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1702809031; x=
	1702895431; bh=GNxJtnuCREIc3LKzjvgp8+1jNOAQR7t6+8ZOIjGQVww=; b=O
	uHjnjhi0jaHqKYj1X++SCg0PM+W9vd9wJmjYUN5XX87JUwnDzPLmkU9wxzhubLLu
	oML5gYlSlIGgkzftVYIT/rJMI/V2rYr/FyK9OdmdNqoGQrl3lMBSekFlSRQXIYBs
	csOyzmg+ZS9nC94Iv8ERLX4bcdNV1idhwiyDoMBWJqJ8SnAaj+ygmjdV9oJH9ZRJ
	gd9NyYb4MU7UEDUCiRG9EsEh+y46UxhS7KQns5tx3XVhHhzqhcvcgpHaOMjnIei7
	sXJ2XEIFe+N+3vbt3qY4JOS5woqQKU4EvJ76n07hUV+1t6pTBnAQvCu/dqzlaeVw
	7gbMP1+dsOv2s6IPDM1XQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1702809031; x=
	1702895431; bh=GNxJtnuCREIc3LKzjvgp8+1jNOAQR7t6+8ZOIjGQVww=; b=S
	9rUBTE4Ri6Ccm+RtAKvzgTfQqVnaPLoaobNM3jrvWbmXl6hXiEk5dDFH8TbnUmHf
	P3UolBM9AWABQvSgqVP++zpvRNXlG18w+ugcbFWRWybHqdCI34xrX2ut5dZ5L4/e
	6L9FtlTxpWP+ViWcouR8XnO1Z3+QeTMfv2SBA2NEXJ9aGzIAALUKrQWP9yLKc+k7
	7codyjuszBI5JlojiN2gDZ5P6D93Lg/ru1SBBGYyYo3Ak1rZAWuQE11LnBgkDJvh
	d0bNyWfUOfsHun2HoWbdWT4eITNqdgmTw19+F7HPGrWQfgBmyYU308UX8h3Roo9G
	J0pQptyboMcciwZUhyH5Q==
X-ME-Sender: <xms:x81-ZRmhcmgluIQVuRNXzfKP_Jqd58nPBu_78XfF0kCT8gDdxq_sHA>
    <xme:x81-Zc0pje4rPbwfiuOsqn0T3FHqWZ1jjXn9-HsB_eUeEwi6dwY8-EzvudCyQt-DC
    NDwEXiBaQT0nbASmBc>
X-ME-Received: <xmr:x81-ZXpSBawnCM8U8Jk_lcZX1gD2dynlBUBlutlE4QfLa_zAx9B0xWkJ9yfo4yBTHeL-2ePFw8p7x3ve9pQ57XKRyLFo6EnKYtAxjsrgeMBmLHY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtiedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:x81-ZRkmuR-qlJ8NJJLnhalG9ELl5JCwJ7XMxlWsB65qdRWHnm3Wug>
    <xmx:x81-Zf1yX-Pe0PgRgyCqnEBkiN8Kzf3x_3bt2qToDm1vtHdncRFLRQ>
    <xmx:x81-ZQvgFXnNskG5GOh3CjGl7HUzjIMBd6Cz1uttd4fg6uRzY33UIA>
    <xmx:x81-ZY97ezlF-h5Q2QffM2QH9tMeYXEKCG9jEdUvDdQFhPT1CI3TVg>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 Dec 2023 05:30:30 -0500 (EST)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: adamg@pobox.com
Subject: [RFC PATCH 8/8] firewire: core: change modalias of unit device with backward incompatibility
Date: Sun, 17 Dec 2023 19:30:12 +0900
Message-Id: <20231217103012.41273-10-o-takashi@sakamocchi.jp>
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


