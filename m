Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1812C7E0B1E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 23:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343901AbjKCWZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 18:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjKCWZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 18:25:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707DFD63
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 15:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699050309; x=1730586309;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Du1SpqA6VHdEc9icB0BqUsAch9xnfE58iJDXei6VCB0=;
  b=a7/1Lqo3rCcdk2+nymwGtWKH0G8W85TgSmnXoFftKdvuZLJ9lHgoKwqf
   31r/UN/86MaKNIA9047Tqit3c2JQzVChCOxiPm3pBqFzJO7sllOamBpjC
   Maume/5uIlaZCCr43k2rzqyt8fgsqXJ0ysH5rxMfkq0bpvg0aZX19a3Xd
   5OD3iRubzEL//qzyjUyyaq7Yqz+kmgFD9u2m/oBY/as4oAUHGITyhYPAo
   OZV7hgT+eWX1uGlIXPQQ5Xk3reYv6iYcVka6es0y6WdEdQuSSovvS4g83
   3VJLM+HqruVLTWdTMU4ntG8+jTZnoCB3an5gc8khCeO9SK1S8XPNu+n16
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="388858983"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="388858983"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 15:25:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="765393282"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="765393282"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 03 Nov 2023 15:25:07 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qz2bB-00030B-18;
        Fri, 03 Nov 2023 22:25:05 +0000
Date:   Sat, 4 Nov 2023 06:24:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: drivers/net/wireless/intel/iwlwifi/fw/acpi.c:1190:25: warning: '%s'
 directive argument is null
Message-ID: <202311040602.sCjU3UXr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sunil,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e392ea4d4d00880bf94550151b1ace4f88a4b17a
commit: a91a9ffbd3a55a0ae1bb75e2b6e85b2a03f64e8f RISC-V: Add support to build the ACPI core
date:   5 months ago
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20231104/202311040602.sCjU3UXr-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231104/202311040602.sCjU3UXr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311040602.sCjU3UXr-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/wireless/intel/iwlwifi/fw/acpi.c:9:
   drivers/net/wireless/intel/iwlwifi/fw/acpi.c: In function 'iwl_acpi_is_ppag_approved':
>> drivers/net/wireless/intel/iwlwifi/fw/acpi.c:1190:25: warning: '%s' directive argument is null [-Wformat-overflow=]
    1190 |                         "System vendor '%s' is not in the approved list, disabling PPAG.\n",
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-debug.h:91:56: note: in definition of macro '__IWL_DEBUG_DEV'
      91 |                 __iwl_dbg(dev, level, limit, __func__, fmt, ##args);    \
         |                                                        ^~~
   drivers/net/wireless/intel/iwlwifi/iwl-debug.h:209:41: note: in expansion of macro 'IWL_DEBUG'
     209 | #define IWL_DEBUG_RADIO(p, f, a...)     IWL_DEBUG(p, IWL_DL_RADIO, f, ## a)
         |                                         ^~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/fw/acpi.c:1189:17: note: in expansion of macro 'IWL_DEBUG_RADIO'
    1189 |                 IWL_DEBUG_RADIO(fwrt,
         |                 ^~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/fw/acpi.c:1190:41: note: format string is defined here
    1190 |                         "System vendor '%s' is not in the approved list, disabling PPAG.\n",
         |                                         ^~


vim +1190 drivers/net/wireless/intel/iwlwifi/fw/acpi.c

e8e10a37c51c08 Matt Chen 2022-03-04  1187  
e8e10a37c51c08 Matt Chen 2022-03-04  1188  	if (!dmi_check_system(dmi_ppag_approved_list)) {
e8e10a37c51c08 Matt Chen 2022-03-04  1189  		IWL_DEBUG_RADIO(fwrt,
e8e10a37c51c08 Matt Chen 2022-03-04 @1190  			"System vendor '%s' is not in the approved list, disabling PPAG.\n",

:::::: The code at line 1190 was first introduced by commit
:::::: e8e10a37c51c08b99d272b2e1b3ef70fcd38f9e8 iwlwifi: acpi: move ppag code from mvm to fw/acpi

:::::: TO: Matt Chen <matt.chen@intel.com>
:::::: CC: Luca Coelho <luciano.coelho@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
