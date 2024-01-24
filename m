Return-Path: <linux-kernel+bounces-36880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0DD83A805
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCB861C24DAF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440D5482D0;
	Wed, 24 Jan 2024 11:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="b4KX7Lhe"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A822481A1;
	Wed, 24 Jan 2024 11:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706096145; cv=none; b=PXU7BI/427fbsnOqD/5K+xVBvpT/IJFTYGI0zsAZHa17pMRd3wSDx7l8OiW37nqxusFsaQXsGXRmlF32w5VcMrnWN1pxeByikwzmNYMjTau+tDDIVQdIA9FTNgTaypvNxibPppWP/0p/dTp7ZakjB6OxzJqiUJSiuSXHFuYwd+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706096145; c=relaxed/simple;
	bh=HCYefsX1KmUIRXpr+U9suQmrYMu9v2QhS9L9o1dBhB0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SYIYqvAZvIJWLJ848d4qEN2pwU4B8pDp8e1DXbs5u65nDfsnUKSpIvi2JrMlsJf5ZDlOW8U5b5fdNM3lsiYbeoS18uLj5M9QAi9rQsSzDO5Vlk0ia68dtLHmSbmr3d0WaOVtS1gy/CFLly1Mnjx4BVPnfKOZPgvzl+/wUAUHZjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=b4KX7Lhe; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706096139;
	bh=uZKMyB06QU/dtKlgVucTjcJYWlW8mUXD33SIywqLlco=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b4KX7Lheg7LGbyB2vN3ozE7BUyKNYoT0N8LBZ/kchGBUetzKM8M3A0Ivk2mLhEEeH
	 VdjzlEFCJ1k2OuPOrUMEn6QOGdrYmsC9lCdibl6iSYjNSHJhbl6OKT/oHUw6d/o212
	 wuGMGZNTEKAUkE6dtu7x7Cy0/ez4EO5D44t4eFQhAY64zLJBJz3bZwNV6Q0LDxcQAf
	 79GOsUqdot1vV/T78XAMwUVDrIoaBEytHvpAO9EUFJB7KzPjbo40KgrRB25duhi2d+
	 ppGza7IQm8YPhzSeG1tog5wiVCWl6HNBsDipFuZXNirUquaiaZttuWqcAeTbZNMuOj
	 WKo64+lMUsSDQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TKhj71RC3z4x3G;
	Wed, 24 Jan 2024 22:35:39 +1100 (AEDT)
Date: Wed, 24 Jan 2024 22:35:37 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Brauner <brauner@kernel.org>
Cc: Baokun Li <libaokun1@huawei.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the vfs-brauner tree
Message-ID: <20240124223537.35433349@canb.auug.org.au>
In-Reply-To: <20240124-liquidieren-retten-8b3c65074c33@brauner>
References: <20240123125227.0521c8d9@canb.auug.org.au>
	<20240124122040.04cd2c8a@canb.auug.org.au>
	<20240124-liquidieren-retten-8b3c65074c33@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/X.XPBeyI_js6B235i5iWxn=";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/X.XPBeyI_js6B235i5iWxn=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Wed, 24 Jan 2024 12:13:02 +0100 Christian Brauner <brauner@kernel.org> w=
rote:
>
> I had dropped both from vfs.misc yesterday night. Maybe it didn't make
> it in time.

It still has not ... I only fetch your vfs.all branch.  Did you remerge
and push it out?

--=20
Cheers,
Stephen Rothwell

--Sig_/X.XPBeyI_js6B235i5iWxn=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWw9gkACgkQAVBC80lX
0GzO/Af+I3qX6RQQfK+Jcaqejh0NFxXCmQLA3SlZhhgU/uCGLi/+Ox2bYy6QK4iD
sGlY1AytR0ZuIu01ifeQlNFREIJQ+Dk+AbewlFmCVCBfhbyrdFFvt2AvvL0ayvmB
WqWL5s95dacesr3g3vCisBJ9sSRMly+ZSZxw0+M/A5sDrXGitXQKK/Fk3SO7M20v
yECvcdWifohSxh1Qky2FskFFoo7t/nt5K6KNIHFaODgvoyxjhfmikc3GGjbMbx1v
FYP0qEw8ZoiqtHFFz9aYNI+1ObnzTGpwGfhavHo68acv0aznhJ6y6CCp4OgIPHb+
O9RIRvmsyI438LpWz8ZERjxhRjF3Mw==
=MlaO
-----END PGP SIGNATURE-----

--Sig_/X.XPBeyI_js6B235i5iWxn=--

