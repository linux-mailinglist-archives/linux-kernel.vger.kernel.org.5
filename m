Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31AD7D22E6
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 13:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjJVL2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 07:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJVL16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 07:27:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4871E5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 04:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697974076; x=1729510076;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6LYTmI1wbNQ70SyfglzIU7ph91hc4WxWBq9ywCAt/1I=;
  b=PCX7pPiPEe5MLXnxjwv5jCn7l87gYdavL2N8e0RzxLOY0ix0iAB1k+iO
   BihTFijxjgz/doW5zFB5POq0h0sISIV79/0lHtU9n5bfJzgn+WsUC1Rez
   crpseYLio9puWcrNnrO7ilyOy+oXGDz11M1dNg2MJdORbSgt0xlCgqmj+
   ur57QBr05Yg7e0x8bD189mF0gaKBxNpCaNduRyn2Sd/VD5UoDvMOqDvsU
   8WJRnDtQD9pvxeO+NxbKepNK4zdYLUFdcqaetfGHUTlifLIkzJxUwt7g8
   JHTFd8Tm6b7ZhTeMHS/BZ6bytQrN0wKBwY1yy+k2R0ok7pPeS6oEA6yYm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="417827858"
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="417827858"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 04:27:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="707658950"
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="707658950"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 22 Oct 2023 04:27:53 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1quWcZ-0005ui-1N;
        Sun, 22 Oct 2023 11:27:51 +0000
Date:   Sun, 22 Oct 2023 19:27:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH 3/5] misc: mlx5ctl: Add info ioctl
Message-ID: <202310221931.r1vsjtys-lkp@intel.com>
References: <20231018081941.475277-4-saeed@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018081941.475277-4-saeed@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
config: arc-allmodconfig (https://download.01.org/0day-ci/archive/20231022/202310221931.r1vsjtys-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231022/202310221931.r1vsjtys-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310221931.r1vsjtys-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/misc/mlx5ctl/main.c:276:27: error: initialization of 'long int (*)(struct file *, unsigned int,  long unsigned int)' from incompatible pointer type 'ssize_t (*)(struct file *, unsigned int,  long unsigned int)' {aka 'int (*)(struct file *, unsigned int,  long unsigned int)'} [-Werror=incompatible-pointer-types]
     276 |         .unlocked_ioctl = mlx5ctl_ioctl,
         |                           ^~~~~~~~~~~~~
   drivers/misc/mlx5ctl/main.c:276:27: note: (near initialization for 'mlx5ctl_fops.unlocked_ioctl')
   cc1: some warnings being treated as errors


vim +276 drivers/misc/mlx5ctl/main.c

   271	
   272	static const struct file_operations mlx5ctl_fops = {
   273		.owner = THIS_MODULE,
   274		.open = mlx5ctl_open,
   275		.release = mlx5ctl_release,
 > 276		.unlocked_ioctl = mlx5ctl_ioctl,
   277	};
   278	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
