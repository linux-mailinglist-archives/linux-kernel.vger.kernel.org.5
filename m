Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1609766121
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 03:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjG1BQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 21:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjG1BQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 21:16:43 -0400
Received: from mgamail.intel.com (unknown [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E98D30EB
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 18:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690506999; x=1722042999;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8KfMBGcONL4k4Z7W2j3Cvr/WVIqdymkJqkOec38jGdU=;
  b=SruQTVb82h6uKNponIElyDfuCdPlHqLcQGw9xsePSZaDua6tD6DReu2K
   22aX8wMmh9MIleFj4+YuT3K5VV6Yo2bz/kDv5NGiPYipWr8UnDPxtt9C2
   TNVvGhbgKQv9yRDvVAct7qQvbw2AlzSbwE4ZzJuIl4DTyeZT/3r8zKegI
   z35W6o+1SRZnXkR4WLDRW/UzIcwKyZWOV6wEwvsm7kT9BPOvwAzjKVnUi
   poxZ+8Meumc4Lz6cEwS3VZClH4WXa6AiBBb4mWkeMDj3zGwHOap903QZR
   YA3ozdyZVHDSQO4ERbzJe9YO6RI6NsE1eAD+CXnM5I18yWSWCUSpIU09E
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="432289208"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="432289208"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 18:16:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="792692843"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="792692843"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 27 Jul 2023 18:16:36 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qPC5H-0002k3-0f;
        Fri, 28 Jul 2023 01:16:25 +0000
Date:   Fri, 28 Jul 2023 09:13:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>
Subject: drivers/spi/spi-stm32-qspi.c:468:27: warning: 'op' is used
 uninitialized
Message-ID: <202307280915.PELlO3TQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   57012c57536f8814dec92e74197ee96c3498d24e
commit: 68f5d3f3b6543266b29e047cfaf9842333019b4c um: add PCI over virtio emulation driver
date:   2 years, 1 month ago
config: um-allyesconfig (https://download.01.org/0day-ci/archive/20230728/202307280915.PELlO3TQ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230728/202307280915.PELlO3TQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307280915.PELlO3TQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/spi/spi-stm32-qspi.c: In function 'stm32_qspi_dirmap_read':
>> drivers/spi/spi-stm32-qspi.c:468:27: warning: 'op' is used uninitialized [-Wuninitialized]
     468 |         struct spi_mem_op op;
         |                           ^~
   drivers/spi/spi-stm32-qspi.c:468:27: note: 'op' declared here
     468 |         struct spi_mem_op op;
         |                           ^~


vim +/op +468 drivers/spi/spi-stm32-qspi.c

18674dee3cd651 Patrice Chotard 2021-04-19  463  
18674dee3cd651 Patrice Chotard 2021-04-19  464  static ssize_t stm32_qspi_dirmap_read(struct spi_mem_dirmap_desc *desc,
18674dee3cd651 Patrice Chotard 2021-04-19  465  				      u64 offs, size_t len, void *buf)
18674dee3cd651 Patrice Chotard 2021-04-19  466  {
18674dee3cd651 Patrice Chotard 2021-04-19  467  	struct stm32_qspi *qspi = spi_controller_get_devdata(desc->mem->spi->master);
18674dee3cd651 Patrice Chotard 2021-04-19 @468  	struct spi_mem_op op;
18674dee3cd651 Patrice Chotard 2021-04-19  469  	u32 addr_max;
18674dee3cd651 Patrice Chotard 2021-04-19  470  	int ret;
18674dee3cd651 Patrice Chotard 2021-04-19  471  
18674dee3cd651 Patrice Chotard 2021-04-19  472  	ret = pm_runtime_get_sync(qspi->dev);
18674dee3cd651 Patrice Chotard 2021-04-19  473  	if (ret < 0) {
18674dee3cd651 Patrice Chotard 2021-04-19  474  		pm_runtime_put_noidle(qspi->dev);
18674dee3cd651 Patrice Chotard 2021-04-19  475  		return ret;
18674dee3cd651 Patrice Chotard 2021-04-19  476  	}
18674dee3cd651 Patrice Chotard 2021-04-19  477  
18674dee3cd651 Patrice Chotard 2021-04-19  478  	mutex_lock(&qspi->lock);
18674dee3cd651 Patrice Chotard 2021-04-19  479  	/* make a local copy of desc op_tmpl and complete dirmap rdesc
18674dee3cd651 Patrice Chotard 2021-04-19  480  	 * spi_mem_op template with offs, len and *buf in  order to get
18674dee3cd651 Patrice Chotard 2021-04-19  481  	 * all needed transfer information into struct spi_mem_op
18674dee3cd651 Patrice Chotard 2021-04-19  482  	 */
18674dee3cd651 Patrice Chotard 2021-04-19  483  	memcpy(&op, &desc->info.op_tmpl, sizeof(struct spi_mem_op));
14ef64ebdc2a45 Arnd Bergmann   2021-04-22  484  	dev_dbg(qspi->dev, "%s len = 0x%zx offs = 0x%llx buf = 0x%p\n", __func__, len, offs, buf);
18674dee3cd651 Patrice Chotard 2021-04-19  485  
18674dee3cd651 Patrice Chotard 2021-04-19  486  	op.data.nbytes = len;
18674dee3cd651 Patrice Chotard 2021-04-19  487  	op.addr.val = desc->info.offset + offs;
18674dee3cd651 Patrice Chotard 2021-04-19  488  	op.data.buf.in = buf;
18674dee3cd651 Patrice Chotard 2021-04-19  489  
18674dee3cd651 Patrice Chotard 2021-04-19  490  	addr_max = op.addr.val + op.data.nbytes + 1;
18674dee3cd651 Patrice Chotard 2021-04-19  491  	if (addr_max < qspi->mm_size && op.addr.buswidth)
18674dee3cd651 Patrice Chotard 2021-04-19  492  		qspi->fmode = CCR_FMODE_MM;
18674dee3cd651 Patrice Chotard 2021-04-19  493  	else
18674dee3cd651 Patrice Chotard 2021-04-19  494  		qspi->fmode = CCR_FMODE_INDR;
18674dee3cd651 Patrice Chotard 2021-04-19  495  
18674dee3cd651 Patrice Chotard 2021-04-19  496  	ret = stm32_qspi_send(desc->mem, &op);
18674dee3cd651 Patrice Chotard 2021-04-19  497  	mutex_unlock(&qspi->lock);
18674dee3cd651 Patrice Chotard 2021-04-19  498  
18674dee3cd651 Patrice Chotard 2021-04-19  499  	pm_runtime_mark_last_busy(qspi->dev);
18674dee3cd651 Patrice Chotard 2021-04-19  500  	pm_runtime_put_autosuspend(qspi->dev);
18674dee3cd651 Patrice Chotard 2021-04-19  501  
18674dee3cd651 Patrice Chotard 2021-04-19  502  	return ret ?: len;
18674dee3cd651 Patrice Chotard 2021-04-19  503  }
18674dee3cd651 Patrice Chotard 2021-04-19  504  

:::::: The code at line 468 was first introduced by commit
:::::: 18674dee3cd651279eb3d9ba789fe483ddfe1137 spi: stm32-qspi: Add dirmap support

:::::: TO: Patrice Chotard <patrice.chotard@foss.st.com>
:::::: CC: Mark Brown <broonie@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
