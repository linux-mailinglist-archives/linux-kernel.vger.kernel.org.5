Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FC4762181
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 20:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjGYSg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 14:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjGYSg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 14:36:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39ACCA3;
        Tue, 25 Jul 2023 11:36:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAFEF6186A;
        Tue, 25 Jul 2023 18:36:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21252C433C8;
        Tue, 25 Jul 2023 18:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690310216;
        bh=OGAIKbXq7O9WeJtvnXVPVvM6DnU7j4TZ+hNdMohimag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gMg3P79k8aKtrtkMMrtgUv7h8bH8RD3YwhsYxv4Ybx2vBnLBR3eIMZf/upVEB5yMC
         RU98h6zMSNx4dc1AYZIPjCY+uddFUj3TXoERhCK9EYnxMl1xSGvg678GguGhpIJDv3
         IwMpi3goPYlMFB7rpnNWR2YeFc573uZxIICM42cVJqmOLV8R0+f+QrsjZGo6yjR1j/
         bssjnR9J0+reLYeEMMFf5i7ZoZKLvO9yACB5EjY8jlYCLm9sgCxZk8fStJZv/uSayk
         Orcw6p6H1AJtpFFbI92Zd2+4LbS2JSZjwlLGiueYNTAF/OVt8x3yZd2rg7P200ANye
         k2P/C9vPdkXyQ==
Date:   Tue, 25 Jul 2023 19:36:51 +0100
From:   Conor Dooley <conor@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, ulf.hansson@linaro.org, shawnguo@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] dt-bindings: power: fsl,scu-pd: separate out fsl,scu-pd
Message-ID: <20230725-excretory-speed-003064040657@spud>
References: <20230725102900.225262-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7EZV4UB6EfrGONHL"
Content-Disposition: inline
In-Reply-To: <20230725102900.225262-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7EZV4UB6EfrGONHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2023 at 06:29:00PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Add an entry dedicated for fsl,scu-pd which could serve i.MX8DXL

Why not just add a soc-specific compatible for the i.MX8DXL?
The current form of this does not look right to me.

>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/power/fsl,scu-pd.yaml         | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/fsl,scu-pd.yaml b/Do=
cumentation/devicetree/bindings/power/fsl,scu-pd.yaml
> index 407b7cfec783..3a92e4fef7ae 100644
> --- a/Documentation/devicetree/bindings/power/fsl,scu-pd.yaml
> +++ b/Documentation/devicetree/bindings/power/fsl,scu-pd.yaml
> @@ -18,11 +18,14 @@ allOf:
> =20
>  properties:
>    compatible:
> -    items:
> +    oneOf:
>        - enum:
> -          - fsl,imx8qm-scu-pd
> -          - fsl,imx8qxp-scu-pd
> -      - const: fsl,scu-pd
> +          - fsl,scu-pd
> +      - items:
> +          - enum:
> +              - fsl,imx8qm-scu-pd
> +              - fsl,imx8qxp-scu-pd
> +          - const: fsl,scu-pd
> =20
>    '#power-domain-cells':
>      const: 1
> --=20
> 2.37.1
>=20

--7EZV4UB6EfrGONHL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMAWQwAKCRB4tDGHoIJi
0rfNAQDlWP28k/SoGr0qeOAevMMGAMV+FRHZnsFzjAeh+XfLjQD8CXmyqPBN73TK
+5kkiXUj9PNRUue0TPtJwgbO6qNX/AI=
=bo2G
-----END PGP SIGNATURE-----

--7EZV4UB6EfrGONHL--
