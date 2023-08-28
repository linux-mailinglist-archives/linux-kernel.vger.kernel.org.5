Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C12678B4E4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjH1P5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbjH1P4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:56:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94443A9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693238208; x=1724774208;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QW3BkRYyDL/GETloI3TLUeyLY4P+wUl5KVJsBAzKuDg=;
  b=cCvHOqd0rXMy5OycH2dyemSFIzzire6yloyzjBmGn2BYqp+oj/R1rOXj
   mBKREF1UPXVtqsu7b2H/JM64XmUCv0Q8LYmmzRCP7mkN8GqVw6Eg02Ce2
   JM8X8X25zUugHz1WcIMreCwBc+Oc++bSbEhFiSGgudf9HdU06GZhV8n22
   tXWw9lBfjh8kxJXGTBt6zaINUwH5fUASNHzFx42+BQvhf/ZHyMzo6CYjq
   88uzY/pN6OCZt6XNC0Tcz75r4aveqDjQncdy35EDfhFCso8odjbvOCvMe
   3A7D7aQx46WaiD4lfQCrVCioCQwtm4wZYOEJvosReElxgu3xEgL5VFGaz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="365340074"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="365340074"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 08:56:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="881977407"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 28 Aug 2023 08:56:51 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qaebd-0007zr-0U;
        Mon, 28 Aug 2023 15:56:45 +0000
Date:   Mon, 28 Aug 2023 23:56:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: arch/x86/include/asm/pgtable_32.h:68:5: warning: 'PTRS_PER_PMD' is
 not defined, evaluates to 0
Message-ID: <202308282335.fH9YoGYl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2dde18cd1d8fac735875f2e4987f11817cc0bc2c
commit: 80b6093b55e31c2c40ff082fb32523d4e852954f kbuild: add -Wundef to KBUILD_CPPFLAGS for W=1 builds
date:   9 months ago
config: i386-allnoconfig (https://download.01.org/0day-ci/archive/20230828/202308282335.fH9YoGYl-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230828/202308282335.fH9YoGYl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308282335.fH9YoGYl-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/x86/kernel/head_32.S:29:
>> arch/x86/include/asm/pgtable_32.h:68:5: warning: 'PTRS_PER_PMD' is not defined, evaluates to 0 [-Wundef]
   #if PTRS_PER_PMD > 1
       ^
   1 warning generated.


vim +/PTRS_PER_PMD +68 arch/x86/include/asm/pgtable_32.h

^1da177e4c3f41 include/asm-i386/pgtable.h        Linus Torvalds  2005-04-16  58  
1e620f9b23e598 arch/x86/include/asm/pgtable_32.h Boris Ostrovsky 2016-12-08  59  /*
ea3186b9572a1b arch/x86/include/asm/pgtable_32.h Arvind Sankar   2020-10-29  60   * This is used to calculate the .brk reservation for initial pagetables.
ea3186b9572a1b arch/x86/include/asm/pgtable_32.h Arvind Sankar   2020-10-29  61   * Enough space is reserved to allocate pagetables sufficient to cover all
ea3186b9572a1b arch/x86/include/asm/pgtable_32.h Arvind Sankar   2020-10-29  62   * of LOWMEM_PAGES, which is an upper bound on the size of the direct map of
ea3186b9572a1b arch/x86/include/asm/pgtable_32.h Arvind Sankar   2020-10-29  63   * lowmem.
1e620f9b23e598 arch/x86/include/asm/pgtable_32.h Boris Ostrovsky 2016-12-08  64   *
ea3186b9572a1b arch/x86/include/asm/pgtable_32.h Arvind Sankar   2020-10-29  65   * With PAE paging (PTRS_PER_PMD > 1), we allocate PTRS_PER_PGD == 4 pages for
ea3186b9572a1b arch/x86/include/asm/pgtable_32.h Arvind Sankar   2020-10-29  66   * the PMD's in addition to the pages required for the last level pagetables.
1e620f9b23e598 arch/x86/include/asm/pgtable_32.h Boris Ostrovsky 2016-12-08  67   */
1e620f9b23e598 arch/x86/include/asm/pgtable_32.h Boris Ostrovsky 2016-12-08 @68  #if PTRS_PER_PMD > 1
1e620f9b23e598 arch/x86/include/asm/pgtable_32.h Boris Ostrovsky 2016-12-08  69  #define PAGE_TABLE_SIZE(pages) (((pages) / PTRS_PER_PMD) + PTRS_PER_PGD)
1e620f9b23e598 arch/x86/include/asm/pgtable_32.h Boris Ostrovsky 2016-12-08  70  #else
1e620f9b23e598 arch/x86/include/asm/pgtable_32.h Boris Ostrovsky 2016-12-08  71  #define PAGE_TABLE_SIZE(pages) ((pages) / PTRS_PER_PGD)
1e620f9b23e598 arch/x86/include/asm/pgtable_32.h Boris Ostrovsky 2016-12-08  72  #endif
1e620f9b23e598 arch/x86/include/asm/pgtable_32.h Boris Ostrovsky 2016-12-08  73  

:::::: The code at line 68 was first introduced by commit
:::::: 1e620f9b23e598ab936ece12233e98e97930b692 x86/boot/32: Convert the 32-bit pgtable setup code from assembly to C

:::::: TO: Boris Ostrovsky <boris.ostrovsky@oracle.com>
:::::: CC: Ingo Molnar <mingo@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
