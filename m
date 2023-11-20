Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED937F1E78
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 22:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjKTVB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 16:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjKTVB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 16:01:57 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45BDA2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 13:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700514113; x=1732050113;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t+grIEx/OoWq8S+aVx/HW0aGncH3ytPBS0KnbHH97xM=;
  b=MXB7afFw1McYwAYQRIpZMQedE0qgDp4EGQFCmWlmyCxjnsany7QopEgs
   VtT4knfkSJ/2/ZyB8UiT8R8i4p1sASqiP2S64r2PAGTOGAgbuBa+ftuyg
   /UCsS4/s9oWC7wXDrcK5DYkWBL5HLUTElRkaSCr1HcEHU9j1ZTW+09cYL
   LcddXZxdsz/XKVCqQhdV6ak7NZlJoi9WQYF/+lhmtOTVs8ecXobplDhG5
   ZUclK6lzyIJpD7Sg6IHHEWZUBSbQ1U816/jkKHui668lNvUBClj/oTf2Q
   GGCPduaCIejIgb2VRdMl/KMB3ipsQUPzsElxUVBdxnAc5mjrMQPWZO7rb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="395632414"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="395632414"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 13:01:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="7837599"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 20 Nov 2023 13:01:46 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5BOq-0006v8-0K;
        Mon, 20 Nov 2023 21:01:44 +0000
Date:   Tue, 21 Nov 2023 05:01:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yong He <zhuangel570@gmail.com>, tj@kernel.org,
        jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] workqueue: fix invalid cpu in kick_pool
Message-ID: <202311210443.gdbUH0vN-lkp@intel.com>
References: <20231120121623.119780-1-alexyonghe@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120121623.119780-1-alexyonghe@tencent.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yong,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tj-wq/for-next]
[also build test WARNING on linus/master v6.7-rc2 next-20231120]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yong-He/workqueue-fix-invalid-cpu-in-kick_pool/20231120-201849
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-next
patch link:    https://lore.kernel.org/r/20231120121623.119780-1-alexyonghe%40tencent.com
patch subject: [PATCH] workqueue: fix invalid cpu in kick_pool
config: arc-randconfig-001-20231121 (https://download.01.org/0day-ci/archive/20231121/202311210443.gdbUH0vN-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231121/202311210443.gdbUH0vN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311210443.gdbUH0vN-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/workqueue.c: In function 'kick_pool':
>> kernel/workqueue.c:1109:13: warning: unused variable 'cpu' [-Wunused-variable]
    1109 |         int cpu;
         |             ^~~


vim +/cpu +1109 kernel/workqueue.c

  1097	
  1098	/**
  1099	 * kick_pool - wake up an idle worker if necessary
  1100	 * @pool: pool to kick
  1101	 *
  1102	 * @pool may have pending work items. Wake up worker if necessary. Returns
  1103	 * whether a worker was woken up.
  1104	 */
  1105	static bool kick_pool(struct worker_pool *pool)
  1106	{
  1107		struct worker *worker = first_idle_worker(pool);
  1108		struct task_struct *p;
> 1109		int cpu;
  1110	
  1111		lockdep_assert_held(&pool->lock);
  1112	
  1113		if (!need_more_worker(pool) || !worker)
  1114			return false;
  1115	
  1116		p = worker->task;
  1117	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
