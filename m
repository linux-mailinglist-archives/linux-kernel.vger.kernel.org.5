Return-Path: <linux-kernel+bounces-1210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6010C814BB0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDC1DB214F6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4423237176;
	Fri, 15 Dec 2023 15:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LMBKxCGH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E546364D8
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 15:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702653893; x=1734189893;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yH7pJArHhMyDIDxZ3CICiPrVXTkVYrLh/AfQlMjPxOk=;
  b=LMBKxCGH1Cb0cR2qxpW3sVEeqG8Sso3SymkRcTmW43TkqsaMm4TDcwLP
   eaPcF+qa28PnhkzdynG4FjnCcr5nt9FOETfmyKn2Ff7FSKhyDxkYzqfXE
   aOzaDVeLBIJefKK+wyjVO5kPIyK6peM5Wz5QLq1ibQD2k+XyePCw/05kB
   jst2MGlvlihbASzgTDFt7H6HPTq0TedSjsJEnYjnpw9Y1u1NdFwK263py
   Ifc3Om/tJ7XI9Kv5AZJsDO6M9bXA5yfRwh3jVhkVFZ6KESgCMNVNHXprm
   yNjXoQaMu1ywYW9K5TuOJopDpfSd1ZcZn5VOAh0o9Tb1HDVYrwPfpGXO3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="8646433"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="8646433"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:24:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="840694242"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="840694242"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 15 Dec 2023 07:24:43 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEA3M-0000Mc-2q;
	Fri, 15 Dec 2023 15:24:40 +0000
Date: Fri, 15 Dec 2023 23:24:21 +0800
From: kernel test robot <lkp@intel.com>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Marc Zyngier <maz@kernel.org>, Fuad Tabba <tabba@google.com>
Subject: arch/arm64/kvm/hyp/nvhe/stacktrace.c:10:1: sparse: sparse: symbol
 '__pcpu_scope_overflow_stack' was not declared. Should it be static?
Message-ID: <202312152318.irx4BVyi-lkp@intel.com>
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
commit: 548ec3336f323db56260b312c232ab37285f0284 KVM: arm64: On stack overflow switch to hyp overflow_stack
date:   1 year, 5 months ago
config: arm64-randconfig-r112-20231117 (https://download.01.org/0day-ci/archive/20231215/202312152318.irx4BVyi-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231215/202312152318.irx4BVyi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312152318.irx4BVyi-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/arm64/kvm/hyp/nvhe/stacktrace.c:10:1: sparse: sparse: symbol '__pcpu_scope_overflow_stack' was not declared. Should it be static?

vim +/__pcpu_scope_overflow_stack +10 arch/arm64/kvm/hyp/nvhe/stacktrace.c

     9	
  > 10	DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)], overflow_stack)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

