Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1C378F0B6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 17:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346569AbjHaPzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 11:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241971AbjHaPzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:55:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C301A3;
        Thu, 31 Aug 2023 08:55:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E860B60B9B;
        Thu, 31 Aug 2023 15:55:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC878C433C8;
        Thu, 31 Aug 2023 15:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693497345;
        bh=6kYNSIgYaJxLu/+vmv4nY7E+BsV6ytSAY2NG81tEbrM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l8FhtKblsxbqJrPMM+JVNEIfI6PhxkdWm9a9sMzK5w6eh2a3YrD5tKeeYPFQSgvle
         /hP9NMQyfvbpfvgG7+ySKrz2bAtLBKhvJeQblebMnPHBF8uipa5wIWhu9wK1UtzcLo
         32oh+d0xK5nPSP2Pf0p8WDupkdhG7quIemjn6Fab4h4nDNtIFM3WFqm/l/AgoQW/LK
         Bu6yKsUFBxXzzTWmT5hzcUqk18lFZF0Tp+TewTJv0Rl2GF+u2ST4oafzZPac5LGXeD
         H5Z0f55pjHCvpMI1pWf6C5gAYVqWpoJ8hqLeoap1GMKG6DXhP4dzSfdetyTLbYoF5u
         hSypfEty2m6+g==
Date:   Thu, 31 Aug 2023 16:55:40 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        bcousson@baylibre.com, tony@atomide.com, mturquette@baylibre.com,
        sboyd@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 2/5] dt-bindings: mfd: ti,twl: Add clock provider
 properties
Message-ID: <20230831-dimness-pushover-3de199fb268c@spud>
References: <20230830182038.878265-1-andreas@kemnade.info>
 <20230830182038.878265-3-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="srGWJR8qE45I+k+n"
Content-Disposition: inline
In-Reply-To: <20230830182038.878265-3-andreas@kemnade.info>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--srGWJR8qE45I+k+n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 30, 2023 at 08:20:35PM +0200, Andreas Kemnade wrote:
> Since these devices provide clock outputs, add the corresponding
> property.
>=20
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  Documentation/devicetree/bindings/mfd/ti,twl.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/ti,twl.yaml b/Document=
ation/devicetree/bindings/mfd/ti,twl.yaml
> index 3d7b3e0addafa..6bb781b95ecdb 100644
> --- a/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> +++ b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> @@ -37,6 +37,9 @@ properties:
>    "#interrupt-cells":
>      const: 1
> =20
> +  "#clock-cells":
> +    const: 1
> +

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

>  additionalProperties: true
> =20
>  required:
> --=20
> 2.39.2
>=20

--srGWJR8qE45I+k+n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZPC3/AAKCRB4tDGHoIJi
0t3IAP9axavIUz5h6IdSBGWOuHgSx5jnlWEoNPa373TRW7/vZQEAtPjG+/jNENgU
EwF8jy9XKAYCoKCoSEtLpq1lQcOWDQQ=
=duFO
-----END PGP SIGNATURE-----

--srGWJR8qE45I+k+n--
