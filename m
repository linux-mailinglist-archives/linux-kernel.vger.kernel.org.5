Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C73C7641E9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 00:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjGZWL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 18:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGZWL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 18:11:57 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2BF270E
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 15:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690409515; x=1721945515;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Pmkc/2BFNx8n8rAEtWPbCsxRy4WV7FZ4zpTMVl30/zc=;
  b=YPaOoIGJ6xfWXiDSBA2TYozQlAHwYhvtbveOvAS38HkniD1x/F45jOFi
   h1yaDOx5qnDrnbi7Jtt+bB+DFs54wmQKrX7AP7X274FRm8nnWnvE5Mn5Z
   ROglbn2Ce3P8XwJxcUel+j2eKrX9FTHU6l5eojY8J56ooSIR5zJwJd54d
   CjL4LKt27mtrzoklvy7ou5RPS+V2l1fjFZc+maMe8vmFLJpj9/OVj8lHS
   /hTYqAZ+lU9sDWofWexijKF5FiWa1dTv2Ibg+NeMsCQLdho9ZlKdTHSgU
   cGyC697VFjhrEZGrXTADgQEZX0/KLcdKV55dOVXgO1odPHO5FxeKfNpjM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="371752906"
X-IronPort-AV: E=Sophos;i="6.01,233,1684825200"; 
   d="scan'208";a="371752906"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 15:11:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="676868382"
X-IronPort-AV: E=Sophos;i="6.01,233,1684825200"; 
   d="scan'208";a="676868382"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 26 Jul 2023 15:11:51 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOmjW-0001NC-1f;
        Wed, 26 Jul 2023 22:11:50 +0000
Date:   Thu, 27 Jul 2023 06:11:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [paulmck-rcu:dev.2023.07.24a 26/26] include/linux/init.h:149:33:
 error: expected '=', ',', ';', 'asm' or '__attribute__' before
 '__ro_after_init'
Message-ID: <202307270622.15fzt0V1-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.07.24a
head:   aaeb7f70ca6fef20998ac6aa580e42ca7b85fb7f
commit: aaeb7f70ca6fef20998ac6aa580e42ca7b85fb7f [26/26] squash! fs/proc: Add /proc/cmdline_load for boot loader arguments
config: parisc-randconfig-r006-20230726 (https://download.01.org/0day-ci/archive/20230727/202307270622.15fzt0V1-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230727/202307270622.15fzt0V1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307270622.15fzt0V1-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from arch/parisc/include/asm/alternative.h:18,
                    from arch/parisc/include/asm/cache.h:9,
                    from include/linux/cache.h:6,
                    from include/linux/slab.h:15,
                    from drivers/w1/w1_netlink.c:6:
>> include/linux/init.h:149:33: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__ro_after_init'
     149 | extern char boot_command_line[] __ro_after_init;
         |                                 ^~~~~~~~~~~~~~~
--
   In file included from include/linux/init.h:116,
                    from arch/parisc/include/asm/alternative.h:18,
                    from arch/parisc/include/asm/cache.h:9,
                    from arch/parisc/include/asm/page.h:23,
                    from arch/parisc/include/asm/pgtable.h:5,
                    from include/linux/pgtable.h:6,
                    from arch/parisc/include/asm/io.h:6,
                    from drivers/w1/w1_io.c:6:
>> include/linux/cache.h:72:31: error: 'L1_CACHE_SHIFT' undeclared here (not in a function); did you mean 'L1_CACHE_ALIGN'?
      72 | #define INTERNODE_CACHE_SHIFT L1_CACHE_SHIFT
         |                               ^~~~~~~~~~~~~~
   include/linux/cache.h:78:42: note: in expansion of macro 'INTERNODE_CACHE_SHIFT'
      78 |         __attribute__((__aligned__(1 << (INTERNODE_CACHE_SHIFT))))
         |                                          ^~~~~~~~~~~~~~~~~~~~~
   include/linux/cache.h:95:3: note: in expansion of macro '____cacheline_internodealigned_in_smp'
      95 | } ____cacheline_internodealigned_in_smp;
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/parisc/include/asm/cache.h:23: warning: "ARCH_DMA_MINALIGN" redefined
      23 | #define ARCH_DMA_MINALIGN       L1_CACHE_BYTES
         | 
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
   153	extern char saved_bootconfig_string[];
   154	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
