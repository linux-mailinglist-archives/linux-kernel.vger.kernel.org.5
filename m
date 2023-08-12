Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6370677A08A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 16:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjHLOqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 10:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHLOqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 10:46:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CCC1B5;
        Sat, 12 Aug 2023 07:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691851581; x=1723387581;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YCfr+Nz7HHzCOXY0udKVpPrS0ljXtJL5gnyuyd57AMw=;
  b=L24JQcUww4+c1RQP0GW4r1l7idd1QDK1x/AR7xv5cZmzBxnOkWBtO5oT
   bi9iFZ23EuH3/RuA9K7WX9IwuTW3YOQki6fQCTOKc48pYr0xzcMZvNBch
   CkcqPrz5ILlPNgE9FPKisrUB7ZcVl3vVeiqZP6O6DNrvB6ZHpp7g+oeBW
   QkBQE8qy8MhbbWEeMew3j1dXhndN9lr0R2yfQ4ck4OhybT4aVuriRHiSb
   2HzMzxm99Uc4AR7iCJFY5ZMNABlz+AR/c3tlOfTiG6ovD73Izp2tu3LTe
   mGLYZL4kH8VexQBPzMlljlX9DB1+QuT2D8Ffa9NgmD/WbSto8Zj22Tp10
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10800"; a="370731525"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="370731525"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2023 07:46:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10800"; a="979503000"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="979503000"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 12 Aug 2023 07:46:16 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qUpsd-0008d2-1y;
        Sat, 12 Aug 2023 14:46:15 +0000
Date:   Sat, 12 Aug 2023 22:46:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aleksandr Shubin <privatesub2@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Aleksandr Shubin <privatesub2@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Andre Przywara <andre.przywara@arm.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 2/3] pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM
 support
Message-ID: <202308122212.SOHP09RP-lkp@intel.com>
References: <20230810145443.1053387-3-privatesub2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810145443.1053387-3-privatesub2@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aleksandr,

kernel test robot noticed the following build warnings:

[auto build test WARNING on thierry-reding-pwm/for-next]
[also build test WARNING on sunxi/sunxi/for-next robh/for-next linus/master v6.5-rc5 next-20230809]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aleksandr-Shubin/dt-bindings-pwm-Add-binding-for-Allwinner-D1-T113-S3-R329-PWM-controller/20230810-225849
base:   https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git for-next
patch link:    https://lore.kernel.org/r/20230810145443.1053387-3-privatesub2%40gmail.com
patch subject: [PATCH v4 2/3] pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM support
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230812/202308122212.SOHP09RP-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230812/202308122212.SOHP09RP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308122212.SOHP09RP-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pwm/pwm-sun20i.c: In function 'sun20i_pwm_apply':
>> drivers/pwm/pwm-sun20i.c:121:48: warning: unused variable 'tmp' [-Wunused-variable]
     121 |         u64 bus_rate, hosc_rate, clk_div, val, tmp;
         |                                                ^~~


vim +/tmp +121 drivers/pwm/pwm-sun20i.c

   115	
   116	static int sun20i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
   117				    const struct pwm_state *state)
   118	{
   119		struct sun20i_pwm_chip *sun20i_chip = to_sun20i_pwm_chip(chip);
   120		u32 clk_gate, clk_cfg, pwm_en, ctl, period;
 > 121		u64 bus_rate, hosc_rate, clk_div, val, tmp;
   122		u32 prescaler, div_m;
   123		bool use_bus_clk;
   124		int ret = 0;
   125	
   126		mutex_lock(&sun20i_chip->mutex);
   127	
   128		pwm_en = sun20i_pwm_readl(sun20i_chip, PWM_ENABLE);
   129	
   130		if (state->enabled != pwm->state.enabled)
   131			clk_gate = sun20i_pwm_readl(sun20i_chip, PWM_CLK_GATE);
   132	
   133		if (state->enabled != pwm->state.enabled && !state->enabled) {
   134			clk_gate &= ~PWM_CLK_GATE_GATING(pwm->hwpwm);
   135			pwm_en &= ~PWM_ENABLE_EN(pwm->hwpwm);
   136			sun20i_pwm_writel(sun20i_chip, pwm_en, PWM_ENABLE);
   137			sun20i_pwm_writel(sun20i_chip, clk_gate, PWM_CLK_GATE);
   138		}
   139	
   140		if (state->polarity != pwm->state.polarity ||
   141		    state->duty_cycle != pwm->state.duty_cycle ||
   142		    state->period != pwm->state.period) {
   143			ctl = sun20i_pwm_readl(sun20i_chip, PWM_CTL(pwm->hwpwm));
   144			clk_cfg = sun20i_pwm_readl(sun20i_chip, PWM_CLK_CFG(pwm->hwpwm));
   145			hosc_rate = clk_get_rate(sun20i_chip->clk_hosc);
   146			bus_rate = clk_get_rate(sun20i_chip->clk_bus);
   147			if (pwm_en & PWM_ENABLE_EN(pwm->hwpwm ^ 1)) {
   148				/* if the neighbor channel is enable, check period only */
   149				use_bus_clk = FIELD_GET(PWM_CLK_CFG_SRC, clk_cfg) != 0;
   150				val = state->period * (use_bus_clk ? bus_rate : hosc_rate);
   151				do_div(val, NSEC_PER_SEC);
   152	
   153				div_m = FIELD_GET(PWM_CLK_CFG_DIV_M, clk_cfg);
   154			} else {
   155				/* check period and select clock source */
   156				use_bus_clk = false;
   157				val = state->period * hosc_rate;
   158				do_div(val, NSEC_PER_SEC);
   159				if (val <= 1) {
   160					use_bus_clk = true;
   161					val = state->period * bus_rate;
   162					do_div(val, NSEC_PER_SEC);
   163					if (val <= 1) {
   164						ret = -EINVAL;
   165						goto unlock_mutex;
   166					}
   167				}
   168				div_m = fls(DIV_ROUND_DOWN_ULL(val, PWM_MAGIC));
   169				if (div_m >= 9) {
   170					ret = -EINVAL;
   171					goto unlock_mutex;
   172				}
   173	
   174				/* set up the CLK_DIV_M and clock CLK_SRC */
   175				clk_cfg = FIELD_PREP(PWM_CLK_CFG_DIV_M, div_m);
   176				clk_cfg |= FIELD_PREP(PWM_CLK_CFG_SRC, use_bus_clk);
   177	
   178				sun20i_pwm_writel(sun20i_chip, clk_cfg, PWM_CLK_CFG(pwm->hwpwm));
   179			}
   180	
   181			/* calculate prescaler, PWM entire cycle */
   182			clk_div = val >> div_m;
   183			if (clk_div <= 65534) {
   184				prescaler = 0;
   185			} else {
   186				prescaler = DIV_ROUND_UP_ULL(clk_div - 65534, 65535);
   187				if (prescaler >= 256) {
   188					ret = -EINVAL;
   189					goto unlock_mutex;
   190				}
   191				do_div(clk_div, prescaler + 1);
   192			}
   193	
   194			period = FIELD_PREP(PWM_PERIOD_ENTIRE_CYCLE, clk_div);
   195	
   196			/* set duty cycle */
   197			val = state->duty_cycle * (use_bus_clk ? bus_rate : hosc_rate);
   198			do_div(val, NSEC_PER_SEC);
   199			clk_div = val >> div_m;
   200			do_div(clk_div, prescaler + 1);
   201	
   202			/*
   203			 * The formula of the output period and the duty-cycle for PWM are as follows.
   204			 * T period = (PWM01_CLK / PWM0_PRESCALE_K)^-1 * (PPR0.PWM_ENTIRE_CYCLE + 1)
   205			 * T high-level = (PWM01_CLK / PWM0_PRESCALE_K)^-1 * PPR0.PWM_ACT_CYCLE
   206			 * Duty-cycle = T high-level / T period
   207			 * In accordance with this formula, in order to set the duty-cycle to 100%,
   208			 * it is necessary that PWM_ACT_CYCLE >= PWM_ENTIRE_CYCLE + 1
   209			 */
   210			if (state->duty_cycle == state->period)
   211				clk_div++;
   212			period |= FIELD_PREP(PWM_PERIOD_ACT_CYCLE, clk_div);
   213			sun20i_pwm_writel(sun20i_chip, period, PWM_PERIOD(pwm->hwpwm));
   214	
   215			ctl = FIELD_PREP(PWM_CTL_PRESCAL_K, prescaler);
   216			if (state->polarity == PWM_POLARITY_NORMAL)
   217				ctl |= PWM_CTL_ACT_STA;
   218	
   219			sun20i_pwm_writel(sun20i_chip, ctl, PWM_CTL(pwm->hwpwm));
   220		}
   221	
   222		if (state->enabled != pwm->state.enabled && state->enabled) {
   223			clk_gate &= ~PWM_CLK_GATE_BYPASS(pwm->hwpwm);
   224			clk_gate |= PWM_CLK_GATE_GATING(pwm->hwpwm);
   225			pwm_en |= PWM_ENABLE_EN(pwm->hwpwm);
   226			sun20i_pwm_writel(sun20i_chip, pwm_en, PWM_ENABLE);
   227			sun20i_pwm_writel(sun20i_chip, clk_gate, PWM_CLK_GATE);
   228		}
   229	
   230	unlock_mutex:
   231		mutex_unlock(&sun20i_chip->mutex);
   232	
   233		return ret;
   234	}
   235	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
