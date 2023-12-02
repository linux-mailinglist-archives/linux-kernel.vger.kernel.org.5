Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866C48019B5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 02:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjLBBxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 20:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjLBBxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 20:53:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59415128
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 17:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701482010; x=1733018010;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=exKe/fBp+Zn0tvSpDSZhyuSKIDItOZZ5SHM5Ldoau1g=;
  b=YfswgcfiHVlC0hEEQQ5I4j82g88tJ1A/Xd36M27ZA2fRTijG4ztoLMmk
   7c/w4/OD8AGxq3oxfvbgOvj3k0PHaWb3CO2kEieJJsDSsfzRWs54KhLLB
   G8SCiJ+S1FtO4fuo2IyN1oGV0HctH6MCecNL1JID1vf1xN6sdTA9rFdSr
   G/zZOFqaEuIVM7t9jhTYAJax91/PDCXdtBoZufeDLM2WTK72ALkYdGfof
   Gl0L8KO7EW2oKn2lcIwbMmnduYGNZqQwWIVaIKLkaUGfQAWw+7aNCJK1v
   5P7RbwgoqXACiT8AX/oDKj68ZpDribvEPq0QUSu9GgZlJgzTVnjhDLjxe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="591372"
X-IronPort-AV: E=Sophos;i="6.04,243,1695711600"; 
   d="scan'208";a="591372"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 17:53:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="773616519"
X-IronPort-AV: E=Sophos;i="6.04,243,1695711600"; 
   d="scan'208";a="773616519"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 01 Dec 2023 17:53:27 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r9FC9-0004XE-0r;
        Sat, 02 Dec 2023 01:53:25 +0000
Date:   Sat, 2 Dec 2023 09:52:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vineet Gupta <vgupta@synopsys.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org
Subject: arch/arc/kernel/signal.c:77:31: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202312020902.BxAYnWbM-lkp@intel.com>
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
head:   815fb87b753055df2d9e50f6cd80eb10235fe3e9
commit: 96f1b00138cb8f04c742c82d0a7c460b2202e887 ARCv2: save ABI registers across signal handling
date:   2 years, 6 months ago
config: arc-randconfig-r111-20231107 (https://download.01.org/0day-ci/archive/20231202/202312020902.BxAYnWbM-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231202/202312020902.BxAYnWbM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312020902.BxAYnWbM-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/arc/kernel/signal.c:77:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got struct user_regs_arcv2 * @@
   arch/arc/kernel/signal.c:77:31: sparse:     expected void [noderef] __user *to
   arch/arc/kernel/signal.c:77:31: sparse:     got struct user_regs_arcv2 *
>> arch/arc/kernel/signal.c:88:41: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct user_regs_arcv2 * @@
   arch/arc/kernel/signal.c:88:41: sparse:     expected void const [noderef] __user *from
   arch/arc/kernel/signal.c:88:41: sparse:     got struct user_regs_arcv2 *
>> arch/arc/kernel/signal.c:134:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sigcontext *mctx @@     got struct sigcontext [noderef] __user * @@
   arch/arc/kernel/signal.c:134:42: sparse:     expected struct sigcontext *mctx
   arch/arc/kernel/signal.c:134:42: sparse:     got struct sigcontext [noderef] __user *
   arch/arc/kernel/signal.c:153:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sigcontext *mctx @@     got struct sigcontext [noderef] __user * @@
   arch/arc/kernel/signal.c:153:45: sparse:     expected struct sigcontext *mctx
   arch/arc/kernel/signal.c:153:45: sparse:     got struct sigcontext [noderef] __user *

vim +77 arch/arc/kernel/signal.c

    63	
    64	static int save_arcv2_regs(struct sigcontext *mctx, struct pt_regs *regs)
    65	{
    66		int err = 0;
    67	#ifndef CONFIG_ISA_ARCOMPACT
    68		struct user_regs_arcv2 v2abi;
    69	
    70		v2abi.r30 = regs->r30;
    71	#ifdef CONFIG_ARC_HAS_ACCL_REGS
    72		v2abi.r58 = regs->r58;
    73		v2abi.r59 = regs->r59;
    74	#else
    75		v2abi.r58 = v2abi.r59 = 0;
    76	#endif
  > 77		err = __copy_to_user(&mctx->v2abi, &v2abi, sizeof(v2abi));
    78	#endif
    79		return err;
    80	}
    81	
    82	static int restore_arcv2_regs(struct sigcontext *mctx, struct pt_regs *regs)
    83	{
    84		int err = 0;
    85	#ifndef CONFIG_ISA_ARCOMPACT
    86		struct user_regs_arcv2 v2abi;
    87	
  > 88		err = __copy_from_user(&v2abi, &mctx->v2abi, sizeof(v2abi));
    89	
    90		regs->r30 = v2abi.r30;
    91	#ifdef CONFIG_ARC_HAS_ACCL_REGS
    92		regs->r58 = v2abi.r58;
    93		regs->r59 = v2abi.r59;
    94	#endif
    95	#endif
    96		return err;
    97	}
    98	
    99	static int
   100	stash_usr_regs(struct rt_sigframe __user *sf, struct pt_regs *regs,
   101		       sigset_t *set)
   102	{
   103		int err;
   104		struct user_regs_struct uregs;
   105	
   106		uregs.scratch.bta	= regs->bta;
   107		uregs.scratch.lp_start	= regs->lp_start;
   108		uregs.scratch.lp_end	= regs->lp_end;
   109		uregs.scratch.lp_count	= regs->lp_count;
   110		uregs.scratch.status32	= regs->status32;
   111		uregs.scratch.ret	= regs->ret;
   112		uregs.scratch.blink	= regs->blink;
   113		uregs.scratch.fp	= regs->fp;
   114		uregs.scratch.gp	= regs->r26;
   115		uregs.scratch.r12	= regs->r12;
   116		uregs.scratch.r11	= regs->r11;
   117		uregs.scratch.r10	= regs->r10;
   118		uregs.scratch.r9	= regs->r9;
   119		uregs.scratch.r8	= regs->r8;
   120		uregs.scratch.r7	= regs->r7;
   121		uregs.scratch.r6	= regs->r6;
   122		uregs.scratch.r5	= regs->r5;
   123		uregs.scratch.r4	= regs->r4;
   124		uregs.scratch.r3	= regs->r3;
   125		uregs.scratch.r2	= regs->r2;
   126		uregs.scratch.r1	= regs->r1;
   127		uregs.scratch.r0	= regs->r0;
   128		uregs.scratch.sp	= regs->sp;
   129	
   130		err = __copy_to_user(&(sf->uc.uc_mcontext.regs.scratch), &uregs.scratch,
   131				     sizeof(sf->uc.uc_mcontext.regs.scratch));
   132	
   133		if (is_isa_arcv2())
 > 134			err |= save_arcv2_regs(&(sf->uc.uc_mcontext), regs);
   135	
   136		err |= __copy_to_user(&sf->uc.uc_sigmask, set, sizeof(sigset_t));
   137	
   138		return err ? -EFAULT : 0;
   139	}
   140	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
