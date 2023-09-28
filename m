Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CD47B1017
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 02:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjI1AiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 20:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI1AiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 20:38:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCB4BF;
        Wed, 27 Sep 2023 17:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695861478; x=1727397478;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uV5QaqpuKb5uDxr1hW2u8bXPE4XZPSR/+dsQ8TrfyRM=;
  b=lO463FprBN0X7jUOmepopMnX+Wt+MK145CtwsmLbAa56XpwrjbQsXRRT
   +18/JJvlmqjTenxYMsTUPX98YotXxZXl+zDotjETkAzSKUgBq0fmkdmal
   TwC+U2H6LerANEnF0cl0tkWNB0O/Vyn5pAydeMNEZuKbXCNjKRpV0alJ7
   kXUHRVAtDxbsn/7Wj5PkU0qvulB5K3vqM7zRD1GM14dRBNJ9kwJgn+amD
   Ufw1bA75rxYx30DS4fVLjFJtLDHeZ3hTwIDhvMayATPOkWg59izYFm+HZ
   yGU+8LOiqULwNynabeejNX9quZLosfEM3NLQI33DntQLWT2R0LSuEBhTl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="565337"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="565337"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 17:37:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="784518923"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="784518923"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 27 Sep 2023 17:37:53 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qlf2M-0000vF-3C;
        Thu, 28 Sep 2023 00:37:50 +0000
Date:   Thu, 28 Sep 2023 08:37:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     liuchang_125125@163.com, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, shaper.liu@bayhubtech.com,
        chevron.li@bayhubtech.com, thomas.hu@bayhubtech.com,
        charl.liu@bayhubtech.com, Charl Liu <liuchang_125125@163.com>
Subject: Re: [PATCH V1 1/1] mmc: sdhci-pci-o2micro: Fix Bayhub SD host
 hardware tuning compatibility issue for BanQ card
Message-ID: <202309280818.XQbiYALu-lkp@intel.com>
References: <20230927122652.4969-1-liuchang_125125@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927122652.4969-1-liuchang_125125@163.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 0e945134b680040b8613e962f586d91b6d40292d]

url:    https://github.com/intel-lab-lkp/linux/commits/liuchang_125125-163-com/mmc-sdhci-pci-o2micro-Fix-Bayhub-SD-host-hardware-tuning-compatibility-issue-for-BanQ-card/20230927-203005
base:   0e945134b680040b8613e962f586d91b6d40292d
patch link:    https://lore.kernel.org/r/20230927122652.4969-1-liuchang_125125%40163.com
patch subject: [PATCH V1 1/1] mmc: sdhci-pci-o2micro: Fix Bayhub SD host hardware tuning compatibility issue for BanQ card
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20230928/202309280818.XQbiYALu-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230928/202309280818.XQbiYALu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309280818.XQbiYALu-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/mmc/host/sdhci-pci-o2micro.c: In function 'sdhci_o2_tuning_setting':
>> drivers/mmc/host/sdhci-pci-o2micro.c:343:25: warning: unused variable 'o2_host' [-Wunused-variable]
     343 |         struct o2_host *o2_host = sdhci_pci_priv(slot);
         |                         ^~~~~~~
   drivers/mmc/host/sdhci-pci-o2micro.c: In function 'sdhci_o2_configure_banq_best_input_phase':
>> drivers/mmc/host/sdhci-pci-o2micro.c:370:13: warning: unused variable 'response' [-Wunused-variable]
     370 |         u32 response = 0;
         |             ^~~~~~~~
   drivers/mmc/host/sdhci-pci-o2micro.c: In function 'sdhci_o2_execute_tuning':
>> drivers/mmc/host/sdhci-pci-o2micro.c:407:26: warning: unused variable 'card' [-Wunused-variable]
     407 |         struct mmc_card *card = mmc->card;
         |                          ^~~~


vim +/o2_host +343 drivers/mmc/host/sdhci-pci-o2micro.c

   337	
   338	static void sdhci_o2_tuning_setting(struct mmc_host *mmc, bool isbanq, u8 phase_num)
   339	{
   340		struct sdhci_host *host = mmc_priv(mmc);
   341		struct sdhci_pci_slot *slot = sdhci_priv(host);
   342		struct sdhci_pci_chip *chip = slot->chip;
 > 343		struct o2_host *o2_host = sdhci_pci_priv(slot);
   344		u32 reg_val;
   345	
   346		if (isbanq) {
   347			/* update tuning command times for BanQ card */
   348			pci_read_config_dword(chip->pdev, O2_SD_TUNING_CTRL, &reg_val);
   349			reg_val &= 0x00FFFFFF;
   350			reg_val |= 0x02000000;
   351			pci_write_config_dword(chip->pdev, O2_SD_TUNING_CTRL, reg_val);
   352		} else {
   353			reg_val = sdhci_readl(host, O2_SD_DLL_CTRL);
   354			reg_val &= ~BIT(28);
   355			sdhci_writel(host, reg_val, O2_SD_DLL_CTRL);
   356	
   357			/* Update tuning command times for normal card */
   358			pci_read_config_dword(chip->pdev, O2_SD_TUNING_CTRL, &reg_val);
   359			reg_val &= 0x00FFFFFF;
   360			reg_val |= (phase_num * 3) << 24;
   361			pci_write_config_dword(chip->pdev, O2_SD_TUNING_CTRL, reg_val);
   362		}
   363	}
   364	
   365	static void sdhci_o2_configure_banq_best_input_phase(struct sdhci_host *host)
   366	{
   367		struct sdhci_pci_slot *slot = sdhci_priv(host);
   368		struct sdhci_pci_chip *chip = slot->chip;
   369	
 > 370		u32 response = 0;
   371		u16 dll_phase_configure = 0;
   372		u16 best_input_phase = 0;
   373	
   374		switch (chip->pdev->device) {
   375		case PCI_DEVICE_ID_O2_FUJIN2:
   376			best_input_phase = 0x0;
   377			break;
   378	
   379		case PCI_DEVICE_ID_O2_SEABIRD0:
   380		case PCI_DEVICE_ID_O2_SEABIRD1:
   381			best_input_phase = 0x0;
   382			break;
   383	
   384		case PCI_DEVICE_ID_O2_GG8_9860:
   385		case PCI_DEVICE_ID_O2_GG8_9861:
   386		case PCI_DEVICE_ID_O2_GG8_9862:
   387		case PCI_DEVICE_ID_O2_GG8_9863:
   388			best_input_phase = 0xB;
   389			break;
   390	
   391		default:
   392			break;
   393		}
   394	
   395		/* configure the best input phase (0xB) for BanQ card */
   396		dll_phase_configure = sdhci_readw(host, 0x1B2);
   397		dll_phase_configure = (dll_phase_configure & (u16)0xF0FF) |
   398			(best_input_phase << 8) | BIT(12);
   399		sdhci_writew(host, dll_phase_configure, 0x1B2);
   400	}
   401	
   402	static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
   403	{
   404		struct sdhci_host *host = mmc_priv(mmc);
   405		struct sdhci_pci_slot *slot = sdhci_priv(host);
   406		struct sdhci_pci_chip *chip = slot->chip;
 > 407		struct mmc_card *card = mmc->card;
   408		struct o2_host *o2_host = sdhci_pci_priv(slot);
   409		int current_bus_width = 0;
   410		u32 scratch32 = 0;
   411		u16 data_timeout_counter_value = 0;
   412		u16 scratch = 0;
   413		u8 phase_num = 0;
   414		u8  scratch_8 = 0;
   415		u32 reg_val;
   416	
   417		/*
   418		 * This handler implements the hardware tuning that is specific to
   419		 * this controller.  Fall back to the standard method for other TIMING.
   420		 */
   421		if ((host->timing != MMC_TIMING_MMC_HS200) &&
   422			(host->timing != MMC_TIMING_UHS_SDR104) &&
   423			(host->timing != MMC_TIMING_UHS_SDR50))
   424			return sdhci_execute_tuning(mmc, opcode);
   425	
   426		if (WARN_ON(!mmc_op_tuning(opcode)))
   427			return -EINVAL;
   428	
   429		if ((chip->pdev->device == PCI_DEVICE_ID_O2_GG8_9860) ||
   430			(chip->pdev->device == PCI_DEVICE_ID_O2_GG8_9861) ||
   431			(chip->pdev->device == PCI_DEVICE_ID_O2_GG8_9862) ||
   432			(chip->pdev->device == PCI_DEVICE_ID_O2_GG8_9863)) {
   433			phase_num = 14;
   434		} else {
   435			phase_num = 11;
   436		}
   437	
   438		/* UnLock WP */
   439		pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
   440		scratch_8 &= 0x7f;
   441		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
   442	
   443		sdhci_o2_tuning_setting(mmc, (bool)o2_host->banq_card_setting, phase_num);
   444	
   445		if (o2_host->banq_card_setting) {
   446			/*
   447			 * set data timeout counter value to 0 to ensure that
   448			 * the tuning process can be completed
   449			 */
   450			data_timeout_counter_value = sdhci_readw(host, SDHCI_TIMEOUT_CONTROL);
   451			sdhci_writew(host, data_timeout_counter_value & (u16)0xFFF0, SDHCI_TIMEOUT_CONTROL);
   452		}
   453	
   454		/* Force power mode enter L0 */
   455		scratch = sdhci_readw(host, O2_SD_MISC_CTRL);
   456		scratch |= O2_SD_PWR_FORCE_L0;
   457		sdhci_writew(host, scratch, O2_SD_MISC_CTRL);
   458	
   459		/* Update output phase */
   460		switch (chip->pdev->device) {
   461		case PCI_DEVICE_ID_O2_SDS0:
   462		case PCI_DEVICE_ID_O2_SEABIRD0:
   463		case PCI_DEVICE_ID_O2_SEABIRD1:
   464		case PCI_DEVICE_ID_O2_SDS1:
   465		case PCI_DEVICE_ID_O2_FUJIN2:
   466			/* Stop clk */
   467			reg_val = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
   468			reg_val &= ~SDHCI_CLOCK_CARD_EN;
   469			sdhci_writew(host, reg_val, SDHCI_CLOCK_CONTROL);
   470	
   471			if ((host->timing == MMC_TIMING_MMC_HS200) ||
   472				(host->timing == MMC_TIMING_UHS_SDR104)) {
   473				/* Set pcr 0x354[16] to choose dll clock, and set the default phase */
   474				pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &reg_val);
   475				reg_val &= ~(O2_SD_SEL_DLL | O2_SD_PHASE_MASK);
   476				reg_val |= (O2_SD_SEL_DLL | O2_SD_FIX_PHASE);
   477				pci_write_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, reg_val);
   478			}
   479	
   480			/* Start clk */
   481			reg_val = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
   482			reg_val |= SDHCI_CLOCK_CARD_EN;
   483			sdhci_writew(host, reg_val, SDHCI_CLOCK_CONTROL);
   484			break;
   485		case PCI_DEVICE_ID_O2_GG8_9860:
   486		case PCI_DEVICE_ID_O2_GG8_9861:
   487		case PCI_DEVICE_ID_O2_GG8_9862:
   488		case PCI_DEVICE_ID_O2_GG8_9863:
   489		default:
   490			break;
   491		}
   492	
   493		/* Lock WP */
   494		pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
   495		scratch_8 |= 0x80;
   496		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
   497	
   498		/* wait DLL lock, timeout value 5ms */
   499		if (readx_poll_timeout(sdhci_o2_pll_dll_wdt_control, host,
   500			scratch32, (scratch32 & O2_DLL_LOCK_STATUS), 1, 5000))
   501			pr_warn("%s: DLL can't lock in 5ms after force L0 during tuning.\n",
   502					mmc_hostname(host->mmc));
   503		/*
   504		 * Judge the tuning reason, whether caused by dll shift
   505		 * If cause by dll shift, should call sdhci_o2_dll_recovery
   506		 */
   507		if (!sdhci_o2_wait_dll_detect_lock(host))
   508			if (!sdhci_o2_dll_recovery(host)) {
   509				pr_err("%s: o2 dll recovery failed\n",
   510					mmc_hostname(host->mmc));
   511				return -EINVAL;
   512			}
   513		/*
   514		 * o2 sdhci host didn't support 8bit emmc tuning
   515		 */
   516		if (mmc->ios.bus_width == MMC_BUS_WIDTH_8) {
   517			current_bus_width = mmc->ios.bus_width;
   518			mmc->ios.bus_width = MMC_BUS_WIDTH_4;
   519			sdhci_set_bus_width(host, MMC_BUS_WIDTH_4);
   520		}
   521	
   522		sdhci_o2_set_tuning_mode(host);
   523	
   524		sdhci_start_tuning(host);
   525	
   526		__sdhci_o2_execute_tuning(host, opcode);
   527	
   528		sdhci_end_tuning(host);
   529	
   530		if (current_bus_width == MMC_BUS_WIDTH_8) {
   531			mmc->ios.bus_width = MMC_BUS_WIDTH_8;
   532			sdhci_set_bus_width(host, current_bus_width);
   533		}
   534	
   535		/* update input phase for BanQ card */
   536		if (o2_host->banq_card_setting) {
   537			/* recover the data timeout counter value */
   538			sdhci_writew(host, data_timeout_counter_value, SDHCI_TIMEOUT_CONTROL);
   539	
   540			/*
   541			 * Stop transfer for CMD19 after tuning done is set to
   542			 * avoid data line inhibit
   543			 */
   544			sdhci_o2_send_stop_transmission(host);
   545	
   546			sdhci_o2_configure_banq_best_input_phase(host);
   547		}
   548	
   549		/* Cancel force power mode enter L0 */
   550		scratch = sdhci_readw(host, O2_SD_MISC_CTRL);
   551		scratch &= ~(O2_SD_PWR_FORCE_L0);
   552		sdhci_writew(host, scratch, O2_SD_MISC_CTRL);
   553	
   554		sdhci_reset(host, SDHCI_RESET_CMD);
   555		sdhci_reset(host, SDHCI_RESET_DATA);
   556	
   557		host->flags &= ~SDHCI_HS400_TUNING;
   558		return 0;
   559	}
   560	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
