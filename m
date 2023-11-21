Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7057F2CF8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbjKUMTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbjKUMTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:19:08 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F0518A;
        Tue, 21 Nov 2023 04:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700569144; x=1732105144;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TH4Q5+J9vXx35s84udmwuHt+PL6CcAyQU4u+aC3JSRs=;
  b=dMcB1hlR1wJcjf/s8t4D3iymcM86Cr+D8/VwdhZaeM8L7vsUi5EqyK5l
   1+FZqbpzCvE15GKfWI2vYJDmFIF2UcN18JD7IStsNRT7Q2YFfZYquh/ho
   IVFlffXHjUUGZqy8Jzhtl11r+P+bzrK69+j84S+rQpBVPjnyH/oRAB+dW
   ZtON1K+9g+5834pYEYCkj+vWfV0g6m+WGhgA3KnUT+w01kpzPVw9EL6Zq
   9qftgb729h3NNTACEZHkEEfY3DaKFf3IP7XGfHLyIutThQZ3Hvygh/O1L
   71vSREvIqxfGiLWF5Ps4S0jj0TN41RQ8TdpskHXUIG9XjEQOzWctcw4AQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="458325779"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="458325779"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 04:19:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="1098043400"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="1098043400"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 21 Nov 2023 04:18:57 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5PiP-0007mU-29;
        Tue, 21 Nov 2023 12:18:54 +0000
Date:   Tue, 21 Nov 2023 20:18:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Romain Gantois <romain.gantois@bootlin.com>, davem@davemloft.net,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Romain Gantois <romain.gantois@bootlin.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH net-next v3 4/8] net: qualcomm: ipqess: Add Ethtool ops
 to IPQESS port netdevices
Message-ID: <202311211930.FOMUSlbU-lkp@intel.com>
References: <20231114105600.1012056-5-romain.gantois@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114105600.1012056-5-romain.gantois@bootlin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Romain,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Romain-Gantois/dt-bindings-net-Introduce-the-Qualcomm-IPQESS-Ethernet-switch/20231114-185953
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231114105600.1012056-5-romain.gantois%40bootlin.com
patch subject: [PATCH net-next v3 4/8] net: qualcomm: ipqess: Add Ethtool ops to IPQESS port netdevices
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20231121/202311211930.FOMUSlbU-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231121/202311211930.FOMUSlbU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311211930.FOMUSlbU-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/qualcomm/ipqess/ipqess_ethtool.c:165:10: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
     165 |                 return ret;
         |                        ^~~
   drivers/net/ethernet/qualcomm/ipqess/ipqess_ethtool.c:152:9: note: initialize the variable 'ret' to silence this warning
     152 |         int ret;
         |                ^
         |                 = 0
   1 warning generated.


vim +/ret +165 drivers/net/ethernet/qualcomm/ipqess/ipqess_ethtool.c

   148	
   149	static int ipqess_port_set_eee(struct net_device *dev, struct ethtool_eee *eee)
   150	{
   151		struct ipqess_port *port = netdev_priv(dev);
   152		int ret;
   153		u32 lpi_en = QCA8K_REG_EEE_CTRL_LPI_EN(port->index);
   154		struct qca8k_priv *priv = port->sw->priv;
   155		u32 lpi_ctl1;
   156	
   157		/* Port's PHY and MAC both need to be EEE capable */
   158		if (!dev->phydev || !port->pl)
   159			return -ENODEV;
   160	
   161		mutex_lock(&priv->reg_mutex);
   162		lpi_ctl1 = qca8k_read(priv, QCA8K_REG_EEE_CTRL, &lpi_ctl1);
   163		if (lpi_ctl1 < 0) {
   164			mutex_unlock(&priv->reg_mutex);
 > 165			return ret;
   166		}
   167	
   168		if (eee->tx_lpi_enabled && eee->eee_enabled)
   169			lpi_ctl1 |= lpi_en;
   170		else
   171			lpi_ctl1 &= ~lpi_en;
   172		ret = qca8k_write(priv, QCA8K_REG_EEE_CTRL, lpi_ctl1);
   173		mutex_unlock(&priv->reg_mutex);
   174	
   175		if (ret)
   176			return ret;
   177	
   178		return phylink_ethtool_set_eee(port->pl, eee);
   179	}
   180	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
