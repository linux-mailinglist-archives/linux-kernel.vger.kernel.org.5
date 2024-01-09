Return-Path: <linux-kernel+bounces-20441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8BF827F02
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E73028394F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49B78F60;
	Tue,  9 Jan 2024 07:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VnH0keTR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444388F40
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 07:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704783872; x=1736319872;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sepT+bLKeypOOuYySm53nhbgI1LOrNXMDgtSjredRGs=;
  b=VnH0keTRJXO1H394JW2smjHJvmwDYIdP23Bl7ZLx0So7YjfdUZKd8316
   wPUuINWeOYiNApPaPXsew6p4QSKcMEMzUQQb8fmBCdAavsIY8JsBQ0Zow
   AC4Zokh779tIKgNfvwBuSxih4eAju/0oWG8r97PGwkPbbI1MiwkOrDJeh
   hMA5fPeWeasJqQaeVMJBcKldFaJCc65ltfC4pp/BcnsbknM+t2ktCZkBT
   E0PDIA6DZBm3rURbBZxLjwIxxPKf4NV8Kei6mUV1OfWN3eLDs7SxWbZQY
   ZhoXI1GhtiWgrUL/r/K+AAJt9r5L2zBz6QuczyHmlgdfurNfAuOTaWHDz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="19614313"
X-IronPort-AV: E=Sophos;i="6.04,182,1695711600"; 
   d="scan'208";a="19614313"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 23:04:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="1112969960"
X-IronPort-AV: E=Sophos;i="6.04,182,1695711600"; 
   d="scan'208";a="1112969960"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 08 Jan 2024 23:04:30 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rN6A0-0005Yk-0D;
	Tue, 09 Jan 2024 07:04:28 +0000
Date: Tue, 9 Jan 2024 15:03:55 +0800
From: kernel test robot <lkp@intel.com>
To: Alexei Starovoitov <ast@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: kernel/bpf/trampoline.c:9:31: sparse: sparse: symbol
 'bpf_extension_verifier_ops' was not declared. Should it be static?
Message-ID: <202401091418.BRAmbw4Y-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9f8413c4a66f2fb776d3dc3c9ed20bf435eb305e
commit: be8704ff07d2374bcc5c675526f95e70c6459683 bpf: Introduce dynamic program extensions
date:   4 years ago
config: x86_64-randconfig-121-20240106 (https://download.01.org/0day-ci/archive/20240109/202401091418.BRAmbw4Y-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240109/202401091418.BRAmbw4Y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401091418.BRAmbw4Y-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/bpf/trampoline.c:9:31: sparse: sparse: symbol 'bpf_extension_verifier_ops' was not declared. Should it be static?
>> kernel/bpf/trampoline.c:11:27: sparse: sparse: symbol 'bpf_extension_prog_ops' was not declared. Should it be static?
   kernel/bpf/trampoline.c:320:9: sparse: sparse: context imbalance in '__bpf_prog_enter' - wrong count at exit
   kernel/bpf/trampoline.c: note: in included file (through include/linux/workqueue.h, include/linux/bpf.h):
   include/linux/rcupdate.h:669:9: sparse: sparse: context imbalance in '__bpf_prog_exit' - unexpected unlock

vim +/bpf_extension_verifier_ops +9 kernel/bpf/trampoline.c

     7	
     8	/* dummy _ops. The verifier will operate on target program's ops. */
   > 9	const struct bpf_verifier_ops bpf_extension_verifier_ops = {
    10	};
  > 11	const struct bpf_prog_ops bpf_extension_prog_ops = {
    12	};
    13	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

