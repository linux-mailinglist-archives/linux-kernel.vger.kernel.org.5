Return-Path: <linux-kernel+bounces-2030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D96E3815716
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 04:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 132A41C23655
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 03:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16BE5670;
	Sat, 16 Dec 2023 03:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cCFIDyfY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8082820F6;
	Sat, 16 Dec 2023 03:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702698005; x=1734234005;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8iTbdebOpdgOKk0llu7oM4iOfYfF2+G5imBwjpyg9rI=;
  b=cCFIDyfYV0AI2OTiamtwCt+LOX1ftnUnQZnJ4T06kBNegOE34Y2IUSzW
   hRDKu9iyaiP0SMZ9xNHRaqNYVkrNeyr78INpNh2dSdZRiZYuZc1XRihd0
   zgvgU+IBYxS+Q3fuLYucbsWhS2eF9swCoiEr3+UBi5yVDxLI09umqcFon
   BgSbaPkG6xPZNlSBDOkpOs8fxX9oDHmFR1ZexjmA/8x0E3gNvdoz2hfyK
   iKnz63Y9eOzynSWIbYrA8YnBv/EEs2/M1//p6k7LEj5KrHmRk1nCofMNQ
   4P3W3bST7sT5BM7qLHGzUhcQncRDzaF+z/64/ZdjXXSnx5suMg+R9bi/E
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="394230239"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="394230239"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 19:40:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="840865508"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="840865508"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 15 Dec 2023 19:39:59 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rELWv-00016c-0d;
	Sat, 16 Dec 2023 03:39:57 +0000
Date: Sat, 16 Dec 2023 11:39:29 +0800
From: kernel test robot <lkp@intel.com>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linus.walleij@linaro.org, brgl@bgdev.pl,
	andy@kernel.org, linux-gpio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Walle <michael@walle.cc>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, ChiaEn Wu <chiaen_wu@richtek.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Haibo Chen <haibo.chen@nxp.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dumitru Ceclan <mitrutzceclan@gmail.com>
Subject: Re: [PATCH v9 1/2] dt-bindings: adc: add AD7173
Message-ID: <202312161107.L0HDURj1-lkp@intel.com>
References: <20231215133512.28735-1-mitrutzceclan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215133512.28735-1-mitrutzceclan@gmail.com>

Hi Dumitru,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.7-rc5 next-20231215]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dumitru-Ceclan/iio-adc-ad7173-add-AD7173-driver/20231215-213722
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20231215133512.28735-1-mitrutzceclan%40gmail.com
patch subject: [PATCH v9 1/2] dt-bindings: adc: add AD7173
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231216/202312161107.L0HDURj1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312161107.L0HDURj1-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml: patternProperties:^channel@[0-9a-f]$:properties:adi,reference-select:type: 'string' is not one of ['boolean', 'object']
   	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
>> Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml: patternProperties:^channel@[0-9a-f]$:properties:adi,reference-select:type: 'boolean' was expected
   	hint: A vendor boolean property can use "type: boolean"
   	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

