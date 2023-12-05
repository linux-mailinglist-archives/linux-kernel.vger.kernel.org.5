Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573798057C0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 15:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346012AbjLEOiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345946AbjLEOiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:38:16 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C642CA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 06:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701787103; x=1733323103;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=k37t3gv+bYZ8jPUj9UFSUGzMILBFHWCIj9JQl0FdFnI=;
  b=IIQAbnncs4zPP5WJQOBQrqmPEke3fiHgbQpWUoOkMCieT4KZuS3CDSxu
   0T+4xGTLSwoRWfVaO6POLhKBncjHg5vtl2pY8S9iTNFKlEuRcbFXgEQ9o
   EhlUponUt8f2rz9FarGqVC9ZfkuOEDicG01loeSn7qC6oAY6vd/rBYI79
   kaG6PN4nGnevmU2lXlMZRL7oJg4Rcd4kQmM1ZNoONFTNqZ155Hr6g/MhC
   F5WnLtul5fpTBWg7ygtL9NiJd7Ple3fYd9HI9JkwAY6GK+hWalskxHtnZ
   BbBpOTyRtGNL9f6Iz+wuYYcigzW7ZUvNVjDWA9h3+Tlpckb5++4MEeuZX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="12618669"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="12618669"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 06:38:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="1018232607"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="1018232607"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 05 Dec 2023 06:38:20 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAWZ0-0009Bd-1M;
        Tue, 05 Dec 2023 14:38:18 +0000
Date:   Tue, 5 Dec 2023 22:38:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Julien Massot <julien.massot@iot.bzh>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: drivers/remoteproc/rcar_rproc.c:45:20: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202312052212.t7e1Apgi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
commit: 285892a74f1370a12249f765c6a4e3b16194852e remoteproc: Add Renesas rcar driver
date:   2 years ago
config: mips-randconfig-r122-20231108 (https://download.01.org/0day-ci/archive/20231205/202312052212.t7e1Apgi-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231205/202312052212.t7e1Apgi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312052212.t7e1Apgi-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/remoteproc/rcar_rproc.c:28:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *va @@     got void [noderef] __iomem * @@
   drivers/remoteproc/rcar_rproc.c:28:12: sparse:     expected void *va
   drivers/remoteproc/rcar_rproc.c:28:12: sparse:     got void [noderef] __iomem *
>> drivers/remoteproc/rcar_rproc.c:45:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *va @@
   drivers/remoteproc/rcar_rproc.c:45:20: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/remoteproc/rcar_rproc.c:45:20: sparse:     got void *va

vim +45 drivers/remoteproc/rcar_rproc.c

    20	
    21	static int rcar_rproc_mem_alloc(struct rproc *rproc,
    22					 struct rproc_mem_entry *mem)
    23	{
    24		struct device *dev = &rproc->dev;
    25		void *va;
    26	
    27		dev_dbg(dev, "map memory: %pa+%zx\n", &mem->dma, mem->len);
  > 28		va = ioremap_wc(mem->dma, mem->len);
    29		if (!va) {
    30			dev_err(dev, "Unable to map memory region: %pa+%zx\n",
    31				&mem->dma, mem->len);
    32			return -ENOMEM;
    33		}
    34	
    35		/* Update memory entry va */
    36		mem->va = va;
    37	
    38		return 0;
    39	}
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
