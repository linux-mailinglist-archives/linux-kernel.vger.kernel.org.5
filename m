Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D2F7718C9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 05:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjHGD3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 23:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjHGD3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 23:29:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306C7AD
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 20:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691378988; x=1722914988;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=3s/+ylINTSppVuLY3rqV3TttUMz2e1nTcrDbx+TAG0Q=;
  b=lPuVCkJmcKtvcLFmnY+YMS3UQN76eboSxpp8GIZQXgeWoGZkYrBEBIUt
   UGcwsTIF+x6EOOvoXifpQCToo9VNqwCTPhcs3746XsyArNVz2Z/1nhLn1
   qMJVfdfD+7+gUqA0EyfIZstsCPgY3MwDald3RuauLz6PnupA5AkGW4PkM
   lsIvJxl5hnZBUw+5xGElGSpyhAf7pTbor95i2P3fxDzW+kR3v735lLjFG
   otAYcR8VMDs0UM3GzTa7LMiy0nnR2Wf8xT5isFXpwxrfA/yphV5hS9Z+L
   vTKNWpAP5NNBDS5IWMXmKFCjOsKnqc0KkX5yI8oIjCFIFyYWjUiwakNcw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="350752432"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; 
   d="scan'208";a="350752432"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2023 20:29:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="760313472"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; 
   d="scan'208";a="760313472"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 06 Aug 2023 20:29:45 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qSqwC-0004WJ-2g;
        Mon, 07 Aug 2023 03:29:44 +0000
Date:   Mon, 7 Aug 2023 11:29:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Li zeming <zeming@nfschina.com>, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Li zeming <zeming@nfschina.com>
Subject: Re: [PATCH] kernel: time: =?utf-8?Q?clocks?=
 =?utf-8?B?b3VyY2U6IFJlbW92ZSB1bm5lY2Vzc2FyeSDigJgw4oCZ?= values from ret
Message-ID: <202308071105.lWPLR4Kr-lkp@intel.com>
References: <20230808173611.3066-1-zeming@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230808173611.3066-1-zeming@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/timers/core]
[also build test WARNING on linus/master v6.5-rc5 next-20230804]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-zeming/kernel-time-clocksource-Remove-unnecessary-0-values-from-ret/20230807-090629
base:   tip/timers/core
patch link:    https://lore.kernel.org/r/20230808173611.3066-1-zeming%40nfschina.com
patch subject: [PATCH] kernel: time: clocksource: Remove unnecessary ‘0’ values from ret
config: um-allnoconfig (https://download.01.org/0day-ci/archive/20230807/202308071105.lWPLR4Kr-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230807/202308071105.lWPLR4Kr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308071105.lWPLR4Kr-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from kernel/time/clocksource.c:11:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from kernel/time/clocksource.c:11:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from kernel/time/clocksource.c:11:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     692 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     700 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     708 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     717 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     726 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     735 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> kernel/time/clocksource.c:1295:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
    1295 |         if (!list_empty(&cs->list))
         |             ^~~~~~~~~~~~~~~~~~~~~~
   kernel/time/clocksource.c:1298:9: note: uninitialized use occurs here
    1298 |         return ret;
         |                ^~~
   kernel/time/clocksource.c:1295:2: note: remove the 'if' if its condition is always true
    1295 |         if (!list_empty(&cs->list))
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
    1296 |                 ret = clocksource_unbind(cs);
         | ~~~~~~~~~~~~~~~~
   kernel/time/clocksource.c:1292:9: note: initialize the variable 'ret' to silence this warning
    1292 |         int ret;
         |                ^
         |                 = 0
   13 warnings generated.


vim +1295 kernel/time/clocksource.c

7eaeb34305dee2 Thomas Gleixner    2013-04-25  1285  
4713e22ce81eb8 Thomas Gleixner    2008-01-30  1286  /**
4713e22ce81eb8 Thomas Gleixner    2008-01-30  1287   * clocksource_unregister - remove a registered clocksource
b1b73d095084e7 Kusanagi Kouichi   2011-12-19  1288   * @cs:	clocksource to be unregistered
4713e22ce81eb8 Thomas Gleixner    2008-01-30  1289   */
a89c7edbe7d7aa Thomas Gleixner    2013-04-25  1290  int clocksource_unregister(struct clocksource *cs)
4713e22ce81eb8 Thomas Gleixner    2008-01-30  1291  {
1c69718b036413 Li zeming          2023-08-09  1292  	int ret;
a89c7edbe7d7aa Thomas Gleixner    2013-04-25  1293  
75c5158f70c065 Martin Schwidefsky 2009-08-14  1294  	mutex_lock(&clocksource_mutex);
a89c7edbe7d7aa Thomas Gleixner    2013-04-25 @1295  	if (!list_empty(&cs->list))
a89c7edbe7d7aa Thomas Gleixner    2013-04-25  1296  		ret = clocksource_unbind(cs);
75c5158f70c065 Martin Schwidefsky 2009-08-14  1297  	mutex_unlock(&clocksource_mutex);
a89c7edbe7d7aa Thomas Gleixner    2013-04-25  1298  	return ret;
4713e22ce81eb8 Thomas Gleixner    2008-01-30  1299  }
fb63a0ebe615fb Martin Schwidefsky 2009-08-14  1300  EXPORT_SYMBOL(clocksource_unregister);
4713e22ce81eb8 Thomas Gleixner    2008-01-30  1301  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
