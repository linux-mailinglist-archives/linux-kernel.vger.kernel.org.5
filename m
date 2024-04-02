Return-Path: <linux-kernel+bounces-128602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE66895CF4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C01EF1F21F81
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF8515D5CB;
	Tue,  2 Apr 2024 19:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKaGY/8V"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E908A15B996;
	Tue,  2 Apr 2024 19:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086989; cv=none; b=ITt1XtHx65nha6JxveJbWClLIGOU8eENYQQRms/1D1RoHs3eMZtJ6vFxSW89VevjwhthTW1j/4wq7pfuTdUwQVvcqOohzs32Ja8gYKNDJYZ1Cq37F+99vocz7PoMKZ2tzGQ/MAkfbyxJAkqtxTbm/SlHZKWqlM8Teyhb7bh76n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086989; c=relaxed/simple;
	bh=3LcCiLUKxttcM1GgoyjUCyAI4QYAu03gt6b0Rb/QW5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KhqEPP2p6zJ1zXp4FoOpmR/imzIGXr13jHDTFidLnoQPLgQlkCvVb5aE6hWoQfXgB33f2jiItBAzaMCOrV5tkKPIRdN5kLp+nC1dXrZSISnhZepH2jJ3VaDM39UcSxndki+b1i2UmHMTu9cGGeLhMr6Seg+j3ONAZF48lKeOd0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKaGY/8V; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6154a1812ffso4171527b3.1;
        Tue, 02 Apr 2024 12:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712086987; x=1712691787; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HTJVONLBOWfYIXXYyOhTTPw9XCjwbvXp4rskUKdwRDo=;
        b=HKaGY/8V1Z9Um0+z0/eWG7k8OD/QiLiNoRIQ5z3DvykcnApZwR7ZVfCP/cCXkd4yov
         5Eoxq1EDjyENhr0kwFAvPi7KYJHPCZqf7cGOeTqiXDDAfsI/sWve7tF3BBrLyKIYIZjV
         lLvl2ZDu0It5MCISrne3wGJ4H8TyeaXyJQnnbx6ilbAVZrH9Fnr0Ogpc153Y2cFOHrsm
         HKvFLISt++DE+1OzVpxkIsMlsjWpsLns618y596Q69EquTNu4cF2hCjvsfc4k0KU5C8A
         +PUB3F9mqaNAwfgPCNGZGxQzHpjR8AH2wwdYm561X7WWrd5JDU2K8NKvIqxn5wY3irwO
         Muxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712086987; x=1712691787;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HTJVONLBOWfYIXXYyOhTTPw9XCjwbvXp4rskUKdwRDo=;
        b=I3ApEKu4c1PEv1VGW86rn3zwcsOOW280y1kXkP759OncQtecv2QePgm/DFozejZDI6
         HzJK5yB9u/FwtU9mKW3krbGvrfrdTORs4yJuWv0KJ8bgT9AGLtdqz1NpS8vIyFq0wOwF
         TYleHk2nBnBhhGKI6mnfIPc0JQIiCE2tN9Z2cO1xD1lE9Eqzy4usDknFhaMQLB7oCaxv
         8XzxCMVoCbb8Gm0wnir4ezq7TJ9RVFsLActVRkcY1dEvaklN9eQmZYhbd13nmvsTXBtf
         iYQOUWLlFRNfvBqeHSQ9IS/JOdMHeB884jZYNiAqM/34zBOuzGW4Dti2pfRCHIu5/6rE
         HD6A==
X-Forwarded-Encrypted: i=1; AJvYcCU9O+dv+OUPhgMNvLTqO9mv2gXA2NzI8P+ZL1Wu6yU1jba6BFhyI10Nn16Gz8/wCYC13Yb7cgu9HcSWVZpCrNb4w1grnJHbDkIk+N0moZdXIOBWSPISdAcGesPyBOeXwyNeuM0/14C1C2YDwDPt3XoGlKgE6miuQJ58gK12noSPJ5HI3Q==
X-Gm-Message-State: AOJu0YxPq+r7JTBLUYFQI+tYcIQOS7UY8/MVydc+fI21ydQzHIZZrVDK
	+TzNbXs0wwoZb+aYYTPDeek3EEcY3k8GtOPD9/zAayMS4wntQSa1au5S4rHNezeQLPKMBwk2IOq
	99H8DVGZyfutF5YONbA1P9PJloBg=
X-Google-Smtp-Source: AGHT+IHYFFXpr3KeU33zxXhX2ZVeehOyLXhFmaJ6JQIOHWpfhAN0d/7P9DC2ivCdw+kd0pPLfV2tNokbt93OKVRLbgY=
X-Received: by 2002:a25:4604:0:b0:dd0:aa2c:4da5 with SMTP id
 t4-20020a254604000000b00dd0aa2c4da5mr10797136yba.6.1712086986537; Tue, 02 Apr
 2024 12:43:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131182653.2673554-1-tmaimon77@gmail.com> <20240131182653.2673554-4-tmaimon77@gmail.com>
 <74e003c6d80611ddd826ac21f48b4b3a.sboyd@kernel.org> <CAP6Zq1g5gwXvYzO5fnHxG-6__gSCpNBY7VeEPyr4Qtijya6EfQ@mail.gmail.com>
 <8acf846e767884978f3bb98646433551.sboyd@kernel.org> <CAP6Zq1htKQ5v0tH9HGRejnKwJ5ZauUWG_CzYUKegkVL4Ek8UxA@mail.gmail.com>
 <CAP6Zq1g4ksdLSVTm+PLqa5dSEidvHdpGZb=J9wKEftaH-Mg+bw@mail.gmail.com>
In-Reply-To: <CAP6Zq1g4ksdLSVTm+PLqa5dSEidvHdpGZb=J9wKEftaH-Mg+bw@mail.gmail.com>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Tue, 2 Apr 2024 22:42:55 +0300
Message-ID: <CAP6Zq1hk46xpQsVFz3RAF3CHU-PNCBxN+6SRKrdWzffRjRep4g@mail.gmail.com>
Subject: Re: [PATCH v23 3/3] clk: npcm8xx: add clock controller
To: Stephen Boyd <sboyd@kernel.org>
Cc: benjaminfair@google.com, joel@jms.id.au, krzysztof.kozlowski+dt@linaro.org, 
	mturquette@baylibre.com, robh+dt@kernel.org, tali.perry1@gmail.com, 
	venture@google.com, yuenn@google.com, openbmc@lists.ozlabs.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Stephen,

Kind remainder, appreciate if you can reply about the comment that
been sent few weeks ago.

Thanks,

Tomer

On Tue, 5 Mar 2024 at 17:59, Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> Hi Stephen,
>
> Appreciate it if you could reply to my email afew days ago, It is
> really important to us to move this driver to upstream.
>
> Thanks,
>
> Tomer
>
> On Thu, 29 Feb 2024 at 23:29, Tomer Maimon <tmaimon77@gmail.com> wrote:
> >
> > Hi Stephen,
> >
> > Thanks for your reply.
> >
> > On Thu, 29 Feb 2024 at 00:48, Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > > Quoting Tomer Maimon (2024-02-25 10:00:35)
> > > > Hi Stephen,
> > > >
> > > > On Thu, 22 Feb 2024 at 07:58, Stephen Boyd <sboyd@kernel.org> wrote:
> > > > >
> > > > > Quoting Tomer Maimon (2024-01-31 10:26:53)
> > > > > > diff --git a/drivers/clk/clk-npcm8xx.c b/drivers/clk/clk-npcm8xx.c
> > > > > > new file mode 100644
> > > > > > index 000000000000..eacb579d30af
> > > > > > --- /dev/null
> > > > > > +++ b/drivers/clk/clk-npcm8xx.c
> > > > > > @@ -0,0 +1,509 @@
> > > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > > +/*
> > > > > > + * Nuvoton NPCM8xx Clock Generator
> > > > > > + * All the clocks are initialized by the bootloader, so this driver allows only
> > > > > [...]
> > > > > > +
> > > > > > +/* external clock definition */
> > > > > > +#define NPCM8XX_CLK_S_REFCLK   "refclk"
> > > > > > +
> > > > > > +/* pll definition */
> > > > > > +#define NPCM8XX_CLK_S_PLL0     "pll0"
> > > > > > +#define NPCM8XX_CLK_S_PLL1     "pll1"
> > > > > > +#define NPCM8XX_CLK_S_PLL2     "pll2"
> > > > > > +#define NPCM8XX_CLK_S_PLL_GFX  "pll_gfx"
> > > > > > +
> > > > > > +/* early divider definition */
> > > > > > +#define NPCM8XX_CLK_S_PLL2_DIV2                "pll2_div2"
> > > > > > +#define NPCM8XX_CLK_S_PLL_GFX_DIV2     "pll_gfx_div2"
> > > > > > +#define NPCM8XX_CLK_S_PLL1_DIV2                "pll1_div2"
> > > > > > +
> > > > > > +/* mux definition */
> > > > > > +#define NPCM8XX_CLK_S_CPU_MUX     "cpu_mux"
> > > > > > +
> > > > > > +/* div definition */
> > > > > > +#define NPCM8XX_CLK_S_TH          "th"
> > > > > > +#define NPCM8XX_CLK_S_AXI         "axi"
> > > > >
> > > > > Please inline all these string #defines to the place they're used.
> > > > The version V21 you mention using define only when the definition is
> > > > used more than once
> > > > https://www.spinics.net/lists/kernel/msg5045826.html
> > > > Should I remove all the string definitions and add the string to the array?
> > >
> > > If it's a clk name for a clk registered in this file it should be
> > > inlined. Is that the case for everything besides refclk? And even refclk
> > > could be inlined so that we don't have to jump to the definition of a
> > > string.
> > I will add the string in the clock arrays and remove all the string definitions.
> > >
> > > > > > +
> > > > > > +static unsigned long npcm8xx_clk_div_get_parent(struct clk_hw *hw,
> > > > > > +                                               unsigned long parent_rate)
> > > > > > +{
> > > > > > +       struct npcm8xx_clk *div = to_npcm8xx_clk(hw);
> > > > > > +       unsigned int val;
> > > > > > +
> > > > > > +       regmap_read(div->clk_regmap, div->offset, &val);
> > > > > > +       val = val >> div->shift;
> > > > > > +       val &= clk_div_mask(div->width);
> > > > > > +
> > > > > > +       return divider_recalc_rate(hw, parent_rate, val, NULL, div->flags,
> > > > > > +                                  div->width);
> > > > > > +}
> > > > > > +
> > > > > > +static const struct clk_ops npcm8xx_clk_div_ops = {
> > > > > > +       .recalc_rate = npcm8xx_clk_div_get_parent,
> > > > > > +};
> > > > > > +
> > > > > > +static int npcm8xx_clk_probe(struct platform_device *pdev)
> > > > > > +{
> > > > > > +       struct device_node *parent_np = of_get_parent(pdev->dev.of_node);
> > > > >
> > > > > The parent of this device is not a syscon.
> > > > Once I have registered the map that handles both reset and the clock
> > > > in general is syscon, this is why we will modify the DTS so the clock
> > > > and the reset will be under syscon father node
> > > >                 sysctrl: system-controller@f0801000 {
> > > >                         compatible = "syscon", "simple-mfd";
> > > >                         reg = <0x0 0xf0801000 0x0 0x1000>;
> > > >
> > > >                         rstc: reset-controller {
> > > >                                 compatible = "nuvoton,npcm845-reset";
> > > >                                 reg = <0x0 0xf0801000 0x0 0xC4>;
> > > >                                 #reset-cells = <2>;
> > > >                                 nuvoton,sysgcr = <&gcr>;
> > > >                         };
> > > >
> > > >                         clk: clock-controller {
> > > >                                 compatible = "nuvoton,npcm845-clk";
> > > >                                 #clock-cells = <1>;
> > > >                                 clocks = <&refclk>;
> > > >                                 clock-names = "refclk";
> > > >                         };
> > > >                 };
> > > > You can see other drivers that using the same method like
> > > > https://elixir.bootlin.com/linux/v6.8-rc5/source/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml
> > >
> > > You will need a similar file like
> > > Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-perictrl.yaml
> > > then to describe the child nodes.
> > I can do it.
> > >
> > > Socionext may not be the best example to follow. I generally try to
> > > avoid syscon and simply put #reset-cells and #clock-cells in the node
> > If I remove syscon I can't use syscon_node_to_regmap function, What
> > should I use If I remove syscon? auxiliary bus? something else?
> > > for the device. You can use the auxiliary bus to register drivers for
> > > clk and reset and put them into the resepective driver directories.
> > I little bit confused, what is an auxiliary bus to register drivers,
> > can you provide me an example?
> > > Avoid syscon means random drivers can't reach into the device with a
> > > regmap handle and read/write registers that they're not supposed to.
> > Indeed, but the drivers could use the reset and clock memory map only
> > if the module is also a child node.
> >
> > Please let me know what is your preferred way to handle it:
> > 1. stick with syscon and upstream-defined documentation for the rst clk syscon.
> > 2. avoid syscon and use an auxiliary bus, appreciate if you could give
> > me an example of how it should be done.
> > 3. Avoid sycon and handle it differently.
> > >
> > > > >
> > > > > > +       struct clk_hw_onecell_data *npcm8xx_clk_data;
> > > > > > +       struct device *dev = &pdev->dev;
> > > > > > +       struct regmap *clk_regmap;
> > > > > > +       struct clk_hw *hw;
> > > > > > +       unsigned int i;
> > > > > > +
> > > > > > +       npcm8xx_clk_data = devm_kzalloc(dev, struct_size(npcm8xx_clk_data, hws,
> > > > > > +                                                        NPCM8XX_NUM_CLOCKS),
> > > > > > +                                       GFP_KERNEL);
> > > > > > +       if (!npcm8xx_clk_data)
> > > > > > +               return -ENOMEM;
> > > > > > +
> > > > > > +       clk_regmap = syscon_node_to_regmap(parent_np);
> > > > > > +       of_node_put(parent_np);
> > > > >
> > > > > Is there another binding update that is going to move this node to be a
> > > > > child of the syscon?
> > > > >
> > > > >                 gcr: system-controller@f0800000 {
> > > > >                         compatible = "nuvoton,npcm845-gcr", "syscon";
> > > > >                         reg = <0x0 0xf0800000 0x0 0x1000>;
> > > > >                 };
> > > > No, sorry but I'm not going to use the GCR node the handle the clock
> > > > and reset modules, the GCR has different memory space.
> > > > the clock driver will have the following device tree
> > >
> > > What does the reset driver use the CGR node for? The driver looks like
> > > it's using it to control USB phy resets.
> > Yes, the USB PHY reset is handled through the GCR registers.
> > >
> > > >                sysctrl: system-controller@f0801000 {
> > > >                         compatible = "syscon", "simple-mfd";
> > > >                         reg = <0x0 0xf0801000 0x0 0x1000>;
> > > >
> > > >                         rstc: reset-controller {
> > > >                                 compatible = "nuvoton,npcm845-reset";
> > > >                                 reg = <0x0 0xf0801000 0x0 0xC4>;
> > >
> > > This isn't a valid reg property for a child node like this.
> > O.K.
> > >
> > > >                                 #reset-cells = <2>;
> > > >                                 nuvoton,sysgcr = <&gcr>;
> > > >                         };
> > > >
> > > >                         clk: clock-controller {
> > > >                                 compatible = "nuvoton,npcm845-clk";
> > > >                                 #clock-cells = <1>;
> > > >                                 clocks = <&refclk>;
> > > >                                 clock-names = "refclk";
> > > >                         };
> > > >                 };
> >
> > Appreciate your guidance!
> >
> > Thanks,
> >
> > Tomer

