Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73ACB7CFF42
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbjJSQRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjJSQRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:17:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9879B
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:17:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3897C433C8;
        Thu, 19 Oct 2023 16:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697732248;
        bh=wwtqeVi8T90A9eG78e3y+UAer9+rhT+4XKm5eCrsfu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qU8+NRhCGj0wLiyKMJejDFBHY6PyTE12U0baIO6jDJBN9PY79b+2NYYh8cjCY4QBW
         2OyhriUXBhcz6Boz/gmmhlb5nFahk6hNpabaYoz3/ON2tnCyQZQVocpOFoRRirrRoS
         eohAeVEnuu/jmJkBtGbMROoWtQS8BHkV8HJD9iAgyjSMOtlThdZVFgVWbpa6yzwYtn
         +M2S2aGcbUc9d/bTlY1xxJw4F0CV0CENipv0WVZbJRpbWn6eWCYdBtpEN0lw7228b0
         g+cP/w3Pv5qi8qi0jdmzFLggdETfmRwVIvoYI/QZr+J5MFlF4QJ7KHWXNWAJuu97B1
         EFkkqdzzXGDZw==
Date:   Thu, 19 Oct 2023 17:17:22 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Yu Chien Peter Lin <peterlin@andestech.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, dminus@andestech.com,
        conor.dooley@microchip.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com, ajones@ventanamicro.com,
        heiko@sntech.de, guoren@kernel.org, jszhang@kernel.org,
        samuel@sholland.org, uwu@icenowy.me, ycliang@andestech.com,
        evan@rivosinc.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, tim609@andestech.com,
        dylan@andestech.com, locus84@andestech.com
Subject: Re: [PATCH v2 01/10] riscv: errata: Rename defines for Andes
Message-ID: <20231019-shrimp-configure-0eb42294d459@spud>
References: <20231019135329.3654793-1-peterlin@andestech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="j/9DDxIzSK4GeIB/"
Content-Disposition: inline
In-Reply-To: <20231019135329.3654793-1-peterlin@andestech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--j/9DDxIzSK4GeIB/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 09:53:29PM +0800, Yu Chien Peter Lin wrote:
> Using "ANDES" rather than "ANDESTECH" to unify the naming
> convention with OpenSBI and U-Boot, and reduce the number
> of characters per line.

NGL, I think this is just churn and the 4-characters-per-line
saving is a weak argument & u-boot/opensbi alignment is not really
relevant. A better argument for it is probably unification with the
directory/file names, Kconfig options and with the
ANDES_SBI_EXT_OPCP_SW_WORKAROUND definitions.

/shrug,
Conor.

>=20
> Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> Reviewed-by: Charles Ci-Jyun Wu <dminus@andestech.com>
> Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
> ---
> Changes v1 -> v2:
>   - No change
> ---
>  arch/riscv/errata/andes/errata.c       | 10 +++++-----
>  arch/riscv/include/asm/errata_list.h   |  4 ++--
>  arch/riscv/include/asm/vendorid_list.h |  2 +-
>  arch/riscv/kernel/alternative.c        |  2 +-
>  4 files changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/riscv/errata/andes/errata.c b/arch/riscv/errata/andes/e=
rrata.c
> index 197db68cc8da..d2e1abcac967 100644
> --- a/arch/riscv/errata/andes/errata.c
> +++ b/arch/riscv/errata/andes/errata.c
> @@ -18,9 +18,9 @@
>  #include <asm/sbi.h>
>  #include <asm/vendorid_list.h>
> =20
> -#define ANDESTECH_AX45MP_MARCHID	0x8000000000008a45UL
> -#define ANDESTECH_AX45MP_MIMPID		0x500UL
> -#define ANDESTECH_SBI_EXT_ANDES		0x0900031E
> +#define ANDES_AX45MP_MARCHID		0x8000000000008a45UL
> +#define ANDES_AX45MP_MIMPID		0x500UL
> +#define ANDES_SBI_EXT_ANDES		0x0900031E
> =20
>  #define ANDES_SBI_EXT_IOCP_SW_WORKAROUND	1
> =20
> @@ -32,7 +32,7 @@ static long ax45mp_iocp_sw_workaround(void)
>  	 * ANDES_SBI_EXT_IOCP_SW_WORKAROUND SBI EXT checks if the IOCP is missi=
ng and
>  	 * cache is controllable only then CMO will be applied to the platform.
>  	 */
> -	ret =3D sbi_ecall(ANDESTECH_SBI_EXT_ANDES, ANDES_SBI_EXT_IOCP_SW_WORKAR=
OUND,
> +	ret =3D sbi_ecall(ANDES_SBI_EXT_ANDES, ANDES_SBI_EXT_IOCP_SW_WORKAROUND,
>  			0, 0, 0, 0, 0, 0);
> =20
>  	return ret.error ? 0 : ret.value;
> @@ -43,7 +43,7 @@ static bool errata_probe_iocp(unsigned int stage, unsig=
ned long arch_id, unsigne
>  	if (!IS_ENABLED(CONFIG_ERRATA_ANDES_CMO))
>  		return false;
> =20
> -	if (arch_id !=3D ANDESTECH_AX45MP_MARCHID || impid !=3D ANDESTECH_AX45M=
P_MIMPID)
> +	if (arch_id !=3D ANDES_AX45MP_MARCHID || impid !=3D ANDES_AX45MP_MIMPID)
>  		return false;
> =20
>  	if (!ax45mp_iocp_sw_workaround())
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/as=
m/errata_list.h
> index b55b434f0059..c190393aa9db 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -12,8 +12,8 @@
>  #include <asm/vendorid_list.h>
> =20
>  #ifdef CONFIG_ERRATA_ANDES
> -#define ERRATA_ANDESTECH_NO_IOCP	0
> -#define ERRATA_ANDESTECH_NUMBER		1
> +#define ERRATA_ANDES_NO_IOCP 0
> +#define ERRATA_ANDES_NUMBER 1
>  #endif
> =20
>  #ifdef CONFIG_ERRATA_SIFIVE
> diff --git a/arch/riscv/include/asm/vendorid_list.h b/arch/riscv/include/=
asm/vendorid_list.h
> index e55407ace0c3..2f2bb0c84f9a 100644
> --- a/arch/riscv/include/asm/vendorid_list.h
> +++ b/arch/riscv/include/asm/vendorid_list.h
> @@ -5,7 +5,7 @@
>  #ifndef ASM_VENDOR_LIST_H
>  #define ASM_VENDOR_LIST_H
> =20
> -#define ANDESTECH_VENDOR_ID	0x31e
> +#define ANDES_VENDOR_ID		0x31e
>  #define SIFIVE_VENDOR_ID	0x489
>  #define THEAD_VENDOR_ID		0x5b7
> =20
> diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternat=
ive.c
> index 319a1da0358b..0128b161bfda 100644
> --- a/arch/riscv/kernel/alternative.c
> +++ b/arch/riscv/kernel/alternative.c
> @@ -43,7 +43,7 @@ static void riscv_fill_cpu_mfr_info(struct cpu_manufact=
urer_info_t *cpu_mfr_info
> =20
>  	switch (cpu_mfr_info->vendor_id) {
>  #ifdef CONFIG_ERRATA_ANDES
> -	case ANDESTECH_VENDOR_ID:
> +	case ANDES_VENDOR_ID:
>  		cpu_mfr_info->patch_func =3D andes_errata_patch_func;
>  		break;
>  #endif
> --=20
> 2.34.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--j/9DDxIzSK4GeIB/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTFWkgAKCRB4tDGHoIJi
0vKcAQD7/5ed28QgqwN8OzDUvTDRZVQYxWaeLacNvyAa8AY6KQEA8Hf8qaNx+/BH
SIyVv6jWcKM5owcNlut0TDNs15Sc3g0=
=BfbK
-----END PGP SIGNATURE-----

--j/9DDxIzSK4GeIB/--
