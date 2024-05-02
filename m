Return-Path: <linux-kernel+bounces-166592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB358B9CC5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AED41F243B2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA711155386;
	Thu,  2 May 2024 14:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PvmcOPeO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFAF1591F6;
	Thu,  2 May 2024 14:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714661205; cv=none; b=pLYeb1VD9EL890ReRJ1rIfspUjyWzjMpwleOZ/VYDDlp0bcRm4SxOrp+KiydKt/Ry0WhVx63zJ2YaJHgjPYo6t75KatBJIDtC/t5AoPWpj/Bvvl93Ig+ywV0IFevBO3iwpT6nMvYxUqti6mh6eleuMFZSIYOyY93ViGp6Xmlyf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714661205; c=relaxed/simple;
	bh=HSPO3BYYrHNKLlywx1qmFZnk+RVxu/4s6sl1HAdCBHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rRLKHSjYOHdq0CVAkwNmcC3dAcLktgbIX0bi3sdaO+Spl8UspdsuwHMANrWPZvmAoQldLbhJ/Y9Hbuv8dfghov8BVsjw20hNM/siCVW498vXtGSDF9oQjh8q4FN/TAritNOPYs+KGEnfYyQlGxn8BmbrnVmyCGE7txTVFUuNOE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PvmcOPeO; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714661204; x=1746197204;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HSPO3BYYrHNKLlywx1qmFZnk+RVxu/4s6sl1HAdCBHQ=;
  b=PvmcOPeOuJ8nduja8qSHFdp4c/KDnRTWIUov+H/c+NcdYzxFSW/womri
   OJqKMb2xwkvCLnhWLXGWbyIZjQ+aDaFV8paV8gpfsiCbwGWd6Drf9mIjN
   89A7/c0RcBXWyPajiUwnWZPI4c1vZzFTooqgYrtlb+oh62QONCC3S7vL+
   Eeavd9ZLbhxUrOnNF2y53YnrDoK8hMnpwd8IahmzHXXvkUIAuhjMM7rmC
   LyZewBANcEHGXoLqXqsYiWADrGtH1A8rySr6mNSG7NQQJAUiBKfHIpL85
   yWR+/yMcleVkuFSYTtrljYPB6p7DYh8tI0h7k4u5qrAcKSrYbvLJaK5qA
   w==;
X-CSE-ConnectionGUID: Dc1aEHjWRB+VBRE9xKuk6Q==
X-CSE-MsgGUID: 3MMmZuRjTk6pKM4K9sRLRA==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10306108"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10306108"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 07:46:36 -0700
X-CSE-ConnectionGUID: ydObUywyQCS8i0iX4ZKWng==
X-CSE-MsgGUID: HDeGRwNCR4Wbj1bmJdvCJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="31632845"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 02 May 2024 07:46:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 44F2AC32; Thu,  2 May 2024 17:46:31 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <pnewman@connecttech.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 10/13] serial: 8250_exar: Switch to use dev_err_probe()
Date: Thu,  2 May 2024 17:44:04 +0300
Message-ID: <20240502144626.2716994-11-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240502144626.2716994-1-andriy.shevchenko@linux.intel.com>
References: <20240502144626.2716994-1-andriy.shevchenko@linux.intel.com>
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


