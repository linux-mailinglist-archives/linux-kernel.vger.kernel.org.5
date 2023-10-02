Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC1F7B4EA3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbjJBJEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235974AbjJBJEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:04:43 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1859CE9
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 02:04:38 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-45456121514so3686020137.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 02:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696237478; x=1696842278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6lSGzMYmbvQIYpVjiyxdxEmD3PDo3maFv/Yj2jKXkA=;
        b=gyK3ViCxB5CiK7cAFiaPb/6seSebdH7OUrotGMBqaF+yMjWGH3EEqLvyIqKlTgCQdC
         8cgX8x0zt2Zvx188KUUlL//un6jrwNUlV7PQaCBX2HCt16AKCgAlApyXEkHfyQL2Twyf
         +3ZDx2w2ZuiXpyFYj78R86tqlsTEc0ihmQYlN0OXf9yBkGU4L6rsk4CoGXLYBDKMghco
         fsexOMU+zFejkPr9Z1MxCxfQwSKNq2vR+FtZ+PGRKIUf7QYknI6Odc3HlBfsnxeX8rLT
         l6Ndz1IS+YlkrpHG8ejPKXaCCr/ayn63wuzJLKJ2HF8By4Yop1E2sGHHy2wvyDbcTDRt
         1U4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696237478; x=1696842278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6lSGzMYmbvQIYpVjiyxdxEmD3PDo3maFv/Yj2jKXkA=;
        b=Fp1pZs+Tjv4HTJt0whVYk7s7cED6gVatKze+mKah99mliPndxrA37ye0Wm3gszuEad
         91DuBYrVWxkCgZzfRH3BXUPztZnCJj8u6ZIEorA33jyDdE2jG6inmt4gz7yEfhMRc07k
         QWACik1r3U0gqPdA5XZSCqN6/RJnKh7wTUTQgXNIBYlNEuS4njfNA42q3I5ICWYPycwl
         lUUa9apq6N22KvTmSyVskFiuyq15FeYz9ojqsaHRGQmtGHPACOH398iFdRxTHqu3M4+e
         +3AL32oOGg4X9S5KPLlMkmqpBTZ+oeORgd1SEoRcMSemplGNoGWJg6Yj/jRdQ4pngtQu
         sTcw==
X-Gm-Message-State: AOJu0YxlJT5peIqh8uBQv/SWddDXsjb9XMqaM6Ypd7BSDW6qoX/nJZJq
        DVI/vftDDrlGXW0I7rWKJ54IFiABukuUqNkTNAZJYA==
X-Google-Smtp-Source: AGHT+IHJZy1TMb/fvXpxgZf1OGsiFiqP+dJU/QormPX81So2k7lHQizhtBNoZhxqRjcK9UBTsp9Haz+YSQw3rbHYVqY=
X-Received: by 2002:a67:ed4e:0:b0:452:5798:64bd with SMTP id
 m14-20020a67ed4e000000b00452579864bdmr7520196vsp.35.1696237477855; Mon, 02
 Oct 2023 02:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <20231001-vf610-gpio-v5-0-8d873a8f224a@nxp.com> <20231001-vf610-gpio-v5-4-8d873a8f224a@nxp.com>
In-Reply-To: <20231001-vf610-gpio-v5-4-8d873a8f224a@nxp.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 2 Oct 2023 11:04:27 +0200
Message-ID: <CAMRc=MdXkFBWMuyr8sbetyP2sJX2QG6Ce=Tsb7RVMguvGdC3TA@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] gpio: vf610: add i.MX8ULP of_device_id entry
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 1, 2023 at 10:23=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> i.MX8ULP/93 GPIO supports similar feature as i.MX7ULP GPIO, but i.MX8ULP =
is
> actually not hardware compatible with i.MX7ULP. i.MX8ULP only has one
> register base, not two bases. i.MX8ULP and i.MX93 actually has two
> interrupts for each gpio controller, one for Trustzone non-secure world,
> one for secure world.
>
> Although the Linux Kernel driver gpio-vf610.c could work with
> fsl,imx7ulp-gpio compatible, it is based on some tricks did in device tre=
e
> with some offset added to base address.
>
> Add a new of_device_id entry for i.MX8ULP. But to make the driver could
> also support old bindings, check the compatible string first, before
> check the device data.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/gpio/gpio-vf610.c | 47 ++++++++++++++++++++++++++++++++++++++++-=
------
>  1 file changed, 40 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
> index dbc7ba0ee72c..8e12706c0b22 100644
> --- a/drivers/gpio/gpio-vf610.c
> +++ b/drivers/gpio/gpio-vf610.c
> @@ -25,6 +25,7 @@
>  struct fsl_gpio_soc_data {
>         /* SoCs has a Port Data Direction Register (PDDR) */
>         bool have_paddr;
> +       bool have_dual_base;
>  };
>
>  struct vf610_gpio_port {
> @@ -60,13 +61,26 @@ struct vf610_gpio_port {
>  #define PORT_INT_EITHER_EDGE   0xb
>  #define PORT_INT_LOGIC_ONE     0xc
>
> +#define IMX8ULP_GPIO_BASE_OFF  0x40
> +#define IMX8ULP_BASE_OFF       0x80
> +
> +static const struct fsl_gpio_soc_data vf610_data =3D {
> +       .have_dual_base =3D true,
> +};
> +
>  static const struct fsl_gpio_soc_data imx_data =3D {
>         .have_paddr =3D true,
> +       .have_dual_base =3D true,
> +};
> +
> +static const struct fsl_gpio_soc_data imx8ulp_data =3D {
> +       .have_paddr =3D true,
>  };
>
>  static const struct of_device_id vf610_gpio_dt_ids[] =3D {
> -       { .compatible =3D "fsl,vf610-gpio",       .data =3D NULL, },
> +       { .compatible =3D "fsl,vf610-gpio",       .data =3D &vf610_data }=
,
>         { .compatible =3D "fsl,imx7ulp-gpio",     .data =3D &imx_data, },
> +       { .compatible =3D "fsl,imx8ulp-gpio",     .data =3D &imx8ulp_data=
, },
>         { /* sentinel */ }
>  };
>
> @@ -263,19 +277,38 @@ static int vf610_gpio_probe(struct platform_device =
*pdev)
>         struct gpio_irq_chip *girq;
>         int i;
>         int ret;
> +       bool dual_base;
>
>         port =3D devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
>         if (!port)
>                 return -ENOMEM;
>
>         port->sdata =3D of_device_get_match_data(dev);
> -       port->base =3D devm_platform_ioremap_resource(pdev, 0);
> -       if (IS_ERR(port->base))
> -               return PTR_ERR(port->base);
>
> -       port->gpio_base =3D devm_platform_ioremap_resource(pdev, 1);
> -       if (IS_ERR(port->gpio_base))
> -               return PTR_ERR(port->gpio_base);
> +       dual_base =3D port->sdata->have_dual_base;
> +
> +       /* support old compatible strings */
> +       if (device_is_compatible(dev, "fsl,imx7ulp-gpio") &&
> +           (device_is_compatible(dev, "fsl,imx93-gpio") ||

Why not just add this compatible to vf610_gpio_dt_ids?

Bart

> +           (device_is_compatible(dev, "fsl,imx8ulp-gpio"))))
> +               dual_base =3D true;
> +
> +       if (dual_base) {
> +               port->base =3D devm_platform_ioremap_resource(pdev, 0);
> +               if (IS_ERR(port->base))
> +                       return PTR_ERR(port->base);
> +
> +               port->gpio_base =3D devm_platform_ioremap_resource(pdev, =
1);
> +               if (IS_ERR(port->gpio_base))
> +                       return PTR_ERR(port->gpio_base);
> +       } else {
> +               port->base =3D devm_platform_ioremap_resource(pdev, 0);
> +               if (IS_ERR(port->base))
> +                       return PTR_ERR(port->base);
> +
> +               port->gpio_base =3D port->base + IMX8ULP_GPIO_BASE_OFF;
> +               port->base =3D port->base + IMX8ULP_BASE_OFF;
> +       }
>
>         port->irq =3D platform_get_irq(pdev, 0);
>         if (port->irq < 0)
>
> --
> 2.37.1
>
