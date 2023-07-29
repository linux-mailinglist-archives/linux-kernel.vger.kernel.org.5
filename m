Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDC1767EC0
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 13:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjG2LjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 07:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjG2LjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 07:39:09 -0400
Received: from mgamail.intel.com (unknown [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE904E4B;
        Sat, 29 Jul 2023 04:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690630748; x=1722166748;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VYVphgUxW/IZwuTVDTy1kBZK4eLOSr3761Byb5rYCFU=;
  b=cR3cqK0eR/U+FmeteYyPajN8I9hgWFIfpOa9iGERmNcC0d4OoLpw9fBy
   2V1IBsupQ/qhVQs3HWFbs/8XhDkK26IT+jO8IL9mNhWqPwEhuupjIzY/r
   3+syV7UhCFq4JzM76Ms0qPiRQhooFKr11Nf/5MHLHSzTE8Lp24nJluaFG
   EkMe2W30GY3eBydsu07NzzW47D0fzeqxGsXSkHF3kcrVeS2Afjngo9nCu
   dzYCw+Or0KwUHj/XwsIBxQkYOVMiY4Bmyf3UQBenJHN7PRc+3+GrVD5lz
   8eUyYx7d1NEhQAA3xfJZMio1Uk4IPUttVHAVfGSXKENGA+lIBmohljMWI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="455115504"
X-IronPort-AV: E=Sophos;i="6.01,240,1684825200"; 
   d="scan'208";a="455115504"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2023 04:39:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="797706733"
X-IronPort-AV: E=Sophos;i="6.01,240,1684825200"; 
   d="scan'208";a="797706733"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 29 Jul 2023 04:39:05 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qPiHo-00040R-22;
        Sat, 29 Jul 2023 11:39:04 +0000
Date:   Sat, 29 Jul 2023 19:38:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] of: dynamic: Refactor action prints to not use "%pOF"
 inside devtree_lock
Message-ID: <202307291901.IEr9LCpd-lkp@intel.com>
References: <20230728231950.1619073-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728231950.1619073-1-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
config: i386-randconfig-i014-20230728 (https://download.01.org/0day-ci/archive/20230729/202307291901.IEr9LCpd-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230729/202307291901.IEr9LCpd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307291901.IEr9LCpd-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/of/dynamic.c:74:6: warning: no previous prototype for function 'of_changeset_action_print' [-Wmissing-prototypes]
   void of_changeset_action_print(unsigned long action, struct device_node *np, const char *prop_name)
        ^
   drivers/of/dynamic.c:74:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void of_changeset_action_print(unsigned long action, struct device_node *np, const char *prop_name)
   ^
   static 
>> drivers/of/dynamic.c:87:6: error: expected expression
           if (pr_debug("notify "))
               ^
   include/linux/printk.h:579:2: note: expanded from macro 'pr_debug'
           dynamic_pr_debug(fmt, ##__VA_ARGS__)
           ^
   include/linux/dynamic_debug.h:267:2: note: expanded from macro 'dynamic_pr_debug'
           _dynamic_func_call(fmt, __dynamic_pr_debug,             \
           ^
   include/linux/dynamic_debug.h:248:2: note: expanded from macro '_dynamic_func_call'
           _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
           ^
   include/linux/dynamic_debug.h:246:2: note: expanded from macro '_dynamic_func_call_cls'
           __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
           ^
   include/linux/dynamic_debug.h:219:58: note: expanded from macro '__dynamic_func_call_cls'
   #define __dynamic_func_call_cls(id, cls, fmt, func, ...) do {   \
                                                            ^
   drivers/of/dynamic.c:571:6: error: expected expression
           if (pr_debug("changeset: applying: cset<%p> ", ce))
               ^
   include/linux/printk.h:579:2: note: expanded from macro 'pr_debug'
           dynamic_pr_debug(fmt, ##__VA_ARGS__)
           ^
   include/linux/dynamic_debug.h:267:2: note: expanded from macro 'dynamic_pr_debug'
           _dynamic_func_call(fmt, __dynamic_pr_debug,             \
           ^
   include/linux/dynamic_debug.h:248:2: note: expanded from macro '_dynamic_func_call'
           _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
           ^
   include/linux/dynamic_debug.h:246:2: note: expanded from macro '_dynamic_func_call_cls'
           __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
           ^
   include/linux/dynamic_debug.h:219:58: note: expanded from macro '__dynamic_func_call_cls'
   #define __dynamic_func_call_cls(id, cls, fmt, func, ...) do {   \
                                                            ^
   1 warning and 2 errors generated.


vim +87 drivers/of/dynamic.c

    81	
    82	int of_reconfig_notify(unsigned long action, struct of_reconfig_data *p)
    83	{
    84		int rc;
    85		struct of_reconfig_data *pr = p;
    86	
  > 87		if (pr_debug("notify "))
    88			of_changeset_action_print(action, pr->dn, pr->prop ? pr->prop->name : NULL);
    89	
    90		rc = blocking_notifier_call_chain(&of_reconfig_chain, action, p);
    91		return notifier_to_errno(rc);
    92	}
    93	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
