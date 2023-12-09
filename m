Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EA780B5C2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 18:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjLIRxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 12:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjLIRxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 12:53:01 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE1910CF;
        Sat,  9 Dec 2023 09:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702144388; x=1733680388;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xTBJuGW7OnJL/FllZh5+SkyJa/3/rDNej9zo2XlGCwo=;
  b=MrXri8uUIafjYhPFgQMep8herFiirO92yQ/Nx49dFAf4BZNMU3Tihu4f
   pJehGYbV4ES0u2vExX/zrMZIdl3XqtqL/4XbpZTEdqOqY9e8LNQYL67gl
   HaTrxx77OCv0MbDbWbxcLtvfFYJu6xJUVAKxy/gzFoI8nmSRD2TZLuJJV
   sCO6QXDFYG/JBGj92GCxGzXMo92eTKUBJhsPxUzgWGnGUTzEAtdoPEhl1
   ZaQEN3mLcbPLztCabRsHkDJQCsrXb37mQPGWxxNuGOdLdvkI2i6eUe5fg
   hdLDYTaU7yUqG5x3ubYU4hGR2aZIHpdjmT/9270Q3D/kbIA/+m6EMCDVk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="1643513"
X-IronPort-AV: E=Sophos;i="6.04,264,1695711600"; 
   d="scan'208";a="1643513"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 09:53:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="895873982"
X-IronPort-AV: E=Sophos;i="6.04,264,1695711600"; 
   d="scan'208";a="895873982"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 09 Dec 2023 09:53:02 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rC1Vc-000FiD-1s;
        Sat, 09 Dec 2023 17:53:00 +0000
Date:   Sun, 10 Dec 2023 01:52:05 +0800
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
Message-ID: <202312100106.hPaGgy7C-lkp@intel.com>
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
config: powerpc-randconfig-r071-20231209 (https://download.01.org/0day-ci/archive/20231210/202312100106.hPaGgy7C-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231210/202312100106.hPaGgy7C-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312100106.hPaGgy7C-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/base/power/wakeup.c:607:6: warning: no previous prototype for function 'pm_add_abort_suspend_source' [-Wmissing-prototypes]
     607 | void pm_add_abort_suspend_source(const char *source_name)
         |      ^
   drivers/base/power/wakeup.c:607:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     607 | void pm_add_abort_suspend_source(const char *source_name)
         | ^
         | static 
   drivers/base/power/wakeup.c:955:24: error: use of undeclared identifier 'info'
     955 |                         list_for_each_entry(info, &pm_abort_suspend_list, list) {
         |                                             ^
   drivers/base/power/wakeup.c:955:24: error: use of undeclared identifier 'info'
   drivers/base/power/wakeup.c:955:24: error: use of undeclared identifier 'info'
   drivers/base/power/wakeup.c:955:24: error: use of undeclared identifier 'info'
   drivers/base/power/wakeup.c:955:24: error: use of undeclared identifier 'info'
   drivers/base/power/wakeup.c:955:24: error: use of undeclared identifier 'info'
   drivers/base/power/wakeup.c:955:24: error: use of undeclared identifier 'info'
   drivers/base/power/wakeup.c:955:24: error: use of undeclared identifier 'info'
   drivers/base/power/wakeup.c:955:24: error: use of undeclared identifier 'info'
   drivers/base/power/wakeup.c:956:5: error: call to undeclared function 'log_suspend_abort_reason'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     956 |                                 log_suspend_abort_reason("ws or subsystem %s aborted suspend\n",
         |                                 ^
   drivers/base/power/wakeup.c:957:7: error: use of undeclared identifier 'info'
     957 |                                                 info->source_triggering_abort_suspend);
         |                                                 ^
   drivers/base/power/wakeup.c:967:11: error: use of undeclared identifier 'MAX_SUSPEND_ABORT_LEN'
     967 |         char buf[MAX_SUSPEND_ABORT_LEN];
         |                  ^
   1 warning and 12 errors generated.


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
