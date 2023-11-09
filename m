Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140D87E71E8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 20:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345083AbjKITIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 14:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjKITIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 14:08:09 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB2930EB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 11:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699556888; x=1731092888;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WQAWgT/ozAaa2+4EL0TBUqDOQYK4PJVhBP+7XYE7o6U=;
  b=ABMGJN549o8zxDZ1Ttg1OYzuqVqkCQbZJoWFwR+X8PZzBxe3ccRHorNt
   cQKJvacjY/N7NtgqxZkwL/crG2t32g1zhnFfUbF4DdFcOp/295lqebNiC
   Plwopkh6TEOd0icZ8YNdDelBMQrH940dQkKYi5HLhiUhgWutmvSqWMWY8
   1wuqAh9sqWrhFmOFwK1OhzZirNdR12P18jfkfrrNHOmkyckgWYvbK9U8R
   d1O6FyTZcf2F10JO3EkF5itHnvqYihg/uy4I7OdidFbDidQOnNraxEFOs
   q2I/gLG0k+F2wiAQ8LQeBTuOfu3U7TXBO6JYsGcDAmwXpC0q58v7Qc2UV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="8710192"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="8710192"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 11:08:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="713415339"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="713415339"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 09 Nov 2023 11:08:06 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1ANn-00094p-1w;
        Thu, 09 Nov 2023 19:08:03 +0000
Date:   Fri, 10 Nov 2023 03:07:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alban Bedel <albeu@free.fr>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jason Cooper <jason@lakedaemon.net>
Subject: drivers/irqchip/irq-ath79-misc.c:173:13: warning: no previous
 prototype for 'ath79_misc_irq_init'
Message-ID: <202311100226.yNCwxxjc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6bc986ab839c844e78a2333a02e55f02c9e57935
commit: 07ba4b061a79896315a7be4b123de12df6a9d2bd irqchip/ath79-misc: Move the MISC driver from arch/mips/ath79/
date:   8 years ago
config: mips-randconfig-r005-20210928 (https://download.01.org/0day-ci/archive/20231110/202311100226.yNCwxxjc-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231110/202311100226.yNCwxxjc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311100226.yNCwxxjc-lkp@intel.com/

All warnings (new ones prefixed by >>):

     158 |                 ______r = !!(cond);                                     \
         |                              ^~~~
   include/linux/preempt.h:165:9: note: in expansion of macro 'if'
     165 |         if (unlikely(preempt_count_dec_and_test())) \
         |         ^~
   include/linux/compiler.h:137:60: note: in expansion of macro '__branch_check__'
     137 | #  define unlikely(x)   (__builtin_constant_p(x) ? !!(x) : __branch_check__(x, 0))
         |                                                            ^~~~~~~~~~~~~~~~
   include/linux/preempt.h:165:13: note: in expansion of macro 'unlikely'
     165 |         if (unlikely(preempt_count_dec_and_test())) \
         |             ^~~~~~~~
   include/linux/radix-tree.h:315:9: note: in expansion of macro 'preempt_enable'
     315 |         preempt_enable();
         |         ^~~~~~~~~~~~~~
   include/linux/compiler.h:153:25: note: previous declaration here
     153 |                         ______f = {                                     \
         |                         ^~~~~~~
   include/linux/compiler.h:145:23: note: in expansion of macro '__trace_if'
     145 | #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
         |                       ^~~~~~~~~~
   include/linux/preempt.h:165:9: note: in expansion of macro 'if'
     165 |         if (unlikely(preempt_count_dec_and_test())) \
         |         ^~
   include/linux/radix-tree.h:315:9: note: in expansion of macro 'preempt_enable'
     315 |         preempt_enable();
         |         ^~~~~~~~~~~~~~
   include/linux/radix-tree.h: In function 'radix_tree_next_slot':
   include/linux/compiler.h:115:39: warning: ignoring attribute 'section ("_ftrace_annotated_branch")' because it conflicts with previous 'section ("_ftrace_branch")' [-Wattributes]
     115 |                         static struct ftrace_branch_data                \
         |                                       ^~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:158:30: note: in definition of macro '__trace_if'
     158 |                 ______r = !!(cond);                                     \
         |                              ^~~~
   include/linux/radix-tree.h:409:17: note: in expansion of macro 'if'
     409 |                 if (likely(iter->tags & 1ul)) {
         |                 ^~
   include/linux/compiler.h:134:60: note: in expansion of macro '__branch_check__'
     134 | #  define likely(x)     (__builtin_constant_p(x) ? !!(x) : __branch_check__(x, 1))
         |                                                            ^~~~~~~~~~~~~~~~
   include/linux/radix-tree.h:409:21: note: in expansion of macro 'likely'
     409 |                 if (likely(iter->tags & 1ul)) {
         |                     ^~~~~~
   include/linux/compiler.h:153:25: note: previous declaration here
     153 |                         ______f = {                                     \
         |                         ^~~~~~~
   include/linux/compiler.h:145:23: note: in expansion of macro '__trace_if'
     145 | #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
         |                       ^~~~~~~~~~
   include/linux/radix-tree.h:409:17: note: in expansion of macro 'if'
     409 |                 if (likely(iter->tags & 1ul)) {
         |                 ^~
   include/linux/compiler.h:115:39: warning: ignoring attribute 'section ("_ftrace_annotated_branch")' because it conflicts with previous 'section ("_ftrace_branch")' [-Wattributes]
     115 |                         static struct ftrace_branch_data                \
         |                                       ^~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:158:30: note: in definition of macro '__trace_if'
     158 |                 ______r = !!(cond);                                     \
         |                              ^~~~
   include/linux/radix-tree.h:413:17: note: in expansion of macro 'if'
     413 |                 if (!(flags & RADIX_TREE_ITER_CONTIG) && likely(iter->tags)) {
         |                 ^~
   include/linux/compiler.h:134:60: note: in expansion of macro '__branch_check__'
     134 | #  define likely(x)     (__builtin_constant_p(x) ? !!(x) : __branch_check__(x, 1))
         |                                                            ^~~~~~~~~~~~~~~~
   include/linux/radix-tree.h:413:58: note: in expansion of macro 'likely'
     413 |                 if (!(flags & RADIX_TREE_ITER_CONTIG) && likely(iter->tags)) {
         |                                                          ^~~~~~
   include/linux/compiler.h:153:25: note: previous declaration here
     153 |                         ______f = {                                     \
         |                         ^~~~~~~
   include/linux/compiler.h:145:23: note: in expansion of macro '__trace_if'
     145 | #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
         |                       ^~~~~~~~~~
   include/linux/radix-tree.h:413:17: note: in expansion of macro 'if'
     413 |                 if (!(flags & RADIX_TREE_ITER_CONTIG) && likely(iter->tags)) {
         |                 ^~
   include/linux/compiler.h:115:39: warning: ignoring attribute 'section ("_ftrace_annotated_branch")' because it conflicts with previous 'section ("_ftrace_branch")' [-Wattributes]
     115 |                         static struct ftrace_branch_data                \
         |                                       ^~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:158:30: note: in definition of macro '__trace_if'
     158 |                 ______r = !!(cond);                                     \
         |                              ^~~~
   include/linux/radix-tree.h:426:25: note: in expansion of macro 'if'
     426 |                         if (likely(*slot))
         |                         ^~
   include/linux/compiler.h:134:60: note: in expansion of macro '__branch_check__'
     134 | #  define likely(x)     (__builtin_constant_p(x) ? !!(x) : __branch_check__(x, 1))
         |                                                            ^~~~~~~~~~~~~~~~
   include/linux/radix-tree.h:426:29: note: in expansion of macro 'likely'
     426 |                         if (likely(*slot))
         |                             ^~~~~~
   include/linux/compiler.h:153:25: note: previous declaration here
     153 |                         ______f = {                                     \
         |                         ^~~~~~~
   include/linux/compiler.h:145:23: note: in expansion of macro '__trace_if'
     145 | #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
         |                       ^~~~~~~~~~
   include/linux/radix-tree.h:426:25: note: in expansion of macro 'if'
     426 |                         if (likely(*slot))
         |                         ^~
   drivers/irqchip/irq-ath79-misc.c: At top level:
>> drivers/irqchip/irq-ath79-misc.c:173:13: warning: no previous prototype for 'ath79_misc_irq_init' [-Wmissing-prototypes]
     173 | void __init ath79_misc_irq_init(void __iomem *regs, int irq,
         |             ^~~~~~~~~~~~~~~~~~~


vim +/ath79_misc_irq_init +173 drivers/irqchip/irq-ath79-misc.c

   169	
   170	IRQCHIP_DECLARE(ar7240_misc_intc, "qca,ar7240-misc-intc",
   171			ar7240_misc_intc_of_init);
   172	
 > 173	void __init ath79_misc_irq_init(void __iomem *regs, int irq,

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
