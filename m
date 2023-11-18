Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A537F02D5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 21:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjKRUIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 15:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKRUIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 15:08:45 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CFF127
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 12:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700338122; x=1731874122;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=x8pSC+uSH0dYmp8GfvebVlsZxSCObqYNZI9X2tzyhhI=;
  b=j4CDeAo8SlFjgtrFJ/+w6a6KXiPRi9qnJVX7RFKRX5wg7gxBjgGFZrJ1
   jO/W5tMpFdfgLOGeGq7Mm78UEwUD5stNo4R5O4kKbofXU0BvOof/8Znfw
   lqdXrdwpbGMuJKn8rRzWp/6pMGpACBesEwx3FthRLHEQ3g3iXB3Exml8W
   Ka293NVxWQ8/WcjdMVfImSr7MU8R2mVHeALZeNzNLa1Nb7Bwb55p3GD3G
   wony1otZpO6Vv+ik7xr/xE64hHrIH782TuKrjf96RqBSi9B4yuF0s4cYn
   kFvWVIWdUTbCUOvYhzWtkHmkZJID2CClk4szCXTO+l5icuiPnoAzDS+Nd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="13005570"
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="13005570"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2023 12:08:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="7163884"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 18 Nov 2023 12:08:40 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4RcL-0004FT-2H;
        Sat, 18 Nov 2023 20:08:37 +0000
Date:   Sun, 19 Nov 2023 04:08:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Juergen Gross <jgross@suse.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Vrabel <david.vrabel@citrix.com>,
        Paul Durrant <paul.durrant@citrix.com>
Subject: drivers/xen/manage.c:337:60: warning: '%s' directive output may be
 truncated writing up to 95 bytes into a region of size 12
Message-ID: <202311190459.zOWcFodz-lkp@intel.com>
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
head:   05aa69b096a089dc85391e36ccdce76961694e22
commit: 44b3c7af02ca2701b6b90ee30c9d1d9c3ae07653 xenbus: advertise control feature flags
date:   7 years ago
config: x86_64-randconfig-r031-20230816 (https://download.01.org/0day-ci/archive/20231119/202311190459.zOWcFodz-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231119/202311190459.zOWcFodz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311190459.zOWcFodz-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/kobject.h:21,
                    from include/linux/device.h:17,
                    from include/linux/node.h:17,
                    from include/linux/cpu.h:16,
                    from include/linux/stop_machine.h:4,
                    from drivers/xen/manage.c:12:
   include/linux/sysfs.h: In function 'sysfs_get_dirent':
   include/linux/sysfs.h:517:44: warning: pointer targets in passing argument 2 of 'kernfs_find_and_get' differ in signedness [-Wpointer-sign]
     517 |         return kernfs_find_and_get(parent, name);
         |                                            ^~~~
         |                                            |
         |                                            const unsigned char *
   In file included from include/linux/sysfs.h:15:
   include/linux/kernfs.h:440:57: note: expected 'const char *' but argument is of type 'const unsigned char *'
     440 | kernfs_find_and_get(struct kernfs_node *kn, const char *name)
         |                                             ~~~~~~~~~~~~^~~~
   drivers/xen/manage.c: In function 'shutdown_event':
>> drivers/xen/manage.c:337:60: warning: '%s' directive output may be truncated writing up to 95 bytes into a region of size 12 [-Wformat-truncation=]
     337 |                 snprintf(node, FEATURE_PATH_SIZE, "feature-%s",
         |                                                            ^~
   In function 'setup_shutdown_watcher',
       inlined from 'shutdown_event' at drivers/xen/manage.c:349:2:
   drivers/xen/manage.c:337:17: note: 'snprintf' output between 9 and 104 bytes into a destination of size 20
     337 |                 snprintf(node, FEATURE_PATH_SIZE, "feature-%s",
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     338 |                          shutdown_handlers[idx].command);
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +337 drivers/xen/manage.c

   333	
   334		for (idx = 0; idx < ARRAY_SIZE(shutdown_handlers); idx++) {
   335			if (!shutdown_handlers[idx].flag)
   336				continue;
 > 337			snprintf(node, FEATURE_PATH_SIZE, "feature-%s",
   338				 shutdown_handlers[idx].command);
   339			xenbus_printf(XBT_NIL, "control", node, "%u", 1);
   340		}
   341	
   342		return 0;
   343	}
   344	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
