Return-Path: <linux-kernel+bounces-146183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 645BB8A61C4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2B011F234C4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 03:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1291B5A4;
	Tue, 16 Apr 2024 03:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="oM8lswoP"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC0DF9F5;
	Tue, 16 Apr 2024 03:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713238981; cv=none; b=AWaSwdVxE+Sk+9jFMV/XUWcPoOp6CS7bEJVk8YA8L3WFsYmJj46/ZHtNG2A5GSqEnCQYgn5ZqwDi1CSdPff9HMCI8PpDpjGP/5ojlYPhzYlap0BlGpqCF++Lp/KdCrZKG4j7P+mz8mTGlcZ6iJsV16WzYAbS3Wf02No+Nd8Nt/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713238981; c=relaxed/simple;
	bh=pGB/ToxmHeXZKZ7+3L6PE4RIlGDMr4MqvmCLKgKCPvk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=LH0iIZhng+DzYhrCs0d2Q+/WiQTVLs04hDIbAvjoVQeaEQMkTmi7PPqu2xTSooisNltp8gPmjxf8q4u7dFTmETkty5JBFEDbBVonKGvM0oDjM44tmkLQ4nmsTdfV5eTtgKhrFnnKNB+XZEG7u9aD16+P760SZ8NohSx0r6hiNDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=oM8lswoP; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713238975;
	bh=XZIFUNdkFHjp9gcwlYgnSXKjSpVMeAGYqf4CZH22ktc=;
	h=Date:From:To:Cc:Subject:From;
	b=oM8lswoPt/QpAJiJiDcv3f2zwvXFk54C+ugwxvgpPHIjsUu/uSjxYTPBpgJlXe7ZJ
	 5jOQ/iL8hVVYzsOHUaabxNZ1EROpD14NfZrhxLCUDNK/9Wx264VEv83o19UUS7kvbL
	 kLp29yn1w6gw0cDozZGJ65oRoxeFSjvKeqyuxAbNa9jdwSpbkV/S+DNt2htD0Nrkuw
	 wrJSI/NeSdDchQDJdkBC/gnjkT8dey6dpcmNLJcZMZt1bi909roYfbNmOrq7aWOkZf
	 7wTpmMUod1XObNMpfBKWR5b4EdTwCYdGpTKvRu2I57A0J0qL4lA0gIu4z0wRCjlU1p
	 S9QQf+dXjEQ2w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VJVHM252vz4wcR;
	Tue, 16 Apr 2024 13:42:55 +1000 (AEST)
Date: Tue, 16 Apr 2024 13:42:54 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Rob Herring <robh@kernel.org>
Cc: Herve Codina <herve.codina@bootlin.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the devicetree tree with Linus' tree
Message-ID: <20240416134254.33f7943f@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Y74o2u2fPDep79udFKe9ZtC";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Y74o2u2fPDep79udFKe9ZtC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the devicetree tree got a conflict in:

  drivers/of/dynamic.c

between commit:

  8917e7385346 ("of: dynamic: Synchronize of_changeset_destroy() with the d=
evlink removals")

from Linus' tree and commit:

  40b0f17453fc ("of: Use scope based kfree() cleanups")

from the devicetree tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/of/dynamic.c
index 4d57a4e34105,43f4e2c93bd2..000000000000
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@@ -9,7 -9,7 +9,8 @@@
 =20
  #define pr_fmt(fmt)	"OF: " fmt
 =20
 +#include <linux/device.h>
+ #include <linux/cleanup.h>
  #include <linux/of.h>
  #include <linux/spinlock.h>
  #include <linux/slab.h>

--Sig_/Y74o2u2fPDep79udFKe9ZtC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYd874ACgkQAVBC80lX
0GzT5gf7B0Y63SR6ROKnpQc+u/leniRu+Yd43RloswRh1kWLRo4iMwoFWthck6sE
X+M3PPVWMUd6ly0HBuZ1GxrdBHbCs6Vd1rt0FI4lbPI+h/cBcCpS+LNbmrjwc8he
XFE9s+eL3sXVizYfHeG5kFQq0z6jaXjwdl4AvsXQktTrrSQ0tcX79BzXIluriUb1
zRb9ZgY7XbdT1zdWRiY65Yoe60JDqwPrtGf4EeOas2T9tV/Mrmvxdjhc/GV9ydtf
cGcjkFpRFN5lICx8toZUSdWkP3KLO1DVc6msgmspB53tQYTEVnNLaArE6VtkYm8z
2SztfYKLFt9RX5x84E+exhBS//2rXg==
=L78L
-----END PGP SIGNATURE-----

--Sig_/Y74o2u2fPDep79udFKe9ZtC--

