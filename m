Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2B97618BB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 14:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjGYMsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 08:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjGYMsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 08:48:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA0319BD
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 05:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690289289; x=1721825289;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CtaLAo17SyqSmF25npVDsvpSdoJ2LEGMP9QqEPffeXI=;
  b=JTAuRyb1ZG+vdySNSQRgA3+YmS4zLrZ0e9JPLdLTPH8ha2Q/lokJ4VKo
   eWSxXDzqyhjStzxvUpqNW4lzMhaD2nwTO5ON+f+wRFQecLBR3GlstLD93
   8xIG1aUQQsfhRDFNlfTB12hDBdMvJioUbbr76xEoEsIHeIP93Sh156mhl
   cHhwavEhp79tkq1084jHyi6kLd+1JiopkpM/fQL+sXYdPAx5zMDFdgLIY
   CiBVONQSzt7gp2BaOCS6A7POI/rOIXbxU9VzkAYil3IXIiynPq7Ofkvpo
   6N4kDmijdyQqohvSofRrvWj5VLvcTqawdjj2FjgF7EC/QAPhwUsJZKhSn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="366590767"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="366590767"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 05:48:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="703264756"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="703264756"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 25 Jul 2023 05:48:07 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOHSQ-000AcG-2m;
        Tue, 25 Jul 2023 12:48:06 +0000
Date:   Tue, 25 Jul 2023 20:47:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: arch/powerpc/mm/book3s64/pgtable.c:422:6: error: no previous
 prototype for 'arch_report_meminfo'
Message-ID: <202307252035.aAJZfroP-lkp@intel.com>
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
head:   0b5547c51827e053cc754db47d3ec3e6c2c451d2
commit: ef104443bffa004f631729dfc924f0b84abbd602 procfs: consolidate arch_report_meminfo declaration
date:   10 weeks ago
config: powerpc-maple_defconfig (https://download.01.org/0day-ci/archive/20230725/202307252035.aAJZfroP-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230725/202307252035.aAJZfroP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307252035.aAJZfroP-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/powerpc/mm/book3s64/pgtable.c:422:6: error: no previous prototype for 'arch_report_meminfo' [-Werror=missing-prototypes]
     422 | void arch_report_meminfo(struct seq_file *m)
         |      ^~~~~~~~~~~~~~~~~~~
   arch/powerpc/mm/book3s64/pgtable.c:478:5: error: no previous prototype for 'pmd_move_must_withdraw' [-Werror=missing-prototypes]
     478 | int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
         |     ^~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/arch_report_meminfo +422 arch/powerpc/mm/book3s64/pgtable.c

a2dc009afa9ae8 arch/powerpc/mm/pgtable-book3s64.c Aneesh Kumar K.V 2018-08-13  421  
a2dc009afa9ae8 arch/powerpc/mm/pgtable-book3s64.c Aneesh Kumar K.V 2018-08-13 @422  void arch_report_meminfo(struct seq_file *m)
a2dc009afa9ae8 arch/powerpc/mm/pgtable-book3s64.c Aneesh Kumar K.V 2018-08-13  423  {
a2dc009afa9ae8 arch/powerpc/mm/pgtable-book3s64.c Aneesh Kumar K.V 2018-08-13  424  	/*
a2dc009afa9ae8 arch/powerpc/mm/pgtable-book3s64.c Aneesh Kumar K.V 2018-08-13  425  	 * Hash maps the memory with one size mmu_linear_psize.
a2dc009afa9ae8 arch/powerpc/mm/pgtable-book3s64.c Aneesh Kumar K.V 2018-08-13  426  	 * So don't bother to print these on hash
a2dc009afa9ae8 arch/powerpc/mm/pgtable-book3s64.c Aneesh Kumar K.V 2018-08-13  427  	 */
a2dc009afa9ae8 arch/powerpc/mm/pgtable-book3s64.c Aneesh Kumar K.V 2018-08-13  428  	if (!radix_enabled())
a2dc009afa9ae8 arch/powerpc/mm/pgtable-book3s64.c Aneesh Kumar K.V 2018-08-13  429  		return;
a2dc009afa9ae8 arch/powerpc/mm/pgtable-book3s64.c Aneesh Kumar K.V 2018-08-13  430  	seq_printf(m, "DirectMap4k:    %8lu kB\n",
a2dc009afa9ae8 arch/powerpc/mm/pgtable-book3s64.c Aneesh Kumar K.V 2018-08-13  431  		   atomic_long_read(&direct_pages_count[MMU_PAGE_4K]) << 2);
a2dc009afa9ae8 arch/powerpc/mm/pgtable-book3s64.c Aneesh Kumar K.V 2018-08-13  432  	seq_printf(m, "DirectMap64k:    %8lu kB\n",
a2dc009afa9ae8 arch/powerpc/mm/pgtable-book3s64.c Aneesh Kumar K.V 2018-08-13  433  		   atomic_long_read(&direct_pages_count[MMU_PAGE_64K]) << 6);
a2dc009afa9ae8 arch/powerpc/mm/pgtable-book3s64.c Aneesh Kumar K.V 2018-08-13  434  	seq_printf(m, "DirectMap2M:    %8lu kB\n",
a2dc009afa9ae8 arch/powerpc/mm/pgtable-book3s64.c Aneesh Kumar K.V 2018-08-13  435  		   atomic_long_read(&direct_pages_count[MMU_PAGE_2M]) << 11);
a2dc009afa9ae8 arch/powerpc/mm/pgtable-book3s64.c Aneesh Kumar K.V 2018-08-13  436  	seq_printf(m, "DirectMap1G:    %8lu kB\n",
a2dc009afa9ae8 arch/powerpc/mm/pgtable-book3s64.c Aneesh Kumar K.V 2018-08-13  437  		   atomic_long_read(&direct_pages_count[MMU_PAGE_1G]) << 20);
a2dc009afa9ae8 arch/powerpc/mm/pgtable-book3s64.c Aneesh Kumar K.V 2018-08-13  438  }
a2dc009afa9ae8 arch/powerpc/mm/pgtable-book3s64.c Aneesh Kumar K.V 2018-08-13  439  #endif /* CONFIG_PROC_FS */
579b9239c1f386 arch/powerpc/mm/pgtable-book3s64.c Aneesh Kumar K.V 2019-01-23  440  

:::::: The code at line 422 was first introduced by commit
:::::: a2dc009afa9ae8b92305be7728676562a104cb40 powerpc/mm/book3s/radix: Add mapping statistics

:::::: TO: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
