Return-Path: <linux-kernel+bounces-131962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2E2898E02
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B8171F2874C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB31131E24;
	Thu,  4 Apr 2024 18:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GkJdFHDN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F96C130485;
	Thu,  4 Apr 2024 18:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712255701; cv=none; b=gsdFKJvtmYFwJ5Zm+mdVqCD3vgQG44nzQ2DkcLr6+wr4Go6Cwp6598B9KF5M5vhwYEllOxvXc7YGI1DaYJmpsNg9qD4vYn9hadvEPEunEc44TaJXfWuX5LzFCQUfi9ZI7fMlpL/tgHr4eLWJgiVCb5UZ0qqST1z9qk7fK0k03b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712255701; c=relaxed/simple;
	bh=VEomS2m+Bw/DPtcNvn269fWrjlZB0hREQwVjQOn0ITk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AwWppbUvmRlgNG3EaLxlc4QGYk/lMUsE+ISho9srKzXI3+y9b2J4PLjMRJIDacgYOMUFLjQ46zaSbFrbksSuW0yDy4QLqDD5C6GweKmF5pQ0zwDTzsi2B4XUpLnF8NJ2fyEzwJbySozYKjkbtzCnFGFy12wUJD8q5EJ2Qr7OFac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GkJdFHDN; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712255700; x=1743791700;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VEomS2m+Bw/DPtcNvn269fWrjlZB0hREQwVjQOn0ITk=;
  b=GkJdFHDNSrGSKvz+zw3VGXZBqotLvdHcTZ1IxyVvoh+V7tjtWZl3QMB0
   tp7hZmnTLH1z3172Kugkg5NP3MLuc3+ZU1s7/FgmbO0Z7DYxi/pPY/xE6
   88qaJA6xI61cf9RPSWKMWzm93qbCYhy0qENbhdm5GpPysMSMpdW8Ao6km
   37hL53FszRexw33uwCz+Xg5SDqW2F/kCIVHLclMLyxnRYaViBW0HjhyOw
   AI3rafE7p2Yd+2Sxh/k//33DvZotz3eJMjAV7PB6ExpnzuLTlrMEiKQL7
   r0H8QqLk6THR9lWIuCM/m9prlVJKGgVwyvtKS3g017UdV5t6mBphk8sAy
   w==;
X-CSE-ConnectionGUID: bU+0p/2LRPSuPhDvBb1MxQ==
X-CSE-MsgGUID: JRCg6aQoSH6EcZ5ChF+gRw==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7751313"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="7751313"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 11:34:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="937086990"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="937086990"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Apr 2024 11:34:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B3F6DC30; Thu,  4 Apr 2024 21:34:54 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Zhang Rui <rui.zhang@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH v2 3/4] ACPI: x86: Move blacklist to x86 folder
Date: Thu,  4 Apr 2024 21:23:41 +0300
Message-ID: <20240404183448.3310449-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240404183448.3310449-1-andriy.shevchenko@linux.intel.com>
References: <20240404183448.3310449-1-andriy.shevchenko@linux.intel.com>
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


