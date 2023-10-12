Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631337C6882
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 10:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbjJLIOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 04:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347168AbjJLHkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 03:40:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B066C6;
        Thu, 12 Oct 2023 00:40:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F495C433C9;
        Thu, 12 Oct 2023 07:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697096439;
        bh=0Rn088LHnsdYyxB8Znmpt/PKMoKR1yv7/AnlS4kFNZs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GUgvkoNdu9WgJT4UiNjOtxQUD3smEPuiG1qOxIjir9BXhZgcUb9DjcxOKWbSCep3O
         Y7DAfg4su382i1oE/wmENZw8umedyDEB2AYiSelY8gCWOSdF1Uzspv9WMsQFtuhRGm
         w7F2E/BCcflH5BLHmTy3w2kC6og45KcW6wXSANOxHKCcDydBXaw6hQ+ZojBX4OfGsc
         sQiZ0SrPGorLmYp9QOH6Uswy+uMm5dFFfHpzE/3ueqBSuVAT+OiGfxmH25W5ehlGUf
         AxwlBOEQVEwz6dg6M25qGw0OcabS2gWAuWYHLpCvibhO9i1OkZfu6zraSuAScGhiCH
         YhKrkzEGibRzQ==
Date:   Thu, 12 Oct 2023 08:40:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ivan Mikhaylov <fr0st61te@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: adc: provide max34408/9 device tree
 binding document
Message-ID: <20231012084052.504ac930@jic23-huawei>
In-Reply-To: <383064a5b0863a4a616cd60cff8d4bc18e397fd7.camel@gmail.com>
References: <20231007234838.8748-1-fr0st61te@gmail.com>
        <20231007234838.8748-2-fr0st61te@gmail.com>
        <20231010154042.2ef667b2@jic23-huawei>
        <383064a5b0863a4a616cd60cff8d4bc18e397fd7.camel@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2023 23:22:48 +0300
Ivan Mikhaylov <fr0st61te@gmail.com> wrote:

> On Tue, 2023-10-10 at 15:40 +0100, Jonathan Cameron wrote:
> > On Sun,=C2=A0 8 Oct 2023 02:48:37 +0300
> > Ivan Mikhaylov <fr0st61te@gmail.com> wrote:
> >  =20
> > > The hardware binding for i2c current monitoring device with
> > > overcurrent
> > > control.
> > >=20
> > > Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
> > > ---
> > > =C2=A0.../bindings/iio/adc/maxim,max34408.yaml=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 141
> > > ++++++++++++++++++
> > > =C2=A01 file changed, 141 insertions(+)
> > > =C2=A0create mode 100644
> > > Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
> > >=20
> > > diff --git
> > > a/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
> > > b/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
> > > new file mode 100644
> > > index 000000000000..9749f1fd1802
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
> > > @@ -0,0 +1,141 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/adc/maxim,max34408.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Two- and four-channel current monitors with overcurrent
> > > control
> > > +
> > > +maintainers:
> > > +=C2=A0 - Ivan Mikhaylov <fr0st61te@gmail.com>
> > > +
> > > +description: |
> > > +=C2=A0 The MAX34408/MAX34409 are two- and four-channel current monit=
ors
> > > that are
> > > +=C2=A0 configured and monitored with a standard I2C/SMBus serial
> > > interface. Each
> > > +=C2=A0 unidirectional current sensor offers precision high-side
> > > operation with a
> > > +=C2=A0 low full-scale sense voltage. The devices automatically seque=
nce
> > > through
> > > +=C2=A0 two or four channels and collect the current-sense samples and
> > > average them
> > > +=C2=A0 to reduce the effect of impulse noise. The raw ADC samples are
> > > compared to
> > > +=C2=A0 user-programmable digital thresholds to indicate overcurrent
> > > conditions.
> > > +=C2=A0 Overcurrent conditions trigger a hardware output to provide an
> > > immediate
> > > +=C2=A0 indication to shut down any necessary external circuitry.
> > > +
> > > +=C2=A0 Specifications about the devices can be found at:
> > > +=C2=A0
> > > https://www.analog.com/media/en/technical-documentation/data-sheets/M=
AX34408-MAX34409.pdf
> > > +
> > > +properties:
> > > +=C2=A0 compatible:
> > > +=C2=A0=C2=A0=C2=A0 enum:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - maxim,max34408
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - maxim,max34409
> > > +
> > > +=C2=A0 "#address-cells":
> > > +=C2=A0=C2=A0=C2=A0 const: 1
> > > +
> > > +=C2=A0 "#size-cells":
> > > +=C2=A0=C2=A0=C2=A0 const: 0
> > > +
> > > +=C2=A0 reg:
> > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > +
> > > +=C2=A0 interrupts:
> > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > +
> > > +=C2=A0 powerdown-gpios:
> > > +=C2=A0=C2=A0=C2=A0 description:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Shutdown Output. Open-drain output. T=
his output transitions
> > > to high impedance
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 when any of the digital comparator th=
resholds are exceeded
> > > as long as the ENA
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pin is high.
> > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > +
> > > +=C2=A0 shtdn-enable-gpios: =20
> >=20
> > I guess the review crossed with you sending v5.=C2=A0 There is some
> > feedback on v4 you need
> > to address here. =20
>=20
> Jonathan, I thought I did, I've changed ena to powerdown-gpios from
> Krzysztof's comments but about this one pin I'm still not sure, it
> looks like *-enable-gpios (like in *-enable-gpios pins in
> iio/frequency/adi,adf4377.yaml) pin or is it not? Or maybe any other
> suggestions about naming of this one?
>=20
> Thanks.

shutdown-gpios and make the sense (active high / low) such that setting
it results in teh device being shut down.
Or treat it as an enable and enable-gpios

Something that indicates both shutdown and enable is confusing ;)

Jonathan


>=20
> >  =20
> > > +=C2=A0=C2=A0=C2=A0 description:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SHTDN Enable Input. CMOS digital inpu=
t. Connect to GND to
> > > clear the latch and
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unconditionally deassert (force low) =
the SHTDN output and
> > > reset the shutdown
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 delay. Connect to VDD to enable norma=
l latch operation of
> > > the SHTDN output.
> > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > +
> > > +=C2=A0 vdd-supply: true
> > > +
> > > +patternProperties:
> > > +=C2=A0 "^channel@[0-3]$":
> > > +=C2=A0=C2=A0=C2=A0 $ref: adc.yaml
> > > +=C2=A0=C2=A0=C2=A0 type: object
> > > +=C2=A0=C2=A0=C2=A0 description:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Represents the internal channels of t=
he ADC.
> > > +
> > > +=C2=A0=C2=A0=C2=A0 properties:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minimum: 0
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maximum: 3
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxim,rsense-val-micro-ohms:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Adjust the Rs=
ense value to monitor higher or lower
> > > current levels for
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 input.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum: [250, 500, 1000, 50=
00, 10000, 50000, 100000, 200000,
> > > 500000]
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default: 1000
> > > +
> > > +=C2=A0=C2=A0=C2=A0 required:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - reg
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - maxim,rsense-val-micro-ohms
> > > +
> > > +=C2=A0=C2=A0=C2=A0 unevaluatedProperties: false
> > > +
> > > +required:
> > > +=C2=A0 - compatible
> > > +=C2=A0 - reg
> > > +
> > > +allOf:
> > > +=C2=A0 - if:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 contains:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
onst: maxim,max34408
> > > +=C2=A0=C2=A0=C2=A0 then:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 patternProperties:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "^channel@[2-3]$": false
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "^channel@[0-1]$":
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eg:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 minimum: 0
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 maximum: 1
> > > +=C2=A0=C2=A0=C2=A0 else:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 patternProperties:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "^channel@[0-3]$":
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eg:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 minimum: 0
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 maximum: 3
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +=C2=A0 - |
> > > +=C2=A0=C2=A0=C2=A0 #include <dt-bindings/gpio/gpio.h>
> > > +
> > > +=C2=A0=C2=A0=C2=A0 i2c {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #address-cells =3D <1>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =3D <0>;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adc@1e {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 compatible =3D "maxim,max34409";
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 reg =3D <0x1e>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 powerdown-gpios =3D <&gpio0 1 GPIO_ACTIVE_LOW>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 shtdn-enable-gpios =3D <&gpio0 2 GPIO_ACTIVE_HIGH>;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 #address-cells =3D <1>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 #size-cells =3D <0>;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 channel@0 {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x0>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxim,rsense-val-micro-ohms =3D <5000>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 };
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 channel@1 {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x1>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxim,rsense-val-micro-ohms =3D <10000=
>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 };
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > > +=C2=A0=C2=A0=C2=A0 }; =20
> >  =20
>=20

