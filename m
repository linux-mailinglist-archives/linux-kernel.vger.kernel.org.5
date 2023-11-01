Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6C97DE313
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjKAPLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbjKAPLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:11:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C37DC;
        Wed,  1 Nov 2023 08:11:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1009BC433C7;
        Wed,  1 Nov 2023 15:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698851463;
        bh=yo1/sF0ttFu5wR6aPa6Te2SqCTO7ZGRY9ZRNoDYt+Nw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HPDz1Oe5/mPIoa9hcRebOrJD0AVW3ajAPopnZaGTOyNUWkUsQDp1HgNOx3h1jAJIF
         5F4dm7jxAR+ReVQz2uwcHCo4JiCyXcBBumBANxWFxbCC7c9wyyFSMJjDulursjhOkE
         7PmmLPmu6zTOUIF/L4/X5AYyjz+GnH1UX01J4OuEYUdJiNAwUlwtGSTFXLAaOQwN3H
         dilnxD/YiPLJpjnit3XDWqawaADVLTaJo9zdqKY1yNtQM3AlhKKu5zQzqxKApYldNs
         fSvnaQfNO8DU5bQMPcRQXBRol8IW6Ar5eLKNtJs+lYIsWAdsd6m5ObkxPniD1Lx8wQ
         YkkYyQRzZiN/w==
Date:   Wed, 1 Nov 2023 15:10:58 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Vincent Knecht <vincent.knecht@mailoo.org>
Cc:     Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] media: dt-bindings: ak7375: Add ak7345 support
Message-ID: <20231101-wise-childless-ed44729657c6@spud>
References: <20231101102257.1232179-1-vincent.knecht@mailoo.org>
 <20231101102257.1232179-2-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pODw/iX2UkMAb4/N"
Content-Disposition: inline
In-Reply-To: <20231101102257.1232179-2-vincent.knecht@mailoo.org>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pODw/iX2UkMAb4/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 01, 2023 at 11:22:56AM +0100, Vincent Knecht wrote:
> Document AK7345 bindings.

The commit message should mention why this device is incompatible with
the 7375. Something like

"Document the ak7345 voice coil motor actuator. Similar to the ak7375,
this model has 4 unilateral phase detractors instead of 8."

Otherwise,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

>=20
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> ---
>  .../devicetree/bindings/media/i2c/asahi-kasei,ak7375.yaml     | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/media/i2c/asahi-kasei,ak73=
75.yaml b/Documentation/devicetree/bindings/media/i2c/asahi-kasei,ak7375.ya=
ml
> index 22a810fc7222..fe312cc6a873 100644
> --- a/Documentation/devicetree/bindings/media/i2c/asahi-kasei,ak7375.yaml
> +++ b/Documentation/devicetree/bindings/media/i2c/asahi-kasei,ak7375.yaml
> @@ -15,7 +15,9 @@ description:
> =20
>  properties:
>    compatible:
> -    const: asahi-kasei,ak7375
> +    enum:
> +      - asahi-kasei,ak7345
> +      - asahi-kasei,ak7375
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.41.0
>=20
>=20
>=20

--pODw/iX2UkMAb4/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZUJqggAKCRB4tDGHoIJi
0slyAP9VpcF5IzeE9i4pnc3z2Dl/ml0Sd6jvPoRkLEufandUYwD+IC8ffkg6jBmB
NHs9lJ26+uz0K/TlXllzodqhGmmjvQs=
=tXf/
-----END PGP SIGNATURE-----

--pODw/iX2UkMAb4/N--
