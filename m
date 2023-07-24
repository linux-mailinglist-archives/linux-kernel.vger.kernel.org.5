Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFEF75FAAA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 17:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjGXPWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 11:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjGXPWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 11:22:03 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F2A1B3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 08:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690212114; x=1721748114;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HyCcFKDOaGEp+RHeQHDa0hvD6I2xyirhVE8nbOeL3BM=;
  b=OStsJV9JmFlkyZgglG2ssM5cKhlxfHX92SLHABp/SOV01NWY2aXMKIbh
   64GrgJ9aoHrAUCt6y3KFUP8OKjKanjCCvgRea1SjPT1QgNZ8E1VDSaL9S
   Jhd6grSbui/BwWC/to1syWN6q/V8u1hpQapbusExBkBRZ6RVi+1dJ5RiS
   h4VCJ2fO6uofiYKHa2kxg5nflxOaj/ejhwBkK6825e/V5U7/mvI9fsgtd
   xhj6fuaeh5R0H/qlfN6GqXZ8++GdqE96ZI06J4+X8+aMBK/gt/JzPnFTg
   gT6YREdwsnaBV0KIHb+shyoZKCSFWJGaLFRn6N5m8HouunZ+3ITIakZ4L
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="366362200"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="366362200"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 08:21:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="795816473"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="795816473"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 24 Jul 2023 08:21:52 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qNxNb-0009oG-0L;
        Mon, 24 Jul 2023 15:21:48 +0000
Date:   Mon, 24 Jul 2023 23:20:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: drivers/clk/ralink/clk-mtmips.c:821:34: warning: unused variable
 'mtmips_of_match'
Message-ID: <202307242310.CdOnd2py-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6eaae198076080886b9e7d57f4ae06fa782f90ef
commit: 6f3b15586eef736831abe6a14f2a6906bc0dc074 clk: ralink: add clock and reset driver for MTMIPS SoCs
date:   5 weeks ago
config: x86_64-buildonly-randconfig-r003-20230723 (https://download.01.org/0day-ci/archive/20230724/202307242310.CdOnd2py-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230724/202307242310.CdOnd2py-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307242310.CdOnd2py-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/clk/ralink/clk-mtmips.c:309:9: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
           return ret;
                  ^~~
   drivers/clk/ralink/clk-mtmips.c:285:9: note: initialize the variable 'ret' to silence this warning
           int ret, i;
                  ^
                   = 0
   drivers/clk/ralink/clk-mtmips.c:359:9: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
           return ret;
                  ^~~
   drivers/clk/ralink/clk-mtmips.c:335:9: note: initialize the variable 'ret' to silence this warning
           int ret, i;
                  ^
                   = 0
>> drivers/clk/ralink/clk-mtmips.c:821:34: warning: unused variable 'mtmips_of_match' [-Wunused-const-variable]
   static const struct of_device_id mtmips_of_match[] = {
                                    ^
   3 warnings generated.


vim +/mtmips_of_match +821 drivers/clk/ralink/clk-mtmips.c

   820	
 > 821	static const struct of_device_id mtmips_of_match[] = {
   822		{
   823			.compatible = "ralink,rt2880-sysc",
   824			.data = &rt2880_clk_data,
   825		},
   826		{
   827			.compatible = "ralink,rt3050-sysc",
   828			.data = &rt305x_clk_data,
   829		},
   830		{
   831			.compatible = "ralink,rt3052-sysc",
   832			.data = &rt305x_clk_data,
   833		},
   834		{
   835			.compatible = "ralink,rt3352-sysc",
   836			.data = &rt3352_clk_data,
   837		},
   838		{
   839			.compatible = "ralink,rt3883-sysc",
   840			.data = &rt3883_clk_data,
   841		},
   842		{
   843			.compatible = "ralink,rt5350-sysc",
   844			.data = &rt5350_clk_data,
   845		},
   846		{
   847			.compatible = "ralink,mt7620-sysc",
   848			.data = &mt7620_clk_data,
   849		},
   850		{
   851			.compatible = "ralink,mt7628-sysc",
   852			.data = &mt76x8_clk_data,
   853		},
   854		{
   855			.compatible = "ralink,mt7688-sysc",
   856			.data = &mt76x8_clk_data,
   857		},
   858		{}
   859	};
   860	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
