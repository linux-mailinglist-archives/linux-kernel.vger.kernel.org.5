Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5CA7E8E3F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 05:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjKLESA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 23:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKLER6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 23:17:58 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF5230D1;
        Sat, 11 Nov 2023 20:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699762675; x=1731298675;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e9isCT7bEJcgrzgtVQaKx8GL3i4TzCEIyJxvqM33IBc=;
  b=LNCd5Tna/flOaNldubf6zJtqMsLTPmBmByVzx/I2b0hV9vWR60K7qJEW
   IW7Loa//SHii0IJKz+0rvVIySidrrV13PesTdOKvh4hilrx3PZ0+/Lijh
   e6NaI+NamqfLCw9uZqWtctTpZk9uN7YjbXBE62Ej1f5n/OWHd6u3cPoIG
   2wGk9YLFa5cldaaPoBsAlgKIHYC6bBxIWierUh7wtRa9v6PdzAZWIJybr
   bk5qYQ2lvgPmHo+gCoQ2+Tn6t47XJIumTXWVZ/eMutSjcZBvPzgDnu41f
   aN8mpHRVMeg1DEysCM24rA5g//6UmcsfzBiFwd9gyVtkWWzjyq4wWcmGc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="369639124"
X-IronPort-AV: E=Sophos;i="6.03,296,1694761200"; 
   d="scan'208";a="369639124"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 20:17:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="798901291"
X-IronPort-AV: E=Sophos;i="6.03,296,1694761200"; 
   d="scan'208";a="798901291"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 11 Nov 2023 20:17:48 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r21ur-000Awc-2p;
        Sun, 12 Nov 2023 04:17:45 +0000
Date:   Sun, 12 Nov 2023 12:17:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>, torvalds@linux-foundation.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
        changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 13/36] sched_ext: Add scx_simple and scx_example_qmap
 example schedulers
Message-ID: <202311121239.GTR1obNe-lkp@intel.com>
References: <20231111024835.2164816-14-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231111024835.2164816-14-tj@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

kernel test robot noticed the following build errors:

[auto build test ERROR on linux/master]
[also build test ERROR on linus/master next-20231110]
[cannot apply to tip/sched/core tj-cgroup/for-next v6.6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tejun-Heo/sched-Restructure-sched_class-order-sanity-checks-in-sched_init/20231111-145751
base:   linux/master
patch link:    https://lore.kernel.org/r/20231111024835.2164816-14-tj%40kernel.org
patch subject: [PATCH 13/36] sched_ext: Add scx_simple and scx_example_qmap example schedulers
reproduce: (https://download.01.org/0day-ci/archive/20231112/202311121239.GTR1obNe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311121239.GTR1obNe-lkp@intel.com/

All errors (new ones prefixed by >>):

>> Makefile:83: *** Cannot find a vmlinux for VMLINUX_BTF at any of "  ../../vmlinux /sys/kernel/btf/vmlinux /boot/vmlinux-5.9.0-0.bpo.2-amd64".  Stop.

vim +83 Makefile

^1da177e4c3f41 Linus Torvalds 2005-04-16  81  
^1da177e4c3f41 Linus Torvalds 2005-04-16  82  ifeq ("$(origin V)", "command line")
^1da177e4c3f41 Linus Torvalds 2005-04-16 @83    KBUILD_VERBOSE = $(V)
^1da177e4c3f41 Linus Torvalds 2005-04-16  84  endif
^1da177e4c3f41 Linus Torvalds 2005-04-16  85  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
