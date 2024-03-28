Return-Path: <linux-kernel+bounces-122277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B78D88F4A2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCF3A1C28B78
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AF3208B0;
	Thu, 28 Mar 2024 01:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n1iYHakG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540B33D7A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 01:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711589512; cv=none; b=lMduUzbvciVap4R0IXtgbhpboxvrELZMm60nnKy1fE9ZMEKWPGxqoHt/bzUkh1Vee/PqY+VwxMMFgR85jQjwyG7YOjxVf06UPwKHLFloHinDuZFR9XVCriJU/cgZlP3KDrULFzzQX4kL2q/dgC8S2CWvpqFNeh9Cf5kHBQQClAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711589512; c=relaxed/simple;
	bh=ldZ7FHyLIiyTh7OMYtqC0ADh9QERRbTQgkL8bAWBlbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vvm2bu5WfBSMdjtQ2+3N0VKIcnxaTdlXnF0ssAz/Ve+oKR4ZsqzgHKJdAgaxhJfqom41LosmgjoYDMocKCzKBGIAsZT0CecW4Hq7G3k3CAKEopqgnllK3QDiZbrvy6mE4CScmdQJnr/qFd2cgHzjhNHGD4uepkg7LPBh2Bz120k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n1iYHakG; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711589510; x=1743125510;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ldZ7FHyLIiyTh7OMYtqC0ADh9QERRbTQgkL8bAWBlbU=;
  b=n1iYHakGFpFvTWVjH8NXCe8TDC4pzc4Vh2YPyIv5TYuZMqdZnqd1brsF
   utLhA4B/gNYR1N5i1wPnyRNaSMvAB4V9765aOMFMuYCKN6ty8Sr8pphrF
   QGAtkKv6I89k23MBvEnx54/bqV5StWBE4ujjYsisuY3Bspxhz0WeP+dCc
   GHLWLroz3Omj5vIEMtOf68uL48ZZWj5sP3xwGPG2jXjBuXRlDHu+I6ZpM
   LtzRedLJllfPc1/hlWoTYdfrKUbciRHUJCaBg1uaDl2Zg61Gy5LSQKwG+
   R7JZ1MvF4g0sLs5NkvWmbfpMPF6J5Sbx6oKHPy0jbSuz+/c25YbYn5bcm
   A==;
X-CSE-ConnectionGUID: suCwEBRJTPi9qV85cQFx/Q==
X-CSE-MsgGUID: siBiAXUGSUeXHjQiMtA2NA==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="10506076"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="10506076"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 18:31:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="21146002"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 27 Mar 2024 18:31:47 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rpecL-0001fz-06;
	Thu, 28 Mar 2024 01:31:45 +0000
Date: Thu, 28 Mar 2024 09:31:14 +0800
From: kernel test robot <lkp@intel.com>
To: Gowthami Thiagarajan <gthiagarajan@marvell.com>, will@kernel.org,
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, sgoutham@marvell.com,
	bbhushan2@marvell.com, gcherian@marvell.com,
	Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: Re: [RESEND PATCH v4 2/3] perf/marvell: perf/marvell: Odyssey DDR
 Performance
Message-ID: <202403280921.NALZ6Tp8-lkp@intel.com>
References: <20240327071832.1556576-3-gthiagarajan@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327071832.1556576-3-gthiagarajan@marvell.com>

Hi Gowthami,

kernel test robot noticed the following build warnings:

[auto build test WARNING on soc/for-next]
[also build test WARNING on linus/master v6.9-rc1 next-20240327]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gowthami-Thiagarajan/perf-marvell-Refactor-to-extract-platform-data/20240327-152242
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20240327071832.1556576-3-gthiagarajan%40marvell.com
patch subject: [RESEND PATCH v4 2/3] perf/marvell: perf/marvell: Odyssey DDR Performance
config: sparc-allmodconfig (https://download.01.org/0day-ci/archive/20240328/202403280921.NALZ6Tp8-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240328/202403280921.NALZ6Tp8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403280921.NALZ6Tp8-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/perf/marvell_cn10k_ddr_pmu.c:982:34: warning: 'ddr_pmu_v2_data' defined but not used [-Wunused-const-variable=]
     982 | static const struct ddr_pmu_data ddr_pmu_v2_data = {
         |                                  ^~~~~~~~~~~~~~~


vim +/ddr_pmu_v2_data +982 drivers/perf/marvell_cn10k_ddr_pmu.c

   981	
 > 982	static const struct ddr_pmu_data ddr_pmu_v2_data = {
   983		.id   = DDR_PMU_V2,
   984	};
   985	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

