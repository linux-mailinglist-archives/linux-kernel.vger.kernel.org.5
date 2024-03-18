Return-Path: <linux-kernel+bounces-105854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4B687E585
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 900371F21086
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3153228DD6;
	Mon, 18 Mar 2024 09:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="W+VR4C0e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EnLSYf1e"
Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5665D2C18F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 09:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710753488; cv=none; b=Fg0Prh4uZhjK/5Ffbz9QHBdNErzGMCnVHQ9Yjq6SWXwUVTeDdCGTwZHCyLWaYhsKy1TIPbHYe8fABYkRW9i4RfF1qF9yG+UcWWUshv9ejaH65e4AqqW6+O82cS1mDfLJwXxN+gSVGKOY8p6EoH10Z90w6rB0jZlwwJdsO+nWlFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710753488; c=relaxed/simple;
	bh=ScHSHwihvRsqyvfslSI+2wXoLFxmTbTzzKqARaQ7TsA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PbRnAjdqaBezXy8m+knQ25u8uka8roWpsZxtSrfV3D305L/RvUNP/4Qn1bNB24SUbQXebE4ZZHO3uSVhCz+TioswHrCpS+yJLRCujZ+WKOHkME82AqEnvj0Iub+JqKYfnSGCWKWOGwbepjTmwGThH0v28+Ksa8NrWhf/Mqoy/+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=W+VR4C0e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EnLSYf1e; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 380841C0009B;
	Mon, 18 Mar 2024 05:18:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 18 Mar 2024 05:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1710753484; x=
	1710839884; bh=0RFvEZpgNJ5bK7Ro7X/Ka3XCibshAo7oB/5HUK+KVBQ=; b=W
	+VR4C0elU/mSiDZEMxJNgm8ecHs24zUwrCfoKXI6jHzCUup1ZQwHlsFExsw3PExE
	Td62LmG0S7JZWIeXnHfLH8GgGppcOwO31tSPu9B2RIC2wZJH9Gg1LDvnFoJEOyto
	oi5A7fXOFYN1lQC8hNrIxH13YGVY4Lc+3fXxs77BqfE3+Wx0lvOr4ykMQBdoOIqu
	Rs/JPLqTSz8MAwIaX+MLf8jPOfuF7nDhKF/R1oa8OHumeS635rZplq33arIc+RjC
	fYkgzYjjdf6DJttZAa+/4/J4i20DHun0qd6/NYro7RcLtvToDJAy03YdNF4d0fqQ
	balp2nQ8aFaLuAj4wqp2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1710753484; x=1710839884; bh=0RFvEZpgNJ5bK
	7Ro7X/Ka3XCibshAo7oB/5HUK+KVBQ=; b=EnLSYf1e1waplDHDfU5zLBTOlmZ84
	TPUujIVTZER0+vNoZwDUgpNpOJJ7SaUdoq0QIVamwDPwKZHtOrmLOFjtVLMCIhR2
	IUSF+vh9TOqtXpNgF93o7NjsvpswJeypir6G7K8rfUthULAnKn6cY3W4YMVDMrwW
	+jgIl8TWkqC/XWcMkzNPw8HJDpkYLWyRFoLJ4MpubEZsq61MDNNZ6+p9sGjhRgaC
	iUgzmZQojp45rnEumFjfDeJxfFgUC2gTQ11kaj5O2+2xrQmVXsolY1sXdffAO9uJ
	uiqhm0allXYsdfV73xi7SB15KGfL6SZgYqB5HJXi6FgNZolouxdXSF2fw==
X-ME-Sender: <xms:zAb4ZRT2FMZto-YUK9S7gwraxcs5kF2lmZNOub_hx0oOAK5nmnl6Ww>
    <xme:zAb4ZazaaKZ13HkDDhr3W-cnNPeOcjVT1LIrULSWXornAl8ZQhf5j8afvGD3yB2bN
    S-5aZbyjkjTWYVeSWU>
X-ME-Received: <xmr:zAb4ZW37C8Wuz1UbCH8KLkWTXmGY7nGtmLJFH0qk096x4vrpuTsXuzu1kl6k1DqEM4vlte7Kl7n7KOaSMeKYool8tAewUFAO8N90sol6VhL0dQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeejgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeevfefffeekte
    fgveegfeelheffhfeujedtjeevtefhkeevkedtjeejvddtjefhjeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrg
    hkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:zAb4ZZBnXT3yxKGDkiBsE7Tw9cQI0B8fzpBCFGV4ihfMyZ8Qa0t3Ow>
    <xmx:zAb4Zag81KAxl5MWUcAYEYaPpdqcukwV1xGvRDW-3Ub1ltiu7Jjnug>
    <xmx:zAb4Zdpfo0Qv-VZxe2SiN0A5JakYTXv3AZ2eYZhku36lql3qd9_UZA>
    <xmx:zAb4ZVg9Q9230mVT2D2w7C2J-UkUKHogwE1jXQ5GULg5h0zwobIFaQ>
    <xmx:zAb4ZbsmwncwBLWmmwYyXTz6_UmHzyQiySlLbrB_sZMIZYu3wTfnrLF4300>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Mar 2024 05:18:03 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH] firewire: core: add memo about the caller of show functions for device attributes
Date: Mon, 18 Mar 2024 18:17:58 +0900
Message-ID: <20240318091759.678326-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240318044609.GA659599@workstation.local>
References: <20240318044609.GA659599@workstation.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the case of firewire core function, the caller of show functions for
device attributes is not only sysfs user, but also device initialization.

This commit adds memo about it against the typical assumption that the
functions are just dedicated to sysfs user.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index f208a02d0ebf..a8172a6c2caa 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -322,6 +322,7 @@ static ssize_t show_immediate(struct device *dev,
 	if (value < 0)
 		return -ENOENT;
 
+	// Note that this function is called by init_fw_attribute_group() with NULL pointer.
 	return buf ? sysfs_emit(buf, "0x%06x\n", value) : 0;
 }
 
@@ -357,6 +358,7 @@ static ssize_t show_text_leaf(struct device *dev,
 		}
 	}
 
+	// Note that this function is called by init_fw_attribute_group() with NULL pointer.
 	if (buf) {
 		bufsize = PAGE_SIZE - 1;
 	} else {
-- 
2.43.0


