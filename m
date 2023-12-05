Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F66805C79
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346871AbjLEP3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346053AbjLEP3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:29:06 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E97122;
        Tue,  5 Dec 2023 07:29:11 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-67ab5e015aaso19514296d6.0;
        Tue, 05 Dec 2023 07:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701790151; x=1702394951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIYKGYeqEa37hnkKOr+7YP8jImIF+a10I7pn6sOwr9E=;
        b=dNjWugS1ERo11GXtamz/7egmeRM7rQOTBf/VvnYIGSDkTSkNv0xUGI7/xnbsRFi71J
         9znzx0uIa1M0RjE6ckkkK+4SsAf8dsrsY464R/OrQkgcg0DVPdUTVdOXegxp7qWwg7NN
         kYxHvgubtAUrqwnkM2JgCwwWn12ACW1OmGqyeLM2A4SgzYkuYDrzOHSpgtQlINy2GsEj
         38iRWKU0H5w7++gpRVEq4LA/UHeNVLY7VCUEKlpMI7AKuS85aEv3UkwTGnpqq/lhhRk5
         ct0PnqckBVAxJVH7Zw0+B/GCKBhozEqKdQRpkGcunBQwhhkUW+Zt4n5JewvAxKWnrjYv
         a3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701790151; x=1702394951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kIYKGYeqEa37hnkKOr+7YP8jImIF+a10I7pn6sOwr9E=;
        b=K/wRtA5IJ65f8kZumY1SO/jQ+KGsXm7B+NwyitxgtZm64uQYqzb90dRD0YZ83mXbLY
         gLnBAXTvkTDOvgA7yhNhJPzXTe/1YEIJXMN6A1dT4H+cxzF9LkhAi5TaPNr9udiHMUTW
         rWTNwrdskUIVfvhhtMN3hVO0vuBaGMGHHFp7ntkorcItDrGvAHm7jyc++25CCQPas2D+
         48pFXfro7RFDN33WD5L4aflwS6MiO5CP5dkU7Z/4ZyBUnbtwQX0oBqFNMll4qFH0jqsv
         6N/0iifmH1RyCkzN7qd+YLMYWin91sxjhwJV4Tm+Oxjtbbb8qiuuAulgzINS2qIL3jOn
         qSzQ==
X-Gm-Message-State: AOJu0YxS0RXqm/v5nyyurfP3Xkx+6eq68uHKhFo2m8yaY6t5lqBoII/o
        u2Jwz/BiygopTCQekNsI4Nj5WKAc2mZKxPFL+xc=
X-Google-Smtp-Source: AGHT+IFP2cXT9WCBVw22m/b3SLYzL/Q+YfaMu4Zah6NkpXTbDv/9NQTg66OiyNUFfmmtLAA5a1BXMW6tzTy8MvgWBmQ=
X-Received: by 2002:a05:6214:1803:b0:67a:656d:72e2 with SMTP id
 o3-20020a056214180300b0067a656d72e2mr1305611qvw.4.1701790150933; Tue, 05 Dec
 2023 07:29:10 -0800 (PST)
MIME-Version: 1.0
References: <20231205134223.17335-1-mitrutzceclan@gmail.com> <20231205134223.17335-2-mitrutzceclan@gmail.com>
In-Reply-To: <20231205134223.17335-2-mitrutzceclan@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Dec 2023 17:28:34 +0200
Message-ID: <CAHp75VeKhR5y4AB=L5VVSrm=13Ruw7e86m+K9m9t-LZg5puDow@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] iio: adc: ad7173: add AD7173 driver
To:     Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
        linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Ceclan Dumitru <dumitru.ceclan@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 5, 2023 at 3:46=E2=80=AFPM Dumitru Ceclan <mitrutzceclan@gmail.=
com> wrote:
>
> The AD7173 family offer a complete integrated Sigma-Delta ADC solution
> which can be used in high precision, low noise single channel
> applications or higher speed multiplexed applications. The Sigma-Delta
> ADC is intended primarily for measurement of signals close to DC but also
> delivers outstanding performance with input bandwidths out to ~10kHz.

...

> +config AD7173
> +       tristate "Analog Devices AD7173 driver"
> +       depends on SPI_MASTER
> +       select AD_SIGMA_DELTA
> +       select GPIO_REGMAP if GPIOLIB
> +       select REGMAP_SPI if GPIOLIB
> +       help
> +         Say yes here to build support for Analog Devices AD7173 and sim=
ilar ADC
> +         Currently supported models:
> +          - AD7172-2,
> +          - AD7173-8,
> +          - AD7175-2,
> +          - AD7176-2

Drop commas (sorry if I was not clear enough).


> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitmap.h>
> +#include <linux/container_of.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>

> +#include <linux/gpio/driver.h>

This...

> +#include <linux/idr.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>

> +#include <linux/gpio/regmap.h>

...and this are too far from each other. I believe you should count on G or=
der.

> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +#include <linux/spi/spi.h>
> +#include <linux/types.h>
> +#include <linux/units.h>

...

> +#define AD7173_GPO12_DATA(x)   BIT(x)

x + 0 ?

> +#define AD7173_GPO23_DATA(x)   BIT(x + 4)
> +#define AD7173_GPO_DATA(x)     (x < 2 ? AD7173_GPO12_DATA(x) : AD7173_GP=
O23_DATA(x))

...

> +               dev_warn(&st->sd.spi->dev,

Here...

> +                        "Unexpected device id: 0x%04X, expected: 0x%04X\=
n",
> +                        id, st->info->id);
> +
> +       st->adc_mode |=3D AD7173_ADC_MODE_SING_CYC;
> +       st->interface_mode =3D 0x0;
> +
> +       st->config_usage_counter =3D 0;
> +       st->config_cnts =3D devm_kcalloc(indio_dev->dev.parent,

...and here are different pointers in use, can you unify to use the
physical device pointer (as per above) here as well?

> +                                      st->info->num_configs, sizeof(u64)=
,
> +                                      GFP_KERNEL);
> +       if (!st->config_cnts)
> +               return -ENOMEM;

...

> +       case IIO_CHAN_INFO_SCALE:
> +               if (chan->type =3D=3D IIO_TEMP) {
> +                       *val =3D 250000000;

MEGA?

> +                       *val2 =3D 800273203; /* (2^24 * 477) / 10 */

Why not write it as is:

                       *val2 =3D (BIT(24) * 477) / 10;

?

It will be more robust as we don't expect compiler to give different
results here

> +                       return IIO_VAL_FRACTIONAL;
> +               } else {
> +                       *val =3D ad7173_get_ref_voltage_milli(st, ch->cfg=
.ref_sel);
> +                       *val2 =3D chan->scan_type.realbits - !!(ch->cfg.b=
ipolar);
> +                       return IIO_VAL_FRACTIONAL_LOG2;
> +               }

...

> +       /* If a regulator is not available, it will be set to a dummy reg=
ulator.
> +        * Each channel reference is checked with regulator_get_voltage()=
 before
> +        *  setting attributes so if any channel uses a dummy supply the =
driver
> +        *  probe will fail.
> +        */

/*
 * Multi-line comments should follow this style. Find the
 * difference.
 */

...

> +               ref_label =3D ad7173_ref_sel_str[AD7173_SETUP_REF_SEL_INT=
_REF];
> +
> +               fwnode_property_read_string(child, "adi,reference-select"=
,
> +                                           &ref_label);
> +               ref_sel =3D match_string(ad7173_ref_sel_str,
> +                                      ARRAY_SIZE(ad7173_ref_sel_str), re=
f_label);
> +               if (ref_sel < 0) {

Can we use fwnode_property_match_property_string()?

> +                       fwnode_handle_put(child);
> +                       return dev_err_probe(dev, -EINVAL,
> +                                            "Invalid channel reference n=
ame %s\n",
> +                                            ref_label);
> +               }

--=20
With Best Regards,
Andy Shevchenko
