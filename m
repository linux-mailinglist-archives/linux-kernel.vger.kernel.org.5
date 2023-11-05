Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E31A7E125A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 07:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjKEGEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 01:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjKEGD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 01:03:58 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9982125
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 23:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699164236; x=1730700236;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=h2CZlAPx/Jx/e1swAd+ZAlpv2E4jqYzwhgBent/86ug=;
  b=CkRpgbZ5vlgyc13eIhPbsZxM69v9ECvPhm9BRDFKN7KIHn/F+642jk0h
   6Snd2mom01JHLJXTSZK17SdK18XOMq/FtHrsAJKuYGQD5SlLFcFQ2fLSs
   ayoe60ltBCuVDrMQctpyu1S4bCwUnRAEjZX23pWR5DE90fOZbDaCq1i2D
   BX9USIg12Buy61u70hqTxxfvQIz+hwhQ1sW3IuaKsCdwE9IiDvMttanLR
   buxjAzVr5GzXf/cRkCzVuVipTrFcHTShBoGOixxf3c32llP5DvjG5Inhj
   DtJhasbqPhfEhB5qvrR0twpVduPuhXZS8Efc0snnNAy+LZ7YPnP9bp48i
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="2100599"
X-IronPort-AV: E=Sophos;i="6.03,278,1694761200"; 
   d="scan'208";a="2100599"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2023 23:03:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,278,1694761200"; 
   d="scan'208";a="9782481"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 04 Nov 2023 23:03:54 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzWEi-00056J-01;
        Sun, 05 Nov 2023 06:03:52 +0000
Date:   Sun, 5 Nov 2023 14:02:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/mtd/nand/raw/nand_legacy.c:42:17: sparse: sparse: cast from
 restricted __le16
Message-ID: <202311051313.EctUyZAY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   aea6bf908d730b01bd264a8821159db9463c111c
commit: 72c5af00272339af6bbed6fe7275cd731f57be2d mtd: rawnand: Clarify Kconfig entry MTD_NAND
date:   4 years, 7 months ago
config: i386-randconfig-063-20231102 (https://download.01.org/0day-ci/archive/20231105/202311051313.EctUyZAY-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231105/202311051313.EctUyZAY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311051313.EctUyZAY-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/mtd/nand/raw/nand_legacy.c:42:17: sparse: sparse: cast from restricted __le16

vim +42 drivers/mtd/nand/raw/nand_legacy.c

3d4af7c195850c Boris Brezillon 2018-09-07  32  
3d4af7c195850c Boris Brezillon 2018-09-07  33  /**
3d4af7c195850c Boris Brezillon 2018-09-07  34   * nand_read_byte16 - [DEFAULT] read one byte endianness aware from the chip
3d4af7c195850c Boris Brezillon 2018-09-07  35   * @chip: NAND chip object
3d4af7c195850c Boris Brezillon 2018-09-07  36   *
3d4af7c195850c Boris Brezillon 2018-09-07  37   * Default read function for 16bit buswidth with endianness conversion.
3d4af7c195850c Boris Brezillon 2018-09-07  38   *
3d4af7c195850c Boris Brezillon 2018-09-07  39   */
3d4af7c195850c Boris Brezillon 2018-09-07  40  static uint8_t nand_read_byte16(struct nand_chip *chip)
3d4af7c195850c Boris Brezillon 2018-09-07  41  {
3d4af7c195850c Boris Brezillon 2018-09-07 @42  	return (uint8_t) cpu_to_le16(readw(chip->legacy.IO_ADDR_R));
3d4af7c195850c Boris Brezillon 2018-09-07  43  }
3d4af7c195850c Boris Brezillon 2018-09-07  44  

:::::: The code at line 42 was first introduced by commit
:::::: 3d4af7c195850cfccaddc2cf03b010b95236b695 mtd: rawnand: Move legacy code to nand_legacy.c

:::::: TO: Boris Brezillon <boris.brezillon@bootlin.com>
:::::: CC: Miquel Raynal <miquel.raynal@bootlin.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
