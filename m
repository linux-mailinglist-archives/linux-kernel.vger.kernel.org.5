Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866527FFDB8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376937AbjK3VlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjK3VlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:41:09 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED2A10F8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:41:14 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c9d4afb7dfso9286421fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701380472; x=1701985272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fd0YG7g3wby74JcgoZTxtodoh2Ma9koAtjIfAtnBqJI=;
        b=2iOGjZfCoTX61S0IzTF8HAWGZHbpH0IEYWbQivxvA/ZxP+xHIYwH0+DikksWbd5mzO
         AcK7xKSkEV8TZrCTG8vTH0Wd7tHM4NPxasAf4ufnqlWHc8vS+ktj5e4GXaAkYQfhY+zt
         xITrQcSELi2udH6Ynwvm0HZo7hvuWM9GcO4lWKdei+1+NHrgTsT7eQCGF31XOUzbxFdE
         9xaGtK4JxeWWNxpPDDHEagDv/7RBYlF5TQ/4xGVHRvgufZ1OUEAYjKckeFgg/0oNKyZh
         Zk3mGJb7etbEBhn8vewD+Kp+g8s5loU58gUO5Bh6oreuQ/On7ERHcvPLkp7HewOpZbci
         GgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701380472; x=1701985272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fd0YG7g3wby74JcgoZTxtodoh2Ma9koAtjIfAtnBqJI=;
        b=Y6BAhJn0KtQrfkprqyKf3GNSGa9wCsx8s2mBIrpXUQqTOoQD/9qyei4YwJMMRse2Mi
         CxrrblAz5qPf76KDWYRjc7eApXolRqgAJtsi5ptLGKgghB1iYCqfvCgZg4x6Q/rPwK+D
         3W39Mql9IEjraabdbGG6pKr9xhxvur8yjBqqugvEsEFEh92NziUR5JuKwxFKn6xLTUxA
         48zTJCXVwHul43fNu2DRemfyZK1JcIPIw3k1THGfY2NX1WgYrypvyEPBXfdpnj628dbr
         POuy40LH/G08QxoJBGJyJ+RX/+zOpwM47t3y/lJc+nBvMjF5W6gkXH99tDAbgFC3/eKm
         1rSg==
X-Gm-Message-State: AOJu0YykHoXI4Dj3G3cbkEd3Zj08NsGlU2MzdGIfOwxWMRCIB2h7s3rx
        EFYOciwdXkbEjed8w5Y4vU7aHr72DrqOfkjZgd4xmQ==
X-Google-Smtp-Source: AGHT+IHOqy3zd2l2wLsrbsS+OGAQHC++9ntml8mSoabCouZoB5MU3hbrors/4KLRm6nsBU9nM5qo4UP0iLwzR7fLM1w=
X-Received: by 2002:a2e:9ec1:0:b0:2c9:d872:abdf with SMTP id
 h1-20020a2e9ec1000000b002c9d872abdfmr87880ljk.93.1701380472434; Thu, 30 Nov
 2023 13:41:12 -0800 (PST)
MIME-Version: 1.0
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com> <20231121-dev-iio-backend-v1-4-6a3d542eba35@analog.com>
In-Reply-To: <20231121-dev-iio-backend-v1-4-6a3d542eba35@analog.com>
From:   David Lechner <dlechner@baylibre.com>
Date:   Thu, 30 Nov 2023 15:41:01 -0600
Message-ID: <CAMknhBGCqnzCp6vQ+59Z-SybScvbtU7aWdAD6KnP1e6=q60gVQ@mail.gmail.com>
Subject: Re: [PATCH 04/12] iio: adc: ad9467: fix reset gpio handling
To:     nuno.sa@analog.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Olivier MOYSAN <olivier.moysan@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 4:17=E2=80=AFAM Nuno Sa via B4 Relay
<devnull+nuno.sa.analog.com@kernel.org> wrote:
>
> From: Nuno Sa <nuno.sa@analog.com>
>
> The reset gpio was being requested with GPIOD_OUT_LOW which means, not
> asserted. Then it was being asserted but never de-asserted which means
> the devices was left in reset. Fix it by de-asserting the gpio.

It could be helpful to update the devicetree bindings to state the
expected active-high or active-low setting for this gpio so it is
clear which state means asserted.

>
> While at it, moved the handling to it's own function and dropped
> 'reset_gpio' from the 'struct ad9467_state' as we only need it during
> probe. On top of that, refactored things so that we now request the gpio
> asserted (i.e in reset) and then de-assert it.
>
> Fixes: ad6797120238 ("iio: adc: ad9467: add support AD9467 ADC")
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/adc/ad9467.c | 33 ++++++++++++++++++++-------------
>  1 file changed, 20 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index 39eccc28debe..368ea57be117 100644
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c
> @@ -121,7 +121,6 @@ struct ad9467_state {
>         unsigned int                    output_mode;
>
>         struct gpio_desc                *pwrdown_gpio;
> -       struct gpio_desc                *reset_gpio;
>  };
>
>  static int ad9467_spi_read(struct spi_device *spi, unsigned int reg)
> @@ -378,6 +377,23 @@ static int ad9467_preenable_setup(struct adi_axi_adc=
_conv *conv)
>         return ad9467_outputmode_set(st->spi, st->output_mode);
>  }
>
> +static int ad9467_reset(struct device *dev)
> +{
> +       struct gpio_desc *gpio;
> +
> +       gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +       if (IS_ERR(gpio))
> +               return PTR_ERR(gpio);
> +       if (!gpio)
> +               return 0;

can be done in one test instead of 2:

if (IS_ERR_OR_NULL(gpio))
        return PTR_ERR_OR_ZERO(gpio);

> +
> +       fsleep(1);
> +       gpiod_direction_output(gpio, 0);
> +       fsleep(10);

Previous version was 10 milliseconds instead of 10 microseconds. Was
this change intentional? If yes, it should be mentioned it in the
commit message.

> +
> +       return 0;
> +}
> +
>  static int ad9467_probe(struct spi_device *spi)
>  {
>         const struct ad9467_chip_info *info;
> @@ -408,18 +424,9 @@ static int ad9467_probe(struct spi_device *spi)
>         if (IS_ERR(st->pwrdown_gpio))
>                 return PTR_ERR(st->pwrdown_gpio);
>
> -       st->reset_gpio =3D devm_gpiod_get_optional(&spi->dev, "reset",
> -                                                GPIOD_OUT_LOW);
> -       if (IS_ERR(st->reset_gpio))
> -               return PTR_ERR(st->reset_gpio);
> -
> -       if (st->reset_gpio) {
> -               udelay(1);
> -               ret =3D gpiod_direction_output(st->reset_gpio, 1);
> -               if (ret)
> -                       return ret;
> -               mdelay(10);
> -       }
> +       ret =3D ad9467_reset(&spi->dev);
> +       if (ret)
> +               return ret;
>
>         conv->chip_info =3D &info->axi_adc_info;
>
>
> --
> 2.42.1
>
>
