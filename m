Return-Path: <linux-kernel+bounces-3048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFCF816695
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 526C21F21A13
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 06:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197B579E1;
	Mon, 18 Dec 2023 06:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ZcKDl9L1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E8C79C0;
	Mon, 18 Dec 2023 06:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1702881307;
	bh=fT3DsR7bk4gWvr/2ga6wtGc9d7VKEYFCvVnBCoeXiq8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZcKDl9L1d4yyEHpgKV8FEqvBDZPZ5AmMQjM2BHmF0Fixdgxjt+zKiEa56d12PAdxd
	 ODZ9uclwABbiq+zq0DJM7PTm+g8rxhHiVZQ9tdcco9/5Iw0cDBJtZinUmj2kBHnMGF
	 gah/cz1oWbW6LCtIiiJB2cN4MnB4QkVJ8n42jIk7VI5tUBSaPtPbU/T9dfHZUwKp3R
	 j6R1Je2cu0r9avnAJyjf/86rnkQjI4YC9IfbIxISxDMNv+7w1N4LQRpfqZdITpiblQ
	 Qr0mAAkMrDvZbIUuPD8VhAjkMyINS15eWGspYx9dUgqzOvYUrgJ5a1Vsi6zdKIfRoP
	 j9PcuzM7pLyIQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4StqnR2gQnz4xNH;
	Mon, 18 Dec 2023 17:35:07 +1100 (AEDT)
Date: Mon, 18 Dec 2023 17:35:06 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg KH <greg@kroah.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the driver-core tree
Message-ID: <20231218173506.2165eef6@canb.auug.org.au>
In-Reply-To: <20231217215429.944b318dc38a3646e734a807@linux-foundation.org>
References: <20231218154034.56bf4c68@canb.auug.org.au>
	<20231217215429.944b318dc38a3646e734a807@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6z2CePDoo.9MDy7TWG2bB/r";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/6z2CePDoo.9MDy7TWG2bB/r
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Sun, 17 Dec 2023 21:54:29 -0800 Andrew Morton <akpm@linux-foundation.org=
> wrote:
>
> On Mon, 18 Dec 2023 15:40:34 +1100 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
>=20
> > The following commit is also in the mm tree as a different commit (but
> > the same patch):
> >=20
> >   2678fd2fe9ee ("initramfs: Expose retained initrd as sysfs file")
> >=20
> > This is commit
> >=20
> >   426081603f6c ("initramfs: expose retained initrd as sysfs file")
> >=20
> > in the mm tree. =20
>=20
> I'm suspecting that something went wrong here?

Like what?  You and Greg have applied the same patch.  It happens.

--=20
Cheers,
Stephen Rothwell

--Sig_/6z2CePDoo.9MDy7TWG2bB/r
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmV/6BoACgkQAVBC80lX
0Gz0lQf9GgTbTx50buVR0HUiIDFQrrola9AfrLcz/F8+hrSH44EYcXqjqeVyBgmx
6fU6KKp/CuXL+LEHVPomBNp2MGgfgqVSUmdo2gIET9q/YI+Y+yRbYdJwZXesASgI
C7S+xMSbXPON0uWShPxFABS5CwQdqlfNxcfHjbC4quLNPxcF/2v0q1YQ44uJ2cq0
xBzSC157kLFdCba2EIGbUNgGfZPC19o++v7ccPCun8TtsZi0C9ZhXxXA30g67h1L
VcqNFHHiTWgnyq3KMgIzdn244mB7X+kRvuiaOUojG0vHz0Xd1YOfVPOqCtO4PSMX
YhKUuWzR/x3R4wJ4VqSjZYEnP1qWzw==
=rG1A
-----END PGP SIGNATURE-----

--Sig_/6z2CePDoo.9MDy7TWG2bB/r--

