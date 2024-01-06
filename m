Return-Path: <linux-kernel+bounces-18693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A93FD82611E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 19:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDCA3283766
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 18:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2353DDDCE;
	Sat,  6 Jan 2024 18:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YVnwx9S8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CA9DDD0
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 18:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704566166; x=1736102166;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ICS92sbB1/1x+lo2Aj30UTbltsE+tini1b/jh30UYBY=;
  b=YVnwx9S85rHC6Tq+uHGozEkNTkbBAhfmWtgyGUPWJdFmGiQDtLzcU2go
   P53wZgPLau2jwjJYWv2WsebladNT+Utme/SJvMvlZQcwvy/9XgT75MSC2
   RUvKctldBMbI0mUbZwh3PEUVHjnj/nqNWM8issq2OCNCaIlkb3pZNIhHb
   m/O6vlxgx2TKla1Jwt+Du/FJNN4tdI6/VR3RM05mosGJRKE+/cjEY+noB
   kRUgG2TRx2AJWWSj0ROmG3RROF6+nsXQc7UBJEO/RkGY8eBtaeMLaT9l/
   fnmigi4HqgXcHNOtHKp4fvDgPNdcVXEfTrxKCM/VoWj2FpXlkoaMQJWXa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="401454880"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="401454880"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 10:36:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="22781219"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 06 Jan 2024 10:36:04 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMBWb-0002se-0T;
	Sat, 06 Jan 2024 18:36:01 +0000
Date: Sun, 7 Jan 2024 02:35:04 +0800
From: kernel test robot <lkp@intel.com>
To: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
	Serge Ayoun <serge.ayoun@intel.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Subject: arch/x86/kernel/cpu/sgx/main.c:124: warning: Function parameter or
 member 'low' not described in 'sgx_calc_section_metric'
Message-ID: <202401070210.pQcalZHm-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Sean,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   95c8a35f1c017327eab3b6a2ff5c04255737c856
commit: e7e0545299d8cb0fd6fe3ba50401b7f5c3937362 x86/sgx: Initialize metadata for Enclave Page Cache (EPC) sections
date:   3 years, 2 months ago
config: x86_64-buildonly-randconfig-006-20240105 (https://download.01.org/0day-ci/archive/20240107/202401070210.pQcalZHm-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240107/202401070210.pQcalZHm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401070210.pQcalZHm-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/cpu/sgx/main.c:124: warning: Function parameter or member 'low' not described in 'sgx_calc_section_metric'
>> arch/x86/kernel/cpu/sgx/main.c:124: warning: Function parameter or member 'high' not described in 'sgx_calc_section_metric'
>> arch/x86/kernel/cpu/sgx/main.c:124: warning: expecting prototype for A section metric is concatenated in a way that @low bits 12(). Prototype was for sgx_calc_section_metric() instead


vim +124 arch/x86/kernel/cpu/sgx/main.c

   117	
   118	/**
   119	 * A section metric is concatenated in a way that @low bits 12-31 define the
   120	 * bits 12-31 of the metric and @high bits 0-19 define the bits 32-51 of the
   121	 * metric.
   122	 */
   123	static inline u64 __init sgx_calc_section_metric(u64 low, u64 high)
 > 124	{
   125		return (low & GENMASK_ULL(31, 12)) +
   126		       ((high & GENMASK_ULL(19, 0)) << 32);
   127	}
   128	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

