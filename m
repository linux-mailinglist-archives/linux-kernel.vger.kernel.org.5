Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4B77681BA
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 22:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjG2ULW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 16:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjG2ULV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 16:11:21 -0400
Received: from mgamail.intel.com (unknown [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCFCE7E
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 13:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690661480; x=1722197480;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UQVRhJxucWrKnCrw3aGUsQGNQTJMn89/PCfjpp1jKwI=;
  b=WcHFUzsnpCURfXE0KRgp27xxwnMVD8oXtijqvirWeY+Tzwaka2wypcyf
   jbCdEb+6jxxzTa98D+QUErcMKdu5Kt1+k/eskmA8I2tHsUqpdJ9/pKIQd
   S9QM/nE3r+Go/dcHzJjXlFNioWHG1TLcjcVHRjvOsWRajeCECFgmSjffi
   TJEbk4XU9CiiBFBgn7WO/An4BIecYsSzTxipn8elQOFzaeU1QfAY7jmDB
   Kk4lcfNbBq+lUuOa8ISwwbDvEK3Xfvky50gWBKrLWj1LP/rYvALcjQ7GP
   XwbC1MTwxwHkHUj9U/Aetabh/Q1d8aXK8ENHHBZ5poDCNso4Rrs8f58Px
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10786"; a="358819792"
X-IronPort-AV: E=Sophos;i="6.01,240,1684825200"; 
   d="scan'208";a="358819792"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2023 13:11:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10786"; a="721616216"
X-IronPort-AV: E=Sophos;i="6.01,240,1684825200"; 
   d="scan'208";a="721616216"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 29 Jul 2023 13:11:18 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qPqHV-0004HX-2r;
        Sat, 29 Jul 2023 20:11:17 +0000
Date:   Sun, 30 Jul 2023 04:10:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [paulmck-rcu:dev.2023.07.26a 16/28] include/linux/init.h:149:33:
 error: expected '=', ',', ';', 'asm' or '__attribute__' before
 '__ro_after_init'
Message-ID: <202307300438.iREjlfde-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.07.26a
head:   709a917710dc01798e01750ea628ece4bfc42b7b
commit: de2f542cfbec295ac0f9b6a832d7b3ba20df391f [16/28] fs/proc: Add /proc/cmdline_load for boot loader arguments
config: parisc64-alldefconfig (https://download.01.org/0day-ci/archive/20230730/202307300438.iREjlfde-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230730/202307300438.iREjlfde-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307300438.iREjlfde-lkp@intel.com/

Note: the paulmck-rcu/dev.2023.07.26a HEAD 709a917710dc01798e01750ea628ece4bfc42b7b builds fine.
      It only hurts bisectability.

All error/warnings (new ones prefixed by >>):

   In file included from arch/parisc/include/asm/alternative.h:18,
                    from arch/parisc/include/asm/cache.h:9,
                    from include/linux/cache.h:6,
                    from include/linux/jiffies.h:5,
                    from init/calibrate.c:8:
>> include/linux/init.h:149:33: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__ro_after_init'
     149 | extern char boot_command_line[] __ro_after_init;
         |                                 ^~~~~~~~~~~~~~~
--
   In file included from arch/parisc/include/asm/page.h:23,
                    from include/linux/generic-radix-tree.h:39,
                    from lib/generic-radix-tree.c:3:
>> arch/parisc/include/asm/cache.h:23: warning: "ARCH_DMA_MINALIGN" redefined
      23 | #define ARCH_DMA_MINALIGN       L1_CACHE_BYTES
         | 
   In file included from include/linux/init.h:116,
                    from arch/parisc/include/asm/alternative.h:18,
                    from arch/parisc/include/asm/cache.h:9:
   include/linux/cache.h:104: note: this is the location of the previous definition
     104 | #define ARCH_DMA_MINALIGN __alignof__(unsigned long long)
         | 
>> arch/parisc/include/asm/cache.h:25: warning: "__read_mostly" redefined
      25 | #define __read_mostly __section(".data..read_mostly")
         | 
   include/linux/cache.h:28: note: this is the location of the previous definition
      28 | #define __read_mostly
         | 


vim +149 include/linux/init.h

   146	
   147	/* Defined in init/main.c */
   148	extern int do_one_initcall(initcall_t fn);
 > 149	extern char boot_command_line[] __ro_after_init;
   150	extern char *saved_command_line;
   151	extern unsigned int saved_command_line_len;
   152	extern unsigned int reset_devices;
   153	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
