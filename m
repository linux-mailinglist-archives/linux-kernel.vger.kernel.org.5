Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC41575DFB2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 04:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjGWCQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 22:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGWCQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 22:16:50 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F15180;
        Sat, 22 Jul 2023 19:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690078609; x=1721614609;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IzEO4IEifVL71A4mhJqlzF1dVCJiZMCAMhavJh+/RIA=;
  b=nkaGN96pFrFfMw2JHjrj8eXthP2GUsqYJIMT/Tomvobdx2Gr221k7c2l
   8KhktMWmcrdfi/7b6g0KVpAcd95Tb6PefA+h17jzHNYXhiO3uXR2w1Ok6
   PXLj3W8YTiQYghbXKcpIz56xs4V3S/yqY4xz1HutI2xESbMV+Ndf4SyDs
   UqNzVjzBKUryEAzzlDw0izm3sRXy/oFIFQ4hh7HWgw+TST3izRghu9rfK
   Ua3H0GU/6ydIoovR8kNYMhP/lk2JAoHdKAPHCe48F0tP23wl+87IuRoNb
   RlP4ElIkwiHaU+5Ay5Vnm/key9O/TftqJYjsizQd6MU3byKl+EjvMJMWY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="431038648"
X-IronPort-AV: E=Sophos;i="6.01,226,1684825200"; 
   d="scan'208";a="431038648"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2023 19:16:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="790577627"
X-IronPort-AV: E=Sophos;i="6.01,226,1684825200"; 
   d="scan'208";a="790577627"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 22 Jul 2023 19:16:39 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qNOeE-0008kF-1B;
        Sun, 23 Jul 2023 02:16:38 +0000
Date:   Sun, 23 Jul 2023 10:15:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nikunj Kela <quic_nkela@quicinc.com>, sudeep.holla@arm.com
Cc:     oe-kbuild-all@lists.linux.dev, cristian.marussi@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Nikunj Kela <quic_nkela@quicinc.com>
Subject: Re: [PATCH 2/2] firmware: arm_scmi: Add qcom hvc/shmem transport
Message-ID: <202307231034.5C5lj4Dv-lkp@intel.com>
References: <20230718160833.36397-3-quic_nkela@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718160833.36397-3-quic_nkela@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikunj,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.5-rc2 next-20230721]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nikunj-Kela/dt-bindings-arm-Add-qcom-specific-hvc-transport-for-SCMI/20230719-001116
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230718160833.36397-3-quic_nkela%40quicinc.com
patch subject: [PATCH 2/2] firmware: arm_scmi: Add qcom hvc/shmem transport
config: arm64-randconfig-r083-20230723 (https://download.01.org/0day-ci/archive/20230723/202307231034.5C5lj4Dv-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230723/202307231034.5C5lj4Dv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307231034.5C5lj4Dv-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/firmware/arm_scmi/qcom_hvc.c:136:26: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/firmware/arm_scmi/qcom_hvc.c:136:52: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/firmware/arm_scmi/qcom_hvc.c:136:52: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/firmware/arm_scmi/qcom_hvc.c:136:52: sparse:     got void *
   drivers/firmware/arm_scmi/qcom_hvc.c:139:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/firmware/arm_scmi/qcom_hvc.c:139:58: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/firmware/arm_scmi/qcom_hvc.c:139:58: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/firmware/arm_scmi/qcom_hvc.c:139:58: sparse:     got void *

vim +/__iomem +136 drivers/firmware/arm_scmi/qcom_hvc.c

    82	
    83	static int qcom_hvc_chan_setup(struct scmi_chan_info *cinfo,
    84				       struct device *dev, bool tx)
    85	{
    86		struct device *cdev = cinfo->dev;
    87		struct scmi_qcom_hvc *scmi_info;
    88		resource_size_t size;
    89		struct resource res;
    90		struct device_node *np;
    91		unsigned long cap_id;
    92		u32 func_id;
    93		int ret, irq;
    94	
    95		if (!tx)
    96			return -ENODEV;
    97	
    98		scmi_info = devm_kzalloc(dev, sizeof(*scmi_info), GFP_KERNEL);
    99		if (!scmi_info)
   100			return -ENOMEM;
   101	
   102		np = of_parse_phandle(cdev->of_node, "shmem", 0);
   103		if (!of_device_is_compatible(np, "arm,scmi-shmem"))
   104			return -ENXIO;
   105	
   106		ret = of_address_to_resource(np, 0, &res);
   107		of_node_put(np);
   108		if (ret) {
   109			dev_err(cdev, "failed to get SCMI Tx shared memory\n");
   110			return ret;
   111		}
   112	
   113		size = resource_size(&res);
   114	
   115		/* let's map 2 additional ulong since
   116		 * func-id & capability-id are kept after shmem.
   117		 *     +-------+
   118		 *     |       |
   119		 *     | shmem |
   120		 *     |       |
   121		 *     |       |
   122		 *     +-------+ <-- size
   123		 *     | funcId|
   124		 *     +-------+ <-- size + sizeof(ulong)
   125		 *     | capId |
   126		 *     +-------+ <-- size + 2*sizeof(ulong)
   127		 */
   128	
   129		scmi_info->shmem = devm_ioremap(dev, res.start,
   130						size + 2 * sizeof(unsigned long));
   131		if (!scmi_info->shmem) {
   132			dev_err(dev, "failed to ioremap SCMI Tx shared memory\n");
   133			return -EADDRNOTAVAIL;
   134		}
   135	
 > 136		func_id = readl((void *)(scmi_info->shmem) + size);
   137	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
