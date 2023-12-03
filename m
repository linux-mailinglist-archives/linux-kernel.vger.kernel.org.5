Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947F3802542
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 16:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbjLCPsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 10:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbjLCPsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 10:48:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD68F2
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 07:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701618536; x=1733154536;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HTifXAT4eCqiavmvvLk91KGer2ZgFrOrc5l9rPnlkIE=;
  b=gBB2oX83fp2AOq24nEqljFJnak9FXj5fm1WHBBhmG0tDRhqt2k48MflV
   QnASIKWtTVwjCr1M2gEswyv5NfWi6QsbEiWF8Q1oBzJuWiGTtBCEmSf46
   8LQnAx0uOjLSa06SEnHezl3t5NMf5RPR6rGs9kszDv/r/aA3bWU8m/TLn
   5sLC/Uh+82iEHT7aA4KT4+Mih4Ip/Ow5qMSF39hzc4iQf6pwnlbP+dgJ3
   FH988iOUpGNwnuRxXfbrLLPLZGjDxLdzZC1H1dYQg2YfRGThZhN8JpSsQ
   CasW6ZgadlsGIFZ7h61bEPeTfusIJfxIwUyn54ln3X7sflX67vlp62O11
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="378683566"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="378683566"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2023 07:48:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="893737730"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="893737730"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 03 Dec 2023 07:48:52 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r9oi9-0006nY-1i;
        Sun, 03 Dec 2023 15:48:49 +0000
Date:   Sun, 3 Dec 2023 23:48:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: drivers/cpuidle/governors/ladder.c:54: warning: Function parameter
 or member 'dev' not described in 'ladder_do_selection'
Message-ID: <202312032330.fMc5ODUJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   33cc938e65a98f1d29d0a18403dbbee050dcad9a
commit: 7d4daeedd575bbc3c40c87fc6708a8b88c50fe7e governors: unify last_state_idx
date:   4 years, 4 months ago
config: x86_64-randconfig-r015-20230805 (https://download.01.org/0day-ci/archive/20231203/202312032330.fMc5ODUJ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231203/202312032330.fMc5ODUJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312032330.fMc5ODUJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/cpuidle/governors/ladder.c:54: warning: Function parameter or member 'dev' not described in 'ladder_do_selection'


vim +54 drivers/cpuidle/governors/ladder.c

4f86d3a8e29720 Len Brown       2007-10-03  44  
4f86d3a8e29720 Len Brown       2007-10-03  45  /**
4f86d3a8e29720 Len Brown       2007-10-03  46   * ladder_do_selection - prepares private data for a state change
4f86d3a8e29720 Len Brown       2007-10-03  47   * @ldev: the ladder device
4f86d3a8e29720 Len Brown       2007-10-03  48   * @old_idx: the current state index
4f86d3a8e29720 Len Brown       2007-10-03  49   * @new_idx: the new target state index
4f86d3a8e29720 Len Brown       2007-10-03  50   */
7d4daeedd575bb Marcelo Tosatti 2019-07-03  51  static inline void ladder_do_selection(struct cpuidle_device *dev,
7d4daeedd575bb Marcelo Tosatti 2019-07-03  52  				       struct ladder_device *ldev,
4f86d3a8e29720 Len Brown       2007-10-03  53  				       int old_idx, int new_idx)
4f86d3a8e29720 Len Brown       2007-10-03 @54  {
4f86d3a8e29720 Len Brown       2007-10-03  55  	ldev->states[old_idx].stats.promotion_count = 0;
4f86d3a8e29720 Len Brown       2007-10-03  56  	ldev->states[old_idx].stats.demotion_count = 0;
7d4daeedd575bb Marcelo Tosatti 2019-07-03  57  	dev->last_state_idx = new_idx;
4f86d3a8e29720 Len Brown       2007-10-03  58  }
4f86d3a8e29720 Len Brown       2007-10-03  59  

:::::: The code at line 54 was first introduced by commit
:::::: 4f86d3a8e297205780cca027e974fd5f81064780 cpuidle: consolidate 2.6.22 cpuidle branch into one patch

:::::: TO: Len Brown <len.brown@intel.com>
:::::: CC: Len Brown <len.brown@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
