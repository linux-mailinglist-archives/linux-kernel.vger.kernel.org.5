Return-Path: <linux-kernel+bounces-164855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B13E98B8403
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 03:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69EA828435B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 01:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EB84400;
	Wed,  1 May 2024 01:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R+eT8Iqq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5654C66;
	Wed,  1 May 2024 01:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714527768; cv=none; b=gFfcwJvk28t0G+o7+QcLEOpnHV9M90hd0kTayQ3uRq11enyRuyhrglm0rdWCdg+auMwZheIU1z71r3nc7WN+bHmpFVD/90ZYY+SIEfLimFjjeM6salLj1f3zA++2MmalZY8zV+UQON8CcXFoBdsWHGMBlnEhvezah0HYTgrNZ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714527768; c=relaxed/simple;
	bh=NXfYsGE9+CDW89d7BYlqMr64teyBUpwW1AwfylRDXJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Doo/6VM9FbMhPxrSGdLoqpJEemreqhYqrVB4OLN2N6Dz4qiSLzDbY9IwQUu4pH/Q2IuIFdW6DPS/T6lUMKCAGKtdAqj0Ohdu/d6TmR3hDy3jfVeeqM7DM7Lr2DmJtbG6q0YnZ7QMiMc/om1BNGMJtYicp2xJkmBS1btvnTMx3Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R+eT8Iqq; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714527766; x=1746063766;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NXfYsGE9+CDW89d7BYlqMr64teyBUpwW1AwfylRDXJI=;
  b=R+eT8IqqgRrFicJ30CKOiz44C8AUPvyx+gjOzKkGBJRdMXtZMgMdDpx/
   WBWZknjguW2yeTmHWJHhV94IxGCuT6sJOL2kZniDshgfkG1XHvuN1hNse
   lNmCci0vGGycwP8SE98lY09g1BfPdcyYN7F3HgSrZ0wplrCgC0sWqzJau
   ug7vrU7+7NAb6KaK81vIH/YELFQRzondxaVTmeFtwiVZyfzlgMsasu6lh
   iMEIIJTASV/HoHTBrXDTV+/663d0IZCaDQMETO32VsFEyyZMEMVh736kT
   uytg8usucv0L5FZyOZsSilF41ILKuK5h2P2hdFc6u1OjDSS9a4iJBVkgL
   w==;
X-CSE-ConnectionGUID: L7AVYFYpSPivopraYDzqRQ==
X-CSE-MsgGUID: SSv0vgmNRrmrdjX1gVGnlQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="35648203"
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="35648203"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 18:40:04 -0700
X-CSE-ConnectionGUID: zR9ugFEtRN6HDdbKAUjQWg==
X-CSE-MsgGUID: UfaCz3N4Sxq+/TNXPh5m7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="64144628"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 30 Apr 2024 18:40:01 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s1ywx-0008kB-0f;
	Wed, 01 May 2024 01:39:59 +0000
Date: Wed, 1 May 2024 09:39:23 +0800
From: kernel test robot <lkp@intel.com>
To: skseofh@gmail.com, robh@kernel.org, saravanak@google.com,
	rppt@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Daero Lee <daero_le.lee@samsung.com>
Subject: Re: [PATCH] of: of_reserved_mem: clean-up reserved memory with no-map
Message-ID: <202405010907.PHM9xSMi-lkp@intel.com>
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
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20240501/202405010907.PHM9xSMi-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240501/202405010907.PHM9xSMi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405010907.PHM9xSMi-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/of/of_reserved_mem.c: In function 'early_init_dt_reserve_memory':
>> drivers/of/of_reserved_mem.c:95:25: warning: 'return' with no value, in function returning non-void [-Wreturn-type]
      95 |                         return;
         |                         ^~~~~~
   drivers/of/of_reserved_mem.c:81:19: note: declared here
      81 | static int __init early_init_dt_reserve_memory(phys_addr_t base,
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/return +95 drivers/of/of_reserved_mem.c

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

