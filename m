Return-Path: <linux-kernel+bounces-166664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 815B08B9DC3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3890A1F2246E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEA915B968;
	Thu,  2 May 2024 15:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cWNrz1KP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877F52B9AC;
	Thu,  2 May 2024 15:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714664911; cv=none; b=eF+9oWTvPty2C7gJz2q8aHWGbLCNbgLMljLXpY/8bF2FihAb6uj0/7WuyvMPJB7AIw+PdTVwTewFFWZOrtmjoCtV58NdC/pcoMP2DFvNhn0ljZO55Rcs2UhThA/XoyGJomzWSoj458Nlnct57kzyUyAcnJrBOLYRGMk4OV3DL3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714664911; c=relaxed/simple;
	bh=l8doLW7JZkb1sxmzvSfab3CJDXy17ExrejxpBzOo1xw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=l3LPX9n+FRwxw5helPits/XvLI9jjMvERFkibaaOliLYXyvkeDkIhXGW8HdDbc3HonkT/NihVvARVATmu1BpQzqXIE6cgQBv9BfLJjH0dcJJMnWCswe1ENZNDNhp3ED2HGCZmE3umSxTYl1cspcqQ9QVcypWhJ5CnqoWJOl4wpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cWNrz1KP; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714664909; x=1746200909;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l8doLW7JZkb1sxmzvSfab3CJDXy17ExrejxpBzOo1xw=;
  b=cWNrz1KPJMDso+5qKebgowx5zpK9QNQa/wtujgCjokVtL8AgmxDlvhJt
   V4CkzY1M6PCDZPrzDn/aPCIR4p0pMexqy8BIibZTswHMF+BARq2pjjM4L
   PUIRlS4He/B2FFWcUMNaC6pbiPj1yWHxx5CuoQ107vTCo4nOi0ObGNq/G
   +TFRGSnZBWm3TfK0fR/DDKtV7sTQVCGvu4MeT4Zhnvq/Oq0+dpdApnSwf
   6mB/svv9Y1KyT8PmlH/UnLG9JKEO9vhCm1Sxy3Z1LlU9J6aaCndWqE6Mq
   zBzOnmSmLly+uIONvjrN2qB1fwt7qqiRQK8qj9cgkM4Wn0jdinc+5ydNG
   w==;
X-CSE-ConnectionGUID: Iv1oFcqGTOCbsGOXw3EWhA==
X-CSE-MsgGUID: MJmHhWyaSpWE7rv1b/TpuQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="21057059"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="21057059"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 08:48:28 -0700
X-CSE-ConnectionGUID: yr+IKKKyRca2WYTbxD+g8g==
X-CSE-MsgGUID: fQWcwUbnSLGdVW6ax+8q4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="58043493"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 02 May 2024 08:48:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2BBA2161; Thu,  2 May 2024 18:48:25 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] spi: bitbang: Use NSEC_PER_*SEC rather than hard coding
Date: Thu,  2 May 2024 18:48:25 +0300
Message-ID: <20240502154825.2752464-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use NSEC_PER_*SEC rather than the hard coded value of 1000s.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-bitbang.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
index a0e2204fc039..c11af39c9842 100644
--- a/drivers/spi/spi-bitbang.c
+++ b/drivers/spi/spi-bitbang.c
@@ -11,6 +11,7 @@
 #include <linux/errno.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/time64.h>
 
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
@@ -168,8 +169,8 @@ int spi_bitbang_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 	if (!hz)
 		hz = spi->max_speed_hz;
 	if (hz) {
-		cs->nsecs = (1000000000/2) / hz;
-		if (cs->nsecs > (MAX_UDELAY_MS * 1000 * 1000))
+		cs->nsecs = (NSEC_PER_SEC / 2) / hz;
+		if (cs->nsecs > (MAX_UDELAY_MS * NSEC_PER_MSEC))
 			return -EINVAL;
 	}
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


