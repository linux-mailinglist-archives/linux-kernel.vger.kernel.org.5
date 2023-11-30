Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E1B7FFF75
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 00:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377256AbjK3Xax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 18:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377216AbjK3Xav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 18:30:51 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85ADE10E4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:30:53 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c9c5d30b32so19896061fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701387052; x=1701991852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlkZfLy7XjVfeJnSAyVxLt4mO60J3JeK1Ayu4OTnn6g=;
        b=Rgrl6LR8zpZCooUNieWI3jD+Rfv1Qqm1fKKdaI+Q65R5bv8wc/EGFsuqmC5XorZokG
         er3Z1FJotq5XRS7Se/Gp/lgN+5yeZBHsMDLMiv4BL+n+3d9EYeLgsoq9aVytJ99v10QX
         COPyEAl0XrA1eLOSXWGlg//9n7FWb04XrQRxNfAENxOsrlX6de6I4mHFLBGmeM7Ye8BR
         7hsRPTGCwbmtbaxV+NpETD+76G8MxJojeIg+zx2uFqYEiGOOK+HI5u2115y/33nNMRec
         gOBhu5QNuCrR40bHEjqQA7G5yUN24QI958vVcfBH0H07gpIstst4Ky0fNbSjRtr0u+Sc
         KNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701387052; x=1701991852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OlkZfLy7XjVfeJnSAyVxLt4mO60J3JeK1Ayu4OTnn6g=;
        b=Fw39N3EYd4gwyuPx7hImqu4djDFU7OyJk5/QsbalkhLqwh+ZLiIbuuHPUn/1UpptDG
         S75ZD4aBya9lDys12XaUCbRSwyJ/9CtV+7jJi5cP8yoRRU2r21a8usjZlEpd6kNRqsgB
         a/lus+RVWKJHDrWuj73Gj+kq0S3zmqcesUREcydSyOZ+yklmuR7btfY6PXtRdy16Um+c
         fI3V7DJz4nf4afqLd56Xdp5TxuiIS+rLCseIhuudtwNXdKX+z2FaSlt+wt7Xl7cuZTaS
         JAqEpnstGssAoRi+feqMzDEl/ChVoQnhkIbXxonO84Pc0SlnBdXnrG0lOM6nUnV7fpp4
         NAUg==
X-Gm-Message-State: AOJu0YxSkSLp/rN+2KWrUAyTk07SIwTOEl8DGDI2bSzKibyOHGku8Wku
        +cMgk0naeXBWCXtgE6+qiVskdwOiKyvw5wwHgsV8FA==
X-Google-Smtp-Source: AGHT+IEXF8b8i2d8gUX/7XGbKeBhO5y4FoKURpNKXdVwOiELp1ycsJ9gIbh2TFOn8p7a8iYvPuGv0h95Jl3CjKO9auA=
X-Received: by 2002:a2e:6e14:0:b0:2c9:d862:c66b with SMTP id
 j20-20020a2e6e14000000b002c9d862c66bmr192908ljc.88.1701387051792; Thu, 30 Nov
 2023 15:30:51 -0800 (PST)
MIME-Version: 1.0
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com> <20231121-dev-iio-backend-v1-10-6a3d542eba35@analog.com>
In-Reply-To: <20231121-dev-iio-backend-v1-10-6a3d542eba35@analog.com>
From:   David Lechner <dlechner@baylibre.com>
Date:   Thu, 30 Nov 2023 17:30:40 -0600
Message-ID: <CAMknhBFbLju8UQJ7Uz85kHKrbK4mzt=wTRdnp40+PwWCJa5dsA@mail.gmail.com>
Subject: Re: [PATCH 10/12] iio: adc: ad9467: convert to backend framework
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
> Convert the driver to use the new IIO backend framework. The device
> functionality is expected to be the same (meaning no added or removed
> features).

Missing a devicetree bindings patch before this one?

>
> Also note this patch effectively breaks ABI and that's needed so we can
> properly support this device and add needed features making use of the
> new IIO framework.

Can you be more specific about what is actually breaking?

>
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/adc/Kconfig  |   2 +-
>  drivers/iio/adc/ad9467.c | 256 +++++++++++++++++++++++++++++------------=
------
>  2 files changed, 157 insertions(+), 101 deletions(-)
>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 1e2b7a2c67c6..af56df63beff 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -275,7 +275,7 @@ config AD799X
>  config AD9467
>         tristate "Analog Devices AD9467 High Speed ADC driver"
>         depends on SPI
> -       depends on ADI_AXI_ADC
> +       select IIO_BACKEND
>         help
>           Say yes here to build support for Analog Devices:
>           * AD9467 16-Bit, 200 MSPS/250 MSPS Analog-to-Digital Converter
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index 5db5690ccee8..8b0402e73ace 100644
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c

<snip>

> +static int ad9467_buffer_get(struct iio_dev *indio_dev)

perhaps a more descriptive name: ad9467_buffer_setup_optional?

> +{
> +       struct device *dev =3D indio_dev->dev.parent;
> +       const char *dma_name;
> +
> +       if (!device_property_present(dev, "dmas"))
> +               return 0;
> +
> +       if (device_property_read_string(dev, "dma-names", &dma_name))
> +               dma_name =3D "rx";
> +
> +       return devm_iio_dmaengine_buffer_setup(dev, indio_dev, dma_name);

The device tree bindings for "adi,ad9467" don't include dma properties
(nor should they). Perhaps the DMA lookup should be a callback to the
backend? Or something similar to the SPI Engine offload that we are
working on?

> +}
> +
>  static int ad9467_probe(struct spi_device *spi)
>  {
> -       const struct ad9467_chip_info *info;
> -       struct adi_axi_adc_conv *conv;
> +       struct iio_dev *indio_dev;
>         struct ad9467_state *st;
>         unsigned int id;
>         int ret;
>
> -       info =3D spi_get_device_match_data(spi);
> -       if (!info)
> -               return -ENODEV;
> -
> -       conv =3D devm_adi_axi_adc_conv_register(&spi->dev, sizeof(*st));
> -       if (IS_ERR(conv))
> -               return PTR_ERR(conv);
> +       indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +       if (!indio_dev)
> +               return -ENOMEM;
>
> -       st =3D adi_axi_adc_conv_priv(conv);
> +       st =3D iio_priv(indio_dev);
>         st->spi =3D spi;
>
> +       st->info =3D spi_get_device_match_data(spi);
> +       if (!st->info)
> +               return -ENODEV;
> +
>         st->clk =3D devm_clk_get_enabled(&spi->dev, "adc-clk");
>         if (IS_ERR(st->clk))
>                 return PTR_ERR(st->clk);
> @@ -476,29 +522,39 @@ static int ad9467_probe(struct spi_device *spi)
>         if (ret)
>                 return ret;
>
> -       conv->chip_info =3D &info->axi_adc_info;
> -
> -       ret =3D ad9467_scale_fill(conv);
> +       ret =3D ad9467_scale_fill(st);
>         if (ret)
>                 return ret;
>
>         id =3D ad9467_spi_read(spi, AN877_ADC_REG_CHIP_ID);
> -       if (id !=3D conv->chip_info->id) {
> +       if (id !=3D st->info->id) {
>                 dev_err(&spi->dev, "Mismatch CHIP_ID, got 0x%X, expected =
0x%X\n",
> -                       id, conv->chip_info->id);
> +                       id, st->info->id);
>                 return -ENODEV;
>         }
>
> -       conv->reg_access =3D ad9467_reg_access;
> -       conv->write_raw =3D ad9467_write_raw;
> -       conv->read_raw =3D ad9467_read_raw;
> -       conv->read_avail =3D ad9467_read_avail;
> -       conv->preenable_setup =3D ad9467_preenable_setup;
> +       indio_dev->name =3D st->info->name;
> +       indio_dev->channels =3D st->info->channels;
> +       indio_dev->num_channels =3D st->info->num_channels;
> +       indio_dev->info =3D &ad9467_info;
> +
> +       ret =3D ad9467_buffer_get(indio_dev);
> +       if (ret)
> +               return ret;
>
> -       st->output_mode =3D info->default_output_mode |
> -                         AN877_ADC_OUTPUT_MODE_TWOS_COMPLEMENT;
> +       st->back =3D devm_iio_backend_get(&spi->dev, NULL);

Based on the descriptions given of IIO frontend and backend, I was
expecting this driver to be the backend since SPI is only used to
configure the chip while the adi-axi-adc driver is the one determining
the scan data format, providing the DMA (INDIO_BUFFER_HARDWARE), etc.

Also, from a devicetree "describe the hardware" mindset, it doesn't
seem like this chip (AD9467) should dictate a specific backend. I know
it doesn't make sense practlically for this chip to not use DMA given
the high sample rate, but why should the devicetree for this chip
require it when there is nothing intrensic about this chip itself
related to DMA?

> +       if (IS_ERR(st->back))
> +               return PTR_ERR(st->back);
>
> -       return 0;
> +       ret =3D iio_backend_enable(st->back);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D ad9467_setup(st);
> +       if (ret)
> +               return ret;
> +
> +       return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>
>  static const struct of_device_id ad9467_of_match[] =3D {
>
> --
> 2.42.1
>
>
