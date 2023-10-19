Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18577CF946
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345562AbjJSMqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345380AbjJSMqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:46:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BBFF7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:46:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4F4C433C7;
        Thu, 19 Oct 2023 12:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697719603;
        bh=zrChmdwZjapKXHOuDShzo54XNW6c5+Js5gqYUObtK/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O/pjOKSw15Eyq52t9nl85klJ8UdBJwT/YwJwJS+3+usiTv2DShKdWaInjqc3GJBu+
         On2MmXCrAFp44XHG2X55Os2Y3DDHncbNWMtbFB8F6peVVN4RyLmSfgvt39KYcVOkVp
         9ygwmt/C+n0oHLdJj5fl2VqHRxsZgDDb6abF925Jn8yGcmYFTkNFLVbPJAXL+814dF
         mb/nJdZEIbkYb3dJhS+APNwFZH4GGhkOYbjyzYeqHOWwU9bZ7oXivEdvkVC+0j4jSn
         5/T22RVnwa07bAzIKK1YarpkufcGDt0zrqKSDC2PoFcm9C4/IgHwiIQRJcR8Vdhhgu
         5+3dfibFfiV1Q==
Date:   Thu, 19 Oct 2023 13:46:36 +0100
From:   Conor Dooley <conor@kernel.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, netdev@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>
Subject: Re: [PATCH net-next v4 1/7] dt-bindings: net: dsa: Require ports or
 ethernet-ports
Message-ID: <20231019-friday-fabulous-4882c4048b8c@spud>
References: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-1-3ee0c67383be@linaro.org>
 <169762516670.391804.7528295251386913602.robh@kernel.org>
 <CACRpkdZ4hkiD6jwENqjZRX8ZHH9+3MSMMLcJe6tJa=6Yhn1w=g@mail.gmail.com>
 <ZTEL6Yw+Xcc0E4TJ@shell.armlinux.org.uk>
 <20231019-pulse-autopilot-166bb6c96090@spud>
 <ZTEgnUP0rFL2frkk@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hRWpvk1HDqmaTX1z"
Content-Disposition: inline
In-Reply-To: <ZTEgnUP0rFL2frkk@shell.armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hRWpvk1HDqmaTX1z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 01:27:09PM +0100, Russell King (Oracle) wrote:
> On Thu, Oct 19, 2023 at 12:58:46PM +0100, Conor Dooley wrote:
> > On Thu, Oct 19, 2023 at 11:58:49AM +0100, Russell King (Oracle) wrote:
> > > On Wed, Oct 18, 2023 at 01:11:45PM +0200, Linus Walleij wrote:
> > > > On Wed, Oct 18, 2023 at 12:32=E2=80=AFPM Rob Herring <robh@kernel.o=
rg> wrote:
> > > > > On Wed, 18 Oct 2023 11:03:40 +0200, Linus Walleij wrote:
> > > >=20
> > > > > > Bindings using dsa.yaml#/$defs/ethernet-ports specify that
> > > > > > a DSA switch node need to have a ports or ethernet-ports
> > > > > > subnode, and that is actually required, so add requirements
> > > > > > using oneOf.
> > > > > >
> > > > > > Suggested-by: Rob Herring <robh@kernel.org>
> > > > > > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > > > > > ---
> > > > > >  Documentation/devicetree/bindings/net/dsa/dsa.yaml | 6 ++++++
> > > > > >  1 file changed, 6 insertions(+)
> > > > > >
> > > > >
> > > > > My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_bindin=
g_check'
> > > > > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > > > >
> > > > > yamllint warnings/errors:
> > > > > ./Documentation/devicetree/bindings/net/dsa/dsa.yaml:60:7: [warni=
ng] wrong indentation: expected 8 but found 6 (indentation)
> > > > > ./Documentation/devicetree/bindings/net/dsa/dsa.yaml:62:7: [warni=
ng] wrong indentation: expected 8 but found 6 (indentation)
> > > >=20
> > > > Really?
> > > >=20
> > > > +  oneOf:
> > > > +    - required:
> > > > +      - ports
> > > > +    - required:
> > > > +      - ethernet-ports
> > > >=20
> > > > Two spaces after the oneOf, 2 spaces after a required as usual.
> > > > I don't get it.
> > >=20
> > > Given the other python errors spat out in Rob's report, I would sugge=
st
> > > that the "bot" is running a development version that hasn't been fully
> > > tested, so anything it spits out is suspect. Maybe Rob can comment on
> > > the validity of the warnings in the report.
> >=20
> > In this case, I think it is correct.
> > 2 spaces for the oneOf, 2 spaces the start of the required for the
> > nested list, so:
> > oneOf:
> >   - required:
>=20
> This is a total of two spaces indentation.
>=20
> >       - ports
>=20
> This is a total of six spaces indentation.
>=20
> You mention 2 spaces for the oneOf, which explains why the "- required"
> needs to be indented by two spaces. You also say 2 spaces for the
> required nested list, but what about the other two spaces?

I a word that might've made it more clear.
It is 2 spaces for the oneOf and 2 spaces _from_ the start of the
required for the nested list.

In theory you might have a contrived example that looks like:

oneOf:
  - required:
      - ports
    properties:
      ethernet-ports: false

  - required:
      - ethernet-ports
    properties:
      ports: false

Maybe with that example you can see that each option of the oneOf
contains a `required` and a `properties` component at 4 spaces of
indent, and then in turn the required properties, being sub-components
of `required` grow 2 more spaces for 6.

> I guess if you're a YAML expert, this all makes sense, but to those of
> us who aren't, these quirky "features" of it just seem totally
> illogical.

If I were a yaml expert, I would probably be able to use the correct
terminology to explain this better, but hopefully the example is useful.

--hRWpvk1HDqmaTX1z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTElLAAKCRB4tDGHoIJi
0nGyAQCSissEbIBxRaCcFxF/SsIhIEna84/VQZA/TgqU6R+5eQEAqIrUvOveubc0
111rEtBQs+tzwLNM+TuvJiUKGztktg0=
=HXqE
-----END PGP SIGNATURE-----

--hRWpvk1HDqmaTX1z--
