Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E4D75DE5F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 21:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjGVTp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 15:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjGVTp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 15:45:58 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF9D10C3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 12:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690055157; x=1721591157;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FEEgno1rH+wwvAMVipqmcS3rNOJtmEjsn6vEz8C3xvo=;
  b=Wf1w28VfhvuhBQTUPEMiguizBXhLcrJwHis3z+gKVasOCY488Xyp+ruY
   zuriQldvUCXo6eq+Cbr8YzXkeUUnN88eOlReHN+l3cYaEDaQn/JGD3w5U
   Cc1PFCzUiY0k304L9seu3T1eGnr6G5ubCn+sqJqKQVzzv4thMqR206q7L
   NyYCQ3oBZ1thO/rSHnr2Srgq8R3HlM2YB/B0ZMf2OyzRTQJr/Foaj8mw/
   Us4C8p/+0p/0f8KDYmTa0WxorBBXX1WyRWMNrYkOMCSH7F+ST08788wdZ
   R1Dbd3Bm/rvx27g+XvcUo68c6DYqsXNl5EEacFTXgV9zCC7k0MTYjUyO2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="431019940"
X-IronPort-AV: E=Sophos;i="6.01,224,1684825200"; 
   d="scan'208";a="431019940"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2023 12:45:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="899061591"
X-IronPort-AV: E=Sophos;i="6.01,224,1684825200"; 
   d="scan'208";a="899061591"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 22 Jul 2023 12:45:54 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qNIY5-0008Yn-30;
        Sat, 22 Jul 2023 19:45:53 +0000
Date:   Sun, 23 Jul 2023 03:45:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: drivers/acpi/osl.c:723:27: sparse: sparse: incorrect type in
 assignment (different address spaces)
Message-ID: <202307230357.egcTAefj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   295e1388de2d5c0c354adbd65d0319c5d636c222
commit: a91a9ffbd3a55a0ae1bb75e2b6e85b2a03f64e8f RISC-V: Add support to build the ACPI core
date:   7 weeks ago
config: riscv-randconfig-r073-20230723 (https://download.01.org/0day-ci/archive/20230723/202307230357.egcTAefj-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230723/202307230357.egcTAefj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307230357.egcTAefj-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   WARNING: invalid argument to '-march': '_zihintpause'
   drivers/acpi/osl.c:296:39: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   drivers/acpi/osl.c:296:39: sparse:     expected void [noderef] __iomem *
   drivers/acpi/osl.c:296:39: sparse:     got void *
   drivers/acpi/osl.c:378:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/acpi/osl.c:723:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *[assigned] virt_addr @@     got void * @@
   drivers/acpi/osl.c:723:27: sparse:     expected void [noderef] __iomem *[assigned] virt_addr
   drivers/acpi/osl.c:723:27: sparse:     got void *
   drivers/acpi/osl.c:754:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *[assigned] virt_addr @@     got void * @@
   drivers/acpi/osl.c:754:27: sparse:     expected void [noderef] __iomem *[assigned] virt_addr
   drivers/acpi/osl.c:754:27: sparse:     got void *
   drivers/acpi/osl.c:1661:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *rv @@     got void [noderef] __iomem * @@
   drivers/acpi/osl.c:1661:20: sparse:     expected void *rv
   drivers/acpi/osl.c:1661:20: sparse:     got void [noderef] __iomem *
   drivers/acpi/osl.c:711:1: sparse: sparse: context imbalance in 'acpi_os_read_memory' - wrong count at exit
   drivers/acpi/osl.c:744:1: sparse: sparse: context imbalance in 'acpi_os_write_memory' - wrong count at exit

vim +723 drivers/acpi/osl.c

eeb2d80d502af2 Srinivas Pandruvada 2017-10-05  709  
e615bf5b551986 Myron Stowe         2012-01-20  710  acpi_status
653f4b538f66d3 Bob Moore           2012-02-14  711  acpi_os_read_memory(acpi_physical_address phys_addr, u64 *value, u32 width)
e615bf5b551986 Myron Stowe         2012-01-20  712  {
e615bf5b551986 Myron Stowe         2012-01-20  713  	void __iomem *virt_addr;
e615bf5b551986 Myron Stowe         2012-01-20  714  	unsigned int size = width / 8;
e615bf5b551986 Myron Stowe         2012-01-20  715  	bool unmap = false;
e615bf5b551986 Myron Stowe         2012-01-20  716  	u64 dummy;
eeb2d80d502af2 Srinivas Pandruvada 2017-10-05  717  	int error;
e615bf5b551986 Myron Stowe         2012-01-20  718  
e615bf5b551986 Myron Stowe         2012-01-20  719  	rcu_read_lock();
e615bf5b551986 Myron Stowe         2012-01-20  720  	virt_addr = acpi_map_vaddr_lookup(phys_addr, size);
e615bf5b551986 Myron Stowe         2012-01-20  721  	if (!virt_addr) {
e615bf5b551986 Myron Stowe         2012-01-20  722  		rcu_read_unlock();
e615bf5b551986 Myron Stowe         2012-01-20 @723  		virt_addr = acpi_os_ioremap(phys_addr, size);
e615bf5b551986 Myron Stowe         2012-01-20  724  		if (!virt_addr)
e615bf5b551986 Myron Stowe         2012-01-20  725  			return AE_BAD_ADDRESS;
e615bf5b551986 Myron Stowe         2012-01-20  726  		unmap = true;
e615bf5b551986 Myron Stowe         2012-01-20  727  	}
e615bf5b551986 Myron Stowe         2012-01-20  728  
e615bf5b551986 Myron Stowe         2012-01-20  729  	if (!value)
e615bf5b551986 Myron Stowe         2012-01-20  730  		value = &dummy;
e615bf5b551986 Myron Stowe         2012-01-20  731  
eeb2d80d502af2 Srinivas Pandruvada 2017-10-05  732  	error = acpi_os_read_iomem(virt_addr, value, width);
eeb2d80d502af2 Srinivas Pandruvada 2017-10-05  733  	BUG_ON(error);
e615bf5b551986 Myron Stowe         2012-01-20  734  
e615bf5b551986 Myron Stowe         2012-01-20  735  	if (unmap)
e615bf5b551986 Myron Stowe         2012-01-20  736  		iounmap(virt_addr);
e615bf5b551986 Myron Stowe         2012-01-20  737  	else
e615bf5b551986 Myron Stowe         2012-01-20  738  		rcu_read_unlock();
e615bf5b551986 Myron Stowe         2012-01-20  739  
e615bf5b551986 Myron Stowe         2012-01-20  740  	return AE_OK;
e615bf5b551986 Myron Stowe         2012-01-20  741  }
e615bf5b551986 Myron Stowe         2012-01-20  742  

:::::: The code at line 723 was first introduced by commit
:::::: e615bf5b5519862ab66172f4dec7455d6543a578 ACPI, APEI: Add 64-bit read/write support for APEI on i386

:::::: TO: Myron Stowe <mstowe@redhat.com>
:::::: CC: Len Brown <len.brown@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
