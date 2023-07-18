Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470DA758540
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 21:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjGRTAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 15:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjGRTAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 15:00:18 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EE5FD
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 12:00:16 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-47e36c35285so1932155e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 12:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1689706816; x=1692298816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kr1xFECZrsAfFudB/oMaSbrGfr4I2aPgz6TBVVMxCmI=;
        b=lz0z8BHLUK812Oe+Ep1RD8zVu2128ZCpp5rAo1gfP7CCJctHIKUIc+fgeGyFxdJFVU
         elP/t+DmkRjTondq97Gn9hJJN8plTf+IuAowxPPXCArcP05cz65paPItRTNMnSW1zbOP
         ZjRheORL1w6oOTnEzGi76xX3B29ujvmOxz5Xhhy9I7ouFblkfT7LZfZv7OUNL+rY7eVt
         6l/Nd4dk1TfhFtbExXouVFRkY5eZylZbdsaItMJudxVET0Ds+nahRJKMViapYu6wlvWB
         OccncIBy44qm5vgopJRBjoCc7DgmXsrY+nP9/KPKGljOd1kk6C9fbn/AMCwt2UFnttW9
         UumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689706816; x=1692298816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kr1xFECZrsAfFudB/oMaSbrGfr4I2aPgz6TBVVMxCmI=;
        b=Mqe0CYXssiSNZLJIu2TndClpPz1ZS2PqVMBsP6zM4RNsvGKmWHB4W4XW4/3aKdBChR
         xR3MSmOS5B7ZKhbRWMWf1rW/EzfzYVg0y60MhfCAE4WW+JcIayQXzz+ywJUCFQXkapHW
         ObBkcrY0KK94zO61fpIm6FABHXf8O5enDpSYRfaD+Lu4/zR7bJ3fE0cRRqJGkKY5w24Z
         /JZO1lWGNbgvkUckETce2TL9nSfouRUcyjWwAyIukaGxTq7UWnY68m0XAOA3yyFf4K/c
         NzldjUn1minb6+sRcbkx8SnVW0CJXRtdmRcOYwtu9ILtxEPZ4kw2CaW7Q+IsBM7y4q+w
         lNDA==
X-Gm-Message-State: ABy/qLasz5usoHc67joHYn2ZbFQ+gU1Eo56SvOZpjRBKFZ1zbsKL6C2Z
        KzbSmlX2ymHL75DibCAzc/EDDTFjY51VEgJ1VUVKBA==
X-Google-Smtp-Source: APBJJlF869L4eV2yvmfEqas1IZbGxZuYy82XGdmJnwZq/4VKOwLSLa1SZV4li9TCzxLXptzfkNfFBvpE4kpjGaWjKXA=
X-Received: by 2002:a67:ea0b:0:b0:443:4f72:fd35 with SMTP id
 g11-20020a67ea0b000000b004434f72fd35mr7802159vso.1.1689706815872; Tue, 18 Jul
 2023 12:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230711151248.4750-1-asmaa@nvidia.com> <CH2PR12MB389544F08A0A20AAB06123D3D738A@CH2PR12MB3895.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB389544F08A0A20AAB06123D3D738A@CH2PR12MB3895.namprd12.prod.outlook.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 18 Jul 2023 21:00:05 +0200
Message-ID: <CAMRc=Me30rRG7GY-aZfapcNZPc3BWJBBjC4BLoaVr0CjnidiUA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] gpio: mmio: handle "ngpios" properly in bgpio_init()
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Thompson <davthompson@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 8:38=E2=80=AFPM Asmaa Mnebhi <asmaa@nvidia.com> wro=
te:
>
>  > bgpio_init() uses "sz" argument to populate ngpio, which is not accura=
te.
> > Instead, read the "ngpios" property from the DT and if it doesn't exist=
, use the
> > "sz" argument. With this change, drivers no longer need to overwrite th=
e ngpio
> > variable after calling bgpio_init().
> >
> > If the "ngpios" property is specified, bgpio_bits is calculated as the =
round up
> > value of ngpio. At the moment, the only requirement specified is that t=
he round
> > up value must be a multiple of 8 but it should also be a power of 2 bec=
ause we
> > provide accessors based on the bank size in bgpio_setup_accessors().
> >
> > Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > ---
> > The following 2 patches were approved in March 2023 but didn't make it =
into
> > the tree:
> > [PATCH v4] gpio: mmio: handle "ngpios" properly in bgpio_init() [PATCH =
v1]
> > gpio: mmio: fix calculation of bgpio_bits
> >
> > They needed a rebase and were combined into a single patch since
> > "gpio: mmio: fix calculation of bgpio_bits" fixes a bug in
> > "gpio: mmio: handle "ngpios" properly in bgpio_init()"
> >
> > v1->v2:
> > - Added the tags
> > - Updated the changelog
> >
> >  drivers/gpio/gpio-mmio.c |  9 +++++-
> >  drivers/gpio/gpiolib.c   | 68 ++++++++++++++++++++++------------------
> >  drivers/gpio/gpiolib.h   |  1 +
> >  3 files changed, 46 insertions(+), 32 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-mmio.c b/drivers/gpio/gpio-mmio.c index
> > d9dff3dc92ae..74fdf0d87b2c 100644
> > --- a/drivers/gpio/gpio-mmio.c
> > +++ b/drivers/gpio/gpio-mmio.c
> > @@ -60,6 +60,8 @@ o        `                     ~~~~\___/~~~~    ` con=
troller in FPGA
> > is ,.`
> >  #include <linux/of.h>
> >  #include <linux/of_device.h>
> >
> > +#include "gpiolib.h"
> > +
> >  static void bgpio_write8(void __iomem *reg, unsigned long data)  {
> >       writeb(data, reg);
> > @@ -614,10 +616,15 @@ int bgpio_init(struct gpio_chip *gc, struct devic=
e
> > *dev,
> >       gc->parent =3D dev;
> >       gc->label =3D dev_name(dev);
> >       gc->base =3D -1;
> > -     gc->ngpio =3D gc->bgpio_bits;
> >       gc->request =3D bgpio_request;
> >       gc->be_bits =3D !!(flags & BGPIOF_BIG_ENDIAN);
> >
> > +     ret =3D gpiochip_get_ngpios(gc, dev);
> > +     if (ret)
> > +             gc->ngpio =3D gc->bgpio_bits;
> > +     else
> > +             gc->bgpio_bits =3D roundup_pow_of_two(round_up(gc->ngpio,
> > 8));
> > +
> >       ret =3D bgpio_setup_io(gc, dat, set, clr, flags);
> >       if (ret)
> >               return ret;
> > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c index
> > 251c875b5c34..7dac8bb9905a 100644
> > --- a/drivers/gpio/gpiolib.c
> > +++ b/drivers/gpio/gpiolib.c
> > @@ -700,6 +700,40 @@ void *gpiochip_get_data(struct gpio_chip *gc)  }
> > EXPORT_SYMBOL_GPL(gpiochip_get_data);
> >
> > +int gpiochip_get_ngpios(struct gpio_chip *gc, struct device *dev) {
> > +     u32 ngpios =3D gc->ngpio;
> > +     int ret;
> > +
> > +     if (ngpios =3D=3D 0) {
> > +             ret =3D device_property_read_u32(dev, "ngpios", &ngpios);
> > +             if (ret =3D=3D -ENODATA)
> > +                     /*
> > +                      * -ENODATA means that there is no property found
> > and
> > +                      * we want to issue the error message to the user=
.
> > +                      * Besides that, we want to return different erro=
r code
> > +                      * to state that supplied value is not valid.
> > +                      */
> > +                     ngpios =3D 0;
> > +             else if (ret)
> > +                     return ret;
> > +
> > +             gc->ngpio =3D ngpios;
> > +     }
> > +
> > +     if (gc->ngpio =3D=3D 0) {
> > +             chip_err(gc, "tried to insert a GPIO chip with zero lines=
\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (gc->ngpio > FASTPATH_NGPIO)
> > +             chip_warn(gc, "line cnt %u is greater than fast path cnt =
%u\n",
> > +                     gc->ngpio, FASTPATH_NGPIO);
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(gpiochip_get_ngpios);
> > +
> >  int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
> >                              struct lock_class_key *lock_key,
> >                              struct lock_class_key *request_key) @@ -70=
7,7
> > +741,6 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *da=
ta,
> >       struct gpio_device *gdev;
> >       unsigned long flags;
> >       unsigned int i;
> > -     u32 ngpios =3D 0;
> >       int base =3D 0;
> >       int ret =3D 0;
> >
> > @@ -753,36 +786,9 @@ int gpiochip_add_data_with_key(struct gpio_chip *g=
c,
> > void *data,
> >       else
> >               gdev->owner =3D THIS_MODULE;
> >
> > -     /*
> > -      * Try the device properties if the driver didn't supply the numb=
er
> > -      * of GPIO lines.
> > -      */
> > -     ngpios =3D gc->ngpio;
> > -     if (ngpios =3D=3D 0) {
> > -             ret =3D device_property_read_u32(&gdev->dev, "ngpios",
> > &ngpios);
> > -             if (ret =3D=3D -ENODATA)
> > -                     /*
> > -                      * -ENODATA means that there is no property found
> > and
> > -                      * we want to issue the error message to the user=
.
> > -                      * Besides that, we want to return different erro=
r code
> > -                      * to state that supplied value is not valid.
> > -                      */
> > -                     ngpios =3D 0;
> > -             else if (ret)
> > -                     goto err_free_dev_name;
> > -
> > -             gc->ngpio =3D ngpios;
> > -     }
> > -
> > -     if (gc->ngpio =3D=3D 0) {
> > -             chip_err(gc, "tried to insert a GPIO chip with zero lines=
\n");
> > -             ret =3D -EINVAL;
> > +     ret =3D gpiochip_get_ngpios(gc, &gdev->dev);
> > +     if (ret)
> >               goto err_free_dev_name;
> > -     }
> > -
> > -     if (gc->ngpio > FASTPATH_NGPIO)
> > -             chip_warn(gc, "line cnt %u is greater than fast path cnt =
%u\n",
> > -                       gc->ngpio, FASTPATH_NGPIO);
> >
> >       gdev->descs =3D kcalloc(gc->ngpio, sizeof(*gdev->descs), GFP_KERN=
EL);
> >       if (!gdev->descs) {
> > @@ -947,7 +953,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc=
,
> > void *data,
> >       /* failures here can mean systems won't boot... */
> >       if (ret !=3D -EPROBE_DEFER) {
> >               pr_err("%s: GPIOs %d..%d (%s) failed to register, %d\n",
> > __func__,
> > -                    base, base + (int)ngpios - 1,
> > +                    base, base + (int)gc->ngpio - 1,
> >                      gc->label ? : "generic", ret);
> >       }
> >       return ret;
> > diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h index
> > cca81375f127..8de748a16d13 100644
> > --- a/drivers/gpio/gpiolib.h
> > +++ b/drivers/gpio/gpiolib.h
> > @@ -217,6 +217,7 @@ int gpiod_configure_flags(struct gpio_desc *desc, c=
onst
> > char *con_id,  int gpio_set_debounce_timeout(struct gpio_desc *desc,
> > unsigned int debounce);  int gpiod_hog(struct gpio_desc *desc, const ch=
ar
> > *name,
> >               unsigned long lflags, enum gpiod_flags dflags);
> > +int gpiochip_get_ngpios(struct gpio_chip *gc, struct device *dev);
> >
> >  /*
> >   * Return the GPIO number of the passed descriptor relative to its chi=
p
> > --
> > 2.30.1
>
> Hi Bart,
>
> This is the final approved patch by both Linus and Andy. Please discard a=
ll others.
>

Ok, I applied this one but you need to get your patch versioning in
order next time.

Bart
