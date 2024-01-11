Return-Path: <linux-kernel+bounces-23750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 834E482B121
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 865291C20F32
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0883D4CB34;
	Thu, 11 Jan 2024 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQFG6bMM"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B594BA99;
	Thu, 11 Jan 2024 14:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50e7c6e3c63so5748394e87.3;
        Thu, 11 Jan 2024 06:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704984951; x=1705589751; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UlC7MH5emtNxlgExvPR+XneavsoEa3KzsnzfQYQhbIY=;
        b=FQFG6bMMcY0aHjP9PsbFYww8mlSMALGSjnAZm7X0Yle8Y5i4zFM0RMRnYN4g1tgGvM
         G1Qizi6HMG6FRTKcSkM2lHXwfEkyeDiRXmmCII0ACV/Tvsz1ZBRtNKgkVEnrx0+m10+v
         7lYWdZvWEtNXENCvkn93PrvPdnOrpL1EfjaqduHNeWEdlZyu8LylQJtKh7hYUSU/1716
         y/nykw5hfhD5EMBN7JSK3wRY8lnZsiM/OaOLVJOLlXJat0DNKXI42xsVfaID7iFIZ4Uz
         ic78cvEjcV6wwugB/JMV+3K8E9wvEW5N+DB9Ana98e7t0wd/zsXZ9EjXZPew6xMpl1ZI
         iHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704984951; x=1705589751;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UlC7MH5emtNxlgExvPR+XneavsoEa3KzsnzfQYQhbIY=;
        b=pwMcjG6EwVKlLAwHsNJMeSHp1cg1VsVzBwsifQjuP2Zpw6sQOnWFjm6xs61M6D6Nen
         38ZoO62iBRXgSE1O8lcv1JbuXBffueSue4S/Em17rgmLLPLCdldEvTBIO99HB0e52Fh4
         u0rjQIwppS+R4sus03YkIuxpAk0omkmMh3DMW61JoXPNoXjsihQ1exJ+10ZQtyWbZBUt
         xqpbmF8mAZs5J4jOVGQZ0becl9woGgGJnpJcmLyIk/zAB47QwvAxtguG9bSeFZYqfVgG
         ojuC64946X8qmWSYgxfQR1WtI54i2oESVqaX1Jgj28rcmZdPmYdTOr43JW+xK81YOu+y
         BcXg==
X-Gm-Message-State: AOJu0Yy5KsV2Fa8RyrgQM0FU6G+KLFyxDxOccqtFKOMKrHrF5ubejNih
	+LSk3/J9hdMrAyKs0C18kzA=
X-Google-Smtp-Source: AGHT+IHTnbXkm25xadU41c4f0AOaFqz4J3GTx5OwPnukSnli8Xj36xO4IHPN1Kd0cuLJFe8V8rSP7g==
X-Received: by 2002:a05:6512:b90:b0:50e:e1d3:7594 with SMTP id b16-20020a0565120b9000b0050ee1d37594mr229845lfv.121.1704984950737;
        Thu, 11 Jan 2024 06:55:50 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id j16-20020a1709062a1000b00a2c467ec72bsm669245eje.60.2024.01.11.06.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 06:55:50 -0800 (PST)
Message-ID: <0e6f38002d83a6a61fa5424499c7c3f2f6d6f3de.camel@gmail.com>
Subject: Re: [PATCH 12/13] iio: offload: add new PWM triggered DMA buffer
 driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>,  Michael Hennerich <michael.hennerich@analog.com>,
 Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Frank Rowand
 <frowand.list@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Jonathan
 Corbet <corbet@lwn.net>,  linux-spi@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Thu, 11 Jan 2024 15:59:02 +0100
In-Reply-To: <20240109-axi-spi-engine-series-3-v1-12-e42c6a986580@baylibre.com>
References: 
	<20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
	 <20240109-axi-spi-engine-series-3-v1-12-e42c6a986580@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-10 at 13:49 -0600, David Lechner wrote:
> This adds a new driver for handling SPI offloading using a PWM as the
> trigger and DMA for the received data. This will be used by ADCs in
> conjunction with SPI controllers with offloading support to be able
> to sample at high rates without CPU intervention.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> =C2=A0drivers/iio/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 1 +
> =C2=A0drivers/iio/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
1 +
> =C2=A0.../iio/buffer/industrialio-hw-triggered-buffer.c=C2=A0 |=C2=A0=C2=
=A0 1 +
> =C2=A0drivers/iio/offload/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 21 ++
> =C2=A0drivers/iio/offload/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A0drivers/iio/offload/iio-pwm-triggered-dma-buffer.c | 212
> +++++++++++++++++++++
> =C2=A06 files changed, 238 insertions(+)
>=20
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index 52eb46ef84c1..56738282d82f 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -90,6 +90,7 @@ source "drivers/iio/imu/Kconfig"
> =C2=A0source "drivers/iio/light/Kconfig"
> =C2=A0source "drivers/iio/magnetometer/Kconfig"
> =C2=A0source "drivers/iio/multiplexer/Kconfig"
> +source "drivers/iio/offload/Kconfig"
> =C2=A0source "drivers/iio/orientation/Kconfig"
> =C2=A0source "drivers/iio/test/Kconfig"
> =C2=A0if IIO_TRIGGER
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index 9622347a1c1b..20acf5e1a4a7 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -34,6 +34,7 @@ obj-y +=3D imu/
> =C2=A0obj-y +=3D light/
> =C2=A0obj-y +=3D magnetometer/
> =C2=A0obj-y +=3D multiplexer/
> +obj-y +=3D offload/
> =C2=A0obj-y +=3D orientation/
> =C2=A0obj-y +=3D position/
> =C2=A0obj-y +=3D potentiometer/
> diff --git a/drivers/iio/buffer/industrialio-hw-triggered-buffer.c
> b/drivers/iio/buffer/industrialio-hw-triggered-buffer.c
> index 7a8a71066b0e..a2fae6059616 100644
> --- a/drivers/iio/buffer/industrialio-hw-triggered-buffer.c
> +++ b/drivers/iio/buffer/industrialio-hw-triggered-buffer.c
> @@ -86,6 +86,7 @@ static int iio_hw_trigger_buffer_probe(struct
> auxiliary_device *adev,
> =C2=A0}
> =C2=A0
> =C2=A0static const struct auxiliary_device_id iio_hw_trigger_buffer_id_ta=
ble[] =3D {
> +	{ .name =3D "pwm-triggered-dma-buffer.triggered-buffer" },
> =C2=A0	{ }
> =C2=A0};
> =C2=A0MODULE_DEVICE_TABLE(auxiliary, iio_hw_trigger_buffer_id_table);
> diff --git a/drivers/iio/offload/Kconfig b/drivers/iio/offload/Kconfig
> new file mode 100644
> index 000000000000..760c0cfe0e9c
> --- /dev/null
> +++ b/drivers/iio/offload/Kconfig
> @@ -0,0 +1,21 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# SPI offload handlers for Industrial I/O
> +#
> +# When adding new entries keep the list in alphabetical order
> +
> +menu "SPI offload handlers"
> +
> +config IIO_PWM_TRIGGERED_DMA_BUFFER
> +	tristate "PWM trigger and DMA buffer connected to SPI offload"
> +	select AUXILIARY_BUS
> +	select IIO_BUFFER_DMAENGINE
> +	help
> +	=C2=A0 Provides a periodic hardware trigger via a PWM connected to the
> +	=C2=A0 trigger input of a SPI offload and a hardware buffer implemented
> +	=C2=A0 via DMA connected to the data output stream the a SPI offload.
> +
> +	=C2=A0 To compile this driver as a module, choose M here: the
> +	=C2=A0 module will be called "iio-pwm-triggered-dma-buffer".
> +
> +endmenu
> diff --git a/drivers/iio/offload/Makefile b/drivers/iio/offload/Makefile
> new file mode 100644
> index 000000000000..7300ce82f066
> --- /dev/null
> +++ b/drivers/iio/offload/Makefile
> @@ -0,0 +1,2 @@
> +
> +obj-$(CONFIG_IIO_PWM_TRIGGERED_DMA_BUFFER) :=3D iio-pwm-triggered-dma-bu=
ffer.o
> diff --git a/drivers/iio/offload/iio-pwm-triggered-dma-buffer.c
> b/drivers/iio/offload/iio-pwm-triggered-dma-buffer.c
> new file mode 100644
> index 000000000000..970ea82316f6
> --- /dev/null
> +++ b/drivers/iio/offload/iio-pwm-triggered-dma-buffer.c
> @@ -0,0 +1,212 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Platform driver for a PWM trigger and DMA buffer connected to a SPI
> + * controller offload instance implementing the iio-hw-triggered-buffer
> + * interface.
> + *
> + * Copyright (C) 2023 Analog Devices, Inc.
> + * Copyright (C) 2023 BayLibre, SAS
> + */
> +
> +#include <linux/auxiliary_bus.h>
> +#include <linux/pwm.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/hw_triggered_buffer_impl.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/buffer-dmaengine.h>
> +#include <linux/sysfs.h>
> +
> +struct iio_pwm_triggered_dma_buffer {
> +	struct iio_hw_triggered_buffer_device hw;
> +	struct pwm_device *pwm;
> +};
> +
> +static const struct iio_trigger_ops iio_pwm_triggered_dma_buffer_ops;
> +
> +static int iio_pwm_triggered_dma_buffer_set_state(struct iio_trigger *tr=
ig,
> bool state)
> +{
> +	struct iio_pwm_triggered_dma_buffer *st =3D
> iio_trigger_get_drvdata(trig);
> +
> +	if (state)
> +		return pwm_enable(st->pwm);
> +
> +	pwm_disable(st->pwm);
> +
> +	return 0;
> +}
> +
> +static int iio_pwm_triggered_dma_buffer_validate_device(struct iio_trigg=
er
> *trig,
> +							struct iio_dev
> *indio_dev)
> +{
> +	/* Don't allow assigning trigger via sysfs. */
> +	return -EINVAL;
> +}
> +
> +static const struct iio_trigger_ops iio_pwm_triggered_dma_buffer_ops =3D=
 {
> +	.set_trigger_state =3D iio_pwm_triggered_dma_buffer_set_state,
> +	.validate_device =3D iio_pwm_triggered_dma_buffer_validate_device,
> +};
> +
> +static u32 axi_spi_engine_offload_pwm_trigger_get_rate(struct iio_trigge=
r
> *trig)
> +{
> +	struct iio_pwm_triggered_dma_buffer *st =3D
> iio_trigger_get_drvdata(trig);
> +	u64 period_ns =3D pwm_get_period(st->pwm);
> +
> +	if (period_ns)
> +		return DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC, period_ns);
> +
> +	return 0;
> +}
> +
> +static int
> +axi_spi_engine_offload_set_samp_freq(struct iio_pwm_triggered_dma_buffer=
 *st,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 u32 requested_hz)
> +{
> +	int period_ns;
> +
> +	if (requested_hz =3D=3D 0)
> +		return -EINVAL;
> +
> +	period_ns =3D DIV_ROUND_UP(NSEC_PER_SEC, requested_hz);
> +
> +	/*
> +	 * FIXME: We really just need a clock, not a PWM. The current duty
> cycle
> +	 * value is a hack to work around the edge vs. level offload trigger
> +	 * issue in the ADI AXI SPI Engine firmware.
> +	 */
> +	return pwm_config(st->pwm, 10, period_ns);
> +}
> +
> +static ssize_t sampling_frequency_show(struct device *dev,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device_attribute *attr, =
char
> *buf)
> +{
> +	struct iio_trigger *trig =3D to_iio_trigger(dev);
> +
> +	return sysfs_emit(buf, "%u\n",
> +			=C2=A0 axi_spi_engine_offload_pwm_trigger_get_rate(trig));
> +}
> +
> +static ssize_t sampling_frequency_store(struct device *dev,
> +					struct device_attribute *attr,
> +					const char *buf, size_t len)
> +{
> +	struct iio_trigger *trig =3D to_iio_trigger(dev);
> +	struct iio_pwm_triggered_dma_buffer *st =3D
> iio_trigger_get_drvdata(trig);
> +	int ret;
> +	u32 val;
> +
> +	ret =3D kstrtou32(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D axi_spi_engine_offload_set_samp_freq(st, val);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +

This is also something that made me wonder... In the end of the day, the
frequency at which we want to sample the data depends on the converter devi=
ce.
This completely detached interface makes it more easy for the user to screw=
 up
things, right?

Things might even become more complicated in usecases where we have an
additional pwm (on top of the data fetch trigger one) for triggering conver=
sions
in the converter and we might need to properly control the phase between th=
ose
two signals. So, how would we handle it in the current form? We have one pw=
m
belonging to the offload engine and one belonging to the converter but they=
 need
to cope together...

I'm aware you have some alternative ideas for not using pwms but the series=
 is
using pwms... And the above usecase is real and it's sitting out of tree wa=
iting
for the offload stuff to get merged so I can upstream that driver :)

- Nuno S=C3=A1



