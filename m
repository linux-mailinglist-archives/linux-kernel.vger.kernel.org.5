Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F137B7830
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 08:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241451AbjJDGxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 02:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241452AbjJDGxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 02:53:34 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6000EB8
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 23:53:30 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-690d935dbc2so357692b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 23:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696402410; x=1697007210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BdHALDEIm6YTzBTHRWo5rZd19YX8oTNV9TpA08WwtXA=;
        b=Mi1t9Jn86rTjM9E9nyzM3gGvSMEZe0nuBYR4EKwzfuBcD8OYahn9VTeTydMdLfT/kS
         P72pmA3xj1WXnH23y9Or6itC4pbRytU+PU7iF5JQzZYayZE6Ahd0fHGtxVWvAfnzLInj
         8V0sz/NIBBXJgtuBVqjhyhvmbbE0YG573dwF8GSv2a9u6jHews3AcmuJIe5Ea2Q8tv90
         CttuFb7vM1BteQvTDRsg0sZ1Md0zmQuL2h30QL/SnrRvKXvK0lCyUuCmg6wXCnichN/a
         dKZ+cz9pMN0wCS54Z71YdDUBmKuMs2DG60Wtg19rvplnflNFozTGnoEYxCHAdWEkLGGu
         T6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696402410; x=1697007210;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BdHALDEIm6YTzBTHRWo5rZd19YX8oTNV9TpA08WwtXA=;
        b=I+LiHEGPz2bYERDVsnieEbcib3nuveLSpzztDDmx7RuMezEp7H1xEvDAW8S1WvuW8i
         GRict3mbQZzlles/ZNCkCtXZYJq7LAIZcO7Vb7OVPKOp+OL3Uaz2dWt05Sfyr73flSYK
         STo0ao1/kYQtANKIxmry06M+LHKoU8iDTBHBFC8v6DTDrya6UwHk4LvqMt8SlqwwUrQY
         tc/KUYzye96Fo4oNvORO3ES2I3s7qk4O60ea5cg4pwlAM/De32ApuVDD16sYNxcfQFLB
         Amb+HTIQ+3L7l/ngtUVStuULOKawgPhr9y0ogUc7tLN269aC071WX9FN5HpuKnwJTOzH
         X+pw==
X-Gm-Message-State: AOJu0YyEqrbussDYzl61eTWzJHvRkMzjQcMVZ1U0YcmnUbBe9AX52GU4
        Px7T6qa0UXqI3SXM5il0Nw6MQA==
X-Google-Smtp-Source: AGHT+IH5FAA8iLf55tG6KbeGPHDT9iWNYYa52t3bq2WmlsNHvOd9gXrMGyIJzGd6AULRtcHxkhtYVA==
X-Received: by 2002:a17:902:f54e:b0:1bb:d7d4:e2b with SMTP id h14-20020a170902f54e00b001bbd7d40e2bmr1793187plf.0.1696402409612;
        Tue, 03 Oct 2023 23:53:29 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:81c4:ac5:bfc9:67a3])
        by smtp.gmail.com with ESMTPSA id jh21-20020a170903329500b001bc930d4517sm2821717plb.42.2023.10.03.23.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 23:53:29 -0700 (PDT)
Date:   Wed, 4 Oct 2023 15:53:24 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Oleksii_Moisieiev@epam.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [RFC 3/4] gpio: scmi: add SCMI pinctrl based gpio driver
Message-ID: <ZR0L5Oe9oT/sEF2p@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>, sudeep.holla@arm.com,
        cristian.marussi@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Oleksii_Moisieiev@epam.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <20231002021602.260100-1-takahiro.akashi@linaro.org>
 <20231002021602.260100-4-takahiro.akashi@linaro.org>
 <CACRpkdZojfC2qr7gfzL9fj=DEYJcuPR=a1+zVWTMysK9BH_m_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZojfC2qr7gfzL9fj=DEYJcuPR=a1+zVWTMysK9BH_m_Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Tue, Oct 03, 2023 at 11:35:31PM +0200, Linus Walleij wrote:
> On Mon, Oct 2, 2023 at 4:17???AM AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> 
> > SCMI pin control protocol supports not only pin controllers, but also
> > gpio controllers by design. This patch includes a generic gpio driver
> > which allows consumer drivers to access gpio pins that are handled
> > through SCMI interfaces.
> >
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> 
> I would write a bit that this is intended for SCMI but it actually
> is a GPIO front-end to any pin controller that supports the
> necessary pin config operations.

I'm still not sure whether my approach can be applied to any other
pinctrl-based gpio drivers, in which extra (driver-specific) operations
might be needed around the generic pinctrl_gpio helpers (i.e. gpiolib.c).
For instance, look at gpio-tegra.c:

! static int tegra_gpio_direction_input(struct gpio_chip *chip,
!                                       unsigned int offset)
! {
!         struct tegra_gpio_info *tgi = gpiochip_get_data(chip);
! 
!         tegra_gpio_mask_write(tgi, GPIO_MSK_OE(tgi, offset), offset, 0);
!         tegra_gpio_enable(tgi, offset);
! 
!         ret = pinctrl_gpio_direction_input(chip->base + offset);
!	  ...
! }

That said, I will send a next version incorporating the changes you
suggest here.

> >  drivers/gpio/gpio-scmi.c | 154 +++++++++++++++++++++++++++++++++++++++
> 
> So I would name it gpio-by-pinctrl.c
> (clear and hard to misunderstand)
> 
> > +config GPIO_SCMI
> 
> GPIO_BY_PINCTRL

Okay.


> > +       tristate "GPIO support based on SCMI pinctrl"
> 
> "GPIO support based on a pure pin control back-end"

Okay.

> > +       depends on OF_GPIO
> 
> Skip this, let's use device properties instead. They will anyways just translate
> to OF properties in the OF case.

Okay, I don't know how device properties work, though.

> > +       depends on PINCTRL_SCMI
> > +       help
> > +         Select this option to support GPIO devices based on SCMI pin
> > +         control protocol.
> 
> "GPIO devices based solely on pin control, specifically pin configuration, such
> as SCMI."

Okay.

> > +#include <linux/of.h>
> 
> Use #include <linux/property.h> so we remove reliance on OF.

Actually we need neither to compile the code.

> > +#include "gpiolib.h"
> 
> Why?

Because we need to access members of struct gpio_device.

> 
> > +static int scmi_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
> 
> Rename all functions pinctrl_gpio_*

Well, this change will result in name conflicts against existing
pinctrl_gpio_direction_[in|out]out(). So use "pin_control_gpio_" prefix.

> > +{
> > +       unsigned long config;
> > +
> > +       config = PIN_CONFIG_OUTPUT_ENABLE;
> > +       if (pinctrl_gpio_get_config(chip->gpiodev->base + offset, &config))
> > +               return -1;
> 
> Probably you want to return the error code from pinctrl_gpio_get_config()
> rather than -1? (same below).

Yes.

> > +       if (config)
> > +               return GPIO_LINE_DIRECTION_OUT;
> > +
> > +       config = PIN_CONFIG_INPUT_ENABLE;
> > +       if (pinctrl_gpio_get_config(chip->gpiodev->base + offset, &config))
> > +               return -1;
> > +       if (config)
> > +               return GPIO_LINE_DIRECTION_IN;
> 
> I would actually not return after checking PIN_CONFIG_OUTPUT_ENABLE.
> I would call *both* something like:
> 
> int ret;
> bool  out_en, in_en;
> 
> config = PIN_CONFIG_OUTPUT_ENABLE;
> ret = pinctrl_gpio_get_config(chip->gpiodev->base + offset, &config);
> if (ret)
>     return ret;
> /* Maybe check for "not implemented" error code here and let that pass
>  * setting out_en = false; not sure. Maybe we should mandate support
>  * for this.
>  */
> out_en = !!config;
> config = PIN_CONFIG_INPUT_ENABLE;
> ret = pinctrl_gpio_get_config(chip->gpiodev->base + offset, &config);
> if (ret)
>     return ret;
> in_en = !!config;
> 
> /* Consistency check - in theory both can be enabled! */
> if (in_en && !out_en)
>     return GPIO_LINE_DIRECTION_IN;
> if (!in_en && out_en)
>     return GPIO_LINE_DIRECTION_OUT;
> if (in_en && out_en) {
>     /*
>      * This is e.g. open drain emulation!
>      * In this case check @PIN_CONFIG_DRIVE_OPEN_DRAIN
>      * if this is enabled, return GPIO_LINE_DIRECTION_OUT,
>      * else return an error. (I think.)
>      */
> }

Not sure how the last case (in_en && out_en && DRIVE_OPEN_DRAIN) works.

In order to be able to read a value as an input pin, I think, we need
to set the output status to Hi-Z. Then we should recognize it as "INPUT"?
In this case, however, we cannot distinguish the other case where we want
to use the pin as OUTPUT and drive it to (active) high.

> /* We get here for (!in_en && !out_en) */
> return -EINVAL;
> 
> > +static int scmi_gpio_get(struct gpio_chip *chip, unsigned int offset)
> > +{
> > +       unsigned long config;
> > +
> > +       /* FIXME: currently, PIN_CONFIG_INPUT not defined */
> > +       config = PIN_CONFIG_INPUT;
> > +       if (pinctrl_gpio_get_config(chip->gpiodev->base + offset, &config))
> > +               return -1;
> > +
> > +       /* FIXME: the packed format not defined */
> > +       if (config >> 8)
> > +               return 1;
> > +
> > +       return 0;
> > +}
> 
> Proper error code instead of -1 otherwise looks good!

Yes.

> > +static void scmi_gpio_set(struct gpio_chip *chip, unsigned int offset, int val)
> 
> static int?

Unfortunately, the function prototype of "set" in struct gpio_device is
        void (*set)(struct gpio_chip *gc, unsigned int offset, int value);

So we cannot propagate an error to the caller.

> > +{
> > +       unsigned long config;
> > +
> > +       config = PIN_CONF_PACKED(PIN_CONFIG_OUTPUT, val & 0x1);
> 
> No need to add & 0x01, the gpiolib core already does this.

Which part of gpiolib core?
The argument is shifted by 8 in PIN_CONF_PACKED(), but never normalized.
Since the driver code, however, should verify the value in some way, I will
drop the masking here.


> > +       pinctrl_gpio_set_config(chip->gpiodev->base + offset, config);
> 
> return pinctrl_gpio_set_config(); so error is propagated.

See above.

> > +static u16 sum_up_ngpios(struct gpio_chip *chip)
> > +{
> > +       struct gpio_pin_range *range;
> > +       struct gpio_device *gdev = chip->gpiodev;
> > +       u16 ngpios = 0;
> > +
> > +       list_for_each_entry(range, &gdev->pin_ranges, node) {
> > +               ngpios += range->range.npins;
> > +       }
> 
> This works but isn't really the intended use case of the ranges.
> Feel a bit uncertain about it, but I can't think of anything better.
> And I guess these come directly out of SCMI so it's first hand
> information about all GPIOs.

I don't get your point.
However many pins SCMI firmware (or other normal pin controllers) might
expose, the total number of pins available by this driver is limited by
"gpio-ranges" property.
So the sum as "ngpios" should make sense unless a user accidentally
specifies a wrong range of pins.

Do I misunderstand anything?

> > +static int scmi_gpio_probe(struct platform_device *pdev)
> > +{
> > +       struct device *dev = &pdev->dev;
> > +       struct device_node *parent_np;
> 
> Skip (not used)

Okay. This code is a remnant from the original driver that I referred to
as a base.

> > +       /* FIXME: who should be the parent */
> > +       parent_np = NULL;
> 
> Skip (not used)
> 
> > +       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +       if (!priv)
> > +               return -ENOMEM;
> > +
> > +       chip = &priv->chip;
> > +       chip->label = dev_name(dev);
> > +       chip->parent = dev;
> 
> This is the actual parent, which is good enough?
> 
> > +       chip->base = -1;
> > +
> > +       chip->request = gpiochip_generic_request;
> > +       chip->free = gpiochip_generic_free;
> > +       chip->get_direction = scmi_gpio_get_direction;
> > +       chip->direction_input = scmi_gpio_direction_input;
> > +       chip->direction_output = scmi_gpio_direction_output;
> 
> Add:
> chip->set_config = gpiochip_generic_config;

Yes.

> which in turn becomes just pinctrl_gpio_set_config(), which
> is what we want.
> 
> The second cell in two-cell GPIOs already supports passing
> GPIO_PUSH_PULL, GPIO_OPEN_DRAIN, GPIO_OPEN_SOURCE,
> GPIO_PULL_UP, GPIO_PULL_DOWN, GPIO_PULL_DISABLE,
> which you can this way trivially pass down to the pin control driver.
> 
> NB: make sure the scmi pin control driver returns error for
> unknown configs.

Well, the error will be determined by SCMI firmware(server)
not the driver itself :)

> > +static int scmi_gpio_remove(struct platform_device *pdev)
> > +{
> > +       struct scmi_gpio_priv *priv = platform_get_drvdata(pdev);
> > +
> > +       gpiochip_remove(&priv->chip);
> 
> You are using devm_* to add it so this is not needed!
> 
> Just drop the remove function.

Okay.

> > +static const struct of_device_id scmi_gpio_match[] = {
> > +       { .compatible = "arm,scmi-gpio-generic" },
> 
> "pin-control-gpio" is my suggestion for this!
> 
> I hope this helps.

Thank you for your kind suggestions.

-Takahiro Akashi


> Yours,
> Linus Walleij
