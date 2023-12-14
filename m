Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D418132B8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjLNOOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjLNOOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:14:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C377C9C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 06:14:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A585C433C8;
        Thu, 14 Dec 2023 14:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702563286;
        bh=wkD8ZyahJypOO+5Crrc5pRGXWHc7YtwbESGjV16riik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fS8GBBui8fZG3+8f96qcY5IMX4PbMPLMqMTEUT0/VtNCuTGZirBDWHhvfaObxmfmf
         uXTfnJlGSsnXI46ykxNASlGPQsIbKbbbzI3t7JUcbzUBOGtz4qNeJBBjf8xQpHQlOe
         ASWuCCq4XDCftqZJpSYHukyrQdTSr07b/N+gdGGm06BsREXW4HNJc7Derg9wy4y0Z2
         Hq0apk2UQkbluBLX7a2qig7SXJsf4RTYCPQ6Fm9iOzf1uydqGQ8hmf1cv/Lv/P5GNO
         JlkliiUv3RV9P3/iiJdko72B3V2ndILpT+BJtCcVEgpYLXan57PZWg8NXn/XXqzHY+
         ZdWkWYrNU5/FQ==
Date:   Thu, 14 Dec 2023 14:14:41 +0000
From:   Conor Dooley <conor@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc:     linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robbin Ehn <rehn@rivosinc.com>
Subject: Re: [PATCH 4/9] riscv: add ISA extension parsing for Zam
Message-ID: <20231214-acts-udder-37d0162e4f61@spud>
References: <20231213113308.133176-1-cleger@rivosinc.com>
 <20231213113308.133176-5-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WZWs6NLSd1UVh/cf"
Content-Disposition: inline
In-Reply-To: <20231213113308.133176-5-cleger@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WZWs6NLSd1UVh/cf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 12:33:00PM +0100, Cl=E9ment L=E9ger wrote:
> Add parsing for Zam ISA extension which is part of the riscv-isa manual
> but was not added to ISA parsing up to now.

This does not appear to be frozen or ratified, NAK.

Cheers,
Conor.

>=20
> Signed-off-by: Cl=E9ment L=E9ger <cleger@rivosinc.com>
> ---
>  arch/riscv/include/asm/hwcap.h | 1 +
>  arch/riscv/kernel/cpufeature.c | 1 +
>  2 files changed, 2 insertions(+)
>=20
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwca=
p.h
> index 3b31efe2f716..016faa08c8ba 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -85,6 +85,7 @@
>  #define RISCV_ISA_EXT_ZVFHMIN		70
>  #define RISCV_ISA_EXT_ZFA		71
>  #define RISCV_ISA_EXT_ZTSO		72
> +#define RISCV_ISA_EXT_ZAM		73
> =20
>  #define RISCV_ISA_EXT_MAX		128
>  #define RISCV_ISA_EXT_INVALID		U32_MAX
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 3eb48a0eecb3..e999320398b7 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -259,6 +259,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D {
>  	__RISCV_ISA_EXT_DATA(zihintntl, RISCV_ISA_EXT_ZIHINTNTL),
>  	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
>  	__RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
> +	__RISCV_ISA_EXT_DATA(zam, RISCV_ISA_EXT_ZAM),
>  	__RISCV_ISA_EXT_DATA(zfa, RISCV_ISA_EXT_ZFA),
>  	__RISCV_ISA_EXT_DATA(zfh, RISCV_ISA_EXT_ZFH),
>  	__RISCV_ISA_EXT_DATA(zfhmin, RISCV_ISA_EXT_ZFHMIN),
> --=20
> 2.43.0
>=20

--WZWs6NLSd1UVh/cf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXsN0QAKCRB4tDGHoIJi
0mOAAP9FBVgammIN1Czcclk1+2JsV7aZsiieQoCdaP7DVN3IHAD/bOx6eMuPj4pR
So4KVt0UR5nj9k0dkJyitxbhYc2V9w0=
=CPjK
-----END PGP SIGNATURE-----

--WZWs6NLSd1UVh/cf--
