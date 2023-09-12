Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C435F79CB9B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbjILJYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbjILJYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:24:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F654A9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694510640; x=1726046640;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5TdwgVKMF5KAB6b8+l6VMEuRaZtOJKaVWoHEmMbfRxE=;
  b=SmNT0ugbHEJVz34XXDZxs4avv8jwvLvyAqLx6vlJFfClLX4tqRlla5cr
   K0AOljMdhJAmHcg/xNSECVNGIYRdPI5bpcV1GRWKEDkwF/cqPkLofkvax
   oHKedFPDpPe0YroznrfaOALKHEiaF59pANWabSGDkxSg6ldhmBkP2AMgV
   UYi0twssMXOf5lNj0lB0brohNKLPvlTbsApkYqYzfdiMT0Vy9PN7zqrV3
   ViAmF/WL+AF/Dev1lTc1DY5qCHjKzlTCTbLBZ/3/Ep85LumPHUy5y2QQY
   qR2SBYfuQYFbZgS4YmKYEuK4JmazgrhHhMxkNfAWLDHbEwJZpuI+JIqjW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="357755758"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="357755758"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 02:23:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="746805238"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="746805238"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 12 Sep 2023 02:23:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B60AB248; Tue, 12 Sep 2023 12:23:56 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH v3 1/1] minmax: Fix header inclusions
Date:   Tue, 12 Sep 2023 12:23:55 +0300
Message-Id: <20230912092355.79280-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BUILD_BUG_ON*() macros are defined in build_bug.h. Include it.
Replace compiler_types.h by compiler.h, which provides the former,
to have a definition of the __UNIQUE_ID().

Reviewed-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v3: rebased on top of the latest -mm patches (assumed to go via Andrew)

 include/linux/minmax.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index 69bbe987fa87..ca69abd6151e 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -2,7 +2,8 @@
 #ifndef _LINUX_MINMAX_H
 #define _LINUX_MINMAX_H
 
-#include <linux/compiler_types.h>
+#include <linux/build_bug.h>
+#include <linux/compiler.h>
 #include <linux/const.h>
 #include <linux/types.h>
 
-- 
2.40.0.1.gaa8946217a0b

