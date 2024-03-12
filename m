Return-Path: <linux-kernel+bounces-99810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFA3878DB9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 05:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA0C31F21A72
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 04:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F86ABA26;
	Tue, 12 Mar 2024 04:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="utHMcUDo"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C48D16FF2B;
	Tue, 12 Mar 2024 04:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710216153; cv=none; b=FKNYM6myVlsuWoIPfDdfSs88BOMVA1L+nHTnGPjdTsZqC2HoM1J0nYIJqk3ZjOwWfWCaUCGbDjRsft8uHxLxjX/KkjKMx+o2qFNzx3KhxOarNqHdtJeeV3wKHNz+2leOw6Q0gprmhN8V/ZWXmYQmTnyLhB4c3JmVq9FaEf6TvqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710216153; c=relaxed/simple;
	bh=7Lpi3zRSX3+XjOy2RJIFHZfKHQGjDfsjho8arA+oqrg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SNypRMwXyG3pLlrWc8rfoy6D0raMZqZbTvMoiVH8egV597+EN/BT0WuBwkHkxHkEB1WqEQGjERT7tCZQaMd64nM5bwRPaTuM25/NXfkttHbSaQlargBoYgSFNcpMfrUf82rA+STsPn08KV2t8nlshOf3p9ybpwyTp7cJYq78nuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=utHMcUDo; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710216149;
	bh=uOUe4BCyHFHmDX7eGTeEvemo/yakiIcj/f9yFYq2KTI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=utHMcUDoCvgXSVq8aXiKSou//3l/Rwbai/U+7CNS6uHW9eQwRk1pInDPnPQkbhTKB
	 E6KenBT0xVEaZErw2OBI+MFNalNfqrKsmB4d2lM006/za+YJXdCKFx09DxwvjCAyx8
	 zfiEVIhZq4/eewEey6LSYJkMhqq72uPKGGYKVsYFWc4Cq0ChtSBtkQCRc/yDmqonbt
	 5I6DLIHBpWE8n2mia656yU/k8MF5QDkEyf20ScvtmFXd3aCff55KWMUF3HZOWeDtUb
	 U4fxxSUBMAbAj9Q/Zsi5zYJ2/VdHP1TFVYJK4hSgGot13P9gMoipg+zrtmFzXQSStd
	 eFvTW1ZIS0MuA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tv0N46gvDz4wcq;
	Tue, 12 Mar 2024 15:02:28 +1100 (AEDT)
Date: Tue, 12 Mar 2024 15:02:28 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Brauner <brauner@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the vfs-brauner tree with the f2fs
 tree
Message-ID: <20240312150228.31190b3c@canb.auug.org.au>
In-Reply-To: <20240229104140.2927da29@canb.auug.org.au>
References: <20240229104140.2927da29@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pFeyoMquibdqUJ=FIlQlIiY";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/pFeyoMquibdqUJ=FIlQlIiY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 29 Feb 2024 10:41:40 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Today's linux-next merge of the vfs-brauner tree got a conflict in:
>=20
>   fs/f2fs/super.c
>=20
> between commit:
>=20
>   5fa6a97d2784 ("f2fs: introduce SEGS_TO_BLKS/BLKS_TO_SEGS for cleanup")
>=20
> from the f2fs tree and commit:
>=20
>   512383ae4910 ("f2fs: port block device access to files")
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
> diff --cc fs/f2fs/super.c
> index 09ffdd554f9c,09e82624eff5..000000000000
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@@ -4206,9 -4265,9 +4206,9 @@@ static int f2fs_scan_devices(struct f2f
>   			} else {
>   				FDEV(i).start_blk =3D FDEV(i - 1).end_blk + 1;
>   				FDEV(i).end_blk =3D FDEV(i).start_blk +
>  -					(FDEV(i).total_segments <<
>  -					sbi->log_blocks_per_seg) - 1;
>  +						SEGS_TO_BLKS(sbi,
>  +						FDEV(i).total_segments) - 1;
> - 				FDEV(i).bdev_handle =3D bdev_open_by_path(
> + 				FDEV(i).bdev_file =3D bdev_file_open_by_path(
>   					FDEV(i).path, mode, sbi->sb, NULL);
>   			}
>   		}

This is now a conflict between the f2fs tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/pFeyoMquibdqUJ=FIlQlIiY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXv09QACgkQAVBC80lX
0GxTMQf/ZOA3yXMwPh52RY76VAhqrcGgY7TSrfDmLEbKOGZp9dLEV7D27bTzdpaQ
mLjd/J/CXTBJ8lGNn5CTIT7XhLNplJRj65pWQk/yW2VewWgveQdOETKBFQPrd0Ak
rPhYFOGyMLXxW7l7dwpTOkceXgzir4vSjYhMJJykDQabmziN5vAhJNFB1TOR8C08
vmUBNrpfBCoNzgYPLInF8BdnX5VO6AS+4r2kOtyjxJtH92jiJonFFIdnfFG9RfKb
1TCJpjscC1jVkwX/R5Fp+RMIPrCQjkJbVHh5xi6koQnSnSgfrfZJG5xm9VenuOga
b9NXeh2BGXpFRXUas8CMKspUKjcSfA==
=rMU4
-----END PGP SIGNATURE-----

--Sig_/pFeyoMquibdqUJ=FIlQlIiY--

