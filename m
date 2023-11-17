Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBE67EF3B4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 14:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjKQNaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 08:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQNaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 08:30:20 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3ACD4B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 05:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700227816; x=1731763816;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yajHqxO2vyLALn8JMoL2xZqghCmkvRZBineKEVAkJGE=;
  b=etsxJWzPDlEyVaS8YSBLsXdg4EH4fexmnX23C+PlDd7Vw+X6t5sgbKTx
   MepeXwjYKXpVcVYsXrq1U/j4BEvb2fBVxQLhRjnVzGdq3SqxUavb3qmlF
   N0vZKOBaG2OE2cQ/9j9qwPpfi+h7nlcZ5ybnwL345Yynjo36TjAc2oRss
   yxiYiHBr/4k3qE2YSADhe42asuFxV1tovZPlGZ4jfWC7oPy1+7bRzagPn
   Ww/zGX3/okt7iD9fuJ+YCjgvgfdGP5prVafaztBtCyf0dz5Eg7Hq9IkKL
   bFKxSP7mJOJgaj1WjKDgZ5YScob4GaDWglCr/3+39GUOVXEEMpszu1sbh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="12846453"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="12846453"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 05:30:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="1012933898"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="1012933898"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 17 Nov 2023 05:30:14 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r3yvE-0002pZ-0c;
        Fri, 17 Nov 2023 13:30:12 +0000
Date:   Fri, 17 Nov 2023 21:30:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c:63: warning: Function
 parameter or member 'parent_rate' not described in 'omap2_table_mpu_recalc'
Message-ID: <202311172108.UYDpxcdv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7475e51b87969e01a6812eac713a1c8310372e8a
commit: 2934167dd02b4fb5f6c57b36c92b3af23e8bad9f ARM: realview: enable multiplatform
date:   8 years ago
config: arm-randconfig-003-20230915 (https://download.01.org/0day-ci/archive/20231117/202311172108.UYDpxcdv-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231117/202311172108.UYDpxcdv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311172108.UYDpxcdv-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/cpumask.h:11,
                    from include/linux/rcupdate.h:40,
                    from include/linux/srcu.h:33,
                    from include/linux/notifier.h:15,
                    from include/linux/clk.h:17,
                    from arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c:31:
   include/linux/bitmap.h: In function 'bitmap_empty':
   include/linux/bitmap.h:287:43: warning: comparison of integer expressions of different signedness: 'int' and 'unsigned int' [-Wsign-compare]
     287 |         return find_first_bit(src, nbits) == nbits;
         |                                           ^~
   include/linux/bitmap.h: In function 'bitmap_full':
   include/linux/bitmap.h:295:48: warning: comparison of integer expressions of different signedness: 'int' and 'unsigned int' [-Wsign-compare]
     295 |         return find_first_zero_bit(src, nbits) == nbits;
         |                                                ^~
>> arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c:63: warning: Function parameter or member 'parent_rate' not described in 'omap2_table_mpu_recalc'
>> arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c:174: warning: expecting prototype for omap2xxx_clkt_vps_check_bootloader_rate(). Prototype was for omap2xxx_clkt_vps_check_bootloader_rates() instead
--
   In file included from include/linux/cpumask.h:11,
                    from include/linux/rcupdate.h:40,
                    from include/linux/srcu.h:33,
                    from include/linux/notifier.h:15,
                    from include/linux/clk.h:17,
                    from arch/arm/mach-omap2/omap2-restart.c:13:
   include/linux/bitmap.h: In function 'bitmap_empty':
   include/linux/bitmap.h:287:43: warning: comparison of integer expressions of different signedness: 'int' and 'unsigned int' [-Wsign-compare]
     287 |         return find_first_bit(src, nbits) == nbits;
         |                                           ^~
   include/linux/bitmap.h: In function 'bitmap_full':
   include/linux/bitmap.h:295:48: warning: comparison of integer expressions of different signedness: 'int' and 'unsigned int' [-Wsign-compare]
     295 |         return find_first_zero_bit(src, nbits) == nbits;
         |                                                ^~
>> arch/arm/mach-omap2/omap2-restart.c:35: warning: Function parameter or member 'mode' not described in 'omap2xxx_restart'
>> arch/arm/mach-omap2/omap2-restart.c:35: warning: Function parameter or member 'cmd' not described in 'omap2xxx_restart'
--
   In file included from include/linux/cpumask.h:11,
                    from include/linux/rcupdate.h:40,
                    from include/linux/srcu.h:33,
                    from include/linux/notifier.h:15,
                    from include/linux/clk.h:17,
                    from arch/arm/mach-omap2/clkt2xxx_dpllcore.c:25:
   include/linux/bitmap.h: In function 'bitmap_empty':
   include/linux/bitmap.h:287:43: warning: comparison of integer expressions of different signedness: 'int' and 'unsigned int' [-Wsign-compare]
     287 |         return find_first_bit(src, nbits) == nbits;
         |                                           ^~
   include/linux/bitmap.h: In function 'bitmap_full':
   include/linux/bitmap.h:295:48: warning: comparison of integer expressions of different signedness: 'int' and 'unsigned int' [-Wsign-compare]
     295 |         return find_first_zero_bit(src, nbits) == nbits;
         |                                                ^~
>> arch/arm/mach-omap2/clkt2xxx_dpllcore.c:192: warning: Function parameter or member 'hw' not described in 'omap2xxx_clkt_dpllcore_init'
>> arch/arm/mach-omap2/clkt2xxx_dpllcore.c:192: warning: Excess function parameter 'clk' description in 'omap2xxx_clkt_dpllcore_init'
--
   In file included from include/linux/cpumask.h:11,
                    from include/linux/rcupdate.h:40,
                    from include/linux/srcu.h:33,
                    from include/linux/notifier.h:15,
                    from include/linux/clk.h:17,
                    from drivers/clk/ti/dpll.c:18:
   include/linux/bitmap.h: In function 'bitmap_empty':
   include/linux/bitmap.h:287:43: warning: comparison of integer expressions of different signedness: 'int' and 'unsigned int' [-Wsign-compare]
     287 |         return find_first_bit(src, nbits) == nbits;
         |                                           ^~
   include/linux/bitmap.h: In function 'bitmap_full':
   include/linux/bitmap.h:295:48: warning: comparison of integer expressions of different signedness: 'int' and 'unsigned int' [-Wsign-compare]
     295 |         return find_first_zero_bit(src, nbits) == nbits;
         |                                                ^~
   drivers/clk/ti/dpll.c: At top level:
>> drivers/clk/ti/dpll.c:130:29: warning: 'dpll_x2_ck_ops' defined but not used [-Wunused-const-variable=]
     130 | static const struct clk_ops dpll_x2_ck_ops = {
         |                             ^~~~~~~~~~~~~~
   drivers/clk/ti/dpll.c:101:29: warning: 'omap3_dpll_core_ck_ops' defined but not used [-Wunused-const-variable=]
     101 | static const struct clk_ops omap3_dpll_core_ck_ops = {};
         |                             ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/clk/ti/dpll.c:44:29: warning: 'dpll_m4xen_ck_ops' defined but not used [-Wunused-const-variable=]
      44 | static const struct clk_ops dpll_m4xen_ck_ops = {};
         |                             ^~~~~~~~~~~~~~~~~


vim +63 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c

baa689b8b2e9a6 Paul Walmsley  2012-10-29   54  
734f69a773d8ff Paul Walmsley  2010-01-26   55  /**
734f69a773d8ff Paul Walmsley  2010-01-26   56   * omap2_table_mpu_recalc - just return the MPU speed
734f69a773d8ff Paul Walmsley  2010-01-26   57   * @clk: virt_prcm_set struct clk
734f69a773d8ff Paul Walmsley  2010-01-26   58   *
734f69a773d8ff Paul Walmsley  2010-01-26   59   * Set virt_prcm_set's rate to the mpu_speed field of the current PRCM set.
734f69a773d8ff Paul Walmsley  2010-01-26   60   */
ed1ebc4948fdfe Rajendra Nayak 2012-04-27   61  unsigned long omap2_table_mpu_recalc(struct clk_hw *clk,
ed1ebc4948fdfe Rajendra Nayak 2012-04-27   62  				     unsigned long parent_rate)
734f69a773d8ff Paul Walmsley  2010-01-26  @63  {
734f69a773d8ff Paul Walmsley  2010-01-26   64  	return curr_prcm_set->mpu_speed;
734f69a773d8ff Paul Walmsley  2010-01-26   65  }
734f69a773d8ff Paul Walmsley  2010-01-26   66  
734f69a773d8ff Paul Walmsley  2010-01-26   67  /*
734f69a773d8ff Paul Walmsley  2010-01-26   68   * Look for a rate equal or less than the target rate given a configuration set.
734f69a773d8ff Paul Walmsley  2010-01-26   69   *
734f69a773d8ff Paul Walmsley  2010-01-26   70   * What's not entirely clear is "which" field represents the key field.
734f69a773d8ff Paul Walmsley  2010-01-26   71   * Some might argue L3-DDR, others ARM, others IVA. This code is simple and
734f69a773d8ff Paul Walmsley  2010-01-26   72   * just uses the ARM rates.
734f69a773d8ff Paul Walmsley  2010-01-26   73   */
ed1ebc4948fdfe Rajendra Nayak 2012-04-27   74  long omap2_round_to_table_rate(struct clk_hw *hw, unsigned long rate,
ed1ebc4948fdfe Rajendra Nayak 2012-04-27   75  			       unsigned long *parent_rate)
734f69a773d8ff Paul Walmsley  2010-01-26   76  {
734f69a773d8ff Paul Walmsley  2010-01-26   77  	const struct prcm_config *ptr;
baa689b8b2e9a6 Paul Walmsley  2012-10-29   78  	long highest_rate;
734f69a773d8ff Paul Walmsley  2010-01-26   79  
734f69a773d8ff Paul Walmsley  2010-01-26   80  	highest_rate = -EINVAL;
734f69a773d8ff Paul Walmsley  2010-01-26   81  
734f69a773d8ff Paul Walmsley  2010-01-26   82  	for (ptr = rate_table; ptr->mpu_speed; ptr++) {
734f69a773d8ff Paul Walmsley  2010-01-26   83  		if (!(ptr->flags & cpu_mask))
734f69a773d8ff Paul Walmsley  2010-01-26   84  			continue;
baa689b8b2e9a6 Paul Walmsley  2012-10-29   85  		if (ptr->xtal_speed != sys_ck_rate)
734f69a773d8ff Paul Walmsley  2010-01-26   86  			continue;
734f69a773d8ff Paul Walmsley  2010-01-26   87  
734f69a773d8ff Paul Walmsley  2010-01-26   88  		highest_rate = ptr->mpu_speed;
734f69a773d8ff Paul Walmsley  2010-01-26   89  
734f69a773d8ff Paul Walmsley  2010-01-26   90  		/* Can check only after xtal frequency check */
734f69a773d8ff Paul Walmsley  2010-01-26   91  		if (ptr->mpu_speed <= rate)
734f69a773d8ff Paul Walmsley  2010-01-26   92  			break;
734f69a773d8ff Paul Walmsley  2010-01-26   93  	}
734f69a773d8ff Paul Walmsley  2010-01-26   94  	return highest_rate;
734f69a773d8ff Paul Walmsley  2010-01-26   95  }
734f69a773d8ff Paul Walmsley  2010-01-26   96  
734f69a773d8ff Paul Walmsley  2010-01-26   97  /* Sets basic clocks based on the specified rate */
ed1ebc4948fdfe Rajendra Nayak 2012-04-27   98  int omap2_select_table_rate(struct clk_hw *hw, unsigned long rate,
ed1ebc4948fdfe Rajendra Nayak 2012-04-27   99  			    unsigned long parent_rate)
734f69a773d8ff Paul Walmsley  2010-01-26  100  {
cd6e9db27728e8 Tero Kristo    2013-10-11  101  	u32 cur_rate, done_rate, bypass = 0;
734f69a773d8ff Paul Walmsley  2010-01-26  102  	const struct prcm_config *prcm;
734f69a773d8ff Paul Walmsley  2010-01-26  103  	unsigned long found_speed = 0;
734f69a773d8ff Paul Walmsley  2010-01-26  104  	unsigned long flags;
734f69a773d8ff Paul Walmsley  2010-01-26  105  
734f69a773d8ff Paul Walmsley  2010-01-26  106  	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
734f69a773d8ff Paul Walmsley  2010-01-26  107  		if (!(prcm->flags & cpu_mask))
734f69a773d8ff Paul Walmsley  2010-01-26  108  			continue;
734f69a773d8ff Paul Walmsley  2010-01-26  109  
baa689b8b2e9a6 Paul Walmsley  2012-10-29  110  		if (prcm->xtal_speed != sys_ck_rate)
734f69a773d8ff Paul Walmsley  2010-01-26  111  			continue;
734f69a773d8ff Paul Walmsley  2010-01-26  112  
734f69a773d8ff Paul Walmsley  2010-01-26  113  		if (prcm->mpu_speed <= rate) {
734f69a773d8ff Paul Walmsley  2010-01-26  114  			found_speed = prcm->mpu_speed;
734f69a773d8ff Paul Walmsley  2010-01-26  115  			break;
734f69a773d8ff Paul Walmsley  2010-01-26  116  		}
734f69a773d8ff Paul Walmsley  2010-01-26  117  	}
734f69a773d8ff Paul Walmsley  2010-01-26  118  
734f69a773d8ff Paul Walmsley  2010-01-26  119  	if (!found_speed) {
734f69a773d8ff Paul Walmsley  2010-01-26  120  		printk(KERN_INFO "Could not set MPU rate to %luMHz\n",
734f69a773d8ff Paul Walmsley  2010-01-26  121  		       rate / 1000000);
734f69a773d8ff Paul Walmsley  2010-01-26  122  		return -EINVAL;
734f69a773d8ff Paul Walmsley  2010-01-26  123  	}
734f69a773d8ff Paul Walmsley  2010-01-26  124  
734f69a773d8ff Paul Walmsley  2010-01-26  125  	curr_prcm_set = prcm;
5f03937700e399 Paul Walmsley  2012-10-29  126  	cur_rate = omap2xxx_clk_get_core_rate();
734f69a773d8ff Paul Walmsley  2010-01-26  127  
734f69a773d8ff Paul Walmsley  2010-01-26  128  	if (prcm->dpll_speed == cur_rate / 2) {
734f69a773d8ff Paul Walmsley  2010-01-26  129  		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL, 1);
734f69a773d8ff Paul Walmsley  2010-01-26  130  	} else if (prcm->dpll_speed == cur_rate * 2) {
734f69a773d8ff Paul Walmsley  2010-01-26  131  		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL_X2, 1);
734f69a773d8ff Paul Walmsley  2010-01-26  132  	} else if (prcm->dpll_speed != cur_rate) {
734f69a773d8ff Paul Walmsley  2010-01-26  133  		local_irq_save(flags);
734f69a773d8ff Paul Walmsley  2010-01-26  134  
734f69a773d8ff Paul Walmsley  2010-01-26  135  		if (prcm->dpll_speed == prcm->xtal_speed)
734f69a773d8ff Paul Walmsley  2010-01-26  136  			bypass = 1;
734f69a773d8ff Paul Walmsley  2010-01-26  137  
734f69a773d8ff Paul Walmsley  2010-01-26  138  		if ((prcm->cm_clksel2_pll & OMAP24XX_CORE_CLK_SRC_MASK) ==
734f69a773d8ff Paul Walmsley  2010-01-26  139  		    CORE_CLK_SRC_DPLL_X2)
734f69a773d8ff Paul Walmsley  2010-01-26  140  			done_rate = CORE_CLK_SRC_DPLL_X2;
734f69a773d8ff Paul Walmsley  2010-01-26  141  		else
734f69a773d8ff Paul Walmsley  2010-01-26  142  			done_rate = CORE_CLK_SRC_DPLL;
734f69a773d8ff Paul Walmsley  2010-01-26  143  
cd6e9db27728e8 Tero Kristo    2013-10-11  144  		omap2xxx_cm_set_mod_dividers(prcm->cm_clksel_mpu,
cd6e9db27728e8 Tero Kristo    2013-10-11  145  					     prcm->cm_clksel_dsp,
cd6e9db27728e8 Tero Kristo    2013-10-11  146  					     prcm->cm_clksel_gfx,
cd6e9db27728e8 Tero Kristo    2013-10-11  147  					     prcm->cm_clksel1_core,
cd6e9db27728e8 Tero Kristo    2013-10-11  148  					     prcm->cm_clksel_mdm);
734f69a773d8ff Paul Walmsley  2010-01-26  149  
734f69a773d8ff Paul Walmsley  2010-01-26  150  		/* x2 to enter omap2xxx_sdrc_init_params() */
734f69a773d8ff Paul Walmsley  2010-01-26  151  		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL_X2, 1);
734f69a773d8ff Paul Walmsley  2010-01-26  152  
734f69a773d8ff Paul Walmsley  2010-01-26  153  		omap2_set_prcm(prcm->cm_clksel1_pll, prcm->base_sdrc_rfr,
734f69a773d8ff Paul Walmsley  2010-01-26  154  			       bypass);
734f69a773d8ff Paul Walmsley  2010-01-26  155  
734f69a773d8ff Paul Walmsley  2010-01-26  156  		omap2xxx_sdrc_init_params(omap2xxx_sdrc_dll_is_unlocked());
734f69a773d8ff Paul Walmsley  2010-01-26  157  		omap2xxx_sdrc_reprogram(done_rate, 0);
734f69a773d8ff Paul Walmsley  2010-01-26  158  
734f69a773d8ff Paul Walmsley  2010-01-26  159  		local_irq_restore(flags);
734f69a773d8ff Paul Walmsley  2010-01-26  160  	}
734f69a773d8ff Paul Walmsley  2010-01-26  161  
734f69a773d8ff Paul Walmsley  2010-01-26  162  	return 0;
734f69a773d8ff Paul Walmsley  2010-01-26  163  }
baa689b8b2e9a6 Paul Walmsley  2012-10-29  164  
baa689b8b2e9a6 Paul Walmsley  2012-10-29  165  /**
baa689b8b2e9a6 Paul Walmsley  2012-10-29  166   * omap2xxx_clkt_vps_check_bootloader_rate - determine which of the rate
baa689b8b2e9a6 Paul Walmsley  2012-10-29  167   * table sets matches the current CORE DPLL hardware rate
baa689b8b2e9a6 Paul Walmsley  2012-10-29  168   *
baa689b8b2e9a6 Paul Walmsley  2012-10-29  169   * Check the MPU rate set by bootloader.  Sets the 'curr_prcm_set'
baa689b8b2e9a6 Paul Walmsley  2012-10-29  170   * global to point to the active rate set when found; otherwise, sets
baa689b8b2e9a6 Paul Walmsley  2012-10-29  171   * it to NULL.  No return value;
baa689b8b2e9a6 Paul Walmsley  2012-10-29  172   */
baa689b8b2e9a6 Paul Walmsley  2012-10-29  173  void omap2xxx_clkt_vps_check_bootloader_rates(void)
baa689b8b2e9a6 Paul Walmsley  2012-10-29 @174  {
baa689b8b2e9a6 Paul Walmsley  2012-10-29  175  	const struct prcm_config *prcm = NULL;
baa689b8b2e9a6 Paul Walmsley  2012-10-29  176  	unsigned long rate;
baa689b8b2e9a6 Paul Walmsley  2012-10-29  177  
baa689b8b2e9a6 Paul Walmsley  2012-10-29  178  	rate = omap2xxx_clk_get_core_rate();
baa689b8b2e9a6 Paul Walmsley  2012-10-29  179  	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
baa689b8b2e9a6 Paul Walmsley  2012-10-29  180  		if (!(prcm->flags & cpu_mask))
baa689b8b2e9a6 Paul Walmsley  2012-10-29  181  			continue;
baa689b8b2e9a6 Paul Walmsley  2012-10-29  182  		if (prcm->xtal_speed != sys_ck_rate)
baa689b8b2e9a6 Paul Walmsley  2012-10-29  183  			continue;
baa689b8b2e9a6 Paul Walmsley  2012-10-29  184  		if (prcm->dpll_speed <= rate)
baa689b8b2e9a6 Paul Walmsley  2012-10-29  185  			break;
baa689b8b2e9a6 Paul Walmsley  2012-10-29  186  	}
baa689b8b2e9a6 Paul Walmsley  2012-10-29  187  	curr_prcm_set = prcm;
baa689b8b2e9a6 Paul Walmsley  2012-10-29  188  }
baa689b8b2e9a6 Paul Walmsley  2012-10-29  189  

:::::: The code at line 63 was first introduced by commit
:::::: 734f69a773d8ff65111562116c18c987049ddac4 OMAP2xxx clock: move the DVFS virtual clock code into mach-omap2/clkt2xxx_virt_prcm_set.c

:::::: TO: Paul Walmsley <paul@pwsan.com>
:::::: CC: Paul Walmsley <paul@pwsan.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
