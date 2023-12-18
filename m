Return-Path: <linux-kernel+bounces-2967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7D0816552
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 04:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4625A1F21BC5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 03:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4AE63BA;
	Mon, 18 Dec 2023 03:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="aPL2BAlU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9990063A3;
	Mon, 18 Dec 2023 03:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1702869938;
	bh=p1ZUN9yydH+yIhaR4/KLunbUiJVXbsKuyzg7+saLzXI=;
	h=Date:From:To:Cc:Subject:From;
	b=aPL2BAlUkMKm/b6Q3dc9R4366ZfBE0jj06r1cKS+Y3YY32/RqYSX46yw0vm+a9siK
	 9L695vqaBDvWUYlYeh5vT279Y8hnmdn7XM8syXqM5il8EFb9qcO5VYGPW8IAPbqYmN
	 dJECTRKVeeqrRW8MLawwuZeQp3Y4/bHUAoPO9Z61DS+xqY/RDmqgOg+FNuRsm63X0q
	 aOwDpcgBbI2hoN/t2H0WXwhC4Sw/hc7MyAUHxB3w8QdFRzE3nad1O75+y6bYUnYhYD
	 yfyP08kB+3hRkSXliSXhYnMpxdIE2hcoxppLKADXXG/y4+iYgk/W+HJ+YS2hGscryv
	 jeutvPcxoyZ+g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4StlZn5VzMz4xPh;
	Mon, 18 Dec 2023 14:25:37 +1100 (AEDT)
Date: Mon, 18 Dec 2023 14:25:37 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Paul E. McKenney" <paulmck@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: linux-next: manual merge of the rcu tree with the jc_docs tree
Message-ID: <20231218142537.3b74c770@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=tx.bSTmqmFJghJvb9Kx2Al";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/=tx.bSTmqmFJghJvb9Kx2Al
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rcu tree got a conflict in:

  Documentation/admin-guide/kernel-parameters.txt

between commit:

  a3a27827452f ("Documentation, mm/unaccepted: document accept_memory kerne=
l parameter")

from the jc_docs tree and commit:

  801f246637ed ("doc: Add EARLY flag to early-parsed kernel boot parameters=
")

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

diff --cc Documentation/admin-guide/kernel-parameters.txt
index 33859d298907,b8f131977682..000000000000
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@@ -1,15 -1,4 +1,15 @@@
 +	accept_memory=3D  [MM]
 +			Format: { eager | lazy }
 +			default: lazy
 +			By default, unaccepted memory is accepted lazily to
 +			avoid prolonged boot times. The lazy option will add
 +			some runtime overhead until all memory is eventually
 +			accepted. In most cases the overhead is negligible.
 +			For some workloads or for debugging purposes
 +			accept_memory=3Deager can be used to accept all memory
 +			at once during boot.
 +
- 	acpi=3D		[HW,ACPI,X86,ARM64,RISCV64]
+ 	acpi=3D		[HW,ACPI,X86,ARM64,RISCV64,EARLY]
  			Advanced Configuration and Power Interface
  			Format: { force | on | off | strict | noirq | rsdt |
  				  copy_dsdt }
@@@ -2449,9 -2440,9 +2451,9 @@@
  			between unregistering the boot console and initializing
  			the real console.
 =20
 -	keepinitrd	[HW,ARM]
 +	keepinitrd	[HW,ARM] See retain_initrd.
 =20
- 	kernelcore=3D	[KNL,X86,IA-64,PPC]
+ 	kernelcore=3D	[KNL,X86,IA-64,PPC,EARLY]
  			Format: nn[KMGTPE] | nn% | "mirror"
  			This parameter specifies the amount of memory usable by
  			the kernel for non-movable allocations.  The requested

--Sig_/=tx.bSTmqmFJghJvb9Kx2Al
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmV/u7EACgkQAVBC80lX
0GwBkwf/QLoReSVnXc/lAGz8KS+ERdxML4dVE20YnwQw1SmaUC1Vc6+rQhLkuOE4
rJd6Gc7aV9M6QOZuo/08JACwpPi2XpvJDNxbSwCKZxjfw6exkEMuUXW2VKWvx55H
avDvZhUIZ4nCxTx4UzOFXVxF6mI9f51VliSFMmTfOzTavEaO/JoeBX1pOtasj4O8
wJANi5Ku61oXWoJjHj/r20gnPw1WoAZzS1RxWcMWgPvt4m9tk7sU9GyBlmj82r+c
yBhgyG4/Yzo7xkdYJvudIB6wCWVn3hyOTlmliK6Smok0SkvcQsZz+9vT6AgWC1Hk
ySNAF27vRWWO8vpv6La/2Rb/WeEp8A==
=i5Lj
-----END PGP SIGNATURE-----

--Sig_/=tx.bSTmqmFJghJvb9Kx2Al--

