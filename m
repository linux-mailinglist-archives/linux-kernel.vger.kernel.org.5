Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD461808085
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 07:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377395AbjLGGID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 01:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjLGGIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 01:08:02 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490FC1AD;
        Wed,  6 Dec 2023 22:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701929288; x=1733465288;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=afuMH9RHeuu1Nlem0Rpl8i/1WPnpTa8StZWPZfDNT08=;
  b=JCqJxrpy94ONnNDR52Etjfj3OEiyZD92fIXjq2F2BPFS/UCJSVvQg+Jx
   hM81E7TY4h7yv6Is6YK3PRgoHu7PIEFYQfK9ffewt3qTNIw7lWPrkdjub
   m1NOVXaYfO6qEJx6416YCBiviHI5op+dy++Z7r/h+WD91sWUMELUQwyyH
   tlfZ925HQRc/3cGoOt2KLE0kFL7WI8w3XG2jKXkqGWk5mePY0RSGSEq1k
   RVivsObPe2m+obw+FEFnVn9xmOzCecFmr3nLn0E50NBpAzHIcg6WmUO8I
   FwR2djzqamKEmfkcqji7VDjQQVHjOTQahJbZrGzUiKG3HPbuoRqtDoxVi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="391352921"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="391352921"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 22:08:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="944915314"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="944915314"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 06 Dec 2023 22:07:56 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rB7Y9-000Btm-2b;
        Thu, 07 Dec 2023 06:07:53 +0000
Date:   Thu, 7 Dec 2023 14:06:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Georgi Djakov <djakov@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adam Skladowski <a39.skl@gmail.com>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Subject: Re: [PATCH 2/2] interconnect: qcom: Add MSM8909 interconnect
 provider driver
Message-ID: <202312071325.M9cg1wry-lkp@intel.com>
References: <20231206-icc-msm8909-v1-2-fe0dd632beff@kernkonzept.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206-icc-msm8909-v1-2-fe0dd632beff@kernkonzept.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephan,

kernel test robot noticed the following build errors:

[auto build test ERROR on feaf241ae2da2a73cb421473f52a4732128a996f]

url:    https://github.com/intel-lab-lkp/linux/commits/Stephan-Gerhold/dt-bindings-interconnect-Add-Qualcomm-MSM8909-DT-bindings/20231206-223626
base:   feaf241ae2da2a73cb421473f52a4732128a996f
patch link:    https://lore.kernel.org/r/20231206-icc-msm8909-v1-2-fe0dd632beff%40kernkonzept.com
patch subject: [PATCH 2/2] interconnect: qcom: Add MSM8909 interconnect provider driver
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20231207/202312071325.M9cg1wry-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231207/202312071325.M9cg1wry-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312071325.M9cg1wry-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/interconnect/qcom/msm8909.c:1319:19: error: initialization of 'int (*)(struct platform_device *)' from incompatible pointer type 'void (*)(struct platform_device *)' [-Werror=incompatible-pointer-types]
    1319 |         .remove = qnoc_remove,
         |                   ^~~~~~~~~~~
   drivers/interconnect/qcom/msm8909.c:1319:19: note: (near initialization for 'msm8909_noc_driver.remove')
   cc1: some warnings being treated as errors


vim +1319 drivers/interconnect/qcom/msm8909.c

  1316	
  1317	static struct platform_driver msm8909_noc_driver = {
  1318		.probe = qnoc_probe,
> 1319		.remove = qnoc_remove,
  1320		.driver = {
  1321			.name = "qnoc-msm8909",
  1322			.of_match_table = msm8909_noc_of_match,
  1323			.sync_state = icc_sync_state,
  1324		},
  1325	};
  1326	module_platform_driver(msm8909_noc_driver);
  1327	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
