Return-Path: <linux-kernel+bounces-2890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E188163D3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 01:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 348631C21EC7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 00:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5ED1107;
	Mon, 18 Dec 2023 00:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ngM086je"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A180410ED;
	Mon, 18 Dec 2023 00:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702859526; x=1734395526;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=76DAx//fmXSqRlR1hum4dGOBFckM5Ymm9g4DymCzyb4=;
  b=ngM086je6SbFFKuB4DyBrI1uiIY42lfviNPEBecKxITin0B0VU66dLDq
   TAZB4Ydo3GapSkmvbrorLHBlRDg3AtvnTmGyI8JwBKXFqWpR3lYSAUgeg
   x4cQCFkpb9MtcNIEZ/7xVejx4m7N0/AmnvnFoxvgnL0Z+BJBoQmo1Qv4i
   RTBkYFDPciL8PXdZoWyKWgI5Jxi86qwuOLoYvAC5W7E4NDzwNNnAhULr+
   WmWsWbI8Vh4nLqS1nrLYBoMcVcTHDhk4fmzw8qHdzYEdL50QR8XkYSLHl
   +RLOfrDNfyFcrY3qeMZXQsr0dYrh7FKObLQZnFOGhejjb02Gim3cfyLiN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="2264606"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="2264606"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 16:32:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="768649698"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="768649698"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 17 Dec 2023 16:32:01 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rF1Y7-0003ZU-04;
	Mon, 18 Dec 2023 00:31:59 +0000
Date: Mon, 18 Dec 2023 08:31:30 +0800
From: kernel test robot <lkp@intel.com>
To: Abdel Alkuor <alkuor@gmail.com>, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: Add AMS AS6200 temperature sensor
Message-ID: <202312180847.bJ22ULTY-lkp@intel.com>
References: <63e352150ed51eefce90ca4058af5459730174b2.1702744180.git.alkuor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63e352150ed51eefce90ca4058af5459730174b2.1702744180.git.alkuor@gmail.com>

Hi Abdel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on groeck-staging/hwmon-next]
[also build test WARNING on robh/for-next linus/master v6.7-rc5 next-20231215]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Abdel-Alkuor/hwmon-Add-AMS-AS6200-temperature-sensor/20231217-004310
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/63e352150ed51eefce90ca4058af5459730174b2.1702744180.git.alkuor%40gmail.com
patch subject: [PATCH 2/2] hwmon: Add AMS AS6200 temperature sensor
config: x86_64-randconfig-r132-20231218 (https://download.01.org/0day-ci/archive/20231218/202312180847.bJ22ULTY-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231218/202312180847.bJ22ULTY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312180847.bJ22ULTY-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/hwmon/as6200.c:141:24: sparse: sparse: symbol 'as6200_chip_info' was not declared. Should it be static?

vim +/as6200_chip_info +141 drivers/hwmon/as6200.c

   140	
 > 141	struct hwmon_chip_info as6200_chip_info = {
   142		.ops = &as6200_hwmon_ops,
   143		.info = as6200_info
   144	};
   145	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

