Return-Path: <linux-kernel+bounces-11172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9C981E27C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 22:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 523E71C20FBD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 21:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D76353E1A;
	Mon, 25 Dec 2023 21:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ReJXnd2q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43C753E18
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 21:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703540946; x=1735076946;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tdG5BbnB6LmrEO1jhGdnktv4c4lzn7LYDIVOM2d0oSI=;
  b=ReJXnd2qcG6DU/Wt5t+bjqwvtxvCsztDT+x5jNc5wDyz2iE+Tu3l1hgF
   ARNgulw11KYyaspeBtKuuS28b7mwZZLZtg6nIe5bZzcHcb5SsZmcPbOx8
   4I77yyagZZYALPo2veq6vWlIzgoYZdYDD3iwpg6+K2cuqAzxQ/OZflHxU
   bTBg2nGu3trkkZwFCsuMlorISiA5ZuiG49lsWvZL0qCA6whlLU5MbUp3b
   GA9fdXu2FUENPIQ3VCxzh40TgQXTmDRft8W5n/Ob3GIjViPaK2quICqVx
   Af0TxKEV1Jx3e0jNjZAC5J6nTwFztOTve4UbKh7xYF4lnNvj3XBxClg3E
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="395194864"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="395194864"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 13:49:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="19840129"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 25 Dec 2023 13:49:04 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHsoo-000Dhp-1Q;
	Mon, 25 Dec 2023 21:49:02 +0000
Date: Tue, 26 Dec 2023 05:48:55 +0800
From: kernel test robot <lkp@intel.com>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Marc Zyngier <maz@kernel.org>, Fuad Tabba <tabba@google.com>
Subject: arch/arm64/kvm/arm.c:52:1: sparse: sparse: symbol
 '__pcpu_scope_kvm_arm_hyp_stack_page' was not declared. Should it be static?
Message-ID: <202312260529.UmEBsG7W-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   861deac3b092f37b2c5e6871732f3e11486f7082
commit: db129d486ebdf4e3168282236f9d9008b42cac7e KVM: arm64: Implement non-protected nVHE hyp stack unwinder
date:   1 year, 5 months ago
config: arm64-randconfig-r112-20231117 (https://download.01.org/0day-ci/archive/20231226/202312260529.UmEBsG7W-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231226/202312260529.UmEBsG7W-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312260529.UmEBsG7W-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/arm64/kvm/arm.c:52:1: sparse: sparse: symbol '__pcpu_scope_kvm_arm_hyp_stack_page' was not declared. Should it be static?

vim +/__pcpu_scope_kvm_arm_hyp_stack_page +52 arch/arm64/kvm/arm.c

    51	
  > 52	DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
    53	unsigned long kvm_arm_hyp_percpu_base[NR_CPUS];
    54	DECLARE_KVM_NVHE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
    55	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

