Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F87E7CBCFB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234730AbjJQIA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234740AbjJQIAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:00:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B16B102
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 01:00:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A87AC433C7;
        Tue, 17 Oct 2023 08:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697529620;
        bh=dDKPWob3NTMe7C9SlY1gR19DUsq4sN8SeXQP0UXWyaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tv8hN+5jlJ0ofhkcuyLjePs3+5j6h6eiQJYCA82U2nTd8vNgQEcUrhJ/e35LA22Ay
         aiyYXEGCK+GDNB4BN7Gj/hK49XhXmB2ebQJITOd0Rz83VHTgynZlzTaQHy5KsHcgDd
         dYO4dv1dcQXaiTYw23PgvEoCHMQWpGOmyd7o93nJn49CIkt98rgKnNxVHaW2ZBk+n6
         reD/irVj5bxCHcmm0CDfxf25qKZgOgQ+gWBhSEMtaDdYik/RU73ytegEKWgbwxpBud
         Bx4YmIESFh/B6BtaysceZjBDq054CwtYevuveEio/GfQV4lWIKe61g+XK4dIOd7ico
         jTvlG8mLzdUaQ==
Date:   Tue, 17 Oct 2023 09:00:15 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Ante Knezic <ante.knezic@helmholz.de>
Cc:     andrew@lunn.ch, conor+dt@kernel.org, davem@davemloft.net,
        devicetree@vger.kernel.org, edumazet@google.com,
        f.fainelli@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org, marex@denx.de,
        netdev@vger.kernel.org, olteanv@gmail.com, pabeni@redhat.com,
        robh+dt@kernel.org, woojung.huh@microchip.com
Subject: Re: [PATCH net-next 2/2] dt-bindings: net: microchip,ksz: document
 microchip,rmii-clk-internal
Message-ID: <20231017-generous-botanical-28436c5ba13a@spud>
References: <20231012-unicorn-rambling-55dc66b78f2f@spud>
 <20231016075349.18792-1-ante.knezic@helmholz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RTdQAc1dJT5nSWZw"
Content-Disposition: inline
In-Reply-To: <20231016075349.18792-1-ante.knezic@helmholz.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RTdQAc1dJT5nSWZw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 09:53:49AM +0200, Ante Knezic wrote:
> On Thu, 12 Oct 2023 16:18:09 +0100, Conor Dooley wrote:
> > On Thu, Oct 12, 2023 at 12:55:56PM +0200, Ante Knezic wrote:
> > > Add documentation for selecting reference rmii clock on KSZ88X3 devic=
es
> > >=20
> > > Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>
> > > ---
> > >  .../devicetree/bindings/net/dsa/microchip,ksz.yaml    | 19 +++++++++=
++++++++++
> > >  1 file changed, 19 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.=
yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> > > index 41014f5c01c4..eaa347b04db1 100644
> > > --- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> > > +++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> > > @@ -72,6 +72,25 @@ properties:
> > >    interrupts:
> > >      maxItems: 1
> > > =20
> > > +  microchip,rmii-clk-internal:
> > > +    $ref: /schemas/types.yaml#/definitions/flag
> > > +    description:
> > > +      Set if the RMII reference clock is provided internally. Otherw=
ise
> > > +      reference clock should be provided externally.
> >=20
> > I regret not asking this on the previous iteration - how come you need a
> > custom property? In the externally provided case would there not be a
> > clocks property pointing to the RMII reference clock, that would be
> > absent when provided by the itnernal reference?

> In both cases (external and internal), the KSZ88X3 is actually providing =
the
> RMII reference clock.
> Difference is only will the clock be routed as external
> copper track (pin REFCLKO -> pin REFCLKI), or will it be routed internall=
y.

The switch always provides it's own external reference, wut? Why would
anyone actually bother doing this instead of just using the internal
reference?

> So, this should not affect the clock relation between the uC and the swit=
ch
> device?

> This property has no effect if KSZ88X3 is not providing the reference clo=
ck.

This appears to contradict with the above, unless I am misunderstanding
something.

> Maybe I should provide more info in the commit message of both patches as=
 well?

What I would have expected to see is that when the reference clock is
provided externally that there would be a clocks property in the DT
node, pointing at that external clock & when there was not, then
no property. Likely that ship has already said, as I don't see clocks
present in the current binding. How does the driver get the frequency of
the RMII reference clock when an external reference is provided?

--RTdQAc1dJT5nSWZw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZS4/DwAKCRB4tDGHoIJi
0rFQAP9m8VpRBlP7rWXT1ZHoFPq6+eLOQwYnPTJprqcCty2+fAEA1o0kvyUPI69W
wXbdny+DrsOyb/DSpvy1L3OvYkdJ/gg=
=xLsw
-----END PGP SIGNATURE-----

--RTdQAc1dJT5nSWZw--
