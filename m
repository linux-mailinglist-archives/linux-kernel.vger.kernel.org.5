Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021777C6F9F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378679AbjJLNr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343925AbjJLNr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:47:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3E6BA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:47:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3955C433C7;
        Thu, 12 Oct 2023 13:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697118474;
        bh=M6/Qc0XbKAWDLzcioQK//3A7VmcEvW6GiZ4CsMaKi9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=toDLP8IoYI0zO1Qr/HpWhBSJedmIYWvtu0OWyQ/cCKT7Em1nDxVTIrGbWueqQOu9F
         uSPs+Dzi1+ob0udaJ8m6YKimln2U50iBfkmAGHGwhxGaC1lq25eK4o7I6NekVLpdkO
         QY49/LwtgRiaJbrW4YkWS2FsuwVFpp+Kq/tUQ52Fxu5cq3w03hYpAQElctBYX3Xoqu
         ffshbo3mrdDUDwsHXQQ8VjQ1Suy/VZ9PqGD7QNDdMoojnZFnyfzCbxp9J45e5Vd6tP
         lmh8YjrleBi0oEr6Ftw9f6dgBNm3CLoSpuZunOM7EaufxvwQc1B2MucilC2Eit+F/S
         y2421EuVP2obw==
Date:   Thu, 12 Oct 2023 14:47:49 +0100
From:   Conor Dooley <conor@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>
Subject: Re: [PATCH v1 04/13] dt-bindings: riscv: add Zv* ratified crypto ISA
 extensions description
Message-ID: <20231012-job-charbroil-469c3e1d2982@spud>
References: <20231011111438.909552-1-cleger@rivosinc.com>
 <20231011111438.909552-5-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+ala/M+NuL0Bx69x"
Content-Disposition: inline
In-Reply-To: <20231011111438.909552-5-cleger@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+ala/M+NuL0Bx69x
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yo,

On Wed, Oct 11, 2023 at 01:14:29PM +0200, Cl=E9ment L=E9ger wrote:
> Add Zv* vector crypto extensions that were added in "RISC-V Cryptography
> Extensions Volume II" specificationi[1]:
>=20
> - Zvbb: Vector Basic Bit-manipulation
> - Zvbc: Vector Carryless Multiplication
> - Zvkb: Vector Cryptography Bit-manipulation
> - Zvkg: Vector GCM/GMAC.
> - Zvkned: NIST Suite: Vector AES Block Cipher
> - Zvknh[ab]: NIST Suite: Vector SHA-2 Secure Hash
> - Zvksed: ShangMi Suite: SM4 Block Cipher
> - Zvksh: ShangMi Suite: SM3 Secure Hash
> - Zvkn: NIST Algorithm Suite
> - Zvknc: NIST Algorithm Suite with carryless multiply
> - Zvkng: NIST Algorithm Suite with GCM.
> - Zvks: ShangMi Algorithm Suite
> - Zvksc: ShangMi Algorithm Suite with carryless multiplication
> - Zvksg: ShangMi Algorithm Suite with GCM.
> - Zvkt: Vector Data-Independent Execution Latency.
>=20
> [1] https://drive.google.com/file/d/1gb9OLH-DhbCgWp7VwpPOVrrY6f3oSJLL/view

Link: <whatever> [1]
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> Signed-off-by: Cl=E9ment L=E9ger <cleger@rivosinc.com>
> ---
>  .../devicetree/bindings/riscv/extensions.yaml | 96 +++++++++++++++++++
>  1 file changed, 96 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index cc1f546fdbdc..4002c65145c9 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -246,5 +246,101 @@ properties:
>              in commit 2e5236 ("Ztso is now ratified.") of the
>              riscv-isa-manual.
> =20
> +        - const: zvbb
> +          description:
> +            The standard Zvbb extension for vectored basic bit-manipulat=
ion
> +            instructions, as ratified in commit 56ed795 ("Update
> +            riscv-crypto-spec-vector.adoc") of riscv-crypto.
> +
> +        - const: zvbc
> +          description:
> +            The standard Zvbc extension for vectored carryless multiplic=
ation
> +            instructions, as ratified in commit 56ed795 ("Update
> +            riscv-crypto-spec-vector.adoc") of riscv-crypto.
> +
> +        - const: zvkb
> +          description:
> +            The standard Zvkb extension for vector cryptography bit-mani=
pulation
> +            instructions, as ratified in commit 56ed795 ("Update
> +            riscv-crypto-spec-vector.adoc") of riscv-crypto.
> +
> +        - const: zvkg
> +          description:
> +            The standard Zvkg extension for vector GCM/GMAC instructions=
, as
> +            ratified in commit 56ed795 ("Update riscv-crypto-spec-vector=
=2Eadoc")
> +            of riscv-crypto.
> +
> +        - const: zvkn
> +          description:
> +            The standard Zvkn extension for NIST algorithm suite instruc=
tions, as
> +            ratified in commit 56ed795 ("Update riscv-crypto-spec-vector=
=2Eadoc")
> +            of riscv-crypto.
> +
> +        - const: zvknc
> +          description:
> +            The standard Zvknc extension for NIST algorithm suite with c=
arryless
> +            multiply instructions, as ratified in commit 56ed795 ("Update
> +            riscv-crypto-spec-vector.adoc") of riscv-crypto.
> +
> +        - const: zvkned
> +          description:
> +            The standard Zvkned extension for Vector AES block cipher
> +            instructions, as ratified in commit 56ed795 ("Update
> +            riscv-crypto-spec-vector.adoc") of riscv-crypto.
> +
> +        - const: zvkng
> +          description:
> +            The standard Zvkng extension for NIST algorithm suite with G=
CM
> +            instructions, as ratified in commit 56ed795 ("Update
> +            riscv-crypto-spec-vector.adoc") of riscv-crypto.
> +
> +        - const: zvknha
> +          description: |
> +            The standard Zvknha extension for NIST suite: vector SHA-2 s=
ecure,
> +            hash (SHA-256 only) instructions, as ratified in commit
> +            56ed795 ("Update riscv-crypto-spec-vector.adoc") of riscv-cr=
ypto.
> +
> +        - const: zvknhb
> +          description: |
> +            The standard Zvknhb extension for NIST suite: vector SHA-2 s=
ecure,
> +            hash (SHA-256 and SHA-512) instructions, as ratified in comm=
it
> +            56ed795 ("Update riscv-crypto-spec-vector.adoc") of riscv-cr=
ypto.
> +
> +        - const: zvks
> +          description:
> +            The standard Zvks extension for ShangMi algorithm suite
> +            instructions, as ratified in commit 56ed795 ("Update
> +            riscv-crypto-spec-vector.adoc") of riscv-crypto.
> +
> +        - const: zvksc
> +          description:
> +            The standard Zvksc extension for ShangMi algorithm suite with
> +            carryless multiplication instructions, as ratified in commit=
 56ed795
> +            ("Update riscv-crypto-spec-vector.adoc") of riscv-crypto.
> +
> +        - const: zvksed
> +          description: |
> +            The standard Zvksed extension for ShangMi suite: SM4 block c=
ipher
> +            instructions, as ratified in commit 56ed795 ("Update
> +            riscv-crypto-spec-vector.adoc") of riscv-crypto.
> +
> +        - const: zvksh
> +          description: |
> +            The standard Zvksh extension for ShangMi suite: SM3 secure h=
ash
> +            instructions, as ratified in commit 56ed795 ("Update
> +            riscv-crypto-spec-vector.adoc") of riscv-crypto.
> +
> +        - const: zvksg
> +          description:
> +            The standard Zvksg extension for ShangMi algorithm suite wit=
h GCM
> +            instructions, as ratified in commit 56ed795 ("Update
> +            riscv-crypto-spec-vector.adoc") of riscv-crypto.
> +
> +        - const: zvkt
> +          description:
> +            The standard zvkt extension for vector data-independent exec=
ution
> +            latency, as ratified in commit 56ed795 ("Update
> +            riscv-crypto-spec-vector.adoc") of riscv-crypto.
> +
>  additionalProperties: true
>  ...
> --=20
> 2.42.0
>=20

--+ala/M+NuL0Bx69x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSf5BQAKCRB4tDGHoIJi
0geQAQDhWB73Yqnqqsw5vfDyfuBoHydY4VRH771rfIyg9uid7gEAv07b2l+r1hLN
isOAcrJ0GWoMBgFW2kO9X6FTgAPTsgk=
=sC9E
-----END PGP SIGNATURE-----

--+ala/M+NuL0Bx69x--
