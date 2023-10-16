Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4057CA94D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbjJPN0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjJPN0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:26:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA8FE3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 06:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697462775; x=1728998775;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pbkg4SMOVkTvs5mOOqa4szwbZzz87zGU8GgAguQEIuE=;
  b=eE4zsKsa+HTPzU2s1H7OwEY+gUUiWcmG9sfAjGCSnxJQm7sN+6HMc7by
   JnEH1FKfj9Iy6ZEW6LYMhaCw/C+8lIpfuHmkfXZyQgoMtgToevz6K5OJ6
   0B7j+/rCOduu48EQD30ABSomQJdFQfk7DNHRoi6IAoBjEVO+rLmPusb8r
   JkIC/H7PmjEZeCVHPadkQ8dqQ8bB9j41/eb6FuyYHYZk0+c3OsGYOSVd3
   zdxwEoliWkIco9YYbe7yK2VM9h7AOCXMCT8iKI35vsHRa7B3AFXg5RhS3
   iGOPpcWk7FqXROvwRZhlXgXg01TqQxqs7qfXsBvU+MY5YPzXvk83Yb2gb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="389383519"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="389383519"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 06:26:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="929346538"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="929346538"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 16 Oct 2023 06:26:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B19DA11D; Mon, 16 Oct 2023 16:26:12 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>
Subject: [resend, PATCH v1 1/1] logic_pio: Use RESOURCE_SIZE_MAX definition
Date:   Mon, 16 Oct 2023 16:26:11 +0300
Message-Id: <20231016132611.1201402-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a predefined limit instead of hardcoding it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v1: resent with Andrew in Cc list
Initial contribution was here more than a month ago:
https://lore.kernel.org/r/20230911224500.16677-1-andriy.shevchenko@linux.intel.com
 lib/logic_pio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/logic_pio.c b/lib/logic_pio.c
index 2ea564a40064..1cab23e4f856 100644
--- a/lib/logic_pio.c
+++ b/lib/logic_pio.c
@@ -175,7 +175,7 @@ resource_size_t logic_pio_to_hwaddr(unsigned long pio)
 	if (range)
 		return range->hw_start + pio - range->io_start;
 
-	return (resource_size_t)~0;
+	return RESOURCE_SIZE_MAX;
 }
 
 /**
-- 
2.40.0.1.gaa8946217a0b

