Return-Path: <linux-kernel+bounces-1925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF688155E9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 02:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3704E1F255F6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC3A110B;
	Sat, 16 Dec 2023 01:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a7sgx6M8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954241846;
	Sat, 16 Dec 2023 01:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702689479; x=1734225479;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qpeVFT6+nCn8mDQXchne21oMHeQlCw5OMS/VZMi0q/Y=;
  b=a7sgx6M8YbjcOjxRN5LawUMeMDbEm9dxkgoO3Owd0PMqtt2c2vl6ywp3
   zjg7Ehg44o4jzmQBYTpj6JMlosj5ZrvlrpHIMIepgBMAbz/bN+j4iFx1t
   jqDFJgKXxvupE5WzlisI5nYlVurNT/f74y6Jhwz6A2WmQuVHzGWNexDtS
   AXBbJ8S46G9njKdD2P7ZfwkmDTigEqR58lRYrDzE7sBbArXuJnlLesapt
   fCu/cAb4EbCw79AiXs8H65DJeEI2cP0iXzrOwaVSULJ2V3+d8ERkvb7XE
   t4Sxv9+yA7RPsIknM7oPfQfacOxx8QMfVei/dQVaXf+mFqyRcI480nViH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="374849834"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="374849834"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 17:17:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="774937165"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="774937165"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 15 Dec 2023 17:17:55 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEJJR-0000z4-2j;
	Sat, 16 Dec 2023 01:17:53 +0000
Date: Sat, 16 Dec 2023 09:17:24 +0800
From: kernel test robot <lkp@intel.com>
To: Thangaraj Samynathan <thangaraj.s@microchip.com>, broonie@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tharunkumar.Pasumarthi@microchip.com,
	Kumaravel.Thiagarajan@microchip.com, Arun.Ramadoss@microchip.com,
	Ronnie.Kunin@microchip.com,
	jegadheesan.gopalmanoharan@microchip.com
Subject: Re: [PATCH SPI for-next 2/3] spi: mchp-pci1xxxx: DMA Read support
 for copying data into SPI Buf
Message-ID: <202312160922.Eb2xnL8g-lkp@intel.com>
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
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20231216/202312160922.Eb2xnL8g-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231216/202312160922.Eb2xnL8g-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312160922.Eb2xnL8g-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/spi/spi-pci1xxxx.c: In function 'pci1xxxx_spi_transfer_one':
>> drivers/spi/spi-pci1xxxx.c:366:13: warning: variable 'mode' set but not used [-Wunused-but-set-variable]
     366 |         int mode, len, loop_iter, transfer_len;
         |             ^~~~


vim +/mode +366 drivers/spi/spi-pci1xxxx.c

bf37ce4603316bb Thangaraj Samynathan 2023-12-15  361  
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  362  static int pci1xxxx_spi_transfer_one(struct spi_controller *spi_ctlr,
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  363  				     struct spi_device *spi, struct spi_transfer *xfer)
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  364  {
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  365  	struct pci1xxxx_spi_internal *p = spi_controller_get_devdata(spi_ctlr);
1cc0cbea7167af5 Tharun Kumar P       2022-10-06 @366  	int mode, len, loop_iter, transfer_len;
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  367  	struct pci1xxxx_spi *par = p->parent;
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  368  	unsigned long bytes_transfered;
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  369  	unsigned long bytes_recvd;
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  370  	unsigned long loop_count;
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  371  	u8 *rx_buf, result;
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  372  	const u8 *tx_buf;
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  373  	u32 regval;
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  374  	u8 clkdiv;
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  375  
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  376  	p->spi_xfer_in_progress = true;
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  377  	mode = spi->mode;
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  378  	clkdiv = pci1xxxx_get_clock_div(xfer->speed_hz);
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  379  	tx_buf = xfer->tx_buf;
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  380  	rx_buf = xfer->rx_buf;
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  381  	transfer_len = xfer->len;
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  382  	regval = readl(par->reg_base + SPI_MST_EVENT_REG_OFFSET(p->hw_inst));
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  383  	writel(regval, par->reg_base + SPI_MST_EVENT_REG_OFFSET(p->hw_inst));
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  384  
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  385  	if (tx_buf) {
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  386  		bytes_transfered = 0;
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  387  		bytes_recvd = 0;
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  388  		loop_count = transfer_len / SPI_MAX_DATA_LEN;
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  389  		if (transfer_len % SPI_MAX_DATA_LEN != 0)
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  390  			loop_count += 1;
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  391  
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  392  		for (loop_iter = 0; loop_iter < loop_count; loop_iter++) {
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  393  			len = SPI_MAX_DATA_LEN;
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  394  			if ((transfer_len % SPI_MAX_DATA_LEN != 0) &&
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  395  			    (loop_iter == loop_count - 1))
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  396  				len = transfer_len % SPI_MAX_DATA_LEN;
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  397  
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  398  			reinit_completion(&p->spi_xfer_done);
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  399  			memcpy_toio(par->reg_base + SPI_MST_CMD_BUF_OFFSET(p->hw_inst),
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  400  				    &tx_buf[bytes_transfered], len);
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  401  			bytes_transfered += len;
bf37ce4603316bb Thangaraj Samynathan 2023-12-15  402  			pci1xxxx_spi_setup(par, p->hw_inst, spi->mode, clkdiv, len);
bf37ce4603316bb Thangaraj Samynathan 2023-12-15  403  			pci1xxxx_start_spi_xfer(p, p->hw_inst);
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  404  
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  405  			/* Wait for DMA_TERM interrupt */
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  406  			result = wait_for_completion_timeout(&p->spi_xfer_done,
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  407  							     PCI1XXXX_SPI_TIMEOUT);
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  408  			if (!result)
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  409  				return -ETIMEDOUT;
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  410  
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  411  			if (rx_buf) {
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  412  				memcpy_fromio(&rx_buf[bytes_recvd], par->reg_base +
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  413  					      SPI_MST_RSP_BUF_OFFSET(p->hw_inst), len);
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  414  				bytes_recvd += len;
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  415  			}
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  416  		}
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  417  	}
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  418  	p->spi_xfer_in_progress = false;
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  419  
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  420  	return 0;
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  421  }
1cc0cbea7167af5 Tharun Kumar P       2022-10-06  422  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

