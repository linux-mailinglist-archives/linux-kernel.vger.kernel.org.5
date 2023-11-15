Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F637EC7BA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjKOPuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjKOPuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:50:09 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE07DD44;
        Wed, 15 Nov 2023 07:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700063405; x=1731599405;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N0fBrj4X1XqKzXRuoFSbE/zJFtv8I5jzQP8GqdgIm9M=;
  b=fdmo5XxqTspkeGiJum18V2VVrATVk9mpHtsyLfPSD9BMu+o+1lris+0K
   1DW3HB/BaxKX9LNrtezwMZyvUivgPBVqCeZUR4Uw827jxHjMAUdXZY+AY
   5FJtrC3qelqKOy1eU/VRa8EDNssYGfX1EoyfhPIsGiASEm483WKxmg/4a
   3PnKgoUJyKo2lgiQ2vAUcbRCUa/w4f1rpfFqFx0krbvqv63P4gwXCKQDU
   zbwriMApO/1m72NYPuSx/gyKQLgqvwA24uxgGxzIWH+xDoIpad45L5+SW
   PJ5vqwn9d7uJijJp0GeVRUXOZz6S1Qp6yYg3AS6FOv4ro9oepdAnIGFih
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="477119140"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="477119140"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 07:50:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="741469104"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="741469104"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 15 Nov 2023 07:49:59 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F40202AC; Wed, 15 Nov 2023 17:49:57 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>
Subject: [PATCH v1 1/3] EDAC, pnd2: Replace custom definition by one from sizes.h
Date:   Wed, 15 Nov 2023 17:49:38 +0200
Message-ID: <20231115154940.664664-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
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

The sizes.h provides a set of common size definitions, use it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/edac/pnd2_edac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index 2b306f2cc605..45e3c2913d51 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -24,6 +24,7 @@
 #include <linux/delay.h>
 #include <linux/edac.h>
 #include <linux/mmzone.h>
+#include <linux/sizes.h>
 #include <linux/smp.h>
 #include <linux/bitmap.h>
 #include <linux/math64.h>
@@ -109,7 +110,6 @@ static struct mem_ctl_info *pnd2_mci;
 #define MOT_CHAN_INTLV_BIT_1SLC_2CH 12
 #define MOT_CHAN_INTLV_BIT_2SLC_2CH 13
 #define SELECTOR_DISABLED (-1)
-#define _4GB (1ul << 32)
 
 #define PMI_ADDRESS_WIDTH	31
 #define PND_MAX_PHYS_BIT	39
@@ -587,7 +587,7 @@ static int get_registers(void)
 /* Get a contiguous memory address (remove the MMIO gap) */
 static u64 remove_mmio_gap(u64 sys)
 {
-	return (sys < _4GB) ? sys : sys - (_4GB - top_lm);
+	return (sys < SZ_4G) ? sys : sys - (SZ_4G - top_lm);
 }
 
 /* Squeeze out one address bit, shift upper part down to fill gap */
@@ -643,7 +643,7 @@ static int sys2pmi(const u64 addr, u32 *pmiidx, u64 *pmiaddr, char *msg)
 
 	/* Give up if address is out of range, or in MMIO gap */
 	if (addr >= (1ul << PND_MAX_PHYS_BIT) ||
-	   (addr >= top_lm && addr < _4GB) || addr >= top_hm) {
+	   (addr >= top_lm && addr < SZ_4G) || addr >= top_hm) {
 		snprintf(msg, PND2_MSG_SIZE, "Error address 0x%llx is not DRAM", addr);
 		return -EINVAL;
 	}
-- 
2.43.0.rc1.1.gbec44491f096

