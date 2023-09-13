Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3027579E494
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 12:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239583AbjIMKIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 06:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236742AbjIMKI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 06:08:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527FA19B3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 03:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694599702; x=1726135702;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yzqMZbUkE5IAiTLtJyHUMRqGU4HUARopLDxLmEnhssk=;
  b=XmYvpD0EjpnksKKvI9y4+yL4RyiOQt1J9KI8LXZDijypYWfxi73qdNG2
   mN4uVEz3qEByt6TXu/2/wCVICkPVp+gOqbb0XT0dC3CrkK2uo772qRGyb
   5ci5AiV2ExiTvGccuzw4dMQKXfwHjRwsr649owEK2jyCq7I5wLXCHjtUc
   ZIxjWfEyyfWiqtGkFqLcujmu8xrEOiuopzAGDag167khd4MiU++G4dlhH
   MLEcrHZ0UBE5l1K63GjBDDUa0apCxh5chdH8gF3xjeFi/KVhlgnHnF89d
   jtrdPIiKCP5vPEjnA+tGRBIz1SQtx6OkQvyraNkY21JpktiT17GNI1/vw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="358052262"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="358052262"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 03:08:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="887271678"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="887271678"
Received: from lkp-server02.sh.intel.com (HELO cf13c67269a2) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 13 Sep 2023 03:07:51 -0700
Received: from kbuild by cf13c67269a2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgMnC-0000N7-1l;
        Wed, 13 Sep 2023 10:08:18 +0000
Date:   Wed, 13 Sep 2023 18:07:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: arch/mips/include/asm/barrier.h:(.text.db1100_mmc_cd+0x1c):
 undefined reference to `mmc_detect_change'
Message-ID: <202309131725.kaSjigzn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3669558bdf354cd352be955ef2764cde6a9bf5ec
commit: d4a5c59a955bba96b273ec1a5885bada24c56979 mmc: au1xmmc: force non-modular build and remove symbol_get usage
date:   6 weeks ago
config: mips-randconfig-r013-20211017 (https://download.01.org/0day-ci/archive/20230913/202309131725.kaSjigzn-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230913/202309131725.kaSjigzn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309131725.kaSjigzn-lkp@intel.com/

All errors (new ones prefixed by >>):

   mipsel-linux-ld: arch/mips/alchemy/devboards/db1000.o: in function `db1100_mmc_cd':
>> arch/mips/include/asm/barrier.h:(.text.db1100_mmc_cd+0x1c): undefined reference to `mmc_detect_change'
   mipsel-linux-ld: arch/mips/alchemy/devboards/db1200.o: in function `pb1200_mmc1_cdfn':
>> arch/mips/include/asm/barrier.h:(.text.pb1200_mmc1_cdfn+0x28): undefined reference to `mmc_detect_change'
   mipsel-linux-ld: arch/mips/alchemy/devboards/db1200.o: in function `db1200_mmc_cdfn':
>> arch/mips/include/asm/barrier.h:(.text.db1200_mmc_cdfn+0x28): undefined reference to `mmc_detect_change'
   mipsel-linux-ld: arch/mips/alchemy/devboards/db1300.o: in function `db1300_mmc_cdfn':
>> arch/mips/include/asm/barrier.h:(.text.db1300_mmc_cdfn+0x28): undefined reference to `mmc_detect_change'
   mipsel-linux-ld: arch/mips/alchemy/devboards/db1300.o: in function `db1300_wm97xx_probe':
   arch/mips/include/asm/barrier.h:(.text.db1300_wm97xx_probe+0x30): undefined reference to `wm97xx_config_gpio'
   mipsel-linux-ld: arch/mips/include/asm/barrier.h:(.text.db1300_wm97xx_probe+0x50): undefined reference to `wm97xx_config_gpio'
   mipsel-linux-ld: arch/mips/include/asm/barrier.h:(.text.db1300_wm97xx_probe+0x70): undefined reference to `wm97xx_register_mach_ops'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
