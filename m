Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6777A5FDD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 12:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbjISKnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 06:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjISKnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:43:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2767BE8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 03:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695120185; x=1726656185;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HweMeV3StQaTObldLMr5619inUbeHhG0ufZI8LmTruE=;
  b=YRAWd9YPovFU3oXMAPK36IVyVEBO5IqCGiEbjHE+6tJ8cIUlqsxiJNz1
   +zqlkTOX4hmlRDv3xyD/rK3PhDo8saSEDkPjWF3oyURk2uPUC2GXEwHJm
   LI4xc7NkqzfFpvgnVCPBUJKULJuvdJeFqAgJVElNRiryR9j5TrsS2CF7F
   3PiAeFUcAZxttAfYQpGcqpE4JjZiBsQdObwA77YLA2EOgRzuWEYrqqna9
   Qqs4qb0feDrJ1L+mYbcrKeygBCvi9aD/1EIY89Kd8iuFMXKf3zgQvZ6S3
   IFxszfM1kj35Fh8GGY+xyOD7lKdgONtl2d02R16Z7J88fr/Dvi90gdpO4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="379810572"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="379810572"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 03:43:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="739637974"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="739637974"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 19 Sep 2023 03:43:02 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qiYC4-0007EC-1r;
        Tue, 19 Sep 2023 10:43:00 +0000
Date:   Tue, 19 Sep 2023 18:42:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexander Larsson <alexl@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: arch/alpha/include/asm/rwonce.h:25:35: warning: array subscript 0 is
 outside array bounds of 'struct inode[11885788707287082]'
Message-ID: <202309191848.cMwd2D4d-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2cf0f715623872823a72e451243bbf555d10d032
commit: 0af950f57fefabab628f1963af881e6b9bfe7f38 ovl: move ovl_entry into ovl_inode
date:   3 months ago
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20230919/202309191848.cMwd2D4d-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230919/202309191848.cMwd2D4d-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309191848.cMwd2D4d-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/compiler.h:246,
                    from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/wait.h:7,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from fs/overlayfs/util.c:7:
   In function 'ovl_upperdentry_dereference',
       inlined from 'ovl_dentry_upper' at fs/overlayfs/util.c:266:9,
       inlined from 'ovl_path_type' at fs/overlayfs/util.c:184:6:
>> arch/alpha/include/asm/rwonce.h:25:35: warning: array subscript 0 is outside array bounds of 'struct inode[11885788707287082]' [-Warray-bounds=]
      25 |         __unqual_scalar_typeof(x) __x =                                 \
         |                                   ^~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   fs/overlayfs/ovl_entry.h:163:16: note: in expansion of macro 'READ_ONCE'
     163 |         return READ_ONCE(oi->__upperdentry);
         |                ^~~~~~~~~


vim +25 arch/alpha/include/asm/rwonce.h

d6462858851549 Will Deacon 2019-10-30  11  
d6462858851549 Will Deacon 2019-10-30  12  /*
d6462858851549 Will Deacon 2019-10-30  13   * Alpha is apparently daft enough to reorder address-dependent loads
d6462858851549 Will Deacon 2019-10-30  14   * on some CPU implementations. Knock some common sense into it with
d6462858851549 Will Deacon 2019-10-30  15   * a memory barrier in READ_ONCE().
d6462858851549 Will Deacon 2019-10-30  16   *
d6462858851549 Will Deacon 2019-10-30  17   * For the curious, more information about this unusual reordering is
d6462858851549 Will Deacon 2019-10-30  18   * available in chapter 15 of the "perfbook":
d6462858851549 Will Deacon 2019-10-30  19   *
d6462858851549 Will Deacon 2019-10-30  20   *  https://kernel.org/pub/linux/kernel/people/paulmck/perfbook/perfbook.html
d6462858851549 Will Deacon 2019-10-30  21   *
d6462858851549 Will Deacon 2019-10-30  22   */
d6462858851549 Will Deacon 2019-10-30  23  #define __READ_ONCE(x)							\
d6462858851549 Will Deacon 2019-10-30  24  ({									\
d6462858851549 Will Deacon 2019-10-30 @25  	__unqual_scalar_typeof(x) __x =					\
d6462858851549 Will Deacon 2019-10-30  26  		(*(volatile typeof(__x) *)(&(x)));			\
d6462858851549 Will Deacon 2019-10-30  27  	mb();								\
d6462858851549 Will Deacon 2019-10-30  28  	(typeof(x))__x;							\
d6462858851549 Will Deacon 2019-10-30  29  })
d6462858851549 Will Deacon 2019-10-30  30  

:::::: The code at line 25 was first introduced by commit
:::::: d6462858851549c62d73eaa14b31132b0f32d6b6 alpha: Override READ_ONCE() with barriered implementation

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
