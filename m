Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0AA7999EB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 18:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbjIIQ0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 12:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241655AbjIIOJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 10:09:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E2CCC1
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 07:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694268567; x=1725804567;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Czqq/j81Dtm6nwP2yz4qKe8IqZZ5MMkNOTJX5VOKxD0=;
  b=DEX8uo9D24NW4gbjYurktfmOzQencI/m0b+izhCMVcOGKng3u4nWTJ+z
   Ck150bcmNvCE99orRIixFACbm/WQ8K8F1jHQLLkGEYmsjdp/4WqdsJ2IJ
   GbDgRvTHGidOPGSVRRV67aS/M+ce6Q4HH1YOUx/JY+Uks7BSUB1MA3Gi1
   NWrUYLYkS0qkmprsVDX+iFp3W4j0AqJYDYdcfMoFsr5mRb90S/lnZf2QK
   kd+g5j5iawRsPjylcNrvwrOvqdfcEAlCUaHAC7w8rPGqKPsFi3tC9SZHq
   mRBS1zBAsKQD4KJQa5NmGirr9gx/TdfCvfhtSBtw41dz6w/PcUPqFnXB1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="357290064"
X-IronPort-AV: E=Sophos;i="6.02,239,1688454000"; 
   d="scan'208";a="357290064"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2023 07:09:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="745903290"
X-IronPort-AV: E=Sophos;i="6.02,239,1688454000"; 
   d="scan'208";a="745903290"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 09 Sep 2023 07:09:25 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qeyeI-0003aY-1X;
        Sat, 09 Sep 2023 14:09:22 +0000
Date:   Sat, 9 Sep 2023 22:08:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Thompson <davthompson@nvidia.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Shravan Kumar Ramani <shravankr@nvidia.com>
Subject: mlxbf-bootctl.c:undefined reference to `sysfs_format_mac'
Message-ID: <202309092107.yUYdtSR9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
config: arm64-randconfig-r032-20210928 (https://download.01.org/0day-ci/archive/20230909/202309092107.yUYdtSR9-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230909/202309092107.yUYdtSR9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309092107.yUYdtSR9-lkp@intel.com/

All errors (new ones prefixed by >>):

   aarch64-linux-ld: drivers/platform/mellanox/mlxbf-bootctl.o: in function `oob_mac_show':
>> mlxbf-bootctl.c:(.text+0x12c8): undefined reference to `sysfs_format_mac'
   mlxbf-bootctl.c:(.text+0x12c8): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `sysfs_format_mac'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
