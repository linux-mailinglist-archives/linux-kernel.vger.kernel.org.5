Return-Path: <linux-kernel+bounces-52065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BC98493AB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D9AE1C2029A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 06:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99007BE67;
	Mon,  5 Feb 2024 06:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="Wh9uleSd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j+aIWJi4"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F94BE4B
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 06:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707113097; cv=none; b=XioIoBF7LZDqZIgLZ1Gdntzbv3UQYd88qXSQYMiSZQ+Ol2YT3u2byKqMQtTbacNNiFe3cjEfjVTuxZ+p+MkZ/wpRWaS6FxEzQt/6cVjLrB52etQ5IBAG8fhSyX63NgVlR2KqSlKRMdXKrqCpCLJNYjcWUcxgPm6E5GieN4JPjyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707113097; c=relaxed/simple;
	bh=xwFTrIlrAls4xajJqJT9lIoJy/mgAuyVcs+oDEyeAus=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qAhR047LNSWt0wNOmgOBLYddcukj1JsHXbGSpS0CHr2HT3piG4OWtGMRDPhNB5vQ5wGugfTtoQD/8C9h9yurikHKFYcO38h+hGJF38D4Du6gAx1r7Nktg3l1MNldrmnlBaOBnpHP9CzcUSV6LW4RwBSn2yRwTK1gTV+DZqu5pto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=Wh9uleSd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j+aIWJi4; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id B954B5C00F7;
	Mon,  5 Feb 2024 01:04:53 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 05 Feb 2024 01:04:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1707113093; x=1707199493; bh=L96t1AozAo
	YK/Cnj9rCJdZC5N9mB5YiS8vFpPwYqvVk=; b=Wh9uleSdER1WIq612o/QY7/9Y+
	nKgd7R+/Nwwkln6Z0fmDCdBwjfa6ZwZTWo+yIPc5xgS8RJ03LI8H0Ua9Im5D/i5o
	+rxvchr9wGxPt8EMKz0IVHigC/ARgDaNHyBWIZEHMZ2z3ZL489OjaKDMABXUX+mJ
	YNcsAM8k/7bwSC+LxdWC79fhohOleUxEunV36gpzTVlp/+v4mcyU4XBBspq7iDKz
	mzzoiT5qnSIO+6W07v6yHjBrcXiL4vzr6uaXGkcyD1H86HqCzLCdobtfgeH2kP8+
	0K0IzphW/4CZbTyjLCqTIbG6UY9lpD4dc9LAnTj13DNN9ecq+47VheEMW9eA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707113093; x=1707199493; bh=L96t1AozAoYK/Cnj9rCJdZC5N9mB
	5YiS8vFpPwYqvVk=; b=j+aIWJi4T0LLCBeSzZaNjxHR5JfcsGUjEbNEqRy2YZDE
	mKfnGe7KPJGdMpnHOMg2AFbRnBMlp4+fxoYpVpw6VEZt7VnBMk2zYFSkbx0tgHoC
	WaJV6Ysut9+ESKjOyEW3gCJpEXaND0lPhjopUULjfv/PHAemw+8NZTeXP0uGawp2
	frvFO7IkgrM0fdnnN7rnlawGXLw0ObZbexTSjeaC7ltSZJKdb9RkQU0vpcunbPn9
	eQ1BF+eHYZZwYK6NxfbjgFY4qmHhRNK1ezRTxmitu7//uNkfhOCLN5ELGkq9T/js
	FMm5nDw2jr/DzvlIgUIihS2eREEBEt+cDN8zTy8vgA==
X-ME-Sender: <xms:hHrAZXZtVmrAv8YI8iiQLQTBp0qhBYnnKGpMrry5d6VYuEclTv6uOg>
    <xme:hHrAZWa74nHA-WDYvl54U8pbGjeKpZibpK-bZBi2Ltz-4ibTnoniyD4o71oIT60O9
    q3Yu-e-vNHHeB3DYlA>
X-ME-Received: <xmr:hHrAZZ_GT1-IvXfayq86jgrJaodt9izmPlGczJru6L68w2lEMxot6WeqeyqAmPl4UrySf3HooCG8YbusgNre_LzRI9Vd_E8OsIWrBtQjtNmr0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduledgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeeggfehleehje
    eileehveefkefhtdeffedtfeeghfekffetudevjeegkeevhfdvueenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:hXrAZdrX4YIie-QgL1m1sOgo27a2m5_k4CBMV4N0ict1aqkAOSjpJw>
    <xmx:hXrAZSqIUufHrNxx1OjEFG20B5HoyDllvRxwHAtiF37R1RO1-3jpkA>
    <xmx:hXrAZTRSGBjvFCKos3Ia8CHSqRjla0E1GpCzx0pE9im1Cjx5C9KkIA>
    <xmx:hXrAZZ2wEpXL7dnEDYjUl35-tSkZRwWPeFQQLPbIoYKJJlYT5mtdyg>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Feb 2024 01:04:51 -0500 (EST)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] firewire: core: fix build failure due to the caller of fw_csr_string()
Date: Mon,  5 Feb 2024 15:04:48 +0900
Message-Id: <20240205060448.13881-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A commit 47dc55181dcb ("firewire: core: search descriptor leaf just after
vendor directory entry in root directory") for v6.8-rc3 and a commit
67a5a58c0443 ("firewire: Kill unnecessary buf check in
device_attribute.show") for v6.9 bring build failure in for-next tree due
to the change of the name of local variable.

This commit fixes it.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/lkml/20240202111602.6f6e2c1a@canb.auug.org.au/
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402022343.NkgsMITA-lkp@intel.com/
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index a802c6d4f4fd..c0976f6268d3 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -366,7 +366,7 @@ static ssize_t show_text_leaf(struct device *dev,
 			// in the root directory follows to the directory entry for vendor ID
 			// instead of the immediate value for vendor ID.
 			result = fw_csr_string(directories[i], CSR_DIRECTORY | attr->key, buf,
-					       bufsize);
+					       PAGE_SIZE - 1);
 			if (result >= 0)
 				ret = result;
 		}
-- 
2.40.1


