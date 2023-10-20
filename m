Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6647D0C5C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 11:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376752AbjJTJyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 05:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376319AbjJTJyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 05:54:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66204C2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 02:54:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40352C433C8;
        Fri, 20 Oct 2023 09:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697795662;
        bh=Mc1hlPCWDoEzc67b2HL65SjbenBfZTNLrCCBJI6gx7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GduuNVjSDu84xGDEpDVvVDUHbOk5JsbRHqP6jtnwPBIe0da+m4IDOvYN7VVIaxyoj
         7Z0XVpHKpTj8/YWkF+1W7x87mbD/ZNRc2E01ItapradAApLpnA60uQzlqMxIc+4aJR
         9zFw/VkPDfl5RSs+STNsOomKEN0HQAw1wVpGWRN+gr12jQHFCKqoOtR3oTtAQ6pcP9
         ctFCsQZk+ptWuv7BptiZczdQfxnPHFUZrvE9BjRg++wLPKoLylPdw42gkFBkpXlwTA
         DyZ26W/Jw5KLUXJS+OZ+9UsMEljFQD3t4WGMW9mYgvDSywplMh83bwmG6ZthfhEWfA
         mzcLDSsblx8gQ==
Date:   Fri, 20 Oct 2023 10:54:16 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Yu Chien Peter Lin <peterlin@andestech.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com, tim609@andestech.com,
        dylan@andestech.com, locus84@andestech.com, dminus@andestech.com
Subject: Re: [PATCH v2 05/10] dt-bindings: riscv: Add andestech,cpu-intc to
 interrupt-controller
Message-ID: <20231020-droop-decimeter-eb22d50d785c@spud>
References: <20231019135905.3658215-1-peterlin@andestech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aOzht/ojDeW4Ytjn"
Content-Disposition: inline
In-Reply-To: <20231019135905.3658215-1-peterlin@andestech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aOzht/ojDeW4Ytjn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yo,

On Thu, Oct 19, 2023 at 09:59:05PM +0800, Yu Chien Peter Lin wrote:
> Add "andestech,cpu-intc" compatible string for Andes INTC which
> provides Andes-specific IRQ chip functions.

You need to provide some information as to what differentiates your intc
=66rom the regular one, not mention linux driver specifics.

>=20
> Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> ---
> Changes v1 -> v2:
>   - New patch
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Document=
ation/devicetree/bindings/riscv/cpus.yaml
> index 97e8441eda1c..5b216e11c69f 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -99,7 +99,9 @@ properties:
>          const: 1
> =20
>        compatible:
> -        const: riscv,cpu-intc
> +        enum:
> +          - riscv,cpu-intc
> +          - andestech,cpu-intc

Should the andestech intc not fall back to the generic intc compatible?
The generic one appears to implement a compatible subset of the features
that yours does.

Cheers,
Conor.

> =20
>        interrupt-controller: true
> =20
> --=20
> 2.34.1
>=20
>=20

--aOzht/ojDeW4Ytjn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTJOSAAKCRB4tDGHoIJi
0kNAAPsFMkJdFWcgrUXsnlWZMeknHckgIwKEIgWH18LiCsJoCQD/SSbOIBby4lmf
fEtXLi5CVUzMCTEadGcz0sJW+kxJygY=
=eRD6
-----END PGP SIGNATURE-----

--aOzht/ojDeW4Ytjn--
