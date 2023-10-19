Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B471D7CF7C0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345410AbjJSL66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345487AbjJSL6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:58:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DBE183
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:58:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F70C433C7;
        Thu, 19 Oct 2023 11:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697716732;
        bh=pQ29kk3ro7C4ElFonv3EiTyV06E9AE6VC1caQ8VJxwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BiHQUzkiiwPx41o8oTijdhqMqEXP1W25W/6P2gxP333hdS1fWElZGUXwcZOFKHvAE
         cmXg9p1vLYgAgLAP0tWcEU4XVlSaZtjlrl+jJV6sX4fFeL2/dYheIuuDxyReA2yPWK
         dmnnFSGr4MMGkrX6NWzxT6aimA2DsamgEPvcRhqZ8+AX+gWX0VK8IJ6GmEHVhjaGvb
         4stUNkFTprB1mcaYGVqaR0HEx2Rhpqryf1F76igl+q5oeYNRQ0vAtdsKM5vxrnGxok
         yBgfszESwHukgx/1g2Or0UuShMbAsnnWlya4MgSz/uUxSpN1pg8AdDRYQmSl4ItAq5
         cNlksfeV7wqbg==
Date:   Thu, 19 Oct 2023 12:58:46 +0100
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
Message-ID: <20231019-pulse-autopilot-166bb6c96090@spud>
References: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-1-3ee0c67383be@linaro.org>
 <169762516670.391804.7528295251386913602.robh@kernel.org>
 <CACRpkdZ4hkiD6jwENqjZRX8ZHH9+3MSMMLcJe6tJa=6Yhn1w=g@mail.gmail.com>
 <ZTEL6Yw+Xcc0E4TJ@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Y6vV29njl6hI4/69"
Content-Disposition: inline
In-Reply-To: <ZTEL6Yw+Xcc0E4TJ@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Y6vV29njl6hI4/69
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 11:58:49AM +0100, Russell King (Oracle) wrote:
> On Wed, Oct 18, 2023 at 01:11:45PM +0200, Linus Walleij wrote:
> > On Wed, Oct 18, 2023 at 12:32=E2=80=AFPM Rob Herring <robh@kernel.org> =
wrote:
> > > On Wed, 18 Oct 2023 11:03:40 +0200, Linus Walleij wrote:
> >=20
> > > > Bindings using dsa.yaml#/$defs/ethernet-ports specify that
> > > > a DSA switch node need to have a ports or ethernet-ports
> > > > subnode, and that is actually required, so add requirements
> > > > using oneOf.
> > > >
> > > > Suggested-by: Rob Herring <robh@kernel.org>
> > > > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > > > ---
> > > >  Documentation/devicetree/bindings/net/dsa/dsa.yaml | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > >
> > >
> > > My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_ch=
eck'
> > > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > >
> > > yamllint warnings/errors:
> > > ./Documentation/devicetree/bindings/net/dsa/dsa.yaml:60:7: [warning] =
wrong indentation: expected 8 but found 6 (indentation)
> > > ./Documentation/devicetree/bindings/net/dsa/dsa.yaml:62:7: [warning] =
wrong indentation: expected 8 but found 6 (indentation)
> >=20
> > Really?
> >=20
> > +  oneOf:
> > +    - required:
> > +      - ports
> > +    - required:
> > +      - ethernet-ports
> >=20
> > Two spaces after the oneOf, 2 spaces after a required as usual.
> > I don't get it.
>=20
> Given the other python errors spat out in Rob's report, I would suggest
> that the "bot" is running a development version that hasn't been fully
> tested, so anything it spits out is suspect. Maybe Rob can comment on
> the validity of the warnings in the report.

In this case, I think it is correct.
2 spaces for the oneOf, 2 spaces the start of the required for the
nested list, so:
oneOf:
  - required:
      - ports
  - required:
      - ethernet-ports

--Y6vV29njl6hI4/69
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTEZ9gAKCRB4tDGHoIJi
0iD0AP9nnypeoKCSb5p1jYVtkd/GxlHX1dmnIRWn/6opBLMHGQD+IqlWgD04icVW
jyfkLzfNK6BmN32rgviaunCpTobjLAY=
=HyDl
-----END PGP SIGNATURE-----

--Y6vV29njl6hI4/69--
