Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3667DF88F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 18:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377170AbjKBRSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 13:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347676AbjKBRSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 13:18:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC301AC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 10:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698945469; x=1730481469;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6/lRIzVgAOoGETCFiDbglY9NWMmHNVkEXyLup1k0O0c=;
  b=DHjJ+dDbgzdbDYs33gTG94P8YJdcxqpFvEuetRcpZ9lvNQoxtC3gvHme
   7kT1XEnqruLFqwyljO2GgB45F2E+iiPnpH/ZWjhsWkgpqUJctXBRFEgIC
   Wi/egdqk0+yrinS5aQdn2YzfJrBTwkfcAvyu53DUABZ7bY+ueZor5PLxj
   LNhS/Tn2ePNYRXFQXI18fQODCoabRWqfV+yjGxQ62Xw3IJVP4UE5ChV7I
   GBpmkzsuu0h2ifmpLqVsy4Y5AIjPHCsfCtyvgPPMxVy9TL4WD9NzyHk++
   oBsUr4AVJrnJI+DmiXaJsH9ZIKDWvT3tYM2dkFH4hp+83z96UIaEy6/JW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="373806339"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="373806339"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 10:17:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="884957850"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="884957850"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 02 Nov 2023 10:17:48 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qybKD-0001hn-2a;
        Thu, 02 Nov 2023 17:17:45 +0000
Date:   Fri, 3 Nov 2023 01:16:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: mm/memfd.c:271:1: sparse: sparse: Using plain integer as NULL pointer
Message-ID: <202311030146.4SJnQUwE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   21e80f3841c01aeaf32d7aee7bbc87b3db1aa0c6
commit: 626e98cb0366e66bdc2088918aecabee1fc6c4b2 mm: make MEMFD_CREATE into a selectable config option
date:   3 months ago
config: s390-randconfig-r133-20231102 (https://download.01.org/0day-ci/archive/20231103/202311030146.4SJnQUwE-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231103/202311030146.4SJnQUwE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311030146.4SJnQUwE-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> mm/memfd.c:271:1: sparse: sparse: Using plain integer as NULL pointer
>> mm/memfd.c:271:1: sparse: sparse: Using plain integer as NULL pointer

vim +271 mm/memfd.c

5d752600a8c373 Mike Kravetz 2018-06-07  270  
5d752600a8c373 Mike Kravetz 2018-06-07 @271  SYSCALL_DEFINE2(memfd_create,

:::::: The code at line 271 was first introduced by commit
:::::: 5d752600a8c373382264392f5b573b2fc9c0e8ea mm: restructure memfd code

:::::: TO: Mike Kravetz <mike.kravetz@oracle.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
