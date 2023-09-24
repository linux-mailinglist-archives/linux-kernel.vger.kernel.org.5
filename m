Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5AC7ACA29
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 16:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjIXO5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 10:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjIXO5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 10:57:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFE6FC;
        Sun, 24 Sep 2023 07:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695567446; x=1727103446;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vz2UOygP0PG/3NMBGLLpj3xINFuw6s3dUMhingYavng=;
  b=gjbSUqDOCvJl/pDN1RwPy5Oco21MqntaoI1rwKcKS6xTwCarn+p4WxX+
   OOjKgOrqcntQL4nq6xgZWPgkcMpUdKaqd3iJnXlA7AXYdbabMbJmAdzkg
   eNVt3hv6/NRVKhZ7Og3Sf2mhdPxitn9YKWsIHlJp2+1uHHSd1HyOMA33Q
   GYnjXFIhDyYN/o8hEQbM6jmWtKn1plSsrAWX4j9QvBUIfXFV6Rfa0bRS9
   HluUGJ9F4C/138Ddtl6e6jEqHG6vEGg39tpTesTyUuSGOleHrLOYWv+RE
   7vgHnz42g7/w94K8MEj8bCO8zSEhKxhpKSi5VBAPj6jXQ/G8eFUlj8CrF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="447586299"
X-IronPort-AV: E=Sophos;i="6.03,173,1694761200"; 
   d="scan'208";a="447586299"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 07:57:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="783200304"
X-IronPort-AV: E=Sophos;i="6.03,173,1694761200"; 
   d="scan'208";a="783200304"
Received: from lkp-server02.sh.intel.com (HELO 493f6c7fed5d) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 24 Sep 2023 07:57:19 -0700
Received: from kbuild by 493f6c7fed5d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qkQXt-0003oH-0P;
        Sun, 24 Sep 2023 14:57:17 +0000
Date:   Sun, 24 Sep 2023 22:57:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tengfei Fan <quic_tengfan@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, tglx@linutronix.de,
        maz@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, geert+renesas@glider.be,
        arnd@arndb.de, neil.armstrong@linaro.org, nfraprado@collabora.com,
        rafal@milecki.pl, peng.fan@nxp.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, quic_tsoni@quicinc.com,
        quic_shashim@quicinc.com, quic_kaushalk@quicinc.com,
        quic_tdas@quicinc.com, quic_tingweiz@quicinc.com,
        quic_aiquny@quicinc.com, kernel@quicinc.com,
        Tengfei Fan <quic_tengfan@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
Subject: Re: [PATCH v4 3/6] arm64: dts: qcom: sm4450: Add RPMH and Global
 clock
Message-ID: <202309242226.wwMJhznj-lkp@intel.com>
References: <20230922081026.2799-4-quic_tengfan@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922081026.2799-4-quic_tengfan@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tengfei,

kernel test robot noticed the following build errors:

[auto build test ERROR on 940fcc189c51032dd0282cbee4497542c982ac59]

url:    https://github.com/intel-lab-lkp/linux/commits/Tengfei-Fan/dt-bindings-interrupt-controller-qcom-pdc-document-qcom-sm4450-pdc/20230922-161433
base:   940fcc189c51032dd0282cbee4497542c982ac59
patch link:    https://lore.kernel.org/r/20230922081026.2799-4-quic_tengfan%40quicinc.com
patch subject: [PATCH v4 3/6] arm64: dts: qcom: sm4450: Add RPMH and Global clock
config: arm64-randconfig-002-20230924 (https://download.01.org/0day-ci/archive/20230924/202309242226.wwMJhznj-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230924/202309242226.wwMJhznj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309242226.wwMJhznj-lkp@intel.com/

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
