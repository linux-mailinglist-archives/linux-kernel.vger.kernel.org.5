Return-Path: <linux-kernel+bounces-2527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0785B815E75
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 11:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76086B22219
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 10:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D2479CB;
	Sun, 17 Dec 2023 10:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="udElJpNm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0iS9cBa2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2E2613C
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 10:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 83F015C0113;
	Sun, 17 Dec 2023 05:30:20 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Sun, 17 Dec 2023 05:30:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1702809020; x=
	1702895420; bh=/6Ta9woOfTDpfu4hjdamNnLTts8ODMKhVhLZw/OsZHE=; b=u
	dElJpNmM8IX4CREWPjR1PnG8MwDSKDRHAVTZrKhneacCnqx+wKR/qZqdl+JoBY5C
	nJA8uoI+3jxPH+rJht0btFRsEz5/DutSaYyXc/G739V3sQtqOa0s/a/wvDfclrGr
	L4uzK3Zefs9hZysyXzwfDMloUVQgxakrFq6NkPWLThL0m3hjfdWDm5pQmwzRoZFL
	TrtcYg7rqP09g7UiQdQ41oxkzu2KSVb9cUg+Oh/FTNZtbaPcb+CtgRxoLC6XjgAr
	QsNuYq8UgAvS/a7tIoBqUcesbo+v2Ns/aVtQ+b9YmoYr5abr5O9g1Vv56uoswlPl
	158mjO6lsRK8VSDjUz/cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1702809020; x=
	1702895420; bh=/6Ta9woOfTDpfu4hjdamNnLTts8ODMKhVhLZw/OsZHE=; b=0
	iS9cBa2rjrrEO2hdjyh2xoBiMgmTZSLtPXEhg4/HDC5Fq3vXbQm5PIJlHS+XL5B1
	x//TzfsE+P17ep6LzDmddcNm50cIwZsqWqzlXJRrd1oF1GbYLfFSU9m47YlpGsVN
	grQMOcp9umLrx9K2RDcN+W587+WpcT1ItRYbYNuSMVwQNW9gfJTQvhE+spMAMfW/
	wDQBpLL3euQFDxc4OJS+qgs8YcCLymq0bSW6AgIqf2wtVyofSkWYiNQnmuPRCxOu
	DVUhSj91sYTb9zRXuWDjNVgcFVaxNhsapciEIpgqQE6YxbzyNDdIoYAtbg6UhN6g
	y3ko9UNv4buPzrKMj0F7w==
X-ME-Sender: <xms:vM1-Zdwve80hczddzxf7LQiTd20hEMY_VEXcchXCHWezT0P8VgIUQQ>
    <xme:vM1-ZdQkOVnYJBbhaT4LzLIOkB_zUjS4PBhS5iUJrHTK6aG3xyldfE_amWwDOYXT9
    4n7jJB-u6et5Kg-Op0>
X-ME-Received: <xmr:vM1-ZXV-Oxd1Lg4-Ey-CYMFfmJIXnR8pOa0NZss4dpSW7SFAq7HVn-VzqQM4p03tNWYEHZQuhweQrRd21xxI5BoD_2NoovRpqK7Y3gPKJRn3l7c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtiedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:vM1-ZfhhsabSmQsm9GBv-zL8aKmMcX5LprEB5DhUBH6iAlogK8PTiQ>
    <xmx:vM1-ZfBKb_TUpYC9M8wkBcB8iWiDCJLAvDTXD4cip0gRnmxIKNXTuw>
    <xmx:vM1-ZYIk3cY1PFUQWEBzyXMBN1aNcO43tt3UQA9bKoiOlY0BSCovFg>
    <xmx:vM1-ZU605fQyh3YEeMGRLleQXN-UYqrdZbIxaKiu2CHMlmhuI7ct3A>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 Dec 2023 05:30:19 -0500 (EST)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: adamg@pobox.com
Subject: [RFC PATCH 2/8] firewire: core: replace magic number with macro
Date: Sun, 17 Dec 2023 19:30:05 +0900
Message-Id: <20231217103012.41273-3-o-takashi@sakamocchi.jp>
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
index 16c32cb38f0f..137001f8a695 100644
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


