Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926DB802341
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 12:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbjLCLmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 06:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbjLCLmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 06:42:18 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB480C0
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 03:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701603741; x=1733139741;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MSrDRMw9T1a87wC9FOdhxFxNXLqisudxS6yZeVo3NSM=;
  b=MRpgDK8rxcqIMedCXYM3U/JFuCrYcgHSYA3nmbcdfryw0vmBbf9WZAEb
   OnndUBuFC5ILJQwvf7ZTJ728oknFtV207Nkx7JEmnCk0Tk1C8rUwCdD7X
   pXij5LiWddKaKdFHdLKezZVTfyDPVhkrlDJ7qtn0J/hl4J9EvgN7RmL1j
   RyaEY4W+V1BcHuMGJAonaywvGqgYbfVDjDAO9yGeD12aYQz4hz+vKKIGU
   5MKwZcvmgC/Rn7v4lSopemBL6Xh8mw4lZmtUDNZXs7th6dWV07wYjNL9l
   qB6iU9vl1X0CKa8f8AeTi2rhCTamurROX9V2Khf6VLSUAES90eTpQRN/J
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="424805344"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="424805344"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2023 03:42:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="914144295"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="914144295"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 03 Dec 2023 03:42:19 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r9krZ-0006bw-0s;
        Sun, 03 Dec 2023 11:42:17 +0000
Date:   Sun, 3 Dec 2023 19:42:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/mtd/nand/raw/sh_flctl.c:458:16: sparse: sparse: cast to
 restricted __le32
Message-ID: <202312031821.Ggx70iAT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   968f35f4ab1c0966ceb39af3c89f2e24afedf878
commit: 72c5af00272339af6bbed6fe7275cd731f57be2d mtd: rawnand: Clarify Kconfig entry MTD_NAND
date:   4 years, 8 months ago
config: openrisc-randconfig-r131-20231102 (https://download.01.org/0day-ci/archive/20231203/202312031821.Ggx70iAT-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231203/202312031821.Ggx70iAT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312031821.Ggx70iAT-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/mtd/nand/raw/sh_flctl.c:458:16: sparse: sparse: cast to restricted __le32
>> drivers/mtd/nand/raw/sh_flctl.c:458:16: sparse: sparse: cast to restricted __le32
>> drivers/mtd/nand/raw/sh_flctl.c:458:16: sparse: sparse: cast to restricted __le32
>> drivers/mtd/nand/raw/sh_flctl.c:458:16: sparse: sparse: cast to restricted __le32
>> drivers/mtd/nand/raw/sh_flctl.c:458:16: sparse: sparse: cast to restricted __le32
>> drivers/mtd/nand/raw/sh_flctl.c:458:16: sparse: sparse: cast to restricted __le32
>> drivers/mtd/nand/raw/sh_flctl.c:481:26: sparse: sparse: cast to restricted __be32
   drivers/mtd/nand/raw/sh_flctl.c:496:38: sparse: sparse: cast to restricted __be32
>> drivers/mtd/nand/raw/sh_flctl.c:512:24: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __be32 [usertype] @@
   drivers/mtd/nand/raw/sh_flctl.c:512:24: sparse:     expected unsigned int [usertype] value
   drivers/mtd/nand/raw/sh_flctl.c:512:24: sparse:     got restricted __be32 [usertype]
>> drivers/mtd/nand/raw/sh_flctl.c:525:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long @@     got restricted __be32 [usertype] @@
   drivers/mtd/nand/raw/sh_flctl.c:525:24: sparse:     expected unsigned long
   drivers/mtd/nand/raw/sh_flctl.c:525:24: sparse:     got restricted __be32 [usertype]
   drivers/mtd/nand/raw/sh_flctl.c: note: in included file (through arch/openrisc/include/asm/io.h, include/linux/scatterlist.h, include/linux/dmaengine.h):
   include/asm-generic/io.h:232:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:232:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:232:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:232:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:232:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:232:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:232:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:232:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:232:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:232:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:232:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:232:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:232:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:232:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:232:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:232:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:232:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:232:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:232:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:232:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:232:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:232:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:232:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:232:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:186:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:232:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
--
>> drivers/mtd/nand/raw/brcmnand/brcmnand.c:1403:42: sparse: sparse: cast to restricted __be32
>> drivers/mtd/nand/raw/brcmnand/brcmnand.c:1517:41: sparse: sparse: dubious: x | !y
   drivers/mtd/nand/raw/brcmnand/brcmnand.c: note: in included file (through arch/openrisc/include/asm/io.h, include/linux/io.h, include/linux/irq.h, ...):
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:306:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:306:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:306:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:306:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:306:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:306:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:306:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:306:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:306:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:306:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:306:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:306:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:306:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:306:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:306:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:306:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:306:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:306:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:306:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:306:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:306:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:274:16: sparse: sparse: cast to restricted __le32

vim +458 drivers/mtd/nand/raw/sh_flctl.c

83738d87e3a0a4 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-10-19  449  
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  450  static void read_datareg(struct sh_flctl *flctl, int offset)
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  451  {
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  452  	unsigned long data;
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  453  	unsigned long *buf = (unsigned long *)&flctl->done_buff[offset];
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  454  
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  455  	wait_completion(flctl);
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  456  
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  457  	data = readl(FLDATAR(flctl));
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14 @458  	*buf = le32_to_cpu(data);
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  459  }
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  460  
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  461  static void read_fiforeg(struct sh_flctl *flctl, int rlen, int offset)
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  462  {
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  463  	int i, len_4align;
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  464  	unsigned long *buf = (unsigned long *)&flctl->done_buff[offset];
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  465  
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  466  	len_4align = (rlen + 3) / 4;
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  467  
83738d87e3a0a4 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-10-19  468  	/* initiate DMA transfer */
83738d87e3a0a4 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-10-19  469  	if (flctl->chan_fifo0_rx && rlen >= 32 &&
e2bfa4ca23d9b5 drivers/mtd/nand/raw/sh_flctl.c Nathan Chancellor 2018-09-20  470  		flctl_dma_fifo0_transfer(flctl, buf, rlen, DMA_FROM_DEVICE) > 0)
83738d87e3a0a4 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-10-19  471  			goto convert;	/* DMA success */
83738d87e3a0a4 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-10-19  472  
83738d87e3a0a4 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-10-19  473  	/* do polling transfer */
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  474  	for (i = 0; i < len_4align; i++) {
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  475  		wait_rfifo_ready(flctl);
3166df0d0424ef drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-05-14  476  		buf[i] = readl(FLDTFIFO(flctl));
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  477  	}
83738d87e3a0a4 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-10-19  478  
83738d87e3a0a4 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-10-19  479  convert:
83738d87e3a0a4 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-10-19  480  	for (i = 0; i < len_4align; i++)
83738d87e3a0a4 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-10-19 @481  		buf[i] = be32_to_cpu(buf[i]);
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  482  }
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  483  
6667a6d58e25d3 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-05-14  484  static enum flctl_ecc_res_t read_ecfiforeg
6667a6d58e25d3 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-05-14  485  		(struct sh_flctl *flctl, uint8_t *buff, int sector)
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  486  {
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  487  	int i;
6667a6d58e25d3 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-05-14  488  	enum flctl_ecc_res_t res;
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  489  	unsigned long *ecc_buf = (unsigned long *)buff;
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  490  
6667a6d58e25d3 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-05-14  491  	res = wait_recfifo_ready(flctl , sector);
6667a6d58e25d3 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-05-14  492  
6667a6d58e25d3 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-05-14  493  	if (res != FL_ERROR) {
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  494  		for (i = 0; i < 4; i++) {
6667a6d58e25d3 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-05-14  495  			ecc_buf[i] = readl(FLECFIFO(flctl));
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  496  			ecc_buf[i] = be32_to_cpu(ecc_buf[i]);
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  497  		}
6667a6d58e25d3 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-05-14  498  	}
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  499  
6667a6d58e25d3 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-05-14  500  	return res;
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  501  }
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  502  
e8a9d8f31c592e drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-10-19  503  static void write_fiforeg(struct sh_flctl *flctl, int rlen,
e8a9d8f31c592e drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-10-19  504  						unsigned int offset)
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  505  {
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  506  	int i, len_4align;
e8a9d8f31c592e drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-10-19  507  	unsigned long *buf = (unsigned long *)&flctl->done_buff[offset];
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  508  
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  509  	len_4align = (rlen + 3) / 4;
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  510  	for (i = 0; i < len_4align; i++) {
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  511  		wait_wfifo_ready(flctl);
e8a9d8f31c592e drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-10-19 @512  		writel(cpu_to_be32(buf[i]), FLDTFIFO(flctl));
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  513  	}
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  514  }
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  515  
e8a9d8f31c592e drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-10-19  516  static void write_ec_fiforeg(struct sh_flctl *flctl, int rlen,
e8a9d8f31c592e drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-10-19  517  						unsigned int offset)
3166df0d0424ef drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-05-14  518  {
3166df0d0424ef drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-05-14  519  	int i, len_4align;
e8a9d8f31c592e drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-10-19  520  	unsigned long *buf = (unsigned long *)&flctl->done_buff[offset];
3166df0d0424ef drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-05-14  521  
3166df0d0424ef drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-05-14  522  	len_4align = (rlen + 3) / 4;
83738d87e3a0a4 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-10-19  523  
83738d87e3a0a4 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-10-19  524  	for (i = 0; i < len_4align; i++)
83738d87e3a0a4 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-10-19 @525  		buf[i] = cpu_to_be32(buf[i]);
83738d87e3a0a4 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-10-19  526  
83738d87e3a0a4 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-10-19  527  	/* initiate DMA transfer */
83738d87e3a0a4 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-10-19  528  	if (flctl->chan_fifo0_tx && rlen >= 32 &&
e2bfa4ca23d9b5 drivers/mtd/nand/raw/sh_flctl.c Nathan Chancellor 2018-09-20  529  		flctl_dma_fifo0_transfer(flctl, buf, rlen, DMA_TO_DEVICE) > 0)
83738d87e3a0a4 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-10-19  530  			return;	/* DMA success */
83738d87e3a0a4 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-10-19  531  
83738d87e3a0a4 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-10-19  532  	/* do polling transfer */
3166df0d0424ef drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-05-14  533  	for (i = 0; i < len_4align; i++) {
3166df0d0424ef drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-05-14  534  		wait_wecfifo_ready(flctl);
83738d87e3a0a4 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-10-19  535  		writel(buf[i], FLECFIFO(flctl));
3166df0d0424ef drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-05-14  536  	}
3166df0d0424ef drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-05-14  537  }
3166df0d0424ef drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-05-14  538  

:::::: The code at line 458 was first introduced by commit
:::::: 6028aa01f759a1dae11e5d0e495b3dc9d2b0a47b [MTD] [NAND] sh_flctl: add support for Renesas SuperH FLCTL

:::::: TO: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
:::::: CC: David Woodhouse <David.Woodhouse@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
