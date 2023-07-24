Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6A975EEA1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 11:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjGXJFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 05:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjGXJFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 05:05:35 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D51F9;
        Mon, 24 Jul 2023 02:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690189534; x=1721725534;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=vawks+SEXMGtEO1DjTLzv4gtbu550zJgPIxABvCGJa0=;
  b=nQ/dTPjJ8dGC9DhbxwwbeveQVq4YP52UfPBd+mjniVd2DO9aPNg5vBCt
   ic4itVZdvVYfFKihKB49NgVP8KbRKAa2T7PyHQC9Ee1vbQ1VnEBpaDnB9
   r9TqasUhmeHUjbyngyFLJInSLHvv2XDpCe18f/jo7WsATIqRgYnjRnn7h
   I61cJP1XLmfFoy7J654JghkfZJMIiAH6boRNqKtgXgULOvdsbVTDqQtew
   O6yykteRqC1GDEOfDokOcN+y3q3gyvzFQkX0S9ANTlnoxLLMnHH8UBVB7
   X99pXVJ9kmipSKFs76iSiTn36ljxZUC78iMZuNXU5zJXBV7hs85DuB+yS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="431184897"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="431184897"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 02:05:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="839376346"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="839376346"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jul 2023 02:05:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qNrVR-005iUH-1g;
        Mon, 24 Jul 2023 12:05:29 +0300
Date:   Mon, 24 Jul 2023 12:05:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afaerber@suse.com
Subject: Re: [PATCH 04/10] clk: mmp: Add Marvell PXA1908 clock driver
Message-ID: <ZL4+2bS3cVGq7q/5@smile.fi.intel.com>
References: <20230721210042.21535-1-duje.mihanovic@skole.hr>
 <20230721210042.21535-5-duje.mihanovic@skole.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230721210042.21535-5-duje.mihanovic@skole.hr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 10:37:46PM +0200, Duje Mihanović wrote:
> Add driver for Marvell PXA1908 clock controller blocks. The SoC has
> numerous clock controller blocks, currently supporting APBC, APBCP, MPMU
> and APMU.

...

> +#include <linux/kernel.h>

Try to avoid using this header without real need.
You have missing a ton of the header inclusions, btw.

> +#include <linux/of_address.h>

> +#define APBC_INDEX_TO_OFFSET(n)	((n - 1) * 4)
> +
> +#define APMU_CLK_GATE_CTRL	0x40
> +#define MPMU_UART_PLL		0x14

...

> +static struct mmp_param_fixed_rate_clk fixed_rate_clks[] = {
> +	{PXA1908_CLK_CLK32, "clk32", NULL, 0, 32768},
> +	{PXA1908_CLK_VCTCXO, "vctcxo", NULL, 0, 26000000},

HZ_PER_MHZ (from units.h) here and elsewhere?

> +	{PXA1908_CLK_PLL1_624, "pll1_624", NULL, 0, 624000000},
> +	{PXA1908_CLK_PLL1_416, "pll1_416", NULL, 0, 416000000},
> +	{PXA1908_CLK_PLL1_499, "pll1_499", NULL, 0, 499000000},
> +	{PXA1908_CLK_PLL1_832, "pll1_832", NULL, 0, 832000000},
> +	{PXA1908_CLK_PLL1_1248, "pll1_1248", NULL, 0, 1248000000},
> +};

...

> +static struct mmp_clk_factor_masks uart_factor_masks = {
> +	.factor = 2,

> +	.num_mask = 0x1fff,
> +	.den_mask = 0x1fff,

GENMASK() (provided in bits.h).

> +	.num_shift = 16,
> +	.den_shift = 0,
> +};

...

> +static struct mmp_clk_factor_tbl uart_factor_tbl[] = {
> +	{.num = 8125, .den = 1536},	/* 14.745MHz */
> +};

Can this struct be dropped in favour of struct u32_fract (from math.h)?

...

> +	pxa_unit->apbc_base = of_iomap(np, 0);
> +	if (!pxa_unit->apbc_base) {
> +		pr_err("failed to map apbc registers\n");

Haven't noticed if you are using pr_fmt().

> +		kfree(pxa_unit);
> +		return;
> +	}

-- 
With Best Regards,
Andy Shevchenko


