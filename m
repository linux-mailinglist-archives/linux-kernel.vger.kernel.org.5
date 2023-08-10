Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E14A7778B7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbjHJMmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 08:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbjHJMmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:42:51 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FEF10C7;
        Thu, 10 Aug 2023 05:42:50 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 38308e7fff4ca-2b70357ca12so2695371fa.1;
        Thu, 10 Aug 2023 05:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691671369; x=1692276169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwBVHzLwd92fsxfzczu9GGQIE3JrMqw9X2QmRcg7bqg=;
        b=eErCXXBKlxtwpdaGMcpmGGDY0JXn5M+MZ14evi5WAxlF21SM7zRD9GX7HiYtTMiJSE
         20EnZl7Flki8LTiodkGMM8aBa4SSns9i10AgqQVmRS5EeTpPmQDSKfaEcRdA3PBWUUtg
         GwAZdlM3Tk7+Rw5tjBo0havDeEqCsKHIlhHyD6OMTMTmZ4MvVfED+9czVcm5eHrsikem
         JwPZz18YaRgKh8r2Nv5eYQWNrbisooKRBcYc+7bVK1/Ym8IbF3j4fnpQBCaDaY3MPld9
         YlAswwE6xxrk62SS4gTuRQv15P/GVxMu3tdpEPAteVcF0WHh5LECT7B5uAiHYFwnc9pU
         I2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691671369; x=1692276169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZwBVHzLwd92fsxfzczu9GGQIE3JrMqw9X2QmRcg7bqg=;
        b=PP+VqSVTfYozbLm2989c/C4iHSFazyqCQFmxjlmF2HyfmhZMSnYF2E/TNL9AKgXgqE
         6Z/m4nKmt7AXBNWedlBdtL6uH5UPAESWHAonnaagMcZO2DyYpSomWL5PKcwScqHwJnER
         7UgHSgYRiITdwnwqtLdKTSR7o9/s2zhJ9LkvqRGYbNSQDSvEQNlnzD9V+kCTDUe/8s+y
         FQ3unwY8GGLqtqLH9WJT81I/wxyMjUPA9B7Aew7EdtQe9dATYfBBtDH8w8kFcQvbqRbn
         9xBNlQMrSQy/Z6FO2j57Al0P4ri4tFvJkJvD0Xa3JpfZaJEFr833WHVq1EJsLgkGuj5/
         so8A==
X-Gm-Message-State: AOJu0YyOjtonex4APKA7aruQpuOG06cSE3eRNXEoHvN0MLf0QpQ8xKCY
        O8UuHFEkavHKL5aT8fTOd5Mk+rm+D55HIeILVjo=
X-Google-Smtp-Source: AGHT+IGRZBB5hG23tmio30ZG3lIblQ2f8knxEM8wV/2rabgVV5k51+RLI++7VMVA4ee5y7srgyjdT/i61LOqCYZKyos=
X-Received: by 2002:a05:651c:a10:b0:2b7:3a7e:9e89 with SMTP id
 k16-20020a05651c0a1000b002b73a7e9e89mr2113707ljq.2.1691671368552; Thu, 10 Aug
 2023 05:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230808072501.3393-1-Wenhua.Lin@unisoc.com> <ZNJIa+CbmvDuKq2L@smile.fi.intel.com>
In-Reply-To: <ZNJIa+CbmvDuKq2L@smile.fi.intel.com>
From:   wenhua lin <wenhua.lin1994@gmail.com>
Date:   Thu, 10 Aug 2023 20:42:36 +0800
Message-ID: <CAB9BWhcPpZRNPki1j0spCzN0kF=-1P1ZwtOLULmr2Raz6aO-_w@mail.gmail.com>
Subject: Re: [PATCH] input: keyboard: Add sprd-keypad driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
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
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 9:51=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Aug 08, 2023 at 03:25:01PM +0800, Wenhua Lin wrote:
> > Add matrix keypad driver, support matrix keypad function.
>
> Bindings should be prerequisite to this, meaning this has to be a series =
of
> two patches.

I don't quite understand what you mean.
Can you describe the problem in detail?

>
> ...
>
> > +     help
> > +       Keypad controller is used to interface a SoC with a matrix-keyp=
ad device,
> > +       The keypad controller supports multiple row and column lines.
> > +       Say Y if you want to use the SPRD keyboard.
> > +       Say M if you want to use the SPRD keyboard on SoC as module.
>
> What will be the module name?

Keypad

>
> ...
>
> >  obj-$(CONFIG_KEYBOARD_ST_KEYSCAN)    +=3D st-keyscan.o
> >  obj-$(CONFIG_KEYBOARD_SUN4I_LRADC)   +=3D sun4i-lradc-keys.o
> >  obj-$(CONFIG_KEYBOARD_SUNKBD)                +=3D sunkbd.o
> > +obj-$(CONFIG_KEYBOARD_SPRD)          +=3D sprd_keypad.o
>
> Are you sure it's ordered correctly?

This configuration is correct, we may not understand what you mean?
 Any suggestions for this modification?

>
> >  obj-$(CONFIG_KEYBOARD_TC3589X)               +=3D tc3589x-keypad.o
> >  obj-$(CONFIG_KEYBOARD_TEGRA)         +=3D tegra-kbc.o
> >  obj-$(CONFIG_KEYBOARD_TM2_TOUCHKEY)  +=3D tm2-touchkey.o
>
> ...
>
> > +/*
> > + * Copyright (C) 2018 Spreadtrum Communications Inc.
> > + */
>
> A single line
>
> ...
>
> Missing bits.h at least.
> Revisit you header inclusion block to add exactly what you are using.
>

The sprd_keypad.c file will include <linux/interrupt.h>, interrupt.h
will include <linux/bitops.h>,
and the bitops.h file will include bits.h. Can this operation method be use=
d?

> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/input/matrix_keypad.h>
> > +#include <linux/io.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/clk.h>
>
> > +#include <linux/of.h>
>
> Why?

ret =3D of_property_read_u32(np, "debounce-interval", &data->debounce_ms);
if (of_get_property(np, "linux,repeat", NULL))

Two interfaces of_property_read_u32 and of_get_property are used
in the sprd_keypad_parse_dt function. If of.h is not included, the
compilation will report an error.

>
> > +#include <linux/input.h>
>
> Order please?

We will fix this issue in patch v2.

>
> ...
>
> > +#define SPRD_KPD_CTRL                        0x0
> > +#define SPRD_KPD_INT_EN                      0x4
> > +#define SPRD_KPD_INT_RAW_STATUS              0x8
> > +#define SPRD_KPD_INT_MASK_STATUS     0xc
>
> Use fixed width for register offset, like 0x00.

We will fix this issue in patch v2.

>
> ...
>
> > +#define SPRD_DEF_LONG_KEY_MS         1000
>
>         (1 * MSEC_PER_SEC)
>
> ?

    Yes.

>
> ...
>
> > +struct sprd_keypad_data {
> > +     u32 rows_en; /* enabled rows bits */
> > +     u32 cols_en; /* enabled cols bits */
>
> Why not bitmaps?

Bitmap has been used, each bit represents different rows and different colu=
mns.

>
> > +     u32 num_rows;
> > +     u32 num_cols;
> > +     u32 capabilities;
> > +     u32 debounce_ms;
> > +     void __iomem *base;
> > +     struct input_dev *input_dev;
> > +     struct clk *enable;
> > +     struct clk *rtc;
> > +};
>
> ...
>
> > +     /*
>
> > +      * y(ms) =3D (x + 1) * array_size
> > +      *              / (32.768 / (clk_div_num + 1))
>
> One line.
>
> +        * Where:
>
> > +      * y means time in ms
> > +      * x means counter
> > +      * array_size equal to rows * columns
> > +      * clk_div_num is devider to keypad source clock
> > +      **/
>
> Single asterisk is enough.

We will fix this issue in patch v2.

>
> ...
>
> > +     value =3D value / (1000 * array_size *
>
> value /=3D ... ?

We will fix this issue in patch v2.

>
> MSEC_PER_SEC ?
>
> > +                     (SPRD_DEF_DIV_CNT + 1));
>
> One line.

We will fix this issue in patch v2.

>
> ...
>
> > +     if (value >=3D 1)
> > +             value -=3D 1;
>
>         if (value)
>                 value--;
>
> ...
>
> > +     value =3D (((data->rows_en << SPRD_KPD_ROWS_SHIFT)
> > +             | (data->cols_en << SPRD_KPD_COLS_SHIFT))
> > +             & (SPRD_KPD_ROWS_MSK | SPRD_KPD_COLS_MSK))
> > +             | SPRD_KPD_EN | SPRD_KPD_SLEEP_EN;
>
> Move | & etc on previous lines respectively.

We will fix this issue in patch v2.

>
> ...
>
> > +static int __maybe_unused sprd_keypad_suspend(struct device *dev)
>
> No __maybe_unused.

We will fix this issue in patch v2.

>
> ...
>
> > +static int __maybe_unused sprd_keypad_resume(struct device *dev)
>
> Ditto.

We will fix this issue in patch v2.

>
> ...
>
> > +static SIMPLE_DEV_PM_OPS(sprd_keypad_pm_ops,
> > +                     sprd_keypad_suspend, sprd_keypad_resume);
>
> Use new DEFINE_*() PM macro.

We will fix this issue in patch v2.

>
> ...
>
> > +static int sprd_keypad_parse_dt(struct device *dev)
>
> dt -> fw

I don't quite understand what you mean,
is it to change the function name to sprd_keypad_parse_fw?

>
> ...
>
> > +     if (data->num_rows > SPRD_KPD_ROWS_MAX
> > +             || data->num_cols > SPRD_KPD_COLS_MAX) {
>
> Move the || to the previous line.

We will fix this issue in patch v2.

>
> > +             dev_err(dev, "invalid num_rows or num_cols\n");
> > +             return -EINVAL;
> > +     }
>
> ...
>
> > +     ret =3D of_property_read_u32(np, "debounce-interval", &data->debo=
unce_ms);
>
> device_property_...()

We will fix this issue in patch v2.

>
> > +     if (ret) {
> > +             data->debounce_ms =3D 5;
>
> > +             dev_warn(dev, "parse debounce-interval failed.\n");
>
> Why do we need this message?

Prompt that debounce time is not defined.

>
> > +     }
>
> ...
>
> > +     if (of_get_property(np, "linux,repeat", NULL))
> > +             data->capabilities |=3D SPRD_CAP_REPEAT;
> > +     if (of_get_property(np, "sprd,support_long_key", NULL))
> > +             data->capabilities |=3D SPRD_CAP_LONG_KEY;
> > +     if (of_get_property(np, "wakeup-source", NULL))
> > +             data->capabilities |=3D SPRD_CAP_WAKEUP;
>
> device_property_*()

We will fix this issue in patch v2.

>
> And I'm wondering if input subsystem already does this for you.

I don't quite understand what you mean.

>
> ...
>
> > +     data->enable =3D devm_clk_get(dev, "enable");
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
>
> Why not bulk?
> Why not _enabled() variant?

I don't quite understand what you mean.
Can you give me an example?

>
> > +     return 0;
> > +}
>
> ...
>
> > +     res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     data->base =3D devm_ioremap_resource(&pdev->dev, res);
>
> devm_platform_ioremap_resource()
>
> > +     if (IS_ERR(data->base)) {
>
> > +             dev_err(&pdev->dev, "ioremap resource failed.\n");
>
> Dup message.

 Do you mean : dev_err(&pdev->dev, "ioremap resource failed.\n")=EF=BC=8C
I think it is necessary to prompt accurate error message.

>
> > +             ret =3D  PTR_ERR(data->base);
> > +             goto err_free;
> > +     }
>
> ...
>
> > +     data->input_dev =3D devm_input_allocate_device(&pdev->dev);
> > +     if (IS_ERR(data->input_dev)) {
> > +             dev_err(&pdev->dev, "alloc input dev failed.\n");
> > +             ret =3D  PTR_ERR(data->input_dev);
>

> Too many spaces.

We will fix this issue in patch v2.

>
> > +             goto err_free;
>
> Here and elsewhere in ->probe() use return dev_err_probe() approach as Dm=
itry
> nowadays is okay with that.

I don't quite understand what you mean.
Can you describe it in detail?
>
> > +     }
>
> ...
>
> > +     ret =3D matrix_keypad_build_keymap(NULL, NULL, data->num_rows,
> > +                                      data->num_cols, NULL, data->inpu=
t_dev);
>
> Reindent this to be split logically.

We will fix this issue in patch v2.

>
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "keypad build keymap failed.\n");
> > +             goto err_free;
> > +     }
>
> ...
>
> > +     irq =3D platform_get_irq(pdev, 0);
> > +     if (irq < 0) {
>
> > +             dev_err(&pdev->dev, "platform get irq failed.\n");
>
> Dup message.
>
> > +             goto clk_free;
> > +     }
>
> ...
>
> > +clk_free:
> > +     sprd_keypad_disable(data);
>
> See above how this can be avoided.

This is hard to explain.

>
> ...
>
> > +err_free:
> > +     devm_kfree(&pdev->dev, data);
>
> Huh?!
>
> > +     return ret;
>
> ...
>
> > +static const struct of_device_id sprd_keypad_match[] =3D {
> > +     { .compatible =3D "sprd,sc9860-keypad", },
> > +     {},
>
> No comma for the terminator.

We will fix this issue in patch v2.

>
> > +};
>
> ...
>
> > +static struct platform_driver sprd_keypad_driver =3D {
> > +     .driver =3D {
> > +             .name =3D "sprd-keypad",
>
> > +             .owner =3D THIS_MODULE,
>
> ~15 years this is not needed.
> Where did you get this code from? Time machine?

Do you mean the keypad driver is no longer in use?

>
> > +             .of_match_table =3D sprd_keypad_match,
> > +             .pm =3D &sprd_keypad_pm_ops,
> > +     },
> > +     .probe =3D sprd_keypad_probe,
> > +     .remove =3D sprd_keypad_remove,
> > +};
>
> > +
>
> No need to have this blank line.

We will fix this issue in patch v2.

>
> > +module_platform_driver(sprd_keypad_driver);
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
