Return-Path: <linux-kernel+bounces-155799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2081C8AF746
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B53D01F22A09
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6436F1420DF;
	Tue, 23 Apr 2024 19:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bcpZqX+0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8CF13F459;
	Tue, 23 Apr 2024 19:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713900338; cv=none; b=CHAKnp/cQYjl60SS745sGYghDDgabH3jqF9Mtvw5hJDMyfkaW2RklGMe8YD/OwExwxZf50ivlCidUmzfMaB9m4KMjs578rqadW5WsPxXwiS8/67w8Bc+YT2XTXt3MgatdJM+2SHaCyPUOzB1H9mPuLLZf14zFE6TYZ29LVWXNao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713900338; c=relaxed/simple;
	bh=iARSuX9KuhJ/Yd1VAlCEEM5wx1EpDHoBr77TViozzoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k9c3F2KGCddltwipzMbAnxNEwStsERJT1IJYUA5npEjIoJRvPhF1C2/F//T/is85gLfwap+na3VcY9ctlq8RsM+G3ytJYaQtJ2R4EfefRjZPK47/ha++/NarHWcj4oGpZDgUkWHg22S0OipIibQ6hXjiRiEOGq+sUkQWl7gN+v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bcpZqX+0; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713900337; x=1745436337;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iARSuX9KuhJ/Yd1VAlCEEM5wx1EpDHoBr77TViozzoM=;
  b=bcpZqX+0DOAVG7xzEVPKU/SKFb8ok9xbKdHwKyOuJJgPssWEA1SYZdgZ
   i+V/dPuyb7yJazszlCFz9P+m5OWtLj0XF1USQ5/isii+HToHlfjgn3elE
   K5GcgVAzhiJZWlAtIFHFe2HdZkpNLEXekyMu2SIoW/Miweq7H23K593Lw
   DwmR9g/DY8Tc9zIk6SLch/xhW5dU8fq1s2aSN+cY21LQmabzwvndOAcl8
   q4qXP7J9HHXXOaXKWtFGbNQJP9EQqgLD4/UJnlbzc0rwpJykZCS/jQaj4
   Ldf0pj2uxtqO+2dm8c/k6clgJ3S/C8C+k1tLhoHb24Z0Sp6bms4yI4K8S
   g==;
X-CSE-ConnectionGUID: PWu/iOuOQP6hBpOi3Nx2jg==
X-CSE-MsgGUID: e1sMQ35cR+uml74cwaOesg==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9613658"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9613658"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 12:25:36 -0700
X-CSE-ConnectionGUID: w/ztJlpcRnuDr+9rvjbvpw==
X-CSE-MsgGUID: v5WeMhnJTXS6NM71pfP0ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24440742"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 23 Apr 2024 12:25:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D372D489; Tue, 23 Apr 2024 22:25:30 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rob Herring <robh@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Cc: Alain Volmat <alain.volmat@foss.st.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sean Wang <sean.wang@mediatek.com>,
	Sean Young <sean@mess.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 3/3] kfifo: Don't use "proxy" headers
Date: Tue, 23 Apr 2024 22:23:10 +0300
Message-ID: <20240423192529.3249134-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240423192529.3249134-1-andriy.shevchenko@linux.intel.com>
References: <20240423192529.3249134-1-andriy.shevchenko@linux.intel.com>
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
 include/linux/kfifo.h       |  9 +++++++--
 lib/kfifo.c                 | 10 +++++-----
 samples/kfifo/dma-example.c |  3 ++-
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/linux/kfifo.h b/include/linux/kfifo.h
index 0b35a41440ff..6b28d642f332 100644
--- a/include/linux/kfifo.h
+++ b/include/linux/kfifo.h
@@ -36,10 +36,15 @@
  * to lock the reader.
  */
 
-#include <linux/kernel.h>
+#include <linux/array_size.h>
 #include <linux/spinlock.h>
 #include <linux/stddef.h>
-#include <linux/scatterlist.h>
+#include <linux/types.h>
+
+#include <asm/barrier.h>
+#include <asm/errno.h>
+
+struct scatterlist;
 
 struct __kfifo {
 	unsigned int	in;
diff --git a/lib/kfifo.c b/lib/kfifo.c
index 12f5a347aa13..15acdee4a8f3 100644
--- a/lib/kfifo.c
+++ b/lib/kfifo.c
@@ -5,13 +5,13 @@
  * Copyright (C) 2009/2010 Stefani Seibold <stefani@seibold.net>
  */
 
-#include <linux/kernel.h>
-#include <linux/export.h>
-#include <linux/slab.h>
 #include <linux/err.h>
-#include <linux/log2.h>
-#include <linux/uaccess.h>
+#include <linux/export.h>
 #include <linux/kfifo.h>
+#include <linux/log2.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
 
 /*
  * internal helper to calculate the unused elements in a fifo
diff --git a/samples/kfifo/dma-example.c b/samples/kfifo/dma-example.c
index 0cf27483cb36..74fe915b7ffe 100644
--- a/samples/kfifo/dma-example.c
+++ b/samples/kfifo/dma-example.c
@@ -6,8 +6,9 @@
  */
 
 #include <linux/init.h>
-#include <linux/module.h>
 #include <linux/kfifo.h>
+#include <linux/module.h>
+#include <linux/scatterlist.h>
 
 /*
  * This module shows how to handle fifo dma operations.
-- 
2.43.0.rc1.1336.g36b5255a03ac


