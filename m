Return-Path: <linux-kernel+bounces-20518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D48BF828011
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77B39B25E79
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750E2C15B;
	Tue,  9 Jan 2024 08:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vl1zmI9u"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DD022EF7
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 08:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704787594; x=1736323594;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UnZNaEDVHHiNOmPFjrSb/L4xlWoqaMqkjktWc8ch+3Q=;
  b=Vl1zmI9uHqYur2EC0SKRsAiSxRndygkVdlomdpTyBcFBLyp4b9m7Xs7W
   SzN43rmEh5bOa1SB6Uth6JfQnYAwLYgbptMdv/oM45jHxoA42uAKDhAcW
   roF3eggfAM4rT86ZQNqo4lacmNQhmRpjQ6WY2InqXEl9HPKZq+8ekFXNp
   vQdkpeWB0+zWIL09rqAkL9ONoA2zbmFlsEys36fa8c2H1AhMu1Zyex4+P
   ncD2AD66QoT5dilmWiTMfvdlP4UaQ05EBu0ZiT8UX9b20UolMVFsa6x65
   zo7URV0wEH883vfJRIifuLpTad5HvO7y1nmpE7yNvh4kONluxibBI6Y3j
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="4876243"
X-IronPort-AV: E=Sophos;i="6.04,182,1695711600"; 
   d="scan'208";a="4876243"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 00:06:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,182,1695711600"; 
   d="scan'208";a="16194775"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 09 Jan 2024 00:06:31 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rN781-0005b4-1B;
	Tue, 09 Jan 2024 08:06:29 +0000
Date: Tue, 9 Jan 2024 16:05:49 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/x86/kernel/cpu/debugfs.c:11:33: sparse: sparse: incorrect type
 in initializer (different address spaces)
Message-ID: <202401091504.PDAmleJY-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9f8413c4a66f2fb776d3dc3c9ed20bf435eb305e
commit: 48525fd1ea1cfa059a580e77b10ea8790914efa2 x86/cpu: Provide debug interface
date:   3 months ago
config: x86_64-randconfig-123-20240106 (https://download.01.org/0day-ci/archive/20240109/202401091504.PDAmleJY-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240109/202401091504.PDAmleJY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401091504.PDAmleJY-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/x86/kernel/cpu/debugfs.c:11:33: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct cpuinfo_x86 * @@
   arch/x86/kernel/cpu/debugfs.c:11:33: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/x86/kernel/cpu/debugfs.c:11:33: sparse:     got struct cpuinfo_x86 *

vim +11 arch/x86/kernel/cpu/debugfs.c

     7	
     8	static int cpu_debug_show(struct seq_file *m, void *p)
     9	{
    10		unsigned long cpu = (unsigned long)m->private;
  > 11		struct cpuinfo_x86 *c = per_cpu_ptr(&cpu_info, cpu);
    12	
    13		seq_printf(m, "online:              %d\n", cpu_online(cpu));
    14		if (!c->initialized)
    15			return 0;
    16	
    17		seq_printf(m, "initial_apicid:      %x\n", c->topo.initial_apicid);
    18		seq_printf(m, "apicid:              %x\n", c->topo.apicid);
    19		seq_printf(m, "pkg_id:              %u\n", c->topo.pkg_id);
    20		seq_printf(m, "die_id:              %u\n", c->topo.die_id);
    21		seq_printf(m, "cu_id:               %u\n", c->topo.cu_id);
    22		seq_printf(m, "core_id:             %u\n", c->topo.core_id);
    23		seq_printf(m, "logical_pkg_id:      %u\n", c->topo.logical_pkg_id);
    24		seq_printf(m, "logical_die_id:      %u\n", c->topo.logical_die_id);
    25		seq_printf(m, "llc_id:              %u\n", c->topo.llc_id);
    26		seq_printf(m, "l2c_id:              %u\n", c->topo.l2c_id);
    27		seq_printf(m, "max_cores:           %u\n", c->x86_max_cores);
    28		seq_printf(m, "max_die_per_pkg:     %u\n", __max_die_per_package);
    29		seq_printf(m, "smp_num_siblings:    %u\n", smp_num_siblings);
    30		return 0;
    31	}
    32	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

