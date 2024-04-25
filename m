Return-Path: <linux-kernel+bounces-159176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C54A08B2A42
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 826E4281788
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32584154C11;
	Thu, 25 Apr 2024 20:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FDO1Llbi"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4986812C7F7;
	Thu, 25 Apr 2024 20:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714078692; cv=none; b=noqZq94O6Vd1uqpfOkxOqQqjCItnUGm/lSCjwfAIKBVrhIlTJhAx7vfsdXNb9brltEIi62jlFrSwElI6n0ojC0UX0jp75jqVRapufqtaKNicbYpMm+IzjETCz8folABsUzY9lyhfbEfe7o1hWrK4vU2DfZkjbcD4vV2hXt9CF4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714078692; c=relaxed/simple;
	bh=rDizQmCs0WL6dUt+S0yZE3TNu2C51lOO3L3058Sgc84=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oDSvbhgN2i637MxzLyStPidKPu5qCw+X8m46vgxk07CReHm88HvH/P+c2yhv2cYBVdqZ81M3FB6kAdgHP60BheSpsRTzrwv5ra4ebJaCbJRbc/9F+rFsa/JylsMurz5QSgvWM7Sc+7my8l9Mf/bd97S1U6OHqnZJnee6xTkldlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=FDO1Llbi; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714078688;
	bh=rDizQmCs0WL6dUt+S0yZE3TNu2C51lOO3L3058Sgc84=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FDO1LlbiypsNuopoYeyGAkt+/96kmrYRohwMaNBE22Y5fLlg69D3JQLk1QvXpMHRn
	 G3ZGA5lBqn3Qoul88XuSkq3ZABonbwc9j77vjWXIKCAw6xtNDW+1jIxV8Rhan7ax2E
	 OR54UvgQRJGkgRV4dMrOg1XJifIAbert0sajMhBzoildhEROh7V/RwQuHFNPB/YnN9
	 c311FU2fadLZd9lSB3OfmbTbNwSuA9LYkjq6g6cE5oxstLn9HDMD2iUUkGwaazhSzu
	 8tGNtTOKExrjQHlAmWXB9xSRnEV9huTU+/fHL5DrocTHJ2U4t6Ew/UgToowc495Eue
	 FjL4Wr4C3r6wA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VQSqh492wz4wby;
	Fri, 26 Apr 2024 06:58:08 +1000 (AEST)
Date: Fri, 26 Apr 2024 06:58:07 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Apr 24
Message-ID: <20240426065807.130c7140@canb.auug.org.au>
In-Reply-To: <f43600b5-dbb0-43a0-bd82-f950f9604b28@kernel.org>
References: <20240424202112.4fc0e0d4@canb.auug.org.au>
	<f43600b5-dbb0-43a0-bd82-f950f9604b28@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ydV9Goey=GXT8GZWbyU_P1V";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/ydV9Goey=GXT8GZWbyU_P1V
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Thu, 25 Apr 2024 08:15:14 +0200 Krzysztof Kozlowski <krzk@kernel.org> wr=
ote:
>
> On 24/04/2024 12:21, Stephen Rothwell wrote:
> >=20
> > News: there will be no linux-next release tomorrow.
> >=20
> > Changes since 20240423: =20
>=20
> If you did not publish next for 25 Apr, maybe you can refetch
> memory-controllers tree (krzk/linux-mem-ctrl.git)?
>=20
> I applied set of patches yesterday evening and I got build results after
> I finished working, so did not react on multiple failures caused by
> these patches.
>=20
> I noticed the failures now, I dropped patchset and refreshed my for-next
> branch.

I did not do a linux-next release yesterday, so it should all be good
today, I guess.

--=20
Cheers,
Stephen Rothwell

--Sig_/ydV9Goey=GXT8GZWbyU_P1V
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYqw98ACgkQAVBC80lX
0Gzl5Af7Bhf4VBZVm5BenwnTxYnbkRPo7fiF9ltFwJv7+cnQ3+GcXU8kQN9WTAon
rN63BukExqxid54eYYM0+Y/1Xii7Hz76YPoAIg2YIKuDXsz2vtpL5hrvg2jROA1q
eaXMa39OhMqKcjsz6sRvcaBb6L6+0SEBHsGtODxNzmNejPlcHARMyULzIU8+UqPW
wdiQc16aKikkpy3bk1da4EfXsfzWEU8PYpYxg87KMq02yKMjHo16k7zArXTrIdwU
IYQLUXbvyPC02PRV6vHiDMwTskmOdxNFsqYih1OBQjhXTodtU1THWfywKe0f8lr6
DO67JLlzYYU8K6qPjDzx4USRYZ+sSQ==
=7Nuo
-----END PGP SIGNATURE-----

--Sig_/ydV9Goey=GXT8GZWbyU_P1V--

