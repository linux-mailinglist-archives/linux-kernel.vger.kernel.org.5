Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAEDE75C5F1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 13:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjGULgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 07:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjGULgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 07:36:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6D91FD7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 04:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689939373; x=1721475373;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fxdDvlKp6ODRz2GyAAt9GykCK2Msp8J7pdh2V3H6nU8=;
  b=Gg1n9o9d06zHeHiTg2IyCVJblnZMB6OkViT6kONK1XeahJxhBuDU3ckF
   xc6m2nHRVgADrBp8Iq84jsW3KFlM+IVMp1+NgQhCjLvNKacydJk3bMJfh
   cHFU1511eupNyoytTDJwbOuWvj9S719t64JqgPNVQPrYjwLgOb83A3H0q
   Q1NKG+rdsAmYMM8jcI0vG84gof+HuMz6S0CU51dLwHh8zSwQF50W5qLif
   z+w8u3ullkl8jkhGJ4edFQA/Pgexcw7j2EwLQh+ZhVc/aemzfgCQ1XKip
   sRuPUjIMls8oC9Qox4nttvne0Bt7hAO6UlMQp7E4b/tJg7TX897hExcWJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="433231852"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="433231852"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 04:36:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="838522867"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="838522867"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jul 2023 04:36:10 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qMoQQ-0007EB-2e;
        Fri, 21 Jul 2023 11:35:59 +0000
Date:   Fri, 21 Jul 2023 19:34:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/kvm/e500mc.c:95:15: error: invalid instruction
Message-ID: <202307211945.TSPcyOhh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f7e3a1bafdea735050dfde00523cf505dc7fd309
commit: e83ca8cfa286c9fc78b585b0e66df7f542bcbcf2 KVM: PPC: booke: Mark three local functions "static"
date:   4 months ago
config: powerpc-randconfig-r001-20230721 (https://download.01.org/0day-ci/archive/20230721/202307211945.TSPcyOhh-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230721/202307211945.TSPcyOhh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307211945.TSPcyOhh-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/powerpc/kvm/e500mc.c:95:15: error: invalid instruction
      95 |         asm volatile("tlbilxlpid");
         |                      ^
   <inline asm>:1:2: note: instantiated into assembly here
       1 |         tlbilxlpid
         |         ^~~~~~~~~~
>> arch/powerpc/kvm/e500mc.c:95:15: error: invalid instruction
      95 |         asm volatile("tlbilxlpid");
         |                      ^
   <inline asm>:1:2: note: instantiated into assembly here
       1 |         tlbilxlpid
         |         ^~~~~~~~~~
   2 errors generated.


vim +95 arch/powerpc/kvm/e500mc.c

73196cd364a2d9 Scott Wood    2011-12-20  88  
73196cd364a2d9 Scott Wood    2011-12-20  89  void kvmppc_e500_tlbil_all(struct kvmppc_vcpu_e500 *vcpu_e500)
73196cd364a2d9 Scott Wood    2011-12-20  90  {
73196cd364a2d9 Scott Wood    2011-12-20  91  	unsigned long flags;
73196cd364a2d9 Scott Wood    2011-12-20  92  
73196cd364a2d9 Scott Wood    2011-12-20  93  	local_irq_save(flags);
188e267ce249b4 Mihai Caraman 2014-09-01  94  	mtspr(SPRN_MAS5, MAS5_SGS | get_lpid(&vcpu_e500->vcpu));
73196cd364a2d9 Scott Wood    2011-12-20 @95  	asm volatile("tlbilxlpid");
73196cd364a2d9 Scott Wood    2011-12-20  96  	mtspr(SPRN_MAS5, 0);
73196cd364a2d9 Scott Wood    2011-12-20  97  	local_irq_restore(flags);
73196cd364a2d9 Scott Wood    2011-12-20  98  }
73196cd364a2d9 Scott Wood    2011-12-20  99  

:::::: The code at line 95 was first introduced by commit
:::::: 73196cd364a2d972d73fa08da9d81ca3215bed68 KVM: PPC: e500mc support

:::::: TO: Scott Wood <scottwood@freescale.com>
:::::: CC: Avi Kivity <avi@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
