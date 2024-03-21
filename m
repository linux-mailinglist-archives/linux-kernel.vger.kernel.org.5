Return-Path: <linux-kernel+bounces-109595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC6E881B3D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 542C9B223D3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8504728E7;
	Thu, 21 Mar 2024 02:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtA5qasU"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC9C365;
	Thu, 21 Mar 2024 02:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710988635; cv=none; b=ZQfvxRMyypj/V1klzFqdbMsIcp5gT2eP1EFC6RLjyUwUwXKgDfzfKW1u0HelZJaT9qlVuc8qErzNRymHIVW6LL3Tc2IQKparO5n9zGU5UB2jVGcflz3cJMU4+E1rHPjmC6XYnaEDm/l9ys72ARUcd2fuZNtaJgyN4tfMhQuiR9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710988635; c=relaxed/simple;
	bh=CDQt1YlQLAhtlbT4Myx10V0kdKAF3m4/QF+FXIBI/HI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YkuAQloTEZBKUEqEE+o7lp7qjfPlITTFYkYLepXpRC8O7mwlMPTP4iGAzF4rWuASkqMa/aZFMY83C+ZGfstk69o0rEEJCfxpfA7Q/6bZQ+AJOD6rUrHsvlAFwdxH6LGZxPeUw8jKscxHe5kWP2kaIPSNPSp0yXm1oCU/kQYUlqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtA5qasU; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3668fd6952bso1846585ab.1;
        Wed, 20 Mar 2024 19:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710988633; x=1711593433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=koXsnHcijzGLY1F8S6wKTc2Nx9yJYkvUhOdgOWDQa58=;
        b=EtA5qasUAynFdB+qj+fjySfBg81p+JXwe4OPiUdeReT05pkP3clzG9KtJMy45jaeb2
         v+aKNadkiWDfXStW/7y3Kx08MI8+Z06uJB6ki3eCzkr2UY+nxRxphlYV6F7nkQ65Amw8
         nEmlnblC0jdh/5Sq/2BRqhvk6GbVxhqJvsQtxSCbHr9VcQvRPq3gt+nu1KBgKeL1Cxtj
         Zj08lu7VxFNIXKEYI7O2RKalf7UzpBblECbAZaMB+AO7BrNmO/Jm88r6ddbgJSjbtA8l
         vFKbGPT7/ldB/heSqG9+9ILpOfCBUl7XRvY7zkpRIFJG0tPl2nANCRQOo42kFp/2PlxJ
         ra+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710988633; x=1711593433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=koXsnHcijzGLY1F8S6wKTc2Nx9yJYkvUhOdgOWDQa58=;
        b=otDV2IoMCRk6zQ6fqSADYBcmUKgWAjlji19aJ+BnkTFfWcHvbwtT4J0rQrWpt4AQ4f
         /voygidinckLgu+oR9oO3bUxFVln/MhSnKmia13mbF7mLct+0U8W/a8A8x3onomifOQg
         wxroMpBbiF6a406YtesK/TQImZRsihlxX9gFjll5yoBhD/5q0MxbO00s7kVRoQOYef/k
         h6WlZOc87WHkrEjs8WQG3r5XKBaeNjW6WOWneKP8jh8s75+Bw7BYU6hw0iwyFPMQ8p8I
         O3bIiOxyyqUX40PDdQwX9xO+HvDne7PA0660ebuDaGio5tTx7W9daeNMJrNIy5Nbl4ps
         apSA==
X-Forwarded-Encrypted: i=1; AJvYcCUqXPBzjq7KeONTKggpq/yZyHn16ME7+z0I+TWi6RCJr85Isx6egYTnNpWJJs3cRihnvfzEaoOb0LGPyB1Q0a0SuJi727NguxAvuHiCTta5LdRt2igzWWUDPZUCydSvCmmMn/A43RZp
X-Gm-Message-State: AOJu0YxFv7jgp3o11jmrs576Zibvr6s5+WOrW/ahiKGOdZehXb8nOyUQ
	RWJzrj2qPI8QEnP042OEZlQHg8fDw35Ew6/cPLU7OBXl0tuoCV0TKOAEP7eeCHaot2r6rmntEeX
	BIOSdYv7bWVQSR9xpRdhGtchu7Do=
X-Google-Smtp-Source: AGHT+IG5qt6Ka6RkWjarmzBDFE3pZdj4vzJ2sS1JF1kW63a1lO+f3xdfXSbX00MSb2mo90coln41s3nfWtbX9LVCbJ4=
X-Received: by 2002:a92:c609:0:b0:365:bee:2563 with SMTP id
 p9-20020a92c609000000b003650bee2563mr20562539ilm.32.1710988632691; Wed, 20
 Mar 2024 19:37:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1710925851-5643-1-git-send-email-shengjiu.wang@nxp.com> <20240320-posing-quit-ab4b13557cc9-mkl@pengutronix.de>
In-Reply-To: <20240320-posing-quit-ab4b13557cc9-mkl@pengutronix.de>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Thu, 21 Mar 2024 10:37:01 +0800
Message-ID: <CAA+D8ANkuKUX-GH2=xbo6d0pZ=Vkc2qXhpMLED5m94WPXdhFWA@mail.gmail.com>
Subject: Re: [PATCH v2] clk: imx: imx8mp: Add pm_runtime support for power saving
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org, peng.fan@nxp.com, 
	mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	linux-imx@nxp.com, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 5:50=E2=80=AFPM Marc Kleine-Budde <mkl@pengutronix.=
de> wrote:
>
> On 20.03.2024 17:10:51, Shengjiu Wang wrote:
> > Add pm_runtime support for power saving. In pm runtime suspend
> > state the registers will be reseted, so add registers save
> > in pm runtime suspend and restore them in pm runtime resume.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > Reviewed-by: Peng Fan <peng.fan@nxp.com>
> > ---
> > changes in v2:
> > - move pm_runtime_enable before the clk register
> >
> >  drivers/clk/imx/clk-imx8mp-audiomix.c | 150 +++++++++++++++++++++++---
> >  1 file changed, 137 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/cl=
k-imx8mp-audiomix.c
> > index 55ed211a5e0b..6042280d6404 100644
> > --- a/drivers/clk/imx/clk-imx8mp-audiomix.c
> > +++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
> > @@ -7,10 +7,12 @@
> >
> >  #include <linux/clk-provider.h>
> >  #include <linux/device.h>
> > +#include <linux/io.h>
> >  #include <linux/mod_devicetable.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> >
> >  #include <dt-bindings/clock/imx8mp-clock.h>
> >
> > @@ -18,6 +20,7 @@
> >
> >  #define CLKEN0                       0x000
> >  #define CLKEN1                       0x004
> > +#define EARC                 0x200
> >  #define SAI1_MCLK_SEL                0x300
> >  #define SAI2_MCLK_SEL                0x304
> >  #define SAI3_MCLK_SEL                0x308
> > @@ -26,6 +29,12 @@
> >  #define SAI7_MCLK_SEL                0x314
> >  #define PDM_SEL                      0x318
> >  #define SAI_PLL_GNRL_CTL     0x400
> > +#define SAI_PLL_FDIVL_CTL0   0x404
> > +#define SAI_PLL_FDIVL_CTL1   0x408
> > +#define SAI_PLL_SSCG_CTL     0x40C
> > +#define SAI_PLL_MNIT_CTL     0x410
> > +#define IPG_LP_CTRL          0x504
> > +#define REGS_NUM             16
>
> not needed
>
> >
> >  #define SAIn_MCLK1_PARENT(n)                                         \
> >  static const struct clk_parent_data                                  \
> > @@ -182,13 +191,65 @@ static struct clk_imx8mp_audiomix_sel sels[] =3D =
{
> >       CLK_SAIn(7)
> >  };
> >
> > +struct clk_imx8mp_audiomix_regs {
> > +     u32 regs_num;
> > +     u32 regs_off[];
>
> nitpick: if the offsets fit into an u16 you can save some space.
>
> > +};
> > +
> > +static const struct clk_imx8mp_audiomix_regs audiomix_regs =3D {
> > +     .regs_num =3D REGS_NUM,
> > +     .regs_off =3D {
> > +             CLKEN0,
> > +             CLKEN1,
> > +             EARC,
> > +             SAI1_MCLK_SEL,
> > +             SAI2_MCLK_SEL,
> > +             SAI3_MCLK_SEL,
> > +             SAI5_MCLK_SEL,
> > +             SAI6_MCLK_SEL,
> > +             SAI7_MCLK_SEL,
> > +             PDM_SEL,
> > +             SAI_PLL_GNRL_CTL,
> > +             SAI_PLL_FDIVL_CTL0,
> > +             SAI_PLL_FDIVL_CTL1,
> > +             SAI_PLL_SSCG_CTL,
> > +             SAI_PLL_MNIT_CTL,
> > +             IPG_LP_CTRL
> > +     },
> > +};
>
> You only need an array with the offsets, use ARRAY_SIZE() to get the
> number of entries in the array.
>
> > +
> > +struct clk_imx8mp_audiomix_drvdata {
> > +     void __iomem *base;
> > +     u32 regs_save[REGS_NUM];
>
> make use of ARRAY_SIZE() here
>
> > +};
> > +
> > +static void clk_imx8mp_audiomix_save_restore(struct device *dev, bool =
save)
> > +{
> > +     struct clk_imx8mp_audiomix_drvdata *drvdata =3D dev_get_drvdata(d=
ev);
> > +     void __iomem *base =3D drvdata->base;
> > +     int i;
> > +
> > +     if (save) {
> > +             for (i =3D 0; i < audiomix_regs.regs_num; i++)
> > +                     drvdata->regs_save[i] =3D readl(base + audiomix_r=
egs.regs_off[i]);
> > +     } else {
> > +             for (i =3D 0; i < audiomix_regs.regs_num; i++)
> > +                     writel(drvdata->regs_save[i], base + audiomix_reg=
s.regs_off[i]);
> > +     }
> > +}
> > +
> >  static int clk_imx8mp_audiomix_probe(struct platform_device *pdev)
> >  {
> > +     struct clk_imx8mp_audiomix_drvdata *drvdata;
> >       struct clk_hw_onecell_data *priv;
> >       struct device *dev =3D &pdev->dev;
> >       void __iomem *base;
> >       struct clk_hw *hw;
> > -     int i;
> > +     int i, ret;
> > +
> > +     drvdata =3D devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>
> You already allocate memory with devm_kzalloc() below. Why not increase
> the size?
>
> Rename clk_imx8mp_audiomix_drvdata to clk_imx8mp_audiomix_priv
> and add struct clk_hw_onecell_data to it.

Ok, I will update according to all the comments in the next version.

best regards
wang shengjiu

>
> > +     if (!drvdata)
> > +             return -ENOMEM;
> >
> >       priv =3D devm_kzalloc(dev,
> >                           struct_size(priv, hws, IMX8MP_CLK_AUDIOMIX_EN=
D),
> > @@ -202,6 +263,18 @@ static int clk_imx8mp_audiomix_probe(struct platfo=
rm_device *pdev)
> >       if (IS_ERR(base))
> >               return PTR_ERR(base);
> >
> > +     drvdata->base =3D base;
> > +     dev_set_drvdata(dev, drvdata);
> > +
> > +     /*
> > +      * pm_runtime_enable needs to be called before clk register.
> > +      * That is to make core->rpm_enabled to be true for clock
> > +      * usage.
> > +      */
> > +     pm_runtime_get_noresume(dev);
> > +     pm_runtime_set_active(dev);
> > +     pm_runtime_enable(dev);
> > +
> >       for (i =3D 0; i < ARRAY_SIZE(sels); i++) {
> >               if (sels[i].num_parents =3D=3D 1) {
> >                       hw =3D devm_clk_hw_register_gate_parent_data(dev,
> > @@ -216,8 +289,10 @@ static int clk_imx8mp_audiomix_probe(struct platfo=
rm_device *pdev)
> >                               0, NULL, NULL);
> >               }
> >
> > -             if (IS_ERR(hw))
> > -                     return PTR_ERR(hw);
> > +             if (IS_ERR(hw)) {
> > +                     ret =3D PTR_ERR(hw);
> > +                     goto err_clk_register;
> > +             }
> >
> >               priv->hws[sels[i].clkid] =3D hw;
> >       }
> > @@ -232,8 +307,10 @@ static int clk_imx8mp_audiomix_probe(struct platfo=
rm_device *pdev)
> >
> >       hw =3D imx_dev_clk_hw_pll14xx(dev, "sai_pll", "sai_pll_ref_sel",
> >                                   base + 0x400, &imx_1443x_pll);
> > -     if (IS_ERR(hw))
> > -             return PTR_ERR(hw);
> > +     if (IS_ERR(hw)) {
> > +             ret =3D PTR_ERR(hw);
> > +             goto err_clk_register;
> > +     }
> >       priv->hws[IMX8MP_CLK_AUDIOMIX_SAI_PLL] =3D hw;
> >
> >       hw =3D devm_clk_hw_register_mux_parent_data_table(dev,
> > @@ -241,26 +318,71 @@ static int clk_imx8mp_audiomix_probe(struct platf=
orm_device *pdev)
> >               ARRAY_SIZE(clk_imx8mp_audiomix_pll_bypass_sels),
> >               CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
> >               base + SAI_PLL_GNRL_CTL, 16, 1, 0, NULL, NULL);
> > -     if (IS_ERR(hw))
> > -             return PTR_ERR(hw);
> > +     if (IS_ERR(hw)) {
> > +             ret =3D PTR_ERR(hw);
> > +             goto err_clk_register;
> > +     }
> > +
> >       priv->hws[IMX8MP_CLK_AUDIOMIX_SAI_PLL_BYPASS] =3D hw;
> >
> >       hw =3D devm_clk_hw_register_gate(dev, "sai_pll_out", "sai_pll_byp=
ass",
> >                                      0, base + SAI_PLL_GNRL_CTL, 13,
> >                                      0, NULL);
> > -     if (IS_ERR(hw))
> > -             return PTR_ERR(hw);
> > +     if (IS_ERR(hw)) {
> > +             ret =3D PTR_ERR(hw);
> > +             goto err_clk_register;
> > +     }
> >       priv->hws[IMX8MP_CLK_AUDIOMIX_SAI_PLL_OUT] =3D hw;
> >
> >       hw =3D devm_clk_hw_register_fixed_factor(dev, "sai_pll_out_div2",
> >                                              "sai_pll_out", 0, 1, 2);
> > -     if (IS_ERR(hw))
> > -             return PTR_ERR(hw);
> > +     if (IS_ERR(hw)) {
> > +             ret =3D PTR_ERR(hw);
> > +             goto err_clk_register;
> > +     }
> > +
> > +     ret =3D devm_of_clk_add_hw_provider(&pdev->dev, of_clk_hw_onecell=
_get,
> > +                                       priv);
> > +     if (ret)
> > +             goto err_clk_register;
> > +
> > +     pm_runtime_put_sync(dev);
> > +     return 0;
> > +
> > +err_clk_register:
> > +     pm_runtime_put_sync(dev);
> > +     pm_runtime_disable(dev);
> > +     return ret;
> > +}
> > +
> > +static int clk_imx8mp_audiomix_remove(struct platform_device *pdev)
> > +{
> > +     pm_runtime_disable(&pdev->dev);
> >
> > -     return devm_of_clk_add_hw_provider(&pdev->dev, of_clk_hw_onecell_=
get,
> > -                                        priv);
> > +     return 0;
> >  }
> >
> > +static int clk_imx8mp_audiomix_runtime_suspend(struct device *dev)
> > +{
> > +     clk_imx8mp_audiomix_save_restore(dev, true);
> > +
> > +     return 0;
> > +}
> > +
> > +static int clk_imx8mp_audiomix_runtime_resume(struct device *dev)
> > +{
> > +     clk_imx8mp_audiomix_save_restore(dev, false);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct dev_pm_ops clk_imx8mp_audiomix_pm_ops =3D {
> > +     SET_RUNTIME_PM_OPS(clk_imx8mp_audiomix_runtime_suspend,
> > +                        clk_imx8mp_audiomix_runtime_resume, NULL)
> > +     SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> > +                                   pm_runtime_force_resume)
> > +};
> > +
> >  static const struct of_device_id clk_imx8mp_audiomix_of_match[] =3D {
> >       { .compatible =3D "fsl,imx8mp-audio-blk-ctrl" },
> >       { /* sentinel */ }
> > @@ -269,9 +391,11 @@ MODULE_DEVICE_TABLE(of, clk_imx8mp_audiomix_of_mat=
ch);
> >
> >  static struct platform_driver clk_imx8mp_audiomix_driver =3D {
> >       .probe  =3D clk_imx8mp_audiomix_probe,
> > +     .remove =3D clk_imx8mp_audiomix_remove,
> >       .driver =3D {
> >               .name =3D "imx8mp-audio-blk-ctrl",
> >               .of_match_table =3D clk_imx8mp_audiomix_of_match,
> > +             .pm =3D &clk_imx8mp_audiomix_pm_ops,
> >       },
> >  };
> >
> > --
> > 2.34.1
> >
> >
> >
>
> regards,
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

