Return-Path: <linux-kernel+bounces-61028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1345B850C6C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 00:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC89128226E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 23:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC941756D;
	Sun, 11 Feb 2024 23:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Vx26p7eX"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5531755B;
	Sun, 11 Feb 2024 23:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707695701; cv=none; b=ZY0w4JMx4RZFTRpYRu+poW2tyugx8w/ybUvDY51Ac28VfsEGTDVavf8LlobMyN2vtTvqcwGDvdc3fp426u+QNON/dRJlUoSKenCbge6WjmqmmGYWJLURPry59ds6jOJv1brLzQZ/gbuDioMnO5gs62hlgzcWtMlxxdlL7UeNSMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707695701; c=relaxed/simple;
	bh=TGKmZ6VjU4vjoCEKe4rT9rXGa5QRictjL84CwzDtqMY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=jqMiqWhLPcSV/uR1dG6T30TCGSrhyR6H1fAQdPXPxPrc/3ovEloymSGg33nS2UO7+sDuTeXE7gnXVy3yj58RvbH7Ku6MYNwaaWKLb1eZsiyZL13yNsOJw4bX6Y13RwcJrOkbTbaXBc9MK7YGEIFxtQKsqCp+rEPHVIZ5QTNDMbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Vx26p7eX; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707695697;
	bh=xz+WlTQ3sspcuVyVHB+D9lW4mLZVRoNLwGnolwIAwZk=;
	h=Date:From:To:Cc:Subject:From;
	b=Vx26p7eXsNdDJgPGvLRQcRE9qtg0mUaqJUDQzNFZOnpWjS5fAvYSDya3joAueuD3V
	 ZCSpsohSQZJHRS394DTun08brVOf7ZgNUW5YfM3ryJzo3Xi3oZLYZkgnA9a7tPRO+r
	 95W8mgu8FzLpC6gCG68qrGfJCX6YFVQqZhr2IOckDHAA1FN3FchjyH8LVi9i+jDEX/
	 oyzajjdsW5V5Y3ebnVAkCMiteDm5SL/KDebtNz5Sc2GirjxwO3tG8FxFDL/nmy8ukR
	 ADtPi+5yewGkvLB5U8oYwSVWuT46jzPvFhF99D68n3UGNuOw6a+wa9NMSKTgmJddE3
	 Qdvf9h30TtUCw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TY4Fr6l8Tz4wcM;
	Mon, 12 Feb 2024 10:54:56 +1100 (AEDT)
Date: Mon, 12 Feb 2024 10:54:56 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the bcachefs tree
Message-ID: <20240212105456.65194f29@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xkRiBedOAwkrQi6CLDTZGW/";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/xkRiBedOAwkrQi6CLDTZGW/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bcachefs tree, today's linux-next build (x86_64
allmodconfig) failed like this:

ERROR: modpost: missing MODULE_LICENSE() in lib/thread_with_file.o
ERROR: modpost: "stdio_redirect_vprintf" [fs/bcachefs/bcachefs.ko] undefine=
d!
ERROR: modpost: "thread_with_file_exit" [fs/bcachefs/bcachefs.ko] undefined!
ERROR: modpost: "run_thread_with_stdio" [fs/bcachefs/bcachefs.ko] undefined!
ERROR: modpost: "__darray_resize_slowpath" [fs/bcachefs/bcachefs.ko] undefi=
ned!
ERROR: modpost: "stdio_redirect_readline" [fs/bcachefs/bcachefs.ko] undefin=
ed!
ERROR: modpost: "run_thread_with_file" [fs/bcachefs/bcachefs.ko] undefined!
ERROR: modpost: "__darray_resize_slowpath" [lib/thread_with_file.ko] undefi=
ned!

Caused by commit

  f894f9e5f0ad ("thread_with_file: Lift from bcachefs")

I have used the version of bcachefs from next-20240206 again.

--=20
Cheers,
Stephen Rothwell

--Sig_/xkRiBedOAwkrQi6CLDTZGW/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXJXlAACgkQAVBC80lX
0GyrcAgAgBEn7qZjc8zhqubPjYcuX5SmOacwtzJGFE1nHoqZKrvxbmaDhTtxmhHN
MaWdEbFyzzUJo8hPEpoGpu8MOVNiT2NOHqjN3xMjFxgRijMbgj3SHwOa5j55rkBy
bXnFkFWKB/P9H3ZT+N1py1JvXvUEEr5q0cJaK/38XprJCyAUztwNpx4JZvL3/7RP
vGxmQi9h0nm0GMMrCqD+Bmm7l0qQfAImjN9jMOM81L3VgzCt5Wg1ZRvDVISPb2fY
fjMvODzUSIB53Zd7nzYI3T8df5L+ZQV/JAKAWk1VvHRQ7Xeant1+xe8Tm3+Tiido
juDsyctbALi/edvT/R4v6KQHJv2Nkw==
=AIUo
-----END PGP SIGNATURE-----

--Sig_/xkRiBedOAwkrQi6CLDTZGW/--

