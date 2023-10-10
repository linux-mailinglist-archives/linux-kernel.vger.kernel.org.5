Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5447BF97F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjJJLSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbjJJLSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:18:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AFD118
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 04:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696936687; x=1728472687;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EkyWNHp1vT6Z/U7iZXwKcw5w3CgnGHncF0R2jGDNf+A=;
  b=l8gLb3RmTesFNPqGWUwrIZes9E+I1kh/4nUwxeB0Y6vF1N6+D7GgskZZ
   VU3Fs9B49aquDzp1RzhCpf4ghf4F6QS9/0knJzU33WJN/Hj0oNhrOrDE6
   rC/q3WVsCj+HWiOKbKldZwiQvi22N+vc6js27bGp5utmTAI43M/EfYdCE
   IKcFfvzgIBhZ7Z46ZBnCI6iyKZqlA0SUzhh5E5Ex66mOE/gDBup50S5cM
   Pctc2roETdEip5QlChAtgy7K/EJyccZ5KXWMuFYrXYBf8h+2oMTjjbqHt
   sONunOQksWp4dnPWr/bcQ6zCD8GnhhlW0zFDpfEiBkgYw8n3S5f3RcxH9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="470632313"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="470632313"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 04:17:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="927102041"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="927102041"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 10 Oct 2023 04:17:55 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qqAkI-0000JN-2l;
        Tue, 10 Oct 2023 11:17:51 +0000
Date:   Tue, 10 Oct 2023 19:16:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Olaf Hering <olaf@aepfle.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: arch/powerpc/include/asm/book3s/64/pgtable-64k.h:60:1: error: no
 return statement in function returning non-void
Message-ID: <202310101939.1583QpNt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   94f6f0550c625fab1f373bb86a6669b45e9748b3
commit: 172aad81a882443eefe1bd860c4eddc81b14dd5b kbuild: enforce -Werror=return-type
date:   3 years ago
config: powerpc64-randconfig-003-20231009 (https://download.01.org/0day-ci/archive/20231010/202310101939.1583QpNt-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231010/202310101939.1583QpNt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310101939.1583QpNt-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/powerpc/include/asm/book3s/64/pgtable.h:302,
                    from arch/powerpc/include/asm/book3s/64/mmu-hash.h:20,
                    from arch/powerpc/include/asm/book3s/64/mmu.h:46,
                    from arch/powerpc/include/asm/mmu.h:369,
                    from arch/powerpc/include/asm/lppaca.h:46,
                    from arch/powerpc/include/asm/paca.h:17,
                    from arch/powerpc/include/asm/current.h:13,
                    from include/linux/thread_info.h:21,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/powerpc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:51,
                    from include/linux/ipc.h:5,
                    from include/uapi/linux/sem.h:5,
                    from include/linux/sem.h:5,
                    from include/linux/compat.h:14,
                    from arch/powerpc/kernel/asm-offsets.c:14:
   arch/powerpc/include/asm/book3s/64/pgtable-64k.h: In function 'get_hugepd_cache_index':
>> arch/powerpc/include/asm/book3s/64/pgtable-64k.h:60:1: error: no return statement in function returning non-void [-Werror=return-type]
      60 | }
         | ^
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:117: arch/powerpc/kernel/asm-offsets.s] Error 1 shuffle=1921690789
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1206: prepare0] Error 2 shuffle=1921690789
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:185: __sub-make] Error 2 shuffle=1921690789
   make: Target 'prepare' not remade because of errors.


vim +60 arch/powerpc/include/asm/book3s/64/pgtable-64k.h

a9252aaefe7e72 Aneesh Kumar K.V 2016-04-29  53  
fadd03c615922d Aneesh Kumar K.V 2018-06-14  54  /*
fadd03c615922d Aneesh Kumar K.V 2018-06-14  55   * This should never get called
fadd03c615922d Aneesh Kumar K.V 2018-06-14  56   */
fadd03c615922d Aneesh Kumar K.V 2018-06-14  57  static inline int get_hugepd_cache_index(int index)
fadd03c615922d Aneesh Kumar K.V 2018-06-14  58  {
fadd03c615922d Aneesh Kumar K.V 2018-06-14  59  	BUG();
fadd03c615922d Aneesh Kumar K.V 2018-06-14 @60  }
fadd03c615922d Aneesh Kumar K.V 2018-06-14  61  

:::::: The code at line 60 was first introduced by commit
:::::: fadd03c615922d8521a2e76d4ba2335891cb2790 powerpc/mm/hash/4k: Free hugetlb page table caches correctly.

:::::: TO: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
