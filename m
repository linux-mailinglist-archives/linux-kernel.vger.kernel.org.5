Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28C2778183
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbjHJT0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236302AbjHJT0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:26:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F95C7;
        Thu, 10 Aug 2023 12:26:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D125864018;
        Thu, 10 Aug 2023 19:26:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DEDEC433C7;
        Thu, 10 Aug 2023 19:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691695609;
        bh=h2DqxVG13dnsEkNHhyxyTR+mtl+zHvJP4CblhcYkRrM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I73IqMyUiqgFtxCIB5FADS0X1Inn8xBcqvIWpl+naTeOatdDjd73eqoXSctboPtMD
         hu3H0UUbqRNw+ExRvLmGPZkgid5SLmr4zEd+rbHP/mX7Jy9vZAtqZVe6WXJg1A3pmY
         Oa8lutgbqB+Pft+fQqenG0odXyAmgAcZY87dDoYc75S/9kayrpA5X85mpPznGdjcO1
         XKbpafIl4J7sPNhHe4907D3hr35bHWMYflkWZmzXF1962zkDl2pKPh6yVdJfyFMEcc
         4oMAxiCWLHmtklNrCsBUvi+Yc3ogfSif46rqJOCkzfCYecdp1fW7WyIpjxaKMD4zcS
         M8BwK/qwBhEbQ==
Date:   Thu, 10 Aug 2023 20:26:44 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Hari Nagalla <hnagalla@ti.com>
Cc:     andersson@kernel.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, s-anna@ti.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: remoteproc: k3-dsp: correct optional sram
 properties for AM62A SoCs
Message-ID: <20230810-dramatic-disregard-c254d763e1fe@spud>
References: <20230810110545.11644-1-hnagalla@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pXtfXRWhPXTRbs8a"
Content-Disposition: inline
In-Reply-To: <20230810110545.11644-1-hnagalla@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pXtfXRWhPXTRbs8a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2023 at 06:05:45AM -0500, Hari Nagalla wrote:
> The C7xv-dsp on AM62A have 32KB L1 I-cache and a 64KB L1 D-cache. It
> does not have an addressable l1dram . So, remove this optional sram
> property from the bindings to fix device tree build warnings.
>=20
> Also set the 'memory-regions' property as optional. This is because
> the remote processors can function without carveout regions.

I thought I already said this today, but must be hallucinating - this
second part here seems like it in an unrelated change that should go in
its own patch..

>=20
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> ---
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

--pXtfXRWhPXTRbs8a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNU59AAKCRB4tDGHoIJi
0ujdAP9/gwpeMbJnjqYnN0kVayzEgItu2KClO+kgQ81UuQw4NgEA5Y6J+VbZyben
m5NLRRbeqxk7L2omT+VGx0b9piUZ5AM=
=czQE
-----END PGP SIGNATURE-----

--pXtfXRWhPXTRbs8a--
