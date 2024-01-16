Return-Path: <linux-kernel+bounces-27575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B7582F26B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4FEB285AC2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006D2747F;
	Tue, 16 Jan 2024 16:30:18 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBABECC;
	Tue, 16 Jan 2024 16:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TDvYW53HJz67vyB;
	Wed, 17 Jan 2024 00:27:27 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 2F8E6140135;
	Wed, 17 Jan 2024 00:30:05 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 16 Jan
 2024 16:30:04 +0000
Date: Tue, 16 Jan 2024 16:30:03 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: David Lechner <dlechner@baylibre.com>
CC: Dumitru Ceclan <mitrutzceclan@gmail.com>, <linus.walleij@linaro.org>,
	<brgl@bgdev.pl>, <andy@kernel.org>, <linux-gpio@vger.kernel.org>, "Lars-Peter
 Clausen" <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Michael Walle <michael@walle.cc>, Andy Shevchenko
	<andy.shevchenko@gmail.com>, Arnd Bergmann <arnd@arndb.de>, ChiaEn Wu
	<chiaen_wu@richtek.com>, Niklas Schnelle <schnelle@linux.ibm.com>, Leonard
 =?ISO-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>, Mike Looijmans
	<mike.looijmans@topic.nl>, Haibo Chen <haibo.chen@nxp.com>, Hugo Villeneuve
	<hvilleneuve@dimonoff.com>, Ceclan Dumitru <dumitru.ceclan@analog.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 1/2] dt-bindings: adc: add AD7173
Message-ID: <20240116163003.0000039d@Huawei.com>
In-Reply-To: <CAMknhBELp3NQEHE16gHhC96bttoafQOGxx3a_dLZn9o2Ru7y9g@mail.gmail.com>
References: <20231220104810.3179-1-mitrutzceclan@gmail.com>
	<CAMknhBELp3NQEHE16gHhC96bttoafQOGxx3a_dLZn9o2Ru7y9g@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 15 Jan 2024 15:53:39 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On Wed, Dec 20, 2023 at 4:48=E2=80=AFAM Dumitru Ceclan <mitrutzceclan@gma=
il.com> wrote:
> >
> > The AD7173 family offer a complete integrated Sigma-Delta ADC solution
> > which can be used in high precision, low noise single channel applicati=
ons
> > or higher speed multiplexed applications. The Sigma-Delta ADC is intend=
ed
> > primarily for measurement of signals close to DC but also delivers
> > outstanding performance with input bandwidths out to ~10kHz.
> >
> > Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
> > --- =20
>=20
> Sorry for the late reply as I see this has been applied already but...
We have plenty of time.  Rather than dropping the ad7173 from my tree,
I'd prefer to see additional patches on top to tidy up whatever
makes sense from David's feedback.

>=20
> (I've been going over the datasheets for these and other related parts
> (AD411x) in detail today so please CC me on future updates to the
> bindings/driver for these if you don't mind)
>=20
> >  .../bindings/iio/adc/adi,ad7173.yaml          | 188 ++++++++++++++++++
> >  1 file changed, 188 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad717=
3.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml =
b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> > new file mode 100644
> > index 000000000000..7c8caef76528
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> > @@ -0,0 +1,188 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright 2023 Analog Devices Inc.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/adi,ad7173.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices AD7173 ADC
> > +
> > +maintainers:
> > +  - Ceclan Dumitru <dumitru.ceclan@analog.com>
> > +
> > +description: |
> > +  Bindings for the Analog Devices AD717X ADC's. Datasheets for support=
ed chips:
> > +    https://www.analog.com/media/en/technical-documentation/data-sheet=
s/AD7172-2.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheet=
s/AD7173-8.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheet=
s/AD7175-2.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheet=
s/AD7176-2.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,ad7172-2
> > +      - adi,ad7173-8
> > +      - adi,ad7175-2
> > +      - adi,ad7176-2
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1 =20
>=20
> As discussed in v8 [1] it is not clear what signal this is. Based on
> that discussion, I'm assuming the RDY signal, but how would bindings
> consumers know that without a description since it is not the only
> digital output signal of the chip? And why the ERROR signal was
> omitted here was never addressed AFAICT.
>=20
> [1]: https://lore.kernel.org/linux-iio/20231217135007.3e5d959a@jic23-huaw=
ei/

I'd forgotten about that.  Adding interrupt-names would be the easiest
way to resolve this.

>=20
> > +
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 0
> > +
> > +  spi-max-frequency:
> > +    maximum: 20000000
> > + =20
>=20
> According to the timing diagram in the datasheet, SCLK is high during
> idle, so don't we need `spi-cpol: true` here?
>=20
> Likewise, data is valid on the trailing SCLK edge, so don't we need
> `spi-cpha: true` here?
>=20
>=20
> > +  gpio-controller:
> > +    description: Marks the device node as a GPIO controller.
> > +
> > +  "#gpio-cells":
> > +    const: 2
> > +    description:
> > +      The first cell is the GPIO number and the second cell specifies
> > +      GPIO flags, as defined in <dt-bindings/gpio/gpio.h>.
> > +
> > +  refin-supply:
> > +    description: external reference supply, can be used as reference f=
or conversion. =20
>=20
> If I'm understanding correctly, this represents both voltage inputs
> REF+ and REF-, correct? The datasheet says "Reference Input Negative
> Terminal. REF=E2=88=92 can span from AVSS to AVDD1 =E2=88=92 1 V". It see=
ms like they
> should be separate supplies in case REF- is non-zero. Otherwise, how
> can we know what voltage it is? (same comment applies to refin2.)

Agreed, in this case these are directly used as references (we recently
had another driver that could take a wide range of negative and positive
inputs but in that case an internal reference was generated that didn't
made it not matter exactly what was being supplied.  Not true here though!

>=20
> > +
> > +  refin2-supply:
> > +    description: external reference supply, can be used as reference f=
or conversion.
> > +
> > +  avdd-supply:
> > +    description: avdd supply, can be used as reference for conversion.
> > +
> > +  avdd2-supply:
> > +    description: avdd2 supply, used as the input to the internal volta=
ge regulator.
> > +
> > +  iovdd-supply:
> > +    description: iovdd supply, used for the chip digital interface.
> > + =20
>=20
> I overlooked this before, but these chips also have an optional
> external clock input so it seems like they should have an optional
> clocks property as well.
>=20
> > +patternProperties:
> > +  "^channel@[0-9a-f]$":
> > +    type: object
> > +    $ref: adc.yaml
> > +    unevaluatedProperties: false
> > +
> > +    properties:
> > +      reg:
> > +        minimum: 0
> > +        maximum: 15
> > +
> > +      diff-channels:
> > +        items:
> > +          minimum: 0
> > +          maximum: 31
> > +
> > +      adi,reference-select:
> > +        description: |
> > +          Select the reference source to use when converting on
> > +          the specific channel. Valid values are:
> > +          refin      : REFIN(+)/REFIN(=E2=88=92).
> > +          refin2     : REFIN2(+)/REFIN2(=E2=88=92)
> > +          refout-avss: REFOUT/AVSS (Internal reference)
> > +          avdd       : AVDD
> > +
> > +          External reference refin2 only available on ad7173-8.
> > +          If not specified, internal reference used.
> > +        $ref: /schemas/types.yaml#/definitions/string
> > +        enum:
> > +          - refin
> > +          - refin2
> > +          - refout-avss
> > +          - avdd
> > +        default: refout-avss
> > +
> > +    required:
> > +      - reg
> > +      - diff-channels
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts =20
>=20
> Why are interrupts required? What if the pin is not connected?
>=20
Ah. I clearly failed to review this one closely enough.

Absolutely agree that interrupts should never be required.
No need for the driver to work if they aren't, but the binding
shouldn't require them!

Jonathan



