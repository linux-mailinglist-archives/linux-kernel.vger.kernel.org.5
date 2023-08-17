Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181EB77F863
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351720AbjHQOIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351814AbjHQOI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:08:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC975E6B;
        Thu, 17 Aug 2023 07:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692281298; x=1723817298;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tSAfQ8VgV7w5FQ6Wp+p1SGY5oFBwBoq+zpUTtKJDwsI=;
  b=J3YBOrgIujR6W2IevsIf9JqC7xBP9LFndV0bUhf00ae6sqeKbNEgqYVk
   x0WgCjmNE3x8bpdbkwpFQVDn8Aq/OUDmMsyPBypjlbVLKbVQs/AEeSMOB
   jRYItCbdIOnD6xWSWlzKDWCrZyBV7cYeXLZyYkncxRFARAWkZjGPdth5e
   RBKpMt01WwHCntrUeZkwTqbchhhxZKhxvTOSj7AE3P7rSYX9gp/79N67w
   i3ioh7XNVEWbmqt+PMfg/dSWv9EkSRPzaGmCXkDGFDFvdFvH/5cd4gByX
   KuvvBdP6kJpJBXP2znnoRlVDpdtdCNL1zoDFcn1o5K46ayjZ6iX7dbgFq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="352404342"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="352404342"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 07:06:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="804689187"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="804689187"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 17 Aug 2023 07:06:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2DE06DAB; Thu, 17 Aug 2023 17:06:57 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] docs: kernel-parameters: Refer to the correct bitmap function
Date:   Thu, 17 Aug 2023 17:04:32 +0300
Message-Id: <20230817140432.507889-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parser of the CPU lists is bitmap_parselist() that supports
special notations with the plain numbers. bitmap_parse() never
supported those and will fail in case one will try it.

Fixes: b18def121f07 ("bitmap_parse: Support 'all' semantics")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/admin-guide/kernel-parameters.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
index 073f73880edf..102937bc8443 100644
--- a/Documentation/admin-guide/kernel-parameters.rst
+++ b/Documentation/admin-guide/kernel-parameters.rst
@@ -80,7 +80,7 @@ The special case-tolerant group name "all" has a meaning of selecting all CPUs,
 so that "nohz_full=all" is the equivalent of "nohz_full=0-N".
 
 The semantics of "N" and "all" is supported on a level of bitmaps and holds for
-all users of bitmap_parse().
+all users of bitmap_parselist().
 
 This document may not be entirely up to date and comprehensive. The command
 "modinfo -p ${modulename}" shows a current list of all parameters of a loadable
-- 
2.40.0.1.gaa8946217a0b

