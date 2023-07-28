Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873517666D1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234858AbjG1ITt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbjG1ITP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:19:15 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EFA3AB3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 01:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690532349; x=1722068349;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b/epiay7cjfSEFmhvgmiHCozve2Mrb9TOzKISarVum8=;
  b=bauMP/jeGEiFXbPrr2Y5s9B4hUhIAN7umsuoBCypN6AYyAgVDNQyXoMg
   rbjU2XCLh+5dMNmpMRWyZE3kiP/JTuxOBy+ddYxVSBSum27zSbJhHQjKd
   kYz5Ivn9kLHBxVzKB8NLf944CIJGIjaJMR3CXMZIg1YsDeXWslmu2ZBue
   3mdKKxeXYCmL95iOy9Q4m/611//JmsvKHzyxKIhmslUNpeXvEFj2dI7Lv
   WnxbV7zdP1mUGMvfwWDZVHglHIWY63bHyQ+ZhXJKahMnNOub9CdLqG0bs
   xGyjZ+wHZmszcauIy7W1XLNObVntgpuxPtWi2KsOJxq7jhYmVF2e9EPyk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="367415186"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="367415186"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 01:19:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="1058040615"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="1058040615"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jul 2023 01:19:04 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qPIgi-00031l-0m;
        Fri, 28 Jul 2023 08:19:04 +0000
Date:   Fri, 28 Jul 2023 16:18:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tanmay Jagdale <tanmay@marvell.com>, will@kernel.org,
        robin.murphy@arm.com, joro@8bytes.org, baolu.lu@linux.intel.com,
        thunder.leizhen@huawei.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, gcherian@marvell.com,
        sgoutham@marvell.com, lcherian@marvell.com, bbhushan2@marvell.com
Subject: Re: [RESEND PATCH 1/4] iommu/arm-smmu-v3: Add support for ECMDQ
 register mode
Message-ID: <202307281657.K3A7kRax-lkp@intel.com>
References: <20230721063513.33431-2-tanmay@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721063513.33431-2-tanmay@marvell.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tanmay,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.5-rc2]
[also build test WARNING on linus/master next-20230728]
[cannot apply to joro-iommu/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tanmay-Jagdale/iommu-arm-smmu-v3-Add-support-for-ECMDQ-register-mode/20230721-143913
base:   v6.5-rc2
patch link:    https://lore.kernel.org/r/20230721063513.33431-2-tanmay%40marvell.com
patch subject: [RESEND PATCH 1/4] iommu/arm-smmu-v3: Add support for ECMDQ register mode
config: arm64-randconfig-r032-20230727 (https://download.01.org/0day-ci/archive/20230728/202307281657.K3A7kRax-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230728/202307281657.K3A7kRax-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307281657.K3A7kRax-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3619:39: warning: variable 'pre_addr' is uninitialized when used here [-Wuninitialized]
    3619 |                 if (i && ((val & ECMDQ_CP_ADDR) != (pre_addr + ECMDQ_CP_RRESET_SIZE))) {
         |                                                     ^~~~~~~~
   include/linux/compiler.h:55:47: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                                               ^~~~
   include/linux/compiler.h:57:52: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3610:20: note: initialize the variable 'pre_addr' to silence this warning
    3610 |                 u64 val, pre_addr;
         |                                  ^
         |                                   = 0
   1 warning generated.


vim +/pre_addr +3619 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c

  3588	
  3589	static int arm_smmu_ecmdq_probe(struct arm_smmu_device *smmu)
  3590	{
  3591		int ret, cpu;
  3592		u32 i, nump, numq, gap;
  3593		u32 reg, shift_increment;
  3594		u64 addr, smmu_dma_base;
  3595		void __iomem *cp_regs, *cp_base;
  3596	
  3597		/* IDR6 */
  3598		reg = readl_relaxed(smmu->base + ARM_SMMU_IDR6);
  3599		nump = 1 << FIELD_GET(IDR6_LOG2NUMP, reg);
  3600		numq = 1 << FIELD_GET(IDR6_LOG2NUMQ, reg);
  3601		smmu->nr_ecmdq = nump * numq;
  3602		gap = ECMDQ_CP_RRESET_SIZE >> FIELD_GET(IDR6_LOG2NUMQ, reg);
  3603	
  3604		smmu_dma_base = (vmalloc_to_pfn(smmu->base) << PAGE_SHIFT);
  3605		cp_regs = ioremap(smmu_dma_base + ARM_SMMU_ECMDQ_CP_BASE, PAGE_SIZE);
  3606		if (!cp_regs)
  3607			return -ENOMEM;
  3608	
  3609		for (i = 0; i < nump; i++) {
  3610			u64 val, pre_addr;
  3611	
  3612			val = readq_relaxed(cp_regs + 32 * i);
  3613			if (!(val & ECMDQ_CP_PRESET)) {
  3614				iounmap(cp_regs);
  3615				dev_err(smmu->dev, "ecmdq control page %u is memory mode\n", i);
  3616				return -EFAULT;
  3617			}
  3618	
> 3619			if (i && ((val & ECMDQ_CP_ADDR) != (pre_addr + ECMDQ_CP_RRESET_SIZE))) {
  3620				iounmap(cp_regs);
  3621				dev_err(smmu->dev, "ecmdq_cp memory region is not contiguous\n");
  3622				return -EFAULT;
  3623			}
  3624	
  3625			pre_addr = val & ECMDQ_CP_ADDR;
  3626		}
  3627	
  3628		addr = readl_relaxed(cp_regs) & ECMDQ_CP_ADDR;
  3629		iounmap(cp_regs);
  3630	
  3631		cp_base = devm_ioremap(smmu->dev, smmu_dma_base + addr, ECMDQ_CP_RRESET_SIZE * nump);
  3632		if (!cp_base)
  3633			return -ENOMEM;
  3634	
  3635		smmu->ecmdq = devm_alloc_percpu(smmu->dev, struct arm_smmu_ecmdq *);
  3636		if (!smmu->ecmdq)
  3637			return -ENOMEM;
  3638	
  3639		ret = arm_smmu_ecmdq_layout(smmu);
  3640		if (ret)
  3641			return ret;
  3642	
  3643		shift_increment = order_base_2(num_possible_cpus() / smmu->nr_ecmdq);
  3644	
  3645		addr = 0;
  3646		for_each_possible_cpu(cpu) {
  3647			struct arm_smmu_ecmdq *ecmdq;
  3648			struct arm_smmu_queue *q;
  3649	
  3650			ecmdq = *per_cpu_ptr(smmu->ecmdq, cpu);
  3651			ecmdq->base = cp_base + addr;
  3652	
  3653			q = &ecmdq->cmdq.q;
  3654	
  3655			q->llq.max_n_shift = ECMDQ_MAX_SZ_SHIFT + shift_increment;
  3656			ret = arm_smmu_init_one_queue(smmu, q, ecmdq->base, ARM_SMMU_ECMDQ_PROD,
  3657					ARM_SMMU_ECMDQ_CONS, CMDQ_ENT_DWORDS, "ecmdq");
  3658			if (ret)
  3659				return ret;
  3660	
  3661			q->ecmdq_prod = ECMDQ_PROD_EN;
  3662			rwlock_init(&q->ecmdq_lock);
  3663	
  3664			ret = arm_smmu_ecmdq_init(&ecmdq->cmdq);
  3665			if (ret) {
  3666				dev_err(smmu->dev, "ecmdq[%d] init failed\n", i);
  3667				return ret;
  3668			}
  3669	
  3670			addr += gap;
  3671		}
  3672	
  3673		return 0;
  3674	}
  3675	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
