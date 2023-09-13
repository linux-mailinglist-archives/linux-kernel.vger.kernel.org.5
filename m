Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98CC79E4B6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 12:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239615AbjIMKSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 06:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239648AbjIMKSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 06:18:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E112219A9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 03:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694600307; x=1726136307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SHP0nIGBAt4mtaptQJxzxBO3GPdpuwYHV4f9icbzzAo=;
  b=b6LZZ7SfWYCCDi9hsAloDScrTFsiUZ08zKlNGJzyb85ny4fwYGusK3Oc
   sKVD+7QL4x/+V+QqvdvjbLl2oL6Dyoys2FkcfCUXDv85+dJI30MAm3Fzm
   JhuXLzZPfJnnlkC7OTGTPA733pjNWuzLXKCeAhiagY3wbcwufok1R4zfz
   pEVEUx/lSzQVUj91NvmyaZh/Dkvlr4pvdhxK2+gDFUHDuT3Xh9P4M/gQb
   MIglw/VUHV3eL6ML3SFbAw1tzerv4i27O8axgg27xc4WD59449xVMEq6i
   130rXPPPzVVvBfHJJashiGiMCgPeGOn73LsVObEdFpNPM/qOXfd8woIG5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="445058230"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="445058230"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 03:18:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="814171608"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="814171608"
Received: from lkp-server02.sh.intel.com (HELO cf13c67269a2) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 13 Sep 2023 03:18:23 -0700
Received: from kbuild by cf13c67269a2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgMwt-0000O9-0y;
        Wed, 13 Sep 2023 10:18:19 +0000
Date:   Wed, 13 Sep 2023 18:17:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ping Gan <jacky_gam_2001@163.com>, kbusch@kernel.org,
        axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev, ping_gan@dell.com,
        jacky_gam_2001@163.com
Subject: Re: [PATCH 4/4] nvme-core: Get lowlevel disk for target polling
 queue task
Message-ID: <202309131858.YUV19V9E-lkp@intel.com>
References: <006b6aefe94d73ee64931c769af4a908616439ad.1694592708.git.jacky_gam_2001@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006b6aefe94d73ee64931c769af4a908616439ad.1694592708.git.jacky_gam_2001@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ping,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.6-rc1]
[also build test WARNING on linus/master next-20230913]
[cannot apply to hch-configfs/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ping-Gan/nvmet-Add-nvme-target-polling-queue-task-parameters/20230913-164112
base:   v6.6-rc1
patch link:    https://lore.kernel.org/r/006b6aefe94d73ee64931c769af4a908616439ad.1694592708.git.jacky_gam_2001%40163.com
patch subject: [PATCH 4/4] nvme-core: Get lowlevel disk for target polling queue task
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230913/202309131858.YUV19V9E-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230913/202309131858.YUV19V9E-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309131858.YUV19V9E-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/nvme/host/multipath.c:375:22: warning: no previous prototype for 'nvme_mpath_get_bdev' [-Wmissing-prototypes]
     375 | struct block_device *nvme_mpath_get_bdev(struct block_device *bdev)
         |                      ^~~~~~~~~~~~~~~~~~~


vim +/nvme_mpath_get_bdev +375 drivers/nvme/host/multipath.c

   373	
   374	//for polling queue task to get lowlevel block device
 > 375	struct block_device *nvme_mpath_get_bdev(struct block_device *bdev)
   376	{
   377		struct nvme_ns_head *head = bdev->bd_disk->private_data;
   378		int srcu_idx;
   379		struct nvme_ns *ns;
   380		struct block_device *ret = NULL;
   381	
   382		if (!multipath)
   383			return NULL;
   384		srcu_idx = srcu_read_lock(&head->srcu);
   385		ns = nvme_find_path(head);
   386		if (likely(ns))
   387			ret = ns->disk->part0;
   388		srcu_read_unlock(&head->srcu, srcu_idx);
   389		return ret;
   390	}
   391	EXPORT_SYMBOL_GPL(nvme_mpath_get_bdev);
   392	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
