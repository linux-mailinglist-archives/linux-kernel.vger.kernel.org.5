Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845307D96CA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 13:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345745AbjJ0Lji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 07:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjJ0Ljg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 07:39:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C55EC2;
        Fri, 27 Oct 2023 04:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698406774; x=1729942774;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sCLsYII0iIYQL0RY7KUb5/cg100s9wFU25OabDcN7+A=;
  b=fy5TRHT5gil3csVDsdlebTfrTAZQIdcczgDYCijCMrLpSR0sUGgV9yJt
   GRAiMpBR8SOJnPItwuRBs9l8lY/sMexHtt0kdcRnEWbKQRPp+Gziu07uV
   bvPlcqjtD+rVx3Jmi7kmt2QXHg0mWCXz6WxPRkrxX+otK9a1PjCWGvS9o
   4QTm24qYH0liyQmBDwOq6T5OIA/aX6/NcK2BGCTBeGTvAvgI7JNdIltEh
   8XIFjjOsSpP2QV9Iul/1RrQina3SJ+QhQKAHmvBa+7gTPR1DAyZZ2LfG6
   t8OBy8VWQpTwP77v+nvQD1k5pyk0n4aDRJgzGWsTO7l/4mOXmG0w9FkV4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="579436"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="579436"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 04:39:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="876309651"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="876309651"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 27 Oct 2023 04:39:30 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qwLBY-000Amc-29;
        Fri, 27 Oct 2023 11:39:28 +0000
Date:   Fri, 27 Oct 2023 19:39:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linhua Xu <Linhua.xu@unisoc.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        lh xu <xulh0829@gmail.com>, Linhua Xu <Linhua.Xu@unisoc.com>,
        Zhirong Qiu <zhirong.qiu@unisoc.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Subject: Re: [PATCH V3 4/6] pinctrl: sprd: Increase the range of register
 values
Message-ID: <202310271959.VUpjvnai-lkp@intel.com>
References: <20231027071426.17724-5-Linhua.xu@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027071426.17724-5-Linhua.xu@unisoc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linhua,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linusw-pinctrl/devel]
[also build test WARNING on linusw-pinctrl/for-next linus/master v6.6-rc7 next-20231026]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Linhua-Xu/pinctrl-sprd-Modify-pull-up-parameters/20231027-151737
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
patch link:    https://lore.kernel.org/r/20231027071426.17724-5-Linhua.xu%40unisoc.com
patch subject: [PATCH V3 4/6] pinctrl: sprd: Increase the range of register values
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231027/202310271959.VUpjvnai-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231027/202310271959.VUpjvnai-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310271959.VUpjvnai-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/pinctrl/sprd/pinctrl-sprd.c:29:
>> drivers/pinctrl/sprd/pinctrl-sprd.h:21: warning: "BIT_MASK" redefined
      21 | #define BIT_MASK        GENMASK(7, 0)
         | 
   In file included from include/linux/ratelimit_types.h:5,
                    from include/linux/printk.h:9,
                    from include/asm-generic/bug.h:22,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/debugfs.h:15,
                    from drivers/pinctrl/sprd/pinctrl-sprd.c:7:
   include/linux/bits.h:9: note: this is the location of the previous definition
       9 | #define BIT_MASK(nr)            (UL(1) << ((nr) % BITS_PER_LONG))
         | 


vim +/BIT_MASK +21 drivers/pinctrl/sprd/pinctrl-sprd.h

    18	
    19	#define NUM_MASK	GENMASK(10, 0)
    20	#define TYPE_MASK	GENMASK(3, 0)
  > 21	#define BIT_MASK	GENMASK(7, 0)
    22	#define WIDTH_MASK	GENMASK(3, 0)
    23	#define REG_MASK	GENMASK(5, 0)
    24	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
