Return-Path: <linux-kernel+bounces-160451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBCF8B3DA5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 524961F238DC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FDC15B15D;
	Fri, 26 Apr 2024 17:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KZ7m4PVa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270B915AACD
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714151523; cv=none; b=OxgGoVL+59ckNID/l/bJGe5df/Aw/0stmZl9vOWvQxJWQhU9Q+B2eIZZ9qWbjUh08DrADCuHD1oljZmHbD287aVidYSyD2m5zv2go7q8rarO3EXU2mbftyW3Jbpe2u3hLmUlEov6qRdhwqEnPYSq6LHu8nt54gAOKbn4l65usno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714151523; c=relaxed/simple;
	bh=3Pd/l/+E5Qm5+7Ld6em+fLyRN0LjhCMbADm7ZQPuL/w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sG3QfWChVTKgW+QJKafhgkKP0A32r5ula/fy1YuLa2fIZUlODpSz+696kPa+1tSrssdH0PUjc5HGlC6+ccyPM/uFVTxnrmEKGDw2hRNR94jEcVqf/CJpksulTDGk1sLLmpGvs6GCwlHxVIRTDr+p/1cqtgV76q6OhemgpEYxiE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KZ7m4PVa; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714151522; x=1745687522;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3Pd/l/+E5Qm5+7Ld6em+fLyRN0LjhCMbADm7ZQPuL/w=;
  b=KZ7m4PVaAxVVQNDBQnwBmaMjEl261TCRY/Iycqko/Pyc63UgvFNt26Dl
   i2KbbOL+EUdfIrM9dk0Dg/5eR5AHCNfWrGWwKtyJuD4RJ/ok8R0jT0b/H
   IQ6gDX5n2yuYnEfIj86LFImQmTDwLqfj055jYcfqI4MmvS5Gexon3uT8J
   8QZS9aC6rLD/Y2K0qp1oxLO6SQNE08kal5vB8fbOR4aczh4alSFk7iu80
   G4u3ar1pzmsIAhtS1hJULWw45GcEgXknskKf8tlZQLwACZrTIMMxQDjQE
   QEzN80OkqjizIMNWdI2Ynozbwa1Q2+1TqDEZaeqGbvCcDU3yMAFXggKGq
   g==;
X-CSE-ConnectionGUID: xYK1N6ntSjSzj4bjCZZz6Q==
X-CSE-MsgGUID: 4raaSl2nS+GvEbBkROUMOA==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="20449274"
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="20449274"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 10:12:02 -0700
X-CSE-ConnectionGUID: 7A0i5Nk8R1SFT6S1ocLM+Q==
X-CSE-MsgGUID: YZxipWCARm25Dx49Iw6AIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="25451311"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 26 Apr 2024 10:12:00 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s0P77-0003zy-2O;
	Fri, 26 Apr 2024 17:11:57 +0000
Date: Sat, 27 Apr 2024 01:11:10 +0800
From: kernel test robot <lkp@intel.com>
To: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: drivers/pci/controller/dwc/pcie-designware.c:898:50: error: '%d'
 directive output may be truncated writing between 1 and 11 bytes into a
 region of size 3
Message-ID: <202404270143.m5ItVzEF-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Serge,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c942a0cd3603e34dd2d7237e064d9318cb7f9654
commit: 939fbcd568fd294034c96edc92ff5b9de1a5fce8 PCI: dwc: Add Root Port and Endpoint controller eDMA engine support
date:   1 year, 2 months ago
config: x86_64-sof-customedconfig-bpf-defconfig (https://download.01.org/0day-ci/archive/20240427/202404270143.m5ItVzEF-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240427/202404270143.m5ItVzEF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404270143.m5ItVzEF-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/controller/dwc/pcie-designware.c: In function 'dw_pcie_edma_detect':
>> drivers/pci/controller/dwc/pcie-designware.c:898:50: error: '%d' directive output may be truncated writing between 1 and 11 bytes into a region of size 3 [-Werror=format-truncation=]
     898 |                 snprintf(name, sizeof(name), "dma%d", pci->edma.nr_irqs);
         |                                                  ^~
   In function 'dw_pcie_edma_irq_verify',
       inlined from 'dw_pcie_edma_detect' at drivers/pci/controller/dwc/pcie-designware.c:949:8:
   drivers/pci/controller/dwc/pcie-designware.c:898:46: note: directive argument in the range [-2147483648, 15]
     898 |                 snprintf(name, sizeof(name), "dma%d", pci->edma.nr_irqs);
         |                                              ^~~~~~~
   drivers/pci/controller/dwc/pcie-designware.c:898:17: note: 'snprintf' output between 5 and 15 bytes into a destination of size 6
     898 |                 snprintf(name, sizeof(name), "dma%d", pci->edma.nr_irqs);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +898 drivers/pci/controller/dwc/pcie-designware.c

   878	
   879	static int dw_pcie_edma_irq_verify(struct dw_pcie *pci)
   880	{
   881		struct platform_device *pdev = to_platform_device(pci->dev);
   882		u16 ch_cnt = pci->edma.ll_wr_cnt + pci->edma.ll_rd_cnt;
   883		char name[6];
   884		int ret;
   885	
   886		if (pci->edma.nr_irqs == 1)
   887			return 0;
   888		else if (pci->edma.nr_irqs > 1)
   889			return pci->edma.nr_irqs != ch_cnt ? -EINVAL : 0;
   890	
   891		ret = platform_get_irq_byname_optional(pdev, "dma");
   892		if (ret > 0) {
   893			pci->edma.nr_irqs = 1;
   894			return 0;
   895		}
   896	
   897		for (; pci->edma.nr_irqs < ch_cnt; pci->edma.nr_irqs++) {
 > 898			snprintf(name, sizeof(name), "dma%d", pci->edma.nr_irqs);
   899	
   900			ret = platform_get_irq_byname_optional(pdev, name);
   901			if (ret <= 0)
   902				return -EINVAL;
   903		}
   904	
   905		return 0;
   906	}
   907	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

