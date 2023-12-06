Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D390F806355
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 01:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346571AbjLFAUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 19:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjLFAUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 19:20:04 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F901FA;
        Tue,  5 Dec 2023 16:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701822010; x=1733358010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h9K6AU4xHVERz83I4OcOX+bcHFvOTHS3L3ye/btbUfg=;
  b=mSLMocFJTuopHabJMHwjt2IqtAExNo3nTgjSBuzXwTjfjBmpmtst3fc4
   O89PblhhECdMEJODRhkPCfh0XQpaiM3RROhAgR0otX8FKPsz2sTFVe58n
   kDLNTDvquIiunD/Y3EhmTguGk5DFe8C67Zr2YhLHyBQa7CEC9c2sUstEU
   OKdaVneMIOCdof14l0kmcBJ7qEOd0fz7uP9vvPoEpVinjnlwd6KFr9z/o
   0T8/xDShmFx1SRdL+GfJxZQrlWdiubmJmN+04eHjvP2pSinAoYG8cYBnK
   sCr32zus8oeOwn5AcVAzVBIouQlaUr1WeVpYr01fIr8c5JL0r68/nzDfS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="425131127"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="425131127"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 16:20:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="800150425"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="800150425"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 05 Dec 2023 16:20:03 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAfdx-0009vc-02;
        Wed, 06 Dec 2023 00:20:01 +0000
Date:   Wed, 6 Dec 2023 08:19:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>,
        openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 13/16] net: stmmac: intel: Register generic MDIO
 device
Message-ID: <202312060845.lDDRDWET-lkp@intel.com>
References: <20231205103559.9605-14-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205103559.9605-14-fancer.lancer@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Serge,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Serge-Semin/net-pcs-xpcs-Drop-sentinel-entry-from-2500basex-ifaces-list/20231205-183808
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231205103559.9605-14-fancer.lancer%40gmail.com
patch subject: [PATCH net-next 13/16] net: stmmac: intel: Register generic MDIO device
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20231206/202312060845.lDDRDWET-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231206/202312060845.lDDRDWET-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312060845.lDDRDWET-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c: In function 'intel_mgbe_common_data':
>> drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c:646:31: error: 'clk' undeclared (first use in this function)
     646 |         clk_disable_unprepare(clk);
         |                               ^~~
   drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c:646:31: note: each undeclared identifier is reported only once for each function it appears in


vim +/clk +646 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c

   446	
   447	static int intel_mgbe_common_data(struct pci_dev *pdev,
   448					  struct plat_stmmacenet_data *plat)
   449	{
   450		struct fwnode_handle *fwnode;
   451		char clk_name[20];
   452		int ret;
   453		int i;
   454	
   455		plat->pdev = pdev;
   456		plat->phy_addr = -1;
   457		plat->clk_csr = 5;
   458		plat->has_gmac = 0;
   459		plat->has_gmac4 = 1;
   460		plat->force_sf_dma_mode = 0;
   461		plat->flags |= (STMMAC_FLAG_TSO_EN | STMMAC_FLAG_SPH_DISABLE);
   462	
   463		/* Multiplying factor to the clk_eee_i clock time
   464		 * period to make it closer to 100 ns. This value
   465		 * should be programmed such that the clk_eee_time_period *
   466		 * (MULT_FACT_100NS + 1) should be within 80 ns to 120 ns
   467		 * clk_eee frequency is 19.2Mhz
   468		 * clk_eee_time_period is 52ns
   469		 * 52ns * (1 + 1) = 104ns
   470		 * MULT_FACT_100NS = 1
   471		 */
   472		plat->mult_fact_100ns = 1;
   473	
   474		plat->rx_sched_algorithm = MTL_RX_ALGORITHM_SP;
   475	
   476		for (i = 0; i < plat->rx_queues_to_use; i++) {
   477			plat->rx_queues_cfg[i].mode_to_use = MTL_QUEUE_DCB;
   478			plat->rx_queues_cfg[i].chan = i;
   479	
   480			/* Disable Priority config by default */
   481			plat->rx_queues_cfg[i].use_prio = false;
   482	
   483			/* Disable RX queues routing by default */
   484			plat->rx_queues_cfg[i].pkt_route = 0x0;
   485		}
   486	
   487		for (i = 0; i < plat->tx_queues_to_use; i++) {
   488			plat->tx_queues_cfg[i].mode_to_use = MTL_QUEUE_DCB;
   489	
   490			/* Disable Priority config by default */
   491			plat->tx_queues_cfg[i].use_prio = false;
   492			/* Default TX Q0 to use TSO and rest TXQ for TBS */
   493			if (i > 0)
   494				plat->tx_queues_cfg[i].tbs_en = 1;
   495		}
   496	
   497		/* FIFO size is 4096 bytes for 1 tx/rx queue */
   498		plat->tx_fifo_size = plat->tx_queues_to_use * 4096;
   499		plat->rx_fifo_size = plat->rx_queues_to_use * 4096;
   500	
   501		plat->tx_sched_algorithm = MTL_TX_ALGORITHM_WRR;
   502		plat->tx_queues_cfg[0].weight = 0x09;
   503		plat->tx_queues_cfg[1].weight = 0x0A;
   504		plat->tx_queues_cfg[2].weight = 0x0B;
   505		plat->tx_queues_cfg[3].weight = 0x0C;
   506		plat->tx_queues_cfg[4].weight = 0x0D;
   507		plat->tx_queues_cfg[5].weight = 0x0E;
   508		plat->tx_queues_cfg[6].weight = 0x0F;
   509		plat->tx_queues_cfg[7].weight = 0x10;
   510	
   511		plat->dma_cfg->pbl = 32;
   512		plat->dma_cfg->pblx8 = true;
   513		plat->dma_cfg->fixed_burst = 0;
   514		plat->dma_cfg->mixed_burst = 0;
   515		plat->dma_cfg->aal = 0;
   516		plat->dma_cfg->dche = true;
   517	
   518		plat->axi = devm_kzalloc(&pdev->dev, sizeof(*plat->axi),
   519					 GFP_KERNEL);
   520		if (!plat->axi)
   521			return -ENOMEM;
   522	
   523		plat->axi->axi_lpi_en = 0;
   524		plat->axi->axi_xit_frm = 0;
   525		plat->axi->axi_wr_osr_lmt = 1;
   526		plat->axi->axi_rd_osr_lmt = 1;
   527		plat->axi->axi_blen[0] = 4;
   528		plat->axi->axi_blen[1] = 8;
   529		plat->axi->axi_blen[2] = 16;
   530	
   531		plat->ptp_max_adj = plat->clk_ptp_rate;
   532		plat->eee_usecs_rate = plat->clk_ptp_rate;
   533	
   534		/* Set system clock */
   535		sprintf(clk_name, "%s-%s", "stmmac", pci_name(pdev));
   536	
   537		plat->stmmac_clk = clk_register_fixed_rate(&pdev->dev,
   538							   clk_name, NULL, 0,
   539							   plat->clk_ptp_rate);
   540	
   541		if (IS_ERR(plat->stmmac_clk)) {
   542			dev_warn(&pdev->dev, "Fail to register stmmac-clk\n");
   543			plat->stmmac_clk = NULL;
   544		}
   545	
   546		ret = clk_prepare_enable(plat->stmmac_clk);
   547		if (ret) {
   548			clk_unregister_fixed_rate(plat->stmmac_clk);
   549			return ret;
   550		}
   551	
   552		plat->ptp_clk_freq_config = intel_mgbe_ptp_clk_freq_config;
   553	
   554		/* Set default value for multicast hash bins */
   555		plat->multicast_filter_bins = HASH_TABLE_SIZE;
   556	
   557		/* Set default value for unicast filter entries */
   558		plat->unicast_filter_entries = 1;
   559	
   560		/* Set the maxmtu to a default of JUMBO_LEN */
   561		plat->maxmtu = JUMBO_LEN;
   562	
   563		plat->flags |= STMMAC_FLAG_VLAN_FAIL_Q_EN;
   564	
   565		/* Use the last Rx queue */
   566		plat->vlan_fail_q = plat->rx_queues_to_use - 1;
   567	
   568		/* For fixed-link setup, we allow phy-mode setting */
   569		fwnode = dev_fwnode(&pdev->dev);
   570		if (fwnode) {
   571			int phy_mode;
   572	
   573			/* "phy-mode" setting is optional. If it is set,
   574			 *  we allow either sgmii or 1000base-x for now.
   575			 */
   576			phy_mode = fwnode_get_phy_mode(fwnode);
   577			if (phy_mode >= 0) {
   578				if (phy_mode == PHY_INTERFACE_MODE_SGMII ||
   579				    phy_mode == PHY_INTERFACE_MODE_1000BASEX)
   580					plat->phy_interface = phy_mode;
   581				else
   582					dev_warn(&pdev->dev, "Invalid phy-mode\n");
   583			}
   584		}
   585	
   586		/* Intel mgbe SGMII interface uses pcs-xcps */
   587		if (plat->phy_interface == PHY_INTERFACE_MODE_SGMII ||
   588		    plat->phy_interface == PHY_INTERFACE_MODE_1000BASEX) {
   589			struct mdio_board_info *xpcs_info;
   590	
   591			xpcs_info = devm_kzalloc(&pdev->dev,
   592						 sizeof(*xpcs_info) + MII_BUS_ID_SIZE,
   593						 GFP_KERNEL);
   594			if (!xpcs_info) {
   595				ret = -ENOMEM;
   596				goto err_alloc_info;
   597			}
   598	
   599			xpcs_info->bus_id = (void *)xpcs_info + sizeof(*xpcs_info);
   600			snprintf((char *)xpcs_info->bus_id, MII_BUS_ID_SIZE,
   601				 "stmmac-%x", plat->bus_id);
   602	
   603			snprintf(xpcs_info->modalias, MDIO_NAME_SIZE, "dwxpcs");
   604	
   605			xpcs_info->mdio_addr = INTEL_MGBE_XPCS_ADDR;
   606	
   607			ret = mdiobus_register_board_info(xpcs_info, 1);
   608			if (ret)
   609				goto err_alloc_info;
   610	
   611			plat->mdio_bus_data->has_xpcs = true;
   612			plat->mdio_bus_data->xpcs_an_inband = true;
   613		}
   614	
   615		/* For fixed-link setup, we clear xpcs_an_inband */
   616		if (fwnode) {
   617			struct fwnode_handle *fixed_node;
   618	
   619			fixed_node = fwnode_get_named_child_node(fwnode, "fixed-link");
   620			if (fixed_node)
   621				plat->mdio_bus_data->xpcs_an_inband = false;
   622	
   623			fwnode_handle_put(fixed_node);
   624		}
   625	
   626		/* Ensure mdio bus PHY-scan skips intel serdes and pcs-xpcs */
   627		plat->mdio_bus_data->phy_mask = 1 << INTEL_MGBE_ADHOC_ADDR;
   628		plat->mdio_bus_data->phy_mask |= 1 << INTEL_MGBE_XPCS_ADDR;
   629	
   630		plat->int_snapshot_num = AUX_SNAPSHOT1;
   631	
   632		plat->crosststamp = intel_crosststamp;
   633		plat->flags &= ~STMMAC_FLAG_INT_SNAPSHOT_EN;
   634	
   635		/* Setup MSI vector offset specific to Intel mGbE controller */
   636		plat->msi_mac_vec = 29;
   637		plat->msi_lpi_vec = 28;
   638		plat->msi_sfty_ce_vec = 27;
   639		plat->msi_sfty_ue_vec = 26;
   640		plat->msi_rx_base_vec = 0;
   641		plat->msi_tx_base_vec = 1;
   642	
   643		return 0;
   644	
   645	err_alloc_info:
 > 646		clk_disable_unprepare(clk);
   647		clk_unregister_fixed_rate(clk);
   648	
   649		return ret;
   650	}
   651	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
