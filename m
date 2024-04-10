Return-Path: <linux-kernel+bounces-137938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB6F89E9D5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF97AB21D4C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 05:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB55F17552;
	Wed, 10 Apr 2024 05:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MXLI7F6C"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA3728FD
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 05:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712727398; cv=none; b=flT2pttIch3Wyvf7XbYoXkYVF/7xv32XKrZOkXHy96qKqpXpCLxGcbgmPZMt9yJRBCp7+EBBDAdlXYXcWwva8gXoc3shp2uzA4GKA3MJsaa7+PNOXNhV/CwUpJZaVkua1nDcHvx178EZF/RhBixU00u8SZ8h8pwMu5hBUS/qKUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712727398; c=relaxed/simple;
	bh=EO1RBHypSAPV6U5wSUJ/fjuGIi2TFMB6oXiotf9PEYE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=bC+iBeQCaZPXzcjooj4HYsdZyxYLQ/okl5m1FrgmAaWkyo0FXRRLXs4mnJLpbIPISvWo6AMo1CER8LKphc4+/08DaGREYac81vHjjiBwJKwHxIQQ5Boy2SftfFJfQmA10SSOjIko/osDBFTHYD/NDb+YoJxyERB8e/hSKgS4Hz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MXLI7F6C; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712727397; x=1744263397;
  h=date:from:to:cc:subject:message-id;
  bh=EO1RBHypSAPV6U5wSUJ/fjuGIi2TFMB6oXiotf9PEYE=;
  b=MXLI7F6CADIBm3oKwr6lkbO2f0WvwCq4U5JG5V/y4x8uHGEE/A9GdV6f
   rmSLPY4yJd08PyaxL7EdqxDOuWbD9XulKK7b8s5G8uBYs6gb0ZMsEf07a
   IfgRcrPuIsbSzuxV8jtNRh8KtD+jMF8SBURI2ZluBt4HT+B3BWkHqMnBy
   e1PtGH9fvzG2N923B/zDHYg9+HmPtl0PZk/QKNApyWppLfze5F/16jmxE
   j5a25rdXRHlKShqBMvZ3qhH6HsTCku77YH9zdtZG4RLhdW9a3Mqnnyarg
   SBNC//Y8lGKkkcBuKWmZFn1hFLSyDqiE1oUIGFfcWu+365oILAZbB6STK
   Q==;
X-CSE-ConnectionGUID: lCguT1+IR92xWubtqJy7VA==
X-CSE-MsgGUID: bLbWweT3RWCQBZ182s9dBA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11911760"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="11911760"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 22:36:36 -0700
X-CSE-ConnectionGUID: bEqjei8jSwOoB74K5aXNfQ==
X-CSE-MsgGUID: hrYplIjuTzmKKU5DEZGszw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="43698938"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 09 Apr 2024 22:36:35 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ruQdM-0006xQ-2W;
	Wed, 10 Apr 2024 05:36:32 +0000
Date: Wed, 10 Apr 2024 13:35:59 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/alternatives] BUILD SUCCESS
 05d277c9a9023e11d2f30a994bde08b854af52a0
Message-ID: <202404101357.v8ufXuWN-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/alternatives
branch HEAD: 05d277c9a9023e11d2f30a994bde08b854af52a0  x86/alternatives: Sort local vars in apply_alternatives()

elapsed time: 740m

configs tested: 32
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386                                defconfig   clang
powerpc                        cell_defconfig   gcc  
riscv                               defconfig   clang
riscv             nommu_k210_sdcard_defconfig   gcc  
s390                             alldefconfig   gcc  
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                               allyesconfig   gcc  
sh                               j2_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                           se7712_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

