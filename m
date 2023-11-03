Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5907DFE89
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 05:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjKCEHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 00:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKCEHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 00:07:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4801AC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 21:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698984427; x=1730520427;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=dcO9AuHqoksDQQ/8cNGvWbN08NBRqa6y0TyfkXM6ma4=;
  b=MBG+JDVEoXve1QOhuW3MDpEpn/cpHbC9RbBR4T46fCMmzzkOrT1HO5UC
   UKdZRQlo/eX74EPCZ0GZBmGKdtGgqn2jGALgA/OWtWPRntxbCY8MWmwEM
   grcUDfyVQf+cqvJ4h7jw+QPsiD1xcFo6WO7PCejclmucPGPaB9F+Hew2l
   I4gJCtdmtoZOk26rXS26O2W50aq2Y3yDONoE0EuBVDso2OVgPIL9ChKLA
   u3/NarFrF/FBL3qv2yQ+5ZW8KJ5j/W9zM2MBA/XjkpG+a6cU70T+/qE4j
   ChyXpJAzmtQlnau/WYTkeSrUYiSAHJCEeBNHvDMlw0Z2dIPWDY/Ad/oLA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="1748536"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="1748536"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 21:07:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="790643194"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="790643194"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 02 Nov 2023 21:07:05 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qylSZ-0002CS-0Q;
        Fri, 03 Nov 2023 04:07:03 +0000
Date:   Fri, 3 Nov 2023 12:06:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dave Airlie <airlied@redhat.com>
Subject: drivers/gpu/drm/scheduler/sched_main.c:266: warning: Function
 parameter or member 'result' not described in 'drm_sched_job_done'
Message-ID: <202311031154.zr7To6n0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Danilo,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   431f1051884e38d2a5751e4731d69b2ff289ee56
commit: b88baab828713ce0b49b185444b2ee83bed373a8 drm/nouveau: implement new VM_BIND uAPI
date:   3 months ago
config: parisc-defconfig (https://download.01.org/0day-ci/archive/20231103/202311031154.zr7To6n0-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231103/202311031154.zr7To6n0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311031154.zr7To6n0-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/scheduler/sched_main.c:266: warning: Function parameter or member 'result' not described in 'drm_sched_job_done'


vim +266 drivers/gpu/drm/scheduler/sched_main.c

08fb97de03aa22 Andrey Grodzovsky 2022-09-30  258  
71173e787cab9d Luben Tuikov      2020-12-03  259  /**
71173e787cab9d Luben Tuikov      2020-12-03  260   * drm_sched_job_done - complete a job
71173e787cab9d Luben Tuikov      2020-12-03  261   * @s_job: pointer to the job which is done
71173e787cab9d Luben Tuikov      2020-12-03  262   *
71173e787cab9d Luben Tuikov      2020-12-03  263   * Finish the job's fence and wake up the worker thread.
71173e787cab9d Luben Tuikov      2020-12-03  264   */
539f9ee4b52a8b Christian König   2023-04-17  265  static void drm_sched_job_done(struct drm_sched_job *s_job, int result)
71173e787cab9d Luben Tuikov      2020-12-03 @266  {
71173e787cab9d Luben Tuikov      2020-12-03  267  	struct drm_sched_fence *s_fence = s_job->s_fence;
71173e787cab9d Luben Tuikov      2020-12-03  268  	struct drm_gpu_scheduler *sched = s_fence->sched;
71173e787cab9d Luben Tuikov      2020-12-03  269  
71173e787cab9d Luben Tuikov      2020-12-03  270  	atomic_dec(&sched->hw_rq_count);
f2f12eb9c32bc7 Christian König   2021-02-02  271  	atomic_dec(sched->score);
71173e787cab9d Luben Tuikov      2020-12-03  272  
71173e787cab9d Luben Tuikov      2020-12-03  273  	trace_drm_sched_process_job(s_fence);
71173e787cab9d Luben Tuikov      2020-12-03  274  
71173e787cab9d Luben Tuikov      2020-12-03  275  	dma_fence_get(&s_fence->finished);
539f9ee4b52a8b Christian König   2023-04-17  276  	drm_sched_fence_finished(s_fence, result);
71173e787cab9d Luben Tuikov      2020-12-03  277  	dma_fence_put(&s_fence->finished);
71173e787cab9d Luben Tuikov      2020-12-03  278  	wake_up_interruptible(&sched->wake_up_worker);
71173e787cab9d Luben Tuikov      2020-12-03  279  }
71173e787cab9d Luben Tuikov      2020-12-03  280  

:::::: The code at line 266 was first introduced by commit
:::::: 71173e787cab9db4ca1fa6229477cb3d254bc285 drm/scheduler: Essentialize the job done callback

:::::: TO: Luben Tuikov <luben.tuikov@amd.com>
:::::: CC: Christian König <christian.koenig@amd.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
