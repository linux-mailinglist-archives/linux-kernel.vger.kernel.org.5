Return-Path: <linux-kernel+bounces-26935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA78082E813
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 04:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86FDD1C229F2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 03:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8ABE6FD1;
	Tue, 16 Jan 2024 03:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FPKHeoDG"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A316FB2
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 03:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705374548; x=1736910548;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bZL1/7zYGHCm/A4nAKVQtXYx7uhmErr1YEeKebQaykQ=;
  b=FPKHeoDG8+TuDijaXbFlv5aL4KoDrTO6E3htGtuXpMOvNq0H/oVIS6ur
   P5oQJTk4c/muHsjDUKG/UXhqD0QI5WtPhunQV73Vq0nxeXGoh45arnzeC
   usNwcU96aLcOWSfg18v+A75sUpNq8wdj2ySyrlkaZosxyGFdRh8v/Iqmr
   CJxP0WiKw34nZsGyfR2W4QjWREV0HmyoLi0juAZyEPLlX5fEWYa4O1n/0
   W43a2uIopNN36M+NV/vJJPIgqeIBwRxtxva3BiJWz8NBTNi+3IdgaO2b2
   5HQUhmKtcrtcfLeO7CSZvhnn7nL4Zk/fRQi57OWbCZ5N72wiP6F2FfbE6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="466114973"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="466114973"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 19:09:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="776885806"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="776885806"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 15 Jan 2024 19:09:03 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rPZml-000Cvk-36;
	Tue, 16 Jan 2024 03:07:57 +0000
Date: Tue, 16 Jan 2024 11:05:23 +0800
From: kernel test robot <lkp@intel.com>
To: Francois Dugast <francois.dugast@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: drivers/gpu/drm/xe/xe_gt_pagefault.c:340:17: warning: writing 16
 bytes into a region of size 0
Message-ID: <202401161031.hjGJHMiJ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   052d534373b7ed33712a63d5e17b2b6cdbce84fd
commit: 5c0553cdc811bb6af4f1bfef178bd07fc16a797e drm/xe: Replace XE_WARN_ON with drm_warn when just printing a string
date:   4 weeks ago
config: s390-randconfig-r071-20240116 (https://download.01.org/0day-ci/archive/20240116/202401161031.hjGJHMiJ-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240116/202401161031.hjGJHMiJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401161031.hjGJHMiJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/xe/xe_gt_pagefault.c: In function 'xe_guc_pagefault_handler':
>> drivers/gpu/drm/xe/xe_gt_pagefault.c:340:17: warning: writing 16 bytes into a region of size 0 [-Wstringop-overflow=]
     340 |                 memcpy(pf_queue->data + pf_queue->tail, msg, len * sizeof(u32));
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/xe/xe_device_types.h:16,
                    from drivers/gpu/drm/xe/xe_vm_types.h:16,
                    from drivers/gpu/drm/xe/xe_bo.h:11,
                    from drivers/gpu/drm/xe/xe_gt_pagefault.c:15:
   drivers/gpu/drm/xe/xe_gt_types.h:102:25: note: at offset [1216, 265396] into destination object 'tile' of size 8
     102 |         struct xe_tile *tile;
         |                         ^~~~


vim +340 drivers/gpu/drm/xe/xe_gt_pagefault.c

dd08ebf6c3525a Matthew Brost   2023-03-30  321  
dd08ebf6c3525a Matthew Brost   2023-03-30  322  int xe_guc_pagefault_handler(struct xe_guc *guc, u32 *msg, u32 len)
dd08ebf6c3525a Matthew Brost   2023-03-30  323  {
dd08ebf6c3525a Matthew Brost   2023-03-30  324  	struct xe_gt *gt = guc_to_gt(guc);
5c0553cdc811bb Francois Dugast 2023-09-12  325  	struct xe_device *xe = gt_to_xe(gt);
dd08ebf6c3525a Matthew Brost   2023-03-30  326  	struct pf_queue *pf_queue;
dd08ebf6c3525a Matthew Brost   2023-03-30  327  	unsigned long flags;
dd08ebf6c3525a Matthew Brost   2023-03-30  328  	u32 asid;
dd08ebf6c3525a Matthew Brost   2023-03-30  329  	bool full;
dd08ebf6c3525a Matthew Brost   2023-03-30  330  
dd08ebf6c3525a Matthew Brost   2023-03-30  331  	if (unlikely(len != PF_MSG_LEN_DW))
dd08ebf6c3525a Matthew Brost   2023-03-30  332  		return -EPROTO;
dd08ebf6c3525a Matthew Brost   2023-03-30  333  
dd08ebf6c3525a Matthew Brost   2023-03-30  334  	asid = FIELD_GET(PFD_ASID, msg[1]);
dd08ebf6c3525a Matthew Brost   2023-03-30  335  	pf_queue = &gt->usm.pf_queue[asid % NUM_PF_QUEUE];
dd08ebf6c3525a Matthew Brost   2023-03-30  336  
dd08ebf6c3525a Matthew Brost   2023-03-30  337  	spin_lock_irqsave(&pf_queue->lock, flags);
dd08ebf6c3525a Matthew Brost   2023-03-30  338  	full = pf_queue_full(pf_queue);
dd08ebf6c3525a Matthew Brost   2023-03-30  339  	if (!full) {
dd08ebf6c3525a Matthew Brost   2023-03-30 @340  		memcpy(pf_queue->data + pf_queue->tail, msg, len * sizeof(u32));
dd08ebf6c3525a Matthew Brost   2023-03-30  341  		pf_queue->tail = (pf_queue->tail + len) % PF_QUEUE_NUM_DW;
dd08ebf6c3525a Matthew Brost   2023-03-30  342  		queue_work(gt->usm.pf_wq, &pf_queue->worker);
dd08ebf6c3525a Matthew Brost   2023-03-30  343  	} else {
5c0553cdc811bb Francois Dugast 2023-09-12  344  		drm_warn(&xe->drm, "PF Queue full, shouldn't be possible");
dd08ebf6c3525a Matthew Brost   2023-03-30  345  	}
dd08ebf6c3525a Matthew Brost   2023-03-30  346  	spin_unlock_irqrestore(&pf_queue->lock, flags);
dd08ebf6c3525a Matthew Brost   2023-03-30  347  
dd08ebf6c3525a Matthew Brost   2023-03-30  348  	return full ? -ENOSPC : 0;
dd08ebf6c3525a Matthew Brost   2023-03-30  349  }
dd08ebf6c3525a Matthew Brost   2023-03-30  350  

:::::: The code at line 340 was first introduced by commit
:::::: dd08ebf6c3525a7ea2186e636df064ea47281987 drm/xe: Introduce a new DRM driver for Intel GPUs

:::::: TO: Matthew Brost <matthew.brost@intel.com>
:::::: CC: Rodrigo Vivi <rodrigo.vivi@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

