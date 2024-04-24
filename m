Return-Path: <linux-kernel+bounces-157314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F6D8B0FAF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36FFF1C2455E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B212F1635AB;
	Wed, 24 Apr 2024 16:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="le9GM7vT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D86161911;
	Wed, 24 Apr 2024 16:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713975987; cv=none; b=Jz/j/W3lSnjxTGUG4bO1hIdefxlJhg1wCDdJG/so78W53m6VjVMfp79mZb/vgoKfi2Jrx6b1QkK5G2m62IQSFVDvAUTQP1o0JwFNVZjraZeFeFGNtNNBHd0TCLMxc932SvXmxQtl6VndrW3zz5vJsxfNDBCojp6HX3GgVK9vIco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713975987; c=relaxed/simple;
	bh=I6pFBHrPRU5Z2cCKG3RAl9CQCSHZHcaqr3fqNrtHn48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWVg8nFQnYHcHJZQ7uB+WQ5PVW3Kf6X0BbFvNfeGL3g8QOouwswFegggorT4yn86Haw4FQXj6LYggGrMV3b5n+Yv4whUipPyLpxHJ7q/zJgy3y9w7beEXD2FkHwNIHRuZcyghLDILLJ/GWzye79OC51hYZD4lqZWTyXMus9DJi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=le9GM7vT; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713975986; x=1745511986;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I6pFBHrPRU5Z2cCKG3RAl9CQCSHZHcaqr3fqNrtHn48=;
  b=le9GM7vTC5WSH/TOm6q+0FMdO3IqDmg+Ip6HSw0eiL4NDevV+nOkyN3Z
   O+tp0oSucFe9bfOZHRT8SzG+PjF2JtKQ9j8kVCKaeSjw/Y6fmkD1gTOpi
   1/LwA1kbbDFNfvlJqbOYjlMmGsowxKt0uUiwSwjU3XkLRcrXZnurlt3KD
   LRBhtekkwkFC6HHZ2c35Jrp0/buJqrKdvs0hlIJ3KEK5TCefw0NsJ2VA9
   XQZ9ULBPWqRXLLcklcDUZD+rs0YhvInQ7C0uIQd15juYJ6ZexyZn/zOXq
   MlNy8XScJFucmwzHTQtazlmwZZddJSuyaTVM2dD/ipswAkWZVA8YtS100
   w==;
X-CSE-ConnectionGUID: F/mEqyh9T+yRtC22PPXnhA==
X-CSE-MsgGUID: 9BGdpWXTQSiGh+6EP99ZXQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="13456323"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="13456323"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 09:26:25 -0700
X-CSE-ConnectionGUID: dZrLZyZVSOqLAc318XUrbQ==
X-CSE-MsgGUID: jnd5jTFxRmOBEn1dWLhsBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="24779901"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 24 Apr 2024 09:26:21 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rzfRr-0001RZ-1g;
	Wed, 24 Apr 2024 16:26:19 +0000
Date: Thu, 25 Apr 2024 00:26:10 +0800
From: kernel test robot <lkp@intel.com>
To: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Michal Simek <monstr@monstr.eu>
Cc: oe-kbuild-all@lists.linux.dev,
	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eng Lee Teh <englee.teh@starfivetech.com>
Subject: Re: [PATCH v1 1/2] spi: spi-cadence: Add optional reset control
 support
Message-ID: <202404250029.8cjM4mtZ-lkp@intel.com>
References: <20240424051317.2084059-2-jisheng.teoh@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424051317.2084059-2-jisheng.teoh@starfivetech.com>

Hi Ji,

kernel test robot noticed the following build errors:

[auto build test ERROR on broonie-spi/for-next]
[also build test ERROR on robh/for-next krzk-dt/for-next linus/master v6.9-rc5 next-20240424]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ji-Sheng-Teoh/spi-spi-cadence-Add-optional-reset-control-support/20240424-131551
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20240424051317.2084059-2-jisheng.teoh%40starfivetech.com
patch subject: [PATCH v1 1/2] spi: spi-cadence: Add optional reset control support
config: nios2-randconfig-r081-20240424 (https://download.01.org/0day-ci/archive/20240425/202404250029.8cjM4mtZ-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240425/202404250029.8cjM4mtZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404250029.8cjM4mtZ-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/spi/spi-cadence.c: In function 'cdns_spi_probe':
>> drivers/spi/spi-cadence.c:593:22: error: implicit declaration of function 'devm_reset_control_get_optional_exclusive' [-Werror=implicit-function-declaration]
     593 |         xspi->rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/spi/spi-cadence.c:593:20: warning: assignment to 'struct reset_control *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     593 |         xspi->rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
         |                    ^
>> drivers/spi/spi-cadence.c:600:9: error: implicit declaration of function 'reset_control_assert' [-Werror=implicit-function-declaration]
     600 |         reset_control_assert(xspi->rstc);
         |         ^~~~~~~~~~~~~~~~~~~~
>> drivers/spi/spi-cadence.c:601:9: error: implicit declaration of function 'reset_control_deassert' [-Werror=implicit-function-declaration]
     601 |         reset_control_deassert(xspi->rstc);
         |         ^~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/devm_reset_control_get_optional_exclusive +593 drivers/spi/spi-cadence.c

   550	
   551	/**
   552	 * cdns_spi_probe - Probe method for the SPI driver
   553	 * @pdev:	Pointer to the platform_device structure
   554	 *
   555	 * This function initializes the driver data structures and the hardware.
   556	 *
   557	 * Return:	0 on success and error value on error
   558	 */
   559	static int cdns_spi_probe(struct platform_device *pdev)
   560	{
   561		int ret = 0, irq;
   562		struct spi_controller *ctlr;
   563		struct cdns_spi *xspi;
   564		u32 num_cs;
   565		bool target;
   566	
   567		target = of_property_read_bool(pdev->dev.of_node, "spi-slave");
   568		if (target)
   569			ctlr = spi_alloc_target(&pdev->dev, sizeof(*xspi));
   570		else
   571			ctlr = spi_alloc_host(&pdev->dev, sizeof(*xspi));
   572	
   573		if (!ctlr)
   574			return -ENOMEM;
   575	
   576		xspi = spi_controller_get_devdata(ctlr);
   577		ctlr->dev.of_node = pdev->dev.of_node;
   578		platform_set_drvdata(pdev, ctlr);
   579	
   580		xspi->regs = devm_platform_ioremap_resource(pdev, 0);
   581		if (IS_ERR(xspi->regs)) {
   582			ret = PTR_ERR(xspi->regs);
   583			goto remove_ctlr;
   584		}
   585	
   586		xspi->pclk = devm_clk_get_enabled(&pdev->dev, "pclk");
   587		if (IS_ERR(xspi->pclk)) {
   588			dev_err(&pdev->dev, "pclk clock not found.\n");
   589			ret = PTR_ERR(xspi->pclk);
   590			goto remove_ctlr;
   591		}
   592	
 > 593		xspi->rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
   594		if (IS_ERR(xspi->rstc)) {
   595			ret = PTR_ERR(xspi->rstc);
   596			dev_err(&pdev->dev, "Cannot get SPI reset.\n");
   597			goto remove_ctlr;
   598		}
   599	
 > 600		reset_control_assert(xspi->rstc);
 > 601		reset_control_deassert(xspi->rstc);
   602	
   603		if (!spi_controller_is_target(ctlr)) {
   604			xspi->ref_clk = devm_clk_get_enabled(&pdev->dev, "ref_clk");
   605			if (IS_ERR(xspi->ref_clk)) {
   606				dev_err(&pdev->dev, "ref_clk clock not found.\n");
   607				ret = PTR_ERR(xspi->ref_clk);
   608				goto remove_ctlr;
   609			}
   610	
   611			pm_runtime_use_autosuspend(&pdev->dev);
   612			pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
   613			pm_runtime_get_noresume(&pdev->dev);
   614			pm_runtime_set_active(&pdev->dev);
   615			pm_runtime_enable(&pdev->dev);
   616	
   617			ret = of_property_read_u32(pdev->dev.of_node, "num-cs", &num_cs);
   618			if (ret < 0)
   619				ctlr->num_chipselect = CDNS_SPI_DEFAULT_NUM_CS;
   620			else
   621				ctlr->num_chipselect = num_cs;
   622	
   623			ret = of_property_read_u32(pdev->dev.of_node, "is-decoded-cs",
   624						   &xspi->is_decoded_cs);
   625			if (ret < 0)
   626				xspi->is_decoded_cs = 0;
   627		}
   628	
   629		cdns_spi_detect_fifo_depth(xspi);
   630	
   631		/* SPI controller initializations */
   632		cdns_spi_init_hw(xspi, spi_controller_is_target(ctlr));
   633	
   634		irq = platform_get_irq(pdev, 0);
   635		if (irq < 0) {
   636			ret = irq;
   637			goto clk_dis_all;
   638		}
   639	
   640		ret = devm_request_irq(&pdev->dev, irq, cdns_spi_irq,
   641				       0, pdev->name, ctlr);
   642		if (ret != 0) {
   643			ret = -ENXIO;
   644			dev_err(&pdev->dev, "request_irq failed\n");
   645			goto clk_dis_all;
   646		}
   647	
   648		ctlr->use_gpio_descriptors = true;
   649		ctlr->prepare_transfer_hardware = cdns_prepare_transfer_hardware;
   650		ctlr->prepare_message = cdns_prepare_message;
   651		ctlr->transfer_one = cdns_transfer_one;
   652		ctlr->unprepare_transfer_hardware = cdns_unprepare_transfer_hardware;
   653		ctlr->mode_bits = SPI_CPOL | SPI_CPHA;
   654		ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
   655	
   656		if (!spi_controller_is_target(ctlr)) {
   657			ctlr->mode_bits |=  SPI_CS_HIGH;
   658			ctlr->set_cs = cdns_spi_chipselect;
   659			ctlr->auto_runtime_pm = true;
   660			xspi->clk_rate = clk_get_rate(xspi->ref_clk);
   661			/* Set to default valid value */
   662			ctlr->max_speed_hz = xspi->clk_rate / 4;
   663			xspi->speed_hz = ctlr->max_speed_hz;
   664			pm_runtime_mark_last_busy(&pdev->dev);
   665			pm_runtime_put_autosuspend(&pdev->dev);
   666		} else {
   667			ctlr->mode_bits |= SPI_NO_CS;
   668			ctlr->target_abort = cdns_target_abort;
   669		}
   670		ret = spi_register_controller(ctlr);
   671		if (ret) {
   672			dev_err(&pdev->dev, "spi_register_controller failed\n");
   673			goto clk_dis_all;
   674		}
   675	
   676		return ret;
   677	
   678	clk_dis_all:
   679		if (!spi_controller_is_target(ctlr)) {
   680			pm_runtime_set_suspended(&pdev->dev);
   681			pm_runtime_disable(&pdev->dev);
   682		}
   683	remove_ctlr:
   684		spi_controller_put(ctlr);
   685		return ret;
   686	}
   687	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

