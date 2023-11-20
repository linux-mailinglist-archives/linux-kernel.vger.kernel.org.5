Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E344C7F0B02
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 04:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjKTDaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 22:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjKTDaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 22:30:04 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E95D50;
        Sun, 19 Nov 2023 19:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700450998; x=1731986998;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=09C+JX3EQpOVjp6ooinVdw2ACy+xGuGZ0pAKM2YA3j0=;
  b=lZPl1trHmEvNeqjAX7wGG7erTxukPH1LWf1QNb+czaXb1+aNjq8qkjSZ
   cFx9hTOIakCtN01noRxkI3XxDVF7ccBo306sazkKgY9NF+rQ3jL0O0Hdl
   jmk4fgvF89dxAhQJCoSurgvSzZA/CcUHRuD9rDb6tMPBsyFfPg9Fp3XFS
   2bhXVXW1prXWgGjJ1MLa2OLulnZ9V9kTsokC17nyJ8Sf+Q7wTDV883hzN
   o4pgke8qXzdhCgsMyFy0jPHcOC0v6Z/Ex65jHPP1wwXC/v6lNrpfVvdbC
   ZRYQcXsaQqzgoNMIeLxPNORPGJbAgF+W00WGcV0bUG7Lj8jtE84Ofry1W
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="455865175"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="455865175"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 19:29:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="1097630069"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="1097630069"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 19 Nov 2023 19:29:21 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4uyM-0005tX-2L;
        Mon, 20 Nov 2023 03:29:18 +0000
Date:   Mon, 20 Nov 2023 11:28:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 4/8] arm64: dts: qcom: sm8650: add initial SM8650 MTP
 dts
Message-ID: <202311201131.R9DpSKl2-lkp@intel.com>
References: <20231106-topic-sm8650-upstream-dt-v2-4-44d6f9710fa7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106-topic-sm8650-upstream-dt-v2-4-44d6f9710fa7@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

kernel test robot noticed the following build errors:

[auto build test ERROR on fe1998aa935b44ef873193c0772c43bce74f17dc]

url:    https://github.com/intel-lab-lkp/linux/commits/Neil-Armstrong/dt-bindings-arm-qcom-document-SM8650-and-the-reference-boards/20231106-170959
base:   fe1998aa935b44ef873193c0772c43bce74f17dc
patch link:    https://lore.kernel.org/r/20231106-topic-sm8650-upstream-dt-v2-4-44d6f9710fa7%40linaro.org
patch subject: [PATCH v2 4/8] arm64: dts: qcom: sm8650: add initial SM8650 MTP dts
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20231120/202311201131.R9DpSKl2-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231120/202311201131.R9DpSKl2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311201131.R9DpSKl2-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/arm64/boot/dts/qcom/sm8650-mtp.dts:9:
>> arch/arm64/boot/dts/qcom/sm8650.dtsi:7:10: fatal error: 'dt-bindings/clock/qcom,sm8650-dispcc.h' file not found
       7 | #include <dt-bindings/clock/qcom,sm8650-dispcc.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +7 arch/arm64/boot/dts/qcom/sm8650.dtsi

e7ea17c3abdf54 Neil Armstrong 2023-11-06  @7  #include <dt-bindings/clock/qcom,sm8650-dispcc.h>
e7ea17c3abdf54 Neil Armstrong 2023-11-06   8  #include <dt-bindings/clock/qcom,sm8650-gcc.h>
e7ea17c3abdf54 Neil Armstrong 2023-11-06   9  #include <dt-bindings/clock/qcom,sm8650-gpucc.h>
e7ea17c3abdf54 Neil Armstrong 2023-11-06  10  #include <dt-bindings/clock/qcom,sm8650-tcsr.h>
e7ea17c3abdf54 Neil Armstrong 2023-11-06  11  #include <dt-bindings/dma/qcom-gpi.h>
e7ea17c3abdf54 Neil Armstrong 2023-11-06  12  #include <dt-bindings/firmware/qcom,scm.h>
e7ea17c3abdf54 Neil Armstrong 2023-11-06  13  #include <dt-bindings/gpio/gpio.h>
e7ea17c3abdf54 Neil Armstrong 2023-11-06  14  #include <dt-bindings/interrupt-controller/arm-gic.h>
e7ea17c3abdf54 Neil Armstrong 2023-11-06  15  #include <dt-bindings/mailbox/qcom-ipcc.h>
e7ea17c3abdf54 Neil Armstrong 2023-11-06  16  #include <dt-bindings/phy/phy-qcom-qmp.h>
e7ea17c3abdf54 Neil Armstrong 2023-11-06  17  #include <dt-bindings/power/qcom,rpmhpd.h>
e7ea17c3abdf54 Neil Armstrong 2023-11-06  18  #include <dt-bindings/power/qcom-rpmpd.h>
e7ea17c3abdf54 Neil Armstrong 2023-11-06  19  #include <dt-bindings/reset/qcom,sm8650-gpucc.h>
e7ea17c3abdf54 Neil Armstrong 2023-11-06  20  #include <dt-bindings/soc/qcom,gpr.h>
e7ea17c3abdf54 Neil Armstrong 2023-11-06  21  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
e7ea17c3abdf54 Neil Armstrong 2023-11-06  22  #include <dt-bindings/thermal/thermal.h>
e7ea17c3abdf54 Neil Armstrong 2023-11-06  23  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
