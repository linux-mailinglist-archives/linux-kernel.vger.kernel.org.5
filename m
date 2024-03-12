Return-Path: <linux-kernel+bounces-100913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DFD879F91
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C0CE1C20AC4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7520E47F60;
	Tue, 12 Mar 2024 23:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="uXpoSmgh"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14AB46421;
	Tue, 12 Mar 2024 23:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710285372; cv=none; b=QJCSkHBzbJCWnbow7gEIAAWudUrdHZHdNZQJ5a659dwtorwa+/+BJTx876y0J9gz4s6eMpmth2T4E98TMDmDs8NCgvPSLvAQinmm8dzj4ThaZKhph8NrPXpbOT+ip68mgv/k8g+zbU3aBP5CSM3Rbhgx7NpdNlrKh0bEmNGWgJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710285372; c=relaxed/simple;
	bh=yYbbljqBsdMlF8ejFt7shK2VJEBf8Yc2Wg5G7/EOOqE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mw/odQibJoydNcNGPeQrZ33cdv3E4wsj0JByeLVmjTB2cmC8QtUN4hocnPzz7Smf4tW5pLf3KKzzssBjpmRRn3TIRZSqst6kFvGi7vhsJADjqUQO1j9ZeZ7Dk3H7CpYXpufklju4KPza+ebOjKM1RJQkDO12wBzzia+4z6ZLEW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=uXpoSmgh; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710285033;
	bh=z/6KbviX2L2Ehh45YDU0JszSdB7+7eemzTYCuV49oao=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uXpoSmgh0cYJbyBoL7LPyjKXN2idaLZdAD/Ga6TPv4UVP3+rBuu+XTN8ObM8vrMLn
	 EtliZRQjsH+5pRTIVOjHtX219aj0VQkx9b8Cmuucqq6oKXP6KKbDeOTUoLbUhJ2q/M
	 0H/CD5mesCo0SdPwfvLMTE/8E1rZr42tNbMmHa5yaCYa0tFiJwarFsqKvDw7iDdFwY
	 qjQYoyupf93jG0pr3bxXE7Gh5AokpmY76G5bHFFZYjCXhGROkX+v6IvPxppoe/1V2B
	 30fCy+We09HHC3FAny3lbnNSUIow/xX9nvy5wdbDzhipKi6Lh5lIXprivQJJqbT5b4
	 AXYS8DegHKq5A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TvTrm6Dstz4wx5;
	Wed, 13 Mar 2024 10:10:32 +1100 (AEDT)
Date: Wed, 13 Mar 2024 10:10:30 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the asm-generic tree with the
 kbuild tree
Message-ID: <20240313101030.093d755c@canb.auug.org.au>
In-Reply-To: <20240307093807.60efa4ec@canb.auug.org.au>
References: <20240307093807.60efa4ec@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oevCpfALKmGAao5f80NhQNQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/oevCpfALKmGAao5f80NhQNQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 7 Mar 2024 09:38:07 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the asm-generic tree got a conflict in:
>=20
>   arch/hexagon/Kconfig
>=20
> between commit:
>=20
>   6b1c2a19cb30 ("hexagon: select FRAME_POINTER instead of redefining it")
>=20
> from the kbuild tree and commit:
>=20
>   ba89f9c8ccba ("arch: consolidate existing CONFIG_PAGE_SIZE_*KB definiti=
ons")
>=20
> from the asm-generic tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc arch/hexagon/Kconfig
> index 89672ef0666f,1414052e7d6b..000000000000
> --- a/arch/hexagon/Kconfig
> +++ b/arch/hexagon/Kconfig
> @@@ -7,9 -7,11 +7,13 @@@ config HEXAGO
>   	select ARCH_32BIT_OFF_T
>   	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
>   	select ARCH_NO_PREEMPT
>  +	select ARCH_WANT_FRAME_POINTERS
>   	select DMA_GLOBAL_POOL
>  +	select FRAME_POINTER
> + 	select HAVE_PAGE_SIZE_4KB
> + 	select HAVE_PAGE_SIZE_16KB
> + 	select HAVE_PAGE_SIZE_64KB
> + 	select HAVE_PAGE_SIZE_256KB
>   	# Other pending projects/to-do items.
>   	# select HAVE_REGS_AND_STACK_ACCESS_API
>   	# select HAVE_HW_BREAKPOINT if PERF_EVENTS

This is now a conflict between the kbuild tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/oevCpfALKmGAao5f80NhQNQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXw4OYACgkQAVBC80lX
0GyFWQf+JrU0hLnizJkTOHdkDs3rzwlBxeBRgsw9BYR9XjlMLmR6HBCdvoGIl2VU
9kWnR39KY7BnODMEC+zFbnt/P85RRj6dcPUj3NgVDGZeNIPL4KoEz1cqF4oNg4KS
N3EaoRuKxDESWLfatOL+bnA6M2tKj+Ku96Hh1unStdXa/cgyuaDjnxXNoOGmX4o3
9wc8EESmVXCkq4T5qxWuPY7pFn6Ne+PbMsPcFxaBNXepTNtu54pJIdbgyWsYnYxU
3znrx7m7QNrXeUcSnNFk9mHmKCSVMWh+unbg33nFl5tc5sPOeVl0A2wv9WnZY2eP
YSdoRoYl4fYM+wIhEmNWqC/62zWXAA==
=Pp10
-----END PGP SIGNATURE-----

--Sig_/oevCpfALKmGAao5f80NhQNQ--

