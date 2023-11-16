Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7366E7EDBD1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 08:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjKPHPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 02:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjKPHPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 02:15:53 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11264197
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 23:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700118950; x=1731654950;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=c+IPOqklc31jQ5GJXna+TFaVrgBYMqlZiLJ6XjApKP8=;
  b=oBiqDlTwQ1SRL4ruhF7FuN1ciclbkkUkLkxh3nmC9iE7w5ky1pUdcCDp
   S0yU6qAdYNCLV5YGwk7rP2DAW0+N1EY9r59MSa90+KmSSJIm6zQYY2Z3n
   GbSMR9KecqPqdd9TZL38opor/JNRYoel5NxS3r0uODc66vo8uU1Z4ww3J
   ZTOzkdbhX0INReigqtFx040891YaItVEo5VQEl7D0gIuQb0hqbMdPzd3a
   Pz0xhBwWwyCi4LHmUejUHbi1/MAFy9jGiBlX8D+9Gif+L968E6R4eal6V
   J96khO/Tt65yLyZjD6kc4rQ+Lf91amctmlJfVGdKUCAngYgojHP1HEM49
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="370391407"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="370391407"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 23:15:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="888830220"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="888830220"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 15 Nov 2023 23:15:48 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r3WbJ-0001Rn-21;
        Thu, 16 Nov 2023 07:15:45 +0000
Date:   Thu, 16 Nov 2023 15:15:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>
Subject: kernel/locking/locktorture.c:127:23: sparse: sparse: symbol
 'call_rcu_chain' was not declared. Should it be static?
Message-ID: <202311161525.FcMR6mQM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c42d9eeef8e5ba9292eda36fd8e3c11f35ee065c
commit: 7f993623e9ebcd633c0f760991e5078b95a37db3 locktorture: Add call_rcu_chains module parameter
date:   8 weeks ago
config: sparc-randconfig-r021-20230427 (https://download.01.org/0day-ci/archive/20231116/202311161525.FcMR6mQM-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20231116/202311161525.FcMR6mQM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311161525.FcMR6mQM-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/locking/locktorture.c:127:23: sparse: sparse: symbol 'call_rcu_chain' was not declared. Should it be static?
   kernel/locking/locktorture.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/umh.h, include/linux/kmod.h, ...):
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false
   kernel/locking/locktorture.c:496:12: sparse: sparse: context imbalance in 'torture_mutex_lock' - wrong count at exit
   kernel/locking/locktorture.c:512:13: sparse: sparse: context imbalance in 'torture_mutex_unlock' - wrong count at exit
   kernel/locking/locktorture.c:570:12: sparse: sparse: context imbalance in 'torture_ww_mutex_lock' - wrong count at exit
   kernel/locking/locktorture.c:614:13: sparse: sparse: context imbalance in 'torture_ww_mutex_unlock' - wrong count at exit
   kernel/locking/locktorture.c:665:12: sparse: sparse: context imbalance in 'torture_rtmutex_lock' - wrong count at exit
   kernel/locking/locktorture.c:689:13: sparse: sparse: context imbalance in 'torture_rtmutex_unlock' - wrong count at exit
   kernel/locking/locktorture.c:729:12: sparse: sparse: context imbalance in 'torture_rwsem_down_write' - wrong count at exit
   kernel/locking/locktorture.c:745:13: sparse: sparse: context imbalance in 'torture_rwsem_up_write' - wrong count at exit
   kernel/locking/locktorture.c:751:12: sparse: sparse: context imbalance in 'torture_rwsem_down_read' - wrong count at exit
   kernel/locking/locktorture.c:769:13: sparse: sparse: context imbalance in 'torture_rwsem_up_read' - wrong count at exit
   kernel/locking/locktorture.c:799:12: sparse: sparse: context imbalance in 'torture_percpu_rwsem_down_write' - wrong count at exit
   kernel/locking/locktorture.c:806:13: sparse: sparse: context imbalance in 'torture_percpu_rwsem_up_write' - wrong count at exit
   kernel/locking/locktorture.c: note: in included file (through include/linux/fs.h, include/linux/proc_fs.h, arch/sparc/include/asm/prom.h, ...):
   include/linux/percpu-rwsem.h:70:9: sparse: sparse: context imbalance in 'torture_percpu_rwsem_down_read' - wrong count at exit
   include/linux/percpu-rwsem.h:121:9: sparse: sparse: context imbalance in 'torture_percpu_rwsem_up_read' - wrong count at exit

vim +/call_rcu_chain +127 kernel/locking/locktorture.c

   122	
   123	struct call_rcu_chain {
   124		struct rcu_head crc_rh;
   125		bool crc_stop;
   126	};
 > 127	struct call_rcu_chain *call_rcu_chain;
   128	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
