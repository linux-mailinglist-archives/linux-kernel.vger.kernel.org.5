Return-Path: <linux-kernel+bounces-2588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F606815F26
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81EC61C20FAF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAE14436B;
	Sun, 17 Dec 2023 13:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WdXcnoHj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3180042ABE;
	Sun, 17 Dec 2023 13:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702818314; x=1734354314;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rW0OaEZOM0RJb9whCOu+rkdFO0Mr/JeW2UKgiI/uOks=;
  b=WdXcnoHjvGMSzutbF0rET2uX9SLHUPop0slKme42FsWTNIAJ7wpWq2b2
   zU1J969Oz7y0IRg9RB/ceDO/UIOvDMcZ0wZszLqnvCTfVgetSA9nGhNF9
   8YpQyFG+vRzU8nAJdwBrOX1/x1EfCM7Pk6z3Fk4NidOgvy2LpfOKwbSw7
   S4NX7mlEtpf/RCI/Y3uIgE0OXRh3EMhYXzruA2D/Hfyrht1wzFV1dJpDV
   XcfjJnKQPJnH2c2zz6eKve6xKUGH4mdhYZ4VqPyHClqIQWM13jw+EmV7l
   XSSbVwBRCNm4cR9deLWr6ZSASZWtNfqc3KY72PrtLMbLzRC7x9JBWm0jd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="374913936"
X-IronPort-AV: E=Sophos;i="6.04,283,1695711600"; 
   d="scan'208";a="374913936"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 05:05:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="918972931"
X-IronPort-AV: E=Sophos;i="6.04,283,1695711600"; 
   d="scan'208";a="918972931"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 17 Dec 2023 05:05:09 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEqpP-00033V-1n;
	Sun, 17 Dec 2023 13:05:07 +0000
Date: Sun, 17 Dec 2023 21:04:50 +0800
From: kernel test robot <lkp@intel.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, apw@canonical.com,
	joe@perches.com, dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
	paul.cercueil@analog.com, Michael.Hennerich@analog.com,
	lars@metafoo.de, jic23@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	dan.carpenter@linaro.org, dlechner@baylibre.com,
	marcelo.schmitt1@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/15] iio: adc: ad7091r: Move chip init data to
 container struct
Message-ID: <202312172006.b2fep1oG-lkp@intel.com>
References: <9d1248860193b55e79640b2e64c21c66bd6645f9.1702746240.git.marcelo.schmitt1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d1248860193b55e79640b2e64c21c66bd6645f9.1702746240.git.marcelo.schmitt1@gmail.com>

Hi Marcelo,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v6.7-rc5 next-20231215]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Marcelo-Schmitt/scripts-checkpatch-Add-__aligned-to-the-list-of-attribute-notes/20231217-055420
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/9d1248860193b55e79640b2e64c21c66bd6645f9.1702746240.git.marcelo.schmitt1%40gmail.com
patch subject: [PATCH v4 6/15] iio: adc: ad7091r: Move chip init data to container struct
config: um-randconfig-r111-20231217 (https://download.01.org/0day-ci/archive/20231217/202312172006.b2fep1oG-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231217/202312172006.b2fep1oG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312172006.b2fep1oG-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/adc/ad7091r5.c:59:14: error: initializer element is not constant
     .irq_info = ad7091r5_chip_info_irq,
                 ^~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/ad7091r5.c:59:14: note: (near initialization for 'ad7091r5_init_info.irq_info')
   drivers/iio/adc/ad7091r5.c:60:17: error: initializer element is not constant
     .info_no_irq = ad7091r5_chip_info_noirq,
                    ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/ad7091r5.c:60:17: note: (near initialization for 'ad7091r5_init_info.info_no_irq')


vim +59 drivers/iio/adc/ad7091r5.c

    57	
    58	static struct ad7091r_init_info ad7091r5_init_info = {
  > 59		.irq_info = ad7091r5_chip_info_irq,
    60		.info_no_irq = ad7091r5_chip_info_noirq,
    61		.regmap_config = &ad7091r_regmap_config,
    62		.init_adc_regmap = &ad7091r5_regmap_init
    63	};
    64	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

