Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6DE7F3031
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbjKUOEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234006AbjKUOEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:04:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627A7D7F;
        Tue, 21 Nov 2023 06:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700575488; x=1732111488;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XZP4lfw1143zghvYLcKoFwr5cIz7iQ/mX6yCIhP2bbY=;
  b=QUTWQv9/IdhRz1wW1AaaA10Bu3n/7/cA0NocRpaZsRxjyE8o0w1mdbc/
   fMQrPdf2YmDoU84WVxjDtkE9W880E9wIOrwe14Gvk/XllKlTKXqJZS4P0
   GTsbMdxt3PRzcPkkU8nMpY/2Fhc+A8LD4MI/tVmUmgsaqqLcbAnwiTyhj
   IVPZvd+kZq7KgIsIUCQ8mGMCZHLvQkkrPQYNnjjhWdPYf1f5gsfn0e+RM
   5R0KRaZx+D+RAieTF54KkUsXHgtZ6sygiYmfgImfb9IPjAiN7IomjDDx/
   KsFvPmKwbMQJ+KOGnOCMxtlXfDvnUPcBL+swgur1KT2qqQECyeVilbTYB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="422939290"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="422939290"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 06:04:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="890261425"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="890261425"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 21 Nov 2023 06:04:39 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5RMj-0007ta-09;
        Tue, 21 Nov 2023 14:04:37 +0000
Date:   Tue, 21 Nov 2023 22:03:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, catalin.marinas@arm.com,
        ulf.hansson@linaro.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        agross@kernel.org, conor+dt@kernel.org, ayan.kumar.halder@amd.com,
        j@jannau.net, dmitry.baryshkov@linaro.org, nfraprado@collabora.com,
        m.szyprowski@samsung.com, u-kumar1@ti.com, peng.fan@nxp.com,
        lpieralisi@kernel.org, quic_rjendra@quicinc.com,
        abel.vesa@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, quic_tsoni@quicinc.com,
        neil.armstrong@linaro.org, Sibi Sankar <quic_sibis@quicinc.com>
Subject: Re: [PATCH V2 3/5] arm64: dts: qcom: Add base X1E80100 dtsi and the
 QCP dts
Message-ID: <202311212100.eIdoZhGN-lkp@intel.com>
References: <20231117113931.26660-4-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117113931.26660-4-quic_sibis@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sibi,

kernel test robot noticed the following build errors:

[auto build test ERROR on v6.7-rc1]
[also build test ERROR on linus/master next-20231121]
[cannot apply to robh/for-next arm64/for-next/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sibi-Sankar/dt-bindings-arm-cpus-Add-qcom-oryon-compatible/20231117-194253
base:   v6.7-rc1
patch link:    https://lore.kernel.org/r/20231117113931.26660-4-quic_sibis%40quicinc.com
patch subject: [PATCH V2 3/5] arm64: dts: qcom: Add base X1E80100 dtsi and the QCP dts
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20231121/202311212100.eIdoZhGN-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231121/202311212100.eIdoZhGN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311212100.eIdoZhGN-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/arm64/boot/dts/qcom/x1e80100-qcp.dts:10:
>> arch/arm64/boot/dts/qcom/x1e80100.dtsi:7:10: fatal error: 'dt-bindings/clock/qcom,x1e80100-gcc.h' file not found
       7 | #include <dt-bindings/clock/qcom,x1e80100-gcc.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +7 arch/arm64/boot/dts/qcom/x1e80100.dtsi

   > 7	#include <dt-bindings/clock/qcom,x1e80100-gcc.h>
     8	#include <dt-bindings/dma/qcom-gpi.h>
     9	#include <dt-bindings/interconnect/qcom,icc.h>
    10	#include <dt-bindings/interconnect/qcom,x1e80100-rpmh.h>
    11	#include <dt-bindings/interrupt-controller/arm-gic.h>
    12	#include <dt-bindings/power/qcom,rpmhpd.h>
    13	#include <dt-bindings/power/qcom-rpmpd.h>
    14	#include <dt-bindings/soc/qcom,rpmh-rsc.h>
    15	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
