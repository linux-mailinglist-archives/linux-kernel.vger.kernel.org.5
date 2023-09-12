Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9466279C1A1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 03:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbjILB0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 21:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234731AbjILB0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 21:26:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1341BFA03
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694481145; x=1726017145;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Qu9yKfw5/BbXLsTulR1lSIpXbF4XhRmFvULhUHk544E=;
  b=LaXGW8d6J8+hEMsbACnGhvmKCetNpxHAhaiga4zveOtZ9xhAR9icXa2i
   vBtYVoMlkANI0MlpLJW23AIHlTvXMn9Ltlpvjc7iFnPhSujaVMCqyTsi7
   sYomzC+2MgfgsnTXZzv7FnMaSG8K3QjME//DbuVUnQikYKgG7rPAzqS/+
   9VRggnxJ6qGiZ0ScrEVUTVJkou/S/RKss1MtdkGwGa1ZPJuy9qfRtZ7XW
   Z+embgfmDPSwm7AS1qnACkLOlb5NDcj0KwKEuBfDwSldK+NyGoBai/XRc
   48u95+ZO6P22orB66nnU3B1DU6XI31LIE+da6mj05VxFQVPJp909Tu8jG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="357678709"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="357678709"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 17:47:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="813596387"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="813596387"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 11 Sep 2023 17:46:59 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qfrYR-0006zs-1k;
        Tue, 12 Sep 2023 00:46:59 +0000
Date:   Tue, 12 Sep 2023 08:46:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chris Morgan <macromorgan@hotmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: include/asm-generic/unaligned.h:119:16: sparse: sparse: cast
 truncates bits from constant value (aa01a0 becomes a0)
Message-ID: <202309120820.bRjnU9fZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0bb80ecc33a8fb5a682236443c1e740d5c917d1d
commit: 66603243f5283f7f28c795f09e7c2167233df0bd Input: add driver for Hynitron cstxxx touchscreens
date:   11 months ago
config: i386-randconfig-061-20230909 (https://download.01.org/0day-ci/archive/20230912/202309120820.bRjnU9fZ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230912/202309120820.bRjnU9fZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309120820.bRjnU9fZ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/input/touchscreen/hynitron_cstxxx.c: note: in included file (through arch/x86/include/generated/asm/unaligned.h):
>> include/asm-generic/unaligned.h:119:16: sparse: sparse: cast truncates bits from constant value (aa01a0 becomes a0)
>> include/asm-generic/unaligned.h:120:20: sparse: sparse: cast truncates bits from constant value (aa01 becomes 1)
>> include/asm-generic/unaligned.h:119:16: sparse: sparse: cast truncates bits from constant value (ab00d0 becomes d0)
>> include/asm-generic/unaligned.h:120:20: sparse: sparse: cast truncates bits from constant value (ab00 becomes 0)

vim +119 include/asm-generic/unaligned.h

803f4e1eab7a89 Arnd Bergmann 2021-05-08  116  
803f4e1eab7a89 Arnd Bergmann 2021-05-08  117  static inline void __put_unaligned_le24(const u32 val, u8 *p)
803f4e1eab7a89 Arnd Bergmann 2021-05-08  118  {
803f4e1eab7a89 Arnd Bergmann 2021-05-08 @119  	*p++ = val;
803f4e1eab7a89 Arnd Bergmann 2021-05-08 @120  	*p++ = val >> 8;
803f4e1eab7a89 Arnd Bergmann 2021-05-08  121  	*p++ = val >> 16;
803f4e1eab7a89 Arnd Bergmann 2021-05-08  122  }
803f4e1eab7a89 Arnd Bergmann 2021-05-08  123  

:::::: The code at line 119 was first introduced by commit
:::::: 803f4e1eab7a8938ba3a3c30dd4eb5e9eeef5e63 asm-generic: simplify asm/unaligned.h

:::::: TO: Arnd Bergmann <arnd@arndb.de>
:::::: CC: Arnd Bergmann <arnd@arndb.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
