Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F1B7C8D63
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 20:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjJMS7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 14:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJMS7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 14:59:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D2A83;
        Fri, 13 Oct 2023 11:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697223570; x=1728759570;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EsdyqAMRIhj+nuI28f5pAZYuhBMa9I0ITCTO8KcjSjQ=;
  b=PNqceIBunZrAczyg4HTLpmJ08UWg2GpiipPgih01QmV9nDceLQOA0/fi
   hroOtrr02g7M0h6VvMmx4swPm34abWE22sSLA5K+lxKVQx0g7n2xMs4NL
   umml1upE4IGmb+lCkyaGkYz0AoDbj95Ff2REDY8T9cVSZr5bpf30AcUss
   foKFGU0C7+Gd5Z35RL4HLcTS83ay+YAW6G5+5kI19fGXNjtsZXhto16yz
   oOQ1UGOltFbVAsOrTh9d64X90RGzlwDb7KxGEkFtdQ85oc79ResIhxYCo
   lTU1vzUxYQkF0jzlv462WafQss8AHDBx1qndMUMyJSG7q/fv2Sdbai2/H
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="370308615"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="370308615"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 11:59:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="1002055617"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="1002055617"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 13 Oct 2023 11:59:23 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qrNNY-0005Ht-35;
        Fri, 13 Oct 2023 18:59:20 +0000
Date:   Sat, 14 Oct 2023 02:58:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tengfei Fan <quic_tengfan@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert+renesas@glider.be, arnd@arndb.de, neil.armstrong@linaro.org,
        nfraprado@collabora.com, u-kumar1@ti.com, peng.fa@nxp.com,
        quic_tsoni@quicinc.com, quic_shashim@quicinc.com,
        quic_kaushalk@quicinc.com, quic_tdas@quicinc.com,
        quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com,
        kernel@quicinc.com, Tengfei Fan <quic_tengfan@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
Subject: Re: [PATCH v5 RESEND 3/7] arm64: dts: qcom: sm4450: Add RPMH and
 Global clock
Message-ID: <202310140224.m4RecMup-lkp@intel.com>
References: <20231011031415.3360-4-quic_tengfan@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011031415.3360-4-quic_tengfan@quicinc.com>
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

[auto build test ERROR on 940fcc189c51032dd0282cbee4497542c982ac59]

url:    https://github.com/intel-lab-lkp/linux/commits/Tengfei-Fan/dt-bindings-interrupt-controller-qcom-pdc-document-qcom-sm4450-pdc/20231011-111816
base:   940fcc189c51032dd0282cbee4497542c982ac59
patch link:    https://lore.kernel.org/r/20231011031415.3360-4-quic_tengfan%40quicinc.com
patch subject: [PATCH v5 RESEND 3/7] arm64: dts: qcom: sm4450: Add RPMH and Global clock
config: arm64-randconfig-003-20231014 (https://download.01.org/0day-ci/archive/20231014/202310140224.m4RecMup-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231014/202310140224.m4RecMup-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310140224.m4RecMup-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/arm64/boot/dts/qcom/sm4450-qrd.dts:8:
>> arch/arm64/boot/dts/qcom/sm4450.dtsi:7:10: fatal error: dt-bindings/clock/qcom,sm4450-gcc.h: No such file or directory
       7 | #include <dt-bindings/clock/qcom,sm4450-gcc.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +7 arch/arm64/boot/dts/qcom/sm4450.dtsi

   > 7	#include <dt-bindings/clock/qcom,sm4450-gcc.h>
     8	#include <dt-bindings/gpio/gpio.h>
     9	#include <dt-bindings/interrupt-controller/arm-gic.h>
    10	#include <dt-bindings/soc/qcom,rpmh-rsc.h>
    11	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
