Return-Path: <linux-kernel+bounces-18779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2978262EA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 06:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3269282C36
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 05:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C4A11CBC;
	Sun,  7 Jan 2024 05:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bVNOm8LT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A3811C8B
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 05:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704603790; x=1736139790;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CoFNLKlm/5r1N1k1P2Xmeg/AaJyqFGTXkUG7NXUgJfg=;
  b=bVNOm8LTNYFnvy+EA7Iz0QTofbULrxNo02WK1ft5o2YUWLtCRrTil8IR
   Q87jKRjUuesWKgwMgfxitnf+thLceyp5jRwLvjHpoTJVhtKjpvN24yHbm
   RoXu87C2y7JOvMDDRd0f4b6s0rB3n8XDnjLLJjwVgpLn+6GkpHGY9PjEB
   6DEJm5sNWqVcdq/f0HDShPRkLpUjKUqK45gCli1iNO9wSDT4coPDPQm1q
   k3AzzKcc3voXRcDR/hKgVJB5hJIj4u6yp4seAsMtxZ5IZJFzPNsjvRq3m
   Kf1KAr7IuHjQcwGWad66GrXrSOHBlSKAHSOQVW4jUO1yWLFK9mkD2M1NA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="396587329"
X-IronPort-AV: E=Sophos;i="6.04,338,1695711600"; 
   d="scan'208";a="396587329"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 21:02:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="1112444844"
X-IronPort-AV: E=Sophos;i="6.04,338,1695711600"; 
   d="scan'208";a="1112444844"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 06 Jan 2024 21:02:49 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMLJ9-0003OK-0q;
	Sun, 07 Jan 2024 05:02:47 +0000
Date: Sun, 7 Jan 2024 13:02:27 +0800
From: kernel test robot <lkp@intel.com>
To: Alexei Starovoitov <ast@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: kernel/bpf/trampoline.c:9:31: sparse: sparse: symbol
 'bpf_extension_verifier_ops' was not declared. Should it be static?
Message-ID: <202401071250.XKU9ZxU4-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   52b1853b080a082ec3749c3a9577f6c71b1d4a90
commit: be8704ff07d2374bcc5c675526f95e70c6459683 bpf: Introduce dynamic program extensions
date:   4 years ago
config: x86_64-randconfig-121-20240106 (https://download.01.org/0day-ci/archive/20240107/202401071250.XKU9ZxU4-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240107/202401071250.XKU9ZxU4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401071250.XKU9ZxU4-lkp@intel.com/

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

