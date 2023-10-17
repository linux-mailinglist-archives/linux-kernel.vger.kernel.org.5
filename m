Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C6F7CCF5B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 23:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbjJQVfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 17:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235033AbjJQVfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 17:35:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1E9212F
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697578081; x=1729114081;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WGhyw6b5AaO5oRHf4oQq9HF58U/arpaEHDj9e0rkUaA=;
  b=joTWFpe1MduXx2XViep9BAclB8C28jsKAkY3wPMlLU33B5/wTLSTzpLg
   j9ZOW5ZtjgH+6dgYd8+fOhcJFIAKNp8fJBphIuVvw0Lh3XOHj3O2bV+kY
   gHA2s6sTxW/al6AqPu3Xmofsn5ivFVZkmpdYOHivbmGDmz5hNS7e5auP6
   gvk1ImjHlCqIxApY6hqI7I3r3svSDY7Xj7oOBjFHMT9Luhym5g6Vd42LW
   8y9P7ao6AAVUAW0ALlorE+55gEMJ47Cl5HOgcEDaaAQ9ZV8oFlyebX2UZ
   g31QG9eqz8JgBssUqVcJ1mKAi4VWotOP9i43VmVjpXH/sGmZf02RBHHjs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="385718703"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="385718703"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 14:27:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="4249453"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 17 Oct 2023 14:28:01 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qsrbV-000A6L-0e;
        Tue, 17 Oct 2023 21:27:53 +0000
Date:   Wed, 18 Oct 2023 05:27:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bradley Grove <bgrove@attotech.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Rob Crispo <rcrispo@attotech.com>
Subject: drivers/scsi/mpt3sas/mpt3sas_base.c:5487: warning: Function
 parameter or member 'sas_addr' not described in 'mpt3sas_atto_get_sas_addr'
Message-ID: <202310180526.lMLsejM1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bradley,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   213f891525c222e8ed145ce1ce7ae1f47921cb9c
commit: 91cf186aa1bfea06c7438b16eb40a612a4c3b87a scsi: mpt3sas: Add support for ATTO ExpressSAS H12xx GT devices
date:   1 year, 2 months ago
config: x86_64-randconfig-x063-20230716 (https://download.01.org/0day-ci/archive/20231018/202310180526.lMLsejM1-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231018/202310180526.lMLsejM1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310180526.lMLsejM1-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/scsi/mpt3sas/mpt3sas_base.c:5487: warning: Function parameter or member 'sas_addr' not described in 'mpt3sas_atto_get_sas_addr'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for DRM_I915_DEBUG_GEM
   Depends on [n]: HAS_IOMEM [=y] && DRM_I915 [=y] && EXPERT [=y] && DRM_I915_WERROR [=n]
   Selected by [y]:
   - DRM_I915_DEBUG [=y] && HAS_IOMEM [=y] && DRM_I915 [=y] && EXPERT [=y] && !COMPILE_TEST [=n]


vim +5487 drivers/scsi/mpt3sas/mpt3sas_base.c

  5477	
  5478	/**
  5479	 * mpt3sas_atto_get_sas_addr - get the ATTO SAS address from mfg page 1
  5480	 *
  5481	 * @ioc : per adapter object
  5482	 * @*sas_addr : return sas address
  5483	 * Return: 0 for success, non-zero for failure.
  5484	 */
  5485	static int
  5486	mpt3sas_atto_get_sas_addr(struct MPT3SAS_ADAPTER *ioc, union ATTO_SAS_ADDRESS *sas_addr)
> 5487	{
  5488		Mpi2ManufacturingPage1_t mfg_pg1;
  5489		Mpi2ConfigReply_t mpi_reply;
  5490		struct ATTO_SAS_NVRAM *nvram;
  5491		int r;
  5492		__be64 addr;
  5493	
  5494		r = mpt3sas_config_get_manufacturing_pg1(ioc, &mpi_reply, &mfg_pg1);
  5495		if (r) {
  5496			ioc_err(ioc, "Failed to read manufacturing page 1\n");
  5497			return r;
  5498		}
  5499	
  5500		/* validate nvram */
  5501		nvram = (struct ATTO_SAS_NVRAM *) mfg_pg1.VPD;
  5502		r = mpt3sas_atto_validate_nvram(ioc, nvram);
  5503		if (r)
  5504			return r;
  5505	
  5506		addr = *((__be64 *) nvram->SasAddr);
  5507		sas_addr->q = cpu_to_le64(be64_to_cpu(addr));
  5508		return r;
  5509	}
  5510	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
