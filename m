Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3977F85A9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 22:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjKXVyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 16:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKXVyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 16:54:46 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDFF198D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 13:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700862892; x=1732398892;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=v0vxVpHUrlbt5wnSpMFK6Zcowa+yjpozXmLNoAHPO4M=;
  b=aZpV2tL2v6ZsJbL6QZePvruZoisNexjrVcx7DhFAWGqCIPO0tfiVvaiS
   xLqxVDKD/PPErFn9oX4YyfnKnPkfTWeNJOXZsqcBLhES8vtsSvz9EKkdY
   poljloWkLCBr4OXdlnte6r0byZFQuCGUdBYnM723ZccoPMvNOdiqAP/1N
   z8h9IgPQcfU+Pm7T9kc9rUjlJh95fr9tcDn93WKpNyyyuAbJJaYjWAmmJ
   KrjDKm7Wardh+FtTCcLMZjcHclbrKe5aKM4+g5W5YgfvEGpJ+2stCajh0
   0Iu4Y8tfPzPQBoAjjfQKVmUI8tBeqDt+oublu15EqnOCfwrs1rKqK6w+L
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="391344087"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="391344087"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 13:54:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="802229625"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="802229625"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 24 Nov 2023 13:54:50 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r6e8O-0003Jn-1H;
        Fri, 24 Nov 2023 21:54:48 +0000
Date:   Sat, 25 Nov 2023 05:54:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Luca Coelho <luciano.coelho@intel.com>
Subject: drivers/net/wireless/intel/iwlwifi/fw/dbg.c:86: warning: Excess
 struct/union/enum/typedef member 'trans_len' description in
 'iwl_fw_dump_ptrs'
Message-ID: <202311250305.tf8Cus1Y-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f1a09972a45ae63efbd1587337c4be13b1893330
commit: 7174beb60c53209c6e98c9cee20efdee97ef880f iwlwifi: refactor firmware debug code
date:   6 years ago
config: powerpc-randconfig-003-20231123 (https://download.01.org/0day-ci/archive/20231125/202311250305.tf8Cus1Y-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231125/202311250305.tf8Cus1Y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311250305.tf8Cus1Y-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/bug.h:4:0,
                    from arch/powerpc/include/asm/cmpxchg.h:8,
                    from arch/powerpc/include/asm/atomic.h:10,
                    from include/linux/atomic.h:4,
                    from include/linux/debug_locks.h:5,
                    from include/linux/lockdep.h:25,
                    from include/linux/spinlock_types.h:18,
                    from include/linux/mutex.h:15,
                    from include/linux/kernfs.h:13,
                    from include/linux/sysfs.h:15,
                    from include/linux/kobject.h:21,
                    from include/linux/device.h:17,
                    from include/linux/devcoredump.h:23,
                    from drivers/net/wireless/intel/iwlwifi/fw/dbg.c:65:
   include/linux/dma-mapping.h: In function 'dma_map_resource':
   arch/powerpc/include/asm/page.h:129:32: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
    #define pfn_valid(pfn)  ((pfn) >= ARCH_PFN_OFFSET && (pfn) < max_mapnr)
                                   ^
   arch/powerpc/include/asm/bug.h:75:27: note: in definition of macro 'BUG_ON'
     if (__builtin_constant_p(x)) {    \
                              ^
   include/linux/dma-mapping.h:307:9: note: in expansion of macro 'pfn_valid'
     BUG_ON(pfn_valid(PHYS_PFN(phys_addr)));
            ^~~~~~~~~
   arch/powerpc/include/asm/page.h:129:32: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
    #define pfn_valid(pfn)  ((pfn) >= ARCH_PFN_OFFSET && (pfn) < max_mapnr)
                                   ^
   arch/powerpc/include/asm/bug.h:76:7: note: in definition of macro 'BUG_ON'
      if (x)      \
          ^
   include/linux/dma-mapping.h:307:9: note: in expansion of macro 'pfn_valid'
     BUG_ON(pfn_valid(PHYS_PFN(phys_addr)));
            ^~~~~~~~~
   arch/powerpc/include/asm/page.h:129:32: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
    #define pfn_valid(pfn)  ((pfn) >= ARCH_PFN_OFFSET && (pfn) < max_mapnr)
                                   ^
   arch/powerpc/include/asm/bug.h:84:25: note: in definition of macro 'BUG_ON'
        "r" ((__force long)(x)));   \
                            ^
   include/linux/dma-mapping.h:307:9: note: in expansion of macro 'pfn_valid'
     BUG_ON(pfn_valid(PHYS_PFN(phys_addr)));
            ^~~~~~~~~
>> drivers/net/wireless/intel/iwlwifi/fw/dbg.c:86: warning: Excess struct/union/enum/typedef member 'trans_len' description in 'iwl_fw_dump_ptrs'


vim +86 drivers/net/wireless/intel/iwlwifi/fw/dbg.c

    72	
    73	/**
    74	 * struct iwl_fw_dump_ptrs - set of pointers needed for the fw-error-dump
    75	 *
    76	 * @fwrt_ptr: pointer to the buffer coming from fwrt
    77	 * @trans_ptr: pointer to struct %iwl_trans_dump_data which contains the
    78	 *	transport's data.
    79	 * @trans_len: length of the valid data in trans_ptr
    80	 * @fwrt_len: length of the valid data in fwrt_ptr
    81	 */
    82	struct iwl_fw_dump_ptrs {
    83		struct iwl_trans_dump_data *trans_ptr;
    84		void *fwrt_ptr;
    85		u32 fwrt_len;
  > 86	};
    87	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
