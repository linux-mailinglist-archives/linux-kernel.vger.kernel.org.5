Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2107A75F533
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 13:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjGXLfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 07:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjGXLe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 07:34:58 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465ADE77
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 04:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690198478; x=1721734478;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Y44xlJ8tDP9ORhfkWkFI860EGN+2lysyuKBMEUHzYzo=;
  b=dgHx3wvSRq1Z8T3IVGBApsZoqc7wqWun7Y1OxzRA4dcTT4y4w5t7vKXM
   d+dqbluIxvBxad/pUcWCwHxVIQuQOzkgV8VYlsjxs3Pcb7i7S4z7qUztE
   7OGu+kHsmTn86sUK7ZghoaUpBz8Ync6e6YNKmcG+Ot6/+7Nr4Hp2VNmqX
   z+T3hCPFftlOni69grLfvfPcxMkOPmGqG3McNBvLx3tguY7i7B3b/eKhm
   KOYRu8LI5Dug5UZhR3iUhlPitfKh5soR6/Utuqei44Xdpw4AOcF15n6Yo
   nthPXCCOEZjHHvjcXPbv5f+hHBXyHVBtL6TXk/wtNpx0AnZe8FFUg/Z02
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="347696234"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="347696234"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:33:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="719649110"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="719649110"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 24 Jul 2023 04:33:42 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qNtoi-0009hm-1M;
        Mon, 24 Jul 2023 11:33:34 +0000
Date:   Mon, 24 Jul 2023 19:32:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: drivers/pnp/pnpacpi/core.c:253:17: warning: 'strncpy' specified
 bound 50 equals destination size
Message-ID: <202307241942.Rff2Nri5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6eaae198076080886b9e7d57f4ae06fa782f90ef
commit: a91a9ffbd3a55a0ae1bb75e2b6e85b2a03f64e8f RISC-V: Add support to build the ACPI core
date:   8 weeks ago
config: riscv-randconfig-r032-20230724 (https://download.01.org/0day-ci/archive/20230724/202307241942.Rff2Nri5-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230724/202307241942.Rff2Nri5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307241942.Rff2Nri5-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pnp/pnpacpi/core.c: In function 'pnpacpi_add_device.isra':
>> drivers/pnp/pnpacpi/core.c:253:17: warning: 'strncpy' specified bound 50 equals destination size [-Wstringop-truncation]
     253 |                 strncpy(dev->name, acpi_device_name(device), sizeof(dev->name));
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/strncpy +253 drivers/pnp/pnpacpi/core.c

420a0f66378c84 Dmitry Torokhov   2010-09-18  208  
^1da177e4c3f41 Linus Torvalds    2005-04-16  209  static int __init pnpacpi_add_device(struct acpi_device *device)
^1da177e4c3f41 Linus Torvalds    2005-04-16  210  {
^1da177e4c3f41 Linus Torvalds    2005-04-16  211  	struct pnp_dev *dev;
844142c3f80c66 Rasmus Villemoes  2015-09-09  212  	const char *pnpid;
7f47fa6c2ff15f Bjorn Helgaas     2009-09-21  213  	struct acpi_hardware_id *id;
249135d1a2ea3c Dmitry Torokhov   2013-12-15  214  	int error;
^1da177e4c3f41 Linus Torvalds    2005-04-16  215  
2905875344f977 Adrian Hunter     2012-11-23  216  	/* Skip devices that are already bound */
2905875344f977 Adrian Hunter     2012-11-23  217  	if (device->physical_node_count)
2905875344f977 Adrian Hunter     2012-11-23  218  		return 0;
2905875344f977 Adrian Hunter     2012-11-23  219  
39a0ad871000d2 Zhao Yakui        2008-08-11  220  	/*
39a0ad871000d2 Zhao Yakui        2008-08-11  221  	 * If a PnPacpi device is not present , the device
39a0ad871000d2 Zhao Yakui        2008-08-11  222  	 * driver should not be loaded.
39a0ad871000d2 Zhao Yakui        2008-08-11  223  	 */
0e77e2c416e8fa Zhang Rui         2013-09-03  224  	if (!acpi_has_method(device->handle, "_CRS"))
420a0f66378c84 Dmitry Torokhov   2010-09-18  225  		return 0;
420a0f66378c84 Dmitry Torokhov   2010-09-18  226  
420a0f66378c84 Dmitry Torokhov   2010-09-18  227  	pnpid = pnpacpi_get_id(device);
420a0f66378c84 Dmitry Torokhov   2010-09-18  228  	if (!pnpid)
420a0f66378c84 Dmitry Torokhov   2010-09-18  229  		return 0;
420a0f66378c84 Dmitry Torokhov   2010-09-18  230  
eec15edbb0e144 Zhang Rui         2014-05-30  231  	if (!device->status.present)
^1da177e4c3f41 Linus Torvalds    2005-04-16  232  		return 0;
^1da177e4c3f41 Linus Torvalds    2005-04-16  233  
420a0f66378c84 Dmitry Torokhov   2010-09-18  234  	dev = pnp_alloc_dev(&pnpacpi_protocol, num, pnpid);
bda1e4e5a3d976 Bjorn Helgaas     2008-04-28  235  	if (!dev)
^1da177e4c3f41 Linus Torvalds    2005-04-16  236  		return -ENOMEM;
bda1e4e5a3d976 Bjorn Helgaas     2008-04-28  237  
2eb1eb02dda368 Rafael J. Wysocki 2015-03-13  238  	ACPI_COMPANION_SET(&dev->dev, device);
c4da6940a7a41c Bjorn Helgaas     2009-11-17  239  	dev->data = device;
07d4e9af109221 Bjorn Helgaas     2007-07-26  240  	/* .enabled means the device can decode the resources */
^1da177e4c3f41 Linus Torvalds    2005-04-16  241  	dev->active = device->status.enabled;
0e77e2c416e8fa Zhang Rui         2013-09-03  242  	if (acpi_has_method(device->handle, "_SRS"))
^1da177e4c3f41 Linus Torvalds    2005-04-16  243  		dev->capabilities |= PNP_CONFIGURABLE;
^1da177e4c3f41 Linus Torvalds    2005-04-16  244  	dev->capabilities |= PNP_READ;
856608ee5e1ea3 Shaohua Li        2008-01-12  245  	if (device->flags.dynamic_status && (dev->capabilities & PNP_CONFIGURABLE))
^1da177e4c3f41 Linus Torvalds    2005-04-16  246  		dev->capabilities |= PNP_WRITE;
^1da177e4c3f41 Linus Torvalds    2005-04-16  247  	if (device->flags.removable)
^1da177e4c3f41 Linus Torvalds    2005-04-16  248  		dev->capabilities |= PNP_REMOVABLE;
0e77e2c416e8fa Zhang Rui         2013-09-03  249  	if (acpi_has_method(device->handle, "_DIS"))
^1da177e4c3f41 Linus Torvalds    2005-04-16  250  		dev->capabilities |= PNP_DISABLE;
^1da177e4c3f41 Linus Torvalds    2005-04-16  251  
^1da177e4c3f41 Linus Torvalds    2005-04-16  252  	if (strlen(acpi_device_name(device)))
^1da177e4c3f41 Linus Torvalds    2005-04-16 @253  		strncpy(dev->name, acpi_device_name(device), sizeof(dev->name));
^1da177e4c3f41 Linus Torvalds    2005-04-16  254  	else
^1da177e4c3f41 Linus Torvalds    2005-04-16  255  		strncpy(dev->name, acpi_device_bid(device), sizeof(dev->name));
^1da177e4c3f41 Linus Torvalds    2005-04-16  256  
d152cf5d0c3325 Bjorn Helgaas     2008-04-28  257  	if (dev->active)
d152cf5d0c3325 Bjorn Helgaas     2008-04-28  258  		pnpacpi_parse_allocated_resource(dev);
^1da177e4c3f41 Linus Torvalds    2005-04-16  259  
d152cf5d0c3325 Bjorn Helgaas     2008-04-28  260  	if (dev->capabilities & PNP_CONFIGURABLE)
d152cf5d0c3325 Bjorn Helgaas     2008-04-28  261  		pnpacpi_parse_resource_option_data(dev);
^1da177e4c3f41 Linus Torvalds    2005-04-16  262  
7f47fa6c2ff15f Bjorn Helgaas     2009-09-21  263  	list_for_each_entry(id, &device->pnp.ids, list) {
420a0f66378c84 Dmitry Torokhov   2010-09-18  264  		if (!strcmp(id->id, pnpid))
^1da177e4c3f41 Linus Torvalds    2005-04-16  265  			continue;
7f47fa6c2ff15f Bjorn Helgaas     2009-09-21  266  		if (!ispnpidacpi(id->id))
7f47fa6c2ff15f Bjorn Helgaas     2009-09-21  267  			continue;
7f47fa6c2ff15f Bjorn Helgaas     2009-09-21  268  		pnp_add_id(dev, id->id);
^1da177e4c3f41 Linus Torvalds    2005-04-16  269  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16  270  
^1da177e4c3f41 Linus Torvalds    2005-04-16  271  	/* clear out the damaged flags */
^1da177e4c3f41 Linus Torvalds    2005-04-16  272  	if (!dev->active)
f44900020926b2 Bjorn Helgaas     2008-04-28  273  		pnp_init_resources(dev);
249135d1a2ea3c Dmitry Torokhov   2013-12-15  274  
249135d1a2ea3c Dmitry Torokhov   2013-12-15  275  	error = pnp_add_device(dev);
249135d1a2ea3c Dmitry Torokhov   2013-12-15  276  	if (error) {
249135d1a2ea3c Dmitry Torokhov   2013-12-15  277  		put_device(&dev->dev);
249135d1a2ea3c Dmitry Torokhov   2013-12-15  278  		return error;
249135d1a2ea3c Dmitry Torokhov   2013-12-15  279  	}
249135d1a2ea3c Dmitry Torokhov   2013-12-15  280  
^1da177e4c3f41 Linus Torvalds    2005-04-16  281  	num++;
^1da177e4c3f41 Linus Torvalds    2005-04-16  282  
2eb1eb02dda368 Rafael J. Wysocki 2015-03-13  283  	return 0;
^1da177e4c3f41 Linus Torvalds    2005-04-16  284  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  285  

:::::: The code at line 253 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
