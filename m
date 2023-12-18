Return-Path: <linux-kernel+bounces-2993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D758165B4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 05:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 580F01C20A9C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 04:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A1563BA;
	Mon, 18 Dec 2023 04:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HjMemx5V"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB9263A3;
	Mon, 18 Dec 2023 04:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1702874435;
	bh=RZCUTY3WdDKvXPR5OpEDurVy+wjz0J7rb/2i6L34Ntk=;
	h=Date:From:To:Cc:Subject:From;
	b=HjMemx5VOUJbpBiGJ+s0BgKedpacrCz733kPGOH5LoDBhnU2/yfQhE5ki+mCLoq39
	 fkgDTW4h8MiM2zBg6qDSz2EPfsUwpVrM85Op3fCJcj05Ce6xGg78vlIoE3YVWQHiUU
	 ncPt3/5dRDV2Wuesrhevd1xtBUeAdI0BwKCmxw7Ngq2srReTZVfdGDEESjTYzAc3sc
	 YVYwTYIFHWVqzGFJSUjTecoSoirOZ0Iys2/roPYAemTMR1eqDhX2I4hCcTgYxJKfWl
	 p7u89q0zJ+Tv9eRroUFoGhH3uBufIyh2zh/LXi/cm7T1Q11VqwBhCq9LNLbo7f8o2N
	 u6t3mWgmqIhow==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4StnFH1rbmz4wc8;
	Mon, 18 Dec 2023 15:40:35 +1100 (AEDT)
Date: Mon, 18 Dec 2023 15:40:34 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the driver-core tree
Message-ID: <20231218154034.56bf4c68@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=WCEwTXc2st=ctHxEtl4Lgf";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/=WCEwTXc2st=ctHxEtl4Lgf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the mm tree as a different commit (but
the same patch):

  2678fd2fe9ee ("initramfs: Expose retained initrd as sysfs file")

This is commit

  426081603f6c ("initramfs: expose retained initrd as sysfs file")

in the mm tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/=WCEwTXc2st=ctHxEtl4Lgf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmV/zUIACgkQAVBC80lX
0GzSSgf9HqWxxl/XYzvqbOM+K/OEseX4eK84k4h+BpHcmir+gdI7dIoBDm5pzVUf
62B7NaupC10mDQZ7kTZ2FLVc6FWHC3WCR2QSALBpPDZqCU0ln1PXnIb0X1WsB5I4
Z//v/uF1+k/0FghGF2Pdg3MHGCy5JxoccYJxZYcdvACCbGttCSYGijluPUZSKqW7
PxM8XgTQqonobTvjxkZoa2040FBjeP4AQ4MNS5nrzvkPefz9m/g/pF8v856Kc3sv
C1EVlsf71ebd82UJciEzqp9dB5NzOfdfi05mpxaetR/LNl1hRq/ZKw+JTW4pgtjM
bVkiGHXMPMLJ+dq2KSXoKCpXvt4Y0Q==
=dq91
-----END PGP SIGNATURE-----

--Sig_/=WCEwTXc2st=ctHxEtl4Lgf--

