Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF29777DD8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236674AbjHJQNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234219AbjHJQNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:13:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274C54ED4;
        Thu, 10 Aug 2023 09:06:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5A0A66230;
        Thu, 10 Aug 2023 16:05:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFFBC433C9;
        Thu, 10 Aug 2023 16:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691683545;
        bh=sE8vJImQJfqIlIoT9GJZ2NkALnDsa4xnLuDYzHmO9oI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l8QpO+0ON3P8JihVTCPLoFyPj/dwAoH0ErCMEO2PXBtmFgobtKRVUtfb0xSyCOkzd
         2tnJgZRQ4cT2j7INbbzbZFEbhL2nnbK+W9FfmBEDZ6Lt4NNlKrtH7UOKB4FAkX5NIW
         yVv86r+zxl4Dbt2mD32mk1O9S/DR+rKm2fJ2NIBnKUrBSZR8yXx/w298eoll3T3kyh
         hG9lwqqusb5EOKApmHpZ2m1EJqBn+pcq/XTfTc2o3Zp7BN25e8oYMbMDEKx26nYtBn
         W3+c6jb+msJ8aqZjSP30ym38RIQEii3ncS7XJoMy5JM0RucrYC3eU82O+eplhv9h2T
         r1Osv+mywiuvg==
Date:   Thu, 10 Aug 2023 17:05:40 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Hari Nagalla <hnagalla@ti.com>
Cc:     nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: remoteproc: k3-dsp: correct optional
 sram properties for AM62A SoCs
Message-ID: <20230810-pastor-unneeded-c79bd4b5875e@spud>
References: <20230810005850.21998-1-hnagalla@ti.com>
 <20230810005850.21998-2-hnagalla@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dyc38nYae261xfW+"
Content-Disposition: inline
In-Reply-To: <20230810005850.21998-2-hnagalla@ti.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dyc38nYae261xfW+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 09, 2023 at 07:58:46PM -0500, Hari Nagalla wrote:
> The C7xv-dsp on AM62A have 32KB L1 I-cache and a 64KB L1 D-cache. It
> does not have an addressable l1dram . So, remove this optional sram
> property from the bindings to fix device tree build warnings.
>=20

> Also set the 'memory-regions' property as optional. This is because
> the remote processors can function without carveout regions.

That seems like an unrelated change that deserves its own commit..

>=20
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> ---
> Changes since v1:
>  - Corrected dsp node binding doc file to fix yamllint warnings for am62a.
>=20
>  .../bindings/remoteproc/ti,k3-dsp-rproc.yaml     | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc=
=2Eyaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
> index f16e90380df1..8dd22c57e22d 100644
> --- a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
> @@ -111,7 +111,6 @@ else:
>      properties:
>        compatible:
>          enum:
> -          - ti,am62a-c7xv-dsp
>            - ti,j721e-c71-dsp
>            - ti,j721s2-c71-dsp
>    then:
> @@ -124,6 +123,20 @@ else:
>          items:
>            - const: l2sram
>            - const: l1dram
> +  else:
> +    if:
> +      properties:
> +        compatible:
> +          enum:
> +            - ti,am62a-c7xv-dsp
> +    then:
> +      properties:
> +        reg:
> +          items:
> +            - description: Address and Size of the L2 SRAM internal memo=
ry region
> +        reg-names:
> +          items:
> +            - const: l2sram
> =20
>  required:
>    - compatible
> @@ -135,7 +148,6 @@ required:
>    - resets
>    - firmware-name
>    - mboxes
> -  - memory-region
> =20
>  unevaluatedProperties: false
> =20
> --=20
> 2.34.1
>=20

--dyc38nYae261xfW+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNUK1AAKCRB4tDGHoIJi
0kr0AP9B06s/CatMWhvBB2RlunbKgobud2j9uCx8xtjKzXn9ugD/Rrvjh5Zp4SlX
iNlgr1ksATHgu0qlBDYZkHreoJKlig8=
=MyTp
-----END PGP SIGNATURE-----

--dyc38nYae261xfW+--
