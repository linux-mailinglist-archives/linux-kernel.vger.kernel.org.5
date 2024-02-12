Return-Path: <linux-kernel+bounces-61869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD8285179A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 900011C219A6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EF33C485;
	Mon, 12 Feb 2024 15:06:46 +0000 (UTC)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68BA3C47E;
	Mon, 12 Feb 2024 15:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707750406; cv=none; b=Z+3ocziLe4jIigyEHX453Jj3Ta2ZCBUoZotioj89DKIVz1X3GBluZCIyey2DAmcnzF7yG9YiyoA9zkfM5eAghN/FDPM/ZHajaNemhi50kkhJcy/gDbmnybAUY4AvWRwdUxWECZGtigJqDWNvN1N9LznHal4wBkXftlVaPjXElFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707750406; c=relaxed/simple;
	bh=ufnmT2e9W6WABLB7hjySQbl0BaqV/Nq73vu6yex5qFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n1bYGxwovZT/okc7ocHorUVJRIc4gigLcktKwS8ogbPCfOHxx73ekuBO1JVOs39pVHH/8NCHmp/f5iysZCfJDU6PffgkiOirl5wbv5EeIU2x0TVcnY2+lpXWqsfIxIJD1fDTAlf2154NlAsLZyjk/KcqzfWTemXRcemzhIZCXF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dcbbc41d3d5so322914276.3;
        Mon, 12 Feb 2024 07:06:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707750402; x=1708355202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aBYpbL0dwUHHMyiE3/WYZAgE3cO8Wbbe2N6Kc8nfj4s=;
        b=ixESpnbLYz3Crlt1CJ/WKv17oODLpMeS8T6LXvAju+L81kL+WTp6WLX6WsmBEjgh5r
         g9aRT5458Q4PVoGakZkm+5MS0GzTn2kF6v0ja1i4fMI8WR/cP72+cbXFLIYvIyBj0zSU
         qVlJ1ddK0WDMddWmCtsznH0lqPCT+kb9u7oMtb781PjSdJ5eZgMY7EMXiXs1paJRhmkB
         dvsd07bMkmGiRGtxPWr2JzCqYfa6/Gl1SC1JizULG0j4Cd5YfvE8qLmgVHvol2yiQmmm
         4hWI291FI1agIXJnl1ydQPoIdaLAZKLOwbq2Y4LwZv7t/+NeFW39biGf2XmByqw+RA/r
         A7mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHPT/rHdhT0aTskVl4ylL0/M6EV/jbV5HWNOHqPk8wAD85Tb8ef5Jakm1c7DebyxWY/aPkWm7E343oiePBFhrnbbJRGECCkDN9kOu7iRnvsJwsvFATmQjYCbO/v531+bYLYhj94j7VgwC6jQ1ONTEBpxgphVsMIQflGH4JnUZX6CUoZW69XAzQTG/E8fwqZWAnFwq9fPeFmfcU9N076vx4sAbsHo4Ovw==
X-Gm-Message-State: AOJu0YyC2L5GM2CveRqmcEf/Ppn3iU1QM8zV+RgPAOKf+7DEjiJNDAJ1
	gpFsCoj7RuXscPIr5u9rXYABEYiuCEBPpERsBcaQqkuIf8+c0jJ3XdoWTluzGvY=
X-Google-Smtp-Source: AGHT+IHz6VvCgpyoqm9gCZ5w++EtGkTJYD6Iv01W86LO4rU6HXC4B4El54S8sZHAsc8pshIT9wDK4Q==
X-Received: by 2002:a25:a28d:0:b0:dc6:db0c:4ff0 with SMTP id c13-20020a25a28d000000b00dc6db0c4ff0mr5654838ybi.32.1707750401871;
        Mon, 12 Feb 2024 07:06:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXfqP2bxEiN7SYCFI0mdeAxet/cVLsj2DZv9/rq/7NzL1avFODdWTopv0GozM1ewCdax0Yfq+EqDjM/Eoepx5hEcTGyz+Yze/XrZv+zmEp134MVwfZwReI8OKwOkrq7P6MpLTsKoiJWZRp2RextkJikVt3N2vPUKNQ1ZgOnvXkEiHOUkPfIuDxppr4I2ml1bXrYRB1eep4hHbxSwT6kfKQfYBUtsG8DWw==
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id w26-20020a25ac1a000000b00dc6bd47cc03sm1260067ybi.5.2024.02.12.07.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 07:06:41 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc236729a2bso3059250276.0;
        Mon, 12 Feb 2024 07:06:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUitnGNnBJFqV58VoJ0Cg80lXUA7S8wi8Y6worc1ooRp6te+ChZHbqWiLLE0pT+6th47Yfk4alczRY+i7Iqjm+nDod9hOw8fhp5QyNtu3f/MMf6sd19FYong/pILdOHP+w0HZ5tRPZerv7mX0w0vzl37tbK3dR+gAOFd8v2XXxEgllCaT+m+YUyK3gKtkKalOsJ58+mj++zSrsUGsL19R8aB+Tl2jkwEQ==
X-Received: by 2002:a05:6902:2007:b0:dc6:978:19a4 with SMTP id
 dh7-20020a056902200700b00dc6097819a4mr6031942ybb.56.1707750401390; Mon, 12
 Feb 2024 07:06:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208135629.2840932-1-claudiu.beznea.uj@bp.renesas.com> <20240208135629.2840932-2-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240208135629.2840932-2-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 Feb 2024 16:06:28 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUG595o8u1kgqW6DxfvBuzKuOPv7XkJhg_GQmnbRui8Tw@mail.gmail.com>
Message-ID: <CAMuHMdUG595o8u1kgqW6DxfvBuzKuOPv7XkJhg_GQmnbRui8Tw@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: renesas: rzg2l: Add suspend/resume support
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: magnus.damm@gmail.com, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, linus.walleij@linaro.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On Thu, Feb 8, 2024 at 6:59=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> w=
rote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> pinctrl-rzg2l driver is used on RZ/G3S which support deep sleep states
> where power to most of the SoC components is turned off.
>
> For this add suspend/resume support. This involves saving and restoring
> configured registers along with disabling clock in case there is no pin
> configured as wakeup sources.
>
> To save/restore registers 2 caches were allocated: one for GPIO pins and
> one for dedicated pins.
>
> On suspend path the pin controller registers are saved and if none of the
> pins are configured as wakeup sources the pinctrl clock is disabled.
> Otherwise it remains on.
>
> On resume path the configuration is done as follows:
> 1/ setup PFCs by writing to registers on pin based accesses
> 2/ setup GPIOs by writing to registers on port based accesses and
>    following configuration steps specified in hardware manual
> 3/ setup dedicated pins by writing to registers on port based accesses
> 4/ setup interrupts.
>
> Because interrupt signals are routed to IA55 interrupt controller and
> IA55 interrupt controller resumes before pin controller, patch restores
> also the configured interrupts just after pin settings are restored to
> avoid invalid interrupts while resuming.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

In my review below, I am focussing on the wake-up part, as that is
usually the hardest part to get right.

> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -260,6 +315,9 @@ struct rzg2l_pinctrl {
>         struct mutex                    mutex; /* serialize adding groups=
 and functions */
>
>         struct rzg2l_pinctrl_pin_settings *settings;
> +       struct rzg2l_pinctrl_reg_cache  *cache;
> +       struct rzg2l_pinctrl_reg_cache  *dedicated_cache;
> +       atomic_t                        wakeup_source;

I'd call this wakeup_path, as the wake-up source is the ultimate device
that triggers the GPIO.

>  };
>
>  static const u16 available_ps[] =3D { 1800, 2500, 3300 };
> @@ -1880,6 +1938,19 @@ static void rzg2l_gpio_irq_print_chip(struct irq_d=
ata *data, struct seq_file *p)
>         seq_printf(p, dev_name(gc->parent));
>  }
>
> +static int rzg2l_gpio_irq_set_wake(struct irq_data *data, unsigned int o=
n)
> +{
> +       struct gpio_chip *gc =3D irq_data_get_irq_chip_data(data);
> +       struct rzg2l_pinctrl *pctrl =3D container_of(gc, struct rzg2l_pin=
ctrl, gpio_chip);
> +

I think you also have to call irq_set_irq_wake(pctrl->hwirq[...]) here.
Cfr. drivers/gpio/gpio-rcar.c (which is simpler, as it has a single interru=
pt
parent, instead of a parent irq_domain with multiple interrupts).

> +       if (on)
> +               atomic_inc(&pctrl->wakeup_source);
> +       else
> +               atomic_dec(&pctrl->wakeup_source);
> +
> +       return 0;
> +}
> +
>  static const struct irq_chip rzg2l_gpio_irqchip =3D {
>         .name =3D "rzg2l-gpio",
>         .irq_disable =3D rzg2l_gpio_irq_disable,


> +static int rzg2l_pinctrl_suspend_noirq(struct device *dev)
> +{
> +       struct rzg2l_pinctrl *pctrl =3D dev_get_drvdata(dev);
> +       const struct rzg2l_hwcfg *hwcfg =3D pctrl->data->hwcfg;
> +       const struct rzg2l_register_offsets *regs =3D &hwcfg->regs;
> +       struct rzg2l_pinctrl_reg_cache *cache =3D pctrl->cache;
> +
> +       rzg2l_pinctrl_pm_setup_regs(pctrl, true);
> +       rzg2l_pinctrl_pm_setup_dedicated_regs(pctrl, true);
> +
> +       for (u8 i =3D 0; i < 2; i++) {
> +               cache->sd_ch[i] =3D readl(pctrl->base + SD_CH(regs->sd_ch=
, i));
> +               cache->eth_poc[i] =3D readl(pctrl->base + ETH_POC(regs->e=
th_poc, i));
> +       }
> +
> +       cache->qspi =3D readl(pctrl->base + QSPI);
> +       cache->eth_mode =3D readl(pctrl->base + ETH_MODE);
> +
> +       if (!atomic_read(&pctrl->wakeup_source))
> +               clk_disable_unprepare(pctrl->clk);

While you handle the module clock yourself, I think there is still merit
in calling device_set_wakeup_path(dev) when the clock is kept enabled.

BTW, is there any need to save the registers when pinctrl is part of
the wake-up path, and its module clock is not disabled?

> +
> +       return 0;
> +}
> +
> +static int rzg2l_pinctrl_resume_noirq(struct device *dev)
> +{
> +       struct rzg2l_pinctrl *pctrl =3D dev_get_drvdata(dev);
> +       const struct rzg2l_hwcfg *hwcfg =3D pctrl->data->hwcfg;
> +       const struct rzg2l_register_offsets *regs =3D &hwcfg->regs;
> +       struct rzg2l_pinctrl_reg_cache *cache =3D pctrl->cache;
> +       int ret;
> +
> +       if (!atomic_read(&pctrl->wakeup_source)) {
> +               ret =3D clk_prepare_enable(pctrl->clk);
> +               if (ret)
> +                       return ret;
> +       }

Is there any need to restore the registers when pinctrl is part of
the wake-up path, and its module clock was not disabled?

> +
> +       writel(cache->qspi, pctrl->base + QSPI);
> +       writel(cache->eth_mode, pctrl->base + ETH_MODE);
> +       for (u8 i =3D 0; i < 2; i++) {
> +               writel(cache->sd_ch[i], pctrl->base + SD_CH(regs->sd_ch, =
i));
> +               writel(cache->eth_poc[i], pctrl->base + ETH_POC(regs->eth=
_poc, i));
> +       }
> +
> +       rzg2l_pinctrl_pm_setup_pfc(pctrl);
> +       rzg2l_pinctrl_pm_setup_regs(pctrl, false);
> +       rzg2l_pinctrl_pm_setup_dedicated_regs(pctrl, false);
> +       rzg2l_gpio_irq_restore(pctrl);
> +
> +       return 0;
> +}

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

