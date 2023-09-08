Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2685798951
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 16:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244198AbjIHOzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 10:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240124AbjIHOz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 10:55:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E341FC1;
        Fri,  8 Sep 2023 07:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694184916; x=1725720916;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hRPta3ptzMNjQT7WswU+lJMeajZApy8eHTToKWyCnrg=;
  b=ni1J1s3emKWzYX2GVe7EgTWHDOlJtxlAg28MmntIn1failtywlofoLuk
   UuAI0Q2fBsjYa/nKENa6Z8P6Z6URPZT4VDXUYL+ypagqqXKWyg6zo7Cst
   W8E06/3ZArfxAgRNQIScRFBsWT+Oa3MJq/eGoR0+Tjar1kNjkIK2lWRg/
   qv2iciD1jbk8WyE7nVbSMvw7ctHNL7Rt35h4OliaC+kc+TePs0LGwcaf8
   Ax3NAfzATMIfPhAI0pJCoVp9cN5z3zR+/gDvN9deoolyYYohNj73Sv3ba
   5bsWdalwBXk8SRngrfwRhBYtOD1pRbjK/clxtydprMrWwoCjzP2kG6dQk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="357969728"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="357969728"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 07:55:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="1073339873"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="1073339873"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 08 Sep 2023 07:55:10 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qect2-0002Mq-27;
        Fri, 08 Sep 2023 14:55:08 +0000
Date:   Fri, 8 Sep 2023 22:55:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tengfei Fan <quic_tengfan@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, lee@kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        robimarko@gmail.com, quic_gurus@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_tsoni@quicinc.com,
        quic_shashim@quicinc.com, quic_kaushalk@quicinc.com,
        quic_tdas@quicinc.com, quic_tingweiz@quicinc.com,
        quic_aiquny@quicinc.com, kernel@quicinc.com,
        quic_bjorande@quicinc.com, Ajit Pandey <quic_ajipan@quicinc.com>,
        Tengfei Fan <quic_tengfan@quicinc.com>
Subject: Re: [PATCH 5/6] arm64: dts: qcom: sm4450: Add RPMH and Global clock
 controller
Message-ID: <202309082243.JImHPFSN-lkp@intel.com>
References: <20230908065847.28382-6-quic_tengfan@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908065847.28382-6-quic_tengfan@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tengfei,

kernel test robot noticed the following build errors:

[auto build test ERROR on a47fc304d2b678db1a5d760a7d644dac9b067752]

url:    https://github.com/intel-lab-lkp/linux/commits/Tengfei-Fan/dt-bindings-firmware-document-Qualcomm-SM4450-SCM/20230908-150308
base:   a47fc304d2b678db1a5d760a7d644dac9b067752
patch link:    https://lore.kernel.org/r/20230908065847.28382-6-quic_tengfan%40quicinc.com
patch subject: [PATCH 5/6] arm64: dts: qcom: sm4450: Add RPMH and Global clock controller
config: arm64-randconfig-r024-20230908 (https://download.01.org/0day-ci/archive/20230908/202309082243.JImHPFSN-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230908/202309082243.JImHPFSN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309082243.JImHPFSN-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/arm64/boot/dts/qcom/sm4450-qrd.dts:8:
>> arch/arm64/boot/dts/qcom/sm4450.dtsi:7:10: fatal error: 'dt-bindings/clock/qcom,sm4450-gcc.h' file not found
   #include <dt-bindings/clock/qcom,sm4450-gcc.h>
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +7 arch/arm64/boot/dts/qcom/sm4450.dtsi

   > 7	#include <dt-bindings/clock/qcom,sm4450-gcc.h>
     8	#include <dt-bindings/gpio/gpio.h>
     9	#include <dt-bindings/interrupt-controller/arm-gic.h>
    10	#include <dt-bindings/soc/qcom,rpmh-rsc.h>
    11	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
