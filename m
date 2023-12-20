Return-Path: <linux-kernel+bounces-6939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B56819F88
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04E531F23665
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FC125768;
	Wed, 20 Dec 2023 13:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ROEhlwb5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A98925541;
	Wed, 20 Dec 2023 13:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703077793; x=1734613793;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YmJJ/ywwMFUEe1HB9Rdue5kNC/FoUdtA01gR+RQluFc=;
  b=ROEhlwb5eTuAZjxH4rdvGPHnGn75LWdanAjiLgKyFJP6IJdOklo4jYqQ
   egBsDeqNySGktz7k+qGsFVL5h+ALcQMrVU9sgAJDcRdOmXGV8fjkuRSr2
   2M4D+2h0gpOmu0HFa8XI9k1vxAKi9WppCmcQZoccVoqrCYWu2X2ZnUh3t
   6JMpDY1u4xFtPk78FfQ3/R39I36rjQd5H8hSmS3YMd1Sw7pUA5XqOyoek
   9Yte8eyU7/4GWuxRF0C2RbcR9DHaf/pTGxtVuyPY0+S9v5UOFJr6MuMt0
   j1FMQ+WjE+qilYtX58V9d+OuHuYjHo0D1755LV9a0PSxA1ZRsva+pILqd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="375966912"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="375966912"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 05:09:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="10751570"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 20 Dec 2023 05:09:45 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rFwKV-0006tP-0m;
	Wed, 20 Dec 2023 13:09:43 +0000
Date: Wed, 20 Dec 2023 21:09:00 +0800
From: kernel test robot <lkp@intel.com>
To: Alexey Makhalov <alexey.makhalov@broadcom.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
	mingo@redhat.com, tglx@linutronix.de
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	dmitry.torokhov@gmail.com, tzimmermann@suse.de,
	pv-drivers@vmware.com, netdev@vger.kernel.org,
	richardcochran@gmail.com, x86@kernel.org,
	dri-devel@lists.freedesktop.org, horms@kernel.org,
	akaher@vmware.com, timothym@vmware.com,
	linux-graphics-maintainer@vmware.com, mripard@kernel.org,
	jsipek@vmware.com, linux-input@vger.kernel.org, namit@vmware.com,
	kirill.shutemov@linux.intel.com, airlied@gmail.com,
	zackr@vmware.com
Subject: Re: [PATCH v3 6/6] x86/vmware: Add TDX hypercall support
Message-ID: <202312202020.5O1T2aSk-lkp@intel.com>
References: <20231219215751.9445-7-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219215751.9445-7-alexey.makhalov@broadcom.com>

Hi Alexey,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on dtor-input/next dtor-input/for-linus linus/master v6.7-rc6 next-20231220]
[cannot apply to tip/x86/vmware]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexey-Makhalov/x86-vmware-Move-common-macros-to-vmware-h/20231220-060028
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20231219215751.9445-7-alexey.makhalov%40broadcom.com
patch subject: [PATCH v3 6/6] x86/vmware: Add TDX hypercall support
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20231220/202312202020.5O1T2aSk-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231220/202312202020.5O1T2aSk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312202020.5O1T2aSk-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/cpu/vmware.c:439:40: warning: format specifies type 'unsigned int' but the argument has type 'unsigned long' [-Wformat]
                   pr_warn("Out of range command %x\n", cmd);
                                                 ~~     ^~~
                                                 %lx
   include/linux/printk.h:508:37: note: expanded from macro 'pr_warn'
           printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
                                      ~~~     ^~~~~~~~~~~
   include/linux/printk.h:455:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:427:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   1 warning generated.


vim +439 arch/x86/kernel/cpu/vmware.c

   430	
   431	#ifdef CONFIG_INTEL_TDX_GUEST
   432	unsigned long vmware_tdx_hypercall(unsigned long cmd,
   433					   struct tdx_module_args *args)
   434	{
   435		if (!hypervisor_is_type(X86_HYPER_VMWARE))
   436			return 0;
   437	
   438		if (cmd & ~VMWARE_CMD_MASK) {
 > 439			pr_warn("Out of range command %x\n", cmd);
   440			return 0;
   441		}
   442	
   443		args->r10 = VMWARE_TDX_VENDOR_LEAF;
   444		args->r11 = VMWARE_TDX_HCALL_FUNC;
   445		args->r12 = VMWARE_HYPERVISOR_MAGIC;
   446		args->r13 = cmd;
   447	
   448		__tdx_hypercall(args);
   449	
   450		return args->r12;
   451	}
   452	EXPORT_SYMBOL_GPL(vmware_tdx_hypercall);
   453	#endif
   454	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

