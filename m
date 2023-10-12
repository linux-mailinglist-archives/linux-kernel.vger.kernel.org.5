Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F527C6E1F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 14:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347190AbjJLMbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 08:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbjJLMa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 08:30:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A2EB8;
        Thu, 12 Oct 2023 05:30:56 -0700 (PDT)
Received: from mercury (dyndsl-091-248-212-229.ewe-ip-backbone.de [91.248.212.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D0E2C660733F;
        Thu, 12 Oct 2023 13:30:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697113854;
        bh=SqYTiOtUppKlZvMe6nHnH40NTI0MY7sewDjs1R3rQVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HUeM/pezKZ48kW54SVra2V2rv+4szeF5ThlojEo06WDvEBgFWirXf4T/M1jkwAXG9
         9xD/I4srIYRJhFx4UaPovNmSvSsp7OeEwwSRGY22v0ssyEPybt/tyWs0sGcQHqAY0A
         qHCMCdrhVLYhYLGknT9LQQqxINcpo/fPpzWBeYkNnYD4+j8TJ+Cw45OU+fHzDrgIyO
         NjwQarrxwt8vMWx0zB3l55oBGblCOZ8ziFcdVTgV2VZ+lf0i4qWmFWyCrY1nS5jKDs
         cutarlN17iJe27Sfr89nmfexZWeTpG3+Yvq1aLDUqEu2hKVzUsP3zX4tjimzjSXjrn
         jVwXKz7Dn3Pqw==
Received: by mercury (Postfix, from userid 1000)
        id A6A9810605A6; Thu, 12 Oct 2023 14:30:51 +0200 (CEST)
Date:   Thu, 12 Oct 2023 14:30:51 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v3 1/3] dt-bindings: usb: add rk3588 compatible to
 rockchip,dwc3
Message-ID: <20231012123051.jkxj4mpczerc2igl@mercury.elektranox.org>
References: <20231009172129.43568-1-sebastian.reichel@collabora.com>
 <20231009172129.43568-2-sebastian.reichel@collabora.com>
 <20231010162722.GA1006254-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dg275xcvg6oalgtm"
Content-Disposition: inline
In-Reply-To: <20231010162722.GA1006254-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dg275xcvg6oalgtm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 10, 2023 at 11:27:22AM -0500, Rob Herring wrote:
> [...]
> > +allOf:
> > +  - $ref: snps,dwc3.yaml#
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: rockchip,rk3328-dwc3
> > +    then:
> > +      properties:
> > +        clocks:
> > +          minItems: 3
> > +          maxItems: 4
> > +        clock-names:
> > +          minItems: 3
> > +          items:
> > +            - const: ref_clk
> > +            - const: suspend_clk
> > +            - const: bus_clk
> > +            - const: grf_clk
>=20
> No need to list everything again. Just:
>=20
> contains:
>   const: grf_clk

No, that does not work because 'grf_clk' is optional and by using
'contains: grf_clk' the check will complain if the list does not
contain 'grf_clk'.

> [...] more improvements suggested by Rob [...]

These look all fine to me and I fixed them up for v4.

> > +        clock-names:
> > +          minItems: 3
> > +          items:
> > +            - const: ref_clk
> > +            - const: suspend_clk
> > +            - const: bus_clk
> > +            - const: utmi
> > +            - const: pipe
>=20
> Again, can use 'contains' here. Where 'utmi' is in the list is already=20
> defined by the top-level schema.

Same issue as above. On RK3588 there is one USB3 controller, which
needs all 5 clocks and two controllers with just the first 3 clocks.
I initially had two different compatible strings to have fixed lists,
but Krzysztof asked to use only a single one.

-- Sebastian

--dg275xcvg6oalgtm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmUn5vMACgkQ2O7X88g7
+pq5iQ//SbD019jkFbISwPoG5pufL8vzlz6VbiCInwaeTLu/GuWEXfKMBsIz+1Ui
p8mJnLWZ+WsvgHHJWDrF/OLlheQ7SJUEx2pd3hKGVI4HmuN/+cQ5Z30Dx4i8NpM9
IW6hUHyE6HnRIGyM9ZHq51Qa6A/rE0Fas4FBcLo0LUWeE3cpJPIlofGW7rLJ8GEW
9/dr70KmKSzo1/Lwsno+UY4VQtAdgMjo3vMqVooOwB6KnOAPYZHgK5C/A/JouzWd
SuvHQ9Bp8iWiuhvLVgkHmVuJ2bjZEmBR0BgoZmQgE/pWcbf+/q6etR2hDafPS/8a
Pxz4KDrnTSfw6v3ZdmsON+vEsyRdrm/qWlQldstzy22xlmt8NHT3wrbbucTaFj2W
Sem+RN/Qj2hJeLqVQQPxGBKjCP2XXDH6SZHU0lO5z3YbUUmEh0Sco1kARE01Dg6S
v7TvHjyDKuUB6UiuqwPrOq4+5Wh+LR3GxJrQqviJ1GzOd5h1iFOjDbKWZoH8KkMG
OsHHN/zj+09EvatG5M3gUyNoT6upKhXHJhAx5VxNda2MuuikQmG2x6aUzlwJldvu
dI+sfV+4opYtRakVfvKmVCZo06hHt8j1fRAOKE51x6MReMHL2R2cQWtr1MQpmeJP
Y9u/fJ0NcKue4wu6YgGBleeH5c/BzSQTP2VfpvFQ0SP7eHHch8U=
=LnH+
-----END PGP SIGNATURE-----

--dg275xcvg6oalgtm--
