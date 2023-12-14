Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2E78134F6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573841AbjLNPjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573844AbjLNPjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:39:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119D898
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:39:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CBFC433C8;
        Thu, 14 Dec 2023 15:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702568362;
        bh=OUgQGKm22QNdpXpommaA6FLJdhjRd74GWH/14+qKI1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VfSZyovlHlRjpzeczdQNcJT3OK37zwhq30uHnBLvGvvflGIUUpOFBkTjj6En0yWuQ
         4jh20GkIla24I08ShPUH5zMb/XqruDn53xePNQb1mm8yxE8HS8gFLrVSFibD3bhxFK
         Rrr0KswEODyf/rJFxie9mAZFUEG++GSx/led50iKLilM23KjPbkmD1t4piSXLreyNZ
         WGnwCWeYBw/gNaD2WZNkaQsdklFh0tPA/e8MNqqwQeohrXn+E4jUaoY2kHdBtb5gZH
         bBhYbRsQIN9G8NJSzAyosSNq/wUZ8WxBdcWJUoKyzf/r2YLyqr3E7RCClkcRk3wiAd
         4EerzlQyXdneQ==
Date:   Thu, 14 Dec 2023 15:39:18 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Daniel Matyas <daniel.matyas@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/3] bindings: hwmon: Add adi,adaq4224_temp as compatible
 string
Message-ID: <20231214-coastline-fled-d7788bc2fb97@spud>
References: <20231214143648.175336-1-daniel.matyas@analog.com>
 <20231214143648.175336-2-daniel.matyas@analog.com>
 <d9ccf7ba-42e6-4ec6-9de9-51802e968de9@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="G6GD49EJmszTie2D"
Content-Disposition: inline
In-Reply-To: <d9ccf7ba-42e6-4ec6-9de9-51802e968de9@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G6GD49EJmszTie2D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 07:15:13AM -0800, Guenter Roeck wrote:
> On 12/14/23 06:36, Daniel Matyas wrote:
> > In the device ada4224 the max31827 temperature sensor will be used, so
> > the default values corresponding to adaq4224_temp are the same for
> > max31827.
> >=20
>=20
> I don't know what that device is, but if the max31827 is used it should
> be instantiated as max31827.

An improved commit message would be rather helpful here, as google did
not turn up any information on what this new device is.
Taking the patch on face value, a couple comments below.

> > Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
> > ---
> >   Documentation/devicetree/bindings/hwmon/adi,max31827.yaml | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml =
b/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
> > index f60e06ab7d0a..9f3b0839aa46 100644
> > --- a/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
> > +++ b/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
> > @@ -20,6 +20,7 @@ properties:
> >         - const: adi,max31827
> >         - items:
> >             - enum:
> > +              - adi,adaq4224_temp

No underscores in the compatible please.

> >                 - adi,max31828
> >                 - adi,max31829
> >             - const: adi,max31827
> > @@ -81,7 +82,9 @@ allOf:
> >         properties:
> >           compatible:
> >             contains:
> > -            const: adi,max31827
> > +            enum:
> > +              - adi,max31827
> > +              - adi,adaq4224_temp

This doesn't do anything afaict, since the binding doesn't allow
"adi,adaq4224_temp" without "adi,max31827".

> >       then:
> >         properties:
>=20

--G6GD49EJmszTie2D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXshpgAKCRB4tDGHoIJi
0i+8AQDLBGQ+HVEs4oHR2QFbfWYmXqmEAx3Uw+1Fm2LmiuGhaQD/b1+AdQl6W2D9
VXZLhAe3bLe3De2JkMLlL8u1XYmRkwc=
=yKeT
-----END PGP SIGNATURE-----

--G6GD49EJmszTie2D--
