Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A4A765206
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 13:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjG0LO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 07:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjG0LO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:14:26 -0400
Received: from mgamail.intel.com (unknown [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC5910B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 04:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690456465; x=1721992465;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kyMBEzns/c1XLgB1MtkLgiBVHcXIiW5UPIbwlDICK5E=;
  b=CuuX8QiyOifzamhjnm/R4u7VdGmvW8XuFR2qddDajfqAQdPGVpBI9HdY
   WCuJqzkZSF34hAWx5NmnKLvTZPuueK8DJNW8QMhXmCkEnm15t0pSB3BUz
   FsBCFXQrr9BrL9lOdukCaSnYr/QVzQRGOOT6BSHb/y9URRivypRenJE86
   3pJLHqtKotRystmqfABdOXlJUO2QQpnodzVoG/f9Gm2q0A99lOtSYpqSr
   XtgzbTGk3QYskUle3hc7UiuIVVyd30i/fuKNK5NixFHlTJ9IlTtihjgyf
   /BMXiL4LzyJBIBAh7g4pDRpGsjleBwDkD6unlMKoUl5tpu61RIZs69ZoT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="432078878"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="432078878"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 04:14:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="870333490"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jul 2023 04:14:22 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOywW-0002DT-1R;
        Thu, 27 Jul 2023 11:14:07 +0000
Date:   Thu, 27 Jul 2023 19:13:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tanmay Jagdale <tanmay@marvell.com>, will@kernel.org,
        robin.murphy@arm.com, joro@8bytes.org, baolu.lu@linux.intel.com,
        thunder.leizhen@huawei.com
Cc:     oe-kbuild-all@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, gcherian@marvell.com,
        sgoutham@marvell.com, lcherian@marvell.com, bbhushan2@marvell.com
Subject: Re: [RESEND PATCH 1/4] iommu/arm-smmu-v3: Add support for ECMDQ
 register mode
Message-ID: <202307271849.sqXiM3CK-lkp@intel.com>
References: <20230721063513.33431-2-tanmay@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721063513.33431-2-tanmay@marvell.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tanmay,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.5-rc2]
[also build test WARNING on linus/master next-20230727]
[cannot apply to joro-iommu/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tanmay-Jagdale/iommu-arm-smmu-v3-Add-support-for-ECMDQ-register-mode/20230721-143913
base:   v6.5-rc2
patch link:    https://lore.kernel.org/r/20230721063513.33431-2-tanmay%40marvell.com
patch subject: [RESEND PATCH 1/4] iommu/arm-smmu-v3: Add support for ECMDQ register mode
config: arm64-randconfig-r083-20230726 (https://download.01.org/0day-ci/archive/20230727/202307271849.sqXiM3CK-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230727/202307271849.sqXiM3CK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307271849.sqXiM3CK-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3573:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct arm_smmu_ecmdq *ecmdq @@     got struct arm_smmu_ecmdq [noderef] __percpu * @@
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3573:23: sparse:     expected struct arm_smmu_ecmdq *ecmdq
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3573:23: sparse:     got struct arm_smmu_ecmdq [noderef] __percpu *
>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3578:58: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct arm_smmu_ecmdq * @@
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3578:58: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3578:58: sparse:     got struct arm_smmu_ecmdq *
>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3604:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *addr @@     got void [noderef] __iomem *base @@
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3604:45: sparse:     expected void const *addr
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3604:45: sparse:     got void [noderef] __iomem *base
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c: note: in included file (through arch/arm64/include/asm/atomic.h, include/linux/atomic.h, include/asm-generic/bitops/atomic.h, ...):
   arch/arm64/include/asm/cmpxchg.h:168:1: sparse: sparse: cast truncates bits from constant value (ffffffff80000000 becomes 0)
   arch/arm64/include/asm/cmpxchg.h:168:1: sparse: sparse: cast truncates bits from constant value (ffffffff80000000 becomes 0)

vim +3573 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c

  3566	
  3567	static int arm_smmu_ecmdq_layout(struct arm_smmu_device *smmu)
  3568	{
  3569		int cpu;
  3570		struct arm_smmu_ecmdq *ecmdq;
  3571	
  3572		if (num_possible_cpus() <= smmu->nr_ecmdq) {
> 3573			ecmdq = devm_alloc_percpu(smmu->dev, *ecmdq);
  3574			if (!ecmdq)
  3575				return -ENOMEM;
  3576	
  3577			for_each_possible_cpu(cpu)
> 3578				*per_cpu_ptr(smmu->ecmdq, cpu) = per_cpu_ptr(ecmdq, cpu);
  3579	
  3580			/* A core requires at most one ECMDQ */
  3581			smmu->nr_ecmdq = num_possible_cpus();
  3582	
  3583			return 0;
  3584		}
  3585	
  3586		return -ENOSPC;
  3587	}
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
> 3604		smmu_dma_base = (vmalloc_to_pfn(smmu->base) << PAGE_SHIFT);
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
  3619			if (i && ((val & ECMDQ_CP_ADDR) != (pre_addr + ECMDQ_CP_RRESET_SIZE))) {
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
