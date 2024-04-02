Return-Path: <linux-kernel+bounces-128486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF77895B76
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FBD01C20898
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5FB15AD86;
	Tue,  2 Apr 2024 18:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rN1JPzb+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C1615AAC4;
	Tue,  2 Apr 2024 18:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712081376; cv=none; b=uNxdED/5Va9PUz07e0GQ3DLEHGfzWKQAGwqooUZs/C4RnqznBPllnLrApwP7FevdrOCWB2pk5W7dNaO7XzUBdIROyMF8C/myjxh8s4ndbqA3LUC4X/aOv8db69QoRln8kDBcHNjuqtx/1anuHeQoy9HCSmKmw+5FFtTJ5LmOYh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712081376; c=relaxed/simple;
	bh=v2yTSI5wVjubdh6O9XGd9XiQiEx2T9wjyrIYVBy4i5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ea2Vhw8Pu7OTY53cxbBc77duR2jddElT5vnsnEil7Rw612xw76HpGHVSfMEbuj9K4GhcGHMswJspDGCulkiYtj6MW/O26DCiLQYJf7jLjbWNv0pJeMXyP3pRRmqTyg77aAl4bUE2j11Sjf4ayFkXNXR80LL5emXo9Cewyrm1oUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rN1JPzb+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43682C433C7;
	Tue,  2 Apr 2024 18:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712081376;
	bh=v2yTSI5wVjubdh6O9XGd9XiQiEx2T9wjyrIYVBy4i5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rN1JPzb+MARtU6UczxPQ7h9luhxp2nCHkJALKqKjYduvj/tMkpNJnwvDaWcqPceGZ
	 LrsnSR3TI7oBn+DZSYRPdwkAQ/yTwpNdM2clC/L2MscHkqpZDMMjyoRXR1l77zF+Bt
	 u8srvdubSsKoHr8CPvbbqqEQX2nlD+gVwVGTE2YRjsg7rJT2kPcRDNq12SUbLSPAU3
	 7kbth671C937lhBHjXwLBaVsP4/QCi/ziYmyX8irs2jeFh97Zf5IuSwryLrzu4XSuj
	 NlVefpZqL8ZKa1edzZjQXxM8Msy784onEpXwKltmZIHMDS1eklHcmiiBy+zI292XeG
	 HueNZcfQlKAag==
Date: Tue, 2 Apr 2024 19:09:32 +0100
From: Conor Dooley <conor@kernel.org>
To: Allen_Lin <allencl_lin@hotmail.com>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, jikos@kernel.org,
	benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: input: Add Himax HX83102J touchscreen
Message-ID: <20240402-doable-routine-8e8cb4f07ffb@spud>
References: <20240402104930.1053016-1-allencl_lin@hotmail.com>
 <TY0PR06MB5611C37640AA40B2B7716ABE9E3E2@TY0PR06MB5611.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wnkQWaX3HDVV3g+f"
Content-Disposition: inline
In-Reply-To: <TY0PR06MB5611C37640AA40B2B7716ABE9E3E2@TY0PR06MB5611.apcprd06.prod.outlook.com>


--wnkQWaX3HDVV3g+f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2024 at 06:49:27PM +0800, Allen_Lin wrote:
> Add the HX83102j touchscreen device tree bindings documents.
> HX83102j is a Himax TDDI touchscreen controller.
> It's power sequence should be bound with a lcm driver, thus it
> needs to be a panel follower. Others are the same as normal SPI
> touchscreen controller.
>=20
> Signed-off-by: Allen_Lin <allencl_lin@hotmail.com>
> ---
>  .../input/touchscreen/himax,hx83102j.yaml     | 100 ++++++++++++++++++
>  MAINTAINERS                                   |   6 ++
>  2 files changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/h=
imax,hx83102j.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/himax,hx=
83102j.yaml b/Documentation/devicetree/bindings/input/touchscreen/himax,hx8=
3102j.yaml
> new file mode 100644
> index 000000000000..fe79129f704a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/himax,hx83102j.=
yaml
> @@ -0,0 +1,100 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/touchscreen/himax,hx83102j.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Himax hx83102j touchscreen
> +
> +maintainers:
> +  - Allen Lin <allencl_lin@hotmail.com>
> +
> +description:
> +  This Himax hx83102j touchscreen uses the spi protocol.
> +
> +allOf:
> +  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    const: himax,hx83102j
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  vccd-supply:
> +    description: A phandle for the regualtor supplying IO power.

nit: regulator

> +=20
> +  vsn-supply:
> +    description: Negative supply regulator.
> +=20
> +  vsp-supply:
> +    description: Positive supply regulator.

Cool, thanks for adding these.

> +
> +  ddreset-gpios:
> +    description: A phandle of gpio for display reset controlled by the L=
CD driver.
> +      This is the master reset, if this reset is triggered, the TP reset=
 will=20
> +      also be triggered.
> + =20
> +  spi-cpha: true
> +
> +  spi-cpol: true
> +
> +  spi-max-frequency: true
> +
> +  panel: true
> +
> +  himax,firmware-name:

firmware-name is a standard property, you don't need to vendor prefix it.

> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      Specify the file name for firmware loading.
> +
> +  himax,pid:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      PID for HID device, used to validate firmware.

Why do you need this _and_ firmware-name? You should be able to trust
the firmware that the dt has told you to use, no?

Cheers,
Conor.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - reset-gpios
> +  - panel
> +  - vccd-supply
> +  - vsn-supply
> +  - vsp-supply
> +  - ddreset-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +      ap_ts: touchscreen@0 {
> +        compatible =3D "himax,hx83102j";
> +        reg =3D <0>;
> +        pinctrl-names =3D "default";
> +        pinctrl-0 =3D <&touch_int0 &touch_reset>;
> +        reset-gpios =3D <&gpio1 8 GPIO_ACTIVE_LOW>;
> +        spi-cpha;
> +        spi-cpol;
> +        interrupt-parent =3D <&gpio1>;
> +        interrupts =3D <7 IRQ_TYPE_LEVEL_LOW>;
> +        panel =3D <&panel>;
> +        vccd-supply =3D <&regulator>;
> +        vsn-supply =3D <&regulator>;
> +        vsp-supply =3D <&regulator>;
> +        ddreset-gpios =3D <&gpio1>;
> +      };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 43b39956694a..aa51c60fd66d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9669,6 +9669,12 @@ L:	linux-kernel@vger.kernel.org
>  S:	Maintained
>  F:	drivers/misc/hisi_hikey_usb.c
> =20
> +HIMAX HID HX83102J TOUCHSCREEN
> +M:	Allen Lin <allencl_lin@hotmail.com>
> +L:	linux-input@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/input/touchscreen/himax,hx83102j.ya=
ml
> +
>  HIMAX HX83112B TOUCHSCREEN SUPPORT
>  M:	Job Noorman <job@noorman.info>
>  L:	linux-input@vger.kernel.org
> --=20
> 2.34.1
>=20

--wnkQWaX3HDVV3g+f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgxJ3AAKCRB4tDGHoIJi
0ngTAP9sAj6qdFZruDOlfI5qPpSzZ9xkZKy3Gcy8R5RWuWZ+WAD+ILoYLlHXju8g
Vaim33nrtscHEM4CFV/YvdfiUdicvgY=
=OLuM
-----END PGP SIGNATURE-----

--wnkQWaX3HDVV3g+f--

