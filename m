Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B9278A29B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 00:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjH0WUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 18:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjH0WTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 18:19:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD67F1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 15:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693174783; x=1724710783;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GXXwQfH5hTfMOdT+ZegeHa3Tze6UVgumD5yL+/ijcU4=;
  b=deM1L2CUvIRpM2oChb8NhmzQdcdM/VkKZdk4z45Sz/EJ+okC02uhODfG
   vX7ZI1O2/TVySJ1igJbQnABNtWQNfjPzT/DrPOVsMYNEEgz+hGCRVKi6p
   mOuFPlvgdC30y22CCH8qdmYUQCN4sSjM2sKkdelFTO9FLCM8E//3lXYpi
   Rl8ujXSfz3zD87SmCwBhQZX6Vr4IOaYXNuO61s9Gko8HDg/pHJayeBCUU
   UtYhce4Uz0qUAOPmcDHaWGFPVE2gjH5zEW+Mkgal6E+vxH65hg3kdnVnT
   RioK71Rx7yDZxzzAK01/F5TzPXSq8IGeCVzeNtBp1WxiCcCyTBg2ATKqz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="438926885"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="438926885"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 15:19:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="731629826"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="731629826"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 27 Aug 2023 15:19:42 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qaO6f-0006Ej-0F;
        Sun, 27 Aug 2023 22:19:41 +0000
Date:   Mon, 28 Aug 2023 06:19:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: drivers/power/supply/qcom_battmgr.c:357:31: sparse: sparse:
 incorrect type in initializer (different base types)
Message-ID: <202308280602.nE6xa80J-lkp@intel.com>
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
head:   85eb043618bb17124050197d71c453d4a1f556e5
commit: 29e8142b5623b5949587bcc4f591c4e6595c4aca power: supply: Introduce Qualcomm PMIC GLINK power supply
date:   7 months ago
config: i386-randconfig-061-20230828 (https://download.01.org/0day-ci/archive/20230828/202308280602.nE6xa80J-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230828/202308280602.nE6xa80J-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308280602.nE6xa80J-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/power/supply/qcom_battmgr.c:357:31: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] battery_id @@     got restricted __le32 [usertype] @@
   drivers/power/supply/qcom_battmgr.c:357:31: sparse:     expected unsigned int [usertype] battery_id
   drivers/power/supply/qcom_battmgr.c:357:31: sparse:     got restricted __le32 [usertype]
   drivers/power/supply/qcom_battmgr.c:369:31: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] battery_id @@     got restricted __le32 [usertype] @@
   drivers/power/supply/qcom_battmgr.c:369:31: sparse:     expected unsigned int [usertype] battery_id
   drivers/power/supply/qcom_battmgr.c:369:31: sparse:     got restricted __le32 [usertype]
>> drivers/power/supply/qcom_battmgr.c:1286:30: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le32 [usertype] owner @@     got int @@
   drivers/power/supply/qcom_battmgr.c:1286:30: sparse:     expected restricted __le32 [usertype] owner
   drivers/power/supply/qcom_battmgr.c:1286:30: sparse:     got int
>> drivers/power/supply/qcom_battmgr.c:1287:29: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le32 [usertype] type @@     got int @@
   drivers/power/supply/qcom_battmgr.c:1287:29: sparse:     expected restricted __le32 [usertype] type
   drivers/power/supply/qcom_battmgr.c:1287:29: sparse:     got int
>> drivers/power/supply/qcom_battmgr.c:1288:31: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le32 [usertype] opcode @@     got int @@
   drivers/power/supply/qcom_battmgr.c:1288:31: sparse:     expected restricted __le32 [usertype] opcode
   drivers/power/supply/qcom_battmgr.c:1288:31: sparse:     got int

vim +357 drivers/power/supply/qcom_battmgr.c

   350	
   351	static int qcom_battmgr_update_status(struct qcom_battmgr *battmgr)
   352	{
   353		struct qcom_battmgr_update_request request = {
   354			.hdr.owner = cpu_to_le32(PMIC_GLINK_OWNER_BATTMGR),
   355			.hdr.type = cpu_to_le32(PMIC_GLINK_REQ_RESP),
   356			.hdr.opcode = cpu_to_le32(BATTMGR_BAT_STATUS),
 > 357			.battery_id = cpu_to_le32(0),
   358		};
   359	
   360		return qcom_battmgr_request(battmgr, &request, sizeof(request));
   361	}
   362	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
