Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B87F7698F4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 16:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjGaOGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 10:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbjGaOG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:06:29 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A0B1BDF;
        Mon, 31 Jul 2023 07:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690812159; x=1722348159;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZjKOqjp3rusEQTrMwBC9OMZcGMJrR0bk27etxmfvtG8=;
  b=kxsQVXX/HzG8FRtIUM6S7W2v8Bn/WPd1wWEGa2e55ALfXpYkmVcewfEn
   gcx5mUVbj+OpkE1rD1RPWGsIbEwoVjl/AdR1WCCjKe+KgENVOTPBBsmOw
   mIQGtrQArfyD5FH6AwLC7oWmyeyTAHAZZoCVD26oO16n57IQG1RQtdTPb
   gwlmkR3N+aKnacs4uI9tzu4uTrPge6E3qYOGNVWQNKlaOSjFE5Env+bRE
   pSqImeeqEshiHql4nX6xsPvJVh+Hn+V67uqzot+ad4DcpOszGNDmwUffU
   Qq+2qfdWHe0kAKQq14ug6UIXoQO4XjQhUwcnYPMWma78SCdqzWUM49h4K
   A==;
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="asc'?scan'208";a="227468323"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Jul 2023 07:02:37 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 31 Jul 2023 07:02:36 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 31 Jul 2023 07:02:34 -0700
Date:   Mon, 31 Jul 2023 15:01:58 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Mingzheng Xing <xingmingzheng@iscas.ac.cn>
CC:     Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Bin Meng <bmeng@tinylab.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>, <stable@vger.kernel.org>,
        Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v3] riscv: Handle zicsr/zifencei issue between gcc and
 binutils
Message-ID: <20230731-calzone-gratified-dbc51639beec@wendy>
References: <20230731095936.23397-1-xingmingzheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sR3rHcOfeYhw3z0E"
Content-Disposition: inline
In-Reply-To: <20230731095936.23397-1-xingmingzheng@iscas.ac.cn>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--sR3rHcOfeYhw3z0E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Mon, Jul 31, 2023 at 05:59:36PM +0800, Mingzheng Xing wrote:
> Binutils-2.38 and GCC-12.1.0 bumped[0][1] the default ISA spec to the new=
er
> 20191213 version which moves some instructions from the I extension to the
> Zicsr and Zifencei extensions. So if one of the binutils and GCC exceeds
> that version, we should explicitly specifying Zicsr and Zifencei via -mar=
ch
> to cope with the new changes. but this only occurs when binutils >=3D 2.36
> and GCC >=3D 11.1.0. It's a different story when binutils < 2.36.
>=20
> binutils-2.36 supports the Zifencei extension[2] and splits Zifencei and
> Zicsr from I[3]. GCC-11.1.0 is particular[4] because it add support Zicsr
> and Zifencei extension for -march. binutils-2.35 does not support the
> Zifencei extension, and does not need to specify Zicsr and Zifencei when
> working with GCC >=3D 12.1.0.
>=20
> To make our lives easier, let's relax the check to binutils >=3D 2.36 in
> CONFIG_TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI. For the other two cases,
> where clang < 17 or GCC < 11.1.0, we will deal with them in
> CONFIG_TOOLCHAIN_NEEDS_OLD_ISA_SPEC.
>=20
> For more information, please refer to:
> commit 6df2a016c0c8 ("riscv: fix build with binutils 2.38")
> commit e89c2e815e76 ("riscv: Handle zicsr/zifencei issues between clang a=
nd binutils")
> Link: https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dcommit;h=3Daed=
44286efa8ae8717a77d94b51ac3614e2ca6dc [0]
> Link: https://gcc.gnu.org/git/?p=3Dgcc.git;a=3Dcommit;h=3D98416dbb0a62579=
d4a7a4a76bab51b5b52fec2cd [1]
> Link: https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dcommit;h=3D5a1=
b31e1e1cee6e9f1c92abff59cdcfff0dddf30 [2]
> Link: https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dcommit;h=3D729=
a53530e86972d1143553a415db34e6e01d5d2 [3]
> Link: https://gcc.gnu.org/git/?p=3Dgcc.git;a=3Dcommit;h=3Db03be74bad08c38=
2da47e048007a78fa3fb4ef49 [4]
> Link: https://lore.kernel.org/all/20230308220842.1231003-1-conor@kernel.o=
rg
> Link: https://lore.kernel.org/all/20230223220546.52879-1-conor@kernel.org
> Signed-off-by: Mingzheng Xing <xingmingzheng@iscas.ac.cn>

You need to actually put the CC: stable@vger.kernel.org into the commit
message for the stable folks to pick things up.

> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 4c07b9189c86..2704bd91dfb5 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -570,24 +570,31 @@ config TOOLCHAIN_HAS_ZIHINTPAUSE
>  config TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI
>  	def_bool y
>  	# https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dcommit;h=3Daed44=
286efa8ae8717a77d94b51ac3614e2ca6dc
> -	depends on AS_IS_GNU && AS_VERSION >=3D 23800
> -	help
> -	  Newer binutils versions default to ISA spec version 20191213 which
> -	  moves some instructions from the I extension to the Zicsr and Zifencei
> -	  extensions.
> +	# https://gcc.gnu.org/git/?p=3Dgcc.git;a=3Dcommit;h=3D98416dbb0a62579d4=
a7a4a76bab51b5b52fec2cd
> +	depends on AS_IS_GNU && AS_VERSION >=3D 23600
> +	help
> +	  Binutils-2.38 and GCC-12.1.0 bumped the default ISA spec to the newer
> +	  20191213 version, which moves some instructions from the I extension =
to
> +	  the Zicsr and Zifencei extensions. This requires explicitly specifying
> +	  zicsr and zifencei when binutils >=3D 2.38 or GCC >=3D 12.1.0,

> but this only
> +	  occurs when binutils >=3D 2.36 and GCC >=3D 11.1.0.
> +	 It's a different story when binutils < 2.36.

I would replace this with something like:
	Binutils-2.38 and GCC-12.1.0 bumped the default ISA spec to the newer
	20191213 version, which moves some instructions from the I extension to
	the Zicsr and Zifencei extensions. This requires explicitly specifying
	zicsr and zifencei when binutils >=3D 2.38 or GCC >=3D 12.1.0. Zicsr
	and Zifencei are supported in binutils from version 2.36 onwards.
	To make life easier, and avoid forcing toolchains that default to a
	newer ISA spec to version 2.2, relax the check to binutils >=3D 2.36.
	For clang < 17 or GCC < 11.1.0, for which this is not possible, this is
	dealt with in CONFIG_TOOLCHAIN_NEEDS_OLD_ISA_SPEC.

I tried to take the personification out of it & hopefully made it a
little clearer what dropping the check to 2.36 does for us.

> Also, we have to consider the case of clang paired with binutils.

I think this sentence can go, its covered in the other config text.

I'm sorry for being a bit of a pedant about this, but this has been such
a can of worms that I would like things to remain explained well enough
that the text is sufficient next time a revisit is required.

Thanks,
Conor.

> +	  To make our lives easier, we relax the check to binutils >=3D 2.36. >=
 =20
>  config TOOLCHAIN_NEEDS_OLD_ISA_SPEC
>  	def_bool y
>  	depends on TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI
>  	# https://github.com/llvm/llvm-project/commit/22e199e6afb1263c943c0c0d4=
498694e15bf8a16
> -	depends on CC_IS_CLANG && CLANG_VERSION < 170000
> -	help
> -	  Certain versions of clang do not support zicsr and zifencei via -march
> -	  but newer versions of binutils require it for the reasons noted in the
> -	  help text of CONFIG_TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI. This
> -	  option causes an older ISA spec compatible with these older versions
> -	  of clang to be passed to GAS, which has the same result as passing zi=
csr
> -	  and zifencei to -march.
> +	# https://gcc.gnu.org/git/?p=3Dgcc.git;a=3Dcommit;h=3Db03be74bad08c382d=
a47e048007a78fa3fb4ef49
> +	depends on (CC_IS_CLANG && CLANG_VERSION < 170000) || (CC_IS_GCC && GCC=
_VERSION < 110100)
> +	help
> +	  Certain versions of clang and GCC do not support zicsr and zifencei v=
ia
> +	  -march. This option causes an older ISA spec compatible with these ol=
der
> +	  versions of clang and GCC to be passed to GAS, which has the same res=
ult
> +	  as passing zicsr and zifencei to -march.
> =20
>  config FPU
>  	bool "FPU support"
> diff --git a/arch/riscv/kernel/compat_vdso/Makefile b/arch/riscv/kernel/c=
ompat_vdso/Makefile
> index 189345773e7e..b86e5e2c3aea 100644
> --- a/arch/riscv/kernel/compat_vdso/Makefile
> +++ b/arch/riscv/kernel/compat_vdso/Makefile
> @@ -11,7 +11,13 @@ compat_vdso-syms +=3D flush_icache
>  COMPAT_CC :=3D $(CC)
>  COMPAT_LD :=3D $(LD)
> =20
> -COMPAT_CC_FLAGS :=3D -march=3Drv32g -mabi=3Dilp32
> +# binutils 2.35 does not support the zifencei extension, but in the ISA
> +# spec 20191213, G stands for IMAFD_ZICSR_ZIFENCEI.
> +ifdef CONFIG_TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI
> +	COMPAT_CC_FLAGS :=3D -march=3Drv32g -mabi=3Dilp32
> +else
> +	COMPAT_CC_FLAGS :=3D -march=3Drv32imafd -mabi=3Dilp32
> +endif
>  COMPAT_LD_FLAGS :=3D -melf32lriscv
> =20
>  # Disable attributes, as they're useless and break the build.
> --=20
> 2.34.1
>=20

--sR3rHcOfeYhw3z0E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMe+1gAKCRB4tDGHoIJi
0gBrAPsHa6EvXr3G1je0dOAZODpBCMpYhT5F0/c3PVvv6IaExgD/Yv0Zt62UDpAM
JnC/CIXdfLT13VMVGzN5EthtdrNgSAI=
=6YQe
-----END PGP SIGNATURE-----

--sR3rHcOfeYhw3z0E--
