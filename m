Return-Path: <linux-kernel+bounces-24246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3EF82B9B7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 03:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4167B23B45
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 02:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1416612E5E;
	Fri, 12 Jan 2024 02:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RMpawhOu"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCA510958;
	Fri, 12 Jan 2024 02:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1705027663;
	bh=JaDpBPpLqHwb5xmT1v8aCpb2CDsCQJCXSfpnpYs2GuA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RMpawhOuUzEMm00tRm+6wKlwDs+qG+jC3fw6UQfOLX/LQyXrMhBtuz3R0/i72SLJC
	 REP7aXAqbTC86spZN39uTsPpWN1N8X/BVVgbNtnWeqXp4mFAYXJZRfc+vrXoSDo1cu
	 lFFfwZ8se4xZkhdwaBsM/Fj7gE4vZ6sK1n60d9SHs7F+m6kKJcbdlGb6y2WsdLp16K
	 LbPKzZBvyomow4Do3JSVJYy59g1BFdmv3Gs3/pcwevH/IVCMftuytekBQgxfY+cu14
	 P3zBBlT3JPERgPiGYKnUnog6cKrOAis/OSGpAG5NJW8gU+iG9X4SALuTz1wnIm82y8
	 xeU1lt15LA1wg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TB5YW1lylz4x5h;
	Fri, 12 Jan 2024 13:47:42 +1100 (AEDT)
Date: Fri, 12 Jan 2024 13:47:42 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 urezki@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: linux-next: Tree for Jan 11 (mm/vmalloc.c)
Message-ID: <20240112134742.4aa15e52@canb.auug.org.au>
In-Reply-To: <74388269-0a03-4c10-8408-fc204c843fd7@infradead.org>
References: <20240111144846.74e443a7@canb.auug.org.au>
	<74388269-0a03-4c10-8408-fc204c843fd7@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TNcwY.FWWyhAyj+91cnM6BG";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/TNcwY.FWWyhAyj+91cnM6BG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Randy,

On Thu, 11 Jan 2024 15:51:50 -0800 Randy Dunlap <rdunlap@infradead.org> wro=
te:
>
> on riscv 64-bit, i386, and UML:
>=20
> ../mm/vmalloc.c: In function 'vmalloc_dump_obj':
> ../mm/vmalloc.c:4691:22: warning: 'addr' is used uninitialized [-Wuniniti=
alized]
>  4691 |                 va =3D __find_vmap_area(addr, &vn->busy.root);
>       |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../mm/vmalloc.c:4684:23: note: 'addr' was declared here
>  4684 |         unsigned long addr;
>       |                       ^~~~

See https://lore.kernel.org/lkml/ZaARXdbigD1hWuOS@pc638.lan/ which I a
have applied to linux-next today.

--=20
Cheers,
Stephen Rothwell

--Sig_/TNcwY.FWWyhAyj+91cnM6BG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWgqE4ACgkQAVBC80lX
0Gz4RQf/d7ZNp0IGyg7cQZaeQBR9Jeu1Sq6/5DAQMb4cmOozrKhr3T3Hbojh9lyx
2932P8plAyEdDdBEs2RUHQSJQJ+rf7fxsdoWfB1O9kzWhY7FnsFKP8Hj8J44NsR3
gv+3IU4DRDgMc9PU+iVgIKv3ctkW+UehXOF2XsRXrE7PSizy/4u0ckOWum9rUIKw
F1l/LrMMwGfxclUQfu4X076aVPnf5lGvntVT0fQGtTk9vocUjYpTOuOnToNayUfd
EIcv8vQhtZkA0ti4NSbryJXo3jaMgT85TdNSJl1zylBZ8u9XZ4NgM23LG0LlzjfX
H1xxs1/7blMb4Y6057pyQm8/NzggYQ==
=r+nA
-----END PGP SIGNATURE-----

--Sig_/TNcwY.FWWyhAyj+91cnM6BG--

