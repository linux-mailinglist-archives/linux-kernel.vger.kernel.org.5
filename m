Return-Path: <linux-kernel+bounces-9764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 300A581CB15
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAF141F21A06
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C25F1A733;
	Fri, 22 Dec 2023 14:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D9upf6vb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266D61A5A2
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 14:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703253849; x=1734789849;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nyzEnZioE83pYhCmupX2qm6TLMbQiT9al2DULrAL15s=;
  b=D9upf6vbJpSkNcx10RA9/QN2ZgJDSDq9px9rZoOVJhoT7DOqQVtW55su
   d0lg8JtXgjp8UAqtxkJ8gMXbEH+iZl61FWC0gYRo9m4p3/8ohHHFtRdnv
   HYz2W9z1Todvdff5MQd2RMT9yLHG7TJI/cwGo7VjkaFTLN15BiY1sVMOY
   ZP9ZmLXZQF62lmuRIr+LV89uBFugvClMVDRggOmdD7dwK4xb7i8nHdsJZ
   gtmjZGEb27qllBQqVeORsMn5GhnluQeH+bol5CX23h60TCkypMxwRJNcW
   IRXosFngwqr7TSA8AJzzhQJ8B+eT84h5hhNCyMSzdXOfSGN1f17SN6xwT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="2964149"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="2964149"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 06:04:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="805948867"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="805948867"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 22 Dec 2023 06:04:06 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 29672291; Fri, 22 Dec 2023 16:04:05 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] bitmap: Step down as a reviewer
Date: Fri, 22 Dec 2023 16:04:02 +0200
Message-ID: <20231222140402.2887556-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Too many things are going on, and reviewing BITMAP related code
seems not the best I can do, hence step down as a reviewer of
the BITMAP library.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8b686a9fa068..2e0e74681511 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3580,7 +3580,6 @@ F:	include/uapi/linux/bfs_fs.h
 
 BITMAP API
 M:	Yury Norov <yury.norov@gmail.com>
-R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 R:	Rasmus Villemoes <linux@rasmusvillemoes.dk>
 S:	Maintained
 F:	include/linux/bitfield.h
-- 
2.43.0.rc1.1.gbec44491f096


