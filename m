Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340B37EA4CF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 21:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjKMUbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 15:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMUbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 15:31:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039881A7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 12:31:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB1BC433C9;
        Mon, 13 Nov 2023 20:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699907502;
        bh=fIARVbAefPJU30DddQ1rgV4vuTrk0KJXRxsHjap3SPc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GQ56aqx3L5+oc843PafhWwRe9LSIfrJkXlAZyn4pAKiJk8nkwDPbGz7xGB0/RqgWI
         FGnnkvOTBVW0stF6Nays6N4CAqat8dWY/RvWnZRKtuHwrd1/if8dxbfXan9s+scbhx
         3FSzORu6SL7Fv6xWwOwD3YlRtwwwa77FFsDguQXBAHsoL4WQu7+bzm02EdsUqVB8xq
         PNVfylEgf0H7ENR9w8wAac0hmyHZQQhFXA6qjjWxrYwHr93RSD28zgfy4rL0Nln8/Q
         z2ZfB3DiidattULbCqbo64l+lt/iPQeeAa9+UuqTlBSu4oM8HdDiDtdaAD/10xIWDW
         Apv81Ne1eoPMQ==
Date:   Mon, 13 Nov 2023 20:31:39 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Piyush Mehta <piyush.mehta@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: usb: microchip,usb5744: Add second
 supply
Message-ID: <20231113-extruding-regroup-8c26fe2eec63@squawk>
References: <20231113145921.30104-1-francesco@dolcini.it>
 <20231113145921.30104-2-francesco@dolcini.it>
 <20231113-jargon-manliness-584f34a5cf85@squawk>
 <ZVKCKop2zxI5FvCv@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y1ODAo1e3RHl1YOW"
Content-Disposition: inline
In-Reply-To: <ZVKCKop2zxI5FvCv@francesco-nb.int.toradex.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Y1ODAo1e3RHl1YOW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 09:08:10PM +0100, Francesco Dolcini wrote:
> Hello Conor,
> thanks for the review.
>=20
> On Mon, Nov 13, 2023 at 07:55:20PM +0000, Conor Dooley wrote:
> > On Mon, Nov 13, 2023 at 03:59:20PM +0100, Francesco Dolcini wrote:
> > > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > >=20
> > > The USB5744 has two power supplies one for 3V3 and one for 1V2. Add t=
he
> > > second supply to the USB5744 DT binding.
> > >=20
> > > Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > ---
> > >  .../devicetree/bindings/usb/microchip,usb5744.yaml         | 7 +++++=
+-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/usb/microchip,usb5744.=
yaml b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
> > > index ff3a1707ef57..6d4cfd943f58 100644
> > > --- a/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
> > > +++ b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
> > > @@ -36,7 +36,11 @@ properties:
> > > =20
> > >    vdd-supply:
> > >      description:
> > > -      VDD power supply to the hub
> > > +      3V3 power supply to the hub
> > > +
> > > +  vdd2-supply:
> > > +    description:
> > > +      1V2 power supply to the hub
> >=20
> > How about v1p2-supply?
>=20
> The reason for vdd2 is this

I see.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--Y1ODAo1e3RHl1YOW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVKHqAAKCRB4tDGHoIJi
0mNjAP9fUcaKxFMcv3wv7oSMVK4Tu6svAPmuTFLJRlXDXPbO5QD8DIgec0uLbdKm
Ikp0/BZFsla62RWFEecdOwC5K+OG+wM=
=fEzx
-----END PGP SIGNATURE-----

--Y1ODAo1e3RHl1YOW--
