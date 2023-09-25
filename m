Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB8B7ADDD5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 19:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbjIYReF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 13:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbjIYReC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 13:34:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F184C10F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 10:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695663233; x=1727199233;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qM4p54JXOJqrlbKg3hXDwj9KvxR4gVFlKf63VxUzCLo=;
  b=hWSgL1LmAcjwarEbZ/JzJoo4d4pEH0OPMIuIWu6d/+8xxlDh+hMrxlzL
   jSWsYlaxAQtK1bfCLrfGV6UwyLAJtYPF+mgLBLhoqRqMou3JCizAH5DqI
   dg6rFBK1GHLTtJhZikzO4Y/EwYjnIhqs7TM3VxM7Xzx9yW1Ezb3JGSi5H
   +mlpMHKWiSnupVe8aZWk+5gja3dnXXDc2voQ21l4i/rLvBELeG9tsrU3i
   F8wT1TdayGd0SaC/NMe56ujPkMh2YT/paqL8Wa6i2kzG0RWz7Bm+MJQVD
   Xy+HSbQEXAtk5a2VIzueW+gMTW/OWuFTUtepG4YOqndBUatqQ8qFVh+tv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="467601024"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="467601024"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 10:33:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="741995229"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="741995229"
Received: from lkp-server02.sh.intel.com (HELO 32c80313467c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 25 Sep 2023 10:33:49 -0700
Received: from kbuild by 32c80313467c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qkpSs-0001rh-2S;
        Mon, 25 Sep 2023 17:33:46 +0000
Date:   Tue, 26 Sep 2023 01:33:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/arm/mm/cache-uniphier.c:72: warning: cannot understand function
 prototype: 'struct uniphier_cache_data '
Message-ID: <202309260130.Uvwh8ceE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6465e260f48790807eef06b583b38ca9789b6072
commit: 09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8 ARM: dove: multiplatform support
date:   1 year, 6 months ago
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20230926/202309260130.Uvwh8ceE-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230926/202309260130.Uvwh8ceE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309260130.Uvwh8ceE-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/arm/mm/cache-uniphier.c:72: warning: cannot understand function prototype: 'struct uniphier_cache_data '
--
   drivers/edac/armada_xp_edac.c: In function 'axp_mc_check':
>> drivers/edac/armada_xp_edac.c:129:47: warning: variable 'cause_msg' set but not used [-Wunused-but-set-variable]
     129 |         uint32_t cnt_sbe, cnt_dbe, cause_err, cause_msg;
         |                                               ^~~~~~~~~
>> drivers/edac/armada_xp_edac.c:129:36: warning: variable 'cause_err' set but not used [-Wunused-but-set-variable]
     129 |         uint32_t cnt_sbe, cnt_dbe, cause_err, cause_msg;
         |                                    ^~~~~~~~~
>> drivers/edac/armada_xp_edac.c:128:26: warning: variable 'data_l' set but not used [-Wunused-but-set-variable]
     128 |         uint32_t data_h, data_l, recv_ecc, calc_ecc, addr;
         |                          ^~~~~~
>> drivers/edac/armada_xp_edac.c:128:18: warning: variable 'data_h' set but not used [-Wunused-but-set-variable]
     128 |         uint32_t data_h, data_l, recv_ecc, calc_ecc, addr;
         |                  ^~~~~~
--
>> drivers/power/supply/ab8500_btemp.c:58: warning: Function parameter or member 'isr' not described in 'ab8500_btemp_interrupts'
>> drivers/power/supply/ab8500_btemp.c:112: warning: Function parameter or member 'prev_bat_temp' not described in 'ab8500_btemp'
>> drivers/power/supply/ab8500_btemp.c:112: warning: Function parameter or member 'bat_ctrl' not described in 'ab8500_btemp'
--
>> drivers/power/supply/ab8500_chargalg.c:173: warning: bad line:                         is set
>> drivers/power/supply/ab8500_chargalg.c:179: warning: bad line:                         increased
>> drivers/power/supply/ab8500_chargalg.c:247: warning: Function parameter or member 't_hyst_norm' not described in 'ab8500_chargalg'
>> drivers/power/supply/ab8500_chargalg.c:247: warning: Function parameter or member 't_hyst_lowhigh' not described in 'ab8500_chargalg'
>> drivers/power/supply/ab8500_chargalg.c:247: warning: Function parameter or member 'ccm' not described in 'ab8500_chargalg'
>> drivers/power/supply/ab8500_chargalg.c:247: warning: Function parameter or member 'ac_chg' not described in 'ab8500_chargalg'
>> drivers/power/supply/ab8500_chargalg.c:247: warning: Function parameter or member 'usb_chg' not described in 'ab8500_chargalg'
>> drivers/power/supply/ab8500_chargalg.c:317: warning: Function parameter or member 'state' not described in 'ab8500_chargalg_state_to'
>> drivers/power/supply/ab8500_chargalg.c:802: warning: Function parameter or member 'di' not described in 'ab8500_chargalg_chg_curr_maxim'
--
>> drivers/power/supply/ab8500_charger.c:181: warning: Function parameter or member 'isr' not described in 'ab8500_charger_interrupts'
>> drivers/power/supply/ab8500_charger.c:323: warning: Function parameter or member 'vbat' not described in 'ab8500_charger'
>> drivers/power/supply/ab8500_charger.c:323: warning: Function parameter or member 'old_vbat' not described in 'ab8500_charger'
>> drivers/power/supply/ab8500_charger.c:323: warning: Function parameter or member 'usb_device_is_unrecognised' not described in 'ab8500_charger'
>> drivers/power/supply/ab8500_charger.c:323: warning: Function parameter or member 'autopower' not described in 'ab8500_charger'
>> drivers/power/supply/ab8500_charger.c:323: warning: Function parameter or member 'autopower_cfg' not described in 'ab8500_charger'
>> drivers/power/supply/ab8500_charger.c:323: warning: Function parameter or member 'invalid_charger_detect_state' not described in 'ab8500_charger'
>> drivers/power/supply/ab8500_charger.c:323: warning: Function parameter or member 'adc_main_charger_v' not described in 'ab8500_charger'
>> drivers/power/supply/ab8500_charger.c:323: warning: Function parameter or member 'adc_main_charger_c' not described in 'ab8500_charger'
>> drivers/power/supply/ab8500_charger.c:323: warning: Function parameter or member 'adc_vbus_v' not described in 'ab8500_charger'
>> drivers/power/supply/ab8500_charger.c:323: warning: Function parameter or member 'adc_usb_charger_c' not described in 'ab8500_charger'
>> drivers/power/supply/ab8500_charger.c:323: warning: Function parameter or member 'check_vbat_work' not described in 'ab8500_charger'
>> drivers/power/supply/ab8500_charger.c:323: warning: Function parameter or member 'usb_phy' not described in 'ab8500_charger'
>> drivers/power/supply/ab8500_charger.c:323: warning: Function parameter or member 'nb' not described in 'ab8500_charger'
>> drivers/power/supply/ab8500_charger.c:1395: warning: Function parameter or member 'charger' not described in 'ab8500_charger_ac_en'
>> drivers/power/supply/ab8500_charger.c:1395: warning: Excess function parameter 'di' description in 'ab8500_charger_ac_en'
>> drivers/power/supply/ab8500_charger.c:1572: warning: Function parameter or member 'charger' not described in 'ab8500_charger_usb_en'
>> drivers/power/supply/ab8500_charger.c:1572: warning: Excess function parameter 'di' description in 'ab8500_charger_usb_en'
>> drivers/power/supply/ab8500_charger.c:1849: warning: Function parameter or member 'charger' not described in 'ab8500_charger_watchdog_kick'
>> drivers/power/supply/ab8500_charger.c:1849: warning: Excess function parameter 'di' description in 'ab8500_charger_watchdog_kick'
   drivers/power/supply/ab8500_charger.c:1970: warning: Function parameter or member 'work' not described in 'ab8500_charger_check_vbat_work'
--
>> drivers/power/supply/ab8500_fg.c:70: warning: Function parameter or member 'isr' not described in 'ab8500_fg_interrupts'
>> drivers/power/supply/ab8500_fg.c:242: warning: Function parameter or member 'irq' not described in 'ab8500_fg'
>> drivers/power/supply/ab8500_fg.c:242: warning: Function parameter or member 'bat_temp' not described in 'ab8500_fg'
>> drivers/power/supply/ab8500_fg.c:242: warning: Function parameter or member 'low_bat_cnt' not described in 'ab8500_fg'
>> drivers/power/supply/ab8500_fg.c:242: warning: Function parameter or member 'nbr_cceoc_irq_cnt' not described in 'ab8500_fg'
>> drivers/power/supply/ab8500_fg.c:242: warning: Function parameter or member 'line_impedance_uohm' not described in 'ab8500_fg'
>> drivers/power/supply/ab8500_fg.c:242: warning: Function parameter or member 'calib_state' not described in 'ab8500_fg'
>> drivers/power/supply/ab8500_fg.c:242: warning: Function parameter or member 'ab8500_fg_started' not described in 'ab8500_fg'
>> drivers/power/supply/ab8500_fg.c:242: warning: Function parameter or member 'ab8500_fg_complete' not described in 'ab8500_fg'
>> drivers/power/supply/ab8500_fg.c:242: warning: Function parameter or member 'fg_reinit_work' not described in 'ab8500_fg'


vim +72 arch/arm/mm/cache-uniphier.c

e7ecbc057bc5cff Masahiro Yamada 2015-10-02  55  
e7ecbc057bc5cff Masahiro Yamada 2015-10-02  56  /* Is the operation region specified by address range? */
e7ecbc057bc5cff Masahiro Yamada 2015-10-02  57  #define UNIPHIER_SSCOQM_S_IS_RANGE(op) \
e7ecbc057bc5cff Masahiro Yamada 2015-10-02  58  		((op & UNIPHIER_SSCOQM_S_MASK) == UNIPHIER_SSCOQM_S_RANGE)
e7ecbc057bc5cff Masahiro Yamada 2015-10-02  59  
e7ecbc057bc5cff Masahiro Yamada 2015-10-02  60  /**
e7ecbc057bc5cff Masahiro Yamada 2015-10-02  61   * uniphier_cache_data - UniPhier outer cache specific data
e7ecbc057bc5cff Masahiro Yamada 2015-10-02  62   *
e7ecbc057bc5cff Masahiro Yamada 2015-10-02  63   * @ctrl_base: virtual base address of control registers
e7ecbc057bc5cff Masahiro Yamada 2015-10-02  64   * @rev_base: virtual base address of revision registers
e7ecbc057bc5cff Masahiro Yamada 2015-10-02  65   * @op_base: virtual base address of operation registers
06369a1e58bd5eb Masahiro Yamada 2017-02-01  66   * @way_mask: each bit specifies if the way is present
e7ecbc057bc5cff Masahiro Yamada 2015-10-02  67   * @nsets: number of associativity sets
e7ecbc057bc5cff Masahiro Yamada 2015-10-02  68   * @line_size: line size in bytes
e7ecbc057bc5cff Masahiro Yamada 2015-10-02  69   * @range_op_max_size: max size that can be handled by a single range operation
e7ecbc057bc5cff Masahiro Yamada 2015-10-02  70   * @list: list node to include this level in the whole cache hierarchy
e7ecbc057bc5cff Masahiro Yamada 2015-10-02  71   */
e7ecbc057bc5cff Masahiro Yamada 2015-10-02 @72  struct uniphier_cache_data {
e7ecbc057bc5cff Masahiro Yamada 2015-10-02  73  	void __iomem *ctrl_base;
e7ecbc057bc5cff Masahiro Yamada 2015-10-02  74  	void __iomem *rev_base;
e7ecbc057bc5cff Masahiro Yamada 2015-10-02  75  	void __iomem *op_base;
6427a840ff6aeaa Masahiro Yamada 2016-04-26  76  	void __iomem *way_ctrl_base;
06369a1e58bd5eb Masahiro Yamada 2017-02-01  77  	u32 way_mask;
e7ecbc057bc5cff Masahiro Yamada 2015-10-02  78  	u32 nsets;
e7ecbc057bc5cff Masahiro Yamada 2015-10-02  79  	u32 line_size;
e7ecbc057bc5cff Masahiro Yamada 2015-10-02  80  	u32 range_op_max_size;
e7ecbc057bc5cff Masahiro Yamada 2015-10-02  81  	struct list_head list;
e7ecbc057bc5cff Masahiro Yamada 2015-10-02  82  };
e7ecbc057bc5cff Masahiro Yamada 2015-10-02  83  

:::::: The code at line 72 was first introduced by commit
:::::: e7ecbc057bc5cffb8ad10b6bf7a80684fd426d23 ARM: uniphier: add outer cache support

:::::: TO: Masahiro Yamada <yamada.masahiro@socionext.com>
:::::: CC: Olof Johansson <olof@lixom.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
