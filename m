Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BD976892F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 00:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjG3Wuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 18:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjG3Wuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 18:50:50 -0400
Received: from mgamail.intel.com (unknown [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8D7AB
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 15:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690757449; x=1722293449;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qp6IAn8qPRQH56wfANMTk4vp9aZZCvE/xlMGcR/TwFw=;
  b=V0aBAM3TAUpvqzMdIwlVaitnW3YKEaAptO5xNgLDvdpqgG5TB7WSz0L9
   6WWe0wkWrb8vD6xTaWJ2fA9DENauwgUK4om4jsdf9jEw1bUDz5KX2UqPB
   ekP5QyLrCjKhdLno9ihKyjYIqwdX5Gj7oDUxOOKDupWrHbbX1iYMFopwn
   19Uuy2zv9qtisvJBxWBwgPWegFPMccU98t4CyPcX8QgLJVIw6di9/j1At
   lWB/nVQ84XZ0qjndM8uNYs1VPDl026/6Wt/0XBxgmshutPoeC/cHqj/pu
   wY1Uo/21v6WD8K8bh7Z0Ct6RgG35pv5YbXp0alDQPuV+DdHXudoGY6ZIy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="455255760"
X-IronPort-AV: E=Sophos;i="6.01,243,1684825200"; 
   d="scan'208";a="455255760"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2023 15:50:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="678116789"
X-IronPort-AV: E=Sophos;i="6.01,243,1684825200"; 
   d="scan'208";a="678116789"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 30 Jul 2023 15:50:45 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qQFFN-0004oJ-0V;
        Sun, 30 Jul 2023 22:50:45 +0000
Date:   Mon, 31 Jul 2023 06:49:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Patricia Alfonso <trishalfonso@google.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        David Gow <davidgow@google.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>
Subject: mm/kasan/kasan.h:485:2: error: #error kasan_arch_is_ready only works
 in KASAN generic outline mode!
Message-ID: <202307310656.h1Bdon57-lkp@intel.com>
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

Hi Patricia,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
commit: 5b301409e8bc5d7fad2ee138be44c5c529dd0874 UML: add support for KASAN under x86_64
date:   1 year ago
config: um-randconfig-r024-20230731 (https://download.01.org/0day-ci/archive/20230731/202307310656.h1Bdon57-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230731/202307310656.h1Bdon57-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307310656.h1Bdon57-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from lib/test_kasan.c:28:
>> lib/../mm/kasan/kasan.h:485:2: error: #error kasan_arch_is_ready only works in KASAN generic outline mode!
     485 | #error kasan_arch_is_ready only works in KASAN generic outline mode!
         |  ^~~~~
--
   In file included from mm/kasan/report_generic.c:30:
>> mm/kasan/kasan.h:485:2: error: #error kasan_arch_is_ready only works in KASAN generic outline mode!
     485 | #error kasan_arch_is_ready only works in KASAN generic outline mode!
         |  ^~~~~


vim +485 mm/kasan/kasan.h

e2db1a9aa38149 Andrey Konovalov 2021-02-25  481  
af3751f3c2b628 Daniel Axtens    2021-06-28  482  #ifndef kasan_arch_is_ready
af3751f3c2b628 Daniel Axtens    2021-06-28  483  static inline bool kasan_arch_is_ready(void)	{ return true; }
af3751f3c2b628 Daniel Axtens    2021-06-28  484  #elif !defined(CONFIG_KASAN_GENERIC) || !defined(CONFIG_KASAN_OUTLINE)
af3751f3c2b628 Daniel Axtens    2021-06-28 @485  #error kasan_arch_is_ready only works in KASAN generic outline mode!
af3751f3c2b628 Daniel Axtens    2021-06-28  486  #endif
af3751f3c2b628 Daniel Axtens    2021-06-28  487  

:::::: The code at line 485 was first introduced by commit
:::::: af3751f3c2b6282bebcb56c35bbe4c8b671f80aa kasan: allow architectures to provide an outline readiness check

:::::: TO: Daniel Axtens <dja@axtens.net>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
