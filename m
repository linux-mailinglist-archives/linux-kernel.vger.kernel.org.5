Return-Path: <linux-kernel+bounces-13783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E879820D20
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 20:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0DA11C2183A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 19:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A961BE50;
	Sun, 31 Dec 2023 19:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="am4vn0so"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20C6BA30;
	Sun, 31 Dec 2023 19:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704052551; x=1735588551;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+iE9TDbu+eOc7+4rEPE+O/B6xT0Y7sDNzvuMA2sE5Qk=;
  b=am4vn0soVODGnTkcR2MnoolWHUNfGTPHsdKrISsj9/yfNCAxrDrAZYHj
   SqcDpXXaGMciYZImhkT1X9fjwAi1e3W3lk6l4aExC9HDf3KbQ3r0LSCVM
   1+yJ2DGT0H8dfv6n8tNvGGrP4UMCob8Z3R/QKZ/JDvmcUqlFkOgtuyuI2
   8qgqGauixGo7h2+ixeQSmABIQzyXmfj9HL/ygVoPn8nOOmIu+DgriUrtC
   4I54OaAqhv4V5m1ZraHkxqjUk7ZiXHcMKN2k/9OZVzmkreVhHYipT6gcT
   46CnJVWT2un0tQncjkBdOUyFUVwqLGMzwARlg91n3+R/ImNq3l1rP0rIY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="482940928"
X-IronPort-AV: E=Sophos;i="6.04,320,1695711600"; 
   d="scan'208";a="482940928"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2023 11:55:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,320,1695711600"; 
   d="scan'208";a="21052724"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 31 Dec 2023 11:55:42 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rK1uO-000JiK-0i;
	Sun, 31 Dec 2023 19:55:40 +0000
Date: Mon, 1 Jan 2024 03:54:58 +0800
From: kernel test robot <lkp@intel.com>
To: Jishnu Prakash <quic_jprakash@quicinc.com>, jic23@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
	lee@kernel.org, andriy.shevchenko@linux.intel.com,
	daniel.lezcano@linaro.org, dmitry.baryshkov@linaro.org
Cc: oe-kbuild-all@lists.linux.dev, quic_jprakash@quicinc.com,
	lars@metafoo.de, luca@z3ntu.xyz, marijn.suijten@somainline.org,
	agross@kernel.org, sboyd@kernel.org, rafael@kernel.org,
	rui.zhang@intel.com, lukasz.luba@arm.com, linus.walleij@linaro.org,
	quic_subbaram@quicinc.com, quic_collinsd@quicinc.com,
	quic_amelende@quicinc.com, quic_kamalw@quicinc.com,
	kernel@quicinc.com, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
Message-ID: <202401010303.pkYUJjby-lkp@intel.com>
References: <20231231171237.3322376-4-quic_jprakash@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231231171237.3322376-4-quic_jprakash@quicinc.com>

Hi Jishnu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20231222]
[cannot apply to robh/for-next jic23-iio/togreg rafael-pm/thermal v6.7-rc7 v6.7-rc6 v6.7-rc5 linus/master v6.7-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jishnu-Prakash/dt-bindings-iio-adc-Move-QCOM-ADC-bindings-to-iio-adc-folder/20240101-011705
base:   next-20231222
patch link:    https://lore.kernel.org/r/20231231171237.3322376-4-quic_jprakash%40quicinc.com
patch subject: [PATCH v3 3/3] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20240101/202401010303.pkYUJjby-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240101/202401010303.pkYUJjby-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401010303.pkYUJjby-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/adc/qcom-spmi-adc5-gen3.c:290: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Worst case delay from PBS in readying handshake bit
   drivers/iio/adc/qcom-spmi-adc5-gen3.c:332: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Worst case delay from PBS for conversion time can be


vim +290 drivers/iio/adc/qcom-spmi-adc5-gen3.c

   288	
   289	/**
 > 290	 * Worst case delay from PBS in readying handshake bit
   291	 * can be up to 15ms, when PBS is busy running other
   292	 * simultaneous transactions, while in the best case, it is
   293	 * already ready at this point. Assigning polling delay and
   294	 * retry count accordingly.
   295	 */
   296	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

