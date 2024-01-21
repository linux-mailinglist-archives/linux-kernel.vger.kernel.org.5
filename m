Return-Path: <linux-kernel+bounces-31995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 773AF835509
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 10:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C9971C212C4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 09:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0B0364BA;
	Sun, 21 Jan 2024 09:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dCq1a1kL"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F14125DA;
	Sun, 21 Jan 2024 09:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705830370; cv=none; b=n+ExrcbrRxjsCeDU8sKQGfIoFOfJ9NsKK41MbIBcNfx/orYlNb4vpr4kcyxhCtwG8/K4IfQSGCQqcYltCZGGDTxweigHpNoYUziTc7GwrN12H6HuBRWTiUqyqxGySCSiJFsnp+LFOxyOwTqpZXSVRxrXkituc/tY8PooJeD155A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705830370; c=relaxed/simple;
	bh=fiO12jNR4YFFyP/hfdAVTblqfo3FyM+OhqWZ29CkoBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=baDAu8dB9I+Oj+4e1qE65n1brmQStV44tD17d2LtfwAoKKdOBUK+J2Pz91eIbVhpTWKsX4TrcK2IwFYt4tNExdZ1m1F/Yc5nXj+Nc58PGjGf0RD36bXfYZLyLHylVol/4c5ybG09qw58WjVDXGGAoTvLf18OHzVkP55c6o/Kbwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=dCq1a1kL; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1705830363;
	bh=ETipMmLnX2wQIoxJS4V3B3iAj3BKdCZkE/ILWrXv9xk=;
	h=Date:From:To:Cc:Subject:From;
	b=dCq1a1kL1GecEQAOOlgNi55zKwq9a6ucuzQAsgWpYZY1X1C9JQaFx64FHmreY8JOc
	 AqxhHvAoaFzQ+Cb4euae3XlT00TkqGIo6q9uI6U6W5t6JRPiE79U/WGlq+BW8HN3KF
	 Ig1jySNCWYZKxO3zjPusQiCx7BY6xB+ZzqVpeaUmT1N0WARhzmhe9698BLE3e7Ytza
	 nT/6Ln7df/kNgU4xxD4dwDAK7ZEJvpyef8NFih+b6mfmI7F/mQjYSGhX1vlINB+Eos
	 gnS0va6Ae+j1pEgebTLBqFgO4cSpMtECBYx4VTtgHT+tu9F3G9kbqDC2uVcoKN/zVm
	 Oa11H2yW5d4VA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4THpQ31qGNz4wnx;
	Sun, 21 Jan 2024 20:46:03 +1100 (AEDT)
Date: Sun, 21 Jan 2024 20:46:02 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Leonardo Bras <leobras@redhat.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the header_cleanup tree
Message-ID: <20240121204602.0a8add39@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mE08j7KBPCQb1fj7VK572JE";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/mE08j7KBPCQb1fj7VK572JE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  5f4c01f1e3c7 ("spinlock: Fix failing build for PREEMPT_RT")

Fixes tag

  Fixes: d1d71b30e1f85 ("sched.h: Move (spin|rwlock)_needbreak() to

has these problem(s):

  - Subject has leading but no trailing quotes

Please do not split fixes tags over more than one line.

--=20
Cheers,
Stephen Rothwell

--Sig_/mE08j7KBPCQb1fj7VK572JE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWs59oACgkQAVBC80lX
0GzIgwf+MkufuPk/dY+50OSJmhRYUY25dbyrGsZt7r4pEe9ZvnsPppm7HaOEG6yp
Tpj7wDKg3N+/TfHr4MECkp+s/fsQ74tU0NurvlW6m5/uUJrksaxG+zl+DrMPkNlh
zG61KQVteP7G7XvH5PSQIJ1eit+/3v/LbMxgxzQqfHBBNH4cxe+ZchLJyU7fXffF
sT2AVzru74QWbypT00q+WDIssf5aeeTVI0JR+NqgORUshDQjRXd4RatrZR5IM2Q0
F6KsEa9LmOJlA+RPeGSmH4mAP6fojxL7QG5PVncbFYq3Xo4XOlYWUMLFPl67FOPB
hXFiAATHBtwqkXfKUxlRCJ71XmPGPw==
=mGui
-----END PGP SIGNATURE-----

--Sig_/mE08j7KBPCQb1fj7VK572JE--

