Return-Path: <linux-kernel+bounces-36753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F5C83A609
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D09031C28EBD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045A8182AB;
	Wed, 24 Jan 2024 09:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+TWF68h"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0985690;
	Wed, 24 Jan 2024 09:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706090106; cv=none; b=o7wab0DkiCHp8dsrG/Sy7a5cCDHm6LgLQGjC8hEXwIv50z9d+LbcpyZrcAlI/YTyYrJ+aXYyTTOjLQ8yzxJanz6SgVUdxA0J6V1X927mcY6T1JCqCrl8QFX3Ow47PuslttxNFTqqoGb2Esq86hjwTjy3dX4E9MnMiazYzhF/3Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706090106; c=relaxed/simple;
	bh=UEeoNa1jLVO654MDyYUNLNxYCkLZibxBbxwFkKhS34A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GrfSWhmb8ezr3HFwPD2VKu3CeXiL2uw943Nw+qM3Hh5pLf8mtTb85lwiHx3n3xJjxeZoI8/0r5+d5GkbbGJUMOE/AOMOTZ+TlKR/gOKXwCJh6SdLcV+6TYPyyTZ19brIgsXTVSf53HJkfgzvWM0czNG8CjQnpy8OHVSXix6/6Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+TWF68h; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55ad2a47b7aso4492094a12.3;
        Wed, 24 Jan 2024 01:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706090102; x=1706694902; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uyeOUVhvBhhLcqw++duQRLw1e9cF/KyZjlhE1TvaoTQ=;
        b=H+TWF68huofahnaMaXdUsCHVSMgtZiUP7TgKn5FS8VmW/Hq0l/u1qlsLm80H/N+7ot
         jx2jZ974ZEBS9pUCVBbXiEXiLyF+3WD3NJ0VfHy9QoakNNiYEUzPc9lcPpYxDctsYjN8
         PeVz2phUdu+XyYfn4CYAtBEn/AE+AEd5HKN2u8+La8Geg/zSLtiGMn7yLtdcO5WDJFn6
         Y14cSBrE6rp6TAsy+e0cnTSc8+uJT1drZH0Ujf6iX1YlonJciZ2j2GcNngrPhgQtfXfG
         or2DeX0tVRfzEed4eKq4So6RoZxHg649X0vPqJrzQ9Unjk29QmIotmmAzqZOmUjcNkAl
         4jIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706090102; x=1706694902;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uyeOUVhvBhhLcqw++duQRLw1e9cF/KyZjlhE1TvaoTQ=;
        b=N5wZifzACgPzM5kL5iaUqr6T2rbP9eV6smhwuiykMnGuNKGhogIwKXVpa2Eq4Ug+4J
         t2LNg63pWqTxExRD4V/QIlRIEIendMOOZSK2rbv5R2ahHX5YcKrb7XLRel6cvoC3xHKe
         GntA8Ni5Qv2X6Bjt8ydJo3rRWR/XpZRRV36lv1qn7By0XZEktLYiDA1PXIT+lEPawR52
         WOx9i1VK10ZbNCnY6DbmH020asgMqH0DEkLGwxpbc4L00Mc3QgrbWRtGMjnaBYeJluCx
         3TuhCvqTnK2eqiCk6mrirqMeMcuUQVmWcbMe+At0uNWt59Ps/qm5W2TFNP0dS+AI0OiT
         /6GQ==
X-Gm-Message-State: AOJu0YwLl3oRBJyUzdDtig85lD2Lk0xsLwwmulRkOg4zojSm4K69Vjjk
	l+2Jq2k9+qtMWULNekoHqnN1fFZ9nykubjmDCm7QxOt43r2p4CEy
X-Google-Smtp-Source: AGHT+IFmP1C6BpXN05d8/Xl8kscSSjPWF+3kW6WKa4ZrT5zW9jOFWNrvi+yaPYOJX/E9BEnVWb2yEQ==
X-Received: by 2002:a17:907:7629:b0:a2f:bd2e:98aa with SMTP id jy9-20020a170907762900b00a2fbd2e98aamr386302ejc.164.1706090101842;
        Wed, 24 Jan 2024 01:55:01 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id bv2-20020a170906b1c200b00a2e81e4876dsm9293040ejb.44.2024.01.24.01.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 01:55:01 -0800 (PST)
Message-ID: <39c9bff3b97408b2f2b80f3290e517b5af536fff.camel@gmail.com>
Subject: Re: [PATCH 2/2 v2] pwm: Add driver for AXI PWM generator
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Trevor Gamblin <tgamblin@baylibre.com>, linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de, 
 michael.hennerich@analog.com, nuno.sa@analog.com,
 devicetree@vger.kernel.org,  robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,  Drew Fustini
 <dfustini@baylibre.com>, Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
 David Lechner <dlechner@baylibre.com>
Date: Wed, 24 Jan 2024 10:58:16 +0100
In-Reply-To: <20240123220515.279439-3-tgamblin@baylibre.com>
References: <20240123220515.279439-1-tgamblin@baylibre.com>
	 <20240123220515.279439-3-tgamblin@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-01-23 at 17:05 -0500, Trevor Gamblin wrote:
> From: Drew Fustini <dfustini@baylibre.com>
>=20
> Add support for the Analog Devices AXI PWM Generator. This device is an
> FPGA-implemented peripheral used as PWM signal generator and can be
> interfaced with AXI4. The register map of this peripheral makes it
> possible to configure the period and duty cycle of the output signal.
>=20
> Link: https://wiki.analog.com/resources/fpga/docs/axi_pwm_gen
> Co-developed-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Co-developed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> Co-developed-by: Trevor Gamblin <tgamblin@baylibre.com>
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
>=20
> ---

One minor nitpick below (but no need to re-spin just for that).
Anyways, from a code point of view, LGTM:

Acked-by: Nuno Sa <nuno.sa@analog.com>

> v2 changes:
> * Address feedback for driver and device tree in v1:
> =C2=A0 * Use more reasonable Kconfig approach
> =C2=A0 * Use common prefixes for all functions
> =C2=A0 * Rename axi_pwmgen struct to axi_pwmgen_ddata
> =C2=A0 * Change use of "pwm" to "ddata"
> =C2=A0 * Set and check state->polarity
> =C2=A0 * Multiply safely with mul_u64_u64_div_u64()
> =C2=A0 * Improve handling of max and zero periods
> =C2=A0 * Error if clk_rate_hz > NSEC_PER_SEC
> =C2=A0 * Add "Limitations" section at top of pwm-axi-pwmgen.c
> =C2=A0 * Don't disable outputs by default
> =C2=A0 * Remove unnecessary macros for period, duty, offset
> =C2=A0 * Fix axi_pwmgen_ddata alignment
> =C2=A0 * Don't artificially limit npwm to four
> =C2=A0 * Use clk_rate_exclusive_get(), balance with clk_rate_exclusive_pu=
t()
> =C2=A0 * Cache clk rate in axi_pwmgen_ddata
> =C2=A0 * Don't assign pwm->chip.base, do assign pwm->chip.atomic
> * Remove redundant calls to clk_get_rate
> * Test contents of AXI_PWMGEN_REG_CORE_MAGIC instead of
> =C2=A0 arbitrary AXI_PWMGEN_TEST_DATA in AXI_PWMGEN_REG_SCRATCHPAD
> * Remove redundant clk struct from axi_pwmgen_ddata
> * Add self as module author
> * Add major version check for IP core
>=20
> ---
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/pwm/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 13 ++
> =C2=A0drivers/pwm/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/pwm/pwm-axi-pwmgen.c | 246 ++++++++++++++++++++++++++++++++=
+++
> =C2=A04 files changed, 261 insertions(+)
> =C2=A0create mode 100644 drivers/pwm/pwm-axi-pwmgen.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8a4ed5545680..2baa7a0a1c8c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3438,6 +3438,7 @@ L:	linux-pwm@vger.kernel.org
> =C2=A0S:	Supported
> =C2=A0W:	https://ez.analog.com/linux-software-drivers
> =C2=A0F:	Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
> +F:	drivers/pwm/pwm-axi-pwmgen.c
> =C2=A0
> =C2=A0AXXIA I2C CONTROLLER
> =C2=A0M:	Krzysztof Adamski <krzysztof.adamski@nokia.com>
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 4b956d661755..d44b0e86adee 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -98,6 +98,19 @@ config PWM_ATMEL_TCB
> =C2=A0	=C2=A0 To compile this driver as a module, choose M here: the modu=
le
> =C2=A0	=C2=A0 will be called pwm-atmel-tcb.
> =C2=A0
> +config PWM_AXI_PWMGEN
> +	tristate "Analog Devices AXI PWM generator"
> +	depends on MICROBLAZE || NIOS2 || ARCH_ZYNQ || ARCH_ZYNQMP ||
> ARCH_INTEL_SOCFPGA || COMPILE_TEST
> +	select REGMAP_MMIO
> +	help
> +	=C2=A0 This enables support for the Analog Devices AXI PWM generator.
> +
> +	=C2=A0 This is a configurable PWM generator with variable pulse width a=
nd
> +	=C2=A0 period.
> +
> +	=C2=A0 To compile this driver as a module, choose M here: the module wi=
ll
> be
> +	=C2=A0 called pwm-axi-pwmgen.
> +
> =C2=A0config PWM_BCM_IPROC
> =C2=A0	tristate "iProc PWM support"
> =C2=A0	depends on ARCH_BCM_IPROC || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index c5ec9e168ee7..8322089954e9 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -6,6 +6,7 @@ obj-$(CONFIG_PWM_APPLE)		+=3D pwm-apple.o
> =C2=A0obj-$(CONFIG_PWM_ATMEL)		+=3D pwm-atmel.o
> =C2=A0obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+=3D pwm-atmel-hlcdc.o
> =C2=A0obj-$(CONFIG_PWM_ATMEL_TCB)	+=3D pwm-atmel-tcb.o
> +obj-$(CONFIG_PWM_AXI_PWMGEN)	+=3D pwm-axi-pwmgen.o
> =C2=A0obj-$(CONFIG_PWM_BCM_IPROC)	+=3D pwm-bcm-iproc.o
> =C2=A0obj-$(CONFIG_PWM_BCM_KONA)	+=3D pwm-bcm-kona.o
> =C2=A0obj-$(CONFIG_PWM_BCM2835)	+=3D pwm-bcm2835.o
> diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
> new file mode 100644
> index 000000000000..39d2c7be0cb4
> --- /dev/null
> +++ b/drivers/pwm/pwm-axi-pwmgen.c
> @@ -0,0 +1,246 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Analog Devices AXI PWM generator
> + *
> + * Copyright 2024 Analog Devices Inc.
> + * Copyright 2024 Baylibre SAS
> + *
> + * Limitations:
> + * - The writes to registers for period and duty are shadowed until
> + *=C2=A0=C2=A0 LOAD_CONFIG is written to AXI_PWMGEN_REG_CONFIG at the en=
d of the
> + *=C2=A0=C2=A0 current period.
> + * - Writing LOAD_CONFIG also has the effect of re-synchronizing all
> + *=C2=A0=C2=A0 enabled channels, which could cause glitching on other ch=
annels. It
> + *=C2=A0=C2=A0 is therefore expected that channels are assigned harmonic=
 periods
> + *=C2=A0=C2=A0 and all have a single user coordinating this.
> + * - Supports normal polarity. Does not support changing polarity.
> + */
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +#define AXI_PWMGEN_VERSION_MAJOR(x)	(((x) >> 16) & 0xff)
> +#define AXI_PWMGEN_VERSION_MINOR(x)	(((x) >> 8) & 0xff)
> +#define AXI_PWMGEN_VERSION_PATCH(x)	((x) & 0xff)
> +
> +#define AXI_PWMGEN_REG_CORE_VERSION	0x00
> +#define AXI_PWMGEN_REG_ID		0x04
> +#define AXI_PWMGEN_REG_SCRATCHPAD	0x08
> +#define AXI_PWMGEN_REG_CORE_MAGIC	0x0C
> +#define AXI_PWMGEN_REG_CONFIG		0x10
> +#define AXI_PWMGEN_REG_NPWM		0x14
> +#define AXI_PWMGEN_CHX_PERIOD(ch)	(0x40 + (12 * (ch)))
> +#define AXI_PWMGEN_CHX_DUTY(ch)		(0x44 + (12 * (ch)))
> +#define AXI_PWMGEN_CHX_OFFSET(ch)	(0x48 + (12 * (ch)))
> +#define AXI_PWMGEN_REG_CORE_MAGIC_VAL	0x601A3471 /* Identification numbe=
r
> to test during setup */
> +#define AXI_PWMGEN_LOAD_CONFIG		BIT(1)
> +#define AXI_PWMGEN_RESET		BIT(0)
> +
> +struct axi_pwmgen_ddata {
> +	struct pwm_chip	chip;
> +	struct regmap *regmap;
> +	unsigned long clk_rate_hz;
> +};
> +
> +static const struct regmap_config axi_pwmgen_regmap_config =3D {
> +	.reg_bits =3D 32,
> +	.reg_stride =3D 4,
> +	.val_bits =3D 32,
> +};
> +
> +static struct axi_pwmgen_ddata *axi_pwmgen_from_chip(struct pwm_chip *ch=
ip)
> +{
> +	return container_of(chip, struct axi_pwmgen_ddata, chip);
> +}
> +
> +static int axi_pwmgen_apply(struct pwm_chip *chip, struct pwm_device *pw=
m,
> +			=C2=A0=C2=A0=C2=A0 const struct pwm_state *state)
> +{
> +	struct axi_pwmgen_ddata *ddata =3D axi_pwmgen_from_chip(chip);
> +	unsigned int ch =3D pwm->hwpwm;
> +	struct regmap *regmap =3D ddata->regmap;
> +	u64 period_cnt, duty_cnt;
> +	int ret;
> +
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	if (state->enabled) {
> +

no need for extra line in here... at the very least, you should be coherent=
 in
both your code paths...

- Nuno S=C3=A1



