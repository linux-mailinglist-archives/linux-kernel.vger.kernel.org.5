Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E937F8503
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 21:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346095AbjKXUDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 15:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbjKXUDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 15:03:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A63C172A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 12:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700856187; x=1732392187;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HLVyh6DP+deo0up/ANyRmz4lG2B/qVvZ0xLnHk1RxlM=;
  b=cvCwZwQZpE/h/lNS3zNJaAqqJoqbM5bMcRw4d1p58fAsl9oQg2lXGO+s
   xsKNUvnUA3JgcXNJz6ha8oKKoJrf/I3kvI/wqZX9+qcCrRYss0oOF5MaS
   6cRLl4T5fX10c1ovBkq5iE6b1cUOBNSwYzBR73b0RlLo/583NjFd7Nv7u
   4GPp6nyz2WPGN2fKSPWn26bow9BWlmPKKNNxqRdibuU7QBpnBZWMHKI98
   U9+oeJLW9ZBJHXHnSGRmYbbYTjHv+VepMvFJxOiGwbegbEza1QfZhHtX/
   Mm1SZZ/Jmt1Iv5+6ESn0yh5YOGTVfcEopkPkuViM6LcVQNc9BMjk9+eoZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="391338132"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="391338132"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 12:03:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="1014983740"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="1014983740"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 24 Nov 2023 12:03:04 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8285C1C7; Fri, 24 Nov 2023 22:03:03 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>
Subject: [PATCH v1 0/5] mfd: intel-lpss: Set of cleanups
Date:   Fri, 24 Nov 2023 21:31:23 +0200
Message-ID: <20231124200258.3682979-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
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

After looking into the latest changes in the driver I noticed one
wrong patch. That induced looking closer to the current state of
affairs in the driver. It appears that some code is outdated and
may be cleaned up. Hence this series.

Andy Shevchenko (5):
  mfd: intel-lpss: Revert "Add missing check for platform_get_resource"
  mfd: intel-lpss: Use device_get_match_data()
  mfd: intel-lpss: Adjust header inclusions
  mfd: intel-lpss: Move exported symbols to INTEL_LPSS namespace
  mfd: intel-lpss: Provide Intel LPSS PM ops structure

 drivers/mfd/intel-lpss-acpi.c | 27 ++++++++++++------------
 drivers/mfd/intel-lpss-pci.c  | 19 ++++++++++-------
 drivers/mfd/intel-lpss.c      | 39 +++++++++++++++++++++--------------
 drivers/mfd/intel-lpss.h      | 28 +------------------------
 4 files changed, 51 insertions(+), 62 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096

