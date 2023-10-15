Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996257C97E4
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 06:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbjJOEhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 00:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjJOEhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 00:37:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D92DD
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 21:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697344659; x=1728880659;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=a2q9IYUQ7FeFiriCNFDIJooBwHPaJOTF76PPDhNT2j0=;
  b=Z8qOi/ag4FNSjzUyIY/VvfR63cpgwkGqA/u7vhwyhGseYrmGdKxX2g5E
   9o0HFBM2Eq0hYvjLf1Og2AWZWHDZ6jt8XefTeykYDV8M2NlgyK7usetX4
   fmJEgY3BssfXOJJgDZjXXObKtYAiEW9aYLZFO6cJxIIVImJZKbhI4Qo11
   TnqFBfK0Gae2tGtHlWc0PeRJb3TE4HEbXyeQz2drznQMgnWXZHs7F8G4e
   TLgH4TygnEZMNXhDJ3+HWDEblXX4MKn4f6xPDoKGFPnmjm2cNG3YerjdX
   GyWfORKQsfv8EWAFoBoNK2nMZo6Uhet+BZEFwd4u6RgSpC+uLmZZC/1Gu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="471594346"
X-IronPort-AV: E=Sophos;i="6.03,226,1694761200"; 
   d="scan'208";a="471594346"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2023 21:37:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="748855498"
X-IronPort-AV: E=Sophos;i="6.03,226,1694761200"; 
   d="scan'208";a="748855498"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 14 Oct 2023 21:37:36 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qrssf-00072L-2N;
        Sun, 15 Oct 2023 04:37:33 +0000
Date:   Sun, 15 Oct 2023 12:37:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Patricia Alfonso <trishalfonso@google.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        David Gow <davidgow@google.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>
Subject: arch/um/os-Linux/mem.c:28:6: warning: no previous prototype for
 'kasan_map_memory'
Message-ID: <202310151211.jASHBduj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patricia,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9a3dad63edbe9a2ab2be1e7361a2133f519f855b
commit: 5b301409e8bc5d7fad2ee138be44c5c529dd0874 UML: add support for KASAN under x86_64
date:   1 year, 3 months ago
config: um-allnoconfig (https://download.01.org/0day-ci/archive/20231015/202310151211.jASHBduj-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231015/202310151211.jASHBduj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310151211.jASHBduj-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/um/os-Linux/mem.c:28:6: warning: no previous prototype for 'kasan_map_memory' [-Wmissing-prototypes]
      28 | void kasan_map_memory(void *start, size_t len)
         |      ^~~~~~~~~~~~~~~~
   arch/um/os-Linux/mem.c:212:13: warning: no previous prototype for 'check_tmpexec' [-Wmissing-prototypes]
     212 | void __init check_tmpexec(void)
         |             ^~~~~~~~~~~~~


vim +/kasan_map_memory +28 arch/um/os-Linux/mem.c

    19	
    20	/*
    21	 * kasan_map_memory - maps memory from @start with a size of @len.
    22	 * The allocated memory is filled with zeroes upon success.
    23	 * @start: the start address of the memory to be mapped
    24	 * @len: the length of the memory to be mapped
    25	 *
    26	 * This function is used to map shadow memory for KASAN in uml
    27	 */
  > 28	void kasan_map_memory(void *start, size_t len)
    29	{
    30		if (mmap(start,
    31			 len,
    32			 PROT_READ|PROT_WRITE,
    33			 MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE|MAP_NORESERVE,
    34			 -1,
    35			 0) == MAP_FAILED) {
    36			os_info("Couldn't allocate shadow memory: %s\n.",
    37				strerror(errno));
    38			exit(1);
    39		}
    40	}
    41	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
