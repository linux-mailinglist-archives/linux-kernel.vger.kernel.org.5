Return-Path: <linux-kernel+bounces-25197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C441D82C967
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 05:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607CC1F22390
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 04:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9937F9E6;
	Sat, 13 Jan 2024 04:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F/605MET"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E41FBEA;
	Sat, 13 Jan 2024 04:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705121670; x=1736657670;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WL/QqSd1Bk1dMQtp6aDp3jGsFXAHfb+taVAOlJrMvNc=;
  b=F/605METF9ZVAln3e8OBqFiocfDKLZZbp7AymsfXutzNmvjTo1/oANHr
   b21SdWYmFiO7l9EDhIF864Z10UgmbobQuC7C9S6UIDC+Enl1zl95cOpUX
   4Cc/QaqTNFs5IGcBNojLPctiSBSstcxi+pEjIihXdMtuo3jTso92Mp1Jl
   7wSaae+B/2OXYtslYg2g/zFc3ZhLs7mK2rfxB3TvpynsMrPZIjGotFwPT
   Yke490Fj0bi4fN2hxsz3xkp4blcnL6yhuv7mKkpNjQTcE4rNQNViho9kK
   09DZlOJRWbEpm/WzOJ8msn9fHaZtqAhdQJuDzsivTtcqSh+I+SctxeKlt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="12715720"
X-IronPort-AV: E=Sophos;i="6.04,191,1695711600"; 
   d="scan'208";a="12715720"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 20:54:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="786570253"
X-IronPort-AV: E=Sophos;i="6.04,191,1695711600"; 
   d="scan'208";a="786570253"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 12 Jan 2024 20:54:24 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rOW2I-000A6u-22;
	Sat, 13 Jan 2024 04:54:22 +0000
Date: Sat, 13 Jan 2024 12:53:50 +0800
From: kernel test robot <lkp@intel.com>
To: Akhil R <akhilrajeev@nvidia.com>, herbert@gondor.apana.org.au,
	davem@davemloft.net, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	thierry.reding@gmail.com, jonathanh@nvidia.com,
	catalin.marinas@arm.com, will@kernel.org, mperttunen@nvidia.com,
	linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	krzk@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Akhil R <akhilrajeev@nvidia.com>
Subject: Re: [PATCH v3 3/5] crypto: tegra: Add Tegra Security Engine driver
Message-ID: <202401131257.8RjvB7OG-lkp@intel.com>
References: <20240109091708.66977-4-akhilrajeev@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109091708.66977-4-akhilrajeev@nvidia.com>

Hi Akhil,

kernel test robot noticed the following build warnings:

[auto build test WARNING on herbert-cryptodev-2.6/master]
[also build test WARNING on herbert-crypto-2.6/master tegra/for-next linus/master v6.7 next-20240112]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Akhil-R/dt-bindings-crypto-Add-Tegra-Security-Engine/20240109-172454
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
patch link:    https://lore.kernel.org/r/20240109091708.66977-4-akhilrajeev%40nvidia.com
patch subject: [PATCH v3 3/5] crypto: tegra: Add Tegra Security Engine driver
config: powerpc64-randconfig-r123-20240112 (https://download.01.org/0day-ci/archive/20240113/202401131257.8RjvB7OG-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20240113/202401131257.8RjvB7OG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401131257.8RjvB7OG-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/crypto/tegra/tegra-se-key.c:20:1: sparse: sparse: symbol 'kslt_lock' was not declared. Should it be static?
   drivers/crypto/tegra/tegra-se-key.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/umh.h, include/linux/kmod.h, ...):
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false

vim +/kslt_lock +20 drivers/crypto/tegra/tegra-se-key.c

    18	
    19	/* Mutex lock to guard keyslots */
  > 20	DEFINE_MUTEX(kslt_lock);
    21	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

