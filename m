Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3517E7CD9F2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjJRK7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjJRK7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:59:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3C9EA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 03:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697626776; x=1729162776;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iNchPBy+GLO0AHcCt2JFOY0IPNG1RyEB4B2/HF/7DIo=;
  b=jYUYEBB0SFnB/H4CFH53X6EiQ9se4GMXbnqDy+ur4kn6N5MkdehswBIb
   okiiRKGpCdKHDfq363/X/Xf3w1SQyP6ZCqEGoA1L/oQspHFZgOjWTGR4z
   K3FBzLvEemX8EEOoUWCP0JiSsL4R6gNlUZO/n8marxnPOyD0OJoWAYsze
   00yTa+vxH9FpLFCq3d+pmYvKxRIclMX1duRrp52M1kwt0FeVMCHjzLW5O
   4ugZRGZnxtE3jLFNnTJLBmHiXvGKz7d3NUBONlB0Ie0+JHDftZxo+FGXx
   VYzUchMQAQZtR+rAbxuqo8NB2z9AOKw1uPm7Q8Yys6GfTu29m3wkoyJLW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="417104407"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="417104407"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 03:59:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="822399893"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="822399893"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 18 Oct 2023 03:59:34 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qt4Gy-0000GW-2g;
        Wed, 18 Oct 2023 10:59:32 +0000
Date:   Wed, 18 Oct 2023 18:59:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: include/linux/fortify-string.h:59:33: warning: '__builtin_memset'
 specified bound 18446744073709551615 exceeds maximum object size
 9223372036854775807
Message-ID: <202310181852.t3zhZN02-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   06dc10eae55b5ceabfef287a7e5f16ceea204aa0
commit: 439a1bcac648fe9b59210cde8991fb2acf37bdab fortify: Use __builtin_dynamic_object_size() when available
date:   10 months ago
config: s390-randconfig-r002-20230326 (https://download.01.org/0day-ci/archive/20231018/202310181852.t3zhZN02-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231018/202310181852.t3zhZN02-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310181852.t3zhZN02-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/string.h:253,
                    from include/linux/bitmap.h:11,
                    from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:15,
                    from drivers/misc/lkdtm/usercopy.c:7:
   drivers/misc/lkdtm/usercopy.c: In function 'do_usercopy_slab_size':
>> include/linux/fortify-string.h:59:33: warning: '__builtin_memset' specified bound 18446744073709551615 exceeds maximum object size 9223372036854775807 [-Wstringop-overflow=]
      59 | #define __underlying_memset     __builtin_memset
         |                                 ^
   include/linux/fortify-string.h:453:9: note: in expansion of macro '__underlying_memset'
     453 |         __underlying_memset(p, c, __fortify_size);                      \
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:461:25: note: in expansion of macro '__fortify_memset_chk'
     461 | #define memset(p, c, s) __fortify_memset_chk(p, c, s,                   \
         |                         ^~~~~~~~~~~~~~~~~~~~
   drivers/misc/lkdtm/usercopy.c:157:9: note: in expansion of macro 'memset'
     157 |         memset(one, 'A', size);
         |         ^~~~~~


vim +/__builtin_memset +59 include/linux/fortify-string.h

78a498c3a227f2 Alexander Potapenko 2022-10-24  46  
78a498c3a227f2 Alexander Potapenko 2022-10-24  47  #if defined(__SANITIZE_MEMORY__)
78a498c3a227f2 Alexander Potapenko 2022-10-24  48  /*
78a498c3a227f2 Alexander Potapenko 2022-10-24  49   * For KMSAN builds all memcpy/memset/memmove calls should be replaced by the
78a498c3a227f2 Alexander Potapenko 2022-10-24  50   * corresponding __msan_XXX functions.
78a498c3a227f2 Alexander Potapenko 2022-10-24  51   */
78a498c3a227f2 Alexander Potapenko 2022-10-24  52  #include <linux/kmsan_string.h>
78a498c3a227f2 Alexander Potapenko 2022-10-24  53  #define __underlying_memcpy	__msan_memcpy
78a498c3a227f2 Alexander Potapenko 2022-10-24  54  #define __underlying_memmove	__msan_memmove
78a498c3a227f2 Alexander Potapenko 2022-10-24  55  #define __underlying_memset	__msan_memset
78a498c3a227f2 Alexander Potapenko 2022-10-24  56  #else
a28a6e860c6cf2 Francis Laniel      2021-02-25  57  #define __underlying_memcpy	__builtin_memcpy
a28a6e860c6cf2 Francis Laniel      2021-02-25  58  #define __underlying_memmove	__builtin_memmove
a28a6e860c6cf2 Francis Laniel      2021-02-25 @59  #define __underlying_memset	__builtin_memset
78a498c3a227f2 Alexander Potapenko 2022-10-24  60  #endif
78a498c3a227f2 Alexander Potapenko 2022-10-24  61  

:::::: The code at line 59 was first introduced by commit
:::::: a28a6e860c6cf231cf3c5171c75c342adcd00406 string.h: move fortified functions definitions in a dedicated header.

:::::: TO: Francis Laniel <laniel_francis@privacyrequired.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
