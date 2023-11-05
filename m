Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19F97E1292
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 09:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjKEIXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 03:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjKEIXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 03:23:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE18CF
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 01:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699172620; x=1730708620;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fYX9k8RdI8NdsMG5qVT0ioFwZw7eWLFc78heJiQIfwc=;
  b=O+Pm29ydgjXXmLWMYPet5JVY7G7dJarPRuQAApGdmQcJLBwU4kjIxJDY
   m26C9CzZ/2o+cYJoLrY9ZkDMD6BBjkxo+rgXuBj58XZdlwex5T3d7Keuz
   fwjY9L99JirmUW69TT0hTVcmoXM6Ca3Ad7Ieb5Lw08UeKD+8P5V/l5LtD
   y+2b7xH1UIBt11w+FKfz4SZ4RBrUyD24eLa5E6DtdPy5VtdNmKnTST5gK
   kgbX6ltmfS4ordyzA6qpFVMDmv1Nl8sF88zSYKadlwcLYMAXKs5HoFkXO
   5TQG22eHD9WnM6UuXQ1xVcNWcbef9yJIIG+YbYzHFeAntreRm+S5kNkF/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="10669200"
X-IronPort-AV: E=Sophos;i="6.03,278,1694761200"; 
   d="scan'208";a="10669200"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 01:23:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="791183392"
X-IronPort-AV: E=Sophos;i="6.03,278,1694761200"; 
   d="scan'208";a="791183392"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 05 Nov 2023 01:23:37 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzYPv-0005C0-1u;
        Sun, 05 Nov 2023 08:23:35 +0000
Date:   Sun, 5 Nov 2023 16:22:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: arch/x86/kernel/callthunks.c:332:35: warning: '%lu' directive
 writing between 1 and 10 bytes into a region of size 7
Message-ID: <202311051618.RFyLD3DD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   aea6bf908d730b01bd264a8821159db9463c111c
commit: f5c1bb2afe93396d41c5cbdcb909b08a75b8dde4 x86/calldepth: Add ret/call counting for debug
date:   1 year, 1 month ago
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20231105/202311051618.RFyLD3DD-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231105/202311051618.RFyLD3DD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311051618.RFyLD3DD-lkp@intel.com/

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
