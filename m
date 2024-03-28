Return-Path: <linux-kernel+bounces-122401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4876988F66E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 05:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAE741F2264B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 04:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEB83F9DE;
	Thu, 28 Mar 2024 04:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BX0ELZ03"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81FA3DB8C;
	Thu, 28 Mar 2024 04:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711600461; cv=none; b=YT3oiwRDf3GZkfEssr69g6oSZYULeH0+fmkrBJ8MCqQXKhpc2u5MPtFjqztVfA115BdTdurPISSv6t4w2fljo0+mpfefHeATTgvu0lMS2y/Hk5HhCJ1Jd3Z4JmUMxkm+TkdIqsXn5z3eCyJD4rgFNyD99zRazd1qIaD6wj4qp6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711600461; c=relaxed/simple;
	bh=NmFgsJpAx7yxb+C9g+fbVwUXAcnrOTlBaGYG8d4WMFE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Wvu1hDqUHN9JPQNcGTE2K/rvNvnrIsZAhgWqeDmnny/e70cqR/UTdA7h2uGCGxcY1/cbHI44a1CElBvy6Bkft2GBBOD3RX51nhgg+9Kk9D+9cIObyaVRI8e0XzBSRNoSCdSfYd4HH3z6BH+v1uGCEdYvLNzc0ziY+QqvYxGYxyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=BX0ELZ03; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1711600456;
	bh=2taK/eJb1jrVdnCdJ8E7At+edEsv4o1BCqfe1S1KcPY=;
	h=Date:From:To:Cc:Subject:From;
	b=BX0ELZ03JQyx0OMme7NazsPQcrRCg65A5xdx2KetBjFsgDAOmYh+ssScPZlbqYi2/
	 AiZQ0Kw+5rqI74kGHpti3DOiYjANNw+4y4hHYGcOA7hjk989DgRRX0KJpB/ZJYc6Ip
	 Dn9RC4dnR3YrFBubQozTyyN3JIWyfqMX6F7xwumpp3U0N53zto+7nQrt61GGLYtYXx
	 iLgOUxAhkvwj3aftI1mDltGtChKIOyjiZIfTDZZ6jA56K5vRIfoXDL/6i5b2ocT6mc
	 wnVQ9JrXd0hQCgOLJtMB80Asl2pEI4CZ6Qkq/3qnhDDGAaKb0rlzZVDaN20QPMHXuJ
	 qFFNYPOo/Jh1g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V4rKL6Bqwz4wc3;
	Thu, 28 Mar 2024 15:34:14 +1100 (AEDT)
Date: Thu, 28 Mar 2024 15:34:14 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20240328153414.326f6774@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_3P3CFaQ+hu8Lc2rdpxu7hf";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/_3P3CFaQ+hu8Lc2rdpxu7hf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (arm64 defconfig)
failed like this:

In file included from include/linux/hugetlb.h:828,
                 from fs/proc/task_mmu.c:4:
arch/arm64/include/asm/hugetlb.h:25:34: error: redefinition of 'arch_clear_=
hugetlb_flags'
   25 | #define arch_clear_hugetlb_flags arch_clear_hugetlb_flags
      |                                  ^~~~~~~~~~~~~~~~~~~~~~~~
include/linux/hugetlb.h:840:20: note: in expansion of macro 'arch_clear_hug=
etlb_flags'
  840 | static inline void arch_clear_hugetlb_flags(struct folio *folio) { }
      |                    ^~~~~~~~~~~~~~~~~~~~~~~~
arch/arm64/include/asm/hugetlb.h:21:20: note: previous definition of 'arch_=
clear_hugetlb_flags' with type 'void(struct folio *)'
   21 | static inline void arch_clear_hugetlb_flags(struct folio *folio)
      |                    ^~~~~~~~~~~~~~~~~~~~~~~~

Caused by commit

  34ffd5e56690 ("mm: convert arch_clear_hugepage_flags to take a folio")

from the mm-unstable branch of the mm tree.

I applied the following patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 28 Mar 2024 15:24:47 +1100
Subject: [PATCH] fix up for "mm: convert arch_clear_hugepage_flags to take =
a folio"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/hugetlb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index cc420c42a773..03fc6d625068 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -836,7 +836,7 @@ static inline int is_hugepage_only_range(struct mm_stru=
ct *mm,
 #define is_hugepage_only_range is_hugepage_only_range
 #endif
=20
-#ifndef arch_clear_hugepage_flags
+#ifndef arch_clear_hugetlb_flags
 static inline void arch_clear_hugetlb_flags(struct folio *folio) { }
 #define arch_clear_hugetlb_flags arch_clear_hugetlb_flags
 #endif
--=20
2.43.0

--=20
Cheers,
Stephen Rothwell

--Sig_/_3P3CFaQ+hu8Lc2rdpxu7hf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYE80YACgkQAVBC80lX
0Gwr8Qf/Tw+h/Npou93MVXy2Tkj5AhW/qhAeMtX3rtJmbFqLr29eI2f8jIiFfIe7
KZ853lQ/ar6qO3nGFzd+jISznk+QHoc1JC7ZvOxktBmoiu6Zcq8xRAyPtiA/M8xk
Jb2FUB2muBRLysO8Lp0/ZQDMy3x6H78147uinLk/nI4zwz/H/W6WPjRd/t/q+39f
eo4p9tk/MPH5lz/sQM+n7o2NaHde8xHnQhe9FyIs+tUCGD8Vyi4RMAbed8/0kRWB
Xt89cIoY0YckYPUK0ukUPFbaE2JG/wtmPTejeerPq5LIaMyNgK2YA7qbHXNtWuNV
rBq0hCBWfG1wQfbypViumQlUrl/d4w==
=F8T9
-----END PGP SIGNATURE-----

--Sig_/_3P3CFaQ+hu8Lc2rdpxu7hf--

