Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCAE17F0E25
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 09:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbjKTIwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 03:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjKTIwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 03:52:32 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A40A2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700470349; x=1732006349;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DPZLGt6UI9pYtOEXLbzH1eJM5jNNTBQEZGnkbehKEME=;
  b=WoSRgUgTSQ7B1kVau5xtw/6soLuUecksUuUlkQz/RlBIcDPnTQGGQYUp
   jVglKUlVFEzALhGIKgvDaJcQ3MGtsJ+ttndwxb3X/mPdiPv45nDVmZ49A
   yJK38DvXfGPGTvbxjhQKcME6mtRokiRg4Ep6kfAbKJA6x8q8z2flVWOUb
   Y03507Pt+b900DLsFebEVyvBGt4g71OMGrYbbaL2NDLcxNQErqBcF7iFp
   9aUrGRquNAItsD8n08IVoxulfQ1dkvP+W+FabRsxOzoR3no5QJqNTGH13
   t9xQjllr7moLT5X84Vk1c8pmvZsTlum1WkQrHhN77vcFiWQ2MAochtH22
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="388718859"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="388718859"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 00:52:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="742662696"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="742662696"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 20 Nov 2023 00:52:22 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r500y-0006ED-0Q;
        Mon, 20 Nov 2023 08:52:20 +0000
Date:   Mon, 20 Nov 2023 16:52:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kent Overstreet <kmo@daterainc.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: fs/bcachefs/replicas.c:25:52: error: builtin functions must be
 directly called
Message-ID: <202311201620.mhbq1YMe-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   98b1cc82c4affc16f5598d4fa14b1858671b2263
commit: 1c6fdbd8f2465ddfb73a01ec620cbf3d14044e1a bcachefs: Initial commit
date:   4 weeks ago
config: i386-buildonly-randconfig-006-20231120 (https://download.01.org/0day-ci/archive/20231120/202311201620.mhbq1YMe-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231120/202311201620.mhbq1YMe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311201620.mhbq1YMe-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/bcachefs/replicas.c:25:52: error: builtin functions must be directly called
           eytzinger0_sort(r->entries, r->nr, r->entry_size, memcmp, NULL);
                                                             ^
   arch/x86/include/asm/string_32.h:159:16: note: expanded from macro 'memcmp'
   #define memcmp __builtin_memcmp
                  ^
   fs/bcachefs/replicas.c:165:5: error: builtin functions must be directly called
                                   memcmp, &search) < r->nr;
                                   ^
   arch/x86/include/asm/string_32.h:159:16: note: expanded from macro 'memcmp'
   #define memcmp __builtin_memcmp
                  ^
   fs/bcachefs/replicas.c:499:9: error: builtin functions must be directly called
                         memcmp, NULL);
                         ^
   arch/x86/include/asm/string_32.h:159:16: note: expanded from macro 'memcmp'
   #define memcmp __builtin_memcmp
                  ^
   3 errors generated.


vim +25 fs/bcachefs/replicas.c

    22	
    23	static void bch2_cpu_replicas_sort(struct bch_replicas_cpu *r)
    24	{
  > 25		eytzinger0_sort(r->entries, r->nr, r->entry_size, memcmp, NULL);
    26	}
    27	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
