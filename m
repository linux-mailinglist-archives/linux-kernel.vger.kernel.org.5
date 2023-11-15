Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AE77EC79B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjKOPuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbjKOPuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:50:07 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B0B1AC;
        Wed, 15 Nov 2023 07:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700063402; x=1731599402;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=er/1zsYTEUqBc9l1o82eaHeGbKLxLZP8/d4Zg+MKFYM=;
  b=nM6YNaYBQTKCSbY5uK8nExxOv7Hrvt/M4rk93xIg17AW2J0mzRBRaXyB
   0+by1E0cmAmUJNqyaTaT6pgZ5WqBv6ufCGxHCCA/lZmGDnNeMaULuz0YA
   EtTG+x6xfvzLu4sR67RYwzq/AjWEfowb6i2p88HYACL0kZPmW0CYjrhAl
   gxq7U8YwI1cs0/VLL+aMuS7A/KTiaxdL3H8u7AWrUaAHPRBw7z3hDY+Y1
   E9kRYAvvdxOnRv/xDkVFOubud+5IG6Mit7/rRUjBO5eGT553eAlyvo+vn
   XMA0XRuMVeFlW/WiLDHbqOJ3IKLKM8+R2MkdQwcVi11rJ3XGPl2XMJooO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="477119132"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="477119132"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 07:50:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="741469101"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="741469101"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 15 Nov 2023 07:49:59 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1C3E4305; Wed, 15 Nov 2023 17:49:58 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>
Subject: [PATCH v1 3/3] EDAC, pnd2: Sort headers alphabetically
Date:   Wed, 15 Nov 2023 17:49:40 +0200
Message-ID: <20231115154940.664664-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20231115154940.664664-1-andriy.shevchenko@linux.intel.com>
References: <20231115154940.664664-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort the headers in alphabetic order in order to ease
the maintenance for this part.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/edac/pnd2_edac.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index 676e02c8dc43..1bbedd59e36b 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -16,19 +16,20 @@
  * rank, bank, row and column using the appropriate "dunit_ops" functions/parameters.
  */
 
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/pci.h>
-#include <linux/pci_ids.h>
-#include <linux/slab.h>
+#include <linux/bitmap.h>
 #include <linux/delay.h>
 #include <linux/edac.h>
-#include <linux/mmzone.h>
-#include <linux/sizes.h>
-#include <linux/smp.h>
-#include <linux/bitmap.h>
+#include <linux/init.h>
 #include <linux/math64.h>
+#include <linux/mmzone.h>
 #include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/pci_ids.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
+#include <linux/smp.h>
+
 #include <linux/platform_data/x86/p2sb.h>
 
 #include <asm/cpu_device_id.h>
-- 
2.43.0.rc1.1.gbec44491f096

