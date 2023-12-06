Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CE9807251
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378920AbjLFOZO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Dec 2023 09:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378896AbjLFOZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:25:12 -0500
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5A4D44;
        Wed,  6 Dec 2023 06:25:17 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50bf8843a6fso1030415e87.0;
        Wed, 06 Dec 2023 06:25:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701872711; x=1702477511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDA9LsEzXKnJo1wcjgHnx7ZnSIK83XRKi/gmScgi8qk=;
        b=dPLR68lJjoZ25czORC4dh6mdx8kGzcKXvcZLZ+W/bKgF/c84mciwfDORcWjRyvI/6g
         pqidB1+DMkh2uBrltNI+eS8/tO/T/Kz84yk0h1UYaMSVuLJxYTgTYfvpVozlOpGDKVvy
         sZLH9fMvsefzpGSoBACytuTTHNcot6fxLkiTprFd8dSr+uTKrr0Tk0c/mHpSC025vnap
         hawnvMn6bzHmWjvxpVPhwcVbUEojFyTfW6LUVy7nnT3qJuwNQPnW9ujwSMufRJt9Ly1j
         r1Jy3vA/05kNzN/D0Yz0Icz5y65fT9Znmt6ppYRaZRXOVtko0rVzUAIQYDNxOJBnKuV7
         x3dA==
X-Gm-Message-State: AOJu0Yz+Dgv1CyotD063HpcHNvm22Xe3fZF/bTSfHUOi9d5kg1shBQ0M
        d4PDo0uCcIDFm7tcoBMet3p0xJoEYYakaoYX
X-Google-Smtp-Source: AGHT+IGbrQ+EHM5+D6j1Ak2j55FpNcMQQ8I5AWOMVw44/p4E1RRJCvVY2FbTFEdNkV4xeFN7RBHU8g==
X-Received: by 2002:a05:6512:230a:b0:50b:e92c:de18 with SMTP id o10-20020a056512230a00b0050be92cde18mr2580192lfu.22.1701872711123;
        Wed, 06 Dec 2023 06:25:11 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id x17-20020ac25dd1000000b0050bf16efc9csm1092937lfq.308.2023.12.06.06.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 06:25:09 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50c04ebe1bbso994987e87.1;
        Wed, 06 Dec 2023 06:25:09 -0800 (PST)
X-Received: by 2002:a05:6512:12c2:b0:50b:ca4c:fedd with SMTP id
 p2-20020a05651212c200b0050bca4cfeddmr798648lfg.31.1701872708833; Wed, 06 Dec
 2023 06:25:08 -0800 (PST)
MIME-Version: 1.0
References: <20231201131551.201503-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20231201131551.201503-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20231201131551.201503-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 6 Dec 2023 15:24:55 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW+Ky7Z2LPT6qFH-fodQzXuHXf00hc8NSgnkMFOUMNT=w@mail.gmail.com>
Message-ID: <CAMuHMdW+Ky7Z2LPT6qFH-fodQzXuHXf00hc8NSgnkMFOUMNT=w@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] pinctrl: renesas: pinctrl-rzg2l: Add the missing
 port pins P19 to P28
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-gpio@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

Thanks for your patch!

On Fri, Dec 1, 2023 at 2:16 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add the missing port pins P19 to P28 for RZ/Five SoC. These additional
> pins provide expanded capabilities and are exclusive to the RZ/Five SoC.
>
> Couple of port pins have different configuration and is not identical for

s/is/are/

> the complete port so introduced struct rzg2l_variable_pin_cfg to handle

introduce

> such cases and introduced PIN_CFG_VARIABLE macro. The actual pin config is

introduce the

> then assigned rzg2l_pinctrl_get_variable_pin_cfg().

assigned in

>
> Add an additional check in rzg2l_gpio_get_gpioint() to only allow GPIO pins
> which support interrupt facility.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/pinctrl/renesas/pinctrl-rzg2l.c | 215 +++++++++++++++++++++++-
>  1 file changed, 213 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> index 94d072c8a743..083cc63c2c82 100644
> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -57,6 +57,8 @@
>  #define PIN_CFG_FILCLKSEL              BIT(12)
>  #define PIN_CFG_IOLH_C                 BIT(13)
>  #define PIN_CFG_SOFT_PS                        BIT(14)
> +#define PIN_CFG_VARIABLE               BIT(15)
> +#define PIN_CFG_NOGPIO_INT             BIT(16)

Note to self: this conflicts with "[PATCH 08/14] pinctrl: renesas:
rzg2l: Add output enable support", so the numbers need to be adapted.

https://lore.kernel.org/all/20231120070024.4079344-9-claudiu.beznea.uj@bp.renesas.com

>
>  #define RZG2L_MPXED_COMMON_PIN_FUNCS(group) \
>                                         (PIN_CFG_IOLH_##group | \
> @@ -82,6 +84,11 @@
>   */
>  #define RZG2L_GPIO_PORT_PACK(n, a, f)  (((n) > 0 ? ((u64)(GENMASK_ULL(((n) - 1 + 28), 28))) : 0) | \
>                                          ((a) << 20) | (f))

I'd rather define RZG2L_GPIO_PORT_PACK() using RZG2L_GPIO_PORT_SPARSE_PACK():

 #define RZG2L_GPIO_PORT_PACK(n, a, f) \
        RZG2L_GPIO_PORT_SPARSE_PACK((1U << (n)) -1, (a), (f))


> +/*
> + * m indicates the bitmap of supported pins, a is the register index
> + * and f is pin configuration capabilities supported.
> + */
> +#define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)   (((u64)(m) << 28) | ((a) << 20) | (f))
>  #define RZG2L_GPIO_PORT_GET_PINMAP(x)  (((x) & GENMASK_ULL(35, 28)) >> 28)
>  #define RZG2L_GPIO_PORT_GET_PINCNT(x)  (hweight8(RZG2L_GPIO_PORT_GET_PINMAP((x))))
>
> @@ -185,6 +192,18 @@ struct rzg2l_dedicated_configs {
>         u64 config;
>  };
>
> +/**
> + * struct rzg2l_variable_pin_cfg - pin data cfg
> + * @cfg: port pin configuration
> + * @port: port number
> + * @pin: port pin
> + */
> +struct rzg2l_variable_pin_cfg {
> +       u32 cfg;
> +       u8 port;
> +       u8 pin;

As cfg only contains the lower bits (PIN_CFG_*), I think you can fit
everything in a u32:

    u32 cfg: 20;
    u32 port: 5;
    u32 pin: 3;

> +};
> +
>  struct rzg2l_pinctrl_data {
>         const char * const *port_pins;
>         const u64 *port_pin_configs;
> @@ -193,6 +212,8 @@ struct rzg2l_pinctrl_data {
>         unsigned int n_port_pins;
>         unsigned int n_dedicated_pins;
>         const struct rzg2l_hwcfg *hwcfg;
> +       const struct rzg2l_variable_pin_cfg *variable_pin_cfg;
> +       unsigned int n_variable_pin_cfg;
>  };
>
>  /**
> @@ -228,6 +249,158 @@ struct rzg2l_pinctrl {
>
>  static const u16 available_ps[] = { 1800, 2500, 3300 };
>
> +#ifdef CONFIG_RISCV
> +static u64 rzg2l_pinctrl_get_variable_pin_cfg(struct rzg2l_pinctrl *pctrl,
> +                                             u64 pincfg,
> +                                             unsigned int port,
> +                                             u8 pin)
> +{
> +       unsigned int i;
> +       u8 pincount;
> +       u8 pinmap;
> +       u32 off;
> +
> +       if (!pctrl->data->n_variable_pin_cfg)
> +               return pincfg;

This cannot happen (but implies a driver table bug).

> +
> +       for (i = 0; i < pctrl->data->n_variable_pin_cfg; i++) {
> +               if (pctrl->data->variable_pin_cfg[i].port == port &&
> +                   pctrl->data->variable_pin_cfg[i].pin == pin)
> +                       break;
> +       }
> +       if (i == pctrl->data->n_variable_pin_cfg)
> +               return pincfg;

My first thought was that this cannot happen either, but this function
is called for non-existent pins on sparse ports?

> +
> +       pinmap = RZG2L_GPIO_PORT_GET_PINMAP(pincfg);
> +       pincount = RZG2L_GPIO_PORT_GET_PINCNT(pincfg);
> +       off = RZG2L_PIN_CFG_TO_PORT_OFFSET(pincfg);
> +
> +       if (pinmap == pincount)

Huh?

> +               return RZG2L_GPIO_PORT_PACK(pincount, off, pctrl->data->variable_pin_cfg[i].cfg);
> +
> +       return RZG2L_GPIO_PORT_SPARSE_PACK(pinmap, off, pctrl->data->variable_pin_cfg[i].cfg);

Can't you just replace the lower bits of pincfg by
pctrl->data->variable_pin_cfg[i].cfg?

    return (pincfg & ~PIN_CFG_...) | pctrl->data->variable_pin_cfg[i].cfg;

And just move this single statement into if-condition in the for-loop
above?

> +}
> +
> +static const struct rzg2l_variable_pin_cfg r9a07g043f_variable_pin_cfg[] = {
> +       {
> +               .port = 20,
> +               .pin = 0,
> +               .cfg = PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD |
> +                      PIN_CFG_FILONOFF | PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL |
> +                      PIN_CFG_IEN | PIN_CFG_NOGPIO_INT,

Why do all new pins have PIN_CFG_NOGPIO_INT set?
P19_1, P20_0-2, P24_5, P25_1, P28_0-4 do have bits defined in an
Interrupt Enable Control Register (ISEL)?

> +       },

> @@ -1320,6 +1493,27 @@ static const u64 r9a07g043_gpio_configs[] = {
>         RZG2L_GPIO_PORT_PACK(2, 0x20, RZG2L_MPXED_PIN_FUNCS),
>         RZG2L_GPIO_PORT_PACK(4, 0x21, RZG2L_MPXED_PIN_FUNCS),
>         RZG2L_GPIO_PORT_PACK(6, 0x22, RZG2L_MPXED_PIN_FUNCS),
> +#ifdef CONFIG_RISCV
> +       /* Below additional port pins (P19 - P28) are exclusively available on RZ/Five SoC only */
> +       RZG2L_GPIO_PORT_SPARSE_PACK(0x2, 0x06, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD |
> +                                   PIN_CFG_FILONOFF | PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL |
> +                                   PIN_CFG_IEN | PIN_CFG_NOGPIO_INT),  /* P19 */
> +       RZG2L_GPIO_PORT_PACK(8, 0x07, PIN_CFG_VARIABLE),        /* P20 */
> +       RZG2L_GPIO_PORT_SPARSE_PACK(0x2, 0x08, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD |
> +                                   PIN_CFG_IEN | PIN_CFG_NOGPIO_INT),  /* P21 */
> +       RZG2L_GPIO_PORT_PACK(4, 0x09, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD |
> +                            PIN_CFG_IEN | PIN_CFG_NOGPIO_INT), /* P22 */
> +       RZG2L_GPIO_PORT_SPARSE_PACK(0x3e, 0x0a, PIN_CFG_VARIABLE),      /* P23 */
> +       RZG2L_GPIO_PORT_PACK(6, 0x0b, PIN_CFG_VARIABLE),        /* P24 */
> +       RZG2L_GPIO_PORT_SPARSE_PACK(0x2, 0x0c, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_FILONOFF |
> +                                   PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL |
> +                                   PIN_CFG_NOGPIO_INT),        /* P25 */
> +       0x0,    /* Dummy port P26 */
> +       0x0,    /* Dummy port P27 */
> +       RZG2L_GPIO_PORT_PACK(6, 0x0f, PIN_CFG_IOLH_A | PIN_CFG_SR | PIN_CFG_PUPD |
> +                            PIN_CFG_FILONOFF | PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL |
> +                            PIN_CFG_NOGPIO_INT),       /* P28 */

The P28 config can be simplified to "RZG2L_MPXED_PIN_FUNCS |
PIN_CFG_NOGPIO_INT".

> +#endif
>  };
>
>  static const u64 r9a08g045_gpio_configs[] = {
> @@ -1478,12 +1672,18 @@ static const struct rzg2l_dedicated_configs rzg3s_dedicated_pins[] = {
>                                                        PIN_CFG_IO_VMC_SD1)) },
>  };
>
> -static int rzg2l_gpio_get_gpioint(unsigned int virq, const struct rzg2l_pinctrl_data *data)
> +static int rzg2l_gpio_get_gpioint(unsigned int virq, struct rzg2l_pinctrl *pctrl)
>  {
> +       const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[virq];
> +       const struct rzg2l_pinctrl_data *data = pctrl->data;
> +       u64 *pin_data = pin_desc->drv_data;
>         unsigned int gpioint;
>         unsigned int i;
>         u32 port, bit;
>
> +       if (*pin_data & PIN_CFG_NOGPIO_INT)
> +               return -EINVAL;
> +
>         port = virq / 8;
>         bit = virq % 8;

Out-of-context, you have:

        gpioint = bit;
        for (i = 0; i < port; i++)
                gpioint +=
RZG2L_GPIO_PORT_GET_PINCNT(data->port_pin_configs[i]);

        return gpioint;

Shouldn't the for-loop skip pins with PIN_CFG_NOGPIO_INT set?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
