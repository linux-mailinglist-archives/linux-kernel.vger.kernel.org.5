Return-Path: <linux-kernel+bounces-2191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3F9815927
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 14:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D321AB2149B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 13:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F6118ECC;
	Sat, 16 Dec 2023 13:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HmSBuDHY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0BD30328
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 13:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702731640; x=1734267640;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pPhv7hbEtV2klsAVYYae6ssgIimkXUCBhsJTOx6lO48=;
  b=HmSBuDHYXc0IOnPHcJPXUH7oRBGg6iSL+ZiEipl8t0zwSuSEXeiZlchh
   5fSbM8RsD5BLRsd1oauXQxf2+IkBzsVQmBP2+whmdBLCST6ZbNabEmg6K
   hWXXuxgOoMk2grQEWS4ExBUdaAxj8ugPwDLWETt/K+2fzzvKEQUaWY6jW
   fl5XRMa8/28HDGdTZkqroL1tvVd7jmUEsLqDrQ8kuqJJKV2mlZ1PxKTAa
   i4U3FgsueLYcVDzOEkJ5ZHtHJ6ImUWIvieMxsjWK8Vy9D8Tml5lMjuXYP
   2+bW7GIEcNo73Xr2dOuTX4qe1JB5WLB1QK0FYbygPcZlKGNtk9rQE26it
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="16929483"
X-IronPort-AV: E=Sophos;i="6.04,281,1695711600"; 
   d="scan'208";a="16929483"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2023 05:00:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="809279374"
X-IronPort-AV: E=Sophos;i="6.04,281,1695711600"; 
   d="scan'208";a="809279374"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 16 Dec 2023 05:00:38 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEUHU-0001bm-0w;
	Sat, 16 Dec 2023 13:00:36 +0000
Date: Sat, 16 Dec 2023 21:00:34 +0800
From: kernel test robot <lkp@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: powerpc.c:undefined reference to `kvm_set_irq'
Message-ID: <202312162045.MByX2xeH-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c8e97fc6b4c057a350a9e9a1ad625e10cc9c39ee
commit: d663b8a285986072428a6a145e5994bc275df994 KVM: replace direct irq.h inclusion
date:   1 year, 1 month ago
config: powerpc-randconfig-r005-20220102 (https://download.01.org/0day-ci/archive/20231216/202312162045.MByX2xeH-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231216/202312162045.MByX2xeH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312162045.MByX2xeH-lkp@intel.com/

All errors (new ones prefixed by >>):

   powerpc-linux-ld: arch/powerpc/sysdev/cpm_common.o: in function `udbg_init_cpm':
   cpm_common.c:(.init.text+0xc0): undefined reference to `setbat'
   powerpc-linux-ld: arch/powerpc/kvm/powerpc.o: in function `kvm_vm_ioctl_irq_line':
>> powerpc.c:(.text+0x4fec): undefined reference to `kvm_set_irq'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

