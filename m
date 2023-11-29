Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC5F7FCDCD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 05:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376838AbjK2ESe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 23:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjK2ESd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 23:18:33 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E3719A;
        Tue, 28 Nov 2023 20:18:38 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3b843fea0dfso3646883b6e.3;
        Tue, 28 Nov 2023 20:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701231518; x=1701836318; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uQo9/9z5ggX4xvrA9jYEd4qbwec1eXPiYblNhuRPU8Q=;
        b=KIvXrw49M1Kaizvl1DntPTRfXbiZWzXw4MW90qlXbQrR6lNRQ2mqu5/5cNqoKDjKfV
         1LJW9YzPRsco/7foTZxNtHb8HHVv3nic6fXGWhvGDkhD2ce65Xv5e/IkO6gzrU/Fc/M5
         ZHSf+MtdrDjJ7E+TJfxExpnAHibjp+eQCAvrnGcYnF/HNpD9ZgZuHqoINHuyuSH7LyIB
         /iLs0DSQwO9++8dKT+gabLP5ZWk0E9IEpi6EIEoY7jIPZxVZ8Qr78NiltTaWCf9Gi4pv
         29TggY2loLra7XLwJMUV802K4fE1iGoq9y1BXMzQndd6Y+ggpESKtpR1hEF0gOba82JJ
         Mh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701231518; x=1701836318;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uQo9/9z5ggX4xvrA9jYEd4qbwec1eXPiYblNhuRPU8Q=;
        b=UPNNyd52iXI7xdH/SkkTO7GJdcxsjmPEseeen9jJwTj1/CDZCbJvub48q+CfMRu03b
         CZH5kP3VZlGkEEc/h8MJ0MSjTwvNC2ejWYGUqFbxANA+5mj8toaE5QLupOiNP8EzTSJr
         pRbKm1AqpBr5ixr45o1vmqV0LJ3KWD5xAHz5Dc1Dv4JVpHwRNCMWGMuhD9UdXFNadnAp
         Ax5BUhfdkf3dl5wDUKNw6q6h2NI48P0jb6UYTjCyTsZcZEEyEd83gt8t8IsC2OPTG0Zb
         ECX36+o5lapDoUIFymu9oi4kftOWQ0k0Fybo1hla0AUhnm3IPw2K5UF6RgWEyU2SSBsK
         p+jg==
X-Gm-Message-State: AOJu0YwwrAzGOC5CWBhntrwOSRkAz2aWj1xdHNqTjBmBD7StQcnI5Ppi
        D/nnsb9ULJEBjKUQCX6Yq6NCQgJEOzQ=
X-Google-Smtp-Source: AGHT+IGnbvVFFBxz/r0jd3vOISqjQ9c742jdHZS/2oKmIVYMzg5ICvEH2oj6E+QhWt6z/F8775/vkQ==
X-Received: by 2002:a05:6808:1313:b0:3b8:63ff:7dc7 with SMTP id y19-20020a056808131300b003b863ff7dc7mr14461300oiv.36.1701231518069;
        Tue, 28 Nov 2023 20:18:38 -0800 (PST)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id e21-20020a656495000000b005b8ebef9fa0sm8889922pgv.83.2023.11.28.20.18.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 20:18:37 -0800 (PST)
Message-ID: <832e76a4-6881-4bc8-af17-4a449ebbea30@gmail.com>
Date:   Wed, 29 Nov 2023 12:18:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] pinctrl: nuvoton: Add ma35d1 pinctrl and GPIO
 driver
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, p.zabel@pengutronix.de, j.neuschaefer@gmx.net,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ychuang3@nuvoton.com, schung@nuvoton.com
References: <20231128061118.575847-1-ychuang570808@gmail.com>
 <20231128061118.575847-5-ychuang570808@gmail.com>
 <CACRpkda3ro2shN7W5iateMTL7RF6jDONUbwwVQ_QK5sBzP3jLg@mail.gmail.com>
Content-Language: en-US
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <CACRpkda3ro2shN7W5iateMTL7RF6jDONUbwwVQ_QK5sBzP3jLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linus,

Thanks for your review.

On 2023/11/28 下午 06:14, Linus Walleij wrote:
> Hi Jacky,
>
> thanks for your patch!
>
> This is an interesting new driver. The initial review pass will be
> along the lines "utilize helpers and library functions please".
> You will see that this will shrink the core driver and make it
> rely on core code helpers making it much easier to maintain
> in the long run (I think).
>
> On Tue, Nov 28, 2023 at 7:11 AM Jacky Huang <ychuang570808@gmail.com> wrote:
>
>> +if ARCH_MA35 || COMPILE_TEST
> Isn't it cleaner to put the depends on inside the Kconfig entries?
> This looks a bit convoluted.
>
>> +config PINCTRL_MA35
>> +       bool
>> +       depends on OF
> So
> depends on ARCH_MA35 || COMPILE_TEST here
>
>> +       select GENERIC_PINCTRL_GROUPS
>> +       select GENERIC_PINMUX_FUNCTIONS
>> +       select GENERIC_PINCONF
>> +       select GPIOLIB
>> +       select GPIO_GENERIC
>> +       select GPIOLIB_IRQCHIP
>> +       select MFD_SYSCON
>> +
>> +config PINCTRL_MA35D1
>> +       bool "Pinctrl and GPIO driver for Nuvoton MA35D1"
>> +       depends on OF
> Now depends on OF gets listed twice, which is confusing
>
>> +       select PINCTRL_MA35
> So use
> depends on PINCTRL_MA35
>
> instead, and this becomes a sub-choice.

OK, I will fix the above issues. It will be:

config PINCTRL_MA35
     bool "Pinctrl and GPIO driver for Nuvoton MA35 series"
     depends on (ARCH_MA35 || COMPILE_TEST) && OF
     select GENERIC_PINCTRL_GROUPS
     select GENERIC_PINMUX_FUNCTIONS
     select GENERIC_PINCONF
     select GPIOLIB
     select GPIO_GENERIC
     select GPIOLIB_IRQCHIP
     select MFD_SYSCON

config PINCTRL_MA35D1
     bool "Pinctrl and GPIO driver for Nuvoton MA35D1"
     depends on PINCTRL_MA35
     help
       Say Y here to enable pin controller and GPIO support
       for Nuvoton MA35D1 SoC.

>> +#include <linux/clk.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/of.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/of_device.h>
>> +#include <linux/of_address.h>
> Do you really need them all?
>
> Then I think you need <linux/platform_device.h> because
> ma35d1_pinctrl_probe(struct platform_device *pdev)
> passes a platform_device into this file.

I will have a compile test and remove unnecessary ones and
add <linux/platform_device.h>.

>> +struct ma35_pin_bank {
>> +       void __iomem            *reg_base;
>> +       struct clk              *clk;
>> +       int                     irq;
>> +       u8                      nr_pins;
>> +       const char              *name;
>> +       u8                      bank_num;
>> +       bool                    valid;
>> +       struct device_node      *of_node;
> Just call the variable *np  ("noide pointer")
> this is the most usual practice despite struct device
> using thus long "of_node" name.

OK, I will use 'struct device_node *np'.

>> +       struct gpio_chip        chip;
>> +       struct irq_chip         irqc;
> Please do not use dynamic irq_chips anymore, use an immutable
> irq_chip, look in other drivers how to do this because we changed
> almost all of them.

I will use immutable instead.
>> +static int ma35_get_group_pins(struct pinctrl_dev *pctldev, unsigned int selector,
>> +                              const unsigned int **pins, unsigned int *npins)
>> +{
>> +       struct ma35_pinctrl *npctl = pinctrl_dev_get_drvdata(pctldev);
>> +
>> +       if (selector >= npctl->ngroups)
>> +               return -EINVAL;
>> +
>> +       *pins = npctl->groups[selector].pins;
>> +       *npins = npctl->groups[selector].npins;
>> +
>> +       return 0;
>> +}
> Hm it looks simple.
>
> Have you looked into using CONFIG_GENERIC_PINCTRL_GROUPS
> and then you get a bunch of these functions such as
> pinctrl_generic_get_group_count
> pinctrl_generic_get_group_name
> pinctrl_generic_get_group_name(this function)
> pinctrl_generic_get_group
> pinctrl_generic_group_name_to_selector
> (etc)
>
> for FREE, also using a radix tree which is neat.

Thank you for your reminder. I will look into how to use 
CONFIG_GENERIC_PINCTRL_GROUPS.

>> +static int ma35_pinctrl_dt_node_to_map_func(struct pinctrl_dev *pctldev,
>> +                                           struct device_node *np,
>> +                                           struct pinctrl_map **map,
>> +                                           unsigned int *num_maps)
>> +{
>> +       struct ma35_pinctrl *npctl = pinctrl_dev_get_drvdata(pctldev);
>> +       struct ma35_pin_group *grp;
>> +       struct pinctrl_map *new_map;
>> +       struct device_node *parent;
>> +       int map_num = 1;
>> +       int i;
>> +
>> +       /*
>> +        * first find the group of this node and check if we need create
>> +        * config maps for pins
>> +        */
>> +       grp = ma35_pinctrl_find_group_by_name(npctl, np->name);
>> +       if (!grp) {
>> +               dev_err(npctl->dev, "unable to find group for node %s\n", np->name);
>> +               return -EINVAL;
>> +       }
>> +
>> +       map_num += grp->npins;
>> +       new_map = devm_kzalloc(pctldev->dev, sizeof(*new_map) * map_num, GFP_KERNEL);
>> +       if (!new_map)
>> +               return -ENOMEM;
>> +
>> +       *map = new_map;
>> +       *num_maps = map_num;
>> +       /* create mux map */
>> +       parent = of_get_parent(np);
>> +       if (!parent) {
>> +               devm_kfree(pctldev->dev, new_map);
>> +               return -EINVAL;
>> +       }
>> +
>> +       new_map[0].type = PIN_MAP_TYPE_MUX_GROUP;
>> +       new_map[0].data.mux.function = parent->name;
>> +       new_map[0].data.mux.group = np->name;
>> +       of_node_put(parent);
>> +
>> +       new_map++;
>> +       for (i = 0; i < grp->npins; i++) {
>> +               new_map[i].type = PIN_MAP_TYPE_CONFIGS_PIN;
>> +               new_map[i].data.configs.group_or_pin = pin_get_name(pctldev, grp->pins[i]);
>> +               new_map[i].data.configs.configs = grp->settings[i].configs;
>> +               new_map[i].data.configs.num_configs = grp->settings[i].nconfigs;
>> +       }
>> +       dev_dbg(pctldev->dev, "maps: function %s group %s num %d\n",
>> +               (*map)->data.mux.function, (*map)->data.mux.group, map_num);
>> +
>> +       return 0;
>> +}
> This looks like it could be replaced with:
> pinconf_generic_dt_node_to_map_group
> pinconf_generic_dt_node_to_map_all
>
> please check the generic helpers closely.

Alright, I will try using these helpers to simplify the code.

>> +static void ma35_dt_free_map(struct pinctrl_dev *pctldev, struct pinctrl_map *map,
>> +                            unsigned int num_maps)
>> +{
>> +       devm_kfree(pctldev->dev, map);
>> +}
> pinconf_generic_dt_free_map

I will fix it.

>
>> +static int ma35_pinmux_get_func_count(struct pinctrl_dev *pctldev)
>> +{
>> +       struct ma35_pinctrl *npctl = pinctrl_dev_get_drvdata(pctldev);
>> +
>> +       return npctl->nfunctions;
>> +}
> pinmux_generic_get_function_count
> pinmux_generic_get_function_name
> pinmux_generic_get_function_groups
> (etc)
>
> Please check the CONFIG_GENERIC_PINMUX_FUNCTIONS
> option because these are again all very generic.

I will try to use these helpers and have a test.

>> +static int ma35_gpio_core_direction_in(struct gpio_chip *gc, unsigned int gpio)
>> +{
>> +       struct ma35_pin_bank *bank = gpiochip_get_data(gc);
>> +       void __iomem *reg_mode = bank->reg_base + MA35_GP_REG_MODE;
>> +       unsigned long flags;
>> +       unsigned int regval;
>> +
>> +       spin_lock_irqsave(&bank->lock, flags);
>> +
>> +       regval = readl(reg_mode);
>> +
>> +       regval &= ~GENMASK(gpio * 2 + 1, gpio * 2);
>> +       regval |= MA35_GP_MODE_INPUT << gpio * 2;
>> +
>> +       writel(regval, reg_mode);
>> +
>> +       spin_unlock_irqrestore(&bank->lock, flags);
>> +
>> +       return 0;
>> +}
> The pinctrl set_mux is using a regmap but not the GPIO which is a bit
> of a weird mix.
>
> Further, if you were using regmap-mmio for GPIO, you could probably
> utilize CONFIG_GPIO_REGMAP to simplify also this part of the
> code with a library. Look at other drivers using this!

Sorry, I'm not quite clear on the issue. This function is just setting 
the input/output
direction for a GPIO pin. The code here is only configuring the GPIO 
control register.
I've observed similar implementations in other drivers, such as in 
pinctrl-amd.c.


>> +               if (bank->irq > 0) {
>> +                       struct gpio_irq_chip *girq;
>> +
>> +                       girq = &bank->chip.irq;
>> +                       girq->chip = &bank->irqc;
>> +                       girq->chip->name = bank->name;
>> +                       girq->chip->irq_disable = ma35_irq_gpio_mask;
>> +                       girq->chip->irq_enable = ma35_irq_gpio_unmask;
>> +                       girq->chip->irq_set_type = ma35_irq_irqtype;
>> +                       girq->chip->irq_mask = ma35_irq_gpio_mask;
>> +                       girq->chip->irq_unmask = ma35_irq_gpio_unmask;
>> +                       girq->chip->flags = IRQCHIP_MASK_ON_SUSPEND |
>> +                       IRQCHIP_SKIP_SET_WAKE | IRQCHIP_IMMUTABLE;
>> +                       girq->parent_handler = ma35_irq_demux_intgroup;
>> +                       girq->num_parents = 1;
>> +
>> +                       girq->parents = devm_kcalloc(&pdev->dev, 1, sizeof(*girq->parents),
>> +                                                    GFP_KERNEL);
>> +                       if (!girq->parents)
>> +                               return -ENOMEM;
>> +
>> +                       girq->parents[0] = bank->irq;
>> +                       girq->default_type = IRQ_TYPE_NONE;
>> +                       girq->handler = handle_level_irq;
>> +               }
> As menioned, replace this with an immutable irq_chip.

OK, I will fix it.

> Yours,
> Linus Walleij

Best Regards,
Jacky Huang


