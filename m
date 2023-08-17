Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DE877F0FF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 09:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348402AbjHQHLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 03:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348377AbjHQHLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 03:11:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF862D40
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 00:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692256272; x=1723792272;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=E3++f8SJ7UJsIAQi52ppbLYsyIM68SGTYY4D2s9skcw=;
  b=E1WhPau1SSwsE4laugg6TmRQEVCj+1BgooWckc9YTpBd5rPkL7jc6jgj
   oEqaqYeaLRXyR3hjZKYatmaKqnw7f1mP1WUyz91DrkXx82JBeGXhtYjTs
   WB/iKu47z98Yf4ZWRowgYZOt33XqNS0PVemlg1s4W6mE/l5FwFzjrH5Fd
   /QU60OnfcP2CKDA2HIqN99c58N6iXQU2MrcF6GiGYisSOMCnYe62CVTkp
   EszlkunFpQObcJ8PALzIuQmL0ZIJozrch9MODkUhSpEepYOhm2eT1LSwE
   8k27yXnM2lS1YTuwSuuRLnUwoxd91LyOhCB/SXx0Hei9ErihXUBLtVWYH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="375499959"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="375499959"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 00:11:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="763941124"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="763941124"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 17 Aug 2023 00:11:10 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWX9x-0000sb-2W;
        Thu, 17 Aug 2023 07:11:09 +0000
Date:   Thu, 17 Aug 2023 15:11:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: drivers/gpio/gpio-pca9570.c:42: warning: Function parameter or
 member 'chip_data' not described in 'pca9570'
Message-ID: <202308171538.nKKUOtbg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6
commit: a3f7c1d6ddcbd487964c58ff246506a781e5be8f gpio: pca9570: rename platform_data to chip_data
date:   7 months ago
config: i386-randconfig-i015-20230817 (https://download.01.org/0day-ci/archive/20230817/202308171538.nKKUOtbg-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce: (https://download.01.org/0day-ci/archive/20230817/202308171538.nKKUOtbg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308171538.nKKUOtbg-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpio/gpio-pca9570.c:42: warning: Function parameter or member 'chip_data' not described in 'pca9570'


vim +42 drivers/gpio/gpio-pca9570.c

b8a34582c7f7f2 Shubhrajyoti Datta  2022-10-26  29  
16d44b6085c1d9 Sungbo Eo           2020-07-09  30  /**
16d44b6085c1d9 Sungbo Eo           2020-07-09  31   * struct pca9570 - GPIO driver data
16d44b6085c1d9 Sungbo Eo           2020-07-09  32   * @chip: GPIO controller chip
b8a34582c7f7f2 Shubhrajyoti Datta  2022-10-26  33   * @p_data: GPIO controller platform data
16d44b6085c1d9 Sungbo Eo           2020-07-09  34   * @lock: Protects write sequences
16d44b6085c1d9 Sungbo Eo           2020-07-09  35   * @out: Buffer for device register
16d44b6085c1d9 Sungbo Eo           2020-07-09  36   */
16d44b6085c1d9 Sungbo Eo           2020-07-09  37  struct pca9570 {
16d44b6085c1d9 Sungbo Eo           2020-07-09  38  	struct gpio_chip chip;
a3f7c1d6ddcbd4 Bartosz Golaszewski 2022-12-30  39  	const struct pca9570_chip_data *chip_data;
16d44b6085c1d9 Sungbo Eo           2020-07-09  40  	struct mutex lock;
16d44b6085c1d9 Sungbo Eo           2020-07-09  41  	u8 out;
16d44b6085c1d9 Sungbo Eo           2020-07-09 @42  };
16d44b6085c1d9 Sungbo Eo           2020-07-09  43  

:::::: The code at line 42 was first introduced by commit
:::::: 16d44b6085c1d90884b264deb938a34ab85a9c6d gpio: pca9570: add GPO driver for PCA9570

:::::: TO: Sungbo Eo <mans0n@gorani.run>
:::::: CC: Linus Walleij <linus.walleij@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
