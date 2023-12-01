Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCF88004E0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 08:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbjLAHlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 02:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjLAHlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 02:41:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286CD170C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701416510; x=1732952510;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ClHNGMotDpvekIbl5i9wnHnSvyAhRySPR4pmDVBvxQw=;
  b=PsfXs/MUri/pQzru+hPJNkqvEf2kNNRYIPoix2tzRgK5nNH9OPwQGcG+
   Y1SUi3UgG/53FkIRsTQ1po/sVdRGCUOVtOBfn+YbJT4DlGdaINAZMMfLN
   cpw+kq7Z6NM9O8bSomUSyFY8HbqgsI8QOrGdfBsNYMITt9uSAh7wZOhLv
   TurcHX2krRpKPbAphNrOOiiuAmpvAjK1O/FlbneVOoIHuLxbyIvu9Rdxh
   G2EKWjP0JYGbXx4DvZ3EPVCJqihX/FIJHSpZuryEIf12RdXu94RMoTN4T
   dMjFT+B8aNSfS/kxoyeY9mhbjSMg9eyn6vmBEz2tkrfvHjo/yz7soAISe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="460792"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="460792"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 23:41:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="913489119"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="913489119"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 30 Nov 2023 23:41:48 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r8y9h-0003HY-2T;
        Fri, 01 Dec 2023 07:41:45 +0000
Date:   Fri, 1 Dec 2023 15:41:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Julien Massot <julien.massot@iot.bzh>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: drivers/remoteproc/rcar_rproc.c:45:20: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202312011500.EHBoglZU-lkp@intel.com>
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
head:   994d5c58e50e91bb02c7be4a91d5186292a895c8
commit: 285892a74f1370a12249f765c6a4e3b16194852e remoteproc: Add Renesas rcar driver
date:   2 years ago
config: mips-randconfig-r122-20231108 (https://download.01.org/0day-ci/archive/20231201/202312011500.EHBoglZU-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231201/202312011500.EHBoglZU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312011500.EHBoglZU-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/remoteproc/rcar_rproc.c:28:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *va @@     got void [noderef] __iomem * @@
   drivers/remoteproc/rcar_rproc.c:28:12: sparse:     expected void *va
   drivers/remoteproc/rcar_rproc.c:28:12: sparse:     got void [noderef] __iomem *
>> drivers/remoteproc/rcar_rproc.c:45:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *va @@
   drivers/remoteproc/rcar_rproc.c:45:20: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/remoteproc/rcar_rproc.c:45:20: sparse:     got void *va

vim +45 drivers/remoteproc/rcar_rproc.c

    40	
    41	static int rcar_rproc_mem_release(struct rproc *rproc,
    42					   struct rproc_mem_entry *mem)
    43	{
    44		dev_dbg(&rproc->dev, "unmap memory: %pa\n", &mem->dma);
  > 45		iounmap(mem->va);
    46	
    47		return 0;
    48	}
    49	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
