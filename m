Return-Path: <linux-kernel+bounces-148736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5458A86C7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDE2E1F2220F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71B41422A4;
	Wed, 17 Apr 2024 14:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gm94Q50I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9A7132807;
	Wed, 17 Apr 2024 14:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713365645; cv=none; b=GkYrGZVnAz7t60yd22CLnoicibwG/xi6fhZn+a4JWjb90F9t4ZgIAgkFMN4Z1vdDASncnT81GtKegi0WXsk2RqtbuGw86Lz+dglIfiTazp4b5HGr+9RgmWydDkAm7g9zPlhphzabMwlJ8R5uQ9Gct7Z2FQJozvfsoiYBmoeWjKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713365645; c=relaxed/simple;
	bh=KXoRcIdsjepxSU6ZzJ4NvcTWctTLBqKZBlDxeAr8ABI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWob64/V4l2D0/oq/MkW5LdMVl1dYPLYogSnrcdHoD0fLqyAlFlJ3xeelGmNv0uWBtgr1inONLnl6vgckRCmoPLHgYTuWRq+MF/MXkedyE3Dq0FwxbWT9VN3Nlnhy314Rwq2hnfo9poQVbY5pgf5D/vt7CNKwcD8rc2qlhVvkBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gm94Q50I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB8CC072AA;
	Wed, 17 Apr 2024 14:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713365644;
	bh=KXoRcIdsjepxSU6ZzJ4NvcTWctTLBqKZBlDxeAr8ABI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gm94Q50I1K8dNBm81Zb/69btVaVgZXrO+r9ncFacD1fPL1GgkThbxsp1pVL6AGRDQ
	 KzUKo56OiWKmYKkOTQOxnH0zu41LIHJ284kQR11uM5yqR1KFv6fKHwdzBi3Md+J0qK
	 mOBtuRQOjEpZHjAyVxCx0dcjTpaGaULJh4V8aI9TPVpcg0zXiwsgDpIleIh+3RnRa4
	 M4/Eg2q5IgEHETq5LvwQKarykXUyrMRmL3GK8AWxFbBI/LHg0JQjWkQ8xoMFbIZOGB
	 Ra0ebBzm54lQ+mlZxk1/uBE57SN3V3g+vDd9sbhTT23PwNAplzps4b3/WNfAzNoAsi
	 MiDxnEBesu2cw==
Date: Wed, 17 Apr 2024 15:53:59 +0100
From: Conor Dooley <conor@kernel.org>
To: Pratik Farkase <pratikfarkase94@gmail.com>
Cc: Pratik Farkase <pratik.farkase@wsisweden.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Stefan Wahren <wahrenst@gmx.net>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: serial: brcm,bcm2835-aux-uart: convert
 to dtschema
Message-ID: <20240417-obscure-denial-ae7c53d0e321@spud>
References: <20240417135111.20375-1-pratik.farkase@wsisweden.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="knnuLnAQI4vYAM9c"
Content-Disposition: inline
In-Reply-To: <20240417135111.20375-1-pratik.farkase@wsisweden.com>


--knnuLnAQI4vYAM9c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 03:51:10PM +0200, Pratik Farkase wrote:
> Convert the Broadcom BCM2835 Auxiliary UART to newer DT schema.
> Created DT schema based on the .txt file which had
> `compatible`, `reg` `clocks` and `interrupts` as the
> required properties. This binding is used by Broadcom BCM2835
> SOC used in some Raspberry PI boards.
> Changes from original file:
> Implemented complete example which the original txt binding lacked.
>=20
> Signed-off-by: Pratik Farkase <pratik.farkase@wsisweden.com>
> ---
> Changes in v2
> - Updated Maintainers list according to feedback
> - Fixed typo `Auxiliar` to `Auxiliary`
> ---
> ---
>  .../bindings/serial/brcm,bcm2835-aux-uart.txt | 18 -------
>  .../serial/brcm,bcm2835-aux-uart.yaml         | 48 +++++++++++++++++++
>  2 files changed, 48 insertions(+), 18 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/brcm,bcm2835=
-aux-uart.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/brcm,bcm2835=
-aux-uart.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/serial/brcm,bcm2835-aux-ua=
rt.txt b/Documentation/devicetree/bindings/serial/brcm,bcm2835-aux-uart.txt
> deleted file mode 100644
> index b5cc6297cd1b..000000000000
> --- a/Documentation/devicetree/bindings/serial/brcm,bcm2835-aux-uart.txt
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -* BCM2835 AUXILIAR UART
> -
> -Required properties:
> -
> -- compatible: "brcm,bcm2835-aux-uart"
> -- reg: The base address of the UART register bank.
> -- interrupts: A single interrupt specifier.
> -- clocks: Clock driving the hardware; used to figure out the baud rate
> -  divisor.
> -
> -Example:
> -
> -	uart1: serial@7e215040 {
> -		compatible =3D "brcm,bcm2835-aux-uart";
> -		reg =3D <0x7e215040 0x40>;
> -		interrupts =3D <1 29>;
> -		clocks =3D <&aux BCM2835_AUX_CLOCK_UART>;
> -	};
> diff --git a/Documentation/devicetree/bindings/serial/brcm,bcm2835-aux-ua=
rt.yaml b/Documentation/devicetree/bindings/serial/brcm,bcm2835-aux-uart.ya=
ml
> new file mode 100644
> index 000000000000..5d4d37371d6b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/brcm,bcm2835-aux-uart.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/brcm,bcm2835-aux-uart.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: BCM2835 AUXILIARY UART
> +
> +maintainers:
> +  - Pratik Farkase <pratikfarkase94@gmail.com>
> +  - Florian Fainelli <florian.fainelli@broadcom.com>
> +  - Stefan Wahren <wahrenst@gmx.net>
> +
> +allOf:
> +  - $ref: serial.yaml
> +
> +properties:
> +  compatible:
> +    const: brcm,bcm2835-aux-uart
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/bcm2835.h>
> +    #include <dt-bindings/clock/bcm2835-aux.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>

Only 1 of these headers seems used, there's only one define below.

> +    uart1: serial@7e215040 {

The label is unused and can be dropped.

Otherwise,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>


> +        compatible =3D "brcm,bcm2835-aux-uart";
> +        reg =3D <0x7e215040 0x40>;
> +        interrupts =3D <1 29>;
> +        clocks =3D <&aux BCM2835_AUX_CLOCK_UART>;
> +    };
> --=20
> 2.34.1
>=20

--knnuLnAQI4vYAM9c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZh/ihwAKCRB4tDGHoIJi
0imwAP9/Is48Rdr8Ve/PrA6TGNes1do/R5ztpGZ9dIDeSWgULQEAiUqD0ir6iPVP
x6UGbzh4csXpoErw8rW9Z1s6E1VC7wU=
=kk4e
-----END PGP SIGNATURE-----

--knnuLnAQI4vYAM9c--

