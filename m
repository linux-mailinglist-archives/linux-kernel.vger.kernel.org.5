Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71466808E53
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 18:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442189AbjLGQ5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 11:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjLGQ5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 11:57:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DB71704;
        Thu,  7 Dec 2023 08:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701968262; x=1733504262;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gz/YhlEPqHemYXUvHjjd7D2SyWR2QGO2GITEF/SCnbY=;
  b=MseZB7+Ky0+c1Bd6J17kAMR0tTSv6k34qNmT+T0G8jWAGWD5uJO1ABx8
   7IMobCRAUVQlM4VayuKivp+7mEktUSIWeirZIW65rQVgNV8Wnb7vQAcLt
   GJps9plRapFoN8cwmOGA2wIs1/9HZ6TsX/XkbCFHfq+F9BefUyxFn3Ut3
   F+rVXcepRx5oVsamftS+KsY7osT9Y6VXtas+g9cDvARdK7VtXnk7Y4xxu
   onJuJMza9vtTxoeRPfe7WAIUZNw7ESLUqgjC38ZcHjdOJwRQXtYgbnm8q
   iFywbgrSk5SKYcyIoSlZ41iuU6HxS37C2vM5dldHqia9V8gl03bUB553U
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="373761370"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="373761370"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 08:57:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1019018026"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="1019018026"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 07 Dec 2023 08:57:38 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rBHgu-000CYl-11;
        Thu, 07 Dec 2023 16:57:36 +0000
Date:   Fri, 8 Dec 2023 00:57:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Georgi Djakov <djakov@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Andy Gross <agross@kernel.org>,
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
Message-ID: <202312080018.m4nXAKLG-lkp@intel.com>
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
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20231208/202312080018.m4nXAKLG-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231208/202312080018.m4nXAKLG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312080018.m4nXAKLG-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/interconnect/qcom/msm8909.c:1319:12: error: incompatible function pointer types initializing 'int (*)(struct platform_device *)' with an expression of type 'void (struct platform_device *)' [-Wincompatible-function-pointer-types]
    1319 |         .remove = qnoc_remove,
         |                   ^~~~~~~~~~~
   1 error generated.


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
