Return-Path: <linux-kernel+bounces-60500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A56DA8505C1
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 18:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6318D2855EA
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83845D46B;
	Sat, 10 Feb 2024 17:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZwDDv0f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5A95C8E8;
	Sat, 10 Feb 2024 17:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707586836; cv=none; b=ACwM1j/7kNi1nOgMt195EeD+sG0IpqI0UPZ6SGicTLixaPQIdBqmekfSgJWM5VurzVu+dJf0Ue+qu92VPQtD35j1uBO3aqsHukUy1uUV7lWOWOSSvjsvj6Cps1lHSaSK336kuuIpH0UxRXewsqi16J6z3DXSLJkUFUG55rbeNAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707586836; c=relaxed/simple;
	bh=Fc8diulIWuhCb0amP63B4SrZUV50n4/GYqCpyB1sdBc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DzMxwNgRV1jwRNEWLSXJXzp78loa+sK8eYZtaIYvhST+3nM01zML+8NzonDnKocuomaDggZDBRubC+1gPemnZ2M5YGfx7RPMKWlJsU3CtY0vipG/EWfDVQsxrFL4wwTdoYXtpmsx6bdX2CPjW/T656sdO5U+kvh7Kv+Xo8DwXxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZwDDv0f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1882C433F1;
	Sat, 10 Feb 2024 17:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707586835;
	bh=Fc8diulIWuhCb0amP63B4SrZUV50n4/GYqCpyB1sdBc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CZwDDv0fz1QceWKOQvulnjHT8apcZf832Tx54pyWGwNAl7z9r8DcuPEFW/LEkQgsM
	 rmNfRgJg46rYEPQYnY3dSvErzklMppheYz5atgoThjbDFIPf8UK2W7boKqo8bDFaXY
	 AlASG0soSQOHJz8F0q38tPIh5CqVs/TOFju3W69YZUFH4sxDiQdUrmUAyLB4X3RXit
	 beeROIdGJH8M803BWzviB/1Wkdan3LJWMlQsQ3y7cbmci5VP1Sgs5tRnxohUldnkd3
	 EqJDwObJ4/rjOmJc8m/iGfBZFypTZVlf0+UAq67RvM6usGJZaBXjeibylN8zSdpSe9
	 2aECyXvK+wSGQ==
Date: Sat, 10 Feb 2024 17:40:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: add ad7944 ADCs
Message-ID: <20240210174022.7a0c7cdc@jic23-huawei>
In-Reply-To: <20240206-ad7944-mainline-v1-1-bf115fa9474f@baylibre.com>
References: <20240206-ad7944-mainline-v1-0-bf115fa9474f@baylibre.com>
	<20240206-ad7944-mainline-v1-1-bf115fa9474f@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue,  6 Feb 2024 11:25:59 -0600
David Lechner <dlechner@baylibre.com> wrote:

> This adds a new binding for the Analog Devices, Inc. AD7944, AD7985, and
> AD7986 ADCs.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Hi David,

Some tricky corners...
3-wire here for example doesn't mean what I at least expected it to.

> ---
>  .../devicetree/bindings/iio/adc/adi,ad7944.yaml    | 231 +++++++++++++++=
++++++
>  MAINTAINERS                                        |   8 +
>  2 files changed, 239 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml
> new file mode 100644
> index 000000000000..a023adbeba42
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml
> @@ -0,0 +1,231 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7944.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices PulSAR LFCSP Analog to Digital Converters
> +
> +maintainers:
> +  - Michael Hennerich <Michael.Hennerich@analog.com>
> +  - Nuno S=C3=A1 <nuno.sa@analog.com

I hope Nuno + Michael will ack this. Bit mean to drop them in it otherwise
(funny though :)

> +
> +description: |
> +  A family of pin-compatible single channel differential analog to digit=
al
> +  converters with SPI support in a LFCSP package.
> +
> +  * https://www.analog.com/en/products/ad7944.html
> +  * https://www.analog.com/en/products/ad7985.html
> +  * https://www.analog.com/en/products/ad7986.html
> +
> +$ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7944
> +      - adi,ad7985
> +      - adi,ad7986
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 111111111

So 9ns for 3-write and 4-wire, but I think it's 11ns for chained.
Maybe it's not worth constraining that.

> +
> +  spi-cpha: true
> +
> +  adi,spi-mode:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [ 3-wire, 4-wire, chain ]
> +    default: 4-wire
> +    description:
> +      This chip can operate in a 3-wire mode where SDI is tied to VIO, a=
 4-wire
> +      mode where SDI acts as the CS line, or a chain mode where SDI of o=
ne chip
> +      is tied to the SDO of the next chip in the chain and the SDI of th=
e last
> +      chip in the chain is tied to GND.

there is a standard property in spi-controller.yaml for 3-wire. Does that c=
over
the selection between 3-wire and 4-wire here?  Seems like this might behave
differently from that (and so perhaps we shouldn't use 3-wire as the descri=
ption
to avoid confusion, normally 3-wire is a half duplex link I think).

Chain mode is more fun.  We've had that before and I'm trying to remember w=
hat
the bindings look like. Devices like ad7280a do a different form of chainin=
g.

Anyhow, main thing here is we need to be careful that the terms don't overl=
ap
with other possible interpretations.

I think what this really means is:

3-wire - no chip select, exclusive use of the SPI bus (yuk)
4-write - conventional SPI with CS
chained - the 3 wire mode really but with some timing effects?

Can we figure out if chained is going on at runtime?







> +
> +  avdd-supply:
> +    description: A 2.5V supply that powers the analog circuitry.
> +
> +  dvdd-supply:
> +    description: A 2.5V supply that powers the digital circuitry.
> +
> +  vio-supply:
> +    description:
> +      A 1.8V to 2.7V supply for the digital inputs and outputs.
> +
> +  bvdd-supply:
> +    description:
> +      A voltage supply for the buffered power. When using an external re=
ference
> +      without an internal buffer (PDREF high, REFIN low), this should be
> +      connected to the same supply as ref-supply. Otherwise, when using =
an
> +      internal reference or an external reference with an internal buffe=
r, this
> +      is connected to a 5V supply.
> +
> +  ref-supply:
> +    description:
> +      Voltage regulator for the reference voltage (REF). This property is
> +      omitted when using an internal reference.
> +
> +  refin-supply:
> +    description:
> +      Voltage regulator for the reference buffer input (REFIN). When usi=
ng an
> +      external buffer with internal reference, this should be connected =
to a
> +      1.2V external reference voltage supply.
> +
> +  adi,reference:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [ internal, internal-buffer, external ]

I'm a bit lost on this one - but think we can get rid of it in favour of us=
ing
the fact someone wired up the supplies to indicate their intent?

> +    default: internal
> +    description: |
> +      This property is used to specify the reference voltage source.
> +
> +      * internal: PDREF is wired low. The internal 4.096V reference volt=
age is
> +        used. The REF pin outputs 4.096V and REFIN outputs 1.2V.

So if neither refin-supply or ref-supply is present then this is the one to=
 use.

> +      * internal-buffer: PDREF is wired high. REFIN is supplied with 1.2=
V. The
> +        buffered internal 4.096V reference voltage is used. The REF pin =
outputs
> +        4.096V.

So if refin-supply is supplied this is the expected choice?

> +      * external: PDREF is wired high and REFIN is wired low. The supply
> +        connnected the REF pin is used as the reference voltage.

So if a ref-supply is provided this is expected choice?

If we are going to rule you supplying refin and ref supplies.=20

> +
> +  cnv-gpios:
> +    description:
> +      The Convert Input (CNV). This input has multiple functions. It ini=
tiates
> +      the conversions and selects the SPI mode of the device (chain or C=
S). In
> +      3-wire mode, this property is omitted if the CNV pin is connected =
to the
> +      CS line of the SPI controller.
> +    maxItems: 1

ah, that's exciting - so in 3-wire mode, we basically put the CS on a diffe=
rent pin...

Mark, perhaps you can suggest how to handle this complex family of spi vari=
ants?

Jonathan


