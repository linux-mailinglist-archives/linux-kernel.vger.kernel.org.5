Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E23812E78
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443831AbjLNLYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443635AbjLNLYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:24:34 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B778E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702553080; x=1734089080;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rerZwQ0/qZqP1HXezOIkE+k7M/FVoApEw2Eamlkzvq8=;
  b=RggZ8mmpFVD7uEF+gkIEv8SjcicydEh7/Hys01euyfl2Krx2IyxWlMfd
   rlKd7pgi5hseMxOHVB9YcnJxLgOOU4OUnElda3hYQ6G5adfOTOw7YVjW6
   QZGksj544+SGedN2EjIq0NHBcRTMKXMpT5WFv719nKV7meh2zicKCheEM
   TTPUl8DoWbqpy+ka9EeG++kwSu611C8fazUNSXq3TyS6oqTBLWD9JDzeM
   NpNmwLwNAxLNO2HsSOS/3yzxnbhvhvATSxw8zh9qDOuRb7ZaPC4ejM84n
   D305cVF04z8BpDlm5jlHFFXs8oevJDUzAJStRQOJwdarLFLOUkYW2f8h+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="394852258"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="394852258"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 03:24:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="808553178"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="808553178"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 14 Dec 2023 03:24:38 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rDjpT-000Ly7-2q;
        Thu, 14 Dec 2023 11:24:35 +0000
Date:   Thu, 14 Dec 2023 19:24:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shravan Kumar Ramani <shravankr@nvidia.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Vadim Pasternak <vadimp@nvidia.com>,
        David Thompson <davthompson@nvidia.com>
Subject: drivers/platform/mellanox/mlxbf-pmc.c:1172:14: sparse: sparse:
 incorrect type in assignment (different address spaces)
Message-ID: <202312141958.5gJeiJvT-lkp@intel.com>
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
head:   5bd7ef53ffe5ca580e93e74eb8c81ed191ddc4bd
commit: 423c3361855c1e81f1cb91728a2ac5ddfd2cbf16 platform/mellanox: mlxbf-pmc: Add support for BlueField-3
date:   3 months ago
config: arm64-randconfig-r121-20231116 (https://download.01.org/0day-ci/archive/20231214/202312141958.5gJeiJvT-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231214/202312141958.5gJeiJvT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312141958.5gJeiJvT-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/platform/mellanox/mlxbf-pmc.c:1172:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem * @@
   drivers/platform/mellanox/mlxbf-pmc.c:1172:14: sparse:     expected void *addr
   drivers/platform/mellanox/mlxbf-pmc.c:1172:14: sparse:     got void [noderef] __iomem *
>> drivers/platform/mellanox/mlxbf-pmc.c:1174:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *addr @@
   drivers/platform/mellanox/mlxbf-pmc.c:1174:31: sparse:     expected void [noderef] __iomem *addr
   drivers/platform/mellanox/mlxbf-pmc.c:1174:31: sparse:     got void *addr
   drivers/platform/mellanox/mlxbf-pmc.c:1186:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *addr @@
   drivers/platform/mellanox/mlxbf-pmc.c:1186:32: sparse:     expected void [noderef] __iomem *addr
   drivers/platform/mellanox/mlxbf-pmc.c:1186:32: sparse:     got void *addr
   drivers/platform/mellanox/mlxbf-pmc.c:1194:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem * @@
   drivers/platform/mellanox/mlxbf-pmc.c:1194:14: sparse:     expected void *addr
   drivers/platform/mellanox/mlxbf-pmc.c:1194:14: sparse:     got void [noderef] __iomem *
   drivers/platform/mellanox/mlxbf-pmc.c:1198:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *addr @@
   drivers/platform/mellanox/mlxbf-pmc.c:1198:32: sparse:     expected void [noderef] __iomem *addr
   drivers/platform/mellanox/mlxbf-pmc.c:1198:32: sparse:     got void *addr
   drivers/platform/mellanox/mlxbf-pmc.c:1415:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem * @@
   drivers/platform/mellanox/mlxbf-pmc.c:1415:14: sparse:     expected void *addr
   drivers/platform/mellanox/mlxbf-pmc.c:1415:14: sparse:     got void [noderef] __iomem *
   drivers/platform/mellanox/mlxbf-pmc.c:1417:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *addr @@
   drivers/platform/mellanox/mlxbf-pmc.c:1417:31: sparse:     expected void [noderef] __iomem *addr
   drivers/platform/mellanox/mlxbf-pmc.c:1417:31: sparse:     got void *addr

vim +1172 drivers/platform/mellanox/mlxbf-pmc.c

  1163	
  1164	/* Method to handle crspace counter programming */
  1165	static int mlxbf_pmc_program_crspace_counter(int blk_num, uint32_t cnt_num,
  1166						     uint32_t evt)
  1167	{
  1168		uint32_t word;
  1169		void *addr;
  1170		int ret;
  1171	
> 1172		addr = pmc->block[blk_num].mmio_base +
  1173			(rounddown(cnt_num, 2) * MLXBF_PMC_CRSPACE_PERFSEL_SZ);
> 1174		ret = mlxbf_pmc_readl(addr, &word);
  1175		if (ret)
  1176			return ret;
  1177	
  1178		if (cnt_num % 2) {
  1179			word &= ~MLXBF_PMC_CRSPACE_PERFSEL1;
  1180			word |= FIELD_PREP(MLXBF_PMC_CRSPACE_PERFSEL1, evt);
  1181		} else {
  1182			word &= ~MLXBF_PMC_CRSPACE_PERFSEL0;
  1183			word |= FIELD_PREP(MLXBF_PMC_CRSPACE_PERFSEL0, evt);
  1184		}
  1185	
  1186		return mlxbf_pmc_write(addr, MLXBF_PMC_WRITE_REG_32, word);
  1187	}
  1188	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
