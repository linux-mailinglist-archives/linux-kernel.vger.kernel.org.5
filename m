Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC26765366
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 14:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbjG0MQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 08:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbjG0MQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 08:16:44 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96192719
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 05:16:42 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RBV9w31l1z4f3pBr
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 20:16:36 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgD3rLAeYMJkyp24Ow--.57086S3;
        Thu, 27 Jul 2023 20:16:32 +0800 (CST)
Subject: Re: [RESEND PATCH 1/4] iommu/arm-smmu-v3: Add support for ECMDQ
 register mode
To:     kernel test robot <lkp@intel.com>,
        Tanmay Jagdale <tanmay@marvell.com>, will@kernel.org,
        robin.murphy@arm.com, joro@8bytes.org, baolu.lu@linux.intel.com,
        thunder.leizhen@huawei.com
Cc:     oe-kbuild-all@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, gcherian@marvell.com,
        sgoutham@marvell.com, lcherian@marvell.com, bbhushan2@marvell.com
References: <20230721063513.33431-2-tanmay@marvell.com>
 <202307271849.sqXiM3CK-lkp@intel.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Message-ID: <6f2863d3-f0ef-900c-c64a-87f02e726cf8@huaweicloud.com>
Date:   Thu, 27 Jul 2023 20:16:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <202307271849.sqXiM3CK-lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgD3rLAeYMJkyp24Ow--.57086S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtrW3CFyfXrykZr4rKFykKrg_yoWxZw4kpa
        1DGa9Yyr1kGF4xZa4xXr1Iv3s8tws5ua4ayFWUur90vr1j9rWrWrs7K3WYkrykKFy5Kw17
        ArnxX3yjkw45ArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU1zuWJUUUUU==
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/27 19:13, kernel test robot wrote:
> Hi Tanmay,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on v6.5-rc2]
> [also build test WARNING on linus/master next-20230727]
> [cannot apply to joro-iommu/next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Tanmay-Jagdale/iommu-arm-smmu-v3-Add-support-for-ECMDQ-register-mode/20230721-143913
> base:   v6.5-rc2
> patch link:    https://lore.kernel.org/r/20230721063513.33431-2-tanmay%40marvell.com
> patch subject: [RESEND PATCH 1/4] iommu/arm-smmu-v3: Add support for ECMDQ register mode
> config: arm64-randconfig-r083-20230726 (https://download.01.org/0day-ci/archive/20230727/202307271849.sqXiM3CK-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 12.3.0
> reproduce: (https://download.01.org/0day-ci/archive/20230727/202307271849.sqXiM3CK-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202307271849.sqXiM3CK-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
>>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3573:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct arm_smmu_ecmdq *ecmdq @@     got struct arm_smmu_ecmdq [noderef] __percpu * @@
>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3573:23: sparse:     expected struct arm_smmu_ecmdq *ecmdq
>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3573:23: sparse:     got struct arm_smmu_ecmdq [noderef] __percpu *

OK, thanks, the local variable 'ecmdq' need modifier '__percpu'.

>>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3578:58: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct arm_smmu_ecmdq * @@
>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3578:58: sparse:     expected void const [noderef] __percpu *__vpp_verify
>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3578:58: sparse:     got struct arm_smmu_ecmdq *
>>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3604:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *addr @@     got void [noderef] __iomem *base @@
>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3604:45: sparse:     expected void const *addr
>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3604:45: sparse:     got void [noderef] __iomem *base

Perhaps it would be better to add a member to the structure arm_smmu_device
to record the start physical address of the smmu.

>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c: note: in included file (through arch/arm64/include/asm/atomic.h, include/linux/atomic.h, include/asm-generic/bitops/atomic.h, ...):
>    arch/arm64/include/asm/cmpxchg.h:168:1: sparse: sparse: cast truncates bits from constant value (ffffffff80000000 becomes 0)
>    arch/arm64/include/asm/cmpxchg.h:168:1: sparse: sparse: cast truncates bits from constant value (ffffffff80000000 becomes 0)
> 
> vim +3573 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> 
>   3566	
>   3567	static int arm_smmu_ecmdq_layout(struct arm_smmu_device *smmu)
>   3568	{
>   3569		int cpu;
>   3570		struct arm_smmu_ecmdq *ecmdq;
>   3571	
>   3572		if (num_possible_cpus() <= smmu->nr_ecmdq) {
>> 3573			ecmdq = devm_alloc_percpu(smmu->dev, *ecmdq);
>   3574			if (!ecmdq)
>   3575				return -ENOMEM;
>   3576	
>   3577			for_each_possible_cpu(cpu)
>> 3578				*per_cpu_ptr(smmu->ecmdq, cpu) = per_cpu_ptr(ecmdq, cpu);
>   3579	
>   3580			/* A core requires at most one ECMDQ */
>   3581			smmu->nr_ecmdq = num_possible_cpus();
>   3582	
>   3583			return 0;
>   3584		}
>   3585	
>   3586		return -ENOSPC;
>   3587	}
>   3588	
>   3589	static int arm_smmu_ecmdq_probe(struct arm_smmu_device *smmu)
>   3590	{
>   3591		int ret, cpu;
>   3592		u32 i, nump, numq, gap;
>   3593		u32 reg, shift_increment;
>   3594		u64 addr, smmu_dma_base;
>   3595		void __iomem *cp_regs, *cp_base;
>   3596	
>   3597		/* IDR6 */
>   3598		reg = readl_relaxed(smmu->base + ARM_SMMU_IDR6);
>   3599		nump = 1 << FIELD_GET(IDR6_LOG2NUMP, reg);
>   3600		numq = 1 << FIELD_GET(IDR6_LOG2NUMQ, reg);
>   3601		smmu->nr_ecmdq = nump * numq;
>   3602		gap = ECMDQ_CP_RRESET_SIZE >> FIELD_GET(IDR6_LOG2NUMQ, reg);
>   3603	
>> 3604		smmu_dma_base = (vmalloc_to_pfn(smmu->base) << PAGE_SHIFT);
>   3605		cp_regs = ioremap(smmu_dma_base + ARM_SMMU_ECMDQ_CP_BASE, PAGE_SIZE);
>   3606		if (!cp_regs)
>   3607			return -ENOMEM;
>   3608	
>   3609		for (i = 0; i < nump; i++) {
>   3610			u64 val, pre_addr;
>   3611	
>   3612			val = readq_relaxed(cp_regs + 32 * i);
>   3613			if (!(val & ECMDQ_CP_PRESET)) {
>   3614				iounmap(cp_regs);
>   3615				dev_err(smmu->dev, "ecmdq control page %u is memory mode\n", i);
>   3616				return -EFAULT;
>   3617			}
>   3618	
>   3619			if (i && ((val & ECMDQ_CP_ADDR) != (pre_addr + ECMDQ_CP_RRESET_SIZE))) {
>   3620				iounmap(cp_regs);
>   3621				dev_err(smmu->dev, "ecmdq_cp memory region is not contiguous\n");
>   3622				return -EFAULT;
>   3623			}
>   3624	
>   3625			pre_addr = val & ECMDQ_CP_ADDR;
>   3626		}
>   3627	
>   3628		addr = readl_relaxed(cp_regs) & ECMDQ_CP_ADDR;
>   3629		iounmap(cp_regs);
>   3630	
>   3631		cp_base = devm_ioremap(smmu->dev, smmu_dma_base + addr, ECMDQ_CP_RRESET_SIZE * nump);
>   3632		if (!cp_base)
>   3633			return -ENOMEM;
>   3634	
>   3635		smmu->ecmdq = devm_alloc_percpu(smmu->dev, struct arm_smmu_ecmdq *);
>   3636		if (!smmu->ecmdq)
>   3637			return -ENOMEM;
>   3638	
>   3639		ret = arm_smmu_ecmdq_layout(smmu);
>   3640		if (ret)
>   3641			return ret;
>   3642	
>   3643		shift_increment = order_base_2(num_possible_cpus() / smmu->nr_ecmdq);
>   3644	
>   3645		addr = 0;
>   3646		for_each_possible_cpu(cpu) {
>   3647			struct arm_smmu_ecmdq *ecmdq;
>   3648			struct arm_smmu_queue *q;
>   3649	
>   3650			ecmdq = *per_cpu_ptr(smmu->ecmdq, cpu);
>   3651			ecmdq->base = cp_base + addr;
>   3652	
>   3653			q = &ecmdq->cmdq.q;
>   3654	
>   3655			q->llq.max_n_shift = ECMDQ_MAX_SZ_SHIFT + shift_increment;
>   3656			ret = arm_smmu_init_one_queue(smmu, q, ecmdq->base, ARM_SMMU_ECMDQ_PROD,
>   3657					ARM_SMMU_ECMDQ_CONS, CMDQ_ENT_DWORDS, "ecmdq");
>   3658			if (ret)
>   3659				return ret;
>   3660	
>   3661			q->ecmdq_prod = ECMDQ_PROD_EN;
>   3662			rwlock_init(&q->ecmdq_lock);
>   3663	
>   3664			ret = arm_smmu_ecmdq_init(&ecmdq->cmdq);
>   3665			if (ret) {
>   3666				dev_err(smmu->dev, "ecmdq[%d] init failed\n", i);
>   3667				return ret;
>   3668			}
>   3669	
>   3670			addr += gap;
>   3671		}
>   3672	
>   3673		return 0;
>   3674	}
>   3675	
> 

-- 
Regards,
  Zhen Lei

