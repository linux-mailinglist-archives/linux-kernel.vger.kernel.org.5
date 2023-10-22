Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008AE7D20A5
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 03:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjJVBqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 21:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJVBqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 21:46:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F8E11B
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 18:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697939199; x=1729475199;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5f1WRU3aRXap4I5n/ofpE3hvuF+uDnHT8apAm1dsN8Y=;
  b=GgO+eC9jnzptKVshrVBfEjAyRIpPd6OMLKjXfeSQWstFy41gE9WhhuOD
   wzqge+ZNrGOIXDU6dIFSzLNnM9M53d0cG6VlcfCD+z4/5rOgqZ7BN0wzi
   LtPBi8YBaz41gLCXgAZ4zoYQJOZVF4+GigXV5KicAeirpEXxjFA9n72K8
   zb6mG6LIZohfWVwzmnWbbhBz2SSZ1huyRw0lZNdNSdMsHmXGeQq5wQNzz
   gVdRpdIvcj/VKg6KAtScIUabydkJKLP2RVWFFTy0wkT+1nBuzaxhGKip1
   RngO11W4EWhJT80o97ZEwWkHYRSv8ifLdkC3TgcIh8u6s8PQkQKV3JwM9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="8233192"
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="8233192"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2023 18:46:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="828085972"
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="828085972"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 21 Oct 2023 18:46:35 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1quNY1-0005Sw-1M;
        Sun, 22 Oct 2023 01:46:33 +0000
Date:   Sun, 22 Oct 2023 09:46:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH 3/5] misc: mlx5ctl: Add info ioctl
Message-ID: <202310220923.Lga6m0Af-lkp@intel.com>
References: <20231018081941.475277-4-saeed@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018081941.475277-4-saeed@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saeed,

kernel test robot noticed the following build errors:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on char-misc/char-misc-next char-misc/char-misc-linus soc/for-next rdma/for-next linus/master v6.6-rc6]
[cannot apply to next-20231020]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Saeed-Mahameed/mlx5-Add-aux-dev-for-ctl-interface/20231018-162610
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20231018081941.475277-4-saeed%40kernel.org
patch subject: [PATCH 3/5] misc: mlx5ctl: Add info ioctl
config: i386-randconfig-011-20231022 (https://download.01.org/0day-ci/archive/20231022/202310220923.Lga6m0Af-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231022/202310220923.Lga6m0Af-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310220923.Lga6m0Af-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
>> ./usr/include/misc/mlx5ctl.h:8:9: error: unknown type name '__aligned_u64'
       8 |         __aligned_u64 flags;
         |         ^~~~~~~~~~~~~
>> ./usr/include/misc/mlx5ctl.h:9:9: error: unknown type name '__u32'
       9 |         __u32 size;
         |         ^~~~~
>> ./usr/include/misc/mlx5ctl.h:10:9: error: unknown type name '__u8'
      10 |         __u8 devname[64]; /* underlaying ConnectX device */
         |         ^~~~
>> ./usr/include/misc/mlx5ctl.h:11:9: error: unknown type name '__u16'
      11 |         __u16 uctx_uid; /* current process allocated UCTX UID */
         |         ^~~~~
   ./usr/include/misc/mlx5ctl.h:12:9: error: unknown type name '__u16'
      12 |         __u16 reserved1;
         |         ^~~~~
   ./usr/include/misc/mlx5ctl.h:13:9: error: unknown type name '__u32'
      13 |         __u32 uctx_cap; /* current process effective UCTX cap */
         |         ^~~~~
   ./usr/include/misc/mlx5ctl.h:14:9: error: unknown type name '__u32'
      14 |         __u32 dev_uctx_cap; /* device's UCTX capabilities */
         |         ^~~~~
   ./usr/include/misc/mlx5ctl.h:15:9: error: unknown type name '__u32'
      15 |         __u32 ucap; /* process user capability */
         |         ^~~~~
   ./usr/include/misc/mlx5ctl.h:16:9: error: unknown type name '__u32'
      16 |         __u32 reserved2[4];
         |         ^~~~~

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
