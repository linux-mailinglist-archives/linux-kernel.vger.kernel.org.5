Return-Path: <linux-kernel+bounces-127602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7942894E3B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B93628323A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3CB57323;
	Tue,  2 Apr 2024 09:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WGTtMwvz"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136E956B8C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 09:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712048685; cv=none; b=oQnvQEVApidyB5Fk5qj7s0Ulp64T6q+7ZnXYtso3uhkA6TVsZrIp5mGbWmBSYI4+rSLj7IvHQZCQooY8x6YflbmDAx/ym43vNXAbFF7uQrISyZDT6dZwfi6j96uZsw5OwLYkJnvMsclvKTGPARimQn0aedmv7E6OQeiaUDmuU7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712048685; c=relaxed/simple;
	bh=UOcXMEcrvtS1548Y9244NrKksQOuvYTLDtzFV9UxEBE=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=FyV8JcXQYEh8k21s3DIwiedtCACtmRbSyxTUpIcFARRMTu8hzFQSTCPZ09POkWUMlr+DCvruNy8p8Kg83iAg3MVCbbXOpSwV/qTWmDWy1YJyLaCEyQUO6+tVyn33B5Fzk8m5c/sPYmTtZLpyqWQBqxOPDDE0cHgBavBrQgZA6dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WGTtMwvz; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3416df43cabso3466255f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 02:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712048681; x=1712653481; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=5DtpQsHWTJr85nIclH627DiK8ml0pGvXwXdSfSvXc3Y=;
        b=WGTtMwvzmFupxB8lisf4+EHLP48vdfvFVTdJ/nGrZOhPyHfVSSqcWJqeUzbrTcMc5G
         O4YcJY3X+GNkKKnvyg+NPGDaf9ka8mO0EwkwZA1wavJIJSBTw8K9hSIx0EkQdzcjy88Q
         ynrxxCXExM1+dYA4BYq3MfgKsl4GJvjYrajQ/4xqvWfDuQkqUIV8JYCus9WIWvtX+Gjv
         ix07CU0HyTYAQiN4n1eBs+RhaM9unzfs+zd4HyCGQctX4TjFrr3yfzN4xW55jLDCaYze
         B9NtTG9HPF6l2p/kwfwZZvRlbz6ztiB/zC6CYkEymSjJbccLvIrp7Jp6JlAOqcdh4qww
         YQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712048681; x=1712653481;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DtpQsHWTJr85nIclH627DiK8ml0pGvXwXdSfSvXc3Y=;
        b=GcD3mTWqriUZrbUYS4YLcU1RUaQgRDqvreBWAr1uwUi/3FuJv0BiBEfUu/+uEo9RbR
         Ab4a5WfpuhksI4mjPcXeQ36kk0b/Fu4nXRv2y8XxIJO4/294oQE94naOS2jiUq9tqbD/
         QeeCshKzFn2LsJwEQNrTf1WYotxdM+2E8vjBD6CsE+9nyfgKDv3boVDnr2mClzvgXx13
         LSYao1fDRDOzQLsmD0wnMSZlGrXtcZHUvKW9QdiP0IJykVEmgTv4z+2FdKNE0ODEEaje
         9AwEbdXSsyeLtgalF0NBIpdDFgr5e0+ees6AfljjlOMQwdUo2XocJm9uWt+mKRnvkYjL
         TW8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXnTUdgOgUQUT/PxDOHujaIMjKAO+v1ymOxEw6CPDgLhi7KibLAhZfROL3D7W/+zpix6xsAAFf0WX+uk94wdkmlcQKyzXDSZMBABUTA
X-Gm-Message-State: AOJu0YwJ4pRqGk+KCUm4pgjb+kSLD4FPRGmxKqjT/HD+qhRHuK8KL/Z7
	P2/a2OjH4veGlDmWk1AI4QWH7tQq2BlkM7oJlkaD6G6t1aLuyFxOh1sZ+PgNp1w=
X-Google-Smtp-Source: AGHT+IH63/gwJe4lsLdmn86BYF7wjy6dJ6d3CdKbvsodEW1CIse+oGPeG50Lip9oSH4TRd0rV3oHFg==
X-Received: by 2002:a05:6000:c8:b0:341:b8d6:e7c7 with SMTP id q8-20020a05600000c800b00341b8d6e7c7mr6500554wrx.71.1712048681104;
        Tue, 02 Apr 2024 02:04:41 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:db22:d5c9:a527:a4cf])
        by smtp.gmail.com with ESMTPSA id dj11-20020a0560000b0b00b003437799a373sm191115wrb.83.2024.04.02.02.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 02:04:40 -0700 (PDT)
References: <20240329205904.25002-1-ddrokosov@salutedevices.com>
 <20240329205904.25002-3-ddrokosov@salutedevices.com>
User-agent: mu4e 1.10.8; emacs 29.2
From: Jerome Brunet <jbrunet@baylibre.com>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: neil.armstrong@linaro.org, jbrunet@baylibre.com,
 mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
 martin.blumenstingl@googlemail.com, kernel@salutedevices.com,
 rockosov@gmail.com, linux-amlogic@lists.infradead.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 2/6] clk: meson: a1: pll: support 'syspll'
 general-purpose PLL for CPU clock
Date: Tue, 02 Apr 2024 11:00:42 +0200
In-reply-to: <20240329205904.25002-3-ddrokosov@salutedevices.com>
Message-ID: <1j4jckjftk.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On Fri 29 Mar 2024 at 23:58, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:

> The 'syspll' PLL, also known as the system PLL, is a general and
> essential PLL responsible for generating the CPU clock frequency.
> With its wide-ranging capabilities, it is designed to accommodate
> frequencies within the range of 768MHz to 1536MHz.
>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>  drivers/clk/meson/a1-pll.c | 78 ++++++++++++++++++++++++++++++++++++++
>  drivers/clk/meson/a1-pll.h |  6 +++
>  2 files changed, 84 insertions(+)
>
> diff --git a/drivers/clk/meson/a1-pll.c b/drivers/clk/meson/a1-pll.c
> index 60b2e53e7e51..02fd2d325cc6 100644
> --- a/drivers/clk/meson/a1-pll.c
> +++ b/drivers/clk/meson/a1-pll.c
> @@ -138,6 +138,81 @@ static struct clk_regmap hifi_pll = {
>  	},
>  };
>  
> +static const struct pll_mult_range sys_pll_mult_range = {
> +	.min = 32,
> +	.max = 64,
> +};
> +
> +/*
> + * We assume that the sys_pll_clk has already been set up by the low-level
> + * bootloaders as the main CPU PLL source. Therefore, it is not necessary to
> + * run the initialization sequence.
> + */

I see no reason to make such assumption.
This clock is no read-only, it apparently is able to re-lock so assuming
anything from the bootloader is just asking from trouble

> +static struct clk_regmap sys_pll = {
> +	.data = &(struct meson_clk_pll_data){
> +		.en = {
> +			.reg_off = ANACTRL_SYSPLL_CTRL0,
> +			.shift   = 28,
> +			.width   = 1,
> +		},
> +		.m = {
> +			.reg_off = ANACTRL_SYSPLL_CTRL0,
> +			.shift   = 0,
> +			.width   = 8,
> +		},
> +		.n = {
> +			.reg_off = ANACTRL_SYSPLL_CTRL0,
> +			.shift   = 10,
> +			.width   = 5,
> +		},
> +		.frac = {
> +			.reg_off = ANACTRL_SYSPLL_CTRL1,
> +			.shift   = 0,
> +			.width   = 19,
> +		},
> +		.l = {
> +			.reg_off = ANACTRL_SYSPLL_STS,
> +			.shift   = 31,
> +			.width   = 1,
> +		},
> +		.current_en = {
> +			.reg_off = ANACTRL_SYSPLL_CTRL0,
> +			.shift   = 26,
> +			.width   = 1,
> +		},
> +		.l_detect = {
> +			.reg_off = ANACTRL_SYSPLL_CTRL2,
> +			.shift   = 6,
> +			.width   = 1,
> +		},
> +		.range = &sys_pll_mult_range,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "sys_pll",
> +		.ops = &meson_clk_pll_ops,
> +		.parent_names = (const char *[]){ "syspll_in" },
> +		.num_parents = 1,
> +		/*
> +		 * This clock is used as the main CPU PLL source in low-level
> +		 * bootloaders, and it is necessary to mark it as critical.
> +		 */
> +		.flags = CLK_IS_CRITICAL,

No I don't think so. Downstream consumer maybe critical but that one is
not, unless it is read-only.

A CPU pll, like on the g12 family, is unlikely to be read-only since the
PLL will need to relock to change rates. During this phase, there will
be no reate coming from the PLL so the PLL is not critical and you must
be able to "park" your CPU an another clock while poking this one

> +	},
> +};
> +
> +static struct clk_fixed_factor sys_pll_div16 = {
> +	.mult = 1,
> +	.div = 16,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "sys_pll_div16",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&sys_pll.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
>  static struct clk_fixed_factor fclk_div2_div = {
>  	.mult = 1,
>  	.div = 2,
> @@ -283,6 +358,8 @@ static struct clk_hw *a1_pll_hw_clks[] = {
>  	[CLKID_FCLK_DIV5]	= &fclk_div5.hw,
>  	[CLKID_FCLK_DIV7]	= &fclk_div7.hw,
>  	[CLKID_HIFI_PLL]	= &hifi_pll.hw,
> +	[CLKID_SYS_PLL]		= &sys_pll.hw,
> +	[CLKID_SYS_PLL_DIV16]	= &sys_pll_div16.hw,
>  };
>  
>  static struct clk_regmap *const a1_pll_regmaps[] = {
> @@ -293,6 +370,7 @@ static struct clk_regmap *const a1_pll_regmaps[] = {
>  	&fclk_div5,
>  	&fclk_div7,
>  	&hifi_pll,
> +	&sys_pll,
>  };
>  
>  static struct regmap_config a1_pll_regmap_cfg = {
> diff --git a/drivers/clk/meson/a1-pll.h b/drivers/clk/meson/a1-pll.h
> index 4be17b2bf383..666d9b2137e9 100644
> --- a/drivers/clk/meson/a1-pll.h
> +++ b/drivers/clk/meson/a1-pll.h
> @@ -18,6 +18,12 @@
>  #define ANACTRL_FIXPLL_CTRL0	0x0
>  #define ANACTRL_FIXPLL_CTRL1	0x4
>  #define ANACTRL_FIXPLL_STS	0x14
> +#define ANACTRL_SYSPLL_CTRL0	0x80
> +#define ANACTRL_SYSPLL_CTRL1	0x84
> +#define ANACTRL_SYSPLL_CTRL2	0x88
> +#define ANACTRL_SYSPLL_CTRL3	0x8c
> +#define ANACTRL_SYSPLL_CTRL4	0x90
> +#define ANACTRL_SYSPLL_STS	0x94
>  #define ANACTRL_HIFIPLL_CTRL0	0xc0
>  #define ANACTRL_HIFIPLL_CTRL1	0xc4
>  #define ANACTRL_HIFIPLL_CTRL2	0xc8


-- 
Jerome

