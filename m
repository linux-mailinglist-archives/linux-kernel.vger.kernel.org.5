Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B428C7F2BC4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbjKULdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbjKULc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:32:59 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA01110;
        Tue, 21 Nov 2023 03:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700566375; x=1732102375;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e9FE42TLG/FvdI9S3SWrIySMHczvHW0nenWXFS9lTmM=;
  b=nNr1G7959BrLUxBioYCp88R8X+nMtASyepJYmeuC5tcyOaRy4M4FBEXa
   vHCSkJUF2BwBdxYCobZUG82W0FJciXbzfcYyxTx7j8d6LWiQO6buHRvur
   nUwW+xmEfZFtredD7eLf4xcC8s7JKucoYPlyTLVvmswLoz7JMTtUDqVRa
   M4vE6eS8KGP0ix1galCmBVH1vbvYr53WcfsLhobh0ROaHk2+pxZ3x3f+I
   /LX1/PO8MekbDmCmFOzH4IsNt6DPW0QLPtnzobWkPzuTy1HMM5F05AQgs
   HjD1N/i3PHxYVvqKscvgMOZlU9eoCauRqWkrCQ3Xc6fPsXjZFfhNKhhHh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="371157256"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="371157256"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 03:32:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="743021699"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="743021699"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 21 Nov 2023 03:32:50 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5OzP-0007ja-1I;
        Tue, 21 Nov 2023 11:32:36 +0000
Date:   Tue, 21 Nov 2023 19:32:13 +0800
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
Message-ID: <202311211958.Z1kPUdyp-lkp@intel.com>
References: <170052491316.21557.13173111699965824301.stgit@skinsburskii.>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170052491316.21557.13173111699965824301.stgit@skinsburskii.>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
config: openrisc-allmodconfig (https://download.01.org/0day-ci/archive/20231121/202311211958.Z1kPUdyp-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231121/202311211958.Z1kPUdyp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311211958.Z1kPUdyp-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pci/controller/pcie-mediatek.c: In function 'mtk_compose_msi_msg':
>> drivers/pci/controller/pcie-mediatek.c:400:62: warning: passing argument 1 of 'virt_to_phys' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     400 |         addr = virt_to_phys((__force const void *)port->base + PCIE_MSI_VECTOR);
         |                                                              ^
   In file included from arch/openrisc/include/asm/io.h:37,
                    from include/linux/io.h:13,
                    from include/linux/iopoll.h:14,
                    from drivers/pci/controller/pcie-mediatek.c:12:
   include/asm-generic/io.h:1003:57: note: expected 'volatile void *' but argument is of type 'const void *'
    1003 | static inline unsigned long virt_to_phys(volatile void *address)
         |                                          ~~~~~~~~~~~~~~~^~~~~~~
   drivers/pci/controller/pcie-mediatek.c: In function 'mtk_pcie_enable_msi':
   drivers/pci/controller/pcie-mediatek.c:523:66: warning: passing argument 1 of 'virt_to_phys' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     523 |         msg_addr = virt_to_phys((__force const void *)port->base + PCIE_MSI_VECTOR);
         |                                                                  ^
   include/asm-generic/io.h:1003:57: note: expected 'volatile void *' but argument is of type 'const void *'
    1003 | static inline unsigned long virt_to_phys(volatile void *address)
         |                                          ~~~~~~~~~~~~~~~^~~~~~~


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
