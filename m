Return-Path: <linux-kernel+bounces-66579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D7B855E95
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3CDE1F21DCA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABFD6351D;
	Thu, 15 Feb 2024 09:54:56 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C934C6350A
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707990895; cv=none; b=oKcKMaiX+UYCgyp7Ii51o3VGYC/SW+I2aJJbwHvu2XMwFAJYdsyERAiJ+JvEG+DjAbUUSLrqsAlD2WA2ZolsIe3TP6GIIOZ+5CQOKQXe4AfuvOtOKHIa8FnxPcpnzR5erQaRzRf3l56rI7crGup/vN4Lxgx2Y1T18FkAi8jfuGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707990895; c=relaxed/simple;
	bh=RNF989/m20IyPhB5QfOKoOvl9/hYrxwPiHxxPlAAJzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjwnmpGZ0wxV6IfCOH6szv2Mll6J+pNP1AxVfb4jQEW/gUg1l4VVw/+Aba2RPQHkwEQY/dF+JVDLD6e3zLe2dyRb2ZOwHLDFgSYC9+ZTtOx4tv8awfrTpthT9JAJKegf1HD1oBj/8e9BjRvUXxjoS2iKPz+BA8pGPV/qELoM9Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raYRr-00047w-9k; Thu, 15 Feb 2024 10:54:31 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raYRp-000rFT-Ba; Thu, 15 Feb 2024 10:54:29 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raYRp-005HU7-0o;
	Thu, 15 Feb 2024 10:54:29 +0100
Date: Thu, 15 Feb 2024 10:54:28 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: sam@ravnborg.org, bbrezillon@kernel.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, lee@kernel.org, 
	thierry.reding@gmail.com, linux-pwm@vger.kernel.org, hari.prasathge@microchip.com, 
	manikandan.m@microchip.com, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [linux][PATCH v6 2/3] dt-bindings: atmel,hlcdc: convert pwm
 bindings to json-schema
Message-ID: <4psibzz7xylyp3zbmp3gup2gojh77bsllkyosbfdacyw4gzxuw@djl7eg4oeg2r>
References: <20240202001733.91455-1-dharma.b@microchip.com>
 <20240202001733.91455-3-dharma.b@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bkvbrrniz7f544mh"
Content-Disposition: inline
In-Reply-To: <20240202001733.91455-3-dharma.b@microchip.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--bkvbrrniz7f544mh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Feb 02, 2024 at 05:47:32AM +0530, Dharma Balasubiramani wrote:
> Convert device tree bindings for Atmel's HLCDC PWM controller to YAML
> format.
>=20
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Changelog
> v5 -> v6
> - Drop the example as we have one complete example in mfd binding.
> v4 -> v5
> v3 -> v4
> - No changes
> Note: The clean up patch will be sent later as Sam suggested.
> v2 -> v3
> - Remove '|' in description, as there is no formatting to preserve.
> - Delete the description for pwm-cells.
> - Drop the label for pwm node as it not used.
> v1 -> v2
> - Remove the explicit copyrights.
> - Modify title (not include words like binding/driver).
> - Modify description actually describing the hardware and not the driver.
> - Remove pinctrl properties which aren't required.
> - Drop parent node and it's other sub-device node which are not related h=
ere.
> ---
>  .../bindings/pwm/atmel,hlcdc-pwm.yaml         | 35 +++++++++++++++++++
>  .../bindings/pwm/atmel-hlcdc-pwm.txt          | 29 ---------------
>  2 files changed, 35 insertions(+), 29 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pwm/atmel,hlcdc-pwm=
=2Eyaml
>  delete mode 100644 Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm=
=2Etxt
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/atmel,hlcdc-pwm.yaml b=
/Documentation/devicetree/bindings/pwm/atmel,hlcdc-pwm.yaml
> new file mode 100644
> index 000000000000..0e92868a2b68
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/atmel,hlcdc-pwm.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/atmel,hlcdc-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel's HLCDC's PWM controller
> +
> +maintainers:
> +  - Nicolas Ferre <nicolas.ferre@microchip.com>
> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
> +  - Claudiu Beznea <claudiu.beznea@tuxon.dev>
> +
> +description:
> +  The LCDC integrates a Pulse Width Modulation (PWM) Controller. This bl=
ock
> +  generates the LCD contrast control signal (LCD_PWM) that controls the
> +  display's contrast by software. LCDC_PWM is an 8-bit PWM signal that c=
an be
> +  converted to an analog voltage with a simple passive filter. LCD displ=
ay
> +  panels have different backlight specifications in terms of minimum/max=
imum
> +  values for PWM frequency. If the LCDC PWM frequency range does not mat=
ch the
> +  LCD display panel, it is possible to use the standalone PWM Controller=
 to
> +  drive the backlight.
> +
> +properties:
> +  compatible:
> +    const: atmel,hlcdc-pwm
> +
> +  "#pwm-cells":
> +    const: 3
> +
> +required:
> +  - compatible
> +  - "#pwm-cells"
> +
> +additionalProperties: false
> diff --git a/Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt b/=
Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt
> deleted file mode 100644
> index afa501bf7f94..000000000000
> --- a/Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -Device-Tree bindings for Atmel's HLCDC (High-end LCD Controller) PWM dri=
ver
> -
> -The Atmel HLCDC PWM is subdevice of the HLCDC MFD device.
> -See ../mfd/atmel-hlcdc.txt for more details.
> -
> -Required properties:
> - - compatible: value should be one of the following:
> -   "atmel,hlcdc-pwm"
> - - pinctr-names: the pin control state names. Should contain "default".
> - - pinctrl-0: should contain the pinctrl states described by pinctrl
> -   default.
> - - #pwm-cells: should be set to 3. This PWM chip use the default 3 cells
> -   bindings defined in pwm.yaml in this directory.
> -
> -Example:
> -
> -	hlcdc: hlcdc@f0030000 {
> -		compatible =3D "atmel,sama5d3-hlcdc";
> -		reg =3D <0xf0030000 0x2000>;
> -		clocks =3D <&lcdc_clk>, <&lcdck>, <&clk32k>;
> -		clock-names =3D "periph_clk","sys_clk", "slow_clk";
> -
> -		hlcdc_pwm: hlcdc-pwm {
> -			compatible =3D "atmel,hlcdc-pwm";
> -			pinctrl-names =3D "default";
> -			pinctrl-0 =3D <&pinctrl_lcd_pwm>;
> -			#pwm-cells =3D <3>;
> -		};
> -	};

I guess dropping the example is fine because it's included now in the
mfd binding.

Applied to

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for=
-next

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--bkvbrrniz7f544mh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXN31QACgkQj4D7WH0S
/k6NeAf9EVR8Xz9GuvTvAqU0vc/y1P/c6V7/AtXRwh5HxqS2eziYkB1DZ7gU7MzY
pZ5nyNIvTFXxrcGr4jKn8XaFMUVLaduPRRld8o4OpCxgrRcdG6yj+MRox9gQ4eTq
H31V7tmZCubtMX1CIrNgFv91u6mj2tnndzxCS2MpVIYCt4SVG0SH9Yah3VTZ2Q4h
zHteuvTsi/4n0JIx4qBGjJerCR8+5DrTW4NxbawleSuXpqfbSSPfabVjPHd4sA9g
DnREROuPWeL3QV/aQ3F7X9y2FcfjK1B2F7V3MVm6N/S7Y/gT7NjmF1985t9O3hmK
hxUuN2McBmMJC3yK4gUBzlAYjOCE3w==
=Q1fN
-----END PGP SIGNATURE-----

--bkvbrrniz7f544mh--

