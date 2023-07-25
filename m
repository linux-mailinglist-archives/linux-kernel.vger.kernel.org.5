Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63DB76115A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbjGYKuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbjGYKt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:49:59 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6307D199E;
        Tue, 25 Jul 2023 03:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690282195; x=1721818195;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N5C5HN9967gW8tCp5yOVdvgPZjm+pd+371s1T29mDB0=;
  b=mogBMQc7pa7+nA+MJglrdMSCNbc+nU03XJ+AoUtD6RWzmvSTSJlLs9GK
   2ATvHlO7XQvBTQUy85zLAFDwuIOl3ow+xrBSIhT3StY9iAr3d8IhFjg/k
   DZsOg9Fbex55R2sqn1D3xu9c9XgjwQMGrS7GAtPUMZyEyeAkEUuRqHRkc
   VMEo8psTe6SIkF9KNEeqUR/denitiNU7+7PJTY8QIfjVZj5tR++CCkIq3
   eQ8W68Yfu2ASzrqrNDMmQgmZzgEXnvHwBIcHwHIRW+nKJ1AM3PHAKFuma
   EdEpogH+yvLLeoH1SQ7UwT0xh6bJfBVEqEDQieA6fLrcXze0ugDUuk5GO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="371295483"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="371295483"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 03:49:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="791332822"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="791332822"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 25 Jul 2023 03:49:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D34F52E9; Tue, 25 Jul 2023 13:49:57 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 1/1] Documentation: core-api: Drop :export: for int_log.h
Date:   Tue, 25 Jul 2023 13:49:56 +0300
Message-Id: <20230725104956.47806-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The :export: keyword makes sense only for C-files, where EXPORT_SYMBOL()
might appear. Otherwise kernel-doc may not produce anything out of this
file.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: f97fa3dcb2db ("lib/math: Move dvb_math.c into lib/math/int_log.c")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Jonathan Corbet <corbet@lwn.net>
---
v2: added tags (Randy, Jonathan), assumed to go via ASoC tree
 Documentation/core-api/kernel-api.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
index a526fbe06f86..ae92a2571388 100644
--- a/Documentation/core-api/kernel-api.rst
+++ b/Documentation/core-api/kernel-api.rst
@@ -166,7 +166,6 @@ Integer log and power Functions
 -------------------------------
 
 .. kernel-doc:: include/linux/int_log.h
-   :export:
 
 .. kernel-doc:: lib/math/int_pow.c
    :export:
-- 
2.40.0.1.gaa8946217a0b

