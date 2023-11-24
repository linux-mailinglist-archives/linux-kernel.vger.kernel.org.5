Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736557F74C1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345231AbjKXNUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345250AbjKXNUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:20:20 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9444810FE;
        Fri, 24 Nov 2023 05:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700832025; x=1732368025;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/5khxxfaWaDrp+7xzbywroUSqPLt6PgF7RJxWSypS1M=;
  b=bDKGCLjqkBHdy/exb3C2Az8/0LMVC3/gO0YtnTQtCDl9NEoab72zSLUd
   F8PNq1TshHAvGFawK2BalTKa9mSJCL65ypyhHNBmWxnw5gTu7AJe7cLSL
   Repiwi64ll6g3yrQMYLq01DllBoEJkR9iBDGnaF0G6bbkIC4uyk1fBWL3
   jIj51Gj7jL0y/quSaEJ8pyAGQ5JNxZgl60/l0HAHW/TXlK0E5kd+8nNJW
   lUnBNrtiw5o6PTs8xWRJeO9lF2Sa5NjNyU2J9pPOGODATFeozWkI6KGsz
   M9OAvAT7j/0m+nKA72T1fIsTMU0nxZcJFlyYVm6J4mRyQbndzgNO3DS+6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="382823492"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="382823492"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 05:20:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="885274546"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="885274546"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 24 Nov 2023 05:20:19 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r6W6T-0002nk-2M;
        Fri, 24 Nov 2023 13:20:17 +0000
Date:   Fri, 24 Nov 2023 21:19:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Suraj Jaiswal <quic_jsuraj@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>
Cc:     oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
        kernel@quicinc.com
Subject: Re: [PATCH net-next v3 3/3] net: stmmac: Add driver support for
 DWMAC5 fault IRQ Support
Message-ID: <202311241444.wkNnpI5Q-lkp@intel.com>
References: <62eaaace3713751cb1ecac3163e857737107ca0e.1700737841.git.quic_jsuraj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62eaaace3713751cb1ecac3163e857737107ca0e.1700737841.git.quic_jsuraj@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suraj,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Suraj-Jaiswal/dt-bindings-net-qcom-ethqos-add-binding-doc-for-fault-IRQ-for-sa8775p/20231123-202252
base:   net-next/main
patch link:    https://lore.kernel.org/r/62eaaace3713751cb1ecac3163e857737107ca0e.1700737841.git.quic_jsuraj%40quicinc.com
patch subject: [PATCH net-next v3 3/3] net: stmmac: Add driver support for DWMAC5 fault IRQ Support
config: csky-randconfig-r081-20231124 (https://download.01.org/0day-ci/archive/20231124/202311241444.wkNnpI5Q-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231124/202311241444.wkNnpI5Q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311241444.wkNnpI5Q-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c:693:5: warning: no previous prototype for 'stmmac_get_fault_intr_config' [-Wmissing-prototypes]
     693 | int stmmac_get_fault_intr_config(struct platform_device *pdev, struct stmmac_resources *res)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/stmmac_get_fault_intr_config +693 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c

   692	
 > 693	int stmmac_get_fault_intr_config(struct platform_device *pdev, struct stmmac_resources *res)
   694	{
   695		int ret = 0;
   696	
   697		res->safety_common_intr = platform_get_irq_byname(pdev, "safety");
   698	
   699		if (res->safety_common_intr < 0) {
   700			if (res->safety_common_intr != -EPROBE_DEFER)
   701				dev_err(&pdev->dev, "safety IRQ configuration information not found\n");
   702			ret = 1;
   703		}
   704	
   705		return ret;
   706	}
   707	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
