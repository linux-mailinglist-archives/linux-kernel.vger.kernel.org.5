Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BB3777210
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbjHJIF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjHJIF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:05:56 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09476ED;
        Thu, 10 Aug 2023 01:05:55 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 2adb3069b0e04-4fe8c1aec15so147286e87.1;
        Thu, 10 Aug 2023 01:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691654753; x=1692259553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtaXDdO/TsBRwtTa51UQGKqBzUEO9A/pF88ifwRgLPo=;
        b=chtToBvy/UxZI3quLER2HMbsWakzkcpbpq7gYoOwgyoLl0sEAS5ow1mGNkpKVzpQ1X
         Ar2WrFC41XFapVRzGcWCclW9y7Qvq7mBQtatgticBxJZnGnmLrqnijtjkVn0Vtx5FU//
         7xnISbR1O2dal44KmqchWftFWlSSAYsNUP0+7U9CuX6fHPxuzKgeL3YAShhCQ+vouRJd
         DvDhQ0szv/RzJTzTJsD3ewGzN8Y+9R6L5TtBfUWwA9mdp390NjvC0yNqEe8SGljUWG6U
         PkI2t27lvGoHzsUdpvYH2iDeu9mhrA1k/rcilaiKE3ZXolMJ16mTW52b3iCCE6zeUmGR
         l+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691654753; x=1692259553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NtaXDdO/TsBRwtTa51UQGKqBzUEO9A/pF88ifwRgLPo=;
        b=FXZcM/V+7No5EklgpSbpO8pUtEg1czW6NipNgimDt2rCYoss1yQVYoaGVjgeMo4N16
         /SWRAaGnhoyKlqUk1t1WGMrN/dacSN5dzSq8D9rpNQtM6UPsM0c4I56Zbyp72I0nFwSA
         I4tvzE+4R327G9YDW1ulfqbTsP4FTWLffp79bx8qdhwdpEemuZXOd5fmgXKsSFXxUL0f
         R+VspG19Kiy09j1x2X1fvSRqL8XEgBflQCUptZ488QPogSptMOmzn5Ca++9GnCWfuAhL
         /TIMIFGopVt274wOmsEly1ht0YlDedQ9pncAFdKJkJdFaZ8dJvrWzgzxV3gb6JM1KjOy
         wvXw==
X-Gm-Message-State: AOJu0Yz2fqc5lr9bW1rLeVN26IvLr2gkzvmJ5HfF5UGlm/26+bcMaCb7
        R5zegQHWYDrXWHTJPNUJy9zkufLsRm/Xvc/8aiQ=
X-Google-Smtp-Source: AGHT+IHMVFWqrCJdUSmuf7L0FjnzlLnA/HVhUUYkjyUJcFUxwFqszlovPrkn1QwRJcrbrSgDDuNPMvo8pywl2/Ko1q0=
X-Received: by 2002:a05:6512:3d2:b0:4fe:5838:3dc0 with SMTP id
 w18-20020a05651203d200b004fe58383dc0mr857844lfp.1.1691654752898; Thu, 10 Aug
 2023 01:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230808072501.3393-1-Wenhua.Lin@unisoc.com> <CAAfSe-srZT0nEnd8_8RpUZPrUaATza-=J24ZRiGzWHX5Nxp8PA@mail.gmail.com>
In-Reply-To: <CAAfSe-srZT0nEnd8_8RpUZPrUaATza-=J24ZRiGzWHX5Nxp8PA@mail.gmail.com>
From:   wenhua lin <wenhua.lin1994@gmail.com>
Date:   Thu, 10 Aug 2023 16:05:40 +0800
Message-ID: <CAB9BWhc_4=5C7_=d2=LfadDTYjJ1wUVajbJKjaGREqpgpYYtqg@mail.gmail.com>
Subject: Re: [PATCH] input: keyboard: Add sprd-keypad driver
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Samuel Holland <samuel@sholland.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
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

On Tue, Aug 8, 2023 at 5:33=E2=80=AFPM Chunyan Zhang <zhang.lyra@gmail.com>=
 wrote:
>
> On Tue, 8 Aug 2023 at 15:25, Wenhua Lin <Wenhua.Lin@unisoc.com> wrote:
> >
> > Add matrix keypad driver, support matrix keypad function.
>
> Add Unisoc keypad driver...

We will fix this issue in patch v2.

>
> >
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
> >           To compile this driver as a module, choose M here: the
> >           module will be called cypress-sf.
> >
> > +config KEYBOARD_SPRD
> > +       tristate "Spreadtrum keyboard support"
>
> %s/Spreadtrum/Unisoc

We will fix this issue in patch v2.

>
> > +       depends on ARCH_SPRD || COMPILE_TEST
> > +       select INPUT_MATRIXKMAP
> > +       help
> > +         Keypad controller is used to interface a SoC with a matrix-ke=
ypad device,
> > +         The keypad controller supports multiple row and column lines.
> > +         Say Y if you want to use the SPRD keyboard.
> > +         Say M if you want to use the SPRD keyboard on SoC as module.
> > +
> >  endif
> > diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/M=
akefile
> > index aecef00c5d09..b747112461b1 100644
> > --- a/drivers/input/keyboard/Makefile
> > +++ b/drivers/input/keyboard/Makefile
> > @@ -66,6 +66,7 @@ obj-$(CONFIG_KEYBOARD_STOWAWAY)               +=3D st=
owaway.o
> >  obj-$(CONFIG_KEYBOARD_ST_KEYSCAN)      +=3D st-keyscan.o
> >  obj-$(CONFIG_KEYBOARD_SUN4I_LRADC)     +=3D sun4i-lradc-keys.o
> >  obj-$(CONFIG_KEYBOARD_SUNKBD)          +=3D sunkbd.o
> > +obj-$(CONFIG_KEYBOARD_SPRD)            +=3D sprd_keypad.o
> >  obj-$(CONFIG_KEYBOARD_TC3589X)         +=3D tc3589x-keypad.o
> >  obj-$(CONFIG_KEYBOARD_TEGRA)           +=3D tegra-kbc.o
> >  obj-$(CONFIG_KEYBOARD_TM2_TOUCHKEY)    +=3D tm2-touchkey.o
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
>
> %s/Spreadtrum/Unisoc

We will fix this issue in patch v2.

>
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
> Please sort the includes in alphabetical order.

We will fix this issue in patch v2.

>
>
> > +
> > +#define SPRD_KPD_CTRL                  0x0
> > +#define SPRD_KPD_INT_EN                        0x4
> > +#define SPRD_KPD_INT_RAW_STATUS                0x8
> > +#define SPRD_KPD_INT_MASK_STATUS       0xc
> > +#define SPRD_KPD_INT_CLR               0x10
> > +#define SPRD_KPD_POLARITY              0x18
> > +#define SPRD_KPD_DEBOUNCE_CNT          0x1c
> > +#define SPRD_KPD_LONG_KEY_CNT          0x20
> > +#define SPRD_KPD_SLEEP_CNT             0x24
> > +#define SPRD_KPD_CLK_DIV_CNT           0x28
> > +#define SPRD_KPD_KEY_STATUS            0x2c
> > +#define SPRD_KPD_SLEEP_STATUS          0x30
> > +#define SPRD_KPD_DEBUG_STATUS1         0x34
> > +#define SPRD_KPD_DEBUG_STATUS2         0x38
> > +
> > +#define SPRD_KPD_EN                    BIT(0)
> > +#define SPRD_KPD_SLEEP_EN              BIT(1)
> > +#define SPRD_KPD_LONG_KEY_EN           BIT(2)
> > +
> > +#define SPRD_KPD_ROWS_MSK              GENMASK(23, 16)
> > +#define SPRD_KPD_COLS_MSK              GENMASK(15, 8)
> > +
> > +#define SPRD_KPD_INT_ALL               GENMASK(11, 0)
> > +#define SPRD_KPD_INT_DOWNUP            GENMASK(7, 0)
> > +#define SPRD_KPD_INT_LONG              GENMASK(11, 8)
> > +
> > +#define SPRD_KPD_ROW_POLARITY          GENMASK(7, 0)
> > +#define SPRD_KPD_COL_POLARITY          GENMASK(15, 8)
> > +
> > +#define SPRD_KPD_PRESS_INTX(X, V) \
> > +       (((V) >> (X)) & GENMASK(0, 0))
> > +#define SPRD_KPD_RELEASE_INTX(X, V) \
> > +       (((V) >> ((X) + 4)) & GENMASK(0, 0))
> > +#define SPRD_KPD_INTX_COL(X, V) \
> > +       (((V) >> ((X) << 3)) & GENMASK(2, 0))
> > +#define SPRD_KPD_INTX_ROW(X, V) \
> > +       (((V) >> (((X) << 3) + 4)) & GENMASK(2, 0))
> > +#define SPRD_KPD_INTX_DOWN(X, V) \
> > +       (((V) >> (((X) << 3) + 7)) & GENMASK(0, 0))
> > +
> > +#define SPRD_KPD_RTC_HZ                        32768
> > +#define SPRD_DEF_LONG_KEY_MS           1000
> > +#define SPRD_DEF_DIV_CNT               1
> > +#define SPRD_KPD_INT_CNT               4
> > +#define SPRD_KPD_ROWS_MAX              8
> > +#define SPRD_KPD_COLS_MAX              8
> > +#define SPRD_KPD_ROWS_SHIFT            16
> > +#define SPRD_KPD_COLS_SHIFT            8
> > +
> > +#define SPRD_CAP_WAKEUP                        BIT(0)
> > +#define SPRD_CAP_LONG_KEY              BIT(1)
> > +#define SPRD_CAP_REPEAT                        BIT(2)
> > +
> > +struct sprd_keypad_data {
> > +       u32 rows_en; /* enabled rows bits */
> > +       u32 cols_en; /* enabled cols bits */
> > +       u32 num_rows;
> > +       u32 num_cols;
> > +       u32 capabilities;
> > +       u32 debounce_ms;
> > +       void __iomem *base;
> > +       struct input_dev *input_dev;
> > +       struct clk *enable;
> > +       struct clk *rtc;
> > +};
> > +
> > +static int sprd_keypad_enable(struct sprd_keypad_data *data)
> > +{
> > +       struct device *dev =3D data->input_dev->dev.parent;
> > +       int ret;
> > +
> > +       ret =3D clk_prepare_enable(data->rtc);
> > +       if (ret) {
> > +               dev_err(dev, "enable rtc failed.\n");
> > +               return ret;
> > +       }
> > +
> > +       ret =3D clk_prepare_enable(data->enable);
> > +       if (ret) {
> > +               dev_err(dev, "enable keypad failed.\n");
> > +               clk_disable_unprepare(data->rtc);
> > +               return ret;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static void sprd_keypad_disable(struct sprd_keypad_data *data)
> > +{
> > +       clk_disable_unprepare(data->enable);
> > +       clk_disable_unprepare(data->rtc);
> > +}
> > +
> > +static irqreturn_t sprd_keypad_handler(int irq, void *id)
> > +{
> > +       struct platform_device *pdev =3D id;
> > +       struct device *dev =3D &pdev->dev;
> > +       struct sprd_keypad_data *data =3D platform_get_drvdata(pdev);
> > +       u32 int_status =3D readl_relaxed(data->base + SPRD_KPD_INT_MASK=
_STATUS);
> > +       u32 key_status =3D readl_relaxed(data->base + SPRD_KPD_KEY_STAT=
US);
> > +       unsigned short *keycodes =3D data->input_dev->keycode;
> > +       u32 row_shift =3D get_count_order(data->num_cols);
> > +       unsigned short key;
> > +       int col, row;
> > +       u32 i;
> > +
> > +       writel_relaxed(SPRD_KPD_INT_ALL, data->base + SPRD_KPD_INT_CLR)=
;
> > +
> > +       for (i =3D 0; i < SPRD_KPD_INT_CNT; i++) {
> > +               if (SPRD_KPD_PRESS_INTX(i, int_status)) {
> > +                       col =3D SPRD_KPD_INTX_COL(i, key_status);
> > +                       row =3D SPRD_KPD_INTX_ROW(i, key_status);
> > +                       key =3D keycodes[MATRIX_SCAN_CODE(row, col, row=
_shift)];
> > +                       input_report_key(data->input_dev, key, 1);
> > +                       input_sync(data->input_dev);
> > +                       dev_dbg(dev, "%dD\n", key);
> > +               }
> > +               if (SPRD_KPD_RELEASE_INTX(i, int_status)) {
> > +                       col =3D SPRD_KPD_INTX_COL(i, key_status);
> > +                       row =3D SPRD_KPD_INTX_ROW(i, key_status);
> > +                       key =3D keycodes[MATRIX_SCAN_CODE(row, col, row=
_shift)];
> > +                       input_report_key(data->input_dev, key, 0);
> > +                       input_sync(data->input_dev);
> > +                       dev_dbg(dev, "%dU\n", key);
> > +               }
> > +       }
> > +
> > +       return IRQ_HANDLED;
> > +}
> > +
> > +static u32 sprd_keypad_time_to_counter(u32 array_size, u32 time_ms)
> > +{
> > +       u32 value;
> > +
> > +       /*
> > +        * y(ms) =3D (x + 1) * array_size
> > +        *              / (32.768 / (clk_div_num + 1))
> > +        * y means time in ms
> > +        * x means counter
> > +        * array_size equal to rows * columns
> > +        * clk_div_num is devider to keypad source clock
> > +        **/
> > +       value =3D SPRD_KPD_RTC_HZ * time_ms;
> > +       value =3D value / (1000 * array_size *
> > +                       (SPRD_DEF_DIV_CNT + 1));
> > +       if (value >=3D 1)
> > +               value -=3D 1;
> > +
> > +       return value;
> > +}
> > +
> > +static int sprd_keypad_hw_init(struct sprd_keypad_data *data)
> > +{
> > +       u32 value;
> > +
> > +       writel_relaxed(SPRD_KPD_INT_ALL, data->base + SPRD_KPD_INT_CLR)=
;
> > +       writel_relaxed(SPRD_KPD_ROW_POLARITY | SPRD_KPD_COL_POLARITY,
> > +                       data->base + SPRD_KPD_POLARITY);
> > +       writel_relaxed(SPRD_DEF_DIV_CNT, data->base + SPRD_KPD_CLK_DIV_=
CNT);
> > +
> > +       value =3D sprd_keypad_time_to_counter(data->num_rows * data->nu=
m_cols,
> > +                                               SPRD_DEF_LONG_KEY_MS);
> > +       writel_relaxed(value, data->base + SPRD_KPD_LONG_KEY_CNT);
> > +
> > +       value =3D sprd_keypad_time_to_counter(data->num_rows * data->nu=
m_cols,
> > +                                               data->debounce_ms);
> > +       writel_relaxed(value, data->base + SPRD_KPD_DEBOUNCE_CNT);
> > +
> > +       value =3D SPRD_KPD_INT_DOWNUP;
> > +       if (data->capabilities & SPRD_CAP_LONG_KEY)
> > +               value |=3D SPRD_KPD_INT_LONG;
> > +       writel_relaxed(value, data->base + SPRD_KPD_INT_EN);
> > +
> > +       value =3D SPRD_KPD_RTC_HZ - 1;
> > +       writel_relaxed(value, data->base + SPRD_KPD_SLEEP_CNT);
> > +
> > +       /* set enabled rows and columns */
> > +       value =3D (((data->rows_en << SPRD_KPD_ROWS_SHIFT)
> > +               | (data->cols_en << SPRD_KPD_COLS_SHIFT))
> > +               & (SPRD_KPD_ROWS_MSK | SPRD_KPD_COLS_MSK))
> > +               | SPRD_KPD_EN | SPRD_KPD_SLEEP_EN;
> > +       if (data->capabilities & SPRD_CAP_LONG_KEY)
> > +               value |=3D SPRD_KPD_LONG_KEY_EN;
> > +       writel_relaxed(value, data->base + SPRD_KPD_CTRL);
> > +
> > +       return 0;
> > +}
> > +
> > +static int __maybe_unused sprd_keypad_suspend(struct device *dev)
> > +{
> > +       struct sprd_keypad_data *data =3D dev_get_drvdata(dev);
> > +
> > +       if (!device_may_wakeup(dev))
> > +               sprd_keypad_disable(data);
> > +
> > +       return 0;
> > +}
> > +
> > +static int __maybe_unused sprd_keypad_resume(struct device *dev)
> > +{
> > +       struct sprd_keypad_data *data =3D dev_get_drvdata(dev);
> > +       int ret =3D 0;
> > +
> > +       if (!device_may_wakeup(dev)) {
> > +               ret =3D sprd_keypad_enable(data);
> > +               if (ret)
> > +                       return ret;
> > +               ret =3D sprd_keypad_hw_init(data);
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(sprd_keypad_pm_ops,
> > +                       sprd_keypad_suspend, sprd_keypad_resume);
> > +
> > +static int sprd_keypad_parse_dt(struct device *dev)
> > +{
> > +       struct sprd_keypad_data *data =3D dev_get_drvdata(dev);
> > +       struct device_node *np =3D dev->of_node;
> > +       int ret;
> > +
> > +       ret =3D matrix_keypad_parse_properties(dev, &data->num_rows, &d=
ata->num_cols);
> > +       if (ret)
> > +               return ret;
> > +
> > +       if (data->num_rows > SPRD_KPD_ROWS_MAX
> > +               || data->num_cols > SPRD_KPD_COLS_MAX) {
> > +               dev_err(dev, "invalid num_rows or num_cols\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       ret =3D of_property_read_u32(np, "debounce-interval", &data->de=
bounce_ms);
> > +       if (ret) {
> > +               data->debounce_ms =3D 5;
> > +               dev_warn(dev, "parse debounce-interval failed.\n");
> > +       }
> > +
> > +       if (of_get_property(np, "linux,repeat", NULL))
> > +               data->capabilities |=3D SPRD_CAP_REPEAT;
> > +       if (of_get_property(np, "sprd,support_long_key", NULL))
> > +               data->capabilities |=3D SPRD_CAP_LONG_KEY;
> > +       if (of_get_property(np, "wakeup-source", NULL))
> > +               data->capabilities |=3D SPRD_CAP_WAKEUP;
> > +
> > +       data->enable =3D devm_clk_get(dev, "enable");
> > +       if (IS_ERR(data->enable)) {
> > +               if (PTR_ERR(data->enable) !=3D -EPROBE_DEFER)
> > +                       dev_err(dev, "get enable clk failed.\n");
> > +               return PTR_ERR(data->enable);
> > +       }
> > +
> > +       data->rtc =3D devm_clk_get(dev, "rtc");
> > +       if (IS_ERR(data->rtc)) {
> > +               if (PTR_ERR(data->enable) !=3D -EPROBE_DEFER)
> > +                       dev_err(dev, "get rtc clk failed.\n");
> > +               return PTR_ERR(data->rtc);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int sprd_keypad_probe(struct platform_device *pdev)
> > +{
> > +       struct sprd_keypad_data *data;
> > +       struct resource *res;
> > +       int ret, irq, i, j, row_shift;
> > +       unsigned long rows, cols;
> > +       unsigned short *keycodes;
> > +
> > +       data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> > +       if (!data)
> > +               return -ENOMEM;
> > +
> > +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       data->base =3D devm_ioremap_resource(&pdev->dev, res);
> > +       if (IS_ERR(data->base)) {
> > +               dev_err(&pdev->dev, "ioremap resource failed.\n");
> > +               ret =3D  PTR_ERR(data->base);
> > +               goto err_free;
> > +       }
> > +
> > +       platform_set_drvdata(pdev, data);
> > +       ret =3D sprd_keypad_parse_dt(&pdev->dev);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "keypad parse dts failed.\n");
> > +               goto err_free;
> > +       }
> > +
> > +       data->input_dev =3D devm_input_allocate_device(&pdev->dev);
> > +       if (IS_ERR(data->input_dev)) {
> > +               dev_err(&pdev->dev, "alloc input dev failed.\n");
> > +               ret =3D  PTR_ERR(data->input_dev);
> > +               goto err_free;
> > +       }
> > +
> > +       data->input_dev->name =3D "sprd-keypad";
> > +       data->input_dev->phys =3D "sprd-key/input0";
> > +
> > +       ret =3D matrix_keypad_build_keymap(NULL, NULL, data->num_rows,
> > +                                        data->num_cols, NULL, data->in=
put_dev);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "keypad build keymap failed.\n");
> > +               goto err_free;
> > +       }
> > +
> > +       rows =3D cols =3D 0;
> > +       row_shift =3D get_count_order(data->num_cols);
> > +       keycodes =3D data->input_dev->keycode;
> > +       for (i =3D 0; i < data->num_rows; i++) {
> > +               for (j =3D 0; j < data->num_cols; j++) {
> > +                       if (!!keycodes[MATRIX_SCAN_CODE(i, j, row_shift=
)]) {
> > +                               set_bit(i, &rows);
> > +                               set_bit(j, &cols);
> > +                       }
> > +               }
> > +       }
> > +       data->rows_en =3D rows;
> > +       data->cols_en =3D cols;
> > +
> > +       if (data->capabilities & SPRD_CAP_REPEAT)
> > +               set_bit(EV_REP, data->input_dev->evbit);
> > +
> > +       input_set_drvdata(data->input_dev, data);
> > +
> > +       ret =3D sprd_keypad_enable(data);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "keypad enable failed.\n");
> > +               goto err_free;
> > +       }
> > +
> > +       ret =3D sprd_keypad_hw_init(data);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "keypad hw init failed.\n");
> > +               goto clk_free;
> > +       }
> > +
> > +       irq =3D platform_get_irq(pdev, 0);
> > +       if (irq < 0) {
> > +               dev_err(&pdev->dev, "platform get irq failed.\n");
> > +               goto clk_free;
> > +       }
> > +
> > +       ret =3D devm_request_irq(&pdev->dev, irq, sprd_keypad_handler,
> > +                               IRQF_NO_SUSPEND, dev_name(&pdev->dev), =
pdev);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "request irq failed.\n");
> > +               goto clk_free;
> > +       }
> > +
> > +       ret =3D input_register_device(data->input_dev);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "register input dev failed\n");
> > +               goto clk_free;
> > +       }
> > +
> > +       if (data->capabilities & SPRD_CAP_WAKEUP)
> > +               device_init_wakeup(&pdev->dev, true);
> > +
> > +       return 0;
> > +
> > +clk_free:
> > +       sprd_keypad_disable(data);
> > +err_free:
> > +       devm_kfree(&pdev->dev, data);
> > +       return ret;
> > +}
> > +
> > +static int sprd_keypad_remove(struct platform_device *pdev)
> > +{
> > +       struct sprd_keypad_data *data =3D platform_get_drvdata(pdev);
> > +       int irq =3D platform_get_irq(pdev, 0);
> > +
> > +       if (data->capabilities & SPRD_CAP_WAKEUP)
> > +               device_init_wakeup(&pdev->dev, false);
> > +
> > +       input_unregister_device(data->input_dev);
> > +       devm_free_irq(&pdev->dev, irq, pdev);
> > +       sprd_keypad_disable(data);
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct of_device_id sprd_keypad_match[] =3D {
> > +       { .compatible =3D "sprd,sc9860-keypad", },
> > +       {},
> > +};
> > +
> > +static struct platform_driver sprd_keypad_driver =3D {
> > +       .driver =3D {
> > +               .name =3D "sprd-keypad",
> > +               .owner =3D THIS_MODULE,
> > +               .of_match_table =3D sprd_keypad_match,
> > +               .pm =3D &sprd_keypad_pm_ops,
> > +       },
> > +       .probe =3D sprd_keypad_probe,
> > +       .remove =3D sprd_keypad_remove,
> > +};
> > +
> > +module_platform_driver(sprd_keypad_driver);
> > +
> > +MODULE_DESCRIPTION("Spreadtrum KPD Driver");
>
> "Unisoc Keypad driver" would be better.

We will fix this issue in patch v2

>
> > +MODULE_LICENSE("GPL");
> > +MODULE_AUTHOR("Neo Hou <neo.hou@unisoc.com>");
>
> You can remove this since this driver's author seems not him.

 You can remove this since this driver's author seems not him.

>
> Thanks,
> Chunyan
