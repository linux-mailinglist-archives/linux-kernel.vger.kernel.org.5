Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99798043A2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 01:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343738AbjLEA5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 19:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjLEA5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 19:57:45 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6334B102
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 16:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701737872; x=1733273872;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=GPEs8Xaj54ZIAaocNHkV6u9vU45MD0NtNKuAgrFkgRM=;
  b=hoAn35/4HGj/sRNvQ28E0g/q9mNnEacNuOxVnbmE2kOpatPTcGDRhf4W
   snRFUwrgII2mpn7OfS/H4pwrHtvaCYMVXjf5za9OHGp1GozhGtOVb3YvB
   aeUI0Q+QlUdK226AlIL04FYnjYVc+OrBhbSJwDKDbwmZBt3o/VIR/YOlL
   LTzwzjW8ANwx1WkOrXbgcH0rzvi+36U3NPXdZMC0aW7aDwuf/T3BAHfIJ
   jf0gJroiKofIJz8WzS01D+PA2p6F3JAtg0ayPohWTeKgqozysh6Q8xCAD
   Jd/lgcYyXCOgwuUJmGrCUD7YT1NqttnIoItZGaOQyHXsvk2kq/9Ttn9DC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="373266641"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="373266641"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 16:57:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="861570166"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="861570166"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Dec 2023 16:57:48 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAJkw-0008F4-0w;
        Tue, 05 Dec 2023 00:57:46 +0000
Date:   Tue, 5 Dec 2023 08:56:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Luben Tuikov <luben.tuikov@amd.com>
Subject: drivers/gpu/drm/scheduler/sched_main.c:266: warning: Function
 parameter or member 'result' not described in 'drm_sched_job_done'
Message-ID: <202312050753.wO5Zucbg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
commit: 539f9ee4b52a8bec95ff064e22dd2fb1e258e818 drm/scheduler: properly forward fence errors
date:   8 months ago
config: x86_64-buildonly-randconfig-004-20230906 (https://download.01.org/0day-ci/archive/20231205/202312050753.wO5Zucbg-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231205/202312050753.wO5Zucbg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312050753.wO5Zucbg-lkp@intel.com/

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
