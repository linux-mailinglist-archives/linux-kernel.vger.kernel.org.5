Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80727E9C21
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 13:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjKMMb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 07:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjKMMb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 07:31:56 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D308D55;
        Mon, 13 Nov 2023 04:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699878713; x=1731414713;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=u5/3Xq+2UoTAILGRcKKzhKvlbjxtJPTVZqEB0uJ39eU=;
  b=MSxGI0QZlaPf1trH97iVFUeND/8cBXECe325KN22hUiS1x9ZYPl02lBy
   f1Ky4R9FJlZCGXeZFNQEt6xbbrFRblNQ85f3hR2tw8R5Llas1U8Twfz++
   M0EUPML4zpL1K4NxfNlt9i+7WyMu5AjYTSqOGpUHDrqoR8rJhXf3mMcgn
   gqnX8JgtXMFImHLic16DqX3b0eHkW0uX+T01MjXUG9Exi/Z5arBcz24f2
   X7pB99WEK0K5gLH0t3esv4DUh9d5kZ8PGviydV8qYZOyE673TMUnLRXmb
   D57tLbhekuBORrPViYvFsnXka2TBx8B+z/DavlONaJIb6wi02QAr5yLU/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="421522830"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="421522830"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 04:31:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="887912967"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="887912967"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 13 Nov 2023 04:31:50 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3298F64A; Mon, 13 Nov 2023 14:31:49 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Raag Jadav <raag.jadav@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 0/2] pinctrl: intel: Add generic platform driver
Date:   Mon, 13 Nov 2023 14:28:46 +0200
Message-ID: <20231113123147.4075203-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New Intel platforms one-by-one will be switching to use generic
approach for the pin control description in ACPI, hence this driver.

It depends on the series
https://lore.kernel.org/r/20231030120734.2831419-1-andriy.shevchenko@linux.intel.com,
which is pending for v6.8-rc1 (will be soon in Linux Next).

In v2:
- squashed ID patch into the driver one (Mika)
- added the list of platforms/SoCs that requires this driver (Mika)
- added a comment about single community per device (Mika)
- miscellaneous fixes (Mika)

Andy Shevchenko (2):
  pinctrl: intel: Revert "Unexport intel_pinctrl_probe()"
  pinctrl: intel: Add a generic Intel pin control platform driver

 drivers/pinctrl/intel/Kconfig                 |  10 +
 drivers/pinctrl/intel/Makefile                |   1 +
 .../pinctrl/intel/pinctrl-intel-platform.c    | 225 ++++++++++++++++++
 drivers/pinctrl/intel/pinctrl-intel.c         |   5 +-
 drivers/pinctrl/intel/pinctrl-intel.h         |   3 +
 5 files changed, 242 insertions(+), 2 deletions(-)
 create mode 100644 drivers/pinctrl/intel/pinctrl-intel-platform.c

-- 
2.43.0.rc1.1.gbec44491f096

