Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E407E1354
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 13:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjKEMWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 07:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKEMWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 07:22:14 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCA6CF
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 04:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699186931; x=1730722931;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AWnU4vhr/KVP+OCfvhfjr1Y91JzeoC/E++lb6aeHgJc=;
  b=g+Obx0wfG5xblGl4tzIlAhSfo5qhrPzu86KvUOfuaFi7o5apBPyAK8JE
   T0/vXobUc6wpqdEdzVxhMUPepMPFc/U1TZ9CUodoYSMdmAGUiT43FP31c
   XJvvTimhn02TUb6S0eZRxx3oOYEIzZFAFIiMZjkk9yfM3iNNiyggBnFpr
   fawipgM4wmFWsMJTcCEH+cTk8pQwGeDDGLeN71lyRI6ZZCdF7wKp+oeEF
   xSuBWApKqCU2jNMT5PwbOmvZe2fKGXoZmHS6VrzKa9Xpn2/49e7yBVVeQ
   rR/cnciAeL1kjuo4e26Edpk+YU5BE9MX7yfINtB25AixmVtuJWz8wLVO8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="392009506"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="392009506"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 04:22:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="935551885"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="935551885"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 05 Nov 2023 04:22:09 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzc8l-0005Pt-0B;
        Sun, 05 Nov 2023 12:22:07 +0000
Date:   Sun, 5 Nov 2023 20:21:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Raghu Vatsavayi <rvatsavayi@caviumnetworks.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Derek Chickles <derek.chickles@caviumnetworks.com>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>
Subject: drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:1069:13:
 warning: variable 'max_possible_vfs' set but not used
Message-ID: <202311052041.0lSUJmvT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1c41041124bd14dd6610da256a3da4e5b74ce6b1
commit: d13520c7ca7761346d2787fff1b3b112f87da77a liquidio CN23XX: HW config for VF support
date:   7 years ago
config: x86_64-buildonly-randconfig-002-20231101 (https://download.01.org/0day-ci/archive/20231105/202311052041.0lSUJmvT-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231105/202311052041.0lSUJmvT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311052041.0lSUJmvT-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/kobject.h:21,
                    from include/linux/pci.h:28,
                    from drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:23:
   include/linux/sysfs.h: In function 'sysfs_get_dirent':
   include/linux/sysfs.h:517:44: warning: pointer targets in passing argument 2 of 'kernfs_find_and_get' differ in signedness [-Wpointer-sign]
     517 |         return kernfs_find_and_get(parent, name);
         |                                            ^~~~
         |                                            |
         |                                            const unsigned char *
   In file included from include/linux/sysfs.h:15:
   include/linux/kernfs.h:452:57: note: expected 'const char *' but argument is of type 'const unsigned char *'
     452 | kernfs_find_and_get(struct kernfs_node *kn, const char *name)
         |                                             ~~~~~~~~~~~~^~~~
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c: In function 'cn23xx_sriov_config':
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:1117:24: error: 'struct octeon_sriov_info' has no member named 'sriov_enabled'
    1117 |         oct->sriov_info.sriov_enabled = 0;
         |                        ^
>> drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:1069:13: warning: variable 'max_possible_vfs' set but not used [-Wunused-but-set-variable]
    1069 |         u32 max_possible_vfs;
         |             ^~~~~~~~~~~~~~~~
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c: At top level:
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:1210:6: warning: no previous declaration for 'cn23xx_dump_iq_regs' [-Wmissing-declarations]
    1210 | void cn23xx_dump_iq_regs(struct octeon_device *oct)
         |      ^~~~~~~~~~~~~~~~~~~


vim +/max_possible_vfs +1069 drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c

  1063	
  1064	static int cn23xx_sriov_config(struct octeon_device *oct)
  1065	{
  1066		struct octeon_cn23xx_pf *cn23xx = (struct octeon_cn23xx_pf *)oct->chip;
  1067		u32 max_rings, total_rings, max_vfs, rings_per_vf;
  1068		u32 pf_srn, num_pf_rings;
> 1069		u32 max_possible_vfs;
  1070	
  1071		cn23xx->conf =
  1072			(struct octeon_config *)oct_get_config_info(oct, LIO_23XX);
  1073		switch (oct->rev_id) {
  1074		case OCTEON_CN23XX_REV_1_0:
  1075			max_rings = CN23XX_MAX_RINGS_PER_PF_PASS_1_0;
  1076			max_possible_vfs = CN23XX_MAX_VFS_PER_PF_PASS_1_0;
  1077			break;
  1078		case OCTEON_CN23XX_REV_1_1:
  1079			max_rings = CN23XX_MAX_RINGS_PER_PF_PASS_1_1;
  1080			max_possible_vfs = CN23XX_MAX_VFS_PER_PF_PASS_1_1;
  1081			break;
  1082		default:
  1083			max_rings = CN23XX_MAX_RINGS_PER_PF;
  1084			max_possible_vfs = CN23XX_MAX_VFS_PER_PF;
  1085			break;
  1086		}
  1087	
  1088		if (max_rings <= num_present_cpus())
  1089			num_pf_rings = 1;
  1090		else
  1091			num_pf_rings = num_present_cpus();
  1092	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
