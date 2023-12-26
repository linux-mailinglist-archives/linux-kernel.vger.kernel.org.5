Return-Path: <linux-kernel+bounces-11591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF92F81E8A7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 18:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68D7D28284E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 17:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3404E4F897;
	Tue, 26 Dec 2023 17:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V1L8cCFv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4A34F885
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 17:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703610842; x=1735146842;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ltBBpaQ6/D3R3CSyabnBf+3+RsQgWDr8d72X9RThQb0=;
  b=V1L8cCFvgaBMW+9dv6CiMWvDcEXfvvDxzlVxv2ggo7zGR8nAzSRo9Lou
   arPEfmck3GmldmgV3iPmavWAr8JdR4Q4RQ1HhfuJx7WVwa+DMdrES/8bO
   LqDwd5GgeHaU92ad7xdByI8tPIEPg7ceLZFCGLIUrRsrH/qn+Gd01jLHA
   fWsH0ysjo1ZzLi9tP4uQMQsTH92QqTydjkSJ5EMcstEuen09/ZgPwJLSj
   TS8mdWJEM9y1yAd4x20Lm1GkfknmhEPAGr5ytOKNx8Gi3L7jKtcygmuOa
   ZI17mP8Ic2FsZX+s2xqG5jF/4kk5tAE8nWmICKlxft46M2mAqOOCAAeKh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="393519810"
X-IronPort-AV: E=Sophos;i="6.04,306,1695711600"; 
   d="scan'208";a="393519810"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 09:14:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="951277016"
X-IronPort-AV: E=Sophos;i="6.04,306,1695711600"; 
   d="scan'208";a="951277016"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 26 Dec 2023 09:14:00 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rIB09-000EgH-2R;
	Tue, 26 Dec 2023 17:13:57 +0000
Date: Wed, 27 Dec 2023 01:13:41 +0800
From: kernel test robot <lkp@intel.com>
To: Youling Tang <youling.tang@outlook.com>, Baoquan He <bhe@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, Huacai Chen <chenhuacai@loongson.cn>,
	linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH] kdump: Remove redundant DEFAULT_CRASH_KERNEL_LOW_SIZE
Message-ID: <202312270133.8w4Wrh4h-lkp@intel.com>
References: <MW4PR84MB3145D3EB871BBD59AA71C0FC8198A@MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW4PR84MB3145D3EB871BBD59AA71C0FC8198A@MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM>

Hi Youling,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.7-rc7 next-20231222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Youling-Tang/kdump-Remove-redundant-DEFAULT_CRASH_KERNEL_LOW_SIZE/20231226-193215
base:   linus/master
patch link:    https://lore.kernel.org/r/MW4PR84MB3145D3EB871BBD59AA71C0FC8198A%40MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM
patch subject: [PATCH] kdump: Remove redundant DEFAULT_CRASH_KERNEL_LOW_SIZE
config: i386-buildonly-randconfig-002-20231226 (https://download.01.org/0day-ci/archive/20231227/202312270133.8w4Wrh4h-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231227/202312270133.8w4Wrh4h-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312270133.8w4Wrh4h-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/x86/kernel/setup.c: In function 'arch_reserve_crashkernel':
>> arch/x86/kernel/setup.c:479:8: error: implicit declaration of function 'parse_crashkernel' [-Werror=implicit-function-declaration]
     479 |  ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
         |        ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/parse_crashkernel +479 arch/x86/kernel/setup.c

a0a0becd2da0ba Yinghai Lu     2008-07-03  468  
9c08a2a139fe83 Baoquan He     2023-09-14  469  static void __init arch_reserve_crashkernel(void)
ccb4defa71744f Yinghai Lu     2008-06-25  470  {
9c08a2a139fe83 Baoquan He     2023-09-14  471  	unsigned long long crash_base, crash_size, low_size = 0;
9c08a2a139fe83 Baoquan He     2023-09-14  472  	char *cmdline = boot_command_line;
55a20ee7804ab6 Yinghai Lu     2013-04-15  473  	bool high = false;
ccb4defa71744f Yinghai Lu     2008-06-25  474  	int ret;
ccb4defa71744f Yinghai Lu     2008-06-25  475  
4ece09be9913a8 Jisheng Zhang  2022-03-23  476  	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
4ece09be9913a8 Jisheng Zhang  2022-03-23  477  		return;
4ece09be9913a8 Jisheng Zhang  2022-03-23  478  
9c08a2a139fe83 Baoquan He     2023-09-14 @479  	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
9c08a2a139fe83 Baoquan He     2023-09-14  480  				&crash_size, &crash_base,
9c08a2a139fe83 Baoquan He     2023-09-14  481  				&low_size, &high);
9c08a2a139fe83 Baoquan He     2023-09-14  482  	if (ret)
32105f7fd8faa7 Bernhard Walle 2008-06-26  483  		return;
32105f7fd8faa7 Bernhard Walle 2008-06-26  484  
3db3eb285259ac Petr Tesarik   2018-04-25  485  	if (xen_pv_domain()) {
3db3eb285259ac Petr Tesarik   2018-04-25  486  		pr_info("Ignoring crashkernel for a Xen PV domain\n");
3db3eb285259ac Petr Tesarik   2018-04-25  487  		return;
3db3eb285259ac Petr Tesarik   2018-04-25  488  	}
3db3eb285259ac Petr Tesarik   2018-04-25  489  
9c08a2a139fe83 Baoquan He     2023-09-14  490  	reserve_crashkernel_generic(cmdline, crash_size, crash_base,
9c08a2a139fe83 Baoquan He     2023-09-14  491  				    low_size, high);
ccb4defa71744f Yinghai Lu     2008-06-25  492  }
ccb4defa71744f Yinghai Lu     2008-06-25  493  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

