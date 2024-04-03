Return-Path: <linux-kernel+bounces-130245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 299B98975E1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D36BB1F29B01
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB60152521;
	Wed,  3 Apr 2024 17:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GKUZ9a85"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00E4152E11;
	Wed,  3 Apr 2024 17:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712163793; cv=none; b=rt6PcsqRPl0rWJrdmmVBP2gv80Vc+vzkaqWmsO/HTPEox5LomGVtS2rgChBUpvILOlTzk8jGVAdj2nHC2UaVCkRWOSNEeK0dUw4HE0buqT3qw5AbGbPNaN6BsVfuIzxLNDq5MuSNj3ncwXdsNbfcvws/WY0CSAqVrpagvLK7CDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712163793; c=relaxed/simple;
	bh=VEomS2m+Bw/DPtcNvn269fWrjlZB0hREQwVjQOn0ITk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PimLyEHL67szEqNtiJC7i6FNZpphHLOgtNtzwEsEb3xLhAq/Q2L4meDYrACbcg4y7/of9cZAwyJoVgm54A6nzALH8eKR0Xg/LRbkG62ZjbSkfyqa7xB+bu8c6nyn6dAP21bBIkGKlY9zm+S5P0hNO0yXFxaRd+PfxCqVgd9pePQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GKUZ9a85; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712163792; x=1743699792;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VEomS2m+Bw/DPtcNvn269fWrjlZB0hREQwVjQOn0ITk=;
  b=GKUZ9a85OfZBONoz2lezCfAgwIkuH8f7vG5NRFBB7XWCr1mTdBs0XppH
   wGBkUfg7Dq9kdD49u54k3dH/YFD3+V8cyX3wuUgQ7U0InfAz4CenCdnXB
   ZaUyhCLkVrFbYQjrgt3a94pDm9ZMN/Rb2vjAG0yFizFWGyh5n0cV0nntJ
   4vBFROO54VJvwULxJCDeuaTXW1RqHzsG3NFxTkSb3uLCODRKZ/QZdYY4B
   bxgx46DgN9iButh7fFrA3/xJ7Sus9VG1DS58QHjasEJiQrA2g+cXIClGt
   EjHUcH4IPgft6Vo5V5hLrqyoQJdamow/YqTnsiTZKeMeQ/6D839foyXdx
   w==;
X-CSE-ConnectionGUID: N8KqgzMpTASsA+x2AJULPQ==
X-CSE-MsgGUID: szju7E1MQwOf3a17C7mIaA==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="18861492"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18861492"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 10:03:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="937085336"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="937085336"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Apr 2024 10:03:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 15B61670; Wed,  3 Apr 2024 20:03:05 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Zhang Rui <rui.zhang@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH v1 3/4] ACPI: x86: Move blacklist to x86 folder
Date: Wed,  3 Apr 2024 19:54:37 +0300
Message-ID: <20240403170302.1073841-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240403170302.1073841-1-andriy.shevchenko@linux.intel.com>
References: <20240403170302.1073841-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blacklist is built solely for x86, move it to the respective folder.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/Makefile              | 1 -
 drivers/acpi/x86/Makefile          | 2 ++
 drivers/acpi/{ => x86}/blacklist.c | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)
 rename drivers/acpi/{ => x86}/blacklist.c (99%)

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 413c18e2bf61..6f4187a34f41 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -14,7 +14,6 @@ tables.o: $(src)/../../include/$(CONFIG_ACPI_CUSTOM_DSDT_FILE) ;
 endif
 
 obj-$(CONFIG_ACPI)		+= tables.o
-obj-$(CONFIG_X86)		+= blacklist.o
 
 #
 # ACPI Core Subsystem (Interpreter)
diff --git a/drivers/acpi/x86/Makefile b/drivers/acpi/x86/Makefile
index b97b1bcf8404..1f3c5fa84f9e 100644
--- a/drivers/acpi/x86/Makefile
+++ b/drivers/acpi/x86/Makefile
@@ -3,3 +3,5 @@ acpi-x86-y		+= apple.o
 acpi-x86-y		+= cmos_rtc.o
 acpi-x86-y		+= s2idle.o
 acpi-x86-y		+= utils.o
+
+obj-$(CONFIG_X86)	+= blacklist.o
diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/x86/blacklist.c
similarity index 99%
rename from drivers/acpi/blacklist.c
rename to drivers/acpi/x86/blacklist.c
index a558d24fb788..55214d0a12b1 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/x86/blacklist.c
@@ -17,7 +17,7 @@
 #include <linux/acpi.h>
 #include <linux/dmi.h>
 
-#include "internal.h"
+#include "../internal.h"
 
 #ifdef CONFIG_DMI
 static const struct dmi_system_id acpi_rev_dmi_table[] __initconst;
-- 
2.43.0.rc1.1.gbec44491f096


