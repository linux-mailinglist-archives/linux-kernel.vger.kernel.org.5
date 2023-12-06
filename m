Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F97780649E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376491AbjLFCFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 21:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjLFCFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 21:05:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A32137
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 18:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701828318; x=1733364318;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=D88FenNGBZ0jopKNI8q1Co9tQjL6DgzlMXdK32S49Wo=;
  b=OGUhLZuTp2yiI2tYJlAfIGGhx81QHMtsALAh9zs1ywkieOKM2w3rLG2L
   wvqUFda3EETL5lNNLv3dCzAunJyiEJZQmqAb6PO4KsHYkWCiJ40KGdl41
   4Dz9fyhuIG6kytDVa5krd4Zj10sfYV30bLOPZ6rpQ7nulPiGr1kwx+uFW
   Io/iNKYMCAu61hUxOcwvZvFQRa6QJjSxcuGWlYPMf2/nfJva1uXVzeSSO
   Zz1d32V+IGKHU48K9+SZMMdMSK6+mj/U8RmCR1gMIXTimaY86ftAuMIsO
   TYRLygMKH1Swu6CBDbIL20AQEzVMBrocCysegGuI5EHWR/oVpCnthjMsr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="1048697"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="1048697"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 18:05:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="894572428"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="894572428"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 05 Dec 2023 18:05:16 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAhHl-000A4L-1m;
        Wed, 06 Dec 2023 02:05:13 +0000
Date:   Wed, 6 Dec 2023 10:05:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/memory/brcmstb_dpfe.c:521:29: sparse: sparse: cast to
 restricted __be32
Message-ID: <202312060952.zRI5dp2r-lkp@intel.com>
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
head:   bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
commit: 904ffa81b709f79b906077e72f4656bdb9930340 memory: brcmstb_dpfe: add separate entry for compile test
date:   3 years, 4 months ago
config: openrisc-randconfig-r131-20231102 (https://download.01.org/0day-ci/archive/20231206/202312060952.zRI5dp2r-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231206/202312060952.zRI5dp2r-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312060952.zRI5dp2r-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/memory/brcmstb_dpfe.c:521:29: sparse: sparse: cast to restricted __be32
   drivers/memory/brcmstb_dpfe.c:522:29: sparse: sparse: cast to restricted __be32
>> drivers/memory/brcmstb_dpfe.c:524:29: sparse: sparse: cast to restricted __le32
>> drivers/memory/brcmstb_dpfe.c:524:29: sparse: sparse: cast to restricted __le32
>> drivers/memory/brcmstb_dpfe.c:524:29: sparse: sparse: cast to restricted __le32
>> drivers/memory/brcmstb_dpfe.c:524:29: sparse: sparse: cast to restricted __le32
>> drivers/memory/brcmstb_dpfe.c:524:29: sparse: sparse: cast to restricted __le32
>> drivers/memory/brcmstb_dpfe.c:524:29: sparse: sparse: cast to restricted __le32
   drivers/memory/brcmstb_dpfe.c:525:29: sparse: sparse: cast to restricted __le32
   drivers/memory/brcmstb_dpfe.c:525:29: sparse: sparse: cast to restricted __le32
   drivers/memory/brcmstb_dpfe.c:525:29: sparse: sparse: cast to restricted __le32
   drivers/memory/brcmstb_dpfe.c:525:29: sparse: sparse: cast to restricted __le32
   drivers/memory/brcmstb_dpfe.c:525:29: sparse: sparse: cast to restricted __le32
   drivers/memory/brcmstb_dpfe.c:525:29: sparse: sparse: cast to restricted __le32
   drivers/memory/brcmstb_dpfe.c:548:46: sparse: sparse: cast to restricted __le32
   drivers/memory/brcmstb_dpfe.c:548:46: sparse: sparse: cast to restricted __le32
   drivers/memory/brcmstb_dpfe.c:548:46: sparse: sparse: cast to restricted __le32
   drivers/memory/brcmstb_dpfe.c:548:46: sparse: sparse: cast to restricted __le32
   drivers/memory/brcmstb_dpfe.c:548:46: sparse: sparse: cast to restricted __le32
   drivers/memory/brcmstb_dpfe.c:548:46: sparse: sparse: cast to restricted __le32
   drivers/memory/brcmstb_dpfe.c:548:19: sparse: sparse: cast to restricted __be32
   drivers/memory/brcmstb_dpfe.c:565:25: sparse: sparse: cast to restricted __be32
   drivers/memory/brcmstb_dpfe.c:566:28: sparse: sparse: cast to restricted __be32
   drivers/memory/brcmstb_dpfe.c:567:27: sparse: sparse: cast to restricted __be32
   drivers/memory/brcmstb_dpfe.c:569:25: sparse: sparse: cast to restricted __le32
   drivers/memory/brcmstb_dpfe.c:569:25: sparse: sparse: cast to restricted __le32
   drivers/memory/brcmstb_dpfe.c:569:25: sparse: sparse: cast to restricted __le32
   drivers/memory/brcmstb_dpfe.c:569:25: sparse: sparse: cast to restricted __le32
   drivers/memory/brcmstb_dpfe.c:569:25: sparse: sparse: cast to restricted __le32
   drivers/memory/brcmstb_dpfe.c:569:25: sparse: sparse: cast to restricted __le32
   drivers/memory/brcmstb_dpfe.c:570:28: sparse: sparse: cast to restricted __le32
   drivers/memory/brcmstb_dpfe.c:570:28: sparse: sparse: cast to restricted __le32
   drivers/memory/brcmstb_dpfe.c:570:28: sparse: sparse: cast to restricted __le32
   drivers/memory/brcmstb_dpfe.c:570:28: sparse: sparse: cast to restricted __le32
   drivers/memory/brcmstb_dpfe.c:570:28: sparse: sparse: cast to restricted __le32
   drivers/memory/brcmstb_dpfe.c:570:28: sparse: sparse: cast to restricted __le32
   drivers/memory/brcmstb_dpfe.c:571:27: sparse: sparse: cast to restricted __le32
   drivers/memory/brcmstb_dpfe.c:571:27: sparse: sparse: cast to restricted __le32
   drivers/memory/brcmstb_dpfe.c:571:27: sparse: sparse: cast to restricted __le32
   drivers/memory/brcmstb_dpfe.c:571:27: sparse: sparse: cast to restricted __le32
   drivers/memory/brcmstb_dpfe.c:571:27: sparse: sparse: cast to restricted __le32
   drivers/memory/brcmstb_dpfe.c:571:27: sparse: sparse: cast to restricted __le32
   drivers/memory/brcmstb_dpfe.c:600:40: sparse: sparse: cast to restricted __be32
   drivers/memory/brcmstb_dpfe.c:603:40: sparse: sparse: cast to restricted __le32
   drivers/memory/brcmstb_dpfe.c:603:40: sparse: sparse: cast to restricted __le32
   drivers/memory/brcmstb_dpfe.c:603:40: sparse: sparse: cast to restricted __le32
   drivers/memory/brcmstb_dpfe.c:603:40: sparse: sparse: cast to restricted __le32
   drivers/memory/brcmstb_dpfe.c:603:40: sparse: sparse: cast to restricted __le32
   drivers/memory/brcmstb_dpfe.c:603:40: sparse: sparse: cast to restricted __le32
   drivers/memory/brcmstb_dpfe.c: note: in included file (through arch/openrisc/include/asm/io.h, include/linux/io.h):
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:299:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:299:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:299:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:299:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:299:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:299:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:299:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:299:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:299:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:299:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:299:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:299:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:299:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:299:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:299:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:299:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:299:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:299:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:299:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:299:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:299:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:299:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:299:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:299:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:299:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:299:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:299:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32

vim +521 drivers/memory/brcmstb_dpfe.c

2f330caff57762 Markus Mayer 2017-08-24  505  
2f330caff57762 Markus Mayer 2017-08-24  506  /* Ensure that the firmware file loaded meets all the requirements. */
2f330caff57762 Markus Mayer 2017-08-24  507  static int __verify_firmware(struct init_data *init,
2f330caff57762 Markus Mayer 2017-08-24  508  			     const struct firmware *fw)
2f330caff57762 Markus Mayer 2017-08-24  509  {
2f330caff57762 Markus Mayer 2017-08-24  510  	const struct dpfe_firmware_header *header = (void *)fw->data;
2f330caff57762 Markus Mayer 2017-08-24  511  	unsigned int dmem_size, imem_size, total_size;
2f330caff57762 Markus Mayer 2017-08-24  512  	bool is_big_endian = false;
2f330caff57762 Markus Mayer 2017-08-24  513  	const u32 *chksum_ptr;
2f330caff57762 Markus Mayer 2017-08-24  514  
2f330caff57762 Markus Mayer 2017-08-24  515  	if (header->magic == DPFE_BE_MAGIC)
2f330caff57762 Markus Mayer 2017-08-24  516  		is_big_endian = true;
2f330caff57762 Markus Mayer 2017-08-24  517  	else if (header->magic != DPFE_LE_MAGIC)
2f330caff57762 Markus Mayer 2017-08-24  518  		return ERR_INVALID_MAGIC;
2f330caff57762 Markus Mayer 2017-08-24  519  
2f330caff57762 Markus Mayer 2017-08-24  520  	if (is_big_endian) {
2f330caff57762 Markus Mayer 2017-08-24 @521  		dmem_size = be32_to_cpu(header->dmem_size);
2f330caff57762 Markus Mayer 2017-08-24  522  		imem_size = be32_to_cpu(header->imem_size);
2f330caff57762 Markus Mayer 2017-08-24  523  	} else {
2f330caff57762 Markus Mayer 2017-08-24 @524  		dmem_size = le32_to_cpu(header->dmem_size);
2f330caff57762 Markus Mayer 2017-08-24  525  		imem_size = le32_to_cpu(header->imem_size);
2f330caff57762 Markus Mayer 2017-08-24  526  	}
2f330caff57762 Markus Mayer 2017-08-24  527  
2f330caff57762 Markus Mayer 2017-08-24  528  	/* Data and instruction sections are 32 bit words. */
2f330caff57762 Markus Mayer 2017-08-24  529  	if ((dmem_size % sizeof(u32)) != 0 || (imem_size % sizeof(u32)) != 0)
2f330caff57762 Markus Mayer 2017-08-24  530  		return ERR_INVALID_SIZE;
2f330caff57762 Markus Mayer 2017-08-24  531  
2f330caff57762 Markus Mayer 2017-08-24  532  	/*
2f330caff57762 Markus Mayer 2017-08-24  533  	 * The header + the data section + the instruction section + the
2f330caff57762 Markus Mayer 2017-08-24  534  	 * checksum must be equal to the total firmware size.
2f330caff57762 Markus Mayer 2017-08-24  535  	 */
2f330caff57762 Markus Mayer 2017-08-24  536  	total_size = dmem_size + imem_size + sizeof(*header) +
2f330caff57762 Markus Mayer 2017-08-24  537  		sizeof(*chksum_ptr);
2f330caff57762 Markus Mayer 2017-08-24  538  	if (total_size != fw->size)
2f330caff57762 Markus Mayer 2017-08-24  539  		return ERR_INVALID_SIZE;
2f330caff57762 Markus Mayer 2017-08-24  540  
2f330caff57762 Markus Mayer 2017-08-24  541  	/* The checksum comes at the very end. */
2f330caff57762 Markus Mayer 2017-08-24  542  	chksum_ptr = (void *)fw->data + sizeof(*header) + dmem_size + imem_size;
2f330caff57762 Markus Mayer 2017-08-24  543  
2f330caff57762 Markus Mayer 2017-08-24  544  	init->is_big_endian = is_big_endian;
2f330caff57762 Markus Mayer 2017-08-24  545  	init->dmem_len = dmem_size;
2f330caff57762 Markus Mayer 2017-08-24  546  	init->imem_len = imem_size;
2f330caff57762 Markus Mayer 2017-08-24  547  	init->chksum = (is_big_endian)
2f330caff57762 Markus Mayer 2017-08-24  548  		? be32_to_cpu(*chksum_ptr) : le32_to_cpu(*chksum_ptr);
2f330caff57762 Markus Mayer 2017-08-24  549  
2f330caff57762 Markus Mayer 2017-08-24  550  	return 0;
2f330caff57762 Markus Mayer 2017-08-24  551  }
2f330caff57762 Markus Mayer 2017-08-24  552  

:::::: The code at line 521 was first introduced by commit
:::::: 2f330caff5776239abb3e0337533886dbb21f6df memory: brcmstb: Add driver for DPFE

:::::: TO: Markus Mayer <mmayer@broadcom.com>
:::::: CC: Florian Fainelli <f.fainelli@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
