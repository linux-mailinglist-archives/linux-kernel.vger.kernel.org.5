Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F395E7FE15C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 21:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbjK2Uuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 15:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbjK2Uu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 15:50:29 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043DB10C8;
        Wed, 29 Nov 2023 12:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1701291023;
        bh=sbuX3N7oxvepbGzhXGjYp8FuqlFjbX1ICGKiB2uKdQM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hCS/nb5+wogn0WYNS2HUBNEUkUL9whGvBLA5iv8ppEx7N2O1KzaYsrzEnezZT64Sp
         64BuWyKwxnbVfFNt3OVMXPjTgiPPVqlTkZvDBJQFBDJ02NnnGKeORgXJF2chxyxlb7
         /Ddk4Vufx1GvXyXLUgFdnqazCKXjOFP2wcusfHO6dnycyDN0fno2ElhK+Didq/V06C
         sQl3lzgeYUivxjjS6mkYiT3lZqzmspD79OSQ0cpA9mOj4/t79VSepzW+YiA01tfNWe
         lZiDkdQGw1T1R/GndS03cC+0Lf+bA9BtqL0Jsr0I8kwW/TpG/SWqEkley2JP35PjyH
         EDpqkVnlHPE/A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SgWg23273z4xT0;
        Thu, 30 Nov 2023 07:50:22 +1100 (AEDT)
Date:   Thu, 30 Nov 2023 07:50:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jan Kara <jack@suse.cz>, Nathan Chancellor <nathan@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        David Sterba <dsterba@suse.cz>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the vfs-brauner tree with the btrfs
 tree
Message-ID: <20231130075021.27851843@canb.auug.org.au>
In-Reply-To: <20231129110930.qncvzm63xjg4ucky@quack3>
References: <20231127092001.54a021e8@canb.auug.org.au>
        <20231128213344.GA3423530@dev-arch.thelio-3990X>
        <20231129110930.qncvzm63xjg4ucky@quack3>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/znoGVz9k4TY6QKX8yOkCQ_s";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/znoGVz9k4TY6QKX8yOkCQ_s
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 29 Nov 2023 12:09:30 +0100 Jan Kara <jack@suse.cz> wrote:
>
> On Tue 28-11-23 14:33:44, Nathan Chancellor wrote:
> > Hi Stephen (and other maintainers),
> >=20
> > On Mon, Nov 27, 2023 at 09:20:01AM +1100, Stephen Rothwell wrote: =20
> > > Hi all,
> > >=20
> > > Today's linux-next merge of the vfs-brauner tree got a conflict in:
> > >=20
> > >   fs/btrfs/super.c
> > >=20
> > > between commit:
> > >=20
> > >   2f2cfead5107 ("btrfs: remove old mount API code")
> > >=20
> > > from the btrfs tree and commit:
> > >=20
> > >   ead622674df5 ("btrfs: Do not restrict writes to btrfs devices")
> > >=20
> > > from the vfs-brauner tree.
> > >=20
> > > I fixed it up (the former removed the funtion updated by the latter, =
but
> > > a further fix may be required to implement the intent of the latter?)=
 =20
> >=20
> > Yes, the lack of ead622674df5 appears to cause issues with mounting
> > btrfs volumes on at least next-20231128 due to the presence of commit
> > 6f861765464f ("fs: Block writes to mounted block devices"). In QEMU, I
> > can see:
> >=20
> >   :: running early hook [udev]
> >   Warning: /lib/modules/6.7.0-rc3-next-20231128/modules.devname not fou=
nd - ignoring
> >   Starting systemd-udevd version 252.5-1-arch
> >   :: running hook [udev]
> >   :: Triggering uevents...
> >   :: running hook [keymap]
> >   :: Loading keymap...kbd_mode: KDSKBMODE: Inappropriate ioctl for devi=
ce
> >   done.
> >   :: performing fsck on '/dev/vda2'
> >   :: mounting '/dev/vda2' on real root
> >   mount: /new_root: wrong fs type, bad option, bad superblock on /dev/v=
da2, missing codepage or helper program, or other error.
> >          dmesg(1) may have more information after failed mount system c=
all.
> >   You are now being dropped into an emergency shell.
> >   sh: can't access tty; job control turned off
> >   [rootfs ]#
> >=20
> > The following diff allows my VM to boot properly but I am not sure if
> > there is a better or more proper fix (I am already out of my element
> > heh). If a proper merge solution cannot be found quickly, can
> > 6f861765464f be reverted in the meantime so that all my machines with
> > btrfs can boot properly? :)
> >=20
> > diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> > index 99d10a25a579..23db0306b8ef 100644
> > --- a/fs/btrfs/super.c
> > +++ b/fs/btrfs/super.c
> > @@ -299,6 +299,7 @@ static int btrfs_parse_param(struct fs_context *fc,
> >  	case Opt_device: {
> >  		struct btrfs_device *device;
> >  		blk_mode_t mode =3D sb_open_mode(fc->sb_flags);
> > +		mode &=3D ~BLK_OPEN_RESTRICT_WRITES;
> > =20
> >  		mutex_lock(&uuid_mutex);
> >  		device =3D btrfs_scan_one_device(param->string, mode, false);
> > @@ -1801,6 +1802,8 @@ static int btrfs_get_tree_super(struct fs_context=
 *fc)
> >  	blk_mode_t mode =3D sb_open_mode(fc->sb_flags);
> >  	int ret;
> > =20
> > +	mode &=3D ~BLK_OPEN_RESTRICT_WRITES;
> > +
> >  	btrfs_ctx_to_info(fs_info, ctx);
> >  	mutex_lock(&uuid_mutex); =20
>=20
> This looks like the proper resolution. Basically btrfs needs to strip
> BLK_OPEN_RESTRICT_WRITES from the mode provided by sb_open_mode(). Thanks
> for writing it!

I have added this patch as a merge fix from today.

--=20
Cheers,
Stephen Rothwell

--Sig_/znoGVz9k4TY6QKX8yOkCQ_s
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVnpA0ACgkQAVBC80lX
0Gyexgf9GCadScaPjjCMOiwzGUV4KztmJNnhRpqGDaZ7sMkRarqx8xE/Kr9YwfQR
zb6XNdkl/o0YgSoWBXuhXPkhZCOFC4CfmiYNHHFJNxCwq3AUMsfRZfBf0meL32RH
81QZRcuDFvg39qsRS6GgWE2fsB+CNmuwH4G5eQOzAM5ehvw+hGro1qfYUsncHHzp
73oLhlCCTsweQ7TYdJPDGhFrz/er1LUuM0ugHGEOdfuUf2EJFde+7Bo8VllcFzQK
K3+nxkR4NovIbimlsIbWRAPEJrptQJUSRB9+AZHiqQZvA71wC/BR30l1gxO0XnDV
uoaIM+cpesjbhBgGf1JmcS/crzU8bg==
=cIWP
-----END PGP SIGNATURE-----

--Sig_/znoGVz9k4TY6QKX8yOkCQ_s--
