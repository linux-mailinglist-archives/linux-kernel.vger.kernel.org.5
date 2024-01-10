Return-Path: <linux-kernel+bounces-22840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DD782A3D8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 23:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E745C1F28358
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598384F897;
	Wed, 10 Jan 2024 22:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FqCD0nKH"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707334CE1D;
	Wed, 10 Jan 2024 22:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704925368;
	bh=Wo4Mp1A7ns+9PBY4a2oxRYPubeQSBQsRulo2OhT3c7o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FqCD0nKHHxoewLiQS37cjmM2fUDSmra8JEJaTm1gngJhbRpeubH5+hPrYjfPKmMLN
	 5Tx8+9fTz3THom3tfn5gstSSr58Tv+EgJ+CWi/jWwGhoExIl7x59VgvPlds5lXa76K
	 BFAdi8jRQq6THFCS9XYh0eHoZ6k4tbA1Go8mIEBql+/CzKiEs80AM2pfon2tb1PeSr
	 FOEVFcrpPS4wclyP+pjE8u8qZpa2wZ+hud6ZKz2nWWD98TYExqG9VVTYRZ5yspqy6V
	 oH5MR/be7ol6xO7fsO/kck6dGsXeSYlNBsfWdcvN6so/PnSLiqI5TlyETTbEyaNHMq
	 aaYamp1KjLEPQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T9MkJ2JsYz4wxx;
	Thu, 11 Jan 2024 09:22:47 +1100 (AEDT)
Date: Thu, 11 Jan 2024 09:22:46 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the asm-generic tree with the mm
 tree
Message-ID: <20240111092246.10ba37af@canb.auug.org.au>
In-Reply-To: <20231205090546.7dffe3aa@canb.auug.org.au>
References: <20231205090546.7dffe3aa@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.Gd64o/4MFJ7UuxtDOxM92N";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/.Gd64o/4MFJ7UuxtDOxM92N
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 5 Dec 2023 09:05:46 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>=20
> Today's linux-next merge of the asm-generic tree got a conflict in:
>=20
>   arch/mips/include/asm/traps.h
>=20
> between commit:
>=20
>   6b281b05cbcc ("mips: add missing declarations for trap handlers")
>=20
> from the mm tree and commit:
>=20
>   23f8c1823bd4 ("arch: add do_page_fault prototypes")
>=20
> from the asm-generic tree.
>=20
>=20
> diff --cc arch/mips/include/asm/traps.h
> index 2c2b26f1e464,d4d9f8a8fdea..000000000000
> --- a/arch/mips/include/asm/traps.h
> +++ b/arch/mips/include/asm/traps.h
> @@@ -39,28 -39,7 +39,30 @@@ extern char except_vec_nmi[]
>   	register_nmi_notifier(&fn##_nb);				\
>   })
>  =20
>  +asmlinkage void do_ade(struct pt_regs *regs);
>  +asmlinkage void do_be(struct pt_regs *regs);
>  +asmlinkage void do_ov(struct pt_regs *regs);
>  +asmlinkage void do_fpe(struct pt_regs *regs, unsigned long fcr31);
>  +asmlinkage void do_bp(struct pt_regs *regs);
>  +asmlinkage void do_tr(struct pt_regs *regs);
>  +asmlinkage void do_ri(struct pt_regs *regs);
>  +asmlinkage void do_cpu(struct pt_regs *regs);
>  +asmlinkage void do_msa_fpe(struct pt_regs *regs, unsigned int msacsr);
>  +asmlinkage void do_msa(struct pt_regs *regs);
>  +asmlinkage void do_mdmx(struct pt_regs *regs);
>  +asmlinkage void do_watch(struct pt_regs *regs);
>  +asmlinkage void do_mcheck(struct pt_regs *regs);
>  +asmlinkage void do_mt(struct pt_regs *regs);
>  +asmlinkage void do_dsp(struct pt_regs *regs);
>  +asmlinkage void do_reserved(struct pt_regs *regs);
>  +asmlinkage void do_ftlb(void);
>  +asmlinkage void do_gsexc(struct pt_regs *regs, u32 diag1);
>  +asmlinkage void do_daddi_ov(struct pt_regs *regs);
>  +
>  +asmlinkage void cache_parity_error(void);
>  +asmlinkage void ejtag_exception_handler(struct pt_regs *regs);
>  +asmlinkage void __noreturn nmi_exception_handler(struct pt_regs *regs);
> + asmlinkage void do_page_fault(struct pt_regs *regs,
> + 	unsigned long write, unsigned long address);
>  =20
>   #endif /* _ASM_TRAPS_H */

This is now a conflict between the asm-generic tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/.Gd64o/4MFJ7UuxtDOxM92N
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWfGLYACgkQAVBC80lX
0Gw8kwf9Hol3IDHWryGa9fEXsiDz7efGVKK5gGjdPFyE13n3/wya4nR8WlyzzpM4
yTaeN0M8TxcxT61kIwtRge5wtH5q+FP8BObSAaUr3ixh3SnZMogUS56DwTHBMsZw
1a80oQzQqQ51ARgcGtrOQER68ZkjMsFtWwMk4oaZKgqZoquR+67QgrjaFCTfCraI
9ek1xlNXq/YEPbWrpeQHnNmoRSffZbvT8v55lgIwsMBC1q6YD+T0MC1FNcbaKbB4
Qm4jd+4s8BKU79nbmloQ6B+RhwHFOJ55S4OWoANXHBal+GKqvj9QSnArxgN6Kd0s
mjn6tqk1JKQl/zPrQqtlLB7/jSfNtQ==
=6QX7
-----END PGP SIGNATURE-----

--Sig_/.Gd64o/4MFJ7UuxtDOxM92N--

