Return-Path: <linux-kernel+bounces-23798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC9482B1E2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E280F281B36
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A194EB41;
	Thu, 11 Jan 2024 15:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jk9DvIOP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44FE4EB33;
	Thu, 11 Jan 2024 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704987166; x=1736523166;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PdaGGrwqDgKANv4fennnp3SNYJCXj4mN51AfYb3oMWU=;
  b=jk9DvIOP1p+4oSaBqZQyacXJPIvutxtMPWKhRQ46SGl1/RaBm9McsWbC
   gNDtcRw/UGGcCL0wDsaqnIxhimsnekpxlinhR1CuDd1MZyrIlkGoY+8Hp
   elCicaOQOt6iDERZZ49h3irmdWUCr0YctxpS1oeWkkcczjpQ6YRe4u7fh
   5Fg5Fa7REm7HVcZMxezK8n2hVr8oj0kGal9nvo1a/2D7vvUAftwYPMrvH
   x5H1BYfnCk43Te55Vd6dkjaZgcm/TkgenLIB79sZL3wEwROVx34fvUteP
   kt9XjsW3nZQtQopVAzqaGZ47/j0fHF4FWAtBJrDtbNryoRfFlcrtPrBX2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="12368657"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="12368657"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 07:32:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="24356280"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 11 Jan 2024 07:32:42 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rNx23-0008PE-1E;
	Thu, 11 Jan 2024 15:32:02 +0000
Date: Thu, 11 Jan 2024 23:30:52 +0800
From: kernel test robot <lkp@intel.com>
To: Bhavin Sharma <bhavin.sharma@siliconsignals.io>, sre@kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Bhavin Sharma <bhavin.sharma@siliconsignals.io>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] power: supply: Add STC3117 fuel gauge unit driver
Message-ID: <202401112330.LVTGnI1p-lkp@intel.com>
References: <20240106133546.936261-1-bhavin.sharma@siliconsignals.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240106133546.936261-1-bhavin.sharma@siliconsignals.io>

Hi Bhavin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on sre-power-supply/for-next]
[also build test WARNING on robh/for-next linus/master v6.7 next-20240111]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bhavin-Sharma/dt-bindings-power-supply-stc3117-Convert-to-DT-schema-format/20240106-213744
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
patch link:    https://lore.kernel.org/r/20240106133546.936261-1-bhavin.sharma%40siliconsignals.io
patch subject: [PATCH v2 1/2] power: supply: Add STC3117 fuel gauge unit driver
config: x86_64-randconfig-r131-20240111 (https://download.01.org/0day-ci/archive/20240111/202401112330.LVTGnI1p-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240111/202401112330.LVTGnI1p-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401112330.LVTGnI1p-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/power/supply/stc3117_fuel_gauge.c:31:25: sparse: sparse: symbol 'tmp_client' was not declared. Should it be static?
>> drivers/power/supply/stc3117_fuel_gauge.c:32:21: sparse: sparse: symbol 'stc_sply' was not declared. Should it be static?
>> drivers/power/supply/stc3117_fuel_gauge.c:49:19: sparse: sparse: symbol 'stc3117_i2c_driver' was not declared. Should it be static?

vim +/tmp_client +31 drivers/power/supply/stc3117_fuel_gauge.c

    30	
  > 31	const struct i2c_client *tmp_client;
  > 32	struct power_supply *stc_sply;
    33	
    34	static const struct of_device_id stc3117_of_match[] = {
    35		{ .compatible = "st,stc3117-fgu" },
    36		{},
    37	};
    38	
    39	MODULE_DEVICE_TABLE(of, stc3117_of_match);
    40	
    41	static const struct i2c_device_id stc3117_id[] = {
    42		{"stc3117", 0},
    43		{},
    44	};
    45	
    46	
    47	MODULE_DEVICE_TABLE(i2c, stc3117_id);
    48	
  > 49	struct i2c_driver stc3117_i2c_driver = {
    50		.driver = {
    51			.name = "stc3117_i2c_driver",
    52			.owner = THIS_MODULE,
    53			.of_match_table = of_match_ptr(stc3117_of_match),
    54		},
    55		.probe = stc3117_probe,
    56		.id_table = stc3117_id,
    57		.remove = stc3117_dev_remove,
    58	};
    59	
    60	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

