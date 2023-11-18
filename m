Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B867EFDFB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 07:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjKRGTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 01:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjKRGTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 01:19:10 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A17D4D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 22:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700288346; x=1731824346;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OvM/2XpTH3vd25dQ8ol/N2BC1ozdJet2rF3Q/bpr9qo=;
  b=Z1H71jSq5vCQOPVwpzlrq2M9sBnbIruadZzxr2ChCwNDmmHcb0L2zD0u
   g4CwnI/pqx0f7kjjrN6ueGeJ3iTDDrbrkzUkDd4xhdxQpwPymKXwE9Y3f
   dOf9Og8+JwzkVPa4nRYTA7sxhfTJirDp+LxAVd2X4MDeZfjOU2Py2O8nb
   KC/ZCLrcGfEHr0EaTSr/DvnNALucYnEwT2+UKfnmJ6sIRCcijzk8sbCVb
   dh4fUD5nvpzX7BNVgXmEpXL7IdBvCEBwZxV9GT5A2BliBAOGdPu6mapF3
   d+EDtL1IKGVE67+yk9DjfgmPIbrznpuJ12cp1GRLkwYlBq2z2wBnicwzX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="394258866"
X-IronPort-AV: E=Sophos;i="6.04,207,1695711600"; 
   d="scan'208";a="394258866"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 22:19:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="1013126542"
X-IronPort-AV: E=Sophos;i="6.04,207,1695711600"; 
   d="scan'208";a="1013126542"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 17 Nov 2023 22:19:03 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4EfV-0003ap-1S;
        Sat, 18 Nov 2023 06:19:01 +0000
Date:   Sat, 18 Nov 2023 14:18:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tianrui Zhao <zhaotianrui@loongson.cn>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>,
        Bibo Mao <maobibo@loongson.cn>
Subject: arch/loongarch/kvm/../../../virt/kvm/kvm_main.c:300:16: sparse:
 sparse: incorrect type in argument 1 (different address spaces)
Message-ID: <202311181454.CTPrSYmQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   791c8ab095f71327899023223940dd52257a4173
commit: c1fc48aad14dbe7654f5986afb906332b528d54b LoongArch: KVM: Enable kvm config and add the makefile
date:   7 weeks ago
config: loongarch-randconfig-r111-20231118 (https://download.01.org/0day-ci/archive/20231118/202311181454.CTPrSYmQ-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231118/202311181454.CTPrSYmQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311181454.CTPrSYmQ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/loongarch/kvm/../../../virt/kvm/kvm_main.c:300:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct cpumask *[noderef] __percpu * @@
   arch/loongarch/kvm/../../../virt/kvm/kvm_main.c:300:16: sparse:     expected void *ptr
   arch/loongarch/kvm/../../../virt/kvm/kvm_main.c:300:16: sparse:     got struct cpumask *[noderef] __percpu *
>> arch/loongarch/kvm/../../../virt/kvm/kvm_main.c:300:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct cpumask *[noderef] __percpu * @@
   arch/loongarch/kvm/../../../virt/kvm/kvm_main.c:300:16: sparse:     expected void *ptr
   arch/loongarch/kvm/../../../virt/kvm/kvm_main.c:300:16: sparse:     got struct cpumask *[noderef] __percpu *
>> arch/loongarch/kvm/../../../virt/kvm/kvm_main.c:300:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct cpumask *[noderef] __percpu * @@
   arch/loongarch/kvm/../../../virt/kvm/kvm_main.c:300:16: sparse:     expected void *ptr
   arch/loongarch/kvm/../../../virt/kvm/kvm_main.c:300:16: sparse:     got struct cpumask *[noderef] __percpu *
>> arch/loongarch/kvm/../../../virt/kvm/kvm_main.c:300:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct cpumask *[noderef] __percpu * @@
   arch/loongarch/kvm/../../../virt/kvm/kvm_main.c:300:16: sparse:     expected void *ptr
   arch/loongarch/kvm/../../../virt/kvm/kvm_main.c:300:16: sparse:     got struct cpumask *[noderef] __percpu *
   arch/loongarch/kvm/../../../virt/kvm/kvm_main.c:327:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct cpumask *[noderef] __percpu * @@
   arch/loongarch/kvm/../../../virt/kvm/kvm_main.c:327:16: sparse:     expected void *ptr
   arch/loongarch/kvm/../../../virt/kvm/kvm_main.c:327:16: sparse:     got struct cpumask *[noderef] __percpu *
   arch/loongarch/kvm/../../../virt/kvm/kvm_main.c:327:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct cpumask *[noderef] __percpu * @@
   arch/loongarch/kvm/../../../virt/kvm/kvm_main.c:327:16: sparse:     expected void *ptr
   arch/loongarch/kvm/../../../virt/kvm/kvm_main.c:327:16: sparse:     got struct cpumask *[noderef] __percpu *
   arch/loongarch/kvm/../../../virt/kvm/kvm_main.c:327:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct cpumask *[noderef] __percpu * @@
   arch/loongarch/kvm/../../../virt/kvm/kvm_main.c:327:16: sparse:     expected void *ptr
   arch/loongarch/kvm/../../../virt/kvm/kvm_main.c:327:16: sparse:     got struct cpumask *[noderef] __percpu *
   arch/loongarch/kvm/../../../virt/kvm/kvm_main.c:327:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct cpumask *[noderef] __percpu * @@
   arch/loongarch/kvm/../../../virt/kvm/kvm_main.c:327:16: sparse:     expected void *ptr
   arch/loongarch/kvm/../../../virt/kvm/kvm_main.c:327:16: sparse:     got struct cpumask *[noderef] __percpu *
   arch/loongarch/kvm/../../../virt/kvm/kvm_main.c: note: in included file:
   include/linux/kvm_host.h:1946:54: sparse: sparse: array of flexible structures
   include/linux/kvm_host.h:1948:56: sparse: sparse: array of flexible structures
   arch/loongarch/kvm/../../../virt/kvm/kvm_main.c:602:9: sparse: sparse: context imbalance in 'kvm_mmu_notifier_change_pte' - different lock contexts for basic block
   arch/loongarch/kvm/../../../virt/kvm/kvm_main.c:602:9: sparse: sparse: context imbalance in 'kvm_mmu_notifier_invalidate_range_start' - different lock contexts for basic block
   arch/loongarch/kvm/../../../virt/kvm/kvm_main.c:602:9: sparse: sparse: context imbalance in 'kvm_mmu_notifier_invalidate_range_end' - different lock contexts for basic block
   arch/loongarch/kvm/../../../virt/kvm/kvm_main.c:602:9: sparse: sparse: context imbalance in 'kvm_mmu_notifier_clear_flush_young' - different lock contexts for basic block
   arch/loongarch/kvm/../../../virt/kvm/kvm_main.c:602:9: sparse: sparse: context imbalance in 'kvm_mmu_notifier_clear_young' - different lock contexts for basic block
   arch/loongarch/kvm/../../../virt/kvm/kvm_main.c:602:9: sparse: sparse: context imbalance in 'kvm_mmu_notifier_test_young' - different lock contexts for basic block
   arch/loongarch/kvm/../../../virt/kvm/kvm_main.c:1969:49: sparse: sparse: self-comparison always evaluates to false
   arch/loongarch/kvm/../../../virt/kvm/kvm_main.c:1975:37: sparse: sparse: self-comparison always evaluates to false
   arch/loongarch/kvm/../../../virt/kvm/kvm_main.c:2674:9: sparse: sparse: context imbalance in 'hva_to_pfn_remapped' - unexpected unlock

vim +300 arch/loongarch/kvm/../../../virt/kvm/kvm_main.c

7053df4edb3ae3 Vitaly Kuznetsov 2018-05-16  289  
ae0946cd360175 Vitaly Kuznetsov 2021-09-03  290  bool kvm_make_vcpus_request_mask(struct kvm *kvm, unsigned int req,
620b2438abf98f Vitaly Kuznetsov 2021-09-03  291  				 unsigned long *vcpu_bitmap)
ae0946cd360175 Vitaly Kuznetsov 2021-09-03  292  {
ae0946cd360175 Vitaly Kuznetsov 2021-09-03  293  	struct kvm_vcpu *vcpu;
620b2438abf98f Vitaly Kuznetsov 2021-09-03  294  	struct cpumask *cpus;
ae0946cd360175 Vitaly Kuznetsov 2021-09-03  295  	int i, me;
ae0946cd360175 Vitaly Kuznetsov 2021-09-03  296  	bool called;
ae0946cd360175 Vitaly Kuznetsov 2021-09-03  297  
ae0946cd360175 Vitaly Kuznetsov 2021-09-03  298  	me = get_cpu();
ae0946cd360175 Vitaly Kuznetsov 2021-09-03  299  
620b2438abf98f Vitaly Kuznetsov 2021-09-03 @300  	cpus = this_cpu_cpumask_var_ptr(cpu_kick_mask);
620b2438abf98f Vitaly Kuznetsov 2021-09-03  301  	cpumask_clear(cpus);
620b2438abf98f Vitaly Kuznetsov 2021-09-03  302  
ae0946cd360175 Vitaly Kuznetsov 2021-09-03  303  	for_each_set_bit(i, vcpu_bitmap, KVM_MAX_VCPUS) {
ae0946cd360175 Vitaly Kuznetsov 2021-09-03  304  		vcpu = kvm_get_vcpu(kvm, i);
381cecc5d7b777 Vitaly Kuznetsov 2021-09-03  305  		if (!vcpu)
ae0946cd360175 Vitaly Kuznetsov 2021-09-03  306  			continue;
b56bd8e03cf4d5 Jinrong Liang    2022-01-25  307  		kvm_make_vcpu_request(vcpu, req, cpus, me);
ae0946cd360175 Vitaly Kuznetsov 2021-09-03  308  	}
ae0946cd360175 Vitaly Kuznetsov 2021-09-03  309  
620b2438abf98f Vitaly Kuznetsov 2021-09-03  310  	called = kvm_kick_many_cpus(cpus, !!(req & KVM_REQUEST_WAIT));
3cba41307a2b13 Xiao Guangrong   2011-01-12  311  	put_cpu();
7053df4edb3ae3 Vitaly Kuznetsov 2018-05-16  312  
7053df4edb3ae3 Vitaly Kuznetsov 2018-05-16  313  	return called;
7053df4edb3ae3 Vitaly Kuznetsov 2018-05-16  314  }
7053df4edb3ae3 Vitaly Kuznetsov 2018-05-16  315  

:::::: The code at line 300 was first introduced by commit
:::::: 620b2438abf98f09e19802cbc3bc2e98179cdbe2 KVM: Make kvm_make_vcpus_request_mask() use pre-allocated cpu_kick_mask

:::::: TO: Vitaly Kuznetsov <vkuznets@redhat.com>
:::::: CC: Paolo Bonzini <pbonzini@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
