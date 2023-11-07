Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF497E3A24
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 11:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbjKGKnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 05:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbjKGKnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 05:43:39 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB8AED
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 02:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699353817; x=1730889817;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jUUzY54dsqAgUm1obJ6G2bCd3naWol3fqdxm7lVwtfk=;
  b=e1XlN8P/mAbudNqIXWm1W+hIsIOwfRULI3n7eFsCucFb4f5MGozRoKE6
   OUhNaQl72oXatc2L/PuzifNKtbHPXTTmR6Q5oX49r/h0+hj9+grK11y0D
   v35+V4mfjsY7H+EFd9DIyvv+aBWD5fV46HrC057Ft79gChozyArv/lFt+
   p8/qSiglNr/vbrYOs7RMOP9w8GLhZQnu5xqv3NHiFsGLaYNSU6ta1gu2E
   UmFjOddoQVTCjDckrz+lPE8nrqQvaEZDsWq/FAuUC1HFSKHZQ0G7W2D8J
   t+sK5gElyqDosgPLHnnROTKYn2y3nqD45C+JVSzh6U/Yewfhtvihx6ZU8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="379870230"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="379870230"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 02:43:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="3948370"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 07 Nov 2023 02:43:35 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r0JYT-00073c-0K;
        Tue, 07 Nov 2023 10:43:33 +0000
Date:   Tue, 7 Nov 2023 18:42:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Paul Burton <paulburton@kernel.org>
Subject: arch/mips/sgi-ip30/ip30-console.c:15:6: warning: no previous
 prototype for 'prom_putchar'
Message-ID: <202311071845.jPegp5hN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   be3ca57cfb777ad820c6659d52e60bbdd36bf5ff
commit: 7505576d1c1ac0cfe85fdf90999433dd8b673012 MIPS: add support for SGI Octane (IP30)
date:   4 years ago
config: mips-randconfig-r002-20230825 (https://download.01.org/0day-ci/archive/20231107/202311071845.jPegp5hN-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231107/202311071845.jPegp5hN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311071845.jPegp5hN-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/mips/sgi-ip30/ip30-console.c:15:6: warning: no previous prototype for 'prom_putchar' [-Wmissing-prototypes]
      15 | void prom_putchar(char c)
         |      ^~~~~~~~~~~~


vim +/prom_putchar +15 arch/mips/sgi-ip30/ip30-console.c

    14	
  > 15	void prom_putchar(char c)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
