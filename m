Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07177F44FB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343747AbjKVLjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343644AbjKVLjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:39:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37940197;
        Wed, 22 Nov 2023 03:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700653178; x=1732189178;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UDaQD3L3io4DrQxy2+jPfRXmkTm3EMCQZir6j3W5qHE=;
  b=G8HJ7lIIZ97INMfKBAnuvSSz7+ScSqNT42CoKpE17MuWBfqriQRz4x3m
   yjW6MmVB/bbuLAnGYanEWCzp+4zhezftzInwJEmwd/3IEryHqhKw2p0me
   jtCRy58cYbACci/nKR2Bz0Ws9JtlDrBXI1j/e+TQZ8Ot+nD+2qOtBuun9
   hj1ZpGloWHaFB0llF+NTOYX/H8aEKbGtn+7i/T3PY7R2TIPLfDSmKlo+i
   ccNE2SUuYLOOM8BDFu+qg0kNljnM5Nqce73E5mU+CMFVi0q3Tdw+w4H/u
   DVGgBbqejeY3XIMZWRA6r/ZmzSlufNLCMdSdU51zXDKP0yfrSPPrLRb8M
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="458532916"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="458532916"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 03:39:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="910763331"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="910763331"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 03:39:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1r5lZt-0000000G4qY-1DtY;
        Wed, 22 Nov 2023 13:39:33 +0200
Date:   Wed, 22 Nov 2023 13:39:33 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Subject: Re: [PATCH v5 03/39] clk: ep93xx: add DT support for Cirrus EP93xx
Message-ID: <ZV3odTS-rheJX0bR@smile.fi.intel.com>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
 <20231122-ep93xx-v5-3-d59a76d5df29@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122-ep93xx-v5-3-d59a76d5df29@maquefel.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 11:59:41AM +0300, Nikita Shubin wrote:
> Rewrite EP93xx clock driver located in arch/arm/mach-ep93xx/clock.c
> trying to do everything the device tree way:
> 
> - provide clock acces via of
> - drop clk_hw_register_clkdev
> - drop init code and use module_auxiliary_driver

...

> +static int ep93xx_clk_enable(struct clk_hw *hw)
> +{
> +	struct ep93xx_clk *clk = ep93xx_clk_from(hw);
> +	struct ep93xx_clk_priv *priv = ep93xx_priv_from(clk);
> +	unsigned long flags;
> +	u32 val;

> +	spin_lock_irqsave(&priv->lock, flags);

Have you considered to use cleanup.h and hence guard()() operator here
(and elsewhere)? Why not?

> +	regmap_read(priv->map, clk->reg, &val);
> +	val |= BIT(clk->bit_idx);
> +
> +	ep93xx_clk_write(priv, clk->reg, val);
> +
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	return 0;
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
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	regmap_read(priv->map, clk->reg, &val);
> +	val &= ~(EP93XX_SYSCON_CLKDIV_MASK);

> +	if (index) {
> +		val |= EP93XX_SYSCON_CLKDIV_ESEL;
> +		val |= (index - 1) ? EP93XX_SYSCON_CLKDIV_PSEL : 0;
> +	}

Maybe

	val |= index > 0 ? EP93XX_SYSCON_CLKDIV_ESEL : 0;
	val |= index > 1 ? EP93XX_SYSCON_CLKDIV_PSEL : 0;

(at least to me it looks better to understand than the original code).

> +	ep93xx_clk_write(priv, clk->reg, val);
> +
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	return 0;
> +}

...

> +	for (i = 0; i < clk_hw_get_num_parents(hw); i++) {
> +		struct clk_hw *parent = clk_hw_get_parent_by_index(hw, i);
> +
> +		parent_rate = clk_hw_get_rate(parent);
> +		mclk_rate = parent_rate * 2;
> +
> +		/* Try each predivider value */
> +		for (pdiv = 4; pdiv <= 6; pdiv++) {
> +			div = DIV_ROUND_CLOSEST(mclk_rate, rate * pdiv);

> +			if (div < 1 || div > 127)

in_range() ?

> +				continue;
> +
> +			actual_rate = DIV_ROUND_CLOSEST(mclk_rate, pdiv * div);
> +			if (is_best(rate, actual_rate, best_rate)) {
> +				best_rate = actual_rate;
> +				parent_rate_best = parent_rate;
> +				parent_best = parent;
> +			}
> +		}
> +	}

...

> +	regmap_read(priv->map, clk->reg, &val);
> +	pdiv = ((val >> EP93XX_SYSCON_CLKDIV_PDIV_SHIFT) & 0x03);

Too many parentheses. Why not GENMASK(1, 0) ?

> +	div = val & GENMASK(6, 0);
> +	if (!div)
> +		return 0;

...

> +	for (pdiv = 4; pdiv <= 6; pdiv++) {
> +		div = DIV_ROUND_CLOSEST(mclk_rate, rate * pdiv);
> +		if (div < 1 || div > 127)

in_range() ?

> +			continue;
> +
> +		actual_rate = DIV_ROUND_CLOSEST(mclk_rate, pdiv * div);
> +		if (abs(actual_rate - rate) < rate_err) {
> +			npdiv = pdiv - 3;
> +			ndiv = div;
> +			rate_err = abs(actual_rate - rate);
> +		}
> +	}

...

> +	/* Clear old dividers */

Not sure if additional comment is needed to explain what is magical about
bit 7...

> +	val &= ~(GENMASK(9, 0) & ~BIT(7));

...

> +	regmap_read(priv->map, clk->reg, &val);
> +	val &= ~clk->mask;
> +	for (i = 0; i < clk->num_div; i++)
> +		if (rate == DIV_ROUND_CLOSEST(parent_rate, clk->div[i])) {

> +			val |= i << clk->shift;

This is an invariant to the loop...

> +			break;
> +		}
> +
> +	if (i == clk->num_div)
> +		return -EINVAL;

...can be moved here, right?

> +	ep93xx_clk_write(priv, clk->reg, val);

...

> +	priv->fixed[EP93XX_CLK_UART] = clk_hw_register_fixed_factor(NULL, "uart", "xtali",
> +								    0, 1, clk_uart_div);

I would format like

	priv->fixed[EP93XX_CLK_UART] =
		clk_hw_register_fixed_factor(NULL, "uart", "xtali", 0, 1, clk_uart_div);

...

> +	struct clk_parent_data xtali = { .index = 0 };

	struct clk_parent_data xtali = { };

will suffice.

...

> +	struct clk_parent_data pdata = {};

Please, keep the style consistent, either all with or without the inner space.

...

> +	hw = devm_clk_hw_register_fixed_factor_parent_hw(dev, "hclk", pll1,
> +							 0, 1, clk_h_div);

Seems you have already long lines, why not on one line here?

> +	if (IS_ERR(hw))
> +		return PTR_ERR(hw);
> +
> +	priv->fixed[EP93XX_CLK_HCLK] = hw;

> +	hw = devm_clk_hw_register_fixed_factor_parent_hw(dev, "pclk", hw,
> +							 0, 1, clk_p_div);

And here?

> +	if (IS_ERR(hw))
> +		return PTR_ERR(hw);

...

> +	clk_usb_div = (((value >> 28) & GENMASK(3, 0)) + 1);

Too many parentheses.

...

> +	 * So i set both dividers to minimum.

s/i/we/ ?

...

> +	/* ENA - Enable CLK divider. */
> +	/* PDIV - 00 - Disable clock */
> +	/* VDIV - at least 2 */
> +	/* Check and enable video clk registers */

Hmm... Why it can't be unified under a single multi-line comment?

-- 
With Best Regards,
Andy Shevchenko


