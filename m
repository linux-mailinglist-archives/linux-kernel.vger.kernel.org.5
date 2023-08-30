Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D30B78D14C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 02:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238945AbjH3AsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 20:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239065AbjH3Ar6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 20:47:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B95E1A6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 17:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693356474; x=1724892474;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iRKqGOCD1jPpP0gdXraU2Y9bRhIFBBPhhueZ1wERy4A=;
  b=g7Sdp0etWCP/P0kVWTop5e23RmoSnOPjgfRIaggGmcfOy89+meqlNSAF
   UzUsOqPzlUxCzdnh+duWXpAUlxslQdX7Osapza5cHuwMrazDzJhRPUxnd
   k6TWiX8roLhgmi0F0hygte14cfIQrVTvFUQOblqvX/zP4iISGsIeHmv1p
   pV1Ir4wLJLaNs23OYDhRxHtNihYQeQiq47qkXWkbmIh3K+R5HUp+zOErm
   RxIwBYkkPyddWCGR8HVoEnogsSowim92O4+IkvkwfIEZKzUFdNoY82u6V
   0JNdkVmjirPVs151fIvog6UFm9lpYyAxDGDvxvISaQ428+COBArsaTD/9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="360514256"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="360514256"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 17:47:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="808895731"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="808895731"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 29 Aug 2023 17:47:45 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qb9N3-0009Fj-0Q;
        Wed, 30 Aug 2023 00:47:45 +0000
Date:   Wed, 30 Aug 2023 08:46:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Helge Deller <deller@gmx.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/parisc/sba_iommu.c:124:31: warning: 'proc_runway_root'
 defined but not used
Message-ID: <202308300800.Jod4sHzM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d68b4b6f307d155475cce541f2aee938032ed22e
commit: 77e0ddf097d6d4ceaf898e088b133b99e0a97fa0 parisc: ccio-dma: Create private runway procfs root entry
date:   33 hours ago
config: parisc-randconfig-r035-20230830 (https://download.01.org/0day-ci/archive/20230830/202308300800.Jod4sHzM-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230830/202308300800.Jod4sHzM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308300800.Jod4sHzM-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/parisc/sba_iommu.c:124:31: warning: 'proc_runway_root' defined but not used [-Wunused-variable]
     124 | static struct proc_dir_entry *proc_runway_root __ro_after_init;
         |                               ^~~~~~~~~~~~~~~~


vim +/proc_runway_root +124 drivers/parisc/sba_iommu.c

   123	
 > 124	static struct proc_dir_entry *proc_runway_root __ro_after_init;
   125	struct proc_dir_entry *proc_mckinley_root __ro_after_init;
   126	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
