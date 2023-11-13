Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6FC7E9C77
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 13:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjKMMzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 07:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjKMMzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 07:55:49 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950571727;
        Mon, 13 Nov 2023 04:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699880147; x=1731416147;
  h=from:to:cc:subject:date:message-id;
  bh=BnaSJphQywDVRq4A2vGL4YUhyyjZMHfJmfHokOGv4CA=;
  b=TzlWg6hB66VZ+/ZEErwmqgxzFpa/oLmX+FwmbHg+5uE2iJQgFKJr9JbM
   g8AeZ6Bix6DHy7UlRVbze0VNgU0lVEpSUhFCRqRdErMGqve10k7iKvD4P
   yCJlDPIIVc1I+JtZkqHlXb/CIr6rsj6+dJFxA99hveWE9qLLqaLmq68EA
   URKIqESKAAD36Xvifn2vf7WEeYwjJ4CHhTAHNG3g6q3tUbtbhDrHvQfB0
   dRpGToBOOUuEwUGDnOpryo6Ydd7UD8StTXAwNOgeio5OQT15p6nUB46sg
   KNC6QfCnXfv8sqOaiaNF7DrFI0hi2ZKzH45UkNdp0GG+BAt0TBwhbksJM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="9071984"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="9071984"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 04:55:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="740764019"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="740764019"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga006.jf.intel.com with ESMTP; 13 Nov 2023 04:55:43 -0800
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1] pinctrl: intel: allow independent COMPILE_TEST
Date:   Mon, 13 Nov 2023 18:25:34 +0530
Message-Id: <20231113125534.4993-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have completed the transition to standard ACPI helpers for the
entire Intel pinctrl tree, we can detach COMPILE_TEST from ACPI dependency.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/pinctrl/intel/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/intel/Kconfig b/drivers/pinctrl/intel/Kconfig
index d66f4f6932d8..44b022d8aee1 100644
--- a/drivers/pinctrl/intel/Kconfig
+++ b/drivers/pinctrl/intel/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Intel pin control drivers
 menu "Intel pinctrl drivers"
-	depends on ACPI && (X86 || COMPILE_TEST)
+	depends on (ACPI && X86) || COMPILE_TEST
 
 config PINCTRL_BAYTRAIL
 	bool "Intel Baytrail GPIO pin control"

base-commit: a35c62ba7ae5f96f6e2683beed3f9c7ee37548cf
-- 
2.17.1

