Return-Path: <linux-kernel+bounces-8585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D79481B9C7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CC98B216AE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5065A1DFF1;
	Thu, 21 Dec 2023 14:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K9JaXGxr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508FF6D6EE
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 14:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703169892; x=1734705892;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=S2RiX7drH6eYvkjw/CmKNkPN7b+VfhWejHLXExiN+nY=;
  b=K9JaXGxrdI3dW/A+u7PPxIw1mQIwwMC187f4dIw7MyosA2VqLS2EmRzn
   Laq6ATLj5eWAL594wLTQCkELhOSDl9uG8/MgTle6U7Cz0H1o/JGvCk/Ms
   pRfXQIRMRGRVjfbaNUr4ASIdSUBYeK9v1jHnnyWhusJeDMuwRnlpCs0HN
   gpGOR4T6As/vb9PAx9YKlqPORH42DvI5jNZoHzZd8e5lW66Ehgw++yADX
   DjUEGOrCcX+UsWs8Xhp8RQyFPllE5Cr/wiL4joAem89Y340UHX93UAMuI
   ECBX3QIP+oet/f68loFeRMPBkVAHLNIFvxASsIc6E7RmN98hwjKzLebK6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="386408457"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="386408457"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 06:44:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="847131730"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="847131730"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 21 Dec 2023 06:44:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id AF117E6; Thu, 21 Dec 2023 16:44:48 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1 1/1] pvpanic: Don't use "proxy" headers
Date: Thu, 21 Dec 2023 16:44:47 +0200
Message-ID: <20231221144447.2762077-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update header inclusions to follow IWYU (Include What You Use)
principle.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/misc/pvpanic/pvpanic-mmio.c |  7 +++----
 drivers/misc/pvpanic/pvpanic-pci.c  |  5 +----
 drivers/misc/pvpanic/pvpanic.c      | 12 ++++++++----
 drivers/misc/pvpanic/pvpanic.h      |  5 +++++
 4 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/pvpanic/pvpanic-mmio.c b/drivers/misc/pvpanic/pvpanic-mmio.c
index 9715798acce3..f3f2113a54a7 100644
--- a/drivers/misc/pvpanic/pvpanic-mmio.c
+++ b/drivers/misc/pvpanic/pvpanic-mmio.c
@@ -7,16 +7,15 @@
  *  Copyright (C) 2021 Oracle.
  */
 
+#include <linux/device.h>
+#include <linux/err.h>
 #include <linux/io.h>
-#include <linux/kernel.h>
+#include <linux/ioport.h>
 #include <linux/kexec.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
-#include <linux/slab.h>
-
-#include <uapi/misc/pvpanic.h>
 
 #include "pvpanic.h"
 
diff --git a/drivers/misc/pvpanic/pvpanic-pci.c b/drivers/misc/pvpanic/pvpanic-pci.c
index c5fb6298cb8d..9ad20e82785b 100644
--- a/drivers/misc/pvpanic/pvpanic-pci.c
+++ b/drivers/misc/pvpanic/pvpanic-pci.c
@@ -5,13 +5,10 @@
  *  Copyright (C) 2021 Oracle.
  */
 
-#include <linux/kernel.h>
+#include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/types.h>
-#include <linux/slab.h>
-
-#include <uapi/misc/pvpanic.h>
 
 #include "pvpanic.h"
 
diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
index 305b367e0ce3..df3457ce1cb1 100644
--- a/drivers/misc/pvpanic/pvpanic.c
+++ b/drivers/misc/pvpanic/pvpanic.c
@@ -8,16 +8,20 @@
  */
 
 #include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/gfp_types.h>
 #include <linux/io.h>
-#include <linux/kernel.h>
 #include <linux/kexec.h>
+#include <linux/kstrtox.h>
+#include <linux/limits.h>
+#include <linux/list.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/platform_device.h>
 #include <linux/panic_notifier.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+#include <linux/sysfs.h>
 #include <linux/types.h>
-#include <linux/cdev.h>
-#include <linux/list.h>
 
 #include <uapi/misc/pvpanic.h>
 
diff --git a/drivers/misc/pvpanic/pvpanic.h b/drivers/misc/pvpanic/pvpanic.h
index 46ffb10438ad..a42fa760eed5 100644
--- a/drivers/misc/pvpanic/pvpanic.h
+++ b/drivers/misc/pvpanic/pvpanic.h
@@ -8,6 +8,11 @@
 #ifndef PVPANIC_H_
 #define PVPANIC_H_
 
+#include <linux/compiler_types.h>
+
+struct attribute_group;
+struct device;
+
 int devm_pvpanic_probe(struct device *dev, void __iomem *base);
 extern const struct attribute_group *pvpanic_dev_groups[];
 
-- 
2.43.0.rc1.1.gbec44491f096


