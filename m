Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C1F7CEA32
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 23:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjJRVqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 17:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjJRVqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 17:46:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92D3EA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 14:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697665589; x=1729201589;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xgdNZ/btJGr/5JZBpMyCC33Jsc4N0BvqOmHeyIP+tZY=;
  b=DQPA71INp6ehydVC668JfWJdT5SLBQzUK/cVDD9ju6VuAnr47rsIYbX9
   +vWHlV0z9+XAtrD8GEGt/f+7gBZfepbuLhjpPnY2g6EP3DXPtvR4SKqxP
   +HerjHVrj8kN1Yc9W5wFRt9O+d7m34RxyudBBI2lv5FFAGlcy9YlHZpuj
   A9mnuZQLgui9yD66lH1D/XXz14ErH1+Rqmpc8Cjt0i+7gZNIdU/+32VXI
   gnKNKev6Af/kWPsNjBh12lRZJqyMsKnFlZi9ouTQybdaeNNoAo3Ms5DkV
   o5gsYyGYiBr+tSz5YczsOmZ5HnvdO789/auue3At3L+PRoUikeOHR8U+y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="385940872"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="385940872"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 14:46:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="760382153"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="760382153"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 18 Oct 2023 14:46:27 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qtEMz-00017A-0D;
        Wed, 18 Oct 2023 21:46:25 +0000
Date:   Thu, 19 Oct 2023 05:46:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: drivers/pci/controller/dwc/pcie-designware.c:898:50: warning: '%d'
 directive output may be truncated writing between 1 and 11 bytes into a
 region of size 3
Message-ID: <202310190534.kkbtdHuH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dd72f9c7e512da377074d47d990564959b772643
commit: 939fbcd568fd294034c96edc92ff5b9de1a5fce8 PCI: dwc: Add Root Port and Endpoint controller eDMA engine support
date:   8 months ago
config: x86_64-buildonly-randconfig-r001-20230530 (https://download.01.org/0day-ci/archive/20231019/202310190534.kkbtdHuH-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231019/202310190534.kkbtdHuH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310190534.kkbtdHuH-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pci/controller/dwc/pcie-designware.c: In function 'dw_pcie_edma_detect':
>> drivers/pci/controller/dwc/pcie-designware.c:898:50: warning: '%d' directive output may be truncated writing between 1 and 11 bytes into a region of size 3 [-Wformat-truncation=]
     898 |                 snprintf(name, sizeof(name), "dma%d", pci->edma.nr_irqs);
         |                                                  ^~
   In function 'dw_pcie_edma_irq_verify',
       inlined from 'dw_pcie_edma_detect' at drivers/pci/controller/dwc/pcie-designware.c:949:8:
   drivers/pci/controller/dwc/pcie-designware.c:898:46: note: directive argument in the range [-2147483648, 22]
     898 |                 snprintf(name, sizeof(name), "dma%d", pci->edma.nr_irqs);
         |                                              ^~~~~~~
   drivers/pci/controller/dwc/pcie-designware.c:898:17: note: 'snprintf' output between 5 and 15 bytes into a destination of size 6
     898 |                 snprintf(name, sizeof(name), "dma%d", pci->edma.nr_irqs);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


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
