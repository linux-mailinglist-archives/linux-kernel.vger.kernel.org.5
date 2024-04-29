Return-Path: <linux-kernel+bounces-163079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9BE8B64C3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14244B20CC9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB7C18410E;
	Mon, 29 Apr 2024 21:45:01 +0000 (UTC)
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [95.217.213.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332131836E9;
	Mon, 29 Apr 2024 21:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.217.213.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714427100; cv=none; b=J8neQFC3sKH5m7kVDylai5LbBBDJmvje4JjNNPlpoXnA7gNViE6MXilwhISESnlJ+1yWHcroxxX0/ATw59OLafVO/TE+PvxO+SOdhA4dh2Fv0USkSIGMkzHQtVmB9hMlrh4cbDJ4V0aGqsps2rEVaCUUjyecM2ZlTEColb9/rq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714427100; c=relaxed/simple;
	bh=RoWHTWHhsord5pYxLYxgW7KTMxod+abyWlHDgLf0u/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dc4sxLswWmpeUBUGlSRre1UYUgDSfGTKs5fdnEkIS4cV8Hl28+yKWAir94o3HJpHkUr4WimZGkh2oE+YXqUycYJaph4AlOhaBY3VYqPs5X3cT/o9Usb8byYSO35spql5/FoyB6HnmD5oJsv3suy23/kHHGtLTl7dwJCyfV0hqA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=95.217.213.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from 213.219.156.63.adsl.dyn.edpnet.net ([213.219.156.63] helo=deadeye)
	by maynard with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ben@decadent.org.uk>)
	id 1s1Ynq-00069t-QU; Mon, 29 Apr 2024 23:44:50 +0200
Received: from ben by deadeye with local (Exim 4.97)
	(envelope-from <ben@decadent.org.uk>)
	id 1s1Ynq-00000001wOL-0yVl;
	Mon, 29 Apr 2024 23:44:50 +0200
Date: Mon, 29 Apr 2024 23:44:50 +0200
From: Ben Hutchings <ben@decadent.org.uk>
To: Greg KH <gregkh@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de
Subject: [PATCH 4.19] Revert "y2038: rusage: use __kernel_old_timeval"
Message-ID: <ZjAU0hFgBDotATCy@decadent.org.uk>
References: <2024041118-slingshot-contented-1586@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Nn+ogYiDFdDnSeEP"
Content-Disposition: inline
In-Reply-To: <2024041118-slingshot-contented-1586@gregkh>
X-SA-Exim-Connect-IP: 213.219.156.63
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--Nn+ogYiDFdDnSeEP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This reverts commit d5e38d6b84d6d21a4f8a4f555a0908b6d9ffe224, which
was commit bdd565f817a74b9e30edec108f7cb1dbc762b8a6 upstream.  It
broke the build for alpha and that can't be fixed without backporting
other more intrusive y2038 changes.

This was not a completely clean revert as the affected code in
getrusage() was moved by subsequent changes.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/alpha/kernel/osf_sys.c   | 2 +-
 include/uapi/linux/resource.h | 4 ++--
 kernel/sys.c                  | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index d5694f263dd6..cff52d8ffdb1 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -964,7 +964,7 @@ put_tv32(struct timeval32 __user *o, struct timespec64 =
*i)
 }
=20
 static inline long
-put_tv_to_tv32(struct timeval32 __user *o, struct __kernel_old_timeval *i)
+put_tv_to_tv32(struct timeval32 __user *o, struct timeval *i)
 {
 	return copy_to_user(o, &(struct timeval32){
 				.tv_sec =3D i->tv_sec,
diff --git a/include/uapi/linux/resource.h b/include/uapi/linux/resource.h
index 74ef57b38f9f..cc00fd079631 100644
--- a/include/uapi/linux/resource.h
+++ b/include/uapi/linux/resource.h
@@ -22,8 +22,8 @@
 #define	RUSAGE_THREAD	1		/* only the calling thread */
=20
 struct	rusage {
-	struct __kernel_old_timeval ru_utime;	/* user time used */
-	struct __kernel_old_timeval ru_stime;	/* system time used */
+	struct timeval ru_utime;	/* user time used */
+	struct timeval ru_stime;	/* system time used */
 	__kernel_long_t	ru_maxrss;	/* maximum resident set size */
 	__kernel_long_t	ru_ixrss;	/* integral shared memory size */
 	__kernel_long_t	ru_idrss;	/* integral unshared data size */
diff --git a/kernel/sys.c b/kernel/sys.c
index 62930aac0bad..690ab55449e7 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1795,8 +1795,8 @@ void getrusage(struct task_struct *p, int who, struct=
 rusage *r)
=20
 out_children:
 	r->ru_maxrss =3D maxrss * (PAGE_SIZE / 1024); /* convert pages to KBs */
-	r->ru_utime =3D ns_to_kernel_old_timeval(utime);
-	r->ru_stime =3D ns_to_kernel_old_timeval(stime);
+	r->ru_utime =3D ns_to_timeval(utime);
+	r->ru_stime =3D ns_to_timeval(stime);
 }
=20
 SYSCALL_DEFINE2(getrusage, int, who, struct rusage __user *, ru)

--Nn+ogYiDFdDnSeEP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmYwFMcACgkQ57/I7JWG
EQnF5Q//VBXRzWWcHeyNlMbFndboUCUpjtohfoY5iVPhbs1ESOxb6yl8JJekeR2n
LQyhcftbM4k8ZOG2dlb363TKh6i3pQBKNxrKoT9zcLEcSvjtVWwtF5n2ypJ1S4Dp
saKTGM8YDWcnKKid8PJfH+A0uvvii+JSQlX/CzUIbpq+MGvwyjg0qBVHUvvr38MU
cwzYMubOCWiULZpOYp46L2tLZzDXp0fB/bCnVqj69Za31mDcrWVQ4w+LjzVO/Bx5
nLzPDLvto7bp74ddB8MAB6xHyqAuwj7keZjMQ5bASKdIW9GEnWPgDAb5YjRPfi1w
lOTNOhFq4MIjai6uvolWrhINRTDerdMrD4TuPdocx69+/0FKXHcmfN9gIgD/UiEz
OV2A421j6HaAM9CZ+yJ3NHFz2D7RixFgTn/iMx7S3nPILaV4bCjgfUaR3B3mc9BV
EKVmSWmm1ivqZ+WQdTID/75OrPkdYwMO1cBjosTEW6jdTmcfZs5St46a+Xc1e3Km
ozjyLrs/KtZ/qhcCjHIsHu39LYXVtz8bVCmKUdTe6LMPTowlZYLmuhExgb/q+RJC
pHPTOTxyP3+pMFVJDqnAImyJr6e7Ekl+C3UironQO7XCMcUCLjgCMT+B0ik/ChGq
QQXT26fUkdpTwy4Yy5T0zsuRMDGsrolYrw7xenF/fprMgVizGSo=
=UsXv
-----END PGP SIGNATURE-----

--Nn+ogYiDFdDnSeEP--

