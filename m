Return-Path: <linux-kernel+bounces-64608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 063A48540D2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 942EC1F2A2AC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B08A934;
	Wed, 14 Feb 2024 00:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="IwxEmGvy"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0899449;
	Wed, 14 Feb 2024 00:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707870329; cv=none; b=e7DxbqWbG0KGAik2g6idsoheNgdYqoXAXCgpVsrOPRFF/Shf5OZGEy1OfqORTYIJqky598jDX7f2ZuEeU+jz9OiiqE3lSF1v4lYnmwjiHEYiZnZoKbLn6LmzSoBfTrMTbBnRFE6uxisiUtNIo6jq6lC/8pj8Dn6Ou3AFgmFwWqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707870329; c=relaxed/simple;
	bh=ZYz52E5UpZ22syPUWwTv63Zl55ZRM/Eb3jbRBRiXYFg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=C7ncQ5nbN/6I420jr0OdYrZanVj1PuTd7FVc4o8pvI2g1hfPJMwI6w1SrpjVxz6Nav4ZtVtc+G19cb/QZaZ+Aar7VitAOjZ/WKLZcK6NuZS2Zw9FvmS55WWWkujhZxk/Jy/ZWjRMwe5JO27icFruEd5dFPRNfemOt1NmSkUyEZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=IwxEmGvy; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707870321;
	bh=T9rHeq/WjASCf4FMqrpZrCbxQNqDKMlgq3tzgKIB91I=;
	h=Date:From:To:Cc:Subject:From;
	b=IwxEmGvySQgBt4zTPvnibksanFVd3+ymF8wR5Bsnoo04QBHevmnkzrxILLFyUgsuo
	 fL+kQI/XpHo7uCtYtfJR9Sp0p/5AgHbRRzC+NqO30bXFrgPwmmB55wyHfAyg6L9gDc
	 L+WPVExXdJWXHQl/B5xD8w/THKBmmtOt7k1viPFg32Gj3Ak1RshZSwOzfVC+vCL9Ak
	 7bi4xY6t1hasNv0zSPlGZedDbEYp/u60jLROtj+jjuySILNn5mZlk3B++Qd0U4bhxD
	 wcGOVH3LoirgULptEYHClPJOiSFpo9Oy0AAYI7U5lzJ+S39fN6nGzwQfL8VYqjRin9
	 5AoSAzEDrjrYA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TZJr10B39z4wcr;
	Wed, 14 Feb 2024 11:25:20 +1100 (AEDT)
Date: Wed, 14 Feb 2024 11:25:19 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: linux-next: manual merge of the block tree with the mm tree
Message-ID: <20240214112519.153c8480@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_N=Ct6hGFsdkTL7zn6nUMH6";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/_N=Ct6hGFsdkTL7zn6nUMH6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got a conflict in:

  include/linux/sched.h

between commit:

  d9233ee073c9 ("mm: document memalloc_noreclaim_save() and memalloc_pin_sa=
ve()")

from the mm-unstable branch of the mm tree and commit:

  06b23f92af87 ("block: update cached timestamp post schedule/preemption")

from the block tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/sched.h
index 5b27a548d863,15b7cb478d16..000000000000
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@@ -1642,9 -1641,8 +1642,9 @@@ extern struct pid *cad_pid
  #define PF__HOLE__02000000	0x02000000
  #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle=
 with cpus_mask */
  #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process polic=
y */
 -#define PF_MEMALLOC_PIN		0x10000000	/* Allocation context constrained to =
zones which allow long term pinning. */
 +#define PF_MEMALLOC_PIN		0x10000000	/* Allocations constrained to zones w=
hich allow long term pinning.
 +						 * See memalloc_pin_save() */
- #define PF__HOLE__20000000	0x20000000
+ #define PF_BLOCK_TS		0x20000000	/* plug has ts that needs updating */
  #define PF__HOLE__40000000	0x40000000
  #define PF_SUSPEND_TASK		0x80000000      /* This thread called freeze_pro=
cesses() and should not be frozen */
 =20

--Sig_/_N=Ct6hGFsdkTL7zn6nUMH6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXMCG8ACgkQAVBC80lX
0Gx2lwf+N0sZkkSiCq720HgLquFLPnRiIuegcVxgskirDnCNO0iM6BpAoL/Fu+7S
dxz4k4SFwGvSlLk7Mhkvft4Ari2hvYyBTOtQn+u2L/iL6xGcJsCxvI7UT8bxFy9q
p4R0qaKZ45jYFCIt5zCR6J63tzDg7IpfR0ltzz4Yu95rffRAhpOgXehet6LvWoyy
Op4zgetnQxKGOmB51uz4oF/bK4ZKhWCg7j5SyJHXMz/Mhhj6ox2FMn7GN3caItSG
n5k5eQIYeQparVem/F/iKFtY1rf4W1ziyAo05nLp6EFIofFG6goX7aLUkB8matBU
HHV4xHjhLrU5RdeYoJr1Kb9nnerZ4g==
=UH5Z
-----END PGP SIGNATURE-----

--Sig_/_N=Ct6hGFsdkTL7zn6nUMH6--

