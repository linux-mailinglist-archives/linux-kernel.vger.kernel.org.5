Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F5A80B9B3
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 08:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjLJHlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 02:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjLJHl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 02:41:29 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DEA10A
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 23:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702194096; x=1733730096;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+vRgyiGCgqomPHbMSPZxXKVYs5y39GKQCXahIcyMcLo=;
  b=VTjy+jqvBH0OsNdaSEGZIizmBY0ILC5HP4zgbAe86CcJByyj+LiL5hF8
   mLepXeIQZ7AxCbLYn8oq+q8VkgwrCVrXAUuXn+GCZLiefHCVkuqtDrIq6
   fftq5XzXDSD1XInUQGR/IexYmK/HdeqwWEZDYeTGQMofBZf7rj1G+cVnp
   6CrKV16YlspzrbUHSuSI5QlhpNJayXsK98S7Q7ANt82W7fQ9yyXpGz+PN
   hzZLlYpyN4tOjMzvFiiBYjHJdiJqmdgFv/9OIo/0DGzx5pYYp37b5rT7L
   xpC2y0qCj41X3Z4YR3XoNElXOZZSurKbxwZwmNF+WCQNkwszi+GrF6Y+P
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="393408236"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="393408236"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 23:41:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="1104043153"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="1104043153"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 09 Dec 2023 23:41:34 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rCERQ-000GYP-1j;
        Sun, 10 Dec 2023 07:41:32 +0000
Date:   Sun, 10 Dec 2023 15:40:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wyes Karny <wyes.karny@amd.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Perry Yuan <perry.yuan@amd.com>
Subject: include/linux/amd-pstate.h:87:27: warning: 'amd_pstate_mode_string'
 defined but not used
Message-ID: <202312101512.2BOW7iSz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wyes,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c527f5606aa545233a4d2c6d5c636ed82b8633ef
commit: 36c5014e5460963ad7766487c0e22a7ff28681fc cpufreq: amd-pstate: optimize driver working mode selection in amd_pstate_param()
date:   10 months ago
config: x86_64-buildonly-randconfig-004-20231010 (https://download.01.org/0day-ci/archive/20231210/202312101512.2BOW7iSz-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231210/202312101512.2BOW7iSz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312101512.2BOW7iSz-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/cpufreq/amd-pstate-ut.c:29:
>> include/linux/amd-pstate.h:87:27: warning: 'amd_pstate_mode_string' defined but not used [-Wunused-const-variable=]
      87 | static const char * const amd_pstate_mode_string[] = {
         |                           ^~~~~~~~~~~~~~~~~~~~~~


vim +/amd_pstate_mode_string +87 include/linux/amd-pstate.h

    86	
  > 87	static const char * const amd_pstate_mode_string[] = {
    88		[AMD_PSTATE_DISABLE]     = "disable",
    89		[AMD_PSTATE_PASSIVE]     = "passive",
    90		[AMD_PSTATE_ACTIVE]      = "active",
    91		NULL,
    92	};
    93	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
