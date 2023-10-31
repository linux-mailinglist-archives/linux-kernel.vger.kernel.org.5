Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1EA7DCA2F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjJaJwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236105AbjJaJwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:52:18 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BBF1726;
        Tue, 31 Oct 2023 02:51:10 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 51809C0004;
        Tue, 31 Oct 2023 09:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698745869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FyjN8eHbYq37HQVccSWii8dO2ARTjErlZVWYsMFISx8=;
        b=UtvrJ5VFR7enY6TYyRjZ+MC0kyvTzg9fiJ/FQXHvebe44qetk8VZpyeKLIS/CmYSFqBV42
        mlFk/T5iDxapn4GaP9azgvw0de4clF/YQIBWztx3Yvr5A9FvaR7e6/9Qa39JsRtgdPYHrp
        7aGYE/zJcE1bkILvJti4atBxNWuLU8Z4Z6RGfPDYrUH9VYNwGyORZwvHjgiZQUHmFAPLmn
        dJ7GgZ1nQV1VdbLL7w1J5wE4ZLDw47n6Av8x4aDv9gR+ZHA1ZXc0Krnjb+HX353Q9tw1vv
        uN1fTIwYIrRyzbIN+bf2glV6SypYzE1iZKGtneHHlooBxZgo26bjLSvVxs0fMA==
Date:   Tue, 31 Oct 2023 10:51:07 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Mehdi Djait <mehdi.djait@bootlin.com>, mchehab@kernel.org,
        heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, maxime.chevallier@bootlin.com,
        michael.riesch@wolfvision.net
Subject: Re: [PATCH v9 1/3] media: dt-bindings: media: add bindings for
 Rockchip CIF
Message-ID: <ZUDOCywnEqJSuQMM@aptenodytes>
References: <cover.1698666612.git.mehdi.djait@bootlin.com>
 <5f83d60031320c4c7b0f0727604903f50ee49058.1698666612.git.mehdi.djait@bootlin.com>
 <20231030193236.GA1995060-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7fCeMisMgRBZQnBb"
Content-Disposition: inline
In-Reply-To: <20231030193236.GA1995060-robh@kernel.org>
X-GND-Sasl: paul.kocialkowski@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7fCeMisMgRBZQnBb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Mon 30 Oct 23, 14:32, Rob Herring wrote:
> On Mon, Oct 30, 2023 at 01:25:12PM +0100, Mehdi Djait wrote:
> > Add a documentation for the Rockchip Camera Interface
> > binding.
> >=20
> > Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
> > ---
> > v8=3D>v9:
> > dropped the "Reviewed-by: Rob Herring <robh@kernel.org>"
> > because of the following changes:
> > - changed the compatible to rk3066-cif: rk3066 is the earliest Rockchip=
 SoC
> >   that uses cif and it is the first model starting the RK30 lineup.
>=20
> Is px30 compatible with rk3066? It's not clear because you didn't add=20
> rk3066 support. If not compatible, then add rk3066 when you have a user.=
=20
> If it is compatible, then you should have a fallback for px30.

Just to clarify here: we haven't checked that rk3066 uses the exact same
programming model as px30 (so there should be no fallback compatible), but =
it
is definitely the same unit (in a different version).

Since the yaml binding document will apply to all generations of the unit,
the name of the file should be the first generation (rk3066) instead of the
px30 which is just one of the many iterations of the unit.

It would be both confusing and irrelevant to pick px30 just because it happ=
ens
to be the first generation supported in the Linux driver (and described in
the binding).

Cheers,

Paul

> > - adjusted the description
> > - changed the node name to video-capture
> >=20
> >=20
> >  .../bindings/media/rockchip,rk3066-cif.yaml   | 96 +++++++++++++++++++
> >  1 file changed, 96 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/rockchip,rk=
3066-cif.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/media/rockchip,rk3066-ci=
f.yaml b/Documentation/devicetree/bindings/media/rockchip,rk3066-cif.yaml
> > new file mode 100644
> > index 000000000000..be69e474ed26
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/rockchip,rk3066-cif.yaml
> > @@ -0,0 +1,96 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/media/rockchip,rk3066-cif.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Rockchip CIF Camera Interface
> > +
> > +maintainers:
> > +  - Mehdi Djait <mehdi.djait@bootlin.com>
> > +
> > +description: |
>=20
> Don't need '|'
>=20
> > +  CIF is a camera interface present on some rockchip SoCs. It
> > +  receives the data from Camera sensor or CCIR656 encoder and
> > +  transfers it into system main memory by AXI bus.
>=20
> Wrap lines at 80.
>=20
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - rockchip,rk3066-cif
> > +      - rockchip,px30-vip
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: ACLK
> > +      - description: HCLK
> > +      - description: PCLK
> > +
> > +  clock-names:
> > +    items:
> > +      - const: aclk
> > +      - const: hclk
> > +      - const: pclk
> > +
> > +  resets:
> > +    items:
> > +      - description: AXI
> > +      - description: AHB
> > +      - description: PCLK IN
> > +
> > +  reset-names:
> > +    items:
> > +      - const: axi
> > +      - const: ahb
> > +      - const: pclkin
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  port:
> > +    $ref: /schemas/graph.yaml#/properties/port
> > +    description: A connection to a sensor or decoder
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - port
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/clock/px30-cru.h>
> > +    #include <dt-bindings/power/px30-power.h>
> > +
> > +    parent {
> > +        #address-cells =3D <2>;
> > +        #size-cells =3D <2>;
> > +
> > +        video-capture@ff490000 {
> > +            compatible =3D "rockchip,px30-vip";
> > +            reg =3D <0x0 0xff490000 0x0 0x200>;
> > +            interrupts =3D <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
> > +            clocks =3D <&cru ACLK_CIF>, <&cru HCLK_CIF>, <&cru PCLK_CI=
F>;
> > +            clock-names =3D "aclk", "hclk", "pclk";
> > +            resets =3D <&cru SRST_CIF_A>, <&cru SRST_CIF_H>, <&cru SRS=
T_CIF_PCLKIN>;
> > +            reset-names =3D "axi", "ahb", "pclkin";
> > +            power-domains =3D <&power PX30_PD_VI>;
> > +
> > +            port {
> > +                endpoint {
> > +                    remote-endpoint =3D <&tw9900_out>;
> > +                };
> > +            };
> > +        };
> > +    };
> > +...
> > --=20
> > 2.41.0
> >=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--7fCeMisMgRBZQnBb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmVAzgsACgkQ3cLmz3+f
v9Hb1Qf9Eze/ep5/BwUEK3IGBy/qFAEjGRoZuXbOHllYr2mnjDO4odYjMWzn7Av+
ZZR3u2CX3YthbJ2Ebrq8ONpweEkIfLTgPD+PE9PsACFsEcOi8oJBQDtO7FxNbVQJ
ztVpqG0kB1cENdFHfj7Q6dI7t9fZXu483YnOTo7gL4ULTd09+Yter3eHoan5jZOB
tqMn3kTUv+0Yn5HpQnhubgN42NQpUIVqtdvjuITo/WWIg3ApnW7cexGkiMBRyiwW
Z96qKuEaHPkFuy3QyV3QgSzTuEOKQZG3A0Abhzvp1GG5p4mHZTocKK/EqYYCZi8U
uN5gs8kAB+u/3LhjwhTgodNISl61Ww==
=s9Kd
-----END PGP SIGNATURE-----

--7fCeMisMgRBZQnBb--
