Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7575C771120
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 19:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjHERtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 13:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHERtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 13:49:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F91113
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 10:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691257772; x=1722793772;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TaWK1Xu3PSHBh+Y6Cr3TB9YkGt2K3wWn+qk8w07ZH0o=;
  b=g/CpRM8xlQOPLXmAGYKhV8OPTNIvdJobFPwILj/+rklUMyglYZgNPqUu
   snPru4u7ezWyTUsREw52VHkK4uoV7RgfCEoLRD47WIlGDeXRQyePYt0zq
   EU2rCTEotJDFnVYb/hgd45vM18czwYOWHeDueRWATtCKuVeGCHgbz9vrV
   c6KzAavNlX1ILE3lJq374ePu58n+5uiH7ae7N3Ch1+Y0eDXBbngj1HCGv
   c/IIbI9rB/xPvFH/vpLRt/aFR2FcdhwpRjYMtkXXUWHDmxKr/XTeNY4Rb
   TumKo2I+r9OCAXzGSMjp6xQJmLl6bZunI3pwfXoiQvpdUTC6xfK0839qS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10793"; a="401292528"
X-IronPort-AV: E=Sophos;i="6.01,258,1684825200"; 
   d="scan'208";a="401292528"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2023 10:49:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10793"; a="820494257"
X-IronPort-AV: E=Sophos;i="6.01,258,1684825200"; 
   d="scan'208";a="820494257"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Aug 2023 10:49:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 905ABF7; Sat,  5 Aug 2023 20:50:29 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>, Marco Elver <elver@google.com>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 1/3] lib/vsprintf: Sort headers alphabetically
Date:   Sat,  5 Aug 2023 20:50:25 +0300
Message-Id: <20230805175027.50029-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230805175027.50029-1-andriy.shevchenko@linux.intel.com>
References: <20230805175027.50029-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorting headers alphabetically helps locating duplicates, and
make it easier to figure out where to insert new headers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/test_printf.c | 17 +++++++----------
 lib/vsprintf.c    | 38 ++++++++++++++++++++------------------
 2 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/lib/test_printf.c b/lib/test_printf.c
index 7677ebccf3c3..2ab09a0dc841 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -5,24 +5,21 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/bitmap.h>
+#include <linux/dcache.h>
+#include <linux/gfp.h>
+#include <linux/in.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/printk.h>
+#include <linux/property.h>
 #include <linux/random.h>
 #include <linux/rtc.h>
 #include <linux/slab.h>
-#include <linux/string.h>
-
-#include <linux/bitmap.h>
-#include <linux/dcache.h>
 #include <linux/socket.h>
-#include <linux/in.h>
-
-#include <linux/gfp.h>
-#include <linux/mm.h>
-
-#include <linux/property.h>
+#include <linux/string.h>
 
 #include "../tools/testing/selftests/kselftest_module.h"
 
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 40f560959b16..b17e0744a7bc 100644
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
 
 /* Disable pointer hashing if requested */
-- 
2.40.0.1.gaa8946217a0b

