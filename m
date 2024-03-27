Return-Path: <linux-kernel+bounces-120205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8A388D470
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 542F1B21314
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7B6208A4;
	Wed, 27 Mar 2024 02:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SvdTlF3y"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20561F60A;
	Wed, 27 Mar 2024 02:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711505455; cv=none; b=o0q4NICrOlvRlbmpxYAoRJxzXWjhMfZi9pxpYLPA3vOOWAjy3wrMKbSkohXI67RMdEIW0O+6VN0wuDLm4GMlQCDqNWOnrgBbt3zdt0fC7qThvKOrF9TonRitMkp9gJYR+7TTFCXisdimCtX4cBK1/tUukGG+szwmIWW+9fQHtgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711505455; c=relaxed/simple;
	bh=yK1BWdP9fBBurO6TjZlMRJkzkDO6xJFUyXMX7xi/poM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=EHd3YirQwqcqW1TDirBEiSTrwGVDkLQH7w+DedBE+CpWxzBV4O3KRDk0pVUiOgryyBpM7kzQFcIvGHkqA1FBkkZoPd4qJ8L5GJGFL5F2er3TYEjLH6TCS9UnJc5hikISS0MWoel+tEE7mKAzJJQr5Y4ZqQhDLRs5VfhH7X53E1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=SvdTlF3y; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1711505447;
	bh=D8wBYTSFVO3Kwg+qqhaeqbpJi3hBXVAJOjaIUMpVxnc=;
	h=Date:From:To:Cc:Subject:From;
	b=SvdTlF3yDAAB6CE2oE+292GRCaCmeKWZG4AGd/RfPBPCWiE+DRFj/XaD6YhQii6TP
	 9Q/mp1M7vHvgq9b8EbNigqQC8o4t6QIlsZ4BFIoUDbdmb69IyINnz3VBaEMBe0CZjf
	 G+SoJsNdcY0h+9l9bDE4N+R8JrxogLeJci54WQgupg2AWdXAXoS4vlLtSHegq16RK9
	 OHcu4j5DbD81FjWvX9O0AUu3pl0n9/9Yhfch9hk9shDd0XnwOO6xPkNQFwi8s2icQD
	 eGFERvJMJ+AkbVP+dzck7amuJoqL0eJ815UCLdZWZhaeZp+PgGXchnwN+P1RKewOWe
	 UWYina0qtPoaQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V49BH44jLz4wc9;
	Wed, 27 Mar 2024 13:10:47 +1100 (AEDT)
Date: Wed, 27 Mar 2024 13:10:44 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Moore <paul@paul-moore.com>
Cc: Christian =?UTF-8?B?R8O2dHRzY2hl?= <cgzones@googlemail.com>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the selinux tree
Message-ID: <20240327131044.2c629921@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/T4I06AC_GtqUxmW6wUhGgUe";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/T4I06AC_GtqUxmW6wUhGgUe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the selinux tree, today's linux-next build (i386 defconfig)
failed like this:

In file included from include/linux/kernel.h:31,
                 from security/selinux/ss/ebitmap.c:16:
security/selinux/ss/ebitmap.c: In function 'ebitmap_read':
include/linux/kern_levels.h:5:25: error: format '%ld' expects argument of t=
ype 'long int', but argument 3 has type 'u32' {aka 'unsigned int'} [-Werror=
=3Dformat=3D]
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
security/selinux/ss/ebitmap.c:464:17: note: in expansion of macro 'pr_err'
  464 |                 pr_err("SELinux: ebitmap: high bit %d is not equal =
to the expected value %ld\n",
      |                 ^~~~~~
cc1: all warnings being treated as errors

Caused by commit

  0142c56682fb ("selinux: reject invalid ebitmaps")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/T4I06AC_GtqUxmW6wUhGgUe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYDgCQACgkQAVBC80lX
0Gyx4wf7B5dPGQPLJCl1RyR5kh+l9b034doZnlG/gW0IP0joJUnjhqvZmzob7/OX
AuTPqAvswvoioReqOFc96XyYLAJBWmpYDrT39q1iigSIYYuVxwYCAM+XO1bmPPoK
qnQNf1s5T6ES22zO5eyzFGTQ+ZC6NLK7HXk5dmct+hSwPp1h0kQANf0uP1V7N91X
rWtooI74UtJL1Yq5+B5TEVugnbM2bg6qA7ZNXgWFdt0I1RSXb4zuWUcCO8OLVEpv
26XgRSqa5X2GsAOQzDqwR9kMkdQ4vYrYZw3CW3CzQrwc2v8EimDghdAC8GAVKqlQ
bUlZQC+XH/OVG3aZ9GCdEI/TjFLwbA==
=JvsM
-----END PGP SIGNATURE-----

--Sig_/T4I06AC_GtqUxmW6wUhGgUe--

