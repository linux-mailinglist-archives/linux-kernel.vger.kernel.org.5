Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E72A794690
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 00:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244736AbjIFWsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 18:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbjIFWsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 18:48:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4D5E71;
        Wed,  6 Sep 2023 15:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694040492; x=1725576492;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3Wlb5udvjKXip8Jt+PHIShNQsOIrXj1TqpblESAd0D0=;
  b=J23afQx3ry1RvR8CsunQYuSf8rovvv3SO6mInwx+qfzhxjQ8m3hHN4aj
   9/MuirAQybOZ3ZO2KNcrLYRxpI127WNN4Lf8+HVOIc8yx9C2pIObrQcl/
   3VwUb7gmex/fyGLnIVsxnV2ZeZ+88H48Ie+WlCTb61xjip9y5enxD3khD
   1cw3EdjlOAtydJTAY3/uXpG5WEZF/oUDeX7WoInQ8r0/KXYLARM4S5ld8
   hNMdT0FVamw/7GvCFfibuIFxsC5gEeMq1eeuaVqoRyCYEBT881c4IHsBA
   W0amgk6kmJ3OISHJ9l3XHdQhQq/jsv36HSmn7hGJ0FgEe/Hei01m1Vqjo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="443587356"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="443587356"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 15:48:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="856650662"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="856650662"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 06 Sep 2023 15:48:07 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qe1Jd-0000ev-19;
        Wed, 06 Sep 2023 22:48:05 +0000
Date:   Thu, 7 Sep 2023 06:47:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martino Fontana <tinozzo123@gmail.com>, djogorchock@gmail.com,
        jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Martino Fontana <tinozzo123@gmail.com>
Subject: Re: [PATCH v3] HID: nintendo: cleanup LED code
Message-ID: <202309070615.yjnCY1YM-lkp@intel.com>
References: <20230906141533.36921-1-tinozzo123@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906141533.36921-1-tinozzo123@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martino,

kernel test robot noticed the following build warnings:

[auto build test WARNING on hid/for-next]
[also build test WARNING on linus/master v6.5 next-20230906]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Martino-Fontana/HID-nintendo-cleanup-LED-code/20230906-221818
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
patch link:    https://lore.kernel.org/r/20230906141533.36921-1-tinozzo123%40gmail.com
patch subject: [PATCH v3] HID: nintendo: cleanup LED code
config: arc-randconfig-r033-20230907 (https://download.01.org/0day-ci/archive/20230907/202309070615.yjnCY1YM-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230907/202309070615.yjnCY1YM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309070615.yjnCY1YM-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/arc/include/asm/ptrace.h:11,
                    from arch/arc/include/asm/unaligned.h:12,
                    from drivers/hid/hid-nintendo.c:26:
   drivers/hid/hid-nintendo.c: In function 'joycon_leds_create':
>> include/linux/compiler.h:55:23: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                       ^~
   drivers/hid/hid-nintendo.c:1954:17: note: in expansion of macro 'if'
    1954 |                 if (ret)
         |                 ^~
   drivers/hid/hid-nintendo.c:1956:25: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
    1956 |                         return ret;
         |                         ^~~~~~
>> include/linux/compiler.h:55:23: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                       ^~
   drivers/hid/hid-nintendo.c:1986:17: note: in expansion of macro 'if'
    1986 |                 if (ret)
         |                 ^~
   drivers/hid/hid-nintendo.c:1988:25: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
    1988 |                         return ret;
         |                         ^~~~~~


vim +/if +55 include/linux/compiler.h

2bcd521a684cc9 Steven Rostedt 2008-11-21  49  
2bcd521a684cc9 Steven Rostedt 2008-11-21  50  #ifdef CONFIG_PROFILE_ALL_BRANCHES
2bcd521a684cc9 Steven Rostedt 2008-11-21  51  /*
2bcd521a684cc9 Steven Rostedt 2008-11-21  52   * "Define 'is'", Bill Clinton
2bcd521a684cc9 Steven Rostedt 2008-11-21  53   * "Define 'if'", Steven Rostedt
2bcd521a684cc9 Steven Rostedt 2008-11-21  54   */
a15fd609ad53a6 Linus Torvalds 2019-03-20 @55  #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
a15fd609ad53a6 Linus Torvalds 2019-03-20  56  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
