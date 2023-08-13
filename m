Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D195677A579
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 09:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjHMHqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 03:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjHMHqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 03:46:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A8B10C4;
        Sun, 13 Aug 2023 00:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691912798; x=1723448798;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JqUSAouNuTXGholsD7n1iikOYHXBNqoBCtLW8vOTh6w=;
  b=hB8P2aN4SKi0mG413UyjVwtDS3R9VUcjv8JG1sYZ0gfCx1sWWiA25RA6
   27Cq9bXpjPaMYdWEgxkT40ni8aEtY3ZKb4e7X+VXdYaigvw3iRbB51BpS
   8ZzbrILmEHTcHN+JbGa10JZDkuBMnMxJBeILXRjWqG39+5hzxGplmX3rh
   Zk7jhWDDe7TH016xaElJRE1VzswFRmqpfjvvrYHPz0IRIroAip9LuVEuL
   iF21awSnicWrE0qh6I5HFJMpXtvnQlWmZ7EtATA330d9n4ro7jaxu9Jnp
   z95uPOms6C/zuHqgcvcbSf8JxxoVJERwf1BxTlGDpxKAtQJqOxViVOsSv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10800"; a="458242879"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="458242879"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2023 00:46:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10800"; a="733102527"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="733102527"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 13 Aug 2023 00:46:33 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qV5o0-00090O-2q;
        Sun, 13 Aug 2023 07:46:32 +0000
Date:   Sun, 13 Aug 2023 15:45:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Roger Quadros <rogerq@kernel.org>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        vladimir.oltean@nxp.com
Cc:     oe-kbuild-all@lists.linux.dev, s-vadapalli@ti.com, srk@ti.com,
        vigneshr@ti.com, p-varis@ti.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH v2] net: ethernet: ti: am65-cpsw-qos: Add Frame
 Preemption MAC Merge support
Message-ID: <202308131536.NSsIpOzG-lkp@intel.com>
References: <20230810152538.138718-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810152538.138718-1-rogerq@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]
[also build test WARNING on net/main linus/master v6.5-rc5 next-20230809]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Roger-Quadros/net-ethernet-ti-am65-cpsw-qos-Add-Frame-Preemption-MAC-Merge-support/20230810-232714
base:   net-next/main
patch link:    https://lore.kernel.org/r/20230810152538.138718-1-rogerq%40kernel.org
patch subject: [PATCH v2] net: ethernet: ti: am65-cpsw-qos: Add Frame Preemption MAC Merge support
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20230813/202308131536.NSsIpOzG-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230813/202308131536.NSsIpOzG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308131536.NSsIpOzG-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/ti/am65-cpsw-ethtool.c: In function 'am65_cpsw_get_mm':
>> drivers/net/ethernet/ti/am65-cpsw-ethtool.c:749:56: warning: variable 'verify_cnt' set but not used [-Wunused-but-set-variable]
     749 |         u32 port_ctrl, cmn_ctrl, iet_ctrl, iet_status, verify_cnt;
         |                                                        ^~~~~~~~~~
>> drivers/net/ethernet/ti/am65-cpsw-ethtool.c:749:24: warning: variable 'cmn_ctrl' set but not used [-Wunused-but-set-variable]
     749 |         u32 port_ctrl, cmn_ctrl, iet_ctrl, iet_status, verify_cnt;
         |                        ^~~~~~~~
--
>> drivers/net/ethernet/ti/am65-cpsw-qos.c:196:6: warning: no previous prototype for 'am65_cpsw_iet_change_preemptible_tcs' [-Wmissing-prototypes]
     196 | void am65_cpsw_iet_change_preemptible_tcs(struct am65_cpsw_port *port, u8 preemptible_tcs)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/ti/am65-cpsw-qos.c:202:6: warning: no previous prototype for 'am65_cpsw_iet_link_state_update' [-Wmissing-prototypes]
     202 | void am65_cpsw_iet_link_state_update(struct net_device *ndev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/verify_cnt +749 drivers/net/ethernet/ti/am65-cpsw-ethtool.c

   745	
   746	static int am65_cpsw_get_mm(struct net_device *ndev, struct ethtool_mm_state *state)
   747	{
   748		struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
 > 749		u32 port_ctrl, cmn_ctrl, iet_ctrl, iet_status, verify_cnt;
   750		struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
   751		struct am65_cpsw_ndev_priv *priv = netdev_priv(ndev);
   752		u32 add_frag_size;
   753	
   754		mutex_lock(&priv->mm_lock);
   755	
   756		iet_ctrl = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
   757		cmn_ctrl = readl(common->cpsw_base + AM65_CPSW_REG_CTL);
   758		port_ctrl = readl(port->port_base + AM65_CPSW_PN_REG_CTL);
   759	
   760		state->tx_enabled = !!(iet_ctrl & AM65_CPSW_PN_IET_MAC_PENABLE);
   761		state->pmac_enabled = !!(port_ctrl & AM65_CPSW_PN_CTL_IET_PORT_EN);
   762	
   763		iet_status = readl(port->port_base + AM65_CPSW_PN_REG_IET_STATUS);
   764	
   765		if (iet_ctrl & AM65_CPSW_PN_IET_MAC_DISABLEVERIFY)
   766			state->verify_status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
   767		else if (iet_status & AM65_CPSW_PN_MAC_VERIFIED)
   768			state->verify_status = ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED;
   769		else if (iet_status & AM65_CPSW_PN_MAC_VERIFY_FAIL)
   770			state->verify_status = ETHTOOL_MM_VERIFY_STATUS_FAILED;
   771		else
   772			state->verify_status = ETHTOOL_MM_VERIFY_STATUS_UNKNOWN;
   773	
   774		add_frag_size = AM65_CPSW_PN_IET_MAC_GET_ADDFRAGSIZE(iet_ctrl);
   775		state->tx_min_frag_size = ethtool_mm_frag_size_add_to_min(add_frag_size);
   776	
   777		/* Errata i2208: RX min fragment size cannot be less than 124 */
   778		state->rx_min_frag_size = 124;
   779	
   780		/* FPE active if common tx_enabled and verification success or disabled (forced) */
   781		state->tx_active = state->tx_enabled &&
   782				   (state->verify_status == ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED ||
   783				    state->verify_status == ETHTOOL_MM_VERIFY_STATUS_DISABLED);
   784		state->verify_enabled = !(iet_ctrl & AM65_CPSW_PN_IET_MAC_DISABLEVERIFY);
   785	
   786		verify_cnt = AM65_CPSW_PN_MAC_GET_VERIFY_CNT(readl(port->port_base +
   787								   AM65_CPSW_PN_REG_IET_VERIFY));
   788		state->verify_time = port->qos.iet.verify_time_ms;
   789		state->max_verify_time = am65_cpsw_iet_get_verify_timeout_ms(AM65_CPSW_PN_MAC_VERIFY_CNT_MASK,
   790									     port);
   791		mutex_unlock(&priv->mm_lock);
   792	
   793		return 0;
   794	}
   795	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
