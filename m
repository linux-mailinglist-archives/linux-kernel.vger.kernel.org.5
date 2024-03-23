Return-Path: <linux-kernel+bounces-112494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC405887A8B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 22:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37A451F218D6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 21:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2CD5A7B4;
	Sat, 23 Mar 2024 21:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="A2X/pwDZ"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178FD946F
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 21:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711230814; cv=none; b=lPb/BDv/ZcHFdrdUnwSgpMvXHVbwnQgwUFCIjqN/9sE+OE0u0j2om8kI/ldFH6mZfkbjFgWQ1QvEdILeFLMOYZbVj7RYNcl9jnhJiYyszanLeQHsLMQUdeBkGcKpu5aEu2kCpb/Ti5UJlzeNtA5TtMHWtu4SVYO43Ax4lqhyXr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711230814; c=relaxed/simple;
	bh=jOqiy8+e5eHnAgVxkJWSknEr5M2YP1P1MzYi18pbGG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mZWocc1EqO9Y+jj6gBWZ3TdxaNX5xjoGuH16vJnhlR5+mUh+92ZTW8zklFSWfdYdy60NOX8L38TWpGHNN9NMktJdb89WeRw5zzYB7bYIv+CGDsLS+l/hIvaAG66vEDrQwIRos35sME30FiwYnQ6ejnqJ89UmzNfeKeLbzgoAcTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=A2X/pwDZ; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d41d1bedc9so61075751fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 14:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711230809; x=1711835609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FB2REDtNh54PPLbGC6FatOZph+1PMnwqPkJaaYXNOrk=;
        b=A2X/pwDZbSCdixhrVCRGZiuBYYRDtC/0c70fbKFfdaRpHMPJ48QyrCTERrFc6wTJ80
         U2vb2CT6Xf8P4oSJVxO3dOekjd0D7E2/sG4z6j+Rc0L3MKOVhbP5BLpprbdIkLwDobtd
         XZOKaCiF2cQrl5EMWGiOAYGn54+LWzv3ZYYS3OdgeJjjOKeM+m+Ei8g6nD9tZ5wrSGQU
         gebAd/3k+wEhT0JzX60jPDEFxdwccmcZeTgs+Y/zZMmk2LphBtXfqUgHXQC2ob4a1nq0
         Y9SmWJASshGhpJkObtZVjsySgvhyp2JQ4eKoUClUyFqtmviBGWfkOdhuWKlV4Z1HSkUX
         nhfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711230809; x=1711835609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FB2REDtNh54PPLbGC6FatOZph+1PMnwqPkJaaYXNOrk=;
        b=nfhK8pcBHf22aLn0OTmlnKFW9peqecuKoR9fxRO3dsJsE0CMzFps5ToGxUheSNrId+
         GOTArBt/bhWkzlZzoc5LUHoGU6X+aAl/FFffkF48/4RE/nfxPARp3S+HYsH1uzESUqGE
         Zs4255w3TzH3z1uCfyO5XTBiG+BctT974dKE2gax/H1XiwCICNmeAzm11Vx02l71675K
         XWBMZox9B9cFxeTTqlTO9A48H02d4O+i6AaSW0/RK/i3rpl+FZVWnuSlErOiZpz3K4Uq
         bpYFR1dba39yewZ9Sz1v6tmG2WM9z87NzC1WrGx6Wf0adcHwbOmFPBe670Mwyjx48ycj
         /KjA==
X-Forwarded-Encrypted: i=1; AJvYcCUNAm8lteZpJuDLwjr/n6lqZrLDS31wYggAZLjE82VRys9XVREmIhf6z1hJ0Zgjvyk2SsB0x+nwmD7AyTdyTYsYvTf10Fsa7s+qq0n9
X-Gm-Message-State: AOJu0Yw/jTZrEiR7odd6UG2IiZNfRnqiIiVrlGB9CCWiqbKe/y0hndHq
	7UIPTz0aMi6xIkZ0tjhMyijDfn51Gxvmp65Jpv0e1tnxZB7hfCnV4G5MJlXtAeAHmks+T1asV/x
	DXk7lu+EmF3MmJ6zeI+0p/JvR5yKtll7PwGPToQ==
X-Google-Smtp-Source: AGHT+IG9yqSGDK/N7j1RWjBwEx8uErwc/0S1zTKWfEGlldATXUsEn4c/6b9EGxkisch0O566u+siV2NpxBDg/b36ALQ=
X-Received: by 2002:a2e:6a04:0:b0:2d4:8d75:7a64 with SMTP id
 f4-20020a2e6a04000000b002d48d757a64mr2398816ljc.13.1711230809073; Sat, 23 Mar
 2024 14:53:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1711131830.git.marcelo.schmitt@analog.com> <15a70e55d7b6f0a97c4042bdaa41c2b672eb4f2f.1711131830.git.marcelo.schmitt@analog.com>
In-Reply-To: <15a70e55d7b6f0a97c4042bdaa41c2b672eb4f2f.1711131830.git.marcelo.schmitt@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 23 Mar 2024 16:53:17 -0500
Message-ID: <CAMknhBH7umcBD0hyt=6fOKu9E8k=CSrnNE4Z+9ynn0F4B=Wk2w@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: Add support for AD4000
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	marcelo.schmitt1@gmail.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 5:06=E2=80=AFPM Marcelo Schmitt
<marcelo.schmitt@analog.com> wrote:
>
> Add support for AD4000 series of high accuracy, high speed, low power,
> successive aproximation register (SAR) ADCs.
>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Pasting relevant comment from cover letter here to aid reviewers.
>
> Differently from AD7944, AD4000 devices have a configuration register to
> toggle some features. For instance, turbo mode is set through configurati=
on
> register rather than an external pin. This simplifies hardware connection=
s,
> but then requires software interface. So, additional ABI being proposed
> in sysfs-bus-iio-adc-ad4000. The one I'm most in doubt about is
> span_compression_en which affects the in_voltageY_scale attribute.
> That might be instead supported by providing _scale_available and allowin=
g write
> to _scale.
>
>  .../ABI/testing/sysfs-bus-iio-adc-ad4000      |  36 +
>  MAINTAINERS                                   |   2 +
>  drivers/iio/adc/Kconfig                       |  12 +
>  drivers/iio/adc/Makefile                      |   1 +
>  drivers/iio/adc/ad4000.c                      | 666 ++++++++++++++++++
>  5 files changed, 717 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4000
>  create mode 100644 drivers/iio/adc/ad4000.c
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4000 b/Documen=
tation/ABI/testing/sysfs-bus-iio-adc-ad4000
> new file mode 100644
> index 000000000000..98fb7539ad6d
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4000
> @@ -0,0 +1,36 @@
> +What:          /sys/bus/iio/devices/iio:deviceX/turbo_en
> +KernelVersion: 6.9
> +Contact:       linux-iio@vger.kernel.org
> +Description:
> +               This attribute is used to enable/disable turbo mode allow=
ing
> +               slower SPI clock rates (at a minimum SCK rate of 75 MHz) =
to
> +               achieve the maximum throughput of 2 MSPS.
> +
> +What:          /sys/bus/iio/devices/iio:deviceX/span_compression_en
> +KernelVersion: 6.9
> +Contact:       linux-iio@vger.kernel.org
> +Description:
> +               This attribute is used to enable/disable the input span
> +               compression feature that reduces the ADC input range by 1=
0% from
> +               the top and bottom of the range while still accessing all
> +               available ADC codes. Enabling span compression causes a
> +               decrease in ADC scale which is reflected in the channel
> +               in_voltageY_scale attribute.
> +
> +What:          /sys/bus/iio/devices/iio:deviceX/status_bits_en
> +KernelVersion: 6.9
> +Contact:       linux-iio@vger.kernel.org
> +Description:
> +               This attribute is used to make the chip append a 6-bit st=
atus
> +               word at the end of conversion results. The 6 status bits =
contain
> +               the configuration register fields for OV clamp flag, span
> +               compression, high-z mode, and turbo mode.
> +

I agree with Jonathan that the three attributes above are not needed
(for the reasons he mentioned).

> +What:          /sys/bus/iio/devices/iio:deviceX/high_impedance_en
> +KernelVersion: 6.9
> +Contact:       linux-iio@vger.kernel.org
> +Description:
> +               This attribute is used to enable/disable high impedance m=
ode
> +               (high-z) which reduces nonlinear charge kickback to the A=
DC
> +               input.
> +

As I mentioned in the DT patch, this one seems like it should be a DT
property, not a runtime setting.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3ca90f842298..2ae98c700ff0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1140,7 +1140,9 @@ M:        Marcelo Schmitt <marcelo.schmitt@analog.c=
om>
>  L:     linux-iio@vger.kernel.org
>  S:     Supported
>  W:     https://ez.analog.com/linux-software-drivers
> +F:     Documentation/ABI/testing/sysfs-bus-iio-adc-ad4000
>  F:     Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> +F:     drivers/iio/adc/ad4000.c
>
>  ANALOG DEVICES INC AD4130 DRIVER
>  M:     Cosmin Tanislav <cosmin.tanislav@analog.com>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 0d9282fa67f5..15db35f00ef0 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -21,6 +21,18 @@ config AD_SIGMA_DELTA
>         select IIO_BUFFER
>         select IIO_TRIGGERED_BUFFER
>
> +config AD4000
> +       tristate "Analog Devices AD4000 ADC Driver"
> +       depends on SPI
> +       select IIO_BUFFER
> +       select IIO_TRIGGERED_BUFFER
> +       help
> +         Say yes here to build support for Analog Devices AD4000 high sp=
eed
> +         SPI analog to digital converters (ADC).
> +
> +         To compile this driver as a module, choose M here: the module w=
ill be
> +         called ad4000.
> +
>  config AD4130
>         tristate "Analog Device AD4130 ADC Driver"
>         depends on SPI
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index b3c434722364..f535d617ae89 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -6,6 +6,7 @@
>  # When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_AB8500_GPADC) +=3D ab8500-gpadc.o
>  obj-$(CONFIG_AD_SIGMA_DELTA) +=3D ad_sigma_delta.o
> +obj-$(CONFIG_AD4000) +=3D ad4000.o
>  obj-$(CONFIG_AD4130) +=3D ad4130.o
>  obj-$(CONFIG_AD7091R) +=3D ad7091r-base.o
>  obj-$(CONFIG_AD7091R5) +=3D ad7091r5.o
> diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
> new file mode 100644
> index 000000000000..f77104755979
> --- /dev/null
> +++ b/drivers/iio/adc/ad4000.c
> @@ -0,0 +1,666 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * AD4000 SPI ADC driver
> + *
> + * Copyright 2024 Analog Devices Inc.
> + */
> +#include <asm/unaligned.h>
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/math.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/sysfs.h>
> +#include <linux/units.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +
> +#define AD400X_READ_COMMAND    0x54
> +#define AD400X_WRITE_COMMAND   0x14
> +
> +#define AD4000_CONFIG_REG_MSK  0xFF
> +
> +/* AD4000 Configuration Register programmable bits */
> +#define AD4000_STATUS          BIT(4) /* Status bits output */
> +#define AD4000_SPAN_COMP       BIT(3) /* Input span compression  */
> +#define AD4000_HIGHZ           BIT(2) /* High impedance mode  */
> +#define AD4000_TURBO           BIT(1) /* Turbo mode */
> +
> +#define AD4000_16BIT_MSK       GENMASK(31, 16)
> +#define AD4000_18BIT_MSK       GENMASK(31, 14)
> +#define AD4000_20BIT_MSK       GENMASK(31, 12)
> +
> +#define AD4000_CHANNEL(_sign, _real_bits)                              \
> +       {                                                               \
> +               .type =3D IIO_VOLTAGE,                                   =
 \
> +               .indexed =3D 1,                                          =
 \

Some chips are fully differential and some are pseudo-differential.
For the fully differential chips, I would expect

                .differential =3D 1,

As discussed on other recent drivers, psudo-differential are
differential =3D 0 though.

> +               .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |         =
 \
> +                                     BIT(IIO_CHAN_INFO_SCALE),         \
> +               .scan_type =3D {                                         =
 \
> +                       .sign =3D _sign,                                 =
 \
> +                       .realbits =3D _real_bits,                        =
 \
> +                       .storagebits =3D 32,                             =
 \
> +                       .endianness =3D IIO_BE,                          =
 \

I think this should be IIO_CPU and we should make use of
bits_per_word in the SPI xfers like we do in the ad7944 driver.
Otherwise, I think we might have difficutly to achieve max sample rate
for the 18 and 20-bit chips once we get SPI offload support added.

> +               },                                                      \
> +       }                                                               \
> +
> +enum ad4000_ids {
> +       ID_AD4000,
> +       ID_AD4001,
> +       ID_AD4002,
> +       ID_AD4003,
> +       ID_AD4004,
> +       ID_AD4005,
> +       ID_AD4006,
> +       ID_AD4007,
> +       ID_AD4008,
> +       ID_AD4010,
> +       ID_AD4011,
> +       ID_AD4020,
> +       ID_AD4021,
> +       ID_AD4022,
> +       ID_ADAQ4001,
> +       ID_ADAQ4003,
> +};

IMHO, these types of enums just make more work (noise) for people
reading the code and don't add anything useful.

> +
> +struct ad4000_chip_info {
> +       const char *dev_name;
> +       struct iio_chan_spec chan_spec;
> +};
> +
> +static const struct ad4000_chip_info ad4000_chips[] =3D {
> +       [ID_AD4000] =3D {
> +               .dev_name =3D "ad4000",
> +               .chan_spec =3D AD4000_CHANNEL('u', 16),
> +       },
> +       [ID_AD4001] =3D {
> +               .dev_name =3D "ad4001",
> +               .chan_spec =3D AD4000_CHANNEL('s', 16),
> +       },
> +       [ID_AD4002] =3D {
> +               .dev_name =3D "ad4002",
> +               .chan_spec =3D AD4000_CHANNEL('u', 18),
> +       },
> +       [ID_AD4003] =3D {
> +               .dev_name =3D "ad4003",
> +               .chan_spec =3D AD4000_CHANNEL('s', 18),
> +       },
> +       [ID_AD4004] =3D {
> +               .dev_name =3D "ad4004",
> +               .chan_spec =3D AD4000_CHANNEL('u', 16),
> +       },
> +       [ID_AD4005] =3D {
> +               .dev_name =3D "ad4005",
> +               .chan_spec =3D AD4000_CHANNEL('s', 16),
> +       },
> +       [ID_AD4006] =3D {
> +               .dev_name =3D "ad4006",
> +               .chan_spec =3D AD4000_CHANNEL('u', 18),
> +       },
> +       [ID_AD4007] =3D {
> +               .dev_name =3D "ad4007",
> +               .chan_spec =3D AD4000_CHANNEL('s', 18),
> +       },
> +       [ID_AD4008] =3D {
> +               .dev_name =3D "ad4008",
> +               .chan_spec =3D AD4000_CHANNEL('u', 16),
> +       },
> +       [ID_AD4010] =3D {
> +               .dev_name =3D "ad4010",
> +               .chan_spec =3D AD4000_CHANNEL('u', 18),
> +       },
> +       [ID_AD4011] =3D {
> +               .dev_name =3D "ad4011",
> +               .chan_spec =3D AD4000_CHANNEL('s', 18),
> +       },
> +       [ID_AD4020] =3D {
> +               .dev_name =3D "ad4020",
> +               .chan_spec =3D AD4000_CHANNEL('s', 20),
> +       },
> +       [ID_AD4021] =3D {
> +               .dev_name =3D "ad4021",
> +               .chan_spec =3D AD4000_CHANNEL('s', 20),
> +       },
> +       [ID_AD4022] =3D {
> +               .dev_name =3D "ad4022",
> +               .chan_spec =3D AD4000_CHANNEL('s', 20),
> +       },
> +       [ID_ADAQ4001] =3D {
> +               .dev_name =3D "adaq4001",
> +               .chan_spec =3D AD4000_CHANNEL('s', 16),
> +       },
> +       [ID_ADAQ4003] =3D {
> +               .dev_name =3D "adaq4003",
> +               .chan_spec =3D AD4000_CHANNEL('s', 18),
> +       },
> +};

As mentioned in my DT bindings reply, I think it would be helpful for
reviewers (and git history) to move adding ADAQ support to a separate
patch since they have some significant differences from the AD parts.

> +
> +enum ad4000_gains {
> +       AD4000_0454_GAIN =3D 0,
> +       AD4000_0909_GAIN =3D 1,
> +       AD4000_1_GAIN =3D 2,
> +       AD4000_1900_GAIN =3D 3,
> +       AD4000_GAIN_LEN
> +};
> +
> +/*
> + * Gains stored and computed as fractions to avoid introducing rounding =
erros.

spelling: errors

> + */
> +static const int ad4000_gains_frac[AD4000_GAIN_LEN][2] =3D {
> +       [AD4000_0454_GAIN] =3D { 227, 500 },
> +       [AD4000_0909_GAIN] =3D { 909, 1000 },
> +       [AD4000_1_GAIN] =3D { 1, 1 },
> +       [AD4000_1900_GAIN] =3D { 19, 10 },
> +};
> +
> +struct ad4000_state {
> +       struct spi_device *spi;
> +       struct gpio_desc *cnv_gpio;
> +       int vref;
> +       bool status_bits;
> +       bool span_comp;
> +       bool turbo_mode;
> +       bool high_z_mode;
> +
> +       enum ad4000_gains pin_gain;
> +       int scale_tbl[AD4000_GAIN_LEN][2];
> +
> +       /*
> +        * DMA (thus cache coherency maintenance) requires the
> +        * transfer buffers to live in their own cache lines.
> +        */
> +       union {
> +               struct {
> +                       u8 sample_buf[4];
> +                       s64 timestamp;

Usually we see __aligned(8) applied to the timestamp (I'm guessing
some archs need it?)

> +               } scan;
> +               u8 d8[2];
> +       } data __aligned(IIO_DMA_MINALIGN);
> +};
> +
> +static void ad4000_fill_scale_tbl(struct ad4000_state *st, int scale_bit=
s)
> +{
> +       int val, val2, tmp0, tmp1, i;
> +       u64 tmp2;
> +
> +       val2 =3D scale_bits;
> +       for (i =3D 0; i < AD4000_GAIN_LEN; i++) {
> +               val =3D st->vref / 1000;
> +               /* Multiply by MILLI here to avoid losing precision */
> +               val =3D mult_frac(val, ad4000_gains_frac[i][1] * MILLI,
> +                               ad4000_gains_frac[i][0]);
> +               /* Would multiply by NANO here but we already multiplied =
by MILLI */
> +               tmp2 =3D shift_right((u64)val * MICRO, val2);
> +               tmp0 =3D (int)div_s64_rem(tmp2, NANO, &tmp1);
> +               st->scale_tbl[i][0] =3D tmp0; /* Integer part */
> +               st->scale_tbl[i][1] =3D abs(tmp1); /* Fractional part */
> +       }
> +}
> +
> +static int ad4000_write_reg(struct ad4000_state *st, uint8_t val)
> +{
> +       struct spi_transfer t =3D {
> +               .tx_buf =3D st->data.d8,
> +               .len =3D 2,
> +       };
> +       struct spi_message m;
> +
> +       put_unaligned_be16(AD400X_WRITE_COMMAND << BITS_PER_BYTE | val, s=
t->data.d8);
> +
> +       spi_message_init(&m);
> +       spi_message_add_tail(&t, &m);
> +
> +       return spi_sync(st->spi, &m);
> +}
> +
> +static int ad4000_read_reg(struct ad4000_state *st, unsigned int *val)
> +{
> +       struct spi_transfer t =3D {0};
> +       struct spi_message m;
> +       int ret;
> +
> +       st->data.d8[0] =3D AD400X_READ_COMMAND;
> +
> +       t.rx_buf =3D st->data.d8;
> +       t.tx_buf =3D st->data.d8;
> +       t.len =3D 2;
> +
> +       spi_message_init_with_transfers(&m, &t, 1);
> +
> +       ret =3D spi_sync(st->spi, &m);
> +       if (ret < 0)
> +               return ret;
> +
> +       *val =3D FIELD_GET(AD4000_CONFIG_REG_MSK, get_unaligned_be16(st->=
data.d8));
> +
> +       return ret;
> +}
> +
> +static int ad4000_read_sample(struct ad4000_state *st, uint32_t *val)

As with the ad7944 driver, I would expect different handling for the
different SPI wiring modes. This looks like it only works with 4-wire
mode.

> +{
> +       struct spi_transfer t =3D {0};
> +       struct spi_message m;
> +       int ret;
> +
> +       t.rx_buf =3D &st->data.scan.sample_buf;
> +       t.len =3D 4;
> +       t.delay.value =3D 60;
> +       t.delay.unit =3D SPI_DELAY_UNIT_NSECS;
> +
> +       spi_message_init_with_transfers(&m, &t, 1);
> +
> +       if (st->cnv_gpio)
> +               gpiod_set_value_cansleep(st->cnv_gpio, GPIOD_OUT_HIGH);
> +
> +       ret =3D spi_sync(st->spi, &m);
> +       if (ret < 0)
> +               return ret;
> +
> +       if (st->cnv_gpio)
> +               gpiod_set_value_cansleep(st->cnv_gpio, GPIOD_OUT_LOW);
> +
> +       *val =3D get_unaligned_be32(&st->data.scan.sample_buf);
> +
> +       return 0;
> +}
> +
> +static int ad4000_single_conversion(struct iio_dev *indio_dev,
> +                                   const struct iio_chan_spec *chan, int=
 *val)
> +{
> +       struct ad4000_state *st =3D iio_priv(indio_dev);
> +       u32 sample;
> +       int ret;
> +
> +       ret =3D iio_device_claim_direct_mode(indio_dev);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D ad4000_read_sample(st, &sample);
> +
> +       iio_device_release_direct_mode(indio_dev);
> +
> +       if (ret)
> +               return ret;
> +
> +       switch (chan->scan_type.realbits) {
> +       case 16:
> +               sample =3D FIELD_GET(AD4000_16BIT_MSK, sample);
> +               break;
> +       case 18:
> +               sample =3D FIELD_GET(AD4000_18BIT_MSK, sample);
> +               break;
> +       case 20:
> +               sample =3D FIELD_GET(AD4000_20BIT_MSK, sample);
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       if (chan->scan_type.sign =3D=3D 's')
> +               *val =3D sign_extend32(sample, chan->scan_type.realbits -=
 1);
> +
> +       return IIO_VAL_INT;
> +}
> +
> +static int ad4000_read_raw(struct iio_dev *indio_dev,
> +                          struct iio_chan_spec const *chan, int *val,
> +                          int *val2, long info)
> +{
> +       struct ad4000_state *st =3D iio_priv(indio_dev);
> +
> +       switch (info) {
> +       case IIO_CHAN_INFO_RAW:
> +               return ad4000_single_conversion(indio_dev, chan, val);
> +       case IIO_CHAN_INFO_SCALE:
> +               *val =3D st->scale_tbl[st->pin_gain][0];
> +               *val2 =3D st->scale_tbl[st->pin_gain][1];
> +               if (st->span_comp)
> +                       *val2 =3D DIV_ROUND_CLOSEST(*val2 * 4, 5);
> +               return IIO_VAL_INT_PLUS_NANO;
> +       default:
> +               break;
> +       }
> +
> +       return -EINVAL;
> +}
> +

..

> +static irqreturn_t ad4000_trigger_handler(int irq, void *p)

I would expect different handling for the different SPI wiring modes here t=
oo.

> +{
> +       struct iio_poll_func *pf =3D p;
> +       struct iio_dev *indio_dev =3D pf->indio_dev;
> +       struct ad4000_state *st =3D iio_priv(indio_dev);
> +       struct spi_transfer t =3D {0};
> +       struct spi_message m;
> +       int ret;
> +
> +       t.rx_buf =3D &st->data.scan.sample_buf;
> +       t.len =3D 4;
> +       t.delay.value =3D 60;
> +       t.delay.unit =3D SPI_DELAY_UNIT_NSECS;
> +
> +       spi_message_init_with_transfers(&m, &t, 1);
> +
> +       if (st->cnv_gpio)
> +               gpiod_set_value(st->cnv_gpio, GPIOD_OUT_HIGH);
> +
> +       ret =3D spi_sync(st->spi, &m);
> +       if (ret < 0)
> +               goto err_out;
> +
> +       if (st->cnv_gpio)
> +               gpiod_set_value(st->cnv_gpio, GPIOD_OUT_LOW);
> +
> +       iio_push_to_buffers_with_timestamp(indio_dev, &st->data.scan,
> +                                          iio_get_time_ns(indio_dev));
> +
> +err_out:
> +       iio_trigger_notify_done(indio_dev->trig);
> +       return IRQ_HANDLED;
> +}
> +
> +static const struct iio_info ad4000_info =3D {
> +       .read_raw =3D &ad4000_read_raw,
> +       .attrs =3D &ad4000_attribute_group,
> +};
> +
> +static void ad4000_regulator_disable(void *reg)
> +{
> +       regulator_disable(reg);
> +}
> +
> +static int ad4000_probe(struct spi_device *spi)
> +{
> +       const struct ad4000_chip_info *chip;
> +       struct regulator *vref_reg;
> +       struct iio_dev *indio_dev;
> +       struct ad4000_state *st;
> +       int ret;
> +
> +       indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +       if (!indio_dev)
> +               return -ENOMEM;
> +
> +       chip =3D (const struct ad4000_chip_info *)device_get_match_data(&=
spi->dev);

Should this be spi_get_device_match_data()?

Also don't need the cast here.

> +       if (!chip)
> +               return -EINVAL;
> +
> +       st =3D iio_priv(indio_dev);
> +       st->spi =3D spi;
> +
> +       vref_reg =3D devm_regulator_get(&spi->dev, "vref");

This should to be devm_regulator_get_optional(), otherwise it can
return a "dummy" regulator if one is missing in the devicetree which
will fail when getting the voltage.

> +       if (IS_ERR(vref_reg))
> +               return dev_err_probe(&spi->dev, PTR_ERR(vref_reg),
> +                                    "Failed to get vref regulator\n");
> +
> +       ret =3D regulator_enable(vref_reg);
> +       if (ret < 0)
> +               return dev_err_probe(&spi->dev, ret,
> +                                    "Failed to enable voltage regulator\=
n");
> +
> +       ret =3D devm_add_action_or_reset(&spi->dev, ad4000_regulator_disa=
ble, vref_reg);
> +       if (ret)
> +               return dev_err_probe(&spi->dev, ret,
> +                                    "Failed to add regulator disable act=
ion\n");
> +
> +       st->vref =3D regulator_get_voltage(vref_reg);
> +       if (st->vref < 0)
> +               return dev_err_probe(&spi->dev, st->vref, "Failed to get =
vref\n");
> +
> +       if (!device_property_present(&spi->dev, "adi,spi-cs-mode")) {
> +               st->cnv_gpio =3D devm_gpiod_get(&spi->dev, "cnv", GPIOD_O=
UT_HIGH);
> +               if (IS_ERR(st->cnv_gpio)) {
> +                       if (PTR_ERR(st->cnv_gpio) =3D=3D -EPROBE_DEFER)
> +                               return -EPROBE_DEFER;
> +
> +                       return dev_err_probe(&spi->dev, PTR_ERR(st->cnv_g=
pio),
> +                                            "Failed to get CNV GPIO");
> +               }
> +       }

Since the DT bindings should be the same for the SPI wirting modes, we
should have the same property and logic as the ad7944 driver here.

> +
> +       indio_dev->name =3D chip->dev_name;
> +       indio_dev->info =3D &ad4000_info;
> +       indio_dev->channels =3D &chip->chan_spec;
> +       indio_dev->num_channels =3D 1;
> +
> +       if (device_property_present(&spi->dev, "adi,gain-milli")) {
> +               u32 val;
> +
> +               ret =3D device_property_read_u32(&spi->dev, "adi,gain-mil=
li", &val);
> +               if (ret)
> +                       return ret;
> +
> +               switch (val) {
> +               case 454:
> +                       st->pin_gain =3D AD4000_0454_GAIN;
> +                       break;
> +               case 909:
> +                       st->pin_gain =3D AD4000_0909_GAIN;
> +                       break;
> +               case 1000:
> +                       st->pin_gain =3D AD4000_1_GAIN;
> +                       break;
> +               case 1900:
> +                       st->pin_gain =3D AD4000_1900_GAIN;
> +                       break;
> +               default:
> +                       return dev_err_probe(&spi->dev, -EINVAL,
> +                                            "Invalid firmware provided g=
ain\n");
> +               }
> +       } else {
> +               st->pin_gain =3D AD4000_1_GAIN;
> +       }
> +
> +       /*
> +        * ADCs that output twos complement code have one less bit to exp=
ress
> +        * voltage magnitude.
> +        */
> +       if (chip->chan_spec.scan_type.sign =3D=3D 's')
> +               ad4000_fill_scale_tbl(st, chip->chan_spec.scan_type.realb=
its - 1);
> +       else
> +               ad4000_fill_scale_tbl(st, chip->chan_spec.scan_type.realb=
its);
> +

AFAICT, the gain stuff only applies to ADAQ chips, so it seems odd to
call this for all chips (and have the scale attribute report this for
chips that don't support it).

> +       ret =3D devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> +                                             &iio_pollfunc_store_time,
> +                                             &ad4000_trigger_handler, NU=
LL);
> +       if (ret)
> +               return ret;
> +
> +       return devm_iio_device_register(&spi->dev, indio_dev);
> +}
> +

..

