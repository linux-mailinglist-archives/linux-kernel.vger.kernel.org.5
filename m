Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226867FE811
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 05:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344372AbjK3EDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 23:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjK3EDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 23:03:02 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809EF98
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 20:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701316988; x=1732852988;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NjdZ4kLBSyYim0sU7gi4YD8EFiD3k7wIQMCyczyZ9oM=;
  b=jMLU5ITlKklxd8+/dbFt7iG5KHHPWtcQvMr/pQQPScGskRjx7miBvamy
   b80qE8ofN+f16taqklJH2Oj4eMaPHOpYM5H0w/RtqJD2QhaFn8coLsGKl
   /Wd1hasdXRfPmd4osywGhBed6cDJnvr+1fPiMiKy2hfPAizEFbCWRoZAH
   DUYhye7GtdrEWheINgp/ZyfSO5bVxoUwNtpLXI+QuldRyPqAAHqK1qe8j
   xfFRWaN4RGhlIQPkkLolQhX9QOj/5I2BHSj41N8HOyReo8lh+QbVn7rBb
   xdMThL8p42cHofxHeyxCUgAg2UGmErhbkNIiyrrU60nq2EK88ecKJZSN/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="393009062"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="393009062"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 20:03:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="913063273"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="913063273"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 29 Nov 2023 20:03:06 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r8YGW-0001K8-1Z;
        Thu, 30 Nov 2023 04:03:04 +0000
Date:   Thu, 30 Nov 2023 12:02:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: include/linux/fortify-string.h:52:29: warning: '__builtin_strcpy'
 source argument is the same as destination
Message-ID: <202311301039.7i51bZCz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3b47bc037bd44f142ac09848e8d3ecccc726be99
commit: ba38961a069b0d8d03b53218a6c29d737577d448 um: Enable FORTIFY_SOURCE
date:   1 year, 3 months ago
config: um-randconfig-r034-20230830 (https://download.01.org/0day-ci/archive/20231130/202311301039.7i51bZCz-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231130/202311301039.7i51bZCz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311301039.7i51bZCz-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/kallsyms.c:570:12: warning: no previous prototype for 'arch_get_kallsym' [-Wmissing-prototypes]
     570 | int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
         |            ^~~~~~~~~~~~~~~~
   In file included from include/linux/string.h:253,
                    from include/linux/bitmap.h:11,
                    from include/linux/cpumask.h:12,
                    from include/linux/mm_types_task.h:14,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/kallsyms.h:10,
                    from kernel/kallsyms.c:15:
   kernel/kallsyms.c: In function '__sprint_symbol.isra.0':
>> include/linux/fortify-string.h:52:29: warning: '__builtin_strcpy' source argument is the same as destination [-Wrestrict]
      52 | #define __underlying_strcpy __builtin_strcpy
         |                             ^
   include/linux/fortify-string.h:567:10: note: in expansion of macro '__underlying_strcpy'
     567 |   return __underlying_strcpy(p, q);
         |          ^~~~~~~~~~~~~~~~~~~


vim +/__builtin_strcpy +52 include/linux/fortify-string.h

3009f891bb9f32 Kees Cook      2021-08-02  33  
a28a6e860c6cf2 Francis Laniel 2021-02-25  34  #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
a28a6e860c6cf2 Francis Laniel 2021-02-25  35  extern void *__underlying_memchr(const void *p, int c, __kernel_size_t size) __RENAME(memchr);
a28a6e860c6cf2 Francis Laniel 2021-02-25  36  extern int __underlying_memcmp(const void *p, const void *q, __kernel_size_t size) __RENAME(memcmp);
a28a6e860c6cf2 Francis Laniel 2021-02-25  37  extern void *__underlying_memcpy(void *p, const void *q, __kernel_size_t size) __RENAME(memcpy);
a28a6e860c6cf2 Francis Laniel 2021-02-25  38  extern void *__underlying_memmove(void *p, const void *q, __kernel_size_t size) __RENAME(memmove);
a28a6e860c6cf2 Francis Laniel 2021-02-25  39  extern void *__underlying_memset(void *p, int c, __kernel_size_t size) __RENAME(memset);
a28a6e860c6cf2 Francis Laniel 2021-02-25  40  extern char *__underlying_strcat(char *p, const char *q) __RENAME(strcat);
a28a6e860c6cf2 Francis Laniel 2021-02-25  41  extern char *__underlying_strcpy(char *p, const char *q) __RENAME(strcpy);
a28a6e860c6cf2 Francis Laniel 2021-02-25  42  extern __kernel_size_t __underlying_strlen(const char *p) __RENAME(strlen);
a28a6e860c6cf2 Francis Laniel 2021-02-25  43  extern char *__underlying_strncat(char *p, const char *q, __kernel_size_t count) __RENAME(strncat);
a28a6e860c6cf2 Francis Laniel 2021-02-25  44  extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size) __RENAME(strncpy);
a28a6e860c6cf2 Francis Laniel 2021-02-25  45  #else
a28a6e860c6cf2 Francis Laniel 2021-02-25  46  #define __underlying_memchr	__builtin_memchr
a28a6e860c6cf2 Francis Laniel 2021-02-25  47  #define __underlying_memcmp	__builtin_memcmp
a28a6e860c6cf2 Francis Laniel 2021-02-25  48  #define __underlying_memcpy	__builtin_memcpy
a28a6e860c6cf2 Francis Laniel 2021-02-25  49  #define __underlying_memmove	__builtin_memmove
a28a6e860c6cf2 Francis Laniel 2021-02-25  50  #define __underlying_memset	__builtin_memset
a28a6e860c6cf2 Francis Laniel 2021-02-25  51  #define __underlying_strcat	__builtin_strcat
a28a6e860c6cf2 Francis Laniel 2021-02-25 @52  #define __underlying_strcpy	__builtin_strcpy
a28a6e860c6cf2 Francis Laniel 2021-02-25  53  #define __underlying_strlen	__builtin_strlen
a28a6e860c6cf2 Francis Laniel 2021-02-25  54  #define __underlying_strncat	__builtin_strncat
a28a6e860c6cf2 Francis Laniel 2021-02-25  55  #define __underlying_strncpy	__builtin_strncpy
a28a6e860c6cf2 Francis Laniel 2021-02-25  56  #endif
a28a6e860c6cf2 Francis Laniel 2021-02-25  57  

:::::: The code at line 52 was first introduced by commit
:::::: a28a6e860c6cf231cf3c5171c75c342adcd00406 string.h: move fortified functions definitions in a dedicated header.

:::::: TO: Francis Laniel <laniel_francis@privacyrequired.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
