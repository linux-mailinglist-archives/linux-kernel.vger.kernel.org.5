Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA26E7E1627
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 21:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjKEUBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 15:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjKEUBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 15:01:36 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4042C0
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 12:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699214494; x=1730750494;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mI5IteH+boj4bkfZ8oz/2buAKwPVJjrId7wMVB+xXTw=;
  b=icMB1U7MjgP5uBjTd1BC6nfW8Kbr/Bn9ZldCd3FYCtm3KxTgFBxEBaj4
   ElxYH6btJass8ziDkkXo0f2eJkYyiqZdeufVQRqwLXPjG1ArQQrQvwEoq
   aoqdF+Tm3H7tChb5X6a1ipod/uwS4Kc7eSoXAdNa8frsFJZ5ARfEnDtoo
   +TgBu5uoAKKzsYh1yWDPOsTht/Nx1P/3cUuTN7TVL4Jioxv+HUWsPYnwA
   TPdK/18U4S+clKGC8FNomoywYPhHmsGBx7IqNFM2MyJN+M7zA4NyXx7cE
   M2uxeaYQtLc85iD1bgxRPR3lRq1oAFxo5J0Dmi/wUNBXoJEL0sXS4OV31
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="2080476"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="2080476"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 12:01:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="738613660"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="738613660"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 05 Nov 2023 12:01:31 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzjJJ-0005ku-19;
        Sun, 05 Nov 2023 20:01:29 +0000
Date:   Mon, 6 Nov 2023 03:59:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Intiyaz Basha <intiyaz.basha@cavium.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Felix Manlunas <felix.manlunas@cavium.com>
Subject: drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:1251:13:
 warning: variable 'max_rings' set but not used
Message-ID: <202311060348.7DFUAcjC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1c41041124bd14dd6610da256a3da4e5b74ce6b1
commit: c33c997346c34ea7b89aec99524ad9632a2f1e0c liquidio: enhanced ethtool --set-channels feature
date:   6 years ago
config: x86_64-buildonly-randconfig-002-20231101 (https://download.01.org/0day-ci/archive/20231106/202311060348.7DFUAcjC-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231106/202311060348.7DFUAcjC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311060348.7DFUAcjC-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c: In function 'cn23xx_sriov_config':
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:1253:13: warning: variable 'max_possible_vfs' set but not used [-Wunused-but-set-variable]
    1253 |         u32 max_possible_vfs;
         |             ^~~~~~~~~~~~~~~~
>> drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:1251:13: warning: variable 'max_rings' set but not used [-Wunused-but-set-variable]
    1251 |         u32 max_rings, total_rings, max_vfs, rings_per_vf;
         |             ^~~~~~~~~
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c: At top level:
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:1417:6: warning: no previous prototype for 'cn23xx_dump_iq_regs' [-Wmissing-prototypes]
    1417 | void cn23xx_dump_iq_regs(struct octeon_device *oct)
         |      ^~~~~~~~~~~~~~~~~~~


vim +/max_rings +1251 drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c

72c0091293c008 Raghu Vatsavayi 2016-08-31  1247  
c33c997346c34e Intiyaz Basha   2018-04-27  1248  int cn23xx_sriov_config(struct octeon_device *oct)
72c0091293c008 Raghu Vatsavayi 2016-08-31  1249  {
72c0091293c008 Raghu Vatsavayi 2016-08-31  1250  	struct octeon_cn23xx_pf *cn23xx = (struct octeon_cn23xx_pf *)oct->chip;
d13520c7ca7761 Raghu Vatsavayi 2016-11-14 @1251  	u32 max_rings, total_rings, max_vfs, rings_per_vf;
72c0091293c008 Raghu Vatsavayi 2016-08-31  1252  	u32 pf_srn, num_pf_rings;
d13520c7ca7761 Raghu Vatsavayi 2016-11-14  1253  	u32 max_possible_vfs;
72c0091293c008 Raghu Vatsavayi 2016-08-31  1254  
72c0091293c008 Raghu Vatsavayi 2016-08-31  1255  	cn23xx->conf =
72c0091293c008 Raghu Vatsavayi 2016-08-31  1256  		(struct octeon_config *)oct_get_config_info(oct, LIO_23XX);
72c0091293c008 Raghu Vatsavayi 2016-08-31  1257  	switch (oct->rev_id) {
72c0091293c008 Raghu Vatsavayi 2016-08-31  1258  	case OCTEON_CN23XX_REV_1_0:
d13520c7ca7761 Raghu Vatsavayi 2016-11-14  1259  		max_rings = CN23XX_MAX_RINGS_PER_PF_PASS_1_0;
d13520c7ca7761 Raghu Vatsavayi 2016-11-14  1260  		max_possible_vfs = CN23XX_MAX_VFS_PER_PF_PASS_1_0;
72c0091293c008 Raghu Vatsavayi 2016-08-31  1261  		break;
72c0091293c008 Raghu Vatsavayi 2016-08-31  1262  	case OCTEON_CN23XX_REV_1_1:
d13520c7ca7761 Raghu Vatsavayi 2016-11-14  1263  		max_rings = CN23XX_MAX_RINGS_PER_PF_PASS_1_1;
d13520c7ca7761 Raghu Vatsavayi 2016-11-14  1264  		max_possible_vfs = CN23XX_MAX_VFS_PER_PF_PASS_1_1;
72c0091293c008 Raghu Vatsavayi 2016-08-31  1265  		break;
72c0091293c008 Raghu Vatsavayi 2016-08-31  1266  	default:
d13520c7ca7761 Raghu Vatsavayi 2016-11-14  1267  		max_rings = CN23XX_MAX_RINGS_PER_PF;
d13520c7ca7761 Raghu Vatsavayi 2016-11-14  1268  		max_possible_vfs = CN23XX_MAX_VFS_PER_PF;
72c0091293c008 Raghu Vatsavayi 2016-08-31  1269  		break;
72c0091293c008 Raghu Vatsavayi 2016-08-31  1270  	}
d13520c7ca7761 Raghu Vatsavayi 2016-11-14  1271  
c33c997346c34e Intiyaz Basha   2018-04-27  1272  	if (oct->sriov_info.num_pf_rings)
c33c997346c34e Intiyaz Basha   2018-04-27  1273  		num_pf_rings = oct->sriov_info.num_pf_rings;
72c0091293c008 Raghu Vatsavayi 2016-08-31  1274  	else
d13520c7ca7761 Raghu Vatsavayi 2016-11-14  1275  		num_pf_rings = num_present_cpus();
72c0091293c008 Raghu Vatsavayi 2016-08-31  1276  

:::::: The code at line 1251 was first introduced by commit
:::::: d13520c7ca7761346d2787fff1b3b112f87da77a liquidio CN23XX: HW config for VF support

:::::: TO: Raghu Vatsavayi <rvatsavayi@caviumnetworks.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
