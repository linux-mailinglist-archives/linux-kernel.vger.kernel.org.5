Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6EB7BC061
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 22:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbjJFUbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 16:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbjJFUbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 16:31:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F18C5
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 13:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696624293; x=1728160293;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/J8gZ8L7hl3O6no8WeVh4EuERdE7tFbN+p1mX9+8Rcg=;
  b=INbprGF3VJdmyhUBIRQo2xdveB1Xon97K0spgZeomN50CL5i3fhC/xke
   FK0UxWI81peOxz/9f+azHVSdSCPxEXfQG/L8gpkjqNgI33LJw+AgkTTwV
   JMSu5ptvDbGkSC1DQ4vnyWgb0CgsT2La6rZWgKhrViKZdiwAkaEc/geqe
   /1F9tAr8VOK8G8fagjHP1kNDkd2J86r3DeVz0cW3GMlVhduTDYioyAoBb
   1AqXOCkVIvjJjsTGW76rQyZAYnp634VMnrwUjcblWEmjrAx16eimhbZA2
   /dTPeUM9+XbuoRxB8SXP9QXB7oJ1CH1uiGwrEADv+haN/oMLwbnG7kOt3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="368904013"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="368904013"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 13:31:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="787500392"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="787500392"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 06 Oct 2023 13:31:31 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qorTt-0003c9-1A;
        Fri, 06 Oct 2023 20:31:29 +0000
Date:   Sat, 7 Oct 2023 04:31:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Wilczynski <kw@linux.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: arch/mips/pci/fixup-lantiq.c:13:5: warning: no previous prototype
 for 'pcibios_plat_dev_init'
Message-ID: <202310070445.tzRBNYRC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   af95dc6fdc25e616051d0234aad638e15c02ec8f
commit: bbd8810d399812f2016713565e4d8ff8f1508aa6 PCI: Remove unused includes and superfluous struct declaration
date:   3 years, 11 months ago
config: mips-xway_defconfig (https://download.01.org/0day-ci/archive/20231007/202310070445.tzRBNYRC-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231007/202310070445.tzRBNYRC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310070445.tzRBNYRC-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/mips/pci/fixup-lantiq.c:13:5: warning: no previous prototype for 'pcibios_plat_dev_init' [-Wmissing-prototypes]
      13 | int pcibios_plat_dev_init(struct pci_dev *dev)
         |     ^~~~~~~~~~~~~~~~~~~~~
>> arch/mips/pci/fixup-lantiq.c:24:5: warning: no previous prototype for 'pcibios_map_irq' [-Wmissing-prototypes]
      24 | int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
         |     ^~~~~~~~~~~~~~~


vim +/pcibios_plat_dev_init +13 arch/mips/pci/fixup-lantiq.c

57c8cb8f242988 John Crispin 2012-05-11  12  
57c8cb8f242988 John Crispin 2012-05-11 @13  int pcibios_plat_dev_init(struct pci_dev *dev)
57c8cb8f242988 John Crispin 2012-05-11  14  {
57c8cb8f242988 John Crispin 2012-05-11  15  	if (ltq_pci_plat_arch_init)
57c8cb8f242988 John Crispin 2012-05-11  16  		return ltq_pci_plat_arch_init(dev);
57c8cb8f242988 John Crispin 2012-05-11  17  
57c8cb8f242988 John Crispin 2012-05-11  18  	if (ltq_pci_plat_dev_init)
57c8cb8f242988 John Crispin 2012-05-11  19  		return ltq_pci_plat_dev_init(dev);
57c8cb8f242988 John Crispin 2012-05-11  20  
57c8cb8f242988 John Crispin 2012-05-11  21  	return 0;
57c8cb8f242988 John Crispin 2012-05-11  22  }
57c8cb8f242988 John Crispin 2012-05-11  23  
8eba3651f1dad4 Manuel Lauss 2017-09-12 @24  int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)

:::::: The code at line 13 was first introduced by commit
:::::: 57c8cb8f242988b8048a7058cd1edde025c6f232 MIPS: pci: convert lantiq driver to OF

:::::: TO: John Crispin <blogic@openwrt.org>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
