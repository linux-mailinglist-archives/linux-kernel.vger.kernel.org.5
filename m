Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90D87CD987
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjJRKsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjJRKsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:48:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAD1BA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 03:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697626116; x=1729162116;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=J0bXUKH1eRfZ+Pn5mUV7HEF3r604mUJg8ynNSCsWqls=;
  b=l+WZNWTkx+zp87mLHjgJWu1W1u4PJxNa3YzSxJSmfUW2R/jQfsO4+55h
   ospkUUVcszYs30xE3M2t5pHP4okWRMF2yr9xbigx+zKT8nZEF+7KyyYIk
   pniPQ0TLYqg9+wCoD+ggy6ODSBdyeqNjNKd271ROzV/iZmFg46hvyrqKq
   rbgYRgW+y9ZhkTcR3ZBL9ox/2nXw5jivQDXSRu/08MVb49xgonWVH0ApY
   rOeslFlbHAmJjx6Pv98yZ4jxyxcPgOBlWxDMFcOdUzuXF0lVf+bVSWan1
   X+TtJJ7oOQlOryJlTOxwim8G+LSdP34impzlMkTNUzXKWXwX7zYtN0Qjf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="376359118"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="376359118"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 03:48:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="733126726"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="733126726"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 18 Oct 2023 03:48:34 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qt46K-0000G4-1t;
        Wed, 18 Oct 2023 10:48:32 +0000
Date:   Wed, 18 Oct 2023 18:47:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: include/linux/fortify-string.h:57:33: warning: '__builtin_memcpy'
 specified bound 18446744073709551615 exceeds maximum object size
 9223372036854775807
Message-ID: <202310181817.yuikXlfV-lkp@intel.com>
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
config: mips-randconfig-r064-20230821 (https://download.01.org/0day-ci/archive/20231018/202310181817.yuikXlfV-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231018/202310181817.yuikXlfV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310181817.yuikXlfV-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/string.h:253,
                    from include/linux/bitmap.h:11,
                    from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from arch/mips/include/asm/cpu-type.h:12,
                    from arch/mips/include/asm/timex.h:19,
                    from include/linux/timex.h:67,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from drivers/ntb/test/ntb_tool.c:181:
   In function 'memcpy_fromio',
       inlined from 'tool_peer_mw_read' at drivers/ntb/test/ntb_tool.c:752:2:
>> include/linux/fortify-string.h:57:33: warning: '__builtin_memcpy' specified bound 18446744073709551615 exceeds maximum object size 9223372036854775807 [-Wstringop-overflow=]
      57 | #define __underlying_memcpy     __builtin_memcpy
         |                                 ^
   include/linux/fortify-string.h:585:9: note: in expansion of macro '__underlying_memcpy'
     585 |         __underlying_##op(p, q, __fortify_size);                        \
         |         ^~~~~~~~~~~~~
   include/linux/fortify-string.h:630:26: note: in expansion of macro '__fortify_memcpy_chk'
     630 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
         |                          ^~~~~~~~~~~~~~~~~~~~
   arch/mips/include/asm/io.h:490:9: note: in expansion of macro 'memcpy'
     490 |         memcpy(dst, (void __force *) src, count);
         |         ^~~~~~


vim +/__builtin_memcpy +57 include/linux/fortify-string.h

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
a28a6e860c6cf2 Francis Laniel      2021-02-25 @57  #define __underlying_memcpy	__builtin_memcpy
a28a6e860c6cf2 Francis Laniel      2021-02-25  58  #define __underlying_memmove	__builtin_memmove
a28a6e860c6cf2 Francis Laniel      2021-02-25  59  #define __underlying_memset	__builtin_memset
78a498c3a227f2 Alexander Potapenko 2022-10-24  60  #endif
78a498c3a227f2 Alexander Potapenko 2022-10-24  61  

:::::: The code at line 57 was first introduced by commit
:::::: a28a6e860c6cf231cf3c5171c75c342adcd00406 string.h: move fortified functions definitions in a dedicated header.

:::::: TO: Francis Laniel <laniel_francis@privacyrequired.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
