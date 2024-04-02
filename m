Return-Path: <linux-kernel+bounces-128268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6108989587E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F386C1F253B7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06E913CC54;
	Tue,  2 Apr 2024 15:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ern3zW7G"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29195137770;
	Tue,  2 Apr 2024 15:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712072555; cv=none; b=rdg5k3erQ6Py559tGd6Rh+wUyX2Vd0QhGmy5h+YxGfPDNtNOCdMd66NVd7t8/alH8bnOpEsXw3e3cpTCXho9pamhc3kK3Y0IOMSOg0eP4ngbpFdNRkKgzb5mIntOD5QMFN1UznleH2KGGPDmxr8PePJuKtZ4BbZMI/ULKuRB1S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712072555; c=relaxed/simple;
	bh=OVHNlIP+AOoymkMOBF5BGMRhdK9G0XAGm3jDVh5hzgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V0AOg5g0wC3bq5kUEn29Uch3Nm5DFY3o4ab6Cd9ekVOzXKKK/yUpwCvOpoj4bUFTtGW55ONzOvk1PJicdlosLPZ5U5FqtF9YAk6Tc1M7pVVUlAxL4irfqQadAqLmNvuQXUXUXSlN+wm2nNVzjJ1ZHEx8X0QVkBZZoSC9E6nzTjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ern3zW7G; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712072554; x=1743608554;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OVHNlIP+AOoymkMOBF5BGMRhdK9G0XAGm3jDVh5hzgs=;
  b=Ern3zW7GHq19188pS7Dz3evoNGdHZnUP/byUZ4+nR6P9jG4ylvMe497W
   In0Jb7iW/c6stMaVMTr7wSW2ZwDNQ5L3Qcy0gRYo4heZd+oxNQB4Vdir6
   GV6PNUKjmPz5RA+MkG1fgtpmOcxFg/uRgM4VU3LnebZV64yEqZyFoIK5g
   o1Obn9ICiOmT3uSaah0kq49yYcOxnOlcEnopiEk8r4nvjVX7iPPp4LjKj
   0UKXgiYfsR0COl/CaZ9wfmZ0wNWFH19OIECB6o7uE01E7qEcv7zINsOCa
   1Rl5bQDm40gFv3YcD2A33ZeMClc9rzm8VEt1UvQjo53M1I9SwSvHNUzmJ
   w==;
X-CSE-ConnectionGUID: UlMApRsfTaG2SLQ3jplajQ==
X-CSE-MsgGUID: Uo57ieySRpyFRU69S8OH3Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="17870085"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="17870085"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 08:42:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937083646"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="937083646"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2024 08:42:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id AA91B812; Tue,  2 Apr 2024 18:42:20 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 11/16] serial: max3100: Replace MODULE_ALIAS() with respective ID tables
Date: Tue,  2 Apr 2024 18:38:17 +0300
Message-ID: <20240402154219.3583679-12-andriy.shevchenko@linux.intel.com>
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

MODULE_ALIAS() in most cases is a pure hack to avoid placing ID tables.
Replace it with the respective ID tables.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/max3100.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index c4e4dc5f0858..599665770b6e 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -19,6 +19,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/device.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/property.h>
 #include <linux/serial_core.h>
@@ -841,13 +842,27 @@ static SIMPLE_DEV_PM_OPS(max3100_pm_ops, max3100_suspend, max3100_resume);
 #define MAX3100_PM_OPS NULL
 #endif
 
+static const struct spi_device_id max3100_spi_id[] = {
+	{ "max3100" },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, max3100_spi_id);
+
+static const struct of_device_id max3100_of_match[] = {
+	{ .compatible = "maxim,max3100" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max3100_of_match);
+
 static struct spi_driver max3100_driver = {
 	.driver = {
 		.name		= "max3100",
+		.of_match_table	= max3100_of_match,
 		.pm		= MAX3100_PM_OPS,
 	},
 	.probe		= max3100_probe,
 	.remove		= max3100_remove,
+	.id_table	= max3100_spi_id,
 };
 
 module_spi_driver(max3100_driver);
@@ -855,4 +870,3 @@ module_spi_driver(max3100_driver);
 MODULE_DESCRIPTION("MAX3100 driver");
 MODULE_AUTHOR("Christian Pellegrin <chripell@evolware.org>");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("spi:max3100");
-- 
2.43.0.rc1.1.gbec44491f096


