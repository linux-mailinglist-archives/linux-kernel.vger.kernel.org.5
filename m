Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCC37D131A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377769AbjJTPpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377800AbjJTPpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:45:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B15D6C
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:45:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E17FC433C8;
        Fri, 20 Oct 2023 15:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697816744;
        bh=RTTrL8bUNOD9Virbg1xygXP66WsHbJ0SwSynqR3CXd8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lWuolx4MVLTnaeD9lAtm+MCAk5SVuDGc3Lq0Zp0ECpUC1yDQsCD0seAS6GLzx1OZ5
         uT+wxnrz7dlH8GY5G+EHqFWVHJ3vGbVEqhesje2R061MU5Op4OSYFvdjM9p0fY8nHm
         HN1WvZ0/IGJMgLlzbVQETcOMTM+xCEWwrsHOV0xj1Tr85nkpXi75wf7PPQylGPNbLv
         /+0maIs4vdS3JOJEkllH6GPhby1g5/3u01dwa0LkDjj8ttAL9KJIAP2j6DYPwZr5NG
         eUw2BMkGrMs+QKk7HX9lJ1QRWViW9LNzk4QJBoZdNS5kNorqyajf6P1DnvOz/kt84y
         Nu9mk2h+zbq8w==
Date:   Fri, 20 Oct 2023 16:45:38 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Ante Knezic <ante.knezic@helmholz.de>
Cc:     netdev@vger.kernel.org, woojung.huh@microchip.com, andrew@lunn.ch,
        f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, marex@denx.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com,
        o.rempel@pengutronix.de
Subject: Re: [PATCH net-next v4 1/2] dt-bindings: net: microchip,ksz:
 document microchip,rmii-clk-internal
Message-ID: <20231020-agency-yapping-17ba240510c0@spud>
References: <cover.1697811160.git.ante.knezic@helmholz.de>
 <cfeeec0f41a815601439e999a8dc947525b0d938.1697811160.git.ante.knezic@helmholz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fdIw5azgw3M22leo"
Content-Disposition: inline
In-Reply-To: <cfeeec0f41a815601439e999a8dc947525b0d938.1697811160.git.ante.knezic@helmholz.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fdIw5azgw3M22leo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 04:25:03PM +0200, Ante Knezic wrote:
> Add documentation for selecting reference rmii clock on KSZ88X3 devices
>=20
> Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>

Something in the commit message explaining why a property is needed
rather than using the regular old clocks property would be good.
Please do that if you re-spin. Otherwise,

Acked-by: Conor Dooley <conor.dooley@microchip.com>

(and despite the domain, I have nothing to do with switches...)

Cheers,
Conor.

> ---
>  .../devicetree/bindings/net/dsa/microchip,ksz.yaml      | 17 +++++++++++=
++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml=
 b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> index 41014f5c01c4..624feb1bb9be 100644
> --- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> @@ -72,6 +72,23 @@ properties:
>    interrupts:
>      maxItems: 1
> =20
> +  microchip,rmii-clk-internal:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Set if the RMII reference clock is provided internally. Otherwise
> +      reference clock should be provided externally.
> +
> +if:
> +  not:
> +    properties:
> +      compatible:
> +        enum:
> +          - microchip,ksz8863
> +          - microchip,ksz8873
> +then:
> +  properties:
> +    microchip,rmii-clk-internal: false
> +
>  required:
>    - compatible
>    - reg
> --=20
> 2.11.0
>=20

--fdIw5azgw3M22leo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTKgogAKCRB4tDGHoIJi
0ijRAP492S8PEzqJeTIZB2c+40q4jZzHJi+JGa2i7Li8kg5hwQD/Ykbw86XHgUeU
zVR70acAT3f7YQwvYo2I8YqyIb73KgI=
=PzQ0
-----END PGP SIGNATURE-----

--fdIw5azgw3M22leo--
