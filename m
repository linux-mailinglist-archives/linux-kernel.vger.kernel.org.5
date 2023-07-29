Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B8076810C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 20:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjG2Sj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 14:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjG2Sjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 14:39:55 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA10E4E;
        Sat, 29 Jul 2023 11:39:50 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.97.66]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MDygG-1qXY5E3dEy-00A07c; Sat, 29 Jul 2023 20:38:57 +0200
Received: from localhost.fjasle.eu (kirkenes.fjasle.eu [10.10.0.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 46E063E9EF;
        Sat, 29 Jul 2023 20:38:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1690655932; bh=QwynynEmRUGdimf9sBFUFDIzzp27aFLDEwfNY3NpIJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AjgHMEAyq4o9+afSwluICI/L6+3NjRKSggklRT3qGzEN+BykcvMD6bnTLpf3S0kCC
         0mPqkLDAkFHDGn2ggHX9vr9yEaCfxGidr2D24yhDcADDvaaEGj26hVNOUVGSA54mAm
         5+Txnqnnpy+l2vhMBUrkbWklVwz+L7Poz/ARyt1k=
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id DA14C6087; Sat, 29 Jul 2023 20:38:12 +0200 (CEST)
Date:   Sat, 29 Jul 2023 20:38:12 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        John Stultz <jstultz@google.com>, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v3 2/4] scripts/mksysmap: Factor out sed ignored symbols
 expression into script
Message-ID: <ZMVclGCbEK33g+2g@bergen.fjasle.eu>
References: <20230728113415.21067-1-will@kernel.org>
 <20230728113415.21067-3-will@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uEI2BuDe0NhIfEtZ"
Content-Disposition: inline
In-Reply-To: <20230728113415.21067-3-will@kernel.org>
X-Operating-System: Debian GNU/Linux trixie/sid
Jabber-ID: nicolas@jabber.no
X-Provags-ID: V03:K1:sn1ot5ai8XeaL/89KCler/Rs3uJrE0PR1g724o0RdXoxIXUPrsX
 MJ/WAmVaPS6kpwaZZwvZbMt91nqaNpXiDH2oMKDhFUV7Qi9X1twj5fE8P+lxxaSnZVAA2hf
 dfz3gh2Rr/FblitVeKQRrAmxd0KRI5PoNzVMqINZ7x1Xv1KZV+GWpPq21UAdIVi6cH/VfpB
 TGbL5luNi3EIkd3zne5aQ==
UI-OutboundReport: notjunk:1;M01:P0:fEpoDGgtNBU=;+bZwjM/frwCqtBmHOcPYSQe61pO
 NDS6ZDqvVmqUreyBolHdUnDDgS8pJUxv+Ztphpg9adfSHWu/3f/QELTT1mbLwswf/Zg41Yju0
 yE6nWn4vwUoyNgDtXuOKc0U6Waz49FzCAb8ioZ0vr5n+Z2G7ijyT8PRJG7Q92+IY+TI7hc8Xs
 /WH0sulU2QOL1i6MgnnR+YK0GppmAULEcGyVSUL6XGhWnV2L9hgtippkjgHzUA5o+1DNY5rD6
 W7hG0F4l4PfIUu77mc/RgiaMXnsDg/i95UtcP35Hq0MD/KjCZrQV0hGIHV/BgwlDlAQ49HiVe
 alIjbGzokjpf9bhSD/ETRDd7G8xwmAnPnFjBTQU421t6nHqfQxqN2f+BsQBpDK/3VIFCvWgw4
 LPHoKJ0EFWNbXDFrhih4WC/fSeUToFm2GQ0zv7Den0R4cLw0dlFGRB1Qf6KsGjGsJI1XyqJCm
 jMcYHxoCW5czCoRSaYshfeq9t0jhsCE9S0DqcOVmif2EzsWfkiwMo0892ioRW1IYqpvqyRxlT
 ZA5L7mI/OAx34I+pQGJBrZgAVE8adogYhT+YEbFAFG+V+Vwn8aY40/55NOqOWJgmZDwHjcXW6
 nilVKl06UZ+5G6l2oZ8pXScjLnAPvgs1RfROvd8tC/a0t7BAgUQAiNNtOF1Zy3O65EuGSd+50
 KbaSghzHRlMiWaMb7/v+Q+a71MBOwEVwFhAiatnDB5JKUJ+w4PayOi3zrGPN1qx/OWgqqlCYT
 MTKRUUxc9dNfyx2E3x6h2V98wyNr5VEoGXfHIjjMH1wl7tJ/5soGaTYWcLBAW3UBwJakDtMqX
 cIV1FPufV7eVGxLDAwUYyU58N2+VrcBPqpbj18u0ZQN+vi5Xxsgi2KOT+NMzeRvcw2nWCqEYX
 dGwP1JZv5Hw3R/A==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uEI2BuDe0NhIfEtZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 28 Jul 2023 12:34:13 GMT, Will Deacon wrote:
> To prepare for 'faddr2line' reusing the same ignored symbols list as
> 'mksysmap', factor out the relevant sed expression into its own script,
> removing the double-escapes for '$' symbols as they are no longer
> required.
>=20
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Nicolas Schier <nicolas@fjasle.eu>
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: John Stultz <jstultz@google.com>
> Cc: linux-kbuild@vger.kernel.org
> Signed-off-by: Will Deacon <will@kernel.org>
> ---

Thanks!

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

>  scripts/mksysmap                | 77 +--------------------------------
>  scripts/sysmap-ignored-syms.sed | 74 +++++++++++++++++++++++++++++++
>  2 files changed, 75 insertions(+), 76 deletions(-)
>  create mode 100644 scripts/sysmap-ignored-syms.sed
>=20
> diff --git a/scripts/mksysmap b/scripts/mksysmap
> index 9ba1c9da0a40..a98b34363258 100755
> --- a/scripts/mksysmap
> +++ b/scripts/mksysmap
> @@ -16,7 +16,7 @@
>  # 'W' or 'w'.
>  #
> =20
> -${NM} -n ${1} | sed >${2} -e "
> +${NM} -n ${1} | sed >${2} -f $(dirname $0)/sysmap-ignored-syms.sed -e "
>  # ----------------------------------------------------------------------=
-----
>  # Ignored symbol types
>  #
> @@ -27,81 +27,6 @@ ${NM} -n ${1} | sed >${2} -e "
>  # w: local weak symbols
>  / [aNUw] /d
> =20
> -# ----------------------------------------------------------------------=
-----
> -# Ignored prefixes
> -#  (do not forget a space before each pattern)
> -
> -# local symbols for ARM, MIPS, etc.
> -/ \\$/d
> -
> -# local labels, .LBB, .Ltmpxxx, .L__unnamed_xx, .LASANPC, etc.
> -/ \.L/d
> -
> -# arm64 EFI stub namespace
> -/ __efistub_/d
> -
> -# arm64 local symbols in PIE namespace
> -/ __pi_\\$/d
> -/ __pi_\.L/d
> -
> -# arm64 local symbols in non-VHE KVM namespace
> -/ __kvm_nvhe_\\$/d
> -/ __kvm_nvhe_\.L/d
> -
> -# arm64 lld
> -/ __AArch64ADRPThunk_/d
> -
> -# arm lld
> -/ __ARMV5PILongThunk_/d
> -/ __ARMV7PILongThunk_/d
> -/ __ThumbV7PILongThunk_/d
> -
> -# mips lld
> -/ __LA25Thunk_/d
> -/ __microLA25Thunk_/d
> -
> -# CFI type identifiers
> -/ __kcfi_typeid_/d
> -/ __kvm_nvhe___kcfi_typeid_/d
> -/ __pi___kcfi_typeid_/d
> -
> -# CRC from modversions
> -/ __crc_/d
> -
> -# EXPORT_SYMBOL (symbol name)
> -/ __kstrtab_/d
> -
> -# EXPORT_SYMBOL (namespace)
> -/ __kstrtabns_/d
> -
> -# ----------------------------------------------------------------------=
-----
> -# Ignored suffixes
> -#  (do not forget '$' after each pattern)
> -
> -# arm
> -/_from_arm$/d
> -/_from_thumb$/d
> -/_veneer$/d
> -
> -# ----------------------------------------------------------------------=
-----
> -# Ignored symbols (exact match)
> -#  (do not forget a space before and '$' after each pattern)
> -
> -# for LoongArch?
> -/ L0$/d
> -
> -# ppc
> -/ _SDA_BASE_$/d
> -/ _SDA2_BASE_$/d
> -
> -# ----------------------------------------------------------------------=
-----
> -# Ignored patterns
> -#  (symbols that contain the pattern are ignored)
> -
> -# ppc stub
> -/\.long_branch\./d
> -/\.plt_branch\./d
> -
>  # ----------------------------------------------------------------------=
-----
>  # Ignored kallsyms symbols
>  #
> diff --git a/scripts/sysmap-ignored-syms.sed b/scripts/sysmap-ignored-sym=
s.sed
> new file mode 100644
> index 000000000000..14b9eb2c9ed9
> --- /dev/null
> +++ b/scripts/sysmap-ignored-syms.sed
> @@ -0,0 +1,74 @@
> +# ----------------------------------------------------------------------=
-----
> +# Ignored prefixes
> +#  (do not forget a space before each pattern)
> +
> +# local symbols for ARM, MIPS, etc.
> +/ \$/d
> +
> +# local labels, .LBB, .Ltmpxxx, .L__unnamed_xx, .LASANPC, etc.
> +/ \.L/d
> +
> +# arm64 EFI stub namespace
> +/ __efistub_/d
> +
> +# arm64 local symbols in PIE namespace
> +/ __pi_\$/d
> +/ __pi_\.L/d
> +
> +# arm64 local symbols in non-VHE KVM namespace
> +/ __kvm_nvhe_\$/d
> +/ __kvm_nvhe_\.L/d
> +
> +# arm64 lld
> +/ __AArch64ADRPThunk_/d
> +
> +# arm lld
> +/ __ARMV5PILongThunk_/d
> +/ __ARMV7PILongThunk_/d
> +/ __ThumbV7PILongThunk_/d
> +
> +# mips lld
> +/ __LA25Thunk_/d
> +/ __microLA25Thunk_/d
> +
> +# CFI type identifiers
> +/ __kcfi_typeid_/d
> +/ __kvm_nvhe___kcfi_typeid_/d
> +/ __pi___kcfi_typeid_/d
> +
> +# CRC from modversions
> +/ __crc_/d
> +
> +# EXPORT_SYMBOL (symbol name)
> +/ __kstrtab_/d
> +
> +# EXPORT_SYMBOL (namespace)
> +/ __kstrtabns_/d
> +
> +# ----------------------------------------------------------------------=
-----
> +# Ignored suffixes
> +#  (do not forget '$' after each pattern)
> +
> +# arm
> +/_from_arm$/d
> +/_from_thumb$/d
> +/_veneer$/d
> +
> +# ----------------------------------------------------------------------=
-----
> +# Ignored symbols (exact match)
> +#  (do not forget a space before and '$' after each pattern)
> +
> +# for LoongArch?
> +/ L0$/d
> +
> +# ppc
> +/ _SDA_BASE_$/d
> +/ _SDA2_BASE_$/d
> +
> +# ----------------------------------------------------------------------=
-----
> +# Ignored patterns
> +#  (symbols that contain the pattern are ignored)
> +
> +# ppc stub
> +/\.long_branch\./d
> +/\.plt_branch\./d
> --=20
> 2.41.0.487.g6d72f3e995-goog

--=20
Nicolas Schier
=20
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
=E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --

--uEI2BuDe0NhIfEtZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmTFXJQACgkQB1IKcBYm
Emk1Gw/9EYXfT0XE/B7XsUjGx3hzto6hXf9K+guZgs9r8kwPtnUqOEM1mAXmcvXS
0bTKEAG5+m9rpv6qC8by/BJUsErQpECczjleG5g/gPMe3yiOR7UwFquVNArkO/zt
uVaSeuHUghum6GINfk4zuhLTY7E8D2BYA/OAyHiWVN55NKU0Y6Y0TlQwydH395eo
51vtrGOUEFvdVWpwsHBYF3FThGYN1QSSSGOQHJ4T4vramFvJ6wtjKmJksWdfs7ro
EOA1iOriiKAI6g5DvuEZv+M7G6KG/+5VaaGVuUwgXKMHhccbJ9xXiaaNK9HkG3px
aPDs3/UkhRAv0am99kh2e2XqrMDRqTdCfWbjcKitcFFjT9Vb49r2tiG1sQWLlSt0
w737xFGUB0GE+GnpuFQ/DJeH61OapiznM25W6MqxhAlk/jMvGH2z27z0R4fTYymR
FbCrMo12pIT7lAkU9mOj1WUlefXiZQev7nXlTKchCsRB4RkqnaLoyoa+GKh2itN2
h21K785HAIMvfCVh2kYUM2OcG83JWA1Ec7+XiivfGMs/J3dhKJ/B8UPL4k/tH+SD
X3+3PLAiS/FtedgfezCfk8jmz+6z2MwogyBgSQJx9YIkjdQGhjLoaRn/jA5rOgik
bcZheNABglL1d8MBULMpFTsu9RbuC3rBhFLklouEPdzTEh9HPGs=
=u62f
-----END PGP SIGNATURE-----

--uEI2BuDe0NhIfEtZ--
