Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B73812646
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 05:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbjLNEIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 23:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjLNEIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 23:08:38 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FD710A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 20:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702526925; x=1734062925;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3Y7R4VTp73zKHZg31C81x9hZqBtmb8iHYBBV9WEoPOo=;
  b=M3JfrGEOHEbTpeCSM0nCqbNzR9jigwibzyfecHdFD2hydpUxPeNbFLAe
   vsZbmu6SbJP0j2RDZVYunZvDQw7/opjToAMgeHBr9D/3rHinQ4sBNA0pi
   Br9peAO8Y17hIKNMos4dnPNeBBSuGXGh1OdycjRt6Z4GMfjznrcGfXxuM
   2JlbuFzCPVVr8TiI2LlHDjM9abjHvU6fcOmfFd/g8okqgTwHIbnz/DCwQ
   xBz+2xbVU31rTS0fVXUiVegUV8WQbWt2fpWpdyTLrb9+mfX9h454ZJnYN
   9a5DwbkqhPS9tFXjUMBYm24EK8UYR85ClfXB8wjYlBflY7Yv7QMn9IEMI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="394811978"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="394811978"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 20:08:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="777757247"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="777757247"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 13 Dec 2023 20:08:42 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rDd1b-000LW1-2z;
        Thu, 14 Dec 2023 04:08:40 +0000
Date:   Thu, 14 Dec 2023 12:06:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: arch/x86/lib/usercopy_64.c:89: warning: Function parameter or member
 'addr' not described in 'clean_cache_range'
Message-ID: <202312141239.7gLVWsfu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5bd7ef53ffe5ca580e93e74eb8c81ed191ddc4bd
commit: 0aed55af88345b5d673240f90e671d79662fb01e x86, uaccess: introduce copy_from_iter_flushcache for pmem / cache-bypass operations
date:   7 years ago
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20231214/202312141239.7gLVWsfu-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231214/202312141239.7gLVWsfu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312141239.7gLVWsfu-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/lib/usercopy_64.c:89: warning: Function parameter or member 'addr' not described in 'clean_cache_range'
>> arch/x86/lib/usercopy_64.c:89: warning: Excess function parameter 'vaddr' description in 'clean_cache_range'


vim +89 arch/x86/lib/usercopy_64.c

    77	
    78	#ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
    79	/**
    80	 * clean_cache_range - write back a cache range with CLWB
    81	 * @vaddr:	virtual start address
    82	 * @size:	number of bytes to write back
    83	 *
    84	 * Write back a cache range using the CLWB (cache line write back)
    85	 * instruction. Note that @size is internally rounded up to be cache
    86	 * line size aligned.
    87	 */
    88	static void clean_cache_range(void *addr, size_t size)
  > 89	{
    90		u16 x86_clflush_size = boot_cpu_data.x86_clflush_size;
    91		unsigned long clflush_mask = x86_clflush_size - 1;
    92		void *vend = addr + size;
    93		void *p;
    94	
    95		for (p = (void *)((unsigned long)addr & ~clflush_mask);
    96		     p < vend; p += x86_clflush_size)
    97			clwb(p);
    98	}
    99	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
