Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31C87834DE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjHUVY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 17:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjHUVYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 17:24:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC42E1AD
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 14:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692653039; x=1724189039;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kfubVw9+zEFG8ng9Lu7O1Q3+M7WrJ1VxjkML+5FetrQ=;
  b=UWcJe07IN89koFMhoXFJKJtgffXSgkfLGc8CNmuOfQ+ZHF4TRzrECLmK
   wN3JyBLCjwDMXYLpnffjw9sNvy5jovbsrC5jdSud0wREYrjMAZNHrWx4d
   02Ie1dz8wrSIM8qPMdyybgF5GpHKAFdRhK/hzzVnvcmCVVu1T8UhroFTz
   qWgRHGCIrKrAdXvfcZqJFAi1uwDO0/SMhFjIcynxaLyco2CeoMVRm7pyx
   fX6gdGwo2ohDOSKnG2H026tLU5P6GzuxqZ4hK1Xyr5xRpIl0Tyhbv8Ujk
   a4LYQNvDNxv8QHCb04Xx25Bk0giSqWaz0tdTqktG2iSIml9fWMletWDAZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="354023607"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="354023607"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 14:23:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="771099541"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="771099541"
Received: from lkp-server02.sh.intel.com (HELO 6809aa828f2a) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 21 Aug 2023 14:23:57 -0700
Received: from kbuild by 6809aa828f2a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qYCNG-0000wl-38;
        Mon, 21 Aug 2023 21:23:51 +0000
Date:   Tue, 22 Aug 2023 05:21:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Oliver Upton <oupton@google.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Reiji Watanabe <reijiw@google.com>
Subject: arch/arm64/kvm/sys_regs.c:2402: warning: Function parameter or
 member 'params' not described in 'kvm_handle_cp_32'
Message-ID: <202308220552.e2OVbfhn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f7757129e3dea336c407551c98f50057c22bb266
commit: e65197666773f39e4378161925e5a1c7771cff29 KVM: arm64: Wire up CP15 feature registers to their AArch64 equivalents
date:   1 year, 4 months ago
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20230822/202308220552.e2OVbfhn-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230822/202308220552.e2OVbfhn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308220552.e2OVbfhn-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/arm64/kvm/sys_regs.c:2305: warning: Function parameter or member 'global' not described in 'kvm_handle_cp_64'
   arch/arm64/kvm/sys_regs.c:2305: warning: Function parameter or member 'nr_global' not described in 'kvm_handle_cp_64'
   arch/arm64/kvm/sys_regs.c:2305: warning: Excess function parameter 'run' description in 'kvm_handle_cp_64'
>> arch/arm64/kvm/sys_regs.c:2402: warning: Function parameter or member 'params' not described in 'kvm_handle_cp_32'
   arch/arm64/kvm/sys_regs.c:2402: warning: Function parameter or member 'global' not described in 'kvm_handle_cp_32'
   arch/arm64/kvm/sys_regs.c:2402: warning: Function parameter or member 'nr_global' not described in 'kvm_handle_cp_32'
   arch/arm64/kvm/sys_regs.c:2402: warning: Excess function parameter 'run' description in 'kvm_handle_cp_32'


vim +2402 arch/arm64/kvm/sys_regs.c

e65197666773f3 Oliver Upton 2022-05-03  2392  
62a89c44954f09 Marc Zyngier 2013-02-07  2393  /**
7769db905bd2df Shannon Zhao 2016-01-13  2394   * kvm_handle_cp_32 -- handles a mrc/mcr trap on a guest CP14/CP15 access
62a89c44954f09 Marc Zyngier 2013-02-07  2395   * @vcpu: The VCPU pointer
62a89c44954f09 Marc Zyngier 2013-02-07  2396   * @run:  The kvm_run struct
62a89c44954f09 Marc Zyngier 2013-02-07  2397   */
72564016aae45f Marc Zyngier 2014-04-24  2398  static int kvm_handle_cp_32(struct kvm_vcpu *vcpu,
e65197666773f3 Oliver Upton 2022-05-03  2399  			    struct sys_reg_params *params,
72564016aae45f Marc Zyngier 2014-04-24  2400  			    const struct sys_reg_desc *global,
dcaffa7bf91157 James Morse  2020-06-22  2401  			    size_t nr_global)
62a89c44954f09 Marc Zyngier 2013-02-07 @2402  {
c667186f1c01ca Marc Zyngier 2017-04-27  2403  	int Rt  = kvm_vcpu_sys_get_rt(vcpu);
62a89c44954f09 Marc Zyngier 2013-02-07  2404  
e65197666773f3 Oliver Upton 2022-05-03  2405  	params->regval = vcpu_get_reg(vcpu, Rt);
62a89c44954f09 Marc Zyngier 2013-02-07  2406  
e65197666773f3 Oliver Upton 2022-05-03  2407  	if (emulate_cp(vcpu, params, global, nr_global)) {
e65197666773f3 Oliver Upton 2022-05-03  2408  		if (!params->is_write)
e65197666773f3 Oliver Upton 2022-05-03  2409  			vcpu_set_reg(vcpu, Rt, params->regval);
72564016aae45f Marc Zyngier 2014-04-24  2410  		return 1;
2ec5be3dbfdcb6 Pavel Fedin  2015-12-04  2411  	}
72564016aae45f Marc Zyngier 2014-04-24  2412  
e65197666773f3 Oliver Upton 2022-05-03  2413  	unhandled_cp_access(vcpu, params);
62a89c44954f09 Marc Zyngier 2013-02-07  2414  	return 1;
62a89c44954f09 Marc Zyngier 2013-02-07  2415  }
62a89c44954f09 Marc Zyngier 2013-02-07  2416  

:::::: The code at line 2402 was first introduced by commit
:::::: 62a89c44954f09072bf07a714c8f68bda14ab87e arm64: KVM: 32bit handling of coprocessor traps

:::::: TO: Marc Zyngier <marc.zyngier@arm.com>
:::::: CC: Marc Zyngier <marc.zyngier@arm.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
