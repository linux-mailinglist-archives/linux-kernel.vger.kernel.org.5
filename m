Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0FD7BBC38
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 17:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbjJFP5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 11:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjJFP5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 11:57:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262E8A6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 08:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696607841; x=1728143841;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kzc0LYg6L2msZi6SaSG/KRmbXMM8HDRdyUT2641/IrQ=;
  b=KLVn+zI3yenlJkuXgb0RNJ4Dv7HP6xodD4xd3CKD+M2qMLJXX+eI023z
   oOC2wuXUHD+r6Ww1Dc0NX0WwO8V0aDBsbzCH0Y/OH1Vj2utA97bxLLf+I
   qjEP8E1TZlCfzL/FwzPPNPJPJ5X62XXEL4FY6q9uNS9p2fNpQFKI4YzHK
   r8LwIHOlK07UxISZPvRJOSGbpnarA6bXKVJ0WTnoYWVm868QQMoyoluT/
   mHN+yIdRCyMpvchnwfJ4Mzz399eP+KDFvHaoQhIGVxfjCl8gFf0hFTyLE
   S8FTXEuAHgeAmOSlUknlroaMfybmuV3kam0Mbk3FRdL7Q1XPm9aW3+HmF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="2379207"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="2379207"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 08:57:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="745911413"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="745911413"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 06 Oct 2023 08:57:18 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qonCW-0003Lt-0N;
        Fri, 06 Oct 2023 15:57:16 +0000
Date:   Fri, 6 Oct 2023 23:57:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>
Subject: arch/x86/kernel/cpu/resctrl/monitor.c:38: warning: Cannot understand
  * @rmid_free_lru    A least recently used list of free RMIDs
Message-ID: <202310062356.lX3xpLP9-lkp@intel.com>
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

Hi Johannes,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b78b18fb8ee19f7a05f20c3abc865b3bfe182884
commit: e6d429313ea5c776d2e76b4494df69102e6b7115 x86/resctrl: Avoid confusion over the new X86_RESCTRL config
date:   4 years, 8 months ago
config: x86_64-randconfig-003-20230909 (https://download.01.org/0day-ci/archive/20231006/202310062356.lX3xpLP9-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231006/202310062356.lX3xpLP9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310062356.lX3xpLP9-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/cpu/resctrl/monitor.c:38: warning: Cannot understand  * @rmid_free_lru    A least recently used list of free RMIDs
    on line 38 - I thought it was a doc line
>> arch/x86/kernel/cpu/resctrl/monitor.c:45: warning: Cannot understand  * @rmid_limbo_count     count of currently unused but (potentially)
    on line 45 - I thought it was a doc line
>> arch/x86/kernel/cpu/resctrl/monitor.c:54: warning: Cannot understand  * @rmid_entry - The entry in the limbo and free lists.
    on line 54 - I thought it was a doc line
--
>> arch/x86/kernel/cpu/resctrl/rdtgroup.c:803: warning: Function parameter or member 'of' not described in 'rdt_bit_usage_show'
>> arch/x86/kernel/cpu/resctrl/rdtgroup.c:803: warning: Function parameter or member 'seq' not described in 'rdt_bit_usage_show'
>> arch/x86/kernel/cpu/resctrl/rdtgroup.c:803: warning: Function parameter or member 'v' not described in 'rdt_bit_usage_show'
>> arch/x86/kernel/cpu/resctrl/rdtgroup.c:1148: warning: Function parameter or member 'rdtgrp' not described in 'rdtgroup_mode_test_exclusive'
>> arch/x86/kernel/cpu/resctrl/rdtgroup.c:1181: warning: Function parameter or member 'of' not described in 'rdtgroup_mode_write'
>> arch/x86/kernel/cpu/resctrl/rdtgroup.c:1181: warning: Function parameter or member 'buf' not described in 'rdtgroup_mode_write'
>> arch/x86/kernel/cpu/resctrl/rdtgroup.c:1181: warning: Function parameter or member 'nbytes' not described in 'rdtgroup_mode_write'
>> arch/x86/kernel/cpu/resctrl/rdtgroup.c:1181: warning: Function parameter or member 'off' not described in 'rdtgroup_mode_write'
>> arch/x86/kernel/cpu/resctrl/rdtgroup.c:1290: warning: Function parameter or member 'of' not described in 'rdtgroup_size_show'
>> arch/x86/kernel/cpu/resctrl/rdtgroup.c:1290: warning: Function parameter or member 's' not described in 'rdtgroup_size_show'
>> arch/x86/kernel/cpu/resctrl/rdtgroup.c:1290: warning: Function parameter or member 'v' not described in 'rdtgroup_size_show'
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:2483: warning: Function parameter or member 'rdtgrp' not described in 'rdtgroup_init_alloc'


vim +38 arch/x86/kernel/cpu/resctrl/monitor.c

6a445edce65781 arch/x86/kernel/cpu/intel_rdt_monitor.c Vikas Shivappa 2017-07-25  36  
6a445edce65781 arch/x86/kernel/cpu/intel_rdt_monitor.c Vikas Shivappa 2017-07-25  37  /**
6a445edce65781 arch/x86/kernel/cpu/intel_rdt_monitor.c Vikas Shivappa 2017-07-25 @38   * @rmid_free_lru    A least recently used list of free RMIDs
6a445edce65781 arch/x86/kernel/cpu/intel_rdt_monitor.c Vikas Shivappa 2017-07-25  39   *     These RMIDs are guaranteed to have an occupancy less than the
6a445edce65781 arch/x86/kernel/cpu/intel_rdt_monitor.c Vikas Shivappa 2017-07-25  40   *     threshold occupancy
6a445edce65781 arch/x86/kernel/cpu/intel_rdt_monitor.c Vikas Shivappa 2017-07-25  41   */
6a445edce65781 arch/x86/kernel/cpu/intel_rdt_monitor.c Vikas Shivappa 2017-07-25  42  static LIST_HEAD(rmid_free_lru);
6a445edce65781 arch/x86/kernel/cpu/intel_rdt_monitor.c Vikas Shivappa 2017-07-25  43  
6a445edce65781 arch/x86/kernel/cpu/intel_rdt_monitor.c Vikas Shivappa 2017-07-25  44  /**
24247aeeabe99e arch/x86/kernel/cpu/intel_rdt_monitor.c Vikas Shivappa 2017-08-15 @45   * @rmid_limbo_count     count of currently unused but (potentially)
6a445edce65781 arch/x86/kernel/cpu/intel_rdt_monitor.c Vikas Shivappa 2017-07-25  46   *     dirty RMIDs.
24247aeeabe99e arch/x86/kernel/cpu/intel_rdt_monitor.c Vikas Shivappa 2017-08-15  47   *     This counts RMIDs that no one is currently using but that
6a445edce65781 arch/x86/kernel/cpu/intel_rdt_monitor.c Vikas Shivappa 2017-07-25  48   *     may have a occupancy value > intel_cqm_threshold. User can change
6a445edce65781 arch/x86/kernel/cpu/intel_rdt_monitor.c Vikas Shivappa 2017-07-25  49   *     the threshold occupancy value.
6a445edce65781 arch/x86/kernel/cpu/intel_rdt_monitor.c Vikas Shivappa 2017-07-25  50   */
5fd88b60e11b7d arch/x86/kernel/cpu/intel_rdt_monitor.c Colin Ian King 2017-10-02  51  static unsigned int rmid_limbo_count;
6a445edce65781 arch/x86/kernel/cpu/intel_rdt_monitor.c Vikas Shivappa 2017-07-25  52  
6a445edce65781 arch/x86/kernel/cpu/intel_rdt_monitor.c Vikas Shivappa 2017-07-25  53  /**
6a445edce65781 arch/x86/kernel/cpu/intel_rdt_monitor.c Vikas Shivappa 2017-07-25 @54   * @rmid_entry - The entry in the limbo and free lists.
6a445edce65781 arch/x86/kernel/cpu/intel_rdt_monitor.c Vikas Shivappa 2017-07-25  55   */
6a445edce65781 arch/x86/kernel/cpu/intel_rdt_monitor.c Vikas Shivappa 2017-07-25  56  static struct rmid_entry	*rmid_ptrs;
6a445edce65781 arch/x86/kernel/cpu/intel_rdt_monitor.c Vikas Shivappa 2017-07-25  57  

:::::: The code at line 38 was first introduced by commit
:::::: 6a445edce657810992594c7b9e679219aaf78ad9 x86/intel_rdt/cqm: Add RDT monitoring initialization

:::::: TO: Vikas Shivappa <vikas.shivappa@linux.intel.com>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
