Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDAB4784E64
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 03:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjHWBsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 21:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjHWBsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 21:48:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BEAE4B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 18:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692755300; x=1724291300;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NyElisvPDPHpr7oLVgdaSPwtbwl5lS6H1vBrdSITnhM=;
  b=G0O3dClY8c6tdUbdTamuw2TveBxt0Ekan6TwFTzvhSBrhRM9fBzkhMf1
   tbeVUbt8HqKvQAT+eR/CV8o+KaOeHsDY/KEuW02XgRuu6SnYn2+wrKBvQ
   iVAY9ZjWLMB7vwMUpMHrzKdRrnpq82LxBbxS7kYHYWw1KXiHJ04IrqMQZ
   +CIMDroYMep2MxHzufllvkKFjDzqLwT/vSJf6EXqKAbNNOIB86JEkUqnW
   NNmcQtlt366KWI3ErYG7nlnlrszdSGVy+lZMuhFauZ8Z+ifbSX74Fq22b
   UHFLPfXx5FoI9S0AcHFS9h01ECUiwV4qPJ9ooTK1P7HcseiV7KuZCGVHM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="371452629"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="371452629"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 18:48:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="860142147"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="860142147"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 22 Aug 2023 18:48:18 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qYcyn-0000jY-2C;
        Wed, 23 Aug 2023 01:48:17 +0000
Date:   Wed, 23 Aug 2023 09:47:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>
Subject: arch/um/drivers/virt-pci.c:537:21: warning: no previous declaration
 for 'pcibios_get_phb_of_node'
Message-ID: <202308230949.PphIIlhq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   89bf6209cad66214d3774dac86b6bbf2aec6a30d
commit: 314a1408b79a844dafdcde867d90de5d509409b7 um: virt-pci: implement pcibios_get_phb_of_node()
date:   6 months ago
config: um-randconfig-r064-20230823 (https://download.01.org/0day-ci/archive/20230823/202308230949.PphIIlhq-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce: (https://download.01.org/0day-ci/archive/20230823/202308230949.PphIIlhq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308230949.PphIIlhq-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/um/drivers/virt-pci.c:537:21: warning: no previous declaration for 'pcibios_get_phb_of_node' [-Wmissing-declarations]
    struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus)
                        ^~~~~~~~~~~~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for FRAMEBUFFER_CONSOLE
   Depends on [n]: VT [=n] && FB [=y] && !UML [=y]
   Selected by [y]:
   - DRM_FBDEV_EMULATION [=y] && HAS_IOMEM [=y] && DRM_KMS_HELPER [=y] && (FB [=y]=y || FB [=y]=DRM_KMS_HELPER [=y]) && !EXPERT [=n]
   WARNING: unmet direct dependencies detected for FRAMEBUFFER_CONSOLE_DETECT_PRIMARY
   Depends on [n]: VT [=n] && FRAMEBUFFER_CONSOLE [=y]
   Selected by [y]:
   - DRM_FBDEV_EMULATION [=y] && HAS_IOMEM [=y] && DRM_KMS_HELPER [=y] && (FB [=y]=y || FB [=y]=DRM_KMS_HELPER [=y]) && FRAMEBUFFER_CONSOLE [=y]


vim +/pcibios_get_phb_of_node +537 arch/um/drivers/virt-pci.c

   535	
   536	/* Copied from arch/x86/kernel/devicetree.c */
 > 537	struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus)
   538	{
   539		struct device_node *np;
   540	
   541		for_each_node_by_type(np, "pci") {
   542			const void *prop;
   543			unsigned int bus_min;
   544	
   545			prop = of_get_property(np, "bus-range", NULL);
   546			if (!prop)
   547				continue;
   548			bus_min = be32_to_cpup(prop);
   549			if (bus->number == bus_min)
   550				return np;
   551		}
   552		return NULL;
   553	}
   554	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
