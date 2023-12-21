Return-Path: <linux-kernel+bounces-8527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 564BD81B909
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11A2D289451
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFFB6D6F7;
	Thu, 21 Dec 2023 13:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="HIuDvn01";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FoavjJCi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A560E6D6CC
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 13:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id BBDAC5C0293;
	Thu, 21 Dec 2023 08:48:55 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 21 Dec 2023 08:48:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1703166535; x=
	1703252935; bh=PBp/kI0n0J8XwNjRh8pLSTFV6N9OxHCw9BU3vtXvG80=; b=H
	IuDvn01LqcWi0C3Hd7AERs4UJmkkz+qSxPdbfFy7Cj4V3gRtcWHb/QU57t50cLFa
	mKT32d7aPDy8Zxhs1kk1+MkieEyOHMe780GJKhvjNMPY5aeWelWt9RxRe4JuW02m
	9kv5SVizWuW5IcspWKH/lnUCLSvoeaG2o+gQRjIRGcceEnzzsCmuY84ZQtjrSlwj
	lANPEMs2c+6fL3LDLsQMXDHG8AqcxZRQZWgMAr9ZWpMBLPfk5PfdJsEHWklW3QKw
	6ymO9Y7gPlymj6K9/JVFImx5Tn+yGzyV2l9RLsPYt8eGM0x+sCnxt8qliRG7mqv9
	7o5YzaXnM5zC58bizd+sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703166535; x=
	1703252935; bh=PBp/kI0n0J8XwNjRh8pLSTFV6N9OxHCw9BU3vtXvG80=; b=F
	oavjJCir1WITV2vHJtlHCl8BENh1qh45/7Ja8Sbi4sntAGLcuUcnmP9zVb0yGfHW
	EFBBooPISK45ABDBJDmn1nV4asER9rWWZzFM5UH/scwEKZnXTlM2oewfOQduUWuC
	P7JZaX7RnVoqGRzuFWTVXHlIthlSwMUWkwG4P3oVTgvZ1ncjXXVYW/2cHLEwIxgW
	qYfbwGpy7O9a9U0Q1KY1eADu12Ic6pcL/q+WU/+Hsx1ikOYulE/hVxwQOVbtBADv
	RSDAJyK7tatHn+fN1acHwuzcZudsdFd3XSXiUgd0xRPkrToh88ZSmi1nQV+NkAha
	ncTx2C29nfs8m0r3tfZKQ==
X-ME-Sender: <xms:R0KEZQIJozOfSEAHXlPbkxSqFPpP0DJHnU3wpmnAJdIIE8y_9osolg>
    <xme:R0KEZQK-UMi0E4a8Dzaz1alrtA2G_BBFGuKHCNUQIGHQNr6EkPIAlr6LbInlvd7sY
    hZrGdWbmH6iY6STFbc>
X-ME-Received: <xmr:R0KEZQsLT7LpCqZpBqfRgFuj83AjnfqkRCZjt-mFDcSp-EtqDt2qq2wagW6W8dUXGEiE24US9uBA8-WZ_AgYSLd4O7aoXfSbOHTwIxteRdgi5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduhedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:R0KEZdYBm-zm5HnnU2hnaRVdOfBI5SP2UDe43lL6-q4Y_XreMuxZ7g>
    <xmx:R0KEZXbQMYO0qr1rPBAHDblH5HRWDAWhbcElAVnLsixtqYmEVxoQkA>
    <xmx:R0KEZZBiLp-tK2Zrc414daBKWom0qxd7RPxg6aAm0wY8ekziDWVLqw>
    <xmx:R0KEZewxZA_X984LxrBWeqio26V_ILP4bt-uIhj57LBI7-SUSafbaA>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Dec 2023 08:48:54 -0500 (EST)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: adamg@pobox.com
Subject: [PATCH v2 2/8] firewire: core: replace magic number with macro
Date: Thu, 21 Dec 2023 22:48:43 +0900
Message-Id: <20231221134849.603857-3-o-takashi@sakamocchi.jp>
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

In IEEE 1394 specification, the size of bus information block of
configuration ROM is fixed to 5, thus the offset of root directory is 5.
Current implementation to handle device structures has the hard-coded
offset.

This commit replaces the offset with macro.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-device.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index 96b0b43da863..315a2fe41643 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -31,6 +31,8 @@
 
 #include "core.h"
 
+#define ROOT_DIR_OFFSET	5
+
 void fw_csr_iterator_init(struct fw_csr_iterator *ci, const u32 *p)
 {
 	ci->p = p + 1;
@@ -135,7 +137,7 @@ static void get_ids(const u32 *directory, int *id)
 
 static void get_modalias_ids(const struct fw_unit *unit, int *id)
 {
-	get_ids(&fw_parent_device(unit)->config_rom[5], id);
+	get_ids(&fw_parent_device(unit)->config_rom[ROOT_DIR_OFFSET], id);
 	get_ids(unit->directory, id);
 }
 
@@ -259,7 +261,7 @@ static ssize_t show_immediate(struct device *dev,
 	if (is_fw_unit(dev))
 		dir = fw_unit(dev)->directory;
 	else
-		dir = fw_device(dev)->config_rom + 5;
+		dir = fw_device(dev)->config_rom + ROOT_DIR_OFFSET;
 
 	fw_csr_iterator_init(&ci, dir);
 	while (fw_csr_iterator_next(&ci, &key, &value))
@@ -292,7 +294,7 @@ static ssize_t show_text_leaf(struct device *dev,
 	if (is_fw_unit(dev))
 		dir = fw_unit(dev)->directory;
 	else
-		dir = fw_device(dev)->config_rom + 5;
+		dir = fw_device(dev)->config_rom + ROOT_DIR_OFFSET;
 
 	if (buf) {
 		bufsize = PAGE_SIZE - 1;
@@ -446,7 +448,7 @@ static ssize_t units_show(struct device *dev,
 	int key, value, i = 0;
 
 	down_read(&fw_device_rwsem);
-	fw_csr_iterator_init(&ci, &device->config_rom[5]);
+	fw_csr_iterator_init(&ci, &device->config_rom[ROOT_DIR_OFFSET]);
 	while (fw_csr_iterator_next(&ci, &key, &value)) {
 		if (key != (CSR_UNIT | CSR_DIRECTORY))
 			continue;
@@ -691,7 +693,7 @@ static void create_units(struct fw_device *device)
 	int key, value, i;
 
 	i = 0;
-	fw_csr_iterator_init(&ci, &device->config_rom[5]);
+	fw_csr_iterator_init(&ci, &device->config_rom[ROOT_DIR_OFFSET]);
 	while (fw_csr_iterator_next(&ci, &key, &value)) {
 		if (key != (CSR_UNIT | CSR_DIRECTORY))
 			continue;
-- 
2.39.2


