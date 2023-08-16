Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1B977D963
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 06:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241741AbjHPEMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 00:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241733AbjHPELs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 00:11:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4401FC6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 21:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692159107; x=1723695107;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+hM076mTtFVP/XFcJDY1enqLmYazFXdz1WhZ1vHbVPY=;
  b=UblMME610QuYB48XhokvkAOJz0/w3giaxdk9oQ2QuSBybaGv435FXoO3
   2RVQpRx9/iKSWPwnUFABvBy+VqIZ8MY1YwaaSL7P5zO6iEXzBdATLb965
   WEa7r6uzx39h/KgXzw2UuJ/otIDM+VpwcqmOhw10AEbrMzt8qRsLLffvo
   KBU/dspVmQwBfUQFwndqBkvfkcPllU8Gq4TqktSfpnM6o3eymL7+g2QWE
   r4oVF+0g5JGsgrSPr9RSk5oFtYXRj6n3HVfTiFftevUfsv67w2/1haHDN
   CFkdWjHmkwn/QoypX8cFwTncKI6p0FbISdj+MRNM4fPyqIA8s+skKyuZb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="458786767"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="458786767"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 21:11:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="683895889"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="683895889"
Received: from lkp-server02.sh.intel.com (HELO b5fb8d9e1ffc) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 15 Aug 2023 21:11:40 -0700
Received: from kbuild by b5fb8d9e1ffc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qW7sh-0001Tt-07;
        Wed, 16 Aug 2023 04:11:39 +0000
Date:   Wed, 16 Aug 2023 12:11:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Rosenberg <drosen@google.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     oe-kbuild-all@lists.linux.dev, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>
Subject: Re: [PATCH 1/1] ANDROID: f2fs: Support Block Size == Page Size
Message-ID: <202308161231.MjDoxlOG-lkp@intel.com>
References: <20230816011432.1966838-2-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816011432.1966838-2-drosen@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 0cc81b1ad51287847e494e055e5d3426f95e7921]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Rosenberg/ANDROID-f2fs-Support-Block-Size-Page-Size/20230816-091721
base:   0cc81b1ad51287847e494e055e5d3426f95e7921
patch link:    https://lore.kernel.org/r/20230816011432.1966838-2-drosen%40google.com
patch subject: [PATCH 1/1] ANDROID: f2fs: Support Block Size == Page Size
config: m68k-randconfig-r013-20230816 (https://download.01.org/0day-ci/archive/20230816/202308161231.MjDoxlOG-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230816/202308161231.MjDoxlOG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308161231.MjDoxlOG-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:7,
                    from include/asm-generic/bug.h:22,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from fs/f2fs/inode.c:8:
   fs/f2fs/inode.c: In function 'sanity_check_inode':
>> include/linux/kern_levels.h:5:25: warning: format '%zu' expects argument of type 'size_t', but argument 6 has type 'long unsigned int' [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/kern_levels.h:12:25: note: in expansion of macro 'KERN_SOH'
      12 | #define KERN_WARNING    KERN_SOH "4"    /* warning conditions */
         |                         ^~~~~~~~
   fs/f2fs/f2fs.h:2315:26: note: in expansion of macro 'KERN_WARNING'
    2315 |         f2fs_printk(sbi, KERN_WARNING fmt, ##__VA_ARGS__)
         |                          ^~~~~~~~~~~~
   fs/f2fs/inode.c:325:25: note: in expansion of macro 'f2fs_warn'
     325 |                         f2fs_warn(sbi, "%s: inode (ino=%lx) has corrupted i_inline_xattr_size: %d, max: %zu",
         |                         ^~~~~~~~~


vim +5 include/linux/kern_levels.h

314ba3520e513a Joe Perches 2012-07-30  4  
04d2c8c83d0e3a Joe Perches 2012-07-30 @5  #define KERN_SOH	"\001"		/* ASCII Start Of Header */
04d2c8c83d0e3a Joe Perches 2012-07-30  6  #define KERN_SOH_ASCII	'\001'
04d2c8c83d0e3a Joe Perches 2012-07-30  7  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
