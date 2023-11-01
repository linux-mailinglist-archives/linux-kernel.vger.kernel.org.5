Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E717DDDCC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 09:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjKAIkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 04:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbjKAIkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 04:40:14 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A18DF
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 01:40:08 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5a8ee23f043so64503577b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 01:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698828007; x=1699432807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3tVJb7zC/twbNf4ono3rkSWKHnaSolrnm8larmH8as=;
        b=QuHNHq2KSJEnPs39WLT5W1d28a9Rvfh9Iav1vLf9siIOa5aM5OgJpISJyxpI4zEjhE
         QCwwbURa+NKb/ziFI0MzrudnqrbeNF2ntSp1AkE+s4WbVuPG+qFJiMm3CE/2hFAqefXP
         cCnadUF9l/1mf9y3BVWBWPnalM8i3bdkVQID8KQojZ91kZgwCCJGRMX8srZ/wsNp7mSq
         0pleue1Evf29dq02VM7Qs9BWsgZRIuBJBZIAlqLcPbyzl22b1kUMgQRDTpnYNbIvzTsK
         KeEAOYYcDgdGDEjqfd9EGhCGjSFKCiskx2SsdUYy2duulH996bhw2K5D3W6WGxxtSLOY
         T0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698828007; x=1699432807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K3tVJb7zC/twbNf4ono3rkSWKHnaSolrnm8larmH8as=;
        b=FthWLClTspwxo7mtPgz2u8qNjiNmZvG/1yvjS2ZeMzsgRYwQf4rLc40cjaIEIubCpL
         Hgt8UfhIR+2Y29x6CkSZBIdCBkBbTz9NXqkq2b3hCz+ijTuxljWerHfVtY0YV7323x7N
         ERTLSQswnCT1wLmY1juwkh1nfAzHBSKul3LfY8lrEUNZ5VQGgy0ECAX6U8X7/3PPTSaM
         7Ti1zTNy+ww9h6PsVBT1YQIl/OUsyrrjDZlah+1htHtFmE9Olz/VX1k6ftenAduSBggL
         nGBYnUKZazDSBVvDHFPmDCRNHWJlfnsIyBhrw50n6umTkW0ru4CJNMH8vVTJtClCe/pT
         MwzQ==
X-Gm-Message-State: AOJu0YyiAPiInEDWLImxZLABhGNoBN3j19Cuzt62ALCcwFa3ZBrasNTa
        1KUjPJMsvxmH/HKL7P23MLZMb7lNlTfT5q+JUQ6DBDJJj1lo2xbOZnw=
X-Google-Smtp-Source: AGHT+IEh+4mXeLjP8A3zy+m99SXAUs37Oam9JI9gibkP9ZN0P91cbT1pp9wU3fc/6HScoQH6ItpqLzqg4JKjDXDVeGs=
X-Received: by 2002:a05:690c:714:b0:5a8:d86f:bb3f with SMTP id
 bs20-20020a05690c071400b005a8d86fbb3fmr16456146ywb.8.1698828007637; Wed, 01
 Nov 2023 01:40:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231101025802.3744-1-tychang@realtek.com> <20231101025802.3744-2-tychang@realtek.com>
In-Reply-To: <20231101025802.3744-2-tychang@realtek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 1 Nov 2023 09:39:55 +0100
Message-ID: <CACRpkdZiKCiVsmkPnJRW1c5SBfzNmBqCH9bS8XsgUszD6H=vPg@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: realtek: Add GPIO support for RTD SoC variants
To:     Tzuyi Chang <tychang@realtek.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tzuyi!

thanks for your patch!

On Wed, Nov 1, 2023 at 3:58=E2=80=AFAM Tzuyi Chang <tychang@realtek.com> wr=
ote:

> This commit adds GPIO support for Realtek DHC RTD SoCs.

What does "DHC" mean? Please spell it out in the commit and Kconfig
so we know what it is.

> This driver enables configuration of GPIO direction, GPIO values, GPIO
> debounce settings and handles GPIO interrupts.
>
> Signed-off-by: Tzuyi Chang <tychang@realtek.com>
(...)
> +config GPIO_RTD
> +       tristate "Realtek DHC GPIO support"
> +       depends on ARCH_REALTEK
> +       default y
> +       select GPIOLIB_IRQCHIP
> +       help
> +         Say yes here to support GPIO on Realtek DHC SoCs.

Explain what DHC is i.e. the acronym expansion, family, use case or somethi=
ng.

> +#include <linux/bitops.h>
> +#include <linux/gpio.h>

Do not include this legacy header.
Include <linux/gpio/driver.h>

> +#include <linux/interrupt.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_gpio.h>
> +#include <linux/of_irq.h>

I don't think you need any of thexe of_* includes.
Try it without them.

> +#include <linux/pinctrl/consumer.h>

Why?

> +/**
> + * struct rtd_gpio_info - Specific GPIO register information
> + * @name: GPIO device name
> + * @type: RTD GPIO ID
> + * @gpio_base: GPIO base number
> + * @num_gpios: Number of GPIOs
> + * @dir_offset: Offset for GPIO direction registers
> + * @dato_offset: Offset for GPIO data output registers
> + * @dati_offset: Offset for GPIO data input registers
> + * @ie_offset: Offset for GPIO interrupt enable registers
> + * @dp_offset: Offset for GPIO detection polarity registers
> + * @gpa_offset: Offset for GPIO assert interrupt status registers
> + * @gpda_offset: Offset for GPIO deassert interrupt status registers
> + * @deb_offset: Offset for GPIO debounce registers
> + */
> +struct rtd_gpio_info {
> +       const char *name;
> +       enum rtd_gpio_type type;
> +       unsigned int gpio_base;
> +       unsigned int num_gpios;
> +       unsigned int *dir_offset;
> +       unsigned int *dato_offset;
> +       unsigned int *dati_offset;
> +       unsigned int *ie_offset;
> +       unsigned int *dp_offset;
> +       unsigned int *gpa_offset;
> +       unsigned int *gpda_offset;
> +       unsigned int *deb_offset;

Use u8 instead of unsigned int for the offsets. It is clear from
the arrays you assign them that they are all u8[].

> +struct rtd_gpio {
> +       struct platform_device *pdev;
> +       const struct rtd_gpio_info *info;
> +       void __iomem *base;
> +       void __iomem *irq_base;
> +       struct gpio_chip gpio_chip;
> +       struct irq_chip irq_chip;

Do not use a dynamic irq_chip, create an immutable irq_chip
using a const struct.

See recent commits and virtually all current drivers in the tree
for examples on how to do that.

> +       int assert_irq;
> +       int deassert_irq;

I don't quite understand these two, but let's see in the rest
of the driver.

> +       .deb_offset =3D (unsigned int []){ 0x30, 0x34, 0x38, 0x3c, 0x40, =
0x44, 0x48, 0x4c },
(...)
> +       .deb_offset =3D (unsigned int []){ 0x50 },

So clearly u8[]

> +static unsigned int rtd_gpio_deb_offset(struct rtd_gpio *data, unsigned =
int offset)
> +{
> +       return data->info->deb_offset[offset / 8];
> +}

So this is clearly counted by the GPIO number offset and the GPIO number
determines how far into the array we can index.

It looks a bit dangerous, it it possible to encode the array lengths better=
?

> +       if (data->info->type =3D=3D RTD1295_ISO_GPIO) {
> +               shift =3D 0;
> +               deb_val +=3D 1;
> +               write_en =3D BIT(shift + 3);
> +               reg_offset =3D rtd1295_gpio_deb_offset(data, offset);
> +       } else if (data->info->type =3D=3D RTD1295_MISC_GPIO) {
> +               shift =3D (offset >> 4) * 4;
> +               deb_val +=3D 1;
> +               write_en =3D BIT(shift + 3);
> +               reg_offset =3D rtd1295_gpio_deb_offset(data, offset);
> +       } else {
> +               shift =3D (offset % 8) * 4;
> +               write_en =3D BIT(shift + 3);
> +               reg_offset =3D rtd_gpio_deb_offset(data, offset);
> +       }

These three different offset functions seem a bit awkward.
Can we do this by just another index instead?

> +static int rtd_gpio_request(struct gpio_chip *chip, unsigned int offset)
> +{
> +       return pinctrl_gpio_request(chip->base + offset);
> +}
> +
> +static void rtd_gpio_free(struct gpio_chip *chip, unsigned int offset)
> +{
> +       pinctrl_gpio_free(chip->base + offset);
> +}

IIRC Bartosz has changed this for kernel v6.7, please check his upstream
commits and adjust the code accordingly.

> +static int rtd_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
> +{
> +       struct rtd_gpio *data =3D gpiochip_get_data(chip);
> +       u32 irq =3D 0;
> +
> +       irq =3D irq_find_mapping(data->domain, offset);
> +       if (!irq) {
> +               dev_err(&data->pdev->dev, "%s: can not find irq number fo=
r hwirq=3D %d\n",
> +                       __func__, offset);
> +               return -EINVAL;
> +       }
> +       return irq;
> +}

Don't implement your own gpio_to_irq, just use the GPIOLIB_IRQCHIP
helpers. See other drivers that select GPIOLIB_IRQCHIP, this
driver is nothing special.

> +       chained_irq_enter(chip, desc);
> +
> +       for (i =3D 0; i < data->info->num_gpios; i =3D i + 31) {
> +               gpa_reg_offset =3D rtd_gpio_gpa_offset(data, i);
> +               status =3D readl_relaxed(data->irq_base + gpa_reg_offset)=
 >> 1;
> +               writel_relaxed(status << 1, data->irq_base + gpa_reg_offs=
et);
> +
> +               while (status) {
> +                       j =3D __ffs(status);
> +                       status &=3D ~BIT(j);
> +                       hwirq =3D i + j;
> +                       if (rtd_gpio_check_ie(data, hwirq)) {
> +                               int irq =3D irq_find_mapping(data->domain=
, hwirq);
> +
> +                               generic_handle_irq(irq);
> +                       }

So you skip the interrupt handler if the interrupt is not enabled?

I think you should report spurious interrupts if they occur without
being enabled, unless there is some hardware flunky making these
lines flicker with noise interrupts too much.

> +static void rtd_gpio_deassert_irq_handle(struct irq_desc *desc)
> +{
> +       struct rtd_gpio *data =3D irq_desc_get_handler_data(desc);
> +       struct irq_chip *chip =3D irq_desc_get_chip(desc);
> +       unsigned int gpda_reg_offset;
> +       u32 status;
> +       int hwirq;
> +       int i;
> +       int j;
> +
> +       chained_irq_enter(chip, desc);
> +
> +       for (i =3D 0; i < data->info->num_gpios; i =3D i + 31) {
> +               gpda_reg_offset =3D rtd_gpio_gpda_offset(data, i);
> +               status =3D readl_relaxed(data->irq_base + gpda_reg_offset=
) >> 1;
> +               writel_relaxed(status << 1, data->irq_base + gpda_reg_off=
set);
> +
> +               while (status) {
> +                       j =3D __ffs(status);
> +                       status &=3D ~BIT(j);
> +                       hwirq =3D i + j;
> +                       if (rtd_gpio_check_ie(data, hwirq)) {
> +                               int irq =3D irq_find_mapping(data->domain=
, hwirq);
> +                               u32 irq_type =3D irq_get_trigger_type(irq=
);
> +
> +                               if ((irq_type & IRQ_TYPE_SENSE_MASK) =3D=
=3D IRQ_TYPE_EDGE_BOTH)
> +                                       generic_handle_irq(irq);
> +                       }
> +               }
> +       }
> +
> +       chained_irq_exit(chip, desc);
> +}

There is some code duplication here. Create wrapper calls with parameters
so you don't need to have several functions that look almost the same.

> +static int rtd_gpio_probe(struct platform_device *pdev)
> +{
> +       struct rtd_gpio *data;
> +       const struct of_device_id *match;
> +       struct device_node *node;

Don't go looking by the OF node, use the device:

struct device *dev =3D &pdev->dev;

> +       int ret;
> +       int i;
> +
> +       node =3D pdev->dev.of_node;

Use #include <linux/property.h>

> +       match =3D of_match_node(rtd_gpio_of_matches, pdev->dev.of_node);
> +       if (!match || !match->data)
> +               return -EINVAL;

Use
data->info =3D device_get_match_data(dev); instead
if (!data->info)...

> +
> +       data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);

With a local dev you can just devm_kzalloc(dev, ...) etc.

> +       data->assert_irq =3D irq_of_parse_and_map(node, 0);
> +       if (!data->assert_irq)
> +               goto deferred;
> +
> +       data->deassert_irq =3D irq_of_parse_and_map(node, 1);
> +       if (!data->deassert_irq)
> +               goto deferred;

So one handler for rising and one handler for falling edge?
Hm that's different. I guess you need separate handlers.

> +       data->base =3D of_iomap(node, 0);
> +       if (!data->base)
> +               return -ENXIO;

Use
data->base =3D devm_platform_ioremap_resource(pdev, 0);

> +       data->irq_base =3D of_iomap(node, 1);
> +       if (!data->irq_base)
> +               return -ENXIO;

Use
data->irq_base =3D platform_get_irq(pdev, 1);

> +       data->gpio_chip.parent =3D &pdev->dev;

Don't assign this, the core will handle it.

> +       data->gpio_chip.label =3D dev_name(&pdev->dev);
> +       data->gpio_chip.of_gpio_n_cells =3D 2;

This is the default, let the core handle OF translation.

> +       data->gpio_chip.base =3D data->info->gpio_base;
> +       data->gpio_chip.ngpio =3D data->info->num_gpios;
> +       data->gpio_chip.request =3D rtd_gpio_request;
> +       data->gpio_chip.free =3D rtd_gpio_free;
> +       data->gpio_chip.get_direction =3D rtd_gpio_get_direction;
> +       data->gpio_chip.direction_input =3D rtd_gpio_direction_input;
> +       data->gpio_chip.direction_output =3D rtd_gpio_direction_output;
> +       data->gpio_chip.set =3D rtd_gpio_set;
> +       data->gpio_chip.get =3D rtd_gpio_get;
> +       data->gpio_chip.set_config =3D rtd_gpio_set_config;
> +       data->gpio_chip.to_irq =3D rtd_gpio_to_irq;

Use the GPIOLIB_IRQCHIP to provide this for you.

> +       data->irq_chip =3D rtd_gpio_irq_chip;

Convert to use immutable irq_chip. (Maybe several struct irq_chip if you ne=
ed!)

> +       data->domain =3D irq_domain_add_linear(node, data->gpio_chip.ngpi=
o,
> +                               &irq_domain_simple_ops, data);
> +       if (!data->domain) {
> +               devm_kfree(&pdev->dev, data);
> +               return -ENOMEM;
> +       }
> +
> +       for (i =3D 0; i < data->gpio_chip.ngpio; i++) {
> +               int irq =3D irq_create_mapping(data->domain, i);
> +
> +               irq_set_chip_data(irq, data);
> +               irq_set_chip_and_handler(irq, &data->irq_chip, handle_sim=
ple_irq);
> +       }
> +
> +       irq_set_chained_handler_and_data(data->assert_irq, rtd_gpio_asser=
t_irq_handle, data);
> +       irq_set_chained_handler_and_data(data->deassert_irq, rtd_gpio_dea=
ssert_irq_handle, data);

Instead of doing this use GPIOLIB_IRQCHIP.

Before registering the gpio_chip set up stuff somewhat like this:

        girq =3D &data->gpio_chip.irq;
        gpio_irq_chip_set_chip(girq, &my_irq_chip);
        girq->parent_handler =3D my_gpio_irq_handler;
        girq->num_parents =3D 1;
        girq->parents =3D devm_kcalloc(dev, 1, sizeof(*girq->parents),
                                     GFP_KERNEL);
        if (!girq->parents)
                ret =3D -ENOMEM;
        girq->default_type =3D IRQ_TYPE_NONE;
        girq->handler =3D handle_bad_irq;
        girq->parents[0] =3D irq;

But maybe in this case you want two parent IRQs? Not sure.

> +deferred:
> +       devm_kfree(&pdev->dev, data);
> +       return -EPROBE_DEFER;

Nope, when you return with an error from probe() all
allocations using devm_* are automatically free:ed that
is kind of the point of the managed resources.

Yours,
Linus Walleij
