Return-Path: <linux-kernel+bounces-91653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 379E88714B4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 05:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AED5B1F226C5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556883FB32;
	Tue,  5 Mar 2024 04:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="g/U0eumi"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CA52940D;
	Tue,  5 Mar 2024 04:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709612802; cv=none; b=ouih7xU73pnf9GBd4AM77f13UnWWobMUtRb6L1F2eS67MFEESFzoC/hDjOdoXUExx0lYGGPvUAA2+oOh7lPawtsWHry0bmOXy/arfSJFhQxtWC8HRnMjlUKIH5tK89MjpGrZcwJEg9PKeVA7B3w/hIBzrP8EsgbnGsd1IBolfnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709612802; c=relaxed/simple;
	bh=N9u8SHVw55L7uBQnxShMclZqCtnvf65Mu/kXFlP3mtw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=pR9KHGgYa3M20Hz7+bhWFQDpCFD/tc/sW5jqQ/MBt6QoXeOtBkhHzBmTZCERJucoeGWTVgH8/APsX0wMzHrZb38umd45cq23JHTOodcfLDCgvA8RxMFdm8Ta4gHgC6vOg0XEuzQlLoZTb9Bdcw8THnRMY/buAsZ4cdNyX8wrYmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=g/U0eumi; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709612795;
	bh=UShGOdlC0yH2lVkxBd6+rii1RiQ+gqN2oJMUTKKrQ/o=;
	h=Date:From:To:Cc:Subject:From;
	b=g/U0eumii7+m1tvWz/S2Vy6tkvNa6Cao5sHJ8TvcFl0tHsX1nBTlpuZmsoHnwyxDQ
	 mfmt+YBi5V37TXAS97bfvBRvrmdKJCrX0LJ81RnVQtrcI9bA7q2dKxb5lbDlDJrzDI
	 7njBFq640xNs5wyytRPOsWoMMkZGFpNk5GfFQcwrMpthJfGToGgj7liTfDalkMItnj
	 Y3Nu5c8H+hlIvRrCGCOeA9M6ksicEjkXaJTZC264Q4bEaoERJ0DKHK+Dp+pES8xdp0
	 tRDh3pmjGDKnX0/NPMoxWUzCGQMpYgCQRF7Hj/m/riqgmSXpj/ZDaod3HmWAXcWXNi
	 bzrTtl+fgRZUQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TpjF66pbCz4wcF;
	Tue,  5 Mar 2024 15:26:34 +1100 (AEDT)
Date: Tue, 5 Mar 2024 15:26:34 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20240305152634.014058aa@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.4=IcelQfVYeu9k8d+ZvOta";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/.4=IcelQfVYeu9k8d+ZvOta
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (s390 defconfig)
failed like this:

In file included from include/linux/smp.h:12,
                 from include/linux/lockdep.h:14,
                 from include/linux/spinlock.h:63,
                 from include/linux/mmzone.h:8,
                 from include/linux/gfp.h:7,
                 from include/linux/mm.h:7,
                 from include/linux/pagewalk.h:5,
                 from arch/s390/mm/gmap.c:12:
arch/s390/mm/gmap.c: In function 'gmap_free':
include/linux/list.h:866:19: error: assignment to 'struct page *' from inco=
mpatible pointer type 'struct ptdesc *' [-Werror=3Dincompatible-pointer-typ=
es]
  866 |                 n =3D list_next_entry(pos, member);                =
       \
      |                   ^
arch/s390/mm/gmap.c:212:17: note: in expansion of macro 'list_for_each_entr=
y_safe'
  212 |                 list_for_each_entry_safe(ptdesc, next, &gmap->pt_li=
st, pt_list)
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~
include/linux/list.h:868:18: error: assignment to 'struct ptdesc *' from in=
compatible pointer type 'struct page *' [-Werror=3Dincompatible-pointer-typ=
es]
  868 |              pos =3D n, n =3D list_next_entry(n, member))
      |                  ^
arch/s390/mm/gmap.c:212:17: note: in expansion of macro 'list_for_each_entr=
y_safe'
  212 |                 list_for_each_entry_safe(ptdesc, next, &gmap->pt_li=
st, pt_list)
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~
In file included from include/linux/kernel.h:22,
                 from arch/s390/mm/gmap.c:11:
arch/s390/mm/gmap.c:212:72: error: 'struct page' has no member named 'pt_li=
st'; did you mean 'pcp_list'?
  212 |                 list_for_each_entry_safe(ptdesc, next, &gmap->pt_li=
st, pt_list)
      |                                                                    =
    ^~~~~~~
include/linux/container_of.h:19:33: note: in definition of macro 'container=
_of'
   19 |         void *__mptr =3D (void *)(ptr);                            =
       \
      |                                 ^~~
include/linux/list.h:645:9: note: in expansion of macro 'list_entry'
  645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
      |         ^~~~~~~~~~
include/linux/list.h:868:27: note: in expansion of macro 'list_next_entry'
  868 |              pos =3D n, n =3D list_next_entry(n, member))
      |                           ^~~~~~~~~~~~~~~
arch/s390/mm/gmap.c:212:17: note: in expansion of macro 'list_for_each_entr=
y_safe'
  212 |                 list_for_each_entry_safe(ptdesc, next, &gmap->pt_li=
st, pt_list)
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~
In file included from include/linux/container_of.h:5:
arch/s390/mm/gmap.c:212:72: error: 'struct page' has no member named 'pt_li=
st'; did you mean 'pcp_list'?
  212 |                 list_for_each_entry_safe(ptdesc, next, &gmap->pt_li=
st, pt_list)
      |                                                                    =
    ^~~~~~~
include/linux/build_bug.h:78:56: note: in definition of macro '__static_ass=
ert'
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                                        ^~~~
include/linux/container_of.h:20:9: note: in expansion of macro 'static_asse=
rt'
   20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||  =
     \
      |         ^~~~~~~~~~~~~
include/linux/container_of.h:20:23: note: in expansion of macro '__same_typ=
e'
   20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||  =
     \
      |                       ^~~~~~~~~~~
include/linux/list.h:601:9: note: in expansion of macro 'container_of'
  601 |         container_of(ptr, type, member)
      |         ^~~~~~~~~~~~
include/linux/list.h:645:9: note: in expansion of macro 'list_entry'
  645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
      |         ^~~~~~~~~~
include/linux/list.h:868:27: note: in expansion of macro 'list_next_entry'
  868 |              pos =3D n, n =3D list_next_entry(n, member))
      |                           ^~~~~~~~~~~~~~~
arch/s390/mm/gmap.c:212:17: note: in expansion of macro 'list_for_each_entr=
y_safe'
  212 |                 list_for_each_entry_safe(ptdesc, next, &gmap->pt_li=
st, pt_list)
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~
arch/s390/mm/gmap.c:212:72: error: 'struct page' has no member named 'pt_li=
st'; did you mean 'pcp_list'?
  212 |                 list_for_each_entry_safe(ptdesc, next, &gmap->pt_li=
st, pt_list)
      |                                                                    =
    ^~~~~~~
include/linux/build_bug.h:78:56: note: in definition of macro '__static_ass=
ert'
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                                        ^~~~
include/linux/container_of.h:20:9: note: in expansion of macro 'static_asse=
rt'
   20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||  =
     \
      |         ^~~~~~~~~~~~~
include/linux/container_of.h:20:23: note: in expansion of macro '__same_typ=
e'
   20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||  =
     \
      |                       ^~~~~~~~~~~
include/linux/list.h:601:9: note: in expansion of macro 'container_of'
  601 |         container_of(ptr, type, member)
      |         ^~~~~~~~~~~~
include/linux/list.h:645:9: note: in expansion of macro 'list_entry'
  645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
      |         ^~~~~~~~~~
include/linux/list.h:868:27: note: in expansion of macro 'list_next_entry'
  868 |              pos =3D n, n =3D list_next_entry(n, member))
      |                           ^~~~~~~~~~~~~~~
arch/s390/mm/gmap.c:212:17: note: in expansion of macro 'list_for_each_entr=
y_safe'
  212 |                 list_for_each_entry_safe(ptdesc, next, &gmap->pt_li=
st, pt_list)
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~
arch/s390/mm/gmap.c:212:72: error: 'struct page' has no member named 'pt_li=
st'; did you mean 'pcp_list'?
  212 |                 list_for_each_entry_safe(ptdesc, next, &gmap->pt_li=
st, pt_list)
      |                                                                    =
    ^~~~~~~
include/linux/build_bug.h:78:56: note: in definition of macro '__static_ass=
ert'
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                                        ^~~~
include/linux/container_of.h:20:9: note: in expansion of macro 'static_asse=
rt'
   20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||  =
     \
      |         ^~~~~~~~~~~~~
include/linux/container_of.h:21:23: note: in expansion of macro '__same_typ=
e'
   21 |                       __same_type(*(ptr), void),                   =
     \
      |                       ^~~~~~~~~~~
include/linux/list.h:601:9: note: in expansion of macro 'container_of'
  601 |         container_of(ptr, type, member)
      |         ^~~~~~~~~~~~
include/linux/list.h:645:9: note: in expansion of macro 'list_entry'
  645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
      |         ^~~~~~~~~~
include/linux/list.h:868:27: note: in expansion of macro 'list_next_entry'
  868 |              pos =3D n, n =3D list_next_entry(n, member))
      |                           ^~~~~~~~~~~~~~~
arch/s390/mm/gmap.c:212:17: note: in expansion of macro 'list_for_each_entr=
y_safe'
  212 |                 list_for_each_entry_safe(ptdesc, next, &gmap->pt_li=
st, pt_list)
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~
include/linux/compiler_types.h:390:27: error: expression in static assertio=
n is not an integer
  390 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), t=
ypeof(b))
      |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:78:56: note: in definition of macro '__static_ass=
ert'
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                                        ^~~~
include/linux/container_of.h:20:9: note: in expansion of macro 'static_asse=
rt'
   20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||  =
     \
      |         ^~~~~~~~~~~~~
include/linux/container_of.h:20:23: note: in expansion of macro '__same_typ=
e'
   20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||  =
     \
      |                       ^~~~~~~~~~~
include/linux/list.h:601:9: note: in expansion of macro 'container_of'
  601 |         container_of(ptr, type, member)
      |         ^~~~~~~~~~~~
include/linux/list.h:645:9: note: in expansion of macro 'list_entry'
  645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
      |         ^~~~~~~~~~
include/linux/list.h:868:27: note: in expansion of macro 'list_next_entry'
  868 |              pos =3D n, n =3D list_next_entry(n, member))
      |                           ^~~~~~~~~~~~~~~
arch/s390/mm/gmap.c:212:17: note: in expansion of macro 'list_for_each_entr=
y_safe'
  212 |                 list_for_each_entry_safe(ptdesc, next, &gmap->pt_li=
st, pt_list)
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~
In file included from include/uapi/linux/posix_types.h:5,
                 from include/uapi/linux/types.h:14,
                 from include/linux/types.h:6,
                 from include/linux/kasan-checks.h:5,
                 from include/asm-generic/rwonce.h:26,
                 from arch/s390/include/asm/rwonce.h:29,
                 from include/linux/compiler.h:299,
                 from include/linux/array_size.h:5,
                 from include/linux/kernel.h:16:
arch/s390/mm/gmap.c:212:72: error: 'struct page' has no member named 'pt_li=
st'; did you mean 'pcp_list'?
  212 |                 list_for_each_entry_safe(ptdesc, next, &gmap->pt_li=
st, pt_list)
      |                                                                    =
    ^~~~~~~
include/linux/stddef.h:16:58: note: in definition of macro 'offsetof'
   16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
      |                                                          ^~~~~~
include/linux/list.h:601:9: note: in expansion of macro 'container_of'
  601 |         container_of(ptr, type, member)
      |         ^~~~~~~~~~~~
include/linux/list.h:645:9: note: in expansion of macro 'list_entry'
  645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
      |         ^~~~~~~~~~
include/linux/list.h:868:27: note: in expansion of macro 'list_next_entry'
  868 |              pos =3D n, n =3D list_next_entry(n, member))
      |                           ^~~~~~~~~~~~~~~
arch/s390/mm/gmap.c:212:17: note: in expansion of macro 'list_for_each_entr=
y_safe'
  212 |                 list_for_each_entry_safe(ptdesc, next, &gmap->pt_li=
st, pt_list)
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors

Caused by commit

  859584c3ddba ("s390: supplement for ptdesc conversion")

from the mm-unstable branch of the mm tree.

I have reverted that commit for today.
--=20
Cheers,
Stephen Rothwell

--Sig_/.4=IcelQfVYeu9k8d+ZvOta
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXmnvoACgkQAVBC80lX
0GyZYwf/ftCln71ecRZeT3axK+7vVkkW5IqGMvJwLalLizgeGNr47zChTxz0deT5
7MExnh4V94UcvLNuKOPisN0IIKxqexo1CtmpFSZxB01WORSrWR4T0nV9YOs0p2IB
VT5NzYwilI1K6hODzqXJKE1IJM+O+3EpPi2iq+/QuVn/urZmf01yu/fh7LaLsLy0
DmO1Jc332TAWAWUUrdJ9e0kDu3QP2pVCK7dKdEcnsibQGS7L3Y9fCe0Jq7NsEQmj
gwDjJWSfexDI5SAlwLVCRkq2lVY1MQreDeHRK3H3okSsxiKucMa7/TGxE+lheIPK
mQjW0mevXQYKGN/DydlPlEQoBRn82A==
=+1yw
-----END PGP SIGNATURE-----

--Sig_/.4=IcelQfVYeu9k8d+ZvOta--

