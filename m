Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0015E7D1EB0
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 19:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjJURm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 13:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjJURmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 13:42:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28FA119
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 10:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697910140; x=1729446140;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TAOgAmMpcce3ktAlcM1kCtu5dm/xjLW86GsQE1F0X1I=;
  b=UKmWDknbb6uSUyPRVEaLiyNatYZB5Bl6uMl3ix/GZttDm7lPYnzinEFJ
   TZRJzj/T7Gbm51YzQkO6qnIcUm6JwVT5cqC6F9Gh6ySAYD/WAhwh2frSy
   VDghIg5KDiZf6nvFgV0MP3K4WeuSPUbaX8bKFFm1b5oTpOEaWlloxJDip
   OHZo8qphvPQefiDtJlnWQXI4pchBEQnKckr+4QhD584Z9FuuNbQPPWR6M
   ALM3pjD9Jl+w06TVsxEAN37w/XJ7hm5+jUAQFjy1hGZsf7WCLgoYdUSRM
   h8RVs6Eo17SQnadis4os4cFDtdeJsYGzVt9pWJ2BY8VKbFqKFgJmsoKw1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="383849809"
X-IronPort-AV: E=Sophos;i="6.03,241,1694761200"; 
   d="scan'208";a="383849809"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2023 10:42:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="901418020"
X-IronPort-AV: E=Sophos;i="6.03,241,1694761200"; 
   d="scan'208";a="901418020"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 21 Oct 2023 10:40:05 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1quFzM-000566-0d;
        Sat, 21 Oct 2023 17:42:16 +0000
Date:   Sun, 22 Oct 2023 01:41:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: drivers/cpuidle/governors/ladder.c:54: warning: Function parameter
 or member 'dev' not described in 'ladder_do_selection'
Message-ID: <202310220146.HIH4ghQD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9c5d00cb7b6bbc5a7965d9ab7d223b5402d1f02c
commit: 7d4daeedd575bbc3c40c87fc6708a8b88c50fe7e governors: unify last_state_idx
date:   4 years, 3 months ago
config: x86_64-alldefconfig (https://download.01.org/0day-ci/archive/20231022/202310220146.HIH4ghQD-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231022/202310220146.HIH4ghQD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310220146.HIH4ghQD-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/cpuidle/governors/ladder.c:54: warning: Function parameter or member 'dev' not described in 'ladder_do_selection'


vim +54 drivers/cpuidle/governors/ladder.c

4f86d3a8e297205 Len Brown       2007-10-03  44  
4f86d3a8e297205 Len Brown       2007-10-03  45  /**
4f86d3a8e297205 Len Brown       2007-10-03  46   * ladder_do_selection - prepares private data for a state change
4f86d3a8e297205 Len Brown       2007-10-03  47   * @ldev: the ladder device
4f86d3a8e297205 Len Brown       2007-10-03  48   * @old_idx: the current state index
4f86d3a8e297205 Len Brown       2007-10-03  49   * @new_idx: the new target state index
4f86d3a8e297205 Len Brown       2007-10-03  50   */
7d4daeedd575bbc Marcelo Tosatti 2019-07-03  51  static inline void ladder_do_selection(struct cpuidle_device *dev,
7d4daeedd575bbc Marcelo Tosatti 2019-07-03  52  				       struct ladder_device *ldev,
4f86d3a8e297205 Len Brown       2007-10-03  53  				       int old_idx, int new_idx)
4f86d3a8e297205 Len Brown       2007-10-03 @54  {
4f86d3a8e297205 Len Brown       2007-10-03  55  	ldev->states[old_idx].stats.promotion_count = 0;
4f86d3a8e297205 Len Brown       2007-10-03  56  	ldev->states[old_idx].stats.demotion_count = 0;
7d4daeedd575bbc Marcelo Tosatti 2019-07-03  57  	dev->last_state_idx = new_idx;
4f86d3a8e297205 Len Brown       2007-10-03  58  }
4f86d3a8e297205 Len Brown       2007-10-03  59  

:::::: The code at line 54 was first introduced by commit
:::::: 4f86d3a8e297205780cca027e974fd5f81064780 cpuidle: consolidate 2.6.22 cpuidle branch into one patch

:::::: TO: Len Brown <len.brown@intel.com>
:::::: CC: Len Brown <len.brown@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
