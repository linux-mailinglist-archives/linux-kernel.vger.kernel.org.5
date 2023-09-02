Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E84C790A42
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 01:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235214AbjIBXSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 19:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjIBXSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 19:18:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15FC1B8
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 16:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693696716; x=1725232716;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zdJhYvh5EdNQDqFSABgtCjvOzBng2FJlqBUlybJhGAA=;
  b=dzl7Sy3ObJhDnz2kGshZoXbvzCin4ta+StUszxASQokQJcVvCvc1WnMO
   +2kXGLDG/zC+FYSat8QnGY6x2FXp0v9sY4vrYBS1Uayw8Q2ax/Q1Rc2cI
   gUwGnht3HvzFTl57VXyZ3w81SHPbh3ybyVtFFLnMYZURD9MHwATrS0nqa
   XuV8RRxH1umA8cE5TWSZoDnZesgNkr1589X2tM0xHAVPM1DzcZForRObw
   cKimqMyv7BUPsE8X62ZAocRHAYHUCgcsB5cNty+ucmulkSJPCwovtULn+
   lUVZNx3FEM8lp16HKn/wtuAkLjHy+7S0pSGwqfX1TPPPKCZOdEuDu8yGa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10821"; a="376338687"
X-IronPort-AV: E=Sophos;i="6.02,223,1688454000"; 
   d="scan'208";a="376338687"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2023 16:18:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10821"; a="855132307"
X-IronPort-AV: E=Sophos;i="6.02,223,1688454000"; 
   d="scan'208";a="855132307"
Received: from lkp-server01.sh.intel.com (HELO 5d8055a4f6aa) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 02 Sep 2023 16:18:34 -0700
Received: from kbuild by 5d8055a4f6aa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qcZsu-0002gN-0r;
        Sat, 02 Sep 2023 23:18:32 +0000
Date:   Sun, 3 Sep 2023 07:17:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Liu Yun <liuyun@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>
Subject: loongson2_pm.c:undefined reference to `input_free_device'
Message-ID: <202309030751.pDnTZX4E-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b89b029377c8c441649c7a6be908386e74ea9420
commit: 67694c076bd7d6b8b73c59d4881822f0493caf35 soc: loongson2_pm: add power management support
date:   12 days ago
config: loongarch-randconfig-r014-20230903 (https://download.01.org/0day-ci/archive/20230903/202309030751.pDnTZX4E-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230903/202309030751.pDnTZX4E-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309030751.pDnTZX4E-lkp@intel.com/

All errors (new ones prefixed by >>):

   loongarch64-linux-ld: drivers/soc/loongson/loongson2_pm.o: in function `.LBB191':
   loongson2_pm.c:(.text+0x10c): undefined reference to `input_allocate_device'
   loongarch64-linux-ld: loongson2_pm.c:(.text+0x144): undefined reference to `input_set_capability'
   loongarch64-linux-ld: loongson2_pm.c:(.text+0x14c): undefined reference to `input_register_device'
   loongarch64-linux-ld: drivers/soc/loongson/loongson2_pm.o: in function `.LBB240':
>> loongson2_pm.c:(.text+0x25c): undefined reference to `input_free_device'
   loongarch64-linux-ld: drivers/soc/loongson/loongson2_pm.o: in function `.LBB387':
   loongson2_pm.c:(.text+0x390): undefined reference to `input_event'
   loongarch64-linux-ld: drivers/soc/loongson/loongson2_pm.o: in function `.LBE387':
   loongson2_pm.c:(.text+0x3a4): undefined reference to `input_event'
   loongarch64-linux-ld: drivers/soc/loongson/loongson2_pm.o: in function `.LBE389':
   loongson2_pm.c:(.text+0x3b8): undefined reference to `input_event'
   loongarch64-linux-ld: drivers/soc/loongson/loongson2_pm.o: in function `.LBE391':
   loongson2_pm.c:(.text+0x3cc): undefined reference to `input_event'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
