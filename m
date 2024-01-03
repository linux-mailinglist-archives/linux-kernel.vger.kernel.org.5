Return-Path: <linux-kernel+bounces-15432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43460822BEB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C16571F222A7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2E018E16;
	Wed,  3 Jan 2024 11:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXllc8JK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A1818E0C;
	Wed,  3 Jan 2024 11:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dbdbfaab70eso6371113276.3;
        Wed, 03 Jan 2024 03:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704280487; x=1704885287; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GVbmSivqFm16l2ZyQvLc7/P+co6sVaCHTLFtmYuE64U=;
        b=KXllc8JKUpgHUbmeBPfzAeAvkI6dLr8KpsBj0TD581VlgFmolZENykuquIzeAgUlkq
         roPGPAi1BHGHLTb/nKPaNPSe6O40UDnAhoKdANVdDv11L++zO6w/PbTJLES8iYHVT53J
         rYop4rMgTvMbvNELTchqWMFfYFdkPof33Xo+qpyg+stB+MRgp7btoPJEOATTA7t9rD5j
         CdNIzrXh2kKvuY7cwyZBHyFuFfd1bubJxipuXHRuKGl/FBNwxS2QkFm9eHomA2a3oJWL
         ZHUFV5fAEN+Tko4zOSje6TWhNTAX/AvzXvwU/mfN40VVY9bcwsumR5GcBFa8TezJb6RT
         vm1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704280487; x=1704885287;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GVbmSivqFm16l2ZyQvLc7/P+co6sVaCHTLFtmYuE64U=;
        b=pfU9nt9jeceDBvCKJRUi432JMn2idElEA03liFPHzLY8Zc5hA6Ngo/iopTcWkB7XP1
         rtJa2RlWw0kkK4h/oJFmy0TZFjbCXPQEx0d4KAU3H9FZRGsZyZG/KGqRi5mPDqTeE4Vo
         YjymBWzCeJECV2M8aVioyIJ6pdJjGYgZDOgeJKTNmVMqmAPt2HrjKvxN3XAMU4tLMWou
         S0fThqEv4CGurlif+pSb8WA/fG5TDqhn3nfg7WuEqJod1I1XepywBq2y5ALU178P0CUY
         v8K/9sGnIKxFMIxBG05M9D/aRRrlpYVbhTzWk6y0NBiZFkbeowAF+op5AvKXpVpuk/MN
         IP3w==
X-Gm-Message-State: AOJu0YxF1rd/IauQyZIWodyVb/N4pnnQ0tude9Hc+hOZ9zucUZGCYsqI
	htFnSRa6PnVCLqqXJnL4/HQyCmnyHHTH4lRleH/y3ZOdR4U=
X-Google-Smtp-Source: AGHT+IE+uUWbonqqQ1YDN9GzN2DHvb4IXcQ8qjCyQF38y+zzd/JJa+SWQk84/EpX8TMl8fJDznYvsK/8hbAF/j2W9JM=
X-Received: by 2002:a81:9884:0:b0:5f0:8159:2df4 with SMTP id
 p126-20020a819884000000b005f081592df4mr3923785ywg.89.1704280486667; Wed, 03
 Jan 2024 03:14:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218170404.910153-1-tmaimon77@gmail.com> <7c322ab2ab59b434429ce471c148c026.sboyd@kernel.org>
 <CAP6Zq1gYJTRw9=w6cP3KXX2jg3SPk2KBqNrbcs9NoOs2JeUnAg@mail.gmail.com> <5b31aa5cfb1e819b03678d080b630667.sboyd@kernel.org>
In-Reply-To: <5b31aa5cfb1e819b03678d080b630667.sboyd@kernel.org>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Wed, 3 Jan 2024 13:14:35 +0200
Message-ID: <CAP6Zq1hTGWcG+63QV2rUVw92E51_NdoXCQaKTCrWNkJDGiEXwQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v21] clk: npcm8xx: add clock controller
To: Stephen Boyd <sboyd@kernel.org>
Cc: avifishman70@gmail.com, benjaminfair@google.com, joel@jms.id.au, 
	mturquette@baylibre.com, tali.perry1@gmail.com, venture@google.com, 
	yuenn@google.com, openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Stephen,

Thanks for your clarifications.

On Wed, 3 Jan 2024 at 01:52, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Tomer Maimon (2023-12-21 05:43:20)
> > Hi Stephen,
> >
> > Thanks for your comments
> >
> > On Thu, 21 Dec 2023 at 00:09, Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > > Quoting Tomer Maimon (2023-12-18 09:04:04)
> > > > diff --git a/drivers/clk/clk-npcm8xx.c b/drivers/clk/clk-npcm8xx.c
> > > > new file mode 100644
> > > > index 000000000000..e6c5111cc255
> > > > --- /dev/null
> > > > +++ b/drivers/clk/clk-npcm8xx.c
> > > > @@ -0,0 +1,552 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Nuvoton NPCM8xx Clock Generator
> > > > + * All the clocks are initialized by the bootloader, so this driver allows only
> > > > + * reading of current settings directly from the hardware.
> > > > + *
> > > > + * Copyright (C) 2020 Nuvoton Technologies
> > > > + * Author: Tomer Maimon <tomer.maimon@nuvoton.com>
> > > > + */
> > > > +
> > > > +#define pr_fmt(fmt) "npcm8xx_clk: " fmt
> > > > +
> > > > +#include <linux/bitfield.h>
> > > > +#include <linux/clk-provider.h>
> > > > +#include <linux/err.h>
> > > > +#include <linux/io.h>
> > > > +#include <linux/kernel.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/platform_device.h>
> > > > +#include <linux/slab.h>
> > > > +#include <linux/regmap.h>
> > > [...]
> > > > +#define NPCM8XX_CLK_S_CLKOUT      "clkout"
> > > > +#define NPCM8XX_CLK_S_PRE_ADC     "pre adc"
> > > > +#define NPCM8XX_CLK_S_UART        "uart"
> > > > +#define NPCM8XX_CLK_S_UART2       "uart2"
> > > > +#define NPCM8XX_CLK_S_TIMER       "timer"
> > > > +#define NPCM8XX_CLK_S_MMC         "mmc"
> > > > +#define NPCM8XX_CLK_S_SDHC        "sdhc"
> > > > +#define NPCM8XX_CLK_S_ADC         "adc"
> > > > +#define NPCM8XX_CLK_S_GFX         "gfx0_gfx1_mem"
> > > > +#define NPCM8XX_CLK_S_USBIF       "serial_usbif"
> > > > +#define NPCM8XX_CLK_S_USB_HOST    "usb_host"
> > > > +#define NPCM8XX_CLK_S_USB_BRIDGE  "usb_bridge"
> > > > +#define NPCM8XX_CLK_S_PCI         "pci"
> > > > +#define NPCM8XX_CLK_S_TH          "th"
> > > > +#define NPCM8XX_CLK_S_ATB         "atb"
> > > > +#define NPCM8XX_CLK_S_PRE_CLK     "pre_clk"
> > > > +#define NPCM8XX_CLK_S_RG         "rg"
> > > > +#define NPCM8XX_CLK_S_RCP        "rcp"
> > > > +
> > > > +static struct clk_hw hw_pll1_div2, hw_pll2_div2, hw_gfx_div2, hw_pre_clk;
> > > > +static struct npcm8xx_clk_pll_data npcm8xx_pll_clks[] = {
> > > > +       { NPCM8XX_CLK_S_PLL0, { .name = NPCM8XX_CLK_S_REFCLK }, NPCM8XX_PLLCON0, 0 },
> > >
> > > This is a new driver, so please stop using .name in clk_parent_data
> > > structures.
> > A few versions ago you suggested defining the reference clock in the
> > device tree,Can I use .fw_name since the reference clock in the device
> > tree
> >
> >         refclk: refclk-25mhz {
> >                 compatible = "fixed-clock";
> >                 clock-output-names = "refclk";
>
> Please don't use clock-output-names property.
Will remove
>
> >                 clock-frequency = <25000000>;
> >                 #clock-cells = <0>;
> >         };
>
> Use of this binding is fine assuming the reference clk is a real thing
> that exists outside the SoC. Is it?
Yes it is.
>
> >
> >         clk: clock-controller@f0801000 {
> >                  compatible = "nuvoton,npcm845-clk";
> >                  nuvoton,sysclk = <&rst>;
> >                  #clock-cells = <1>;
> >                  clocks = <&refclk>;
>
> This is index = 0
O.K.
>
> >                  clock-names = "refclk";
> >          };
> >
> > I will make sure to add refclk-25mhz to NPCM8xx device tree.
> > >
> > > > +       { NPCM8XX_CLK_S_PLL1, { .name = NPCM8XX_CLK_S_REFCLK }, NPCM8XX_PLLCON1, 0 },
> > > > +       { NPCM8XX_CLK_S_PLL2, { .name = NPCM8XX_CLK_S_REFCLK }, NPCM8XX_PLLCON2, 0 },
> > > > +       { NPCM8XX_CLK_S_PLL_GFX, { .name = NPCM8XX_CLK_S_REFCLK }, NPCM8XX_PLLCONG, 0 },
> > > > +};
> > > > +
> > > > +static const u32 cpuck_mux_table[] = { 0, 1, 2, 7 };
> > > > +static const struct clk_parent_data cpuck_mux_parents[] = {
> > > > +       { .hw = &npcm8xx_pll_clks[0].hw },
> > > > +       { .hw = &npcm8xx_pll_clks[1].hw },
> > > > +       { .index = 0 },
> > >
> > > This requires a binding update. As of today, there isn't a 'clocks'
> > > property for the nuvoton,npcm845-clk binding.
> > Can I use fw_name = NPCM8XX_CLK_S_REFCLK instead of  .index = 0 in
> > that way, I will not need to modify nuvoton,npcm845-clk binding.
>
> Why don't you want to modify the binding? If you add a clocks property
> like in the example above you will have to modify the binding.
Will add clocks property to nuvoton,npcm845-clk binding.

Thanks,

Tomer

