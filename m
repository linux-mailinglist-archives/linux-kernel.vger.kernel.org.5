Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBDB7FB6E4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343716AbjK1KOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234626AbjK1KOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:14:20 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51AD131
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:14:25 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-dae0ab8ac3eso4703806276.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701166465; x=1701771265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDYuOa0Z95bwZdXi4RNLwU1ybgqiSo1lhIUr1bukG28=;
        b=Fdd7PUO6SzzXdIq5iI/XvNCzBk+hkxOewh1DPhwMR8T/dplH9kLUt/NXZCHaB8CVS9
         7Xtg+Yh1IxJHxJKpdqnTv4Tm3dkHXfkD2mfP4wZXSxdwzpMO/7eF9W2lboBbL5T7OkL5
         Qlbf6fqGtBBep5ms9u+4r1ht3MB/xSaNnEUIia+Yfk9fsc5+Dsr7AWpyvtXWjqqi1KkA
         i0FXo9KtuCp0Q/Qut3aeHVJN7Vn8+mFzuZf/bXIgogD19IQx2XFTHFWSEtvGnuL33ZBG
         rtWgZZtfpnnqA8Dnq4vIi0q4hner7pFE13x81zY49e21xazGlPHzl4SzsQz5xdyJSMgD
         4lVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701166465; x=1701771265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDYuOa0Z95bwZdXi4RNLwU1ybgqiSo1lhIUr1bukG28=;
        b=IrGViUoa/Tyx7VVDdY+mziVYhlEa8TU2aW0boNEreirlcQJQX3D2Fuz09MGrmmIKnN
         ++Driq5fJpJrTk+1p56xW89kbmgnZkrgPrv5PgyPkauDqIhS0MQsV6kkc7K3y2LJhSEW
         cpmwpBetNKiVn2nwN2lbE93bVMMR5qB3hUdYLn7386HVgNbmLOSjeAABF7bDi7rco1ts
         9yIK0NRba0eLeAeg9q3dP2b6U6Ssqds5Jqlz4CI7ZR2qy6VcRLBGN9cIhb/n3JtVJnwM
         2uJkQCt5aWb57DHBlufB3bIistaFPiHEbWBKjYk3R/ZjpxBvb3o84QKyMGrrRP9js7/4
         ImPA==
X-Gm-Message-State: AOJu0Yxp3w7METDtkY9bmTFNxr6Wgzx6pzvUxqlPOqYd0gSk4P7z6Knh
        8ST928gZIq43gtsd/SpcYVpDpMZy1yDM3zDT9XXlLQ==
X-Google-Smtp-Source: AGHT+IFTMtIk4AxRTB0t45v1MEkPE7qtIltciuNCg31fummK1gEIueLA5ewKvHdFI5EF6O52jYMdCKHB/i4ypOEn7Wg=
X-Received: by 2002:a25:260c:0:b0:d89:4357:a9fd with SMTP id
 m12-20020a25260c000000b00d894357a9fdmr14050870ybm.18.1701166464923; Tue, 28
 Nov 2023 02:14:24 -0800 (PST)
MIME-Version: 1.0
References: <20231128061118.575847-1-ychuang570808@gmail.com> <20231128061118.575847-5-ychuang570808@gmail.com>
In-Reply-To: <20231128061118.575847-5-ychuang570808@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Nov 2023 11:14:12 +0100
Message-ID: <CACRpkda3ro2shN7W5iateMTL7RF6jDONUbwwVQ_QK5sBzP3jLg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] pinctrl: nuvoton: Add ma35d1 pinctrl and GPIO driver
To:     Jacky Huang <ychuang570808@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, p.zabel@pengutronix.de, j.neuschaefer@gmx.net,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ychuang3@nuvoton.com, schung@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacky,

thanks for your patch!

This is an interesting new driver. The initial review pass will be
along the lines "utilize helpers and library functions please".
You will see that this will shrink the core driver and make it
rely on core code helpers making it much easier to maintain
in the long run (I think).

On Tue, Nov 28, 2023 at 7:11=E2=80=AFAM Jacky Huang <ychuang570808@gmail.co=
m> wrote:

> +if ARCH_MA35 || COMPILE_TEST

Isn't it cleaner to put the depends on inside the Kconfig entries?
This looks a bit convoluted.

> +config PINCTRL_MA35
> +       bool
> +       depends on OF

So
depends on ARCH_MA35 || COMPILE_TEST here

> +       select GENERIC_PINCTRL_GROUPS
> +       select GENERIC_PINMUX_FUNCTIONS
> +       select GENERIC_PINCONF
> +       select GPIOLIB
> +       select GPIO_GENERIC
> +       select GPIOLIB_IRQCHIP
> +       select MFD_SYSCON
> +
> +config PINCTRL_MA35D1
> +       bool "Pinctrl and GPIO driver for Nuvoton MA35D1"
> +       depends on OF

Now depends on OF gets listed twice, which is confusing

> +       select PINCTRL_MA35

So use
depends on PINCTRL_MA35

instead, and this becomes a sub-choice.

> +#include <linux/clk.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_device.h>
> +#include <linux/of_address.h>

Do you really need them all?

Then I think you need <linux/platform_device.h> because
ma35d1_pinctrl_probe(struct platform_device *pdev)
passes a platform_device into this file.

> +struct ma35_pin_bank {
> +       void __iomem            *reg_base;
> +       struct clk              *clk;
> +       int                     irq;
> +       u8                      nr_pins;
> +       const char              *name;
> +       u8                      bank_num;
> +       bool                    valid;
> +       struct device_node      *of_node;

Just call the variable *np  ("noide pointer")
this is the most usual practice despite struct device
using thus long "of_node" name.

> +       struct gpio_chip        chip;
> +       struct irq_chip         irqc;

Please do not use dynamic irq_chips anymore, use an immutable
irq_chip, look in other drivers how to do this because we changed
almost all of them.

> +static int ma35_get_group_pins(struct pinctrl_dev *pctldev, unsigned int=
 selector,
> +                              const unsigned int **pins, unsigned int *n=
pins)
> +{
> +       struct ma35_pinctrl *npctl =3D pinctrl_dev_get_drvdata(pctldev);
> +
> +       if (selector >=3D npctl->ngroups)
> +               return -EINVAL;
> +
> +       *pins =3D npctl->groups[selector].pins;
> +       *npins =3D npctl->groups[selector].npins;
> +
> +       return 0;
> +}

Hm it looks simple.

Have you looked into using CONFIG_GENERIC_PINCTRL_GROUPS
and then you get a bunch of these functions such as
pinctrl_generic_get_group_count
pinctrl_generic_get_group_name
pinctrl_generic_get_group_name(this function)
pinctrl_generic_get_group
pinctrl_generic_group_name_to_selector
(etc)

for FREE, also using a radix tree which is neat.

> +static int ma35_pinctrl_dt_node_to_map_func(struct pinctrl_dev *pctldev,
> +                                           struct device_node *np,
> +                                           struct pinctrl_map **map,
> +                                           unsigned int *num_maps)
> +{
> +       struct ma35_pinctrl *npctl =3D pinctrl_dev_get_drvdata(pctldev);
> +       struct ma35_pin_group *grp;
> +       struct pinctrl_map *new_map;
> +       struct device_node *parent;
> +       int map_num =3D 1;
> +       int i;
> +
> +       /*
> +        * first find the group of this node and check if we need create
> +        * config maps for pins
> +        */
> +       grp =3D ma35_pinctrl_find_group_by_name(npctl, np->name);
> +       if (!grp) {
> +               dev_err(npctl->dev, "unable to find group for node %s\n",=
 np->name);
> +               return -EINVAL;
> +       }
> +
> +       map_num +=3D grp->npins;
> +       new_map =3D devm_kzalloc(pctldev->dev, sizeof(*new_map) * map_num=
, GFP_KERNEL);
> +       if (!new_map)
> +               return -ENOMEM;
> +
> +       *map =3D new_map;
> +       *num_maps =3D map_num;
> +       /* create mux map */
> +       parent =3D of_get_parent(np);
> +       if (!parent) {
> +               devm_kfree(pctldev->dev, new_map);
> +               return -EINVAL;
> +       }
> +
> +       new_map[0].type =3D PIN_MAP_TYPE_MUX_GROUP;
> +       new_map[0].data.mux.function =3D parent->name;
> +       new_map[0].data.mux.group =3D np->name;
> +       of_node_put(parent);
> +
> +       new_map++;
> +       for (i =3D 0; i < grp->npins; i++) {
> +               new_map[i].type =3D PIN_MAP_TYPE_CONFIGS_PIN;
> +               new_map[i].data.configs.group_or_pin =3D pin_get_name(pct=
ldev, grp->pins[i]);
> +               new_map[i].data.configs.configs =3D grp->settings[i].conf=
igs;
> +               new_map[i].data.configs.num_configs =3D grp->settings[i].=
nconfigs;
> +       }
> +       dev_dbg(pctldev->dev, "maps: function %s group %s num %d\n",
> +               (*map)->data.mux.function, (*map)->data.mux.group, map_nu=
m);
> +
> +       return 0;
> +}

This looks like it could be replaced with:
pinconf_generic_dt_node_to_map_group
pinconf_generic_dt_node_to_map_all

please check the generic helpers closely.

> +static void ma35_dt_free_map(struct pinctrl_dev *pctldev, struct pinctrl=
_map *map,
> +                            unsigned int num_maps)
> +{
> +       devm_kfree(pctldev->dev, map);
> +}

pinconf_generic_dt_free_map

> +static int ma35_pinmux_get_func_count(struct pinctrl_dev *pctldev)
> +{
> +       struct ma35_pinctrl *npctl =3D pinctrl_dev_get_drvdata(pctldev);
> +
> +       return npctl->nfunctions;
> +}

pinmux_generic_get_function_count
pinmux_generic_get_function_name
pinmux_generic_get_function_groups
(etc)

Please check the CONFIG_GENERIC_PINMUX_FUNCTIONS
option because these are again all very generic.

> +static int ma35_gpio_core_direction_in(struct gpio_chip *gc, unsigned in=
t gpio)
> +{
> +       struct ma35_pin_bank *bank =3D gpiochip_get_data(gc);
> +       void __iomem *reg_mode =3D bank->reg_base + MA35_GP_REG_MODE;
> +       unsigned long flags;
> +       unsigned int regval;
> +
> +       spin_lock_irqsave(&bank->lock, flags);
> +
> +       regval =3D readl(reg_mode);
> +
> +       regval &=3D ~GENMASK(gpio * 2 + 1, gpio * 2);
> +       regval |=3D MA35_GP_MODE_INPUT << gpio * 2;
> +
> +       writel(regval, reg_mode);
> +
> +       spin_unlock_irqrestore(&bank->lock, flags);
> +
> +       return 0;
> +}

The pinctrl set_mux is using a regmap but not the GPIO which is a bit
of a weird mix.

Further, if you were using regmap-mmio for GPIO, you could probably
utilize CONFIG_GPIO_REGMAP to simplify also this part of the
code with a library. Look at other drivers using this!

> +               if (bank->irq > 0) {
> +                       struct gpio_irq_chip *girq;
> +
> +                       girq =3D &bank->chip.irq;
> +                       girq->chip =3D &bank->irqc;
> +                       girq->chip->name =3D bank->name;
> +                       girq->chip->irq_disable =3D ma35_irq_gpio_mask;
> +                       girq->chip->irq_enable =3D ma35_irq_gpio_unmask;
> +                       girq->chip->irq_set_type =3D ma35_irq_irqtype;
> +                       girq->chip->irq_mask =3D ma35_irq_gpio_mask;
> +                       girq->chip->irq_unmask =3D ma35_irq_gpio_unmask;
> +                       girq->chip->flags =3D IRQCHIP_MASK_ON_SUSPEND |
> +                       IRQCHIP_SKIP_SET_WAKE | IRQCHIP_IMMUTABLE;
> +                       girq->parent_handler =3D ma35_irq_demux_intgroup;
> +                       girq->num_parents =3D 1;
> +
> +                       girq->parents =3D devm_kcalloc(&pdev->dev, 1, siz=
eof(*girq->parents),
> +                                                    GFP_KERNEL);
> +                       if (!girq->parents)
> +                               return -ENOMEM;
> +
> +                       girq->parents[0] =3D bank->irq;
> +                       girq->default_type =3D IRQ_TYPE_NONE;
> +                       girq->handler =3D handle_level_irq;
> +               }

As menioned, replace this with an immutable irq_chip.

Yours,
Linus Walleij
