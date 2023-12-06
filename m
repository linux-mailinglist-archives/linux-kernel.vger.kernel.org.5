Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1ADA8063A7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 01:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376360AbjLFAvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 19:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376345AbjLFAvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 19:51:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3ED0C9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 16:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701823864; x=1733359864;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=A0643l07M794niF7N/B9EOXsl7Zsisy4aQA/I48mxKo=;
  b=R3Zu8Yz5h8tPFkQEg0SenGK2N1zw5fiS5y+/n2uslYPjM4UH2yGZ/ZQ7
   uFdEP+6n24i0zRGjPJ5ONebO4y+rVz7keiLdr4+DgVXA5hLfuYsUdE5x9
   kItiu1I9mCsS0dgUUPkkdELrarGemWikeMNUyVEjPymxkyI5/RJTociGc
   +SS3jydZy0GH9xzIqzeQReMcjkoVUS+0ihB1EHrkU1OpX2ImGkxALfHJJ
   kcWMGeREzWdSB8iY5n2JahBvQI+yrCEDrZCFBp5I+XtXGA0Io7uIvqoAj
   kOlXdq4oPg3ax2WeZWwWEhkpny6xKsmLcnEahPWj9paOGkOOoeyz+w6Ni
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="12698972"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="12698972"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 16:51:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="841652277"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="841652277"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 05 Dec 2023 16:51:01 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAg7v-0009yv-1D;
        Wed, 06 Dec 2023 00:50:59 +0000
Date:   Wed, 6 Dec 2023 08:50:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Luca Coelho <luciano.coelho@intel.com>
Subject: drivers/net/wireless/intel/iwlwifi/fw/dbg.c:86: warning: Excess
 struct/union/enum/typedef member 'trans_len' description in
 'iwl_fw_dump_ptrs'
Message-ID: <202312060810.QT9zourt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
commit: 7174beb60c53209c6e98c9cee20efdee97ef880f iwlwifi: refactor firmware debug code
date:   6 years ago
config: powerpc-randconfig-003-20231123 (https://download.01.org/0day-ci/archive/20231206/202312060810.QT9zourt-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231206/202312060810.QT9zourt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312060810.QT9zourt-lkp@intel.com/

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
