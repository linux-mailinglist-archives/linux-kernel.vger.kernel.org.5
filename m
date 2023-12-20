Return-Path: <linux-kernel+bounces-6132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C26819500
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B04B9287BA9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5983279DD;
	Wed, 20 Dec 2023 00:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Qs5HHIlt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2F4747B;
	Wed, 20 Dec 2023 00:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1703031207;
	bh=rZnBd1T/fKVecpDX9jnpYUYyafbdv3cCHuAbDvu51mQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qs5HHIltPUGSTmwK6MzJ/DD4vTdAgRb+eUwBGVMLbWn12wM6DD51BZWbckznetHvr
	 2DlutB3I7IH8v7uzOMxBOqxNJ/wnuoRQoYisLlFuBbatXmEUft0q3qmqBDHd5QhxpF
	 0CPYxws6svbErrHvquMGdOkTVEH3VuuvFGoAuxcYlIjiUxLqP0TOO1Z0YU4WbVvwAS
	 BPF5GBwum7IzBldqWdXCU3yVYzRjFgUM4fvVdJp5pt4O16o+vZCNWG5+8fyZAHCUyk
	 +1boyUZ0M1H24e/YKYcIkFn92SS7OkSDtQcKoBI8bcGqL8oyCZNzMArPaXjFUawgJF
	 Jjr/fBlIWKpFQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SvvD661Vhz4wdB;
	Wed, 20 Dec 2023 11:13:26 +1100 (AEDT)
Date: Wed, 20 Dec 2023 11:13:25 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Al Viro <viro@ZenIV.linux.org.uk>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>, Jan Kara <jack@suse.cz>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the vfs tree with the f2fs tree
Message-ID: <20231220111325.5dd55e47@canb.auug.org.au>
In-Reply-To: <20231220104734.0979a9f8@canb.auug.org.au>
References: <20231220104734.0979a9f8@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/za_oBUSqBa1NS65BZ31N7+h";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/za_oBUSqBa1NS65BZ31N7+h
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Al,

On Wed, 20 Dec 2023 10:47:34 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the vfs tree got a conflict in:
>=20
>   fs/f2fs/namei.c
>=20
> between commit:
>=20
>   53edb549565f ("f2fs: fix to avoid dirent corruption")
>=20
> from the f2fs tree and commit:
>=20
>   7deee77b993a ("f2fs: Avoid reading renamed directory if parent does not=
 change")
>=20
> from the vfs tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Then I remembered to look at your suggested resolution and redid it
like you did (see below).
--=20
Cheers,
Stephen Rothwell

--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@@ -1104,12 -1106,12 +1105,9 @@@ static int f2fs_rename(struct mnt_idma
  		iput(whiteout);
  	}
 =20
 -	if (old_is_dir) {
 -		if (old_dir_entry && !whiteout)
 -			f2fs_set_link(old_inode, old_dir_entry,
 +	if (old_dir_entry) {
- 		if (old_dir !=3D new_dir)
- 			f2fs_set_link(old_inode, old_dir_entry,
++		f2fs_set_link(old_inode, old_dir_entry,
  						old_dir_page, new_dir);
--		else
--			f2fs_put_page(old_dir_page, 0);
  		f2fs_i_links_write(old_dir, false);
  	}
  	if (F2FS_OPTION(sbi).fsync_mode =3D=3D FSYNC_MODE_STRICT) {

--Sig_/za_oBUSqBa1NS65BZ31N7+h
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWCMaUACgkQAVBC80lX
0GxkUQf/dro/dS32sGdL1hEyx/nQs9iXfBANu2fWDrvBoPiEsnWKSAb5jyjHkg3o
PWxyCM+umwm5PlM/bXqGYcdcpBeaVH38ioE8zY7LfJW/wvHiR9LLPwHY7rnARU0E
pvBvBBDtxZpqqnr2wLEad42ycOmXNFCjqboZCoA4FrQU7aE8Vhr9fQV5jdiz7hPU
sSybwakljN+k/5MvAC6z9O4xGFlKunCymFeA2sCLTrjuamKF17Sfk/jXMX6d7wfM
IzU2Rw5XA+ZLRsnlRwXczPuWm4brlBp/Kzfq8G2EuIjhgzPOfOcrcQQP48YygD/X
Qdhav14q6MQmn+0sgK0mOJYp7H5eSw==
=Brhi
-----END PGP SIGNATURE-----

--Sig_/za_oBUSqBa1NS65BZ31N7+h--

