Return-Path: <linux-kernel+bounces-10908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF6B81DEA6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 07:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D55028199C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 06:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBC52580;
	Mon, 25 Dec 2023 06:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B/5dcEpz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC001C2E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 06:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703486807; x=1735022807;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IQv6tyECz8xdfgIfqsT1mI3NoKH7Aa/6U4bIYpS+4Js=;
  b=B/5dcEpz+8CsFnhv9am2qJkOcEh/Q7HMkfODzJoQ0SmxuVZ7UUxc5fba
   04fRsqhlzT9KTq2NxHv90yljwYbVqmonggAPRRoAOuSzBEuVj0JP7c/6r
   wdi26t07TJ0fthfS0Uf5qOJngvrdTExs4nD2w+/EPouJbxixdSIYeaTS+
   /0kFnMh+GdrNQbPOFDJKpWMDSFsq0N5w91L66e5fQsNIc6Y0XG4yUjJVH
   AtHaWdw+EmPXrPuMEECOtXHHpzIDjXfRZUUfEZbLw0Rp9+5fP3FpU4peq
   S3jImOdspnCVRLmQflu/APod09sNUKeFUs346m6J22IM/sjWXW6GzlIX3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="9791248"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="9791248"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 22:46:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="19380811"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 24 Dec 2023 22:46:45 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHejV-000D3J-1r;
	Mon, 25 Dec 2023 06:46:39 +0000
Date: Mon, 25 Dec 2023 14:45:57 +0800
From: kernel test robot <lkp@intel.com>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Marc Zyngier <maz@kernel.org>, Fuad Tabba <tabba@google.com>
Subject: arch/arm64/kvm/hyp/nvhe/stacktrace.c:15:1: sparse: sparse: symbol
 '__pcpu_scope_kvm_stacktrace_info' was not declared. Should it be static?
Message-ID: <202312251401.gspRxsAI-lkp@intel.com>
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
commit: 879e5ac7b2e4db05799a905b5a07fc9e5dedf651 KVM: arm64: Prepare non-protected nVHE hypervisor stacktrace
date:   1 year, 5 months ago
config: arm64-randconfig-r112-20231117 (https://download.01.org/0day-ci/archive/20231225/202312251401.gspRxsAI-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231225/202312251401.gspRxsAI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312251401.gspRxsAI-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   arch/arm64/kvm/hyp/nvhe/stacktrace.c:12:1: sparse: sparse: symbol '__pcpu_scope_overflow_stack' was not declared. Should it be static?
>> arch/arm64/kvm/hyp/nvhe/stacktrace.c:15:1: sparse: sparse: symbol '__pcpu_scope_kvm_stacktrace_info' was not declared. Should it be static?

vim +/__pcpu_scope_kvm_stacktrace_info +15 arch/arm64/kvm/hyp/nvhe/stacktrace.c

    11	
  > 12	DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)], overflow_stack)
    13		__aligned(16);
    14	
  > 15	DEFINE_PER_CPU(struct kvm_nvhe_stacktrace_info, kvm_stacktrace_info);
    16	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

