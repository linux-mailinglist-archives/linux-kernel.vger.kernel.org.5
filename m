Return-Path: <linux-kernel+bounces-128261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D352989586F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89E321F249EE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4983135A63;
	Tue,  2 Apr 2024 15:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IlDQGPkT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6820D134730;
	Tue,  2 Apr 2024 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712072550; cv=none; b=bMm7MpWU1HLeH/iLk1yelBtc6d0Ok7YhE2SV7T3fbIBi7Eyn6wAfn+UpZOBhlx8sfpN4HCFzSrzau8ddbZDnKnWgrn0Ps8ZinubrJA8kFzpsZEWP5TGlXOQMykrWT3EwSsPet3nTdC9uZS86yAveN9MmKDDPIMD5AeZpzXEF9Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712072550; c=relaxed/simple;
	bh=LcqZFh6/V3ILmvm1KWfU5KvKxMmRC9e8E1vyzCpbkO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXD/uN09h88CWjJ0Cx+fT9azkKlieOZ857d3T4+7JD6RCdwnfo5pdm7upSJJWaTBBkmFWzpXNJCFJE7L6rOK2uAd7aZLEWdv+mU9tJ4UP+jmzFl5QpldZejc8CdR57oe9pjf4rbvEKbt3X1N/P17aA16TJc9ofHeLni9FMzVpiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IlDQGPkT; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712072549; x=1743608549;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LcqZFh6/V3ILmvm1KWfU5KvKxMmRC9e8E1vyzCpbkO0=;
  b=IlDQGPkTnFbN7FS3YRRXNOGsjVhdUVACNa7R9UAVeoTWeFQh0yTx5vN5
   f5+ej/h3uIvzMEHUEeD2Le8tt93mjkd7s7IeWoHdtZf5w1WoDDKg43L39
   R8f06Vuz3pqZKCQ9CXTWlenOcxOpMJu7iKReMv270VcKb+yCvKGQCwQ6I
   OXj1OnhIicAVBGWqCwfjH7o49ZjzHCoDpWpgjqDeFfAixL+gl0A35aLm2
   JTS/SSDIkowtxzUVYYi+Db1p77BcvBpStWsJABVeez9yamYeWSxS1ZV3N
   qiFlu/Bg9Zf3VcbLifo8d0aJPJI6pd3EJL5FaS9T4TLAaybvP/OmrhuC4
   w==;
X-CSE-ConnectionGUID: 2TuxaaalQnek3TFHY3LrrA==
X-CSE-MsgGUID: pjcKM7UrSoudoVEyiC0k2A==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="17870072"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="17870072"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 08:42:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937083644"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="937083644"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2024 08:42:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A367B1506; Tue,  2 Apr 2024 18:42:20 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 10/16] serial: max3100: Switch to use dev_err_probe()
Date: Tue,  2 Apr 2024 18:38:16 +0300
Message-ID: <20240402154219.3583679-11-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240402154219.3583679-1-andriy.shevchenko@linux.intel.com>
References: <20240402154219.3583679-1-andriy.shevchenko@linux.intel.com>
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
index e7963382bbb6..c4e4dc5f0858 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -719,9 +719,8 @@ static int max3100_probe(struct spi_device *spi)
 		uart_driver_registered = 1;
 		retval = uart_register_driver(&max3100_uart_driver);
 		if (retval) {
-			printk(KERN_ERR "Couldn't register max3100 uart driver\n");
 			mutex_unlock(&max3100s_lock);
-			return retval;
+			return dev_err_probe(dev, retval, "Couldn't register max3100 uart driver\n");
 		}
 	}
 
@@ -729,15 +728,12 @@ static int max3100_probe(struct spi_device *spi)
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
@@ -761,9 +757,7 @@ static int max3100_probe(struct spi_device *spi)
 
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


