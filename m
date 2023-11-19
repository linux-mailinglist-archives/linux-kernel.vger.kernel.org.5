Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95787F08BD
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 21:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjKSUHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 15:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKSUHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 15:07:14 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5595011D
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 12:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700424428; x=1731960428;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P+2fLevcKnnnglLyKBrbcympk8gX7ujEVNTWU+3+FQ4=;
  b=cQgWER0ofKksxgpmjSllBRVDS0C62jSDfdUiE2wiFlGeBtcj1kIOAWZq
   zJhEREe4umGo8V1/WtJr21Yl+BAnZbtpa95qn4FsdTIfEfTStpuLizRWf
   I+GUyJY4sljmGZf/ydDFSH8BWs6HW/0+UcxuD0w2H21VIW6RFbK98qhPu
   CQVerfwJ0Zct7lBDrxayjHPBhqiPjHsfAFaQvd9jw+LgGiUdNOiO42Fhs
   pZUJPSgQKGJ7h2ddu/+rly+f03VA16PNEOqQSOGhash8DXotjIGBQOWmO
   7M1efZfIGAwQ9jl1V84bt/i1DO6QcjAnAcny+Gk+2tg10L28i4o8RkZVP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="458018860"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="458018860"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 12:07:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="14401994"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 19 Nov 2023 12:07:04 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4o4M-0005V7-0l;
        Sun, 19 Nov 2023 20:07:02 +0000
Date:   Mon, 20 Nov 2023 04:06:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH v2 5/5] misc: mlx5ctl: Add umem reg/unreg ioctl
Message-ID: <202311200346.0gytNeOc-lkp@intel.com>
References: <20231119092450.164996-6-saeed@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231119092450.164996-6-saeed@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saeed,

kernel test robot noticed the following build errors:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on rdma/for-next linus/master v6.7-rc1 next-20231117]
[cannot apply to char-misc/char-misc-next char-misc/char-misc-linus soc/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Saeed-Mahameed/misc-mlx5ctl-Add-mlx5ctl-misc-driver/20231119-215311
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20231119092450.164996-6-saeed%40kernel.org
patch subject: [PATCH v2 5/5] misc: mlx5ctl: Add umem reg/unreg ioctl
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20231120/202311200346.0gytNeOc-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231120/202311200346.0gytNeOc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311200346.0gytNeOc-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/misc/mlx5ctl/main.c:441:25: error: called object type 'void *' is not a function or function pointer
           return compat_ptr_ioctl(file, cmd, arg);
                  ~~~~~~~~~~~~~~~~^
   1 error generated.


vim +441 drivers/misc/mlx5ctl/main.c

   434	
   435	static long mlx5ctl_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
   436	{
   437		if (cmd == MLX5CTL_IOCTL_UMEM_UNREG) /* arg is a scalar */
   438			return mlx5ctl_ioctl(file, cmd, arg);
   439	
   440		/* arg is a pointer */
 > 441		return compat_ptr_ioctl(file, cmd, arg);
   442	}
   443	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
