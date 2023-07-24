Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2068B75FB96
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjGXQNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjGXQNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:13:19 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7885310C0;
        Mon, 24 Jul 2023 09:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690215198; x=1721751198;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TDfCRPTa02JLEPln3IZiA9Efmjo5+l+tF2BINPHp4ow=;
  b=khdxBK9SwNi1YUAfs6O7rTF25JDqHzvWSD4AUStQcri6X9QVhOHp1Fwd
   tO7/Fh4tARW7KhdjG6ORJ5vhxC9E1w6dcWjdm5Bgua9C/OQOm/OYxwNH8
   yzeKMaHJMhw5M/Cyrdw/OwWPWXmeEdbZ5nwqS36iqCPbhMOhFLgN0+U0s
   lhWxAWvYv1OsY9jUZaT8OvprVlvq/hl3woRsVkR6pIM6wyoY0aJjObvct
   HVnaWdqDWQGv1/NvRQfOJjVedx6RQjyHnA5bXP37K3mHUjC+RGd2LlBwZ
   DSC8q+qWZhbxE9G4VfDuTwjEVVkGaC53QyLxx77a3fXdp/eNFTdF3LUjg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="364945361"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="364945361"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 09:13:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="702949234"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="702949234"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 24 Jul 2023 09:13:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5CB1A1A6; Mon, 24 Jul 2023 19:13:21 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 0/6] gpio: ge: fixes and cleanups
Date:   Mon, 24 Jul 2023 19:13:14 +0300
Message-Id: <20230724161320.63876-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy reported a couple of problems, the first two patches
fix that. On top are a few cleanups.

Andy Shevchenko (6):
  gpio: ge: Add missing header
  gpio: ge: Fix English spelling and grammar
  gpio: ge: Make driver OF-independent
  gpio: ge: Utilise temporary variable for struct device
  gpio: ge: Replace GPLv2 boilerplate with SPDX
  gpio: ge: Enable COMPILE_TEST for the driver

 drivers/gpio/Kconfig   |  2 +-
 drivers/gpio/gpio-ge.c | 66 +++++++++++++++++++-----------------------
 2 files changed, 30 insertions(+), 38 deletions(-)

-- 
2.40.0.1.gaa8946217a0b

