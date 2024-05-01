Return-Path: <linux-kernel+bounces-164933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6608B8529
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DF251F22D31
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 05:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B551A3FB1E;
	Wed,  1 May 2024 05:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MYmYdORC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9E93D968;
	Wed,  1 May 2024 05:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714539612; cv=none; b=XOsqZJX/hSLKC57H+oQjuWwhSFt+tzs5oKd3/CzOI/LLjOu8LoMZaPzmw48Q2rgi3e9UKSaPnorAsWcqI18lefaKvlLS2TOWCu3jeND3jM1iVCCmCESVQrvihgwh3Xx8Exj0csGTSQS2loUX/2RID3+0xtZb3GOBfMC3KPF1UEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714539612; c=relaxed/simple;
	bh=xGgIRf+AUlgNu4Hmw4Eq+u2jwmcGNa54lIyE8XYNIqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5Hdx1ViQupgJe0Xdfm4opL+W6b0g2CiBnfWY8ztg1MlrLqM4fiRvpnKt9rvpOuWX1q5s8z6Zan3swKIh0QTFzQqjfbV8tmcIMh4EUbjpE4jkT3A9xImSubLUEjFzHWgEn1PNWp99gYCdu1rwGq4N9WbuYSzFXaIqKoJPU7LpkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MYmYdORC; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714539609; x=1746075609;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xGgIRf+AUlgNu4Hmw4Eq+u2jwmcGNa54lIyE8XYNIqg=;
  b=MYmYdORCgQn6SitgMANP13TVgocwFSiYzJ7spSXysQIaOxrHFfHtZ177
   ekAdZDz5sRhiDrOs2SWJBvVPtZHKzM7N3H+ovhaH0yUKMG3Ap6OnGTMTL
   qC90LQJAy0NktH6q7hndX89ZGEPdtSLgsn5Qs9VjgCPROe4x11nckmITK
   Ep/wC7jV8seqytdLA8LQSRcC9BfIQ/UYV0g4Hy2Qw9qd80pAJpevzrOwG
   AV0vQz9LA2Pu6j2ve049aX8DXM+OqAsHEpKE+lDp4eJ8jDajfAkCBmIad
   Z4yRZahG4MGN6f7A99Eb4qz4LzjVylVQxdT85363Dq/2f/x0Wf9W4iOIR
   Q==;
X-CSE-ConnectionGUID: gSHdX6hmSuGDmCn/WpyjJw==
X-CSE-MsgGUID: T+ddMySpRoKrTMMnwvm34g==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="21685689"
X-IronPort-AV: E=Sophos;i="6.07,244,1708416000"; 
   d="scan'208";a="21685689"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 22:00:09 -0700
X-CSE-ConnectionGUID: sCXbPdPwQy6s9UjquLETkw==
X-CSE-MsgGUID: d8ABBAZJQOK+XCc+ZhXLFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,244,1708416000"; 
   d="scan'208";a="31479719"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 30 Apr 2024 22:00:07 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s224b-0008rn-03;
	Wed, 01 May 2024 05:00:05 +0000
Date: Wed, 1 May 2024 12:59:21 +0800
From: kernel test robot <lkp@intel.com>
To: skseofh@gmail.com, robh@kernel.org, saravanak@google.com,
	rppt@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daero Lee <daero_le.lee@samsung.com>
Subject: Re: [PATCH] of: of_reserved_mem: clean-up reserved memory with no-map
Message-ID: <202405011208.qsZQwChO-lkp@intel.com>
References: <20240428125505.434962-1-skseofh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240428125505.434962-1-skseofh@gmail.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.9-rc6 next-20240430]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/skseofh-gmail-com/of-of_reserved_mem-clean-up-reserved-memory-with-no-map/20240430-144643
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240428125505.434962-1-skseofh%40gmail.com
patch subject: [PATCH] of: of_reserved_mem: clean-up reserved memory with no-map
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240501/202405011208.qsZQwChO-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240501/202405011208.qsZQwChO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405011208.qsZQwChO-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/of/of_reserved_mem.c:95:4: warning: non-void function 'early_init_dt_reserve_memory' should return a value [-Wreturn-type]
                           return;
                           ^
   1 warning generated.


vim +/early_init_dt_reserve_memory +95 drivers/of/of_reserved_mem.c

    80	
    81	static int __init early_init_dt_reserve_memory(phys_addr_t base,
    82						       phys_addr_t size, bool nomap)
    83	{
    84		if (nomap) {
    85			/*
    86			 * If the memory is already reserved (by another region), we
    87			 * should not allow it to be marked nomap, but don't worry
    88			 * if the region isn't memory as it won't be mapped.
    89			 */
    90			if (memblock_overlaps_region(&memblock.memory, base, size) &&
    91			    memblock_is_region_reserved(base, size))
    92				return -EBUSY;
    93	
    94			if (memblock_mark_nomap(base, size))
  > 95				return;
    96		}
    97		return memblock_reserve(base, size);
    98	}
    99	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

