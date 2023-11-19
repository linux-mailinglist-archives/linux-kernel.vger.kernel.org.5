Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96BA7F087A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 20:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjKSTaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 14:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjKSTaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 14:30:19 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96C611D
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700422214; x=1731958214;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ETOrYbqa1HeiKSHWQehgF4FTHmbnCJsLsFMNwZnGaRA=;
  b=dd31hVAYui87GdT4p0A3oPg1136s17bOIaCTnHsqGZtbJHiUV9hHUSck
   7f3yWSobVvqcPhF228wMlMyOPCJ8UzZIBFRIdHxizK7gzq2M9fhpyWi/c
   hVGWLbSpXiaKC9cncE8HMUKRSaR4MWpLtGFBinSKOy+egGTj8Yo6fCMcx
   CC0uQlu3dr0kRVFYAHYLXZeGNHbM5p2jNN+L1TJiLrPX7HH3g3AEWUuRr
   e/VhJ/jVV+bU6y4VmKYf9c7TqhQmPLh2w9YuzQDAbbrTSlutHLEl06Mnp
   PgVpOjU9TDrAWzbytHdA3apAX8s/lCoBoggbOewBCAWViCiMmkPTqfFfj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="13072003"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="13072003"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 11:30:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="939608783"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="939608783"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 19 Nov 2023 11:30:10 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4nUd-0005Tr-2p;
        Sun, 19 Nov 2023 19:30:07 +0000
Date:   Mon, 20 Nov 2023 03:29:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     oe-kbuild-all@lists.linux.dev, Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH v2 5/5] misc: mlx5ctl: Add umem reg/unreg ioctl
Message-ID: <202311200350.qRmXknpI-lkp@intel.com>
References: <20231119092450.164996-6-saeed@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231119092450.164996-6-saeed@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saeed,

kernel test robot noticed the following build warnings:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on rdma/for-next linus/master v6.7-rc1 next-20231117]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Saeed-Mahameed/misc-mlx5ctl-Add-mlx5ctl-misc-driver/20231119-215311
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20231119092450.164996-6-saeed%40kernel.org
patch subject: [PATCH v2 5/5] misc: mlx5ctl: Add umem reg/unreg ioctl
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20231120/202311200350.qRmXknpI-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231120/202311200350.qRmXknpI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311200350.qRmXknpI-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/kcsan-checks.h:14,
                    from include/asm-generic/barrier.h:17,
                    from arch/alpha/include/asm/barrier.h:21,
                    from arch/alpha/include/asm/rwonce.h:10,
                    from include/linux/compiler.h:251,
                    from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/miscdevice.h:5,
                    from drivers/misc/mlx5ctl/main.c:4:
   drivers/misc/mlx5ctl/main.c: In function 'mlx5ctl_compat_ioctl':
   include/linux/stddef.h:8:14: error: called object is not a function or function pointer
       8 | #define NULL ((void *)0)
         |              ^
   include/linux/fs.h:1837:26: note: in expansion of macro 'NULL'
    1837 | #define compat_ptr_ioctl NULL
         |                          ^~~~
   drivers/misc/mlx5ctl/main.c:441:16: note: in expansion of macro 'compat_ptr_ioctl'
     441 |         return compat_ptr_ioctl(file, cmd, arg);
         |                ^~~~~~~~~~~~~~~~
>> drivers/misc/mlx5ctl/main.c:442:1: warning: control reaches end of non-void function [-Wreturn-type]
     442 | }
         | ^


vim +442 drivers/misc/mlx5ctl/main.c

   434	
   435	static long mlx5ctl_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
   436	{
   437		if (cmd == MLX5CTL_IOCTL_UMEM_UNREG) /* arg is a scalar */
   438			return mlx5ctl_ioctl(file, cmd, arg);
   439	
   440		/* arg is a pointer */
   441		return compat_ptr_ioctl(file, cmd, arg);
 > 442	}
   443	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
