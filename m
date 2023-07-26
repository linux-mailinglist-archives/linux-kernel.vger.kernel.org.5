Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0027630A1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjGZI6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbjGZI5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:57:35 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47154C24
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690361428; x=1721897428;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iyIbrS5bRkZecFmv/upuSvmDUQbzaGSKA8C1j/1fDCw=;
  b=Ak5bhLbf026U8zSiXb9H1vwXnYqBEsqww8jJJQhldtm6bpH/1hnBabiK
   7cPqTx+YGZgxDrfCaTL3ico7iEemqQD3UP8+ymqY8UnUkLh4L9N0WRcAe
   v9h19lU9fq7YViVfdME8kvSg0g0pEcOqxKhncIfyGn4oG5NFi+UsHkMQ4
   phniT+zHxWTAFnxJfzGIhLISA4lQzCWIyogCZbKeeNlj51xfkwNMw3fgn
   uycfOhzeVDzNEhtrLuofWn7Pfxn3Is0UoAtH/uR7iyc5XSonC1xXUh4Nz
   CcZsB7luSpdl3xvp5FI9V5+qYLYmJ9PS3yelSXLw2KuIPgRsKid5L7l+1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="352858260"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="352858260"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 01:50:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="816583519"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="816583519"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Jul 2023 01:50:26 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOaDx-0000pg-34;
        Wed, 26 Jul 2023 08:50:25 +0000
Date:   Wed, 26 Jul 2023 16:47:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>
Subject: drivers/remoteproc/qcom_q6v5_pas.c:550:30: sparse: sparse: incorrect
 type in assignment (different address spaces)
Message-ID: <202307261656.mKtxBu6y-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   18b44bc5a67275641fb26f2c54ba7eef80ac5950
commit: 29814986b82e820ae9d3eb7474cdcf66605bd114 remoteproc: qcom_q6v5_pas: add support for dtb co-firmware loading
date:   6 months ago
config: arm64-randconfig-r093-20230726 (https://download.01.org/0day-ci/archive/20230726/202307261656.mKtxBu6y-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230726/202307261656.mKtxBu6y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307261656.mKtxBu6y-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/remoteproc/qcom_q6v5_pas.c:528:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *mem_region @@     got void [noderef] __iomem * @@
   drivers/remoteproc/qcom_q6v5_pas.c:528:26: sparse:     expected void *mem_region
   drivers/remoteproc/qcom_q6v5_pas.c:528:26: sparse:     got void [noderef] __iomem *
>> drivers/remoteproc/qcom_q6v5_pas.c:550:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *dtb_mem_region @@     got void [noderef] __iomem * @@
   drivers/remoteproc/qcom_q6v5_pas.c:550:30: sparse:     expected void *dtb_mem_region
   drivers/remoteproc/qcom_q6v5_pas.c:550:30: sparse:     got void [noderef] __iomem *

vim +550 drivers/remoteproc/qcom_q6v5_pas.c

   508	
   509	static int adsp_alloc_memory_region(struct qcom_adsp *adsp)
   510	{
   511		struct device_node *node;
   512		struct resource r;
   513		int ret;
   514	
   515		node = of_parse_phandle(adsp->dev->of_node, "memory-region", 0);
   516		if (!node) {
   517			dev_err(adsp->dev, "no memory-region specified\n");
   518			return -EINVAL;
   519		}
   520	
   521		ret = of_address_to_resource(node, 0, &r);
   522		of_node_put(node);
   523		if (ret)
   524			return ret;
   525	
   526		adsp->mem_phys = adsp->mem_reloc = r.start;
   527		adsp->mem_size = resource_size(&r);
 > 528		adsp->mem_region = devm_ioremap_wc(adsp->dev, adsp->mem_phys, adsp->mem_size);
   529		if (!adsp->mem_region) {
   530			dev_err(adsp->dev, "unable to map memory region: %pa+%zx\n",
   531				&r.start, adsp->mem_size);
   532			return -EBUSY;
   533		}
   534	
   535		if (!adsp->dtb_pas_id)
   536			return 0;
   537	
   538		node = of_parse_phandle(adsp->dev->of_node, "memory-region", 1);
   539		if (!node) {
   540			dev_err(adsp->dev, "no dtb memory-region specified\n");
   541			return -EINVAL;
   542		}
   543	
   544		ret = of_address_to_resource(node, 0, &r);
   545		if (ret)
   546			return ret;
   547	
   548		adsp->dtb_mem_phys = adsp->dtb_mem_reloc = r.start;
   549		adsp->dtb_mem_size = resource_size(&r);
 > 550		adsp->dtb_mem_region = devm_ioremap_wc(adsp->dev, adsp->dtb_mem_phys, adsp->dtb_mem_size);
   551		if (!adsp->dtb_mem_region) {
   552			dev_err(adsp->dev, "unable to map dtb memory region: %pa+%zx\n",
   553				&r.start, adsp->dtb_mem_size);
   554			return -EBUSY;
   555		}
   556	
   557		return 0;
   558	}
   559	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
