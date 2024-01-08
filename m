Return-Path: <linux-kernel+bounces-20116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EE18279D3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 22:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 592971F23B77
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F46A55E77;
	Mon,  8 Jan 2024 21:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GavrQZjC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60AD55E64;
	Mon,  8 Jan 2024 21:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704747624;
	bh=YqV5AgAGEOazvOvs1GJw09LdxTkgJ59V1OtP+pWv6fY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GavrQZjC+rJimkKYGZ9a8xQVWURd1vhIXyu6/O0i1SPJ/KsWQ5CeawOxwQC4272jV
	 VcD32qehbJKJAFhDFZ8wB0vANeUokbMW79xtuX6S7P8zjiOc5KTrXI7yTrPq2GXLrZ
	 yWLEmV1nr4vsfGhb74gzP82B1LxYF3HAMN39dyc5104xO0B5fykR7sXukuk2jKqVr4
	 iSNLJDEw/rwpON7q8TWoCwgXPb30TP8sWAfdXmQIQgx2l8ANvKSm8jsn/s91H0F9Y5
	 uK6iYJVxocRupPsLvXOseJNWXNIOj/aKEA4zvCRQRfJZKrhs8dJg6NPk8ZyHIlPFsx
	 7mdsHVShn+pDg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T8607695vz4wnx;
	Tue,  9 Jan 2024 08:00:23 +1100 (AEDT)
Date: Tue, 9 Jan 2024 08:00:23 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>
Subject: Re: linux-next: manual merge of the vfs-brauner tree with the mm
 tree
Message-ID: <20240109080023.7d345d2f@canb.auug.org.au>
In-Reply-To: <20231122103119.34d23955@canb.auug.org.au>
References: <20231122103119.34d23955@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/iiiAq3WfRpgO=IHKNHceiVR";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/iiiAq3WfRpgO=IHKNHceiVR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 22 Nov 2023 10:31:19 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Today's linux-next merge of the vfs-brauner tree got a conflict in:
>=20
>   fs/buffer.c
>=20
> between commits:
>=20
>   2c68861ed127 ("buffer: return bool from grow_dev_folio()")
>   5334c6480adb ("buffer: calculate block number inside folio_init_buffers=
()")
>=20
> from the mm tree and commit:
>=20
>   488e2eea5100 ("fs: Rename mapping private members")
>=20
> from the vfs-brauner tree.
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
> diff --cc fs/buffer.c
> index 4eb44ccdc6be,5ffc44ab4854..000000000000
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@@ -1067,14 -1064,17 +1067,14 @@@ static bool grow_dev_folio(struct block
>   	 * lock to be atomic wrt __find_get_block(), which does not
>   	 * run under the folio lock.
>   	 */
> - 	spin_lock(&inode->i_mapping->private_lock);
> + 	spin_lock(&inode->i_mapping->i_private_lock);
>   	link_dev_buffers(folio, bh);
>  -	end_block =3D folio_init_buffers(folio, bdev,
>  -			(sector_t)index << sizebits, size);
>  +	end_block =3D folio_init_buffers(folio, bdev, size);
> - 	spin_unlock(&inode->i_mapping->private_lock);
> + 	spin_unlock(&inode->i_mapping->i_private_lock);
>  -done:
>  -	ret =3D (block < end_block) ? 1 : -ENXIO;
>  -failed:
>  +unlock:
>   	folio_unlock(folio);
>   	folio_put(folio);
>  -	return ret;
>  +	return block < end_block;
>   }
>  =20
>   /*

This is now a conflict between the mm tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/iiiAq3WfRpgO=IHKNHceiVR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWcYmcACgkQAVBC80lX
0GzNowf7BhWxmWSv54DY8AKJv93rzhtjUrU77IIdQ5siTFYtwsgA9hOMctwhRB/5
ZEenocBBoziGa9WWIarXpEgOwjWZC5OqQmxKMFz4/DfjTtn+wjJiBSp8W/jwPuZw
4b2/XulYZ9SHmh6QLob4Ew8A9CxzXlynD5B5jMGvQREIXVY95VZfmdUqcHiT9wkv
5NDh8B8aH4SpgHW+6MOgRKFZiMUQP5dEg8GpEaadpqIkb72O/mdOiShQyZtDVVg5
KSUeaIM4ZYHIPMix7krDaeFc948OLf8IICPWY5xVzhS+ltccNCWb9moVrS8ykwBY
hDNHpket4uKN21n9Br/NxUw5UxeIhw==
=ThKu
-----END PGP SIGNATURE-----

--Sig_/iiiAq3WfRpgO=IHKNHceiVR--

