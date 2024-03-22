Return-Path: <linux-kernel+bounces-112053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F5F8874A5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 22:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A7331C211A5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 21:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FC68174C;
	Fri, 22 Mar 2024 21:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="bF9zTDAy"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4310580632;
	Fri, 22 Mar 2024 21:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711144357; cv=none; b=QGQpIsWkQzg0OIj0zasWG2edbHNB6iL6d7hpdiMf9o9XdxBT9fnWUCVt5eo97F5aC5xJkEN+vgah6vl9NGDekU8MddrkfkkXEC3xNSSUoXQYfKDzookBFy41+WM3yypU/O5JKdx4g67RO2VqVnA/vn7ECGB5sczMDyo6GKGBMio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711144357; c=relaxed/simple;
	bh=9AVEqpvegcwayQLsYLiqrLsqGvbY35k/BMs7cZ5TrFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAGIuq1UXoQdj1X1KItgFl/umVpzDMmn1zdc7SLkWwxxrGq91Kj9/3MrhcjXlWdJga9fqZc6xqe8NDxIIzU71Jjs8fl8SGxHUbXqaXZ82E1z+75OHnUdC1zEGLgJHFYytdzeYuSLn4g1oJ3rf00e5YKE/GvBLpZzEtRaNFJtHYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=bF9zTDAy; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id DE4701C0071; Fri, 22 Mar 2024 22:52:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1711144349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qTYypDyCpf7WWdaBFqdyDpLRaW+o0sjezjr9PtcZ8PU=;
	b=bF9zTDAy8OH5OZCMJs9NAvRnSONbY5mJB74n8Dl0YNGE05PCpu/FshPiTkTu6X7K9N+9my
	gdfVC0G2Y532MDuFTAKm7SHwoAZoUxLQ0tAlnrxZTtc3cArcUIWDqzNCzWAGR0nNcqgvYV
	UnsF6K95sfvUB8CBeb/yAfFbNjPH9Tk=
Date: Fri, 22 Mar 2024 22:52:29 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Daniel Hodges <hodges.daniel.scott@gmail.com>
Cc: ast@kernel.org, lee@kernel.org, linux-leds@vger.kernel.org,
	daniel@iogearbox.net, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] leds: trigger: legtrig-bpf: Add ledtrig-bpf module
Message-ID: <Zf39nYJVOH9/J8cs@duo.ucw.cz>
References: <cover.1711113657.git.hodges.daniel.scott@gmail.com>
 <ac8e77881212e18d117059a698affd6afc2607af.1711113657.git.hodges.daniel.scott@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="N4DJvJWOynbcHMAs"
Content-Disposition: inline
In-Reply-To: <ac8e77881212e18d117059a698affd6afc2607af.1711113657.git.hodges.daniel.scott@gmail.com>


--N4DJvJWOynbcHMAs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch adds a led trigger that interfaces with the bpf subsystem. It
> allows for BPF programs to control LED activity through calling bpf
> kfuncs. This functionality is useful in giving users a physical
> indication that a BPF program has performed an operation such as
> handling a packet or probe point.
>=20
> Signed-off-by: Daniel Hodges <hodges.daniel.scott@gmail.com>

> +static int init_bpf(void)
> +{
> +	int ret;
> +
> +	ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
> +			&ledtrig_bpf_kfunc_set);
> +	ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
> +			&ledtrig_bpf_kfunc_set);

Should have ret ?: here, too?

> +static int ledtrig_bpf_init(void)
> +{
> +	led_trigger_register_simple("bpf", &ledtrig_bpf);
> +
> +	return init_bpf();
> +}

Is it somehow possible to have multiple LEDs hooked to bpf
functionality? I guess someone will want that...

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--N4DJvJWOynbcHMAs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZf39nQAKCRAw5/Bqldv6
8s0/AJ4ggTuHhsWQVEaesd844GKZQZ9mwgCgvsVcXdfViLuzhTNkVoM55R3JpwE=
=JQmB
-----END PGP SIGNATURE-----

--N4DJvJWOynbcHMAs--

