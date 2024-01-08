Return-Path: <linux-kernel+bounces-20112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B838279B6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73FCF282A56
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B38254BE9;
	Mon,  8 Jan 2024 20:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="s/LAsJ23"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEDB56B67;
	Mon,  8 Jan 2024 20:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704747228;
	bh=u4PSZoBxfcNP9TlOlX2nwk0N5IWVfjg8KWDg0/CD2UI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s/LAsJ23E8YZ9eBZsxGiEr2hzmRAFpJP/RLC27Bg33uWpHL0UPzVe8s+JjyQe0Cnb
	 8bWvmGy3M6MDwCagKqs30QUICuQlVW8drCDKKqdoMnal8bCSd9uRqLWjgcir4MQRQy
	 QPm8t5cZ8Yd2NUL84YnNe0mXTZ1jbriRbh0TSqbik36HAoKPR1ZJrYDU1MUwPtPuwP
	 nbTlYCWZvnyyBbvTvVlCZn5DvCDBoy4ho6FMYaImGZ+cbzFO8JxeJS+TEJAOMcvqM0
	 XeYvkcqQ3FIEP2OaMtCFSFprdxO7bgb00ebE3MtzARSExCIkgLpVAfchwk+h4aDE5k
	 lQp84Ai7RGPXA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T85rX1Jhjz4x1P;
	Tue,  9 Jan 2024 07:53:47 +1100 (AEDT)
Date: Tue, 9 Jan 2024 07:53:46 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Sterba <dsterba@suse.cz>
Cc: Jan Kara <jack@suse.cz>, Nathan Chancellor <nathan@kernel.org>,
 Christian Brauner <brauner@kernel.org>, David Sterba <dsterba@suse.com>,
 Josef Bacik <josef@toxicpanda.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the vfs-brauner tree with the btrfs
 tree
Message-ID: <20240109075346.0e1ac96b@canb.auug.org.au>
In-Reply-To: <20231130075021.27851843@canb.auug.org.au>
References: <20231127092001.54a021e8@canb.auug.org.au>
	<20231128213344.GA3423530@dev-arch.thelio-3990X>
	<20231129110930.qncvzm63xjg4ucky@quack3>
	<20231130075021.27851843@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BWFky=4e=HQX3e3_BD8zGnd";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/BWFky=4e=HQX3e3_BD8zGnd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 30 Nov 2023 07:50:21 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Wed, 29 Nov 2023 12:09:30 +0100 Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 28-11-23 14:33:44, Nathan Chancellor wrote: =20
> > > Hi Stephen (and other maintainers),
> > >=20
> > > On Mon, Nov 27, 2023 at 09:20:01AM +1100, Stephen Rothwell wrote:   =
=20
> > > > Hi all,
> > > >=20
> > > > Today's linux-next merge of the vfs-brauner tree got a conflict in:
> > > >=20
> > > >   fs/btrfs/super.c
> > > >=20
> > > > between commit:
> > > >=20
> > > >   2f2cfead5107 ("btrfs: remove old mount API code")
> > > >=20
> > > > from the btrfs tree and commit:
> > > >=20
> > > >   ead622674df5 ("btrfs: Do not restrict writes to btrfs devices")
> > > >=20
> > > > from the vfs-brauner tree.
> > > >=20
> > > > I fixed it up (the former removed the funtion updated by the latter=
, but
> > > > a further fix may be required to implement the intent of the latter=
?)   =20
> > >=20
> > > Yes, the lack of ead622674df5 appears to cause issues with mounting
> > > btrfs volumes on at least next-20231128 due to the presence of commit
> > > 6f861765464f ("fs: Block writes to mounted block devices"). In QEMU, I
> > > can see:
> > >=20
> > >   :: running early hook [udev]
> > >   Warning: /lib/modules/6.7.0-rc3-next-20231128/modules.devname not f=
ound - ignoring
> > >   Starting systemd-udevd version 252.5-1-arch
> > >   :: running hook [udev]
> > >   :: Triggering uevents...
> > >   :: running hook [keymap]
> > >   :: Loading keymap...kbd_mode: KDSKBMODE: Inappropriate ioctl for de=
vice
> > >   done.
> > >   :: performing fsck on '/dev/vda2'
> > >   :: mounting '/dev/vda2' on real root
> > >   mount: /new_root: wrong fs type, bad option, bad superblock on /dev=
/vda2, missing codepage or helper program, or other error.
> > >          dmesg(1) may have more information after failed mount system=
 call.
> > >   You are now being dropped into an emergency shell.
> > >   sh: can't access tty; job control turned off
> > >   [rootfs ]#
> > >=20
> > > The following diff allows my VM to boot properly but I am not sure if
> > > there is a better or more proper fix (I am already out of my element
> > > heh). If a proper merge solution cannot be found quickly, can
> > > 6f861765464f be reverted in the meantime so that all my machines with
> > > btrfs can boot properly? :)
> > >=20
> > > diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> > > index 99d10a25a579..23db0306b8ef 100644
> > > --- a/fs/btrfs/super.c
> > > +++ b/fs/btrfs/super.c
> > > @@ -299,6 +299,7 @@ static int btrfs_parse_param(struct fs_context *f=
c,
> > >  	case Opt_device: {
> > >  		struct btrfs_device *device;
> > >  		blk_mode_t mode =3D sb_open_mode(fc->sb_flags);
> > > +		mode &=3D ~BLK_OPEN_RESTRICT_WRITES;
> > > =20
> > >  		mutex_lock(&uuid_mutex);
> > >  		device =3D btrfs_scan_one_device(param->string, mode, false);
> > > @@ -1801,6 +1802,8 @@ static int btrfs_get_tree_super(struct fs_conte=
xt *fc)
> > >  	blk_mode_t mode =3D sb_open_mode(fc->sb_flags);
> > >  	int ret;
> > > =20
> > > +	mode &=3D ~BLK_OPEN_RESTRICT_WRITES;
> > > +
> > >  	btrfs_ctx_to_info(fs_info, ctx);
> > >  	mutex_lock(&uuid_mutex);   =20
> >=20
> > This looks like the proper resolution. Basically btrfs needs to strip
> > BLK_OPEN_RESTRICT_WRITES from the mode provided by sb_open_mode(). Than=
ks
> > for writing it! =20
>=20
> I have added this patch as a merge fix from today.

This is now a conflict between the btrfs tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/BWFky=4e=HQX3e3_BD8zGnd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWcYNoACgkQAVBC80lX
0GzpDgf+NY7RKKB4lCa/PNkJyYvVWs2+h2s8ZNKr/Tc197oQ35TaH+Rx7W7CxRx0
4qiXE6LuuoYMlJzdqL2M21PR1RSgyuflYBTTa2K7Q7P2ejWzLdE8KASJgU4titsR
d7uEzyFGXwa/lyFS9hle8O+zRESMscF2swnKl/DtM+RDrpVbIrbWYw5tdEH92mS1
Bh7ZeDbrANCIgLTNyhLzRDGtuV40Lgw24wzy174cCnkCh+ciNioP8cHYxYcr1BGh
bo7D5mFaEgwZO+Ew6BCgwtDkYhhk60c4YEmLmIuOqV3uVW+VK7gGsuAJPe6nGCiE
Y/UI91rdiy0qBEAhaRs/fbCvnJWMIw==
=ADb9
-----END PGP SIGNATURE-----

--Sig_/BWFky=4e=HQX3e3_BD8zGnd--

