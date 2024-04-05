Return-Path: <linux-kernel+bounces-133030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FAC899DBF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCDA61C23924
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF3F16D321;
	Fri,  5 Apr 2024 12:57:16 +0000 (UTC)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B2B16D4D3;
	Fri,  5 Apr 2024 12:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712321835; cv=none; b=XfO0x/mLj3a3ADgFas4CsP4LXnC3XaWQi3C8qe6me27HLJRzchAd8C7M0qT82xhAUQf+KrjOWk5FhlCaFUbO3DAy+TIz8fD3mZ4c1JRC6wnNNFoYanUmKNGxh4XFvjbU2VhkpBz1JCvOYga5jU0hcjw/hanAozOppkyjwU/XNSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712321835; c=relaxed/simple;
	bh=2YtxCtIfHL+1+HO+ks+D6RthwuzyQBykWodO082NqcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nKQJdYZBXtvqv0oh9JI3aMAScbTV5sJuHV3OgU40LrfcjpIZUPG6bXSRUiDOmSLb5cmcyBHx2iV4uNl4HBE1RNKxfKBDp9zQh2Lx/lBC3nNLFGXQQOaTP7unp3Am/9NaQCcgL8bJURazOcPy0ChQnRTND8SCSkD8TdkLH3HB2fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dcc6fc978ddso1759262276.0;
        Fri, 05 Apr 2024 05:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712321829; x=1712926629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IrYQalnHLpNlFPtXNRcvWmXwt3g+egtwV8d+Fjl7XAg=;
        b=lWaScKyTMPjDLZlXlZXd8hC5e/C0F8CMRpvEE7Wndpe9XyY1AGivuOd4soOCAJ3Sca
         zv7jTm80IOPceLWvrhds8RJ5cDIBXyda74r3qiJK4U4MVRBaXOWyfDnNWg3RIiJbGp1d
         Iva2FO+zJsBPgicaD6u9fYhk/Ju7BpaZsmRTvYTOEyV3uf+7l59lQzn+NhyW0XJnGRlz
         ZvB5OV7AjSpgdZK/vPaFwQA5TcnrJgW8zEa40ER6GiHCNcKICjIchHpBkPCfIB4PON6x
         PNqPApUrovXQ6J1mY7deja4OHKnugaIPkUlicvX6a6WXDfJuuMIJEJfCJqMhh0u9rytl
         3ELA==
X-Forwarded-Encrypted: i=1; AJvYcCU/WkinzxD1N7Oe8jTXZnse5TLsLglAFNt5gEFe3j01EJJ0Zh/cghOBJkXuNqI8yE1HR7rts4+w9kONd0GSyyK5MC9LCZu6cKjk/wpbN1p+A0/0En5TvD1XkusEYD919vDa5ZDIzRiUV4RP3oN87giRLCmJKSJGNUafTwQs/C6ltLuALkITGOcHgFuYjgd55lyNWzxS+ybIa9fmNMH07Jh7jhwXfEPO9MdCaAS69tSzmeHiWW5K9pC/X3Czj45DoNEoHii2eL/+65rjdwZFvLYPb2YrfE5hnCu439qjFwm1lye1cm0pl1b3QvEd3tppXOJB4YcFj3PxHEGYngdmHgsygjVgBzWl+RWEoVFBHanJcClugS59HIU=
X-Gm-Message-State: AOJu0Yy48WtO/yikFldb1xSDBkxcvJp4wgFAk4+NYc7wH/Y4HWmJUxd/
	kyBsHcOQJNuqpBzH5kX//grO1cRqZ7uvTLXP4eoXK7bzf5b4D9TdQCaSfDohKq4=
X-Google-Smtp-Source: AGHT+IEr1cWRfbRnWqwooGaruYL1olqIXbBlkHEnD+nK0QdasKLy/60NBLixdP9lFuE8mI19MpfUAw==
X-Received: by 2002:a5b:ed0:0:b0:dc6:f0ac:6b53 with SMTP id a16-20020a5b0ed0000000b00dc6f0ac6b53mr866097ybs.15.1712321829314;
        Fri, 05 Apr 2024 05:57:09 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id 133-20020a25198b000000b00dc2328c28ebsm296209ybz.51.2024.04.05.05.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 05:57:08 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc6cbe1ac75so1595520276.1;
        Fri, 05 Apr 2024 05:57:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW7omlBOIn7yssfNTnAvTG1djrkeJ4J6Yq/4eSM44Jd5SMBECoXwPcXZdsItin1OGLxarVqxwoEn7Oqa/d4jCkwtorvWZtc1IsPX3Y4LG9xyFT2C8PRVYyLaarZwQxDkm1wYQTNZVzYj9/xGhbAWewoRuAurPNDWfirVUsQnA7LFRHDMl+PeFecj6dglK2pNjb4mqMmeDNyUg4wCuf99+aT9/uSKqib3sXVO50zAs7Vs4zXVm5m/+n/R+A0Dno6cpqpbxnO64W/ngKt4SLRsbme1SX8mt4viWZ6FqfXALgPbGuyOs2AoJOPj1kbumDdVIzsfKfKIHGF+k1oV+qp99f0lSxiyTB3E76n2NPhHB08H0O8v2IGBOU=
X-Received: by 2002:a05:6902:2b10:b0:dcd:b806:7446 with SMTP id
 fi16-20020a0569022b1000b00dcdb8067446mr1084419ybb.1.1712321827974; Fri, 05
 Apr 2024 05:57:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712207606.git.ysato@users.sourceforge.jp> <9c1d56d37f5d3780d3c506ae680133b6bdaa5fdc.1712207606.git.ysato@users.sourceforge.jp>
In-Reply-To: <9c1d56d37f5d3780d3c506ae680133b6bdaa5fdc.1712207606.git.ysato@users.sourceforge.jp>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 5 Apr 2024 14:56:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVXvPW+3-sY2XPQ2aMcTZkK9zoMnxWeZ+PRB+VRgGszdQ@mail.gmail.com>
Message-ID: <CAMuHMdVXvPW+3-sY2XPQ2aMcTZkK9zoMnxWeZ+PRB+VRgGszdQ@mail.gmail.com>
Subject: Re: [RESEND v7 14/37] clk: Compatible with narrow registers
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Lee Jones <lee@kernel.org>, Helge Deller <deller@gmx.de>, 
	Heiko Stuebner <heiko.stuebner@cherry.de>, Shawn Guo <shawnguo@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	David Rientjes <rientjes@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Baoquan He <bhe@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Javier Martinez Canillas <javierm@redhat.com>, Guo Ren <guoren@kernel.org>, 
	Azeem Shaikh <azeemshaikh38@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jacky Huang <ychuang3@nuvoton.com>, 
	Herve Codina <herve.codina@bootlin.com>, 
	Manikanta Guntupalli <manikanta.guntupalli@amd.com>, Anup Patel <apatel@ventanamicro.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Sam Ravnborg <sam@ravnborg.org>, Sergey Shtylyov <s.shtylyov@omp.ru>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-ide@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sato-san,

On Thu, Apr 4, 2024 at 7:15=E2=80=AFAM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> divider and gate only support 32-bit registers.
> Older hardware uses narrower registers, so I want to be able to handle
> 8-bit and 16-bit wide registers.
>
> Seven clk_divider flags are used, and if I add flags for 8bit access and
> 16bit access, 8bit will not be enough, so I expanded it to u16.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for the update!

> --- a/drivers/clk/clk-divider.c
> +++ b/drivers/clk/clk-divider.c
> @@ -26,20 +26,38 @@
>   * parent - fixed parent.  No clk_set_parent support
>   */
>
> -static inline u32 clk_div_readl(struct clk_divider *divider)
> -{
> -       if (divider->flags & CLK_DIVIDER_BIG_ENDIAN)
> -               return ioread32be(divider->reg);
> -
> -       return readl(divider->reg);
> +static inline u32 clk_div_read(struct clk_divider *divider)
> +{
> +       if (divider->flags & CLK_DIVIDER_REG_8BIT)

When you need curly braces in one branch of an if/else statement,
please use curly braces in all branches (everywhere).

> +               return readb(divider->reg);
> +       else if (divider->flags & CLK_DIVIDER_REG_16BIT) {
> +               if (divider->flags & CLK_DIVIDER_BIG_ENDIAN)
> +                       return ioread16be(divider->reg);
> +               else
> +                       return readw(divider->reg);
> +       } else {
> +               if (divider->flags & CLK_DIVIDER_BIG_ENDIAN)
> +                       return ioread32be(divider->reg);
> +               else
> +                       return readl(divider->reg);
> +       }
>  }

> --- a/drivers/clk/clk-gate.c
> +++ b/drivers/clk/clk-gate.c

> @@ -137,12 +155,30 @@ struct clk_hw *__clk_hw_register_gate(struct device=
 *dev,
>         struct clk_init_data init =3D {};
>         int ret =3D -EINVAL;
>
> +       /* validate register size option and bit_idx */
>         if (clk_gate_flags & CLK_GATE_HIWORD_MASK) {
>                 if (bit_idx > 15) {
>                         pr_err("gate bit exceeds LOWORD field\n");
>                         return ERR_PTR(-EINVAL);
>                 }
>         }
> +       if (clk_gate_flags & CLK_GATE_REG_16BIT) {
> +               if (bit_idx > 15) {
> +                       pr_err("gate bit exceeds 16 bits\n");
> +                       return ERR_PTR(-EINVAL);
> +               }
> +       }
> +       if (clk_gate_flags & CLK_GATE_REG_8BIT) {
> +               if (bit_idx > 7) {
> +                       pr_err("gate bit exceeds 8 bits\n");
> +                       return ERR_PTR(-EINVAL);
> +               }
> +       }
> +       if ((clk_gate_flags & CLK_GATE_HIWORD_MASK) &&

If you use parentheses around "a & b" here...

> +           clk_gate_flags & (CLK_GATE_REG_8BIT | CLK_GATE_REG_16BIT)) {

please add parentheses here, too.

> +               pr_err("HIWORD_MASK required 32-bit register\n");
> +               return ERR_PTR(-EINVAL);
> +       }
>
>         /* allocate the gate */
>         gate =3D kzalloc(sizeof(*gate), GFP_KERNEL);
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 4a537260f655..eaa6ff1d0b2e 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -508,12 +508,16 @@ void of_fixed_clk_setup(struct device_node *np);
>   * CLK_GATE_BIG_ENDIAN - by default little endian register accesses are =
used for
>   *     the gate register.  Setting this flag makes the register accesses=
 big
>   *     endian.
> + * CLK_GATE_REG_8BIT - by default 32bit register accesses are used for
> + *     the gate register.  Setting this flag makes the register accesses=
 8bit.
> + * CLK_GATE_REG_16BIT - by default 32bit register accesses are used for
> + *     the gate register.  Setting this flag makes the register accesses=
 16bit.
>   */
>  struct clk_gate {
>         struct clk_hw hw;
>         void __iomem    *reg;
>         u8              bit_idx;
> -       u8              flags;
> +       u32             flags;

(from my comments on v6)
There is no need to increase the size of the flags field for the gate clock=
.


>         spinlock_t      *lock;
>  };
>

> @@ -675,13 +681,17 @@ struct clk_div_table {
>   * CLK_DIVIDER_BIG_ENDIAN - By default little endian register accesses a=
re used
>   *     for the divider register.  Setting this flag makes the register a=
ccesses
>   *     big endian.
> + * CLK_DIVIDER_REG_8BIT - by default 32bit register accesses are used fo=
r
> + *     the gate register.  Setting this flag makes the register accesses=
 8bit.
> + * CLK_DIVIDER_REG_16BIT - by default 32bit register accesses are used f=
or
> + *     the gate register.  Setting this flag makes the register accesses=
 16bit.
>   */
>  struct clk_divider {
>         struct clk_hw   hw;
>         void __iomem    *reg;
>         u8              shift;
>         u8              width;
> -       u8              flags;
> +       u16             flags;
>         const struct clk_div_table      *table;
>         spinlock_t      *lock;
>  };

> @@ -726,18 +738,18 @@ struct clk_hw *__clk_hw_register_divider(struct dev=
ice *dev,
>                 struct device_node *np, const char *name,
>                 const char *parent_name, const struct clk_hw *parent_hw,
>                 const struct clk_parent_data *parent_data, unsigned long =
flags,
> -               void __iomem *reg, u8 shift, u8 width, u8 clk_divider_fla=
gs,
> +               void __iomem *reg, u8 shift, u8 width, u32 clk_divider_fl=
ags,

"u16 clk_divider_flags", to match clk_divider.flags.

>                 const struct clk_div_table *table, spinlock_t *lock);
>  struct clk_hw *__devm_clk_hw_register_divider(struct device *dev,
>                 struct device_node *np, const char *name,
>                 const char *parent_name, const struct clk_hw *parent_hw,
>                 const struct clk_parent_data *parent_data, unsigned long =
flags,
> -               void __iomem *reg, u8 shift, u8 width, u8 clk_divider_fla=
gs,
> +               void __iomem *reg, u8 shift, u8 width, u32 clk_divider_fl=
ags,

Likewise.

>                 const struct clk_div_table *table, spinlock_t *lock);
>  struct clk *clk_register_divider_table(struct device *dev, const char *n=
ame,
>                 const char *parent_name, unsigned long flags,
>                 void __iomem *reg, u8 shift, u8 width,
> -               u8 clk_divider_flags, const struct clk_div_table *table,
> +               u32 clk_divider_flags, const struct clk_div_table *table,

Likewise.

>                 spinlock_t *lock);
>  /**
>   * clk_register_divider - register a divider clock with the clock framew=
ork

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

