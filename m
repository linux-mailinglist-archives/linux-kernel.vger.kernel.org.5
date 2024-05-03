Return-Path: <linux-kernel+bounces-167266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA688BA6B6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 07:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 598D0280DEF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 05:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2B9139D14;
	Fri,  3 May 2024 05:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dzrVrBjW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D3213959D;
	Fri,  3 May 2024 05:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714714701; cv=none; b=lwOcAw4bwwWRs7W1SyctdgOA+uPFHHRr58cXxgBcNQc4YNHVeqzbx2ku/5ztahacGrnidAMMhBYYFRkzAe4r32KzIyU6TX3lGshX6z2K+5LpKmcJMTuLPb6hmRUR9tizJO/G8Zn9v0qYSwxzsmTmO1Xu8GiVGQ/WuIU8+vUOlSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714714701; c=relaxed/simple;
	bh=rIOanS3NEM0FdsDfQos+HeWqaxYjUZHhl//Lgnnpjyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRYFvupVGrrQZGaN6iP3XZ6Q1KrLTgAIzOi661sacRj2E3QNyLrzqNsAqhVIoo/lQgYuFA51ARcX4N837qieGhtvBWBgVvDY/Gdae1wMKmcD2PWDp7N5goDULrRhLA4Rquh63NJXaTyFIjdn2fHkztBZ3cOo9uVbxxpai5nC3JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dzrVrBjW; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714714699; x=1746250699;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rIOanS3NEM0FdsDfQos+HeWqaxYjUZHhl//Lgnnpjyc=;
  b=dzrVrBjWe4gQ6u/nw+NVKJ+UXZ8c9bm1BGXRwmA+NPGfgGt2jqlDZY7D
   ZWnX0NELOXQ6DwNmdMmpfHBt/pK0K9izWVJtOmDJnBfuKHYcHJNwS4a3A
   vGdYtwIqRVyYiQc3kj1RgHDC39TPse7WrC6iDwnI+1Mr33n49r9EoKtJ2
   SYJZCXHohIYIpopfoCB0jAu8sW6/6d0zXno3nOzYXlRVZQH9hw9zTXlDN
   EZvgz5Efq+R7n5o8Pnk3d+ympPDn3ywTDZ74wE+r+Bl3uOFEc7imSH9jg
   2Fd2D7meu1Brm6/Rm7OrHyP5Dy7tjRkXfCkVsb53Z7hMMO1Tos0t2wg91
   w==;
X-CSE-ConnectionGUID: VMd6hextTJu1LCne89QvDQ==
X-CSE-MsgGUID: OZ4GFDdTSVKtGw2RUhrKZw==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="33025268"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="33025268"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 22:38:18 -0700
X-CSE-ConnectionGUID: zZhTx/LNQVyeh59xXQiJuA==
X-CSE-MsgGUID: wByDFti2RZ+Xlb7eXRFXLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27760508"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 02 May 2024 22:38:16 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s2lcb-000BLu-1O;
	Fri, 03 May 2024 05:38:13 +0000
Date: Fri, 3 May 2024 13:37:50 +0800
From: kernel test robot <lkp@intel.com>
To: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	Mark Brown <broonie@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	valentina.fernandezalanis@microchip.com,
	Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
Subject: Re: [PATCH 1/3] spi: spi-microchip-core: Add support for GPIO based
 CS
Message-ID: <202405031322.8UuTAWrf-lkp@intel.com>
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
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20240503/202405031322.8UuTAWrf-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240503/202405031322.8UuTAWrf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405031322.8UuTAWrf-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/spi/spi-microchip-core.c: In function 'mchp_corespi_setup':
>> drivers/spi/spi-microchip-core.c:261:13: warning: the comparison will always evaluate as 'true' for the address of 'cs_gpiod' will never be NULL [-Waddress]
     261 |         if (spi->cs_gpiod)
         |             ^~~
   In file included from drivers/spi/spi-microchip-core.c:21:
   include/linux/spi/spi.h:219:34: note: 'cs_gpiod' declared here
     219 |         struct gpio_desc        *cs_gpiod[SPI_CS_CNT_MAX];      /* Chip select gpio desc */
         |                                  ^~~~~~~~


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

