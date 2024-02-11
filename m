Return-Path: <linux-kernel+bounces-61026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE277850C67
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 00:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E121B1C20A13
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 23:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421D1179B0;
	Sun, 11 Feb 2024 23:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="oVHgtheW"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41721799D;
	Sun, 11 Feb 2024 23:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707695564; cv=none; b=CRfhjkBMrl7sar/QSqxz9HxcsNe6Mj0jNOwtoWFcyNaC8p4EFQBggwLvPD7Qnx18ftTxzObKpsKJYhmxFh1gVYxCAFE4su2lx3KlB64KXc3ckxXNn0c3IX6AfjNQogEXSPQ06yUhLnYdL3r29Hq5H5KkCxGnZoGfA/3WEfY1n/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707695564; c=relaxed/simple;
	bh=JQXFAnoO4YA2Ogt6hiOhYeOgJwanEtxRjZrzG3hDdas=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=nTEcuMIkzjNf53xyduVnnvHk+8gXnTBLFa4sSlZLFFRNfVwWlMG8zyqrgHtBI2Hspslj8nBjeyKrWPmF5kYrDTLplkrf47bCiVXK+E1MS+pTDabdp+rzkE8Tmp3oH4qEAH6vTZmkewdAoMrnpSHpEGtnFHh3aWrItp4bPUacPhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=oVHgtheW; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707695559;
	bh=vxJzZFESSgxmpG0isEn0cmRDeJHyk97FZp1YJrOe3Qk=;
	h=Date:From:To:Cc:Subject:From;
	b=oVHgtheWMNglRc5Gq0Gi3RWxk+FXlnKbG7QbwBT5YF3I19zvK1skTFs+NFyqUuYxK
	 ERu8qAaSW7idLZISazKfQ+dHN08j5Z+zmAOcQX+qOuZtBaakxj1tE1o6qZpwSWMa1Y
	 YqoWKh4wAt8gN/JpOEC0CPk8SGPjq6jpn0ucNWx6SCf2Oxk8vwIL0dxg8k9HccC0M2
	 T4v6JwILooPgClK2qnbpFJFYHliZ8Gjg56Fs7zj2+EqNGXRdnEjlYsUf4pDxvPvf+i
	 i0F0lkHHYRtcdU9Rzgz5LY+yXmi6tG/t7q6aeSBEUcOwiB8O63k+mda8wkSchJfeER
	 MaLDwfyGL1kyg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TY4CC17fkz4wcM;
	Mon, 12 Feb 2024 10:52:39 +1100 (AEDT)
Date: Mon, 12 Feb 2024 10:52:37 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Brauner <brauner@kernel.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the vfs-brauner tree
Message-ID: <20240212105237.674e6fcb@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/e7Wj8RxO4hgSjuzIgwMC=U=";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/e7Wj8RxO4hgSjuzIgwMC=U=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the vfs-brauner tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from include/linux/highmem.h:5,
                 from include/linux/bvec.h:10,
                 from include/linux/blk_types.h:10,
                 from include/linux/blkdev.h:9,
                 from fs/btrfs/super.c:6:
include/linux/fs.h: In function 'super_set_sysfs_name_generic':
include/linux/fs.h:2597:9: error: function 'super_set_sysfs_name_generic' m=
ight be a candidate for 'gnu_printf' format attribute [-Werror=3Dsuggest-at=
tribute=3Dformat]
 2597 |         vsnprintf(sb->s_sysfs_name, sizeof(sb->s_sysfs_name), fmt, =
args);
      |         ^~~~~~~~~
cc1: all warnings being treated as errors

and many more similar.

Caused by commit

  eeea5d25d4a7 ("fs: add FS_IOC_GETFSSYSFSPATH")

This new finction is not used anywhere, so just remove it for now?

I have used the vfs-brauner tree from next-20240209 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/e7Wj8RxO4hgSjuzIgwMC=U=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXJXcUACgkQAVBC80lX
0Gxe0wgAo5b6n5uWR8n7W7Tz/W9QganNVeeQnF2frZJR8ufXYnDceIgCJ9Ea9AJI
uvuS/hlOjJ1UGS3u7pHt09qsOHr5+jtIYvslUtWAHtqU3MRD4b7E4eecOQ+5vTd6
+EzlYPeZp5ZR9Rya7fKduC0EJAhhP033dkMFeZvULmIwox43IJbWbIhLaA3AumMX
+/QiiRXEmSqgv1hXbl5tsepihFH4iJ2SVqLTmaua5lnEnN1FvsKy9oYp0njHULNJ
MwkWm/fBy7aF+xM8uJfMUzyFe/rzbX8ruJWzfAN0vRKSKINv3OCBAsNIBiwNsV96
Wja8xn+G1aB/Y0VxxW450nWeoj3XBg==
=WTax
-----END PGP SIGNATURE-----

--Sig_/e7Wj8RxO4hgSjuzIgwMC=U=--

