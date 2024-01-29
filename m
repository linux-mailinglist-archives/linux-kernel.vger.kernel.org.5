Return-Path: <linux-kernel+bounces-42298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2393A83FF43
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD2A81F234C9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 07:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976DA4F1EA;
	Mon, 29 Jan 2024 07:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="IKCOIRHl"
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880B34EB3D;
	Mon, 29 Jan 2024 07:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706514683; cv=none; b=nIn6A8FNpC4/so8HyFI27ZXJdI+NuA5oUHOSAataSdlqgUbVb7Tg4IH81yJzfMZjYnfNjrNWrMFf3EG6knGrUd6lRSZZAdvK9Krpr4dxd6H/H8PcvPeIfvDdIXKVXGTdbOXC7H7dUcKl5rrz/RrTALgcx1BZVeY0of2pXFAIk+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706514683; c=relaxed/simple;
	bh=iAhMw5TqYSRo4aVrVeK/fdRJjl4Oy9WJcyP5Hh89bgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=coiua4ZeVkKD7Fi3E301+zP5XyHG91C8Gw6Gctlrt1jklG7ElHfYEeTv7TBE5z2HNZkLWz3MAOVpAMWurDvPMGlLHuwmwaPjqyrkgWaA4dHz8ioYxGHdxjFJrBIi2uL+5f+tStapnyw4ueB5uPB5ebjzjm9Jaoqnxzx2UlSn0AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=IKCOIRHl; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4TNgTy65Csz681p;
	Mon, 29 Jan 2024 08:51:18 +0100 (CET)
Received: from andreas.got.gaisler.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4TNgTs3vDWz6825;
	Mon, 29 Jan 2024 08:51:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1706514678;
	bh=REe3zM9H0lwUxZ2BIr7JXuDrLpxdjjZWFjcYYPPgQXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IKCOIRHlpbUk3hI5mDpYxbsrB6zyNUsSuBF9JiLxo/M43zE3leX7DasYdVy8+fdi1
	 eYRHaF3FtAvqC3aOocsBfzT2DycEMTCC4QE3FCjgFwsfzkxstuy72yCXzjK7JAq7qK
	 M5QR85S+wXBX1wT7u+3rjzTC3NEH+WvKs/AjvX5k=
From: Andreas Larsson <andreas@gaisler.com>
To: Alan Stern <stern@rowland.harvard.edu>,
	linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org,
	software@gaisler.com
Subject: [PATCH v2] usb: uhci-grlib: Explicitly include linux/platform_device.h
Date: Mon, 29 Jan 2024 08:50:56 +0100
Message-Id: <20240129075056.1511630-1-andreas@gaisler.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b6b66bed-10f1-421a-a561-3e07dcbd6781@gaisler.com>
References: <b6b66bed-10f1-421a-a561-3e07dcbd6781@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes relying upon linux/of_platform.h to include
linux/platform_device.h, which it no longer does, thereby fixing
compilation problems like:

In file included from drivers/usb/host/uhci-hcd.c:850:
drivers/usb/host/uhci-grlib.c: In function 'uhci_hcd_grlib_probe':
drivers/usb/host/uhci-grlib.c:92:29: error: invalid use of undefined type 'struct platform_device'
   92 |  struct device_node *dn = op->dev.of_node;
      |                             ^~

Fixes: ef175b29a242 ("of: Stop circularly including of_device.h and of_platform.h")
Signed-off-by: Andreas Larsson <andreas@gaisler.com>
---
v2:
- Fix commit ID in Fixes reference

 drivers/usb/host/uhci-grlib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/uhci-grlib.c b/drivers/usb/host/uhci-grlib.c
index ac3fc5970315..cfebb833668e 100644
--- a/drivers/usb/host/uhci-grlib.c
+++ b/drivers/usb/host/uhci-grlib.c
@@ -22,6 +22,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 
 static int uhci_grlib_init(struct usb_hcd *hcd)
 {
-- 
2.34.1


