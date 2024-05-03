Return-Path: <linux-kernel+bounces-167967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 110088BB1B6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ED751F2401B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35005158DC0;
	Fri,  3 May 2024 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FM8XKVSs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3024158A07;
	Fri,  3 May 2024 17:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714756788; cv=none; b=fydnY7H/HXBoiRV59LMk78Rt1OXAMmXdec2o0s0c8fFnxXXjbs+HGWeDukLYrS7LlYJGeyM8G/k7TavXJF56RoFMSBuSYnWSfQI9MCldWgxOlQSBRDsXaneIJbM+92LvxpWUVtnYRzZgb9q6+5aIHyV3613DRUXw9AdCzIuX+rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714756788; c=relaxed/simple;
	bh=HSPO3BYYrHNKLlywx1qmFZnk+RVxu/4s6sl1HAdCBHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3OvGNywblhGdPrK4m0+VLZ4P/rfkm6IGm0jwOCl3TZYAK0qXCaBIPFyGKc5/oV/Lp5Tz0v8YYHFeWGbYma5Ug1OVanEld/FSaG3nm4MffFs38kJZQSt/YheG33iamL3vnO+q6WwoQdBoxFGI+vnZyxrGrtvgvqFBJl9HIXbzp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FM8XKVSs; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714756786; x=1746292786;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HSPO3BYYrHNKLlywx1qmFZnk+RVxu/4s6sl1HAdCBHQ=;
  b=FM8XKVSsA4gMPahmf2QG5HxjUoPz3nLlD0cMeqToNBF8uLStG3T9gfzK
   lFWZm8rzszgArQbAiMTB1IM0bM/NtxyDwH0JCi1Bj233ecdS/lTIbuojA
   GEWST4th7iSkCMBA08Ygj7WrOg9LxSazQ3AyEGB+ApxJ8tXxtKw6FLspD
   wcwdf1GYLGdBdP861/V0fpbQV8cgzP1RPTHfS17tf8qYzAMNT1q82nZ2E
   YMkeeZ7B2V49RrYfEP7RIS3oOo9gAYnBjo616h39lopIQvPAmAj5CkmWO
   DQNMO5hPtwus7fIBiuSLfX+3khVf/6RwHY8AzkW1HcHPUncrwGV/VWmQE
   A==;
X-CSE-ConnectionGUID: lduSk7ykTfG0NcnwiX+CGg==
X-CSE-MsgGUID: 5Vq0t4bFR6C127elLUgLnQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="11107819"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="11107819"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 10:19:44 -0700
X-CSE-ConnectionGUID: k7YE1zu7QG2Gy40YjxVtmg==
X-CSE-MsgGUID: oVe/rjzDTTGMxgTvIVH2hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="58415426"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 03 May 2024 10:19:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 8C2E5699; Fri,  3 May 2024 20:19:38 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <pnewman@connecttech.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v2 10/13] serial: 8250_exar: Switch to use dev_err_probe()
Date: Fri,  3 May 2024 20:16:02 +0300
Message-ID: <20240503171917.2921250-11-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240503171917.2921250-1-andriy.shevchenko@linux.intel.com>
References: <20240503171917.2921250-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch to use dev_err_probe() to simplify the error path and
unify a message template.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_exar.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 51f6af16c557..306bc6d7c141 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -889,11 +889,8 @@ static int cti_port_setup_common(struct exar8250 *priv,
 	port->port.uartclk = priv->osc_freq;
 
 	ret = serial8250_pci_setup_port(pcidev, port, 0, offset, 0);
-	if (ret) {
-		dev_err(&pcidev->dev,
-			"failed to setup pci for port %d err: %d\n", idx, ret);
+	if (ret)
 		return ret;
-	}
 
 	port->port.private_data = (void *)priv;
 	port->port.pm = exar_pm;
@@ -1522,11 +1519,8 @@ exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
 	maxnr = pci_resource_len(pcidev, bar) >> (board->reg_shift + 3);
 
 	nr_ports = exar_get_nr_ports(board, pcidev);
-	if (nr_ports == 0) {
-		dev_err_probe(&pcidev->dev, -ENODEV,
-				"failed to get number of ports\n");
-		return -ENODEV;
-	}
+	if (nr_ports == 0)
+		return dev_err_probe(&pcidev->dev, -ENODEV, "failed to get number of ports\n");
 
 	priv = devm_kzalloc(&pcidev->dev, struct_size(priv, line, nr_ports), GFP_KERNEL);
 	if (!priv)
@@ -1559,7 +1553,7 @@ exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
 	for (i = 0; i < nr_ports && i < maxnr; i++) {
 		rc = board->setup(priv, pcidev, &uart, i);
 		if (rc) {
-			dev_err(&pcidev->dev, "Failed to setup port %u\n", i);
+			dev_err_probe(&pcidev->dev, rc, "Failed to setup port %u\n", i);
 			break;
 		}
 
@@ -1568,10 +1562,9 @@ exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
 
 		priv->line[i] = serial8250_register_8250_port(&uart);
 		if (priv->line[i] < 0) {
-			dev_err(&pcidev->dev,
-				"Couldn't register serial port %lx, irq %d, type %d, error %d\n",
-				uart.port.iobase, uart.port.irq,
-				uart.port.iotype, priv->line[i]);
+			dev_err_probe(&pcidev->dev, priv->line[i],
+				"Couldn't register serial port %lx, type %d, irq %d\n",
+				uart.port.iobase, uart.port.iotype, uart.port.irq);
 			break;
 		}
 	}
-- 
2.43.0.rc1.1336.g36b5255a03ac


