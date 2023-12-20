Return-Path: <linux-kernel+bounces-6354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C800F8197A4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 05:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CDB82886D8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB17911CBA;
	Wed, 20 Dec 2023 04:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="fY40KPok";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dpy34s+f"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B3CC8CE
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 04:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 2A3373200A09;
	Tue, 19 Dec 2023 23:18:18 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 19 Dec 2023 23:18:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1703045897; x=
	1703132297; bh=PBp/kI0n0J8XwNjRh8pLSTFV6N9OxHCw9BU3vtXvG80=; b=f
	Y40KPokZAY6J+ufOGjMPW2NLsBhIO/1jaJFshHolkz0OSX2yqX+5V2cEq+LTfvri
	q/6QMA+2R1dr8gbFO5/TATROjSnXZfC9XL3ceJIEK/VB1Mg9SFVIpqoX1fw+Njpx
	MbBwGYEUvSUyytGhSO0hdBiz1EikSymd0rKVZ9rF1R1VMpmiwYgjiSsVGpUenf7V
	bMRlDmXq7PGLeQJHLvhtzh0z2eJGa9ZMvhE8KbeDBqNvKJRmBLWC1G6JKIlkfPAo
	blSR6nbbH97y2+FSg4ixguyjS+B/LRJ9daQc1j5kDxAK8mnF76Fn+kpcBWLVt73Y
	sw8ppfGhQSrEQzvqcMq9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703045897; x=
	1703132297; bh=PBp/kI0n0J8XwNjRh8pLSTFV6N9OxHCw9BU3vtXvG80=; b=D
	py34s+f+qgQJ0jRSDUaGmewcd6Io0FZd252UL5qJt/8nnksY/cZm4OkRxEdMQCPu
	AmtlXSgV8MsqFa9grb5opBseDrCKpn1/1u9+wT1KYHcUv75GSc17GKN2GyptCz/h
	WhBrGFzXAloTxlzBLGXLYHtXMPvGpKVemovfSJDsSCnTjhDDk9tm8gpPegcdPRPn
	OrpOeABiCZS5Rcrs6k2BxJ7Mlpgwqqgk1lRYb8CFP/mf3LVqErCJwC4TfqtDI+9Z
	3i2CMU8eYRm2fQI42d2BLyzNegSbq6sas5pySOjGtwal5oNHZTV/97UhFBFoIhnL
	bFjXVLF0Gn/goXi1lpZHg==
X-ME-Sender: <xms:CWuCZcmrTgHFaB2C-4eZW_LElQvwcjWM6NcQQy_Tt3lNRXRw9s4lRQ>
    <xme:CWuCZb3WFzA1Fl9Jg4rMfDwe7OMZtziEDbkGVMdJVv6If5kljr6Y7XQ9mecTGtBHC
    zNgA4gjcOY5-bfi1mc>
X-ME-Received: <xmr:CWuCZaqUsLitb_2L-ZnkjMcf8m9v4lcTeiIBnU4bREaUN1sNhweOJVFhosBdwOntSxr2WUe56Zvcdj-twCNPunmcENHQQrEd6wK8LEgr0SVI6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduuddgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:CWuCZYl0WwZi4TckxBQPswHxEMRMoMx2UR6CYsrOd50UCHlmHFXTjw>
    <xmx:CWuCZa14M1hhG4I3ircJ6fO_2jEMcf49IvD9duI2SjulU16t4TkEBQ>
    <xmx:CWuCZftruJIA9FaVv9Yad6aw5uDRpfylPeIPnlJs8uLajEdQVA-nvw>
    <xmx:CWuCZf8nT6la6u_N7brXBmxiOjWij3T0e0ygZsn8cDdG-VVui_VUyQ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Dec 2023 23:18:16 -0500 (EST)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: adamg@pobox.com
Subject: [PATCH 2/8] firewire: core: replace magic number with macro
Date: Wed, 20 Dec 2023 13:18:00 +0900
Message-Id: <20231220041806.39816-3-o-takashi@sakamocchi.jp>
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


