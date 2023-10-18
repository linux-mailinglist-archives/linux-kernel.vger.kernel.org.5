Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6C67CD53B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 09:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjJRHId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 03:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjJRHI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 03:08:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9751DBA;
        Wed, 18 Oct 2023 00:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697612906; x=1729148906;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hlo0dF2zQh9hT3gGeZX9xPY12yYQ2jU6Lldf2uB640M=;
  b=BQkYi58RsrGh3cGS6qIQ0Dx1KNnjXOZ/JwIcB61b1KbhfFFgn5+rg8hi
   Tv6Uw8oXcRjC+y7cfRGb70wjQQXVM3z1QVtVLADtwbyQJLoVmPx3HJnZn
   SjURTH9mdgrHvX40tB3Ut3E7A7Ru49Kp12Ykf4XPMHSeMFWQUtlnDkuRI
   +xDGZT2yPbg/ukqCqmgrAcKP6ZbXxF+XkAHzII0uQirk8ii4H9jiDLD22
   aeAQq+ko3IhEAN5/hClPgQQL39Obp+HuotoumkY9ML3USSk8jkqXog9oo
   tJAn3yZRXT6E2L6Rl4EEmuTWYaOAXkjdZXE0JWMaLhQtn/6Iv8NZN67C9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="452426793"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="452426793"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 00:08:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="872897878"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="872897878"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 18 Oct 2023 00:08:22 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qt0fD-000038-21;
        Wed, 18 Oct 2023 07:08:19 +0000
Date:   Wed, 18 Oct 2023 15:07:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     liuchang_125125@163.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, mark.tao@bayhubtech.com,
        shaper.liu@bayhubtech.com, thomas.hu@bayhubtech.com,
        chevron.li@bayhubtech.com, charl.liu@bayhubtech.com,
        Charl Liu <liuchang_125125@163.com>
Subject: Re: [PATCH 6/9] scsi: bht: linux_os: Add the source files related to
 SCSI frame and driver entry
Message-ID: <202310181402.y79qeFJw-lkp@intel.com>
References: <20231013083415.10330-1-liuchang_125125@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013083415.10330-1-liuchang_125125@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 401644852d0b2a278811de38081be23f74b5bb04]

url:    https://github.com/intel-lab-lkp/linux/commits/liuchang_125125-163-com/scsi-Update-Kconfig-and-Makefile-for-supporting-Bayhub-s-SD-MMC-Card-interface-driver/20231017-123349
base:   401644852d0b2a278811de38081be23f74b5bb04
patch link:    https://lore.kernel.org/r/20231013083415.10330-1-liuchang_125125%40163.com
patch subject: [PATCH 6/9] scsi: bht: linux_os: Add the source files related to SCSI frame and driver entry
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20231018/202310181402.y79qeFJw-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231018/202310181402.y79qeFJw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310181402.y79qeFJw-lkp@intel.com/

All warnings (new ones prefixed by >>):

   cc1: warning: /drivers/scsi: No such file or directory [-Wmissing-include-dirs]
>> drivers/scsi/bht/linux_os/linux_base.c:239:6: warning: no previous prototype for 'bht_bios_setting' [-Wmissing-prototypes]
     239 | void bht_bios_setting(bht_dev_ext_t *pdx)
         |      ^~~~~~~~~~~~~~~~
   drivers/scsi/bht/linux_os/linux_base.c: In function 'bht_sd_dma_init':
>> drivers/scsi/bht/linux_os/linux_base.c:610:9: warning: "CONFIG_X86_64" is not defined, evaluates to 0 [-Wundef]
     610 | #if     CONFIG_X86_64
         |         ^~~~~~~~~~~~~
   drivers/scsi/bht/linux_os/linux_base.c: At top level:
>> drivers/scsi/bht/linux_os/linux_base.c:803:6: warning: no previous prototype for 'bht_sd_remove' [-Wmissing-prototypes]
     803 | void bht_sd_remove(struct pci_dev *pdev)
         |      ^~~~~~~~~~~~~
--
   cc1: warning: /drivers/scsi: No such file or directory [-Wmissing-include-dirs]
>> drivers/scsi/bht/linux_os/linux_api.c:444:5: warning: no previous prototype for 'pci_cfgio_readl' [-Wmissing-prototypes]
     444 | u32 pci_cfgio_readl(sd_host_t *host, u16 offset)
         |     ^~~~~~~~~~~~~~~
>> drivers/scsi/bht/linux_os/linux_api.c:480:6: warning: no previous prototype for 'timer_auto_cb2' [-Wmissing-prototypes]
     480 | void timer_auto_cb2(struct timer_list *t)
         |      ^~~~~~~~~~~~~~
>> drivers/scsi/bht/linux_os/linux_api.c:519:6: warning: no previous prototype for 'timer_subid_cb' [-Wmissing-prototypes]
     519 | void timer_subid_cb(PVOID ctx, PVOID pdx)
         |      ^~~~~~~~~~~~~~
>> drivers/scsi/bht/linux_os/linux_api.c:2059:6: warning: no previous prototype for 'os_bak_reg_hibernate' [-Wmissing-prototypes]
    2059 | void os_bak_reg_hibernate(void)
         |      ^~~~~~~~~~~~~~~~~~~~
--
   cc1: warning: /drivers/scsi: No such file or directory [-Wmissing-include-dirs]
>> drivers/scsi/bht/card/cardcommon.c:61:6: warning: no previous prototype for 'card_send_sdcmd_timeout' [-Wmissing-prototypes]
      61 | bool card_send_sdcmd_timeout(sd_card_t *card,
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bht/card/cardcommon.c: In function 'card_set_csd_info':
>> drivers/scsi/bht/card/cardcommon.c:472:13: warning: variable 'value' set but not used [-Wunused-but-set-variable]
     472 |         u32 value, unit;
         |             ^~~~~
   drivers/scsi/bht/card/cardcommon.c: In function 'card_get_legacy_freq':
>> drivers/scsi/bht/card/cardcommon.c:867:54: warning: the comparison will always evaluate as 'false' for the address of 'dmdn_tbl' will never be NULL [-Waddress]
     867 |         if (host->cfg == NULL || host->cfg->dmdn_tbl == NULL) {
         |                                                      ^~
   In file included from drivers/scsi/bht/card/../include/basic.h:180,
                    from drivers/scsi/bht/card/cardcommon.c:20:
   drivers/scsi/bht/card/../include/cfgmng.h:1269:13: note: 'dmdn_tbl' declared here
    1269 |         u32 dmdn_tbl[MAX_FREQ_SUPP];
         |             ^~~~~~~~
--
   cc1: warning: /drivers/scsi: No such file or directory [-Wmissing-include-dirs]
>> drivers/scsi/bht/card/mmc.c:175:6: warning: no previous prototype for 'emmc_set_rca' [-Wmissing-prototypes]
     175 | bool emmc_set_rca(sd_card_t *card, sd_command_t *sd_cmd)
         |      ^~~~~~~~~~~~
>> drivers/scsi/bht/card/mmc.c:1610:6: warning: no previous prototype for 'mmc_degrade_policy' [-Wmissing-prototypes]
    1610 | void mmc_degrade_policy(sd_card_t *card)
         |      ^~~~~~~~~~~~~~~~~~
--
   cc1: warning: /drivers/scsi: No such file or directory [-Wmissing-include-dirs]
>> drivers/scsi/bht/card/sd.c:777:6: warning: no previous prototype for 'sd_switch_function_set_am' [-Wmissing-prototypes]
     777 | bool sd_switch_function_set_am(sd_card_t *card,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/scsi/bht/card/sd.c:837:6: warning: no previous prototype for 'sd_switch_function_set_ds' [-Wmissing-prototypes]
     837 | bool sd_switch_function_set_ds(sd_card_t *card,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/scsi/bht/card/sd.c:1060:6: warning: no previous prototype for 'sd_switch_access_mode' [-Wmissing-prototypes]
    1060 | bool sd_switch_access_mode(sd_card_t *card, sd_command_t *sd_cmd, bool *bchg)
         |      ^~~~~~~~~~~~~~~~~~~~~
>> drivers/scsi/bht/card/sd.c:1229:6: warning: no previous prototype for 'sd_switch_function_set' [-Wmissing-prototypes]
    1229 | bool sd_switch_function_set(sd_card_t *card, sd_command_t *sd_cmd)
         |      ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/scsi/bht/card/sd.c:1332:6: warning: no previous prototype for 'sd_tuning_hw' [-Wmissing-prototypes]
    1332 | bool sd_tuning_hw(sd_card_t *card, sd_command_t *sd_cmd, u32 timeout)
         |      ^~~~~~~~~~~~
>> drivers/scsi/bht/card/sd.c:1393:6: warning: no previous prototype for 'sd_tuning_sw' [-Wmissing-prototypes]
    1393 | bool sd_tuning_sw(sd_card_t *card, sd_command_t *sd_cmd)
         |      ^~~~~~~~~~~~
>> drivers/scsi/bht/card/sd.c:1641:6: warning: no previous prototype for 'sd_lightning_mode_sw' [-Wmissing-prototypes]
    1641 | bool sd_lightning_mode_sw(sd_card_t *card, sd_command_t *sd_cmd)
         |      ^~~~~~~~~~~~~~~~~~~~
>> drivers/scsi/bht/card/sd.c:2522:6: warning: no previous prototype for 'sd_degrade_policy' [-Wmissing-prototypes]
    2522 | void sd_degrade_policy(sd_card_t *card)
         |      ^~~~~~~~~~~~~~~~~
>> drivers/scsi/bht/card/sd.c:2584:6: warning: no previous prototype for 'sd_thermal_control' [-Wmissing-prototypes]
    2584 | bool sd_thermal_control(sd_card_t *card)
         |      ^~~~~~~~~~~~~~~~~~
>> drivers/scsi/bht/card/sd.c:2785:6: warning: no previous prototype for 'sd_dll_divider' [-Wmissing-prototypes]
    2785 | bool sd_dll_divider(sd_card_t *card, sd_command_t *pcmd)
         |      ^~~~~~~~~~~~~~
   drivers/scsi/bht/card/sd.c: In function 'sd_dll_divider':
>> drivers/scsi/bht/card/sd.c:2788:17: warning: variable 'jj' set but not used [-Wunused-but-set-variable]
    2788 |         u32 ii, jj, pattern_i;
         |                 ^~
--
   cc1: warning: /drivers/scsi: No such file or directory [-Wmissing-include-dirs]
>> drivers/scsi/bht/card/thermal.c:222:6: warning: no previous prototype for 'func_thermal_control' [-Wmissing-prototypes]
     222 | bool func_thermal_control(sd_card_t *card)
         |      ^~~~~~~~~~~~~~~~~~~~
>> drivers/scsi/bht/card/thermal.c:305:6: warning: no previous prototype for 'func_thermal_update_time' [-Wmissing-prototypes]
     305 | void func_thermal_update_time(bht_dev_ext_t *pdx)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/scsi/bht/card/thermal.c:327:6: warning: no previous prototype for 'thermal_init' [-Wmissing-prototypes]
     327 | void thermal_init(bht_dev_ext_t *pdx)
         |      ^~~~~~~~~~~~
>> drivers/scsi/bht/card/thermal.c:343:6: warning: no previous prototype for 'thermal_uninit' [-Wmissing-prototypes]
     343 | void thermal_uninit(bht_dev_ext_t *pdx)
         |      ^~~~~~~~~~~~~~
--
   cc1: warning: /drivers/scsi: No such file or directory [-Wmissing-include-dirs]
>> drivers/scsi/bht/card/uhs2.c:229:6: warning: no previous prototype for 'uhs2_send_fullreset' [-Wmissing-prototypes]
     229 | bool uhs2_send_fullreset(sd_card_t *card, sd_command_t *sd_cmd)
         |      ^~~~~~~~~~~~~~~~~~~
>> drivers/scsi/bht/card/uhs2.c:262:6: warning: no previous prototype for 'uhs2_trans_abort' [-Wmissing-prototypes]
     262 | bool uhs2_trans_abort(sd_card_t *card, sd_command_t *sd_cmd)
         |      ^~~~~~~~~~~~~~~~
>> drivers/scsi/bht/card/uhs2.c:333:6: warning: no previous prototype for 'uhs2_dev_enumeration' [-Wmissing-prototypes]
     333 | bool uhs2_dev_enumeration(sd_card_t *card, sd_command_t *sd_cmd)
         |      ^~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bht/card/uhs2.c: In function 'uhs2_dev_enumeration':
>> drivers/scsi/bht/card/uhs2.c:339:12: warning: variable 'devcnt' set but not used [-Wunused-but-set-variable]
     339 |         u8 devcnt = 0;
         |            ^~~~~~
   drivers/scsi/bht/card/uhs2.c: At top level:
>> drivers/scsi/bht/card/uhs2.c:900:6: warning: no previous prototype for 'uhs2_card_configuration' [-Wmissing-prototypes]
     900 | bool uhs2_card_configuration(sd_card_t *card, sd_command_t *sd_cmd,
         |      ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/scsi/bht/card/uhs2.c:1094:6: warning: no previous prototype for 'uhs2_degrade_policy' [-Wmissing-prototypes]
    1094 | void uhs2_degrade_policy(sd_card_t *card, sd_command_t *sd_cmd)
         |      ^~~~~~~~~~~~~~~~~~~
>> drivers/scsi/bht/card/uhs2.c:1158:6: warning: no previous prototype for 'uhs2_sd_error_recovery' [-Wmissing-prototypes]
    1158 | bool uhs2_sd_error_recovery(sd_card_t *card, sd_command_t *sd_cmd)
         |      ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/scsi/bht/card/uhs2.c:1208:5: warning: no previous prototype for 'card_get_uhs2_freq' [-Wmissing-prototypes]
    1208 | u32 card_get_uhs2_freq(sd_card_t *card)
         |     ^~~~~~~~~~~~~~~~~~
   drivers/scsi/bht/card/uhs2.c: In function 'card_get_uhs2_freq':
>> drivers/scsi/bht/card/uhs2.c:1215:54: warning: the comparison will always evaluate as 'false' for the address of 'dmdn_tbl' will never be NULL [-Waddress]
    1215 |         if (host->cfg == NULL || host->cfg->dmdn_tbl == NULL) {
         |                                                      ^~
   In file included from drivers/scsi/bht/card/../include/basic.h:180,
                    from drivers/scsi/bht/card/uhs2.c:20:
   drivers/scsi/bht/card/../include/cfgmng.h:1269:13: note: 'dmdn_tbl' declared here
    1269 |         u32 dmdn_tbl[MAX_FREQ_SUPP];
         |             ^~~~~~~~
--
   cc1: warning: /drivers/scsi: No such file or directory [-Wmissing-include-dirs]
>> drivers/scsi/bht/card/output_tuning.c:59:5: warning: no previous prototype for 'tuning_phase_result' [-Wmissing-prototypes]
      59 | u16 tuning_phase_result(sd_card_t *card)
         |     ^~~~~~~~~~~~~~~~~~~
>> drivers/scsi/bht/card/output_tuning.c:105:4: warning: no previous prototype for 'select_tuning_phase' [-Wmissing-prototypes]
     105 | u8 select_tuning_phase(u16 tuning_phase, u8 phase_cnt)
         |    ^~~~~~~~~~~~~~~~~~~
>> drivers/scsi/bht/card/output_tuning.c:144:6: warning: no previous prototype for 'set_input_tuning_phase' [-Wmissing-prototypes]
     144 | void set_input_tuning_phase(sd_card_t *card, u8 sel_phase)
         |      ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/scsi/bht/card/output_tuning.c:163:6: warning: no previous prototype for 'generate_traverse_range' [-Wmissing-prototypes]
     163 | void generate_traverse_range(sd_card_t *card, u8 center_point, u8 offset,
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bht/card/output_tuning.c: In function 'generate_traverse_range':
>> drivers/scsi/bht/card/output_tuning.c:166:13: warning: variable 'phase_mask_all_pass' set but not used [-Wunused-but-set-variable]
     166 |         u16 phase_mask_all_pass = 0;
         |             ^~~~~~~~~~~~~~~~~~~
   drivers/scsi/bht/card/output_tuning.c: At top level:
>> drivers/scsi/bht/card/output_tuning.c:187:4: warning: no previous prototype for 'get_output_fix_phase' [-Wmissing-prototypes]
     187 | u8 get_output_fix_phase(sd_card_t *card)
         |    ^~~~~~~~~~~~~~~~~~~~
>> drivers/scsi/bht/card/output_tuning.c:217:5: warning: no previous prototype for 'find_input_phase_fail_point' [-Wmissing-prototypes]
     217 | u32 find_input_phase_fail_point(sd_card_t *card, u8 *output_phase,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/scsi/bht/card/output_tuning.c:278:5: warning: no previous prototype for 'generate_output_input_phase_pair' [-Wmissing-prototypes]
     278 | u32 generate_output_input_phase_pair(sd_card_t *card, u8 input_fix_phase,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/scsi/bht/card/output_tuning.c:415:5: warning: no previous prototype for 'output_tuning' [-Wmissing-prototypes]
     415 | int output_tuning(sd_card_t *card, u32 address, bool ddr200)
         |     ^~~~~~~~~~~~~
>> drivers/scsi/bht/card/output_tuning.c:581:5: warning: no previous prototype for 'sdr104_sdr50_output_tuning' [-Wmissing-prototypes]
     581 | u32 sdr104_sdr50_output_tuning(sd_card_t *card, u32 address)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/scsi/bht/card/output_tuning.c:675:5: warning: no previous prototype for 'ddr200_output_tuning' [-Wmissing-prototypes]
     675 | u32 ddr200_output_tuning(sd_card_t *card, u32 address)
         |     ^~~~~~~~~~~~~~~~~~~~
--
   cc1: warning: /drivers/scsi: No such file or directory [-Wmissing-include-dirs]
>> drivers/scsi/bht/host/host.c:168:6: warning: no previous prototype for 'host_enable_pll_software_reset' [-Wmissing-prototypes]
     168 | void host_enable_pll_software_reset(sd_host_t *host, bool on)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/scsi/bht/host/host.c:223:6: warning: no previous prototype for 'host_init_clock' [-Wmissing-prototypes]
     223 | void host_init_clock(sd_host_t *host, u32 value)
         |      ^~~~~~~~~~~~~~~
   drivers/scsi/bht/host/host.c: In function 'host_init_400k_clock':
>> drivers/scsi/bht/host/host.c:240:54: warning: the comparison will always evaluate as 'false' for the address of 'dmdn_tbl' will never be NULL [-Waddress]
     240 |         if (host->cfg == NULL || host->cfg->dmdn_tbl == NULL) {
         |                                                      ^~
   In file included from drivers/scsi/bht/host/../include/basic.h:180,
                    from drivers/scsi/bht/host/host.c:19:
   drivers/scsi/bht/host/../include/cfgmng.h:1269:13: note: 'dmdn_tbl' declared here
    1269 |         u32 dmdn_tbl[MAX_FREQ_SUPP];
         |             ^~~~~~~~
   drivers/scsi/bht/host/host.c: At top level:
>> drivers/scsi/bht/host/host.c:325:6: warning: no previous prototype for 'host_dma_select' [-Wmissing-prototypes]
     325 | void host_dma_select(sd_host_t *host, e_trans_type mode)
         |      ^~~~~~~~~~~~~~~
>> drivers/scsi/bht/host/host.c:573:6: warning: no previous prototype for 'host_set_vdd1_power_nodelay' [-Wmissing-prototypes]
     573 | void host_set_vdd1_power_nodelay(sd_host_t *host, bool on, u32 vol_sel)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/scsi/bht/host/host.c:2615:6: warning: no previous prototype for 'host_error_int_recovery_stage1' [-Wmissing-prototypes]
    2615 | void host_error_int_recovery_stage1(sd_host_t *host, u16 error_int_state,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   cc1: warning: /drivers/scsi: No such file or directory [-Wmissing-include-dirs]
>> drivers/scsi/bht/host/hostven.c:558:6: warning: no previous prototype for 'hostven_update_dmdn' [-Wmissing-prototypes]
     558 | void hostven_update_dmdn(sd_host_t *host, u32 dmdn)
         |      ^~~~~~~~~~~~~~~~~~~
>> drivers/scsi/bht/host/hostven.c:599:6: warning: no previous prototype for 'hostven_drive_strength_cfg' [-Wmissing-prototypes]
     599 | void hostven_drive_strength_cfg(sd_host_t *host)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/scsi/bht/host/hostven.c:655:6: warning: no previous prototype for 'hostven_transfer_init' [-Wmissing-prototypes]
     655 | void hostven_transfer_init(sd_host_t *host, bool enable)
         |      ^~~~~~~~~~~~~~~~~~~~~
>> drivers/scsi/bht/host/hostven.c:1019:6: warning: no previous prototype for 'hostven_ocb_cfg' [-Wmissing-prototypes]
    1019 | void hostven_ocb_cfg(sd_host_t *host)
         |      ^~~~~~~~~~~~~~~
>> drivers/scsi/bht/host/hostven.c:1054:6: warning: no previous prototype for 'hostven_switch_flow_cfg' [-Wmissing-prototypes]
    1054 | void hostven_switch_flow_cfg(sd_host_t *host)
         |      ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/scsi/bht/host/hostven.c:1117:6: warning: no previous prototype for 'hostven_cmd_low_cfg' [-Wmissing-prototypes]
    1117 | void hostven_cmd_low_cfg(sd_host_t *host)
         |      ^~~~~~~~~~~~~~~~~~~
>> drivers/scsi/bht/host/hostven.c:1154:6: warning: no previous prototype for 'hostven_pinshare_cfg' [-Wmissing-prototypes]
    1154 | void hostven_pinshare_cfg(sd_host_t *host)
         |      ^~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bht/host/hostven.c: In function 'hostven_load_pcr_cfg':
>> drivers/scsi/bht/host/hostven.c:1477:37: warning: variable 'reg_val' set but not used [-Wunused-but-set-variable]
    1477 |                                 u32 reg_val = 0;
         |                                     ^~~~~~~
   drivers/scsi/bht/host/hostven.c: At top level:
>> drivers/scsi/bht/host/hostven.c:2724:6: warning: no previous prototype for 'hostven_hs400_host_chk' [-Wmissing-prototypes]
    2724 | bool hostven_hs400_host_chk(sd_host_t *host)
         |      ^~~~~~~~~~~~~~~~~~~~~~
--
   cc1: warning: /drivers/scsi: No such file or directory [-Wmissing-include-dirs]
>> drivers/scsi/bht/host/cmdhandler.c:32:6: warning: no previous prototype for 'host_dump_reg' [-Wmissing-prototypes]
      32 | void host_dump_reg(sd_host_t *host)
         |      ^~~~~~~~~~~~~
..


vim +/bht_bios_setting +239 drivers/scsi/bht/linux_os/linux_base.c

   238	
 > 239	void bht_bios_setting(bht_dev_ext_t *pdx)
   240	{
   241		sd_host_t *host = &pdx->host;
   242		cfg_item_t *cfg = pdx->cfg;
   243		u32 regaddr;
   244		u32 regval;
   245	
   246		DbgInfo(MODULE_OS_ENTRYAPI, FEATURE_RW_TRACE, NOT_TO_RAM,
   247			"Enter %s chip type = 0x%x\n", __func__, host->chip_type);
   248	
   249		switch (host->chip_type) {
   250		case CHIP_GG8:
   251			regval = pci_readl(host, 0x300);
   252			regval &= ~(0xff);
   253			regval |= 0x33;
   254			pci_writel(host, 0x300, regval);
   255			break;
   256		case CHIP_SEAEAGLE2:
   257			/* we need set this to enable hs400 function */
   258			if (cfg->card_item.emmc_mode.enable_force_hs400)
   259				pci_orl(host, 0x3f8, BIT13);
   260			else
   261				pci_andl(host, 0x3f8, ~BIT13);
   262			break;
   263		case CHIP_SDS2_SD0:
   264		case CHIP_SDS2_SD1:
   265			/* pcie & pm #2, should be the first operation after detect host type */
   266			pci_writel(host, 0x438, m_ram_ema);
   267	
   268			/* uhsi #1 */
   269			pci_orl(host, 0x3e4, 0x80000000);
   270			/* uhsi #3 */
   271			regaddr = (host->chip_type == CHIP_SDS2_SD0) ? 0x300 : 0x380;
   272			pci_writel(host, regaddr, INPUT_TUNING_PASS_WINDOW);
   273	
   274			/* ushi #4 */
   275			regval = pci_readl(host, 0x3f8);
   276			regval &= ~(0x03u << 19);
   277			regval |= (m_vdd18_debounce_time << 19);
   278			pci_orl(host, 0x3f8, regval);
   279	
   280			/* uhsi #6 */
   281			regaddr = host->chip_type == CHIP_SDS2_SD0 ? 0x304 : 0x384;
   282			regval = pci_readl(host, regaddr);
   283			regval &= 0xffff8881;
   284			regval |= ((m_sd_3v3_clk_driver_strength & 0x07) << 12 |
   285				   (m_sd_3v3_cmddata_driver_strength & 0x07) << 8 |
   286				   (m_sd_1v8_clk_driver_strength & 0x07) << 4 |
   287				   (m_sd_1v8_cmddata_driver_strength & 0x07) << 1 | 1);
   288			pci_writel(host, regaddr, regval);
   289	
   290			/* ushii #1  */
   291			regval = pci_readl(host, 0x3fc);
   292			regval &= ~0x7f000000;
   293			regval |= ((m_cnfg_drv & 0x7f) << 24);
   294			pci_writel(host, 0x3fc, regval);
   295	
   296			regval = pci_readl(host, 0x400);
   297			regval &= ~(0xfff);
   298			regval |= ((m_cnfg_trm_code_tx & 0x0f) << 8);
   299			regval |= ((m_cnfg_trm_code_rx & 0x0f) << 4);
   300			regval |= (m_cnfg_rint_code & 0x0f);
   301			pci_writel(host, 0x400, regval);
   302	
   303			/* uhsii 2 */
   304			switch (m_vdd1_vdd2_source) {
   305			case 0:
   306				regval = pci_readl(host, 0x508);
   307				/* bit[25:24] = 2'b00 */
   308				regval &= ~(0x3 << 24);
   309				/* bit[9:8] = 2'b00 */
   310				regval &= ~(0x3 << 8);
   311				regval &= ~(0xf << 2);
   312				/* bit[5:2]=4'b0101 */
   313				regval |= 0x14;
   314				break;
   315			case 1:
   316				regval = pci_readl(host, 0x508);
   317				/* bit[25:24] = 2'b11 */
   318				regval |= (0x3 << 24);
   319				/* bit[9:8] = 2'b11 */
   320				regval |= (0x3 << 8);
   321				/* bit[5:2]=4'b1111 */
   322				regval |= (0xf << 2);
   323				break;
   324			case 2:
   325				regval = pci_readl(host, 0x508);
   326				/* bit[25:24] = 2'b00 */
   327				regval &= ~(0x3 << 24);
   328				/* bit[25:24] = 2'b10 */
   329				regval |= (0x2 << 24);
   330				/* bit[9:8] = 2'b00 */
   331				regval &= ~(0x3 << 8);
   332				/* bit[9:8] = 2'b10 */
   333				regval |= (0x2 << 8);
   334				regval &= ~(0xf << 2);
   335				/* bit[5:2]=4'b1010 */
   336				regval |= 0x28;
   337				break;
   338			default:
   339				break;
   340			}
   341			pci_writel(host, 0x508, regval);
   342	
   343			/* clock & generator #1 */
   344			if (m_ssc_enable != 0) {
   345				pci_writel(host, 0x420, 0xa0005e1e);
   346				pci_writel(host, 0x424, 0x61180000);
   347			} else {
   348				pci_writel(host, 0x420, 0xa000561e);
   349				pci_writel(host, 0x424, 0x21180000);
   350			}
   351			/* clock & generator #2 */
   352			pci_writel(host, 0x428, 0x01f0f0fa);
   353			pci_writel(host, 0x42c, 0x01f0f0fa);
   354			break;
   355		default:
   356			break;
   357		}
   358	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
