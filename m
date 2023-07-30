Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C2C768634
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 17:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjG3P1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 11:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjG3P1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 11:27:30 -0400
Received: from mgamail.intel.com (unknown [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451C7171F
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 08:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690730848; x=1722266848;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qKL6AV/RJuaeynuX1l+RCD0edE24l5muTqMBrmTwkMw=;
  b=KM/RFiJ4vwgf0ktUUDHxXxEcWIENRIVtPX6xwJYpQRxhDBGVsqSWPqaQ
   DSjGnYSVdgO7e9FNDgIz0HaF6JHQLr/Pk6+63ljk5ROTR9VJMW4TiGs2w
   KVX9ocKPC5/hB+ma41k8i3gXuHVCSNNJZK1RcGXrrpH+ihj49Fa8+KCsw
   evkBSQqZ/ekXzZ8/SZ3VeKlEXUSWenHRRqwFw39I4y5DI5KhIRBjmMiGa
   rWSdzf18mWoVxlxPrhYODUv3mDCGhGgkvL0suzL9w4LaL89SflxBkhmjw
   gi6mnnYU/ZN4SsDaxlRgxFa2gmYy+KsB5iyZcDuXIezQBZommrT1Q9+96
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="349154052"
X-IronPort-AV: E=Sophos;i="6.01,242,1684825200"; 
   d="scan'208";a="349154052"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2023 08:27:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="851770570"
X-IronPort-AV: E=Sophos;i="6.01,242,1684825200"; 
   d="scan'208";a="851770570"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 30 Jul 2023 08:27:26 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qQ8KL-0004eF-1K;
        Sun, 30 Jul 2023 15:27:25 +0000
Date:   Sun, 30 Jul 2023 23:26:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: drivers/net/ethernet/intel/i40e/i40e_main.c:16227:1: warning: the
 frame size of 1032 bytes is larger than 1024 bytes
Message-ID: <202307302339.4WcgJQA7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d31e3792919e5c97d572c8a27a5a7c1eb9de5aca
commit: c27cd083cfb9d392f304657ed00fcde1136704e7 Compiler attributes: GCC cold function alignment workarounds
date:   6 months ago
config: x86_64-intel-next-customedconfig-intel_next_rpm_defconfig (https://download.01.org/0day-ci/archive/20230730/202307302339.4WcgJQA7-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230730/202307302339.4WcgJQA7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307302339.4WcgJQA7-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/intel/i40e/i40e_main.c: In function 'i40e_probe.part.0':
>> drivers/net/ethernet/intel/i40e/i40e_main.c:16227:1: warning: the frame size of 1032 bytes is larger than 1024 bytes [-Wframe-larger-than=]
   16227 | }
         | ^


vim +16227 drivers/net/ethernet/intel/i40e/i40e_main.c

41c445ff0f482b Jesse Brandeburg        2013-09-11  16075  
e3219ce6a77546 Anjali Singhai Jain     2016-01-20  16076  	if (pf->flags & I40E_FLAG_IWARP_ENABLED) {
e3219ce6a77546 Anjali Singhai Jain     2016-01-20  16077  		pf->iwarp_base_vector = i40e_get_lump(pf, pf->irq_pile,
e3219ce6a77546 Anjali Singhai Jain     2016-01-20  16078  						      pf->num_iwarp_msix,
e3219ce6a77546 Anjali Singhai Jain     2016-01-20  16079  						      I40E_IWARP_IRQ_PILE_ID);
e3219ce6a77546 Anjali Singhai Jain     2016-01-20  16080  		if (pf->iwarp_base_vector < 0) {
e3219ce6a77546 Anjali Singhai Jain     2016-01-20  16081  			dev_info(&pdev->dev,
e3219ce6a77546 Anjali Singhai Jain     2016-01-20  16082  				 "failed to get tracking for %d vectors for IWARP err=%d\n",
e3219ce6a77546 Anjali Singhai Jain     2016-01-20  16083  				 pf->num_iwarp_msix, pf->iwarp_base_vector);
e3219ce6a77546 Anjali Singhai Jain     2016-01-20  16084  			pf->flags &= ~I40E_FLAG_IWARP_ENABLED;
e3219ce6a77546 Anjali Singhai Jain     2016-01-20  16085  		}
e3219ce6a77546 Anjali Singhai Jain     2016-01-20  16086  	}
93cd765bb27365 Anjali Singhai Jain     2013-11-20  16087  
41c445ff0f482b Jesse Brandeburg        2013-09-11  16088  	i40e_dbg_pf_init(pf);
41c445ff0f482b Jesse Brandeburg        2013-09-11  16089  
41c445ff0f482b Jesse Brandeburg        2013-09-11  16090  	/* tell the firmware that we're starting */
44033fac14340f Jesse Brandeburg        2014-04-23  16091  	i40e_send_version(pf);
41c445ff0f482b Jesse Brandeburg        2013-09-11  16092  
41c445ff0f482b Jesse Brandeburg        2013-09-11  16093  	/* since everything's happy, start the service_task timer */
41c445ff0f482b Jesse Brandeburg        2013-09-11  16094  	mod_timer(&pf->service_timer,
41c445ff0f482b Jesse Brandeburg        2013-09-11  16095  		  round_jiffies(jiffies + pf->service_timer_period));
41c445ff0f482b Jesse Brandeburg        2013-09-11  16096  
e3219ce6a77546 Anjali Singhai Jain     2016-01-20  16097  	/* add this PF to client device list and launch a client service task */
004eb614c4d2fc Mitch Williams          2017-04-04  16098  	if (pf->flags & I40E_FLAG_IWARP_ENABLED) {
e3219ce6a77546 Anjali Singhai Jain     2016-01-20  16099  		err = i40e_lan_add_device(pf);
e3219ce6a77546 Anjali Singhai Jain     2016-01-20  16100  		if (err)
e3219ce6a77546 Anjali Singhai Jain     2016-01-20  16101  			dev_info(&pdev->dev, "Failed to add PF to client API service list: %d\n",
e3219ce6a77546 Anjali Singhai Jain     2016-01-20  16102  				 err);
004eb614c4d2fc Mitch Williams          2017-04-04  16103  	}
e3219ce6a77546 Anjali Singhai Jain     2016-01-20  16104  
3fced535079a6a Anjali Singhai Jain     2015-09-03  16105  #define PCI_SPEED_SIZE 8
3fced535079a6a Anjali Singhai Jain     2015-09-03  16106  #define PCI_WIDTH_SIZE 8
3fced535079a6a Anjali Singhai Jain     2015-09-03  16107  	/* Devices on the IOSF bus do not have this information
3fced535079a6a Anjali Singhai Jain     2015-09-03  16108  	 * and will report PCI Gen 1 x 1 by default so don't bother
3fced535079a6a Anjali Singhai Jain     2015-09-03  16109  	 * checking them.
3fced535079a6a Anjali Singhai Jain     2015-09-03  16110  	 */
d36e41dc78d313 Jacob Keller            2017-06-23  16111  	if (!(pf->hw_features & I40E_HW_NO_PCI_LINK_CHECK)) {
3fced535079a6a Anjali Singhai Jain     2015-09-03  16112  		char speed[PCI_SPEED_SIZE] = "Unknown";
3fced535079a6a Anjali Singhai Jain     2015-09-03  16113  		char width[PCI_WIDTH_SIZE] = "Unknown";
3fced535079a6a Anjali Singhai Jain     2015-09-03  16114  
3fced535079a6a Anjali Singhai Jain     2015-09-03  16115  		/* Get the negotiated link width and speed from PCI config
3fced535079a6a Anjali Singhai Jain     2015-09-03  16116  		 * space
3fced535079a6a Anjali Singhai Jain     2015-09-03  16117  		 */
3fced535079a6a Anjali Singhai Jain     2015-09-03  16118  		pcie_capability_read_word(pf->pdev, PCI_EXP_LNKSTA,
3fced535079a6a Anjali Singhai Jain     2015-09-03  16119  					  &link_status);
d4dfb81af79496 Catherine Sullivan      2013-11-28  16120  
d4dfb81af79496 Catherine Sullivan      2013-11-28  16121  		i40e_set_pci_config_data(hw, link_status);
d4dfb81af79496 Catherine Sullivan      2013-11-28  16122  
3fced535079a6a Anjali Singhai Jain     2015-09-03  16123  		switch (hw->bus.speed) {
3fced535079a6a Anjali Singhai Jain     2015-09-03  16124  		case i40e_bus_speed_8000:
f029c781dd6d8e Wolfram Sang            2022-08-30  16125  			strscpy(speed, "8.0", PCI_SPEED_SIZE); break;
3fced535079a6a Anjali Singhai Jain     2015-09-03  16126  		case i40e_bus_speed_5000:
f029c781dd6d8e Wolfram Sang            2022-08-30  16127  			strscpy(speed, "5.0", PCI_SPEED_SIZE); break;
3fced535079a6a Anjali Singhai Jain     2015-09-03  16128  		case i40e_bus_speed_2500:
f029c781dd6d8e Wolfram Sang            2022-08-30  16129  			strscpy(speed, "2.5", PCI_SPEED_SIZE); break;
3fced535079a6a Anjali Singhai Jain     2015-09-03  16130  		default:
3fced535079a6a Anjali Singhai Jain     2015-09-03  16131  			break;
3fced535079a6a Anjali Singhai Jain     2015-09-03  16132  		}
3fced535079a6a Anjali Singhai Jain     2015-09-03  16133  		switch (hw->bus.width) {
3fced535079a6a Anjali Singhai Jain     2015-09-03  16134  		case i40e_bus_width_pcie_x8:
f029c781dd6d8e Wolfram Sang            2022-08-30  16135  			strscpy(width, "8", PCI_WIDTH_SIZE); break;
3fced535079a6a Anjali Singhai Jain     2015-09-03  16136  		case i40e_bus_width_pcie_x4:
f029c781dd6d8e Wolfram Sang            2022-08-30  16137  			strscpy(width, "4", PCI_WIDTH_SIZE); break;
3fced535079a6a Anjali Singhai Jain     2015-09-03  16138  		case i40e_bus_width_pcie_x2:
f029c781dd6d8e Wolfram Sang            2022-08-30  16139  			strscpy(width, "2", PCI_WIDTH_SIZE); break;
3fced535079a6a Anjali Singhai Jain     2015-09-03  16140  		case i40e_bus_width_pcie_x1:
f029c781dd6d8e Wolfram Sang            2022-08-30  16141  			strscpy(width, "1", PCI_WIDTH_SIZE); break;
3fced535079a6a Anjali Singhai Jain     2015-09-03  16142  		default:
3fced535079a6a Anjali Singhai Jain     2015-09-03  16143  			break;
3fced535079a6a Anjali Singhai Jain     2015-09-03  16144  		}
3fced535079a6a Anjali Singhai Jain     2015-09-03  16145  
3fced535079a6a Anjali Singhai Jain     2015-09-03  16146  		dev_info(&pdev->dev, "PCI-Express: Speed %sGT/s Width x%s\n",
3fced535079a6a Anjali Singhai Jain     2015-09-03  16147  			 speed, width);
d4dfb81af79496 Catherine Sullivan      2013-11-28  16148  
d4dfb81af79496 Catherine Sullivan      2013-11-28  16149  		if (hw->bus.width < i40e_bus_width_pcie_x8 ||
d4dfb81af79496 Catherine Sullivan      2013-11-28  16150  		    hw->bus.speed < i40e_bus_speed_8000) {
d4dfb81af79496 Catherine Sullivan      2013-11-28  16151  			dev_warn(&pdev->dev, "PCI-Express bandwidth available for this device may be insufficient for optimal performance.\n");
d4dfb81af79496 Catherine Sullivan      2013-11-28  16152  			dev_warn(&pdev->dev, "Please move the device to a different PCI-e link with more lanes and/or higher transfer rate.\n");
d4dfb81af79496 Catherine Sullivan      2013-11-28  16153  		}
3fced535079a6a Anjali Singhai Jain     2015-09-03  16154  	}
d4dfb81af79496 Catherine Sullivan      2013-11-28  16155  
e827845c7deefb Catherine Sullivan      2015-02-06  16156  	/* get the requested speeds from the fw */
e827845c7deefb Catherine Sullivan      2015-02-06  16157  	err = i40e_aq_get_phy_capabilities(hw, false, false, &abilities, NULL);
e827845c7deefb Catherine Sullivan      2015-02-06  16158  	if (err)
8279e49531f427 Neerav Parikh           2015-09-03  16159  		dev_dbg(&pf->pdev->dev, "get requested speeds ret =  %s last_status =  %s\n",
f1c7e72e390391 Shannon Nelson          2015-06-04  16160  			i40e_stat_str(&pf->hw, err),
f1c7e72e390391 Shannon Nelson          2015-06-04  16161  			i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
e827845c7deefb Catherine Sullivan      2015-02-06  16162  	pf->hw.phy.link_info.requested_speeds = abilities.link_speed;
e827845c7deefb Catherine Sullivan      2015-02-06  16163  
1d96340196f1ee Damian Dybek            2018-12-19  16164  	/* set the FEC config due to the board capabilities */
1d96340196f1ee Damian Dybek            2018-12-19  16165  	i40e_set_fec_in_flags(abilities.fec_cfg_curr_mod_ext_info, &pf->flags);
1d96340196f1ee Damian Dybek            2018-12-19  16166  
fc72dbce09989b Catherine Sullivan      2015-09-01  16167  	/* get the supported phy types from the fw */
fc72dbce09989b Catherine Sullivan      2015-09-01  16168  	err = i40e_aq_get_phy_capabilities(hw, false, true, &abilities, NULL);
fc72dbce09989b Catherine Sullivan      2015-09-01  16169  	if (err)
fc72dbce09989b Catherine Sullivan      2015-09-01  16170  		dev_dbg(&pf->pdev->dev, "get supported phy types ret =  %s last_status =  %s\n",
fc72dbce09989b Catherine Sullivan      2015-09-01  16171  			i40e_stat_str(&pf->hw, err),
fc72dbce09989b Catherine Sullivan      2015-09-01  16172  			i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
fc72dbce09989b Catherine Sullivan      2015-09-01  16173  
3a2c6ced90e183 Todd Fujinaka           2020-05-28  16174  	/* make sure the MFS hasn't been set lower than the default */
3a2c6ced90e183 Todd Fujinaka           2020-05-28  16175  #define MAX_FRAME_SIZE_DEFAULT 0x2600
3a2c6ced90e183 Todd Fujinaka           2020-05-28  16176  	val = (rd32(&pf->hw, I40E_PRTGL_SAH) &
3a2c6ced90e183 Todd Fujinaka           2020-05-28  16177  	       I40E_PRTGL_SAH_MFS_MASK) >> I40E_PRTGL_SAH_MFS_SHIFT;
3a2c6ced90e183 Todd Fujinaka           2020-05-28  16178  	if (val < MAX_FRAME_SIZE_DEFAULT)
3a2c6ced90e183 Todd Fujinaka           2020-05-28  16179  		dev_warn(&pdev->dev, "MFS for port %x has been set below the default: %x\n",
3a2c6ced90e183 Todd Fujinaka           2020-05-28  16180  			 i, val);
3a2c6ced90e183 Todd Fujinaka           2020-05-28  16181  
e7358f54a3954d Anjali Singhai Jain     2015-10-01  16182  	/* Add a filter to drop all Flow control frames from any VSI from being
e7358f54a3954d Anjali Singhai Jain     2015-10-01  16183  	 * transmitted. By doing so we stop a malicious VF from sending out
e7358f54a3954d Anjali Singhai Jain     2015-10-01  16184  	 * PAUSE or PFC frames and potentially controlling traffic for other
e7358f54a3954d Anjali Singhai Jain     2015-10-01  16185  	 * PF/VF VSIs.
e7358f54a3954d Anjali Singhai Jain     2015-10-01  16186  	 * The FW can still send Flow control frames if enabled.
e7358f54a3954d Anjali Singhai Jain     2015-10-01  16187  	 */
e7358f54a3954d Anjali Singhai Jain     2015-10-01  16188  	i40e_add_filter_to_drop_tx_flow_control_frames(&pf->hw,
e7358f54a3954d Anjali Singhai Jain     2015-10-01  16189  						       pf->main_vsi_seid);
e7358f54a3954d Anjali Singhai Jain     2015-10-01  16190  
31b606d0c40a14 Carolyn Wyborny         2016-02-17  16191  	if ((pf->hw.device_id == I40E_DEV_ID_10G_BASE_T) ||
31b606d0c40a14 Carolyn Wyborny         2016-02-17  16192  		(pf->hw.device_id == I40E_DEV_ID_10G_BASE_T4))
d36e41dc78d313 Jacob Keller            2017-06-23  16193  		pf->hw_features |= I40E_HW_PHY_CONTROLS_LEDS;
4ad9f4f9e2873c Harshitha Ramamurthy    2016-11-08  16194  	if (pf->hw.device_id == I40E_DEV_ID_SFP_I_X722)
d36e41dc78d313 Jacob Keller            2017-06-23  16195  		pf->hw_features |= I40E_HW_HAVE_CRT_RETIMER;
0c22b3dd68a67e Jesse Brandeburg        2014-02-11  16196  	/* print a string summarizing features */
0c22b3dd68a67e Jesse Brandeburg        2014-02-11  16197  	i40e_print_features(pf);
0c22b3dd68a67e Jesse Brandeburg        2014-02-11  16198  
41c445ff0f482b Jesse Brandeburg        2013-09-11  16199  	return 0;
41c445ff0f482b Jesse Brandeburg        2013-09-11  16200  
41c445ff0f482b Jesse Brandeburg        2013-09-11  16201  	/* Unwind what we've done if something failed in the setup */
41c445ff0f482b Jesse Brandeburg        2013-09-11  16202  err_vsis:
9e6c9c0f2ce675 Mauro S. M. Rodrigues   2017-05-12  16203  	set_bit(__I40E_DOWN, pf->state);
41c445ff0f482b Jesse Brandeburg        2013-09-11  16204  	i40e_clear_interrupt_scheme(pf);
41c445ff0f482b Jesse Brandeburg        2013-09-11  16205  	kfree(pf->vsi);
04b03013a52517 Shannon Nelson          2013-11-28  16206  err_switch_setup:
04b03013a52517 Shannon Nelson          2013-11-28  16207  	i40e_reset_interrupt_capability(pf);
292a089d78d3e2 Steven Rostedt (Google  2022-12-20  16208) 	timer_shutdown_sync(&pf->service_timer);
41c445ff0f482b Jesse Brandeburg        2013-09-11  16209  err_mac_addr:
41c445ff0f482b Jesse Brandeburg        2013-09-11  16210  err_configure_lan_hmc:
41c445ff0f482b Jesse Brandeburg        2013-09-11  16211  	(void)i40e_shutdown_lan_hmc(hw);
41c445ff0f482b Jesse Brandeburg        2013-09-11  16212  err_init_lan_hmc:
41c445ff0f482b Jesse Brandeburg        2013-09-11  16213  	kfree(pf->qp_pile);
41c445ff0f482b Jesse Brandeburg        2013-09-11  16214  err_sw_init:
41c445ff0f482b Jesse Brandeburg        2013-09-11  16215  err_adminq_setup:
41c445ff0f482b Jesse Brandeburg        2013-09-11  16216  err_pf_reset:
41c445ff0f482b Jesse Brandeburg        2013-09-11  16217  	iounmap(hw->hw_addr);
41c445ff0f482b Jesse Brandeburg        2013-09-11  16218  err_ioremap:
41c445ff0f482b Jesse Brandeburg        2013-09-11  16219  	kfree(pf);
41c445ff0f482b Jesse Brandeburg        2013-09-11  16220  err_pf_alloc:
41c445ff0f482b Jesse Brandeburg        2013-09-11  16221  	pci_disable_pcie_error_reporting(pdev);
56d766d64ca5c9 Johannes Thumshirn      2016-06-07  16222  	pci_release_mem_regions(pdev);
41c445ff0f482b Jesse Brandeburg        2013-09-11  16223  err_pci_reg:
41c445ff0f482b Jesse Brandeburg        2013-09-11  16224  err_dma:
41c445ff0f482b Jesse Brandeburg        2013-09-11  16225  	pci_disable_device(pdev);
41c445ff0f482b Jesse Brandeburg        2013-09-11  16226  	return err;
41c445ff0f482b Jesse Brandeburg        2013-09-11 @16227  }
41c445ff0f482b Jesse Brandeburg        2013-09-11  16228  

:::::: The code at line 16227 was first introduced by commit
:::::: 41c445ff0f482bb6e6b72dcee9e598e20575f743 i40e: main driver core

:::::: TO: Jesse Brandeburg <jesse.brandeburg@intel.com>
:::::: CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
