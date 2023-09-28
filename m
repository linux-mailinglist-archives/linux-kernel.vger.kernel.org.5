Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF877B14F1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjI1Hdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjI1Hdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:33:31 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 28 Sep 2023 00:33:29 PDT
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C3D99
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695886410; x=1727422410;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=J3X5CMCKL1P/23rm+UPIpvvk2cR1JV83hHUHkbtZJvM=;
  b=Hq8gConN81GIRCZFkYx9X4Wt6e6se8e/rtCL+bVMqZy8s58Pg9qGXojG
   NZWYaBx9opc1XEUONLAMUB2Xz1kEMCdHiLa18tjZkfpdgkxcEjGlMAok7
   4gYCjI2UWRR6Y6MhWX7CPi1Lt8Cnuw09SgiDt0P9fD9EPKzAHYmcIJG+o
   h5dhMD/UKLRQFB/mi+B4GBFNTXNxl2aUvqW+ehYx6NmSZZ3X+tPB347+6
   fh9PhDZJ4FMLBcNvx4I6enoauJEteb0DFFuQAul2GA3A198hpry+OUuRz
   tETV+fuWzJYyAm195epelZsdivwsc5+1IiofInXlSKsEO5Iw/zkBaBOun
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="3558763"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="3558763"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 00:32:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="815150330"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="815150330"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 28 Sep 2023 00:32:25 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qllVR-0001En-03;
        Thu, 28 Sep 2023 07:32:17 +0000
Date:   Thu, 28 Sep 2023 15:31:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Avraham Stern <avraham.stern@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: drivers/net/wireless/intel/iwlwifi/pcie/drv.c:1126:5-8: Unneeded
 variable: "ret". Return "  0" on line 1154
Message-ID: <202309281538.TJc5nQNH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   633b47cb009d09dc8f4ba9cdb3a0ca138809c7c7
commit: 057381ddac0593c6e4ca8f58732830d8542b9c4e wifi: iwlwifi: pcie: avoid a warning in case prepare card failed
date:   5 weeks ago
config: x86_64-randconfig-101-20230927 (https://download.01.org/0day-ci/archive/20230928/202309281538.TJc5nQNH-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230928/202309281538.TJc5nQNH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309281538.TJc5nQNH-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/net/wireless/intel/iwlwifi/pcie/drv.c:1126:5-8: Unneeded variable: "ret". Return "  0" on line 1154

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
