Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129577B07D9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbjI0PNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbjI0PNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:13:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA893F5;
        Wed, 27 Sep 2023 08:13:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA932C433C8;
        Wed, 27 Sep 2023 15:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695827588;
        bh=g5EOXFHedEBnggecBSFHP8NOek2TJapAj4sjU/UIAz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mxgaPNkc986KVYs3slQ+tMkDMhuGs1SZJEnQSCDks5EJZqTJ09v5w5xzWElWVQlHp
         e7FN3HgM/tb8EXKMB/2CexMjdwXYPxWXTW8Z7fUyY38cLl6OqR5KJeTJBNCsmNu/Vl
         9Xjn/fmYvizs05tRnO/vbgslZyGoMSmA/XMbB3C2D+ChQ+QUVR0auIO6wDMpm1W31G
         UPa+zYTE7sTLPv2ybAOms8QfGlJ2IrC5Xao/sMXdgOhlTxze81sH4HeMuuvdHGSSX2
         i1TeYB+IXYQw4WOfxFvs010/sG5ji9ERz8Tksjm97dD8nidsXX2M2BaSS715P6ptx4
         aEjlMTo1IpuJA==
Date:   Wed, 27 Sep 2023 16:13:03 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: thermal: nvidia,tegra124-soctherm: Add
 missing unevaluatedProperties on child node schemas
Message-ID: <20230927-tiling-hunting-453feaac8b1c@spud>
References: <20230926164500.101593-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IhOOYgmqxIzylWTn"
Content-Disposition: inline
In-Reply-To: <20230926164500.101593-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IhOOYgmqxIzylWTn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2023 at 11:44:52AM -0500, Rob Herring wrote:
> Just as unevaluatedProperties or additionalProperties are required at
> the top level of schemas, they should (and will) also be required for
> child node schemas. That ensures only documented properties are
> present for any node.
>=20
> Add unevaluatedProperties as needed, and then add any missing properties
> flagged by the addition.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  .../bindings/thermal/nvidia,tegra124-soctherm.yaml           | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-so=
ctherm.yaml b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soc=
therm.yaml
> index 04a2ba1aa946..b0237d236021 100644
> --- a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.=
yaml
> +++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.=
yaml
> @@ -68,7 +68,12 @@ properties:
>      patternProperties:
>        "^(light|heavy|oc1)$":
>          type: object
> +        additionalProperties: false
> +
>          properties:
> +          "#cooling-cells":
> +            const: 2
> +
>            nvidia,priority:
>              $ref: /schemas/types.yaml#/definitions/uint32
>              minimum: 1
> --=20
> 2.40.1
>=20

--IhOOYgmqxIzylWTn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRRGfwAKCRB4tDGHoIJi
0pL5AP93nGR1ok7VfGFI8vPrm3J9Y/DSPEG2zoqDGmjLAOyZHwD+OeCakWy91CkC
Eur1LH00tjtdCXMthnUKfCT3lj9c8wo=
=CF+b
-----END PGP SIGNATURE-----

--IhOOYgmqxIzylWTn--
