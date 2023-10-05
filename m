Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD0E7BA651
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbjJEQdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237125AbjJEQcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:32:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8EE29B30;
        Thu,  5 Oct 2023 08:38:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34DDC433C7;
        Thu,  5 Oct 2023 15:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696520320;
        bh=xqrKx4Kd9+GEwmVN2AFDTKEreQZrRE6Wy71JqH75+OE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LqCYd0wShQEfQ34aCPNRYpG9e1rGe5FNRozfs/5sOKIA7TYVUgPTcijdTj55JFWfQ
         auvuso6FRNRvidbRggXlLxtCwXiF4iNXlwfJGvSsgs/hO/3op6t1hPMIONqaXIrZ2w
         Q2mv8hKik9Ebvlu064LHGgiEYBub0T7YobcTM+ShQ4zVSJljVfhHsn+FnEEg/UkAaR
         BrErZ1FXfwVsWQNVbdO755cLE4C3aM6wzbhZZHZouxWn1O/C4XMTe0UnflQ14xMm1W
         Tx4Z1/aYWNgLgnxbBIfmbcjKn39eOQGviAjTdvZ0M81mTSMbXkfuSyR4yo7ZkMzGHY
         8J1tjnGUqTqYQ==
Date:   Thu, 5 Oct 2023 16:38:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     werneazc <werneazc@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, lars@metafoo.de, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andre Werner <andre.werner@systec-electronic.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: ti,ads7038: Add description
 for ADS7038
Message-ID: <20231005163844.3294e4e1@jic23-huawei>
In-Reply-To: <CAKDJRcf4ikKWvENrg=9JW1EneY8qehD8HTxahL8x+5KxoCSQ0g@mail.gmail.com>
References: <20231004102330.3713-1-andre.werner@systec-electronic.com>
        <20231004151150.GA3140591-robh@kernel.org>
        <CAKDJRcf4ikKWvENrg=9JW1EneY8qehD8HTxahL8x+5KxoCSQ0g@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2023 05:51:40 +0200
werneazc <werneazc@gmail.com> wrote:

> Dear Mr. Herring,
>=20
> On Wed, Oct 4, 2023 at 5:11=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:
> >
> > On Wed, Oct 04, 2023 at 12:23:29PM +0200, werneazc@gmail.com wrote: =20
> > > From: Andre Werner <andre.werner@systec-electronic.com>
> > > =20
> >
> > Needs a commit message. =20
>=20
> Added in an upcoming commit.
>=20
> > =20
> > > Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
> > > ---
> > >  .../bindings/iio/adc/ti,ads7038.yaml          | 51 +++++++++++++++++=
++
> > >  1 file changed, 51 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads7=
038.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads7038.yam=
l b/Documentation/devicetree/bindings/iio/adc/ti,ads7038.yaml
> > > new file mode 100644
> > > index 000000000000..37fbae95c8e6
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads7038.yaml
> > > @@ -0,0 +1,51 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/adc/ti,ads7038.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Texas Instruments ADS7038 and similar ADCs
> > > +
> > > +maintainers:
> > > +  - Andre Werner <andre.werner@systec-electronic.com>
> > > +
> > > +description: |
> > > +  Family of 7 channel, 12 bit ADCs with SPI/I2C interface.
> > > +
> > > +  Datasheet: https://www.ti.com/lit/gpn/ads7038
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - ti,ads7038
> > > +      - ti,ads7138
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  spi-max-frequency:
> > > +    maximum: 60000000
> > > +
> > > +  vref-supply:
> > > +    description: Supplies the 2.5V or 5V reference voltage =20
> >
> > I don't see that in the datasheet. It has AVDD and DVDD. =20
>=20
> Yes, that was a copy-and-paste error from another description used as
> a template.
>=20
> >
> > Also, looks like there are GPIOs. Those aren't ever exposed to the OS? =
=20
>=20
> Yes, you are right. This is a fundamental implementation of the driver
> to support the chip family. I want to add further functionalities in
> upcoming commits.
> I wanted to get some feedback when the first steps are done to not
> reinvent everything from the beginning if something is generally
> wrong in the driver structure and the way I had used the APIs.

Device tree binding should fully describe the hardware, not what
the driver currently implements.

So add the GPIOs for v3.
>=20
> > =20
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - vref-supply
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    spi {
> > > +        #address-cells =3D <1>;
> > > +        #size-cells =3D <0>;
> > > +
> > > +        adc@0 {
> > > +            compatible =3D "ti,ads7038";
> > > +            reg =3D <0>;
> > > +            vref-supply =3D <&refin_supply>;
> > > +            spi-max-frequency =3D <10000000>;
> > > +        };
> > > +    };
> > > --
> > > 2.42.0
> > > =20
>=20
> Regards,
>=20
> Andr=C3=A9

