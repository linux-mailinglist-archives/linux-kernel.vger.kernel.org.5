Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB827BCA74
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 01:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344240AbjJGXVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 19:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344151AbjJGXVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 19:21:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4BDB9
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 16:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696720904; x=1728256904;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yGkg57+9OSRQbVDylYzXeI84jQ+j0uTOCH3Vpr4F7bk=;
  b=WkH2USJiILpRO73FzpSar2OZkk374Txli/GUxPs9mRN4LSENqljg+hf0
   MPw3Kxr9PFiqZqwr8A3jSHK8erRDERUgJ2mnS5LhUZuUSQKEDIeF4bDW3
   URrsYxDZeYvMoqdCRz+/GWguZiAGIVKsqux/UPOyVeAvOWK2jVE7kAaLU
   mQ9QcOcPVbwAui7xZAUKlqBYPzmEKOgU8y5RFvfig8Qk7u6AlKbjvkgAu
   wQQFFNngWHTAK4bWKaf4cW6vBEtLHxQv4e4iWzuXSwAgPghxZnT4qC+bl
   Q7Ni8zTq+rGNDVA1LCEUQdQ+bVkg0bz6doFfl4N/nO9JTERX0XOBmVY/V
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10856"; a="364253213"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; 
   d="scan'208";a="364253213"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2023 16:21:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10856"; a="818435441"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; 
   d="scan'208";a="818435441"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 07 Oct 2023 16:21:42 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qpGc2-0004uW-2F;
        Sat, 07 Oct 2023 23:21:34 +0000
Date:   Sun, 8 Oct 2023 07:21:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Avraham Stern <avraham.stern@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: drivers/net/wireless/intel/iwlwifi/pcie/drv.c:1126:5-8: Unneeded
 variable: "ret". Return "  0" on line 1154
Message-ID: <202310080743.rx2s9fDg-lkp@intel.com>
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
head:   b9ddbb0cde2adcedda26045cc58f31316a492215
commit: 057381ddac0593c6e4ca8f58732830d8542b9c4e wifi: iwlwifi: pcie: avoid a warning in case prepare card failed
date:   7 weeks ago
config: x86_64-randconfig-101-20230927 (https://download.01.org/0day-ci/archive/20231008/202310080743.rx2s9fDg-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231008/202310080743.rx2s9fDg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310080743.rx2s9fDg-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/net/wireless/intel/iwlwifi/pcie/drv.c:1126:5-8: Unneeded variable: "ret". Return "  0" on line 1154

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
