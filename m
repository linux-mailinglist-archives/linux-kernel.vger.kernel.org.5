Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A42788EE7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 20:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjHYSq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 14:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjHYSqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 14:46:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9995CD2;
        Fri, 25 Aug 2023 11:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692989157; x=1724525157;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bdi3UHV6cWAJbUhLUlM5vlImO4KnMAKOGjs965oD0OI=;
  b=RahZIZ63Nhvm+8cMRBpJpRl2rXFVxEMktYlHlpkOCdVmL1Dys5k/VUVa
   DrnS0spn/9T7SPlpdBFSezcoSsVGzh/AjBYYtRWNtA6QmlMpToeD9hxVI
   Fm8qVtAc+T8xzNa0XlI3sKBwivgIg205uScDnOIjbXQx+OoxYJluoIy0p
   XJ72ozEeo9d2aqfmrliQ2aEJLSeSeCzdAxLTM4o4c8aT8RvxgIlFli4Qs
   8GuCtG0BXjF7mS7RWkCzzIgYlAmg6fjM9Wf3gX3mnumVnete0yqfPLJia
   a+UWsZWXkq11bCQ7HyoANFPDUYVsNeumScQSWFZIYQVBvufK+MzJ3CKSN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="378560385"
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="378560385"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 11:45:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="984198849"
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="984198849"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 25 Aug 2023 11:45:50 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZbob-0003uV-1G;
        Fri, 25 Aug 2023 18:45:49 +0000
Date:   Sat, 26 Aug 2023 02:45:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc:     oe-kbuild-all@lists.linux.dev, azkali <a.ffcc7@gmail.com>,
        Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        Adam Jiang <chaoj@nvidia.com>, CTCaer <ctcaer@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] misc: bm92txx: Add driver for the ROHM BM92Txx
Message-ID: <202308260248.MfhnxNk4-lkp@intel.com>
References: <20230824153059.212244-3-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824153059.212244-3-linkmauve@linkmauve.fr>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Emmanuel,

kernel test robot noticed the following build errors:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on char-misc/char-misc-next char-misc/char-misc-linus robh/for-next linus/master v6.5-rc7 next-20230825]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Emmanuel-Gil-Peyrot/dt-bindings-misc-rohm-bm92txx-Add-BM92Txx-support/20230824-233354
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20230824153059.212244-3-linkmauve%40linkmauve.fr
patch subject: [PATCH 2/2] misc: bm92txx: Add driver for the ROHM BM92Txx
config: riscv-randconfig-r034-20230826 (https://download.01.org/0day-ci/archive/20230826/202308260248.MfhnxNk4-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230826/202308260248.MfhnxNk4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308260248.MfhnxNk4-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/misc/bm92txx.c: In function 'bm92t_cmd_write':
   drivers/misc/bm92txx.c:2037:16: error: invalid storage class for function 'bm92t_usbhub_dp_sleep_write'
    2037 | static ssize_t bm92t_usbhub_dp_sleep_write(struct file *file,
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/bm92txx.c:2063:18: error: initializer element is not constant
    2063 |         .write = bm92t_usbhub_dp_sleep_write,
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/bm92txx.c:2063:18: note: (near initialization for 'bm92t_usbhub_dp_sleep_fops.write')
   drivers/misc/bm92txx.c:2066:12: error: invalid storage class for function 'bm92t_debug_init'
    2066 | static int bm92t_debug_init(struct bm92t_info *info)
         |            ^~~~~~~~~~~~~~~~
>> drivers/misc/bm92txx.c:2126:1: warning: 'alias' attribute ignored [-Wattributes]
    2126 | MODULE_DEVICE_TABLE(of, bm92t_of_match);
         | ^~~~~~~~~~~~~~~~~~~
   drivers/misc/bm92txx.c:2129:36: error: invalid storage class for function 'bm92t_parse_dt'
    2129 | static struct bm92t_platform_data *bm92t_parse_dt(struct device *dev)
         |                                    ^~~~~~~~~~~~~~
   drivers/misc/bm92txx.c:2180:12: error: invalid storage class for function 'bm92t_probe'
    2180 | static int bm92t_probe(struct i2c_client *client)
         |            ^~~~~~~~~~~
   drivers/misc/bm92txx.c:2316:12: error: invalid storage class for function 'bm92t_pm_suspend'
    2316 | static int bm92t_pm_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~~~
   drivers/misc/bm92txx.c:2335:12: error: invalid storage class for function 'bm92t_pm_resume'
    2335 | static int bm92t_pm_resume(struct device *dev)
         |            ^~~~~~~~~~~~~~~
   drivers/misc/bm92txx.c:2365:20: error: initializer element is not constant
    2365 |         .suspend = bm92t_pm_suspend,
         |                    ^~~~~~~~~~~~~~~~
   drivers/misc/bm92txx.c:2365:20: note: (near initialization for 'bm92t_pm_ops.suspend')
   drivers/misc/bm92txx.c:2366:19: error: initializer element is not constant
    2366 |         .resume = bm92t_pm_resume,
         |                   ^~~~~~~~~~~~~~~
   drivers/misc/bm92txx.c:2366:19: note: (near initialization for 'bm92t_pm_ops.resume')
   drivers/misc/bm92txx.c:2374:1: warning: 'alias' attribute ignored [-Wattributes]
    2374 | MODULE_DEVICE_TABLE(i2c, bm92t_id);
         | ^~~~~~~~~~~~~~~~~~~
   drivers/misc/bm92txx.c:2386:18: error: initializer element is not constant
    2386 |         .probe = bm92t_probe,
         |                  ^~~~~~~~~~~
   drivers/misc/bm92txx.c:2386:18: note: (near initialization for 'bm92t_i2c_driver.<anonymous>.probe')
   drivers/misc/bm92txx.c:2391:19: error: invalid storage class for function 'bm92t_init'
    2391 | static int __init bm92t_init(void)
         |                   ^~~~~~~~~~
   In file included from drivers/misc/bm92txx.c:15:
>> include/linux/module.h:131:49: error: invalid storage class for function '__inittest'
     131 |         static inline initcall_t __maybe_unused __inittest(void)                \
         |                                                 ^~~~~~~~~~
   include/linux/module.h:118:41: note: in expansion of macro 'module_init'
     118 | #define subsys_initcall_sync(fn)        module_init(fn)
         |                                         ^~~~~~~~~~~
   drivers/misc/bm92txx.c:2395:1: note: in expansion of macro 'subsys_initcall_sync'
    2395 | subsys_initcall_sync(bm92t_init);
         | ^~~~~~~~~~~~~~~~~~~~
   drivers/misc/bm92txx.c:2395:1: warning: 'alias' attribute ignored [-Wattributes]
   drivers/misc/bm92txx.c:2397:20: error: invalid storage class for function 'bm92t_exit'
    2397 | static void __exit bm92t_exit(void)
         |                    ^~~~~~~~~~
>> include/linux/module.h:139:49: error: invalid storage class for function '__exittest'
     139 |         static inline exitcall_t __maybe_unused __exittest(void)                \
         |                                                 ^~~~~~~~~~
   drivers/misc/bm92txx.c:2401:1: note: in expansion of macro 'module_exit'
    2401 | module_exit(bm92t_exit);
         | ^~~~~~~~~~~
   drivers/misc/bm92txx.c:2401:1: warning: 'alias' attribute ignored [-Wattributes]
   drivers/misc/bm92txx.c:2403:1: error: expected declaration or statement at end of input
    2403 | MODULE_LICENSE("GPL");
         | ^~~~~~~~~~~~~~
   drivers/misc/bm92txx.c: At top level:
   drivers/misc/bm92txx.c:2008:16: warning: 'bm92t_cmd_write' defined but not used [-Wunused-function]
    2008 | static ssize_t bm92t_cmd_write(struct file *file,
         |                ^~~~~~~~~~~~~~~


vim +/__inittest +131 include/linux/module.h

0fd972a7d91d6e Paul Gortmaker 2015-05-01  128  
0fd972a7d91d6e Paul Gortmaker 2015-05-01  129  /* Each module must use one module_init(). */
0fd972a7d91d6e Paul Gortmaker 2015-05-01  130  #define module_init(initfn)					\
1f318a8bafcfba Arnd Bergmann  2017-02-01 @131  	static inline initcall_t __maybe_unused __inittest(void)		\
0fd972a7d91d6e Paul Gortmaker 2015-05-01  132  	{ return initfn; }					\
cf68fffb66d60d Sami Tolvanen  2021-04-08  133  	int init_module(void) __copy(initfn)			\
cf68fffb66d60d Sami Tolvanen  2021-04-08  134  		__attribute__((alias(#initfn)));		\
92efda8eb15295 Sami Tolvanen  2022-09-08  135  	___ADDRESSABLE(init_module, __initdata);
0fd972a7d91d6e Paul Gortmaker 2015-05-01  136  
0fd972a7d91d6e Paul Gortmaker 2015-05-01  137  /* This is only required if you want to be unloadable. */
0fd972a7d91d6e Paul Gortmaker 2015-05-01  138  #define module_exit(exitfn)					\
1f318a8bafcfba Arnd Bergmann  2017-02-01 @139  	static inline exitcall_t __maybe_unused __exittest(void)		\
0fd972a7d91d6e Paul Gortmaker 2015-05-01  140  	{ return exitfn; }					\
cf68fffb66d60d Sami Tolvanen  2021-04-08  141  	void cleanup_module(void) __copy(exitfn)		\
cf68fffb66d60d Sami Tolvanen  2021-04-08  142  		__attribute__((alias(#exitfn)));		\
92efda8eb15295 Sami Tolvanen  2022-09-08  143  	___ADDRESSABLE(cleanup_module, __exitdata);
0fd972a7d91d6e Paul Gortmaker 2015-05-01  144  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
