Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CAF7E8CC1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 22:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjKKVAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 16:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjKKVAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 16:00:22 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0ACE2D64
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 13:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699736419; x=1731272419;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hw5W07KvQKlwxFOk9Pg2V64H6PROzUJWUu4Yz/EbsqM=;
  b=GRMvZ8UjIZwoS2CzTFgziJHbZy1Otb6CZ2aKNJs+LgUDrmxw781J7Wqj
   siKPIwZyXYXldql0vMK6m6Zo9lYy0qdPGhcGkCa2uE69H610YTCuCC0+K
   FUY/7IQFWX83VsPySNxDu9fpmgonpuK/hJUTtzoT8T0L29DTKhbI3ywF9
   IhUWBPhguz6Ux5LX948nQSek15Wum943AYgYA7euSspUpco+xfse660cL
   7g6NBjRpU+InRtoAcxps0uNK9rLf30MeQSYHhnIrrknd3hLx3v+QaRZKm
   EF0kyWZonH7mBnGkfL20u+WRbbeVnWDEsJsiGq0qRwy6slPhPr1MfSkTT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="454598464"
X-IronPort-AV: E=Sophos;i="6.03,296,1694761200"; 
   d="scan'208";a="454598464"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 13:00:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="1095426102"
X-IronPort-AV: E=Sophos;i="6.03,296,1694761200"; 
   d="scan'208";a="1095426102"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 11 Nov 2023 13:00:17 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1v5T-000Akv-14;
        Sat, 11 Nov 2023 21:00:15 +0000
Date:   Sun, 12 Nov 2023 04:59:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@iguana.be>
Subject: drivers/watchdog/it87_wdt.c:321: warning: Function parameter or
 member 'wdd' not described in 'wdt_set_timeout'
Message-ID: <202311120459.240skMhF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3ca112b71f35dd5d99fc4571a56b5fc6f0c15814
commit: 1d7b80394c48a56c705733cb6c044199ffbf1dfd watchdog: it87: Convert to use watchdog core infrastructure
date:   6 years ago
config: x86_64-randconfig-a001-20230604 (https://download.01.org/0day-ci/archive/20231112/202311120459.240skMhF-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231112/202311120459.240skMhF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311120459.240skMhF-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/watchdog/it87_wdt.c:31:
   include/linux/module.h:131:13: warning: 'init_module' specifies less restrictive attribute than its target 'it87_wdt_init': 'cold' [-Wmissing-attributes]
     131 |         int init_module(void) __attribute__((alias(#initfn)));
         |             ^~~~~~~~~~~
   drivers/watchdog/it87_wdt.c:557:1: note: in expansion of macro 'module_init'
     557 | module_init(it87_wdt_init);
         | ^~~~~~~~~~~
   drivers/watchdog/it87_wdt.c:367:19: note: 'init_module' target declared here
     367 | static int __init it87_wdt_init(void)
         |                   ^~~~~~~~~~~~~
   include/linux/module.h:137:14: warning: 'cleanup_module' specifies less restrictive attribute than its target 'it87_wdt_exit': 'cold' [-Wmissing-attributes]
     137 |         void cleanup_module(void) __attribute__((alias(#exitfn)));
         |              ^~~~~~~~~~~~~~
   drivers/watchdog/it87_wdt.c:558:1: note: in expansion of macro 'module_exit'
     558 | module_exit(it87_wdt_exit);
         | ^~~~~~~~~~~
   drivers/watchdog/it87_wdt.c:529:20: note: 'cleanup_module' target declared here
     529 | static void __exit it87_wdt_exit(void)
         |                    ^~~~~~~~~~~~~
>> drivers/watchdog/it87_wdt.c:321: warning: Function parameter or member 'wdd' not described in 'wdt_set_timeout'


vim +321 drivers/watchdog/it87_wdt.c

e1fee94f346387 Oliver Schuster 2008-03-05  309  
e1fee94f346387 Oliver Schuster 2008-03-05  310  /**
e1fee94f346387 Oliver Schuster 2008-03-05  311   *	wdt_set_timeout - set a new timeout value with watchdog ioctl
e1fee94f346387 Oliver Schuster 2008-03-05  312   *	@t: timeout value in seconds
e1fee94f346387 Oliver Schuster 2008-03-05  313   *
dfb0b8eae1f78c Ondrej Zajicek  2010-09-14  314   *	The hardware device has a 8 or 16 bit watchdog timer (depends on
dfb0b8eae1f78c Ondrej Zajicek  2010-09-14  315   *	chip version) that can be configured to count seconds or minutes.
e1fee94f346387 Oliver Schuster 2008-03-05  316   *
e1fee94f346387 Oliver Schuster 2008-03-05  317   *	Used within WDIOC_SETTIMEOUT watchdog device ioctl.
e1fee94f346387 Oliver Schuster 2008-03-05  318   */
e1fee94f346387 Oliver Schuster 2008-03-05  319  
1d7b80394c48a5 Guenter Roeck   2017-06-10  320  static int wdt_set_timeout(struct watchdog_device *wdd, unsigned int t)
e1fee94f346387 Oliver Schuster 2008-03-05 @321  {
1d7b80394c48a5 Guenter Roeck   2017-06-10  322  	int ret = 0;
e1fee94f346387 Oliver Schuster 2008-03-05  323  
dfb0b8eae1f78c Ondrej Zajicek  2010-09-14  324  	if (t > max_units)
1d7b80394c48a5 Guenter Roeck   2017-06-10  325  		t = wdt_round_time(t);
e1fee94f346387 Oliver Schuster 2008-03-05  326  
1d7b80394c48a5 Guenter Roeck   2017-06-10  327  	wdd->timeout = t;
e1fee94f346387 Oliver Schuster 2008-03-05  328  
1d7b80394c48a5 Guenter Roeck   2017-06-10  329  	if (watchdog_hw_running(wdd))
1d7b80394c48a5 Guenter Roeck   2017-06-10  330  		ret = wdt_update_timeout();
e1fee94f346387 Oliver Schuster 2008-03-05  331  
a134b825608df6 Nat Gurumoorthy 2011-05-09  332  	return ret;
a134b825608df6 Nat Gurumoorthy 2011-05-09  333  }
e1fee94f346387 Oliver Schuster 2008-03-05  334  

:::::: The code at line 321 was first introduced by commit
:::::: e1fee94f346387739e683b31815ab54dc0a30bd6 [WATCHDOG] add watchdog driver IT8716 IT8726 IT8712J/K

:::::: TO: Oliver Schuster <olivers137@aol.com>
:::::: CC: Wim Van Sebroeck <wim@iguana.be>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
