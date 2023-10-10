Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B2B7C040A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 21:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343726AbjJJTDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 15:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343716AbjJJTDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:03:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FB9AC
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 12:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696964587; x=1728500587;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=g6ICwdHm2qLrdz71DY2dLOuCiuEY/QKetDo4YI9iKGs=;
  b=KdWMOj0u02BKuNlA97RIGgpX0hmJ+GGGajdp/YJRoEjZ8Lmc5m5KJ8Ai
   Z3rFAxhGUUmQgWEvqjdPdDYr72cxMAq7Ax6xCAkbhnEVvqlFS6xqxA/AY
   5KivwQEzZHPXu6dOV9R8TSI58R/JOhHrtqeLuHMefUDyhC9wICoxejx73
   gJPmw+q2ULEVAT1H4620p1v4QavCN0rHLB7K/2vSM6tJx/IhhLgciMsNA
   lfgKRN7REuUNR7QWhHpBXmGapAa2cj1QNt67a89AozxouGIICP8dt5u5I
   KY79fIWUAD1iAy/RpykTKWfdWOwHfbjqFdKW9heogu0VK+TjUctcppfCD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="387328691"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="387328691"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 12:03:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="703413383"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="703413383"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 10 Oct 2023 12:03:05 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qqI0U-0000x6-32;
        Tue, 10 Oct 2023 19:03:02 +0000
Date:   Wed, 11 Oct 2023 03:02:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>,
        Jianmin Lv <lvjianmin@loongson.cn>
Subject: drivers/pci/controller/pcie-mediatek.c:400:40: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202310110223.HPW666St-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   94f6f0550c625fab1f373bb86a6669b45e9748b3
commit: 57fc7323a8e7c2e7c1d5795ab63cb3ffea3cfdfb LoongArch: Add PCI controller support
date:   1 year, 2 months ago
config: loongarch-randconfig-r122-20230906 (https://download.01.org/0day-ci/archive/20231011/202310110223.HPW666St-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231011/202310110223.HPW666St-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310110223.HPW666St-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/pci/controller/pcie-mediatek.c:400:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile *address @@     got void [noderef] __iomem * @@
   drivers/pci/controller/pcie-mediatek.c:400:40: sparse:     expected void volatile *address
   drivers/pci/controller/pcie-mediatek.c:400:40: sparse:     got void [noderef] __iomem *
   drivers/pci/controller/pcie-mediatek.c:523:44: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile *address @@     got void [noderef] __iomem * @@
   drivers/pci/controller/pcie-mediatek.c:523:44: sparse:     expected void volatile *address
   drivers/pci/controller/pcie-mediatek.c:523:44: sparse:     got void [noderef] __iomem *
--
   drivers/uio/uio_aec.c:44:49: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *int_flag @@     got void * @@
   drivers/uio/uio_aec.c:44:49: sparse:     expected void [noderef] __iomem *int_flag
   drivers/uio/uio_aec.c:44:49: sparse:     got void *
>> drivers/uio/uio_aec.c:50:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:50:49: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/uio/uio_aec.c:50:49: sparse:     got void *
   drivers/uio/uio_aec.c:59:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:59:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/uio/uio_aec.c:59:9: sparse:     got void *
   drivers/uio/uio_aec.c:59:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:59:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/uio/uio_aec.c:59:9: sparse:     got void *
   drivers/uio/uio_aec.c:59:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:59:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/uio/uio_aec.c:59:9: sparse:     got void *
   drivers/uio/uio_aec.c:59:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:59:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/uio/uio_aec.c:59:9: sparse:     got void *
   drivers/uio/uio_aec.c:59:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:59:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/uio/uio_aec.c:59:9: sparse:     got void *
   drivers/uio/uio_aec.c:59:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:59:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/uio/uio_aec.c:59:9: sparse:     got void *
   drivers/uio/uio_aec.c:88:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *priv @@     got void [noderef] __iomem * @@
   drivers/uio/uio_aec.c:88:20: sparse:     expected void *priv
   drivers/uio/uio_aec.c:88:20: sparse:     got void [noderef] __iomem *
>> drivers/uio/uio_aec.c:104:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:104:42: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/uio/uio_aec.c:104:42: sparse:     got void *
   drivers/uio/uio_aec.c:105:43: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:105:43: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/uio/uio_aec.c:105:43: sparse:     got void *
   drivers/uio/uio_aec.c:106:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:106:34: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/uio/uio_aec.c:106:34: sparse:     got void *
   drivers/uio/uio_aec.c:115:31: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got void *priv @@
   drivers/uio/uio_aec.c:115:31: sparse:     expected void [noderef] __iomem *
   drivers/uio/uio_aec.c:115:31: sparse:     got void *priv
   drivers/uio/uio_aec.c:128:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:128:42: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/uio/uio_aec.c:128:42: sparse:     got void *
   drivers/uio/uio_aec.c:129:43: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:129:43: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/uio/uio_aec.c:129:43: sparse:     got void *
   drivers/uio/uio_aec.c:131:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:131:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/uio/uio_aec.c:131:28: sparse:     got void *
   drivers/uio/uio_aec.c:136:31: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got void *priv @@
   drivers/uio/uio_aec.c:136:31: sparse:     expected void [noderef] __iomem *
   drivers/uio/uio_aec.c:136:31: sparse:     got void *priv

vim +400 drivers/pci/controller/pcie-mediatek.c

b099631df160ec6 drivers/pci/host/pcie-mediatek.c Ryder Lee     2017-08-10  393  
42fe2f91b4ebc07 drivers/pci/host/pcie-mediatek.c Honghui Zhang 2018-05-04  394  static void mtk_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
43e6409db64ddab drivers/pci/host/pcie-mediatek.c Honghui Zhang 2017-08-14  395  {
42fe2f91b4ebc07 drivers/pci/host/pcie-mediatek.c Honghui Zhang 2018-05-04  396  	struct mtk_pcie_port *port = irq_data_get_irq_chip_data(data);
42fe2f91b4ebc07 drivers/pci/host/pcie-mediatek.c Honghui Zhang 2018-05-04  397  	phys_addr_t addr;
43e6409db64ddab drivers/pci/host/pcie-mediatek.c Honghui Zhang 2017-08-14  398  
42fe2f91b4ebc07 drivers/pci/host/pcie-mediatek.c Honghui Zhang 2018-05-04  399  	/* MT2712/MT7622 only support 32-bit MSI addresses */
42fe2f91b4ebc07 drivers/pci/host/pcie-mediatek.c Honghui Zhang 2018-05-04 @400  	addr = virt_to_phys(port->base + PCIE_MSI_VECTOR);
42fe2f91b4ebc07 drivers/pci/host/pcie-mediatek.c Honghui Zhang 2018-05-04  401  	msg->address_hi = 0;
42fe2f91b4ebc07 drivers/pci/host/pcie-mediatek.c Honghui Zhang 2018-05-04  402  	msg->address_lo = lower_32_bits(addr);
42fe2f91b4ebc07 drivers/pci/host/pcie-mediatek.c Honghui Zhang 2018-05-04  403  
42fe2f91b4ebc07 drivers/pci/host/pcie-mediatek.c Honghui Zhang 2018-05-04  404  	msg->data = data->hwirq;
43e6409db64ddab drivers/pci/host/pcie-mediatek.c Honghui Zhang 2017-08-14  405  
42fe2f91b4ebc07 drivers/pci/host/pcie-mediatek.c Honghui Zhang 2018-05-04  406  	dev_dbg(port->pcie->dev, "msi#%d address_hi %#x address_lo %#x\n",
42fe2f91b4ebc07 drivers/pci/host/pcie-mediatek.c Honghui Zhang 2018-05-04  407  		(int)data->hwirq, msg->address_hi, msg->address_lo);
43e6409db64ddab drivers/pci/host/pcie-mediatek.c Honghui Zhang 2017-08-14  408  }
43e6409db64ddab drivers/pci/host/pcie-mediatek.c Honghui Zhang 2017-08-14  409  

:::::: The code at line 400 was first introduced by commit
:::::: 42fe2f91b4ebc07c815fb334ea1262e6dc23bf77 PCI: mediatek: Implement chained IRQ handling setup

:::::: TO: Honghui Zhang <honghui.zhang@mediatek.com>
:::::: CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
