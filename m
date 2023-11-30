Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B6A7FED70
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 12:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345072AbjK3LAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 06:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345046AbjK3LAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 06:00:46 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF27F10D0;
        Thu, 30 Nov 2023 03:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701342053; x=1732878053;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5Es/sP+Z8lTumroAf9xSnE7FpQCQXhOFzPMrUUJAEDA=;
  b=jEuK9Y3QzFKrzlzaR5xCJcUG3sihH2hr6oj3+Bq8LPFLTdhAFcNQT+tJ
   +dIDeU3IMTvFZ+Glx0Da6wi7mXXiqcfRsG/KwAZzY0MifSOxuMcNClxlD
   lHXRGsz+HVCTjh6QEvI73mQGnpNK0M3mG6aoKxYLAKWVqzq99iyNy/oWf
   cFbj1JV8PfMf9Jq/ugOk+dYyByIJJL0ajJHU75CygnhuuyZKp9ObF/YAN
   vqE8mOHPwKCwTyuyQs9yYZp2YNiVuYE9zVrLGYMApxTlWHyaXLRLqpOce
   4rmqvav1uH8yuwsFerVKufzQsrInDXvmM8LOkHxrPQslndWY/P+LKsqqy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="207308"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="207308"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 03:00:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="17352575"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 30 Nov 2023 03:00:50 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r8emm-0001jU-1c;
        Thu, 30 Nov 2023 11:00:48 +0000
Date:   Thu, 30 Nov 2023 19:00:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wujie Duan <wjduan@linx-info.com>, tsbogend@alpha.franken.de
Cc:     oe-kbuild-all@lists.linux.dev, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wujie Duan <wjduan@linx-info.com>
Subject: Re: [PATCH] Mark symbols static where possible for mips/kernel
Message-ID: <202311301824.pu39T7C9-lkp@intel.com>
References: <20231128071225.801111-1-wjduan@linx-info.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128071225.801111-1-wjduan@linx-info.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wujie,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.7-rc3 next-20231130]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wujie-Duan/Mark-symbols-static-where-possible-for-mips-kernel/20231128-152256
base:   linus/master
patch link:    https://lore.kernel.org/r/20231128071225.801111-1-wjduan%40linx-info.com
patch subject: [PATCH] Mark symbols static where possible for mips/kernel
config: mips-cavium_octeon_defconfig (https://download.01.org/0day-ci/archive/20231130/202311301824.pu39T7C9-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231130/202311301824.pu39T7C9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311301824.pu39T7C9-lkp@intel.com/

All errors (new ones prefixed by >>):

   mips64-linux-ld: arch/mips/kernel/signal_n32.o: in function `setup_rt_frame_n32':
>> arch/mips/kernel/signal_n32.c:109:(.text+0xb8): undefined reference to `setup_sigcontext'


vim +109 arch/mips/kernel/signal_n32.c

^1da177e4c3f41 Linus Torvalds     2005-04-16   91  
81d103bf806786 Richard Weinberger 2013-10-06   92  static int setup_rt_frame_n32(void *sig_return, struct ksignal *ksig,
81d103bf806786 Richard Weinberger 2013-10-06   93  			      struct pt_regs *regs, sigset_t *set)
^1da177e4c3f41 Linus Torvalds     2005-04-16   94  {
9bbf28a36cae08 Atsushi Nemoto     2006-02-01   95  	struct rt_sigframe_n32 __user *frame;
^1da177e4c3f41 Linus Torvalds     2005-04-16   96  	int err = 0;
^1da177e4c3f41 Linus Torvalds     2005-04-16   97  
7c4f563507c33c Richard Weinberger 2014-03-05   98  	frame = get_sigframe(ksig, regs, sizeof(*frame));
96d4f267e40f95 Linus Torvalds     2019-01-03   99  	if (!access_ok(frame, sizeof (*frame)))
81d103bf806786 Richard Weinberger 2013-10-06  100  		return -EFAULT;
^1da177e4c3f41 Linus Torvalds     2005-04-16  101  
^1da177e4c3f41 Linus Torvalds     2005-04-16  102  	/* Create siginfo.  */
81d103bf806786 Richard Weinberger 2013-10-06  103  	err |= copy_siginfo_to_user32(&frame->rs_info, &ksig->info);
^1da177e4c3f41 Linus Torvalds     2005-04-16  104  
^1da177e4c3f41 Linus Torvalds     2005-04-16  105  	/* Create the ucontext.	 */
^1da177e4c3f41 Linus Torvalds     2005-04-16  106  	err |= __put_user(0, &frame->rs_uc.uc_flags);
^1da177e4c3f41 Linus Torvalds     2005-04-16  107  	err |= __put_user(0, &frame->rs_uc.uc_link);
ea536ad4f231a0 Al Viro            2012-12-23  108  	err |= __compat_save_altstack(&frame->rs_uc.uc_stack, regs->regs[29]);
^1da177e4c3f41 Linus Torvalds     2005-04-16 @109  	err |= setup_sigcontext(regs, &frame->rs_uc.uc_mcontext);
431dc8040354db Ralf Baechle       2007-02-13  110  	err |= __copy_conv_sigset_to_user(&frame->rs_uc.uc_sigmask, set);
^1da177e4c3f41 Linus Torvalds     2005-04-16  111  
^1da177e4c3f41 Linus Torvalds     2005-04-16  112  	if (err)
81d103bf806786 Richard Weinberger 2013-10-06  113  		return -EFAULT;
^1da177e4c3f41 Linus Torvalds     2005-04-16  114  
^1da177e4c3f41 Linus Torvalds     2005-04-16  115  	/*
^1da177e4c3f41 Linus Torvalds     2005-04-16  116  	 * Arguments to signal handler:
^1da177e4c3f41 Linus Torvalds     2005-04-16  117  	 *
^1da177e4c3f41 Linus Torvalds     2005-04-16  118  	 *   a0 = signal number
^1da177e4c3f41 Linus Torvalds     2005-04-16  119  	 *   a1 = 0 (should be cause)
^1da177e4c3f41 Linus Torvalds     2005-04-16  120  	 *   a2 = pointer to ucontext
^1da177e4c3f41 Linus Torvalds     2005-04-16  121  	 *
^1da177e4c3f41 Linus Torvalds     2005-04-16  122  	 * $25 and c0_epc point to the signal handler, $29 points to
^1da177e4c3f41 Linus Torvalds     2005-04-16  123  	 * the struct rt_sigframe.
^1da177e4c3f41 Linus Torvalds     2005-04-16  124  	 */
81d103bf806786 Richard Weinberger 2013-10-06  125  	regs->regs[ 4] = ksig->sig;
^1da177e4c3f41 Linus Torvalds     2005-04-16  126  	regs->regs[ 5] = (unsigned long) &frame->rs_info;
^1da177e4c3f41 Linus Torvalds     2005-04-16  127  	regs->regs[ 6] = (unsigned long) &frame->rs_uc;
^1da177e4c3f41 Linus Torvalds     2005-04-16  128  	regs->regs[29] = (unsigned long) frame;
d814c28ceca8f6 David Daney        2010-02-18  129  	regs->regs[31] = (unsigned long) sig_return;
81d103bf806786 Richard Weinberger 2013-10-06  130  	regs->cp0_epc = regs->regs[25] = (unsigned long) ksig->ka.sa.sa_handler;
^1da177e4c3f41 Linus Torvalds     2005-04-16  131  
722bb63de630f9 Franck Bui-Huu     2007-02-05  132  	DEBUGP("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%lx\n",
^1da177e4c3f41 Linus Torvalds     2005-04-16  133  	       current->comm, current->pid,
^1da177e4c3f41 Linus Torvalds     2005-04-16  134  	       frame, regs->cp0_epc, regs->regs[31]);
722bb63de630f9 Franck Bui-Huu     2007-02-05  135  
7b3e2fc847c832 Ralf Baechle       2006-02-08  136  	return 0;
^1da177e4c3f41 Linus Torvalds     2005-04-16  137  }
151fd6acd94e12 Ralf Baechle       2007-02-15  138  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
