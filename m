Return-Path: <linux-kernel+bounces-52034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA0284931E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 06:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA7611C20B42
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 05:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD93B669;
	Mon,  5 Feb 2024 05:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="sI4rNwtX"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E473B653;
	Mon,  5 Feb 2024 05:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707109221; cv=none; b=Mzbi0IUsR1ioAgdH3yIhQlQUvDr+2C+zFNqHzobQobg9+fMwEFMDn45PMIrLOdnXJhvBPY+VQcriWqrmMvY3WYFiOxzgmV+/BIOL0p6kQgLr5Z419/9L8zxpglmC+qnCh7JpGI3mHfvTmLGiggDMYGEvKB/y8GC/0TrLXxR9gWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707109221; c=relaxed/simple;
	bh=EjhIpOnmpg03CcfmIATRCOFiJ0pMLuPbiwLKQVjgHV0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H5St7/b35fhaQ6LxV/gEHQe2FNycAAqciKdBv9qPSt9ppBCQUCKD9MY+t8vZGnnbbHgKqC2N6cSoglC9qyuU9T5s2LzQIPXSss+gIqU88imG8fRgMzgAjdQ2Xau7DvWTokDHhsizNZByNDlQFduMK94grwOS1bgQJFKRzxn99CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=sI4rNwtX; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707109217;
	bh=gVvzuEOg9DUahP1WNPlD4/+AJQ5R7pLdf6kS7Mzx3pg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sI4rNwtXSO1g7gneU8P4+RkXuURzUk7tToNdCf0PFXo2b3NDkA0AtsOSosaVc9S6p
	 wr0s7JctoraZk+5G92qtUDtgHXCirij/p+TzsGr+SkHQiNM03bfrgR2gZWhgYcq6DP
	 KjHCgCUV/PAZsSe2z9h4C/xEnJWERJBDe93Q6LqhnHsV/aC7WJVDMWq7jJsQ+0hYqn
	 0SPi/eXuN+nFxJl7pSzGrMxiODaP1I2n4P5AkcoHh5qOfCvi0sYWpnLSChSjMhH108
	 mgafYtt1hHuksnybYWR7gA2R5ZuEZFVh7kH/qIPNMjTka4l9tj7dk033o5lD6yP7LZ
	 R9qIEsrcsq6zQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TSvMP3y5Vz4wp3;
	Mon,  5 Feb 2024 16:00:17 +1100 (AEDT)
Date: Mon, 5 Feb 2024 16:00:15 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Brauner <brauner@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: boot failure after merge of the vfs-brauner tree
Message-ID: <20240205160015.36db95cb@canb.auug.org.au>
In-Reply-To: <20240205155836.7a388196@canb.auug.org.au>
References: <20240205155836.7a388196@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/dbZKh/4TT1XyHw5m+08pHqf";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/dbZKh/4TT1XyHw5m+08pHqf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 5 Feb 2024 15:58:36 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> After merging the vfs-brauner tree, today's linux-next build (powerpc
> pseries_le_defconfig) failed like this:
>=20
>=20
> Bisected to commit
>=20
>   7a1cac7d58e3 ("pidfd: convert to wake_up_poll()")

Ignore this, it was sent to soon ...

--=20
Cheers,
Stephen Rothwell

--Sig_/dbZKh/4TT1XyHw5m+08pHqf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXAa18ACgkQAVBC80lX
0GxJqAf/dJnvprJybU0two8iAD2YRWhlS19cpG5cSejq6ncgJCFkgiiMTTxsvRvT
8K00PM/ncW7V33EdeJnoIlegpXELcMN8nJSYfM5Gk986rtvyYBcHWcKv630fL7fh
26laK9ArSAq3zynVdFUozn/kaorox9OcG6a+3PBk9iv4QB/0735nuVWOTnKrsZXu
zWmIdfaIG17gd2OI3XX2S3ks1X/qMiaPU7YhjVu4JV5qHCBCRW2EP0rihM9lgEYn
2XGt0dtPXnYrVuNg7H7+a6iDWp510q61JEoIRGa31VBY9LA7JUw/xmYdz386CJWz
fIgO27N5xUUwsvNUVD4DvQyLPmgTMg==
=b0fi
-----END PGP SIGNATURE-----

--Sig_/dbZKh/4TT1XyHw5m+08pHqf--

