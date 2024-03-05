Return-Path: <linux-kernel+bounces-92648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E94587236B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25AEE283F0A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D206312839B;
	Tue,  5 Mar 2024 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkkXvzQL"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3382B127B67;
	Tue,  5 Mar 2024 15:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654379; cv=none; b=rnbrPFE0ZmeroAOu9fKTaYknOaKaN2Fx4lvWm9ViV9En2/VefAgcMQ1HpLmxmV/Sbb9bDUKX5pq3KL+5+JSXcmJahs0PCl88bHEfUNRGZntUHwr+z6qQlPp2xDnQmizMrgzD8RzVG7r/sPSAQEPtw7AGSt2KInlcBogGLhXdqi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654379; c=relaxed/simple;
	bh=pMaYClOL1f2fCEBdpO9yV9QnHfTCoTbrFgJXNloevEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ighxWR0jG8K8SAyFoXzTXmwZTauNENCgr/MomFurscUD/VgedMmp+N42JgvXdqicKgWZw200RpVGUYzC7gL4MEjRrOw3khS0IOC5OwyltUDCyKq3d0QYm8UBjyju/cC/pMxHttLJPyXpId/Kwzhzq+875VwE8fwopzYc82Wk5q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkkXvzQL; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc745927098so5119808276.3;
        Tue, 05 Mar 2024 07:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709654377; x=1710259177; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FCOuK42WVPhy1j4uSU/uGoBgIzJdOLgBH9p1sEa2EVw=;
        b=hkkXvzQLXfsYnMrbGt7Rbhdcq+S4oh9HSHUh/QxHofhghWFHUbryaBaBjUYAR1Vdm3
         iS6o41xL28Yj1CD3lvNWWTdF1O8T40l9MdbVeUcJTFb4cw8lladBCbwzts6ThnhwHhtU
         Ulyt4Tx+0mLFXF0gpzaYaenMzWCmYRjVme7oxzUFKFpYb7BNVqEYmIJIo4H1bF7NHdFx
         +A5Y1Pw3BFWYMezAjrqxvCfTtOJOeLgj6PkcS86l8lrINaf32DS3Ft/b2lcHrkJJJGrG
         o9UdyDwNFE2A659IugDKkYDodz83m44UimLLGf2iUo3OaqVwaD4sJKalfWIy+JL3u/KS
         ad4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709654377; x=1710259177;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FCOuK42WVPhy1j4uSU/uGoBgIzJdOLgBH9p1sEa2EVw=;
        b=aLLHdQSjFYmFIXHpiQAp8gFIK77zFt9IHkkeBFGZeFxMuJM6l4BoDliG2ziWIXK7K/
         yIoZGQlEi42ImOGNaLarGgyu7vIYKxMb5K6JjJwoNbh0FFwYpDfNZgeRg2YOcdqOKajo
         bdv+hm9qZFo0V2lRcltCWyGfC9MgQTr5+BsSpdHcEIVFozWRz+7fURZduggy5yFqivsD
         KPwjpCFLQqkdFig5KaycyK4mKeoIE2pGLqvnkiK3mtqQwEHRSEtJI42Id5FyXopEbR9f
         Ck1/edA2U7gIRNDkDazFCly8u8uqM9dwmilY1diXNc33KS/EkxMyEq70sWazhVgcoYA4
         9WNw==
X-Forwarded-Encrypted: i=1; AJvYcCUc3xgCyVm0+2oIJT4NLRQ51kyHlYs1i9wIipPo2zOq6RbO9qNd2BzAp2hJqwlH1I8s6V+P/sWSc0F3JycVNGnOWeDdLoaoN3zQjMr1zRa1FzVWhI93yaEo5KzNnYcZubAX1ah/4664vGzMtXSAOWxWqQGdsCGFHcubd3UQGddvNN4snQ==
X-Gm-Message-State: AOJu0YydcN+rieAliLOrg7FjoqGBBAbuUZEru1NPfaJzOIAwmfo0sovm
	LCwZ8Q4l7MM0FG5zTANrVbiMfJ67OWsa1TNvCEIH4cKxoIjTluU7mRs1/HJQWFntGTMYKSKnU3u
	BxdQA/tDJT7fDY6GCXEd+gkbCNP8=
X-Google-Smtp-Source: AGHT+IGRKsPs+Rmg+G7IRByyGlLAIbv/gh2rXO2CsKTyMg8RVV0haXKjJswP3onDQp/fvGC2DQYEq3EkJUOgNJqf33E=
X-Received: by 2002:a25:aa8a:0:b0:dce:2e9:a637 with SMTP id
 t10-20020a25aa8a000000b00dce02e9a637mr11131475ybi.20.1709654377024; Tue, 05
 Mar 2024 07:59:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131182653.2673554-1-tmaimon77@gmail.com> <20240131182653.2673554-4-tmaimon77@gmail.com>
 <74e003c6d80611ddd826ac21f48b4b3a.sboyd@kernel.org> <CAP6Zq1g5gwXvYzO5fnHxG-6__gSCpNBY7VeEPyr4Qtijya6EfQ@mail.gmail.com>
 <8acf846e767884978f3bb98646433551.sboyd@kernel.org> <CAP6Zq1htKQ5v0tH9HGRejnKwJ5ZauUWG_CzYUKegkVL4Ek8UxA@mail.gmail.com>
In-Reply-To: <CAP6Zq1htKQ5v0tH9HGRejnKwJ5ZauUWG_CzYUKegkVL4Ek8UxA@mail.gmail.com>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Tue, 5 Mar 2024 17:59:26 +0200
Message-ID: <CAP6Zq1g4ksdLSVTm+PLqa5dSEidvHdpGZb=J9wKEftaH-Mg+bw@mail.gmail.com>
Subject: Re: [PATCH v23 3/3] clk: npcm8xx: add clock controller
To: Stephen Boyd <sboyd@kernel.org>
Cc: benjaminfair@google.com, joel@jms.id.au, krzysztof.kozlowski+dt@linaro.org, 
	mturquette@baylibre.com, robh+dt@kernel.org, tali.perry1@gmail.com, 
	venture@google.com, yuenn@google.com, openbmc@lists.ozlabs.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Stephen,

Appreciate it if you could reply to my email afew days ago, It is
really important to us to move this driver to upstream.

Thanks,

Tomer

On Thu, 29 Feb 2024 at 23:29, Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> Hi Stephen,
>
> Thanks for your reply.
>
> On Thu, 29 Feb 2024 at 00:48, Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Tomer Maimon (2024-02-25 10:00:35)
> > > Hi Stephen,
> > >
> > > On Thu, 22 Feb 2024 at 07:58, Stephen Boyd <sboyd@kernel.org> wrote:
> > > >
> > > > Quoting Tomer Maimon (2024-01-31 10:26:53)
> > > > > diff --git a/drivers/clk/clk-npcm8xx.c b/drivers/clk/clk-npcm8xx.c
> > > > > new file mode 100644
> > > > > index 000000000000..eacb579d30af
> > > > > --- /dev/null
> > > > > +++ b/drivers/clk/clk-npcm8xx.c
> > > > > @@ -0,0 +1,509 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +/*
> > > > > + * Nuvoton NPCM8xx Clock Generator
> > > > > + * All the clocks are initialized by the bootloader, so this driver allows only
> > > > [...]
> > > > > +
> > > > > +/* external clock definition */
> > > > > +#define NPCM8XX_CLK_S_REFCLK   "refclk"
> > > > > +
> > > > > +/* pll definition */
> > > > > +#define NPCM8XX_CLK_S_PLL0     "pll0"
> > > > > +#define NPCM8XX_CLK_S_PLL1     "pll1"
> > > > > +#define NPCM8XX_CLK_S_PLL2     "pll2"
> > > > > +#define NPCM8XX_CLK_S_PLL_GFX  "pll_gfx"
> > > > > +
> > > > > +/* early divider definition */
> > > > > +#define NPCM8XX_CLK_S_PLL2_DIV2                "pll2_div2"
> > > > > +#define NPCM8XX_CLK_S_PLL_GFX_DIV2     "pll_gfx_div2"
> > > > > +#define NPCM8XX_CLK_S_PLL1_DIV2                "pll1_div2"
> > > > > +
> > > > > +/* mux definition */
> > > > > +#define NPCM8XX_CLK_S_CPU_MUX     "cpu_mux"
> > > > > +
> > > > > +/* div definition */
> > > > > +#define NPCM8XX_CLK_S_TH          "th"
> > > > > +#define NPCM8XX_CLK_S_AXI         "axi"
> > > >
> > > > Please inline all these string #defines to the place they're used.
> > > The version V21 you mention using define only when the definition is
> > > used more than once
> > > https://www.spinics.net/lists/kernel/msg5045826.html
> > > Should I remove all the string definitions and add the string to the array?
> >
> > If it's a clk name for a clk registered in this file it should be
> > inlined. Is that the case for everything besides refclk? And even refclk
> > could be inlined so that we don't have to jump to the definition of a
> > string.
> I will add the string in the clock arrays and remove all the string definitions.
> >
> > > > > +
> > > > > +static unsigned long npcm8xx_clk_div_get_parent(struct clk_hw *hw,
> > > > > +                                               unsigned long parent_rate)
> > > > > +{
> > > > > +       struct npcm8xx_clk *div = to_npcm8xx_clk(hw);
> > > > > +       unsigned int val;
> > > > > +
> > > > > +       regmap_read(div->clk_regmap, div->offset, &val);
> > > > > +       val = val >> div->shift;
> > > > > +       val &= clk_div_mask(div->width);
> > > > > +
> > > > > +       return divider_recalc_rate(hw, parent_rate, val, NULL, div->flags,
> > > > > +                                  div->width);
> > > > > +}
> > > > > +
> > > > > +static const struct clk_ops npcm8xx_clk_div_ops = {
> > > > > +       .recalc_rate = npcm8xx_clk_div_get_parent,
> > > > > +};
> > > > > +
> > > > > +static int npcm8xx_clk_probe(struct platform_device *pdev)
> > > > > +{
> > > > > +       struct device_node *parent_np = of_get_parent(pdev->dev.of_node);
> > > >
> > > > The parent of this device is not a syscon.
> > > Once I have registered the map that handles both reset and the clock
> > > in general is syscon, this is why we will modify the DTS so the clock
> > > and the reset will be under syscon father node
> > >                 sysctrl: system-controller@f0801000 {
> > >                         compatible = "syscon", "simple-mfd";
> > >                         reg = <0x0 0xf0801000 0x0 0x1000>;
> > >
> > >                         rstc: reset-controller {
> > >                                 compatible = "nuvoton,npcm845-reset";
> > >                                 reg = <0x0 0xf0801000 0x0 0xC4>;
> > >                                 #reset-cells = <2>;
> > >                                 nuvoton,sysgcr = <&gcr>;
> > >                         };
> > >
> > >                         clk: clock-controller {
> > >                                 compatible = "nuvoton,npcm845-clk";
> > >                                 #clock-cells = <1>;
> > >                                 clocks = <&refclk>;
> > >                                 clock-names = "refclk";
> > >                         };
> > >                 };
> > > You can see other drivers that using the same method like
> > > https://elixir.bootlin.com/linux/v6.8-rc5/source/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml
> >
> > You will need a similar file like
> > Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-perictrl.yaml
> > then to describe the child nodes.
> I can do it.
> >
> > Socionext may not be the best example to follow. I generally try to
> > avoid syscon and simply put #reset-cells and #clock-cells in the node
> If I remove syscon I can't use syscon_node_to_regmap function, What
> should I use If I remove syscon? auxiliary bus? something else?
> > for the device. You can use the auxiliary bus to register drivers for
> > clk and reset and put them into the resepective driver directories.
> I little bit confused, what is an auxiliary bus to register drivers,
> can you provide me an example?
> > Avoid syscon means random drivers can't reach into the device with a
> > regmap handle and read/write registers that they're not supposed to.
> Indeed, but the drivers could use the reset and clock memory map only
> if the module is also a child node.
>
> Please let me know what is your preferred way to handle it:
> 1. stick with syscon and upstream-defined documentation for the rst clk syscon.
> 2. avoid syscon and use an auxiliary bus, appreciate if you could give
> me an example of how it should be done.
> 3. Avoid sycon and handle it differently.
> >
> > > >
> > > > > +       struct clk_hw_onecell_data *npcm8xx_clk_data;
> > > > > +       struct device *dev = &pdev->dev;
> > > > > +       struct regmap *clk_regmap;
> > > > > +       struct clk_hw *hw;
> > > > > +       unsigned int i;
> > > > > +
> > > > > +       npcm8xx_clk_data = devm_kzalloc(dev, struct_size(npcm8xx_clk_data, hws,
> > > > > +                                                        NPCM8XX_NUM_CLOCKS),
> > > > > +                                       GFP_KERNEL);
> > > > > +       if (!npcm8xx_clk_data)
> > > > > +               return -ENOMEM;
> > > > > +
> > > > > +       clk_regmap = syscon_node_to_regmap(parent_np);
> > > > > +       of_node_put(parent_np);
> > > >
> > > > Is there another binding update that is going to move this node to be a
> > > > child of the syscon?
> > > >
> > > >                 gcr: system-controller@f0800000 {
> > > >                         compatible = "nuvoton,npcm845-gcr", "syscon";
> > > >                         reg = <0x0 0xf0800000 0x0 0x1000>;
> > > >                 };
> > > No, sorry but I'm not going to use the GCR node the handle the clock
> > > and reset modules, the GCR has different memory space.
> > > the clock driver will have the following device tree
> >
> > What does the reset driver use the CGR node for? The driver looks like
> > it's using it to control USB phy resets.
> Yes, the USB PHY reset is handled through the GCR registers.
> >
> > >                sysctrl: system-controller@f0801000 {
> > >                         compatible = "syscon", "simple-mfd";
> > >                         reg = <0x0 0xf0801000 0x0 0x1000>;
> > >
> > >                         rstc: reset-controller {
> > >                                 compatible = "nuvoton,npcm845-reset";
> > >                                 reg = <0x0 0xf0801000 0x0 0xC4>;
> >
> > This isn't a valid reg property for a child node like this.
> O.K.
> >
> > >                                 #reset-cells = <2>;
> > >                                 nuvoton,sysgcr = <&gcr>;
> > >                         };
> > >
> > >                         clk: clock-controller {
> > >                                 compatible = "nuvoton,npcm845-clk";
> > >                                 #clock-cells = <1>;
> > >                                 clocks = <&refclk>;
> > >                                 clock-names = "refclk";
> > >                         };
> > >                 };
>
> Appreciate your guidance!
>
> Thanks,
>
> Tomer

