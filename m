Return-Path: <linux-kernel+bounces-137411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F37589E1AF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B7891C220E7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDA415667C;
	Tue,  9 Apr 2024 17:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eruILjw4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCEA4C85
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 17:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712684369; cv=none; b=grylVD6AwXJrO/hMUxu1T4NOjGLRU94fmCgaD8yaLvzr/k2NkWxq7pLQXNsCCSn7PE7ftPqXTgeeXxuSz3BqNfa1Z3KblvjvzndUHH2GmhX1BN8WSBgyRCEzsVLrq5/2zFE56XJBa9K+uWClRpnXMctuN3ddEDIAYmQi0E4jnEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712684369; c=relaxed/simple;
	bh=D6no2q4BPXav0GadcSykjMo9DQS40m4v5xe13lK8CYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WsmHQijIJyTMUSaOUT7CKpHu+csE6Jax5pw+SNy+bcOx4TKWnj+zFNWeGQMDjdjzBlEWzwRdUOtVFdf235XnIFDNKUy4Pl7cCyT0M1/zqKrs4SkkUHLqf8N7mhbBY7teogg0KgUP5rIZr1B/oGXodqT0Z7U1Z+oejGw1I13Wtio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eruILjw4; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712684368; x=1744220368;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D6no2q4BPXav0GadcSykjMo9DQS40m4v5xe13lK8CYE=;
  b=eruILjw4QA6DGuSZq1iII/HaOLvf/2Jz00yrNdQDOUe8BzcuHZDOEOLV
   GKgudlGzjNKF+Jk5++E4FAL5J6WoA9TEFCXxvCwsiP1bnFHdxpegfvQbq
   BfAHqYPRXIrLAKlx2u5cqJdfrHxgWjpdYwNT4uQ1Nn6FgvRNU5xWJd8a6
   VjNev7yzW2Q9Wx71U+IRKPxYvUTpTRFj+su+M42MnB8j5iadwzE7j6w8S
   FDkPUFb8HiFayIMM9koDthuRuEdMxQFdrCGu8INFL7Rw6uT9hIFI8Bbm/
   FfdSStVCOeOwcxDT+QHGceGv070bTeAT5ZubfdW/ThqfOZGF/5NxHXbnW
   Q==;
X-CSE-ConnectionGUID: RZJmNilATfqvHEl08rueZg==
X-CSE-MsgGUID: Ml/vDtuuSrOgMduPOup4jA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11855962"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="11855962"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 10:39:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="937093673"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="937093673"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Apr 2024 10:39:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 0C70512C; Tue,  9 Apr 2024 20:39:23 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v1 1/1] auxdisplay: charlcd: Don't rebuild when CONFIG_PANEL_BOOT_MESSAGE=y
Date: Tue,  9 Apr 2024 20:39:21 +0300
Message-ID: <20240409173921.1080616-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_PANEL_BOOT_MESSAGE=y the module still includes
the generated header and gets rebuilt even if it doesn't use
anything from that header.  Include generated header conditionally
to avoid unnecessary rebuilds.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/charlcd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 5df019720c56..bb9463814454 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -17,7 +17,9 @@
 #include <linux/uaccess.h>
 #include <linux/workqueue.h>
 
+#ifndef CONFIG_PANEL_BOOT_MESSAGE
 #include <generated/utsrelease.h>
+#endif
 
 #include "charlcd.h"
 
-- 
2.43.0.rc1.1.gbec44491f096


