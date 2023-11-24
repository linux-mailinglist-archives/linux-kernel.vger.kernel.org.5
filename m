Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567767F6D46
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 08:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344773AbjKXH5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 02:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXH5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 02:57:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72D3D5E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 23:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700812657; x=1732348657;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1xQeoQLuqvy8Rt1LsnO9sRPGxJAfWcakYzUYs++VG2o=;
  b=f1DKbPNDp/oJfQ255atpx4/cdGWYUhoWivjE07qLNENKFfUy1AZvaGVs
   rI1tSA1MjnpOObgC83O1zGVMDtYCQwCKr4WtbO/wD2STTu1pFuN4VQuFU
   pdZmVmOet9tnleXQQT0LW/xTEjGLboqK1AZx1gtpkgcIjsB87eu+GIoU+
   8vx2Vye+Fslgda89B1VPeOj5qkw/B7hRThvyuTr8nghkQFJ0RlVV/xlq+
   ZOPyRqx2ztjWYX2C89zECC+7iX5DTbaYflCW0iwL/AaEJjliQzWltuvnT
   ed8Cz387MoICQ+hgi6ORRW99vTKM6LH0xqA+HBwHXHC4v3gEXOta45pQH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="395199297"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="395199297"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 23:57:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="767393120"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="767393120"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 23 Nov 2023 23:57:34 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r6R48-0002F0-0l;
        Fri, 24 Nov 2023 07:57:32 +0000
Date:   Fri, 24 Nov 2023 15:56:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: drivers/net/ethernet/freescale/ucc_geth.c:2454:64: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202311241204.B9Bel5dV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f1a09972a45ae63efbd1587337c4be13b1893330
commit: b28d1ccf921a4333be14017d82066386d419e638 powerpc/io: Expect immutable pointer in virt_to_phys() prototype
date:   5 weeks ago
config: powerpc-randconfig-r112-20231123 (https://download.01.org/0day-ci/archive/20231124/202311241204.B9Bel5dV-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231124/202311241204.B9Bel5dV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311241204.B9Bel5dV-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/net/ethernet/freescale/ucc_geth.c:244:21: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:244:21: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:244:21: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:405:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] [usertype] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:405:22: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:405:22: sparse:     got restricted __be16 [noderef] [usertype] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:406:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] [usertype] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:406:22: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:406:22: sparse:     got restricted __be16 [noderef] [usertype] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:407:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] [usertype] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:407:22: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:407:22: sparse:     got restricted __be16 [noderef] [usertype] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:449:23: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __be16 [noderef] [usertype] __iomem *reg @@     got unsigned short [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:449:23: sparse:     expected restricted __be16 [noderef] [usertype] __iomem *reg
   drivers/net/ethernet/freescale/ucc_geth.c:449:23: sparse:     got unsigned short [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:1317:26: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:1317:26: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1317:26: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:1344:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:1344:19: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1344:19: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:1390:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_uccm @@
   drivers/net/ethernet/freescale/ucc_geth.c:1390:9: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1390:9: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_uccm
   drivers/net/ethernet/freescale/ucc_geth.c:1390:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_uccm @@
   drivers/net/ethernet/freescale/ucc_geth.c:1390:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1390:9: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_uccm
   drivers/net/ethernet/freescale/ucc_geth.c:1391:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_ucce @@
   drivers/net/ethernet/freescale/ucc_geth.c:1391:22: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1391:22: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_ucce
   drivers/net/ethernet/freescale/ucc_geth.c:1402:36: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_ucce @@
   drivers/net/ethernet/freescale/ucc_geth.c:1402:36: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1402:36: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_ucce
   drivers/net/ethernet/freescale/ucc_geth.c:1571:38: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:1571:38: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1571:38: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:1636:35: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:1636:35: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1636:35: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:1824:41: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:1824:41: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1824:41: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:1839:50: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *objp @@     got unsigned char [noderef] [usertype] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:1839:50: sparse:     expected void const *objp
   drivers/net/ethernet/freescale/ucc_geth.c:1839:50: sparse:     got unsigned char [noderef] [usertype] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:1864:33: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:1864:33: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1864:33: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:1876:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *objp @@     got unsigned char [noderef] [usertype] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:1876:42: sparse:     expected void const *objp
   drivers/net/ethernet/freescale/ucc_geth.c:1876:42: sparse:     got unsigned char [noderef] [usertype] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:1965:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:1965:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1965:17: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:1965:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:1965:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1965:17: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:1967:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:1967:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1967:17: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:1967:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:1967:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1967:17: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2013:29: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_uccm @@
   drivers/net/ethernet/freescale/ucc_geth.c:2013:29: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:2013:29: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_uccm
   drivers/net/ethernet/freescale/ucc_geth.c:2016:29: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_ucce @@
   drivers/net/ethernet/freescale/ucc_geth.c:2016:29: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:2016:29: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_ucce
   drivers/net/ethernet/freescale/ucc_geth.c:2160:40: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] [usertype] __iomem * @@     got void * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2160:40: sparse:     expected unsigned char [noderef] [usertype] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2160:40: sparse:     got void *
   drivers/net/ethernet/freescale/ucc_geth.c:2168:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got unsigned char [noderef] [usertype] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2168:47: sparse:     expected void *
   drivers/net/ethernet/freescale/ucc_geth.c:2168:47: sparse:     got unsigned char [noderef] [usertype] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2188:37: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2188:37: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:2188:37: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2221:40: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] [usertype] __iomem * @@     got void * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2221:40: sparse:     expected unsigned char [noderef] [usertype] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2221:40: sparse:     got void *
   drivers/net/ethernet/freescale/ucc_geth.c:2248:37: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2248:37: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:2248:37: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2310:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [noderef] [usertype] __iomem *upsmr_register @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2310:32: sparse:     expected unsigned int [noderef] [usertype] __iomem *upsmr_register
   drivers/net/ethernet/freescale/ucc_geth.c:2310:32: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2316:57: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected unsigned int [noderef] [usertype] __iomem *upsmr_register @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2316:57: sparse:     expected unsigned int [noderef] [usertype] __iomem *upsmr_register
   drivers/net/ethernet/freescale/ucc_geth.c:2316:57: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2328:35: sparse: sparse: incorrect type in argument 6 (different base types) @@     expected unsigned int [noderef] [usertype] __iomem *upsmr_register @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2328:35: sparse:     expected unsigned int [noderef] [usertype] __iomem *upsmr_register
   drivers/net/ethernet/freescale/ucc_geth.c:2328:35: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2376:37: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int [noderef] [usertype] __iomem *upsmr_register @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2376:37: sparse:     expected unsigned int [noderef] [usertype] __iomem *upsmr_register
   drivers/net/ethernet/freescale/ucc_geth.c:2376:37: sparse:     got restricted __be32 [noderef] __iomem *
>> drivers/net/ethernet/freescale/ucc_geth.c:2454:64: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile *address @@     got unsigned char [noderef] [usertype] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2454:64: sparse:     expected void const volatile *address
   drivers/net/ethernet/freescale/ucc_geth.c:2454:64: sparse:     got unsigned char [noderef] [usertype] __iomem *
>> drivers/net/ethernet/freescale/ucc_geth.c:2457:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile *address @@     got unsigned char [noderef] [usertype] __iomem *[assigned] endOfRing @@
   drivers/net/ethernet/freescale/ucc_geth.c:2457:45: sparse:     expected void const volatile *address
   drivers/net/ethernet/freescale/ucc_geth.c:2457:45: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] endOfRing
   drivers/net/ethernet/freescale/ucc_geth.c:2677:64: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile *address @@     got unsigned char [noderef] [usertype] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2677:64: sparse:     expected void const volatile *address
   drivers/net/ethernet/freescale/ucc_geth.c:2677:64: sparse:     got unsigned char [noderef] [usertype] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2944:21: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2944:21: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:2944:21: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:3010:46: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:3010:46: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:3010:46: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:3138:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_uccm @@
   drivers/net/ethernet/freescale/ucc_geth.c:3138:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:3138:17: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_uccm
   drivers/net/ethernet/freescale/ucc_geth.c:3138:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_uccm @@
   drivers/net/ethernet/freescale/ucc_geth.c:3138:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:3138:17: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_uccm
   drivers/net/ethernet/freescale/ucc_geth.c:3159:34: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_ucce @@
   drivers/net/ethernet/freescale/ucc_geth.c:3159:34: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:3159:34: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_ucce
   drivers/net/ethernet/freescale/ucc_geth.c:3160:34: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_uccm @@
   drivers/net/ethernet/freescale/ucc_geth.c:3160:34: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:3160:34: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_uccm
   drivers/net/ethernet/freescale/ucc_geth.c:3162:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_ucce @@
   drivers/net/ethernet/freescale/ucc_geth.c:3162:22: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:3162:22: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_ucce
   drivers/net/ethernet/freescale/ucc_geth.c:3168:38: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_uccm @@
   drivers/net/ethernet/freescale/ucc_geth.c:3168:38: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:3168:38: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_uccm
   drivers/net/ethernet/freescale/ucc_geth.c:3414:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_uccm @@
   drivers/net/ethernet/freescale/ucc_geth.c:3414:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:3414:17: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_uccm
   drivers/net/ethernet/freescale/ucc_geth.c:3414:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_uccm @@
   drivers/net/ethernet/freescale/ucc_geth.c:3414:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:3414:17: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_uccm
   drivers/net/ethernet/freescale/ucc_geth.c:3437:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_uccm @@
   drivers/net/ethernet/freescale/ucc_geth.c:3437:25: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:3437:25: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_uccm
   drivers/net/ethernet/freescale/ucc_geth.c:3437:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_uccm @@
   drivers/net/ethernet/freescale/ucc_geth.c:3437:25: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:3437:25: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_uccm
   drivers/net/ethernet/freescale/ucc_geth.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/slab.h):
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false

vim +2454 drivers/net/ethernet/freescale/ucc_geth.c

e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker    2012-02-27  2258  
728de4c927a354 drivers/net/ucc_geth.c                    Kim Phillips      2007-04-13  2259  static int ucc_geth_startup(struct ucc_geth_private *ugeth)
728de4c927a354 drivers/net/ucc_geth.c                    Kim Phillips      2007-04-13  2260  {
6fee40e9b8155a drivers/net/ucc_geth.c                    Andy Fleming      2008-05-02  2261  	struct ucc_geth_82xx_address_filtering_pram __iomem *p_82xx_addr_filt;
6fee40e9b8155a drivers/net/ucc_geth.c                    Andy Fleming      2008-05-02  2262  	struct ucc_geth_init_pram __iomem *p_init_enet_pram;
728de4c927a354 drivers/net/ucc_geth.c                    Kim Phillips      2007-04-13  2263  	struct ucc_fast_private *uccf;
728de4c927a354 drivers/net/ucc_geth.c                    Kim Phillips      2007-04-13  2264  	struct ucc_geth_info *ug_info;
728de4c927a354 drivers/net/ucc_geth.c                    Kim Phillips      2007-04-13  2265  	struct ucc_fast_info *uf_info;
6fee40e9b8155a drivers/net/ucc_geth.c                    Andy Fleming      2008-05-02  2266  	struct ucc_fast __iomem *uf_regs;
6fee40e9b8155a drivers/net/ucc_geth.c                    Andy Fleming      2008-05-02  2267  	struct ucc_geth __iomem *ug_regs;
728de4c927a354 drivers/net/ucc_geth.c                    Kim Phillips      2007-04-13  2268  	int ret_val = -EINVAL;
728de4c927a354 drivers/net/ucc_geth.c                    Kim Phillips      2007-04-13  2269  	u32 remoder = UCC_GETH_REMODER_INIT;
3bc53427e4f323 drivers/net/ucc_geth.c                    Timur Tabi        2009-01-11  2270  	u32 init_enet_pram_offset, cecr_subblock, command;
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker    2012-02-27  2271  	u32 ifstat, i, j, size, l2qt, l3qt;
728de4c927a354 drivers/net/ucc_geth.c                    Kim Phillips      2007-04-13  2272  	u16 temoder = UCC_GETH_TEMODER_INIT;
728de4c927a354 drivers/net/ucc_geth.c                    Kim Phillips      2007-04-13  2273  	u8 function_code = 0;
6fee40e9b8155a drivers/net/ucc_geth.c                    Andy Fleming      2008-05-02  2274  	u8 __iomem *endOfRing;
728de4c927a354 drivers/net/ucc_geth.c                    Kim Phillips      2007-04-13  2275  	u8 numThreadsRxNumerical, numThreadsTxNumerical;
7d9fe90036f75a drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes  2021-01-19  2276  	s32 rx_glbl_pram_offset, tx_glbl_pram_offset;
728de4c927a354 drivers/net/ucc_geth.c                    Kim Phillips      2007-04-13  2277  
b39d66a81fb4f5 drivers/net/ucc_geth.c                    Harvey Harrison   2008-08-20  2278  	ugeth_vdbg("%s: IN", __func__);
728de4c927a354 drivers/net/ucc_geth.c                    Kim Phillips      2007-04-13  2279  	uccf = ugeth->uccf;
728de4c927a354 drivers/net/ucc_geth.c                    Kim Phillips      2007-04-13  2280  	ug_info = ugeth->ug_info;
728de4c927a354 drivers/net/ucc_geth.c                    Kim Phillips      2007-04-13  2281  	uf_info = &ug_info->uf_info;
728de4c927a354 drivers/net/ucc_geth.c                    Kim Phillips      2007-04-13  2282  	uf_regs = uccf->uf_regs;
728de4c927a354 drivers/net/ucc_geth.c                    Kim Phillips      2007-04-13  2283  	ug_regs = ugeth->ug_regs;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2284  
634b5bd7318725 drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes  2021-01-19  2285  	numThreadsRxNumerical = ucc_geth_thread_count(ug_info->numThreadsRx);
634b5bd7318725 drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes  2021-01-19  2286  	if (!numThreadsRxNumerical) {
890de95e8fe617 drivers/net/ucc_geth.c                    Li Yang           2007-07-19  2287  		if (netif_msg_ifup(ugeth))
c84d8055e0c997 drivers/net/ethernet/freescale/ucc_geth.c Joe Perches       2013-04-13  2288  			pr_err("Bad number of Rx threads value\n");
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2289  		return -EINVAL;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2290  	}
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2291  
634b5bd7318725 drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes  2021-01-19  2292  	numThreadsTxNumerical = ucc_geth_thread_count(ug_info->numThreadsTx);
634b5bd7318725 drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes  2021-01-19  2293  	if (!numThreadsTxNumerical) {
890de95e8fe617 drivers/net/ucc_geth.c                    Li Yang           2007-07-19  2294  		if (netif_msg_ifup(ugeth))
c84d8055e0c997 drivers/net/ethernet/freescale/ucc_geth.c Joe Perches       2013-04-13  2295  			pr_err("Bad number of Tx threads value\n");
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2296  		return -EINVAL;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2297  	}
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2298  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2299  	/* Calculate rx_extended_features */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2300  	ugeth->rx_non_dynamic_extended_features = ug_info->ipCheckSumCheck ||
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2301  	    ug_info->ipAddressAlignment ||
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2302  	    (ug_info->numStationAddresses !=
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2303  	     UCC_GETH_NUM_OF_STATION_ADDRESSES_1);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2304  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2305  	ugeth->rx_extended_features = ugeth->rx_non_dynamic_extended_features ||
8e95a2026f3b43 drivers/net/ucc_geth.c                    Joe Perches       2009-12-03  2306  		(ug_info->vlanOperationTagged != UCC_GETH_VLAN_OPERATION_TAGGED_NOP) ||
8e95a2026f3b43 drivers/net/ucc_geth.c                    Joe Perches       2009-12-03  2307  		(ug_info->vlanOperationNonTagged !=
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2308  		 UCC_GETH_VLAN_OPERATION_NON_TAGGED_NOP);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2309  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2310  	init_default_reg_vals(&uf_regs->upsmr,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2311  			      &ug_regs->maccfg1, &ug_regs->maccfg2);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2312  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2313  	/*                    Set UPSMR                      */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2314  	/* For more details see the hardware spec.           */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2315  	init_rx_parameters(ug_info->bro,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2316  			   ug_info->rsh, ug_info->pro, &uf_regs->upsmr);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2317  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2318  	/* We're going to ignore other registers for now, */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2319  	/* except as needed to get up and running         */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2320  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2321  	/*                    Set MACCFG1                    */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2322  	/* For more details see the hardware spec.           */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2323  	init_flow_control_params(ug_info->aufc,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2324  				 ug_info->receiveFlowControl,
ac421852b3a01e drivers/net/ucc_geth.c                    Li Yang           2007-07-19  2325  				 ug_info->transmitFlowControl,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2326  				 ug_info->pausePeriod,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2327  				 ug_info->extensionField,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2328  				 &uf_regs->upsmr,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2329  				 &ug_regs->uempr, &ug_regs->maccfg1);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2330  
3bc53427e4f323 drivers/net/ucc_geth.c                    Timur Tabi        2009-01-11  2331  	setbits32(&ug_regs->maccfg1, MACCFG1_ENABLE_RX | MACCFG1_ENABLE_TX);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2332  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2333  	/*                    Set IPGIFG                     */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2334  	/* For more details see the hardware spec.           */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2335  	ret_val = init_inter_frame_gap_params(ug_info->nonBackToBackIfgPart1,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2336  					      ug_info->nonBackToBackIfgPart2,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2337  					      ug_info->
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2338  					      miminumInterFrameGapEnforcement,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2339  					      ug_info->backToBackInterFrameGap,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2340  					      &ug_regs->ipgifg);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2341  	if (ret_val != 0) {
890de95e8fe617 drivers/net/ucc_geth.c                    Li Yang           2007-07-19  2342  		if (netif_msg_ifup(ugeth))
c84d8055e0c997 drivers/net/ethernet/freescale/ucc_geth.c Joe Perches       2013-04-13  2343  			pr_err("IPGIFG initialization parameter too large\n");
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2344  		return ret_val;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2345  	}
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2346  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2347  	/*                    Set HAFDUP                     */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2348  	/* For more details see the hardware spec.           */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2349  	ret_val = init_half_duplex_params(ug_info->altBeb,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2350  					  ug_info->backPressureNoBackoff,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2351  					  ug_info->noBackoff,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2352  					  ug_info->excessDefer,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2353  					  ug_info->altBebTruncation,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2354  					  ug_info->maxRetransmission,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2355  					  ug_info->collisionWindow,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2356  					  &ug_regs->hafdup);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2357  	if (ret_val != 0) {
890de95e8fe617 drivers/net/ucc_geth.c                    Li Yang           2007-07-19  2358  		if (netif_msg_ifup(ugeth))
c84d8055e0c997 drivers/net/ethernet/freescale/ucc_geth.c Joe Perches       2013-04-13  2359  			pr_err("Half Duplex initialization parameter too large\n");
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2360  		return ret_val;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2361  	}
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2362  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2363  	/*                    Set IFSTAT                     */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2364  	/* For more details see the hardware spec.           */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2365  	/* Read only - resets upon read                      */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2366  	ifstat = in_be32(&ug_regs->ifstat);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2367  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2368  	/*                    Clear UEMPR                    */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2369  	/* For more details see the hardware spec.           */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2370  	out_be32(&ug_regs->uempr, 0);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2371  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2372  	/*                    Set UESCR                      */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2373  	/* For more details see the hardware spec.           */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2374  	init_hw_statistics_gathering_mode((ug_info->statisticsMode &
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2375  				UCC_GETH_STATISTICS_GATHERING_MODE_HARDWARE),
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2376  				0, &uf_regs->upsmr, &ug_regs->uescr);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2377  
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker    2012-02-27  2378  	ret_val = ucc_geth_alloc_tx(ugeth);
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker    2012-02-27  2379  	if (ret_val != 0)
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker    2012-02-27  2380  		return ret_val;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2381  
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker    2012-02-27  2382  	ret_val = ucc_geth_alloc_rx(ugeth);
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker    2012-02-27  2383  	if (ret_val != 0)
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker    2012-02-27  2384  		return ret_val;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2385  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2386  	/*
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2387  	 * Global PRAM
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2388  	 */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2389  	/* Tx global PRAM */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2390  	/* Allocate global tx parameter RAM page */
7d9fe90036f75a drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes  2021-01-19  2391  	tx_glbl_pram_offset =
18a8e8649d2687 drivers/net/ucc_geth.c                    Li Yang           2006-10-19  2392  	    qe_muram_alloc(sizeof(struct ucc_geth_tx_global_pram),
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2393  			   UCC_GETH_TX_GLOBAL_PRAM_ALIGNMENT);
7d9fe90036f75a drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes  2021-01-19  2394  	if (tx_glbl_pram_offset < 0) {
890de95e8fe617 drivers/net/ucc_geth.c                    Li Yang           2007-07-19  2395  		if (netif_msg_ifup(ugeth))
c84d8055e0c997 drivers/net/ethernet/freescale/ucc_geth.c Joe Perches       2013-04-13  2396  			pr_err("Can not allocate DPRAM memory for p_tx_glbl_pram\n");
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2397  		return -ENOMEM;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2398  	}
7d9fe90036f75a drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes  2021-01-19  2399  	ugeth->p_tx_glbl_pram = qe_muram_addr(tx_glbl_pram_offset);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2400  	/* Fill global PRAM */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2401  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2402  	/* TQPTR */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2403  	/* Size varies with number of Tx threads */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2404  	ugeth->thread_dat_tx_offset =
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2405  	    qe_muram_alloc(numThreadsTxNumerical *
18a8e8649d2687 drivers/net/ucc_geth.c                    Li Yang           2006-10-19  2406  			   sizeof(struct ucc_geth_thread_data_tx) +
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2407  			   32 * (numThreadsTxNumerical == 1),
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2408  			   UCC_GETH_THREAD_DATA_ALIGNMENT);
4c35630ccda56e drivers/net/ucc_geth.c                    Timur Tabi        2007-05-08  2409  	if (IS_ERR_VALUE(ugeth->thread_dat_tx_offset)) {
890de95e8fe617 drivers/net/ucc_geth.c                    Li Yang           2007-07-19  2410  		if (netif_msg_ifup(ugeth))
c84d8055e0c997 drivers/net/ethernet/freescale/ucc_geth.c Joe Perches       2013-04-13  2411  			pr_err("Can not allocate DPRAM memory for p_thread_data_tx\n");
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2412  		return -ENOMEM;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2413  	}
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2414  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2415  	ugeth->p_thread_data_tx =
6fee40e9b8155a drivers/net/ucc_geth.c                    Andy Fleming      2008-05-02  2416  	    (struct ucc_geth_thread_data_tx __iomem *) qe_muram_addr(ugeth->
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2417  							thread_dat_tx_offset);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2418  	out_be32(&ugeth->p_tx_glbl_pram->tqptr, ugeth->thread_dat_tx_offset);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2419  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2420  	/* vtagtable */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2421  	for (i = 0; i < UCC_GETH_TX_VTAG_TABLE_ENTRY_MAX; i++)
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2422  		out_be32(&ugeth->p_tx_glbl_pram->vtagtable[i],
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2423  			 ug_info->vtagtable[i]);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2424  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2425  	/* iphoffset */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2426  	for (i = 0; i < TX_IP_OFFSET_ENTRY_MAX; i++)
6fee40e9b8155a drivers/net/ucc_geth.c                    Andy Fleming      2008-05-02  2427  		out_8(&ugeth->p_tx_glbl_pram->iphoffset[i],
6fee40e9b8155a drivers/net/ucc_geth.c                    Andy Fleming      2008-05-02  2428  				ug_info->iphoffset[i]);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2429  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2430  	/* SQPTR */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2431  	/* Size varies with number of Tx queues */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2432  	ugeth->send_q_mem_reg_offset =
53f49d86ea2108 drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes  2021-01-19  2433  	    qe_muram_alloc(ucc_geth_tx_queues(ug_info) *
18a8e8649d2687 drivers/net/ucc_geth.c                    Li Yang           2006-10-19  2434  			   sizeof(struct ucc_geth_send_queue_qd),
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2435  			   UCC_GETH_SEND_QUEUE_QUEUE_DESCRIPTOR_ALIGNMENT);
4c35630ccda56e drivers/net/ucc_geth.c                    Timur Tabi        2007-05-08  2436  	if (IS_ERR_VALUE(ugeth->send_q_mem_reg_offset)) {
890de95e8fe617 drivers/net/ucc_geth.c                    Li Yang           2007-07-19  2437  		if (netif_msg_ifup(ugeth))
c84d8055e0c997 drivers/net/ethernet/freescale/ucc_geth.c Joe Perches       2013-04-13  2438  			pr_err("Can not allocate DPRAM memory for p_send_q_mem_reg\n");
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2439  		return -ENOMEM;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2440  	}
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2441  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2442  	ugeth->p_send_q_mem_reg =
6fee40e9b8155a drivers/net/ucc_geth.c                    Andy Fleming      2008-05-02  2443  	    (struct ucc_geth_send_queue_mem_region __iomem *) qe_muram_addr(ugeth->
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2444  			send_q_mem_reg_offset);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2445  	out_be32(&ugeth->p_tx_glbl_pram->sqptr, ugeth->send_q_mem_reg_offset);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2446  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2447  	/* Setup the table */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2448  	/* Assume BD rings are already established */
53f49d86ea2108 drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes  2021-01-19  2449  	for (i = 0; i < ucc_geth_tx_queues(ug_info); i++) {
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2450  		endOfRing =
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2451  		    ugeth->p_tx_bd_ring[i] + (ug_info->bdRingLenTx[i] -
18a8e8649d2687 drivers/net/ucc_geth.c                    Li Yang           2006-10-19  2452  					      1) * sizeof(struct qe_bd);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2453  		out_be32(&ugeth->p_send_q_mem_reg->sqqd[i].bd_ring_base,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14 @2454  			 (u32) virt_to_phys(ugeth->p_tx_bd_ring[i]));
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2455  		out_be32(&ugeth->p_send_q_mem_reg->sqqd[i].
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2456  			 last_bd_completed_address,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14 @2457  			 (u32) virt_to_phys(endOfRing));
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2458  	}
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2459  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2460  	/* schedulerbasepointer */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2461  
53f49d86ea2108 drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes  2021-01-19  2462  	if (ucc_geth_tx_queues(ug_info) > 1) {
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2463  	/* scheduler exists only if more than 1 tx queue */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2464  		ugeth->scheduler_offset =
18a8e8649d2687 drivers/net/ucc_geth.c                    Li Yang           2006-10-19  2465  		    qe_muram_alloc(sizeof(struct ucc_geth_scheduler),
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2466  				   UCC_GETH_SCHEDULER_ALIGNMENT);
4c35630ccda56e drivers/net/ucc_geth.c                    Timur Tabi        2007-05-08  2467  		if (IS_ERR_VALUE(ugeth->scheduler_offset)) {
890de95e8fe617 drivers/net/ucc_geth.c                    Li Yang           2007-07-19  2468  			if (netif_msg_ifup(ugeth))
c84d8055e0c997 drivers/net/ethernet/freescale/ucc_geth.c Joe Perches       2013-04-13  2469  				pr_err("Can not allocate DPRAM memory for p_scheduler\n");
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2470  			return -ENOMEM;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2471  		}
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2472  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2473  		ugeth->p_scheduler =
6fee40e9b8155a drivers/net/ucc_geth.c                    Andy Fleming      2008-05-02  2474  		    (struct ucc_geth_scheduler __iomem *) qe_muram_addr(ugeth->
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2475  							   scheduler_offset);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2476  		out_be32(&ugeth->p_tx_glbl_pram->schedulerbasepointer,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2477  			 ugeth->scheduler_offset);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2478  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2479  		/* Set values in scheduler */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2480  		out_be32(&ugeth->p_scheduler->mblinterval,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2481  			 ug_info->mblinterval);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2482  		out_be16(&ugeth->p_scheduler->nortsrbytetime,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2483  			 ug_info->nortsrbytetime);
6fee40e9b8155a drivers/net/ucc_geth.c                    Andy Fleming      2008-05-02  2484  		out_8(&ugeth->p_scheduler->fracsiz, ug_info->fracsiz);
6fee40e9b8155a drivers/net/ucc_geth.c                    Andy Fleming      2008-05-02  2485  		out_8(&ugeth->p_scheduler->strictpriorityq,
6fee40e9b8155a drivers/net/ucc_geth.c                    Andy Fleming      2008-05-02  2486  				ug_info->strictpriorityq);
6fee40e9b8155a drivers/net/ucc_geth.c                    Andy Fleming      2008-05-02  2487  		out_8(&ugeth->p_scheduler->txasap, ug_info->txasap);
6fee40e9b8155a drivers/net/ucc_geth.c                    Andy Fleming      2008-05-02  2488  		out_8(&ugeth->p_scheduler->extrabw, ug_info->extrabw);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2489  		for (i = 0; i < NUM_TX_QUEUES; i++)
6fee40e9b8155a drivers/net/ucc_geth.c                    Andy Fleming      2008-05-02  2490  			out_8(&ugeth->p_scheduler->weightfactor[i],
6fee40e9b8155a drivers/net/ucc_geth.c                    Andy Fleming      2008-05-02  2491  			    ug_info->weightfactor[i]);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2492  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2493  		/* Set pointers to cpucount registers in scheduler */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2494  		ugeth->p_cpucount[0] = &(ugeth->p_scheduler->cpucount0);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2495  		ugeth->p_cpucount[1] = &(ugeth->p_scheduler->cpucount1);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2496  		ugeth->p_cpucount[2] = &(ugeth->p_scheduler->cpucount2);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2497  		ugeth->p_cpucount[3] = &(ugeth->p_scheduler->cpucount3);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2498  		ugeth->p_cpucount[4] = &(ugeth->p_scheduler->cpucount4);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2499  		ugeth->p_cpucount[5] = &(ugeth->p_scheduler->cpucount5);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2500  		ugeth->p_cpucount[6] = &(ugeth->p_scheduler->cpucount6);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2501  		ugeth->p_cpucount[7] = &(ugeth->p_scheduler->cpucount7);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2502  	}
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2503  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2504  	/* schedulerbasepointer */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2505  	/* TxRMON_PTR (statistics) */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2506  	if (ug_info->
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2507  	    statisticsMode & UCC_GETH_STATISTICS_GATHERING_MODE_FIRMWARE_TX) {
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2508  		ugeth->tx_fw_statistics_pram_offset =
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2509  		    qe_muram_alloc(sizeof
18a8e8649d2687 drivers/net/ucc_geth.c                    Li Yang           2006-10-19  2510  				   (struct ucc_geth_tx_firmware_statistics_pram),
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2511  				   UCC_GETH_TX_STATISTICS_ALIGNMENT);
4c35630ccda56e drivers/net/ucc_geth.c                    Timur Tabi        2007-05-08  2512  		if (IS_ERR_VALUE(ugeth->tx_fw_statistics_pram_offset)) {
890de95e8fe617 drivers/net/ucc_geth.c                    Li Yang           2007-07-19  2513  			if (netif_msg_ifup(ugeth))
c84d8055e0c997 drivers/net/ethernet/freescale/ucc_geth.c Joe Perches       2013-04-13  2514  				pr_err("Can not allocate DPRAM memory for p_tx_fw_statistics_pram\n");
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2515  			return -ENOMEM;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2516  		}
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2517  		ugeth->p_tx_fw_statistics_pram =
6fee40e9b8155a drivers/net/ucc_geth.c                    Andy Fleming      2008-05-02  2518  		    (struct ucc_geth_tx_firmware_statistics_pram __iomem *)
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2519  		    qe_muram_addr(ugeth->tx_fw_statistics_pram_offset);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2520  	}
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2521  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2522  	/* temoder */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2523  	/* Already has speed set */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2524  
53f49d86ea2108 drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes  2021-01-19  2525  	if (ucc_geth_tx_queues(ug_info) > 1)
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2526  		temoder |= TEMODER_SCHEDULER_ENABLE;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2527  	if (ug_info->ipCheckSumGenerate)
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2528  		temoder |= TEMODER_IP_CHECKSUM_GENERATE;
53f49d86ea2108 drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes  2021-01-19  2529  	temoder |= ((ucc_geth_tx_queues(ug_info) - 1) << TEMODER_NUM_OF_QUEUES_SHIFT);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2530  	out_be16(&ugeth->p_tx_glbl_pram->temoder, temoder);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2531  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2532  	/* Function code register value to be used later */
6b0b594bb81f86 drivers/net/ucc_geth.c                    Timur Tabi        2007-10-03  2533  	function_code = UCC_BMR_BO_BE | UCC_BMR_GBL;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2534  	/* Required for QE */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2535  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2536  	/* function code register */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2537  	out_be32(&ugeth->p_tx_glbl_pram->tstate, ((u32) function_code) << 24);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2538  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2539  	/* Rx global PRAM */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2540  	/* Allocate global rx parameter RAM page */
7d9fe90036f75a drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes  2021-01-19  2541  	rx_glbl_pram_offset =
18a8e8649d2687 drivers/net/ucc_geth.c                    Li Yang           2006-10-19  2542  	    qe_muram_alloc(sizeof(struct ucc_geth_rx_global_pram),
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2543  			   UCC_GETH_RX_GLOBAL_PRAM_ALIGNMENT);
7d9fe90036f75a drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes  2021-01-19  2544  	if (rx_glbl_pram_offset < 0) {
890de95e8fe617 drivers/net/ucc_geth.c                    Li Yang           2007-07-19  2545  		if (netif_msg_ifup(ugeth))
c84d8055e0c997 drivers/net/ethernet/freescale/ucc_geth.c Joe Perches       2013-04-13  2546  			pr_err("Can not allocate DPRAM memory for p_rx_glbl_pram\n");
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2547  		return -ENOMEM;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2548  	}
7d9fe90036f75a drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes  2021-01-19  2549  	ugeth->p_rx_glbl_pram = qe_muram_addr(rx_glbl_pram_offset);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2550  	/* Fill global PRAM */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2551  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2552  	/* RQPTR */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2553  	/* Size varies with number of Rx threads */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2554  	ugeth->thread_dat_rx_offset =
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2555  	    qe_muram_alloc(numThreadsRxNumerical *
18a8e8649d2687 drivers/net/ucc_geth.c                    Li Yang           2006-10-19  2556  			   sizeof(struct ucc_geth_thread_data_rx),
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2557  			   UCC_GETH_THREAD_DATA_ALIGNMENT);
4c35630ccda56e drivers/net/ucc_geth.c                    Timur Tabi        2007-05-08  2558  	if (IS_ERR_VALUE(ugeth->thread_dat_rx_offset)) {
890de95e8fe617 drivers/net/ucc_geth.c                    Li Yang           2007-07-19  2559  		if (netif_msg_ifup(ugeth))
c84d8055e0c997 drivers/net/ethernet/freescale/ucc_geth.c Joe Perches       2013-04-13  2560  			pr_err("Can not allocate DPRAM memory for p_thread_data_rx\n");
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2561  		return -ENOMEM;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2562  	}
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2563  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2564  	ugeth->p_thread_data_rx =
6fee40e9b8155a drivers/net/ucc_geth.c                    Andy Fleming      2008-05-02  2565  	    (struct ucc_geth_thread_data_rx __iomem *) qe_muram_addr(ugeth->
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2566  							thread_dat_rx_offset);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2567  	out_be32(&ugeth->p_rx_glbl_pram->rqptr, ugeth->thread_dat_rx_offset);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2568  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2569  	/* typeorlen */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2570  	out_be16(&ugeth->p_rx_glbl_pram->typeorlen, ug_info->typeorlen);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2571  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2572  	/* rxrmonbaseptr (statistics) */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2573  	if (ug_info->
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2574  	    statisticsMode & UCC_GETH_STATISTICS_GATHERING_MODE_FIRMWARE_RX) {
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2575  		ugeth->rx_fw_statistics_pram_offset =
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2576  		    qe_muram_alloc(sizeof
18a8e8649d2687 drivers/net/ucc_geth.c                    Li Yang           2006-10-19  2577  				   (struct ucc_geth_rx_firmware_statistics_pram),
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2578  				   UCC_GETH_RX_STATISTICS_ALIGNMENT);
4c35630ccda56e drivers/net/ucc_geth.c                    Timur Tabi        2007-05-08  2579  		if (IS_ERR_VALUE(ugeth->rx_fw_statistics_pram_offset)) {
890de95e8fe617 drivers/net/ucc_geth.c                    Li Yang           2007-07-19  2580  			if (netif_msg_ifup(ugeth))
c84d8055e0c997 drivers/net/ethernet/freescale/ucc_geth.c Joe Perches       2013-04-13  2581  				pr_err("Can not allocate DPRAM memory for p_rx_fw_statistics_pram\n");
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2582  			return -ENOMEM;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2583  		}
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2584  		ugeth->p_rx_fw_statistics_pram =
6fee40e9b8155a drivers/net/ucc_geth.c                    Andy Fleming      2008-05-02  2585  		    (struct ucc_geth_rx_firmware_statistics_pram __iomem *)
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2586  		    qe_muram_addr(ugeth->rx_fw_statistics_pram_offset);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2587  	}
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2588  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2589  	/* intCoalescingPtr */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2590  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2591  	/* Size varies with number of Rx queues */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2592  	ugeth->rx_irq_coalescing_tbl_offset =
53f49d86ea2108 drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes  2021-01-19  2593  	    qe_muram_alloc(ucc_geth_rx_queues(ug_info) *
7563907eb8aad8 drivers/net/ucc_geth.c                    Michael Barkowski 2007-04-13  2594  			   sizeof(struct ucc_geth_rx_interrupt_coalescing_entry)
7563907eb8aad8 drivers/net/ucc_geth.c                    Michael Barkowski 2007-04-13  2595  			   + 4, UCC_GETH_RX_INTERRUPT_COALESCING_ALIGNMENT);
4c35630ccda56e drivers/net/ucc_geth.c                    Timur Tabi        2007-05-08  2596  	if (IS_ERR_VALUE(ugeth->rx_irq_coalescing_tbl_offset)) {
890de95e8fe617 drivers/net/ucc_geth.c                    Li Yang           2007-07-19  2597  		if (netif_msg_ifup(ugeth))
c84d8055e0c997 drivers/net/ethernet/freescale/ucc_geth.c Joe Perches       2013-04-13  2598  			pr_err("Can not allocate DPRAM memory for p_rx_irq_coalescing_tbl\n");
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2599  		return -ENOMEM;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2600  	}
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2601  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2602  	ugeth->p_rx_irq_coalescing_tbl =
6fee40e9b8155a drivers/net/ucc_geth.c                    Andy Fleming      2008-05-02  2603  	    (struct ucc_geth_rx_interrupt_coalescing_table __iomem *)
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2604  	    qe_muram_addr(ugeth->rx_irq_coalescing_tbl_offset);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2605  	out_be32(&ugeth->p_rx_glbl_pram->intcoalescingptr,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2606  		 ugeth->rx_irq_coalescing_tbl_offset);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2607  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2608  	/* Fill interrupt coalescing table */
53f49d86ea2108 drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes  2021-01-19  2609  	for (i = 0; i < ucc_geth_rx_queues(ug_info); i++) {
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2610  		out_be32(&ugeth->p_rx_irq_coalescing_tbl->coalescingentry[i].
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2611  			 interruptcoalescingmaxvalue,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2612  			 ug_info->interruptcoalescingmaxvalue[i]);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2613  		out_be32(&ugeth->p_rx_irq_coalescing_tbl->coalescingentry[i].
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2614  			 interruptcoalescingcounter,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2615  			 ug_info->interruptcoalescingmaxvalue[i]);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2616  	}
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2617  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2618  	/* MRBLR */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2619  	init_max_rx_buff_len(uf_info->max_rx_buf_length,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2620  			     &ugeth->p_rx_glbl_pram->mrblr);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2621  	/* MFLR */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2622  	out_be16(&ugeth->p_rx_glbl_pram->mflr, ug_info->maxFrameLength);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2623  	/* MINFLR */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2624  	init_min_frame_len(ug_info->minFrameLength,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2625  			   &ugeth->p_rx_glbl_pram->minflr,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2626  			   &ugeth->p_rx_glbl_pram->mrblr);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2627  	/* MAXD1 */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2628  	out_be16(&ugeth->p_rx_glbl_pram->maxd1, ug_info->maxD1Length);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2629  	/* MAXD2 */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2630  	out_be16(&ugeth->p_rx_glbl_pram->maxd2, ug_info->maxD2Length);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2631  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2632  	/* l2qt */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2633  	l2qt = 0;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2634  	for (i = 0; i < UCC_GETH_VLAN_PRIORITY_MAX; i++)
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2635  		l2qt |= (ug_info->l2qt[i] << (28 - 4 * i));
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2636  	out_be32(&ugeth->p_rx_glbl_pram->l2qt, l2qt);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2637  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2638  	/* l3qt */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2639  	for (j = 0; j < UCC_GETH_IP_PRIORITY_MAX; j += 8) {
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2640  		l3qt = 0;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2641  		for (i = 0; i < 8; i++)
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2642  			l3qt |= (ug_info->l3qt[j + i] << (28 - 4 * i));
18a8e8649d2687 drivers/net/ucc_geth.c                    Li Yang           2006-10-19  2643  		out_be32(&ugeth->p_rx_glbl_pram->l3qt[j/8], l3qt);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2644  	}
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2645  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2646  	/* vlantype */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2647  	out_be16(&ugeth->p_rx_glbl_pram->vlantype, ug_info->vlantype);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2648  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2649  	/* vlantci */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2650  	out_be16(&ugeth->p_rx_glbl_pram->vlantci, ug_info->vlantci);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2651  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2652  	/* ecamptr */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2653  	out_be32(&ugeth->p_rx_glbl_pram->ecamptr, ug_info->ecamptr);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2654  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2655  	/* RBDQPTR */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2656  	/* Size varies with number of Rx queues */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2657  	ugeth->rx_bd_qs_tbl_offset =
53f49d86ea2108 drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes  2021-01-19  2658  	    qe_muram_alloc(ucc_geth_rx_queues(ug_info) *
18a8e8649d2687 drivers/net/ucc_geth.c                    Li Yang           2006-10-19  2659  			   (sizeof(struct ucc_geth_rx_bd_queues_entry) +
18a8e8649d2687 drivers/net/ucc_geth.c                    Li Yang           2006-10-19  2660  			    sizeof(struct ucc_geth_rx_prefetched_bds)),
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2661  			   UCC_GETH_RX_BD_QUEUES_ALIGNMENT);
4c35630ccda56e drivers/net/ucc_geth.c                    Timur Tabi        2007-05-08  2662  	if (IS_ERR_VALUE(ugeth->rx_bd_qs_tbl_offset)) {
890de95e8fe617 drivers/net/ucc_geth.c                    Li Yang           2007-07-19  2663  		if (netif_msg_ifup(ugeth))
c84d8055e0c997 drivers/net/ethernet/freescale/ucc_geth.c Joe Perches       2013-04-13  2664  			pr_err("Can not allocate DPRAM memory for p_rx_bd_qs_tbl\n");
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2665  		return -ENOMEM;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2666  	}
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2667  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2668  	ugeth->p_rx_bd_qs_tbl =
6fee40e9b8155a drivers/net/ucc_geth.c                    Andy Fleming      2008-05-02  2669  	    (struct ucc_geth_rx_bd_queues_entry __iomem *) qe_muram_addr(ugeth->
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2670  				    rx_bd_qs_tbl_offset);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2671  	out_be32(&ugeth->p_rx_glbl_pram->rbdqptr, ugeth->rx_bd_qs_tbl_offset);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2672  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2673  	/* Setup the table */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2674  	/* Assume BD rings are already established */
53f49d86ea2108 drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes  2021-01-19  2675  	for (i = 0; i < ucc_geth_rx_queues(ug_info); i++) {
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2676  		out_be32(&ugeth->p_rx_bd_qs_tbl[i].externalbdbaseptr,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2677  			 (u32) virt_to_phys(ugeth->p_rx_bd_ring[i]));
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2678  		/* rest of fields handled by QE */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2679  	}
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2680  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2681  	/* remoder */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2682  	/* Already has speed set */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2683  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2684  	if (ugeth->rx_extended_features)
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2685  		remoder |= REMODER_RX_EXTENDED_FEATURES;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2686  	if (ug_info->rxExtendedFiltering)
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2687  		remoder |= REMODER_RX_EXTENDED_FILTERING;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2688  	if (ug_info->dynamicMaxFrameLength)
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2689  		remoder |= REMODER_DYNAMIC_MAX_FRAME_LENGTH;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2690  	if (ug_info->dynamicMinFrameLength)
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2691  		remoder |= REMODER_DYNAMIC_MIN_FRAME_LENGTH;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2692  	remoder |=
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2693  	    ug_info->vlanOperationTagged << REMODER_VLAN_OPERATION_TAGGED_SHIFT;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2694  	remoder |=
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2695  	    ug_info->
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2696  	    vlanOperationNonTagged << REMODER_VLAN_OPERATION_NON_TAGGED_SHIFT;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2697  	remoder |= ug_info->rxQoSMode << REMODER_RX_QOS_MODE_SHIFT;
53f49d86ea2108 drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes  2021-01-19  2698  	remoder |= ((ucc_geth_rx_queues(ug_info) - 1) << REMODER_NUM_OF_QUEUES_SHIFT);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2699  	if (ug_info->ipCheckSumCheck)
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2700  		remoder |= REMODER_IP_CHECKSUM_CHECK;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2701  	if (ug_info->ipAddressAlignment)
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2702  		remoder |= REMODER_IP_ADDRESS_ALIGNMENT;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2703  	out_be32(&ugeth->p_rx_glbl_pram->remoder, remoder);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2704  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2705  	/* Note that this function must be called */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2706  	/* ONLY AFTER p_tx_fw_statistics_pram */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2707  	/* andp_UccGethRxFirmwareStatisticsPram are allocated ! */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2708  	init_firmware_statistics_gathering_mode((ug_info->
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2709  		statisticsMode &
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2710  		UCC_GETH_STATISTICS_GATHERING_MODE_FIRMWARE_TX),
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2711  		(ug_info->statisticsMode &
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2712  		UCC_GETH_STATISTICS_GATHERING_MODE_FIRMWARE_RX),
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2713  		&ugeth->p_tx_glbl_pram->txrmonbaseptr,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2714  		ugeth->tx_fw_statistics_pram_offset,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2715  		&ugeth->p_rx_glbl_pram->rxrmonbaseptr,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2716  		ugeth->rx_fw_statistics_pram_offset,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2717  		&ugeth->p_tx_glbl_pram->temoder,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2718  		&ugeth->p_rx_glbl_pram->remoder);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2719  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2720  	/* function code register */
6fee40e9b8155a drivers/net/ucc_geth.c                    Andy Fleming      2008-05-02  2721  	out_8(&ugeth->p_rx_glbl_pram->rstate, function_code);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2722  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2723  	/* initialize extended filtering */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2724  	if (ug_info->rxExtendedFiltering) {
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2725  		if (!ug_info->extendedFilteringChainPointer) {
890de95e8fe617 drivers/net/ucc_geth.c                    Li Yang           2007-07-19  2726  			if (netif_msg_ifup(ugeth))
c84d8055e0c997 drivers/net/ethernet/freescale/ucc_geth.c Joe Perches       2013-04-13  2727  				pr_err("Null Extended Filtering Chain Pointer\n");
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2728  			return -EINVAL;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2729  		}
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2730  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2731  		/* Allocate memory for extended filtering Mode Global
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2732  		Parameters */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2733  		ugeth->exf_glbl_param_offset =
18a8e8649d2687 drivers/net/ucc_geth.c                    Li Yang           2006-10-19  2734  		    qe_muram_alloc(sizeof(struct ucc_geth_exf_global_pram),
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2735  		UCC_GETH_RX_EXTENDED_FILTERING_GLOBAL_PARAMETERS_ALIGNMENT);
4c35630ccda56e drivers/net/ucc_geth.c                    Timur Tabi        2007-05-08  2736  		if (IS_ERR_VALUE(ugeth->exf_glbl_param_offset)) {
890de95e8fe617 drivers/net/ucc_geth.c                    Li Yang           2007-07-19  2737  			if (netif_msg_ifup(ugeth))
c84d8055e0c997 drivers/net/ethernet/freescale/ucc_geth.c Joe Perches       2013-04-13  2738  				pr_err("Can not allocate DPRAM memory for p_exf_glbl_param\n");
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2739  			return -ENOMEM;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2740  		}
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2741  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2742  		ugeth->p_exf_glbl_param =
6fee40e9b8155a drivers/net/ucc_geth.c                    Andy Fleming      2008-05-02  2743  		    (struct ucc_geth_exf_global_pram __iomem *) qe_muram_addr(ugeth->
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2744  				 exf_glbl_param_offset);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2745  		out_be32(&ugeth->p_rx_glbl_pram->exfGlobalParam,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2746  			 ugeth->exf_glbl_param_offset);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2747  		out_be32(&ugeth->p_exf_glbl_param->l2pcdptr,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2748  			 (u32) ug_info->extendedFilteringChainPointer);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2749  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2750  	} else {		/* initialize 82xx style address filtering */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2751  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2752  		/* Init individual address recognition registers to disabled */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2753  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2754  		for (j = 0; j < NUM_OF_PADDRS; j++)
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2755  			ugeth_82xx_filtering_clear_addr_in_paddr(ugeth, (u8) j);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2756  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2757  		p_82xx_addr_filt =
6fee40e9b8155a drivers/net/ucc_geth.c                    Andy Fleming      2008-05-02  2758  		    (struct ucc_geth_82xx_address_filtering_pram __iomem *) ugeth->
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2759  		    p_rx_glbl_pram->addressfiltering;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2760  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2761  		ugeth_82xx_filtering_clear_all_addr_in_hash(ugeth,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2762  			ENET_ADDR_TYPE_GROUP);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2763  		ugeth_82xx_filtering_clear_all_addr_in_hash(ugeth,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2764  			ENET_ADDR_TYPE_INDIVIDUAL);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2765  	}
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2766  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2767  	/*
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2768  	 * Initialize UCC at QE level
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2769  	 */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2770  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2771  	command = QE_INIT_TX_RX;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2772  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2773  	/* Allocate shadow InitEnet command parameter structure.
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2774  	 * This is needed because after the InitEnet command is executed,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2775  	 * the structure in DPRAM is released, because DPRAM is a premium
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2776  	 * resource.
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2777  	 * This shadow structure keeps a copy of what was done so that the
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2778  	 * allocated resources can be released when the channel is freed.
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2779  	 */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2780  	if (!(ugeth->p_init_enet_param_shadow =
830c8ddc66df50 drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes  2021-01-19  2781  	      kzalloc(sizeof(struct ucc_geth_init_pram), GFP_KERNEL))) {
890de95e8fe617 drivers/net/ucc_geth.c                    Li Yang           2007-07-19  2782  		if (netif_msg_ifup(ugeth))
c84d8055e0c997 drivers/net/ethernet/freescale/ucc_geth.c Joe Perches       2013-04-13  2783  			pr_err("Can not allocate memory for p_UccInitEnetParamShadows\n");
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2784  		return -ENOMEM;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2785  	}
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2786  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2787  	/* Fill shadow InitEnet command parameter structure */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2788  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2789  	ugeth->p_init_enet_param_shadow->resinit1 =
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2790  	    ENET_INIT_PARAM_MAGIC_RES_INIT1;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2791  	ugeth->p_init_enet_param_shadow->resinit2 =
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2792  	    ENET_INIT_PARAM_MAGIC_RES_INIT2;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2793  	ugeth->p_init_enet_param_shadow->resinit3 =
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2794  	    ENET_INIT_PARAM_MAGIC_RES_INIT3;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2795  	ugeth->p_init_enet_param_shadow->resinit4 =
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2796  	    ENET_INIT_PARAM_MAGIC_RES_INIT4;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2797  	ugeth->p_init_enet_param_shadow->resinit5 =
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2798  	    ENET_INIT_PARAM_MAGIC_RES_INIT5;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2799  	ugeth->p_init_enet_param_shadow->rgftgfrxglobal |=
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2800  	    ((u32) ug_info->numThreadsRx) << ENET_INIT_PARAM_RGF_SHIFT;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2801  	ugeth->p_init_enet_param_shadow->rgftgfrxglobal |=
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2802  	    ((u32) ug_info->numThreadsTx) << ENET_INIT_PARAM_TGF_SHIFT;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2803  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2804  	ugeth->p_init_enet_param_shadow->rgftgfrxglobal |=
7d9fe90036f75a drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes  2021-01-19  2805  	    rx_glbl_pram_offset | ug_info->riscRx;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2806  	if ((ug_info->largestexternallookupkeysize !=
8e95a2026f3b43 drivers/net/ucc_geth.c                    Joe Perches       2009-12-03  2807  	     QE_FLTR_LARGEST_EXTERNAL_TABLE_LOOKUP_KEY_SIZE_NONE) &&
8e95a2026f3b43 drivers/net/ucc_geth.c                    Joe Perches       2009-12-03  2808  	    (ug_info->largestexternallookupkeysize !=
8e95a2026f3b43 drivers/net/ucc_geth.c                    Joe Perches       2009-12-03  2809  	     QE_FLTR_LARGEST_EXTERNAL_TABLE_LOOKUP_KEY_SIZE_8_BYTES) &&
8e95a2026f3b43 drivers/net/ucc_geth.c                    Joe Perches       2009-12-03  2810  	    (ug_info->largestexternallookupkeysize !=
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2811  	     QE_FLTR_LARGEST_EXTERNAL_TABLE_LOOKUP_KEY_SIZE_16_BYTES)) {
890de95e8fe617 drivers/net/ucc_geth.c                    Li Yang           2007-07-19  2812  		if (netif_msg_ifup(ugeth))
c84d8055e0c997 drivers/net/ethernet/freescale/ucc_geth.c Joe Perches       2013-04-13  2813  			pr_err("Invalid largest External Lookup Key Size\n");
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2814  		return -EINVAL;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2815  	}
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2816  	ugeth->p_init_enet_param_shadow->largestexternallookupkeysize =
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2817  	    ug_info->largestexternallookupkeysize;
18a8e8649d2687 drivers/net/ucc_geth.c                    Li Yang           2006-10-19  2818  	size = sizeof(struct ucc_geth_thread_rx_pram);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2819  	if (ug_info->rxExtendedFiltering) {
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2820  		size += THREAD_RX_PRAM_ADDITIONAL_FOR_EXTENDED_FILTERING;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2821  		if (ug_info->largestexternallookupkeysize ==
8844a00626c78c drivers/net/ethernet/freescale/ucc_geth.c Zhao Qiang        2014-07-01  2822  		    QE_FLTR_LARGEST_EXTERNAL_TABLE_LOOKUP_KEY_SIZE_8_BYTES)
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2823  			size +=
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2824  			    THREAD_RX_PRAM_ADDITIONAL_FOR_EXTENDED_FILTERING_8;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2825  		if (ug_info->largestexternallookupkeysize ==
8844a00626c78c drivers/net/ethernet/freescale/ucc_geth.c Zhao Qiang        2014-07-01  2826  		    QE_FLTR_LARGEST_EXTERNAL_TABLE_LOOKUP_KEY_SIZE_16_BYTES)
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2827  			size +=
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2828  			    THREAD_RX_PRAM_ADDITIONAL_FOR_EXTENDED_FILTERING_16;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2829  	}
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2830  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2831  	if ((ret_val = fill_init_enet_entries(ugeth, &(ugeth->
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2832  		p_init_enet_param_shadow->rxthread[0]),
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2833  		(u8) (numThreadsRxNumerical + 1)
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2834  		/* Rx needs one extra for terminator */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2835  		, size, UCC_GETH_THREAD_RX_PRAM_ALIGNMENT,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2836  		ug_info->riscRx, 1)) != 0) {
890de95e8fe617 drivers/net/ucc_geth.c                    Li Yang           2007-07-19  2837  		if (netif_msg_ifup(ugeth))
c84d8055e0c997 drivers/net/ethernet/freescale/ucc_geth.c Joe Perches       2013-04-13  2838  			pr_err("Can not fill p_init_enet_param_shadow\n");
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2839  		return ret_val;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2840  	}
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2841  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2842  	ugeth->p_init_enet_param_shadow->txglobal =
7d9fe90036f75a drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes  2021-01-19  2843  	    tx_glbl_pram_offset | ug_info->riscTx;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2844  	if ((ret_val =
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2845  	     fill_init_enet_entries(ugeth,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2846  				    &(ugeth->p_init_enet_param_shadow->
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2847  				      txthread[0]), numThreadsTxNumerical,
18a8e8649d2687 drivers/net/ucc_geth.c                    Li Yang           2006-10-19  2848  				    sizeof(struct ucc_geth_thread_tx_pram),
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2849  				    UCC_GETH_THREAD_TX_PRAM_ALIGNMENT,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2850  				    ug_info->riscTx, 0)) != 0) {
890de95e8fe617 drivers/net/ucc_geth.c                    Li Yang           2007-07-19  2851  		if (netif_msg_ifup(ugeth))
c84d8055e0c997 drivers/net/ethernet/freescale/ucc_geth.c Joe Perches       2013-04-13  2852  			pr_err("Can not fill p_init_enet_param_shadow\n");
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2853  		return ret_val;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2854  	}
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2855  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2856  	/* Load Rx bds with buffers */
53f49d86ea2108 drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes  2021-01-19  2857  	for (i = 0; i < ucc_geth_rx_queues(ug_info); i++) {
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2858  		if ((ret_val = rx_bd_buffer_set(ugeth, (u8) i)) != 0) {
890de95e8fe617 drivers/net/ucc_geth.c                    Li Yang           2007-07-19  2859  			if (netif_msg_ifup(ugeth))
c84d8055e0c997 drivers/net/ethernet/freescale/ucc_geth.c Joe Perches       2013-04-13  2860  				pr_err("Can not fill Rx bds with buffers\n");
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2861  			return ret_val;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2862  		}
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2863  	}
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2864  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2865  	/* Allocate InitEnet command parameter structure */
18a8e8649d2687 drivers/net/ucc_geth.c                    Li Yang           2006-10-19  2866  	init_enet_pram_offset = qe_muram_alloc(sizeof(struct ucc_geth_init_pram), 4);
4c35630ccda56e drivers/net/ucc_geth.c                    Timur Tabi        2007-05-08  2867  	if (IS_ERR_VALUE(init_enet_pram_offset)) {
890de95e8fe617 drivers/net/ucc_geth.c                    Li Yang           2007-07-19  2868  		if (netif_msg_ifup(ugeth))
c84d8055e0c997 drivers/net/ethernet/freescale/ucc_geth.c Joe Perches       2013-04-13  2869  			pr_err("Can not allocate DPRAM memory for p_init_enet_pram\n");
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2870  		return -ENOMEM;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2871  	}
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2872  	p_init_enet_pram =
6fee40e9b8155a drivers/net/ucc_geth.c                    Andy Fleming      2008-05-02  2873  	    (struct ucc_geth_init_pram __iomem *) qe_muram_addr(init_enet_pram_offset);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2874  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2875  	/* Copy shadow InitEnet command parameter structure into PRAM */
6fee40e9b8155a drivers/net/ucc_geth.c                    Andy Fleming      2008-05-02  2876  	out_8(&p_init_enet_pram->resinit1,
6fee40e9b8155a drivers/net/ucc_geth.c                    Andy Fleming      2008-05-02  2877  			ugeth->p_init_enet_param_shadow->resinit1);
6fee40e9b8155a drivers/net/ucc_geth.c                    Andy Fleming      2008-05-02  2878  	out_8(&p_init_enet_pram->resinit2,
6fee40e9b8155a drivers/net/ucc_geth.c                    Andy Fleming      2008-05-02  2879  			ugeth->p_init_enet_param_shadow->resinit2);
6fee40e9b8155a drivers/net/ucc_geth.c                    Andy Fleming      2008-05-02  2880  	out_8(&p_init_enet_pram->resinit3,
6fee40e9b8155a drivers/net/ucc_geth.c                    Andy Fleming      2008-05-02  2881  			ugeth->p_init_enet_param_shadow->resinit3);
6fee40e9b8155a drivers/net/ucc_geth.c                    Andy Fleming      2008-05-02  2882  	out_8(&p_init_enet_pram->resinit4,
6fee40e9b8155a drivers/net/ucc_geth.c                    Andy Fleming      2008-05-02  2883  			ugeth->p_init_enet_param_shadow->resinit4);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2884  	out_be16(&p_init_enet_pram->resinit5,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2885  		 ugeth->p_init_enet_param_shadow->resinit5);
6fee40e9b8155a drivers/net/ucc_geth.c                    Andy Fleming      2008-05-02  2886  	out_8(&p_init_enet_pram->largestexternallookupkeysize,
6fee40e9b8155a drivers/net/ucc_geth.c                    Andy Fleming      2008-05-02  2887  	    ugeth->p_init_enet_param_shadow->largestexternallookupkeysize);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2888  	out_be32(&p_init_enet_pram->rgftgfrxglobal,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2889  		 ugeth->p_init_enet_param_shadow->rgftgfrxglobal);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2890  	for (i = 0; i < ENET_INIT_PARAM_MAX_ENTRIES_RX; i++)
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2891  		out_be32(&p_init_enet_pram->rxthread[i],
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2892  			 ugeth->p_init_enet_param_shadow->rxthread[i]);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2893  	out_be32(&p_init_enet_pram->txglobal,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2894  		 ugeth->p_init_enet_param_shadow->txglobal);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2895  	for (i = 0; i < ENET_INIT_PARAM_MAX_ENTRIES_TX; i++)
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2896  		out_be32(&p_init_enet_pram->txthread[i],
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2897  			 ugeth->p_init_enet_param_shadow->txthread[i]);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2898  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2899  	/* Issue QE command */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2900  	cecr_subblock =
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2901  	    ucc_fast_get_qe_cr_subblock(ugeth->ug_info->uf_info.ucc_num);
18a8e8649d2687 drivers/net/ucc_geth.c                    Li Yang           2006-10-19  2902  	qe_issue_cmd(command, cecr_subblock, QE_CR_PROTOCOL_ETHERNET,
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2903  		     init_enet_pram_offset);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2904  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2905  	/* Free InitEnet command parameter */
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2906  	qe_muram_free(init_enet_pram_offset);
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2907  
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2908  	return 0;
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2909  }
ce973b141dfac4 drivers/net/ucc_geth.c                    Li Yang           2006-08-14  2910  

:::::: The code at line 2454 was first introduced by commit
:::::: ce973b141dfac4a0f160c7435d65e3ea47753ce8 [PATCH] Freescale QE UCC gigabit ethernet driver

:::::: TO: Li Yang <leoli@freescale.com>
:::::: CC: Jeff Garzik <jeff@garzik.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
