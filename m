Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D397E7EE060
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 13:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345229AbjKPMIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 07:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344966AbjKPMH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 07:07:59 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108C39C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 04:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700136476; x=1731672476;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lOf+dsY6hg6ALegKfu+XLgN7HT546Llv2QELZgpFiuY=;
  b=MEGNhA7dYRdhzm3Wf72+IeCHCEft+Oi/YkGSWjpIFyRfi18Fc3i0hMek
   A70rr2hMSVSmRV7i6aJe1ifRmqOpLyka3za5toSeHzqLJv1pYobWKbUhB
   w4p5t7gmc5VsmT3p7/iGB1c4qcAzChFKqfs1vb/iG9hdmlDHQPPOTh1JW
   Js+bjJb9U9DQ0GLJyD3qZZhJ3dREVEtP++ZK0iGc2EwK5f2e6TqDyqL0v
   MF80C5cI8X0Cy1wHjUc07uFQt5diYvVwE5JlN622XbFQkeRA5aa+Y8U07
   QD5fKkvJ2cvZ+5CQrlyPeGfzOB4m7NpmuQfWUwkS5LAd1GeFVdYZ5MBGO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="457568028"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="457568028"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 04:07:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="909091192"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="909091192"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 16 Nov 2023 04:07:54 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r3b9z-0001cZ-2h;
        Thu, 16 Nov 2023 12:07:51 +0000
Date:   Thu, 16 Nov 2023 20:07:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Subject: arch/alpha/include/asm/xchg.h:234:32: sparse: sparse: cast truncates
 bits from constant value (eb9f becomes 9f)
Message-ID: <202311161930.Y0q8E1aT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c42d9eeef8e5ba9292eda36fd8e3c11f35ee065c
commit: c3c510ce431cd99fa10dcd50d995c8e89330ee5b bpf: Add 'owner' field to bpf_{list,rb}_node
date:   4 months ago
config: alpha-randconfig-r123-20231116 (https://download.01.org/0day-ci/archive/20231116/202311161930.Y0q8E1aT-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231116/202311161930.Y0q8E1aT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311161930.Y0q8E1aT-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/bpf/helpers.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/umh.h, include/linux/kmod.h, ...):
   include/linux/page-flags.h:240:46: sparse: sparse: self-comparison always evaluates to false
   kernel/bpf/helpers.c: note: in included file (through arch/alpha/include/asm/cmpxchg.h, arch/alpha/include/asm/atomic.h, include/linux/atomic.h, ...):
>> arch/alpha/include/asm/xchg.h:234:32: sparse: sparse: cast truncates bits from constant value (eb9f becomes 9f)
>> arch/alpha/include/asm/xchg.h:234:32: sparse: sparse: cast truncates bits from constant value (eb9f becomes 9f)
   kernel/bpf/helpers.c:2419:18: sparse: sparse: context imbalance in 'bpf_rcu_read_lock' - wrong count at exit
   kernel/bpf/helpers.c:2424:18: sparse: sparse: context imbalance in 'bpf_rcu_read_unlock' - unexpected unlock

vim +234 arch/alpha/include/asm/xchg.h

a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  227  
a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  228  static __always_inline unsigned long
a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  229  ____cmpxchg(, volatile void *ptr, unsigned long old, unsigned long new,
a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  230  	      int size)
a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  231  {
a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  232  	switch (size) {
a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  233  		case 1:
a6209d6d71f2ab Ivan Kokshaysky 2009-03-31 @234  			return ____cmpxchg(_u8, ptr, old, new);
a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  235  		case 2:
a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  236  			return ____cmpxchg(_u16, ptr, old, new);
a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  237  		case 4:
a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  238  			return ____cmpxchg(_u32, ptr, old, new);
a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  239  		case 8:
a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  240  			return ____cmpxchg(_u64, ptr, old, new);
a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  241  	}
a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  242  	__cmpxchg_called_with_bad_pointer();
a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  243  	return old;
a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  244  }
a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  245  

:::::: The code at line 234 was first introduced by commit
:::::: a6209d6d71f2ab8c63cc1587ef65490d83022baf alpha: xchg/cmpxchg cleanup and fixes

:::::: TO: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
