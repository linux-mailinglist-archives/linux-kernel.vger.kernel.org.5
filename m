Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8407CF073
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 08:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344730AbjJSGxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 02:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjJSGxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 02:53:05 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56311116
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 23:53:02 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qtMtZ-0008N8-0Z; Thu, 19 Oct 2023 08:52:37 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qtMtX-002jMJ-SI; Thu, 19 Oct 2023 08:52:35 +0200
Received: from sha by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qtMtX-00FE1j-Nd; Thu, 19 Oct 2023 08:52:35 +0200
Date:   Thu, 19 Oct 2023 08:52:35 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Chanwoo Choi <chanwoo@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        linux-rockchip@lists.infradead.org, oe-kbuild-all@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
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
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v8 16/26] PM / devfreq: rockchip-dfi: Add perf support
Message-ID: <20231019065235.GL3359458@pengutronix.de>
References: <20231018061714.3553817-17-s.hauer@pengutronix.de>
 <202310181557.GIXGL21M-lkp@intel.com>
 <f5ce51a4-d47d-4074-9498-8632b09791e6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5ce51a4-d47d-4074-9498-8632b09791e6@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On Thu, Oct 19, 2023 at 12:11:14AM +0900, Chanwoo Choi wrote:
> Hi Sascha, 
> 
> Could you plesae fix the following kernel build report?

Just did that as a reply to the original patch. I moved
rockchip_ddr_perf_counters_add() inside the #ifdef CONFIG_PERF_EVENTS

Thanks for reviewing this series and for bringing it forward.

Sascha

> 
> On 23. 10. 18. 16:58, kernel test robot wrote:
> > Hi Sascha,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > [auto build test WARNING on linus/master]
> > [also build test WARNING on v6.6-rc6]
> > [cannot apply to next-20231018]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Sascha-Hauer/PM-devfreq-rockchip-dfi-Make-pmu-regmap-mandatory/20231018-142228
> > base:   linus/master
> > patch link:    https://lore.kernel.org/r/20231018061714.3553817-17-s.hauer%40pengutronix.de
> > patch subject: [PATCH v8 16/26] PM / devfreq: rockchip-dfi: Add perf support
> > config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231018/202310181557.GIXGL21M-lkp@intel.com/config)
> > compiler: m68k-linux-gcc (GCC) 13.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231018/202310181557.GIXGL21M-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202310181557.GIXGL21M-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> >>> drivers/devfreq/event/rockchip-dfi.c:203:13: warning: 'rockchip_ddr_perf_counters_add' defined but not used [-Wunused-function]
> >      203 | static void rockchip_ddr_perf_counters_add(struct rockchip_dfi *dfi,
> >          |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > --
> >>> drivers/devfreq/event/rockchip-dfi.c:79: warning: Function parameter or member 'write_access' not described in 'dmc_count_channel'
> > 
> > 
> > vim +/rockchip_ddr_perf_counters_add +203 drivers/devfreq/event/rockchip-dfi.c
> > 
> >     66	
> >     67	/**
> >     68	 * struct dmc_count_channel - structure to hold counter values from the DDR controller
> >     69	 * @access:       Number of read and write accesses
> >     70	 * @clock_cycles: DDR clock cycles
> >     71	 * @read_access:  number of read accesses
> >     72	 * @write_acccess: number of write accesses
> >     73	 */
> >     74	struct dmc_count_channel {
> >     75		u64 access;
> >     76		u64 clock_cycles;
> >     77		u64 read_access;
> >     78		u64 write_access;
> >   > 79	};
> >     80	
> >     81	struct dmc_count {
> >     82		struct dmc_count_channel c[DMC_MAX_CHANNELS];
> >     83	};
> >     84	
> >     85	/*
> >     86	 * The dfi controller can monitor DDR load. It has an upper and lower threshold
> >     87	 * for the operating points. Whenever the usage leaves these bounds an event is
> >     88	 * generated to indicate the DDR frequency should be changed.
> >     89	 */
> >     90	struct rockchip_dfi {
> >     91		struct devfreq_event_dev *edev;
> >     92		struct devfreq_event_desc desc;
> >     93		struct dmc_count last_event_count;
> >     94	
> >     95		struct dmc_count last_perf_count;
> >     96		struct dmc_count total_count;
> >     97		seqlock_t count_seqlock; /* protects last_perf_count and total_count */
> >     98	
> >     99		struct device *dev;
> >    100		void __iomem *regs;
> >    101		struct regmap *regmap_pmu;
> >    102		struct clk *clk;
> >    103		int usecount;
> >    104		struct mutex mutex;
> >    105		u32 ddr_type;
> >    106		unsigned int channel_mask;
> >    107		unsigned int max_channels;
> >    108		enum cpuhp_state cpuhp_state;
> >    109		struct hlist_node node;
> >    110		struct pmu pmu;
> >    111		struct hrtimer timer;
> >    112		unsigned int cpu;
> >    113		int active_events;
> >    114		int burst_len;
> >    115		int buswidth[DMC_MAX_CHANNELS];
> >    116	};
> >    117	
> >    118	static int rockchip_dfi_enable(struct rockchip_dfi *dfi)
> >    119	{
> >    120		void __iomem *dfi_regs = dfi->regs;
> >    121		int ret = 0;
> >    122	
> >    123		mutex_lock(&dfi->mutex);
> >    124	
> >    125		dfi->usecount++;
> >    126		if (dfi->usecount > 1)
> >    127			goto out;
> >    128	
> >    129		ret = clk_prepare_enable(dfi->clk);
> >    130		if (ret) {
> >    131			dev_err(&dfi->edev->dev, "failed to enable dfi clk: %d\n", ret);
> >    132			goto out;
> >    133		}
> >    134	
> >    135		/* clear DDRMON_CTRL setting */
> >    136		writel_relaxed(HIWORD_UPDATE(0, DDRMON_CTRL_TIMER_CNT_EN | DDRMON_CTRL_SOFTWARE_EN |
> >    137			       DDRMON_CTRL_HARDWARE_EN), dfi_regs + DDRMON_CTRL);
> >    138	
> >    139		/* set ddr type to dfi */
> >    140		switch (dfi->ddr_type) {
> >    141		case ROCKCHIP_DDRTYPE_LPDDR2:
> >    142		case ROCKCHIP_DDRTYPE_LPDDR3:
> >    143			writel_relaxed(HIWORD_UPDATE(DDRMON_CTRL_LPDDR23, DDRMON_CTRL_DDR_TYPE_MASK),
> >    144				       dfi_regs + DDRMON_CTRL);
> >    145			break;
> >    146		case ROCKCHIP_DDRTYPE_LPDDR4:
> >    147		case ROCKCHIP_DDRTYPE_LPDDR4X:
> >    148			writel_relaxed(HIWORD_UPDATE(DDRMON_CTRL_LPDDR4, DDRMON_CTRL_DDR_TYPE_MASK),
> >    149				       dfi_regs + DDRMON_CTRL);
> >    150			break;
> >    151		default:
> >    152			break;
> >    153		}
> >    154	
> >    155		/* enable count, use software mode */
> >    156		writel_relaxed(HIWORD_UPDATE(DDRMON_CTRL_SOFTWARE_EN, DDRMON_CTRL_SOFTWARE_EN),
> >    157			       dfi_regs + DDRMON_CTRL);
> >    158	out:
> >    159		mutex_unlock(&dfi->mutex);
> >    160	
> >    161		return ret;
> >    162	}
> >    163	
> >    164	static void rockchip_dfi_disable(struct rockchip_dfi *dfi)
> >    165	{
> >    166		void __iomem *dfi_regs = dfi->regs;
> >    167	
> >    168		mutex_lock(&dfi->mutex);
> >    169	
> >    170		dfi->usecount--;
> >    171	
> >    172		WARN_ON_ONCE(dfi->usecount < 0);
> >    173	
> >    174		if (dfi->usecount > 0)
> >    175			goto out;
> >    176	
> >    177		writel_relaxed(HIWORD_UPDATE(0, DDRMON_CTRL_SOFTWARE_EN),
> >    178			       dfi_regs + DDRMON_CTRL);
> >    179		clk_disable_unprepare(dfi->clk);
> >    180	out:
> >    181		mutex_unlock(&dfi->mutex);
> >    182	}
> >    183	
> >    184	static void rockchip_dfi_read_counters(struct rockchip_dfi *dfi, struct dmc_count *res)
> >    185	{
> >    186		u32 i;
> >    187		void __iomem *dfi_regs = dfi->regs;
> >    188	
> >    189		for (i = 0; i < dfi->max_channels; i++) {
> >    190			if (!(dfi->channel_mask & BIT(i)))
> >    191				continue;
> >    192			res->c[i].read_access = readl_relaxed(dfi_regs +
> >    193					DDRMON_CH0_RD_NUM + i * 20);
> >    194			res->c[i].write_access = readl_relaxed(dfi_regs +
> >    195					DDRMON_CH0_WR_NUM + i * 20);
> >    196			res->c[i].access = readl_relaxed(dfi_regs +
> >    197					DDRMON_CH0_DFI_ACCESS_NUM + i * 20);
> >    198			res->c[i].clock_cycles = readl_relaxed(dfi_regs +
> >    199					DDRMON_CH0_COUNT_NUM + i * 20);
> >    200		}
> >    201	}
> >    202	
> >  > 203	static void rockchip_ddr_perf_counters_add(struct rockchip_dfi *dfi,
> >    204						   const struct dmc_count *now,
> >    205						   struct dmc_count *res)
> >    206	{
> >    207		const struct dmc_count *last = &dfi->last_perf_count;
> >    208		int i;
> >    209	
> >    210		for (i = 0; i < dfi->max_channels; i++) {
> >    211			res->c[i].read_access = dfi->total_count.c[i].read_access +
> >    212				(u32)(now->c[i].read_access - last->c[i].read_access);
> >    213			res->c[i].write_access = dfi->total_count.c[i].write_access +
> >    214				(u32)(now->c[i].write_access - last->c[i].write_access);
> >    215			res->c[i].access = dfi->total_count.c[i].access +
> >    216				(u32)(now->c[i].access - last->c[i].access);
> >    217			res->c[i].clock_cycles = dfi->total_count.c[i].clock_cycles +
> >    218				(u32)(now->c[i].clock_cycles - last->c[i].clock_cycles);
> >    219		}
> >    220	}
> >    221	
> > 
> 
> -- 
> Best Regards,
> Samsung Electronics
> Chanwoo Choi
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
