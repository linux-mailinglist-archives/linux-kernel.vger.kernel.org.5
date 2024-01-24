Return-Path: <linux-kernel+bounces-36305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B96839F22
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB6B61C21953
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E572BAD46;
	Wed, 24 Jan 2024 02:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="eK0Y7NeQ"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D604695;
	Wed, 24 Jan 2024 02:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706063174; cv=none; b=TgsA4HNWRHGizf3DiKLJ+wjIDg4sOYnF/TLoJXH3wPJrxM52TWw8gmgqtUlP8NHAkKQb51izp2Hw6ZOvXXtJrs/krz1o7lTNp/p4iHDPJ/8moRcSD/ZmjwPQnNgot/si6iigXgLae55iNp1mt3fZ9j/BelW/Hrr5NrSXUYUL+YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706063174; c=relaxed/simple;
	bh=1d0rirm7fPWnsXFqR8FPcskImHT9SAAk/2/7YqAmF34=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=SGT9OgJp9ao4FF/XRgOtfNRQVfSxEwfp5afvMURXym5wwfxkilAoi/yEXQIyhKzC07XdHdRWWgdi12LQo4q1HpyQV+6/Bmg1ibj6OHl2FwLDl0VWABY16y+sdGHNToSj/uR7xUuMD5A3Qf2qaN+GWsxql44M6oYXy96UDpy6EXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=eK0Y7NeQ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706063167;
	bh=6F80REPxr/jziMzJ/GrhOuQyX3Uh+joEHN8SkpL5vWI=;
	h=Date:From:To:Cc:Subject:From;
	b=eK0Y7NeQZlKRUDdlcH2E2wbHm+DjYcx5dLa0kykJ2FUehH7z3dgg5HLBHixxENjvs
	 x49hWqtIAEOnv4ULRWnntBpAp3oK0uCGpN4Q9QlsPHE18gG5oX9h/GKnvtQ994JuHu
	 bkM54j7RYExMWm+eMmnvIU8dbY6RSz1mFyjxUC0tAVQ3OcgpVhSdth4uYrwHanNDl7
	 khztVWK0Proh3tANQRKazodGY+7qQU0YxygRTs3Yu2gRkpty4FvLF9Esf1QDgeygJ8
	 ZsUm0Vwo97h/vRdGiijkgbarybWNuWxsiJXnUhkGFrHZG7v8yc03ngx4q4mPtxkL8B
	 vaMEufTRpnsSw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TKSW23k7Nz4wbp;
	Wed, 24 Jan 2024 13:26:06 +1100 (AEDT)
Date: Wed, 24 Jan 2024 13:26:05 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Oded Gabbay <ogabbay@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Dafna Hirschfeld
 <dhirschfeld@habana.ai>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the accel tree with Linus' tree
Message-ID: <20240124132605.4f6681de@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/z/8dOFjR0p0mC.Xa5RdR8V7";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/z/8dOFjR0p0mC.Xa5RdR8V7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the accel tree got a conflict in:

  drivers/accel/habanalabs/common/device.c

between commits:

  3652117f8548 ("eventfd: simplify eventfd_signal()")
  b7638ad0c780 ("eventfd: make eventfd_signal{_mask}() void")

from Linus' tree and commit:

  1436a2242aa5 ("accel/habanalabs: check failure of eventfd_signal")

from the accel tree.

I fixed it up (I just used the former version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer when
your tree is submitted for merging.  You may also want to consider cooperat=
ing
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/z/8dOFjR0p0mC.Xa5RdR8V7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWwdT0ACgkQAVBC80lX
0GxtBQf+Ot0VNm+vJ0mL8LWFWmvJRIu/hkTHFxWcCXzteLPgmHmgQqleW/aINGun
fX66MMkP6EzCca75OJvV+MDZfQAfn/6pNHThSbxSVSqpTuViz8CkMlE1X4IJT07a
b+GkbVU8mV/X4hWrXO6+ClWCsNFtlKW5++MEnh109xEUMddwRCrL1DhLVWlaE1/P
Hr+0NFh+hNu8EXD9Kr3rnB6xiEktJsDfxUXaDgrjVRgsF+70UkUddhbU2fS5YOzS
EDCjZcb+j081ojZaCFHXSeKD+2AS6VHuSHo5MuugspbeRekCGZNC7vZnw9dq9E4t
g3n2wmO4fyHdmJVqFghWJTgTERal8g==
=rMWl
-----END PGP SIGNATURE-----

--Sig_/z/8dOFjR0p0mC.Xa5RdR8V7--

