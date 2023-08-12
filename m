Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67188779D7B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 08:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbjHLGGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 02:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjHLGGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 02:06:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D87130DC
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 23:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691820365; x=1723356365;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2c+Dvs7L02fAugdjqKNUzz6vs5QPKsDtwNuRLaivTm0=;
  b=aL1T7mUF4d/s3uG1Lr9GUbhbsJ7GF/Ec33mEkN/SaBSLr9KBuSzPTpxJ
   sH9fTSGD7RxotHkUOqPfEPtrpknao6gnv32OPD60f4agnG76ooM6EHLCS
   1wOYXT09RQZNgxaLslvqesCyQ6lnngARSEDyjGVvn/BDIyEYrc/i/17n4
   rXLUDNFgWVFvjk70BqHvNO/gwoR2tkzTKvzCILnro4WZGvoUy8PKuJwE3
   dNcgvAIi7Ep4Zfy0EtGEyOxV8Gd83h83ch55JRpiPnu9vt6uyzlBfnAKZ
   2TvHX6unmUjeCzDZL6pFyYrqqCjaLRS/YJmd6SNYP2Ybfj22iKb63XCkN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="402787721"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="402787721"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 23:06:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="906650448"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="906650448"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 11 Aug 2023 23:06:04 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qUhlD-0008Jk-2J;
        Sat, 12 Aug 2023 06:06:03 +0000
Date:   Sat, 12 Aug 2023 14:05:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Steen Hegelund <steen.hegelund@microchip.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c:1435:5-8:
 Unneeded variable: "err". Return "  - ENOENT" on line 1450
Message-ID: <202308121355.3dcD5fvI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f8de32cc060ba3f63171aaa0e8764d22d8c37978
commit: e1d597ecbe5c5d7128630d4c9ec27c42018613ed net: microchip: sparx5: Add TC template support
date:   5 months ago
config: csky-randconfig-r051-20230812 (https://download.01.org/0day-ci/archive/20230812/202308121355.3dcD5fvI-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230812/202308121355.3dcD5fvI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308121355.3dcD5fvI-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c:1435:5-8: Unneeded variable: "err". Return "  - ENOENT" on line 1450

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
