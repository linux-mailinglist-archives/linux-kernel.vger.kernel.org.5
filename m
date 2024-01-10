Return-Path: <linux-kernel+bounces-21713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66ABC829326
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 06:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196741F26A66
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 05:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237F4D50F;
	Wed, 10 Jan 2024 05:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SbOv9znO"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1096B6FB1
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 05:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704863033;
	bh=8PQdV+sCXBurfHsJgRraVqjZBsjUZXo3blKQWPD3jkE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SbOv9znOZ76Pxvok7owHDDRU65apx+cX1S2fv+Zr2uTbmzqJygaP5sRjwuAOwTI3s
	 i8tvi++Fuq+P3O8nwdGkl6zlhcWf9tnqzclC3vABucVKu5XTpS697oczH4bQQnUIgd
	 x31gxDJg2bjKBTRQ4DbRV8euM9DVVrrgYvJNFx93VuANlVVsu7JlRBeyIneC5R6OJ0
	 33fMrurpn7+4X9eWU3HTDwifCkFnvIAVhKg28O5FS4tiAJi8QLjf+lEkIKwr4Q9u+o
	 KksEOJ+3A5X/fLNzJoTHm+av7HCeGetb5cLhdOnTmiRZgHY6OJ6QoZOjL1wMErIrjR
	 AOduCWQU9migA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T8wgX5ynHz4wcZ;
	Wed, 10 Jan 2024 16:03:52 +1100 (AEDT)
Date: Wed, 10 Jan 2024 16:03:51 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
 linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org
Subject: Re: [BUG] allmodconfig build error in next-20240108
Message-ID: <20240110160335.2bad7d54@oak>
In-Reply-To: <3d14049c-d44c-4b33-9933-0f96055b8a70@paulmck-laptop>
References: <45ad1d0f-a10f-483e-848a-76a30252edbe@paulmck-laptop>
	<20240109095757.1313b2d9@canb.auug.org.au>
	<341a4955-0cdd-48d0-bfbd-cc6f6f09df37@paulmck-laptop>
	<atbx7mspjbymkzgstk4l64qz3uky3wpmx4isrfg3ixgtvebdd2@cktpe4ejfk7k>
	<20240110081155.48bb0cbd@oak>
	<d61dfe52-9567-4f62-98f5-5c1e00cb4708@paulmck-laptop>
	<20240110095822.3ba3d979@canb.auug.org.au>
	<3d14049c-d44c-4b33-9933-0f96055b8a70@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Qi2gBvZmhSjDhm_0pAGQggf";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Qi2gBvZmhSjDhm_0pAGQggf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Tue, 9 Jan 2024 19:46:27 -0800 "Paul E. McKenney" <paulmck@kernel.org> w=
rote:
>
> On Wed, Jan 10, 2024 at 09:58:22AM +1100, Stephen Rothwell wrote:
> >
> > Maybe that line "subdir-ccflags-y +=3D $(call cc-option, -Wstringop-ove=
rflow)"
> > should just be removed as the setting of that option has been moved to =
the
> > normal C flags in the top level Makefile (out of Makefile.extrawarn). =
=20
>=20
> If you meant like this, no joy.  :-(

Actually I meant the one in drivers/gpu/drm/xe/Makefile

--=20
Cheers,
Stephen Rothwell

--Sig_/Qi2gBvZmhSjDhm_0pAGQggf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWeJTcACgkQAVBC80lX
0GxmEQf/dbbKDm5FsKocV5j89ymwcJw+M6c12PRQs4dpqD7LtxyPDykHF1Ct9/Qi
Ex0YC+kaYYPytGHd/f6Hpop94MeALH8VSDruTp++pOQmef9wH799wRy+O0yHkYcY
8oDUL7WIh/EsBm4cIS4AuuHt+NFDNkGy3N44Inb+gu//w101oK4vCNfLmWgQwy3g
7aCNHsO0bQzFQa5OV/lE9o+EFF9hbzHJfhj6W2EwUkHLbbGJI7m9wX00BLLdPJ0X
j5gT1dzSrCNbLG9QLDZ3wUzvuBlUZxn5GWxSBjUe3Jm89E2nUNkRiHb32WGWfmdq
/Lb54WC7OmY8ldE/j3pmkVQTeQehLw==
=DgtH
-----END PGP SIGNATURE-----

--Sig_/Qi2gBvZmhSjDhm_0pAGQggf--

