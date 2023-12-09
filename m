Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A5E80B5C3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 18:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjLIRxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 12:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjLIRxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 12:53:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6C011F;
        Sat,  9 Dec 2023 09:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702144386; x=1733680386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HwA9hXTpu4rYa8Lnzvejv74AVkq6Mfu/ugSlkhv6tT4=;
  b=cuRTzk5XMkwEPDFkEqYLo8Hfhs9u59rQPN5M2cJULLNeYp0boyTdTDfT
   3DQbJHmbDNM8M/67fHHIprcyB7IfoXBwjuY9agJ4emgvbXxPB7aicrH5o
   oLJ8a2TE5Hqz04xFHJo+YMKerBEbCOldzdKgajVCNdqCEMgQ8vujELcTP
   6nDkDPUmDUzPWBPjwWMmYX6L8ioi35TyngMVaENg/hL8XiNFili7Rqydk
   J3yquXOMcfZYUgfeReAK4bHLdnSVCQhIj+CVyiKt4foyBi5AEB9RoAd0D
   2NAGluqXda6Xt8A+DbaE+Seyl5Xue4knVoDXhsxY6Nrl0WRG6APJfn7GN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="1643506"
X-IronPort-AV: E=Sophos;i="6.04,264,1695711600"; 
   d="scan'208";a="1643506"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 09:53:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="895873980"
X-IronPort-AV: E=Sophos;i="6.04,264,1695711600"; 
   d="scan'208";a="895873980"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 09 Dec 2023 09:53:02 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rC1Vc-000Fi5-1c;
        Sat, 09 Dec 2023 17:53:00 +0000
Date:   Sun, 10 Dec 2023 01:52:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vimal Kumar <vimal.kumar32@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, chinmoyghosh2001@gmail.com,
        badolevishal1116@gmail.com, mintupatel89@gmail.com,
        Vimal Kumar <vimal.kumar32@gmail.com>
Subject: Re: [PATCH] PM / sleep: Mechanism to find source aborting kernel
 suspend transition
Message-ID: <202312100146.Nv4INLR5-lkp@intel.com>
References: <20231209081056.1497-1-vimal.kumar32@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231209081056.1497-1-vimal.kumar32@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vimal,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/acpi-bus linus/master rafael-pm/devprop v6.7-rc4 next-20231208]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vimal-Kumar/PM-sleep-Mechanism-to-find-source-aborting-kernel-suspend-transition/20231209-161237
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20231209081056.1497-1-vimal.kumar32%40gmail.com
patch subject: [PATCH] PM / sleep: Mechanism to find source aborting kernel suspend transition
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20231210/202312100146.Nv4INLR5-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231210/202312100146.Nv4INLR5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312100146.Nv4INLR5-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/base/power/wakeup.c:607:6: warning: no previous prototype for 'pm_add_abort_suspend_source' [-Wmissing-prototypes]
     607 | void pm_add_abort_suspend_source(const char *source_name)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/rculist.h:10,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/base/power/wakeup.c:9:
   drivers/base/power/wakeup.c: In function 'pm_wakeup_pending':
   drivers/base/power/wakeup.c:955:45: error: 'info' undeclared (first use in this function)
     955 |                         list_for_each_entry(info, &pm_abort_suspend_list, list) {
         |                                             ^~~~
   include/linux/list.h:778:14: note: in definition of macro 'list_for_each_entry'
     778 |         for (pos = list_first_entry(head, typeof(*pos), member);        \
         |              ^~~
   drivers/base/power/wakeup.c:955:45: note: each undeclared identifier is reported only once for each function it appears in
     955 |                         list_for_each_entry(info, &pm_abort_suspend_list, list) {
         |                                             ^~~~
   include/linux/list.h:778:14: note: in definition of macro 'list_for_each_entry'
     778 |         for (pos = list_first_entry(head, typeof(*pos), member);        \
         |              ^~~
   In file included from include/linux/bits.h:21,
                    from include/linux/ratelimit_types.h:5,
                    from include/linux/ratelimit.h:5,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/base/power/wakeup.c:9:
   include/linux/compiler_types.h:376:27: error: expression in static assertion is not an integer
     376 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:601:9: note: in expansion of macro 'container_of'
     601 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:612:9: note: in expansion of macro 'list_entry'
     612 |         list_entry((ptr)->next, type, member)
         |         ^~~~~~~~~~
   include/linux/list.h:778:20: note: in expansion of macro 'list_first_entry'
     778 |         for (pos = list_first_entry(head, typeof(*pos), member);        \
         |                    ^~~~~~~~~~~~~~~~
   drivers/base/power/wakeup.c:955:25: note: in expansion of macro 'list_for_each_entry'
     955 |                         list_for_each_entry(info, &pm_abort_suspend_list, list) {
         |                         ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:376:27: error: expression in static assertion is not an integer
     376 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:601:9: note: in expansion of macro 'container_of'
     601 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:645:9: note: in expansion of macro 'list_entry'
     645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   include/linux/list.h:780:20: note: in expansion of macro 'list_next_entry'
     780 |              pos = list_next_entry(pos, member))
         |                    ^~~~~~~~~~~~~~~
   drivers/base/power/wakeup.c:955:25: note: in expansion of macro 'list_for_each_entry'
     955 |                         list_for_each_entry(info, &pm_abort_suspend_list, list) {
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/base/power/wakeup.c:956:33: error: implicit declaration of function 'log_suspend_abort_reason' [-Werror=implicit-function-declaration]
     956 |                                 log_suspend_abort_reason("ws or subsystem %s aborted suspend\n",
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/base/power/wakeup.c: In function 'pm_system_wakeup':
   drivers/base/power/wakeup.c:967:18: error: 'MAX_SUSPEND_ABORT_LEN' undeclared (first use in this function)
     967 |         char buf[MAX_SUSPEND_ABORT_LEN];
         |                  ^~~~~~~~~~~~~~~~~~~~~
>> drivers/base/power/wakeup.c:967:14: warning: unused variable 'buf' [-Wunused-variable]
     967 |         char buf[MAX_SUSPEND_ABORT_LEN];
         |              ^~~
   cc1: some warnings being treated as errors


vim +/pm_add_abort_suspend_source +607 drivers/base/power/wakeup.c

   602	
   603	/**
   604	 * pm_add_abort_suspend_source: add sources who aborted system suspend transitions.
   605	 * @func_name: Name of the WS or subsystem which needs to added in the list
   606	 */
 > 607	void pm_add_abort_suspend_source(const char *source_name)
   608	{
   609		struct pm_abort_suspend_source *info = NULL;
   610	
   611		info = kmalloc(sizeof(struct pm_abort_suspend_source), GFP_KERNEL);
   612		if (unlikely(!info)) {
   613			pr_err("Failed to alloc memory for pm_abort_suspend_source info\n");
   614			return;
   615		}
   616	
   617		/* Initialize the list within the struct if it's not already initialized */
   618		if (list_empty(&info->list))
   619			INIT_LIST_HEAD(&info->list);
   620	
   621		info->source_triggering_abort_suspend = kstrdup(source_name, GFP_KERNEL);
   622		if (unlikely(!info->source_triggering_abort_suspend)) {
   623			pr_err("Failed to get abort_suspend source_name\n");
   624			kfree(info);
   625			return;
   626		}
   627	
   628		list_add_tail(&info->list, &pm_abort_suspend_list);
   629	}
   630	EXPORT_SYMBOL_GPL(pm_add_abort_suspend_source);
   631	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
