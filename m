Return-Path: <linux-kernel+bounces-44350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E78B842097
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C9D81F2B9CE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD0867E77;
	Tue, 30 Jan 2024 10:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="NxRYIy/x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ngr+Tur7"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6065460B9F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 10:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706609064; cv=none; b=a7fA2uRjSHXHh0sHuF8bATXVNfkTfeB88fB4RJZ6IWwIrB5+96xeJipzV0i7FafE0NVSd4kqTnydBh1YOyHUFpz4yOhc+l/XRBVEa5FAMOuhLqAERp7pP07ofsjdxJvFUxbiJQWkh8FnV4oYLiySHD6XkNX/ylS5EbihDO5I2to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706609064; c=relaxed/simple;
	bh=FfkYryqAmG6xE6UW8GUeT6E10tnJ8xZna0vF8DOBDBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I/WsQXQ/HV+MKUNKw1kMmClFS1QPaXcMAoCaszTbfNwIBuCso7OwnANdQ+HxZcjSuwL7iwbMbADV3v9oyxNAiXfO3dS5sMU8YiCH4M7Udt6fKlE1Ra+J3DLxIRYB1Q3lEKEI4T48f/nlfUVEdN8D1UICzvFcv3GgCUwzNgFmj3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=NxRYIy/x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ngr+Tur7; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 2C3C93200B4D;
	Tue, 30 Jan 2024 05:04:21 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 30 Jan 2024 05:04:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1706609060; x=
	1706695460; bh=I+csVATMzSI1F8H1aPvtNTgAoo14qkkNUYONssdVe64=; b=N
	xRYIy/xZfHsyrINy6VgUN+snFexBvSAXBge0HXOtuCdkict2BkEi2tPFfD0wwSQT
	hgapcf0R3KbxMo40D7/AoPnPh3r+pfN4hwjO0c/mdc/P6YhwhfmtCMfizF/c8WpQ
	f5OMQ7zAvkAXf7Tg2iByjnvxPA3HJIgXkpC1vSg4lutbTkmRsSNacBW+Is6guvqN
	ObijbQK3Pb/ZDToYdlYg0sba38KHLFrOkttx6ZJRP2w33yf0lql7u1TjeIYFR9Qx
	jFth5hrhS/BSOU73jlTyJ1yCekQUxzD+bnnNeQfJzSoKYB1ZpUgeEVFkrMmFsW33
	sBAzm9EqxlCZXnIDR4XFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706609060; x=
	1706695460; bh=I+csVATMzSI1F8H1aPvtNTgAoo14qkkNUYONssdVe64=; b=N
	gr+Tur7N1qun+HgmRQaInOhgmSAX9BseCsxsfCWM8wWYozm73voDnO0CiqPvTuGU
	BVsZVCx9X7IrTeG0sQCM8TQjm6mpRRVMY/l8LjFX9wGy6aodvvsqIZtYUKy4IMrY
	rSzGVmvl8ywsFUELFDTl9oZnGwIRFxbNFg0ZkU12vPp3m8dI4nituQlkudnlqoUW
	l0TJ7iqGResAr4RYgsoTCyiYjjHtnXwBCLlR80HWRSBoOoIANkhJKoWcja8TXw9M
	gLYf+K68yzeyMsqDqAx+jkZXqrnkLuMf1JBI3DLk5GCaCO8JiwThYU7lAO74+JNz
	j/TqlA653GgjB8R93ij9A==
X-ME-Sender: <xms:pMm4ZSazSl8P0z7HlqgQCErC4GYthbC4LaVAOYTz0tjV7UwOLLRegQ>
    <xme:pMm4ZVaHwBIQI5v4E3eOHfEDtH6-NSF1S4DAt2ymj7USclkEpnU4L4hDxIieb5GGD
    W_ykJwAeluJg26uzQM>
X-ME-Received: <xmr:pMm4Zc87OUSoWNc-U707NQZ5C63DF_-ybLwrBZ-vjYW3mBFGy17OMj3iDZRW1xvIv0bLfG-lDE22ba4JD_JgRYIDm8gMXf4J6W40Yca65KIY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtiedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:pMm4ZUrd0WHuiH8s9041c5aCltXMBvOysQASy2mVIvZ7BLVfqiLPbg>
    <xmx:pMm4Zdp4p5uxWUmEnkD-K2tJ2BJVDSxady4fVUGfcWL7FE6lxgIg0A>
    <xmx:pMm4ZSTtwLIUUcOGyylUzudfVUGMWx8lqYeqq0W8u1clv1dRB87S-A>
    <xmx:pMm4ZeCHhwHjU1iUIeEmI2W30lsmytW8S9a-k0r-DqzwxCxcGb3mVg>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jan 2024 05:04:19 -0500 (EST)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: adamg@pobox.com
Subject: [PATCH 2/2] firewire: core: search descriptor leaf just after vendor directory entry in root directory
Date: Tue, 30 Jan 2024 19:04:09 +0900
Message-Id: <20240130100409.30128-3-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240130100409.30128-1-o-takashi@sakamocchi.jp>
References: <20240130100409.30128-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It appears that Sony DVMC-DA1 has a quirk that the descriptor leaf entry
locates just after the vendor directory entry in root directory. This is
not conformant to the legacy layout of configuration ROM described in
Configuration ROM for AV/C Devices 1.0 (1394 Trading Association, Dec 2000,
TA Document 1999027).

This commit changes current implementation to parse configuration ROM for
device attributes so that the descriptor leaf entry can be detected for
the vendor name.

$ config-rom-pretty-printer < Sony-DVMC-DA1.img
               ROM header and bus information block
               -----------------------------------------------------------------
1024  041ee7fb  bus_info_length 4, crc_length 30, crc 59387
1028  31333934  bus_name "1394"
1032  e0644000  irmc 1, cmc 1, isc 1, bmc 0, cyc_clk_acc 100, max_rec 4 (32)
1036  08004603  company_id 080046     |
1040  0014193c  device_id 12886219068  | EUI-64 576537731003586876

               root directory
               -----------------------------------------------------------------
1044  0006b681  directory_length 6, crc 46721
1048  03080046  vendor
1052  0c0083c0  node capabilities: per IEEE 1394
1056  8d00000a  --> eui-64 leaf at 1096
1060  d1000003  --> unit directory at 1072
1064  c3000005  --> vendor directory at 1084
1068  8100000a  --> descriptor leaf at 1108

               unit directory at 1072
               -----------------------------------------------------------------
1072  0002cdbf  directory_length 2, crc 52671
1076  1200a02d  specifier id
1080  13010000  version

               vendor directory at 1084
               -----------------------------------------------------------------
1084  00020cfe  directory_length 2, crc 3326
1088  17fa0000  model
1092  81000008  --> descriptor leaf at 1124

               eui-64 leaf at 1096
               -----------------------------------------------------------------
1096  0002c66e  leaf_length 2, crc 50798
1100  08004603  company_id 080046     |
1104  0014193c  device_id 12886219068  | EUI-64 576537731003586876

               descriptor leaf at 1108
               -----------------------------------------------------------------
1108  00039e26  leaf_length 3, crc 40486
1112  00000000  textual descriptor
1116  00000000  minimal ASCII
1120  536f6e79  "Sony"

               descriptor leaf at 1124
               -----------------------------------------------------------------
1124  0005001d  leaf_length 5, crc 29
1128  00000000  textual descriptor
1132  00000000  minimal ASCII
1136  44564d43  "DVMC"
1140  2d444131  "-DA1"
1144  00000000

Suggested-by: Adam Goldman <adamg@pobox.com>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-device.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index e4cb5106fb7d..7d3346b3a2bf 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -367,8 +367,17 @@ static ssize_t show_text_leaf(struct device *dev,
 	for (i = 0; i < ARRAY_SIZE(directories) && !!directories[i]; ++i) {
 		int result = fw_csr_string(directories[i], attr->key, buf, bufsize);
 		// Detected.
-		if (result >= 0)
+		if (result >= 0) {
 			ret = result;
+		} else if (i == 0 && attr->key == CSR_VENDOR) {
+			// Sony DVMC-DA1 has configuration ROM such that the descriptor leaf entry
+			// in the root directory follows to the directory entry for vendor ID
+			// instead of the immediate value for vendor ID.
+			result = fw_csr_string(directories[i], CSR_DIRECTORY | attr->key, buf,
+					       bufsize);
+			if (result >= 0)
+				ret = result;
+		}
 	}
 
 	if (ret >= 0) {
-- 
2.40.1


