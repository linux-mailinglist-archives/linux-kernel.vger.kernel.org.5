Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D939811B68
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441991AbjLMRmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbjLMRmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:42:14 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2F899;
        Wed, 13 Dec 2023 09:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702489340; x=1734025340;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jBtGP8WM+RYBuZNY+rEd0+l1PJWe6enNGl91hLRWMnw=;
  b=gcgBs36E88/YKFlh1UAXDRAVSMX/JLaNisK4hiMw9e4Vxh0Xc9njYKnx
   x4SOkyBpiQ1h3Vjpo5eoJElSDrCDVKH+7kNfgQx7bqTj5f/iGqXRxKo6F
   lQ7ktjRaZW0hCQNkmVHo0OctItNq+bc76cT3XpM6tv2K3fTI2JpYWihfB
   /QMBLJEQeOQxrrzZXwV1Vt+YZLX3LoIsZjia9HMAjjs4I0DN02e4Xmh45
   Xh5SQIc2wDKYMVvmP94iq6ZmZ8T5RmwT7TVlTRRi9JFz73GMkX4xOkcTk
   RtWWSJhUY+0FLhT7brXksHFTmT5zi5+5xA631dP5UtC5wMrmiejQrQSgL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="459317604"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="459317604"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 09:42:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="844398862"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="844398862"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 09:42:17 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1rDTFP-00000005b77-08xn;
        Wed, 13 Dec 2023 19:42:15 +0200
Date:   Wed, 13 Dec 2023 19:42:14 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 04/40] clk: ep93xx: add DT support for Cirrus EP93xx
Message-ID: <ZXns9klLAhuK-Alz@smile.fi.intel.com>
References: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
 <20231212-ep93xx-v6-4-c307b8ac9aa8@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212-ep93xx-v6-4-c307b8ac9aa8@maquefel.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 11:20:21AM +0300, Nikita Shubin wrote:
> Rewrite EP93xx clock driver located in arch/arm/mach-ep93xx/clock.c
> trying to do everything the device tree way:
> 
> - provide clock acces via of
> - drop clk_hw_register_clkdev
> - drop init code and use module_auxiliary_driver

...

> +#define EP93XX_I2SCLKDIV_SDIV		(1 << 16)

BIT() ?

...

> +static u8 ep93xx_mux_get_parent(struct clk_hw *hw)
> +{
> +	struct ep93xx_clk *clk = ep93xx_clk_from(hw);
> +	struct ep93xx_clk_priv *priv = ep93xx_priv_from(clk);
> +	u32 val;
> +
> +	regmap_read(priv->map, clk->reg, &val);
> +
> +	val &= EP93XX_SYSCON_CLKDIV_MASK;
> +
> +	switch (val) {
> +	case EP93XX_SYSCON_CLKDIV_ESEL:
> +		return 1; /* PLL1 */
> +	case EP93XX_SYSCON_CLKDIV_MASK:
> +		return 2; /* PLL2 */

> +	default:
> +		break;
> +	};
> +
> +	return 0; /* XTALI */

You may return directly from default.

> +}

...

> +static int ep93xx_mux_set_parent_lock(struct clk_hw *hw, u8 index)
> +{
> +	struct ep93xx_clk *clk = ep93xx_clk_from(hw);
> +	struct ep93xx_clk_priv *priv = ep93xx_priv_from(clk);
> +	unsigned long flags;
> +	u32 val;
> +
> +	if (index >= 3)
> +		return -EINVAL;

> +	spin_lock_irqsave(&priv->lock, flags);

Why not guard() ?

> +	regmap_read(priv->map, clk->reg, &val);
> +	val &= ~(EP93XX_SYSCON_CLKDIV_MASK);
> +	val |= index > 0 ? EP93XX_SYSCON_CLKDIV_ESEL : 0;
> +	val |= index > 1 ? EP93XX_SYSCON_CLKDIV_PSEL : 0;
> +
> +	ep93xx_clk_write(priv, clk->reg, val);
> +
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	return 0;
> +}

...

> +static bool is_best(unsigned long rate, unsigned long now,
> +		     unsigned long best)
> +{
> +	return abs_diff(rate, now) < abs_diff(rate, best);

Have you included necessary header for this?

> +}

...

> +static int ep93xx_mux_determine_rate(struct clk_hw *hw,
> +				struct clk_rate_request *req)
> +{
> +	unsigned long best_rate = 0, actual_rate, mclk_rate;
> +	unsigned long rate = req->rate;

> +	struct clk_hw *parent_best = NULL;

Strictly speaking you don't need an assignment here as you can compare the loop
variable value against the maximum. But I don't know how heave the respective
CLk call is and if it has no side-effects due to operations inside the loop body.

> +	unsigned long parent_rate_best;
> +	unsigned long parent_rate;
> +	int div, pdiv;
> +	unsigned int i;
> +
> +	/*
> +	 * Try the two pll's and the external clock

Either comma + 'b' or missing period.

> +	 * Because the valid predividers are 2, 2.5 and 3, we multiply
> +	 * all the clocks by 2 to avoid floating point math.
> +	 *
> +	 * This is based on the algorithm in the ep93xx raster guide:
> +	 * http://be-a-maverick.com/en/pubs/appNote/AN269REV1.pdf
> +	 *
> +	 */
> +	for (i = 0; i < clk_hw_get_num_parents(hw); i++) {
> +		struct clk_hw *parent = clk_hw_get_parent_by_index(hw, i);
> +
> +		parent_rate = clk_hw_get_rate(parent);
> +		mclk_rate = parent_rate * 2;
> +
> +		/* Try each predivider value */
> +		for (pdiv = 4; pdiv <= 6; pdiv++) {
> +			div = DIV_ROUND_CLOSEST(mclk_rate, rate * pdiv);

> +			if (!in_range(div, 1, 127))

Same header as for abs_diff()?

> +				continue;
> +
> +			actual_rate = DIV_ROUND_CLOSEST(mclk_rate, pdiv * div);
> +			if (is_best(rate, actual_rate, best_rate)) {
> +				best_rate = actual_rate;
> +				parent_rate_best = parent_rate;
> +				parent_best = parent;
> +			}
> +		}

(1)

> +	}
> +
> +	if (!parent_best)
> +		return -EINVAL;
> +
> +	req->best_parent_rate = parent_rate_best;
> +	req->best_parent_hw = parent_best;
> +	req->rate = best_rate;
> +
> +	return 0;
> +}

...

> +	mclk_rate = parent_rate * 2;
> +
> +	for (pdiv = 4; pdiv <= 6; pdiv++) {
> +		div = DIV_ROUND_CLOSEST(mclk_rate, rate * pdiv);
> +		if (!in_range(div, 1, 127))
> +			continue;
> +
> +		actual_rate = DIV_ROUND_CLOSEST(mclk_rate, pdiv * div);
> +		if (abs(actual_rate - rate) < rate_err) {
> +			npdiv = pdiv - 3;
> +			ndiv = div;
> +			rate_err = abs(actual_rate - rate);
> +		}
> +	}

Looks very similar to (1). Can be deduplicated?

...

> +	/*
> +	 * Clear old dividers
> +	 * Bit 7 is reserved bit in all ClkDiv registers

Missing periods.

> +	 */

...

> +static unsigned long calc_pll_rate(u64 rate, u32 config_word)
> +{
> +	rate *= ((config_word >> 11) & GENMASK(4, 0)) + 1;	/* X1FBD */
> +	rate *= ((config_word >> 5) & GENMASK(5, 0)) + 1;	/* X2FBD */
> +	do_div(rate, (config_word & GENMASK(4, 0)) + 1);	/* X2IPD */

> +	rate >>= ((config_word >> 16) & GENMASK(1, 0));		/* PS */

Outer parentheses are redundant.

> +	return rate;
> +}

...

> +	/*
> +	 * EP93xx SSP clock rate was doubled in version E2. For more information
> +	 * see:
> +	 *     http://www.cirrus.com/en/pubs/appNote/AN273REV4.pdf

Can you point to the specific section? Like

	 * see section 1.2.3 "Foo bar":

> +	 */

...

> +	/* touchscreen/adc clock */

ADC

...

> +	/*
> +	 * On reset PDIV and VDIV is set to zero, while PDIV zero
> +	 * means clock disable, VDIV shouldn't be zero.
> +	 * So we set both video and is2 dividers to minimum.

i2s?

> +	 * ENA - Enable CLK divider.
> +	 * PDIV - 00 - Disable clock
> +	 * VDIV - at least 2
> +	 */

-- 
With Best Regards,
Andy Shevchenko


