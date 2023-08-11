Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238A577859F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 04:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbjHKCsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 22:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjHKCsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 22:48:39 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7264D2D5F;
        Thu, 10 Aug 2023 19:48:38 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id 4fb4d7f45d1cf-5230f92b303so418255a12.0;
        Thu, 10 Aug 2023 19:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691722117; x=1692326917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=diy+0nBkkt1CrCLNSV+e2V8fOSZANPi3q9y60cepOno=;
        b=LA4NkRmwFxZLPlZYBHFY7V86nmJvhBiC01s99nypy/fG8Kt0vj8YO4jw9NTLC8DhtF
         0QEhIOir3rjy5iZOowmBDZ2YZrqVDCKPTO+DSvnihf92TAGiAiDuHKRUIwWq73ELZ2Qs
         OGVMww/Kc4tTw0R5Nxa7V/k+DojmUSd3kN6beAN7mdGN74JJ72Hev2mqS6mv/qIPlGl5
         vpkkIhuqTUuSaTi/WVnb5Qi/szIcFQOtfUwXVKxLHocNinQdxStu0nYnYMeAkc3Dykec
         5n4/wZXhblwivikeUJ2gBoq4PmmEvBpwOAUF9qmktAUCVR4T0NZ0rbA1DX0riQFteCme
         IliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691722117; x=1692326917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=diy+0nBkkt1CrCLNSV+e2V8fOSZANPi3q9y60cepOno=;
        b=UvoU/Ld0DQdkd7mcmIULfbqPGop42tAjmDldH3T0KIcruo7OCwRz14FJLQ7l8kFnl6
         BqErpcxfvE+BzIGSz5mAJPJTPwXt5h1GwuKXa/LRQtnS+3yPDTna8/G067y7h6CGT/jU
         ypwQiibBu0JbkpywApVUkt1oJWlEkSYjuMsbpHVKjr7CbOUbv0htLgpULhGeNRPdmWJ6
         ERct3E9Lny9OZPqbggTh4qmXYiWl9eyMlDcUxwyRPyH3bHEXzKdFA0BpHGrxfLPyXPns
         +lH6jm8I/kvi7hYt3H6m+XTh7lH456dGK1TCuPYqdFA4Jig7Va/90mT05Mjg8CYt3Hdq
         4pTQ==
X-Gm-Message-State: AOJu0Yw/Cd1a+ILBWaJVsEJwZfqJIjAVGRugOOAJR45Hmo3MMaI4XCym
        INKyYK/zoArxbmUoZ2DojJBWdvOJcZeUizxBtkM=
X-Google-Smtp-Source: AGHT+IE/36oXvDrkcmGP8mpraaxTwk+Rt7D4gXb4+H6HVms0t+Lkw9oeAenXljXY2dItsGzQP2IWU1Lh6//GtY5fs10=
X-Received: by 2002:a05:6402:4314:b0:51d:cfeb:fc3b with SMTP id
 m20-20020a056402431400b0051dcfebfc3bmr650669edc.1.1691722116645; Thu, 10 Aug
 2023 19:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230808072501.3393-1-Wenhua.Lin@unisoc.com> <20230808100721.00006775@Huawei.com>
In-Reply-To: <20230808100721.00006775@Huawei.com>
From:   wenhua lin <wenhua.lin1994@gmail.com>
Date:   Fri, 11 Aug 2023 10:48:24 +0800
Message-ID: <CAB9BWhe+1Re85MNG92V6mGruPFT0-2=k9etvMprEswFOt-c8gQ@mail.gmail.com>
Subject: Re: [PATCH] input: keyboard: Add sprd-keypad driver
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Samuel Holland <samuel@sholland.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 5:07=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 8 Aug 2023 15:25:01 +0800
> Wenhua Lin <Wenhua.Lin@unisoc.com> wrote:
>
> > Add matrix keypad driver, support matrix keypad function.
> >
>
> No idea why you cc'd me on this one, but I wanted some light reading whil=
st
> having a coffee so here's a quick review :)
>
> Hohum. Took me a bit long than planned. Ah well, I hope you find the
> feedback useful.

We may have made a mistake, your feedback is greatly appreciated,
these suggestions help us a lot.

>
> > Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> > ---
> >  drivers/input/keyboard/Kconfig       |  10 +
> >  drivers/input/keyboard/Makefile      |   1 +
> >  drivers/input/keyboard/sprd_keypad.c | 418 +++++++++++++++++++++++++++
> >  3 files changed, 429 insertions(+)
> >  create mode 100644 drivers/input/keyboard/sprd_keypad.c
> >
> > diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kc=
onfig
> > index 1d0c5f4c0f99..f35d9bf05f72 100644
> > --- a/drivers/input/keyboard/Kconfig
> > +++ b/drivers/input/keyboard/Kconfig
> > @@ -809,4 +809,14 @@ config KEYBOARD_CYPRESS_SF
> >         To compile this driver as a module, choose M here: the
> >         module will be called cypress-sf.
> >
> > +config KEYBOARD_SPRD
> > +     tristate "Spreadtrum keyboard support"
> > +     depends on ARCH_SPRD || COMPILE_TEST
> > +     select INPUT_MATRIXKMAP
> > +     help
> > +       Keypad controller is used to interface a SoC with a matrix-keyp=
ad device,
> > +       The keypad controller supports multiple row and column lines.
> > +       Say Y if you want to use the SPRD keyboard.
> > +       Say M if you want to use the SPRD keyboard on SoC as module.
> > +
> >  endif
> > diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/M=
akefile
> > index aecef00c5d09..b747112461b1 100644
> > --- a/drivers/input/keyboard/Makefile
> > +++ b/drivers/input/keyboard/Makefile
> > @@ -66,6 +66,7 @@ obj-$(CONFIG_KEYBOARD_STOWAWAY)             +=3D stow=
away.o
> >  obj-$(CONFIG_KEYBOARD_ST_KEYSCAN)    +=3D st-keyscan.o
> >  obj-$(CONFIG_KEYBOARD_SUN4I_LRADC)   +=3D sun4i-lradc-keys.o
> >  obj-$(CONFIG_KEYBOARD_SUNKBD)                +=3D sunkbd.o
> > +obj-$(CONFIG_KEYBOARD_SPRD)          +=3D sprd_keypad.o
> >  obj-$(CONFIG_KEYBOARD_TC3589X)               +=3D tc3589x-keypad.o
> >  obj-$(CONFIG_KEYBOARD_TEGRA)         +=3D tegra-kbc.o
> >  obj-$(CONFIG_KEYBOARD_TM2_TOUCHKEY)  +=3D tm2-touchkey.o
> > diff --git a/drivers/input/keyboard/sprd_keypad.c b/drivers/input/keybo=
ard/sprd_keypad.c
> > new file mode 100644
> > index 000000000000..5b88072831e8
> > --- /dev/null
> > +++ b/drivers/input/keyboard/sprd_keypad.c
> > @@ -0,0 +1,418 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2018 Spreadtrum Communications Inc.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/input/matrix_keypad.h>
> > +#include <linux/io.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/clk.h>
> > +#include <linux/of.h>
> > +#include <linux/input.h>
>
> Some sort of order of headers would be good.
> Alphabetical is a good choice, though maybe Dmitry prefers something else=
.

We will fix this issue in patch v2.

>
> > +
> > +#define SPRD_KPD_CTRL                        0x0
> > +#define SPRD_KPD_INT_EN                      0x4
> > +#define SPRD_KPD_INT_RAW_STATUS              0x8
> > +#define SPRD_KPD_INT_MASK_STATUS     0xc
> > +#define SPRD_KPD_INT_CLR             0x10
> > +#define SPRD_KPD_POLARITY            0x18
> > +#define SPRD_KPD_DEBOUNCE_CNT                0x1c
> > +#define SPRD_KPD_LONG_KEY_CNT                0x20
> > +#define SPRD_KPD_SLEEP_CNT           0x24
> > +#define SPRD_KPD_CLK_DIV_CNT         0x28
> > +#define SPRD_KPD_KEY_STATUS          0x2c
> > +#define SPRD_KPD_SLEEP_STATUS                0x30
> > +#define SPRD_KPD_DEBUG_STATUS1               0x34
> > +#define SPRD_KPD_DEBUG_STATUS2               0x38
> > +
> > +#define SPRD_KPD_EN                  BIT(0)
> > +#define SPRD_KPD_SLEEP_EN            BIT(1)
> > +#define SPRD_KPD_LONG_KEY_EN         BIT(2)
> > +
> > +#define SPRD_KPD_ROWS_MSK            GENMASK(23, 16)
> > +#define SPRD_KPD_COLS_MSK            GENMASK(15, 8)
> > +
> > +#define SPRD_KPD_INT_ALL             GENMASK(11, 0)
> > +#define SPRD_KPD_INT_DOWNUP          GENMASK(7, 0)
> > +#define SPRD_KPD_INT_LONG            GENMASK(11, 8)
> > +
> > +#define SPRD_KPD_ROW_POLARITY                GENMASK(7, 0)
> > +#define SPRD_KPD_COL_POLARITY                GENMASK(15, 8)
> > +
> > +#define SPRD_KPD_PRESS_INTX(X, V) \
> > +     (((V) >> (X)) & GENMASK(0, 0))
>
> Given how this is used as a boolean check, I think
> if (SPRD_KPD_PRESS_INTX(i, int_status))
> is same as
>
> if (int_status & BIT(i)) which id easier to read.

Thanks for your suggestion, I will seriously consider it.

>
> > +#define SPRD_KPD_RELEASE_INTX(X, V) \
> > +     (((V) >> ((X) + 4)) & GENMASK(0, 0))
> For this one I'd define a mask and use field get so the check
>
> if (SPRD_KPD_RELEASE_INTX(i, int_status)) {
>
> becomes
>
> #define SPRD_KPD_RELEASE_INTX_MSK GENMASK(7, 4)
>
> if (FIELD_GET(SPRD_KPD_RELEASE_INTX_MSK, int_status) & BIT(i));
>

Thanks for your suggestion, I will seriously consider it.

>
> > +#define SPRD_KPD_INTX_COL(X, V) \
> > +     (((V) >> ((X) << 3)) & GENMASK(2, 0))
> > +#define SPRD_KPD_INTX_ROW(X, V) \
> > +     (((V) >> (((X) << 3) + 4)) & GENMASK(2, 0))
>
> Ok, on this I'm struggling to work out what is actually happening.
>
> Looks to be picking out an 8 bit field then masking with 3 bits.
> X =3D 0..3
>
> So define the mask with a suitable name and provide a macro to extract
> only the 8 bit field.  I would suggest using multiply as simpler.
>
> Something along the lines of...
>
> #define SPRD_KBD_INTX_COL_MSK GENMASK(2, 0)
> #define SPRD_KBD_INTX_ROW_MSK GENMASK(6, 4)
> static u8 sprd_kbd_intx_extract_entry(u32 key_input, int x)
> {
>         return key_input >> (x * 8);
> }
> (key_input >> (X * 8)) & GENMASK(2, 0)

Thanks for your suggestion, but
I am concerned that the modification of the algorithm
will affect the understanding of register usage.

>
> So
> col =3D SPRD_KPD_INTX_COL(i, key_status);
> row =3D SPRD_KPD_INTX_ROW(i, key_status);
> becomes
>
> u8 entry =3D sprd_kbd_intx_extract_entry(key_input, i);
> col =3D FIELD_GET(SPRD_KBD_INTX_COL_MSK, entry)
> row =3D FIELD_GET(SPRD_KBD_INTX_ROW_MSK, entry);
>
> which is easier to follow than above macros.
> That of course assumes I correctly figured out what those macros
> were doing.
>
> This is a case where readability is better than short code.
>

Thanks for your suggestion, I will seriously consider it.

>
>
> > +#define SPRD_KPD_INTX_DOWN(X, V) \
> > +     (((V) >> (((X) << 3) + 7)) & GENMASK(0, 0))
> > +
>
>
> > +
> > +static u32 sprd_keypad_time_to_counter(u32 array_size, u32 time_ms)
> > +{
> > +     u32 value;
> > +
> > +     /*
> > +      * y(ms) =3D (x + 1) * array_size
> > +      *              / (32.768 / (clk_div_num + 1))
> > +      * y means time in ms
> > +      * x means counter
> > +      * array_size equal to rows * columns
> > +      * clk_div_num is devider to keypad source clock
>
> divider
> Also good to say the maths here is inverting the equation given.

We will fix this issue in patch v2.

>
> > +      **/
> > +     value =3D SPRD_KPD_RTC_HZ * time_ms;
> > +     value =3D value / (1000 * array_size *
> > +                     (SPRD_DEF_DIV_CNT + 1));
> > +     if (value >=3D 1)
> > +             value -=3D 1;
> Good to have a comment on why this last check.  Can it end up as
> less than one.

This code is implemented according to the calculation formula, and x
represents value.
y(ms) =3D (x + 1) * array_size / (32.768 / (clk_div_num + 1))

> > +
> > +     return value;
> > +}
> > +
> > +static int sprd_keypad_hw_init(struct sprd_keypad_data *data)
> > +{
> > +     u32 value;
> > +
> > +     writel_relaxed(SPRD_KPD_INT_ALL, data->base + SPRD_KPD_INT_CLR);
> > +     writel_relaxed(SPRD_KPD_ROW_POLARITY | SPRD_KPD_COL_POLARITY,
> > +                     data->base + SPRD_KPD_POLARITY);
> > +     writel_relaxed(SPRD_DEF_DIV_CNT, data->base + SPRD_KPD_CLK_DIV_CN=
T);
> > +
> > +     value =3D sprd_keypad_time_to_counter(data->num_rows * data->num_=
cols,
> > +                                             SPRD_DEF_LONG_KEY_MS);
> > +     writel_relaxed(value, data->base + SPRD_KPD_LONG_KEY_CNT);
> > +
> > +     value =3D sprd_keypad_time_to_counter(data->num_rows * data->num_=
cols,
> > +                                             data->debounce_ms);
> > +     writel_relaxed(value, data->base + SPRD_KPD_DEBOUNCE_CNT);
> > +
> > +     value =3D SPRD_KPD_INT_DOWNUP;
> > +     if (data->capabilities & SPRD_CAP_LONG_KEY)
> > +             value |=3D SPRD_KPD_INT_LONG;
> > +     writel_relaxed(value, data->base + SPRD_KPD_INT_EN);
> > +
> > +     value =3D SPRD_KPD_RTC_HZ - 1;
> > +     writel_relaxed(value, data->base + SPRD_KPD_SLEEP_CNT);
> > +
> > +     /* set enabled rows and columns */
> > +     value =3D (((data->rows_en << SPRD_KPD_ROWS_SHIFT)
> > +             | (data->cols_en << SPRD_KPD_COLS_SHIFT))
> > +             & (SPRD_KPD_ROWS_MSK | SPRD_KPD_COLS_MSK))
> > +             | SPRD_KPD_EN | SPRD_KPD_SLEEP_EN;
> > +     if (data->capabilities & SPRD_CAP_LONG_KEY)
> > +             value |=3D SPRD_KPD_LONG_KEY_EN;
> > +     writel_relaxed(value, data->base + SPRD_KPD_CTRL);
> > +
> > +     return 0;
> > +}
> > +
> > +static int __maybe_unused sprd_keypad_suspend(struct device *dev)
>
> What Arnd said on this.

He made no comment on this issue.

>
> > +{
> > +     struct sprd_keypad_data *data =3D dev_get_drvdata(dev);
> > +
> > +     if (!device_may_wakeup(dev))
> > +             sprd_keypad_disable(data);
> > +
> > +     return 0;
> > +}
> > +
> > +static int __maybe_unused sprd_keypad_resume(struct device *dev)
> > +{
> > +     struct sprd_keypad_data *data =3D dev_get_drvdata(dev);
> > +     int ret =3D 0;
> > +
> > +     if (!device_may_wakeup(dev)) {
> > +             ret =3D sprd_keypad_enable(data);
> > +             if (ret)
> > +                     return ret;
> > +             ret =3D sprd_keypad_hw_init(data);
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(sprd_keypad_pm_ops,
> > +                     sprd_keypad_suspend, sprd_keypad_resume);
> > +
> > +static int sprd_keypad_parse_dt(struct device *dev)
> > +{
> > +     struct sprd_keypad_data *data =3D dev_get_drvdata(dev);
> > +     struct device_node *np =3D dev->of_node;
> > +     int ret;
> > +
> > +     ret =3D matrix_keypad_parse_properties(dev, &data->num_rows, &dat=
a->num_cols);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (data->num_rows > SPRD_KPD_ROWS_MAX
> > +             || data->num_cols > SPRD_KPD_COLS_MAX) {
> > +             dev_err(dev, "invalid num_rows or num_cols\n");
>
> This is only called from probe, so dev_err_probe() is appropriate through=
out this
> function.

We will fix this issue in patch v2.

>
> > +             return -EINVAL;
> > +     }
> > +
> > +     ret =3D of_property_read_u32(np, "debounce-interval", &data->debo=
unce_ms);
>
> Whilst it's probably unlikely another firmware will be used with this,
> we have generic property accessors in linux/property.h that will work sho=
uld anyone
> ever do so and at no cost for this driver.

We will fix this issue in patch v2.

>
> > +     if (ret) {
> > +             data->debounce_ms =3D 5;
> > +             dev_warn(dev, "parse debounce-interval failed.\n");
> > +     }
> > +
> > +     if (of_get_property(np, "linux,repeat", NULL))
>
> device_property_read_bool() calls the check on the property being present
> so is both more general and more obvious than what you have here.

We will fix this issue in patch v2.

>
>
> > +             data->capabilities |=3D SPRD_CAP_REPEAT;
> > +     if (of_get_property(np, "sprd,support_long_key", NULL))
> > +             data->capabilities |=3D SPRD_CAP_LONG_KEY;
> > +     if (of_get_property(np, "wakeup-source", NULL))
> > +             data->capabilities |=3D SPRD_CAP_WAKEUP;
> > +
> > +     data->enable =3D devm_clk_get(dev, "enable");
>
> devm_clk_get_enabled() for both of these.

We will fix this issue in patch v2.

>
> > +     if (IS_ERR(data->enable)) {
> > +             if (PTR_ERR(data->enable) !=3D -EPROBE_DEFER)
> > +                     dev_err(dev, "get enable clk failed.\n");
> > +             return PTR_ERR(data->enable);
> > +     }
> > +
> > +     data->rtc =3D devm_clk_get(dev, "rtc");
> > +     if (IS_ERR(data->rtc)) {
> > +             if (PTR_ERR(data->enable) !=3D -EPROBE_DEFER)
> > +                     dev_err(dev, "get rtc clk failed.\n");
> > +             return PTR_ERR(data->rtc);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int sprd_keypad_probe(struct platform_device *pdev)
> > +{
> > +     struct sprd_keypad_data *data;
> > +     struct resource *res;
> > +     int ret, irq, i, j, row_shift;
> > +     unsigned long rows, cols;
> > +     unsigned short *keycodes;
> > +
> > +     data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> > +     if (!data)
> > +             return -ENOMEM;
> > +
> > +     res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     data->base =3D devm_ioremap_resource(&pdev->dev, res);
>
> devm_platform_get_and_ioremap_resource)
>
> > +     if (IS_ERR(data->base)) {
> > +             dev_err(&pdev->dev, "ioremap resource failed.\n");
> > +             ret =3D  PTR_ERR(data->base);
> > +             goto err_free;
>
> Read up on what devm calls do - there is no need to manually free
> things that were allocated with them in the error paths or remove.
> So this should be a direct return. Also use
>                 return dev_err_probe(&pdev->dev, PTR_ERR(data->base),
>                                      "....")
>
> It both creates neater code and for cases where deferred probing
> is possible you will get a nice message on 'why' registered for
> debug purposes.

We will fix this issue in patch v2.

>
>
> > +     }
> > +
> > +     platform_set_drvdata(pdev, data);
> > +     ret =3D sprd_keypad_parse_dt(&pdev->dev);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "keypad parse dts failed.\n");
> > +             goto err_free;
>
> Direct return and dev_err_probe()

We will fix this issue in patch v2.

>
> > +     }
> > +
> > +     data->input_dev =3D devm_input_allocate_device(&pdev->dev);
> > +     if (IS_ERR(data->input_dev)) {
> > +             dev_err(&pdev->dev, "alloc input dev failed.\n");
> > +             ret =3D  PTR_ERR(data->input_dev);
> > +             goto err_free;
>
> Direct return, dev_err_probe() and what happened with the spacing?

We will fix this issue in patch v2.

>
> > +     }
> > +
> > +     data->input_dev->name =3D "sprd-keypad";
> > +     data->input_dev->phys =3D "sprd-key/input0";
> > +
> > +     ret =3D matrix_keypad_build_keymap(NULL, NULL, data->num_rows,
> > +                                      data->num_cols, NULL, data->inpu=
t_dev);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "keypad build keymap failed.\n");
> > +             goto err_free;
>
> As above.

We will fix this issue in patch v2.

>
> > +     }
> > +
> > +     rows =3D cols =3D 0;
> > +     row_shift =3D get_count_order(data->num_cols);
> > +     keycodes =3D data->input_dev->keycode;
> > +     for (i =3D 0; i < data->num_rows; i++) {
> > +             for (j =3D 0; j < data->num_cols; j++) {
> > +                     if (!!keycodes[MATRIX_SCAN_CODE(i, j, row_shift)]=
) {
>
> The !! is pointless if using it as a boolean.  No need to first convert i=
t
> to 0/1   0 is false anything else is true.
>
> > +                             set_bit(i, &rows);
> > +                             set_bit(j, &cols);
> > +                     }
> > +             }
> > +     }
> > +     data->rows_en =3D rows;
> > +     data->cols_en =3D cols;
> > +
> > +     if (data->capabilities & SPRD_CAP_REPEAT)
> > +             set_bit(EV_REP, data->input_dev->evbit);
> > +
> > +     input_set_drvdata(data->input_dev, data);
> > +
> > +     ret =3D sprd_keypad_enable(data);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "keypad enable failed.\n");
> > +             goto err_free;
> Same again.
>
> > +     }
>
> I'd suggest a suitable callback and devm_add_action_or_reset()
> to unwind the enable.
>
> Actually seeing the code above, just call
> devm_clk_get_enabled() here and drop the enable / disable functions.

We will fix this issue in patch v2.

>
>
> > +
> > +     ret =3D sprd_keypad_hw_init(data);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "keypad hw init failed.\n");
> > +             goto clk_free;
> > +     }
> > +
> > +     irq =3D platform_get_irq(pdev, 0);
> > +     if (irq < 0) {
> > +             dev_err(&pdev->dev, "platform get irq failed.\n");
> > +             goto clk_free;
> > +     }
> > +
> > +     ret =3D devm_request_irq(&pdev->dev, irq, sprd_keypad_handler,
> > +                             IRQF_NO_SUSPEND, dev_name(&pdev->dev), pd=
ev);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "request irq failed.\n");
> > +             goto clk_free;
> > +     }
> > +
> > +     ret =3D input_register_device(data->input_dev);
>
> Whilst there isn't a specific devm_ version of this, that is because ther=
e
> doesn't need to be one.  Have a look at the implementation and how
> it handles things when input_dev->devres_managed is set.
>
> Upshot, you don't need to manually unwind this either.

I don't quite understand what you mean.

>
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "register input dev failed\n");
> > +             goto clk_free;
> > +     }
> > +
> > +     if (data->capabilities & SPRD_CAP_WAKEUP)
> > +             device_init_wakeup(&pdev->dev, true);
> Another devm_add_action_or_reset() use case.  Note: only register
> the cleanup, if you use device_init_wakeup() here.

Thanks for your suggestion, I will seriously consider it.

>
> > +
> > +     return 0;
> > +
> > +clk_free:
> > +     sprd_keypad_disable(data);
> > +err_free:
> > +     devm_kfree(&pdev->dev, data);
> With changes above, there will be no manual cleanup to do here.

We will fix this issue in patch v2.

> > +     return ret;
> > +}
> > +
> > +static int sprd_keypad_remove(struct platform_device *pdev)
> > +{
> > +     struct sprd_keypad_data *data =3D platform_get_drvdata(pdev);
> > +     int irq =3D platform_get_irq(pdev, 0);
> > +
> > +     if (data->capabilities & SPRD_CAP_WAKEUP)
> > +             device_init_wakeup(&pdev->dev, false);
> > +
> > +     input_unregister_device(data->input_dev);
> > +     devm_free_irq(&pdev->dev, irq, pdev);
>
> Calling a devm free is usually a bad sign and implies you shouldn't have =
used
> devm to get the thing in the first place.
> The two should not be mixed - so the moment you reach a call in probe() t=
hat
> you don't want to use devm_ managed releases for, stop using them for eve=
rything
> after that point.  There is devm_add_action_or_reset() though which can b=
e used
> to register your own cleanup functions and sometimes lets you take the wh=
ole
> of the release flow device managed.
>
> Suggestions above mean you will have no remove() function at all.

Thanks for your suggestion, I will seriously consider it.

>
>
> > +     sprd_keypad_disable(data);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct of_device_id sprd_keypad_match[] =3D {
> > +     { .compatible =3D "sprd,sc9860-keypad", },
> > +     {},
> > +};
> > +
> > +static struct platform_driver sprd_keypad_driver =3D {
> > +     .driver =3D {
> > +             .name =3D "sprd-keypad",
> > +             .owner =3D THIS_MODULE,
> > +             .of_match_table =3D sprd_keypad_match,
> > +             .pm =3D &sprd_keypad_pm_ops,
> > +     },
> > +     .probe =3D sprd_keypad_probe,
> > +     .remove =3D sprd_keypad_remove,
> > +};
> > +
> > +module_platform_driver(sprd_keypad_driver);
> > +
> > +MODULE_DESCRIPTION("Spreadtrum KPD Driver");
> > +MODULE_LICENSE("GPL");
> > +MODULE_AUTHOR("Neo Hou <neo.hou@unisoc.com>");
>
