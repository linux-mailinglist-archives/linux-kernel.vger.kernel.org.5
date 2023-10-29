Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4967DAA4F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 02:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjJ2Azw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 20:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjJ2Azu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 20:55:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1F1E1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 17:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698540947; x=1730076947;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eF8fo2yUQBllFvcYLXvob+9lDFdhwOsHFerr3Z7u1a4=;
  b=POnFUdvCUx4EpTRRQd6h/j3YAEzaC6BCX6C+Hf/gwFCM6uqZDe3Xy7Cv
   4uKNxB59TOgIBksz8+pGeNLnXwOchVLTdvnApmk6XBLuNPauoLYucRmTP
   dIchzIy9Yy/eWne9ZoYLE3WrGNhcigjiFNog8xxvpnOecd//0dGVh8fIq
   HQ7P/STAr/IBEKmLxJjMr2npHUAlPmlo4Kp3sk66YbRTNWdb8ir62o1fQ
   48x8YWXftSUG53lcYQTR1Ux+4Q9a9nthLpUHOacT5YXGSI3KGOa4DPPhY
   RZIMz9W+tneL8Z/+brQ0jqdq0mtG9ozM4by6w3z92gowoxemAAD0cPhtc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10877"; a="391789901"
X-IronPort-AV: E=Sophos;i="6.03,260,1694761200"; 
   d="scan'208";a="391789901"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2023 17:55:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10877"; a="753456275"
X-IronPort-AV: E=Sophos;i="6.03,260,1694761200"; 
   d="scan'208";a="753456275"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 28 Oct 2023 17:55:45 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qwu5e-000CDb-2Y;
        Sun, 29 Oct 2023 00:55:42 +0000
Date:   Sun, 29 Oct 2023 08:55:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: arch/x86/kernel/callthunks.c:332:35: warning: '%lu' directive
 writing between 1 and 10 bytes into a region of size 7
Message-ID: <202310290814.2Io3e73Q-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2af9b20dbb39f6ebf9b9b6c090271594627d818e
commit: f5c1bb2afe93396d41c5cbdcb909b08a75b8dde4 x86/calldepth: Add ret/call counting for debug
date:   1 year ago
config: x86_64-randconfig-r013-20230116 (https://download.01.org/0day-ci/archive/20231029/202310290814.2Io3e73Q-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231029/202310290814.2Io3e73Q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310290814.2Io3e73Q-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/x86/kernel/callthunks.c: In function 'callthunks_debugfs_init':
>> arch/x86/kernel/callthunks.c:332:35: warning: '%lu' directive writing between 1 and 10 bytes into a region of size 7 [-Wformat-overflow=]
     332 |                 sprintf(name, "cpu%lu", cpu);
         |                                   ^~~
   arch/x86/kernel/callthunks.c:332:31: note: directive argument in the range [0, 4294967294]
     332 |                 sprintf(name, "cpu%lu", cpu);
         |                               ^~~~~~~~
   arch/x86/kernel/callthunks.c:332:17: note: 'sprintf' output between 5 and 14 bytes into a destination of size 10
     332 |                 sprintf(name, "cpu%lu", cpu);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +332 arch/x86/kernel/callthunks.c

   321	
   322	static int __init callthunks_debugfs_init(void)
   323	{
   324		struct dentry *dir;
   325		unsigned long cpu;
   326	
   327		dir = debugfs_create_dir("callthunks", NULL);
   328		for_each_possible_cpu(cpu) {
   329			void *arg = (void *)cpu;
   330			char name [10];
   331	
 > 332			sprintf(name, "cpu%lu", cpu);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
