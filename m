Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC577D87FF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 20:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjJZSGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 14:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjJZSGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 14:06:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D729C;
        Thu, 26 Oct 2023 11:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698343602; x=1729879602;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2Akrt3XkQC1r7qz/7YkQdobfE2+0OS3PJnwTrBQQOzk=;
  b=PgbQWH4ltEJBFMxQ2Z7SQVYtloYGNVPuBQ3VMU44NIEK+pfYWAOBSZ+F
   p2xlqJuNLq6E/idbLewl994ZKI/FuP3vaakEBbZvblbLEO/xLAFZJGmsc
   fov9til0+IPB1NJbJ0cr0SRydpsgim2gmRIuJ/PbbqIAdfONkBw3YTBSm
   kP0v1fKxhcW/4ft8LhcNOsk5dBI/HbLUxWAGFRZbqkmbJnBkIKslxpu2X
   6iN+EziB1N55qY1kuVjQD0wjS2uee0sSm0chi15RNuI8/3tnfaKD1C/5h
   KMVl6+AqDkYaNsKrg6bYUtaACAy6cvebHppAgy2D9x5HJ9hdC3V+HEnPw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="367827897"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="367827897"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 11:06:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="788588247"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="788588247"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 26 Oct 2023 11:06:35 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qw4ka-000A1B-2o;
        Thu, 26 Oct 2023 18:06:32 +0000
Date:   Fri, 27 Oct 2023 02:05:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, catalin.marinas@arm.com,
        ulf.hansson@linaro.org
Cc:     oe-kbuild-all@lists.linux.dev, agross@kernel.org,
        conor+dt@kernel.org, ayan.kumar.halder@amd.com, j@jannau.net,
        dmitry.baryshkov@linaro.org, nfraprado@collabora.com,
        m.szyprowski@samsung.com, u-kumar1@ti.com, peng.fan@nxp.com,
        lpieralisi@kernel.org, quic_rjendra@quicinc.com,
        abel.vesa@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, quic_tsoni@quicinc.com,
        neil.armstrong@linaro.org, Sibi Sankar <quic_sibis@quicinc.com>
Subject: Re: [PATCH 3/5] arm64: dts: qcom: Add base SC8380XP dtsi and the QCP
 dts
Message-ID: <202310270119.EeUyjyx2-lkp@intel.com>
References: <20231025142427.2661-4-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025142427.2661-4-quic_sibis@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sibi,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on arm64/for-next/core linus/master v6.6-rc7 next-20231026]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sibi-Sankar/dt-bindings-arm-cpus-Add-qcom-oryon-compatible/20231026-001800
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20231025142427.2661-4-quic_sibis%40quicinc.com
patch subject: [PATCH 3/5] arm64: dts: qcom: Add base SC8380XP dtsi and the QCP dts
config: arm64-randconfig-004-20231026 (https://download.01.org/0day-ci/archive/20231027/202310270119.EeUyjyx2-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231027/202310270119.EeUyjyx2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310270119.EeUyjyx2-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/arm64/boot/dts/qcom/sc8380xp-qcp.dts:10:
>> arch/arm64/boot/dts/qcom/sc8380xp.dtsi:7:10: fatal error: dt-bindings/clock/qcom,sc8380xp-gcc.h: No such file or directory
       7 | #include <dt-bindings/clock/qcom,sc8380xp-gcc.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +7 arch/arm64/boot/dts/qcom/sc8380xp.dtsi

   > 7	#include <dt-bindings/clock/qcom,sc8380xp-gcc.h>
     8	#include <dt-bindings/dma/qcom-gpi.h>
     9	#include <dt-bindings/interconnect/qcom,sc8380xp-rpmh.h>
    10	#include <dt-bindings/interrupt-controller/arm-gic.h>
    11	#include <dt-bindings/power/qcom,rpmhpd.h>
    12	#include <dt-bindings/power/qcom-rpmpd.h>
    13	#include <dt-bindings/soc/qcom,rpmh-rsc.h>
    14	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
