Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43697F74D5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjKXNVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbjKXNVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:21:22 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD782171C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700832080; x=1732368080;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YBu33gyDzpFS19gtf1YvRqlEcr+xRwDlgCwrqg5C7xw=;
  b=flR4+vkYYFD8bKsLjrJuYrr0Ik9uLOBvrmBXfQIM0rE6MPRMFXgb3lHj
   grpFnsRiL3B1wo9gdhf+Po4UkAbope5k/LbcTVAdwWF2uaiA/4u9DZPne
   tFp0OjtRA86tSl9etCgVpbed2su6fabVI+fa6KgG87XsO//1Jue6727zX
   ugRqgr0rxBdL0bV1bdZ2zoFDfL7waTLGXNKiNCKgDs3lb1yaF8UDOeO4B
   Z6a+1FjdDL76ah2yWwRJnHrFavBO4qIcmFpuJt1rqNIpadDc83oiHfyGA
   lv4hmdNMUYFegwfCiDr4lJfR/j7lx30p4liF9H6bGW4FX8bCs8RMYakD3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="456765162"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="456765162"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 05:20:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="767477151"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="767477151"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 24 Nov 2023 05:20:30 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r6W6e-0002o5-0N;
        Fri, 24 Nov 2023 13:20:28 +0000
Date:   Fri, 24 Nov 2023 21:19:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wei Gao <wegao@suse.com>, tglx@linutronix.de, mingo@redhat.com,
        peterz@infradead.org, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, wei gao <wegao@suse.com>
Subject: Re: [PATCH v1] futex: Add compat_sys_futex_waitv for 32bit
 compatibility
Message-ID: <202311241440.BxBAsQ2i-lkp@intel.com>
References: <20231123053140.16062-1-wegao@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123053140.16062-1-wegao@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/asm]
[also build test ERROR on tip/locking/core linus/master v6.7-rc2 next-20231124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wei-Gao/futex-Add-compat_sys_futex_waitv-for-32bit-compatibility/20231123-133427
base:   tip/x86/asm
patch link:    https://lore.kernel.org/r/20231123053140.16062-1-wegao%40suse.com
patch subject: [PATCH v1] futex: Add compat_sys_futex_waitv for 32bit compatibility
config: x86_64-buildonly-randconfig-005-20231123 (https://download.01.org/0day-ci/archive/20231124/202311241440.BxBAsQ2i-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231124/202311241440.BxBAsQ2i-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311241440.BxBAsQ2i-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld: arch/x86/entry/syscall_32.o:(.rodata+0xe08): undefined reference to `__ia32_compat_sys_futex_waitv'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
