Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B3E7E133A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 12:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjKELwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 06:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjKELwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 06:52:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E39CE9
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 03:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699185120; x=1730721120;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Qr3/tNpVCqupgwjaUG9/Q6gCVC8204wPmzWLT76y2+8=;
  b=f4jSngC6Hzl9LoOxjZ4a9nepT4E+mNWX5Ikvs7fQr+IYH8ZBVhiG7fku
   Xi1fs+Sea7tqX8whshIFj5/D1oCdF0i4q6gp9P2kU9oVxKoS3FHu1zQPn
   IQlFSAwrPb+hyPx9q8643O6izJsTRVC5ayVK27EaiWbe3XUsllNaC6/h0
   AgNMo3aEa/MXjFsKKX90YtqKq2enZA/FsHikIQMZ/ZeCZcVplW1MpcOqs
   o8qFi1eUJjgERbC7VaIaFN6kGAzT3QGvcoD6OA03M/nBWMaJx+h8kV9sB
   RbIRevAMvvek6tORMquVj/E0NAHxoYDxSPorvG7a7u1DYyV2Ce/trslD3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="420259642"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="420259642"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 03:52:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="9829171"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 05 Nov 2023 03:51:58 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzbfX-0005Ng-1f;
        Sun, 05 Nov 2023 11:51:55 +0000
Date:   Sun, 5 Nov 2023 19:51:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        James Morris <jamorris@linux.microsoft.com>,
        Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
Subject: arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy'
 specified bound 4294967295 exceeds maximum object size 2147483647
Message-ID: <202311051904.8hqTj5mc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
head:   aea6bf908d730b01bd264a8821159db9463c111c
commit: ae271c1b14de343b888e77f74f640e3dcbdeb4c9 landlock: Add ruleset and domain management
date:   2 years, 6 months ago
config: i386-buildonly-randconfig-r002-20220101 (https://download.01.org/0day-ci/archive/20231105/202311051904.8hqTj5mc-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231105/202311051904.8hqTj5mc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311051904.8hqTj5mc-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/x86/include/asm/string.h:3,
                    from include/linux/string.h:21,
                    from include/linux/bitmap.h:9,
                    from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from security/landlock/ruleset.c:15:
   security/landlock/ruleset.c: In function 'create_rule':
>> arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' specified bound 4294967295 exceeds maximum object size 2147483647 [-Wstringop-overflow=]
     182 | #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
   security/landlock/ruleset.c:96:9: note: in expansion of macro 'memcpy'
      96 |         memcpy(new_rule->layers, layers,
         |         ^~~~~~


vim +/__builtin_memcpy +182 arch/x86/include/asm/string_32.h

^1da177e4c3f41 include/asm-i386/string.h        Linus Torvalds   2005-04-16  177  
^1da177e4c3f41 include/asm-i386/string.h        Linus Torvalds   2005-04-16  178  /*
^1da177e4c3f41 include/asm-i386/string.h        Linus Torvalds   2005-04-16  179   *	No 3D Now!
^1da177e4c3f41 include/asm-i386/string.h        Linus Torvalds   2005-04-16  180   */
^1da177e4c3f41 include/asm-i386/string.h        Linus Torvalds   2005-04-16  181  
ff60fab71bb3b4 arch/x86/include/asm/string_32.h Arjan van de Ven 2009-09-28 @182  #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
^1da177e4c3f41 include/asm-i386/string.h        Linus Torvalds   2005-04-16  183  

:::::: The code at line 182 was first introduced by commit
:::::: ff60fab71bb3b4fdbf8caf57ff3739ffd0887396 x86: Use __builtin_memset and __builtin_memcpy for memset/memcpy

:::::: TO: Arjan van de Ven <arjan@infradead.org>
:::::: CC: H. Peter Anvin <hpa@zytor.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
