Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAA57EF799
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 19:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjKQSxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 13:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjKQSxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 13:53:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D141D90
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 10:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700247176; x=1731783176;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eAtpTQ3wMl0uO+JUbnTPU9wK1M2iiRCqPZrPjmYZfAY=;
  b=E9ulgZNUr1S+7OoG16bzwWlOyYQxhr9T78eEoj9veRZTdG9aR7khjCEI
   IXw3a9ZPjlgKlMVcTt8AjTV+h5aM30+XeB300/her9OMxM8+vJGUfFLdG
   4Qicr1J+IVTsNUKT25ihm4egiPgBIMwRv5Xk5tYSIe3PhA/X4Lk2eFO0L
   4akO9s6WNbPqQVat/OXAXpg8LpFKJjJVhEhTlelNAYz/nZbG5gMWSKY0E
   mx/Z1OoKP0vGhHhlW0JlRT1/yweJXu+xDq+vebrJ8t9eK2RL4oIK0X5H/
   DCiowaJq+JYUZH1Ymep6+HlL2kZeAteglgxK9YseZUbxCmAd0OciaXPjM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="422444917"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="422444917"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 10:52:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="6928611"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 17 Nov 2023 10:52:55 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r43xU-00032x-2J;
        Fri, 17 Nov 2023 18:52:52 +0000
Date:   Sat, 18 Nov 2023 02:52:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/splice.c:53:19: sparse: sparse: cast from restricted fmode_t
Message-ID: <202311180228.sLGuM7AA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6bc40e44f1ddef16a787f3501b97f1fff909177c
commit: 0f99fc513ddd28de155c58547824a9fd63daacea splice: clear FMODE_NOWAIT on file if splice/vmsplice is used
date:   7 months ago
config: sparc-randconfig-r021-20230427 (https://download.01.org/0day-ci/archive/20231118/202311180228.sLGuM7AA-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20231118/202311180228.sLGuM7AA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311180228.sLGuM7AA-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/splice.c:53:19: sparse: sparse: cast from restricted fmode_t
>> fs/splice.c:53:19: sparse: sparse: cast from restricted fmode_t
>> fs/splice.c:53:19: sparse: sparse: cast to restricted fmode_t
   fs/splice.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
   include/linux/page-flags.h:246:46: sparse: sparse: self-comparison always evaluates to false

vim +53 fs/splice.c

    39	
    40	/*
    41	 * Splice doesn't support FMODE_NOWAIT. Since pipes may set this flag to
    42	 * indicate they support non-blocking reads or writes, we must clear it
    43	 * here if set to avoid blocking other users of this pipe if splice is
    44	 * being done on it.
    45	 */
    46	static noinline void noinline pipe_clear_nowait(struct file *file)
    47	{
    48		fmode_t fmode = READ_ONCE(file->f_mode);
    49	
    50		do {
    51			if (!(fmode & FMODE_NOWAIT))
    52				break;
  > 53		} while (!try_cmpxchg(&file->f_mode, &fmode, fmode & ~FMODE_NOWAIT));
    54	}
    55	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
