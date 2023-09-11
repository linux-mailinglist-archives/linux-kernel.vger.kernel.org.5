Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D7879C370
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241266AbjILC64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241211AbjILC6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:58:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CF8843E0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 15:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694472393; x=1726008393;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VayNHSWBTxSmxrDMD/oMC5BqAqdDeO7Yt7+xQTvU15M=;
  b=eLd1gQOPcaanE6W0X81fj2K2P42jXfVrRzCeT0x6w5lyrcjGS6l+aPdj
   jV9NlzZK6bdd+3Ybvpls8MNOtxowGQQWejeyLiOkkbwh8i7dj2KgYo9xe
   mOY7LcMnFwmGMBmXEpbtYRkvMtHO5FltuJceM3K5kLdq1MECpvLGP1sp/
   TPe0K7iKAfvZi9vmTxc40kSAN01XrgbcHRnP5jzrQG3s3ZyDHi6n0zMR/
   PVVagRfNyndP47i7hw8z7M+g4O58gyJCsSeJmqm6htyXe3yYa7e3WqJyA
   tW2QgCOV6UJ9Il3mhLDvtnM+EZ1SXC3MNCiEHF8XYA/E3UhF6fuNFR0yy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="363257772"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="363257772"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 15:45:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="813567314"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="813567314"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 11 Sep 2023 15:45:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 58475248; Tue, 12 Sep 2023 01:45:16 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] logic_pio: Use RESOURCE_SIZE_MAX definition
Date:   Tue, 12 Sep 2023 01:45:00 +0300
Message-Id: <20230911224500.16677-1-andriy.shevchenko@linux.intel.com>
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

Use a predefined limit instead of hardcoding it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
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

