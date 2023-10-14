Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEAF7C9604
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 21:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjJNTZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 15:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJNTZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 15:25:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821F4BF
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 12:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697311538; x=1728847538;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7Rx2zS6heNlW6j/U6kTDEMPIWUPYq5wOJuodFWiKd/Q=;
  b=KX3jJrFp3dPBUygW1d1KUCGaFlrEaN0TYh4H30Lqo3Wa3KBtAjN4MQPY
   iJcSnF2WellHe2IRHDw8X7CWpzuXOXLyo4TiHE8tEsRMgowuNCKBHT2yS
   zr9a2KUM/6yYp+6/h0pKXzmzWR9kK4x24n4Y7x7BvoFjROiKagLEAzDzY
   d9kVpTMAbBMIKJ+9LQyLhzd6Gpw3JvVk98HEPyHn5fBNjq3kfjsw5k3Tx
   2QXHAo9o8V55Y9gEipT7mhXI/WpUTCVtnj9uABrI2mpgNfhdcwPS9M2aJ
   11c/MdqaG+QpaJbat3YZDOBHeEfXZic/0LuD6z/z855zZl/2HjTMPcjk0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="375696289"
X-IronPort-AV: E=Sophos;i="6.03,224,1694761200"; 
   d="scan'208";a="375696289"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2023 12:25:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="845875439"
X-IronPort-AV: E=Sophos;i="6.03,224,1694761200"; 
   d="scan'208";a="845875439"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Oct 2023 12:25:28 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qrkGM-0006Z5-1Q;
        Sat, 14 Oct 2023 19:25:26 +0000
Date:   Sun, 15 Oct 2023 03:24:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: drivers/clk/ralink/clk-mtmips.c:821:34: warning: unused variable
 'mtmips_of_match'
Message-ID: <202310150352.KyKovpbT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   70f8c6f8f8800d970b10676cceae42bba51a4899
commit: 6f3b15586eef736831abe6a14f2a6906bc0dc074 clk: ralink: add clock and reset driver for MTMIPS SoCs
date:   4 months ago
config: hexagon-randconfig-r016-20230817 (https://download.01.org/0day-ci/archive/20231015/202310150352.KyKovpbT-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231015/202310150352.KyKovpbT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310150352.KyKovpbT-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/clk/ralink/clk-mtmips.c:11:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from drivers/clk/ralink/clk-mtmips.c:11:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/clk/ralink/clk-mtmips.c:11:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   drivers/clk/ralink/clk-mtmips.c:309:9: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
           return ret;
                  ^~~
   drivers/clk/ralink/clk-mtmips.c:285:9: note: initialize the variable 'ret' to silence this warning
           int ret, i;
                  ^
                   = 0
   drivers/clk/ralink/clk-mtmips.c:359:9: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
           return ret;
                  ^~~
   drivers/clk/ralink/clk-mtmips.c:335:9: note: initialize the variable 'ret' to silence this warning
           int ret, i;
                  ^
                   = 0
>> drivers/clk/ralink/clk-mtmips.c:821:34: warning: unused variable 'mtmips_of_match' [-Wunused-const-variable]
   static const struct of_device_id mtmips_of_match[] = {
                                    ^
   9 warnings generated.


vim +/mtmips_of_match +821 drivers/clk/ralink/clk-mtmips.c

   820	
 > 821	static const struct of_device_id mtmips_of_match[] = {
   822		{
   823			.compatible = "ralink,rt2880-sysc",
   824			.data = &rt2880_clk_data,
   825		},
   826		{
   827			.compatible = "ralink,rt3050-sysc",
   828			.data = &rt305x_clk_data,
   829		},
   830		{
   831			.compatible = "ralink,rt3052-sysc",
   832			.data = &rt305x_clk_data,
   833		},
   834		{
   835			.compatible = "ralink,rt3352-sysc",
   836			.data = &rt3352_clk_data,
   837		},
   838		{
   839			.compatible = "ralink,rt3883-sysc",
   840			.data = &rt3883_clk_data,
   841		},
   842		{
   843			.compatible = "ralink,rt5350-sysc",
   844			.data = &rt5350_clk_data,
   845		},
   846		{
   847			.compatible = "ralink,mt7620-sysc",
   848			.data = &mt7620_clk_data,
   849		},
   850		{
   851			.compatible = "ralink,mt7628-sysc",
   852			.data = &mt76x8_clk_data,
   853		},
   854		{
   855			.compatible = "ralink,mt7688-sysc",
   856			.data = &mt76x8_clk_data,
   857		},
   858		{}
   859	};
   860	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
