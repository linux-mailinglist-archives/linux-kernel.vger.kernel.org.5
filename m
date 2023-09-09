Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89162799A5C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 20:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237791AbjIISNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 14:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbjIISNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 14:13:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2251B0
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 11:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694283218; x=1725819218;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Sa7wB2GJMlHLBCwqRdyyalXAnSj55KZP/ugyaKK4Fxg=;
  b=LmCsHjQPCYv/f0wmjFqeSo6zsYwmeTQztBe0if6y0MLEIRnMsHe7sXPW
   5stABIQqO7cg7Q26CxEn+txmfpg8vFJh/h6LU31Mwqn/24NNeVCl7nPGe
   mmRT+66aUT5tWZXAzPJs8nkmz5bWldBVY2GF5fw/S280iQFPV76gyz9D8
   nwhqm7sLMJJr2iU6dCxa7ubnWtyWGf9LEqNFslwTnX/UjIA9IFT4Z0Elz
   0Kx7HTf4IGxnlNca5poh56CBAbjE6Ky340MA1Z6wOPCnu5bcdQMk8vt1p
   0FkPdEkvN+De1vL2hYrHEMjWMPjkwhDkiHH3CD40kxEu8Cq37aRi0YAGO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="408819057"
X-IronPort-AV: E=Sophos;i="6.02,239,1688454000"; 
   d="scan'208";a="408819057"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2023 11:13:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="808354209"
X-IronPort-AV: E=Sophos;i="6.02,239,1688454000"; 
   d="scan'208";a="808354209"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 09 Sep 2023 11:13:36 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qf2Sc-0003kx-16;
        Sat, 09 Sep 2023 18:13:34 +0000
Date:   Sun, 10 Sep 2023 02:13:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Thompson <davthompson@nvidia.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Shravan Kumar Ramani <shravankr@nvidia.com>
Subject: drivers/platform/mellanox/mlxbf-bootctl.c:516: undefined reference
 to `sysfs_format_mac'
Message-ID: <202309100251.FBtxnkZX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6099776f9f268e61fe5ecd721f994a8cfce5306f
commit: 7e38a7422f128e7d7ba24b444e957d585dbb272f mlxbf-bootctl: Support sysfs entries for MFG fields
date:   2 weeks ago
config: arm64-randconfig-r033-20210930 (https://download.01.org/0day-ci/archive/20230910/202309100251.FBtxnkZX-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230910/202309100251.FBtxnkZX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309100251.FBtxnkZX-lkp@intel.com/

All errors (new ones prefixed by >>):

   aarch64-linux-ld: Unexpected GOT/PLT entries detected!
   aarch64-linux-ld: Unexpected run-time procedure linkages detected!
   aarch64-linux-ld: drivers/platform/mellanox/mlxbf-bootctl.o: in function `oob_mac_show':
>> drivers/platform/mellanox/mlxbf-bootctl.c:516: undefined reference to `sysfs_format_mac'


vim +516 drivers/platform/mellanox/mlxbf-bootctl.c

   500	
   501	static ssize_t oob_mac_show(struct device *dev,
   502				    struct device_attribute *attr, char *buf)
   503	{
   504		struct arm_smccc_res res;
   505		u8 *mac_byte_ptr;
   506	
   507		mutex_lock(&mfg_ops_lock);
   508		arm_smccc_smc(MLXBF_BOOTCTL_GET_MFG_INFO, MLNX_MFG_TYPE_OOB_MAC, 0, 0, 0,
   509			      0, 0, 0, &res);
   510		mutex_unlock(&mfg_ops_lock);
   511		if (res.a0)
   512			return -EPERM;
   513	
   514		mac_byte_ptr = (u8 *)&res.a1;
   515	
 > 516		return sysfs_format_mac(buf, mac_byte_ptr, ETH_ALEN);
   517	}
   518	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
