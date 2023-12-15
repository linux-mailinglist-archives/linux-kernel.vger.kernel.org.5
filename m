Return-Path: <linux-kernel+bounces-1661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 640098151AC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4D43B2336D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 21:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7289256393;
	Fri, 15 Dec 2023 21:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CAiO43n6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647D949F7E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 21:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702674686; x=1734210686;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=73V91GoV1H8usB4OfHXnPDk6fIOp5q9JXo1ugLiO5G4=;
  b=CAiO43n6+pCMU2943ilRvfMr/BSMTmF51CCHElQoS9QwFctVb8gQUChV
   bofHicKHLvNZ3UcEuKVdKZRu2dTEby9+QMcNP/O8nYPpcFLEGVJU56cv6
   EndXZyFztegyBIi7Fuh6Wt4rgwrJVUIu9jWcxF8NZ0zgCkM/1xQibll67
   A1HpqxQyv9gRGj8TAYL949GS3ddT4SWyEH1KO/9ObwrJcg+ktiMNBaIwk
   hruxk4dupxtV6hbkr3QxW9LKMnnlKOJIK6uvkY7iDDxOs6VdZxst/dUzd
   CDoRuFDRV5IsurwyKfFpEWj0csU9AuFfNBiVqG08pGzaj/B6YEr4+5Qkb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="380325707"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="380325707"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 13:11:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="840787678"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="840787678"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 15 Dec 2023 13:11:24 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEFSr-0000lm-2V;
	Fri, 15 Dec 2023 21:11:21 +0000
Date: Sat, 16 Dec 2023 05:11:12 +0800
From: kernel test robot <lkp@intel.com>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Marc Zyngier <maz@kernel.org>, Fuad Tabba <tabba@google.com>
Subject: arch/arm64/kvm/arm.c:52:1: sparse: sparse: symbol
 '__pcpu_scope_kvm_arm_hyp_stack_page' was not declared. Should it be static?
Message-ID: <202312160504.mmbGlWvN-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3f7168591ebf7bbdb91797d02b1afaf00a4289b1
commit: db129d486ebdf4e3168282236f9d9008b42cac7e KVM: arm64: Implement non-protected nVHE hyp stack unwinder
date:   1 year, 5 months ago
config: arm64-randconfig-r112-20231117 (https://download.01.org/0day-ci/archive/20231216/202312160504.mmbGlWvN-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231216/202312160504.mmbGlWvN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312160504.mmbGlWvN-lkp@intel.com/

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

