Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E86475D5C8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 22:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjGUUbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 16:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjGUUb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 16:31:29 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABF81FD2;
        Fri, 21 Jul 2023 13:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689971486; x=1721507486;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xych12fXAllQmfKXQOtduucuGRdzVWia+wDdseBLe4E=;
  b=PDfOfxjioxfxKPyAAPpyAtz9YU/ZwvwcaODR3q2mO1lMsiHgeBNcx7a/
   6CUxWMW5vGe28pKEmApkvkN6XFSRsYme8Dxb382miXSO7WSJziAVxZEss
   egaB6l2txffrXA9ErRlXYoldB5IS7dpeQzzWFo8m382+mRZoBb/YdjtOX
   jmf1hFVR3Z1I1wAeLAs7CwE4M530oDdk6wrn6S2u4Tzy5vT6rjIrWcTKp
   TlI5FEb2TTWZ+M9F4/GLuvHUXehEixjgBBbpNXQqhMMht9bptzJ0LHU/O
   OlLTwoyKgxICgbak8OYCfkkuAk5Oc727DWdVbm/msz/j3m3NCceTMCjqW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="430905729"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="430905729"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 13:31:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="728224177"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="728224177"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 21 Jul 2023 13:31:21 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qMwmW-0007dx-0p;
        Fri, 21 Jul 2023 20:31:20 +0000
Date:   Sat, 22 Jul 2023 04:31:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marco Felsch <m.felsch@pengutronix.de>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, peppe.cavallaro@st.com,
        alexandre.torgue@foss.st.com, joabreu@synopsys.com,
        mcoquelin.stm32@gmail.com
Cc:     oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v3 2/2] net: stmmac: add support for phy-supply
Message-ID: <202307220459.2gaQtSqH-lkp@intel.com>
References: <20230720072304.3358701-2-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720072304.3358701-2-m.felsch@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Marco-Felsch/net-stmmac-add-support-for-phy-supply/20230720-152642
base:   net-next/main
patch link:    https://lore.kernel.org/r/20230720072304.3358701-2-m.felsch%40pengutronix.de
patch subject: [PATCH net-next v3 2/2] net: stmmac: add support for phy-supply
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20230722/202307220459.2gaQtSqH-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230722/202307220459.2gaQtSqH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307220459.2gaQtSqH-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c: In function 'stmmac_suspend':
>> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:7706:32: error: 'struct plat_stmmacenet_data' has no member named 'use_phy_wol'
    7706 |                 if (!priv->plat->use_phy_wol)
         |                                ^~
   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c: In function 'stmmac_resume':
   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:7790:32: error: 'struct plat_stmmacenet_data' has no member named 'use_phy_wol'
    7790 |                 if (!priv->plat->use_phy_wol)
         |                                ^~


vim +7706 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

  7651	
  7652	/**
  7653	 * stmmac_suspend - suspend callback
  7654	 * @dev: device pointer
  7655	 * Description: this is the function to suspend the device and it is called
  7656	 * by the platform driver to stop the network queue, release the resources,
  7657	 * program the PMT register (for WoL), clean and release driver resources.
  7658	 */
  7659	int stmmac_suspend(struct device *dev)
  7660	{
  7661		struct net_device *ndev = dev_get_drvdata(dev);
  7662		struct stmmac_priv *priv = netdev_priv(ndev);
  7663		u32 chan;
  7664	
  7665		if (!ndev || !netif_running(ndev))
  7666			return 0;
  7667	
  7668		mutex_lock(&priv->lock);
  7669	
  7670		netif_device_detach(ndev);
  7671	
  7672		stmmac_disable_all_queues(priv);
  7673	
  7674		for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
  7675			hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
  7676	
  7677		if (priv->eee_enabled) {
  7678			priv->tx_path_in_lpi_mode = false;
  7679			del_timer_sync(&priv->eee_ctrl_timer);
  7680		}
  7681	
  7682		/* Stop TX/RX DMA */
  7683		stmmac_stop_all_dma(priv);
  7684	
  7685		if (priv->plat->serdes_powerdown)
  7686			priv->plat->serdes_powerdown(ndev, priv->plat->bsp_priv);
  7687	
  7688		/* Enable Power down mode by programming the PMT regs */
  7689		if (device_may_wakeup(priv->device) && priv->plat->pmt) {
  7690			stmmac_pmt(priv, priv->hw, priv->wolopts);
  7691			priv->irq_wake = 1;
  7692		} else {
  7693			stmmac_mac_set(priv, priv->ioaddr, false);
  7694			pinctrl_pm_select_sleep_state(priv->device);
  7695		}
  7696	
  7697		mutex_unlock(&priv->lock);
  7698	
  7699		rtnl_lock();
  7700		if (device_may_wakeup(priv->device) && priv->plat->pmt) {
  7701			phylink_suspend(priv->phylink, true);
  7702		} else {
  7703			if (device_may_wakeup(priv->device))
  7704				phylink_speed_down(priv->phylink, false);
  7705			phylink_suspend(priv->phylink, false);
> 7706			if (!priv->plat->use_phy_wol)
  7707				stmmac_phy_power_off(priv);
  7708		}
  7709		rtnl_unlock();
  7710	
  7711		if (priv->dma_cap.fpesel) {
  7712			/* Disable FPE */
  7713			stmmac_fpe_configure(priv, priv->ioaddr,
  7714					     priv->plat->tx_queues_to_use,
  7715					     priv->plat->rx_queues_to_use, false);
  7716	
  7717			stmmac_fpe_handshake(priv, false);
  7718			stmmac_fpe_stop_wq(priv);
  7719		}
  7720	
  7721		priv->speed = SPEED_UNKNOWN;
  7722		return 0;
  7723	}
  7724	EXPORT_SYMBOL_GPL(stmmac_suspend);
  7725	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
