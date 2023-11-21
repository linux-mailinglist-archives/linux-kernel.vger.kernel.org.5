Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E280A7F2405
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 03:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbjKUCcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 21:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbjKUCcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 21:32:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D427AA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 18:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700533967; x=1732069967;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=I3KXbIJz5aKj3iv+O03cvS4BabvvS6Y4JaK0ag7J/20=;
  b=EkMMJseqtHS+oBd1MsJiByMgnU8zi/lm0vNWVVpv1YOzZCSZwdft04I7
   5sAeVVu/2jh+/c+DZgqffpjgZdbafruHduk+PV6k6ivpzOWowbWU6IwZd
   d2CrzKXtXrtaqG0Zj61YPHfFO7+tydPGqVSyqDG41e2ReTs/OSBYcQZW1
   25M5Iy71KMLix3A+SCf3Ynh4YS68vV8yKUdx/r3KJ5qdF9+Pffxo4bHsQ
   BI6lQPOayO6ITuoFR0hoT+eFugpqPYSHJyfNMyqiudz16J4ShNfJ4OAvv
   Hivy5PcqrON/wE1f6w6FVMAWvhHgLYVNxpGnxUHx0DoD4eQHQC93feFy1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="371090888"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="371090888"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 18:32:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="939959223"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="939959223"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 20 Nov 2023 18:32:45 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5GZ9-0007CI-1w;
        Tue, 21 Nov 2023 02:32:43 +0000
Date:   Tue, 21 Nov 2023 10:32:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Waiman Long <longman@redhat.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: kernel/cgroup/debug.c:1: warning: no structured comments found
Message-ID: <202311211005.Qwt1FHrO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   98b1cc82c4affc16f5598d4fa14b1858671b2263
commit: a28f8f5e995fe5964ae304444913536058f26e37 cgroup: Move debug cgroup to its own file
date:   6 years ago
config: i386-buildonly-randconfig-005-20231120 (https://download.01.org/0day-ci/archive/20231121/202311211005.Qwt1FHrO-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231121/202311211005.Qwt1FHrO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311211005.Qwt1FHrO-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/cgroup/debug.c:1: warning: no structured comments found


vim +1 kernel/cgroup/debug.c

   > 1	#include <linux/ctype.h>
     2	#include <linux/mm.h>
     3	#include <linux/slab.h>
     4	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
