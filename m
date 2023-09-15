Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F02F7A2900
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 23:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237746AbjIOVIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 17:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237647AbjIOVHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 17:07:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1CAB8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 14:07:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9AE6C433C8;
        Fri, 15 Sep 2023 21:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694812062;
        bh=yWUk6FUlYOLjDYbRClgivGA5rBQf/ssbmNXyCcG5dBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X8q+80RgmydYetEN7N0GuV/XpsFwFSajEX0D3KmsUTxIw9rvCQcWvk0fpEBDmsEYT
         vYIYaJV0uZ6gzsiMgLZUf9OpNnY3nMKS6M5RH2Qew5MZwU3Ksy/tuCdiyFjFhkc3mE
         aD4pM9bDK4eEddohaQrgLBJfveET1P97K+buMbvWtcuTUYQECsjTOjK0DYOmIIiamk
         yR9SBKszFgdOeAjPIjovoalbwt4nDjhrPu/ZUKe9rr+j6k0iiUMx1X4KGlUOrF2378
         44fTiEFhgPC7INW74fZwPuS76j7V/G/RkyQZcGCZwl/vRofGKuZAPJlAKA+GGi1DDL
         DU9nr+905/RsA==
Date:   Fri, 15 Sep 2023 22:07:38 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: riscv: cpus: Add missing
 additionalProperties on interrupt-controller node
Message-ID: <20230915-ethanol-doorframe-f500a5d9521e@spud>
References: <20230915201946.4184468-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="064DYEBcFbFiNMAU"
Content-Disposition: inline
In-Reply-To: <20230915201946.4184468-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--064DYEBcFbFiNMAU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2023 at 03:19:36PM -0500, Rob Herring wrote:
> The "interrupt-controller" CPU child node is missing constraints on
> extra properties. Add "additionalProperties: false" to fix this.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Was wondering why I couldn't see this in my dt queue, guess
get_maintainer.pl struggled with the multiple claims on the file :)
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Document=
ation/devicetree/bindings/riscv/cpus.yaml
> index 38c0b5213736..97e8441eda1c 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -91,6 +91,7 @@ properties:
> =20
>    interrupt-controller:
>      type: object
> +    additionalProperties: false
>      description: Describes the CPU's local interrupt controller
> =20
>      properties:
> --=20
> 2.40.1
>=20

--064DYEBcFbFiNMAU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQTHmgAKCRB4tDGHoIJi
0g91AP0YiS0atHOPqWoysBPu+aFzJt8G+4W+Ng/yWcAqOg2rmAEAyWksUAWE2Blw
L+/D+8Tq4OdxCfKJjDcWuW8QGTBZZQ8=
=BkiN
-----END PGP SIGNATURE-----

--064DYEBcFbFiNMAU--
