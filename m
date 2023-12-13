Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F4F8090A1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443771AbjLGSnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 13:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443763AbjLGSnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 13:43:41 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D139B171B
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 10:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701974625; x=1733510625;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jJJ6Fe6KdSpWiVrI8cvk8u6sKPDsIEB6P876TLyzOEo=;
  b=eAcNGzXAa4O1xcjZxSKmK8yaODEsqtkSG8utvnISndyXprTx+Ykfq47i
   KunMizBumYf6JuHcT91rlLy3V2ZdeN9AIFM3t1CHSweMOfUFIS9y7bXMF
   S7rmTSuV+w4s5B41IUTNmzygkMFwXdk0mLnQH4ph2YjLSlH1GhjC9Hfua
   slrO0CIyc8AtKsg/XeNgecK/7uTK/2gi8h261vJRHsPcW3E3/TYA0OvCZ
   qBXvxQw78eDTq6Qnt8+Fxd6YT1RI+ZSKMn32Du6c4uJpd7P1lLts9HRsr
   BlKkmRcxkw+g7XHUnsOdcHT8g64GpmsQpTyic6ZeRmofdKZuZFeC+xXP6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="480476366"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="480476366"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 10:43:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="806113509"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="806113509"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 07 Dec 2023 10:43:43 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rBJLY-000CgJ-2C;
        Thu, 07 Dec 2023 18:43:40 +0000
Date:   Fri, 8 Dec 2023 02:43:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: drivers/i2c/busses/i2c-cpm.c:661:58: sparse: sparse: incorrect type
 in argument 1 (different base types)
Message-ID: <202312080225.z4UrXocp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
commit: eb5aa2137275da82052586f9bd405a1358b48139 powerpc/82xx: Remove CONFIG_8260 and CONFIG_8272
date:   4 months ago
config: powerpc-randconfig-r131-20231118 (https://download.01.org/0day-ci/archive/20231208/202312080225.z4UrXocp-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231208/202312080225.z4UrXocp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312080225.z4UrXocp-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/i2c/busses/i2c-cpm.c:661:58: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __be32 const [usertype] *p @@     got unsigned int const [usertype] *[assigned] data @@
   drivers/i2c/busses/i2c-cpm.c:661:58: sparse:     expected restricted __be32 const [usertype] *p
   drivers/i2c/busses/i2c-cpm.c:661:58: sparse:     got unsigned int const [usertype] *[assigned] data
--
   drivers/soc/fsl/qe/qmc.c:334:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cpm_buf_desc [usertype] *[noderef] __iomem bd @@     got struct cpm_buf_desc [noderef] [usertype] __iomem *txbd_free @@
   drivers/soc/fsl/qe/qmc.c:334:12: sparse:     expected struct cpm_buf_desc [usertype] *[noderef] __iomem bd
   drivers/soc/fsl/qe/qmc.c:334:12: sparse:     got struct cpm_buf_desc [noderef] [usertype] __iomem *txbd_free
   drivers/soc/fsl/qe/qmc.c:346:39: sparse: sparse: subtraction of different types can't work (different address spaces)
   drivers/soc/fsl/qe/qmc.c:389:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cpm_buf_desc [usertype] *[noderef] __iomem bd @@     got struct cpm_buf_desc [noderef] [usertype] __iomem *txbd_done @@
   drivers/soc/fsl/qe/qmc.c:389:12: sparse:     expected struct cpm_buf_desc [usertype] *[noderef] __iomem bd
   drivers/soc/fsl/qe/qmc.c:389:12: sparse:     got struct cpm_buf_desc [noderef] [usertype] __iomem *txbd_done
   drivers/soc/fsl/qe/qmc.c:396:47: sparse: sparse: subtraction of different types can't work (different address spaces)
   drivers/soc/fsl/qe/qmc.c:441:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cpm_buf_desc [usertype] *[noderef] __iomem bd @@     got struct cpm_buf_desc [noderef] [usertype] __iomem *rxbd_free @@
   drivers/soc/fsl/qe/qmc.c:453:39: sparse: sparse: subtraction of different types can't work (different address spaces)
   drivers/soc/fsl/qe/qmc.c:505:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cpm_buf_desc [usertype] *[noderef] __iomem bd @@     got struct cpm_buf_desc [noderef] [usertype] __iomem *rxbd_done @@
   drivers/soc/fsl/qe/qmc.c:505:12: sparse:     expected struct cpm_buf_desc [usertype] *[noderef] __iomem bd
   drivers/soc/fsl/qe/qmc.c:505:12: sparse:     got struct cpm_buf_desc [noderef] [usertype] __iomem *rxbd_done
   drivers/soc/fsl/qe/qmc.c:512:47: sparse: sparse: subtraction of different types can't work (different address spaces)
   drivers/soc/fsl/qe/qmc.c:670:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cpm_buf_desc [usertype] *[noderef] __iomem bd @@     got struct cpm_buf_desc [noderef] [usertype] __iomem *rxbds @@
   drivers/soc/fsl/qe/qmc.c:675:47: sparse: sparse: subtraction of different types can't work (different address spaces)
   drivers/soc/fsl/qe/qmc.c:705:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cpm_buf_desc [usertype] *[noderef] __iomem bd @@     got struct cpm_buf_desc [noderef] [usertype] __iomem *txbds @@
   drivers/soc/fsl/qe/qmc.c:705:12: sparse:     expected struct cpm_buf_desc [usertype] *[noderef] __iomem bd
   drivers/soc/fsl/qe/qmc.c:705:12: sparse:     got struct cpm_buf_desc [noderef] [usertype] __iomem *txbds
   drivers/soc/fsl/qe/qmc.c:710:47: sparse: sparse: subtraction of different types can't work (different address spaces)
   drivers/soc/fsl/qe/qmc.c:1108:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *[noderef] __iomem addr @@     got unsigned short [noderef] __iomem * @@
   drivers/soc/fsl/qe/qmc.c:1108:30: sparse:     expected void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1108:30: sparse:     got unsigned short [noderef] __iomem *
   drivers/soc/fsl/qe/qmc.c:1111:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *[noderef] __iomem addr @@     got unsigned short [noderef] __iomem * @@
   drivers/soc/fsl/qe/qmc.c:1111:22: sparse:     expected void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1111:22: sparse:     got unsigned short [noderef] __iomem *
   drivers/soc/fsl/qe/qmc.c:1120:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *[noderef] __iomem addr @@     got unsigned short [noderef] __iomem * @@
   drivers/soc/fsl/qe/qmc.c:1120:30: sparse:     expected void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1120:30: sparse:     got unsigned short [noderef] __iomem *
   drivers/soc/fsl/qe/qmc.c:1123:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *[noderef] __iomem addr @@     got unsigned short [noderef] __iomem * @@
   drivers/soc/fsl/qe/qmc.c:1123:22: sparse:     expected void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1123:22: sparse:     got unsigned short [noderef] __iomem *
   drivers/soc/fsl/qe/qmc.c:1176:44: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *[noderef] __iomem addr @@     got unsigned short [noderef] [usertype] __iomem * @@
   drivers/soc/fsl/qe/qmc.c:1176:44: sparse:     expected void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1176:44: sparse:     got unsigned short [noderef] [usertype] __iomem *
   drivers/soc/fsl/qe/qmc.c:1181:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *[noderef] __iomem addr @@     got unsigned short [noderef] [usertype] __iomem *[assigned] last @@
   drivers/soc/fsl/qe/qmc.c:1181:29: sparse:     expected void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1181:29: sparse:     got unsigned short [noderef] [usertype] __iomem *[assigned] last
   drivers/soc/fsl/qe/qmc.c:1194:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *[noderef] __iomem addr @@     got unsigned short [noderef] [usertype] __iomem *int_curr @@
   drivers/soc/fsl/qe/qmc.c:1194:35: sparse:     expected void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1194:35: sparse:     got unsigned short [noderef] [usertype] __iomem *int_curr
   drivers/soc/fsl/qe/qmc.c:1197:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *[noderef] __iomem addr @@     got unsigned short [noderef] [usertype] __iomem *int_curr @@
   drivers/soc/fsl/qe/qmc.c:1197:32: sparse:     expected void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1197:32: sparse:     got unsigned short [noderef] [usertype] __iomem *int_curr
   drivers/soc/fsl/qe/qmc.c:1242:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *[noderef] __iomem addr @@     got unsigned short [noderef] [usertype] __iomem *int_curr @@
   drivers/soc/fsl/qe/qmc.c:1242:43: sparse:     expected void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1242:43: sparse:     got unsigned short [noderef] [usertype] __iomem *int_curr
   drivers/soc/fsl/qe/qmc.c:1286:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[noderef] scc_regs @@     got void [noderef] __iomem * @@
   drivers/soc/fsl/qe/qmc.c:1286:23: sparse:     expected void *[noderef] scc_regs
   drivers/soc/fsl/qe/qmc.c:1286:23: sparse:     got void [noderef] __iomem *
   drivers/soc/fsl/qe/qmc.c:1295:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[noderef] scc_pram @@     got void [noderef] __iomem * @@
   drivers/soc/fsl/qe/qmc.c:1295:23: sparse:     expected void *[noderef] scc_pram
   drivers/soc/fsl/qe/qmc.c:1295:23: sparse:     got void [noderef] __iomem *
   drivers/soc/fsl/qe/qmc.c:1299:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[noderef] dpram @@     got void [noderef] __iomem * @@
   drivers/soc/fsl/qe/qmc.c:1299:21: sparse:     expected void *[noderef] dpram
   drivers/soc/fsl/qe/qmc.c:1299:21: sparse:     got void [noderef] __iomem *
   drivers/soc/fsl/qe/qmc.c:1335:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cpm_buf_desc [noderef] [usertype] __iomem *bd_table @@     got void * @@
   drivers/soc/fsl/qe/qmc.c:1335:23: sparse:     expected struct cpm_buf_desc [noderef] [usertype] __iomem *bd_table
   drivers/soc/fsl/qe/qmc.c:1335:23: sparse:     got void *
>> drivers/soc/fsl/qe/qmc.c:1342:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got struct cpm_buf_desc [noderef] [usertype] __iomem *bd_table @@
   drivers/soc/fsl/qe/qmc.c:1342:9: sparse:     expected void const *
   drivers/soc/fsl/qe/qmc.c:1342:9: sparse:     got struct cpm_buf_desc [noderef] [usertype] __iomem *bd_table
>> drivers/soc/fsl/qe/qmc.c:1342:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got struct cpm_buf_desc [noderef] [usertype] __iomem *bd_table @@
   drivers/soc/fsl/qe/qmc.c:1342:9: sparse:     expected void const *
   drivers/soc/fsl/qe/qmc.c:1342:9: sparse:     got struct cpm_buf_desc [noderef] [usertype] __iomem *bd_table
   drivers/soc/fsl/qe/qmc.c:1342:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got struct cpm_buf_desc [noderef] [usertype] __iomem *bd_table @@
   drivers/soc/fsl/qe/qmc.c:1342:9: sparse:     expected void *
   drivers/soc/fsl/qe/qmc.c:1342:9: sparse:     got struct cpm_buf_desc [noderef] [usertype] __iomem *bd_table
   drivers/soc/fsl/qe/qmc.c:1348:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] [usertype] __iomem *int_table @@     got void * @@
   drivers/soc/fsl/qe/qmc.c:1348:24: sparse:     expected unsigned short [noderef] [usertype] __iomem *int_table
   drivers/soc/fsl/qe/qmc.c:1348:24: sparse:     got void *
>> drivers/soc/fsl/qe/qmc.c:1355:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned short [noderef] [usertype] __iomem *int_table @@
   drivers/soc/fsl/qe/qmc.c:1355:9: sparse:     expected void const *
   drivers/soc/fsl/qe/qmc.c:1355:9: sparse:     got unsigned short [noderef] [usertype] __iomem *int_table
>> drivers/soc/fsl/qe/qmc.c:1355:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned short [noderef] [usertype] __iomem *int_table @@
   drivers/soc/fsl/qe/qmc.c:1355:9: sparse:     expected void const *
   drivers/soc/fsl/qe/qmc.c:1355:9: sparse:     got unsigned short [noderef] [usertype] __iomem *int_table
   drivers/soc/fsl/qe/qmc.c:1355:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got unsigned short [noderef] [usertype] __iomem *int_table @@
   drivers/soc/fsl/qe/qmc.c:1355:9: sparse:     expected void *
   drivers/soc/fsl/qe/qmc.c:1355:9: sparse:     got unsigned short [noderef] [usertype] __iomem *int_table
   drivers/soc/fsl/qe/qmc.c:290:33: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:290:33: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:292:29: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:292:29: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:295:39: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:295:39: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:233:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:233:38: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     expected void const [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:233:38: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:233:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:233:38: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:298:39: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:298:39: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:238:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:238:38: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     expected void const [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:238:38: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:238:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:238:38: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:304:29: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:304:29: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:336:28: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     expected void const [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:336:28: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:343:22: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:343:22: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:344:22: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:344:22: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:346:36: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:353:22: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:353:22: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:356:31: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:356:31: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:233:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:233:38: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     expected void const [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:233:38: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression

vim +661 drivers/i2c/busses/i2c-cpm.c

61045dbe9d8d81 Jochen Friedrich 2008-07-14  632  
0b255e927d47b5 Bill Pemberton   2012-11-27  633  static int cpm_i2c_probe(struct platform_device *ofdev)
61045dbe9d8d81 Jochen Friedrich 2008-07-14  634  {
61045dbe9d8d81 Jochen Friedrich 2008-07-14  635  	int result, len;
61045dbe9d8d81 Jochen Friedrich 2008-07-14  636  	struct cpm_i2c *cpm;
61045dbe9d8d81 Jochen Friedrich 2008-07-14  637  	const u32 *data;
61045dbe9d8d81 Jochen Friedrich 2008-07-14  638  
61045dbe9d8d81 Jochen Friedrich 2008-07-14  639  	cpm = kzalloc(sizeof(struct cpm_i2c), GFP_KERNEL);
61045dbe9d8d81 Jochen Friedrich 2008-07-14  640  	if (!cpm)
61045dbe9d8d81 Jochen Friedrich 2008-07-14  641  		return -ENOMEM;
61045dbe9d8d81 Jochen Friedrich 2008-07-14  642  
61045dbe9d8d81 Jochen Friedrich 2008-07-14  643  	cpm->ofdev = ofdev;
61045dbe9d8d81 Jochen Friedrich 2008-07-14  644  
c2c64954723b9d Jingoo Han       2013-05-23  645  	platform_set_drvdata(ofdev, cpm);
61045dbe9d8d81 Jochen Friedrich 2008-07-14  646  
61045dbe9d8d81 Jochen Friedrich 2008-07-14  647  	cpm->adap = cpm_ops;
61045dbe9d8d81 Jochen Friedrich 2008-07-14  648  	i2c_set_adapdata(&cpm->adap, cpm);
61045dbe9d8d81 Jochen Friedrich 2008-07-14  649  	cpm->adap.dev.parent = &ofdev->dev;
9fd049927ccba1 Grant Likely     2010-06-08  650  	cpm->adap.dev.of_node = of_node_get(ofdev->dev.of_node);
61045dbe9d8d81 Jochen Friedrich 2008-07-14  651  
61045dbe9d8d81 Jochen Friedrich 2008-07-14  652  	result = cpm_i2c_setup(cpm);
61045dbe9d8d81 Jochen Friedrich 2008-07-14  653  	if (result) {
61045dbe9d8d81 Jochen Friedrich 2008-07-14  654  		dev_err(&ofdev->dev, "Unable to init hardware\n");
61045dbe9d8d81 Jochen Friedrich 2008-07-14  655  		goto out_free;
61045dbe9d8d81 Jochen Friedrich 2008-07-14  656  	}
61045dbe9d8d81 Jochen Friedrich 2008-07-14  657  
61045dbe9d8d81 Jochen Friedrich 2008-07-14  658  	/* register new adapter to i2c module... */
61045dbe9d8d81 Jochen Friedrich 2008-07-14  659  
61c7a080a5a061 Grant Likely     2010-04-13  660  	data = of_get_property(ofdev->dev.of_node, "linux,i2c-index", &len);
488bf314bf219c Grant Likely     2011-07-25 @661  	cpm->adap.nr = (data && len == 4) ? be32_to_cpup(data) : -1;
61045dbe9d8d81 Jochen Friedrich 2008-07-14  662  	result = i2c_add_numbered_adapter(&cpm->adap);
61045dbe9d8d81 Jochen Friedrich 2008-07-14  663  
ea734404f3daf1 Wolfram Sang     2016-08-09  664  	if (result < 0)
61045dbe9d8d81 Jochen Friedrich 2008-07-14  665  		goto out_shut;
61045dbe9d8d81 Jochen Friedrich 2008-07-14  666  
61045dbe9d8d81 Jochen Friedrich 2008-07-14  667  	dev_dbg(&ofdev->dev, "hw routines for %s registered.\n",
61045dbe9d8d81 Jochen Friedrich 2008-07-14  668  		cpm->adap.name);
61045dbe9d8d81 Jochen Friedrich 2008-07-14  669  
61045dbe9d8d81 Jochen Friedrich 2008-07-14  670  	return 0;
61045dbe9d8d81 Jochen Friedrich 2008-07-14  671  out_shut:
61045dbe9d8d81 Jochen Friedrich 2008-07-14  672  	cpm_i2c_shutdown(cpm);
61045dbe9d8d81 Jochen Friedrich 2008-07-14  673  out_free:
61045dbe9d8d81 Jochen Friedrich 2008-07-14  674  	kfree(cpm);
61045dbe9d8d81 Jochen Friedrich 2008-07-14  675  
61045dbe9d8d81 Jochen Friedrich 2008-07-14  676  	return result;
61045dbe9d8d81 Jochen Friedrich 2008-07-14  677  }
61045dbe9d8d81 Jochen Friedrich 2008-07-14  678  

:::::: The code at line 661 was first introduced by commit
:::::: 488bf314bf219c66922305a1a320950efa86662f i2c: Allow i2c_add_numbered_adapter() to assign a bus id

:::::: TO: Grant Likely <grant.likely@secretlab.ca>
:::::: CC: Jean Delvare <khali@endymion.delvare>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
