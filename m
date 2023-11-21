Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B6E7F2CF4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbjKUMTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbjKUMTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:19:06 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A409186;
        Tue, 21 Nov 2023 04:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700569143; x=1732105143;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SdXthQjnrrZo9AkzWMY7oGpGWTtB+tK49t5BJyhg9q4=;
  b=PuXuTdVdcgmi9XkslxzVOYPs0rk4NJvs7s1jtn0qO6+6xoKzUJcUskEa
   VcGU4oQhAQGmK0CJCwiLRWBVFyFDydkU4tjqWrdrxD7iGFLj99vpbz5yZ
   U145ovPJ3gomNVf8tRcmsLEsmCvdlY9We79k/P+OJZ1aJGkoa75mFkXZN
   Vp1m43jd3R6FC32DpPz25fa8Vmxj+bXMzzODCbY02ISK5tUvJ/uDoCa5Y
   zVnr5C5fXrL0Ka+GxduQe+Ly89svxg8o1bKSdE5MxquyRAG7dAGTnI4Jz
   VjhGQEIUBrVPzHksaVdxSsztBRM6eX0K4xXjKCNREgI5FFLXC6bQqc90j
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="10493429"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="10493429"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 04:19:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="8076113"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 21 Nov 2023 04:18:58 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5PiQ-0007mW-37;
        Tue, 21 Nov 2023 12:18:55 +0000
Date:   Tue, 21 Nov 2023 20:18:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
        ryder.lee@mediatek.com, jianjun.wang@mediatek.com,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] PCI: mediatek: Fix sparse warning caused to
 virt_to_phys() prototype change
Message-ID: <202311212050.Z3EDRIR3-lkp@intel.com>
References: <170052491316.21557.13173111699965824301.stgit@skinsburskii.>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170052491316.21557.13173111699965824301.stgit@skinsburskii.>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stanislav,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.7-rc2 next-20231121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stanislav-Kinsburskii/PCI-mediatek-Fix-sparse-warning-caused-to-virt_to_phys-prototype-change/20231121-080253
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/170052491316.21557.13173111699965824301.stgit%40skinsburskii.
patch subject: [PATCH v2] PCI: mediatek: Fix sparse warning caused to virt_to_phys() prototype change
config: s390-randconfig-r113-20231121 (https://download.01.org/0day-ci/archive/20231121/202311212050.Z3EDRIR3-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231121/202311212050.Z3EDRIR3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311212050.Z3EDRIR3-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/pci/controller/pcie-mediatek.c:400:62: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void volatile *address @@     got void const * @@
   drivers/pci/controller/pcie-mediatek.c:400:62: sparse:     expected void volatile *address
   drivers/pci/controller/pcie-mediatek.c:400:62: sparse:     got void const *
   drivers/pci/controller/pcie-mediatek.c:523:66: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void volatile *address @@     got void const * @@
   drivers/pci/controller/pcie-mediatek.c:523:66: sparse:     expected void volatile *address
   drivers/pci/controller/pcie-mediatek.c:523:66: sparse:     got void const *

vim +400 drivers/pci/controller/pcie-mediatek.c

   393	
   394	static void mtk_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
   395	{
   396		struct mtk_pcie_port *port = irq_data_get_irq_chip_data(data);
   397		phys_addr_t addr;
   398	
   399		/* MT2712/MT7622 only support 32-bit MSI addresses */
 > 400		addr = virt_to_phys((__force const void *)port->base + PCIE_MSI_VECTOR);
   401		msg->address_hi = 0;
   402		msg->address_lo = lower_32_bits(addr);
   403	
   404		msg->data = data->hwirq;
   405	
   406		dev_dbg(port->pcie->dev, "msi#%d address_hi %#x address_lo %#x\n",
   407			(int)data->hwirq, msg->address_hi, msg->address_lo);
   408	}
   409	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
