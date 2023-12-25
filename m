Return-Path: <linux-kernel+bounces-10883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0E581DE06
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 04:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66ADAB20E94
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 03:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE386ED1;
	Mon, 25 Dec 2023 03:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aZw1+YyN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BA0A51
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 03:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703476297; x=1735012297;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MMJdGmzHx00PxSu218IQ7Zqzm4US9C+yf1v+i0TeyCk=;
  b=aZw1+YyN2XdrAeOo6ifi/OsViy/YPPYJjJbnImD3DhyhNFJ+Gl2oiNxc
   dnfbdwC+HGzfmi6hMTI3oArQUMWn5cXLeOib0fxVztMlU4E8IRjzM/Y/r
   3uR1I3sVL2i+GwAwwPjkZroyxFJWwBOYj+Kc5uz88mmTcjLkpNFEQFjNI
   7t/Z4PhUu2NMyWSMHJnv4EOuDbnvbIJMP+Q5q5aR1ni/JpOeB0SQ2FUvZ
   L2rsq2dMVsL4hBqZ2HkKKvmaYFm6YmhPYDr8NlHtkKiYmhhQOI9K5blwT
   gL1jH2gBJq2QiMa28lqpyKLZs0aO9JBWX1gsH5I96XaVMb1iajbS+n0U3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="460592872"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="460592872"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 19:51:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="901099648"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="901099648"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 24 Dec 2023 19:51:15 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHbzg-000Ctb-0F;
	Mon, 25 Dec 2023 03:51:10 +0000
Date: Mon, 25 Dec 2023 11:50:14 +0800
From: kernel test robot <lkp@intel.com>
To: Andi Kleen <ak@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: arch/x86/kernel/kvm.c:70:1: sparse: sparse: symbol
 '__pcpu_scope_steal_time' was not declared. Should it be static?
Message-ID: <202312251110.VDvI8CSS-lkp@intel.com>
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
commit: 14e581c381b942ce5463a7e61326d8ce1c843be7 x86/kvm: Make steal_time visible
date:   4 years, 8 months ago
config: x86_64-randconfig-122-20231101 (https://download.01.org/0day-ci/archive/20231225/202312251110.VDvI8CSS-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231225/202312251110.VDvI8CSS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312251110.VDvI8CSS-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/x86/kernel/kvm.c:70:1: sparse: sparse: symbol '__pcpu_scope_steal_time' was not declared. Should it be static?

vim +/__pcpu_scope_steal_time +70 arch/x86/kernel/kvm.c

    68	
    69	static DEFINE_PER_CPU_DECRYPTED(struct kvm_vcpu_pv_apf_data, apf_reason) __aligned(64);
  > 70	DEFINE_PER_CPU_DECRYPTED(struct kvm_steal_time, steal_time) __aligned(64) __visible;
    71	static int has_steal_clock = 0;
    72	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

