Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C557622C5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 21:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjGYT6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 15:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjGYT6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 15:58:18 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF88128
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 12:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690315097; x=1721851097;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2P3XGUMV1NtRncQpKb7KyFd8Aka7g+NPhuuBjng82a0=;
  b=QxJMmfbs5N4kzaKQBnRGckgyT2/PDl/PyF4vXVNd7x1JbEMZ0cIIQpm1
   AHEhw+lszKQ82R8AvvaIjdyk6Sek+4u22iG/NDhanpc3vj33xLNy3sFoF
   B+XFFvt0HMrRXecvjxWvcwKBCBUCQ4fs6/qMjnXrB2om0Ch7XTry8kEC+
   668Lvl6EqpvTZgcnCWS+61HhvmFfuSRug2w/gSlrCYzb2Lvw0haQwkL6T
   /ZP8Ageybvbi50M3SWPcS1YpxEjEqiedewkaN14rOuXqqf15V4dRSt8ie
   nca7rlb1gfQTdguJ2XXr1IFk2K6IuT5qo3/Pv/ezFam4nGSsUXWrE85Tj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="348105884"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="348105884"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 12:58:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="726211034"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="726211034"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 25 Jul 2023 12:58:15 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOOAg-0000Ip-2F;
        Tue, 25 Jul 2023 19:58:14 +0000
Date:   Wed, 26 Jul 2023 03:57:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: arch/x86/kernel/paravirt.c:337:4: warning: cast from 'void
 (*)(struct mmu_gather *, struct page *)' to 'void (*)(struct mmu_gather *,
 void *)' converts to incompatible function type
Message-ID: <202307260332.pJntWR6o-lkp@intel.com>
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
head:   af2e19389c2c1d8a299e04c5105b180ef0c5b5b5
commit: 552a23a0e5d0a84cecd4687043d8030673981d30 Makefile: Enable -Wcast-function-type
date:   1 year, 8 months ago
config: x86_64-randconfig-r003-20230725 (https://download.01.org/0day-ci/archive/20230726/202307260332.pJntWR6o-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230726/202307260332.pJntWR6o-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307260332.pJntWR6o-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/x86/kernel/paravirt.c:107:13: warning: no previous prototype for function 'native_pv_lock_init' [-Wmissing-prototypes]
   void __init native_pv_lock_init(void)
               ^
   arch/x86/kernel/paravirt.c:107:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init native_pv_lock_init(void)
   ^
   static 
>> arch/x86/kernel/paravirt.c:337:4: warning: cast from 'void (*)(struct mmu_gather *, struct page *)' to 'void (*)(struct mmu_gather *, void *)' converts to incompatible function type [-Wcast-function-type-strict]
                           (void (*)(struct mmu_gather *, void *))tlb_remove_page,
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   2 warnings generated.


vim +337 arch/x86/kernel/paravirt.c

5c83511bdb9832 Juergen Gross   2018-08-28  330  
5c83511bdb9832 Juergen Gross   2018-08-28  331  	/* Mmu ops. */
2faf153bb7346b Thomas Gleixner 2020-04-21  332  	.mmu.flush_tlb_user	= native_flush_tlb_local,
5c83511bdb9832 Juergen Gross   2018-08-28  333  	.mmu.flush_tlb_kernel	= native_flush_tlb_global,
5c83511bdb9832 Juergen Gross   2018-08-28  334  	.mmu.flush_tlb_one_user	= native_flush_tlb_one_user,
4ce94eabac16b1 Nadav Amit      2021-02-20  335  	.mmu.flush_tlb_multi	= native_flush_tlb_multi,
5c83511bdb9832 Juergen Gross   2018-08-28  336  	.mmu.tlb_remove_table	=
5c83511bdb9832 Juergen Gross   2018-08-28 @337  			(void (*)(struct mmu_gather *, void *))tlb_remove_page,
5c83511bdb9832 Juergen Gross   2018-08-28  338  
fdc0269e8958a1 Juergen Gross   2018-08-28  339  	.mmu.exit_mmap		= paravirt_nop,
064ce6c550a063 Brijesh Singh   2021-08-24  340  	.mmu.notify_page_enc_status_changed	= paravirt_nop,
fdc0269e8958a1 Juergen Gross   2018-08-28  341  

:::::: The code at line 337 was first introduced by commit
:::::: 5c83511bdb9832c86be20fb86b783356e2f58062 x86/paravirt: Use a single ops structure

:::::: TO: Juergen Gross <jgross@suse.com>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
