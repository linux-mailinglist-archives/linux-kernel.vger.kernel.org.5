Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F847CEC0A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 01:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjJRXam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 19:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjJRXag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 19:30:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79AE116
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 16:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697671835; x=1729207835;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XYmTFSuYLOrfa5SSs65gm16cQyePHty0bHzTVLsfZXY=;
  b=BY4MkwOQoBQqC/aKTBp49HqcF3W06XySGIDLY/NWy5fOV4zIwbRtJbAw
   En5kOPFM2t542ZWuqAvXjAqng7CrGhWMcmaIIWI9UMkQkB7+cT0xs9wVR
   vpvzKD4AnQTip3bnXiJfcSCXf1T+wc5plwYt0RG58QK6+qK1gFGx9eWqU
   I/TUshakrb38/qk+tRmwOiBTumbd7q9f2Ny9vQCzTe6uAZzqv/542eP0K
   eyQMjs9zz14njBd0fzw5qp4yEgqbwqdoFOG74/ZxnFrwcbI09aCIUgrAH
   +Osu0WKPLj10D5UAeWzF4eCifWbgMqgHiBYcruBKzehLLP/uEen1Ai9tl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="4730909"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="4730909"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 16:30:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="822621143"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="822621143"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 18 Oct 2023 16:30:33 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qtFzi-0001Eu-2v;
        Wed, 18 Oct 2023 23:30:30 +0000
Date:   Thu, 19 Oct 2023 07:30:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/powerpc/platforms/pseries/lpar.c:2032:36: error: '%ld'
 directive writing between 1 and 20 bytes into a region of size 12
Message-ID: <202310190736.sgDpsRRj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dd72f9c7e512da377074d47d990564959b772643
commit: 33e67710beda78aed38a2fe10be6088d4aeb1c53 cpumask: switch for_each_cpu{,_not} to use for_each_bit()
date:   1 year, 1 month ago
config: powerpc64-randconfig-r003-20220418 (https://download.01.org/0day-ci/archive/20231019/202310190736.sgDpsRRj-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231019/202310190736.sgDpsRRj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310190736.sgDpsRRj-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/powerpc/platforms/pseries/lpar.c: In function '__machine_initcall_pseries_vpa_debugfs_init':
>> arch/powerpc/platforms/pseries/lpar.c:2032:36: error: '%ld' directive writing between 1 and 20 bytes into a region of size 12 [-Werror=format-overflow=]
    2032 |                 sprintf(name, "cpu-%ld", i);
         |                                    ^~~
   In function 'vpa_debugfs_init',
       inlined from '__machine_initcall_pseries_vpa_debugfs_init' at arch/powerpc/platforms/pseries/lpar.c:2038:1:
   arch/powerpc/platforms/pseries/lpar.c:2032:31: note: directive argument in the range [-9223372036854775808, 4294967294]
    2032 |                 sprintf(name, "cpu-%ld", i);
         |                               ^~~~~~~~~
   arch/powerpc/platforms/pseries/lpar.c:2032:17: note: 'sprintf' output between 6 and 25 bytes into a destination of size 16
    2032 |                 sprintf(name, "cpu-%ld", i);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
   arch/powerpc/sysdev/xive/common.c: In function 'xive_core_debug_init':
>> arch/powerpc/sysdev/xive/common.c:1845:50: error: '%ld' directive output may be truncated writing between 1 and 20 bytes into a region of size 13 [-Werror=format-truncation=]
    1845 |                 snprintf(name, sizeof(name), "cpu%ld", cpu);
         |                                                  ^~~
   In function 'xive_core_debugfs_create',
       inlined from 'xive_core_debug_init' at arch/powerpc/sysdev/xive/common.c:1861:3:
   arch/powerpc/sysdev/xive/common.c:1845:46: note: directive argument in the range [-9223372036854775808, 4294967294]
    1845 |                 snprintf(name, sizeof(name), "cpu%ld", cpu);
         |                                              ^~~~~~~~
   arch/powerpc/sysdev/xive/common.c:1845:17: note: 'snprintf' output between 5 and 24 bytes into a destination of size 16
    1845 |                 snprintf(name, sizeof(name), "cpu%ld", cpu);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +2032 arch/powerpc/platforms/pseries/lpar.c

c6c26fb55e8e4b Aravinda Prasad  2018-10-16  2018  
c6c26fb55e8e4b Aravinda Prasad  2018-10-16  2019  static int __init vpa_debugfs_init(void)
c6c26fb55e8e4b Aravinda Prasad  2018-10-16  2020  {
c6c26fb55e8e4b Aravinda Prasad  2018-10-16  2021  	char name[16];
c6c26fb55e8e4b Aravinda Prasad  2018-10-16  2022  	long i;
11dd34f3eae5a4 YueHaibing       2019-02-18  2023  	struct dentry *vpa_dir;
c6c26fb55e8e4b Aravinda Prasad  2018-10-16  2024  
c6c26fb55e8e4b Aravinda Prasad  2018-10-16  2025  	if (!firmware_has_feature(FW_FEATURE_SPLPAR))
c6c26fb55e8e4b Aravinda Prasad  2018-10-16  2026  		return 0;
c6c26fb55e8e4b Aravinda Prasad  2018-10-16  2027  
dbf77fed8b302e Aneesh Kumar K.V 2021-08-12  2028  	vpa_dir = debugfs_create_dir("vpa", arch_debugfs_dir);
c6c26fb55e8e4b Aravinda Prasad  2018-10-16  2029  
c6c26fb55e8e4b Aravinda Prasad  2018-10-16  2030  	/* set up the per-cpu vpa file*/
c6c26fb55e8e4b Aravinda Prasad  2018-10-16  2031  	for_each_possible_cpu(i) {
c6c26fb55e8e4b Aravinda Prasad  2018-10-16 @2032  		sprintf(name, "cpu-%ld", i);

:::::: The code at line 2032 was first introduced by commit
:::::: c6c26fb55e8e4b3fc376be5611685990a17de27a powerpc/pseries: Export raw per-CPU VPA data via debugfs

:::::: TO: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
