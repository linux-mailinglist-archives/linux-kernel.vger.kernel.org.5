Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA3B7E058E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 16:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbjKCP2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 11:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjKCP2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 11:28:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC05DB8
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 08:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699025311; x=1730561311;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hynph1M8Ibd6GNZ7OW5P7kCTBCahqEz1ha5NGWCOJDM=;
  b=EQ4cCUz5caPms2qvZJ3lXmKP91sNbGe/vudV3QAl2xtCO+mwqLOucF0J
   t7rpmhRzXccLPa7YMg9Tm0uyTex6mWwhUd4QNUlIaABlib0eg+PjT0XHA
   rt/iIF0qUU9Ycxxz2NMLZSMua6oD36J9oVo1AY8rDYIILkoN7KwDu+PdO
   UotzWGPaqqz54x3GNhbxdrHFRut4jIg5XfwOmJzLwINWql/16elv04eNG
   UIhNOEtLFgt8dsBEYySuV2u/zf5pA2ZcBVVg/5T3JQRxpmhBsdKyHznGg
   iEFKMZoZldGU9qCyV/mgheH7amTaAZBKlUFo+1RZKmBuMO8tsEJkVodP5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="368307138"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="368307138"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 08:28:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="852291921"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="852291921"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Nov 2023 08:28:30 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qyw60-0002dA-03;
        Fri, 03 Nov 2023 15:28:28 +0000
Date:   Fri, 3 Nov 2023 23:27:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/sparc/kernel/traps_64.c:2839:13: warning: no previous prototype
 for 'trap_init'
Message-ID: <202311032350.zdir71xr-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8f6f76a6a29f36d2f3e4510d0bde5046672f6924
commit: 7e09cb0b84ac5d17086a65ca21479dfec600a232 of: Drop cpu.h include from of_device.h
date:   7 months ago
config: sparc-sparc64_defconfig (https://download.01.org/0day-ci/archive/20231103/202311032350.zdir71xr-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231103/202311032350.zdir71xr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311032350.zdir71xr-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/sparc/kernel/traps_64.c:252:6: warning: no previous prototype for 'is_no_fault_exception' [-Wmissing-prototypes]
     252 | bool is_no_fault_exception(struct pt_regs *regs)
         |      ^~~~~~~~~~~~~~~~~~~~~
   arch/sparc/kernel/traps_64.c:2034:6: warning: no previous prototype for 'do_mcd_err' [-Wmissing-prototypes]
    2034 | void do_mcd_err(struct pt_regs *regs, struct sun4v_error_entry ent)
         |      ^~~~~~~~~~
   arch/sparc/kernel/traps_64.c:2152:6: warning: no previous prototype for 'sun4v_nonresum_error_user_handled' [-Wmissing-prototypes]
    2152 | bool sun4v_nonresum_error_user_handled(struct pt_regs *regs,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/sparc/kernel/traps_64.c:2839:13: warning: no previous prototype for 'trap_init' [-Wmissing-prototypes]
    2839 | void __init trap_init(void)
         |             ^~~~~~~~~


vim +/trap_init +2839 arch/sparc/kernel/traps_64.c

^1da177e4c3f415 arch/sparc64/kernel/traps.c Linus Torvalds 2005-04-16  2837  
^1da177e4c3f415 arch/sparc64/kernel/traps.c Linus Torvalds 2005-04-16  2838  /* Only invoked on boot processor. */
^1da177e4c3f415 arch/sparc64/kernel/traps.c Linus Torvalds 2005-04-16 @2839  void __init trap_init(void)

:::::: The code at line 2839 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
