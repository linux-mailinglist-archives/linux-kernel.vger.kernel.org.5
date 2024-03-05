Return-Path: <linux-kernel+bounces-91457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8788711C1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC32D284F8B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CFD4A1B;
	Tue,  5 Mar 2024 00:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="eTwMpLvA"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3962E7F;
	Tue,  5 Mar 2024 00:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709598908; cv=none; b=QoymBKIWAk6Y9CYgi1vtNlkCct8O+rpSsQ0lOTt2SaQYIOGtMugOHI8TBiiVDMjepk4RVcDTCmfayB40+MOM72z82F2dWKqFOD97sotYs23kg3fMQNw0Xm17WNkucmRiR0S+reY1UAd30yRhwU1sfJbRq0t+gBAafs6RMLhdgqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709598908; c=relaxed/simple;
	bh=PCsYDTURvV1tW5UvefTJtXT6+1YGaA5XQOuwIQggbKs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tw4uZxViQwIiQwIj5cvAS0XtFN5G2PzKsO5vmd2OPVr1RLDl1Abbmrfw71ZVVI45kytibf9fgMCQ3T17FdL5FgqFGhdK2JjqwA7FoqN9eRlLMJvbYbbgnzpzzpCopaH+GS2rdsGlrkxhLxMxI0j9N5E8r1TDL0qLu7dpyCQcu+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=eTwMpLvA; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709598903;
	bh=l+gec52w3b84L5VzZeWYR71Pd4VTnc6B+mzVkOS7Lx0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eTwMpLvA1SaHF4LNc71kUpwGr6OMJcdv/zLvDzu2y+S3QjQ5NGb+hDA+R1XfiEMgs
	 JDv3yYQklVt9+RT+oqz7iuOgnG93MriigmvPc0HnOv6Kzb3HLc3kWY3vGJxUrPxSBv
	 8HnHGiiHtcIA7TwOuBcDbjRIwtOn5U0PTKOGnstblyx/jGZQSSZK83eW+Tb/JG6Tor
	 vYCDAXm701w9IDdwmSNDPcCNsQ4WqRX7i1pGVjSX6QwT7Er5oRpydFfPZGa5mNQl/k
	 9tCKBW1TQF51V2yG9oJ1r7g+m+ocdBB9bWRvkeyZLPVURRLsMsEan1A7JoacHMSzZ3
	 sMjKOZ/U4n8Hw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tpc5z2B0Hz4wc9;
	Tue,  5 Mar 2024 11:35:03 +1100 (AEDT)
Date: Tue, 5 Mar 2024 11:35:02 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Chao Yu <chao@kernel.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the vfs-brauner tree with the f2fs
 tree
Message-ID: <20240305113502.50980f88@canb.auug.org.au>
In-Reply-To: <ZeC7OEA4Onoi-mED@google.com>
References: <20240229104140.2927da29@canb.auug.org.au>
	<ZeC7OEA4Onoi-mED@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oRJlkEHKcsgvBkXqxPsyIe6";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/oRJlkEHKcsgvBkXqxPsyIe6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jaegeuk,

On Thu, 29 Feb 2024 09:13:28 -0800 Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>
> On 02/29, Stephen Rothwell wrote:
> >=20
> > Today's linux-next merge of the vfs-brauner tree got a conflict in:
> >=20
> >   fs/f2fs/super.c
> >=20
> > between commit:
> >=20
> >   5fa6a97d2784 ("f2fs: introduce SEGS_TO_BLKS/BLKS_TO_SEGS for cleanup"=
) =20
>=20
> fyi; I dropped the above commit in -dev.

And it seems to have come back as commit

  45809cd3bdac ("f2fs: introduce SEGS_TO_BLKS/BLKS_TO_SEGS for cleanup")

(which is fine, but the conflict has returned).

> > from the f2fs tree and commit:
> >=20
> >   512383ae4910 ("f2fs: port block device access to files")
> >=20
> > from the vfs-brauner tree.
> >=20
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> >=20
> > --=20
> > Cheers,
> > Stephen Rothwell
> >=20
> > diff --cc fs/f2fs/super.c
> > index 09ffdd554f9c,09e82624eff5..000000000000
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@@ -4206,9 -4265,9 +4206,9 @@@ static int f2fs_scan_devices(struct f2f
> >   			} else {
> >   				FDEV(i).start_blk =3D FDEV(i - 1).end_blk + 1;
> >   				FDEV(i).end_blk =3D FDEV(i).start_blk +
> >  -					(FDEV(i).total_segments <<
> >  -					sbi->log_blocks_per_seg) - 1;
> >  +						SEGS_TO_BLKS(sbi,
> >  +						FDEV(i).total_segments) - 1;
> > - 				FDEV(i).bdev_handle =3D bdev_open_by_path(
> > + 				FDEV(i).bdev_file =3D bdev_file_open_by_path(
> >   					FDEV(i).path, mode, sbi->sb, NULL);
> >   			}
> >   		} =20

--=20
Cheers,
Stephen Rothwell

--Sig_/oRJlkEHKcsgvBkXqxPsyIe6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXmaLYACgkQAVBC80lX
0GzIEQf+Nr7j63ZtcVQULgGJvkNDDgjoF6q3Y2b/Dgc+nwd9RrXMHP5uWM70hOok
2XOU081BQ/+s4/wOWGaP8iKENH5dCKUXlyE3mBnMfwxX9v2KqiIMIkBEv1Mlub0r
npC4XvwZB/2LNgrmQsdkVi/CIw4DHsjmwciS8BSu/rI0cApaeHjepqF/9WTeTAuv
GbrFt1aZQvHEve2k4Aay3MfrdRkVD/n4cF8hFyq/+MjfIfZnmvlgklPzfW/aa4f3
e/ACrwEnk+E4WM6U/n060yVsk8lZOr14fb3uIS5ZTzqNvhKyoZJmhHVwf+mkA4Lx
HyWxwvxnaz3HRESvcby91iW4x8zMng==
=xfij
-----END PGP SIGNATURE-----

--Sig_/oRJlkEHKcsgvBkXqxPsyIe6--

