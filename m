Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3880A7A30A7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 15:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239369AbjIPNRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 09:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239257AbjIPNQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 09:16:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747A5139
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 06:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694870200; x=1726406200;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JxbzpYVN521YHhqcI4SHspUSz+oF7VEr3ENcG2aE+Dc=;
  b=QPUX/WiFekRMYqqadMtoHy/NgjuaABfna2bZkhCpiVVmq/bp6JFwBrOx
   Kfy7Wun83VG6adRvDeqa2sGehYvlcFkgZO6Uzfv49cBa+XqJXvn9mNR1X
   VSIKdXjQAWsVDhF+zlCaF3sC7F1fn0plaLP5FRKMrggTWHFQNPNbJZu2M
   GpTxxZT0ngqZqIRMlIaTOmuGDnEwdAy7FPNjUEdjqybRi9MEKFoDhe8G1
   JCD2Wdw2BJSk8imU2oMCNa5kL3+N1C5AdQsEIWgDFmmVK50lkCma2K4c9
   7Qub4ac3WRMD6xeHOAASVzd+gBjYIbSQwvUP4xKiahDW09fkQdC34v3+l
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10835"; a="359662004"
X-IronPort-AV: E=Sophos;i="6.02,152,1688454000"; 
   d="scan'208";a="359662004"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2023 06:16:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10835"; a="780421605"
X-IronPort-AV: E=Sophos;i="6.02,152,1688454000"; 
   d="scan'208";a="780421605"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 16 Sep 2023 06:16:38 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qhVA4-0004JK-1B;
        Sat, 16 Sep 2023 13:16:36 +0000
Date:   Sat, 16 Sep 2023 21:15:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: drivers/power/supply/qcom_battmgr.c:357:31: sparse: sparse:
 incorrect type in initializer (different base types)
Message-ID: <202309162149.4owm9iXc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   57d88e8a5974644039fbc47806bac7bb12025636
commit: 29e8142b5623b5949587bcc4f591c4e6595c4aca power: supply: Introduce Qualcomm PMIC GLINK power supply
date:   7 months ago
config: i386-randconfig-062-20230916 (https://download.01.org/0day-ci/archive/20230916/202309162149.4owm9iXc-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230916/202309162149.4owm9iXc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309162149.4owm9iXc-lkp@intel.com/

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
