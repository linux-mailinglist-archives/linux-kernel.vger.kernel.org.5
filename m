Return-Path: <linux-kernel+bounces-119714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F49E88CC56
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3A651F379AF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F2113C3D8;
	Tue, 26 Mar 2024 18:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBwJPZa5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6CB128839;
	Tue, 26 Mar 2024 18:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711478970; cv=none; b=uR+oUOvHy6LgOsL/JlQVERzVpElSPfg1D9jqsVU4k69cgYO1WhWgYem/pHO0VbwopVa96/gRc6QbjcZKMdNED+eexmC94N+Hh5Z42fekXzYiPsdEi5xmVMSpuXSyfRxyNdAC1W6o5Jxi/t/gfStYZMs4tnH1uZafIWYFJLMIFZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711478970; c=relaxed/simple;
	bh=UU2VDr3u/3TXCOqy+TTP1ocWAPAmrxpuuTkUu5erUDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFqar4zSaqP+UX8NNHkUwxESs8Cbs9li+LySpNtmYTBwcXStYMZvFzbJLus4tGH6w7WsoT9zXxUVvPVUKUBBpKumLT8xCKhk0mXrT6oBekAmRH9OGunOI2oMoScsPeTwULRPVU+f2NAAhEK9DKFzNJemqFVeqjsqSNw9EDRqLqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBwJPZa5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2DBC433F1;
	Tue, 26 Mar 2024 18:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711478969;
	bh=UU2VDr3u/3TXCOqy+TTP1ocWAPAmrxpuuTkUu5erUDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PBwJPZa5DPG76Ku/rLXmTHS2TSZtuV1OhnF2IcXykh8DO9dhbAx6Rj+MiH36XNYm0
	 z/CCvjUf/DfFy+oYzImWu29MntAO08O+h+gjiVqCXht566Q2IJeQc51ukzqV8Afn7W
	 iSzzlxZqv0ul84yT6zg3aLv8A/EvTXVbuHUvqxDE8qSzLjDN8/eLrAr70f5rDCS77Z
	 an332I9toO+IxNlKk9tevAEZKF40UGoJz4JAGRgr0r+tQjSYYFXk6+rxZliOdd28Jo
	 79OqNa0pZC85cYV/WVkq8Mt/UkAYC9EXpv2WFwfgarN4bcizLd3LUZC951mYtBwhDv
	 RMiijqOlPD0Zw==
Date: Tue, 26 Mar 2024 18:49:25 +0000
From: Conor Dooley <conor@kernel.org>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Kees Cook <keescook@chromium.org>, linux-riscv@lists.infradead.org,
	llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH] riscv: Mark __se_sys_* functions __used
Message-ID: <20240326-proofing-projector-0b8eef253667@spud>
References: <20240326153712.1839482-2-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UzV3RQm1Ipc55SDT"
Content-Disposition: inline
In-Reply-To: <20240326153712.1839482-2-samitolvanen@google.com>


--UzV3RQm1Ipc55SDT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 03:37:13PM +0000, Sami Tolvanen wrote:
> Clang doesn't think ___se_sys_* functions used even though they are
> aliased to __se_sys_*, resulting in -Wunused-function warnings when
> building rv32. For example:
>=20
>    mm/oom_kill.c:1195:1: warning: unused function '___se_sys_process_mrel=
ease' [-Wunused-function]
>     1195 | SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, fl=
ags)
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
>    include/linux/syscalls.h:221:36: note: expanded from macro 'SYSCALL_DE=
FINE2'
>      221 | #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name,=
 __VA_ARGS__)
>          |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~
>    include/linux/syscalls.h:231:2: note: expanded from macro 'SYSCALL_DEF=
INEx'
>      231 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/riscv/include/asm/syscall_wrapper.h:81:2: note: expanded from mac=
ro '__SYSCALL_DEFINEx'
>       81 |         __SYSCALL_SE_DEFINEx(x, sys, name, __VA_ARGS__)       =
                  \
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/riscv/include/asm/syscall_wrapper.h:40:14: note: expanded from ma=
cro '__SYSCALL_SE_DEFINEx'
>       40 |         static long ___se_##prefix##name(__MAP(x,__SC_LONG,__V=
A_ARGS__))
>          |                     ^~~~~~~~~~~~~~~~~~~~
>    <scratch space>:30:1: note: expanded from here
>       30 | ___se_sys_process_mrelease
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~~
>    1 warning generated.
>=20
> Mark the functions __used explicitly to fix the Clang warnings.
>=20
> Fixes: a9ad73295cc1 ("riscv: Fix syscall wrapper for >word-size arguments=
")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Oh neat, thanks. This was generating a shed load of noise in CI :)
Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  arch/riscv/include/asm/syscall_wrapper.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/include/asm/syscall_wrapper.h b/arch/riscv/includ=
e/asm/syscall_wrapper.h
> index 980094c2e976..ac80216549ff 100644
> --- a/arch/riscv/include/asm/syscall_wrapper.h
> +++ b/arch/riscv/include/asm/syscall_wrapper.h
> @@ -36,7 +36,8 @@ asmlinkage long __riscv_sys_ni_syscall(const struct pt_=
regs *);
>  					ulong)						\
>  			__attribute__((alias(__stringify(___se_##prefix##name))));	\
>  	__diag_pop();									\
> -	static long noinline ___se_##prefix##name(__MAP(x,__SC_LONG,__VA_ARGS__=
));	\
> +	static long noinline ___se_##prefix##name(__MAP(x,__SC_LONG,__VA_ARGS__=
))	\
> +			__used;								\
>  	static long ___se_##prefix##name(__MAP(x,__SC_LONG,__VA_ARGS__))
> =20
>  #define SC_RISCV_REGS_TO_ARGS(x, ...) \
>=20
> base-commit: 4cece764965020c22cff7665b18a012006359095
> --=20
> 2.44.0.396.g6e790dbe36-goog
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--UzV3RQm1Ipc55SDT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgMYtQAKCRB4tDGHoIJi
0lpHAP9MHNkX3etDTKmHZ6qt1m7X45+uBOZZWopKhVa5d8UFvAD/YTeTIdZXASl8
l+cYdYHZwoR710Xt9ZyEhVuNCGR0Igs=
=jNoi
-----END PGP SIGNATURE-----

--UzV3RQm1Ipc55SDT--

