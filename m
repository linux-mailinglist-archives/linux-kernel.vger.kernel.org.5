Return-Path: <linux-kernel+bounces-131963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0D9898E03
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48BC9288F90
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C3D1327EB;
	Thu,  4 Apr 2024 18:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q1Go5UIF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81868130ACF;
	Thu,  4 Apr 2024 18:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712255702; cv=none; b=RnhZyCthCRhMr7Vcl1SdcFIo0fYzvAvFTPPBZSWdPxBuSaZX2YMoX3CLpmGaAoRHZTGtGNb9MWcBtC6J4om3jyJdZDCPjtkCN3A+mfeZTDZy+6toiD7TaNMvYN+lt4rbCnHl/AS+z7cbasLmSKWecBJSXeOgxx0sVfLhER0kwDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712255702; c=relaxed/simple;
	bh=85DPr1M713nmUHHni9kf5oNPao5iIopZ0TF1O8A9FAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sehLJaWUnSAmr5A/nCBY3g0RuVYwu3BBMuUgivyHz8ib2fLEo6d4P6gGpP6K75Vtz8VJpfDrhR6t3zlLLxFZ5W/fV9d6sEBdJLLIMd4bm22+2V+HRkEWV0nPYNwDATgUgWERyz9VwjjfEuF389XpLtlqMxTsvBsPtOwGLwbAeFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q1Go5UIF; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712255700; x=1743791700;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=85DPr1M713nmUHHni9kf5oNPao5iIopZ0TF1O8A9FAM=;
  b=Q1Go5UIFrG5zWXiSIS7zqCJjVhOYjqZ/x/a4CfewB/I9Ub8Rd8ztSEfk
   HuZr3ONwr6z+zf+kiqwY0ntwf1L39XG1lOhzi/825QsNRfjLN5SEWP5T2
   keK26re6FOYpUf5ESH7JCsBVPiAvOp3pCrhFTULb70/afrt+nHF6Bzh38
   +lIVYPl6r2w5jghQnq12VjcyhTlNtHiH+Yld40o468Vry+8/Jebysw7Jm
   s5Aw6Uk7UHPjeyIN4M2DdxN/eGtAWGIsyPwMkb2wkIkfAgpoYno6lZzbh
   jNkXYFCtcJLM9soTvB84FYHncdH6tivaty548ifrZeSa/rV3Slj347WPI
   w==;
X-CSE-ConnectionGUID: a6zpCmffSEykzr+/i+KbLw==
X-CSE-MsgGUID: SZld8nuHSpKbm+VqEX+lvw==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7751316"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="7751316"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 11:34:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="937086994"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="937086994"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Apr 2024 11:34:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9B0D53E5; Thu,  4 Apr 2024 21:34:54 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Zhang Rui <rui.zhang@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH v2 1/4] ACPI: x86: Introduce a Makefile
Date: Thu,  4 Apr 2024 21:23:39 +0300
Message-ID: <20240404183448.3310449-2-andriy.shevchenko@linux.intel.com>
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

There will be more modules coming here, so, introduce a separate
Makefile and include it in parent one via obj-$(CONFIG_X86).

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/Makefile     | 4 +---
 drivers/acpi/x86/Makefile | 4 ++++
 2 files changed, 5 insertions(+), 3 deletions(-)
 create mode 100644 drivers/acpi/x86/Makefile

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index d69d5444acdb..0db88aab309f 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -56,9 +56,6 @@ acpi-y				+= evged.o
 acpi-y				+= sysfs.o
 acpi-y				+= property.o
 acpi-$(CONFIG_X86)		+= acpi_cmos_rtc.o
-acpi-$(CONFIG_X86)		+= x86/apple.o
-acpi-$(CONFIG_X86)		+= x86/utils.o
-acpi-$(CONFIG_X86)		+= x86/s2idle.o
 acpi-$(CONFIG_DEBUG_FS)		+= debugfs.o
 acpi-y				+= acpi_lpat.o
 acpi-$(CONFIG_ACPI_FPDT)	+= acpi_fpdt.o
@@ -133,3 +130,4 @@ obj-$(CONFIG_ARM64)		+= arm64/
 obj-$(CONFIG_ACPI_VIOT)		+= viot.o
 
 obj-$(CONFIG_RISCV)		+= riscv/
+obj-$(CONFIG_X86)		+= x86/
diff --git a/drivers/acpi/x86/Makefile b/drivers/acpi/x86/Makefile
new file mode 100644
index 000000000000..bd17dd2c2c5b
--- /dev/null
+++ b/drivers/acpi/x86/Makefile
@@ -0,0 +1,4 @@
+obj-$(CONFIG_ACPI)	+= acpi-x86.o
+acpi-x86-y		+= apple.o
+acpi-x86-y		+= s2idle.o
+acpi-x86-y		+= utils.o
-- 
2.43.0.rc1.1.gbec44491f096


