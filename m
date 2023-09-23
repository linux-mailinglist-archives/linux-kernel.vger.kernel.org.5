Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DF07AC3A6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 18:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjIWQ2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 12:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbjIWQ2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 12:28:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C085A3;
        Sat, 23 Sep 2023 09:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695486473; x=1727022473;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2EgNBjJKkDIylgKrJfdQAHWESh7j0MS+R2T8A6UuXSQ=;
  b=XBm44GApVkQSR/KyJfFfFo2jOcXXgWWx6rzwkMBJZsb5KjraL3otF3vp
   ff85BHHTchlJ46555Dw4yLlL7vXYZ1JDKfFjr7ahoX8wVWH0j96dHrOyu
   /iZ9YGeaB7/YoOCbiH9uGvUnbEnnjJl+QpqIlN5NYVhUeCuq/hPi5D9CL
   CErgCmgnN0lf4g/OObKvxs+HCiigVlLM0G9pI/ZkK/jeKa3JWSFMSrVEu
   9rcs4dWnS3FBiDuUjEbqSEd933Ypbrx2TE4Dd4S+g+zir6pSM8x86v3IN
   a3Wfq1We5icDZ6+J3TBs+Uz/I3GBBVVvxqCT4YM1TBB44+pznxwQjLH6m
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10842"; a="379916301"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; 
   d="scan'208";a="379916301"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2023 09:27:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10842"; a="697540892"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; 
   d="scan'208";a="697540892"
Received: from lkp-server02.sh.intel.com (HELO 493f6c7fed5d) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 23 Sep 2023 09:27:49 -0700
Received: from kbuild by 493f6c7fed5d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qk5Tv-0002cs-2D;
        Sat, 23 Sep 2023 16:27:47 +0000
Date:   Sun, 24 Sep 2023 00:27:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: Re: [PATCH 1/3] arm64: dts: qcom: Add interconnect nodes for SDX75
Message-ID: <202309240033.AmuJpOkT-lkp@intel.com>
References: <1695383434-24705-2-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1695383434-24705-2-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rohit,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.6-rc2 next-20230921]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rohit-Agarwal/arm64-dts-qcom-Add-interconnect-nodes-for-SDX75/20230922-195140
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/1695383434-24705-2-git-send-email-quic_rohiagar%40quicinc.com
patch subject: [PATCH 1/3] arm64: dts: qcom: Add interconnect nodes for SDX75
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20230924/202309240033.AmuJpOkT-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230924/202309240033.AmuJpOkT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309240033.AmuJpOkT-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/arm64/boot/dts/qcom/sdx75-idp.dts:9:
>> arch/arm64/boot/dts/qcom/sdx75.dtsi:11:10: fatal error: dt-bindings/interconnect/qcom,sdx75.h: No such file or directory
      11 | #include <dt-bindings/interconnect/qcom,sdx75.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +11 arch/arm64/boot/dts/qcom/sdx75.dtsi

  > 11	#include <dt-bindings/interconnect/qcom,sdx75.h>
    12	#include <dt-bindings/interrupt-controller/arm-gic.h>
    13	#include <dt-bindings/power/qcom,rpmhpd.h>
    14	#include <dt-bindings/power/qcom-rpmpd.h>
    15	#include <dt-bindings/soc/qcom,rpmh-rsc.h>
    16	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
