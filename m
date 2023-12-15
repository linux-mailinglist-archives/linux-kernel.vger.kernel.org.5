Return-Path: <linux-kernel+bounces-951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F7281486E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28FEA1F245B2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9192C6B8;
	Fri, 15 Dec 2023 12:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Shn0gYuo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114502DB75
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 12:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702644685; x=1734180685;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Qitsnoe4czQzS8dI93mK8gLEVhXQMpYmjWDPRKPtpOY=;
  b=Shn0gYuoiFgZ2NdcWGqkz9WPeqGAUIH8Ffw2UvmHaOUAfyziGK5RM8cr
   zvl01Ewt/Y/opARDQEaesLQaNWkVNxZJkGPaCivhiV7UqM/xf2wKo+/WZ
   7VQDcdo3cRrj74f6piIdxcnmeHh5hb6i5DyF90W9/5fGgnjHan5AOw5Z0
   bi04srLHzR8ykUEfSZLkaYRCpsU31TYLi/sa31jdU8PBLTAzzXtxNlsL6
   F4dPGKfj+tu5D9iiNOhEjn3oYbMGIduxQb+BwpHalFvfyuTIkbXU5rauo
   wxyl/CdWmqu1KY0icaC3q+bwXH06HnNJhx6EVm8NE68ddgSekyETp9I8t
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="380266703"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="380266703"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 04:51:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="898128676"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="898128676"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 15 Dec 2023 04:51:23 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rE7ey-0000DQ-2s;
	Fri, 15 Dec 2023 12:51:20 +0000
Date: Fri, 15 Dec 2023 20:50:27 +0800
From: kernel test robot <lkp@intel.com>
To: Will Deacon <will@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/arm64/kernel/proton-pack.c:353:1: sparse: sparse: symbol
 '__pcpu_scope_arm64_ssbd_callback_required' was not declared. Should it be
 static?
Message-ID: <202312152025.1qeAzjCU-lkp@intel.com>
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
commit: 5c8b0cbd9d6bac5f40943b5a7d8eac8cb86cbe7f arm64: Pull in task_stack_page() to Spectre-v4 mitigation code
date:   3 years, 3 months ago
config: arm64-randconfig-r112-20231117 (https://download.01.org/0day-ci/archive/20231215/202312152025.1qeAzjCU-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231215/202312152025.1qeAzjCU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312152025.1qeAzjCU-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/arm64/kernel/proton-pack.c:353:1: sparse: sparse: symbol '__pcpu_scope_arm64_ssbd_callback_required' was not declared. Should it be static?

vim +/__pcpu_scope_arm64_ssbd_callback_required +353 arch/arm64/kernel/proton-pack.c

c28762070ca651 Will Deacon 2020-09-18  351  
c28762070ca651 Will Deacon 2020-09-18  352  /* This is the per-cpu state tracking whether we need to talk to firmware */
c28762070ca651 Will Deacon 2020-09-18 @353  DEFINE_PER_CPU_READ_MOSTLY(u64, arm64_ssbd_callback_required);
c28762070ca651 Will Deacon 2020-09-18  354  

:::::: The code at line 353 was first introduced by commit
:::::: c28762070ca651fe7a981b8f31d972c9b7d2c386 arm64: Rewrite Spectre-v4 mitigation code

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

