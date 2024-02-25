Return-Path: <linux-kernel+bounces-80307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE514862D28
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 22:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C8C51F226D0
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 21:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499A71B95A;
	Sun, 25 Feb 2024 21:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qzD1St73"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB84D1804E;
	Sun, 25 Feb 2024 21:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708896586; cv=none; b=LxfQKpnQUHK4NN5Ff9QKmHDFSu28CB7tgGtBMo58efsoU8m+Xam36bG1/VvDqC9DD2NV3QuGz/L6MJ33Tx7LjqcJ/8K0IAc007RCMdX+HuveWNJ84vvwvkTk+D3gmci8+LpaPiPYwa4SoCPdGmbQi3lbTS75ToXtafWcwz6uYs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708896586; c=relaxed/simple;
	bh=TStgQ32RJQIYWvQkQniLPfRN7HL8sA9R19DtSfOsoeI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=fsH6dYd4QfHrl1Dg7oGp5dCG9WL5fQ4PSU7uA4ySn6vhiy7lppGGwJmgRLZFsFb9p5zdepynPXiIHlD+Fox01wTsux6eghA/FsGMjH0rptsK0JZa4KS2HViI/o4Tp2ZRy11PdIlGs77HUy0q+JDuqP1TESM91x/7YhCYCzQiNqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=qzD1St73; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708896582;
	bh=folSkQSGRsD/FHbuwlbgdkvXZx2rUUnVc8oJ+ULgRfA=;
	h=Date:From:To:Cc:Subject:From;
	b=qzD1St730vDpz7H8nqCGULYv8ZzhF7VHkSfCK45URZGEUTN5tnHpnUzk79s6Did2O
	 WJqoUo/BvUqOT3d1+v25N6iCUn7C8WJMddm2HQ013rJ9TX2J6GPY7puYQ9or9L+ihT
	 cZHYfcdQpONigQMVnT5dqBYx57XmJ+zvtT3f//Z1ukJSSHD25bhZP4JgwVNyA3pxMQ
	 qDR/Dnlplym8g3sX/0mJPnRklnYgz76+zuBAJ/Wkf+kJDwB04ODeQfYWH7xl0Gi0GX
	 4ebfZmHEwRchYIzQvkBjrgXeCxnnAl6brrAVQjm7r/AHD9rm0icRIOHuE3cQuyO//6
	 Ux+RWqL9tSZOQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TjcMp5Rnpz4wc4;
	Mon, 26 Feb 2024 08:29:42 +1100 (AEDT)
Date: Mon, 26 Feb 2024 08:29:41 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tags needs some work in the bcachefs tree
Message-ID: <20240226082941.039719fb@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nfpdkeg2TVPUOv4LTqd.tBF";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/nfpdkeg2TVPUOv4LTqd.tBF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  277112ce9192 ("thread_with_file: Fix missing va_end()")

Fixes tag

  Fixes: https://lore.kernel.org/linux-bcachefs/202402131603.E953E2CF@keesc=
ook/T/#u

has these problem(s):

  - No SHA1 recognised

In commit

  a7b46148ed37 ("bcachefs: Check for subvolume children when deleting subvo=
lumes")

Fixes tag

  Fixes: https://github.com/koverstreet/bcachefs/issues/634

has these problem(s):

  - No SHA1 recognised

Please use a "Closes" tag for these.

In commit

  b58b1b883b9b ("bcachefs: fix iov_iter count underflow on sub-block dio re=
ad")

Fixes tag

  Fixes:

has these problem(s):

  - No SHA1 recognised

In commit

  204f45140faa ("bcachefs: Fix BTREE_ITER_FILTER_SNAPSHOTS on inodes btree")

Fixes tag

  Fixes:

has these problem(s):

  - No SHA1 recognised

In commit

  04fee68dd99a ("bcachefs: Kill __GFP_NOFAIL in buffered read path")

Fixes tag

  Fixes:

has these problem(s):

  - No SHA1 recognised

In commit

  1f626223a0c8 ("bcachefs: fix backpointer_to_text() when dev does not exis=
t")

Fixes tag

  Fixes:

has these problem(s):

  - No SHA1 recognised

Just remove the empty Fixes: tags (or fill them in - and change to Closes:
if necessary).



--=20
Cheers,
Stephen Rothwell

--Sig_/nfpdkeg2TVPUOv4LTqd.tBF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXbsUYACgkQAVBC80lX
0GwqrQf9FfSubckYmd8ygmwaclGHev0559Fy+VC4u1cW+JDOn/SqiW7VaMX1hQZc
xRBOGdqumosGe+Fpaai/UxTKuIChdn35GnLVXb1LKVosVQaRHNVO9kIGP9mP48mA
KtqiSCUQLX7Wd0biIU9BN/jL4LOqhMHn9Sql8CY94B34kZMrXiTfnBtom6U+QmQD
YTM2KzcLyeKlbO0c1D1TS97ghtTtj/7bnm8kpNdLnHbdylFYhYQnjuQ74pl3MK3H
3l3i9OrpNBosI+ioPzzLbQ5ZbmMcxHt/3N9u8T7LUPBX+QugLWtAznV5ElMhI9+K
vxQ6qXUDjfJtjOyBcwo7GPXX55+OEQ==
=ui7r
-----END PGP SIGNATURE-----

--Sig_/nfpdkeg2TVPUOv4LTqd.tBF--

