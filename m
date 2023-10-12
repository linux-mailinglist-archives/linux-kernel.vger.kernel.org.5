Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796247C7144
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 17:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379191AbjJLPSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 11:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379209AbjJLPSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 11:18:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C7EDD
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 08:18:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62640C433C7;
        Thu, 12 Oct 2023 15:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697123894;
        bh=ib4tVcVonMixI1OaRSfJ8k6/MBGpORgj2wRciIN3hFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OGuD6B3Y4kGRzFfF+OHdIZKGMC3mk5oZ7/NsxSP/KgOEk2l4v7U3giA5yC4V2yoUI
         ALFjgu3Iter3SXK53rgH0MNqNidH1ui7rLKpfSxT/oToFP6YZj0iYshbGOvF4mYZCP
         BDrOKwCcTR5dZP+ix92yTYkvey50s+565Ay9NLsRzwwZZcC+09+/g/MykdNPAXAYmA
         b1RapCYfkBnWXxUhpVL7MpiIuTpYCO+zzTW8fSQMv00VU7D+1rLjEx78TpmkbWuAEl
         9Wq0yzECozGGuH09Egfq6KPAJkpLSFvIp1JHsBokmStGczuntXTd13vcMFUNOTdJNM
         dGffdeMES2n7w==
Date:   Thu, 12 Oct 2023 16:18:09 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Ante Knezic <ante.knezic@helmholz.de>
Cc:     netdev@vger.kernel.org, woojung.huh@microchip.com, andrew@lunn.ch,
        f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, marex@denx.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] dt-bindings: net: microchip,ksz:
 document microchip,rmii-clk-internal
Message-ID: <20231012-unicorn-rambling-55dc66b78f2f@spud>
References: <cover.1697107915.git.ante.knezic@helmholz.de>
 <1b8db5331638f1380ec2ba6e00235c8d5d7a882c.1697107915.git.ante.knezic@helmholz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="M6DiZrwt0r0ByUbo"
Content-Disposition: inline
In-Reply-To: <1b8db5331638f1380ec2ba6e00235c8d5d7a882c.1697107915.git.ante.knezic@helmholz.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M6DiZrwt0r0ByUbo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 12:55:56PM +0200, Ante Knezic wrote:
> Add documentation for selecting reference rmii clock on KSZ88X3 devices
>=20
> Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>
> ---
>  .../devicetree/bindings/net/dsa/microchip,ksz.yaml    | 19 +++++++++++++=
++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml=
 b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> index 41014f5c01c4..eaa347b04db1 100644
> --- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> @@ -72,6 +72,25 @@ properties:
>    interrupts:
>      maxItems: 1
> =20
> +  microchip,rmii-clk-internal:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Set if the RMII reference clock is provided internally. Otherwise
> +      reference clock should be provided externally.

I regret not asking this on the previous iteration - how come you need a
custom property? In the externally provided case would there not be a
clocks property pointing to the RMII reference clock, that would be
absent when provided by the itnernal reference?

Cheers,
Conor.

> +
> +if:
> +  not:
> +    properties:
> +      compatible:
> +        enum:
> +          - microchip,ksz8863
> +          - microchip,ksz8873
> +then:
> +  not:
> +    required:
> +      - microchip,rmii-clk-internal
> +
> +
>  required:
>    - compatible
>    - reg
> --=20
> 2.11.0
>=20

--M6DiZrwt0r0ByUbo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSgOMQAKCRB4tDGHoIJi
0neJAP9d2qGGl2LH+I7VWMfbPU56oSDwdRC6pm1sFFw7lC9EOQEA+esT0L2AHZjZ
D4EAcuZ5Z8L6DtFVkVh8TbCerUm5eAo=
=LPuI
-----END PGP SIGNATURE-----

--M6DiZrwt0r0ByUbo--
