Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C6C78493D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 20:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjHVSHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 14:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjHVSH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 14:07:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFACD10D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 11:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692727620; x=1724263620;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cwGhR5AwafMsuOw+p9j0rPog41N/qRISE816aZR6K+Q=;
  b=AxUXRK62qXF6fifsYxuVz7m0srKo4J7rnQAyfmaBnfN3CSePp9riYvKI
   Qe4ZjsFUlPcy7+PXHtttxSy8Bti0DgNo70NnYd4YiUUNdqzHr6PJVA5c1
   A4/lm/QL0PhjDcNcL9Num0EM+Y8F78BWuqachHY5kksOTDIUwNNdQkPUV
   dNoPHWKVEmgFIdEcC9nhP0Crh33Jj1Mn9ScK/Rcqd7YgkCayR2wqnEmB9
   97hTM1e+RvQqOVs+RkIPFYQ/LREQhKqaScGYDYbiimhSajEnYYbKXqMaH
   68r9LSg3QiFbb+ZicxX50vHu2iPsZY19ck8fDmsc/39Zoa5PS0KIsW/Fc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="354291547"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="354291547"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 11:06:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="801773724"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="801773724"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 22 Aug 2023 11:06:48 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qYVmB-0000PM-0w;
        Tue, 22 Aug 2023 18:06:47 +0000
Date:   Wed, 23 Aug 2023 02:06:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Hu <nick.hu@sifive.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        leyfoon.tan@starfivetech.com, mason.huo@starfivetech.com,
        conor.dooley@microchip.com, jeeheng.sia@starfivetech.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        zong.li@sifive.com
Cc:     oe-kbuild-all@lists.linux.dev, Andy Chiu <andy.chiu@sifive.com>
Subject: Re: [PATCH v2] riscv: suspend: Add syscore ops for suspend
Message-ID: <202308230107.1L1ahyas-lkp@intel.com>
References: <20230822054739.33552-1-nick.hu@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822054739.33552-1-nick.hu@sifive.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.5-rc7 next-20230822]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nick-Hu/riscv-suspend-Add-syscore-ops-for-suspend/20230822-135024
base:   linus/master
patch link:    https://lore.kernel.org/r/20230822054739.33552-1-nick.hu%40sifive.com
patch subject: [PATCH v2] riscv: suspend: Add syscore ops for suspend
config: riscv-randconfig-r121-20230822 (https://download.01.org/0day-ci/archive/20230823/202308230107.1L1ahyas-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230823/202308230107.1L1ahyas-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308230107.1L1ahyas-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/riscv/kernel/suspend.c: In function 'riscv_cpu_resume':
>> arch/riscv/kernel/suspend.c:114:25: warning: unused variable 'regs' [-Wunused-variable]
     114 |         struct pt_regs *regs = task_pt_regs(cur_task);
         |                         ^~~~


vim +/regs +114 arch/riscv/kernel/suspend.c

   110	
   111	static void riscv_cpu_resume(void)
   112	{
   113		struct task_struct *cur_task = get_current();
 > 114		struct pt_regs *regs = task_pt_regs(cur_task);
   115	
   116		if (has_fpu())
   117			fstate_restore(cur_task, regs);
   118		if (has_vector())
   119			riscv_v_vstate_restore(cur_task, regs);
   120	}
   121	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
