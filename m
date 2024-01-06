Return-Path: <linux-kernel+bounces-18702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6819B826157
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 20:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03E9A1F221D6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 19:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95DFF50D;
	Sat,  6 Jan 2024 19:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WXypUmHN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED5EE573
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 19:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704570444; x=1736106444;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mnFIl0dvqXooO299Hp/kM9Igogj5TlXsxdN7Rzfe+4w=;
  b=WXypUmHNcXyxe7omDbgfbe8mzC6ZlVI4lV7orJuFadpMXbDZCrrapiLJ
   7v50tVz4aeDj3LMzzn+ytCjXlRHQrBaRtxGNTmaSOQ5o+QIUO+mKrO4y6
   ZDxam63RBDeIN74a3GChe1fGTP5HGtT1Dm0rmvfvD/kQ74YbsK/aQIrB6
   Ws5aNAqamRT3YbCIOzGbyl6UKy3LCHjTgTwK2XlNCnIAGUJxP+hdPqPk+
   34bjPOAVil8Uq8KgGeKNl8uQhHorNUKNvL3VfCHYcmh02Wes+khR+tBGo
   UEWMvb9j7hVEoC1Hr7+Zq90teLJRwvtDbZikrfzl4kf7bxieQhrx7Sqed
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="4769632"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="4769632"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 11:47:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="924502792"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="924502792"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 06 Jan 2024 11:47:21 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMCdb-0002wO-12;
	Sat, 06 Jan 2024 19:47:19 +0000
Date: Sun, 7 Jan 2024 03:47:08 +0800
From: kernel test robot <lkp@intel.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Yu-cheng Yu <yu-cheng.yu@intel.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Kees Cook <keescook@chromium.org>
Subject: arch/x86/kernel/shstk.c:295:55: sparse: sparse: cast removes address
 space '__user' of expression
Message-ID: <202401070321.axBUxYMQ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   95c8a35f1c017327eab3b6a2ff5c04255737c856
commit: 05e36022c0543ba55a3de55af455b00cb3eb4fcc x86/shstk: Handle signals for shadow stack
date:   5 months ago
config: x86_64-randconfig-123-20240106 (https://download.01.org/0day-ci/archive/20240107/202401070321.axBUxYMQ-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240107/202401070321.axBUxYMQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401070321.axBUxYMQ-lkp@intel.com/

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

