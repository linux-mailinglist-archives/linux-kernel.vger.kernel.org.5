Return-Path: <linux-kernel+bounces-19001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31822826651
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 23:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29854B2104C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 22:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A61511CAE;
	Sun,  7 Jan 2024 22:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I7jQcDNT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16ED13AE2;
	Sun,  7 Jan 2024 22:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704665526; x=1736201526;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/xeVGbq1ohEkkwou+0NT7S2wRq+Kkp0E7oeDwdtlim4=;
  b=I7jQcDNTXRdNE1z4KQllnMd+UjlAUXJernt45ZiLPMzRAbMIqsQuFRXU
   96lI3Lxy+GOaKFD4j/6RGFze53WgyS6Ly59uqhD0ouUSgKAjiaHmqcBft
   b44UJU9NewESqddpm0yUyepiRubbmCcTu8Y8ey4fIlYgePhhsbhP90woV
   4F7yxwdCMsfqzQY0RabN/jEv3cYEfOj6UubLNymREHMaOw7WzfIC0kAjm
   D/S3nVmLQwQ8RAhd6EpDHZ7y6iWi3nIpUwuI0l3vJ0kv/QJN893/UWEus
   FMLUDlVNab3Ux9KLoHwsUmTQhoeDzj0I39rkPkJI6E4fSqvTj7o7eqI1k
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="388217493"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="388217493"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2024 14:12:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="1028228604"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="1028228604"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 07 Jan 2024 14:11:59 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMbN6-0004CJ-32;
	Sun, 07 Jan 2024 22:11:56 +0000
Date: Mon, 8 Jan 2024 06:11:34 +0800
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
Message-ID: <202401080530.0hMWnrIg-lkp@intel.com>
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
[also build test WARNING on robh/for-next linus/master v6.7-rc8 next-20240105]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bhavin-Sharma/dt-bindings-power-supply-stc3117-Convert-to-DT-schema-format/20240106-213744
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
patch link:    https://lore.kernel.org/r/20240106133546.936261-1-bhavin.sharma%40siliconsignals.io
patch subject: [PATCH v2 1/2] power: supply: Add STC3117 fuel gauge unit driver
config: alpha-randconfig-r112-20240108 (https://download.01.org/0day-ci/archive/20240108/202401080530.0hMWnrIg-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240108/202401080530.0hMWnrIg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401080530.0hMWnrIg-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/power/supply/stc3117_fuel_gauge.c:34:34: warning: 'stc3117_of_match' defined but not used [-Wunused-const-variable=]
      34 | static const struct of_device_id stc3117_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~


vim +/stc3117_of_match +34 drivers/power/supply/stc3117_fuel_gauge.c

    33	
  > 34	static const struct of_device_id stc3117_of_match[] = {
    35		{ .compatible = "st,stc3117-fgu" },
    36		{},
    37	};
    38	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

