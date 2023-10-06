Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1607BBACA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbjJFOtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbjJFOtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:49:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71463CE;
        Fri,  6 Oct 2023 07:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696603770; x=1728139770;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ls4VkimTOVrFvW0MKJV3HoKVItCCEU0Bs2/H222NV1k=;
  b=aw8A+YF9SdIuYrB/idzYxJ4jICz8EtYCLjrOrbhSVnVD2YSdh+of1/OW
   n5hDgKE4koWUJJ0+P5CdschyjoC4khV/WD5I8+i1wHB4PINI3C3QC3oFk
   cCY8X3D7BltBxgWmTFhM9BOp+yDafAU2p+DNY7jp4nnQTN9pOK9xNUQDt
   NVOgZpH+ZFPQvtHvLR2yINYcy7BAKkaUp92PwHsSm2vukTZoJ0PWRME73
   UeEuSz5Wmn+68J+dYknrb19wHqdm72Sif7qlASLXEN7c/BukaE19EDLWs
   /HomrpcoGmF+3nW6vtNapn3OLTw6jjrtlSSCOoLn9u4SHjklvi2IZyHKC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="386589922"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="386589922"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 07:49:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="842853647"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="842853647"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Oct 2023 07:49:27 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qom8q-0001SH-2Q;
        Fri, 06 Oct 2023 14:49:24 +0000
Date:   Fri, 6 Oct 2023 22:48:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Komal Bajaj <quic_kbajaj@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        luca.weiss@fairphone.com, Komal Bajaj <quic_kbajaj@quicinc.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: qcm6490: Add qcm6490 dts file
Message-ID: <202310062256.LQAdaNZV-lkp@intel.com>
References: <20231003175456.14774-3-quic_kbajaj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003175456.14774-3-quic_kbajaj@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Komal,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20231003]
[cannot apply to robh/for-next v6.6-rc4 v6.6-rc3 v6.6-rc2 linus/master v6.6-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Komal-Bajaj/dt-bindings-arm-qcom-Add-QCM6490-IDP-board/20231004-015725
base:   next-20231003
patch link:    https://lore.kernel.org/r/20231003175456.14774-3-quic_kbajaj%40quicinc.com
patch subject: [PATCH v3 2/2] arm64: dts: qcom: qcm6490: Add qcm6490 dts file
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20231006/202310062256.LQAdaNZV-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231006/202310062256.LQAdaNZV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310062256.LQAdaNZV-lkp@intel.com/

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/qcom/pm7325.dtsi:9.11-33.3 Label or path spmi_bus not found
>> Error: arch/arm64/boot/dts/qcom/pm7325.dtsi:35.1-15 Label or path thermal_zones not found
>> Error: arch/arm64/boot/dts/qcom/pm8350c.dtsi:9.1-10 Label or path spmi_bus not found
>> Error: arch/arm64/boot/dts/qcom/pmk8350.dtsi:26.1-10 Label or path spmi_bus not found
>> Error: arch/arm64/boot/dts/qcom/qcm6490-idp.dts:249.1-13 Label or path pm8350c_pwm not found
   FATAL ERROR: Syntax error parsing input tree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
