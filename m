Return-Path: <linux-kernel+bounces-137291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B4489E094
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97B0DB2B74C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9CA13D897;
	Tue,  9 Apr 2024 16:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYpMf4tM"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D6C3A1C7;
	Tue,  9 Apr 2024 16:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712678955; cv=none; b=Sn7nXKMIaw8/9PWJSc9QcyeK5TrXOp/1bas6AuhYqp3K5H4o/RUUSiMjkwN7TQ4rIb8biIQ9hJCUfGk1T0JwSzsM/ME3rWfdmBn5gAgNd9HGHrnm2Bse7+abGsu1Rnju+bOPqLJHJRgf3OgAZGchKvJTW7NUriZFG9QvrnlkC9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712678955; c=relaxed/simple;
	bh=H8UHTjKDRtZzROnTZYZdJN0hAjYq4JlYhqNR7TCyGFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6PpYhodIIzGWl8Ut3YkCwkp5j+KPkBGEACL6iQcdPw/5OUzY27aHGITt9j2Y9vx/o4HN+65ejh7Gd9oR0b165HjSPmZzjHjiaQxWQM5tRqInpt76JAInIEN1gHX5vCUxSInqKDcOmKA/s9OC9VS+oS5ESIPvTRcMie6OsXQeLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYpMf4tM; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ed112c64beso2470360b3a.1;
        Tue, 09 Apr 2024 09:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712678952; x=1713283752; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nI6tO54iKsM3F1EKzz0HWPaiHji+mdiQZu9UBjHR1lM=;
        b=cYpMf4tMrwMcj+QqpET3AT9vcFRL6NwYu7B+lchUAuhISBXfpS5Lwil03kECmljYnH
         vlAsAswqq1qv3h16e/pbpG2oxC+5Y4xZNWy6CJyttiYpBU35CkRv/HnZFsRp3iymrDJD
         BC2YqGf6D+DOBb9/iKLAWLNRHBqykzI/SEWOsXEQzbO1kLRR1wrW+AXsD6OwnQaHZ8j9
         dRM+5vN6iXllDPgUONO97q3f1ADGYoKIqNB9GlPJydYOTWSo+sG7PHVCuI9NDrEVu6jB
         Z9PuxZSbkC88bCv8GQ42/UiIsrevdnGEbIRLaPVn9o/657Vm6S7lEe3hOVrDTS7ZodNc
         lV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712678952; x=1713283752;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nI6tO54iKsM3F1EKzz0HWPaiHji+mdiQZu9UBjHR1lM=;
        b=kVbGhgOXkE9E4+TLzX4PTaUdj+uflmTG8KkZ38obf0v/ETB4p2tF7+RZu6sL7UsS7m
         6J+zlimtyG5X4/OdLTa3bxGWKdFnW3CEa3A0e2UYLy+NRjRPxFcHlf3HL8bLDwGGpwcH
         JYL1fadk8DKi61CK/NvaZT1ltDJLhI6qOOB7OpbS9U5ShvB7mraHYXkI/T4u1uM0vX9X
         LjXwWbXZO0hNEk1AJr9/SF7woFUVFXilexlfCF3TYW8vPbuNTzX9h0dmiA9jBshQlrUQ
         6FJPshiv7L2FHdpbbh3ESINdpTiInxq3wtvrJSvaOinpRSNR1DbC3lFhbA5pxaA6Dx//
         zvUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqk7H8k/sL55fvtdR0KzCzcBq+HhOQkHkqjewL3uXuQDmPJaQbMg3UHYeBQp8b1Sl58Z9cpfO2g02S9kKXAMapdk1wq3nGq4I6OrgM/vmsuUO3iIn5ZArpMDr6hgl9PjgNn0THM1eqVP9wcTt8jFxcEsqbOljKX0XUxTUXbOgkR8v0cA==
X-Gm-Message-State: AOJu0YyBThm+WEhr9rRycCzCDS7nKGoUHyaCgPosqtvMRk5wj61oTSgb
	hZhQQtynSwoduWzXkK5/ZrZyOpryBy493TeFCLZfwGcIGAzJFaVo
X-Google-Smtp-Source: AGHT+IHsQ7ezUXFYAhFCmPBcjpOH7HFPFgzTzqdJNdIlZo6ConAvqBxhnNjEoB4IdutGWra6haJaHw==
X-Received: by 2002:a05:6a21:6d89:b0:1a7:47b1:e8e2 with SMTP id wl9-20020a056a216d8900b001a747b1e8e2mr364861pzb.9.1712678952338;
        Tue, 09 Apr 2024 09:09:12 -0700 (PDT)
Received: from localhost ([2804:30c:1618:ed00:d152:440c:102b:144e])
        by smtp.gmail.com with ESMTPSA id fs22-20020a17090af29600b0029ddac03effsm10118885pjb.11.2024.04.09.09.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 09:09:11 -0700 (PDT)
Date: Tue, 9 Apr 2024 13:09:50 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: Add support for AD4000
Message-ID: <ZhVoTi2amNTOJ4eS@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1712585500.git.marcelo.schmitt@analog.com>
 <1d95d7d023dad69b894a2d0e7b0bad9d569ae382.1712585500.git.marcelo.schmitt@analog.com>
 <CAMknhBEMDg3YF5pvoKJ-6y0Y5OJpmBthWfogCjy90B=F84SvzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMknhBEMDg3YF5pvoKJ-6y0Y5OJpmBthWfogCjy90B=F84SvzA@mail.gmail.com>

On 04/08, David Lechner wrote:
> On Mon, Apr 8, 2024 at 9:32 AM Marcelo Schmitt
> <marcelo.schmitt@analog.com> wrote:
> >
> > Add support for AD4000 family of low noise, low power, high speed,
> > successive aproximation register (SAR) ADCs.
> >
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> >  MAINTAINERS              |   1 +
> >  drivers/iio/adc/Kconfig  |  12 +
> >  drivers/iio/adc/Makefile |   1 +
> >  drivers/iio/adc/ad4000.c | 649 +++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 663 insertions(+)
> >  create mode 100644 drivers/iio/adc/ad4000.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 5dfe118a5dd3..86aa96115f5a 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1165,6 +1165,7 @@ L:        linux-iio@vger.kernel.org
> >  S:     Supported
> >  W:     https://ez.analog.com/linux-software-drivers
> >  F:     Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> > +F:     drivers/iio/adc/ad4000.c
> >
> >  ANALOG DEVICES INC AD4130 DRIVER
> >  M:     Cosmin Tanislav <cosmin.tanislav@analog.com>
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index 8db68b80b391..9c9d13d4b74f 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -21,6 +21,18 @@ config AD_SIGMA_DELTA
> >         select IIO_BUFFER
> >         select IIO_TRIGGERED_BUFFER
> >
> > +config AD4000
> > +       tristate "Analog Devices AD4000 ADC Driver"
> > +       depends on SPI
> > +       select IIO_BUFFER
> > +       select IIO_TRIGGERED_BUFFER
> > +       help
> > +         Say yes here to build support for Analog Devices AD4000 high speed
> > +         SPI analog to digital converters (ADC).
> > +
> > +         To compile this driver as a module, choose M here: the module will be
> > +         called ad4000.
> > +
> >  config AD4130
> >         tristate "Analog Device AD4130 ADC Driver"
> >         depends on SPI
> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > index edb32ce2af02..aa52068d864b 100644
> > --- a/drivers/iio/adc/Makefile
> > +++ b/drivers/iio/adc/Makefile
> > @@ -6,6 +6,7 @@
> >  # When adding new entries keep the list in alphabetical order
> >  obj-$(CONFIG_AB8500_GPADC) += ab8500-gpadc.o
> >  obj-$(CONFIG_AD_SIGMA_DELTA) += ad_sigma_delta.o
> > +obj-$(CONFIG_AD4000) += ad4000.o
> >  obj-$(CONFIG_AD4130) += ad4130.o
> >  obj-$(CONFIG_AD7091R) += ad7091r-base.o
> >  obj-$(CONFIG_AD7091R5) += ad7091r5.o
> > diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
> > new file mode 100644
> > index 000000000000..7997d9d98743
> > --- /dev/null
> > +++ b/drivers/iio/adc/ad4000.c
> > @@ -0,0 +1,649 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * AD4000 SPI ADC driver
> > + *
> > + * Copyright 2024 Analog Devices Inc.
> > + */
> > +#include <asm/unaligned.h>
> > +#include <linux/bits.h>
> > +#include <linux/bitfield.h>
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/kernel.h>
> > +#include <linux/math.h>
> > +#include <linux/module.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/spi/spi.h>
> > +#include <linux/sysfs.h>
> > +#include <linux/units.h>
> > +#include <linux/util_macros.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +#include <linux/iio/trigger_consumer.h>
> > +
> > +#define AD400X_READ_COMMAND    0x54
> > +#define AD400X_WRITE_COMMAND   0x14
> > +
> > +/* AD4000 Configuration Register programmable bits */
> > +#define AD4000_STATUS          BIT(4) /* Status bits output */
> > +#define AD4000_SPAN_COMP       BIT(3) /* Input span compression  */
> > +#define AD4000_HIGHZ           BIT(2) /* High impedance mode  */
> > +#define AD4000_TURBO           BIT(1) /* Turbo mode */
> 
> Usually bits of the same register share a similar prefix, e.g.
> AD4000_CFG_TURBO, AD4000_CFG_HIGHZ, etc.

This only has one register, but if this makes things look better will do it.

> 
> > +
> > +#define AD4000_TQUIET2_NS              60
> > +
> > +#define AD4000_18BIT_MSK       GENMASK(31, 14)
> > +#define AD4000_20BIT_MSK       GENMASK(31, 12)
> > +
> > +#define AD4000_DIFF_CHANNEL(_sign, _real_bits)                         \
> > +       {                                                               \
> > +               .type = IIO_VOLTAGE,                                    \
> > +               .indexed = 1,                                           \
> > +               .differential = 1,                                      \
> > +               .channel = 0,                                           \
> > +               .channel2 = 1,                                          \
> > +               .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |          \
> > +                                     BIT(IIO_CHAN_INFO_SCALE),         \
> > +               .info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),\
> > +               .scan_type = {                                          \
> > +                       .sign = _sign,                                  \
> > +                       .realbits = _real_bits,                         \
> > +                       .storagebits = _real_bits > 16 ? 32 : 16,       \
> > +                       .shift = _real_bits > 16 ? 32 - _real_bits : 0, \
> > +                       .endianness = IIO_BE,                           \
> > +               },                                                      \
> > +       }                                                               \
> > +
> > +#define AD4000_PSEUDO_DIFF_CHANNEL(_sign, _real_bits)                  \
> > +       {                                                               \
> > +               .type = IIO_VOLTAGE,                                    \
> > +               .indexed = 1,                                           \
> > +               .channel = 0,                                           \
> > +               .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |          \
> > +                                     BIT(IIO_CHAN_INFO_SCALE) |        \
> > +                                     BIT(IIO_CHAN_INFO_OFFSET),        \
> > +               .info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),\
> > +               .scan_type = {                                          \
> > +                       .sign = _sign,                                  \
> > +                       .realbits = _real_bits,                         \
> > +                       .storagebits = _real_bits > 16 ? 32 : 16,       \
> > +                       .shift = _real_bits > 16 ? 32 - _real_bits : 0, \
> > +                       .endianness = IIO_BE,                           \
> > +               },                                                      \
> > +       }                                                               \
> 
> It looks like all differential chips are signed and all
> pseduo-differential chips are unsigned, so I don't think we need the
> _sign parameter in these macros.

That's correct, the _sign param can be removed after the split of channel macros.
Will do it for v3.

> 
> I also still have doubts about using IIO_BE and 8-bit xfers when it
> comes to adding support later to achieve max sample rate with a SPI
> offload. For example to get 2MSPS with an 18-bit chip, it will require
> an approx 33% faster SPI clock than the actual slowest clock possible
> because it will have to read 6 extra bits per sample. I didn't check
> the specs, but this may not even be physically possible without
> exceeding the datasheet max SPI clock rate. Also errors could be
> reduced if we could actually use the slowest allowable SPI clock rate.
> Furthermore, the offload hardware would have to be capable of adding
> an extra byte per sample for 18 and 20-bit chips when piping the data
> to DMA in order to get the 32-bit alignment in the buffer required by
> IIO scan_type and the natural alignment requirements of IIO buffers in
> general.

Maybe I should already implement support for reading with SPI offload
rather than doing it after this set is merged?
So we can test what happens at faster sample rates before we commit to a solution.

> 
> > +
> > +enum ad4000_ids {
> > +       ID_AD4000,
> > +       ID_AD4001,
> > +       ID_AD4002,
> > +       ID_AD4003,
> > +       ID_AD4004,
> > +       ID_AD4005,
> > +       ID_AD4006,
> > +       ID_AD4007,
> > +       ID_AD4008,
> > +       ID_AD4010,
> > +       ID_AD4011,
> > +       ID_AD4020,
> > +       ID_AD4021,
> > +       ID_AD4022,
> > +       ID_ADAQ4001,
> > +       ID_ADAQ4003,
> > +};
> > +
> > +struct ad4000_chip_info {
> > +       const char *dev_name;
> > +       struct iio_chan_spec chan_spec;
> > +};
> > +
> > +static const struct ad4000_chip_info ad4000_chips[] = {
> > +       [ID_AD4000] = {
> > +               .dev_name = "ad4000",
> > +               .chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16),
> > +       },
> > +       [ID_AD4001] = {
> > +               .dev_name = "ad4001",
> > +               .chan_spec = AD4000_DIFF_CHANNEL('s', 16),
> > +       },
> > +       [ID_AD4002] = {
> > +               .dev_name = "ad4002",
> > +               .chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 18),
> > +       },
> > +       [ID_AD4003] = {
> > +               .dev_name = "ad4003",
> > +               .chan_spec = AD4000_DIFF_CHANNEL('s', 18),
> > +       },
> > +       [ID_AD4004] = {
> > +               .dev_name = "ad4004",
> > +               .chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16),
> > +       },
> > +       [ID_AD4005] = {
> > +               .dev_name = "ad4005",
> > +               .chan_spec = AD4000_DIFF_CHANNEL('s', 16),
> > +       },
> > +       [ID_AD4006] = {
> > +               .dev_name = "ad4006",
> > +               .chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 18),
> > +       },
> > +       [ID_AD4007] = {
> > +               .dev_name = "ad4007",
> > +               .chan_spec = AD4000_DIFF_CHANNEL('s', 18),
> > +       },
> > +       [ID_AD4008] = {
> > +               .dev_name = "ad4008",
> > +               .chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16),
> > +       },
> > +       [ID_AD4010] = {
> > +               .dev_name = "ad4010",
> > +               .chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 18),
> > +       },
> > +       [ID_AD4011] = {
> > +               .dev_name = "ad4011",
> > +               .chan_spec = AD4000_DIFF_CHANNEL('s', 18),
> > +       },
> > +       [ID_AD4020] = {
> > +               .dev_name = "ad4020",
> > +               .chan_spec = AD4000_DIFF_CHANNEL('s', 20),
> > +       },
> > +       [ID_AD4021] = {
> > +               .dev_name = "ad4021",
> > +               .chan_spec = AD4000_DIFF_CHANNEL('s', 20),
> > +       },
> > +       [ID_AD4022] = {
> > +               .dev_name = "ad4022",
> > +               .chan_spec = AD4000_DIFF_CHANNEL('s', 20),
> > +       },
> > +       [ID_ADAQ4001] = {
> > +               .dev_name = "adaq4001",
> > +               .chan_spec = AD4000_DIFF_CHANNEL('s', 16),
> > +       },
> > +       [ID_ADAQ4003] = {
> > +               .dev_name = "adaq4003",
> > +               .chan_spec = AD4000_DIFF_CHANNEL('s', 18),
> > +       },
> > +};
> > +
> > +enum ad4000_gains {
> > +       AD4000_0454_GAIN = 0,
> > +       AD4000_0909_GAIN = 1,
> > +       AD4000_1_GAIN = 2,
> 
> AD4000_1000_GAIN would be more consistent with the others.

Ack

> 
> > +       AD4000_1900_GAIN = 3,
> > +       AD4000_GAIN_LEN
> > +};
> > +
> > +/*
> > + * Gains stored and computed as fractions to avoid introducing rounding errors.
> > + */
> > +static const int ad4000_gains_frac[AD4000_GAIN_LEN][2] = {
> > +       [AD4000_0454_GAIN] = { 227, 500 },
> > +       [AD4000_0909_GAIN] = { 909, 1000 },
> > +       [AD4000_1_GAIN] = { 1, 1 },
> > +       [AD4000_1900_GAIN] = { 19, 10 },
> > +};
> 
> Why not just store the numerator in milli units and always use 1000
> for the denominator? It seems like it would simplify the code and make
> it easier to read and understand. Also, these values are coming from
> the adi,gain-milli property already, so we could avoid the enum and
> the lookup table entirely and simplify things even more.

Makes sense. Will do it.

> 
> > +
> > +struct ad4000_state {
> > +       struct spi_device *spi;
> > +       struct gpio_desc *cnv_gpio;
> > +       int vref;
> > +       bool status_bits;
> > +       bool span_comp;
> > +       bool turbo_mode;
> > +       bool high_z_mode;
> > +
> > +       enum ad4000_gains pin_gain;
> > +       int scale_tbl[AD4000_GAIN_LEN][2][2];
> > +
> > +       /*
> > +        * DMA (thus cache coherency maintenance) requires the
> > +        * transfer buffers to live in their own cache lines.
> > +        */
> > +       struct {
> > +               union {
> > +                       u16 sample_buf16;
> > +                       u32 sample_buf32;
> 
> Technically, these are holding big-endian data, so __be16 and __be32
> would be more correct.

Ack

> 
> > +               } data;
> > +               s64 timestamp __aligned(8);
> > +       } scan;
> > +       __be16 tx_buf __aligned(IIO_DMA_MINALIGN);
> > +       __be16 rx_buf;
> > +};
> 
> scan.data is used as SPI rx_buf so __aligned(IIO_DMA_MINALIGN); needs
> to be moved to the scan field.

I have already tried it. Maybe I did something wrong besides buffer alignment
at that time. Will give it another try.

> 
> > +
> > +static void ad4000_fill_scale_tbl(struct ad4000_state *st, int scale_bits,
> > +                                 const struct ad4000_chip_info *chip)
> > +{
> > +       int diff = chip->chan_spec.differential;
> > +       int val, val2, tmp0, tmp1, i;
> > +       u64 tmp2;
> > +
> > +       val2 = scale_bits;
> > +       for (i = 0; i < AD4000_GAIN_LEN; i++) {
> 
> Only one gain is selected by the devicetree, so why do we need to do
> this for all 4 gains?
> 

Good point. Will think better how to simplify this.

> > +               val = st->vref / 1000;
> > +               /* Multiply by MILLI here to avoid losing precision */
> > +               val = mult_frac(val, ad4000_gains_frac[i][1] * MILLI,
> > +                               ad4000_gains_frac[i][0]);
> > +               /* Would multiply by NANO here but we already multiplied by MILLI */
> > +               tmp2 = shift_right((u64)val * MICRO, val2);
> > +               tmp0 = (int)div_s64_rem(tmp2, NANO, &tmp1);
> > +               /* Store scale for when span compression is disabled */
> > +               st->scale_tbl[i][0][0] = tmp0; /* Integer part */
> > +               st->scale_tbl[i][0][1] = abs(tmp1); /* Fractional part */
> > +               /* Store scale for when span compression is enabled */
> > +               st->scale_tbl[i][1][0] = tmp0;
> > +               if (diff)
> > +                       st->scale_tbl[i][1][1] = DIV_ROUND_CLOSEST(abs(tmp1) * 4, 5);
> > +               else
> > +                       st->scale_tbl[i][1][1] = DIV_ROUND_CLOSEST(abs(tmp1) * 9, 10);
> > +       }
> > +}
> > +
> > +static int ad4000_write_reg(struct ad4000_state *st, uint8_t val)
> > +{
> > +       put_unaligned_be16(AD400X_WRITE_COMMAND << BITS_PER_BYTE | val,
> > +                          &st->tx_buf);
> > +       return spi_write(st->spi, &st->tx_buf, 2);
> > +}
> > +
> > +static int ad4000_read_reg(struct ad4000_state *st, unsigned int *val)
> > +{
> > +       struct spi_transfer t[] = {
> > +               {
> > +                       .tx_buf = &st->tx_buf,
> > +                       .rx_buf = &st->rx_buf,
> > +                       .len = 2,
> > +               },
> > +       };
> > +       int ret;
> > +
> > +       put_unaligned_be16(AD400X_READ_COMMAND << BITS_PER_BYTE, &st->tx_buf);
> > +       ret = spi_sync_transfer(st->spi, t, ARRAY_SIZE(t));
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       *val = get_unaligned_be16(&st->rx_buf);
> > +
> > +       return ret;
> > +}
> > +
> 
> It would be very helpful to have comments here explaining the exact
> expected wiring configuration and signal timing here since there are
> so many possibilities for this chip.
> 

Ok, will be spliting this into different handling for the wiring modes so
will add comments to make clear what supports each configuration.

> > +static int ad4000_read_sample(struct ad4000_state *st,
> > +                             const struct iio_chan_spec *chan)
> > +{
> > +       struct spi_transfer t[] = {
> 
> Don't really need [] here since there is only one xfer.
> 
Ack

> > +               {
> > +                       .rx_buf = &st->scan.data,
> > +                       .len = BITS_TO_BYTES(chan->scan_type.storagebits),
> > +                       .delay = {
> > +                               .value = AD4000_TQUIET2_NS,
> > +                               .unit = SPI_DELAY_UNIT_NSECS,
> > +                       },
> > +               },
> > +       };
> > +       int ret;
> > +
> > +       ret = spi_sync_transfer(st->spi, t, ARRAY_SIZE(t));
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       return 0;
> > +}
> > +
> > +static int ad4000_single_conversion(struct iio_dev *indio_dev,
> > +                                   const struct iio_chan_spec *chan, int *val)
> > +{
> > +       struct ad4000_state *st = iio_priv(indio_dev);
> > +       u32 sample;
> > +       int ret;
> > +
> > +       if (st->cnv_gpio)
> > +               gpiod_set_value_cansleep(st->cnv_gpio, GPIOD_OUT_HIGH);
> 
> It would make more sense and be less redundant to move the gpio code
> into ad4000_read_sample().
> 
> Also, gpiod_set_value_cansleep() checks for NULL, so the if () is redundant.
> 
Good point. I think the execution flow migth change a bit here but will try
to avoid things like that.

> > +
> > +       ret = ad4000_read_sample(st, chan);
> > +       if (ret)
> > +               return ret;
> > +
> > +       if (st->cnv_gpio)
> > +               gpiod_set_value_cansleep(st->cnv_gpio, GPIOD_OUT_LOW);
> > +
> > +       if (chan->scan_type.storagebits > 16)
> > +               sample = get_unaligned_be32(&st->scan.data);
> > +       else
> > +               sample = get_unaligned_be16(&st->scan.data);
> 
> data is aligned, so be32/16_to_cpu() should be fine. Also, Jonathan
> will suggest to use &st->scan.data.sample_b32/16 here too. :-)

Ack
> 
> > +
> > +       switch (chan->scan_type.realbits) {
> > +       case 16:
> > +               break;
> > +       case 18:
> > +               sample = FIELD_GET(AD4000_18BIT_MSK, sample);
> > +               break;
> > +       case 20:
> > +               sample = FIELD_GET(AD4000_20BIT_MSK, sample);
> > +               break;
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +
> > +       if (chan->scan_type.sign == 's')
> > +               *val = sign_extend32(sample, chan->scan_type.realbits - 1);
> > +
> > +       return IIO_VAL_INT;
> > +}
> > +
> > +static int ad4000_read_raw(struct iio_dev *indio_dev,
> > +                          struct iio_chan_spec const *chan, int *val,
> > +                          int *val2, long info)
> > +{
> > +       struct ad4000_state *st = iio_priv(indio_dev);
> > +
> > +       switch (info) {
> > +       case IIO_CHAN_INFO_RAW:
> > +               iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
> > +                       return ad4000_single_conversion(indio_dev, chan, val);
> > +               unreachable();
> > +       case IIO_CHAN_INFO_SCALE:
> > +               *val = st->scale_tbl[st->pin_gain][st->span_comp][0];
> > +               *val2 = st->scale_tbl[st->pin_gain][st->span_comp][1];
> > +               return IIO_VAL_INT_PLUS_NANO;
> > +       case IIO_CHAN_INFO_OFFSET:
> > +               *val = 0;
> > +               if (st->span_comp)
> > +                       *val = mult_frac(st->vref / 1000, 1, 10);
> > +
> > +               return IIO_VAL_INT;
> > +       default:
> > +               break;
> > +       }
> > +
> > +       return -EINVAL;
> > +}
> > +
> > +static int ad4000_read_avail(struct iio_dev *indio_dev,
> > +                            struct iio_chan_spec const *chan,
> > +                            const int **vals, int *type, int *length,
> > +                            long info)
> > +{
> > +       struct ad4000_state *st = iio_priv(indio_dev);
> > +
> > +       switch (info) {
> > +       case IIO_CHAN_INFO_SCALE:
> > +               *vals = (int *)st->scale_tbl[st->pin_gain];
> > +               *length = 2 * 2;
> > +               *type = IIO_VAL_INT_PLUS_NANO;
> > +               return IIO_AVAIL_LIST;
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +}
> > +
> > +static int ad4000_write_raw_get_fmt(struct iio_dev *indio_dev,
> > +                                   struct iio_chan_spec const *chan, long mask)
> > +{
> > +       switch (mask) {
> > +       case IIO_CHAN_INFO_SCALE:
> > +               return IIO_VAL_INT_PLUS_NANO;
> > +       default:
> > +               return IIO_VAL_INT_PLUS_MICRO;
> > +       }
> > +       return -EINVAL;
> 
> not reachable because of default, so can be left out
> 
Ack

> > +}
> > +
> > +static int ad4000_write_raw(struct iio_dev *indio_dev,
> > +                           struct iio_chan_spec const *chan, int val, int val2,
> > +                           long mask)
> > +{
> > +       struct ad4000_state *st = iio_priv(indio_dev);
> > +       unsigned int reg_val;
> > +       bool span_comp_en;
> > +       int ret;
> > +
> > +       switch (mask) {
> > +       case IIO_CHAN_INFO_SCALE:
> > +               iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> > +                       ret = ad4000_read_reg(st, &reg_val);
> > +                       if (ret < 0)
> > +                               return ret;
> > +
> > +                       span_comp_en = (val2 == st->scale_tbl[st->pin_gain][1][1]);
> > +                       reg_val &= ~AD4000_SPAN_COMP;
> > +                       reg_val |= FIELD_PREP(AD4000_SPAN_COMP, span_comp_en);
> > +
> > +                       ret = ad4000_write_reg(st, reg_val);
> > +                       if (ret < 0)
> > +                               return ret;
> > +
> > +                       st->span_comp = span_comp_en;
> > +                       return 0;
> > +               }
> > +               unreachable();
> 
> Can bring out the return 0 to avoid unreachable.

Ack
> 
> > +       default:
> > +               break;
> 
> Can return -EINVAL to avoid break;
> 
Ack

> > +       }
> > +
> > +       return -EINVAL;
> > +}
> > +
> > +static irqreturn_t ad4000_trigger_handler(int irq, void *p)
> > +{
> > +       struct iio_poll_func *pf = p;
> > +       struct iio_dev *indio_dev = pf->indio_dev;
> > +       struct ad4000_state *st = iio_priv(indio_dev);
> > +       int ret;
> > +
> > +       if (st->cnv_gpio)
> > +               gpiod_set_value(st->cnv_gpio, GPIOD_OUT_HIGH);
> > +
> > +       ret = ad4000_read_sample(st, &indio_dev->channels[0]);
> > +       if (ret < 0)
> > +               goto err_out;
> > +
> > +       if (st->cnv_gpio)
> > +               gpiod_set_value(st->cnv_gpio, GPIOD_OUT_LOW);
> > +
> > +       iio_push_to_buffers_with_timestamp(indio_dev, &st->scan,
> > +                                          iio_get_time_ns(indio_dev));
> > +
> > +err_out:
> > +       iio_trigger_notify_done(indio_dev->trig);
> > +       return IRQ_HANDLED;
> > +}
> > +
> > +static const struct iio_info ad4000_info = {
> > +       .read_raw = &ad4000_read_raw,
> > +       .read_avail = &ad4000_read_avail,
> > +       .write_raw = &ad4000_write_raw,
> > +       .write_raw_get_fmt = &ad4000_write_raw_get_fmt,
> > +};
> > +
> > +static void ad4000_config(struct ad4000_state *st)
> > +{
> > +       unsigned int reg_val;
> > +       int ret;
> > +
> > +       reg_val = FIELD_PREP(AD4000_TURBO, 1);
> 
> Since the driver in it's current state can get anywhere near the max
> sample rate of ~1MSPS, I don't think it makes sense to enable turbo at
> this point.
> 

This is just enabling turbo at start up. If not enabling turbo during probe,
we would want(need?) to provide some interface for that, which might not be
much desired.

> > +
> > +       if (device_property_present(&st->spi->dev, "adi,high-z-input"))
> > +               reg_val |= FIELD_PREP(AD4000_HIGHZ, 1);
> > +
> > +       /*
> > +        * The ADC SDI pin might be connected to controller CS line in which
> > +        * case the write might fail. This, however, does not prevent the device
> > +        * from functioning even though in a configuration other than the
> > +        * requested one.
> > +        */
> > +       ret = ad4000_write_reg(st, reg_val);
> > +       if (ret < 0)
> > +               dev_dbg(&st->spi->dev, "Failed to config device\n");
> 
> If writing fails because there is no CS line wired up, we won't get an
> error returned here. The SPI controller has no way of knowing this
> happened, so it can only assume the write was successful and return 0.
> So this should return ret.
> 
Ok, ack.

> Ideally, the devicetree should tell us if CS is wired up or not.
> 
> > +}
> > +
> > +static void ad4000_regulator_disable(void *reg)
> > +{
> > +       regulator_disable(reg);
> > +}
> > +
> > +static int ad4000_probe(struct spi_device *spi)
> > +{
> > +       const struct ad4000_chip_info *chip;
> > +       struct regulator *vref_reg;
> > +       struct iio_dev *indio_dev;
> > +       struct ad4000_state *st;
> > +       int ret;
> 
> We need a check somewhere in here to make sure that adi,spi-mode is in
> a supported configuration. E.g. chain mode is not currently
> implemented.

ok, will add that.

> 
> > +
> > +       indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> > +       if (!indio_dev)
> > +               return -ENOMEM;
> > +
> > +       chip = spi_get_device_match_data(spi);
> > +       if (!chip)
> > +               return -EINVAL;
> > +
> > +       st = iio_priv(indio_dev);
> > +       st->spi = spi;
> > +
> > +       ret = devm_regulator_get_enable(&spi->dev, "vdd");
> > +       if (ret)
> > +               return dev_err_probe(&spi->dev, ret, "Failed to enable VDD supply\n");
> > +
> > +       ret = devm_regulator_get_enable(&spi->dev, "vio");
> > +       if (ret)
> > +               return dev_err_probe(&spi->dev, ret, "Failed to enable VIO supply\n");
> > +
> > +       vref_reg = devm_regulator_get(&spi->dev, "ref");
> > +       if (IS_ERR(vref_reg))
> > +               return dev_err_probe(&spi->dev, PTR_ERR(vref_reg),
> > +                                    "Failed to get vref regulator\n");
> > +
> > +       ret = regulator_enable(vref_reg);
> > +       if (ret < 0)
> > +               return dev_err_probe(&spi->dev, ret,
> > +                                    "Failed to enable voltage regulator\n");
> > +
> > +       ret = devm_add_action_or_reset(&spi->dev, ad4000_regulator_disable, vref_reg);
> > +       if (ret)
> > +               return dev_err_probe(&spi->dev, ret,
> > +                                    "Failed to add regulator disable action\n");
> > +
> > +       st->vref = regulator_get_voltage(vref_reg);
> > +       if (st->vref < 0)
> > +               return dev_err_probe(&spi->dev, st->vref, "Failed to get vref\n");
> > +
> > +       st->cnv_gpio = devm_gpiod_get_optional(&spi->dev, "cnv", GPIOD_OUT_HIGH);
> > +       if (IS_ERR(st->cnv_gpio)) {
> > +               if (PTR_ERR(st->cnv_gpio) == -EPROBE_DEFER)
> > +                       return -EPROBE_DEFER;
> 
> EPROBE_DEFER check is not needed with dev_err_probe();, it already does that.

Ack
> 
> 
> > +
> > +               return dev_err_probe(&spi->dev, PTR_ERR(st->cnv_gpio),
> > +                                    "Failed to get CNV GPIO");
> > +       }
> > +
> > +       ad4000_config(st);
> > +
> > +       indio_dev->name = chip->dev_name;
> > +       indio_dev->info = &ad4000_info;
> > +       indio_dev->channels = &chip->chan_spec;
> > +       indio_dev->num_channels = 1;
> > +
> > +       st->pin_gain = AD4000_1_GAIN;
> > +       if (device_property_present(&spi->dev, "adi,gain-milli")) {
> > +               u32 val;
> 
> Should it be an error if adi,gain-milli is set on non-adaq chips?

Maybe. We should not change the scale if it's a chip that don't have the
amplifier in front of the ADC. I think the best handling would be to just
ignore adi,gain-milli if it's not an ADAQ device. Maybe better add a DT
constraint,
  - if:
      properties:
        compatible:
          contains:
            enum:
              - adi,adaq4001
              - adi,adaq4003
    then:
      properties:
        adi,gain-milli: false
?

> 
> > +
> > +               ret = device_property_read_u32(&spi->dev, "adi,gain-milli", &val);
> > +               if (ret)
> > +                       return ret;
> > +
> > +               switch (val) {
> > +               case 454:
> > +                       st->pin_gain = AD4000_0454_GAIN;
> > +                       break;
> > +               case 909:
> > +                       st->pin_gain = AD4000_0909_GAIN;
> > +                       break;
> > +               case 1000:
> > +                       st->pin_gain = AD4000_1_GAIN;
> > +                       break;
> > +               case 1900:
> > +                       st->pin_gain = AD4000_1900_GAIN;
> > +                       break;
> > +               default:
> > +                       return dev_err_probe(&spi->dev, -EINVAL,
> > +                                            "Invalid firmware provided gain\n");
> 
> Could help debugging if val is included in the error message.

Ack
> 
> 
> > +               }
> > +       }
> > +
> > +       /*
> > +        * ADCs that output twos complement code have one less bit to express
> > +        * voltage magnitude.
> > +        */
> > +       if (chip->chan_spec.scan_type.sign == 's')
> > +               ad4000_fill_scale_tbl(st, chip->chan_spec.scan_type.realbits - 1,
> > +                                     chip);
> > +       else
> > +               ad4000_fill_scale_tbl(st, chip->chan_spec.scan_type.realbits,
> > +                                     chip);
> > +
> > +       ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> > +                                             &iio_pollfunc_store_time,
> > +                                             &ad4000_trigger_handler, NULL);
> > +       if (ret)
> > +               return ret;
> > +
> > +       return devm_iio_device_register(&spi->dev, indio_dev);
> > +}
> > +
> > +static const struct spi_device_id ad4000_id[] = {
> > +       { "ad4000", (kernel_ulong_t)&ad4000_chips[ID_AD4000] },
> > +       { "ad4001", (kernel_ulong_t)&ad4000_chips[ID_AD4001] },
> > +       { "ad4002", (kernel_ulong_t)&ad4000_chips[ID_AD4002] },
> > +       { "ad4003", (kernel_ulong_t)&ad4000_chips[ID_AD4003] },
> > +       { "ad4004", (kernel_ulong_t)&ad4000_chips[ID_AD4004] },
> > +       { "ad4005", (kernel_ulong_t)&ad4000_chips[ID_AD4005] },
> > +       { "ad4006", (kernel_ulong_t)&ad4000_chips[ID_AD4006] },
> > +       { "ad4007", (kernel_ulong_t)&ad4000_chips[ID_AD4007] },
> > +       { "ad4008", (kernel_ulong_t)&ad4000_chips[ID_AD4008] },
> > +       { "ad4010", (kernel_ulong_t)&ad4000_chips[ID_AD4010] },
> > +       { "ad4011", (kernel_ulong_t)&ad4000_chips[ID_AD4011] },
> > +       { "ad4020", (kernel_ulong_t)&ad4000_chips[ID_AD4020] },
> > +       { "ad4021", (kernel_ulong_t)&ad4000_chips[ID_AD4021] },
> > +       { "ad4022", (kernel_ulong_t)&ad4000_chips[ID_AD4022] },
> > +       { "adaq4001", (kernel_ulong_t)&ad4000_chips[ID_ADAQ4001] },
> > +       { "adaq4003", (kernel_ulong_t)&ad4000_chips[ID_ADAQ4003] },
> > +       { }
> > +};
> > +MODULE_DEVICE_TABLE(spi, ad4000_id);
> > +
> > +static const struct of_device_id ad4000_of_match[] = {
> > +       { .compatible = "adi,ad4000", .data = &ad4000_chips[ID_AD4000] },
> > +       { .compatible = "adi,ad4001", .data = &ad4000_chips[ID_AD4001] },
> > +       { .compatible = "adi,ad4002", .data = &ad4000_chips[ID_AD4002] },
> > +       { .compatible = "adi,ad4003", .data = &ad4000_chips[ID_AD4003] },
> > +       { .compatible = "adi,ad4004", .data = &ad4000_chips[ID_AD4004] },
> > +       { .compatible = "adi,ad4005", .data = &ad4000_chips[ID_AD4005] },
> > +       { .compatible = "adi,ad4006", .data = &ad4000_chips[ID_AD4006] },
> > +       { .compatible = "adi,ad4007", .data = &ad4000_chips[ID_AD4007] },
> > +       { .compatible = "adi,ad4008", .data = &ad4000_chips[ID_AD4008] },
> > +       { .compatible = "adi,ad4010", .data = &ad4000_chips[ID_AD4010] },
> > +       { .compatible = "adi,ad4011", .data = &ad4000_chips[ID_AD4011] },
> > +       { .compatible = "adi,ad4020", .data = &ad4000_chips[ID_AD4020] },
> > +       { .compatible = "adi,ad4021", .data = &ad4000_chips[ID_AD4021] },
> > +       { .compatible = "adi,ad4022", .data = &ad4000_chips[ID_AD4022] },
> > +       { .compatible = "adi,adaq4001", .data = &ad4000_chips[ID_ADAQ4001] },
> > +       { .compatible = "adi,adaq4003", .data = &ad4000_chips[ID_ADAQ4003] },
> > +       { }
> > +};
> > +MODULE_DEVICE_TABLE(of, ad4000_of_match);
> > +
> > +static struct spi_driver ad4000_driver = {
> > +       .driver = {
> > +               .name   = "ad4000",
> > +               .of_match_table = ad4000_of_match,
> > +       },
> > +       .probe          = ad4000_probe,
> > +       .id_table       = ad4000_id,
> > +};
> > +module_spi_driver(ad4000_driver);
> > +
> > +MODULE_AUTHOR("Mircea Caprioru <mircea.caprioru@analog.com>");
> > +MODULE_AUTHOR("Marcelo Schmitt <marcelo.schmitt@analog.com>");
> > +MODULE_DESCRIPTION("Analog Devices AD4000 ADC driver");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.43.0
> >
> >

