Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7FE7F77F2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345771AbjKXPlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjKXPlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:41:19 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC7E199A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 07:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700840486; x=1732376486;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jECZQEmtQJY9QTjL/s/7QzDZJDf7QYHkCzmToT1TTkg=;
  b=MeCEO1Gmb7/3bd9bBCp9v9eKpHAUO5KcJS2CPQ6SU4+/P0d6MthcU0m+
   hUFaqItX9eWD17D6tiL1PUpe8fHmanf78Hsfvl6piuSztNu4GgS6oK9YU
   YuhsDEWrurJq4yVvZIrJL0SJ3fokJulPtDWpSTV3DJi8yA9ntPwBabC7M
   bAMnobNZ7xJOw22qHM9T8Lrez7NIfmkYf0HzIvqv2ULPhaGl+wOaJKgFS
   yot+8hrsBZQCTSZIeplkb68UxKLfJMvaZZCsGZB0DK6twUYlmbRdVqiZW
   r2Q7kFsnhqjjcfb0TyzUNhMPHd8zQG56MltmB+uLUrM1q5knKBWGCouMU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="478650500"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="478650500"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 07:41:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="838110810"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="838110810"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 24 Nov 2023 07:41:23 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r6YIz-0002y7-2g;
        Fri, 24 Nov 2023 15:41:21 +0000
Date:   Fri, 24 Nov 2023 23:40:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>
Subject: drivers/remoteproc/qcom_q6v5_pas.c:550:30: sparse: sparse: incorrect
 type in assignment (different address spaces)
Message-ID: <202311241748.wzrgG9o6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f1a09972a45ae63efbd1587337c4be13b1893330
commit: 29814986b82e820ae9d3eb7474cdcf66605bd114 remoteproc: qcom_q6v5_pas: add support for dtb co-firmware loading
date:   10 months ago
config: arm64-randconfig-r132-20231123 (https://download.01.org/0day-ci/archive/20231124/202311241748.wzrgG9o6-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce: (https://download.01.org/0day-ci/archive/20231124/202311241748.wzrgG9o6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311241748.wzrgG9o6-lkp@intel.com/

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
   528		adsp->mem_region = devm_ioremap_wc(adsp->dev, adsp->mem_phys, adsp->mem_size);
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
