Return-Path: <linux-kernel+bounces-8557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E6B81B95D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99D901F216BE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CED6D6DD;
	Thu, 21 Dec 2023 14:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EwdpX4On"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1A06D6D8
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703168129; x=1734704129;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iMrCzrWJJr1u3QicO//ObHnKRcxYI0V8zbYVzyhczoU=;
  b=EwdpX4OnO0wfZcSJu9F+0w60dCT8D7vEBuhuHY+e1D9T+CX/xMk8B3E0
   GQTnc0Ku9dUQQ3lxZqg9btCiC/8aWEWxNeS/ot3ehPiJkXDrvg/sLfw/u
   njJaYbyOiv9W5UQpJaf5CoxKjytLcsE+y0pMQZ+gSC4WvHkttL7Ipustl
   sAvSHtBZ//EUxzufMYslXeGf7dF/OE4KhL2g5PrJHqP981Q/FvlpvzvuU
   HMRsZ0Vh3HJS9+bbqcGWLT7gclIMXyBfDv09nsbOLIVWfVN7xD6uzubUm
   7cYH8qF86QnbCO57ZOA7VU0B5Z8/sGigqr7zKJeQOis+EfMx4ueJls34U
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="2813496"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="2813496"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 06:15:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="810978509"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="810978509"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 21 Dec 2023 06:15:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D9C0EE6; Thu, 21 Dec 2023 16:09:25 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] pvpanic: Kill duplicate PCI_VENDOR_ID_REDHAT definition
Date: Thu, 21 Dec 2023 16:09:21 +0200
Message-ID: <20231221140921.2760432-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCI_VENDOR_ID_REDHAT is already defined in pci_ids.h. Kill the dup.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/misc/pvpanic/pvpanic-pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/pvpanic/pvpanic-pci.c b/drivers/misc/pvpanic/pvpanic-pci.c
index 689af4c28c2a..c5fb6298cb8d 100644
--- a/drivers/misc/pvpanic/pvpanic-pci.c
+++ b/drivers/misc/pvpanic/pvpanic-pci.c
@@ -15,7 +15,6 @@
 
 #include "pvpanic.h"
 
-#define PCI_VENDOR_ID_REDHAT             0x1b36
 #define PCI_DEVICE_ID_REDHAT_PVPANIC     0x0011
 
 MODULE_AUTHOR("Mihai Carabas <mihai.carabas@oracle.com>");
-- 
2.43.0.rc1.1.gbec44491f096


