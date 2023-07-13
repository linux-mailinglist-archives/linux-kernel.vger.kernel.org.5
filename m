Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA7E751C23
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbjGMItX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234547AbjGMItA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:49:00 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4052705
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689238129; x=1720774129;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0Vq2BNtu198ujMLredNYKnBTUadZbPG+CthtUYOiZgk=;
  b=jJr4G+AX2QrgLfn8kSUonei+WUqx2Vd8twAhAnCvYEIMXCr4WzD45GKw
   JqwJpg5oUIRXSS9PHwCHcP/eH5UTiEAYW532KlTySaqqBKd6NfbkD1Xmj
   6wz5vaoUzHMMxZX2CRabY1C8qUZJLOobG+vtzGVZ93JHNC16DbcR8WCyM
   /kGUlR210zsBI4hBZMzbStZI3xBVkRWdXQkYatctqj8+Y4Hgpmkmy4sW7
   fMhtUJYPm/UEmuFq7c+YJfwPm+Acfr5yS+5yFwxs8RvopHivlqHrKnRR6
   c3nLXTGca30lT4xBvOPHuMVgwa+Fl4tY6FdHnmUZcFz6epEK3tDGDZ5CZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="451494350"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="451494350"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 01:48:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="968531032"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="968531032"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 13 Jul 2023 01:48:47 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qJs0E-0006RZ-0o;
        Thu, 13 Jul 2023 08:48:46 +0000
Date:   Thu, 13 Jul 2023 16:47:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>
Subject: [tip:x86/shstk 31/42] arch/x86/kernel/shstk.c:244:29: sparse:
 sparse: incorrect type in argument 1 (different address spaces)
Message-ID: <202307131601.a3YybdUr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/shstk
head:   727f2a6ea02467c331f86ec5fde8e70dab418baa
commit: 6bf19cec9a198b8f6af939b5f7bd5d3e721c9e7e [31/42] x86/shstk: Handle signals for shadow stack
config: x86_64-randconfig-x061-20230713 (https://download.01.org/0day-ci/archive/20230713/202307131601.a3YybdUr-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230713/202307131601.a3YybdUr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307131601.a3YybdUr-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/x86/kernel/shstk.c:244:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [noderef] [usertype] __user *addr @@     got void *[noderef] __user @@
   arch/x86/kernel/shstk.c:244:29: sparse:     expected unsigned long long [noderef] [usertype] __user *addr
   arch/x86/kernel/shstk.c:244:29: sparse:     got void *[noderef] __user
>> arch/x86/kernel/shstk.c:295:55: sparse: sparse: cast removes address space '__user' of expression

vim +244 arch/x86/kernel/shstk.c

   234	
   235	static int shstk_push_sigframe(unsigned long *ssp)
   236	{
   237		unsigned long target_ssp = *ssp;
   238	
   239		/* Token must be aligned */
   240		if (!IS_ALIGNED(target_ssp, 8))
   241			return -EINVAL;
   242	
   243		*ssp -= SS_FRAME_SIZE;
 > 244		if (put_shstk_data((void *__user)*ssp, target_ssp))
   245			return -EFAULT;
   246	
   247		return 0;
   248	}
   249	
   250	static int shstk_pop_sigframe(unsigned long *ssp)
   251	{
   252		unsigned long token_addr;
   253		int err;
   254	
   255		err = get_shstk_data(&token_addr, (unsigned long __user *)*ssp);
   256		if (unlikely(err))
   257			return err;
   258	
   259		/* Restore SSP aligned? */
   260		if (unlikely(!IS_ALIGNED(token_addr, 8)))
   261			return -EINVAL;
   262	
   263		/* SSP in userspace? */
   264		if (unlikely(token_addr >= TASK_SIZE_MAX))
   265			return -EINVAL;
   266	
   267		*ssp = token_addr;
   268	
   269		return 0;
   270	}
   271	
   272	int setup_signal_shadow_stack(struct ksignal *ksig)
   273	{
   274		void __user *restorer = ksig->ka.sa.sa_restorer;
   275		unsigned long ssp;
   276		int err;
   277	
   278		if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK) ||
   279		    !features_enabled(ARCH_SHSTK_SHSTK))
   280			return 0;
   281	
   282		if (!restorer)
   283			return -EINVAL;
   284	
   285		ssp = get_user_shstk_addr();
   286		if (unlikely(!ssp))
   287			return -EINVAL;
   288	
   289		err = shstk_push_sigframe(&ssp);
   290		if (unlikely(err))
   291			return err;
   292	
   293		/* Push restorer address */
   294		ssp -= SS_FRAME_SIZE;
 > 295		err = write_user_shstk_64((u64 __user *)ssp, (u64)restorer);
   296		if (unlikely(err))
   297			return -EFAULT;
   298	
   299		fpregs_lock_and_load();
   300		wrmsrl(MSR_IA32_PL3_SSP, ssp);
   301		fpregs_unlock();
   302	
   303		return 0;
   304	}
   305	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
