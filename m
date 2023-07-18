Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF2D7581CA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjGRQMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjGRQMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:12:22 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD879B5;
        Tue, 18 Jul 2023 09:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689696741; x=1721232741;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xJz/Q2VPWovJMeTlZg5Nu1AilnZ3M8HZafInk4+HO3I=;
  b=l8aOHXQ1W1R6I49o3Or8F7ZwR8HRCjKpAJRt0MjNZ45WxUOQzdkybS0h
   gCiSH/d0nMIb0zlUWEvIbn+VHLMenf9hGEVk1m1JM/EB3ytCVK88+incH
   AdvivtIawnUKcHhN57MFzUU6Li8BYFfAEHSwMmonyDXO6orifQB37g0do
   HwtYbIZByA9TJZpp9CPb0F/gnmS1MVsEHGQo+lxyk9D6FcIU+6qF+HgUN
   j+sbDUxILFLwxAizDwJrG9J3tz1Gg2mrQag77qkIwMtd131cUokXjNVMv
   Tr+uJ5/65e6W9u4FS2TeX9eKMlb7qH3x5BfqmyX7RTSEXO5TTxiv7r8Qa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="368890788"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="368890788"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 09:12:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="753382540"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="753382540"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 18 Jul 2023 09:12:16 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qLnJ9-000112-1U;
        Tue, 18 Jul 2023 16:12:15 +0000
Date:   Wed, 19 Jul 2023 00:10:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Piyush Malgujar <pmalgujar@marvell.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, p.zabel@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        yamada.masahiro@socionext.com, devicetree@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, jannadurai@marvell.com,
        cchavva@marvell.com, Piyush Malgujar <pmalgujar@marvell.com>
Subject: Re: [PATCH v4 6/6] mmc: sdhci-cadence: Add debug option for SD6
 controller
Message-ID: <202307182343.ZsoiCcbg-lkp@intel.com>
References: <20230717125146.16791-7-pmalgujar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717125146.16791-7-pmalgujar@marvell.com>
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

Hi Piyush,

kernel test robot noticed the following build errors:

[auto build test ERROR on ulf-hansson-mmc-mirror/next]
[also build test ERROR on robh/for-next linus/master v6.5-rc2 next-20230718]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Piyush-Malgujar/mmc-sdhci-cadence-Rename-functions-structures-to-SD4-specific/20230718-175102
base:   https://git.linaro.org/people/ulf.hansson/mmc-mirror.git next
patch link:    https://lore.kernel.org/r/20230717125146.16791-7-pmalgujar%40marvell.com
patch subject: [PATCH v4 6/6] mmc: sdhci-cadence: Add debug option for SD6 controller
config: csky-randconfig-r023-20230718 (https://download.01.org/0day-ci/archive/20230718/202307182343.ZsoiCcbg-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230718/202307182343.ZsoiCcbg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307182343.ZsoiCcbg-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/mmc/host/sdhci-cadence.c: In function 'sdhci_cdns_sd6_dump':
>> drivers/mmc/host/sdhci-cadence.c:1066:9: error: too few arguments to function 'sdhci_cdns_sd6_phy_dump'
    1066 |         sdhci_cdns_sd6_phy_dump(phy);
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/host/sdhci-cadence.c:981:6: note: declared here
     981 | void sdhci_cdns_sd6_phy_dump(struct sdhci_cdns_sd6_phy *phy,
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/host/sdhci-cadence.c: In function 'sdhci_cdns_probe':
   drivers/mmc/host/sdhci-cadence.c:1973:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    1973 |         static const u16 version = SDHCI_SPEC_400 << SDHCI_SPEC_VER_SHIFT;
         |         ^~~~~~


vim +/sdhci_cdns_sd6_phy_dump +1066 drivers/mmc/host/sdhci-cadence.c

  1059	
  1060	static
  1061	void sdhci_cdns_sd6_dump(struct sdhci_cdns_priv *priv, struct sdhci_host *host)
  1062	{
  1063		struct sdhci_cdns_sd6_phy *phy = priv->phy;
  1064		int id;
  1065	
> 1066		sdhci_cdns_sd6_phy_dump(phy);
  1067	
  1068		dev_dbg(mmc_dev(host->mmc), "Host controller Register Dump\n");
  1069		for (id = 0; id < 14; id++) {
  1070			dev_dbg(mmc_dev(host->mmc), "HRS%d 0x%x\n", id,
  1071				readl(priv->hrs_addr + (id * 4)));
  1072		}
  1073	
  1074		id = 29;
  1075		dev_dbg(mmc_dev(host->mmc), "HRS%d 0x%x\n", id,
  1076			readl(priv->hrs_addr + (id * 4)));
  1077		id = 30;
  1078		dev_dbg(mmc_dev(host->mmc), "HRS%d 0x%x\n", id,
  1079			readl(priv->hrs_addr + (id * 4)));
  1080	
  1081		for (id = 0; id < 27; id++) {
  1082			dev_dbg(mmc_dev(host->mmc), "SRS%d 0x%x\n", id,
  1083				readl(priv->hrs_addr + 0x200 + (id * 4)));
  1084		}
  1085	
  1086		dev_dbg(mmc_dev(host->mmc), "SDHCI_CDNS_SD6_PHY_DQS_TIMING 0x%x\n",
  1087			sdhci_cdns_sd6_read_phy_reg(priv,
  1088						    SDHCI_CDNS_SD6_PHY_DQS_TIMING));
  1089		dev_dbg(mmc_dev(host->mmc), "SDHCI_CDNS_SD6_PHY_GATE_LPBK 0x%x\n",
  1090			sdhci_cdns_sd6_read_phy_reg(priv,
  1091						    SDHCI_CDNS_SD6_PHY_GATE_LPBK));
  1092		dev_dbg(mmc_dev(host->mmc), "SDHCI_CDNS_SD6_PHY_DLL_MASTER 0x%x\n",
  1093			sdhci_cdns_sd6_read_phy_reg(priv,
  1094						    SDHCI_CDNS_SD6_PHY_DLL_MASTER));
  1095		dev_dbg(mmc_dev(host->mmc), "SDHCI_CDNS_SD6_PHY_DLL_SLAVE 0x%x\n",
  1096			sdhci_cdns_sd6_read_phy_reg(priv,
  1097						    SDHCI_CDNS_SD6_PHY_DLL_SLAVE));
  1098		dev_dbg(mmc_dev(host->mmc), "SDHCI_CDNS_SD6_PHY_CTRL 0x%x\n",
  1099			sdhci_cdns_sd6_read_phy_reg(priv, SDHCI_CDNS_SD6_PHY_CTRL));
  1100		dev_dbg(mmc_dev(host->mmc), "SDHCI_CDNS_SD6_PHY_GPIO_CTRL0 0x%x\n",
  1101			sdhci_cdns_sd6_read_phy_reg(priv,
  1102						    SDHCI_CDNS_SD6_PHY_GPIO_CTRL0));
  1103		dev_dbg(mmc_dev(host->mmc), "SDHCI_CDNS_SD6_PHY_DQ_TIMING 0x%x\n",
  1104			sdhci_cdns_sd6_read_phy_reg(priv,
  1105						    SDHCI_CDNS_SD6_PHY_DQ_TIMING));
  1106		dev_dbg(mmc_dev(host->mmc), "SDHCI_CDNS_SD6_PHY_DLL_OBS_REG0 0x%x\n",
  1107			sdhci_cdns_sd6_read_phy_reg(priv,
  1108						    SDHCI_CDNS_SD6_PHY_DLL_OBS_REG0));
  1109		dev_dbg(mmc_dev(host->mmc), "SDHCI_CDNS_SD6_PHY_DLL_OBS_REG1 0x%x\n",
  1110			sdhci_cdns_sd6_read_phy_reg(priv,
  1111						    SDHCI_CDNS_SD6_PHY_DLL_OBS_REG1));
  1112		dev_dbg(mmc_dev(host->mmc), "SDHCI_CDNS_SD6_PHY_DLL_OBS_REG2 0x%x\n",
  1113			sdhci_cdns_sd6_read_phy_reg(priv,
  1114						    SDHCI_CDNS_SD6_PHY_DLL_OBS_REG2));
  1115	}
  1116	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
