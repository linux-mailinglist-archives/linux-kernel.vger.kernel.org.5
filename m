Return-Path: <linux-kernel+bounces-128139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C088956BF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4946C1C20E45
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DE512A157;
	Tue,  2 Apr 2024 14:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ASbBU2eN"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11F77E766
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 14:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068383; cv=none; b=EcTXiwjyDdguqKsf2n0NvcI/DOz2QdamGPJbPOiSNI1Vx3TYbGu5cVynTKAdiZ54/OHhpUKWrXDDF+ypmwOaBsRBPnOtk2FK+5wU//Wy+1mDOfUti+a4VM/uWeERCtou5SAEHypNDpG885IRTvp9C9nF6gRK+K6B96VIJC6EOAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068383; c=relaxed/simple;
	bh=KWrZusQJQMji6aE2OtrhtDKPN3yVC7+g4kaaFj0WaeA=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=lDtdzxK12SRKIbVGU1PqI/vA387D/lfqKsfQSIfq4S8N1qxpdNWysrae6AOMyfQ92awfMhe3MFqK0xoCFrogQhvetDiRUcauyIqQg2s+apdM1sgfYWdGSLsNvvgshThkAJjZxEXb9X9dUmNz3QsB9Du3eKwdaq9weDpGRp6o17E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ASbBU2eN; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41569f1896dso11836255e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 07:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712068379; x=1712673179; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=HEtsCpz4MIzWRds8geMwgNxbFpu0vjPrqmUI/UEAmeE=;
        b=ASbBU2eNpktN1mASt2oIkJxJ+ag6imn6E+y8qQnsr5iljeUmqYaZes82eS0glp9xd1
         MYAQdtILkTVuW4ylfKsVS9b4Bf/lrpo6FhCbTEFQbVNqlAQN35b5j0cbFQPugqksXNRz
         a8jr89LAwQTc9nfAL2X3oX6BClfc+uUCShfu4OiubPMpZFLZDtT1f2pDLMT9kOmptfge
         zsV0aJaRjyhmvQze3wFThHDp4D6QzMeiY0JimY1CntMnBrzo0RC2h8hgTVQsPBwYOS9M
         c30rwKMjV1DbK7xrImUnnC+U846tN52Pyyp0Y6fHXl38GslAC6R0fHGQhBZ/TXK8exLZ
         d+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712068379; x=1712673179;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEtsCpz4MIzWRds8geMwgNxbFpu0vjPrqmUI/UEAmeE=;
        b=pR9a2lboP19NAwGNUlC7K2g35yG5byvAtphc5wwijyu31Lo7TIhw0dTdJJb0ZU9QJC
         UNEQluT+h79kLOs0QAKDfK/fR7B/oNscHXJ5EVccB1NUOdNLC49VO5k3dT+N/NZLKJ/0
         M4bSLWOPSXRp4cqHG/R8/kBQ/3VcoqdQyDq8+0HYYSbOIgNxNBderSJidstbJBcjX0sD
         yxnC834gOezxrnqVumKTYbMNvlF2P9We1q3Em1I/P9/6/FlPiaaklsLpqtSdAbIcfbSf
         biYFNMt5qvZXeI0HxazuFxt2R5ShsMIxSuDS2b4VTZnPTo5tPf1hGXk1GDqwlXre8zn2
         LSag==
X-Forwarded-Encrypted: i=1; AJvYcCWSY60xD3hVxcvxVvE6YaNNsvzeJ+ilwLjaUPbZ94WfazB6UAJrB8aAv8zPycDNrrP8dmKyluvTLW8FWXzrYPuhxrG7YAAw3rivbhwB
X-Gm-Message-State: AOJu0YwTBucmoYj9rzhNcUf6VfvAiG1rTmTQL0S3g8amrRhQse/LfQI5
	PQTuhn9IYneeOmtC0sAFOYhPAWyXnDD59jtYPIOKorO2swiSGtO14/q/64YMn08=
X-Google-Smtp-Source: AGHT+IGjNhWiDBYNmq+K/GKR39m/w7jR+0GLSVTnRUJMeSZ9vwCrOhr9OwZtV2iO8DIQ0nlr/sftPA==
X-Received: by 2002:a5d:69cd:0:b0:33e:cf4e:86ba with SMTP id s13-20020a5d69cd000000b0033ecf4e86bamr6631161wrw.63.1712068379089;
        Tue, 02 Apr 2024 07:32:59 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:2b3:4f20:7b45:be58])
        by smtp.gmail.com with ESMTPSA id k4-20020a05600c1c8400b00414807ef8dfsm18315928wms.5.2024.04.02.07.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 07:32:58 -0700 (PDT)
References: <20240329205904.25002-1-ddrokosov@salutedevices.com>
 <20240329205904.25002-3-ddrokosov@salutedevices.com>
 <1j4jckjftk.fsf@starbuckisacylon.baylibre.com>
 <20240402121546.qrrc7r5un75464pb@CAB-WSD-L081021>
User-agent: mu4e 1.10.8; emacs 29.2
From: Jerome Brunet <jbrunet@baylibre.com>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, neil.armstrong@linaro.org,
 mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
 martin.blumenstingl@googlemail.com, kernel@salutedevices.com,
 rockosov@gmail.com, linux-amlogic@lists.infradead.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 2/6] clk: meson: a1: pll: support 'syspll'
 general-purpose PLL for CPU clock
Date: Tue, 02 Apr 2024 16:27:17 +0200
In-reply-to: <20240402121546.qrrc7r5un75464pb@CAB-WSD-L081021>
Message-ID: <1jmsqbj0md.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On Tue 02 Apr 2024 at 15:15, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:

> On Tue, Apr 02, 2024 at 11:00:42AM +0200, Jerome Brunet wrote:
>> 
>> On Fri 29 Mar 2024 at 23:58, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:
>> 
>> > The 'syspll' PLL, also known as the system PLL, is a general and
>> > essential PLL responsible for generating the CPU clock frequency.
>> > With its wide-ranging capabilities, it is designed to accommodate
>> > frequencies within the range of 768MHz to 1536MHz.
>> >
>> > Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
>> > ---
>> >  drivers/clk/meson/a1-pll.c | 78 ++++++++++++++++++++++++++++++++++++++
>> >  drivers/clk/meson/a1-pll.h |  6 +++
>> >  2 files changed, 84 insertions(+)
>> >
>> > diff --git a/drivers/clk/meson/a1-pll.c b/drivers/clk/meson/a1-pll.c
>> > index 60b2e53e7e51..02fd2d325cc6 100644
>> > --- a/drivers/clk/meson/a1-pll.c
>> > +++ b/drivers/clk/meson/a1-pll.c
>> > @@ -138,6 +138,81 @@ static struct clk_regmap hifi_pll = {
>> >  	},
>> >  };
>> >  
>> > +static const struct pll_mult_range sys_pll_mult_range = {
>> > +	.min = 32,
>> > +	.max = 64,
>> > +};
>> > +
>> > +/*
>> > + * We assume that the sys_pll_clk has already been set up by the low-level
>> > + * bootloaders as the main CPU PLL source. Therefore, it is not necessary to
>> > + * run the initialization sequence.
>> > + */
>> 
>> I see no reason to make such assumption.
>> This clock is no read-only, it apparently is able to re-lock so assuming
>> anything from the bootloader is just asking from trouble
>> 
>
> Indeed, I have implemented the following initialization sequence. I have
> dumped the bootloader setup and included it in the definition of my
> sys_pll. However, I have encountered an issue with the enable bit. If I
> leave the enable bit switched on by default, there is a possibility that
> the bootloader selects a fixed CPU clock while the sys_pll should be
> switched off. On the other hand, if I keep the enable bit switched off
> by default, the bootloader might configure the CPU clock to use sys_pll,
> resulting in the execution halting when the initialization sequence is
> run. This situation has led me to assume that we should place our trust
> in the bootloader setup.
>
> If you believe it is necessary to include the initialization sequence, I
> can prepare it with the sys_pll enabled by default.

I just noted your initial comment is misleading.

You could submit a patch to apply the init sequence only if the PLL is
not already enabled. Maybe even condition that to flag in the pll data
to avoid applying it to the other platforms for now.

>
>> > +static struct clk_regmap sys_pll = {
>> > +	.data = &(struct meson_clk_pll_data){
>> > +		.en = {
>> > +			.reg_off = ANACTRL_SYSPLL_CTRL0,
>> > +			.shift   = 28,
>> > +			.width   = 1,
>> > +		},
>> > +		.m = {
>> > +			.reg_off = ANACTRL_SYSPLL_CTRL0,
>> > +			.shift   = 0,
>> > +			.width   = 8,
>> > +		},
>> > +		.n = {
>> > +			.reg_off = ANACTRL_SYSPLL_CTRL0,
>> > +			.shift   = 10,
>> > +			.width   = 5,
>> > +		},
>> > +		.frac = {
>> > +			.reg_off = ANACTRL_SYSPLL_CTRL1,
>> > +			.shift   = 0,
>> > +			.width   = 19,
>> > +		},
>> > +		.l = {
>> > +			.reg_off = ANACTRL_SYSPLL_STS,
>> > +			.shift   = 31,
>> > +			.width   = 1,
>> > +		},
>> > +		.current_en = {
>> > +			.reg_off = ANACTRL_SYSPLL_CTRL0,
>> > +			.shift   = 26,
>> > +			.width   = 1,
>> > +		},
>> > +		.l_detect = {
>> > +			.reg_off = ANACTRL_SYSPLL_CTRL2,
>> > +			.shift   = 6,
>> > +			.width   = 1,
>> > +		},
>> > +		.range = &sys_pll_mult_range,
>> > +	},
>> > +	.hw.init = &(struct clk_init_data){
>> > +		.name = "sys_pll",
>> > +		.ops = &meson_clk_pll_ops,
>> > +		.parent_names = (const char *[]){ "syspll_in" },
>> > +		.num_parents = 1,
>> > +		/*
>> > +		 * This clock is used as the main CPU PLL source in low-level
>> > +		 * bootloaders, and it is necessary to mark it as critical.
>> > +		 */
>> > +		.flags = CLK_IS_CRITICAL,
>> 
>> No I don't think so. Downstream consumer maybe critical but that one is
>> not, unless it is read-only.
>> 
>> A CPU pll, like on the g12 family, is unlikely to be read-only since the
>> PLL will need to relock to change rates. During this phase, there will
>> be no reate coming from the PLL so the PLL is not critical and you must
>> be able to "park" your CPU an another clock while poking this one
>> 
>
> Initially, I tagged it with CLK_IS_CRITICAL because I observed in the
> kernel start that CCF disables it.
> However, upon further understanding,
> I realized that this happened due to other reasons. I believe that if I
> provide an init sequence where sys_pll is enabled by default, CCF will
> not disable this clock.
>
>> > +	},
>> > +};
>> > +
>> > +static struct clk_fixed_factor sys_pll_div16 = {
>> > +	.mult = 1,
>> > +	.div = 16,
>> > +	.hw.init = &(struct clk_init_data){
>> > +		.name = "sys_pll_div16",
>> > +		.ops = &clk_fixed_factor_ops,
>> > +		.parent_hws = (const struct clk_hw *[]) {
>> > +			&sys_pll.hw
>> > +		},
>> > +		.num_parents = 1,
>> > +	},
>> > +};
>> > +
>> >  static struct clk_fixed_factor fclk_div2_div = {
>> >  	.mult = 1,
>> >  	.div = 2,
>> > @@ -283,6 +358,8 @@ static struct clk_hw *a1_pll_hw_clks[] = {
>> >  	[CLKID_FCLK_DIV5]	= &fclk_div5.hw,
>> >  	[CLKID_FCLK_DIV7]	= &fclk_div7.hw,
>> >  	[CLKID_HIFI_PLL]	= &hifi_pll.hw,
>> > +	[CLKID_SYS_PLL]		= &sys_pll.hw,
>> > +	[CLKID_SYS_PLL_DIV16]	= &sys_pll_div16.hw,
>> >  };
>> >  
>> >  static struct clk_regmap *const a1_pll_regmaps[] = {
>> > @@ -293,6 +370,7 @@ static struct clk_regmap *const a1_pll_regmaps[] = {
>> >  	&fclk_div5,
>> >  	&fclk_div7,
>> >  	&hifi_pll,
>> > +	&sys_pll,
>> >  };
>> >  
>> >  static struct regmap_config a1_pll_regmap_cfg = {
>> > diff --git a/drivers/clk/meson/a1-pll.h b/drivers/clk/meson/a1-pll.h
>> > index 4be17b2bf383..666d9b2137e9 100644
>> > --- a/drivers/clk/meson/a1-pll.h
>> > +++ b/drivers/clk/meson/a1-pll.h
>> > @@ -18,6 +18,12 @@
>> >  #define ANACTRL_FIXPLL_CTRL0	0x0
>> >  #define ANACTRL_FIXPLL_CTRL1	0x4
>> >  #define ANACTRL_FIXPLL_STS	0x14
>> > +#define ANACTRL_SYSPLL_CTRL0	0x80
>> > +#define ANACTRL_SYSPLL_CTRL1	0x84
>> > +#define ANACTRL_SYSPLL_CTRL2	0x88
>> > +#define ANACTRL_SYSPLL_CTRL3	0x8c
>> > +#define ANACTRL_SYSPLL_CTRL4	0x90
>> > +#define ANACTRL_SYSPLL_STS	0x94
>> >  #define ANACTRL_HIFIPLL_CTRL0	0xc0
>> >  #define ANACTRL_HIFIPLL_CTRL1	0xc4
>> >  #define ANACTRL_HIFIPLL_CTRL2	0xc8


-- 
Jerome

