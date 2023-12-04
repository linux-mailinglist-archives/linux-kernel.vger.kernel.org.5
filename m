Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945FC804055
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbjLDUo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235556AbjLDUoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:44:46 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0B8136
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701722613; x=1733258613;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rrkVsWwVuZEpj1Ucy+j+quLwOGu4nWFIXsNGgsyStmQ=;
  b=AVC3BwPdVnJMGd+qnaqIBRiNMy/iv7DGt3GbssPOsVZazvA9k+lKCEvX
   ciN0nleRmD2sIYCVWdkPvi7P5F3zJVgcIjLCb60Oaf9gndJ2tfjQqfRoB
   hKft0zABrpJkvueBR7IfEXIsgHZaS/UJClc3vu4hL/xWl6UAh0UGwxfEl
   B4/h16gHFeJmGUsQYbGIY0pWxn1PhcsIoiv9czBRFeQAsC+uU1llV3IjT
   BSpj8g7ciIHFn0M7efsJEZaI+i3bztpQjXAaPMvizIP179EppiowBMKtp
   oNrgzh0r+EreXrV6iJxP8dOBXX/Pgq350wfOR4WdMRwPlx5xModz/nqLD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="392664368"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="392664368"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 12:43:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="764088178"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="764088178"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 04 Dec 2023 12:43:29 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAFmo-00084e-37;
        Mon, 04 Dec 2023 20:43:26 +0000
Date:   Tue, 5 Dec 2023 04:42:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: drivers/soc/fsl/qe/tsa.c:663:22: sparse: sparse: incorrect type in
 assignment (different address spaces)
Message-ID: <202312050410.yt3T9JRK-lkp@intel.com>
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

Hi Christophe,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   33cc938e65a98f1d29d0a18403dbbee050dcad9a
commit: eb5aa2137275da82052586f9bd405a1358b48139 powerpc/82xx: Remove CONFIG_8260 and CONFIG_8272
date:   4 months ago
config: powerpc-randconfig-r121-20231107 (https://download.01.org/0day-ci/archive/20231205/202312050410.yt3T9JRK-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231205/202312050410.yt3T9JRK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312050410.yt3T9JRK-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/soc/fsl/qe/tsa.c:663:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[noderef] si_regs @@     got void [noderef] __iomem * @@
   drivers/soc/fsl/qe/tsa.c:663:22: sparse:     expected void *[noderef] si_regs
   drivers/soc/fsl/qe/tsa.c:663:22: sparse:     got void [noderef] __iomem *
>> drivers/soc/fsl/qe/tsa.c:673:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[noderef] si_ram @@     got void [noderef] __iomem * @@
   drivers/soc/fsl/qe/tsa.c:673:21: sparse:     expected void *[noderef] si_ram
   drivers/soc/fsl/qe/tsa.c:673:21: sparse:     got void [noderef] __iomem *
>> drivers/soc/fsl/qe/tsa.c:189:26: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/tsa.c:189:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:160:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:160:39: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/tsa.c:150:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/tsa.c:150:27: sparse:     expected void const [noderef] __iomem *addr
   drivers/soc/fsl/qe/tsa.c:150:27: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/tsa.c:160:39: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:150:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:150:27: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/tsa.c:140:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/tsa.c:140:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/tsa.c:140:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/tsa.c:160:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:160:39: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:150:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:140:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:140:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:218:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:218:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:160:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:160:39: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/tsa.c:150:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/tsa.c:150:27: sparse:     expected void const [noderef] __iomem *addr
   drivers/soc/fsl/qe/tsa.c:150:27: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/tsa.c:160:39: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:150:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:150:27: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/tsa.c:140:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/tsa.c:140:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/tsa.c:140:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/tsa.c:160:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:160:39: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:150:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:140:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:140:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:245:25: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:245:47: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:246:25: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:246:46: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:247:25: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:250:25: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:250:47: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:251:25: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:251:46: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:252:25: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:259:33: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:259:55: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:260:33: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:260:54: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:261:33: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:264:33: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:264:55: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:265:33: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:265:54: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:266:33: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:271:33: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:271:55: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:272:33: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:272:54: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:273:33: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:276:33: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:276:55: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:277:33: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:277:54: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:278:33: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:322:9: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:322:16: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:322:35: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:322:58: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:325:14: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:325:33: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:330:13: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:332:31: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:332:31: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:155:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:155:38: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/tsa.c:150:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/tsa.c:150:27: sparse:     expected void const [noderef] __iomem *addr
   drivers/soc/fsl/qe/tsa.c:150:27: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/tsa.c:155:38: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:150:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:150:27: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/tsa.c:140:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/tsa.c:140:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/tsa.c:140:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/tsa.c:155:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:155:38: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:150:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:140:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:140:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:344:25: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:344:44: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:348:29: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/tsa.c:140:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/tsa.c:140:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/tsa.c:140:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/tsa.c:348:29: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:140:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:140:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:349:17: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:640:29: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/tsa.c:140:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/tsa.c:140:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/tsa.c:140:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/tsa.c:640:29: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:140:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:140:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:664:20: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:664:20: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:665:32: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:665:32: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:674:20: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:674:20: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:675:32: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:675:32: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:690:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:690:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:160:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:160:39: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/tsa.c:150:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/tsa.c:150:27: sparse:     expected void const [noderef] __iomem *addr
   drivers/soc/fsl/qe/tsa.c:150:27: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/tsa.c:160:39: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:150:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:150:27: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/tsa.c:140:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/tsa.c:140:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/tsa.c:140:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/tsa.c:160:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:160:39: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:150:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:140:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:140:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:702:20: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:145:23: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/tsa.c:145:23: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/soc/fsl/qe/tsa.c:145:23: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/tsa.c:702:20: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:145:23: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/tsa.c:145:23: sparse: sparse: dereference of noderef expression
--
>> drivers/soc/fsl/qe/qmc.c:334:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cpm_buf_desc [usertype] *[noderef] __iomem bd @@     got struct cpm_buf_desc [noderef] [usertype] __iomem *txbd_free @@
   drivers/soc/fsl/qe/qmc.c:334:12: sparse:     expected struct cpm_buf_desc [usertype] *[noderef] __iomem bd
   drivers/soc/fsl/qe/qmc.c:334:12: sparse:     got struct cpm_buf_desc [noderef] [usertype] __iomem *txbd_free
>> drivers/soc/fsl/qe/qmc.c:346:39: sparse: sparse: subtraction of different types can't work (different address spaces)
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
>> drivers/soc/fsl/qe/qmc.c:1108:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *[noderef] __iomem addr @@     got unsigned short [noderef] __iomem * @@
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
>> drivers/soc/fsl/qe/qmc.c:1176:44: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *[noderef] __iomem addr @@     got unsigned short [noderef] [usertype] __iomem * @@
   drivers/soc/fsl/qe/qmc.c:1176:44: sparse:     expected void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1176:44: sparse:     got unsigned short [noderef] [usertype] __iomem *
>> drivers/soc/fsl/qe/qmc.c:1181:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *[noderef] __iomem addr @@     got unsigned short [noderef] [usertype] __iomem *[assigned] last @@
   drivers/soc/fsl/qe/qmc.c:1181:29: sparse:     expected void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1181:29: sparse:     got unsigned short [noderef] [usertype] __iomem *[assigned] last
>> drivers/soc/fsl/qe/qmc.c:1194:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *[noderef] __iomem addr @@     got unsigned short [noderef] [usertype] __iomem *int_curr @@
   drivers/soc/fsl/qe/qmc.c:1194:35: sparse:     expected void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1194:35: sparse:     got unsigned short [noderef] [usertype] __iomem *int_curr
   drivers/soc/fsl/qe/qmc.c:1197:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *[noderef] __iomem addr @@     got unsigned short [noderef] [usertype] __iomem *int_curr @@
   drivers/soc/fsl/qe/qmc.c:1197:32: sparse:     expected void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1197:32: sparse:     got unsigned short [noderef] [usertype] __iomem *int_curr
   drivers/soc/fsl/qe/qmc.c:1242:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *[noderef] __iomem addr @@     got unsigned short [noderef] [usertype] __iomem *int_curr @@
   drivers/soc/fsl/qe/qmc.c:1242:43: sparse:     expected void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1242:43: sparse:     got unsigned short [noderef] [usertype] __iomem *int_curr
>> drivers/soc/fsl/qe/qmc.c:1286:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[noderef] scc_regs @@     got void [noderef] __iomem * @@
   drivers/soc/fsl/qe/qmc.c:1286:23: sparse:     expected void *[noderef] scc_regs
   drivers/soc/fsl/qe/qmc.c:1286:23: sparse:     got void [noderef] __iomem *
>> drivers/soc/fsl/qe/qmc.c:1295:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[noderef] scc_pram @@     got void [noderef] __iomem * @@
   drivers/soc/fsl/qe/qmc.c:1295:23: sparse:     expected void *[noderef] scc_pram
   drivers/soc/fsl/qe/qmc.c:1295:23: sparse:     got void [noderef] __iomem *
>> drivers/soc/fsl/qe/qmc.c:1299:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[noderef] dpram @@     got void [noderef] __iomem * @@
   drivers/soc/fsl/qe/qmc.c:1299:21: sparse:     expected void *[noderef] dpram
   drivers/soc/fsl/qe/qmc.c:1299:21: sparse:     got void [noderef] __iomem *
>> drivers/soc/fsl/qe/qmc.c:1335:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cpm_buf_desc [noderef] [usertype] __iomem *bd_table @@     got void * @@
   drivers/soc/fsl/qe/qmc.c:1335:23: sparse:     expected struct cpm_buf_desc [noderef] [usertype] __iomem *bd_table
   drivers/soc/fsl/qe/qmc.c:1335:23: sparse:     got void *
>> drivers/soc/fsl/qe/qmc.c:1342:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got struct cpm_buf_desc [noderef] [usertype] __iomem *bd_table @@
   drivers/soc/fsl/qe/qmc.c:1342:19: sparse:     expected void *
   drivers/soc/fsl/qe/qmc.c:1342:19: sparse:     got struct cpm_buf_desc [noderef] [usertype] __iomem *bd_table
>> drivers/soc/fsl/qe/qmc.c:1348:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] [usertype] __iomem *int_table @@     got void * @@
   drivers/soc/fsl/qe/qmc.c:1348:24: sparse:     expected unsigned short [noderef] [usertype] __iomem *int_table
   drivers/soc/fsl/qe/qmc.c:1348:24: sparse:     got void *
>> drivers/soc/fsl/qe/qmc.c:1355:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got unsigned short [noderef] [usertype] __iomem *int_table @@
   drivers/soc/fsl/qe/qmc.c:1355:19: sparse:     expected void *
   drivers/soc/fsl/qe/qmc.c:1355:19: sparse:     got unsigned short [noderef] [usertype] __iomem *int_table
>> drivers/soc/fsl/qe/qmc.c:290:33: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
>> drivers/soc/fsl/qe/qmc.c:290:33: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:292:29: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:292:29: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:295:39: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:295:39: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:233:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:233:38: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     expected void const [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:233:38: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
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
>> drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     expected void const [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:238:38: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:238:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:238:38: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:304:29: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:304:29: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:336:28: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     expected void const [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:336:28: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:343:22: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
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
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:353:22: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:356:31: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:356:31: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:233:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:233:38: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     expected void const [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:233:38: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:233:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:233:38: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:391:28: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     expected void const [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:391:28: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:396:44: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:402:30: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:402:30: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:416:36: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     expected void const [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:416:36: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:443:28: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     expected void const [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:443:28: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:450:22: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:450:22: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:451:22: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:451:22: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:453:36: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:460:22: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:460:22: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:466:37: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:466:37: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:468:37: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:468:37: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:469:29: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:469:29: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:507:28: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     expected void const [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:507:28: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:512:44: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:518:39: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     expected void const [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:518:39: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:519:30: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:519:30: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:535:36: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     expected void const [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:535:36: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:619:29: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:619:29: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:621:29: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:621:29: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:622:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:622:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:640:23: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:640:23: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:233:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:233:38: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     expected void const [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:233:38: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:233:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:233:38: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:643:23: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:643:23: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:233:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:233:38: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     expected void const [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:233:38: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:233:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:233:38: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:672:36: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     expected void const [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:672:36: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:673:30: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:673:30: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:675:44: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:679:17: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:684:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:685:32: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     expected void const [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:685:32: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:684:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:685:32: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:703:23: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:703:23: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:238:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:238:38: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     expected void const [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:238:38: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:238:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:238:38: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:707:36: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     expected void const [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:707:36: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:708:30: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:708:30: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:710:44: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:714:17: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:719:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:720:32: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     expected void const [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:720:32: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:719:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:720:32: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:723:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:723:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:724:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:724:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:912:29: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:912:29: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:922:37: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:922:37: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:927:23: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:927:23: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:233:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:233:38: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     expected void const [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:233:38: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:233:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:233:38: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:932:21: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:932:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:933:21: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:933:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:934:21: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:934:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:935:21: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:935:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:953:29: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:953:29: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:954:29: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:954:29: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:966:37: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:966:37: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:975:37: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:975:37: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:980:23: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:980:23: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:233:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:233:38: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     expected void const [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:233:38: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:233:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:233:38: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:982:23: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:982:23: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:233:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:233:38: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     expected void const [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:233:38: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:233:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:233:38: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:987:21: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:987:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:988:21: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:988:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:992:21: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:992:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:993:21: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:993:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1041:21: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1041:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1061:9: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1061:25: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1073:21: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1073:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1074:21: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1074:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1078:21: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1078:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1079:21: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1079:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1080:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1080:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1081:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1081:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1082:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1082:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1084:29: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1084:29: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1085:29: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1085:29: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1089:29: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1089:29: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1094:29: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1094:29: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1095:29: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1095:29: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1096:29: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1096:29: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1101:21: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1101:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1150:37: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1150:37: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1155:37: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1155:37: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     expected void const [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1223:53: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1223:53: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1225:53: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1225:53: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1226:45: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1226:45: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     expected void const [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1251:27: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     expected void const [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1251:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1252:21: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1252:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1287:20: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1287:20: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1288:32: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1288:32: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1296:20: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1296:20: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1297:32: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1297:32: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1300:20: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1300:20: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1301:32: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1301:32: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1324:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1324:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1328:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1328:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1344:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1344:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1358:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1358:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1359:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1359:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1362:21: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1362:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1364:21: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1364:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1365:21: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1365:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1367:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1367:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1368:21: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1368:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1374:21: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1374:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1386:21: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1386:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1387:21: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1387:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1396:21: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1396:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1404:23: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1404:23: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:253:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:253:38: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:248:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:248:27: sparse:     expected void const [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:248:27: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:253:38: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:248:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:248:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:253:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:253:38: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:248:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1411:21: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1411:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1423:23: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1423:23: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:253:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:253:38: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:248:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:248:27: sparse:     expected void const [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:248:27: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:253:38: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:248:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:248:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:253:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:253:38: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:248:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:1426:21: sparse: sparse: dereference of noderef expression
>> drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1426:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression

vim +663 drivers/soc/fsl/qe/tsa.c

1d4ba0b81c1cf2 Herve Codina 2023-02-17  642  
1d4ba0b81c1cf2 Herve Codina 2023-02-17  643  static int tsa_probe(struct platform_device *pdev)
1d4ba0b81c1cf2 Herve Codina 2023-02-17  644  {
1d4ba0b81c1cf2 Herve Codina 2023-02-17  645  	struct device_node *np = pdev->dev.of_node;
1d4ba0b81c1cf2 Herve Codina 2023-02-17  646  	struct resource *res;
1d4ba0b81c1cf2 Herve Codina 2023-02-17  647  	struct tsa *tsa;
1d4ba0b81c1cf2 Herve Codina 2023-02-17  648  	unsigned int i;
1d4ba0b81c1cf2 Herve Codina 2023-02-17  649  	u32 val;
1d4ba0b81c1cf2 Herve Codina 2023-02-17  650  	int ret;
1d4ba0b81c1cf2 Herve Codina 2023-02-17  651  
1d4ba0b81c1cf2 Herve Codina 2023-02-17  652  	tsa = devm_kzalloc(&pdev->dev, sizeof(*tsa), GFP_KERNEL);
1d4ba0b81c1cf2 Herve Codina 2023-02-17  653  	if (!tsa)
1d4ba0b81c1cf2 Herve Codina 2023-02-17  654  		return -ENOMEM;
1d4ba0b81c1cf2 Herve Codina 2023-02-17  655  
1d4ba0b81c1cf2 Herve Codina 2023-02-17  656  	tsa->dev = &pdev->dev;
1d4ba0b81c1cf2 Herve Codina 2023-02-17  657  
1d4ba0b81c1cf2 Herve Codina 2023-02-17  658  	for (i = 0; i < ARRAY_SIZE(tsa->serials); i++)
1d4ba0b81c1cf2 Herve Codina 2023-02-17  659  		tsa->serials[i].id = i;
1d4ba0b81c1cf2 Herve Codina 2023-02-17  660  
1d4ba0b81c1cf2 Herve Codina 2023-02-17  661  	spin_lock_init(&tsa->lock);
1d4ba0b81c1cf2 Herve Codina 2023-02-17  662  
1d4ba0b81c1cf2 Herve Codina 2023-02-17 @663  	tsa->si_regs = devm_platform_ioremap_resource_byname(pdev, "si_regs");
1d4ba0b81c1cf2 Herve Codina 2023-02-17  664  	if (IS_ERR(tsa->si_regs))
1d4ba0b81c1cf2 Herve Codina 2023-02-17  665  		return PTR_ERR(tsa->si_regs);
1d4ba0b81c1cf2 Herve Codina 2023-02-17  666  
1d4ba0b81c1cf2 Herve Codina 2023-02-17  667  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "si_ram");
1d4ba0b81c1cf2 Herve Codina 2023-02-17  668  	if (!res) {
1d4ba0b81c1cf2 Herve Codina 2023-02-17  669  		dev_err(tsa->dev, "si_ram resource missing\n");
1d4ba0b81c1cf2 Herve Codina 2023-02-17  670  		return -EINVAL;
1d4ba0b81c1cf2 Herve Codina 2023-02-17  671  	}
1d4ba0b81c1cf2 Herve Codina 2023-02-17  672  	tsa->si_ram_sz = resource_size(res);
1d4ba0b81c1cf2 Herve Codina 2023-02-17 @673  	tsa->si_ram = devm_ioremap_resource(&pdev->dev, res);
1d4ba0b81c1cf2 Herve Codina 2023-02-17  674  	if (IS_ERR(tsa->si_ram))
1d4ba0b81c1cf2 Herve Codina 2023-02-17  675  		return PTR_ERR(tsa->si_ram);
1d4ba0b81c1cf2 Herve Codina 2023-02-17  676  
1d4ba0b81c1cf2 Herve Codina 2023-02-17  677  	tsa_init_si_ram(tsa);
1d4ba0b81c1cf2 Herve Codina 2023-02-17  678  
1d4ba0b81c1cf2 Herve Codina 2023-02-17  679  	ret = tsa_of_parse_tdms(tsa, np);
1d4ba0b81c1cf2 Herve Codina 2023-02-17  680  	if (ret)
1d4ba0b81c1cf2 Herve Codina 2023-02-17  681  		return ret;
1d4ba0b81c1cf2 Herve Codina 2023-02-17  682  
1d4ba0b81c1cf2 Herve Codina 2023-02-17  683  	/* Set SIMODE */
1d4ba0b81c1cf2 Herve Codina 2023-02-17  684  	val = 0;
1d4ba0b81c1cf2 Herve Codina 2023-02-17  685  	if (tsa->tdm[0].is_enable)
1d4ba0b81c1cf2 Herve Codina 2023-02-17  686  		val |= TSA_SIMODE_TDMA(tsa->tdm[0].simode_tdm);
1d4ba0b81c1cf2 Herve Codina 2023-02-17  687  	if (tsa->tdm[1].is_enable)
1d4ba0b81c1cf2 Herve Codina 2023-02-17  688  		val |= TSA_SIMODE_TDMB(tsa->tdm[1].simode_tdm);
1d4ba0b81c1cf2 Herve Codina 2023-02-17  689  
1d4ba0b81c1cf2 Herve Codina 2023-02-17  690  	tsa_clrsetbits32(tsa->si_regs + TSA_SIMODE,
1d4ba0b81c1cf2 Herve Codina 2023-02-17  691  			 TSA_SIMODE_TDMA(TSA_SIMODE_TDM_MASK) |
1d4ba0b81c1cf2 Herve Codina 2023-02-17  692  			 TSA_SIMODE_TDMB(TSA_SIMODE_TDM_MASK),
1d4ba0b81c1cf2 Herve Codina 2023-02-17  693  			 val);
1d4ba0b81c1cf2 Herve Codina 2023-02-17  694  
1d4ba0b81c1cf2 Herve Codina 2023-02-17  695  	/* Set SIGMR */
1d4ba0b81c1cf2 Herve Codina 2023-02-17  696  	val = (tsa->tdms == BIT(TSA_TDMA)) ?
1d4ba0b81c1cf2 Herve Codina 2023-02-17  697  		TSA_SIGMR_RDM_STATIC_TDMA : TSA_SIGMR_RDM_STATIC_TDMAB;
1d4ba0b81c1cf2 Herve Codina 2023-02-17  698  	if (tsa->tdms & BIT(TSA_TDMA))
1d4ba0b81c1cf2 Herve Codina 2023-02-17  699  		val |= TSA_SIGMR_ENA;
1d4ba0b81c1cf2 Herve Codina 2023-02-17  700  	if (tsa->tdms & BIT(TSA_TDMB))
1d4ba0b81c1cf2 Herve Codina 2023-02-17  701  		val |= TSA_SIGMR_ENB;
1d4ba0b81c1cf2 Herve Codina 2023-02-17  702  	tsa_write8(tsa->si_regs + TSA_SIGMR, val);
1d4ba0b81c1cf2 Herve Codina 2023-02-17  703  
1d4ba0b81c1cf2 Herve Codina 2023-02-17  704  	platform_set_drvdata(pdev, tsa);
1d4ba0b81c1cf2 Herve Codina 2023-02-17  705  
1d4ba0b81c1cf2 Herve Codina 2023-02-17  706  	return 0;
1d4ba0b81c1cf2 Herve Codina 2023-02-17  707  }
1d4ba0b81c1cf2 Herve Codina 2023-02-17  708  

:::::: The code at line 663 was first introduced by commit
:::::: 1d4ba0b81c1cf2bfc0c55658f53809846ae9de52 soc: fsl: cpm1: Add support for TSA

:::::: TO: Herve Codina <herve.codina@bootlin.com>
:::::: CC: Mark Brown <broonie@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
