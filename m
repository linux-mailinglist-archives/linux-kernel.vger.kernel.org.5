Return-Path: <linux-kernel+bounces-128609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2C0895D0B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8397728671D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB9E15D5BD;
	Tue,  2 Apr 2024 19:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hUbH33rz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF54E15CD52;
	Tue,  2 Apr 2024 19:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712087597; cv=none; b=oKVX4PYqRZEF2UE/HlqVPrH1TrRSDiddmCIXT+Gl8mje5N1O4yXouCvXUL8+ZRLMmo36/UtRstviXNTFTrC0uvJcgkq4xmUqi1Z2EaeJZBikVY/T78JoFtY6hBoCXxGS7r2q/0abID+sZOr6K0JA/hLaYzODMbN/gobH+fKPCig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712087597; c=relaxed/simple;
	bh=+of8nXv2yYLVGjFEgKMdTt0MbiPEXZvBXfKBOaicXQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nhxTI7w/M9Uo4fKJg1gAblQT9reTO9UHO6hRsOEi32UjOcLqaPuCl0qmtW+5us5YMCrEsv3yayRMjSYSZESuVFj046Nv4DD2lqTZAHkrKhEeLPLj1MARhfEqWKaElBw/g+Bb+WGal+G/9XHzIrZFPzFiksMZlwc1Q+5mWSfa444=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hUbH33rz; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712087596; x=1743623596;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+of8nXv2yYLVGjFEgKMdTt0MbiPEXZvBXfKBOaicXQI=;
  b=hUbH33rzfuJ2h3Ohx5ci3UqwW5HR1QoO8bwzQTUPQthM54hro2TgXOXo
   WCQ6q9vN9WkfnBVPd1c3QCjgjYqZZuyfsoLUrFtiJPCZT59agvzBsyfPH
   x/q10IllAtq/6MJ54+P5GC+hMldBdFj+dzVnCi1Wr7GloR5GSR9PNJyaT
   hv2VIvJypvaBQRfN2rziP5DK/X1zs5gFU2M42Emm6R5Sv2K1AE1WCWc4U
   GfAlIOtJIsgXAcVbt4oowRz4oO9NMVOTAcVivROYiaeWymWFKc/PngmaB
   IasfwHN+BajN1QOO/KHX/GItJuDJlx1IcwQmzwfSU22nFFjO0HwYcmn63
   A==;
X-CSE-ConnectionGUID: 5hki2DydQuygUCvQJfyRlA==
X-CSE-MsgGUID: lE3iizYUR8irxiv6wO32yQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7150992"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="7150992"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 12:53:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937083784"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="937083784"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2024 12:53:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B5A32133; Tue,  2 Apr 2024 22:53:09 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hugo@hugovil.com>
Subject: [PATCH v2 01/16] serial: max3100: Lock port->lock when calling uart_handle_cts_change()
Date: Tue,  2 Apr 2024 22:50:28 +0300
Message-ID: <20240402195306.269276-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240402195306.269276-1-andriy.shevchenko@linux.intel.com>
References: <20240402195306.269276-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uart_handle_cts_change() has to be called with port lock taken,
Since we run it in a separate work, the lock may not be taken at
the time of running. Make sure that it's taken by explicitly doing
that. Without it we got a splat:

  WARNING: CPU: 0 PID: 10 at drivers/tty/serial/serial_core.c:3491 uart_handle_cts_change+0xa6/0xb0
  ...
  Workqueue: max3100-0 max3100_work [max3100]
  RIP: 0010:uart_handle_cts_change+0xa6/0xb0
  ...
   max3100_handlerx+0xc5/0x110 [max3100]
   max3100_work+0x12a/0x340 [max3100]

Fixes: 7831d56b0a35 ("tty: MAX3100")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/max3100.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 5efb2b593be3..45022f2909f0 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -213,7 +213,7 @@ static int max3100_sr(struct max3100_port *s, u16 tx, u16 *rx)
 	return 0;
 }
 
-static int max3100_handlerx(struct max3100_port *s, u16 rx)
+static int max3100_handlerx_unlocked(struct max3100_port *s, u16 rx)
 {
 	unsigned int status = 0;
 	int ret = 0, cts;
@@ -254,6 +254,17 @@ static int max3100_handlerx(struct max3100_port *s, u16 rx)
 	return ret;
 }
 
+static int max3100_handlerx(struct max3100_port *s, u16 rx)
+{
+	unsigned long flags;
+	int ret;
+
+	uart_port_lock_irqsave(&s->port, &flags);
+	ret = max3100_handlerx_unlocked(s, rx);
+	uart_port_unlock_irqrestore(&s->port, flags);
+	return ret;
+}
+
 static void max3100_work(struct work_struct *w)
 {
 	struct max3100_port *s = container_of(w, struct max3100_port, work);
-- 
2.43.0.rc1.1.gbec44491f096


