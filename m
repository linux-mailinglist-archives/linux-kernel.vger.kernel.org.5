Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18F280214F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 07:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbjLCGeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 01:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbjLCGeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 01:34:07 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F49102
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 22:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701585227; x=1733121227;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4OAkahF0bBJzKDBPfgxrcW/iCyBN5+YRtt0Z5Yo1vxE=;
  b=ekmYr2rgFTKJyHo+DC+/XWPOR/BFnkQrDtu/Y36Q1O/KXYC36k7NN7Zi
   laLwO0YUPZEb0B+U43UQ8V2m1cmLYuIQa1l1aIz4wY4xO9m8IPYBtzPlh
   7I2Y7lY7fQfL7BhnAPEhsCXQuKf6KQnG9o6gyxtn/UTPF/7IBJdELK8Yd
   V4SXCO7iAcvXB+Mcbl73VIvbtWt9oAr64US2piuLCILSvEYPXhZB5I+xj
   uxUxn1eQWaxn3PR7HyFThRRmoDcmD7Wo8K11b2VJ96LhtTqMkSsVWbl/R
   8hW7OXrtBfMj1GwbPMT8CnCNH2KyiDBNxdHzmv8bakP5/49JeYSFcphKB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="15180434"
X-IronPort-AV: E=Sophos;i="6.04,246,1695711600"; 
   d="scan'208";a="15180434"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 22:32:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="914081654"
X-IronPort-AV: E=Sophos;i="6.04,246,1695711600"; 
   d="scan'208";a="914081654"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 02 Dec 2023 22:32:47 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r9g20-0006MH-3C;
        Sun, 03 Dec 2023 06:32:44 +0000
Date:   Sun, 3 Dec 2023 14:31:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Kurtz <djkurtz@chromium.org>
Subject: drivers/base/power/domain_governor.c:236: warning: cannot understand
 function prototype: 'struct dev_power_governor pm_domain_always_on_gov = '
Message-ID: <202312030241.E2FA2zJY-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   815fb87b753055df2d9e50f6cd80eb10235fe3e9
commit: c84e358718a66f76ac0de1681d15d8d0c68fcdab soc: Mediatek: Add SCPSYS power domain driver
date:   8 years ago
config: x86_64-buildonly-randconfig-006-20230906 (https://download.01.org/0day-ci/archive/20231203/202312030241.E2FA2zJY-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231203/202312030241.E2FA2zJY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312030241.E2FA2zJY-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/kobject.h:21,
                    from include/linux/device.h:17,
                    from include/linux/pm_domain.h:12,
                    from drivers/base/power/domain_governor.c:10:
   include/linux/sysfs.h: In function 'sysfs_get_dirent':
   include/linux/sysfs.h:496:44: warning: pointer targets in passing argument 2 of 'kernfs_find_and_get' differ in signedness [-Wpointer-sign]
     496 |         return kernfs_find_and_get(parent, name);
         |                                            ^~~~
         |                                            |
         |                                            const unsigned char *
   In file included from include/linux/sysfs.h:15:
   include/linux/kernfs.h:424:57: note: expected 'const char *' but argument is of type 'const unsigned char *'
     424 | kernfs_find_and_get(struct kernfs_node *kn, const char *name)
         |                                             ~~~~~~~~~~~~^~~~
>> drivers/base/power/domain_governor.c:236: warning: cannot understand function prototype: 'struct dev_power_governor pm_domain_always_on_gov = '


vim +236 drivers/base/power/domain_governor.c

e59a8db8d9b7c0 Rafael J. Wysocki 2012-01-14  232  
925b44a273aa8c Mark Brown        2011-12-08  233  /**
925b44a273aa8c Mark Brown        2011-12-08  234   * pm_genpd_gov_always_on - A governor implementing an always-on policy
925b44a273aa8c Mark Brown        2011-12-08  235   */
925b44a273aa8c Mark Brown        2011-12-08 @236  struct dev_power_governor pm_domain_always_on_gov = {

:::::: The code at line 236 was first introduced by commit
:::::: 925b44a273aa8c4c23c006c1228aacd538eead09 PM / Domains: Provide an always on power domain governor

:::::: TO: Mark Brown <broonie@opensource.wolfsonmicro.com>
:::::: CC: Rafael J. Wysocki <rjw@sisk.pl>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
