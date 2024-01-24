Return-Path: <linux-kernel+bounces-36415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CC783A063
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAA2E28F2D8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A903C8D2;
	Wed, 24 Jan 2024 04:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="V5URN7vj"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B4FC2C2;
	Wed, 24 Jan 2024 04:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706069872; cv=none; b=dJ/6HnjDBKqKQ0Sdem/kmFb+BaXASr9FHfo85QXiIc7L/tSWG51/XUSoEemlJdISmWPtpMR+YILMOCvdXSaEmDZivPh6E3EtF0MeY/a7AMftdDeWAXz3EJjwCVNRoCabGOl7dz2Ni0tVABAXykVB8vU9KrusScCbfmtHlFfcZEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706069872; c=relaxed/simple;
	bh=h1Zx9chmo75LnPQIiqh4H3IlVg4HiDd8PoSigJuM1Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=aJsd74kf8ESneIWDxNUxz+jnIVLw5n5g7Patqr1ACEdReM2NPwZN9kQ4SeLRdHCruS4I3uranVveNvmiJS++v5NzhtKNRfOxo62MpYVbrb3l/UzUnkj18jXs0TG3TonqcMn+FfRZPzvMWEB5x3G3ujEWfHDbknoZVBeNVcWlBx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=V5URN7vj; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706069866;
	bh=nbuBPatZNQLu7DeaKD2YdARqRK58myRlIcfcJb36wbo=;
	h=Date:From:To:Cc:Subject:From;
	b=V5URN7vjBglSUV0CHi/Y2b22jfCFsJYvFRIMFSjjSOrTOa2qh6GaBb+2V7CmqRy2s
	 5S1fq4VE6mwxm7XisRtCcccGjEyKWPS8OqYgotB09+GwG/4Q2N0eX4TLQ4G/J4Drxx
	 Bs32tD2zgVOk6UkOqZSzJWVzGvwRmMEC9waKrgAu1ktXhykpv25SfSQx1X7xlz7ywR
	 NwyS1UuIsLsAZy46FPEmGKx6JSFn6u4YAkWn7GOommh6RWVxfanedC4FIx23nbVx+h
	 IRt/bVBOslrNx+2S+JCqGyyJKx4xRGXWM4fdknLNOewDHqpPaGEo0fKQw8EUG21fto
	 acrsu//OLo7zg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TKVzt14LQz4wbv;
	Wed, 24 Jan 2024 15:17:46 +1100 (AEDT)
Date: Wed, 24 Jan 2024 15:17:43 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Jiri Wiesner <jwiesner@suse.de>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the rcu tree
Message-ID: <20240124151743.052082af@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vF0TX9T9zLF40hSlS2GvDCt";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/vF0TX9T9zLF40hSlS2GvDCt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the rcu tree, today's linux-next build (i386 defconfig)
failed like this:

In file included from include/linux/dev_printk.h:14,
                 from include/linux/device.h:15,
                 from kernel/time/clocksource.c:10:
kernel/time/clocksource.c: In function 'clocksource_watchdog':
kernel/time/clocksource.c:103:34: error: integer overflow in expression of =
type 'long int' results in '-1619276800' [-Werror=3Doverflow]
  103 |                                  * NSEC_PER_SEC / HZ)
      |                                  ^
include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
   77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
      |                                             ^
kernel/time/clocksource.c:486:41: note: in expansion of macro 'WATCHDOG_INT=
R_MAX_NS'
  486 |                 if (unlikely(interval > WATCHDOG_INTR_MAX_NS)) {
      |                                         ^~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Caused by commit

  1a4545025600 ("clocksource: Skip watchdog check for large watchdog interv=
als")

I have used the rcu tree from next-20240123 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/vF0TX9T9zLF40hSlS2GvDCt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWwj2cACgkQAVBC80lX
0Gwj7Af8C8lVG4i8wkjmvpOcDrYUOAXw+d31wrLqK3aBuA5TLEY9iFz4q+heDIDS
9kQCeJJ33n+K6pEXVIbPoobZCYYbtccWr+1wg+juS8//t35dKuNjpTDLS0YKOid3
F2EFRQ9O6oC2Z7o6NqqWyGiQyTVWuW9g0roiqI0wAyAmzAhoVZwKd/Qx7JLuudv5
Gb1dsJaDEDE7edaApooI2SGnAnMAXAMbVH2JYmVXlA6PpFuH6TpaG1se+xy5pCwK
O7n9hYgILu3FVqOS8B0osB7vp+q6fZYZCOR25hvDUpuxfhuomAEDHLcVK5eevGrZ
fky3d+6Cn2C//XDZryfaQ9vwafMZVw==
=vID9
-----END PGP SIGNATURE-----

--Sig_/vF0TX9T9zLF40hSlS2GvDCt--

