Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1F77EF68E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 17:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbjKQQsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 11:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjKQQsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 11:48:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC549D56
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 08:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700239676; x=1731775676;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OwMwwXyJd4v3YYjcKZBorvEoIaxkujw0SDA0rSRSLKg=;
  b=gq3/xhtMoDFK7UPp//fxkVsLfStN1WxF+sfZp76tuaFcz3WGnf0T+osi
   GYbxswySA67wgz7LzIt/Zx9j95ARc0jGe6KwwF11anAhYFmX3P8bZz7Le
   uDlRf6T6uhf+KgIck3eFsxbtEwlZrFR0jeC2DnkbPjP6e994cEa6AYsqK
   GKWgILKF2X0jLcsUk0R7TNldkKcdEFFFHdYHyazKsl1eTZSKQ+DcPLjGX
   C5hPnkYUnGZ9SADaHXVa/swVGDJL5vdUOGGthoRG3mY8yd6rB+lHECSZy
   j8LBBBeat91aHuBHx5HJwO9yXEmX68hx1SAK2bdP2u275Cj1kTk3qCpWX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="394178078"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="394178078"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 08:47:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="939196922"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="939196922"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 17 Nov 2023 08:47:53 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r420U-0002xr-2Y;
        Fri, 17 Nov 2023 16:47:50 +0000
Date:   Sat, 18 Nov 2023 00:47:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chris Morgan <macromorgan@hotmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: include/asm-generic/unaligned.h:119:16: sparse: sparse: cast
 truncates bits from constant value (aa01a0 becomes a0)
Message-ID: <202311180032.YrkvZVwK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
head:   6bc40e44f1ddef16a787f3501b97f1fff909177c
commit: 66603243f5283f7f28c795f09e7c2167233df0bd Input: add driver for Hynitron cstxxx touchscreens
date:   1 year, 1 month ago
config: x86_64-randconfig-x001-20230717 (https://download.01.org/0day-ci/archive/20231118/202311180032.YrkvZVwK-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231118/202311180032.YrkvZVwK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311180032.YrkvZVwK-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/input/touchscreen/hynitron_cstxxx.c: note: in included file (through arch/x86/include/generated/asm/unaligned.h):
>> include/asm-generic/unaligned.h:119:16: sparse: sparse: cast truncates bits from constant value (aa01a0 becomes a0)
   include/asm-generic/unaligned.h:120:20: sparse: sparse: cast truncates bits from constant value (aa01 becomes 1)
>> include/asm-generic/unaligned.h:119:16: sparse: sparse: cast truncates bits from constant value (ab00d0 becomes d0)
   include/asm-generic/unaligned.h:120:20: sparse: sparse: cast truncates bits from constant value (ab00 becomes 0)

vim +119 include/asm-generic/unaligned.h

803f4e1eab7a89 Arnd Bergmann 2021-05-08  116  
803f4e1eab7a89 Arnd Bergmann 2021-05-08  117  static inline void __put_unaligned_le24(const u32 val, u8 *p)
803f4e1eab7a89 Arnd Bergmann 2021-05-08  118  {
803f4e1eab7a89 Arnd Bergmann 2021-05-08 @119  	*p++ = val;
803f4e1eab7a89 Arnd Bergmann 2021-05-08  120  	*p++ = val >> 8;
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
