Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90E3791740
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 14:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343785AbjIDMf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 08:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjIDMf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 08:35:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86055EC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 05:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693830953; x=1725366953;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KHo2uXBPUoUZkLcloIlDvQry2MWmGHn4YHZjhc47z/8=;
  b=J87VNiHEaJ9G20cQsU57Rr92HTiiMy3dyJ0Rr6+2PpZ/zaZdn1JAn2q1
   1doRPKtKGr9oDsxLMwdMGZs2Nw/ZhSJmcztcSAj7ITcaLlV0FQCaHfmAW
   /dcOfm+QiIqVbLBv0nymr6/YgAalgZ620Rk3lEyQYcKqT+XTL8gNuL/rZ
   sNKlKlnwDvnFatIbymxz6Pn4ZgKU70Qgc2cu3MU2Xu0A7Va3fhFTuxtD+
   egIEAVlT2AVHNlq3OJF+TWAwuDVyYu1Fn/uiWPv1zR/kTubSXOE7/mSiq
   irank2o87QJQVVIh2o2H+cA+ULfxnFS8jI45UDL/HrkYI+AhDLdvwP46j
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="376525499"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="376525499"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 05:35:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="830897034"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="830897034"
Received: from lkp-server02.sh.intel.com (HELO e0b2ea88afd5) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Sep 2023 05:35:51 -0700
Received: from kbuild by e0b2ea88afd5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qd8o1-0000Tv-1p;
        Mon, 04 Sep 2023 12:35:49 +0000
Date:   Mon, 4 Sep 2023 20:35:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: drivers/clk/clk-asm9260.c:258:17: warning: variable 'hw' set but not
 used
Message-ID: <202309042014.IWERPl09-lkp@intel.com>
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

Hi Dmitry,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   708283abf896dd4853e673cc8cba70acaf9bf4ea
commit: f5290d8e4f0caa81a491448a27dd70e726095d07 clk: asm9260: use parent index to link the reference clock
date:   11 months ago
config: arm-randconfig-r001-20230904 (https://download.01.org/0day-ci/archive/20230904/202309042014.IWERPl09-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230904/202309042014.IWERPl09-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309042014.IWERPl09-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/clk/clk-asm9260.c:258:17: warning: variable 'hw' set but not used [-Wunused-but-set-variable]
           struct clk_hw *hw, *pll_hw;
                          ^
   1 warning generated.


vim +/hw +258 drivers/clk/clk-asm9260.c

   255	
   256	static void __init asm9260_acc_init(struct device_node *np)
   257	{
 > 258		struct clk_hw *hw, *pll_hw;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
