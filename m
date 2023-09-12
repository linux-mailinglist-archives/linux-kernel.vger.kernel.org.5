Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B3379D460
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236203AbjILPHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236276AbjILPHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:07:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C67910CA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 08:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694531240; x=1726067240;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hvjWSe8g2gvyLab18B/7HjQZ7vefXnYvuFSi1pPYm3k=;
  b=RGAeZ4/PIixWddwAohOIxRQtyYWz2WE4xldkvVoY8775lzzdjOCTmBOf
   9rBaopPtiPe5yGMAnB4vRuxs36ZJ+bBuARe/EimrxipnvS8dIv012fvQM
   pDqkcI2Rbtd/oQDAX3E6W4R+bVQ9aIAo+92UD35fKg+blCd3H2zIRpQsJ
   vbKXG84IohhtDrtKqZbyjScCI41dwJpoOCOH31hg1qiamGIjWMqha030w
   bjxqpmHL4Q1r796Yl2fYnwAZpXQ462bE082KeR7xT+sfreHzvyA1uZjwu
   T5r5UVGTfGd3DUdXhWYqqIBaTEnK6luT9LOWMj5aDEL3iwZ/5k7oTK+Om
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="409356494"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="409356494"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 08:05:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="858836462"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="858836462"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 12 Sep 2023 08:05:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9F3E6C0D; Tue, 12 Sep 2023 18:05:54 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v1 6/6] params: Fix multi-line comment style
Date:   Tue, 12 Sep 2023 18:05:51 +0300
Message-Id: <20230912150551.401537-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230912150551.401537-1-andriy.shevchenko@linux.intel.com>
References: <20230912150551.401537-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The multi-line comment style in the file is rather arbitrary.
Make it follow the standard one.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/params.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/kernel/params.c b/kernel/params.c
index bcd535200c31..a6d7023dc993 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* Helpers for initial module or kernel cmdline parsing
-   Copyright (C) 2001 Rusty Russell.
-
-*/
+/*
+ * Helpers for initial module or kernel cmdline parsing
+ * Copyright (C) 2001 Rusty Russell.
+ */
 #include <linux/ctype.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -270,8 +270,10 @@ int param_set_charp(const char *val, const struct kernel_param *kp)
 
 	maybe_kfree_parameter(*(char **)kp->arg);
 
-	/* This is a hack.  We can't kmalloc in early boot, and we
-	 * don't need to; this mangled commandline is preserved. */
+	/*
+	 * This is a hack. We can't kmalloc() in early boot, and we
+	 * don't need to; this mangled commandline is preserved.
+	 */
 	if (slab_is_available()) {
 		*(char **)kp->arg = kmalloc_parameter(len + 1);
 		if (!*(char **)kp->arg)
@@ -743,8 +745,10 @@ void module_param_sysfs_remove(struct module *mod)
 {
 	if (mod->mkobj.mp) {
 		sysfs_remove_group(&mod->mkobj.kobj, &mod->mkobj.mp->grp);
-		/* We are positive that no one is using any param
-		 * attrs at this point.  Deallocate immediately. */
+		/*
+		 * We are positive that no one is using any param
+		 * attrs at this point. Deallocate immediately.
+		 */
 		free_module_param_attrs(&mod->mkobj);
 	}
 }
-- 
2.40.0.1.gaa8946217a0b

