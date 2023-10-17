Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858EF7CBCB9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 09:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234735AbjJQHsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 03:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234669AbjJQHsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 03:48:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9660DFD
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 00:48:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DEFBC433C9;
        Tue, 17 Oct 2023 07:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697528913;
        bh=ULSURu0f9pF10jB8uWo7rgXsdlYUF/R9Y1q7G+/vIm4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eHNHh/gmur/uVvgbuvQjCDcpZiBcUV6ML9UhjZcjC2NCtGe4I8Zg4p4iWCs0kQzf5
         UM6k4E/tTEUqScuFvyXIrwIZPr/t7PaiHmV/sXJKD2qRn89b8oclTi3BlUxSYdQ5rA
         oQBMNkh0LddC71ItQZzn5Pn35UcXpzBi4tNlSfYdygxRwagFgRKiRzHnqSvroDIfrz
         7xSqjcBMs5+a0S/p9V2/4gqULO/BSx/HVbC5nuA4ZHbi/lNBQqOU3sMRWEIEhW76Xa
         JwpBs8Ke4HaMf7vMx3+re7faHHVMrJAKYYC1aKzM+4xRvTveCny8kYO7CrcN+5OYRZ
         h1bhxyxKi7c8w==
Date:   Tue, 17 Oct 2023 08:48:27 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Ante Knezic <ante.knezic@helmholz.de>
Cc:     olteanv@gmail.com, andrew@lunn.ch, conor+dt@kernel.org,
        davem@davemloft.net, devicetree@vger.kernel.org,
        edumazet@google.com, f.fainelli@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, marex@denx.de,
        netdev@vger.kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        woojung.huh@microchip.com
Subject: Re: [PATCH net-next v2 2/2] dt-bindings: net: microchip,ksz:
 document microchip,rmii-clk-internal
Message-ID: <20231017-fading-retrial-7faebda79ebb@spud>
References: <20231016103708.6ka5vxfkdatrjvdk@skbuf>
 <20231017073548.15050-1-ante.knezic@helmholz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wIO3iCZ/QV7V4j5D"
Content-Disposition: inline
In-Reply-To: <20231017073548.15050-1-ante.knezic@helmholz.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wIO3iCZ/QV7V4j5D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2023 at 09:35:48AM +0200, Ante Knezic wrote:
> > > +  microchip,rmii-clk-internal:
> > > +    $ref: /schemas/types.yaml#/definitions/flag
> > > +    description:
> > > +      Set if the RMII reference clock is provided internally. Otherw=
ise
> > > +      reference clock should be provided externally.
> > > +
> > > +if:
> > > +  not:
> > > +    properties:
> > > +      compatible:
> > > +        enum:
> > > +          - microchip,ksz8863
> > > +          - microchip,ksz8873
> > > +then:
> > > +  not:
> > > +    required:
> > > +      - microchip,rmii-clk-internal

I think this bit can become the slightly simpler
	then:
	  properties:
	     microchip,rmii-clk-internal: false

> > I think that what you want to express is that microchip,rmii-clk-intern=
al
> > is only defined for microchip,ksz8863 and microchip,ksz8873.
> > Can't you describe that as "if: properties: compatible: (...) then:
> > properties: microchip,rmii-clk-internal"?
>=20
> If I understood you correctly you are refering to a solution like
> if:
>   properties:
>     compatible:
>       enum:
>         - microchip,ksz8863
>         - microchip,ksz8873
> then:
>   properties:
>     microchip,rmii-clk-internal:
>       $ref: /schemas/types.yaml#/definitions/flag
>       description:
>         Set if the RMII reference clock is provided internally. Otherwise
>         reference clock should be provided externally.
>=20
> This was already suggested in v1, but was not a satisfactory solution
> according to Mr. Conor Dooley:

Yeah, we prefer not to have the property definitions inside the
conditionals, but rather constrain or allow/disallow them there.

Cheers,
Conor.

>=20
> >> On Tue, 10 Oct 2023 16:25:55 +0100, Conor Dooley wrote:
> >> > On Tue, Oct 10, 2023 at 03:18:54PM +0200, Ante Knezic wrote:
> >> > > Add documentation for selecting reference rmii clock on KSZ88X3 de=
vices
> >> > >=20
> >> > > Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>
> >> > > ---
> >> > >  Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml | 6 =
++++++
> >> > >  1 file changed, 6 insertions(+)
> >> > >=20
> >> > > diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,k=
sz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> >> > > index e51be1ac0362..3df5d2e72dba 100644
> >> > > --- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> >> > > +++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> >> > > @@ -49,6 +49,12 @@ properties:
> >> > >        Set if the output SYNCLKO clock should be disabled. Do not =
mix with
> >> > >        microchip,synclko-125.
> >> > > =20
> >> > > +  microchip,rmii-clk-internal:
> >> > > +    $ref: /schemas/types.yaml#/definitions/flag
> >> > > +    description:
> >> > > +      Set if the RMII reference clock should be provided internal=
ly.
> >> >=20
> >> > > Applies only
> >> > > +      to KSZ88X3 devices.
> >> >=20
> >> > This should be enforced by the schema, the example schema in the docs
> >> > should show you how to do this.
> >>=20
> >> I am guessing you are refering to limiting the property to ksz88x3 dev=
ices?
> >> Something like:
> >>=20
> >> if:
> >>   properties:
> >>     compatible:
> >>       enum:
> >>         - microchip,ksz8863
> >>         - microchip,ksz8873
> >> then:
> >>   properties:
> >>     microchip,rmii-clk-internal:
> >>       $ref: /schemas/types.yaml#/definitions/flag
> >>       description:
> >>         Set if the RMII reference clock is provided internally. Otherw=
ise
> >>         reference clock should be provided externally.
> >
> >Not quite. The definition of the property should be outside the if/then,
> >but one should be used to allow/disallow the property.
>=20

--wIO3iCZ/QV7V4j5D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZS48SwAKCRB4tDGHoIJi
0velAQClJ9EQ6MEhRqxPuOI8Aa3rxhaXsnRNccr4O2vn8y6vLwD/ffOYqRRz1OQ+
vAcG8dVYyfmc7/0OfyJOWaW4keCGvQM=
=/J8x
-----END PGP SIGNATURE-----

--wIO3iCZ/QV7V4j5D--
