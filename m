Return-Path: <linux-kernel+bounces-143144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 311B18A34F4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAB091F23069
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B9714D45A;
	Fri, 12 Apr 2024 17:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TeDX5t0h"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A53149009;
	Fri, 12 Apr 2024 17:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712943577; cv=none; b=J3Gp+Nr8VYflIACYKTI56SO/wrKj+2tGUNBMr+1DA9kLk9vv8CU9sTy0m6xPwGnVbe3oumk337EJQVjOIqrKzoVOK/Kmg8jwNuqw0u317V5OPPO06qC+G7J7GUYCZ7tfbmgeAq58kAYZGm2O6XUEG9FJNdHHMDAXocUg39uUxOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712943577; c=relaxed/simple;
	bh=WX2C22JYEAq+JyD5cs6erlsGiFqL70FmZLflNcjHv1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qY8KFkgBNT/UpCskZug9vlrnOptU/bqDGsKKZC4Swf5RlvhLQ5CnDPwsYW+LbvCuV9+rMtNWWQ6Lw9a2tAEI9JyPtgeryvr8NRJZ0MDhOzKmpbmoK/7+vPtBl82xiPJK67veZxPvGdwIxcgwovx97sGVSKfrX5u7+dn2YJmj604=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TeDX5t0h; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712943576; x=1744479576;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WX2C22JYEAq+JyD5cs6erlsGiFqL70FmZLflNcjHv1I=;
  b=TeDX5t0he17UQABD2fg6eGyBLqFlCDNKNoC0tvkkLZTbLXKbN1LsFGwW
   nmEkuaNteiI82nUhDg/jKw0y/88DJou97X1xSSPE9PKCyqyTl9xODQ6Cs
   st9Gw2xQIIDQ/P9fuRO+g7G51xeUyuJK7lVs0LfSh9C4nmZmEH6wN8Sdm
   4MtM69j1wNiqnMNLwGSSVV9FOoeHkf+zup2udNX1FrTIPn4yeleX2YNyQ
   uc0ETR7zBHxGPoYAkseFbQOx5PFdK6r7AcfIu+jNOiqWFoTaObeJthttG
   2nAyronUIsDVHvd3f7YTiLw5wXuZfJ3T9xngRy0jXesMR4cW2MjFw8kZf
   Q==;
X-CSE-ConnectionGUID: AYshO3FGQ3mfG1lEjoYhLw==
X-CSE-MsgGUID: +ISbItpARxCNlMPJEeGDjw==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="33801723"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="33801723"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 10:39:35 -0700
X-CSE-ConnectionGUID: a6dgsmHMRSiCEwUxEqa/9g==
X-CSE-MsgGUID: Hk6QlCg4R6a4mLN90Q/PUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="25942392"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 12 Apr 2024 10:39:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A1E0BFF; Fri, 12 Apr 2024 20:39:32 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 1/1] serial: 8250_dw: Deduplicate LCR checks
Date: Fri, 12 Apr 2024 20:39:31 +0300
Message-ID: <20240412173931.187411-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All callers of dw8250_check_lcr() perform the same check.
Deduplicate it by moving them into respective call.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c | 41 +++++++++++--------------------
 1 file changed, 15 insertions(+), 26 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 1300c92b8702..1e81024f8fd3 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -100,14 +100,18 @@ static void dw8250_force_idle(struct uart_port *p)
 	(void)p->serial_in(p, UART_RX);
 }
 
-static void dw8250_check_lcr(struct uart_port *p, int value)
+static void dw8250_check_lcr(struct uart_port *p, int offset, int value)
 {
-	void __iomem *offset = p->membase + (UART_LCR << p->regshift);
+	struct dw8250_data *d = to_dw8250_data(p->private_data);
+	void __iomem *addr = p->membase + (offset << p->regshift);
 	int tries = 1000;
 
+	if (offset != UART_LCR || d->uart_16550_compatible)
+		return;
+
 	/* Make sure LCR write wasn't ignored */
 	while (tries--) {
-		unsigned int lcr = p->serial_in(p, UART_LCR);
+		unsigned int lcr = p->serial_in(p, offset);
 
 		if ((value & ~UART_LCR_SPAR) == (lcr & ~UART_LCR_SPAR))
 			return;
@@ -116,15 +120,15 @@ static void dw8250_check_lcr(struct uart_port *p, int value)
 
 #ifdef CONFIG_64BIT
 		if (p->type == PORT_OCTEON)
-			__raw_writeq(value & 0xff, offset);
+			__raw_writeq(value & 0xff, addr);
 		else
 #endif
 		if (p->iotype == UPIO_MEM32)
-			writel(value, offset);
+			writel(value, addr);
 		else if (p->iotype == UPIO_MEM32BE)
-			iowrite32be(value, offset);
+			iowrite32be(value, addr);
 		else
-			writeb(value, offset);
+			writeb(value, addr);
 	}
 	/*
 	 * FIXME: this deadlocks if port->lock is already held
@@ -158,12 +162,8 @@ static void dw8250_tx_wait_empty(struct uart_port *p)
 
 static void dw8250_serial_out(struct uart_port *p, int offset, int value)
 {
-	struct dw8250_data *d = to_dw8250_data(p->private_data);
-
 	writeb(value, p->membase + (offset << p->regshift));
-
-	if (offset == UART_LCR && !d->uart_16550_compatible)
-		dw8250_check_lcr(p, value);
+	dw8250_check_lcr(p, offset, value);
 }
 
 static void dw8250_serial_out38x(struct uart_port *p, int offset, int value)
@@ -194,26 +194,19 @@ static unsigned int dw8250_serial_inq(struct uart_port *p, int offset)
 
 static void dw8250_serial_outq(struct uart_port *p, int offset, int value)
 {
-	struct dw8250_data *d = to_dw8250_data(p->private_data);
-
 	value &= 0xff;
 	__raw_writeq(value, p->membase + (offset << p->regshift));
 	/* Read back to ensure register write ordering. */
 	__raw_readq(p->membase + (UART_LCR << p->regshift));
 
-	if (offset == UART_LCR && !d->uart_16550_compatible)
-		dw8250_check_lcr(p, value);
+	dw8250_check_lcr(p, offset, value);
 }
 #endif /* CONFIG_64BIT */
 
 static void dw8250_serial_out32(struct uart_port *p, int offset, int value)
 {
-	struct dw8250_data *d = to_dw8250_data(p->private_data);
-
 	writel(value, p->membase + (offset << p->regshift));
-
-	if (offset == UART_LCR && !d->uart_16550_compatible)
-		dw8250_check_lcr(p, value);
+	dw8250_check_lcr(p, offset, value);
 }
 
 static unsigned int dw8250_serial_in32(struct uart_port *p, int offset)
@@ -225,12 +218,8 @@ static unsigned int dw8250_serial_in32(struct uart_port *p, int offset)
 
 static void dw8250_serial_out32be(struct uart_port *p, int offset, int value)
 {
-	struct dw8250_data *d = to_dw8250_data(p->private_data);
-
 	iowrite32be(value, p->membase + (offset << p->regshift));
-
-	if (offset == UART_LCR && !d->uart_16550_compatible)
-		dw8250_check_lcr(p, value);
+	dw8250_check_lcr(p, offset, value);
 }
 
 static unsigned int dw8250_serial_in32be(struct uart_port *p, int offset)
-- 
2.43.0.rc1.1336.g36b5255a03ac


