Return-Path: <linux-kernel+bounces-130834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AD3897DB0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 04:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 420B41F270E3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1796C1BC2F;
	Thu,  4 Apr 2024 02:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jeawC86v"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622EC1758F;
	Thu,  4 Apr 2024 02:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712197506; cv=none; b=BYId62GpqFzjrmrv/1/Moc7/5AXueyAaZUrveKmiiSget+allJ7JtYcqa7zZFraUikvcbO76qTs/EcqMk6hFMRCovpRf0sVUGqLBUB+9aXbKm03D2HCNWKWxZYcDnUis+qhpIpaJcDhI1c46MNBusHJV1O8EXV5ciELO+T5q0go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712197506; c=relaxed/simple;
	bh=CCXn41sCFZXqZdd1kZnbI/L4Or0QZMMjVD7ekxCR1Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=tE0+Y2opft2kI8cA9VOQGuGhuSvlkNkyhVklEZuekob9+fepunwgQ5RJgQRfb6H6Xof5gK6LfvPCZZPk6cHXW9oCsgK4BqIuUpeuvO5CF9jtgcqmlbjd6OfEXOP6xhXGH9Wm5KaW8eY7L4n1dBK3Lj1Zhy11WwYE/xSHguNa0GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=jeawC86v; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712197501;
	bh=HGuA1BiYJkBKg11SWiSbzXr+IOm4HuT0pPHhPq3qQYA=;
	h=Date:From:To:Cc:Subject:From;
	b=jeawC86vztEjSuIA9/bapTUvkGbwhEYC3IhA2XON4lvcFlP/a7HYyoDwOxy9xgesB
	 55W+gj2ddippVra7LudrKC/NQChgIkouynigaaNfTtx6IPUx2faV2z2LpXKpKgvfpi
	 NUOFD1H0JnCiFt/oMxML5Q4J5koMwlNgEQYBXKzOBlonNxkJZfQ7j2WCAEOt50sMmo
	 896FegEyTEKlBz/Pf4Bp5iYxNP0lvZX+GCaGWnZaCzW6j4D86clL2gg5sB+T56daR5
	 SIFrz6Tahh4OOspIargsxTj7/g/Px9FI7jeL32iKpGFYqIXTJYuX852HQwhMcAy74S
	 MyBmcMQIV47qA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V95712BLsz4wc3;
	Thu,  4 Apr 2024 13:25:01 +1100 (AEDT)
Date: Thu, 4 Apr 2024 13:24:56 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Brauner <brauner@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the vfs-brauner tree
Message-ID: <20240404132456.579b8ae9@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2ACvVmjSFWwr11OvUGXS5KD";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/2ACvVmjSFWwr11OvUGXS5KD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the vfs-brauner tree, today's linux-next build (i386
defconfig) failed like this:

In file included from include/linux/kernel.h:31,
                 from include/linux/uio.h:8,
                 from fs/netfs/direct_write.c:9:
fs/netfs/direct_write.c: In function 'netfs_unbuffered_write_iter_locked':
fs/netfs/internal.h:399:36: error: format '%lx' expects argument of type 'l=
ong unsigned int', but argument 3 has type 'size_t' {aka 'unsigned int'} [-=
Werror=3Dformat=3D]
  399 | #define _enter(FMT, ...) no_printk("=3D=3D> %s("FMT")", __func__, #=
#__VA_ARGS__)
      |                                    ^~~~~~~~~
include/linux/printk.h:129:25: note: in definition of macro 'no_printk'
  129 |                 _printk(fmt, ##__VA_ARGS__);            \
      |                         ^~~
fs/netfs/direct_write.c:40:9: note: in expansion of macro '_enter'
   40 |         _enter("%lx", iov_iter_count(iter));
      |         ^~~~~~
cc1: all warnings being treated as errors
In file included from include/linux/kernel.h:31,
                 from include/linux/cpumask.h:11,
                 from arch/x86/include/asm/cpumask.h:5,
                 from arch/x86/include/asm/msr.h:11,
                 from arch/x86/include/asm/tsc.h:10,
                 from arch/x86/include/asm/timex.h:6,
                 from include/linux/timex.h:67,
                 from include/linux/time32.h:13,
                 from include/linux/time.h:60,
                 from include/linux/stat.h:19,
                 from include/linux/module.h:13,
                 from net/9p/client.c:11:
net/9p/client.c: In function 'p9_client_write_subreq':
include/linux/kern_levels.h:5:25: error: format '%lu' expects argument of t=
ype 'long unsigned int', but argument 3 has type 'size_t' {aka 'unsigned in=
t'} [-Werror=3Dformat=3D]
    5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
      |                         ^~~~~~
include/linux/printk.h:429:25: note: in definition of macro 'printk_index_w=
rap'
  429 |                 _p_func(_fmt, ##__VA_ARGS__);                      =
     \
      |                         ^~~~
include/linux/printk.h:500:9: note: in expansion of macro 'printk'
  500 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
      |         ^~~~~~
include/linux/kern_levels.h:11:25: note: in expansion of macro 'KERN_SOH'
   11 | #define KERN_ERR        KERN_SOH "3"    /* error conditions */
      |                         ^~~~~~~~
include/linux/printk.h:500:16: note: in expansion of macro 'KERN_ERR'
  500 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
      |                ^~~~~~~~
net/9p/client.c:1702:17: note: in expansion of macro 'pr_err'
 1702 |                 pr_err("bogus RWRITE count (%d > %lu)\n", written, =
len);
      |                 ^~~~~~
cc1: all warnings being treated as errors

Caused by commits

  1351be4f832e ("netfs, 9p: Implement helpers for new write code")
  671136799613 ("netfs: Remove the old writeback code")

I have applied the following patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 4 Apr 2024 13:17:42 +1100
Subject: [PATCH] fixup for "netfs, 9p: Implement helpers for new write code"

and "netfs: Remove the old writeback code"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/netfs/direct_write.c | 2 +-
 net/9p/client.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index e4a9cf7cd234..a2f9a4917ab6 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -37,7 +37,7 @@ static ssize_t netfs_unbuffered_write_iter_locked(struct =
kiocb *iocb, struct iov
 	size_t len =3D iov_iter_count(iter);
 	bool async =3D !is_sync_kiocb(iocb);
=20
-	_enter("%lx", iov_iter_count(iter));
+	_enter("%zx", iov_iter_count(iter));
=20
 	/* We're going to need a bounce buffer if what we transmit is going to
 	 * be different in some way to the source buffer, e.g. because it gets
diff --git a/net/9p/client.c b/net/9p/client.c
index dada0033d71e..d4b88b7ff5ef 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -1699,7 +1699,7 @@ p9_client_write_subreq(struct netfs_io_subrequest *su=
breq)
 	}
=20
 	if (written > len) {
-		pr_err("bogus RWRITE count (%d > %lu)\n", written, len);
+		pr_err("bogus RWRITE count (%d > %zu)\n", written, len);
 		written =3D len;
 	}
=20
--=20
2.43.0

--=20
Cheers,
Stephen Rothwell

--Sig_/2ACvVmjSFWwr11OvUGXS5KD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYOD3gACgkQAVBC80lX
0GzA/Qf9H67JOiDX3jTjmUcBgK2EPg//RxggiIMs7b/fKh88YW2en2bg/YrmTQIb
jKdX4GAgtlhD/WtYSP4EjCtnYYmhuDW/vbJy1V5s+3tJ0Z0JLMin2jKGUjL1iDwR
s1UkICbRDZLqt3hA2nKliVJkQPpvS+E3BL2WFazGwnWh8c4+RB7XXpBYjvzjRqzQ
VzAWr7xXdafYA8vKAdsI5GNiU7gFiBIBX4c2lxJreFu6T8lz23s39VFdgBXo5op3
WbNMg237REaa81w+DtQIz9rBFonz3Y4xLIfX2/IbD2KwAgwcagLp1Cn947rrA2Yh
3BGNkA0VxSDHrx7QIVG28i43YQ+kOQ==
=Jzd7
-----END PGP SIGNATURE-----

--Sig_/2ACvVmjSFWwr11OvUGXS5KD--

