Return-Path: <linux-kernel+bounces-159417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F23418B2E5C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 03:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA014283289
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 01:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D708C17C2;
	Fri, 26 Apr 2024 01:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="cIMUG+tF"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CFCEA4;
	Fri, 26 Apr 2024 01:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714095394; cv=none; b=daiPqrPMdAKEmD4NcGd2A1s40HaYqfR40J4Hl+PCkPqmfcvtVGwqHqajOgyWuXlHBmI7pv+upUFk261oqkLdcqRQouzmjizuNoxmplmdpT4oLD6am+u+o/EuIvIVXByzKt7aj3nr/szGWHrvm17vViyjAmE33dkDk89GxZcqoKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714095394; c=relaxed/simple;
	bh=lNmvERQcvW68KokotIoCcccOI1SExoGN+4NuTUFKq6I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qOwRItEXEkvgLmSJuLAGVNV+XWc0AXJegmrbCRA6nWiaG8xHQVCkjNOfbNynpzIgLbuPOAUC7mvTCdbN2Q0ClOb5pnKE4jKjhzt8gp0wxstzCaGJi90WyGftPiaYrTBGSKdDd4giRFnNmZdpWC1Ema9+NFb5UgdvGWoDK3j2IHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=cIMUG+tF; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714095388;
	bh=lNmvERQcvW68KokotIoCcccOI1SExoGN+4NuTUFKq6I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cIMUG+tF33SaoainAdnHacEBylB+GtDMf+Ki8LknmUXYC4Fr5F2UlCXLnkdv1VYAv
	 IVaXMA8nU2CcHuhasuoRzxDJjXvLKaOB0nd3Di2YE84rVymMkRrtI4EGM1tRu/jZ/5
	 XQfSkqz4YhKFvUMPJgOkbsfXlJCv5Q2WTf9TPMc4EDjIqpGjeuF5RYJ4xnpabaQXSb
	 w7paWzFEJzNQDhfhwBH1/KoiFIG1lW4wSpFu2Ixv5yl6mfZVrTXZLuG8c5eUgSWzAj
	 A1BUYWgiWEh7vd0HCAI+/ZXTxTyN29TvFhtTXYR3Bvb3jU8m5AK6MzEHKgbDcw4Zgw
	 tp4OvDGTaZ5dQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VQb0r2RGhz4wnr;
	Fri, 26 Apr 2024 11:36:28 +1000 (AEST)
Date: Fri, 26 Apr 2024 11:36:25 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: error fetching the drm-msm-lumag tree
Message-ID: <20240426113625.5b97c03d@canb.auug.org.au>
In-Reply-To: <CAA8EJprYTKSwS+r+u3yVbo7cLVkA+XnBT9UHVt+yM4Qp3u-GnQ@mail.gmail.com>
References: <20240426104618.43d926d3@canb.auug.org.au>
	<CAA8EJprYTKSwS+r+u3yVbo7cLVkA+XnBT9UHVt+yM4Qp3u-GnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7ZTw+rLQEGDDQJ1eFsW6t=D";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/7ZTw+rLQEGDDQJ1eFsW6t=D
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Fri, 26 Apr 2024 04:26:26 +0300 Dmitry Baryshkov <dmitry.baryshkov@linar=
o.org> wrote:
>
> On Fri, 26 Apr 2024 at 03:46, Stephen Rothwell <sfr@canb.auug.org.au> wro=
te:
> >
> > Fetching the drm-msm-lumag tree produced this error:
> >
> > fatal: couldn't find remote ref refs/heads/msm-next-lumag =20
>=20
> Should be fixed now

Yes, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/7ZTw+rLQEGDDQJ1eFsW6t=D
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYrBRkACgkQAVBC80lX
0GwTwwf/QGHpN90AybQ9sFwSsHbo8xJ/vuW6r4hwiEwwrimqGe7VOT9TVuSWi6kp
8xC0X1YhwKjyJ4ws5PD8GxYofx37rZtgJPf0SynktTQMGQd7JgGAMeXJYkQRvOMl
rKgqqYfDW9/AQoy8MWw+WP+1IJTCZ4pJF6eFOCWBU/eu4LkJ4xVz8Kg9tIN353uh
UdGR6eI9HMoai5KjDiN2P8FauXF4FW6iMrOu2qv+i4keWxE27fLtUlNns6enWNtt
xXEC7ZE3hFO0INxSR8DKRxrdj13n5OCaC4NLxBy6DXGIniO1NWFyJLqhXbh06Wo7
MH4ktcoLSyRkdRDZPfKStGbLG6XgmQ==
=d5N3
-----END PGP SIGNATURE-----

--Sig_/7ZTw+rLQEGDDQJ1eFsW6t=D--

