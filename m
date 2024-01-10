Return-Path: <linux-kernel+bounces-22871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8761982A4B8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 00:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FFFF1F23D34
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 23:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFEA4F8A1;
	Wed, 10 Jan 2024 23:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="JJ/EtR29"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709794F88A;
	Wed, 10 Jan 2024 23:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704927820;
	bh=t6qTg4+hvafGldknVqf3jODmxC5jGlYpKg7EK7DM02M=;
	h=Date:From:To:Cc:Subject:From;
	b=JJ/EtR29eTIsbcJ588Zmtjz2E6jDXJrZsaKITXfKkha3WYLh+UQKLPn+17s7MGqbb
	 SyX/y77pWDfbgDRIuZaRErnDJm22EF6RgzZsTRTWevVdiapW5zd/qhoaklg1F06TmR
	 ZwBoxy2KEaZ+tkTy9ajA8pcQCUhL0zx43j4fxByi9jk1QWXBtlq1FKaUAg/pzgceSS
	 Oaz/mXSKGOlevIpo2UM51GfRFMXC5OGmKTK1XnS0ac7f9cZC06DljBwVoc0Jr8ATs9
	 ceqfC++/oWbPwncv3h1m05S60dCo+EiIGYnrtJPTHSQr5KhcI2wsuixvdDwJ4GU57b
	 c4enJvJ7Ob2ew==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T9NdR3XJNz4x43;
	Thu, 11 Jan 2024 10:03:38 +1100 (AEDT)
Date: Thu, 11 Jan 2024 10:03:37 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Sterba <dsterba@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, David Sterba <dsterba@suse.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Qu Wenruo <wqu@suse.com>
Subject: linux-next: manual merge of the btrfs tree with Linus' tree
Message-ID: <20240111100337.3e9ef25c@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lLfBhIqmLWmkcJpHWEd/qNC";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/lLfBhIqmLWmkcJpHWEd/qNC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

FIXME: Add owner of second tree to To:
       Add author(s)/SOB of conflicting commits.

Today's linux-next merge of the btrfs tree got a conflict in:

  fs/btrfs/extent_io.c

between commits:

  affc5af36bbb ("Merge tag 'for-6.8-tag' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/kdave/linux")
  600f111ef51d ("fs: Rename mapping private members")

from Linus' tree and commit:

  08236d11031b ("btrfs: cache folio size and shift in extent_buffer")

from the btrfs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/btrfs/extent_io.c
index cfd2967f04a2,c8aabe3be169..000000000000
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@@ -3677,7 -3668,9 +3668,9 @@@ reallocate
  		 * and free the allocated page.
  		 */
  		folio =3D eb->folios[i];
+ 		eb->folio_size =3D folio_size(folio);
+ 		eb->folio_shift =3D folio_shift(folio);
 -		spin_lock(&mapping->private_lock);
 +		spin_lock(&mapping->i_private_lock);
  		/* Should not fail, as we have preallocated the memory */
  		ret =3D attach_extent_buffer_folio(eb, folio, prealloc);
  		ASSERT(!ret);

--Sig_/lLfBhIqmLWmkcJpHWEd/qNC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWfIkkACgkQAVBC80lX
0GypFwgAl5YNYuk4e0ljNREu1f9sb1MwxPNZYf9yeVDZYb2AqRu4ccHcSj5g5/Lz
FFb32Sx9dr7p80CTTMpt/Vx+RJie2B0QnXKi6MxSOHUOvxHix28j1PfJMYGCMRFE
7FLxaDbSU4Zwkyuergma2qy9fiWUitpxLXnbl19uPOqAzVJSOYeTq8DsfK5upS9E
TKbR63+wOpaqExPWICu6dGvvmbUFizi438ckdnQuczqsLVwEqEz8/PYKEgj8XTZR
5EskRvoiuTkwmeHXU+/w7t89BA10GSLFwmDTgbb++KqFf4Hnts3sRM5/gYiRRNTB
sf2qqDeqimxeC2N78sRHYb8XdYEOzw==
=ycui
-----END PGP SIGNATURE-----

--Sig_/lLfBhIqmLWmkcJpHWEd/qNC--

