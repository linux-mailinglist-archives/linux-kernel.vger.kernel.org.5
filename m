Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0786A7E8E0A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 03:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjKLC4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 21:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKLC4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 21:56:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C7630F7
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 18:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699757808; x=1731293808;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BkSL3nCgo0GguoyiHtH8QGOQwv/jQtbkQV3vMQdjSL8=;
  b=F7z6x2Pm36cYFEWD1UpFypMfIMX8QhjRRTWzaIGrO3exVUdr9bcCLpnb
   wvHN+gqslgQx4B+p9wsnsODVdTZ1CZHq3+wVKhn7HSxeCUZyHmULykfvz
   usyl2b7C34N8NpTl6kc1E3jpwJUpGqhiebqG0xyTsIVbbQHeaSLUNFm8H
   Mt3sbjRFB8juaYwnSVxHJKUxRhHplr0gXvRGa/GIgLABaMPB8agRMkvOP
   dEZr9EWvY5zM3syF8MugIYXtQ3H/Jur/R6MzN40muNOrPwucMSGa/nCe4
   LkaZdB54soLNUbwejQOqHt3yKqNwThpZoWhtXr9ApYkc31IZC9VT6i2CH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="11859135"
X-IronPort-AV: E=Sophos;i="6.03,296,1694761200"; 
   d="scan'208";a="11859135"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 18:56:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="881320856"
X-IronPort-AV: E=Sophos;i="6.03,296,1694761200"; 
   d="scan'208";a="881320856"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 11 Nov 2023 18:56:46 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r20eS-000Au6-2X;
        Sun, 12 Nov 2023 02:56:44 +0000
Date:   Sun, 12 Nov 2023 10:55:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: drivers/cpuidle/governors/ladder.c:54: warning: Function parameter
 or member 'dev' not described in 'ladder_do_selection'
Message-ID: <202311121013.hcdaCtXP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3ca112b71f35dd5d99fc4571a56b5fc6f0c15814
commit: 7d4daeedd575bbc3c40c87fc6708a8b88c50fe7e governors: unify last_state_idx
date:   4 years, 3 months ago
config: x86_64-alldefconfig (https://download.01.org/0day-ci/archive/20231112/202311121013.hcdaCtXP-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231112/202311121013.hcdaCtXP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311121013.hcdaCtXP-lkp@intel.com/

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
