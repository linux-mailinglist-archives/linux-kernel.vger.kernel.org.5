Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD4579CD37
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbjILKHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbjILKHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:07:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEC710E3;
        Tue, 12 Sep 2023 03:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694513232; x=1726049232;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eK2t15mGnsXgSy49KZauX10qwOfSdZIw/vwbiA8F8s0=;
  b=KW51nUaYHCu/eAG/xGfC/KpKhLHciWHZNt9/mP+5Yxl8Hjbqme3h3OqM
   zGOmyy5QDulRkM0IqA8rMu71/c5mSovdyOtomE5ECmmZUUfQzpRoV2HvN
   6+E6qpttqbeSXRUwsIaVwJ4oYCYHThFkMjaR9BxnYaOgONR76/SQw5b8m
   1Uzf17ga0up3LxhUa66oeQc9fqyWa0N6OMHQgpPpfOanmcYRLQBfKjuD5
   lAZUvTGhOxEOfm2FtlpL2lownHokMB040aiDmyN80gouqRiGKwsqGsO2p
   QxI8wXlLbzLzNfKbVex7cusC+CBU+UfB1R4OY81cA7RjG29k3Kt4KKFR1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="368589851"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="368589851"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 03:07:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="778738399"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="778738399"
Received: from lkp-server02.sh.intel.com (HELO 1e56c5165d33) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 12 Sep 2023 03:07:06 -0700
Received: from kbuild by 1e56c5165d33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qg0IP-0000Ej-0o;
        Tue, 12 Sep 2023 10:07:01 +0000
Date:   Tue, 12 Sep 2023 18:06:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v2 1/2] phy: qcom-qmp-combo: Square out 8550
 POWER_STATE_CONFIG1
Message-ID: <202309121747.8Ln8K1XY-lkp@intel.com>
References: <20230829-topic-8550_usbphy-v2-1-a72f43311d19@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829-topic-8550_usbphy-v2-1-a72f43311d19@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.6-rc1 next-20230912]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Konrad-Dybcio/phy-qcom-qmp-combo-initialize-PCS_USB-registers/20230912-072106
base:   linus/master
patch link:    https://lore.kernel.org/r/20230829-topic-8550_usbphy-v2-1-a72f43311d19%40linaro.org
patch subject: [PATCH v2 1/2] phy: qcom-qmp-combo: Square out 8550 POWER_STATE_CONFIG1
config: arm-randconfig-r016-20230912 (https://download.01.org/0day-ci/archive/20230912/202309121747.8Ln8K1XY-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230912/202309121747.8Ln8K1XY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309121747.8Ln8K1XY-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/phy/qualcomm/phy-qcom-qmp-combo.c:865:19: error: use of undeclared identifier 'QPHY_USB_Q6_PCS_USB3_POWER_STATE_CONFIG1'
     865 |         QMP_PHY_INIT_CFG(QPHY_USB_Q6_PCS_USB3_POWER_STATE_CONFIG1, 0x68),
         |                          ^
>> drivers/phy/qualcomm/phy-qcom-qmp-combo.c:1837:21: error: invalid application of 'sizeof' to an incomplete type 'const struct qmp_phy_init_tbl[]'
    1837 |         .pcs_usb_tbl_num        = ARRAY_SIZE(sm8550_usb3_pcs_usb_tbl),
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:57:32: note: expanded from macro 'ARRAY_SIZE'
      57 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                ^~~~~
   2 errors generated.


vim +/QPHY_USB_Q6_PCS_USB3_POWER_STATE_CONFIG1 +865 drivers/phy/qualcomm/phy-qcom-qmp-combo.c

   863	
   864	static const struct qmp_phy_init_tbl sm8550_usb3_pcs_usb_tbl[] = {
 > 865		QMP_PHY_INIT_CFG(QPHY_USB_Q6_PCS_USB3_POWER_STATE_CONFIG1, 0x68),
   866		QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
   867		QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_USB3_RXEQTRAINING_DFE_TIME_S2, 0x07),
   868		QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_USB3_RCVR_DTCT_DLY_U3_L, 0x40),
   869		QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_USB3_RCVR_DTCT_DLY_U3_H, 0x00),
   870	};
   871	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
