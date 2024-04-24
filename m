Return-Path: <linux-kernel+bounces-157536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D538B1288
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68C311F20CCA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE12718B1A;
	Wed, 24 Apr 2024 18:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ILxkC2G3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFCB1FDD;
	Wed, 24 Apr 2024 18:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713984093; cv=none; b=VsMD/vSUc7OpX3EkQxXo3JeJQsrrnKLlsUy2h0kDxQIM3d12v/KeN6E/eNKtkwN8g9QUbX+NfsoeyoEJXSqFe85O27oA6b4NFpdJEdrTxXPu5pr7IZ2wNl8TvyukcbBanc7N8741tgMqWuluOWEsmQK/g1UxW6+c8zBEWvK1UU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713984093; c=relaxed/simple;
	bh=kzZQaB5GtZ+QKzA70o+yGDoOKj7SVZ+KzMiOqdNiaoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhuOkVNaZO2rJL1IwHwkoZMiFp14HgEO7AedhpKePcx9YiiTaQgmL+7VxYGPO9XBu4cy5Ycs1I/Fp2I9xQSyX3vYqvZEjjEdqfUST0p43xOyMN4E//L7+ck3lTfMw47gdp4nZaOFUXOgOEcAvxyEgLuFz8BkOO9h9gYd1aWtt5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ILxkC2G3; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713984092; x=1745520092;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kzZQaB5GtZ+QKzA70o+yGDoOKj7SVZ+KzMiOqdNiaoY=;
  b=ILxkC2G3jeAoOtuo2EYbPqj8LUpguPxQ7q7mS03pZnep+OunkKsY5HVI
   oi1bkuG26SD7W3RzoYlhVne4kMkd1HMFMyDRU8boHa953WwpnVY6osxka
   N/tZGZr0Si1aSk7OBrYRXEOUd9n9B3xEPqPFbpYIVIFW+7msXdVuHK4fG
   l4Yj70LGOVj83IzN88K8jpfQbqTz0Vk88R0nwkwET5H/yFp306ncebnzX
   nINhSEF4JpOvD2wsSeXW3LHca/qQcOj3Rb7BEmg2eTBmSEOGykV4ukmUW
   PlAeoxnP1ohTv+kN+HcfGO+xz2SSh88LiaGjffGLuhXNKKPKKriTE41bu
   Q==;
X-CSE-ConnectionGUID: a39ikSP3TaqENMk+mWlBaA==
X-CSE-MsgGUID: YeCa1Kq2Qo2+NICH5tB68g==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="13422967"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="13422967"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:41:31 -0700
X-CSE-ConnectionGUID: wqTHl7JJReqs5HYabPqhqA==
X-CSE-MsgGUID: fxEjS7Z2SPqCu/yhMAcCUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="29593424"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 24 Apr 2024 11:41:28 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rzhYa-0001YS-2Z;
	Wed, 24 Apr 2024 18:41:24 +0000
Date: Thu, 25 Apr 2024 02:40:51 +0800
From: kernel test robot <lkp@intel.com>
To: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Michal Simek <monstr@monstr.eu>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eng Lee Teh <englee.teh@starfivetech.com>
Subject: Re: [PATCH v1 1/2] spi: spi-cadence: Add optional reset control
 support
Message-ID: <202404250235.htdVhIMY-lkp@intel.com>
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
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240425/202404250235.htdVhIMY-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240425/202404250235.htdVhIMY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404250235.htdVhIMY-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/spi/spi-cadence.c:593:15: error: implicit declaration of function 'devm_reset_control_get_optional_exclusive' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           xspi->rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
                        ^
>> drivers/spi/spi-cadence.c:593:13: warning: incompatible integer to pointer conversion assigning to 'struct reset_control *' from 'int' [-Wint-conversion]
           xspi->rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
                      ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/spi/spi-cadence.c:600:2: error: implicit declaration of function 'reset_control_assert' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           reset_control_assert(xspi->rstc);
           ^
>> drivers/spi/spi-cadence.c:601:2: error: implicit declaration of function 'reset_control_deassert' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           reset_control_deassert(xspi->rstc);
           ^
   drivers/spi/spi-cadence.c:601:2: note: did you mean 'reset_control_assert'?
   drivers/spi/spi-cadence.c:600:2: note: 'reset_control_assert' declared here
           reset_control_assert(xspi->rstc);
           ^
   1 warning and 3 errors generated.


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

