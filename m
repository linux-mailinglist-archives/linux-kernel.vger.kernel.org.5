Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985357593C2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 13:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjGSLFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 07:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjGSLFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 07:05:37 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305F319A;
        Wed, 19 Jul 2023 04:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689764736; x=1721300736;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lqPMmv8M10HlNolBgp653qSVYTh89TergptkrLWqzYo=;
  b=S5NtVeRoGxWEjiy4hfYUAS6bs0vfE83cCaG/koNG3riMlWxEYMmxngH7
   wd/UooOkJRRRf8oXEF1DJgiCM1fLoahHlHIoA1yA/8oYaOyrqLhMVs4Or
   RUQm4+dbmqmr2n3HXCWsHzIO1QU8BY8NpqVJfIaKra3CIRmGTkE55oEYE
   h/JUbwQI2rh7uzoF7NTpBdEQh+d/Nl+lfW+dJLoe4CIyIWKAjALjNVU5N
   wBZV+ZjH1CcQsGEOPCEa+62lNArQO+022rBZYuDQQMNdczTFJNkIC54z2
   PRwJxBle5D6naYj8wNIDeOjEdrIkxWMZ0jM53U4o2qAFBujmBb/bPR48k
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="346023055"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="346023055"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 04:05:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="867422501"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jul 2023 04:05:15 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qM4zX-0004hf-2P;
        Wed, 19 Jul 2023 11:05:12 +0000
Date:   Wed, 19 Jul 2023 19:04:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mathieu.poirier@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        quic_eberman@quicinc.com, kvalo@kernel.org,
        loic.poulain@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, quic_srichara@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_anusha@quicinc.com
Subject: Re: [V3,09/11] remoteproc: qcom: Add Hexagon based multipd rproc
 driver
Message-ID: <202307191844.WyywUs6s-lkp@intel.com>
References: <20230718120501.3205661-10-quic_mmanikan@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718120501.3205661-10-quic_mmanikan@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manikanta,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20230718]
[also build test WARNING on v6.5-rc2]
[cannot apply to remoteproc/rproc-next clk/clk-next robh/for-next linus/master v6.5-rc2 v6.5-rc1 v6.4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Manikanta-Mylavarapu/dt-bindings-remoteproc-qcom-Add-support-for-multipd-model/20230718-202747
base:   next-20230718
patch link:    https://lore.kernel.org/r/20230718120501.3205661-10-quic_mmanikan%40quicinc.com
patch subject: [V3,09/11] remoteproc: qcom: Add Hexagon based multipd rproc driver
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20230719/202307191844.WyywUs6s-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230719/202307191844.WyywUs6s-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307191844.WyywUs6s-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/remoteproc/qcom_q6v5_mpd.c:112:4: warning: no previous prototype for 'qcom_get_pd_asid' [-Wmissing-prototypes]
     112 | u8 qcom_get_pd_asid(struct rproc *rproc)
         |    ^~~~~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for SM_GCC_8350
   Depends on [n]: COMMON_CLK [=y] && COMMON_CLK_QCOM [=m] && (ARM64 || COMPILE_TEST [=n])
   Selected by [m]:
   - SM_VIDEOCC_8350 [=m] && COMMON_CLK [=y] && COMMON_CLK_QCOM [=m]
   WARNING: unmet direct dependencies detected for SM_GCC_8450
   Depends on [n]: COMMON_CLK [=y] && COMMON_CLK_QCOM [=m] && (ARM64 || COMPILE_TEST [=n])
   Selected by [m]:
   - SM_GPUCC_8450 [=m] && COMMON_CLK [=y] && COMMON_CLK_QCOM [=m]
   - SM_VIDEOCC_8450 [=m] && COMMON_CLK [=y] && COMMON_CLK_QCOM [=m]
   WARNING: unmet direct dependencies detected for SM_GCC_8550
   Depends on [n]: COMMON_CLK [=y] && COMMON_CLK_QCOM [=m] && (ARM64 || COMPILE_TEST [=n])
   Selected by [m]:
   - SM_GPUCC_8550 [=m] && COMMON_CLK [=y] && COMMON_CLK_QCOM [=m]
   - SM_VIDEOCC_8550 [=m] && COMMON_CLK [=y] && COMMON_CLK_QCOM [=m]


vim +/qcom_get_pd_asid +112 drivers/remoteproc/qcom_q6v5_mpd.c

   105	
   106	/**
   107	 * qcom_get_pd_asid() - get the pd asid number from PD spawn bit
   108	 * @rproc:	rproc handle
   109	 *
   110	 * Returns asid on success
   111	 */
 > 112	u8 qcom_get_pd_asid(struct rproc *rproc)
   113	{
   114		struct q6_wcss *wcss = rproc->priv;
   115		u8 bit = wcss->q6.spawn_bit;
   116	
   117		return bit / 8;
   118	}
   119	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
