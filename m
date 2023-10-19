Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9947CF8F3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345576AbjJSMbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345681AbjJSMbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:31:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5DBD5B
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697718642; x=1729254642;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ysn72zKm2ezAHbajP0v8uJnorqnslZz4UU5r/q9XCA8=;
  b=dbBezESn+FelmXSfpRzJlo/ZMtrYIX45Zqv43wKmd/dKYYlIuLp76ock
   HXTHorZIvAFsQcZqN3ehYxxW5A64U8yQ8n9R27rLnenoHZd9PVj7LV/cQ
   fSnwIu9VPkUDR837iVEBLZQm6MwiPHJyYapOLRy8+2dkRNH6fgpHdEZ00
   k5EmYz1DMU6iiWkzDIrss/u653pVH2kAVHeRA2Q6U63OT8lJvubhQsa2S
   laTBz4uQ+mFIEqfxlJUOFi1zia8IYvlsZ4UK4oG/6knyLAXGdmPrp60wu
   sfTWWJZ6fhgXupEQrjZWUJEBHnwsAs23uvRKr73G4Y28N2SI2WuB3nlWY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="472468897"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="472468897"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 05:30:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="760625283"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="760625283"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 19 Oct 2023 05:30:09 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qtSAB-00026E-2A;
        Thu, 19 Oct 2023 12:30:07 +0000
Date:   Thu, 19 Oct 2023 20:29:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: drivers/thermal/qcom/tsens-v0_1.c:296:31: warning: 'ops_v0_1'
 defined but not used
Message-ID: <202310192004.IHu0auyN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephan,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dd72f9c7e512da377074d47d990564959b772643
commit: 6812d1dfbca99cd5032683354bf50e0002b2aa02 thermal/drivers/qcom/tsens-v0_1: Fix mdm9607 slope values
date:   4 months ago
config: x86_64-buildonly-randconfig-006-20230906 (https://download.01.org/0day-ci/archive/20231019/202310192004.IHu0auyN-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231019/202310192004.IHu0auyN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310192004.IHu0auyN-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/thermal/qcom/tsens-v0_1.c:296:31: warning: 'ops_v0_1' defined but not used [-Wunused-const-variable=]
     296 | static const struct tsens_ops ops_v0_1 = {
         |                               ^~~~~~~~


vim +/ops_v0_1 +296 drivers/thermal/qcom/tsens-v0_1.c

c19970548edc359 Amit Kucheria    2019-03-20  295  
51d78b8b1beba24 Dmitry Baryshkov 2023-01-01 @296  static const struct tsens_ops ops_v0_1 = {
51d78b8b1beba24 Dmitry Baryshkov 2023-01-01  297  	.init		= init_common,
51d78b8b1beba24 Dmitry Baryshkov 2023-01-01  298  	.calibrate	= tsens_calibrate_common,
51d78b8b1beba24 Dmitry Baryshkov 2023-01-01  299  	.get_temp	= get_temp_common,
51d78b8b1beba24 Dmitry Baryshkov 2023-01-01  300  };
51d78b8b1beba24 Dmitry Baryshkov 2023-01-01  301  

:::::: The code at line 296 was first introduced by commit
:::::: 51d78b8b1beba247e1e4314420d98acb0732c4b7 thermal/drivers/tsens: Drop single-cell code for mdm9607

:::::: TO: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
:::::: CC: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
