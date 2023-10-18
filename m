Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34807CD5D2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 09:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344627AbjJRH6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 03:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjJRH6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 03:58:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE50C6;
        Wed, 18 Oct 2023 00:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697615910; x=1729151910;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7CsCblM7LOsvb1R6ZhggOe011s3+ZIIulQCoil7hgcc=;
  b=HYLiztXMXrbs+PHqmeJU8I8r/HeeB2plcfEB8xxzZF4hYtzo+RJLtYe/
   cvuYH8wg7kkHDfA+Au8ZmLovXD6KM5WNRj5+2MNVg07MJuwrjMubFaFjX
   BmLfP2IC1U0wIOcKN6PoGCQBG1AiTwcKNFG1EZhqKwiGS+AkshKN7F052
   z97pLHIZ7Vsg9XuKPbeRtnFmu24SN2hDZQtU5gLxikfCSj3KPI2JIhpSG
   gUxgb4DxiJFCziHsfwTeXwC8SNtaHFSH/q3whjAnO351L3R/6d4mFfQso
   sAON/AKPDsg6XZTn9Ss4CP3OmolJdBvTy4kLXq/NX0pxcVEOY1stCA1DK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="384843681"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="384843681"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 00:58:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="756467973"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="756467973"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 18 Oct 2023 00:58:23 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qt1Rd-00005c-0M;
        Wed, 18 Oct 2023 07:58:21 +0000
Date:   Wed, 18 Oct 2023 15:58:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-rockchip@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Chanwoo Choi <chanwoo@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Vincent Legoll <vincent.legoll@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v8 16/26] PM / devfreq: rockchip-dfi: Add perf support
Message-ID: <202310181557.GIXGL21M-lkp@intel.com>
References: <20231018061714.3553817-17-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018061714.3553817-17-s.hauer@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sascha,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.6-rc6]
[cannot apply to next-20231018]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sascha-Hauer/PM-devfreq-rockchip-dfi-Make-pmu-regmap-mandatory/20231018-142228
base:   linus/master
patch link:    https://lore.kernel.org/r/20231018061714.3553817-17-s.hauer%40pengutronix.de
patch subject: [PATCH v8 16/26] PM / devfreq: rockchip-dfi: Add perf support
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231018/202310181557.GIXGL21M-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231018/202310181557.GIXGL21M-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310181557.GIXGL21M-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/devfreq/event/rockchip-dfi.c:203:13: warning: 'rockchip_ddr_perf_counters_add' defined but not used [-Wunused-function]
     203 | static void rockchip_ddr_perf_counters_add(struct rockchip_dfi *dfi,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
>> drivers/devfreq/event/rockchip-dfi.c:79: warning: Function parameter or member 'write_access' not described in 'dmc_count_channel'


vim +/rockchip_ddr_perf_counters_add +203 drivers/devfreq/event/rockchip-dfi.c

    66	
    67	/**
    68	 * struct dmc_count_channel - structure to hold counter values from the DDR controller
    69	 * @access:       Number of read and write accesses
    70	 * @clock_cycles: DDR clock cycles
    71	 * @read_access:  number of read accesses
    72	 * @write_acccess: number of write accesses
    73	 */
    74	struct dmc_count_channel {
    75		u64 access;
    76		u64 clock_cycles;
    77		u64 read_access;
    78		u64 write_access;
  > 79	};
    80	
    81	struct dmc_count {
    82		struct dmc_count_channel c[DMC_MAX_CHANNELS];
    83	};
    84	
    85	/*
    86	 * The dfi controller can monitor DDR load. It has an upper and lower threshold
    87	 * for the operating points. Whenever the usage leaves these bounds an event is
    88	 * generated to indicate the DDR frequency should be changed.
    89	 */
    90	struct rockchip_dfi {
    91		struct devfreq_event_dev *edev;
    92		struct devfreq_event_desc desc;
    93		struct dmc_count last_event_count;
    94	
    95		struct dmc_count last_perf_count;
    96		struct dmc_count total_count;
    97		seqlock_t count_seqlock; /* protects last_perf_count and total_count */
    98	
    99		struct device *dev;
   100		void __iomem *regs;
   101		struct regmap *regmap_pmu;
   102		struct clk *clk;
   103		int usecount;
   104		struct mutex mutex;
   105		u32 ddr_type;
   106		unsigned int channel_mask;
   107		unsigned int max_channels;
   108		enum cpuhp_state cpuhp_state;
   109		struct hlist_node node;
   110		struct pmu pmu;
   111		struct hrtimer timer;
   112		unsigned int cpu;
   113		int active_events;
   114		int burst_len;
   115		int buswidth[DMC_MAX_CHANNELS];
   116	};
   117	
   118	static int rockchip_dfi_enable(struct rockchip_dfi *dfi)
   119	{
   120		void __iomem *dfi_regs = dfi->regs;
   121		int ret = 0;
   122	
   123		mutex_lock(&dfi->mutex);
   124	
   125		dfi->usecount++;
   126		if (dfi->usecount > 1)
   127			goto out;
   128	
   129		ret = clk_prepare_enable(dfi->clk);
   130		if (ret) {
   131			dev_err(&dfi->edev->dev, "failed to enable dfi clk: %d\n", ret);
   132			goto out;
   133		}
   134	
   135		/* clear DDRMON_CTRL setting */
   136		writel_relaxed(HIWORD_UPDATE(0, DDRMON_CTRL_TIMER_CNT_EN | DDRMON_CTRL_SOFTWARE_EN |
   137			       DDRMON_CTRL_HARDWARE_EN), dfi_regs + DDRMON_CTRL);
   138	
   139		/* set ddr type to dfi */
   140		switch (dfi->ddr_type) {
   141		case ROCKCHIP_DDRTYPE_LPDDR2:
   142		case ROCKCHIP_DDRTYPE_LPDDR3:
   143			writel_relaxed(HIWORD_UPDATE(DDRMON_CTRL_LPDDR23, DDRMON_CTRL_DDR_TYPE_MASK),
   144				       dfi_regs + DDRMON_CTRL);
   145			break;
   146		case ROCKCHIP_DDRTYPE_LPDDR4:
   147		case ROCKCHIP_DDRTYPE_LPDDR4X:
   148			writel_relaxed(HIWORD_UPDATE(DDRMON_CTRL_LPDDR4, DDRMON_CTRL_DDR_TYPE_MASK),
   149				       dfi_regs + DDRMON_CTRL);
   150			break;
   151		default:
   152			break;
   153		}
   154	
   155		/* enable count, use software mode */
   156		writel_relaxed(HIWORD_UPDATE(DDRMON_CTRL_SOFTWARE_EN, DDRMON_CTRL_SOFTWARE_EN),
   157			       dfi_regs + DDRMON_CTRL);
   158	out:
   159		mutex_unlock(&dfi->mutex);
   160	
   161		return ret;
   162	}
   163	
   164	static void rockchip_dfi_disable(struct rockchip_dfi *dfi)
   165	{
   166		void __iomem *dfi_regs = dfi->regs;
   167	
   168		mutex_lock(&dfi->mutex);
   169	
   170		dfi->usecount--;
   171	
   172		WARN_ON_ONCE(dfi->usecount < 0);
   173	
   174		if (dfi->usecount > 0)
   175			goto out;
   176	
   177		writel_relaxed(HIWORD_UPDATE(0, DDRMON_CTRL_SOFTWARE_EN),
   178			       dfi_regs + DDRMON_CTRL);
   179		clk_disable_unprepare(dfi->clk);
   180	out:
   181		mutex_unlock(&dfi->mutex);
   182	}
   183	
   184	static void rockchip_dfi_read_counters(struct rockchip_dfi *dfi, struct dmc_count *res)
   185	{
   186		u32 i;
   187		void __iomem *dfi_regs = dfi->regs;
   188	
   189		for (i = 0; i < dfi->max_channels; i++) {
   190			if (!(dfi->channel_mask & BIT(i)))
   191				continue;
   192			res->c[i].read_access = readl_relaxed(dfi_regs +
   193					DDRMON_CH0_RD_NUM + i * 20);
   194			res->c[i].write_access = readl_relaxed(dfi_regs +
   195					DDRMON_CH0_WR_NUM + i * 20);
   196			res->c[i].access = readl_relaxed(dfi_regs +
   197					DDRMON_CH0_DFI_ACCESS_NUM + i * 20);
   198			res->c[i].clock_cycles = readl_relaxed(dfi_regs +
   199					DDRMON_CH0_COUNT_NUM + i * 20);
   200		}
   201	}
   202	
 > 203	static void rockchip_ddr_perf_counters_add(struct rockchip_dfi *dfi,
   204						   const struct dmc_count *now,
   205						   struct dmc_count *res)
   206	{
   207		const struct dmc_count *last = &dfi->last_perf_count;
   208		int i;
   209	
   210		for (i = 0; i < dfi->max_channels; i++) {
   211			res->c[i].read_access = dfi->total_count.c[i].read_access +
   212				(u32)(now->c[i].read_access - last->c[i].read_access);
   213			res->c[i].write_access = dfi->total_count.c[i].write_access +
   214				(u32)(now->c[i].write_access - last->c[i].write_access);
   215			res->c[i].access = dfi->total_count.c[i].access +
   216				(u32)(now->c[i].access - last->c[i].access);
   217			res->c[i].clock_cycles = dfi->total_count.c[i].clock_cycles +
   218				(u32)(now->c[i].clock_cycles - last->c[i].clock_cycles);
   219		}
   220	}
   221	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
