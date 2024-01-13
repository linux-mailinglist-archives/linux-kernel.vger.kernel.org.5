Return-Path: <linux-kernel+bounces-25185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE2882C93A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 04:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3E6FB23AF7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 03:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509AEDF6D;
	Sat, 13 Jan 2024 03:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LAFTrAa+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0480CCA68;
	Sat, 13 Jan 2024 03:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705116434; x=1736652434;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+i6zvCOVB0Ay9M3zKU0z/a8nJ8irYOwSAOjr0lKoeXA=;
  b=LAFTrAa+JSFuvqkvlG4f/8oMEJfA+L4a9MWMHti1FvTr64mXijatM6gX
   4jaihk0yVKrxesfqDj9rZUZdPqypo3SSLIoq4QVkBU25wIjZHGmAgiFx4
   fnQy1h/3moZ37KE8XGMMSAtQxQlPr0I0JTPe9lmsOz2QHWVVUOWZoYnRl
   d/a1FFFGDsnBqq7M1mrJULeTM4HngjKPo+UFvpyoGiglWKGTg+89nXqxm
   CDniFPAKgKu+7fv8ta3yJW34FtppuFKZA30XSuO6p/dUzqb4gb599FGgl
   aFXA83dmB+3h1B0/dyI1zeyNBDVdf9vDdEBc6q9J+B9tbKCX7scUPy/qF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="6700509"
X-IronPort-AV: E=Sophos;i="6.04,191,1695711600"; 
   d="scan'208";a="6700509"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 19:27:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="926589699"
X-IronPort-AV: E=Sophos;i="6.04,191,1695711600"; 
   d="scan'208";a="926589699"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 12 Jan 2024 19:27:09 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rOUfp-000A2Y-29;
	Sat, 13 Jan 2024 03:27:06 +0000
Date: Sat, 13 Jan 2024 11:26:55 +0800
From: kernel test robot <lkp@intel.com>
To: Catalin Popescu <catalin.popescu@leica-geosystems.com>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, afd@ti.com,
	andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Catalin Popescu <catalin.popescu@leica-geosystems.com>
Subject: Re: [PATCH 3/3] net: phy: dp83826: add support for voltage tuning of
 logical levels
Message-ID: <202401131120.vAXFTd3t-lkp@intel.com>
References: <20240111161927.3689084-3-catalin.popescu@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111161927.3689084-3-catalin.popescu@leica-geosystems.com>

Hi Catalin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on net-next/main net/main linus/master v6.7 next-20240112]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Catalin-Popescu/dt-bindings-net-dp83826-add-ti-cfg-dac-plus-binding/20240112-002701
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240111161927.3689084-3-catalin.popescu%40leica-geosystems.com
patch subject: [PATCH 3/3] net: phy: dp83826: add support for voltage tuning of logical levels
config: x86_64-randconfig-121-20240112 (https://download.01.org/0day-ci/archive/20240113/202401131120.vAXFTd3t-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240113/202401131120.vAXFTd3t-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401131120.vAXFTd3t-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/phy/dp83822.c:570:4: sparse: sparse: symbol 'dp83826_cfg_dac_minus_raw' was not declared. Should it be static?
>> drivers/net/phy/dp83822.c:573:4: sparse: sparse: symbol 'dp83826_cfg_dac_plus_raw' was not declared. Should it be static?

vim +/dp83826_cfg_dac_minus_raw +570 drivers/net/phy/dp83822.c

   569	
 > 570	u8 dp83826_cfg_dac_minus_raw[DP83826_CFG_DAC_RAW_VALUES_MAX] = {0x38, 0x37, 0x36, 0x35, 0x34, 0x33,
   571									0x32, 0x31, 0x30, 0x2f, 0x2e, 0x2d,
   572									0x2c, 0x2b, 0x2a, 0x29, 0x28};
 > 573	u8 dp83826_cfg_dac_plus_raw[DP83826_CFG_DAC_RAW_VALUES_MAX] = {0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d,
   574								       0x0e, 0x0f, 0x10, 0x11, 0x12, 0x13,
   575								       0x14, 0x15, 0x16, 0x17, 0x18};
   576	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

