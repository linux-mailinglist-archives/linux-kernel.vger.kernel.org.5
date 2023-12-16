Return-Path: <linux-kernel+bounces-2151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F27D8158B1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 11:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 092701F25A88
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 10:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B22B156C0;
	Sat, 16 Dec 2023 10:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Og2RndLr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E01714A8A;
	Sat, 16 Dec 2023 10:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702723537; x=1734259537;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I0qrNg6Slh+zGrDjlVe0Cfl4FAancD/6o5nFADSVZlY=;
  b=Og2RndLr4j5iOTvaqvykbAe2d/wGBTCwXUvXbJ7uXrip0IE1x4qGkclx
   l+FtBa5bgT2NasmOmvkJAxwxssifl0uOv4mN5iuTrjjjRak4swfLwofSI
   Sy96C4w2NSBT2+FPp5sZfEXV0mfKULV8RTc4wAiPA5C+LuVuBhPjE+O9g
   7FtQI87C2ERuI5ysbU8Tb4bsKh+LPhKlvze+zybGK2SO+GKQW2KrpJ6gO
   aIMQpUSYKa69mcmJq12SsrCzPw4R2VcQkDtxehWfgiwyivDV36OY2r47V
   xhYq73YDJbeIP1QRNaTVPFIyiy4gn+MumMRQLDhCCBDNovXJqOmX9WPcy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="459695317"
X-IronPort-AV: E=Sophos;i="6.04,281,1695711600"; 
   d="scan'208";a="459695317"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2023 02:45:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="948241864"
X-IronPort-AV: E=Sophos;i="6.04,281,1695711600"; 
   d="scan'208";a="948241864"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 16 Dec 2023 02:45:33 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rESAl-0001Tu-1P;
	Sat, 16 Dec 2023 10:45:31 +0000
Date: Sat, 16 Dec 2023 18:44:40 +0800
From: kernel test robot <lkp@intel.com>
To: Thangaraj Samynathan <thangaraj.s@microchip.com>, broonie@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tharunkumar.Pasumarthi@microchip.com,
	Kumaravel.Thiagarajan@microchip.com, Arun.Ramadoss@microchip.com,
	Ronnie.Kunin@microchip.com,
	jegadheesan.gopalmanoharan@microchip.com
Subject: Re: [PATCH SPI for-next 2/3] spi: mchp-pci1xxxx: DMA Read support
 for copying data into SPI Buf
Message-ID: <202312161832.s8L4PtmO-lkp@intel.com>
References: <20231215114748.152319-3-thangaraj.s@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215114748.152319-3-thangaraj.s@microchip.com>

Hi Thangaraj,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-spi/for-next]
[also build test WARNING on linus/master v6.7-rc5 next-20231215]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Thangaraj-Samynathan/spi-mchp-pci1xxxx-Add-support-for-DMA-in-SPI/20231215-195133
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20231215114748.152319-3-thangaraj.s%40microchip.com
patch subject: [PATCH SPI for-next 2/3] spi: mchp-pci1xxxx: DMA Read support for copying data into SPI Buf
config: arc-randconfig-r132-20231216 (https://download.01.org/0day-ci/archive/20231216/202312161832.s8L4PtmO-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231216/202312161832.s8L4PtmO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312161832.s8L4PtmO-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/spi/spi-pci1xxxx.c:321:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *base @@     got void [noderef] __iomem * @@
   drivers/spi/spi-pci1xxxx.c:321:22: sparse:     expected void *base
   drivers/spi/spi-pci1xxxx.c:321:22: sparse:     got void [noderef] __iomem *
   drivers/spi/spi-pci1xxxx.c:323:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *base @@     got void [noderef] __iomem * @@
   drivers/spi/spi-pci1xxxx.c:323:22: sparse:     expected void *base
   drivers/spi/spi-pci1xxxx.c:323:22: sparse:     got void [noderef] __iomem *
>> drivers/spi/spi-pci1xxxx.c:325:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/spi/spi-pci1xxxx.c:325:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/spi/spi-pci1xxxx.c:325:9: sparse:     got void *
   drivers/spi/spi-pci1xxxx.c:326:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/spi/spi-pci1xxxx.c:326:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/spi/spi-pci1xxxx.c:326:9: sparse:     got void *
   drivers/spi/spi-pci1xxxx.c:327:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/spi/spi-pci1xxxx.c:327:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/spi/spi-pci1xxxx.c:327:9: sparse:     got void *
   drivers/spi/spi-pci1xxxx.c:328:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/spi/spi-pci1xxxx.c:328:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/spi/spi-pci1xxxx.c:328:9: sparse:     got void *
   drivers/spi/spi-pci1xxxx.c:330:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/spi/spi-pci1xxxx.c:330:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/spi/spi-pci1xxxx.c:330:9: sparse:     got void *
   drivers/spi/spi-pci1xxxx.c:332:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/spi/spi-pci1xxxx.c:332:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/spi/spi-pci1xxxx.c:332:9: sparse:     got void *
   drivers/spi/spi-pci1xxxx.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false

vim +321 drivers/spi/spi-pci1xxxx.c

   314	
   315	static void pci1xxxx_spi_setup_dma_read(struct pci1xxxx_spi_internal *p,
   316						dma_addr_t dma_addr, u32 len)
   317	{
   318		void *base;
   319	
   320		if (!p->hw_inst)
 > 321			base = p->parent->dma_offset_bar + SPI_DMA_CH0_RD_BASE;
   322		else
   323			base = p->parent->dma_offset_bar + SPI_DMA_CH1_RD_BASE;
   324	
 > 325		writel(DMA_INTR_EN, base + SPI_DMA_CH_CTL1_OFFSET);
   326		writel(len, base + SPI_DMA_CH_XFER_LEN_OFFSET);
   327		writel(lower_32_bits(dma_addr), base + SPI_DMA_CH_SAR_LO_OFFSET);
   328		writel(upper_32_bits(dma_addr), base + SPI_DMA_CH_SAR_HI_OFFSET);
   329		/* Updated SPI Command Registers */
   330		writel(lower_32_bits(SPI_PERI_ADDR_BASE + SPI_MST_CMD_BUF_OFFSET(p->hw_inst)),
   331		       base + SPI_DMA_CH_DAR_LO_OFFSET);
   332		writel(upper_32_bits(SPI_PERI_ADDR_BASE + SPI_MST_CMD_BUF_OFFSET(p->hw_inst)),
   333		       base + SPI_DMA_CH_DAR_HI_OFFSET);
   334	}
   335	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

