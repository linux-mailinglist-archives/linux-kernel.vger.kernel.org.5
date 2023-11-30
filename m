Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4AB7FFC62
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376634AbjK3UVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjK3UVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:21:49 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CD2194
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701375716; x=1732911716;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LdDGtlUZL7IaMCOcKKta/1AReyJHwabRXk+kRxB64n4=;
  b=LJcLR8Mx1t/+LruL2ON2KxrSHiDKlHzvUkq2b0QE4NkYlwmFXyQqTuek
   GMJh3Jg4NuTzbI7QVEIVBXmUKnz2SXPYVUCMNrKO4IPssRmkqRP2PRQx8
   y+es5p4bKDzNsmjCUPRlZmVV9Lah28Uo9lkmhwAbQeMI867DGOvIw7C0d
   Ypz/IeEQCu8NnVUvim3Y8QoW1Z/tRdWh1Lx1pekOGQRmTYVC7DOsZyDWc
   na7trIvjiHhtJ9+eTdq3y8vA7uwUlpLe4X1XC6DM8cdOwtRSowkJDfM9H
   /TkBpxXj0duDCXUaHWbWkQUIUuFi4ohnshMpuTvcMlod8/vAni1gBItwN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="286778"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="286778"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 12:21:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="10917332"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 30 Nov 2023 12:21:54 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r8nXj-0002dM-1R;
        Thu, 30 Nov 2023 20:21:51 +0000
Date:   Fri, 1 Dec 2023 04:21:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/x86/kernel/cpu/debugfs.c:11:33: sparse: sparse: incorrect type
 in initializer (different address spaces)
Message-ID: <202312010444.uoDYtflb-lkp@intel.com>
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
head:   3b47bc037bd44f142ac09848e8d3ecccc726be99
commit: 48525fd1ea1cfa059a580e77b10ea8790914efa2 x86/cpu: Provide debug interface
date:   7 weeks ago
config: i386-randconfig-061-20231014 (https://download.01.org/0day-ci/archive/20231201/202312010444.uoDYtflb-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231201/202312010444.uoDYtflb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312010444.uoDYtflb-lkp@intel.com/

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
