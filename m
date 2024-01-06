Return-Path: <linux-kernel+bounces-18578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF23825FA2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 14:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D70F91F22BFC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 13:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF361748E;
	Sat,  6 Jan 2024 13:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="atfioCXw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFAA6FA4
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 13:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704546885; x=1736082885;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=08jgx8ytAVS3L9xXxt21JJeOVjwVtOFl6ZHUWa31dLE=;
  b=atfioCXwx4zY3Hx4kFTdtUopOEjRyVi8QDbgqaYLJodfOQIzy8LCjgfH
   DpqBcS84j+9meuZW+XM7HhvLjs8ORiorSpRq3XLJgowjYcK6X8x3PDQjx
   Xo1X/fysp095GkVvlAtVqo03f0lJ6guUPVa3Ev78Zo/Dx/qguVevVFA0H
   q3klMZ5ZfDFGnRapo5a+8kcKRlqS8cUo3jMPJWOO/V4NcQU8ZIFKQC5Dv
   wTCNoDC4I+nu8PjJxQRnt/7WNi7h1zqPOcI9WVpNiHGr5ryMGXTMqrj/M
   i+Hoq5Mq38vilk5f6zNU73TXWK4wJx8KHZgvNcTUDLYptbG0W75DjDzG1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="461955813"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="461955813"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 05:14:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="924456737"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="924456737"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 06 Jan 2024 05:14:43 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rM6Vc-0002W2-0l;
	Sat, 06 Jan 2024 13:14:40 +0000
Date: Sat, 6 Jan 2024 21:14:09 +0800
From: kernel test robot <lkp@intel.com>
To: Oliver Upton <oupton@google.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Marc Zyngier <maz@kernel.org>, Reiji Watanabe <reijiw@google.com>
Subject: arch/arm64/kvm/sys_regs.c:2402: warning: Function parameter or
 member 'params' not described in 'kvm_handle_cp_32'
Message-ID: <202401062105.Xv4LmwCQ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Oliver,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   95c8a35f1c017327eab3b6a2ff5c04255737c856
commit: e65197666773f39e4378161925e5a1c7771cff29 KVM: arm64: Wire up CP15 feature registers to their AArch64 equivalents
date:   1 year, 8 months ago
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20240106/202401062105.Xv4LmwCQ-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240106/202401062105.Xv4LmwCQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401062105.Xv4LmwCQ-lkp@intel.com/

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

