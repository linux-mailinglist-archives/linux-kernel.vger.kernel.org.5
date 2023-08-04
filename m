Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF2C76FBF8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbjHDI0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234564AbjHDI02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:26:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF24A4696
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691137586; x=1722673586;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9je9OUfnXEviEXKQNXB4gUKmQR3Ey4mpBgwuRjMpZ5o=;
  b=mlSVorM3xUk2ULomzOf0Uwsstg78ZW3bu6sMBjntjXgz+1fTepacBxxB
   6a1P3PaHrbyKC/BW+Cps4hGSJjm+obUMtoxQPH9coDf/HFr6qqsTDxYon
   /xKr+8F5Nh6Z975giawYu8Q+3+EN2oBlyTQi/QiqTuMOgVaI6+t6DCqC0
   UGeEUU4ifKVIAwfV+k0/QcKDV6pYAgN5fDTS/gLtBF3vRqsla0sUiqM8Q
   4tmwPhI2eJuxet6FIOO5Neh1kUs8GO7hWtK4a/QTVCF2vytpO36EKZ5TP
   EjJhH2BHRxvcsK0IcPS/uD+4ITs5FC/E2c2KY3Y3lTW9cpUNeipG6SSem
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="370090221"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="370090221"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 01:26:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="733132238"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="733132238"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 04 Aug 2023 01:26:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 868F8F4D; Fri,  4 Aug 2023 11:26:32 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 2/4] lib/vsprintf: Sort headers alphabetically
Date:   Fri,  4 Aug 2023 11:26:17 +0300
Message-Id: <20230804082619.61833-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230804082619.61833-1-andriy.shevchenko@linux.intel.com>
References: <20230804082619.61833-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorting headers alphabetically helps locating duplicates, and
make it easier to figure out where to insert new headers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/vsprintf.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 6774cf84e623..63afffab4249 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -17,42 +17,44 @@
  * - scnprintf and vscnprintf
  */
 
-#include <linux/stdarg.h>
 #include <linux/build_bug.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
-#include <linux/errname.h>
-#include <linux/module.h>	/* for KSYM_SYMBOL_LEN */
-#include <linux/types.h>
-#include <linux/string.h>
+#include <linux/compiler.h>
+#include <linux/cred.h>
 #include <linux/ctype.h>
-#include <linux/kernel.h>
+#include <linux/dcache.h>
+#include <linux/errname.h>
+#include <linux/ioport.h>
 #include <linux/kallsyms.h>
+#include <linux/kernel.h>
 #include <linux/math64.h>
-#include <linux/uaccess.h>
-#include <linux/ioport.h>
-#include <linux/dcache.h>
-#include <linux/cred.h>
+#include <linux/module.h>	/* for KSYM_SYMBOL_LEN */
+#include <linux/notifier.h>
+#include <linux/of.h>
+#include <linux/property.h>
 #include <linux/rtc.h>
+#include <linux/siphash.h>
+#include <linux/stdarg.h>
+#include <linux/string.h>
+#include <linux/string_helpers.h>
 #include <linux/time.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
 #include <linux/uuid.h>
-#include <linux/of.h>
-#include <net/addrconf.h>
-#include <linux/siphash.h>
-#include <linux/compiler.h>
-#include <linux/property.h>
-#include <linux/notifier.h>
+
 #ifdef CONFIG_BLOCK
 #include <linux/blkdev.h>
 #endif
 
+#include <net/addrconf.h>
+
 #include "../mm/internal.h"	/* For the trace_print_flags arrays */
 
-#include <asm/page.h>		/* for PAGE_SIZE */
 #include <asm/byteorder.h>	/* cpu_to_le16 */
+#include <asm/page.h>		/* for PAGE_SIZE */
 #include <asm/unaligned.h>
 
-#include <linux/string_helpers.h>
 #include "kstrtox.h"
 #include "vsprintf.h"
 
-- 
2.40.0.1.gaa8946217a0b

