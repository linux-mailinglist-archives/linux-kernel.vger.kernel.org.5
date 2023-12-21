Return-Path: <linux-kernel+bounces-7963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AED581AFCE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0744A284776
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85625156CB;
	Thu, 21 Dec 2023 07:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Ag9SUkmw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61956156C9;
	Thu, 21 Dec 2023 07:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1703144937;
	bh=nqVI3JA9aEoz73f5c4pDD1oc3m2TjqW6l6YBxyiNWmY=;
	h=Date:From:To:Cc:Subject:From;
	b=Ag9SUkmwCGLkheOgOoMJ6PGZUbBbdYHGVix5Zp8QmKgt0Ih03ovSTXauXljeJ/sOz
	 1V1ogCoMDzjyKmx35xFbZHouLBOrlEOW9Qtf9cxKtMwlQRdTJNhnzA/EVBtxO31LBQ
	 vZUG9EkOQReY9Z0zF38Jw8ShCWaiOTHBO9AMj7A8J56mKEu7jMW83P1R/E74trYyYx
	 RdGmWzwBU6LxIpulMJ9Gwn9D/c3Rd+O38uwbTHQesxbQ0WW7J+yuDs/6P8tUgnTYxf
	 6Aggu6NAZGynr3Zv0M786h5QbbtY9FwAghSBR8L5O1UQjjMSAqqYH5IjzxIDQSlIWz
	 vmA7jH5V4hPog==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SwjHF2SHDz4x5m;
	Thu, 21 Dec 2023 18:48:57 +1100 (AEDT)
Date: Thu, 21 Dec 2023 18:48:56 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Brauner <brauner@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the vfs-brauner tree
Message-ID: <20231221184856.71d71623@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uyCGBqUue/5TS.dfQHXhFEd";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/uyCGBqUue/5TS.dfQHXhFEd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the vfs-brauner tree, today's linux-next build (s390
defconfig) produced this warning:

arch/s390/configs/defconfig:626:warning: symbol value 'm' invalid for FSCAC=
HE

Introduced by commit

  9896c4f367fc ("netfs, fscache: Combine fscache with netfs")

--=20
Cheers,
Stephen Rothwell

--Sig_/uyCGBqUue/5TS.dfQHXhFEd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWD7egACgkQAVBC80lX
0GySvAf+KZePxfiBcN0u77VGhlxIdFOTPTLGQFW1t4oB1TskApPZq6f/Yw9Y+gW9
X/FsgDrq8NGCd6a6Nkyk1/pfeBrASeKMie1G/hpzSmiBfiZ5XX2OZ9tb+6KmxBxr
ApPonvcGZaDFBJSK44nSSHBbq++VpNvd4ce/IkHZBEMp6a0Y1weZa9r57rEjupN9
5D0+kQYP8/HYoS/MNluW7Lz/5a59oU173OhwfLpISv8MSFoSiBuD9TAk3M2Gmz6S
A+A94NeDVTBeqdzPAciFP8F7SykX8MPlLaV0mccQhqsoBeTHzhzFDZyjBGjosJXb
6o/TNDSA4cKvFgJ8ltlkikQDrePR2Q==
=hVmy
-----END PGP SIGNATURE-----

--Sig_/uyCGBqUue/5TS.dfQHXhFEd--

