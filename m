Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9D47FF3D6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346379AbjK3Poj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjK3Poi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:44:38 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA377D4A;
        Thu, 30 Nov 2023 07:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701359085; x=1732895085;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yTVB9ftg0pvX/GWyIwf9wN47bXSiOb29mW5fNamuZCM=;
  b=dBRPXv/8GeJw0yOx/S/HCEUn+T0l8bkBS0BGzMl76R/InbIvAPPyKx18
   GZBzH8npjJfmfv6Wb/csWeDcts+BxbllYbAtc+XfqZ+j9W9BD4OiN6Dyi
   t7Qsx5wc9aUDPFOnb01gZuTIJR7fHgzUJxn40zN0wq1Mk/W2sY7Eo761R
   nAFecosuru9jctYvEkb0B/IOg8S/a4dlrcEEPkTGlPg89PQkjP1sX6D1T
   i/pE+Uf3VyruyAGl9emjPQLlNqvE/MgZW1izrZGemZV4qZ+qzNAcqg+tx
   LwsCWYCkrltBmeJtFGSb7Pv6qsDMrJtcayf7l9k7ZB+iadri3BBdrbevP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="14888695"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="14888695"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 07:44:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="773092655"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="773092655"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 30 Nov 2023 07:44:28 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r8jDG-0002Fd-1k;
        Thu, 30 Nov 2023 15:44:26 +0000
Date:   Thu, 30 Nov 2023 23:43:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sagi Maimon <maimon.sagi@gmail.com>, richardcochran@gmail.com,
        reibax@gmail.com, davem@davemloft.net, rrameshbabu@nvidia.com
Cc:     oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, maheshb@google.com,
        maimon.sagi@gmail.com
Subject: Re: [PATCH v2] posix-timers: add multi_clock_gettime system call
Message-ID: <202311302333.CokAopgU-lkp@intel.com>
References: <20231127153901.6399-1-maimon.sagi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127153901.6399-1-maimon.sagi@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sagi,

kernel test robot noticed the following build errors:

[auto build test ERROR on arnd-asm-generic/master]
[also build test ERROR on tip/timers/core linus/master v6.7-rc3]
[cannot apply to tip/x86/asm next-20231130]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sagi-Maimon/posix-timers-add-multi_clock_gettime-system-call/20231128-000215
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
patch link:    https://lore.kernel.org/r/20231127153901.6399-1-maimon.sagi%40gmail.com
patch subject: [PATCH v2] posix-timers: add multi_clock_gettime system call
config: arc-randconfig-001-20231130 (https://download.01.org/0day-ci/archive/20231130/202311302333.CokAopgU-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231130/202311302333.CokAopgU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311302333.CokAopgU-lkp@intel.com/

All errors (new ones prefixed by >>):

   arceb-elf-ld: drivers/greybus/gb-beagleplay.o: in function `hdlc_tx_frames':
   gb-beagleplay.c:(.text+0x184): undefined reference to `crc_ccitt'
   arceb-elf-ld: gb-beagleplay.c:(.text+0x184): undefined reference to `crc_ccitt'
   arceb-elf-ld: gb-beagleplay.c:(.text+0x1f2): undefined reference to `crc_ccitt'
   arceb-elf-ld: gb-beagleplay.c:(.text+0x1f2): undefined reference to `crc_ccitt'
   arceb-elf-ld: gb-beagleplay.c:(.text+0x28c): undefined reference to `crc_ccitt'
   arceb-elf-ld: drivers/greybus/gb-beagleplay.o:gb-beagleplay.c:(.text+0x28c): more undefined references to `crc_ccitt' follow
>> arceb-elf-ld: arch/arc/kernel/sys.o:(.data+0x728): undefined reference to `sys_multi_clock_gettime'
>> arceb-elf-ld: arch/arc/kernel/sys.o:(.data+0x728): undefined reference to `sys_multi_clock_gettime'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
