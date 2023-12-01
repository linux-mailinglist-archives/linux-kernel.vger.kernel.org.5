Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C9480001C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377567AbjLAAPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 19:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377412AbjLAAPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:15:10 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE23E199F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 16:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701389703; x=1732925703;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=F45eBiwVykne8RrSCsrvX+aJ+5zGswwLedZbIjpG3S0=;
  b=d7v6R5saxanGHTcEY+lzni8tyF29hEQtCZbeSq8k9C0RFN5iz8pcpTx3
   u74V0FHnBJqTndq1K0sLKibuhDCr95LWhZVjL5N+ephNPFMsbcvA3USWJ
   pw8zE7I9f5XdQOLAx9WzmkcsfX9F0OyZ6ygkx9Zqk9mrJBmP6KwWjK8QA
   euDcWDJ6FU1VL76b8MFJHT4qRqvTyDSIr8L3XKaSbrK9t1JcWd/m5x2RX
   5puAAWD2xjaFLbbif+A615RyCXCltoRV21JUM03zkyrdFPA+GYwshvlgr
   GbQtLtxB/+QQUsTefFdXmtHU/IRyK/ha3PvOBxq06jCCRP8OPVlKQdf0l
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="390576503"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="390576503"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 16:15:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="803862186"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="803862186"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 30 Nov 2023 16:15:01 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r8rBL-0002qG-09;
        Fri, 01 Dec 2023 00:14:59 +0000
Date:   Fri, 1 Dec 2023 08:14:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: ppc476.c:undefined reference to `i2c_register_driver'
Message-ID: <202312010820.cmdwF5X9-lkp@intel.com>
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
head:   3b47bc037bd44f142ac09848e8d3ecccc726be99
commit: 799c43415442414b1032580c47684cb709dfed6d kbuild: thin archives make default for all archs
date:   6 years ago
config: powerpc-randconfig-r026-20220819 (https://download.01.org/0day-ci/archive/20231201/202312010820.cmdwF5X9-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231201/202312010820.cmdwF5X9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312010820.cmdwF5X9-lkp@intel.com/

All errors (new ones prefixed by >>):

   powerpc-linux-ld: warning: drivers/of/unittest-data/overlay_base.dtb.o: missing .note.GNU-stack section implies executable stack
   powerpc-linux-ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
   powerpc-linux-ld: warning: drivers/of/unittest-data/overlay_base.dtb.o: missing .note.GNU-stack section implies executable stack
   powerpc-linux-ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
   powerpc-linux-ld: arch/powerpc/platforms/44x/ppc476.o: in function `avr_halt_system':
   ppc476.c:(.text+0x50): undefined reference to `i2c_smbus_write_byte_data'
   powerpc-linux-ld: arch/powerpc/platforms/44x/ppc476.o: in function `__machine_initcall_ppc47x_ppc47x_device_probe':
>> ppc476.c:(.init.text+0x88): undefined reference to `i2c_register_driver'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
