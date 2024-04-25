Return-Path: <linux-kernel+bounces-158466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3298B208C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 316061C23B14
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC7A12BF02;
	Thu, 25 Apr 2024 11:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJhVCzex"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C48D8528D;
	Thu, 25 Apr 2024 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714045229; cv=none; b=DLR4uVpFd90ROtkj5KzwKQl763n6nexXeKXjBIT6r6yw3s6lTcfhAF8x9TDUqrWzfECaz2DcaBE/GSaOANChJFobdB+M7TkP7bk9VknqSvnDQR1Ohxsm4iV7vbO0JresTAtdt02wKwwrlpqrowOy0x6B/XzfBOUA+2ikpeepPwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714045229; c=relaxed/simple;
	bh=P2bBCQSt7jxNjqJbsUjBZaYMNZKXq0ftcL7j1Mc1Msk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oIwpomjWYUCchb5vGTixS2W+f6GCM+I0C1xd3zMI1cQ7iJK0Bj0YtZNXSkyw6Ise1vb3rZhiJKhgcEfiYUSu+ja/S4iy0MelDHNtzsIEp0m7QpiV+ujxecm0RABMAx16ex0C9lVfM/BRg0hodHiad6ec0U0GH1rU37V2baJEFkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJhVCzex; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4db27d21a22so309413e0c.3;
        Thu, 25 Apr 2024 04:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714045227; x=1714650027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2j3MigI8NH+d9tQkVlNYjGUfIdSi+E3EDQqvgjTKO4=;
        b=ZJhVCzex4IZfvqX2kzS4mrEYWIGaB4nyNtfwFsje0GKIgrKGjBT0kiLc10yfNTfvw2
         ohza30tyIlT2ICHjY95dbs38/R9pLPsOiRPORfZ8xca50sWC2/X38XHagCqT3cFHJ1IR
         bkTDP5IMuLyP5qMU5P1nYg2HTT+KeCO7h0vfRn8Yq7zH7kqhF2sPk0L9oTg4+6PjkYRX
         t2wxQhJ7mty2VEMyhtHilFj3np1pwrMqLBas3m8eL8drppRgdYmGDjE4ghVhrTry1QXl
         1e+UB9ul6iOsZLI2BHj2B5+TS1JDqcrWbZFgdG5f6NF72i6d0WOOtF43KqoDw/wdyBij
         3BPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714045227; x=1714650027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+2j3MigI8NH+d9tQkVlNYjGUfIdSi+E3EDQqvgjTKO4=;
        b=YcqomU2QudKFLPm66okUI1ghQ89o6CrRIfTy0qidhBq77DaJzS2oe+JJtNrgOGHtfk
         9GjNK7Mu2DuxkOr9Ker2v2GwcL1Yk1oeD1GeIrjtPrG9KUpNsKVrZwyCxf95bD+rFKEO
         XGOG+YVyi9nBwd+yAXfq6hUzTQslJy6F5/OEzD9IE0CdSXB668UnyRzhONJDMrplq2oA
         5muvDfEpWAoNZ37iUeyAhqu7BD4MNJZOuy8Qt21Or6mLk2nf32g4lgskTSaZhei6wdqd
         qVsFsNyCa6K4ZwJkecuYMgou3a/NbR2qewLTbkvE3pg7B7oXOG/0HHQx1fWbQWVx/4d8
         wWJg==
X-Forwarded-Encrypted: i=1; AJvYcCUumNXfGJkSfBE+rHL/n0GOM4fGjTk73lAc9uDiYVCR5ebKbagxj445iZZQg1GB9ptRX0Bpa4pTqPWQHBYwr1lkbddVahQMkU4eIuch2TUt1sFAR8X+meEJ9jOAlHgtPbxLBINu9KodLY47kONGnYb5JJvcvIH51/TebnL23GCQZmBaiF85LqifquKAbxeuwYfI3WALzUfgm6LeO67zU0MJuEMDj1aXSA==
X-Gm-Message-State: AOJu0YwWqBJOTwVXrsb9fAOIWbRlLSoj/BNnaC0duC9IFl2RIgnE62WZ
	a1rVgNv1S3N/OyNj6rTtaNS2A5Uy8m68AnGqIgVw1V6vIaOtyuIPoJX87h40dqiyAj+JwB+qS6T
	Zyt9M5mXc8HuqhLRSrUeFCSZZMcs=
X-Google-Smtp-Source: AGHT+IHH+ElMXgp262UJLi2quqWfhPISWmMGS1bNCcZPUrybLQLRCO3bDBycNVluIG56q7wZ7IqSOIETxhbJbn1ZFpw=
X-Received: by 2002:a05:6122:1da7:b0:4d3:4aad:1b9c with SMTP id
 gg39-20020a0561221da700b004d34aad1b9cmr6810330vkb.0.1714045226911; Thu, 25
 Apr 2024 04:40:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423175900.702640-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240423175900.702640-7-prabhakar.mahadev-lad.rj@bp.renesas.com> <TY3PR01MB113461F28EA97F494D831267C86112@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB113461F28EA97F494D831267C86112@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 25 Apr 2024 12:40:00 +0100
Message-ID: <CA+V-a8sxu0eqSY1CsftHjU5mUmLAhKfApNpwEc3o=BjT23h_AQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/13] pinctrl: renesas: pinctrl-rzg2l: Add function
 pointers for locking/unlocking the PFC register
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Biju,

Thank you for the review.

On Tue, Apr 23, 2024 at 7:12=E2=80=AFPM Biju Das <biju.das.jz@bp.renesas.co=
m> wrote:
>
> Hi Prabhakar,
>
> Thanks for the patch.
>
> > -----Original Message-----
> > From: Prabhakar <prabhakar.csengg@gmail.com>
> > Sent: Tuesday, April 23, 2024 6:59 PM
> > Subject: [PATCH v2 06/13] pinctrl: renesas: pinctrl-rzg2l: Add function=
 pointers for
> > locking/unlocking the PFC register
> >
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > On the RZ/G2L SoC, the PFCWE bit controls writing to PFC registers.
> > However, on the RZ/V2H(P) SoC, the PFCWE (REGWE_A on RZ/V2H) bit contro=
ls writing to both PFC and
> > PMC registers. Additionally, BIT(7) B0WI is undocumented for the PWPR r=
egister on RZ/V2H(P) SoC. To
> > accommodate these differences across SoC variants, introduce the set_pf=
c_mode() and
> > pm_set_pfc() function pointers.
> >
> > Note, in rzg2l_pinctrl_set_pfc_mode() the pwpr_pfc_unlock() call is now=
 called before PMC
> > read/write and pwpr_pfc_lock() call is now called after PMC read/write =
this is to keep changes
> > minimal for RZ/V2H(P).
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > RFC->v2
> > - Introduced function pointer for (un)lock
> > ---
> >  drivers/pinctrl/renesas/pinctrl-rzg2l.c | 51 ++++++++++++++++---------
> >  1 file changed, 34 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/=
renesas/pinctrl-rzg2l.c
> > index bec4685b4681..0840fda7ca69 100644
> > --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > @@ -246,6 +246,8 @@ struct rzg2l_variable_pin_cfg {
> >       u64 pin:3;
> >  };
> >
> > +struct rzg2l_pinctrl;
> > +
> >  struct rzg2l_pinctrl_data {
> >       const char * const *port_pins;
> >       const u64 *port_pin_configs;
> > @@ -256,6 +258,8 @@ struct rzg2l_pinctrl_data {
> >       const struct rzg2l_hwcfg *hwcfg;
> >       const struct rzg2l_variable_pin_cfg *variable_pin_cfg;
> >       unsigned int n_variable_pin_cfg;
> > +     void (*pwpr_pfc_unlock)(struct rzg2l_pinctrl *pctrl);
> > +     void (*pwpr_pfc_lock)(struct rzg2l_pinctrl *pctrl);
> >  };
> >
> >  /**
> > @@ -462,7 +466,6 @@ static const struct rzg2l_variable_pin_cfg r9a07g04=
3f_variable_pin_cfg[] =3D
> > {  static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
> >                                      u8 pin, u8 off, u8 func)
> >  {
> > -     const struct rzg2l_register_offsets *regs =3D &pctrl->data->hwcfg=
->regs;
> >       unsigned long flags;
> >       u32 reg;
> >
> > @@ -473,27 +476,23 @@ static void rzg2l_pinctrl_set_pfc_mode(struct rzg=
2l_pinctrl *pctrl,
> >       reg &=3D ~(PM_MASK << (pin * 2));
> >       writew(reg, pctrl->base + PM(off));
> >
> > +     pctrl->data->pwpr_pfc_unlock(pctrl);
> > +
> >       /* Temporarily switch to GPIO mode with PMC register */
> >       reg =3D readb(pctrl->base + PMC(off));
> >       writeb(reg & ~BIT(pin), pctrl->base + PMC(off));
> >
> > -     /* Set the PWPR register to allow PFC register to write */
> > -     writel(0x0, pctrl->base + regs->pwpr);          /* B0WI=3D0, PFCW=
E=3D0 */
> > -     writel(PWPR_PFCWE, pctrl->base + regs->pwpr);   /* B0WI=3D0, PFCW=
E=3D1 */
> > -
> >       /* Select Pin function mode with PFC register */
> >       reg =3D readl(pctrl->base + PFC(off));
> >       reg &=3D ~(PFC_MASK << (pin * 4));
> >       writel(reg | (func << (pin * 4)), pctrl->base + PFC(off));
> >
> > -     /* Set the PWPR register to be write-protected */
> > -     writel(0x0, pctrl->base + regs->pwpr);          /* B0WI=3D0, PFCW=
E=3D0 */
> > -     writel(PWPR_B0WI, pctrl->base + regs->pwpr);    /* B0WI=3D1, PFCW=
E=3D0 */
> > -
> >       /* Switch to Peripheral pin function with PMC register */
> >       reg =3D readb(pctrl->base + PMC(off));
> >       writeb(reg | BIT(pin), pctrl->base + PMC(off));
> >
> > +     pctrl->data->pwpr_pfc_lock(pctrl);
> > +
> >       spin_unlock_irqrestore(&pctrl->lock, flags);  };
> >
> > @@ -2519,12 +2518,8 @@ static void rzg2l_pinctrl_pm_setup_dedicated_reg=
s(struct rzg2l_pinctrl
> > *pctrl, b  static void rzg2l_pinctrl_pm_setup_pfc(struct rzg2l_pinctrl =
*pctrl)  {
> >       u32 nports =3D pctrl->data->n_port_pins / RZG2L_PINS_PER_PORT;
> > -     const struct rzg2l_hwcfg *hwcfg =3D pctrl->data->hwcfg;
> > -     const struct rzg2l_register_offsets *regs =3D &hwcfg->regs;
> >
> > -     /* Set the PWPR register to allow PFC register to write. */
> > -     writel(0x0, pctrl->base + regs->pwpr);          /* B0WI=3D0, PFCW=
E=3D0 */
> > -     writel(PWPR_PFCWE, pctrl->base + regs->pwpr);   /* B0WI=3D0, PFCW=
E=3D1 */
> > +     pctrl->data->pwpr_pfc_unlock(pctrl);
> >
> >       /* Restore port registers. */
> >       for (u32 port =3D 0; port < nports; port++) { @@ -2567,9 +2562,7 =
@@ static void
> > rzg2l_pinctrl_pm_setup_pfc(struct rzg2l_pinctrl *pctrl)
> >               }
> >       }
> >
> > -     /* Set the PWPR register to be write-protected. */
> > -     writel(0x0, pctrl->base + regs->pwpr);          /* B0WI=3D0, PFCW=
E=3D0 */
> > -     writel(PWPR_B0WI, pctrl->base + regs->pwpr);    /* B0WI=3D1, PFCW=
E=3D0 */
> > +     pctrl->data->pwpr_pfc_lock(pctrl);
> >  }
> >
> >  static int rzg2l_pinctrl_suspend_noirq(struct device *dev) @@ -2631,6 =
+2624,24 @@ static int
> > rzg2l_pinctrl_resume_noirq(struct device *dev)
> >       return 0;
> >  }
> >
> > +static void rzg2l_pwpr_pfc_unlock(struct rzg2l_pinctrl *pctrl) {
> > +     const struct rzg2l_register_offsets *regs =3D &pctrl->data->hwcfg=
->regs;
> > +
> > +     /* Set the PWPR register to allow PFC register to write */
> > +     writel(0x0, pctrl->base + regs->pwpr);          /* B0WI=3D0, PFCW=
E=3D0 */
> > +     writel(PWPR_PFCWE, pctrl->base + regs->pwpr);   /* B0WI=3D0, PFCW=
E=3D1 */
> > +}
> > +
> > +static void rzg2l_pwpr_pfc_lock(struct rzg2l_pinctrl *pctrl) {
> > +     const struct rzg2l_register_offsets *regs =3D &pctrl->data->hwcfg=
->regs;
> > +
> > +     /* Set the PWPR register to be write-protected */
> > +     writel(0x0, pctrl->base + regs->pwpr);          /* B0WI=3D0, PFCW=
E=3D0 */
> > +     writel(PWPR_B0WI, pctrl->base + regs->pwpr);    /* B0WI=3D1, PFCW=
E=3D0 */
> > +}
> > +
> >  static const struct rzg2l_hwcfg rzg2l_hwcfg =3D {
> >       .regs =3D {
> >               .pwpr =3D 0x3014,
> > @@ -2688,6 +2699,8 @@ static struct rzg2l_pinctrl_data r9a07g043_data =
=3D {
> >       .variable_pin_cfg =3D r9a07g043f_variable_pin_cfg,
> >       .n_variable_pin_cfg =3D ARRAY_SIZE(r9a07g043f_variable_pin_cfg),
> >  #endif
> > +     .pwpr_pfc_unlock =3D &rzg2l_pwpr_pfc_unlock,
> > +     .pwpr_pfc_lock =3D &rzg2l_pwpr_pfc_lock,
> >  };
> >
> >  static struct rzg2l_pinctrl_data r9a07g044_data =3D { @@ -2699,6 +2712=
,8 @@ static struct
> > rzg2l_pinctrl_data r9a07g044_data =3D {
> >       .n_dedicated_pins =3D ARRAY_SIZE(rzg2l_dedicated_pins.common) +
> >               ARRAY_SIZE(rzg2l_dedicated_pins.rzg2l_pins),
> >       .hwcfg =3D &rzg2l_hwcfg,
> > +     .pwpr_pfc_unlock =3D &rzg2l_pwpr_pfc_unlock,
> > +     .pwpr_pfc_lock =3D &rzg2l_pwpr_pfc_lock,
> >  };
> >
> >  static struct rzg2l_pinctrl_data r9a08g045_data =3D { @@ -2709,6 +2724=
,8 @@ static struct
> > rzg2l_pinctrl_data r9a08g045_data =3D {
> >       .n_port_pins =3D ARRAY_SIZE(r9a08g045_gpio_configs) * RZG2L_PINS_=
PER_PORT,
> >       .n_dedicated_pins =3D ARRAY_SIZE(rzg3s_dedicated_pins),
> >       .hwcfg =3D &rzg3s_hwcfg,
> > +     .pwpr_pfc_unlock =3D &rzg2l_pwpr_pfc_unlock,
> > +     .pwpr_pfc_lock =3D &rzg2l_pwpr_pfc_lock,
>
> Some memory can be saved by avoiding duplication of data by using
> a single pointer for structure containing function pointers??
>
> struct rzg2l_pinctrl_fns {
>         void (*pwpr_pfc_unlock)(struct rzg2l_pinctrl *pctrl);
>         void (*pwpr_pfc_lock)(struct rzg2l_pinctrl *pctrl);
> }
>
Ok makes sense, I will do that in the next version.

Cheers,
Prabhakar

