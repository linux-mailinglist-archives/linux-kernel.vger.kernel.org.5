Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696B0796E05
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 02:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243290AbjIGAfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 20:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjIGAfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 20:35:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C0319A2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 17:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694046925; x=1725582925;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tJ/6mfJDtq1ITgyNOvkwUq6nmZRSGtCxj4pdlXJtXbQ=;
  b=S6ZLbVkP83Zn7g4vjNPIAGQMcCbQlZvMqJuXjHey8rSGpuI/hUDDkiBB
   7hw6jHa/nSm5+l0GMWwTCWjB2uVjtEcrU9EREcD55FkA0oiqxMC8fMOVb
   CF43Dq4enG6tdmoxMAloUFmJZmpPAFbSxY+x81Bhcbgvo/qBUzVW2ymUU
   YYNHfRIt2W2M2mBjMG+5LXiFRX65JFMCm6RRT1h3icCBvGUvcxz6yA/NG
   YPEOuFbZEoyUUTI8HLxfk8RsW3uHdpkmatKqe9tF1Dfvr1ieoll/6isil
   DkskJvTvWzvlpSKtUOyUyDy/LyCIf8kkl4MpKjJ8N/CPoJX4ZKaTId9Ou
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="367444565"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="367444565"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 17:35:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="831924517"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="831924517"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Sep 2023 17:35:23 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qe2zQ-0000k7-2h;
        Thu, 07 Sep 2023 00:35:20 +0000
Date:   Thu, 7 Sep 2023 08:35:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: arch/x86/kvm/smm.c:215 enter_smm() warn: inconsistent indenting
Message-ID: <202309070828.4OVHiaEQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7ba2090ca64ea1aa435744884124387db1fac70f
commit: c53da4f3af6e613e82f88abc6eb988e44c5dadd7 KVM: x86: move SMM entry to a new file
date:   10 months ago
config: i386-randconfig-141-20230907 (https://download.01.org/0day-ci/archive/20230907/202309070828.4OVHiaEQ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230907/202309070828.4OVHiaEQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309070828.4OVHiaEQ-lkp@intel.com/

smatch warnings:
arch/x86/kvm/smm.c:215 enter_smm() warn: inconsistent indenting

vim +215 arch/x86/kvm/smm.c

   194	
   195	void enter_smm(struct kvm_vcpu *vcpu)
   196	{
   197		struct kvm_segment cs, ds;
   198		struct desc_ptr dt;
   199		unsigned long cr0;
   200		char buf[512];
   201	
   202		memset(buf, 0, 512);
   203	#ifdef CONFIG_X86_64
   204		if (guest_cpuid_has(vcpu, X86_FEATURE_LM))
   205			enter_smm_save_state_64(vcpu, buf);
   206		else
   207	#endif
   208			enter_smm_save_state_32(vcpu, buf);
   209	
   210		/*
   211		 * Give enter_smm() a chance to make ISA-specific changes to the vCPU
   212		 * state (e.g. leave guest mode) after we've saved the state into the
   213		 * SMM state-save area.
   214		 */
 > 215		static_call(kvm_x86_enter_smm)(vcpu, buf);
   216	
   217		kvm_smm_changed(vcpu, true);
   218		kvm_vcpu_write_guest(vcpu, vcpu->arch.smbase + 0xfe00, buf, sizeof(buf));
   219	
   220		if (static_call(kvm_x86_get_nmi_mask)(vcpu))
   221			vcpu->arch.hflags |= HF_SMM_INSIDE_NMI_MASK;
   222		else
   223			static_call(kvm_x86_set_nmi_mask)(vcpu, true);
   224	
   225		kvm_set_rflags(vcpu, X86_EFLAGS_FIXED);
   226		kvm_rip_write(vcpu, 0x8000);
   227	
   228		cr0 = vcpu->arch.cr0 & ~(X86_CR0_PE | X86_CR0_EM | X86_CR0_TS | X86_CR0_PG);
   229		static_call(kvm_x86_set_cr0)(vcpu, cr0);
   230		vcpu->arch.cr0 = cr0;
   231	
   232		static_call(kvm_x86_set_cr4)(vcpu, 0);
   233	
   234		/* Undocumented: IDT limit is set to zero on entry to SMM.  */
   235		dt.address = dt.size = 0;
   236		static_call(kvm_x86_set_idt)(vcpu, &dt);
   237	
   238		kvm_set_dr(vcpu, 7, DR7_FIXED_1);
   239	
   240		cs.selector = (vcpu->arch.smbase >> 4) & 0xffff;
   241		cs.base = vcpu->arch.smbase;
   242	
   243		ds.selector = 0;
   244		ds.base = 0;
   245	
   246		cs.limit    = ds.limit = 0xffffffff;
   247		cs.type     = ds.type = 0x3;
   248		cs.dpl      = ds.dpl = 0;
   249		cs.db       = ds.db = 0;
   250		cs.s        = ds.s = 1;
   251		cs.l        = ds.l = 0;
   252		cs.g        = ds.g = 1;
   253		cs.avl      = ds.avl = 0;
   254		cs.present  = ds.present = 1;
   255		cs.unusable = ds.unusable = 0;
   256		cs.padding  = ds.padding = 0;
   257	
   258		kvm_set_segment(vcpu, &cs, VCPU_SREG_CS);
   259		kvm_set_segment(vcpu, &ds, VCPU_SREG_DS);
   260		kvm_set_segment(vcpu, &ds, VCPU_SREG_ES);
   261		kvm_set_segment(vcpu, &ds, VCPU_SREG_FS);
   262		kvm_set_segment(vcpu, &ds, VCPU_SREG_GS);
   263		kvm_set_segment(vcpu, &ds, VCPU_SREG_SS);
   264	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
