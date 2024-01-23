Return-Path: <linux-kernel+bounces-36164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA60D839CEB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD32E1C236DA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D37053E1C;
	Tue, 23 Jan 2024 23:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="vH7Lla7v"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588231FBF;
	Tue, 23 Jan 2024 23:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706051121; cv=none; b=M76CSEG1xLAFnhnS2Pz4efs5BYHgsPIzUqv5D6BHOUB1uyJkndPOlx1eXb+zV3N4D0q2ep4nHxuhKiaT+BiiimqOvXBb+eBzr5WPD2z/bomz5eyrG29Su3ayLYF7cBZo4MgSS8U9G7AJdCWcaboXqbL3WghQvHNYTrTCxRvaN7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706051121; c=relaxed/simple;
	bh=cLrGrbY6uV0ei8zOEGo18FtgiZ5MqiDjUB06AAHyR3w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Es+CblKOqF/LYIKLxJnFmsJXTENO9BaTOqKA8Yg0gC7yplWj7pMy8xwH36VkN2ZnS8N/oGkpCajscb0kZC8LycpcSaIYJgxHD2/jV1w8BjhdZP9+bHuz2QldQTnAI+3wPyrnsH+/O0Lrt0gDj+I4VwFoThxJ+PIUzBLQxO2PzUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=vH7Lla7v; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706051108;
	bh=HNFyw6oJLgUp6IbWrIIGpsmsfbcCq2FixbzA2mxEIOY=;
	h=Date:From:To:Cc:Subject:From;
	b=vH7Lla7vUtxH7y6GsBak7pUxSj0AW0py9ULNlPmgWYfvyvQ0Xnh89m1xPmZztw4jR
	 3YLp1lVxQQvEGbt19VLsTjRobuvP+s63vJ5R/xO5UJgmNrrR9E1Lhf593hXtVBdTJb
	 5j/GqY56dWVxzHiQzn5B7UGDKMQ2uNgnhF6oLlOqpC74qSYU83IBLlGzOkh5ExTRgk
	 V0SrJIt5BMqXdLV6MyUdr0g8qzO7p8Fm9/HIGwc1uaG6H42P6ah5rPCgZO5e2EZ5oh
	 97ZnLYFIthNOkKCsvfxQtEYhAFn3xJxeG76M+mmG4KvvuZ++Q+hjSeuXoA+b1a5e05
	 cK52RXqVjN2/g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TKN3832Ynz4wbp;
	Wed, 24 Jan 2024 10:05:08 +1100 (AEDT)
Date: Wed, 24 Jan 2024 10:05:06 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20240124100506.67f0df5f@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/AhJKXlXOWKXq6qP/K3eIOQX";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/AhJKXlXOWKXq6qP/K3eIOQX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

fs/proc/task_mmu.c: In function 'get_vma_snapshow':
fs/proc/task_mmu.c:145:19: error: 'struct vm_area_struct' has no member nam=
ed 'anon_name'; did you mean 'anon_vma'?
  145 |         if (copy->anon_name && !anon_vma_name_get_rcu(copy))
      |                   ^~~~~~~~~
      |                   anon_vma
fs/proc/task_mmu.c:161:19: error: 'struct vm_area_struct' has no member nam=
ed 'anon_name'; did you mean 'anon_vma'?
  161 |         if (copy->anon_name)
      |                   ^~~~~~~~~
      |                   anon_vma
fs/proc/task_mmu.c:162:41: error: 'struct vm_area_struct' has no member nam=
ed 'anon_name'; did you mean 'anon_vma'?
  162 |                 anon_vma_name_put(copy->anon_name);
      |                                         ^~~~~~~~~
      |                                         anon_vma
fs/proc/task_mmu.c: In function 'put_vma_snapshot':
fs/proc/task_mmu.c:174:18: error: 'struct vm_area_struct' has no member nam=
ed 'anon_name'; did you mean 'anon_vma'?
  174 |         if (vma->anon_name)
      |                  ^~~~~~~~~
      |                  anon_vma
fs/proc/task_mmu.c:175:40: error: 'struct vm_area_struct' has no member nam=
ed 'anon_name'; did you mean 'anon_vma'?
  175 |                 anon_vma_name_put(vma->anon_name);
      |                                        ^~~~~~~~~
      |                                        anon_vma

Caused by commit

  786cebbd51a4 ("mm/maps: read proc/pid/maps under RCU")

from the mm-unstable branch.

This build does not have CONFIG_ANON_VMA_NAME set.

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/AhJKXlXOWKXq6qP/K3eIOQX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWwRiIACgkQAVBC80lX
0Gzb7Af9EHsvuGa7WYVxJEP6AawzUeNjezkKjf4whJr+t2fpG93ztYsZrSLxT2aH
ejrn4p1pVier+ziLB/K9r5AwSv3hZpr9FWSVlx+MC5vCIc7BOGM2GqmcG6Y0snWD
F57xS54FcXea6GkGJaHnPDS1cV/4lqNZwMfFQ7ifuxSU25FytylsM9yDFDiVLGa0
1p2LfXadQj5KYL1Vb0I5vNuvJSf1wGPJ9VwWibXOTBhA/Wwj6A7O2rqLh2LRiu3q
kapW4Hqw39FgiWqWlf++m8q1fAVcT6zxq+iLmoKQGKPpN7vKHajXmtU5PzplkZ74
YypR3eYvtQgP4SVfo+NCwZ2+HpT1zg==
=Mcnf
-----END PGP SIGNATURE-----

--Sig_/AhJKXlXOWKXq6qP/K3eIOQX--

