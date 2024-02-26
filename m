Return-Path: <linux-kernel+bounces-81138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 173148670EE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1AF1C238DF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51A95D8E9;
	Mon, 26 Feb 2024 10:13:38 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5EE5D739
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 10:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708942418; cv=none; b=eNRNuNKSkIT7FNvRE9Cd9GO49Vn9yadVF9IH0Hc6VZuoW4jTD/SvzobzW4hZqMRr6gx3rvEa0/E/7aLR79ObUYf0CpK1AcvU5mFILXFx6UldwVWFAcyJSAVCiLb/fMMvqBHCpmhd7t38kAvaRPUQPrNVAU1S2G9Yr+i0N+jP4Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708942418; c=relaxed/simple;
	bh=l/XNUdsfXsVRtLmfrCgBFlt+3X14xsPp0ov7WWwqMKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubLUCF5Zg929K7ZnoJ0+/BwH4wG56ezLMmqNOZuFcoO5FCY7NzcD61Xdlx2bL6quZoyBlHJKW2HqzCgK/hZ7JcryCP915IkBOc4RTsdZv0GVgGGEkE/ETJX8srhroM70iLF24WXYf7im3CWl4nLMTFR9rMze1+P0FlAHZY8a3tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1reXzJ-0004kk-1T; Mon, 26 Feb 2024 11:13:33 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1reXzH-002yMd-U7; Mon, 26 Feb 2024 11:13:31 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1reXzH-00Ba9u-2h;
	Mon, 26 Feb 2024 11:13:31 +0100
Date: Mon, 26 Feb 2024 11:13:31 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.hennerich@analog.com, nuno.sa@analog.com, devicetree@vger.kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	Drew Fustini <dfustini@baylibre.com>, Sergiu Cuciurean <sergiu.cuciurean@analog.com>, 
	David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH 2/2 v3] pwm: Add driver for AXI PWM generator
Message-ID: <rqozm7c4xixq3mb7sod7uslceieme7jrtdj2yelrekrqnttch2@vpsbe2nqmdsd>
References: <20240131214042.1335251-1-tgamblin@baylibre.com>
 <20240131214042.1335251-3-tgamblin@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e7n7hyci5zrnb2jl"
Content-Disposition: inline
In-Reply-To: <20240131214042.1335251-3-tgamblin@baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--e7n7hyci5zrnb2jl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 04:40:41PM -0500, Trevor Gamblin wrote:
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
> Acked-by: Nuno Sa <nuno.sa@analog.com>
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---
> v3 changes:
> * Address feedback for driver in v2:
>   * Remove unnecessary blank line in axi_pwmgen_apply
>   * Use macros already defined in <linux/fpga/adi-axi-common.h> for
>     version checking
>=20
> v2 changes:
> * Address feedback for driver and device tree in v1:
>   * Use more reasonable Kconfig approach
>   * Use common prefixes for all functions
>   * Rename axi_pwmgen struct to axi_pwmgen_ddata
>   * Change use of "pwm" to "ddata"
>   * Set and check state->polarity
>   * Multiply safely with mul_u64_u64_div_u64()
>   * Improve handling of max and zero periods
>   * Error if clk_rate_hz > NSEC_PER_SEC
>   * Add "Limitations" section at top of pwm-axi-pwmgen.c
>   * Don't disable outputs by default
>   * Remove unnecessary macros for period, duty, offset
>   * Fix axi_pwmgen_ddata alignment
>   * Don't artificially limit npwm to four
>   * Use clk_rate_exclusive_get(), balance with clk_rate_exclusive_put()
>   * Cache clk rate in axi_pwmgen_ddata
>   * Don't assign pwm->chip.base, do assign pwm->chip.atomic
> * Remove redundant calls to clk_get_rate
> * Test contents of AXI_PWMGEN_REG_CORE_MAGIC instead of
>   arbitrary AXI_PWMGEN_TEST_DATA in AXI_PWMGEN_REG_SCRATCHPAD
> * Remove redundant clk struct from axi_pwmgen_ddata
> * Add self as module author
> * Add major version check for IP core
>=20
> ---
>  MAINTAINERS                  |   1 +
>  drivers/pwm/Kconfig          |  13 ++
>  drivers/pwm/Makefile         |   1 +
>  drivers/pwm/pwm-axi-pwmgen.c | 242 +++++++++++++++++++++++++++++++++++
>  4 files changed, 257 insertions(+)
>  create mode 100644 drivers/pwm/pwm-axi-pwmgen.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8a4ed5545680..2baa7a0a1c8c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3438,6 +3438,7 @@ L:	linux-pwm@vger.kernel.org
>  S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
> +F:	drivers/pwm/pwm-axi-pwmgen.c
> =20
>  AXXIA I2C CONTROLLER
>  M:	Krzysztof Adamski <krzysztof.adamski@nokia.com>
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 4b956d661755..d44b0e86adee 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -98,6 +98,19 @@ config PWM_ATMEL_TCB
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-atmel-tcb.
> =20
> +config PWM_AXI_PWMGEN
> +	tristate "Analog Devices AXI PWM generator"
> +	depends on MICROBLAZE || NIOS2 || ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_INTE=
L_SOCFPGA || COMPILE_TEST
> +	select REGMAP_MMIO
> +	help
> +	  This enables support for the Analog Devices AXI PWM generator.
> +
> +	  This is a configurable PWM generator with variable pulse width and
> +	  period.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called pwm-axi-pwmgen.
> +
>  config PWM_BCM_IPROC
>  	tristate "iProc PWM support"
>  	depends on ARCH_BCM_IPROC || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index c5ec9e168ee7..8322089954e9 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -6,6 +6,7 @@ obj-$(CONFIG_PWM_APPLE)		+=3D pwm-apple.o
>  obj-$(CONFIG_PWM_ATMEL)		+=3D pwm-atmel.o
>  obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+=3D pwm-atmel-hlcdc.o
>  obj-$(CONFIG_PWM_ATMEL_TCB)	+=3D pwm-atmel-tcb.o
> +obj-$(CONFIG_PWM_AXI_PWMGEN)	+=3D pwm-axi-pwmgen.o
>  obj-$(CONFIG_PWM_BCM_IPROC)	+=3D pwm-bcm-iproc.o
>  obj-$(CONFIG_PWM_BCM_KONA)	+=3D pwm-bcm-kona.o
>  obj-$(CONFIG_PWM_BCM2835)	+=3D pwm-bcm2835.o
> diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
> new file mode 100644
> index 000000000000..44e62e90b227
> --- /dev/null
> +++ b/drivers/pwm/pwm-axi-pwmgen.c
> @@ -0,0 +1,242 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Analog Devices AXI PWM generator
> + *
> + * Copyright 2024 Analog Devices Inc.
> + * Copyright 2024 Baylibre SAS
> + *
> + * Limitations:
> + * - The writes to registers for period and duty are shadowed until
> + *   LOAD_CONFIG is written to AXI_PWMGEN_REG_CONFIG at the end of the
> + *   current period.
> + * - Writing LOAD_CONFIG also has the effect of re-synchronizing all
> + *   enabled channels, which could cause glitching on other channels. It
> + *   is therefore expected that channels are assigned harmonic periods
> + *   and all have a single user coordinating this.

That means that when I reconfigure pwm2 the currently running period of
pwm2 is completed and then all pwmX's counters are reset to zero?

The patch looks good to me now. It needs a rework to use
pwmchip_alloc(). If you could care for that, that would be great.
Otherwise I'd pick up your patch later and add the conversion myself.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--e7n7hyci5zrnb2jl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXcZEoACgkQj4D7WH0S
/k7gbQf/UafmyR6iYiS28SUjB9rcyGxLIkjm6YaqST0mFEHMDwLQjDp+Qbhz3DRf
7FMBK69me846eI2rHxxYDJRLZoxl6nwUmV0pcgb7eBBM11wnjPYwDtgdWzbQ4E0e
/lRcvKD5V+9S9JP5jt9fPSqqrvVT0lvX//CecbVQhV1qnAprLyufklqJ4e/AYxBo
+1hrtgtC+rpkMvQQhCCMvjihPPaT6wtdlTwBvyzENfKg9AgA++ENl5pOLESg5Yhl
aa+1w3IljZ+y4pG01qqN8Ot5BK9KPf1ALkfTOPQkc/+CnG6ZVz/lE4r6ClN99/va
cS39QBEz07t8N6+98MXWgk99vHEXLw==
=6eaA
-----END PGP SIGNATURE-----

--e7n7hyci5zrnb2jl--

