Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CBF767BCF
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 05:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbjG2DD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 23:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjG2DDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 23:03:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6319B5;
        Fri, 28 Jul 2023 20:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690599829; x=1722135829;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SckTOmpQ74JSOMCIFxF+j9+kYZd18qTNgBYUcGdkyrw=;
  b=kRNZ7yjyO6cBbd2/8F4NjbepySo9cgkIKqwShKrzCY6sa21jrhTN84IF
   uJXMn09u9N6DQ2WBLBrNoqA3efZx4opkc+lJc1L9bWyVo9mNihPTO0Qv/
   /CQUSzJ+gJBTVpl6S0ftOA+EsiaB7x8yYYO7NNyt9kD79dstaaf84I6E0
   wCSYH9VMvQXpChQZX/XW1ydVh2AbLW6VoRB4A8qVn4xvvfOWbX2hr1xbj
   2Z47B6uotHD9+qi3D41TX4owzE7Tj8RiUrDd9l+zZ1VX0/s5SMNAtDpum
   itEat0sr3km5GNihiuqVb/FCn3nMuF0WYtElzVjHb0PHbJXgfp2KgPnA9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="353629916"
X-IronPort-AV: E=Sophos;i="6.01,239,1684825200"; 
   d="scan'208";a="353629916"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 20:03:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="730965552"
X-IronPort-AV: E=Sophos;i="6.01,239,1684825200"; 
   d="scan'208";a="730965552"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 28 Jul 2023 20:03:46 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qPaF7-0003mf-0k;
        Sat, 29 Jul 2023 03:03:45 +0000
Date:   Sat, 29 Jul 2023 11:03:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] of: dynamic: Refactor action prints to not use "%pOF"
 inside devtree_lock
Message-ID: <202307291024.DHfPmyN4-lkp@intel.com>
References: <20230728231950.1619073-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728231950.1619073-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.5-rc3 next-20230728]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rob-Herring/of-dynamic-Refactor-action-prints-to-not-use-pOF-inside-devtree_lock/20230729-072155
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230728231950.1619073-1-robh%40kernel.org
patch subject: [PATCH v3] of: dynamic: Refactor action prints to not use "%pOF" inside devtree_lock
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20230729/202307291024.DHfPmyN4-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230729/202307291024.DHfPmyN4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307291024.DHfPmyN4-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/of/dynamic.c:74:6: warning: no previous prototype for 'of_changeset_action_print' [-Wmissing-prototypes]
      74 | void of_changeset_action_print(unsigned long action, struct device_node *np, const char *prop_name)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/printk.h:564,
                    from include/asm-generic/bug.h:22,
                    from arch/loongarch/include/asm/bug.h:59,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/current.h:5,
                    from ./arch/loongarch/include/generated/asm/current.h:1,
                    from include/linux/mutex.h:14,
                    from include/linux/kernfs.h:11,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from drivers/of/dynamic.c:12:
   drivers/of/dynamic.c: In function 'of_reconfig_notify':
>> include/linux/dynamic_debug.h:219:58: error: expected expression before 'do'
     219 | #define __dynamic_func_call_cls(id, cls, fmt, func, ...) do {   \
         |                                                          ^~
   include/linux/dynamic_debug.h:246:9: note: in expansion of macro '__dynamic_func_call_cls'
     246 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:248:9: note: in expansion of macro '_dynamic_func_call_cls'
     248 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:267:9: note: in expansion of macro '_dynamic_func_call'
     267 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/printk.h:579:9: note: in expansion of macro 'dynamic_pr_debug'
     579 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~
   drivers/of/dynamic.c:87:13: note: in expansion of macro 'pr_debug'
      87 |         if (pr_debug("notify "))
         |             ^~~~~~~~
   drivers/of/dynamic.c: In function '__of_changeset_entry_apply':
>> include/linux/dynamic_debug.h:219:58: error: expected expression before 'do'
     219 | #define __dynamic_func_call_cls(id, cls, fmt, func, ...) do {   \
         |                                                          ^~
   include/linux/dynamic_debug.h:246:9: note: in expansion of macro '__dynamic_func_call_cls'
     246 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:248:9: note: in expansion of macro '_dynamic_func_call_cls'
     248 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:267:9: note: in expansion of macro '_dynamic_func_call'
     267 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/printk.h:579:9: note: in expansion of macro 'dynamic_pr_debug'
     579 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~
   drivers/of/dynamic.c:571:13: note: in expansion of macro 'pr_debug'
     571 |         if (pr_debug("changeset: applying: cset<%p> ", ce))
         |             ^~~~~~~~


vim +/of_changeset_action_print +74 drivers/of/dynamic.c

    73	
  > 74	void of_changeset_action_print(unsigned long action, struct device_node *np, const char *prop_name)
    75	{
    76		if (prop_name)
    77			pr_cont("%-15s %pOF:%s\n", action_names[action], np, prop_name);
    78		else
    79			pr_cont("%-15s %pOF\n", action_names[action], np);
    80	}
    81	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
