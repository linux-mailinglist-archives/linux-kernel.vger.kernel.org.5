Return-Path: <linux-kernel+bounces-111889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 802BA88723A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ACEF283527
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B077B60893;
	Fri, 22 Mar 2024 17:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLseMYIp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47ED605A3;
	Fri, 22 Mar 2024 17:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711130053; cv=none; b=kPP4++dCUn04e+r2mCyh2BJLMsWGHwPtf9tjEJdSMDG8HdKcVBoN+pvSGMMr7bJrOgYGGphTgCViCEPlIL/JV/5IgXBI32dbYavuR7bqsTTmkXCAXWwJLAlQKs6OCmQm6vDaZ46SZmqA0wEZ+lzEoUPI88xiJBcnKaqCxR+8aZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711130053; c=relaxed/simple;
	bh=cuEt0R+/b/OljUG03tx8fQcLhAkGOfqCIl+FHBVR1u4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+6lv89h4TFsPgqNXLfwOVzJiTvosMfb4o4z8nxCsHMTxYsWxaA6HU6u2gbnAjzxxJm+vXyheWZ2PDLYwCT0lczAdnsIMxNGt/H8upnGKE03w+hRgpJ4iDiCpG5a+CpR/g+ZwQ4ggh/G2gkMH1LdirHs2YqAa6iimhDGn1Jz8TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLseMYIp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA043C43390;
	Fri, 22 Mar 2024 17:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711130052;
	bh=cuEt0R+/b/OljUG03tx8fQcLhAkGOfqCIl+FHBVR1u4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZLseMYIp9W0rxvFDH/VAZuwtH7tqFA+4borkS9S8MI+m3S2Tm+0VpmmM7MtvARqJF
	 W4/yvVKch22j+FjQqV/yuoZhpx08quQe9ql1REpy/x226FzLUu54MZalvxf03x/y9m
	 geOLi8lkiX3UPOYLARypRZuqCz9DE9zoDOmho7RirACzt4V/WOoDQiRptgwNg0e8RB
	 N927ATfXYQaxO60ajvGG/wHaeeSubfGKlAnwV1KvOQJSRpDaFg1KLzvrGNJUZpL0T6
	 ZIDCuEik6FMWJKkDMhLutqT6ewvAcboIs9peAZVcYwXtbhW/j1pLhUuQbAy6RgTMKr
	 TTn5fySWdRnqA==
Date: Fri, 22 Mar 2024 17:54:08 +0000
From: Conor Dooley <conor@kernel.org>
To: Allen_Lin <allencl_lin@hotmail.com>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	jikos@kernel.org, benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] dt-bindings: input: Add Himax HX83102J touchscreen
Message-ID: <20240322-mammary-boil-f9a4c347fba1@spud>
References: <20240322085606.993896-1-allencl_lin@hotmail.com>
 <TY0PR06MB56116F0902017225C78EDDDD9E312@TY0PR06MB5611.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hK1Zc8DPJQdpQOE2"
Content-Disposition: inline
In-Reply-To: <TY0PR06MB56116F0902017225C78EDDDD9E312@TY0PR06MB5611.apcprd06.prod.outlook.com>


--hK1Zc8DPJQdpQOE2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 04:56:03PM +0800, Allen_Lin wrote:
> Add the HX83102j touchscreen device tree bindings documents.
> HX83102j is a Himax TDDI touchscreen controller.
> It's power sequence should be bound with a lcm driver, thus it
> needs to be a panel follower. Others are the same as normal SPI
> touchscreen controller.
>=20
> Signed-off-by: Allen_Lin <allencl_lin@hotmail.com>

note to self/Krzysztof/Rob:
There was a previous attempt at this kind of device. This version looks
better but might be incomplete given there's a bunch more properties in
that patchset:
https://lore.kernel.org/all/20231017091900.801989-1-tylor_yang@himax.corp-p=
artner.google.com/

> ---
>  .../input/touchscreen/himax,hx83102j.yaml     | 73 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/h=
imax,hx83102j.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/himax,hx=
83102j.yaml b/Documentation/devicetree/bindings/input/touchscreen/himax,hx8=
3102j.yaml
> new file mode 100644
> index 000000000000..6c0a1ebf8d91
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/himax,hx83102j.=
yaml
> @@ -0,0 +1,73 @@
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
> +  spi-cpha: true
> +
> +  spi-cpol: true
> +
> +  spi-max-frequency: true
> +
> +  panel: true
> +
> +  himax,pid:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      PID for HID device, used to load correct firmware.

One thing I did comment on that old patchset is why you cannot just use
firmware-name here?

Cheers,
Conor.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - reset-gpios
> +  - panel
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
>

--hK1Zc8DPJQdpQOE2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZf3FwAAKCRB4tDGHoIJi
0gyYAP9Md446e439eml8dXX9grwTZoejgH0BhgAAWh8Q7P4ATwEA3PgLj7r0Tl9p
tDry6VYILvNuLKpI13WhewztAPskIAk=
=PNnb
-----END PGP SIGNATURE-----

--hK1Zc8DPJQdpQOE2--

