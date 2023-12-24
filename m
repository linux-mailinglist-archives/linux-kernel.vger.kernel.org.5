Return-Path: <linux-kernel+bounces-10618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CB381D773
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 01:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A43E91F21D10
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 00:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5C0807;
	Sun, 24 Dec 2023 00:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="icaeB3+2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204F5EBB;
	Sun, 24 Dec 2023 00:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703379483; x=1734915483;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4d0I8vRHbzVyHrLROf04Yy7sbIuPKbG+MABm9FG8Q0c=;
  b=icaeB3+2CtPxGND6w54UVvQgT5a4gp03mu8YQf6O5BpvicddrspjTh07
   xdN9FZ8uy/Mec7JsjHK3S054xZfvjcNp+HENkk1IK+OEqCiDmE+mjYIxF
   yKaE2soHtjus7KvuHQPinbCyKUTcBkcdvVulK6LVBWTxiySZ9IQ5Rh/zN
   13YsEqpa3rl/WkHn0UGL4F9YHR+wQLeIFMXMNkpsnq/gHw3UbHjiFQaGN
   rlfk5/fcJ0ZAM+6ZyCNRopsHNVyr+2Ci9+y8pGAPixMyVeZeU8iZsbrmu
   u3CxfeGGMoYwh28iSCGcCrQIb/9ZB19vx1z+P3Bwran0ZwUoor2qgQDzk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10933"; a="14894219"
X-IronPort-AV: E=Sophos;i="6.04,300,1695711600"; 
   d="scan'208";a="14894219"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2023 16:58:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10933"; a="780943460"
X-IronPort-AV: E=Sophos;i="6.04,300,1695711600"; 
   d="scan'208";a="780943460"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 23 Dec 2023 16:58:00 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHCoW-000Bi9-2T;
	Sun, 24 Dec 2023 00:57:57 +0000
Date: Sun, 24 Dec 2023 08:57:09 +0800
From: kernel test robot <lkp@intel.com>
To: Sagi Maimon <maimon.sagi@gmail.com>, richardcochran@gmail.com,
	jonathan.lemon@gmail.com, vadfed@fb.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	maimon.sagi@gmail.com
Subject: Re: [PATCH v1] ptp: ocp: add Adva timecard support
Message-ID: <202312240816.FklJZk9r-lkp@intel.com>
References: <20231221153755.2690-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221153755.2690-1-maimon.sagi@gmail.com>

Hi Sagi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]
[also build test WARNING on net-next/main linus/master v6.7-rc6 next-20231222]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sagi-Maimon/ptp-ocp-add-Adva-timecard-support/20231222-182253
base:   net/main
patch link:    https://lore.kernel.org/r/20231221153755.2690-1-maimon.sagi%40gmail.com
patch subject: [PATCH v1] ptp: ocp: add Adva timecard support
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20231224/202312240816.FklJZk9r-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231224/202312240816.FklJZk9r-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312240816.FklJZk9r-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/ptp/ptp_ocp.c:418:32: warning: tentative definition of variable with internal linkage has incomplete non-array type 'const struct ocp_sma_op' [-Wtentative-definition-incomplete-type]
   static const struct ocp_sma_op ocp_adva_sma_op;
                                  ^
   drivers/ptp/ptp_ocp.c:377:15: note: forward declaration of 'struct ocp_sma_op'
           const struct ocp_sma_op *sma_op;
                        ^
   1 warning generated.


vim +418 drivers/ptp/ptp_ocp.c

   417	
 > 418	static const struct ocp_sma_op ocp_adva_sma_op;
   419	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

