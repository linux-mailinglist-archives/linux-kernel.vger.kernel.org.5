Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5EB27996D6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 10:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343854AbjIIIRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 04:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243092AbjIIIRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 04:17:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597DF1BD3
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 01:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694247418; x=1725783418;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=on7fcGhDhOSHrDFPYPxEfCIkCWmYbrJyFDP+8sMR7fQ=;
  b=cEPT5O5TQKrbo6V3pZeqEg0UK2siQltU8M3mVsNIrei878/FAlX4hwvK
   pzwA1CjVoBzTnLozpAMCkqpdJecQiY+8ZTxQz0siqn4SPLt5s5JTyZA4o
   2P/d2vinXuzkJhbdnwxFGUJifUplBei/FmEto1cCAs03J9/+DvfbvVBqQ
   GiGZehA4SRsHLk7PUUsv+DXkSsVeKsTbhg3EHeHPJZmgwXjeiwNFovrOL
   oaUYL7C62VICw97WlUCuoCdUN82QYjiSgvD3pC7hCFoBSlLknx0H8vzeR
   JxG4KgHpO7nOcytcqElugMzYj39dOXiClbJwSCugMwhMlqRBZzoSfR4DK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="376714666"
X-IronPort-AV: E=Sophos;i="6.02,239,1688454000"; 
   d="scan'208";a="376714666"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2023 01:16:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="692512082"
X-IronPort-AV: E=Sophos;i="6.02,239,1688454000"; 
   d="scan'208";a="692512082"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 09 Sep 2023 01:16:55 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qet9B-00038j-22;
        Sat, 09 Sep 2023 08:16:53 +0000
Date:   Sat, 9 Sep 2023 16:16:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/loongarch/kernel/asm-offsets.c:262:6: warning: no previous
 prototype for 'output_pbe_defines'
Message-ID: <202309091602.wwOWrqLD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huacai,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6099776f9f268e61fe5ecd721f994a8cfce5306f
commit: 7db54bfe44a662c8f2c10277bccfa02c2f4c719c LoongArch: Add hibernation (ACPI S4) support
date:   9 months ago
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20230909/202309091602.wwOWrqLD-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230909/202309091602.wwOWrqLD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309091602.wwOWrqLD-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/loongarch/kernel/asm-offsets.c:16:6: warning: no previous prototype for 'output_ptreg_defines' [-Wmissing-prototypes]
      16 | void output_ptreg_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/asm-offsets.c:63:6: warning: no previous prototype for 'output_task_defines' [-Wmissing-prototypes]
      63 | void output_task_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/asm-offsets.c:75:6: warning: no previous prototype for 'output_thread_info_defines' [-Wmissing-prototypes]
      75 | void output_thread_info_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/asm-offsets.c:91:6: warning: no previous prototype for 'output_thread_defines' [-Wmissing-prototypes]
      91 | void output_thread_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/asm-offsets.c:134:6: warning: no previous prototype for 'output_thread_fpu_defines' [-Wmissing-prototypes]
     134 | void output_thread_fpu_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/asm-offsets.c:174:6: warning: no previous prototype for 'output_mm_defines' [-Wmissing-prototypes]
     174 | void output_mm_defines(void)
         |      ^~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/asm-offsets.c:206:6: warning: no previous prototype for 'output_sc_defines' [-Wmissing-prototypes]
     206 | void output_sc_defines(void)
         |      ^~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/asm-offsets.c:214:6: warning: no previous prototype for 'output_signal_defines' [-Wmissing-prototypes]
     214 | void output_signal_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/asm-offsets.c:252:6: warning: no previous prototype for 'output_smpboot_defines' [-Wmissing-prototypes]
     252 | void output_smpboot_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~
>> arch/loongarch/kernel/asm-offsets.c:262:6: warning: no previous prototype for 'output_pbe_defines' [-Wmissing-prototypes]
     262 | void output_pbe_defines(void)
         |      ^~~~~~~~~~~~~~~~~~
--
   arch/loongarch/kernel/asm-offsets.c:16:6: warning: no previous prototype for 'output_ptreg_defines' [-Wmissing-prototypes]
      16 | void output_ptreg_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/asm-offsets.c:63:6: warning: no previous prototype for 'output_task_defines' [-Wmissing-prototypes]
      63 | void output_task_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/asm-offsets.c:75:6: warning: no previous prototype for 'output_thread_info_defines' [-Wmissing-prototypes]
      75 | void output_thread_info_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/asm-offsets.c:91:6: warning: no previous prototype for 'output_thread_defines' [-Wmissing-prototypes]
      91 | void output_thread_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/asm-offsets.c:134:6: warning: no previous prototype for 'output_thread_fpu_defines' [-Wmissing-prototypes]
     134 | void output_thread_fpu_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/asm-offsets.c:174:6: warning: no previous prototype for 'output_mm_defines' [-Wmissing-prototypes]
     174 | void output_mm_defines(void)
         |      ^~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/asm-offsets.c:206:6: warning: no previous prototype for 'output_sc_defines' [-Wmissing-prototypes]
     206 | void output_sc_defines(void)
         |      ^~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/asm-offsets.c:214:6: warning: no previous prototype for 'output_signal_defines' [-Wmissing-prototypes]
     214 | void output_signal_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/asm-offsets.c:252:6: warning: no previous prototype for 'output_smpboot_defines' [-Wmissing-prototypes]
     252 | void output_smpboot_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~
>> arch/loongarch/kernel/asm-offsets.c:262:6: warning: no previous prototype for 'output_pbe_defines' [-Wmissing-prototypes]
     262 | void output_pbe_defines(void)
         |      ^~~~~~~~~~~~~~~~~~
   <stdin>:569:2: warning: #warning syscall fstat not implemented [-Wcpp]


vim +/output_pbe_defines +262 arch/loongarch/kernel/asm-offsets.c

   260	
   261	#ifdef CONFIG_HIBERNATION
 > 262	void output_pbe_defines(void)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
