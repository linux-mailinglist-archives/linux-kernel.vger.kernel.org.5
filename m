Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031357E125B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 07:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjKEGEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 01:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjKEGD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 01:03:58 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B9ED9
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 23:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699164235; x=1730700235;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Eahp2kbubkQuAzMafx2n44T6htvDW7oZRxOkgo7uesk=;
  b=MOthCGBTLR+MRv6WLARfB3i1fTNagIegy/Yb4OqZQyraIdSZXhVNQGCU
   PB1pi4AFoZRRYg3m+okfPAWVw2kjEAo/KS10tU3kewXfE3mKZ80pR3Klf
   1wspM0UxX7bslLNLWgwQbGHjHGNiBrcKj88iWn05xijj87at7MibzPOuc
   ZvvQk/ZoecxLwL/qDjuiHJ3lzqs+ZYopefVaWupaRDhZaXcerN8PB/p5q
   krygFBEbyGvjwo7J7ybdJAGvNKm9bCZhv3DeF4jdP6vGgouwDmrLM9G8G
   n0o1EA5Uumr+iU1/142VQUzOhmqNMNmxO3Q0hGPiY/DXoakY0PILieAp7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="455615636"
X-IronPort-AV: E=Sophos;i="6.03,278,1694761200"; 
   d="scan'208";a="455615636"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2023 23:03:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="765654929"
X-IronPort-AV: E=Sophos;i="6.03,278,1694761200"; 
   d="scan'208";a="765654929"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 04 Nov 2023 23:03:53 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzWEh-00056G-1w;
        Sun, 05 Nov 2023 06:03:51 +0000
Date:   Sun, 5 Nov 2023 14:02:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: drivers/spi/spi-rockchip.c:891:34: warning: 'rockchip_spi_dt_match'
 defined but not used
Message-ID: <202311051312.XPufwrD5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Axel,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   aea6bf908d730b01bd264a8821159db9463c111c
commit: 46cb41534a1a1d1f75aae5eab0dd8c06a9461e6b spi: Drop unnecessary dependencies on relaxed I/O accessors
date:   8 years ago
config: i386-buildonly-randconfig-005-20231101 (https://download.01.org/0day-ci/archive/20231105/202311051312.XPufwrD5-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231105/202311051312.XPufwrD5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311051312.XPufwrD5-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/spi/spi-rockchip.c:891:34: warning: 'rockchip_spi_dt_match' defined but not used [-Wunused-const-variable=]
     891 | static const struct of_device_id rockchip_spi_dt_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~~~


vim +/rockchip_spi_dt_match +891 drivers/spi/spi-rockchip.c

64e36824b32b06 addy ke    2014-07-01  890  
64e36824b32b06 addy ke    2014-07-01 @891  static const struct of_device_id rockchip_spi_dt_match[] = {
64e36824b32b06 addy ke    2014-07-01  892  	{ .compatible = "rockchip,rk3066-spi", },
b839b785182497 Addy Ke    2014-07-11  893  	{ .compatible = "rockchip,rk3188-spi", },
b839b785182497 Addy Ke    2014-07-11  894  	{ .compatible = "rockchip,rk3288-spi", },
9b7a56221590ca Xu Jianqun 2016-02-18  895  	{ .compatible = "rockchip,rk3399-spi", },
64e36824b32b06 addy ke    2014-07-01  896  	{ },
64e36824b32b06 addy ke    2014-07-01  897  };
64e36824b32b06 addy ke    2014-07-01  898  MODULE_DEVICE_TABLE(of, rockchip_spi_dt_match);
64e36824b32b06 addy ke    2014-07-01  899  

:::::: The code at line 891 was first introduced by commit
:::::: 64e36824b32b061a9537dc2e026977806f75846f spi/rockchip: add driver for Rockchip RK3xxx SoCs integrated SPI

:::::: TO: addy ke <addy.ke@rock-chips.com>
:::::: CC: Mark Brown <broonie@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
