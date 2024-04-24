Return-Path: <linux-kernel+bounces-156233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F61A8B0000
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C11E31C236B3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A42F13BC16;
	Wed, 24 Apr 2024 03:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="VBzYkDzE"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C557385C59;
	Wed, 24 Apr 2024 03:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713930355; cv=none; b=s8aASUzJvECE79nwxtBDwNZ/bVI7ka5DpE9Wy2u6gSvgfYMoEkK90eYYa5q4UGpbGoIOgLrhQU9l4TdbxvICAl9nw9gaAX7ChxkM5S37FUBY57ONdG1Cg2bH4xmHeAKOUbz/3JzSpv4xnRId/+TsgMfiDPU7iqbnQWW3APFCC7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713930355; c=relaxed/simple;
	bh=5KHG4Klud08VnzfawmdvcmznP0NCKI9/pGgclfwlI9A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=qmvzh7kFT6obA37E/zHxaV5mMLjdNbM5JE0Mt7x/XSBzVXG7lSXq0hRcjmUqa04tukTPlErCQZrvzE8qhUqECLFcacSCG2NPfzYNRGiOYVp9/GDoDyLTMYq0tEjIrwtRQZxeE75tWtEFJ5YzUiOPl1YhHl8n+x8h8B1CyBxLn70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=VBzYkDzE; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713930352;
	bh=kqTWpcHaimLGklEUrnsjykAcbnJGjdI278ZkeHnvtLE=;
	h=Date:From:To:Cc:Subject:From;
	b=VBzYkDzEWwQ1xjE0WHmXjQAxegMiItStqJJpKXXsBdf+D1WmUr0eHA9lTaLOrFAM+
	 XI7sUd7tqN5tjjrw6oW2tJaSPq7Sj9YcxJ4orhRx6lKvJhY9+wXpWo5L5gMNmwf+2v
	 DaEOe4q1O5VdYhINLAJuke3Q3cmdk2olkjzdU8ssrIO55v18miNHOTtmL2kSTeHTNr
	 /pdOQnm6SKvcQlJKddluIMmgIA6X0EwJEEqybJdITfLNOFGpOa+qmSv+zsJnXSzyYn
	 qqlScacsYROYnCQHO4hUx1l/R7aRt25/f3DuhW2EJRWw1hCXo4QOF3eKiZK53M5oBJ
	 g1lGbUnlnqVvA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VPPz40vvfz4wnv;
	Wed, 24 Apr 2024 13:45:52 +1000 (AEST)
Date: Wed, 24 Apr 2024 13:45:51 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Paul E. McKenney" <paulmck@kernel.org>, Luis Chamberlain
 <mcgrof@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: linux-next: manual merge of the rcu tree with the modules tree
Message-ID: <20240424134551.44531979@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=s271tOq0qvWSVNq73D9bg0";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/=s271tOq0qvWSVNq73D9bg0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rcu tree got a conflict in:

  arch/Kconfig

between commit:

  3f26835b6c72 ("kprobes: remove dependency on CONFIG_MODULES")

from the modules tree and commit:

  900da4d2a57c ("arch: Select new NEED_TASKS_RCU Kconfig option")

from the rcu tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/Kconfig
index 0ce4df5afd95,93d5010dfc92..000000000000
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@@ -52,10 -52,10 +52,10 @@@ config GENERIC_ENTR
 =20
  config KPROBES
  	bool "Kprobes"
 -	depends on MODULES
  	depends on HAVE_KPROBES
  	select KALLSYMS
 +	select EXECMEM
- 	select TASKS_RCU if PREEMPTION
+ 	select NEED_TASKS_RCU
  	help
  	  Kprobes allows you to trap at almost any kernel address and
  	  execute a callback function.  register_kprobe() establishes

--Sig_/=s271tOq0qvWSVNq73D9bg0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYogG8ACgkQAVBC80lX
0GyMQQgAofxbv9h7HzukOk6AEY7+11fAkec8OxbeFBBYWkMek2D0batnoe1fJl8v
BGc6EswaKuPbnAAjPrW9fzgh6joylgDJzOv771p2Jk8KAHFAw9AKDLZEgw4CHLhU
ig36LlzGlh61IqGav3+1mYrLNQa1489uNq1u6V45eGq98ZN71Ekj3EXpIo/cymG8
IozEegtYkO0DyGoI5qsObyP7wIiyMUm0GvyQmYDN2yGyfOzEfyJWU95B5meKwC3J
sg40l7F+K3L8ybi98bzhrbx+7ppoLNgLw8Uw1sco/LBpZcs+gN3oDNPa0+NjIfbk
SUT4yAPD927gj9TEVcJzn+rhQ6eASA==
=oaCN
-----END PGP SIGNATURE-----

--Sig_/=s271tOq0qvWSVNq73D9bg0--

