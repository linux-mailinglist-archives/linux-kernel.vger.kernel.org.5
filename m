Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332487CEEE6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 07:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjJSFI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 01:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbjJSFIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 01:08:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3552C114
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 22:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697692132; x=1729228132;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gziTHjwqV3QCw2NE0vt9SOwL1XAfyFYPhv2V+qjhags=;
  b=i4Hfb2DcMVr1mu5CkSakNSF40V3qz9uYVX4vlwSMtNvayO1HF5y8gET0
   mBxdErJYFssJ2w7bk9RrLoK92DAf0gzKePVfwi1X4QCtj1i3bc+oNvc3k
   4HFyUjTk68YNdxk7lFD9A21zavZf8TZA3aTcE8ynFgchmEm38RFUWpPzL
   gIC2foZXH6fkMXlnfO9G60ki6kQPQ49n7wPJfkmpwT4szJxkLGvmqbP1w
   XYvEXr6pntEa1PmpBibC1bqBorPVE0w4vjPiBFyivDomNCDK6Z8svhzK7
   G95YKTktbK63sXOXtQnlKpr6DPOGCvL6bVqupiTINDjr4ia+Ix0DDzIq4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="390051110"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="390051110"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 22:08:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="760504123"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="760504123"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 18 Oct 2023 22:08:50 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qtLH5-0001ee-2g;
        Thu, 19 Oct 2023 05:08:47 +0000
Date:   Thu, 19 Oct 2023 13:07:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shay Drory <shayd@nvidia.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>
Subject: include/linux/bitops.h:52:11: warning: array subscript 0 is outside
 array bounds of 'long unsigned int[0]'
Message-ID: <202310191307.RwgNqy0s-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dd72f9c7e512da377074d47d990564959b772643
commit: b90ebfc018b087ba1e4981b298b58733236ff296 net/mlx5: Allocate command stats with xarray
date:   3 months ago
config: parisc-randconfig-r006-20230313 (https://download.01.org/0day-ci/archive/20231019/202310191307.RwgNqy0s-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231019/202310191307.RwgNqy0s-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310191307.RwgNqy0s-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:22,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/parisc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/highmem.h:5,
                    from drivers/net/ethernet/mellanox/mlx5/core/main.c:33:
   drivers/net/ethernet/mellanox/mlx5/core/main.c: In function 'mlx5_vf_get_core_dev':
>> include/linux/bitops.h:52:11: warning: array subscript 0 is outside array bounds of 'long unsigned int[0]' [-Warray-bounds=]
      52 |           __builtin_constant_p(*(const unsigned long *)(addr))) ?       \
         |           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitops.h:61:41: note: in expansion of macro 'bitop'
      61 | #define test_bit(nr, addr)              bitop(_test_bit, nr, addr)
         |                                         ^~~~~
   drivers/net/ethernet/mellanox/mlx5/core/main.c:2256:14: note: in expansion of macro 'test_bit'
    2256 |         if (!test_bit(MLX5_INTERFACE_STATE_UP, &mdev->intf_state)) {
         |              ^~~~~~~~
   cc1: note: source object is likely at address zero
   In file included from include/linux/bitops.h:34:
   In function 'generic_test_bit',
       inlined from 'mlx5_vf_get_core_dev' at drivers/net/ethernet/mellanox/mlx5/core/main.c:2256:7:
>> include/asm-generic/bitops/generic-non-atomic.h:128:27: warning: array subscript 0 is outside array bounds of 'long unsigned int[0]' [-Warray-bounds=]
     128 |         return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
         |                       ~~~~^~~~~~~~~~~~~~
   In function 'mlx5_vf_get_core_dev':
   cc1: note: source object is likely at address zero


vim +52 include/linux/bitops.h

0e862838f29014 Alexander Lobakin 2022-06-24  35  
b03fc1173c0c2b Alexander Lobakin 2022-06-24  36  /*
b03fc1173c0c2b Alexander Lobakin 2022-06-24  37   * Many architecture-specific non-atomic bitops contain inline asm code and due
b03fc1173c0c2b Alexander Lobakin 2022-06-24  38   * to that the compiler can't optimize them to compile-time expressions or
b03fc1173c0c2b Alexander Lobakin 2022-06-24  39   * constants. In contrary, generic_*() helpers are defined in pure C and
b03fc1173c0c2b Alexander Lobakin 2022-06-24  40   * compilers optimize them just well.
b03fc1173c0c2b Alexander Lobakin 2022-06-24  41   * Therefore, to make `unsigned long foo = 0; __set_bit(BAR, &foo)` effectively
b03fc1173c0c2b Alexander Lobakin 2022-06-24  42   * equal to `unsigned long foo = BIT(BAR)`, pick the generic C alternative when
b03fc1173c0c2b Alexander Lobakin 2022-06-24  43   * the arguments can be resolved at compile time. That expression itself is a
b03fc1173c0c2b Alexander Lobakin 2022-06-24  44   * constant and doesn't bring any functional changes to the rest of cases.
b03fc1173c0c2b Alexander Lobakin 2022-06-24  45   * The casts to `uintptr_t` are needed to mitigate `-Waddress` warnings when
b03fc1173c0c2b Alexander Lobakin 2022-06-24  46   * passing a bitmap from .bss or .data (-> `!!addr` is always true).
b03fc1173c0c2b Alexander Lobakin 2022-06-24  47   */
e69eb9c460f128 Alexander Lobakin 2022-06-24  48  #define bitop(op, nr, addr)						\
b03fc1173c0c2b Alexander Lobakin 2022-06-24  49  	((__builtin_constant_p(nr) &&					\
b03fc1173c0c2b Alexander Lobakin 2022-06-24  50  	  __builtin_constant_p((uintptr_t)(addr) != (uintptr_t)NULL) &&	\
b03fc1173c0c2b Alexander Lobakin 2022-06-24  51  	  (uintptr_t)(addr) != (uintptr_t)NULL &&			\
b03fc1173c0c2b Alexander Lobakin 2022-06-24 @52  	  __builtin_constant_p(*(const unsigned long *)(addr))) ?	\
b03fc1173c0c2b Alexander Lobakin 2022-06-24  53  	 const##op(nr, addr) : op(nr, addr))
e69eb9c460f128 Alexander Lobakin 2022-06-24  54  

:::::: The code at line 52 was first introduced by commit
:::::: b03fc1173c0c2bb8fad61902a862985cecdc4b1b bitops: let optimize out non-atomic bitops on compile-time constants

:::::: TO: Alexander Lobakin <alexandr.lobakin@intel.com>
:::::: CC: Yury Norov <yury.norov@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
