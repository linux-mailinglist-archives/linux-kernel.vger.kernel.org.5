Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3055B7CE16E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344773AbjJRPpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbjJRPpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:45:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499A511B
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 08:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697643906; x=1729179906;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MP10YohGiPP+OhqmtVYeRkq3ED2HUZXN0Rbya0uXRZY=;
  b=eXV2+k3yNcQcBYygavRyPZOPzn6zpxoR5g9BX9BJm0sy/nd/EXCBi910
   PZu9zbBaRK8GPNABi+5Ez+BTg33B0OO1YxBzQDzGz2fhdZyTQeX+8N3po
   ENEo70U90r1TYQaC37liUGNs3vp1mWR4DKsBf92vTOAe9PwACVRWTmnR6
   nGaws2ZUKgq/pamaqaIYPMGLNIxtsCh0C4H66HjbGhEu8irgZD/wDmhdi
   5ISY4np1Eio02HqQR19AQeQpm15dSCzo0Jc48JhWgMfG2Yqy9mV0rpBUp
   iHem+0ITzhj0rmgfXGsbeTgYfaJMmFmEtuHp2JyPopDcvXmgTUwqsH+2e
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="383263398"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="383263398"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 08:45:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="4587033"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 18 Oct 2023 08:45:08 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qt8jF-0000bQ-2A;
        Wed, 18 Oct 2023 15:45:01 +0000
Date:   Wed, 18 Oct 2023 23:44:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: drivers/net/wireless/intel/iwlwifi/fw/acpi.c:1190:25: warning: '%s'
 directive argument is null
Message-ID: <202310182347.zS9BxqD4-lkp@intel.com>
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
head:   06dc10eae55b5ceabfef287a7e5f16ceea204aa0
commit: a91a9ffbd3a55a0ae1bb75e2b6e85b2a03f64e8f RISC-V: Add support to build the ACPI core
date:   5 months ago
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20231018/202310182347.zS9BxqD4-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231018/202310182347.zS9BxqD4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310182347.zS9BxqD4-lkp@intel.com/

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
--
   In file included from drivers/net/wireless/intel/iwlwifi/mvm/../iwl-trans.h:15,
                    from drivers/net/wireless/intel/iwlwifi/mvm/fw.c:11:
   drivers/net/wireless/intel/iwlwifi/mvm/fw.c: In function 'iwl_mvm_tas_init':
>> drivers/net/wireless/intel/iwlwifi/mvm/fw.c:1167:33: warning: '%s' directive argument is null [-Wformat-overflow=]
    1167 |                                 "System vendor '%s' is not in the approved list, disabling TAS in US and Canada.\n",
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/mvm/../iwl-debug.h:91:56: note: in definition of macro '__IWL_DEBUG_DEV'
      91 |                 __iwl_dbg(dev, level, limit, __func__, fmt, ##args);    \
         |                                                        ^~~
   drivers/net/wireless/intel/iwlwifi/mvm/../iwl-debug.h:209:41: note: in expansion of macro 'IWL_DEBUG'
     209 | #define IWL_DEBUG_RADIO(p, f, a...)     IWL_DEBUG(p, IWL_DL_RADIO, f, ## a)
         |                                         ^~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/mvm/fw.c:1166:17: note: in expansion of macro 'IWL_DEBUG_RADIO'
    1166 |                 IWL_DEBUG_RADIO(mvm,
         |                 ^~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/mvm/fw.c:1167:49: note: format string is defined here
    1167 |                                 "System vendor '%s' is not in the approved list, disabling TAS in US and Canada.\n",
         |                                                 ^~


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
