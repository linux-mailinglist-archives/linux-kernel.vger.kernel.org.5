Return-Path: <linux-kernel+bounces-128619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34403895D1E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1E26289542
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE75C15ECD1;
	Tue,  2 Apr 2024 19:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yfk5EQ2Y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F4F15E5B1;
	Tue,  2 Apr 2024 19:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712087603; cv=none; b=V6gwID2fPKvR/EaYlA31l5CSeuRWDefBQTp0LcPU1Ivw4uxrZfyq/m9AeHP2j+D+vn9gZX8z9GhjLoLYPhUlRVCih5bon2WCcTnq8TUTNqhJA9NDF0HjdmUwUHnQyO3Juampit+Yo0jdP0gMMG0rvEyTivooTi8Gk2TIl9hn93A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712087603; c=relaxed/simple;
	bh=SwTcUDBjZbj3VUyVgmN94kgSUzBs3VieG+KuXT7YGZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UL4Jr2Hpvc/mx6Z2fxYOnremVX/IW457cmSDvmomKrL4pLYOqSADKBt6G76dMBYJDSb9FelE2pQPv6TqcKCkuqBvq5YDaYAKTrtc8XssWVLRZTrtAdjwHEQK/2Y7ezvPoOn9K8vW5dO1s5Omgh8i3u5MODFyLu7dEUIxAN/jjiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yfk5EQ2Y; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712087602; x=1743623602;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SwTcUDBjZbj3VUyVgmN94kgSUzBs3VieG+KuXT7YGZg=;
  b=Yfk5EQ2YT5iAC+eaMoPsqmiwxLL7EgRetHlqEIBwVu8NvzFTKAv2hXeP
   VMajvZe8hSnT4R/qzRhEw9Z0dCQocoZj2pG7VmZJWDFZbnF5pdjjBcFOB
   CxojfE3K7qhSiQsy6dB6SBO73KtOMX8SE9eJGJ9QO24XuS8nxQz08nSui
   nrOK0X6Ac18rzFjk8a5qg7qPwAo0DDdvokbuMG87bMuXs6VSJQxVzQdTw
   U/CQ8jXHHnPRZgvyO3l7cRO2U/JOpc3ZO4sPKN1uDveBd+XVVFCBBDphB
   rtTutn5dR07+36nUlcQa/h698JAf8RhnPsziAR4POFZiyN2BwCO51fuct
   w==;
X-CSE-ConnectionGUID: NY6zp3b+TDCwM1wzKmhblQ==
X-CSE-MsgGUID: HSYltHnJS965pAZvY8Xkkg==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7151030"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="7151030"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 12:53:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937083796"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="937083796"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2024 12:53:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1B581C74; Tue,  2 Apr 2024 22:53:10 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hugo@hugovil.com>
Subject: [PATCH v2 10/16] serial: max3100: Switch to use dev_err_probe()
Date: Tue,  2 Apr 2024 22:50:37 +0300
Message-ID: <20240402195306.269276-11-andriy.shevchenko@linux.intel.com>
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

Switch to use dev_err_probe() to simplify the error path and
unify a message template.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/max3100.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 85899ef010e9..d287fb377523 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -718,9 +718,8 @@ static int max3100_probe(struct spi_device *spi)
 	if (!uart_driver_registered) {
 		retval = uart_register_driver(&max3100_uart_driver);
 		if (retval) {
-			printk(KERN_ERR "Couldn't register max3100 uart driver\n");
 			mutex_unlock(&max3100s_lock);
-			return retval;
+			return dev_err_probe(dev, retval, "Couldn't register max3100 uart driver\n");
 		}
 
 		uart_driver_registered = 1;
@@ -730,15 +729,12 @@ static int max3100_probe(struct spi_device *spi)
 		if (!max3100s[i])
 			break;
 	if (i == MAX_MAX3100) {
-		dev_warn(&spi->dev, "too many MAX3100 chips\n");
 		mutex_unlock(&max3100s_lock);
-		return -ENOMEM;
+		return dev_err_probe(dev, -ENOMEM, "too many MAX3100 chips\n");
 	}
 
 	max3100s[i] = kzalloc(sizeof(struct max3100_port), GFP_KERNEL);
 	if (!max3100s[i]) {
-		dev_warn(&spi->dev,
-			 "kmalloc for max3100 structure %d failed!\n", i);
 		mutex_unlock(&max3100s_lock);
 		return -ENOMEM;
 	}
@@ -762,9 +758,7 @@ static int max3100_probe(struct spi_device *spi)
 
 	retval = uart_add_one_port(&max3100_uart_driver, &max3100s[i]->port);
 	if (retval < 0)
-		dev_warn(&spi->dev,
-			 "uart_add_one_port failed for line %d with error %d\n",
-			 i, retval);
+		dev_err_probe(dev, retval, "uart_add_one_port failed for line %d\n", i);
 
 	/* set shutdown mode to save power. Will be woken-up on open */
 	max3100_sr(max3100s[i], MAX3100_WC | MAX3100_SHDN, &rx);
-- 
2.43.0.rc1.1.gbec44491f096


