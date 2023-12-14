Return-Path: <linux-kernel+bounces-50-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E30D813B44
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39FD02822F7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA4A6A006;
	Thu, 14 Dec 2023 20:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mbtNiX0h"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F8C6A036;
	Thu, 14 Dec 2023 20:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702584499; x=1734120499;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SEbmdNQI4oR9juNQv5BOktkdGKtVXGwsaSvQNvpGCOs=;
  b=mbtNiX0hkvqnclP3l+XrN1tylS06G3iMKCIrk1kLpBxAclD7Ykzxn/O7
   XvLOM9lvlBOOKHEspg45UxGShxLMsyrGNs8/k5Oo+UpXZnFuPxWvRPXD2
   js3XgLkwv0FgJO+hBKM33pnvocm7v/2KHo12UXXZ40B24jrWRHbm1fE8X
   6CWfR5DDJQgfsn1hEOu0nzVeakLJGe+FYXLMolR1ZB1o6lNi8gyZFM0yf
   VP5AxSR0CN1jbvRo4sJKSSgiPeyNMrVePEP8492uYDOjBnSYFg+DOU8gb
   znbSg3ooBVWSg1M11Zp0TvYkLq0d01X/+sHKGnZ9mHal2rBcxTXs3rlRZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="392356776"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="392356776"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 12:08:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="918168048"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="918168048"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 14 Dec 2023 12:08:12 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDs09-000MZA-1y;
	Thu, 14 Dec 2023 20:08:09 +0000
Date: Fri, 15 Dec 2023 04:07:45 +0800
From: kernel test robot <lkp@intel.com>
To: Cosmo Chou <chou.cosmo@gmail.com>, linux@roeck-us.net,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, jdelvare@suse.com, corbet@lwn.net,
	broonie@kernel.org, naresh.solanki@9elements.com,
	vincent@vtremblay.dev, patrick.rudolph@9elements.com,
	luca.ceresoli@bootlin.com, bhelgaas@google.com, festevam@denx.de,
	alexander.stein@ew.tq-group.com, heiko@sntech.de,
	jernej.skrabec@gmail.com, macromorgan@hotmail.com,
	forbidden405@foxmail.com, sre@kernel.org, linus.walleij@linaro.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	chou.cosmo@gmail.com, cosmo.chou@quantatw.com
Subject: Re: [PATCH v2 3/3] hwmon: Add driver for Astera Labs PT5161L retimer
Message-ID: <202312150313.eDD5WEPc-lkp@intel.com>
References: <20231214060552.2852761-4-chou.cosmo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214060552.2852761-4-chou.cosmo@gmail.com>

Hi Cosmo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on groeck-staging/hwmon-next]
[also build test WARNING on robh/for-next linus/master v6.7-rc5 next-20231214]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cosmo-Chou/dt-bindings-vendor-prefixes-add-asteralabs/20231214-140823
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20231214060552.2852761-4-chou.cosmo%40gmail.com
patch subject: [PATCH v2 3/3] hwmon: Add driver for Astera Labs PT5161L retimer
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20231215/202312150313.eDD5WEPc-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231215/202312150313.eDD5WEPc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312150313.eDD5WEPc-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hwmon/pt5161l.c:517:36: warning: unused variable 'pt5161l_acpi_match' [-Wunused-const-variable]
     517 | static const struct acpi_device_id pt5161l_acpi_match[] = {
         |                                    ^
   1 warning generated.


vim +/pt5161l_acpi_match +517 drivers/hwmon/pt5161l.c

   516	
 > 517	static const struct acpi_device_id pt5161l_acpi_match[] = {
   518		{ "PT5161L", 0 },
   519		{},
   520	};
   521	MODULE_DEVICE_TABLE(acpi, pt5161l_acpi_match);
   522	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

