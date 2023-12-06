Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D0B8076C8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442715AbjLFRje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442595AbjLFRjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:39:32 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43ACDD47
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 09:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701884379; x=1733420379;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ra06s2wat/gRp2NTt+vmqIMOkgGactMT0z9RIX4ie/8=;
  b=FAM9/2AGk2K74pQ2jtBnyQoFcKxZHMRIK+o1ehyoTI+CiDrHjyyao2PU
   of8m1ibBQRHRd16IAt+9T0rsylC9b96sLayYyx0qRjeGkjHpJzrRCLMRB
   yya6syW4AbJYmkqjMgu7dC/FVrlQTHorXTNiX3SB2FMgQIJElbsgp9COx
   2eULtPzgJVTBchriphyj8L9hNyWVxBy3h5XzotcKNi1bqNJyWmiifNva+
   nEKJkbv2WJJJQmcLuPMHGHaI7uHVdnGxdxrQRUiRk9xLtlQK4D10Z/nEQ
   h+khB7mIW0EfaRodp1L8COQ7NQDktq1QGvCInwJWRJKF5OQ71wFAko+Jt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="1197924"
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="1197924"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 09:39:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="1102910109"
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="1102910109"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 06 Dec 2023 09:39:34 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAvrw-000BCl-0u;
        Wed, 06 Dec 2023 17:39:32 +0000
Date:   Thu, 7 Dec 2023 01:38:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH v3 3/4] nvme: move ns id info to struct nvme_ns_head
Message-ID: <202312070134.P5lZMJCN-lkp@intel.com>
References: <20231206081244.32733-4-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206081244.32733-4-dwagner@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

kernel test robot noticed the following build errors:

[auto build test ERROR on v6.7-rc4]
[also build test ERROR on linus/master next-20231206]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Wagner/nvme-lookup-ctrl-from-request-instead-from-namespace/20231206-161455
base:   v6.7-rc4
patch link:    https://lore.kernel.org/r/20231206081244.32733-4-dwagner%40suse.de
patch subject: [PATCH v3 3/4] nvme: move ns id info to struct nvme_ns_head
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20231207/202312070134.P5lZMJCN-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231207/202312070134.P5lZMJCN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312070134.P5lZMJCN-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/nvme/host/core.c: In function 'nvme_update_ns_info_generic':
>> drivers/nvme/host/core.c:2034:47: error: passing argument 1 of 'nvme_mpath_revalidate_paths' from incompatible pointer type [-Werror=incompatible-pointer-types]
    2034 |                 nvme_mpath_revalidate_paths(ns->head);
         |                                             ~~^~~~~~
         |                                               |
         |                                               struct nvme_ns_head *
   In file included from drivers/nvme/host/core.c:25:
   drivers/nvme/host/nvme.h:945:64: note: expected 'struct nvme_ns *' but argument is of type 'struct nvme_ns_head *'
     945 | static inline void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
         |                                                ~~~~~~~~~~~~~~~~^~
   drivers/nvme/host/core.c: In function 'nvme_update_ns_info_block':
   drivers/nvme/host/core.c:2109:47: error: passing argument 1 of 'nvme_mpath_revalidate_paths' from incompatible pointer type [-Werror=incompatible-pointer-types]
    2109 |                 nvme_mpath_revalidate_paths(ns->head);
         |                                             ~~^~~~~~
         |                                               |
         |                                               struct nvme_ns_head *
   drivers/nvme/host/nvme.h:945:64: note: expected 'struct nvme_ns *' but argument is of type 'struct nvme_ns_head *'
     945 | static inline void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
         |                                                ~~~~~~~~~~~~~~~~^~
   cc1: some warnings being treated as errors


vim +/nvme_mpath_revalidate_paths +2034 drivers/nvme/host/core.c

  2022	
  2023	static int nvme_update_ns_info_generic(struct nvme_ns *ns,
  2024			struct nvme_ns_info *info)
  2025	{
  2026		blk_mq_freeze_queue(ns->disk->queue);
  2027		nvme_set_queue_limits(ns->ctrl, ns->queue);
  2028		set_disk_ro(ns->disk, nvme_ns_is_readonly(ns, info));
  2029		blk_mq_unfreeze_queue(ns->disk->queue);
  2030	
  2031		if (nvme_ns_head_multipath(ns->head)) {
  2032			blk_mq_freeze_queue(ns->head->disk->queue);
  2033			set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
> 2034			nvme_mpath_revalidate_paths(ns->head);
  2035			blk_stack_limits(&ns->head->disk->queue->limits,
  2036					 &ns->queue->limits, 0);
  2037			ns->head->disk->flags |= GENHD_FL_HIDDEN;
  2038			blk_mq_unfreeze_queue(ns->head->disk->queue);
  2039		}
  2040	
  2041		/* Hide the block-interface for these devices */
  2042		ns->disk->flags |= GENHD_FL_HIDDEN;
  2043		set_bit(NVME_NS_READY, &ns->flags);
  2044	
  2045		return 0;
  2046	}
  2047	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
