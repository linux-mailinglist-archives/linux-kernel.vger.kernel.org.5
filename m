Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28BF18118CC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbjLMQLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbjLMQLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:11:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AC391
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:11:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF873C433C8;
        Wed, 13 Dec 2023 16:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702483905;
        bh=81xPCJRD7sl164kIgTp1GjUGAC/Vhq0axvltDwrUq6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KzF+ocBP2mjoUW7K6RrQnV1IecVV9GUl7VbnGppZXWa9pFdZ/9oqsPkdpKaNjNG9F
         sDnv+khOdzHKBkx/qW3goyvSyP+kSr2TFJwb6+iFJXAkSpwU4uhLmLpcBzE4uFJwxs
         Ldbqq1qKObWZbW5OpTFV7fwuAGj17EBuzWiJknnlhNBUXz51OZbc7Ri/SgKhuV1OQR
         miGZlwfVq5+IWZ9Y3moitNR97Hkv5ewYYM5W4X7ni3pXx03hFk+fS23T6G3q/48gt/
         rb5SOoCl6uGLokBwxdad36Qzv4ikjEhSaEjLuQ4crLA6Saiyc13X69hGOPfx+Tb3KT
         HAY+glTMvRqpw==
Date:   Wed, 13 Dec 2023 16:11:40 +0000
From:   Conor Dooley <conor@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: adc: Add binding for AD7380 ADCs
Message-ID: <20231213-harmless-aspect-b7cee2d0173f@spud>
References: <20231213-ad7380-mainline-v2-0-cd32150d84a3@baylibre.com>
 <20231213-ad7380-mainline-v2-2-cd32150d84a3@baylibre.com>
 <20231213-grooving-bulk-58fcfc20be11@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qvGfKPR0cMEVlYu+"
Content-Disposition: inline
In-Reply-To: <20231213-grooving-bulk-58fcfc20be11@spud>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qvGfKPR0cMEVlYu+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 04:10:40PM +0000, Conor Dooley wrote:
> On Wed, Dec 13, 2023 at 05:21:19AM -0600, David Lechner wrote:
> > This adds a binding specification for the Analog Devices Inc. AD7380
> > family of ADCs.
> >=20
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> >=20
> > v2 changes:
> > - Added maxItems to reg property
> > - Replaced adi,sdo-mode property with spi-rx-bus-channels
> > - Made spi-rx-bus-channels property optional with default value of 1
> >     (this made the if: check more complex)
> > - Changed example to use gpio for interrupt
> >=20
> >  .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 107 +++++++++++++=
++++++++
> >  MAINTAINERS                                        |   9 ++
> >  2 files changed, 116 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml =
b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
> > new file mode 100644
> > index 000000000000..43d58c52f7dd
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
> > @@ -0,0 +1,107 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/adi,ad7380.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices Simultaneous Sampling Analog to Digital Converte=
rs
> > +
> > +maintainers:
> > +  - Michael Hennerich <Michael.Hennerich@analog.com>
> > +  - Nuno S=E1 <nuno.sa@analog.com>
> > +
> > +description: |
> > +  * https://www.analog.com/en/products/ad7380.html
> > +  * https://www.analog.com/en/products/ad7381.html
> > +  * https://www.analog.com/en/products/ad7383.html
> > +  * https://www.analog.com/en/products/ad7384.html
> > +
> > +$ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,ad7380
> > +      - adi,ad7381
> > +      - adi,ad7383
> > +      - adi,ad7384
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-max-frequency:
> > +    maximum: 80000000
> > +  spi-cpol: true
> > +  spi-cpha: true
> > +
> > +  spi-rx-bus-channels:
>=20
> This is now being framed as a standard property, so I think it should be
> in spi-peripheral-props, no? Granted, you'd need a rather more
> generalised explanation of the property in that case.
>=20
> > +    description:
> > +      In 1-wire mode, the SDOA pin acts as the sole data line and the =
SDOB/ALERT
> > +      pin acts as the ALERT interrupt signal. In 2-wire mode, data for=
 input A
> > +      is read from SDOA and data for input B is read from SDOB/ALERT (=
and the
> > +      ALERT interrupt signal is not available).
> > +    enum: [1, 2]
>=20
> Jonathan also mentioned specifying that this defaults to 1-wire. I
> didn't see a response or that implemented. Did you miss that comment
> from him?

Ah, I read the patchset backwards, d'oh. I see you did in fact do both
of these things. Apologies!

--qvGfKPR0cMEVlYu+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXnXvAAKCRB4tDGHoIJi
0gCaAP99Nw069HRWHRkR+FtYfcruPmekFSXXFB33zvwWkx5HwAEAgxNJu+bcPA7w
U/bdib1bIPbUfCwaFj1cLZ9bDIzd2A8=
=0aeo
-----END PGP SIGNATURE-----

--qvGfKPR0cMEVlYu+--
