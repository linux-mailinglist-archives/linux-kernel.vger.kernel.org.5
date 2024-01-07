Return-Path: <linux-kernel+bounces-18919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFB782651D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 17:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBE631C2158A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 16:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0548134C4;
	Sun,  7 Jan 2024 16:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UVqpfz47"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BDC13AE6
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704645094; x=1736181094;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oNMzL668MgSACBaTvRfKi5Y6xEU5aNxKtjNOaM4E8Os=;
  b=UVqpfz47fUY3M3E3Xd5mpYcJAT/wO6+p6otRrEu6frbKD35/QDPLiP8a
   3icx5cNDvvRTgTYlg7zWnzBqdF0e/EeQhoypqiXRbzh60imHWU8i2eyCQ
   /Yd34wAY1CWMDiSEIOaODnXhVhI/bOR7eQ9w97NqJD6oNeuMvJ+Xl2O1p
   NBVIrxfyDRxfaYN1TehutnqFi4QYDspYg3Emdaia1VLUDUzf8cCAc6vZf
   1+9bZnVb5hxHB3jk+j7pJYLEWfcGtpGJdL2bza3oI2Zc1VmASFdXvFVZK
   1V67E5RmpVXAOgWfbPjpxwG5mYqJ41rSd+MrR3wXzWX1OUN83cjfWQaky
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="464140700"
X-IronPort-AV: E=Sophos;i="6.04,339,1695711600"; 
   d="scan'208";a="464140700"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2024 08:31:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="1028190538"
X-IronPort-AV: E=Sophos;i="6.04,339,1695711600"; 
   d="scan'208";a="1028190538"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 07 Jan 2024 08:31:31 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMW3d-0003wE-27;
	Sun, 07 Jan 2024 16:31:29 +0000
Date: Mon, 8 Jan 2024 00:31:22 +0800
From: kernel test robot <lkp@intel.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Yu-cheng Yu <yu-cheng.yu@intel.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Kees Cook <keescook@chromium.org>
Subject: arch/x86/kernel/shstk.c:295:55: sparse: sparse: cast removes address
 space '__user' of expression
Message-ID: <202401080003.duO4RmjK-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   52b1853b080a082ec3749c3a9577f6c71b1d4a90
commit: 05e36022c0543ba55a3de55af455b00cb3eb4fcc x86/shstk: Handle signals for shadow stack
date:   5 months ago
config: x86_64-randconfig-123-20240106 (https://download.01.org/0day-ci/archive/20240108/202401080003.duO4RmjK-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240108/202401080003.duO4RmjK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401080003.duO4RmjK-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   arch/x86/kernel/shstk.c:244:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [noderef] [usertype] __user *addr @@     got void *[noderef] __user @@
   arch/x86/kernel/shstk.c:244:29: sparse:     expected unsigned long long [noderef] [usertype] __user *addr
   arch/x86/kernel/shstk.c:244:29: sparse:     got void *[noderef] __user
>> arch/x86/kernel/shstk.c:295:55: sparse: sparse: cast removes address space '__user' of expression

vim +/__user +295 arch/x86/kernel/shstk.c

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

