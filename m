Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0338D7E45FD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjKGQab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjKGQa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:30:29 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CC583
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 08:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699374626; x=1730910626;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=abtFY7YsoLZNUrdKLvq3nUwks/oKbdC5tqfjzJ0a+9A=;
  b=gTJFgkxj7QN07fCg3IJF+spdLr+4D4eq7YkYGGeGISXgRv/wNOMpN5tx
   2cvR3ofuqiiQm9iCCNZ9VFcuZ3QTSCzWr+ONLEq7ZUBF++3zuzos30V5q
   PqGmIhQVObZpYLLduEmVf1QVTNkQSjXtS0MhJ/++CTQWgM5bBRyPUm3hb
   0YbCkQK6XtBvavQLczG1rDianh6uP9c4++smzLYlbDGO5h0lV8UP87c6Q
   BT1z/CR7d+bFHms7ElqORI0FfyGmprCkKSesJ4l5h8jUQh6r698+ojd9n
   w+lJDFddIx1EkjT/i7Wvj/G9Po5fDrdOY0n1IIBiDjppbe8q5o0U87o+N
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="420657288"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="420657288"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 08:30:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="879870029"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="879870029"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 07 Nov 2023 08:30:24 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r0Oy6-0007Da-0c;
        Tue, 07 Nov 2023 16:30:22 +0000
Date:   Wed, 8 Nov 2023 00:29:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: mm/filemap.c:4249:1: sparse: sparse: Using plain integer as NULL
 pointer
Message-ID: <202311080014.GABRIG2T-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   be3ca57cfb777ad820c6659d52e60bbdd36bf5ff
commit: cf264e1329fb0307e044f7675849f9f38b44c11a cachestat: implement cachestat syscall
date:   5 months ago
config: s390-randconfig-r123-20231107 (https://download.01.org/0day-ci/archive/20231108/202311080014.GABRIG2T-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231108/202311080014.GABRIG2T-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311080014.GABRIG2T-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   mm/filemap.c:1416:17: sparse: sparse: context imbalance in 'migration_entry_wait_on_locked' - unexpected unlock
>> mm/filemap.c:4249:1: sparse: sparse: Using plain integer as NULL pointer
>> mm/filemap.c:4249:1: sparse: sparse: Using plain integer as NULL pointer
>> mm/filemap.c:4249:1: sparse: sparse: Using plain integer as NULL pointer
>> mm/filemap.c:4249:1: sparse: sparse: Using plain integer as NULL pointer

vim +4249 mm/filemap.c

  4214	
  4215	/*
  4216	 * The cachestat(2) system call.
  4217	 *
  4218	 * cachestat() returns the page cache statistics of a file in the
  4219	 * bytes range specified by `off` and `len`: number of cached pages,
  4220	 * number of dirty pages, number of pages marked for writeback,
  4221	 * number of evicted pages, and number of recently evicted pages.
  4222	 *
  4223	 * An evicted page is a page that is previously in the page cache
  4224	 * but has been evicted since. A page is recently evicted if its last
  4225	 * eviction was recent enough that its reentry to the cache would
  4226	 * indicate that it is actively being used by the system, and that
  4227	 * there is memory pressure on the system.
  4228	 *
  4229	 * `off` and `len` must be non-negative integers. If `len` > 0,
  4230	 * the queried range is [`off`, `off` + `len`]. If `len` == 0,
  4231	 * we will query in the range from `off` to the end of the file.
  4232	 *
  4233	 * The `flags` argument is unused for now, but is included for future
  4234	 * extensibility. User should pass 0 (i.e no flag specified).
  4235	 *
  4236	 * Currently, hugetlbfs is not supported.
  4237	 *
  4238	 * Because the status of a page can change after cachestat() checks it
  4239	 * but before it returns to the application, the returned values may
  4240	 * contain stale information.
  4241	 *
  4242	 * return values:
  4243	 *  zero        - success
  4244	 *  -EFAULT     - cstat or cstat_range points to an illegal address
  4245	 *  -EINVAL     - invalid flags
  4246	 *  -EBADF      - invalid file descriptor
  4247	 *  -EOPNOTSUPP - file descriptor is of a hugetlbfs file
  4248	 */
> 4249	SYSCALL_DEFINE4(cachestat, unsigned int, fd,

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
