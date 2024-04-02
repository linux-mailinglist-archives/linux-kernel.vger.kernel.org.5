Return-Path: <linux-kernel+bounces-127910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBDB8952B3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42C6A28528D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F414A79DD4;
	Tue,  2 Apr 2024 12:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="h3Pv8g6A"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320B274BF4;
	Tue,  2 Apr 2024 12:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712060154; cv=none; b=sfwu37eOOPywH3dkwvjSybgUZADGP2ZN3LhHPT6LshgDIJhmi+iRef8ZiaY+Wl+BaveAZLrNm4EJyOzDZHrb3t90MlQ4OphtQR40gI20cUbB0nE41p9E/goS/4iW4quzkk//A6aS8Ly0K5/Wk9bVwiyO33nfhZ7O8WCZJBeyhAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712060154; c=relaxed/simple;
	bh=ewzAxxTaBnRdT6oO+knWQphhzHVCDmh0P1cdcSltxiQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4LHuvVVBSnvy5HGziSATUIqhsDrwt2+II+I52+5X+DMRvziXXh94Si/inpWlwq0ksh4WzpIUKHEUsDoR7/35DDwsyawBROwhFsfH3APEMI67oEE3AvJWGBU0FnfzLMacr+mWsGMOBlGI/4+GbP6dos0PkMcMHYsRskPBWmbG94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=h3Pv8g6A; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 99DA1120002;
	Tue,  2 Apr 2024 15:15:47 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 99DA1120002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1712060147;
	bh=ElpTZ1TrAlE8CP0mE0jFlYKQjyXNnVn6kDPBRqPutDI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=h3Pv8g6AY+VQuvPVaWfziPBCxqr344JkhvXY/zJB7BS0MiJa6oAsjk65LY8Nbza6L
	 mW+QPOWfa7T6iGWeVvKntxMXBoOYy9BQ1bmjm0ZvaUe6ynMZ3Dd6hQKwXtGeTPNBHV
	 ptTXlYMYJlveLsrJvLAE78+pXPJxppJWYDBmUmufDLDAqaZrpox5kUTSNGB5L6cdCA
	 Om/8HBftrdji1dCm6zYVY8Eh4J1YmE9YNoETy8htKFMHh87/IWOheTw0jvc0Vnue8R
	 Yp8J4RYi79zl1DPr9bCNmRwDKam740vmzedZ0kbWY4uQZpWXHuuidWG1MMq0YEYBFh
	 8r+akjvJrTdOw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue,  2 Apr 2024 15:15:47 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m02.sberdevices.ru
 (172.16.192.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 2 Apr
 2024 15:15:46 +0300
Date: Tue, 2 Apr 2024 15:15:46 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Jerome Brunet <jbrunet@baylibre.com>
CC: <neil.armstrong@linaro.org>, <mturquette@baylibre.com>,
	<sboyd@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <khilman@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <kernel@salutedevices.com>,
	<rockosov@gmail.com>, <linux-amlogic@lists.infradead.org>,
	<linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1 2/6] clk: meson: a1: pll: support 'syspll'
 general-purpose PLL for CPU clock
Message-ID: <20240402121546.qrrc7r5un75464pb@CAB-WSD-L081021>
References: <20240329205904.25002-1-ddrokosov@salutedevices.com>
 <20240329205904.25002-3-ddrokosov@salutedevices.com>
 <1j4jckjftk.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1j4jckjftk.fsf@starbuckisacylon.baylibre.com>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184533 [Apr 02 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/02 07:07:00 #24571916
X-KSMG-AntiVirus-Status: Clean, skipped

On Tue, Apr 02, 2024 at 11:00:42AM +0200, Jerome Brunet wrote:
> 
> On Fri 29 Mar 2024 at 23:58, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:
> 
> > The 'syspll' PLL, also known as the system PLL, is a general and
> > essential PLL responsible for generating the CPU clock frequency.
> > With its wide-ranging capabilities, it is designed to accommodate
> > frequencies within the range of 768MHz to 1536MHz.
> >
> > Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> > ---
> >  drivers/clk/meson/a1-pll.c | 78 ++++++++++++++++++++++++++++++++++++++
> >  drivers/clk/meson/a1-pll.h |  6 +++
> >  2 files changed, 84 insertions(+)
> >
> > diff --git a/drivers/clk/meson/a1-pll.c b/drivers/clk/meson/a1-pll.c
> > index 60b2e53e7e51..02fd2d325cc6 100644
> > --- a/drivers/clk/meson/a1-pll.c
> > +++ b/drivers/clk/meson/a1-pll.c
> > @@ -138,6 +138,81 @@ static struct clk_regmap hifi_pll = {
> >  	},
> >  };
> >  
> > +static const struct pll_mult_range sys_pll_mult_range = {
> > +	.min = 32,
> > +	.max = 64,
> > +};
> > +
> > +/*
> > + * We assume that the sys_pll_clk has already been set up by the low-level
> > + * bootloaders as the main CPU PLL source. Therefore, it is not necessary to
> > + * run the initialization sequence.
> > + */
> 
> I see no reason to make such assumption.
> This clock is no read-only, it apparently is able to re-lock so assuming
> anything from the bootloader is just asking from trouble
> 

Indeed, I have implemented the following initialization sequence. I have
dumped the bootloader setup and included it in the definition of my
sys_pll. However, I have encountered an issue with the enable bit. If I
leave the enable bit switched on by default, there is a possibility that
the bootloader selects a fixed CPU clock while the sys_pll should be
switched off. On the other hand, if I keep the enable bit switched off
by default, the bootloader might configure the CPU clock to use sys_pll,
resulting in the execution halting when the initialization sequence is
run. This situation has led me to assume that we should place our trust
in the bootloader setup.

If you believe it is necessary to include the initialization sequence, I
can prepare it with the sys_pll enabled by default.

> > +static struct clk_regmap sys_pll = {
> > +	.data = &(struct meson_clk_pll_data){
> > +		.en = {
> > +			.reg_off = ANACTRL_SYSPLL_CTRL0,
> > +			.shift   = 28,
> > +			.width   = 1,
> > +		},
> > +		.m = {
> > +			.reg_off = ANACTRL_SYSPLL_CTRL0,
> > +			.shift   = 0,
> > +			.width   = 8,
> > +		},
> > +		.n = {
> > +			.reg_off = ANACTRL_SYSPLL_CTRL0,
> > +			.shift   = 10,
> > +			.width   = 5,
> > +		},
> > +		.frac = {
> > +			.reg_off = ANACTRL_SYSPLL_CTRL1,
> > +			.shift   = 0,
> > +			.width   = 19,
> > +		},
> > +		.l = {
> > +			.reg_off = ANACTRL_SYSPLL_STS,
> > +			.shift   = 31,
> > +			.width   = 1,
> > +		},
> > +		.current_en = {
> > +			.reg_off = ANACTRL_SYSPLL_CTRL0,
> > +			.shift   = 26,
> > +			.width   = 1,
> > +		},
> > +		.l_detect = {
> > +			.reg_off = ANACTRL_SYSPLL_CTRL2,
> > +			.shift   = 6,
> > +			.width   = 1,
> > +		},
> > +		.range = &sys_pll_mult_range,
> > +	},
> > +	.hw.init = &(struct clk_init_data){
> > +		.name = "sys_pll",
> > +		.ops = &meson_clk_pll_ops,
> > +		.parent_names = (const char *[]){ "syspll_in" },
> > +		.num_parents = 1,
> > +		/*
> > +		 * This clock is used as the main CPU PLL source in low-level
> > +		 * bootloaders, and it is necessary to mark it as critical.
> > +		 */
> > +		.flags = CLK_IS_CRITICAL,
> 
> No I don't think so. Downstream consumer maybe critical but that one is
> not, unless it is read-only.
> 
> A CPU pll, like on the g12 family, is unlikely to be read-only since the
> PLL will need to relock to change rates. During this phase, there will
> be no reate coming from the PLL so the PLL is not critical and you must
> be able to "park" your CPU an another clock while poking this one
> 

Initially, I tagged it with CLK_IS_CRITICAL because I observed in the
kernel start that CCF disables it. However, upon further understanding,
I realized that this happened due to other reasons. I believe that if I
provide an init sequence where sys_pll is enabled by default, CCF will
not disable this clock.

> > +	},
> > +};
> > +
> > +static struct clk_fixed_factor sys_pll_div16 = {
> > +	.mult = 1,
> > +	.div = 16,
> > +	.hw.init = &(struct clk_init_data){
> > +		.name = "sys_pll_div16",
> > +		.ops = &clk_fixed_factor_ops,
> > +		.parent_hws = (const struct clk_hw *[]) {
> > +			&sys_pll.hw
> > +		},
> > +		.num_parents = 1,
> > +	},
> > +};
> > +
> >  static struct clk_fixed_factor fclk_div2_div = {
> >  	.mult = 1,
> >  	.div = 2,
> > @@ -283,6 +358,8 @@ static struct clk_hw *a1_pll_hw_clks[] = {
> >  	[CLKID_FCLK_DIV5]	= &fclk_div5.hw,
> >  	[CLKID_FCLK_DIV7]	= &fclk_div7.hw,
> >  	[CLKID_HIFI_PLL]	= &hifi_pll.hw,
> > +	[CLKID_SYS_PLL]		= &sys_pll.hw,
> > +	[CLKID_SYS_PLL_DIV16]	= &sys_pll_div16.hw,
> >  };
> >  
> >  static struct clk_regmap *const a1_pll_regmaps[] = {
> > @@ -293,6 +370,7 @@ static struct clk_regmap *const a1_pll_regmaps[] = {
> >  	&fclk_div5,
> >  	&fclk_div7,
> >  	&hifi_pll,
> > +	&sys_pll,
> >  };
> >  
> >  static struct regmap_config a1_pll_regmap_cfg = {
> > diff --git a/drivers/clk/meson/a1-pll.h b/drivers/clk/meson/a1-pll.h
> > index 4be17b2bf383..666d9b2137e9 100644
> > --- a/drivers/clk/meson/a1-pll.h
> > +++ b/drivers/clk/meson/a1-pll.h
> > @@ -18,6 +18,12 @@
> >  #define ANACTRL_FIXPLL_CTRL0	0x0
> >  #define ANACTRL_FIXPLL_CTRL1	0x4
> >  #define ANACTRL_FIXPLL_STS	0x14
> > +#define ANACTRL_SYSPLL_CTRL0	0x80
> > +#define ANACTRL_SYSPLL_CTRL1	0x84
> > +#define ANACTRL_SYSPLL_CTRL2	0x88
> > +#define ANACTRL_SYSPLL_CTRL3	0x8c
> > +#define ANACTRL_SYSPLL_CTRL4	0x90
> > +#define ANACTRL_SYSPLL_STS	0x94
> >  #define ANACTRL_HIFIPLL_CTRL0	0xc0
> >  #define ANACTRL_HIFIPLL_CTRL1	0xc4
> >  #define ANACTRL_HIFIPLL_CTRL2	0xc8

-- 
Thank you,
Dmitry

