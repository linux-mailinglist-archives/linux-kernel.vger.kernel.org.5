Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F427BC300
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 01:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbjJFXl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 19:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbjJFXly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 19:41:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9903BF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 16:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696635713; x=1728171713;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PmldO6Vue/WEGvxwtrboNcpHrlA4BpqVRmNMWAp8B18=;
  b=GL+7B+Y43Jf/focwhXt6C8mT23jg7v5cX1zaDEOXJo3ONrFlV9jXlXHq
   N1hING2gBl9dpd91V+AdB9saS/611bKVFYH96PCMpEyZgS/fdlZCVpBPl
   J3Oi7/1F7pNZ86KJBhdjOkcLslCSQHnMdAdcgfxPgYdiScj8SecAU17yv
   V/olTTz9h2jRf+GMnFL3g6OtlXHp4j5Q+PaAwXOIkTeSb6VDMoJkuftAl
   codndRMZ3m7TS6gTsk76QP46Y6Ol31PLJwVd/9gv+OhXCoyLP+gcoNrgQ
   nTbSzPsMhWImJxzmGhnP2/SXq1/fM3v/4i8bBD8rpmyZPOyApsO0xm05+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="374191550"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="374191550"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 16:41:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="818170704"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="818170704"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 06 Oct 2023 16:41:36 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qouRq-0003kF-0O;
        Fri, 06 Oct 2023 23:41:34 +0000
Date:   Sat, 7 Oct 2023 07:40:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: drivers/thermal/qcom/tsens-v0_1.c:296:31: warning: 'ops_v0_1'
 defined but not used
Message-ID: <202310070757.7yMq1PFA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephan,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   af95dc6fdc25e616051d0234aad638e15c02ec8f
commit: 6812d1dfbca99cd5032683354bf50e0002b2aa02 thermal/drivers/qcom/tsens-v0_1: Fix mdm9607 slope values
date:   3 months ago
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231007/202310070757.7yMq1PFA-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231007/202310070757.7yMq1PFA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310070757.7yMq1PFA-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/thermal/qcom/tsens-v0_1.c:296:31: warning: 'ops_v0_1' defined but not used [-Wunused-const-variable=]
     296 | static const struct tsens_ops ops_v0_1 = {
         |                               ^~~~~~~~


vim +/ops_v0_1 +296 drivers/thermal/qcom/tsens-v0_1.c

c19970548edc35 Amit Kucheria    2019-03-20  295  
51d78b8b1beba2 Dmitry Baryshkov 2023-01-01 @296  static const struct tsens_ops ops_v0_1 = {
51d78b8b1beba2 Dmitry Baryshkov 2023-01-01  297  	.init		= init_common,
51d78b8b1beba2 Dmitry Baryshkov 2023-01-01  298  	.calibrate	= tsens_calibrate_common,
51d78b8b1beba2 Dmitry Baryshkov 2023-01-01  299  	.get_temp	= get_temp_common,
51d78b8b1beba2 Dmitry Baryshkov 2023-01-01  300  };
51d78b8b1beba2 Dmitry Baryshkov 2023-01-01  301  

:::::: The code at line 296 was first introduced by commit
:::::: 51d78b8b1beba247e1e4314420d98acb0732c4b7 thermal/drivers/tsens: Drop single-cell code for mdm9607

:::::: TO: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
:::::: CC: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
