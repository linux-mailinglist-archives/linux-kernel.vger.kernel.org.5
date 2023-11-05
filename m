Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D885E7E1268
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 07:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjKEGzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 01:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjKEGzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 01:55:19 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF0BD3
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 23:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699167316; x=1730703316;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0N08MRP6zZZzPRQyVan2xj2g8PgOxLW3ji83injGmro=;
  b=Xr2qdas3P3Zs6oLSLqtwbr4rti9i2bpgcAoDItKJurVecoAE3HYWWDOL
   YG015rZbQLK9UGiGiIlgi0jUFYZJUul1mrgyOnOTacOS1N3EpMgRzX9Sh
   0EcptMLJDZrAxtwcLbzSH9lLZe992UHYigsZsPA/KQmm89XIFSi+SR6ME
   gid+Sqhn2AR8/4uCicbZGPpWOGiqdtJPVAw0eafQ2D56W4HwZIrm4TFEm
   2DWx6ssSO4aMpLAOlyxV72gYYK95nv6lgc1v/1mLW//Sl7i1Wuy8WLIAu
   drfAhFFna922JLw+PZT4K9f7lEKp+oV6PsZ8mR0XfsWkLTZ/GiuNdmli8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="386305066"
X-IronPort-AV: E=Sophos;i="6.03,278,1694761200"; 
   d="scan'208";a="386305066"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2023 23:55:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="852667785"
X-IronPort-AV: E=Sophos;i="6.03,278,1694761200"; 
   d="scan'208";a="852667785"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Nov 2023 23:55:14 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzX2O-00058a-24;
        Sun, 05 Nov 2023 06:55:12 +0000
Date:   Sun, 5 Nov 2023 14:54:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Purna Chandra Mandal <purna.mandal@microchip.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: drivers/spi/spi-pic32.c:869:34: warning: 'pic32_spi_of_match'
 defined but not used
Message-ID: <202311051454.MWgWyxBp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   aea6bf908d730b01bd264a8821159db9463c111c
commit: 1bcb9f8ceb67803960871ecf4ed2d365a2a919c8 spi: spi-pic32: Add PIC32 SPI master driver
date:   8 years ago
config: i386-buildonly-randconfig-005-20231101 (https://download.01.org/0day-ci/archive/20231105/202311051454.MWgWyxBp-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231105/202311051454.MWgWyxBp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311051454.MWgWyxBp-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/spi/spi-pic32.c: In function 'pic32_spi_dma_transfer':
   drivers/spi/spi-pic32.c:323:43: warning: implicit conversion from 'enum dma_data_direction' to 'enum dma_transfer_direction' [-Wenum-conversion]
     323 |                                           DMA_FROM_DEVICE,
         |                                           ^~~~~~~~~~~~~~~
   drivers/spi/spi-pic32.c:333:43: warning: implicit conversion from 'enum dma_data_direction' to 'enum dma_transfer_direction' [-Wenum-conversion]
     333 |                                           DMA_TO_DEVICE,
         |                                           ^~~~~~~~~~~~~
   drivers/spi/spi-pic32.c: At top level:
>> drivers/spi/spi-pic32.c:869:34: warning: 'pic32_spi_of_match' defined but not used [-Wunused-const-variable=]
     869 | static const struct of_device_id pic32_spi_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/bitops.h:36,
                    from include/linux/kernel.h:10,
                    from include/linux/clk.h:16,
                    from drivers/spi/spi-pic32.c:17:
   In function 'set_bit',
       inlined from '__dma_cap_set' at include/linux/dmaengine.h:1167:2,
       inlined from 'pic32_spi_dma_prep' at drivers/spi/spi-pic32.c:632:2,
       inlined from 'pic32_spi_probe' at drivers/spi/spi-pic32.c:802:2:
   arch/x86/include/asm/bitops.h:75:17: warning: array subscript 'long int[0]' is partly outside array bounds of 'dma_cap_mask_t[1]' [-Warray-bounds]
      75 |                 asm volatile(LOCK_PREFIX "orb %1,%0"
         |                 ^~~
   drivers/spi/spi-pic32.c: In function 'pic32_spi_probe':
   drivers/spi/spi-pic32.c:629:24: note: at offset 1 into object 'mask' of size 4
     629 |         dma_cap_mask_t mask;
         |                        ^~~~
   In function 'set_bit',
       inlined from '__dma_cap_set' at include/linux/dmaengine.h:1167:2,
       inlined from 'pic32_spi_dma_prep' at drivers/spi/spi-pic32.c:632:2,
       inlined from 'pic32_spi_probe' at drivers/spi/spi-pic32.c:802:2:
   arch/x86/include/asm/bitops.h:75:17: warning: array subscript 'long int[0]' is partly outside array bounds of 'dma_cap_mask_t[1]' [-Warray-bounds]
      75 |                 asm volatile(LOCK_PREFIX "orb %1,%0"
         |                 ^~~
   drivers/spi/spi-pic32.c: In function 'pic32_spi_probe':
   drivers/spi/spi-pic32.c:629:24: note: at offset 1 into object 'mask' of size 4
     629 |         dma_cap_mask_t mask;
         |                        ^~~~


vim +/pic32_spi_of_match +869 drivers/spi/spi-pic32.c

   868	
 > 869	static const struct of_device_id pic32_spi_of_match[] = {
   870		{.compatible = "microchip,pic32mzda-spi",},
   871		{},
   872	};
   873	MODULE_DEVICE_TABLE(of, pic32_spi_of_match);
   874	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
