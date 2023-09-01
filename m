Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D647790034
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 17:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239274AbjIAP53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 11:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbjIAP52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 11:57:28 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CE8E40;
        Fri,  1 Sep 2023 08:57:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CD9B4CE2432;
        Fri,  1 Sep 2023 15:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2F5C433C7;
        Fri,  1 Sep 2023 15:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693583842;
        bh=JGy3YR8DCAAeMCd/+utAzvUeCAo5PJiatwnbhTsPF2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s41OL3q4laOd8Y1JNO6f8ieIcLG7uFyctVHlnQ+VJETg8y2HBYVb5C9ZRQQKLwrAN
         CRAorJiRUDn1t9CR7UK7MAt8+3JZFw5CrEbZ5cqYFsuVV5WlM+SgUhfPqeIi+T1C7r
         vZUCVlT6ZjFGPqrNCOJSH4BGTft2Km9NSuY04AGquhwIvmqZGJi8cz0YHd7eUoCbhr
         nUKGyAJJfjnR7zQjgGtqWW6/+LkPHxj2PUtM3hc0MPzMEAqYgSNU55cWgky9yE3Oqf
         iXfukMCRvC3BT5A8fWoezr8wjIK+z0IQb7NU1eY/qH/3koKSS1TtYPmQSxhMUS8L38
         8v8468JQVYglg==
Date:   Fri, 1 Sep 2023 16:57:17 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: power: syscon-poweroff: get regmap from
 parent node
Message-ID: <20230901-uninvited-crewless-a2146c901e2d@spud>
References: <20230901120057.47018-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ID0nFTcvt+Gm0iXJ"
Content-Disposition: inline
In-Reply-To: <20230901120057.47018-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ID0nFTcvt+Gm0iXJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yo,

Two minor nits that look like copy-paste duplication of the same
problems in the syscon-reboot binding.

On Fri, Sep 01, 2023 at 02:00:55PM +0200, Krzysztof Kozlowski wrote:
> Just like syscon-reboot device, the syscon-poweroff is supposed to be a
> child of syscon node, thus we can take the same approach as
> syscon-poweroff: deprecate the 'regmap' field in favor of taking it from
> the parent's node.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> ---
>=20
> See also syscon-regmap:
> https://lore.kernel.org/all/20200526135102.21236-1-Sergey.Semin@baikalele=
ctronics.ru/
> ---
>  .../bindings/power/reset/syscon-poweroff.yaml          | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/reset/syscon-powerof=
f.yaml b/Documentation/devicetree/bindings/power/reset/syscon-poweroff.yaml
> index 3412fe7e1e80..3c58f8251882 100644
> --- a/Documentation/devicetree/bindings/power/reset/syscon-poweroff.yaml
> +++ b/Documentation/devicetree/bindings/power/reset/syscon-poweroff.yaml
> @@ -15,6 +15,9 @@ description: |+
>    defined by the register map pointed by syscon reference plus the offset
>    with the value and mask defined in the poweroff node.
>    Default will be little endian mode, 32 bit access only.
> +  The SYSCON registers map is normally retrieved from the parental dt-no=
de. So

s/registers/register/, no?

> +  the SYSCON poweroff node should be represented as a sub-node of a "sys=
con",
> +  "simple-mfd" node.
> =20
>  properties:
>    compatible:
> @@ -30,7 +33,10 @@ properties:
> =20
>    regmap:
>      $ref: /schemas/types.yaml#/definitions/phandle
> -    description: Phandle to the register map node.
> +    deprecated: true
> +    description:
> +      Phandle to the register map node. This property is deprecated in f=
avor of
> +      the syscon-poweroff node been a child of a system controller node.

s/been/being/

Otherwise,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> =20
>    value:
>      $ref: /schemas/types.yaml#/definitions/uint32
> @@ -38,7 +44,6 @@ properties:
> =20
>  required:
>    - compatible
> -  - regmap
>    - offset
> =20
>  additionalProperties: false
> @@ -56,7 +61,6 @@ examples:
>    - |
>      poweroff {
>          compatible =3D "syscon-poweroff";
> -        regmap =3D <&regmapnode>;
>          offset =3D <0x0>;
>          mask =3D <0x7a>;
>      };
> --=20
> 2.34.1
>=20

--ID0nFTcvt+Gm0iXJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZPIJ3QAKCRB4tDGHoIJi
0sWlAP0TOemTcQpeCcheNgkSboHB/V4lT/KIZKHapFPD7j/yAgD8CYX36UqnVUKA
07qa2Zi7FGAmsR3eWjEsxyCQfViMqg0=
=XNmB
-----END PGP SIGNATURE-----

--ID0nFTcvt+Gm0iXJ--
