Return-Path: <linux-kernel+bounces-139873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8BB8A08BD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECF90B24C88
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8198013E033;
	Thu, 11 Apr 2024 06:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="un7obRe5"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041B513D8BE;
	Thu, 11 Apr 2024 06:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712818020; cv=none; b=B3LI0aqU68Z6QSlyJHJrDBAUnMSkT+FzrT8W+p4UsXTu5cuDzEIL/BYcAukJZH9kWVV5I9gRYkwIRtS2eXK3MWbVN0tzHcWSW8ne26QU089HO79u0DtvOj1i2EDcWANEAf/NjXtxMMzYPy9NMHeI02PfUWqXMvTAzCL+X3S5zGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712818020; c=relaxed/simple;
	bh=ycsytKfJK6t7NOr6jPcN6Fm+AqSm01T0ZZBdzwiB6dM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Z5TvFENJRCNHkpF3SyyLZxYvvotm65bTYSEusYihjzd7ewnNpyXwcAIUsVAZaeOp/4+ES4fd+AC8FaqCYcnywstudGqsmG2b7lxp6sinX9B956/9GNSNLQCYCp1a/eE794fkc3/E3aTir5GFjG3uWn/n0tQOGWpLpGE3KeraIhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=un7obRe5; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712818015;
	bh=GQC8k/W3Y7vUrOqYNyhfKiTc49l/e+bbC4LzTGQHhlo=;
	h=Date:From:To:Cc:Subject:From;
	b=un7obRe5JjDn1QJ2uLXC/VYRATuD4GpHW86j0giLzcsLvWtM9mWFmVbE5B1VDyGaJ
	 IXsAKeysuUjQNSGKRkorCVHTncGmnZ1SfWwKISf1TLKQ685Ple7BQ9jflnFvUX+/Mx
	 J1wGm8cVRdmNgkIYswHERHJqPzL/8fE3NgwQJEsRCnGtdT9UM9AvfGfrhfSPxYdPYT
	 MR8crjaWYvX7fznY6/PgIzKhWAmMqurZzEMOI6FFTt1jRAc4W7ilVVdhSXcI37ZI+p
	 3Q/JQdOzQ0Y2GqaH9OY3d4Y7lq32q8eLMwj/IyFEjsuHWjPKffteP9oZhiwSss42ks
	 z3VXd5o2yVkQA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VFVbz519Jz4wx5;
	Thu, 11 Apr 2024 16:46:55 +1000 (AEST)
Date: Thu, 11 Apr 2024 16:46:55 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the rcu tree
Message-ID: <20240411164655.781a57d3@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rE8LfDGL.hadOQUIHXl.46E";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/rE8LfDGL.hadOQUIHXl.46E
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  56544e22cc3a ("fs/proc: remove redundant comments from /proc/bootconfig")
  e6f3a323fcfa ("fs/proc: Skip bootloader comment if no embedded kernel par=
amete

These are commits

  fbbdc255fbee ("fs/proc: remove redundant comments from /proc/bootconfig")
  c722cea20878 ("fs/proc: Skip bootloader comment if no embedded kernel par=
ameters")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/rE8LfDGL.hadOQUIHXl.46E
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYXh18ACgkQAVBC80lX
0GxjKQf+PB0/3uhRvOYkmjXt3ZXD19XAWr6PYwybbY+B8d9Z1VStM2yK8sVrJlip
BJowCuEjSb9Vm1HHtTgvby5yGUlyTLD5pALjcrl0oWTLgBIY/jff86lTGm5lDXgN
Bh/y7yhAcJT6YhdYzs0ih0NMFHG2rwgFbJfY5e8J6CCQeJPvfClgmqI7yfe0ijQz
jfPFBQSWEHRpt5ylc5mZIFMda3SPSWQWezv5OCtga7GrcFW76RZ+pLlVUcoFQbTJ
LRsDHvIBRcgsmI+2Q9nlrq47W9sAz5MuY4aKPqo/3IbCeg1TVcr93Qjeh2DXTzd6
qbTy3eXnB9Nwm0tvv+065bNbzwdEhg==
=mBps
-----END PGP SIGNATURE-----

--Sig_/rE8LfDGL.hadOQUIHXl.46E--

