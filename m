Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2DA80B9B4
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 08:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjLJHlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 02:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjLJHla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 02:41:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06EF10B
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 23:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702194096; x=1733730096;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9tcIt+TB5P1DJyu9h2pcP51XH7QhxQ2mvayCg02Fvhw=;
  b=h1znD7o6FglEkY9GaT1K+33B/h/s2M+T/zUl7Ui5/xgJeuE0/wJQwI68
   3+xEKtY/ESq0o35Wkys3a3BS1vjKu3cyPEf5X4OVbq/4O1eT/Inr7Q2Kw
   hJbj3RXRa1mRwNmnR6zWk++7wfY5VsXUECvLOw0LhbwL8EW3deSJ/eLp1
   QiMpUhIQKOwkjSM27Bm3Bw2u5q6BU5nbHseb4eL0Fh6yjSzO+9oyEmobG
   a1xPG6RtruG9vCWrA4tJPxtuDg2+bEFtnvzcM8kcky1mSJZyBq275kTlt
   hTCKAl7MW/oHuHq0pDHYVpqou1EB8OcnIPt9Z/9dYtask8BMdGwLb62dO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="461013905"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="461013905"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 23:41:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="776271036"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="776271036"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 09 Dec 2023 23:41:34 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rCERQ-000GYR-1n;
        Sun, 10 Dec 2023 07:41:32 +0000
Date:   Sun, 10 Dec 2023 15:40:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: drivers/mtd/nand/raw/rockchip-nand-controller.c:109: warning:
 expecting prototype for struct rk_ecc_cnt_status. Prototype was for struct
 ecc_cnt_status instead
Message-ID: <202312101522.stseR1ez-lkp@intel.com>
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
head:   c527f5606aa545233a4d2c6d5c636ed82b8633ef
commit: 058e0e847d54944c5dc9ec6d29727e1449feb131 mtd: rawnand: rockchip: NFC driver for RK3308, RK2928 and others
date:   3 years ago
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20231210/202312101522.stseR1ez-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231210/202312101522.stseR1ez-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312101522.stseR1ez-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mtd/nand/raw/rockchip-nand-controller.c:109: warning: expecting prototype for struct rk_ecc_cnt_status. Prototype was for struct ecc_cnt_status instead
   drivers/mtd/nand/raw/rockchip-nand-controller.c:112: warning: Cannot understand  * @type: NFC version
    on line 112 - I thought it was a doc line


vim +109 drivers/mtd/nand/raw/rockchip-nand-controller.c

    92	
    93	/**
    94	 * struct rk_ecc_cnt_status: represent a ecc status data.
    95	 * @err_flag_bit: error flag bit index at register.
    96	 * @low: ECC count low bit index at register.
    97	 * @low_mask: mask bit.
    98	 * @low_bn: ECC count low bit number.
    99	 * @high: ECC count high bit index at register.
   100	 * @high_mask: mask bit
   101	 */
   102	struct ecc_cnt_status {
   103		u8 err_flag_bit;
   104		u8 low;
   105		u8 low_mask;
   106		u8 low_bn;
   107		u8 high;
   108		u8 high_mask;
 > 109	};
   110	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
