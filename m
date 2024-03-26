Return-Path: <linux-kernel+bounces-120139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE1B88D2DC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 00:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 468711F3EF90
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C180613E047;
	Tue, 26 Mar 2024 23:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="NZ6262Kj"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01931C288;
	Tue, 26 Mar 2024 23:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711496158; cv=none; b=iNlfVKfN080ZsB2SXwtIAdDM0XchHcXkSK1WXdkldhIObeCCg+KLMTlRaVnBAPPPZCUeKGGiwKmQsOdGWXDdYiCBaKf1CRsYKt0J3q4WyxBnZJmBBrKZiJPB0YVL7Jxc+9B8XS6lCyCDV8HXdAYSZeQyKJgO19Z24iUtRdH1xy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711496158; c=relaxed/simple;
	bh=2kYHyEHjL8vZZ93MqEh/vWakgojswPv+9v7lJxFVHFs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Taf1MOYc/dIfb5s3UUDbr6F3IseugtFySoLdgjtT6cIXrzpqm5FXqPl3s7YqociQLlqWF/09+K87DSIdHfDiaOXkNOxiMzemj69Qks8AXKlttcOT44kSMKW9znzkXJnGA97CmuwloeBjjUh3y6gb61wLi0UAmf6S0KIRvOmc4s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=NZ6262Kj; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1711496152;
	bh=2kYHyEHjL8vZZ93MqEh/vWakgojswPv+9v7lJxFVHFs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NZ6262Kj5XXUhR0E3X2YWJpmaC9m1zUbGtxoimTNTmPrbX88qALXmj45xalMwF+iH
	 /g2juhHtjGA4sG1fUm+MwrpoOAAA8+jYsZBabHSLWWbUcMjDKVQ2vqfR6t9LbGOIAO
	 kCGTKIAh0/z1lalNi9Ue55Jk2RZnXQ3Sxtil/mWZFOpX9nZwmxf/mMRPn8FmWfCu/o
	 8PSQnEG89gu898KXVzbasvCPKmeFMthQ4yATx8XYrK93FqyT7qK+EeIY0FIV8R3Ust
	 Pd0o9ABAsXIQzsCjJvZc/8DLZIH6B309o7mDuUdkLYZKuT+plMcVo27Gk3nv4sHznP
	 VEBWvJuGMF4MQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V45lX53hFz4wcQ;
	Wed, 27 Mar 2024 10:35:52 +1100 (AEDT)
Date: Wed, 27 Mar 2024 10:35:51 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: error fetching the clockevents tree
Message-ID: <20240327103551.392a1b87@canb.auug.org.au>
In-Reply-To: <20240319093614.16d6eb11@canb.auug.org.au>
References: <20240319093614.16d6eb11@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/isLxSh+W9DLDD4TM98S8OuM";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/isLxSh+W9DLDD4TM98S8OuM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 19 Mar 2024 09:36:14 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Fetching the clockevents tree produces this error:
>=20
> fatal: unable to connect to git.linaro.org:
> git.linaro.org[0: 54.152.253.35]: errno=3DConnection refused

OK, it looks like someone turned off the git daemon on git.linaro.org.
I will switch to fetching over https.

--=20
Cheers,
Stephen Rothwell

--Sig_/isLxSh+W9DLDD4TM98S8OuM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYDW9cACgkQAVBC80lX
0GxlGQf/ZkBNqsFh6gdlH8EdYCDnggO5SvJQoVzc65vOTqbwtYJBbkbX/GFjyvcq
zVzOjaU1w5mXpmXuwBLULj5+1iwCmcFcpYQz0fKaZz584UE965PpiouGWDSFgKhi
96ztjhOEqqCAJ1prXsBbqvyeMWW8kw5/bt6bzlTDD6l+DEp7umZXiIhyOZWJghDT
MRYq9GUJYG1R/AaOR+Kawz8H4TcG0l7IMdozs0vjSHdOivwNiRunxR9tskWd6T3B
h5tDBw5NnVaz52HiguDfrAK1nbJ5hYVPH2AGVSSWNmBvMrceYNirn/5b++78ttuQ
YfdIt/qSt9eHSLN9rL9KrbGi9dl2mQ==
=GArU
-----END PGP SIGNATURE-----

--Sig_/isLxSh+W9DLDD4TM98S8OuM--

