Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80ED97D05D7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 02:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346788AbjJTAhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 20:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346721AbjJTAhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 20:37:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FDBA3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 17:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697762259; x=1729298259;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=U5Og3gFNFr48uYUyi8zgfbrV3Xvg5s1tnliY0dXezHM=;
  b=lfK18NYChQg1S7AAtlvN8aMra3GJTsGzGibe2F/KOblOfOYCqdL4w0Ic
   6smS33NWDh85o2Qf7L9b+MMeRbjeRmUhiPsqsYF9Di8InAcvPBjfq528Z
   VdraO/Ll99u7WjG8v92VkTBaMMFTuE82Ashemvq8wjc/h1WMzo+1OVpGD
   //+Svc7PD/Fx5luzlocT4Rrf7ro9R2IuCy0isSBR+ascYOtVlf++FIelo
   6c/QxpLsbhqlKYM/V0hDiLLAjhfF/GuFJOFJ4DA21ulq71sK46TANWXim
   tg7mrEUhCOeoL7k04kZd2mzszIPQW0WgC1/wM1oH9mckkCAlWDM7Js7xJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="385279692"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="385279692"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 17:37:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="733784111"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="733784111"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 19 Oct 2023 17:37:37 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qtdWB-0002mU-0J;
        Fri, 20 Oct 2023 00:37:35 +0000
Date:   Fri, 20 Oct 2023 08:37:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:mmap_sem.2023.10.18a 18/31]
 kernel/locking/qspinlock.c:741:23: warning: no previous declaration for
 '__pv_spinlock_dump'
Message-ID: <202310200814.xePmkBus-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git mmap_sem.2023.10.18a
head:   4015256f2bc734d4175381762282784597f41cfa
commit: 851f9c70733ed644c8a03d8f93f9876942181bee [18/31] EXP qspinlock: Add spinlock_dump() to dump lock state
config: x86_64-randconfig-016-20231020 (https://download.01.org/0day-ci/archive/20231020/202310200814.xePmkBus-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231020/202310200814.xePmkBus-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310200814.xePmkBus-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/locking/qspinlock.c:741:23: warning: no previous declaration for '__pv_spinlock_dump' [-Wmissing-declarations]
    #define spinlock_dump __pv_spinlock_dump
                          ^
   kernel/locking/qspinlock.c:691:6: note: in expansion of macro 'spinlock_dump'
    void spinlock_dump(spinlock_t *sp, bool full)
         ^~~~~~~~~~~~~


vim +/__pv_spinlock_dump +741 kernel/locking/qspinlock.c

   737	
   738	#undef  queued_spin_lock_slowpath
   739	#define queued_spin_lock_slowpath	__pv_queued_spin_lock_slowpath
   740	#define queued_spin_lock_slowpath_diags	__pv_queued_spin_lock_slowpath_diags
 > 741	#define spinlock_dump	__pv_spinlock_dump
   742	#define tail_to_cpu	__pv_tail_to_cpu
   743	#define tail_to_idx	__pv_tail_to_idx
   744	#define next_to_prev	__pv_next_to_prev
   745	#define next_to_cpu_idx	__pv_next_to_cpu_idx
   746	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
