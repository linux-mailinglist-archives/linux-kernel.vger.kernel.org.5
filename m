Return-Path: <linux-kernel+bounces-164779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F97A8B82C6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 00:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B42AD1F22C6D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 22:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD448524D4;
	Tue, 30 Apr 2024 22:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U/pQYjHK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD4F17C6A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 22:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714517463; cv=none; b=tOTyTxFteydyH4s+Mqrqr9+JuDg6SityByFRJ3cqy0R7GP8bNwO7ryewi/m5/BwIL+XQEu/2iZ5iLMh/NlINhzqRjVmEr3JpyOPhhSV5nmH0n3JhSjiz1I3zPT3UQ5R/TQtRMPwgpMlDS4oJvmmStoHJonI0hHEXqstwgkSpd4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714517463; c=relaxed/simple;
	bh=QDc0/ZXmXrwa0tmWD5eIxdzIC3ZtGZAfru1mJNK9reE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=giWOgHFh8r/ajf/KPsgf68nzdnTxkoDcNZ94k3t314kjDbbi+e0eHlQB19JU5Tlf6TJ6kNXTALbLMWQE4pOYRbKZyxEjUZrRjfygxaaF5MFhSyE725UgnaispeHOf9jlaEGThqdNiYIIvur3LRqVD7GQwz2XxxeRieEDqwmaUbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U/pQYjHK; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714517462; x=1746053462;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QDc0/ZXmXrwa0tmWD5eIxdzIC3ZtGZAfru1mJNK9reE=;
  b=U/pQYjHKs4aTkOXMoGKVA4D0kwXo/Tr8xZc/aWsxnGgdvOPvhGn+U6kY
   e6SJ4uSeIS6RUFAPHRwr7ELc6mHj1jX6jWM+bx9HPW40FdeoyNEykJn8+
   KASZ1aL+MkC/tQGVptJnWTdPPkqdUMe4GS85NZF9oO5ZZX/VV3g661YyR
   llmXN6kRGe9zz33lSop5h93a3aHcU8tsYB6iHfj/s+b6IfVEETsVfhenR
   ZSrfW2bE3WbKAKn3AuC/rzzLgHaxs9Lz6Ltg1zDUxtCRLdIzWluQ+A/zQ
   uRC/jprySBsA6S6eq9LYquMiPKLl5EGGWx+aszpnIbvYsqyWl0VDAcepj
   w==;
X-CSE-ConnectionGUID: 1YiqbW6hQKqWHQX2rdwyow==
X-CSE-MsgGUID: HRAJTlkhQcaCINOk54Iltg==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="27695264"
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="27695264"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 15:51:01 -0700
X-CSE-ConnectionGUID: gsUoUHs4RjeDFGkQNsG+ig==
X-CSE-MsgGUID: +ShwWDgwQgyQSizh1t45qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="31409414"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 30 Apr 2024 15:50:58 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s1wJM-0008fF-0C;
	Tue, 30 Apr 2024 22:50:56 +0000
Date: Wed, 1 May 2024 06:50:25 +0800
From: kernel test robot <lkp@intel.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>, akpm@linux-foundation.org,
	yury.norov@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, linux@rasmusvillemoes.dk,
	linux-kernel@vger.kernel.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: Re: [PATCH v2 1/2] lib/find_bit_benchmark: Add benchmark test for
 fns()
Message-ID: <202405010642.tHmTpd1i-lkp@intel.com>
References: <20240430054912.124237-2-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430054912.124237-2-visitorckw@gmail.com>

Hi Kuan-Wei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.9-rc6 next-20240430]
[cannot apply to akpm-mm/mm-everything akpm-mm/mm-nonmm-unstable]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuan-Wei-Chiu/lib-find_bit_benchmark-Add-benchmark-test-for-fns/20240430-144241
base:   linus/master
patch link:    https://lore.kernel.org/r/20240430054912.124237-2-visitorckw%40gmail.com
patch subject: [PATCH v2 1/2] lib/find_bit_benchmark: Add benchmark test for fns()
config: i386-buildonly-randconfig-004-20240501 (https://download.01.org/0day-ci/archive/20240501/202405010642.tHmTpd1i-lkp@intel.com/config)
compiler: gcc-11 (Ubuntu 11.4.0-4ubuntu1) 11.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240501/202405010642.tHmTpd1i-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405010642.tHmTpd1i-lkp@intel.com/

All warnings (new ones prefixed by >>):

   lib/find_bit_benchmark.c: In function 'test_fns':
>> lib/find_bit_benchmark.c:154:35: warning: variable 'y' set but not used [-Wunused-but-set-variable]
     154 |         volatile unsigned long x, y;
         |                                   ^


vim +/y +154 lib/find_bit_benchmark.c

   148	
   149	static int __init test_fns(void)
   150	{
   151		const unsigned long round = 1000000;
   152		s64 time[BITS_PER_LONG + 1];
   153		unsigned int i, n;
 > 154		volatile unsigned long x, y;
   155	
   156		for (n = 0; n <= BITS_PER_LONG; n++) {
   157			time[n] = ktime_get();
   158			for (i = 0; i < round; i++) {
   159				x = get_random_long();
   160				y = fns(x, n);
   161			}
   162			time[n] = ktime_get() - time[n];
   163		}
   164	
   165		for (n = 0; n <= BITS_PER_LONG; n++)
   166			pr_err("fns: n = %2u: %12lld ns\n", n, time[n]);
   167	
   168		return 0;
   169	}
   170	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

