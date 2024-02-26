Return-Path: <linux-kernel+bounces-82061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E20A5867E81
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FB2A1F2D36C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EC612DDBB;
	Mon, 26 Feb 2024 17:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRekSXus"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AA112CD9B;
	Mon, 26 Feb 2024 17:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708968576; cv=none; b=i1sqV8aozsqMViy5zVyt9Q+EWucHDya2Ng2i2iISavET0AAs1ckiAhZoGFVEZw52vZuGrnBl9o0f7WjxGE0+dRTLFxshiB9tBiQ2crYAqF3jKg5lqol+zXj6715vNlyEsszSCZp58mbyvGlzumntAgOjEs9RMCDxbRmCnrEQ8+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708968576; c=relaxed/simple;
	bh=PPWpZn6QtPq4YjG7xsHntmUxU7EVh0Grx4E9f2KCnvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BD4wxe0WDF5PHsJKuQ86XiZ9rZNk7jpEb5ch2c/fawrSbslSWRV/1kDCOh/SLK2aa8TtmM7UnZFada4OjIDNViIiXe7nQ0rLVbfFxKaJK3yOTvkSPI4GSBfODBNKMYAojVHwCLSY+RcCwj11+2Y/8W6Yt7nnBNpgEG8dj2akI7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRekSXus; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a43488745bcso192359666b.3;
        Mon, 26 Feb 2024 09:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708968571; x=1709573371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTNfYrs5k6Gz8OzZ/jpN+432GP+s/eKGWOpfysyFss0=;
        b=DRekSXuscqmuuBFo+98sI6lTLq8uUleca6U7+/pduuHPyB5GE/908tNkpRWLa2GBny
         AT7RorkQWr1hG6zrSU898xM5ohwVGP1M0dwEvl/RFDszj6UTqXD4LCamTCUAeLTl5zXX
         1VOu4DGFW+ide7lCXhGHPzkB/g3UIC2avGD+Ptrj8Z6Q4bkzLLIgIV3tGKOoGmD3ljdc
         Tnj1rU/x24GHQkq1YCcGT2OxXsX0qb1zdBf6I4sULyLEF2zyCaV67Zx3FDlpQsZQnOMP
         +BH13J63p41NK2MX652I+BY/aSMZGxD34vIDinzgKqphlHBPrN7v7x+rQWGtnC2mppzn
         DOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708968571; x=1709573371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uTNfYrs5k6Gz8OzZ/jpN+432GP+s/eKGWOpfysyFss0=;
        b=oZwGcKIzpjkNSvCpA/CJ8aifmqSX+di42VH/II5/WyQNb54df1xa44LNtmeMa6Fvyv
         0K3+qsfsWIoqJW2d5U6zkiWPrS77YETadzm36VK7JJMDzW6rqO3LmLVtRMFtbIZKi/wl
         5YSRPXH1JuHZlxApkOKobrdFnyGp6cag2KIZWtsV+aeMmy2GRNLyA91/n1ZAvIF3Buz6
         3ksg9flXnqmSPS/eZPQJpiy1YuoIJ0Pa7qSzFydrCHuYYQDsvHKrl1h8L7DfdtSRWJKN
         3mb+aRvqPY84bSvewo//9VL+Fhsd85QqARSAbJdRK904QjAT883NwVrHhENMONbAV5FD
         Fjqw==
X-Forwarded-Encrypted: i=1; AJvYcCWp2QmYStuxCZMXJ3Kx8q79cWq9HUhh7xh9nmmFhuIo7Fx5rBNYKJBqxoxZf2jjvYDz0b5Yqs0BHLilhtFeCTOqgc9lqEikE+l7+I/S60912YzKX/8JpFbKp9m0ZC57u07Ulx31bR+PTdMtBijW9eYn9MqSKHovdse9DL44wjDs101bTQ==
X-Gm-Message-State: AOJu0YzyPpak277B/pPblKl2Nh+yB0fBjs4jKcv0cFQirSBle4ZG3nuZ
	TYTitFMX36tIkFxihfNne2Kap8DO1APy7TCy97R9lVM4TN7OrxcZ
X-Google-Smtp-Source: AGHT+IF/2k+pmfOW66mPmU1VQ//WB/gsjeh7KQflarLtcUM81gJHGL8o2NsXzTzgDh1Y2GpLoJ6CEg==
X-Received: by 2002:a17:906:d297:b0:a42:f7af:741b with SMTP id ay23-20020a170906d29700b00a42f7af741bmr4236943ejb.51.1708968571164;
        Mon, 26 Feb 2024 09:29:31 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id bj3-20020a17090736c300b00a3f5ff7b675sm2617714ejc.23.2024.02.26.09.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 09:29:30 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: =?utf-8?B?T25kxZllag==?= Jirman <megi@xff.cz>,
 Maxime Ripard <mripard@kernel.org>, Frank Oltmanns <frank@oltmanns.dev>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
 Purism Kernel Team <kernel@puri.sm>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
Subject:
 Re: [PATCH v2 0/6] Pinephone video out fixes (flipping between two frames)
Date: Mon, 26 Feb 2024 18:29:28 +0100
Message-ID: <3546609.iIbC2pHGDl@jernej-laptop>
In-Reply-To: <875xybr93t.fsf@oltmanns.dev>
References:
 <20240205-pinephone-pll-fixes-v2-0-96a46a2d8c9b@oltmanns.dev>
 <87r0h8n64g.fsf@oltmanns.dev> <875xybr93t.fsf@oltmanns.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Dne ponedeljek, 26. februar 2024 ob 08:13:42 CET je Frank Oltmanns napisal(=
a):
> Hi Jernej,
> hi Maxime,
> hi Ond=C5=99ej,
>=20
> On 2024-02-19 at 10:41:19 +0100, Frank Oltmanns <frank@oltmanns.dev> wrot=
e:
> > Hi Ond=C5=99ej,
> >
> > On 2024-02-11 at 20:25:29 +0100, Ond=C5=99ej Jirman <megi@xff.cz> wrote:
> >> Hi Frank,
> >>
> >> On Sun, Feb 11, 2024 at 04:09:16PM +0100, Frank Oltmanns wrote:
> >>> Hi Ond=C5=99ej,
> >>>
> >>> On 2024-02-05 at 17:02:00 +0100, Ond=C5=99ej Jirman <megi@xff.cz> wro=
te:
> >>> > On Mon, Feb 05, 2024 at 04:54:07PM +0100, Ond=C5=99ej Jirman wrote:
> >>> >> On Mon, Feb 05, 2024 at 04:22:23PM +0100, Frank Oltmanns wrote:
> >>> >>
> >>> >> [...]
> >>> >>
> >>> >> Also sunxi-ng clk driver does apply NM factors at once to PLL_GPU =
clock,
> >>> >> which can cause sudden frequency increase beyond intended output f=
requency,
> >>> >> because division is applied immediately while multiplication is re=
flected
> >>> >> slowly.
> >>> >>
> >>> >> Eg. if you're changing divider from 7 to 1, you can get a sudden 7=
x output
> >>> >> frequency spike, before PLL VCO manages to lower the frequency thr=
ough N clk
> >>> >> divider feedback loop and lock on again. This can mess up whatever=
's connected
> >>> >> to the output quite badly.
> >>> >>
> >>> >> You'd have to put logging on kernel writes to PLL_GPU register to =
see what
> >>> >> is written in there and if divider is lowered significantly on som=
e GPU
> >>> >> devfreq frequency transitions.
> >>>
> >>> By looking at the clocks in clk_summary in debugfs, the rate of PLL-G=
PU
> >>> always matches the rate of the GPU (at least at 120, 312, and 432 MHz=
).
> >>> This is further underlined by the fact, that none of the rates can be
> >>> achieved by integer dividing one of the other rates. sunxi-ng would
> >>> only favor a different rate for pll-gpu than the one that is requested
> >>> for the gpu, if pll-gpu is already running at a rate such that there
> >>> exists an M =E2=88=88 {1, 2, 3, 4, 5, 6, 7, 8}, where
> >>>   rate of pll-gpu / M =3D requested gpu rate
> >>> or if the requested rate could not be reached directly by pll-gpu. Bo=
th
> >>> is not the case for the rates in question (120, 192, 312, and 432 MHz=
).
> >>>
> >>> This means that the following divisor/multipliers are used by sunxi-n=
g's
> >>> ccu_nm:
> >>> N =3D  5, M =3D 1 for 120 MHz (min value without PATCH 6)
> >>> N =3D  8, M =3D 1 for 192 MHz (min value after applying PATCH 6)
> >>> N =3D 13, M =3D 1 for 312 MHz
> >>> N =3D 18, M =3D 1 for 432 MHz
> >>>
> >>> So, with or without PATCH 6, the divider stays constant and it's only
> >>> the multiplier that changes. This means, there should be no unexpected
> >>> frequency spikes, right?
> >>
> >> Maybe. Thanks for giving it a try. There may still be other kinds of g=
litches
> >> even if the divisor stays the same. It all depends how the register up=
date is
> >> implemented in the PLL block. It's hard to say. I guess, unless Allwin=
ner
> >> guarantees glitchless output from a given PLL when changing its parame=
ters,
> >> you can't rely on the output being clean during changes.
> >>
> >>> >> It's also unclear what happens when FRAC_CLK_OUT or PLL_MODE_SEL c=
hanges.
> >>>
> >>> Those are not changed once the clock is initialized. The bug however
> >>> occurs hours or days after booting. IMO, this makes it unlikely that =
this
> >>> could be the culprit.
> >>>
> >>> >> Maybe not much because M is supposed to be set to 1, but you still=
 need to
> >>> >> care when enabling fractional mode, and setting M to 1 because tha=
t's exactly
> >>> >> the bad scenario if M was previously higher than 1.
> >>> >>
> >>> >> It's tricky.
> >>> >>
> >>> >> Having GPU module clock gated during PLL config changes may help! =
You can
> >>> >> do that without locking yourself out, unlike with the CPU PLL.
> >>> >>
> >>> >> There's a gate enable bit for it at GPU_CLK_REG.SCLK_GATING. (page=
 122)
> >>>
> >>> The GPU should already be properly gated:
> >>> https://elixir.bootlin.com/linux/v6.7.4/source/drivers/clk/sunxi-ng/c=
cu-sun50i-a64.c#L599
> >>
> >> How so? That's just clock declaration. How does it guarantee the clock=
 to the
> >> module is gated during parent PLL configuration changes?
> >>
> >
> > You're of course right.
> >
> > I now tried using a similar approach like the one for changes for on
> > PLL-CPU. It's using a notifier to connect the CPU to the 24 MHz
> > oscillator and, after PLL-CPU is at its new rate, connecting it back to
> > PLL-CPU.
> >
> > For the GPU my approach was to disable the GPU prior to changing
> > PLL-GPU's rate and then re-enabling it, once the rate change is
> > complete. I think, that's what you were proposing, right?
> >
> > Unfortunately, this results in a frozen phone even more quickly.
> >
> > Below is my code. Again, it doesn't solve the problem, but maybe
> > somebody can spot what I'm doing wrong.
>=20
> It seems to me that all options for changing the GPU's rate in a stable
> manner have been exhausted. There seems to be no common interpretation
> what the phrase "Clock output of PLL_GPU can be used for GPU;and dynamic
> frequency scaling is not supported" in the Allwinner A64 manual (chapter
> 3.3.3) means.
>=20
> The BSP uses a fixed rate of 432 MHz. Unless one of you has a clever
> idea, I suggest to remove the OPPs from the device tree and set the GPU
> to 432 MHz.
>=20
> What are your thoughts on that?

I can't find original source of these points. So I'm good with removing
them. But instead of fully removing table, you can just leave one point and
it should work.

Best regards,
Jernej

>=20
> Best regards,
>   Frank
>=20
> >
> > Best regards,
> >   Frank
> >
> > diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-=
ng/ccu-sun50i-a64.c
> > index d68bdf7dd342..74538259d67a 100644
> > --- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> > +++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> > @@ -977,6 +977,11 @@ static struct ccu_rate_reset_nb sun50i_a64_pll_vid=
eo0_reset_tcon0_nb =3D {
> >
> >  #define CCU_MIPI_DSI_CLK 0x168
> >
> > +static struct ccu_div_nb sun50i_a64_gpu_nb =3D {
> > +	.common		=3D &gpu_clk.common,
> > +	.delay_us	=3D 1, /* ??? */
> > +};
> > +
> >  static int sun50i_a64_ccu_probe(struct platform_device *pdev)
> >  {
> >  	void __iomem *reg;
> > @@ -1025,6 +1030,10 @@ static int sun50i_a64_ccu_probe(struct platform_=
device *pdev)
> >  	sun50i_a64_pll_video0_reset_tcon0_nb.target_clk =3D tcon0_clk.common.=
hw.clk;
> >  	ccu_rate_reset_notifier_register(&sun50i_a64_pll_video0_reset_tcon0_n=
b);
> >
> > +	/* Gate then ungate GPU on PLL-GPU changes */
> > +	ccu_div_notifier_register(pll_gpu_clk.common.hw.clk,
> > +				  &sun50i_a64_gpu_nb);
> > +
> >  	return 0;
> >  }
> >
> > diff --git a/drivers/clk/sunxi-ng/ccu_div.c b/drivers/clk/sunxi-ng/ccu_=
div.c
> > index cb10a3ea23f9..83813c54fb2f 100644
> > --- a/drivers/clk/sunxi-ng/ccu_div.c
> > +++ b/drivers/clk/sunxi-ng/ccu_div.c
> > @@ -4,7 +4,9 @@
> >   * Maxime Ripard <maxime.ripard@free-electrons.com>
> >   */
> >
> > +#include <linux/clk.h>
> >  #include <linux/clk-provider.h>
> > +#include <linux/delay.h>
> >  #include <linux/io.h>
> >
> >  #include "ccu_gate.h"
> > @@ -142,3 +144,37 @@ const struct clk_ops ccu_div_ops =3D {
> >  	.set_rate	=3D ccu_div_set_rate,
> >  };
> >  EXPORT_SYMBOL_NS_GPL(ccu_div_ops, SUNXI_CCU);
> > +
> > +static int ccu_div_notifier_cb(struct notifier_block *nb,
> > +			       unsigned long event, void *data)
> > +{
> > +	struct ccu_div_nb *div_nb =3D to_ccu_div_nb(nb);
> > +
> > +	if (event =3D=3D PRE_RATE_CHANGE) {
> > +		div_nb->original_enable =3D ccu_div_is_enabled(&div_nb->common->hw);
> > +		if (div_nb->original_enable) {
> > +			ccu_div_disable(&div_nb->common->hw);
> > +			udelay(div_nb->delay_us);
> > +		}
> > +	} else if (event =3D=3D POST_RATE_CHANGE) {
> > +		if (div_nb->original_enable) {
> > +			ccu_div_enable(&div_nb->common->hw);
> > +			udelay(div_nb->delay_us);
> > +		}
> > +	}
> > +
> > +	return NOTIFY_OK;
> > +}
> > +
> > +int ccu_div_notifier_register(struct clk *clk, struct ccu_div_nb *div_=
nb)
> > +{
> > +	div_nb->clk_nb.notifier_call =3D ccu_div_notifier_cb;
> > +
> > +	return clk_notifier_register(clk, &div_nb->clk_nb);
> > +}
> > diff --git a/drivers/clk/sunxi-ng/ccu_div.h b/drivers/clk/sunxi-ng/ccu_=
div.h
> > index 90d49ee8e0cc..e096c7be5dca 100644
> > --- a/drivers/clk/sunxi-ng/ccu_div.h
> > +++ b/drivers/clk/sunxi-ng/ccu_div.h
> > @@ -283,4 +283,16 @@ static inline struct ccu_div *hw_to_ccu_div(struct=
 clk_hw *hw)
> >
> >  extern const struct clk_ops ccu_div_ops;
> >
> > +struct ccu_div_nb {
> > +	struct notifier_block	clk_nb;
> > +	struct ccu_common	*common;
> > +
> > +	u32	delay_us;	/* us to wait after changing parent rate */
> > +	int	original_enable;/* This is set by the notifier callback */
> > +};
> > +
> > +#define to_ccu_div_nb(_nb) container_of(_nb, struct ccu_div_nb, clk_nb)
> > +
> > +int ccu_div_notifier_register(struct clk *clk, struct ccu_div_nb *mux_=
nb);
> > +
> >  #endif /* _CCU_DIV_H_ */
> >
> >
> >
> >>
> >> CLK_SET_RATE_PARENT only gates output on re-parenting, not on parent r=
ate changes,
> >> according to the header:
> >>
> >>   https://elixir.bootlin.com/linux/v6.7.4/source/include/linux/clk-pro=
vider.h#L19
> >>
> >> You'd need perhaps CLK_SET_RATE_GATE *and* still verify that it actual=
ly works
> >> as expected via some tracing of gpu clock enable/disable/set_rate and =
pll-gpu
> >> set_rate. CLK_SET_RATE_GATE seems confusingly docummented:
> >>
> >>   https://elixir.bootlin.com/linux/v6.7.4/source/drivers/clk/clk.c#L10=
34
> >>
> >> so I don't particularly trust it does exaclty what the header claims a=
nd what
> >> would be needed to test the theory that gating gpu clock during rate c=
hange
> >> might help.
> >>
> >> kind regards,
> >> 	o.
> >>
> >>> Thank you for your detailed proposal! It was insightful to read. But
> >>> while those were all great ideas, they have all already been taken ca=
re
> >>> of. I'm fresh out of ideas again (except for pinning the GPU rate).
> >>>
> >>> Again, thank you so much,
> >>>   Frank
> >>>
> >>> >>
> >>> >> Kind regards,
> >>> >> 	o.
> >>> >>
> >>> >> > I very much appreciate your feedback!
> >>> >> >
> >>> >> > [1] https://gitlab.com/postmarketOS/pmaports/-/issues/805
> >>> >> >
> >>> >> > Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> >>> >> > ---
> >>> >> > Changes in v2:
> >>> >> > - dts: Increase minimum GPU frequency to 192 MHz.
> >>> >> > - nkm and a64: Add minimum and maximum rate for PLL-MIPI.
> >>> >> > - nkm: Use the same approach for skipping invalid rates in
> >>> >> >   ccu_nkm_find_best() as in ccu_nkm_find_best_with_parent_adj().
> >>> >> > - nkm: Improve names for ratio struct members and hence get rid =
of
> >>> >> >   describing comments.
> >>> >> > - nkm and a64: Correct description in the commit messages: M/N <=
=3D 3
> >>> >> > - Remove patches for nm as they were not needed.
> >>> >> > - st7703: Rework the commit message to cover more background for=
 the
> >>> >> >   change.
> >>> >> > - Link to v1: https://lore.kernel.org/r/20231218-pinephone-pll-f=
ixes-v1-0-e238b6ed6dc1@oltmanns.dev
> >>> >> >
> >>> >> > ---
> >>> >> > Frank Oltmanns (6):
> >>> >> >       clk: sunxi-ng: nkm: Support constraints on m/n ratio and p=
arent rate
> >>> >> >       clk: sunxi-ng: a64: Add constraints on PLL-MIPI's n/m rati=
o and parent rate
> >>> >> >       clk: sunxi-ng: nkm: Support minimum and maximum rate
> >>> >> >       clk: sunxi-ng: a64: Set minimum and maximum rate for PLL-M=
IPI
> >>> >> >       drm/panel: st7703: Drive XBD599 panel at higher clock rate
> >>> >> >       arm64: dts: allwinner: a64: Fix minimum GPU OPP rate
> >>> >> >
> >>> >> >  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  4 ++--
> >>> >> >  drivers/clk/sunxi-ng/ccu-sun50i-a64.c         | 14 +++++++----
> >>> >> >  drivers/clk/sunxi-ng/ccu_nkm.c                | 34 ++++++++++++=
+++++++++++++++
> >>> >> >  drivers/clk/sunxi-ng/ccu_nkm.h                |  4 ++++
> >>> >> >  drivers/gpu/drm/panel/panel-sitronix-st7703.c | 14 +++++------
> >>> >> >  5 files changed, 56 insertions(+), 14 deletions(-)
> >>> >> > ---
> >>> >> > base-commit: 059c53e877ca6e723e10490c27c1487a63e66efe
> >>> >> > change-id: 20231218-pinephone-pll-fixes-0ccdfde273e4
> >>> >> >
> >>> >> > Best regards,
> >>> >> > --
> >>> >> > Frank Oltmanns <frank@oltmanns.dev>
> >>> >> >
>=20





