Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46AA67E70AD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344841AbjKIRpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344859AbjKIRpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:45:40 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A140D2D63;
        Thu,  9 Nov 2023 09:45:37 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 18BF620004;
        Thu,  9 Nov 2023 17:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699551935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0Q5/m2yxLb2+8S6LP3q83n6hJXZkXarQVShg5MoacVU=;
        b=VmHgxizThJrbE3wHg12rB4KajgKl01mlpedNWWIe1dlcxixSLs1sj6zoHEnVye7f9YIAa+
        0SXv7hOrbAZ8X6WXOyc2PobU0bvvSlOeFUwG7uE1kwWbb1Q4UwdNZk+3FZWXoJ5B7t6Kt6
        bqQAGD61Wbo3g1nfM8Dv/MFvyw38lre0tsrRL7bGHpgz2FvNB26dQZf22AqC86xCiNqnE+
        F3sT9WSUAPoB6Xkyf4XNnRK7cg/TimGV4E95zn0xUC/mPG/Md2XpGYlZHYwXc24Lpimx5+
        8Fd7E9alFHvooAAMrdQro2I0Tb5hOL8fGcAls8rG0mxJWKzaZAlSK95tPFQnEA==
Date:   Thu, 9 Nov 2023 18:45:34 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Mehdi Djait <mehdi.djait@bootlin.com>, mchehab@kernel.org,
        heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        maxime.chevallier@bootlin.com, michael.riesch@wolfvision.net
Subject: Re: [PATCH v10 1/3] media: dt-bindings: media: add bindings for
 Rockchip CIF
Message-ID: <ZU0avuRRaITV4jws@aptenodytes>
References: <cover.1699460637.git.mehdi.djait@bootlin.com>
 <037bcabf97294d37b271537e4b11fb88cf9bb6f6.1699460637.git.mehdi.djait@bootlin.com>
 <20231109-closable-superglue-5e7f39739cf1@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2Ex8Ew6F9ijkgEgp"
Content-Disposition: inline
In-Reply-To: <20231109-closable-superglue-5e7f39739cf1@spud>
X-GND-Sasl: paul.kocialkowski@bootlin.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2Ex8Ew6F9ijkgEgp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu 09 Nov 23, 17:24, Conor Dooley wrote:
> On Wed, Nov 08, 2023 at 05:38:56PM +0100, Mehdi Djait wrote:
> > Add a documentation for the Rockchip Camera Interface binding.
> >=20
> > the name of the file rk3066 is the first Rockchip SoC generation that u=
ses cif
> > instead of the px30 which is just one of the many iterations of the uni=
t.
>=20
> I think this is becoming ridiculous. You've now removed the compatible
> for the rk3066 but kept it in the filename. I don't understand the
> hangup about naming the file after the px30-vip, but naming it after
> something that is not documented here at all makes no sense to me.
> Either document the rk3066 properly, or remove all mention of it IMO.

I think the opposite is ridiculous. We have spent some time investigating t=
he
history of this unit, to find out that RK3066 is the first occurence where
it exists. Since we want the binding to cover all generations of the same u=
nit
and give it a name that reflects this, rk3066 is the natural choice that co=
mes
to mind. As far as I understand, this is the normal thing to do to name
bindings: name after the earliest known occurence of the unit.

What is the rationale behind naming the file after a generation of the unit
that happens to be the one introducing the binding? This is neither the fir=
st
nor the last one to include this unit. The binding will be updated later to
cover other generations. Do we want to rename the file each time an a gener=
ation
earlier than px30 is introduced? That sounds quite ridiculous too.

We've done the research work to give it the most relevant name here.
I'd expect some strong arguments not to use it. Can you ellaborate?

Cheers,

Paul


> Cheers,
> Conor.
>=20
> >=20
> > Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
> > ---
> >  .../bindings/media/rockchip,rk3066-cif.yaml   | 94 +++++++++++++++++++
> >  1 file changed, 94 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/rockchip,rk=
3066-cif.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/media/rockchip,rk3066-ci=
f.yaml b/Documentation/devicetree/bindings/media/rockchip,rk3066-cif.yaml
> > new file mode 100644
> > index 000000000000..c3a5cd2baf71
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/rockchip,rk3066-cif.yaml
> > @@ -0,0 +1,94 @@
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
> > +description:
> > +  CIF is a camera interface present on some rockchip SoCs. It receives=
 the data
> > +  from Camera sensor or CCIR656 encoder and transfers it into system m=
ain memory
> > +  by AXI bus.
> > +
> > +properties:
> > +  compatible:
> > +    const: rockchip,px30-vip
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

--2Ex8Ew6F9ijkgEgp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmVNGr4ACgkQ3cLmz3+f
v9Eq4wgAj7fY0daXUAOGwuI7yN814j3NW7LprnB1K7vAwnMgqegqZ7mvDhk9eXli
JvvUVWDCgDiKTzY+egLYELm2WHZnjFpz/S0UBxGlFx8EbMqZZUmS9KQNeKpoDIf9
gQP1YrzsJ9QCnZ929p38FKKq2QpFGrpa5/iNjbvczMoX8T2ZFCatPEdPAULW+r2q
O5O/r56CYVqy7nSJKn1Y6nW6ICYyYTqdxxfdY3c2ewD+ze3Y0taINQMrOGWSkq1q
l3I3dGQ+ps7orektmW3STRwLCQsor027gjIOJe151Bbmm8l7cIXHUG2Wwv+6ndSr
QiyNpLrC/ylFArfSUp9kMpNyUNJveQ==
=ElAt
-----END PGP SIGNATURE-----

--2Ex8Ew6F9ijkgEgp--
