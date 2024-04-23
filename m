Return-Path: <linux-kernel+bounces-155681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3F38AF593
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6A441F24D92
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0224313DDD1;
	Tue, 23 Apr 2024 17:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IJ/F6wjh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CABE13D287;
	Tue, 23 Apr 2024 17:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713893790; cv=none; b=HFOEOkkdIeiuBxA+/HOzUzr4fHOPZFWuJBVzBf7HCT8oKXtuhoU8amWrLmk7DdQoNmTB262vKeJ75dBYo49NssKUclfcZSe40ywFo5CqT8ParY+LflN3qLz777y+yaZEI0FWHU1wQ6EN9mfjnhC9dUEsn/AT1g/6Ee/1ol6YBE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713893790; c=relaxed/simple;
	bh=96a/hF+nh+YvRKYaFLg+hwTfTv2zLQG6m8D8hdW3Yfg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y42CXCso8wXgjBp2IvPDBoBIbtsHhCJ53QKKIrHk7ehXnOPFBsoKc/S3AP0ZRJK+YH93CS9bV2A2166ADYhofGeZZ8hJjS301HkMH7HhZhwdgz5JzsshwB16hqP1SqRwU30dnG62tc67Rz02oed5vVmnJXVNP2da2TzmJ+uDV9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IJ/F6wjh; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713893789; x=1745429789;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=96a/hF+nh+YvRKYaFLg+hwTfTv2zLQG6m8D8hdW3Yfg=;
  b=IJ/F6wjhSvyR2WfVA9NpK1mpb+KqRNG7kXpuDJPK1bjAMgf5pTkZ37Ig
   WQAET8xEhcwIqnc+XETAjMVICS+QWcc87lJRQw8kB+JpomDfK77qipDZ7
   BjcrE8m7uMtBbCpCV2m4RKgwR0fdB3FGhsfORm7SnTJH8rl43EwIwZxDc
   n8F1LB5r6kuVRpW6tv/jBfWOMgKtjPEWVvoa57FyB+9pJw8ZoC5NApH5X
   F7+JB1NgaAdqCfc9ViIDIxXIss6HtQ9eQS5Zj4qY2cDzLZad67qkBw6JK
   Zc6uLquGOuycRUiRL40LP+mxMqo+fRVQnFRD+QT5zYIA7RUqGLkOCl1K+
   w==;
X-CSE-ConnectionGUID: lzhs5B+zTL6K40jkYPWPMA==
X-CSE-MsgGUID: t2V7o337QeKERsxV+S+ehQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9658607"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9658607"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 10:36:29 -0700
X-CSE-ConnectionGUID: /8VeUUHTSHibYtTrwOiQ+g==
X-CSE-MsgGUID: kF4oE0xRSe6ufvujCxDwqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="47713735"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 23 Apr 2024 10:36:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 7EF5A192; Tue, 23 Apr 2024 20:36:25 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH v1 1/1] fbtft: seps525: Don't use "proxy" headers
Date: Tue, 23 Apr 2024 20:36:23 +0300
Message-ID: <20240423173623.2748621-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
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
 drivers/staging/fbtft/fb_seps525.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/fbtft/fb_seps525.c b/drivers/staging/fbtft/fb_seps525.c
index 05882e2cde7f..46c257308b49 100644
--- a/drivers/staging/fbtft/fb_seps525.c
+++ b/drivers/staging/fbtft/fb_seps525.c
@@ -16,11 +16,10 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/bits.h>
 #include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/module.h>
 
 #include "fbtft.h"
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


