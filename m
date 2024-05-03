Return-Path: <linux-kernel+bounces-167258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B178BA69D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 07:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53734281F5E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 05:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74084139CE0;
	Fri,  3 May 2024 05:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ElBD925d"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B8242A91;
	Fri,  3 May 2024 05:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714714100; cv=none; b=N6i3iZs/uYhOr/a9yLLk4R/BsikdlJu3tLNXlfe7f7+YWqfd3dzjK63Eiyfo0y168mvkk6+A6TeXACYKI9v0vO47lclauo6rfwkxGKmhCw8XXTUcc8NKh9EEDCH/aenr6ngUTSvIAlH71k8jBm5kjd5yLph6dUT2ujz9q0W5JNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714714100; c=relaxed/simple;
	bh=qbvw7iLaf2fZEd6UPwtqlQskjo9r3Fjn07UVy58tZgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjM8fGrUwhthnl/Ym+K6OuVGlD5UgNrjAt86yiZ0foQCs89sOrh4Mwb1WTQwKK7Aj2updyABk5y5qU7eC5nTd+IsqIxxoa65RiaTZ8M6KU+wJVQXh/23vYxWpVwG/b+Q26QqsCSmCtKDI8opufwRl4eFnkQCebSttQi/nOuDDhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ElBD925d; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714714099; x=1746250099;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qbvw7iLaf2fZEd6UPwtqlQskjo9r3Fjn07UVy58tZgA=;
  b=ElBD925dW9JxaybTDo2CA694V3TEWz76KLcYbHRY2mAlM8QzW79ahcgX
   8/7EItBHHQeoMi7lYcRD65FdCPhU6Qm9s0iziEjf1w4xzRJiG90ERXAzj
   mmoFZ5iM1MK4A58n19DNueNLO7t2Q/IRSi5LzlxEpGnPHK6U5007TJkvO
   G00/B2xrLhf8X7mD4ffGt+BvttWsjwFqYFD6uHYaAinmpNSYUWozcMNPY
   Uoa9fxudmHeUITAqFHhd5ERTSOtDuMxK/azTGzJ3m7REsjGVgFP/y+qBK
   +ch671WYGJWuUaYg74Uvlw79pxuGbc0V1ueYnquMFgOwaCWimBPtaNcmc
   g==;
X-CSE-ConnectionGUID: m2MK65+1QGm8NYDzbTaEdw==
X-CSE-MsgGUID: yHwYBrQVQxu94+hKaNk4iA==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10442869"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10442869"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 22:28:18 -0700
X-CSE-ConnectionGUID: LHay6kF8TfWXCwKCUIJX2Q==
X-CSE-MsgGUID: hdpS1xCtR+q0Evxs84mdzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27399371"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 02 May 2024 22:28:15 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s2lSu-000BLA-3A;
	Fri, 03 May 2024 05:28:13 +0000
Date: Fri, 3 May 2024 13:27:33 +0800
From: kernel test robot <lkp@intel.com>
To: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	Mark Brown <broonie@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	valentina.fernandezalanis@microchip.com,
	Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
Subject: Re: [PATCH 1/3] spi: spi-microchip-core: Add support for GPIO based
 CS
Message-ID: <202405031328.ljBB1tMb-lkp@intel.com>
References: <20240502143410.12629-2-prajna.rajendrakumar@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502143410.12629-2-prajna.rajendrakumar@microchip.com>

Hi Prajna,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-spi/for-next]
[also build test WARNING on robh/for-next krzk-dt/for-next linus/master v6.9-rc6 next-20240502]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Prajna-Rajendra-Kumar/spi-spi-microchip-core-Add-support-for-GPIO-based-CS/20240502-223714
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20240502143410.12629-2-prajna.rajendrakumar%40microchip.com
patch subject: [PATCH 1/3] spi: spi-microchip-core: Add support for GPIO based CS
config: arm-randconfig-002-20240503 (https://download.01.org/0day-ci/archive/20240503/202405031328.ljBB1tMb-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 37ae4ad0eef338776c7e2cffb3896153d43dcd90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240503/202405031328.ljBB1tMb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405031328.ljBB1tMb-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/spi/spi-microchip-core.c:21:
   In file included from include/linux/spi/spi.h:17:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/spi/spi-microchip-core.c:261:11: warning: address of array 'spi->cs_gpiod' will always evaluate to 'true' [-Wpointer-bool-conversion]
     261 |         if (spi->cs_gpiod)
         |         ~~  ~~~~~^~~~~~~~
   2 warnings generated.


vim +261 drivers/spi/spi-microchip-core.c

   255	
   256	static int mchp_corespi_setup(struct spi_device *spi)
   257	{
   258		struct mchp_corespi *corespi = spi_controller_get_devdata(spi->controller);
   259		u32 reg;
   260	
 > 261		if (spi->cs_gpiod)
   262			return 0;
   263	
   264		/*
   265		 * Active high targets need to be specifically set to their inactive
   266		 * states during probe by adding them to the "control group" & thus
   267		 * driving their select line low.
   268		 */
   269		if (spi->mode & SPI_CS_HIGH) {
   270			reg = mchp_corespi_read(corespi, REG_SLAVE_SELECT);
   271			reg |= BIT(spi_get_chipselect(spi, 0));
   272			mchp_corespi_write(corespi, REG_SLAVE_SELECT, reg);
   273		}
   274		return 0;
   275	}
   276	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

