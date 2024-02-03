Return-Path: <linux-kernel+bounces-51138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 015FC8486FA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79E291F21F4D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A7C5DF2D;
	Sat,  3 Feb 2024 15:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="joSUV3VM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7910386;
	Sat,  3 Feb 2024 15:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706972945; cv=none; b=AVCqsaXv8vY6LAdficpg2bhP+29S+aXA7vfyh0DCYxWipz5+/IH95NsHFCp0PT1LJvg41Ktbec7IXdyyEn6+KlyGUIai+a90z+R+7bVzsSolwhFmyQRvqhn6Hx/xaQwDArbiyzcxfVPsE8DX1cCHZVnNIHQWco6joOhM5pwWsVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706972945; c=relaxed/simple;
	bh=n3DQeWHJWDUnE82O0BBKSEXBBTFwmxZR2bU3dokNRDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kykSz8ks2RCQ3noMKuDnIYi1m5cKgu/0ZX6A70hUvRMmEbgB3p0XP7Z8MhmRdsluWAqdLkJyFWR7CqKgnlSOT40xDWuqF8t79G15uHSUfvnJu4X1t/fAdEdxW9atjpWSPOseEUI2+K+ZxYt9jcLHf3GaF/DLuoVfu5fEbUzPKxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=joSUV3VM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CCEAC433F1;
	Sat,  3 Feb 2024 15:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706972944;
	bh=n3DQeWHJWDUnE82O0BBKSEXBBTFwmxZR2bU3dokNRDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=joSUV3VM4rycs/8+EsAkn7lP3I4OCEgqt2ns7lIRdED0K6MuzzofhIRoVC+/okzGn
	 h2tSZcGOQ/ImpmRhUNDtjcXgEekW/dCsf4sxU6THHrXqKoX4p45YcpistEcNgWRHkr
	 eG76v8xhQJPMi+3mKYz1fD5k5GZ8tIcwg3sekctRm+0DG+EF6qR+vYzTmV+QNxmRn3
	 XkHIme5Ojf+GZE1ONq2wiN1yMj7QPFsMHFd6psU5HphGPF+75cvbwQjGsXfNCATfvq
	 3VygN4Tn4qLmc04Nlwtq/+/d7HY8cqtHRMobhbXCPHCq5cYitzAkkCdRtJ0G9JfKVB
	 x69x7aOqw4dcQ==
Date: Sat, 3 Feb 2024 15:08:59 +0000
From: Conor Dooley <conor@kernel.org>
To: Josua Mayer <josua@solid-run.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v4 2/5] dt-bindings: rtc: abx80x: convert to yaml
Message-ID: <20240203-prolonged-backfield-c659e0016d70@spud>
References: <20240202-add-am64-som-v4-0-5f8b12af5e71@solid-run.com>
 <20240202-add-am64-som-v4-2-5f8b12af5e71@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="17xXMyX9vB+FnccJ"
Content-Disposition: inline
In-Reply-To: <20240202-add-am64-som-v4-2-5f8b12af5e71@solid-run.com>


--17xXMyX9vB+FnccJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Fri, Feb 02, 2024 at 05:10:49PM +0100, Josua Mayer wrote:
> Convert the abracon abx80x rtc text bindings to dt-schema format.
>=20
> In addition to the text description reference generic interrupts
> properties and add an example.
>=20
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
>  .../devicetree/bindings/rtc/abracon,abx80x.txt     | 31 ---------
>  .../devicetree/bindings/rtc/abracon,abx80x.yaml    | 74 ++++++++++++++++=
++++++
>  2 files changed, 74 insertions(+), 31 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/rtc/abracon,abx80x.txt b/D=
ocumentation/devicetree/bindings/rtc/abracon,abx80x.txt
> deleted file mode 100644
> index 2405e35a1bc0..000000000000
> --- a/Documentation/devicetree/bindings/rtc/abracon,abx80x.txt
> +++ /dev/null
> @@ -1,31 +0,0 @@
> -Abracon ABX80X I2C ultra low power RTC/Alarm chip
> -
> -The Abracon ABX80X family consist of the ab0801, ab0803, ab0804, ab0805,=
 ab1801,
> -ab1803, ab1804 and ab1805. The ab0805 is the superset of ab080x and the =
ab1805
> -is the superset of ab180x.
> -
> -Required properties:
> -
> - - "compatible": should one of:
> -        "abracon,abx80x"
> -        "abracon,ab0801"
> -        "abracon,ab0803"
> -        "abracon,ab0804"
> -        "abracon,ab0805"
> -        "abracon,ab1801"
> -        "abracon,ab1803"
> -        "abracon,ab1804"
> -        "abracon,ab1805"
> -        "microcrystal,rv1805"
> -	Using "abracon,abx80x" will enable chip autodetection.
> - - "reg": I2C bus address of the device
> -
> -Optional properties:
> -
> -The abx804 and abx805 have a trickle charger that is able to charge the
> -connected battery or supercap. Both the following properties have to be =
defined
> -and valid to enable charging:
> -
> - - "abracon,tc-diode": should be "standard" (0.6V) or "schottky" (0.3V)
> - - "abracon,tc-resistor": should be <0>, <3>, <6> or <11>. 0 disables th=
e output
> -                          resistor, the other values are in kOhm.
> diff --git a/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml b/=
Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml
> new file mode 100644
> index 000000000000..405b386a54b0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml
> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/abracon,abx80x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Abracon ABX80X I2C ultra low power RTC/Alarm chip
> +
> +maintainers:
> +  - devicetree@vger.kernel.org

Ideally you put someone here, not the DT list. Usually the original
author is a good choice, which I think happens to be the subsystem
maintainer... Failing that, the rtc subsystem list is likely a better
choice than the DT one.

> +
> +allOf:
> +  - $ref: rtc.yaml#

> +  - $ref: /schemas/interrupts.yaml#

This should not be need.

> +
> +properties:
> +  compatible:
> +    description:
> +      Select a specific compatible chip.

I'd drop this line.

> +      'abracon,abx80x' has special meaning,
> +      it provides auto-dection based on ID register.

And reword this. The compatible itself does not provide auto-detection,
it's the opposite - the driver must perform auto detection if this
compatible is used.

> +    enum:
> +      - abracon,abx80x
> +      - abracon,ab0801
> +      - abracon,ab0803
> +      - abracon,ab0804
> +      - abracon,ab0805
> +      - abracon,ab1801
> +      - abracon,ab1803
> +      - abracon,ab1804
> +      - abracon,ab1805
> +      - microcrystal,rv1805
> +
> +  reg:
> +    maxItems: 1
> +
> +  abracon,tc-diode:
> +    description:
> +      Trickle-charge diode type.
> +      Required to enable charging backup battery.
> +
> +      Supported are 'standard' diodes with a 0.6V drop
> +      and 'schottky' diodes with a 0.3V drop.
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum:
> +      - standard
> +      - schottky
> +
> +  abracon,tc-resistor:
> +    description:
> +      Trickle-charge resistor value in kOhm.
> +      Required to enable charging backup battery.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 3, 6, 11]
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    rtc@69 {
> +        compatible =3D "abracon,abx80x";
> +        reg =3D <0x69>;

You'll have to make a "fake" i2c bus here to satisfy the tooling. There
should be lots of examples for how to do this in other rtc bindings.

Thanks,
Conor.

> +        abracon,tc-diode =3D "schottky";
> +        abracon,tc-resistor =3D <3>;
> +        interrupt-parent =3D <&fake_intc0>;
> +        interrupts =3D <44 IRQ_TYPE_EDGE_FALLING>;
> +    };
>=20
> --=20
> 2.35.3
>=20

--17xXMyX9vB+FnccJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZb5XCwAKCRB4tDGHoIJi
0irkAQCbUpXTrsuLcaoIcKjhRCjmidmeJEVH0ydbqhZIFCeipQD9GXWfXGxujmRu
u+QORduBHw9wvIq0cTbVb8HcQlZ5TAE=
=ZE4k
-----END PGP SIGNATURE-----

--17xXMyX9vB+FnccJ--

